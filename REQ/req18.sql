-- XVIII)
-- Contrainte :
-- Renvoie le prix moyen pour chaque type de produit
-- Remarque
SELECT P.type_produit, TRUNC( CAST (AVG(P.prix) AS NUMERIC), 2) AS prix_moy
FROM produits P
GROUP BY (P.type_produit);
