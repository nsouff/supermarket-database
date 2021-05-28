-- XI)
-- Contrainte : Jointure externe
-- Sélectionne les produits qui ne sont pas commandés
-- Remarque : Sélectionne aussi les produits qui sont dans des commandes annulées et sous requête peut être évitée par une jointure.
SELECT REQ.id_produit, REQ.nom
FROM (
    SELECT PR.id_produit, PR.nom, CO.id_commande
    FROM produits PR
    LEFT OUTER JOIN commandes CO
    ON PR.id_produit = CO.id_produit
) AS REQ
WHERE REQ.id_commande IS NULL;