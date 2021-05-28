-- XIV)
-- Contrainte :
-- Calcule la valeur de toutes les commandes remboursées
-- Remarque :
SELECT SUM(P.prix * C.quantite)
FROM produits P, commandes C
WHERE C.id_produit = P.id_produit
AND C.rembourse = TRUE;