CREATE TABLE Comptes (
    ID_compte int PRIMARY KEY SERIAL,
    Nom text NOT NULL,
    Prenom text NOT NULL,
    Mail text NOT NULL,
    Age int 
);

CREATE TABLE Visiteurs (
    ID_visiteur int PRIMARY KEY SERIAL
);

CREATE TABLE VariationPrix (
    DateChangement timestamp NOT NULL,
    NouveauPrix int NOT NULL,
    ID_produit FOREIGN KEY REFERENCES Produits,
    PRIMARY KEY(DateChangement, NouveauPrix, ID_produit)
);