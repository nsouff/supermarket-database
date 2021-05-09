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