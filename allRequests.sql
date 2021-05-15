-- I)
-- Contrainte : requête sur trois tables
-- Trouve le prix total des paniers de chaque client connecté
-- Remarque : 
SELECT C.nom, C.prenom, SUM(PA.quantite * PR.prix) 
FROM comptes C, panier PA, produits PR 
WHERE PA.id_produit = PR.id_produit AND C.id_compte = PA.id_compte 
GROUP BY C.nom, C.prenom;

-- II)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouve les produits dont le prix maximum a, à un moment donné, été supérieur supérieur à 15€.
-- Remarque : remplacer le 15 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, MAX(V.nouveauprix) AS prix_maximum
FROM variationPrix V, produits PR 
WHERE PR.id_produit = V.id_produit 
GROUP BY PR.nom, PR.id_produit
HAVING MAX(V.nouveauprix) > 15;

-- Avec en plus datechangement -> problèmes
SELECT V.datechangement, PR.id_produit, PR.nom, MAX(V.nouveauprix) AS prix_maximum
FROM variationPrix V, produits PR 
WHERE PR.id_produit = V.id_produit 
GROUP BY PR.nom, PR.id_produit, V.datechangement
HAVING MAX(V.nouveauprix) > 16;

-- III)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouver les produits dont le prix moyen est inférieur à 1€.
-- Remarque : remplacer le 1 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, AVG(V.nouveauprix) AS prix_moyen
FROM variationPrix V, produits PR 
WHERE PR.id_produit = V.id_produit
GROUP BY PR.id_produit, PR.nom
HAVING AVG(V.nouveauprix) < 1;

-- IV)
-- Contrainte : auto-jointure
-- Trouver des paires de produits de catégories différentes dont le prix à un moment donné été le même (pas forcément simultanément)
-- Remarque : 
SELECT PR1.nom AS nom_produit_1, PR1.id_produit, PR2.nom AS nom_produit_2, PR2.id_produit
FROM produits PR1, produits PR2, variationPrix V1, variationPrix V2
WHERE PR1.type_produit <> PR2.type_produit 
AND PR1.id_produit = V1.id_produit
AND PR2.id_produit = V2.id_produit
AND V1.nouveauPrix = V2.nouveauPrix;

-- V)
-- Contrainte : Calcul de deux agrégats
--
-- Remarque :
SELECT REQ.marque, AVG(REQ.prix_max)
FROM (SELECT PR.type_produit, PR.marque, MAX(PR.prix) as prix_max
FROM produits PR
WHERE PR.marque IS NOT NULL
GROUP BY PR.type_produit, PR.marque) AS REQ
GROUP BY REQ.marque;

-- VI)
--
-- Calcul les notes moyennes des marques, selon les notes données par les clients à des produits livrés.
-- Remarque :
SELECT PR.marque, AVG(C.note)
FROM produits PR, commandes C
WHERE C.id_produit = PR.id_produit
AND PR.marque IS NOT NULL
AND C.note IS NOT NULL
GROUP BY PR.marque;


-- VII)
--
-- Calcul des dépensens moyennes de chaque client
-- Remarque : 
SELECT C.nom, C.prenom, AVG(CO.quantite * PR.prix)
FROM comptes C, produits PR, commandes CO
WHERE C.ID_compte = CO.ID_compte
AND PR.id_produit = CO.id_produit
GROUP BY C.nom, C.prenom;