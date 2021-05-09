
CREATE TABLE produits (
  id_produit text PRIMARY KEY,
  stock INT, CONSTRAINT stock_positif CHECK (stock >= 0),
  prix INT, CONSTRAINT prix_positif CHECK (prix > 0),
  nom TEXT,
  péremption TIMESTAMP,
  bio BOOL NOT NULL,
  marque text,
  label_bio text,
  provenance text,
  type_produit ENUM
    ('Légume', 'Fruit', 'Produit laitier', 'Viande rouge', 'Volaille', 'Poisson'
    'Epicerie', 'Boisson alcoolisé', 'Boisson non alcoolisé', 'Hygiène'),
  CONSTRAINT label_bio_if_bio CHECK (bio=TRUE OR label_bio IS NULL),
  CONSTRAINT marque_is_null CHECK
    (type_produit NOT IN
      ('Légume', 'Fruit', 'Viande rouge', 'Volaille', 'Poisson')
      OR marque IS NULL),
  CONSTRAINT marque_is_not_null CHECK
    (type produit NOT IN
      ('Produit laitier', 'Epicerie', 'Boisson alcoolisé',
      'Boisson non alcoolisé', 'Hygiène'))
    OR marque NOT NULL
);


CREATE TABLE commandes (
  id_commande INT PRIMARY KEY SERIAL,
  date TIMESTAMP NOT NULL,
  rembourse BOOL NOT NULL,
  status ENUM ('Annulé', 'En cours', 'Livré'),
  avis text,
  note INT CONSTRAINT note_0_5 CHECK (note <= 5 AND note >= 0),
  id_compte INT, FOREIGN KEY REFERENCES comptes(id_compte),
  id_produit INT, FOREIGN KEY REFERENCES produits(id_produit),
  quantite INT
);

CREATE TABLE comptes (
    ID_compte int PRIMARY KEY SERIAL,
    nom text NOT NULL,
    prenom text NOT NULL,
    adresse text NOT NULL,
    mail text NOT NULL,
    age int 
);

CREATE TABLE visiteurs (
    ID_visiteur int PRIMARY KEY SERIAL
);

CREATE TABLE variationPrix (
    dateChangement timestamp NOT NULL,
    nouveauPrix int NOT NULL,
    ID_produit FOREIGN KEY REFERENCES produits,
    PRIMARY KEY(dateChangement, nouveauPrix, ID_produit)
);

CREATE TABLE panier (
    ID_compte int FOREIGN KEY REFERENCES comptes,
    ID_visiteur int FOREIGN KEY REFERENCES visiteurs,
    ID_produit int FOREIGN KEY REFERENCES produits,
    quantite int,
);

