DROP TABLE IF EXISTS produits CASCADE;
DROP TABLE IF EXISTS comptes CASCADE;
DROP TABLE IF EXISTS commandes CASCADE;
DROP TABLE IF EXISTS variationPrix CASCADE;
DROP TABLE IF EXISTS visiteurs CASCADE;
DROP TABLE IF EXISTS panier CASCADE;
DROP TYPE IF EXISTS CATEGORIE_PRODUIT;
DROP TYPE IF EXISTS STATUS_COMMANDE;

CREATE TYPE CATEGORIE_PRODUIT AS ENUM ('Légume', 'Fruit', 'Produit laitier',
'Viande rouge', 'Volaille', 'Poisson', 'Epicerie', 'Boisson alcoolisé',
'Boisson non alcoolisé', 'Hygiène');

CREATE TYPE STATUS_COMMANDE AS ENUM ('Annulé', 'En cours', 'Livré');


CREATE TABLE produits (
  id_produit SERIAL PRIMARY KEY,
  stock INT, CONSTRAINT stock_positif CHECK (stock >= 0),
  prix REAL, CONSTRAINT prix_positif CHECK (prix > 0),
  nom TEXT,
  péremption DATE,
  bio BOOL NOT NULL,
  marque text,
  label_bio text,
  provenance text,
  type_produit CATEGORIE_PRODUIT,
  CONSTRAINT label_bio_if_bio CHECK (bio=TRUE OR label_bio IS NULL),
  CONSTRAINT marque_is_null CHECK
    (type_produit NOT IN
      ('Légume', 'Fruit', 'Viande rouge', 'Volaille', 'Poisson')
      OR marque IS NULL),
  CONSTRAINT marque_is_not_null CHECK
    (type_produit NOT IN
      ('Epicerie', 'Boisson non alcoolisé', 'Hygiène')
    OR marque IS NOT NULL)
);

CREATE TABLE comptes (
  ID_compte SERIAL PRIMARY KEY,
  nom text NOT NULL,
  prenom text NOT NULL,
  adresse text NOT NULL,
  mail text NOT NULL,
  age int
  );

CREATE TABLE commandes (
  id_commande SERIAL PRIMARY KEY,
  date TIMESTAMP NOT NULL,
  rembourse BOOL NOT NULL,
  status STATUS_COMMANDE,
  avis text,
  note INT CONSTRAINT note_0_5 CHECK (note <= 5 AND note >= 0),
  ID_compte INT REFERENCES comptes(ID_compte),
  id_produit INT REFERENCES produits(id_produit),
  quantite INT
  CONSTRAINT rembourse_is_false CHECK (status='Annulé' OR rembourse=false)
);


CREATE TABLE visiteurs (
  ID_visiteur SERIAL PRIMARY KEY
);

CREATE TABLE variationPrix (
  dateChangement DATE NOT NULL,
  nouveauPrix int NOT NULL,
  ID_produit INT REFERENCES produits(id_produit),
  PRIMARY KEY(dateChangement, nouveauPrix, ID_produit)
);

CREATE TABLE panier (
  ID_compte INT REFERENCES comptes,
  ID_visiteur INT REFERENCES visiteurs,
  ID_produit INT REFERENCES produits,
  quantite int
  CONSTRAINT one_id CHECK (
    ID_compte IS NULL AND ID_visiteur IS NOT NULL OR
    ID_compte IS NOT NULL AND ID_visiteur IS NULL)
);
