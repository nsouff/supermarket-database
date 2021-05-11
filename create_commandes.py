import lorem
import csv
import os
import random
import datetime

file = 'CSV/commandes.csv'
product_file = 'CSV/products.csv'
random.seed()

if os.path.exists(file):
    os.remove(file)

if not os.path.exists(product_file):
    print('Product file does not exists, exit...')
    exit()

products = None
with open(product_file, 'r') as f:
    products = list(csv.DictReader(f, delimiter=';'))

size = 100000
commandes = {}
datas = [None for i in range(size)]
for i in range(size):
    id_produit = int(random.random()*10000)+1
    id_compte = int(random.random()*10000)+1
    status = random.choice(['Annulé', 'En cours', 'Livré'])
    rembourse = False
    if status=='Annulé':
        rembourse = bool(random.getrandbits(1))
    avis = note = None
    if random.getrandbits(1):
        avis = lorem.sentence()
    if random.getrandbits(1):
        note = int(random.random() * 6)
    quantite = int(random.random()*int(products[id_produit-1]['stock']))
    delta = -int(random.random()*10)
    date = datetime.datetime.today() + datetime.timedelta(days=delta)

    datas[i] = {'date': date, 'rembourse': rembourse, 'status': status, 'avis':
    avis, 'note': note, 'ID_compte': id_compte, 'id_produit': id_produit,
    'quantite': quantite}


keys = datas[0].keys()
with open(file, 'w') as csv_f:
    dict_writer = csv.DictWriter(csv_f, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(datas)
