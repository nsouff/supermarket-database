-- I)
-- Contrainte : requête sur trois tables
-- Trouve le prix total des paniers de chaque client connecté
-- Remarque : On peut complexifier la requête en incluant les paniers des visiteurs.
SELECT C.ID_compte, C.nom, C.prenom, SUM(PA.quantite * PR.prix)
FROM comptes C, panier PA, produits PR
WHERE PA.id_produit = PR.id_produit AND C.id_compte = PA.id_compte
GROUP BY C.ID_compte, C.nom, C.prenom;