-- II)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouve les produits dont le prix maximum a, à un moment donné, été supérieur supérieur à 15€.
-- Remarque : remplacer le 15 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, MAX(V.nouveauPrix) AS prix_maximum
FROM variationPrix V, produits PR
WHERE PR.id_produit = V.id_produit
GROUP BY PR.nom, PR.id_produit
HAVING MAX(V.nouveauPrix) > 15;