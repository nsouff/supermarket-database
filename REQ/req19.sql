-- XIX)
-- Contrainte:
-- Renvoie pour chaque type de produit la difference de prix moyenne entre le
-- bio et le non bio et cette même différence mais en pourcentage
-- Remarque
WITH P_BIO AS (
  SELECT type_produit, AVG(prix) AS avg_prix FROM produits
  WHERE bio=true GROUP BY (type_produit)
), P_NOT_BIO AS (
  SELECT type_produit, AVG(prix) AS avg_prix FROM produits
  WHERE bio=false GROUP BY (type_produit)
)
SELECT
  P_BIO.type_produit,
  TRUNC (CAST (P_BIO.avg_prix - P_NOT_BIO.avg_prix AS NUMERIC), 2) AS diff_bio,
  CAST ( (TRUNC( CAST( (100*P_BIO.avg_prix)/P_NOT_BIO.avg_prix - 100 AS NUMERIC), 1)) AS text) || '%'
    AS diff_bio_perc
FROM P_BIO
JOIN P_NOT_BIO ON P_BIO.type_produit=P_NOT_BIO.type_produit;
