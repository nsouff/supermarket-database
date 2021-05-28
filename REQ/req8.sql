-- VIII)
-- Contrainte : Sous-requête dans le WHERE
-- Trouve toutes les marques qui ne vendent pas des produits de type 'Epicerie'.
-- Remarque :
SELECT DISTINCT PR1.marque
FROM produits PR1
WHERE PR1.marque NOT IN
(SELECT DISTINCT PR2.marque
FROM produits PR2
WHERE PR2.marque IS NOT NULL
AND PR2.type_produit = 'Epicerie');