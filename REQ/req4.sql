-- IV)
-- Contrainte : auto-jointure
-- Trouver des paires de produits de catégories différentes dont le prix à un moment donné été le même (pas forcément simultanément)
-- Remarque : Requête pas très intéressante.
SELECT PR1.nom AS nom_produit_1, PR1.id_produit, PR2.nom AS nom_produit_2, PR2.id_produit
FROM produits PR1, produits PR2, variationPrix V1, variationPrix V2
WHERE PR1.type_produit <> PR2.type_produit
AND PR1.id_produit = V1.id_produit
AND PR2.id_produit = V2.id_produit
AND V1.nouveauPrix = V2.nouveauPrix;