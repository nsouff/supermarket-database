-- XV)
-- Contrainte :
-- Trouve tous les produits dont la date de péremption sera dépassé dans cinq jours ou moins ou est déjà dépassée
-- Remarque :
SELECT P.id_produit, P.nom
FROM produits P
WHERE P.péremption - (SELECT current_date) <= 5;