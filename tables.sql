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
