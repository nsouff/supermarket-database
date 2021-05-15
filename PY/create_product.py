import random
import datetime
import csv
import os

random.seed()

file = '../CSV/products.csv'

if os.path.exists(file):
    os.remove(file)


fruits = ['Pomme', 'Banane', 'Poire', 'Orange', 'Clementine', 'Abricot',
'Peche', 'Mandarine', 'Raisin', 'Fraise', 'Framboise', 'Mure', 'Casis',
'Mytrtille', 'Tomate']
veget = ['Courgette', 'Poivron', 'Bettrave', 'Aubergine', 'Radis', 'Oignon',
'Concombre', 'Haricot vert', 'Haricot rouge', 'Petit pois', 'Mais', 'Poireau']
dairy = ['Yaourt nature', 'Lait ecreme', 'Lait demi ecreme', 'Creme',
'Fromage de chevre', 'Compte', 'Morbier', 'Emmental', 'Camembert', 'Cantal']
red_meat = ['Cote de boeuf', 'Cote d\'agneau', 'Steak de beouf']
poultry = ['Poulet entier', 'Cuisse de poulet', 'Aile de poulet', 'Canard entier']
fish = ['Turbo', 'Dorade', 'Anchois', 'Sardine', 'Thon', 'Saumon', 'Truite',
'Harang', 'Lotte', 'Rouget', 'Sole']
grocery = ['Pate', 'Riz', 'Ble']
alcohol = ['Vin blanc', 'Vin rouge', 'Rose', 'Whisky', 'Bière blonde',
'Bière brune', 'Bière rousse', 'Vodka']
drinks = ['Soda', 'Jus d\'orange', 'Jus de pomme', 'Jus de raisin',
'Jus d\'abricot']
hygiene = ['Creme visage', 'Creme main', 'Papier toilette']


labels_bio = ['AB', 'Bio cohérence', 'Bio partenaire']
brands = {'Pate': ['Barilla', 'Panzanni', 'Rummo'],
'Riz': ['Uncle ben\'s', 'Taureau aile'],
'Ble': ['Ebli', 'Markal'],
'Soda': ['Coca Cola', '7UP', 'Pepsi'],
'Jus d\'orange': ['Tropicana', 'Innocent', 'Pressade', 'Joker'],
'Jus de pomme': ['Tropicana', 'Innocent'],
'Jus de raisin': ['Tropicana', 'Innocent'],
'Jus d\'abricot': ['Tropicana', 'Innocent', 'Pressade'],
'Creme visage': ['Nivea', 'Cerave'],
'Creme main': ['Nivea', 'Cerave'],
'Papier toilette': ['Okay', 'Lotus'],
'Vin rouge': ['Domaine de Villeneuve', 'Domaine du Moulin', 'Domain de la Borde'],
'Vin blanc': ['Domaine de Villeneuve', 'Domaine du Moulin', 'Domain de la Borde'],
'Rose': ['Domaine de Villeneuve', 'Domaine du Moulin', 'Domain de la Borde'],
'Whisky': ['William Peal', 'Jack Daniels', 'Grants'],
'Vodka': ['Zubrowka', 'Poliakov'],
'Bière brune': ['Leffe', 'Guinness'],
'Bière blonde': ['Leffe', 'Chouffe'],
'Bière rousse': ['Guinness', 'Boréale']}


products_type=[('Légume', veget, 1.5, 7), ('Fruit', fruits, 1.5, 5),
('Produit laitier', dairy, 1.5, 60), ('Viande rouge', red_meat, 10, 3),
('Volaille', poultry, 8, 5), ('Poisson', fish, 6, 5), ('Epicerie', grocery, 1.2, 1000),
('Boisson alcoolisé', alcohol, 8, None), ('Boisson non alcoolisé', drinks, 1.8, 21),
('Hygiène', hygiene, 5, 700)]
sub_size = 1000


dep = ['Hauts de France', 'Ile de France', 'Grand Est', 'Bretagne', 'Normandie',
'Bougogne Franche Compte', 'Pays de la Loire', 'Centre-Val de Loire',
'Nouvelle Aquitaine', 'Auvergne-Rhone-Alpes', 'Occitanie',
'Provence-Alpes-Cote d\'Azur']

datas = [None for i in range(len(products_type)*sub_size)]

i = 0
for type, list, price_moy, nb_day_perem_moy in products_type:
    for j in range(sub_size):
        bio = bool(random.getrandbits(1))
        label_bio = None
        if bio:
            label_bio = random.choice(labels_bio)
        perem = None
        if nb_day_perem_moy:
            delta = int((random.random()*(0.4) + 0.8)*nb_day_perem_moy)
            perem = datetime.datetime.today() + datetime.timedelta(days=delta)
        stock = int(random.random()*500)
        price = price_moy + (price_moy * (random.random() - 0.5))
        name = random.choice(list)
        brand = None
        if name in brands:
            brand = random.choice(brands[name])
        prov = None
        if type in ['Légume', 'Fruit', 'Viande rouge', 'Volaille', 'Poisson']:
            prov = random.choice(dep)
        datas[i] = {'stock': stock, 'prix': price, 'nom': name,
        'péremption': perem, 'bio': bio, 'marque': brand,
        'label_bio': label_bio, 'provenance': prov, 'type_produit': type}
        i += 1

keys = datas[0].keys()
with open(file, 'w') as csv_f:
    dict_writer = csv.DictWriter(csv_f, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(datas)
