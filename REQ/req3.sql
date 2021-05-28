-- III)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouver les produits dont la moyenne des prix au cours du temps est inférieure à la moyenne des prix actuels des produits de même type.
-- Remarque : remplacer le 1 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, AVG(V.nouveauPrix) AS prix_moyen
FROM variationPrix V, produits PR
WHERE PR.id_produit = V.id_produit
GROUP BY PR.id_produit, PR.nom
HAVING AVG(V.nouveauPrix) < (
    SELECT AVG(P.prix)
    FROM produits P
    WHERE P.type_produit = PR.type_produit
);