\copy comptes (nom, prenom, adresse, mail, age) from 'CSV/users.csv' with (FORMAT csv, HEADER, delimiter ';')
