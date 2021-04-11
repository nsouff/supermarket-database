# Supermarket Database

Nous souhaitons créer la base de données d'un commerce de "première nécessité", vendant de la nourriture, des boissons et des produits d'hygiène. Notre modélisation représente cinq classes de données différentes: les produits en vente, les clients, les paniers des clients, les commandes effectuées par les clients ainsi que la variation des prix des produits.
Soulignons avant toute chose que nous avons utilisés les mêmes notations que celles introduites en cours.

#### Produits
Les données liées aux produits en vente sont organisées en un système de spécialisation classique. Vous trouverez ainsi une table ``Produits`` de laquelle hérite tous les articles en ventes. Aussi préciserons-nous qu'une instance de la table Produits ne représente pas un unique article, mais une classe d'articles: par exemple l'instance associée au produit "jus d'orange Tropicana" représente tous les jus d'orange Tropicana mis en vente.

#### Clients
Pour les clients, nous avons imaginé la situation suivante: à un instant donné, la table ``Clients`` contient toutes les personnes qui explorent le site de notre commerce. Ces clients peuvent être, ou pas, connecté à leur compte.

#### Commandes
Les commandes s'organisent de la manière suivante: à chaque commande est associée une unique classe de produit et un unique client (connecté à son compte). Par exemple, si une commande contient des pommes, elle ne contient qu'une quantité donnée de pommes. Ainsi, quand un client (connecté) valide son panier contenant ``n`` classes d'articles, ``n`` commandes différentes sont générées. Une instance de ``Clients connectés`` peut donc avoir un nombre quelconque de commande, et une instance de ``Produits`` peut également être associée à un nombre quelconque de commandes.
Comme nous avons choisi de modéliser un commerce de première nécessité, nous n'avons pas jugé essentielle la mise en place d'un sytème complet de notation et d'avis. En revanche, lorsqu'une commande est dans l'état ``livrée``, le client associé a la possibilité de donner un avis et une note à la commande (la commande étant associée à une unique classe d'articles, cet avis et note peut facilement être associée à l'article correspondant).

#### Paniers
Les paniers sont modélisés par une association entre ``Clients`` et ``Produits``: un panier est associé à un unique client et contient un nombre arbitraire de classes de produits.

#### Variations des prix
Enfin, les variations des prix sont modélisées par une entité faible, associée à la tables ``Produits``.