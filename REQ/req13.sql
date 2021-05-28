-- XIII)
-- Contrainte : requêtes équivalentes sans null, on obtient cette fois le bon
-- résultat
-- Remarque :
SELECT c.id_compte FROM commandes c
EXCEPT
SELECT p.id_compte FROM panier p;