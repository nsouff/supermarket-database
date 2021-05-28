-- XX)
-- Contrainte :
-- Retourne pour chaque provenance le client qui a fait le plus d'achat dans
-- cette région.
-- Remarque :
WITH REQ AS (
  SELECT CL.id_compte, CL.prenom, CL.nom, PR.provenance, SUM(CO.quantite)
  FROM comptes CL
  JOIN commandes CO ON CO.ID_compte=CL.id_compte
  JOIN produits PR ON PR.ID_produit=CO.ID_produit
  WHERE PR.provenance IS NOT NULL
  GROUP BY (CL.id_compte, CL.prenom, CL.nom, PR.provenance)
)
SELECT
  R1.id_compte,
  R1.prenom,
  R1.nom,
  ('Miss/Mister ' || R1.provenance) AS award,
  R1.sum
FROM REQ R1
WHERE R1.sum >= ALL (
  SELECT R2.sum
  FROM REQ R2
  WHERE R2.provenance=R1.provenance
);
