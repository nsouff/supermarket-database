-- V)
-- Contrainte : Calcul de deux agrégats + Sous-requête dans le FROM.
-- La sous-reqête de FROM calcul le prix maximum d'un article d'un certain type vendu par une certaine marque. La requête principale
-- calcule la moyenne de ces prix maximums par marques.
-- Remarque : Le résultat de la requête n'est peut-être pas très intéressant
SELECT REQ.marque, AVG(REQ.prix_max)
FROM (
    SELECT PR.type_produit, PR.marque, MAX(PR.prix) as prix_max
    FROM produits PR
    WHERE PR.marque IS NOT NULL
    GROUP BY PR.type_produit, PR.marque
    ) AS REQ
GROUP BY REQ.marque;