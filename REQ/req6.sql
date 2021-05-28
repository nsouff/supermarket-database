-- VI)
-- Contrainte :
-- Calcul les notes moyennes des marques, selon les notes données par les clients à des produits livrés.
-- Remarque :
SELECT PR.marque, AVG(C.note)
FROM produits PR, commandes C
WHERE C.id_produit = PR.id_produit
AND C.status = 'Livré'
AND PR.marque IS NOT NULL
AND C.note IS NOT NULL
GROUP BY PR.marque;