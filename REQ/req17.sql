-- XVII)
-- Contrainte :
-- Trouve le nombre de clients (comptes) qui n'ont pas de commande
-- Remarque :
SELECT COUNT(CO.id_compte)
FROM comptes CO
WHERE CO.id_compte NOT IN(
    SELECT DISTINCT C.id_compte
    FROM commandes C
);