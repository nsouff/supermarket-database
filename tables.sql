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
