\copy comptes (nom, prenom, adresse, mail, age) FROM 'CSV/users.csv' with (FORMAT csv, HEADER, delimiter ';')
\copy produits (stock, prix, nom, péremption, bio, marque, label_bio, provenance, type_produit) FROM 'CSV/products.csv' with (FORMAT csv, HEADER, delimiter ';')
\copy commandes (date, rembourse, status, avis, note, ID_compte, id_produit, quantite) FROM 'CSV/commandes.csv' with (FORMAT csv, HEADER, delimiter ';')
