-- X)
-- Contrainte : Condition de totalité + agrégation (+ équivalente à IX))
-- Trouver les marques dont tous les produits commandés ont tous leur note supérieure ou égale 3 (si la note n'est pas null)
-- Remarque : COUNT igonre les NULL donc la clause CO2.note IS NOT NULL n'est peut être pas nécessaire.
SELECT REQ.marque FROM (
    SELECT PR.marque, CO.note
    FROM produits PR, commandes CO
    WHERE PR.id_produit = CO.id_produit
    AND CO.note IS NOT NULL
    AND PR.marque IS NOT NULL
    AND CO.note >= 3
) AS REQ
GROUP BY REQ.marque
HAVING COUNT(REQ.note) = (
    SELECT COUNT(CO2.note)
    FROM commandes CO2, produits PR2
    WHERE CO2.id_produit = PR2.id_produit
    AND CO2.note IS NOT NULL
    AND PR2.marque = REQ.marque
);