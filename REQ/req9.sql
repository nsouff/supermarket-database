-- IX)
-- Contrainte : Condition de totalité + sous-requêtes corrélées (+ équivalente à X))
-- Trouver les marques dont tous les produits commandés ont tous leur note supérieure ou égale 3 (si la note n'est pas null)
-- Remarque : Requête très lente
SELECT DISTINCT PRC.marque
FROM produits PRC
WHERE PRC.marque IS NOT NULL
AND NOT EXISTS (
    SELECT C.id_produit
    FROM produits P, commandes C
    WHERE P.marque = PRC.marque
    AND C.note IS NOT NULL
    AND P.id_produit = C.id_produit
    AND P.id_produit NOT IN (
            SELECT CO.id_produit
            FROM commandes CO, produits PR
            WHERE CO.id_produit = PR.id_produit
            AND CO.note IS NOT NULL
            AND CO.note >= 3
            AND PR.marque = PRC.marque
        )
);