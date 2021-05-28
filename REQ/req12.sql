-- XII)
-- Contrainte : requêtes équivalentes sans null, mais différentes avec
-- Séléctionne les comptes ayant fait une commande mais n'ayant pas de panier,
-- mais ne marche pas à cause des null
-- Remarque :
SELECT DISTINCT c.id_compte
FROM commandes c
WHERE c.id_compte NOT IN (
  SELECT p.id_compte FROM panier p);