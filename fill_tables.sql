\copy comptes (nom, prenom, adresse, mail, age) FROM 'CSV/users.csv' with (FORMAT csv, HEADER, delimiter ';')
\copy produits (stock, prix, nom, péremption, bio, marque, label_bio, provenance, type_produit) FROM 'CSV/products.csv' with (FORMAT csv, HEADER, delimiter ';')
\copy commandes (date, rembourse, status, avis, note, ID_compte, id_produit, quantite) FROM 'CSV/commandes.csv' with (FORMAT csv, HEADER, delimiter ';')
INSERT INTO visiteurs (ID_visiteur)
  SELECT id_compte FROM comptes;
ALTER SEQUENCE visiteurs_id_visiteur_seq RESTART WITH 10001;
\copy variationPrix (dateChangement, nouveauPrix, ID_produit) FROM 'CSV/variationPrix.csv' with (FORMAT csv, HEADER, delimiter ';')
