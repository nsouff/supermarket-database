-- VII)
-- Contrainte :
-- Calcul le prix moyen d'une commande pour chaque client
-- Remarque : Cette moyenne ne se fait pas sur une durée : on n'a pas la dépense moyenne d'un client sur un mois par exemple
SELECT C.nom, C.prenom, AVG(CO.quantite * PR.prix)
FROM comptes C, produits PR, commandes CO
WHERE C.ID_compte = CO.ID_compte
AND PR.id_produit = CO.id_produit
GROUP BY C.nom, C.prenom;