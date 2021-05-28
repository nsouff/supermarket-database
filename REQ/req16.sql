-- XVI)
-- Contrainte :
-- Trouve le produit le plus vendu
-- Remarque :
WITH Q AS (SELECT PR.id_produit, SUM(C.quantite)
FROM produits PR, commandes C
WHERE PR.id_produit = C.id_produit
GROUP BY PR.id_produit)
SELECT P.nom, P.id_produit
FROM produits P, Q
WHERE P.id_produit = Q.id_produit
AND Q.sum = (SELECT MAX(Q.sum) FROM Q);