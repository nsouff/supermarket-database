-- I)
-- Contrainte : requête sur trois tables
-- Trouve le prix total des paniers de chaque client connecté
-- Remarque : On peut complexifier la requête en incluant les paniers des visiteurs.
SELECT C.ID_compte, C.nom, C.prenom, SUM(PA.quantite * PR.prix)
FROM comptes C, panier PA, produits PR
WHERE PA.id_produit = PR.id_produit AND C.id_compte = PA.id_compte
GROUP BY C.ID_compte, C.nom, C.prenom;

-- II)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouve les produits dont le prix maximum a, à un moment donné, été supérieur supérieur à 15€.
-- Remarque : remplacer le 15 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, MAX(V.nouveauPrix) AS prix_maximum
FROM variationPrix V, produits PR
WHERE PR.id_produit = V.id_produit
GROUP BY PR.nom, PR.id_produit
HAVING MAX(V.nouveauPrix) > 15;

-- III)
-- Contrainte : requête avec GROUP BY et HAVING
-- Trouver les produits dont la moyenne des prix au cours du temps est inférieure à la moyenne des prix actuels des produits de même type.
-- Remarque : remplacer le 1 par le résultat d'une requête plus complexe.
SELECT PR.id_produit, PR.nom, AVG(V.nouveauPrix) AS prix_moyen
FROM variationPrix V, produits PR
WHERE PR.id_produit = V.id_produit
GROUP BY PR.id_produit, PR.nom
HAVING AVG(V.nouveauPrix) < (
    SELECT AVG(P.prix)
    FROM produits P
    WHERE P.type_produit = PR.type_produit
);

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

-- V)
-- Contrainte : Calcul de deux agrégats + Sous-requête dans le FROM.
-- La sous-reqête de FROM calcul le prix maximum d'un article d'un certain type vendu par une certaine marque. La requête principale
-- calcule la moyenne de ces prix maximums par marques.
-- Remarque : Le résultat de la requête n'est peut-être pas très intéressant
SELECT REQ.marque, AVG(REQ.prix_max)
FROM (
    SELECT PR.type_produit, PR.marque, MAX(PR.prix) as prix_max
    FROM produits PR
    WHERE PR.marque IS NOT NULL
    GROUP BY PR.type_produit, PR.marque
    ) AS REQ
GROUP BY REQ.marque;

-- VI)
-- Contrainte :
-- Calcul les notes moyennes des marques, selon les notes données par les clients à des produits livrés.
-- Remarque :
SELECT PR.marque, AVG(C.note)
FROM produits PR, commandes C
WHERE C.id_produit = PR.id_produit
AND C.status = 'Livré'
AND PR.marque IS NOT NULL
AND C.note IS NOT NULL
GROUP BY PR.marque;


-- VII)
-- Contrainte :
-- Calcul le prix moyen d'une commande pour chaque client
-- Remarque : Cette moyenne ne se fait pas sur une durée : on n'a pas la dépense moyenne d'un client sur un mois par exemple
SELECT C.nom, C.prenom, AVG(CO.quantite * PR.prix)
FROM comptes C, produits PR, commandes CO
WHERE C.ID_compte = CO.ID_compte
AND PR.id_produit = CO.id_produit
GROUP BY C.nom, C.prenom;

-- VIII)
-- Contrainte : Sous-requête dans le WHERE
-- Trouve toutes les marques qui ne vendent pas des produits de type 'Epicerie'.
-- Remarque :
SELECT DISTINCT PR1.marque
FROM produits PR1
WHERE PR1.marque NOT IN
(SELECT DISTINCT PR2.marque
FROM produits PR2
WHERE PR2.marque IS NOT NULL
AND PR2.type_produit = 'Epicerie');

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

-- XII)
-- Contrainte : requêtes équivalentes sans null, mais différentes avec
-- Séléctionne les comptes ayant fait une commande mais n'ayant pas de panier,
-- mais ne marche pas à cause des null
-- Remarque :
SELECT DISTINCT c.id_compte
FROM commandes c
WHERE c.id_compte NOT IN (
  SELECT p.id_compte FROM panier p);

-- XIII)
-- Contrainte : requêtes équivalentes sans null, on obtient cette fois le bon
-- résultat
-- Remarque :
SELECT c.id_compte FROM commandes c
EXCEPT
SELECT p.id_compte FROM panier p;

-- XIV)
-- Contrainte :
-- Calcule la valeur de toutes les commandes remboursées
-- Remarque :
SELECT SUM(P.prix * C.quantite)
FROM produits P, commandes C
WHERE C.id_produit = P.id_produit
AND C.rembourse = TRUE;

-- XV)
-- Contrainte :
-- Trouve tous les produits dont la date de péremption sera dépassé dans cinq jours ou moins ou est déjà dépassée
-- Remarque :
SELECT P.id_produit, P.nom
FROM produits P
WHERE P.péremption - (SELECT current_date) <= 5;

-- XVI)
-- Contrainte :
-- Trouve le produit le plus vendu
-- Remarque :
WITH Q AS (SELECT PR.id_produit, SUM(C.quantite)
FROM produits PR, commandes C
WHERE PR.id_produit = C.id_produit
GROUP BY PR.id_produit)
SELECT P.nom, P.id_produit
FROM produits P, Q
WHERE P.id_produit = Q.id_produit
AND Q.sum = (SELECT MAX(Q.sum) FROM Q);

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

-- XVIII)
-- Contrainte :
-- Renvoie le prix moyen pour chaque type de produit
-- Remarque
SELECT P.type_produit, TRUNC( CAST (AVG(P.prix) AS NUMERIC), 2) AS prix_moy
FROM produits P
GROUP BY (P.type_produit);

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
