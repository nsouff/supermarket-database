import os
import datetime
import random
import csv

prod_file = 'CSV/products.csv'

file = 'CSV/paniers.csv'

if not os.path.exists(prod_file):
    print(prod_file + ' file must exists...')
    exit()

if os.path.exists(file):
    os.remove(file)

products = None

with open(prod_file, 'r') as f:
    products = list(csv.DictReader(f, delimiter=';'))

size = 10000

datas = [None for i in range(size)]
for i in range(size):
    id_vis = None
    id_acc = None
    if random.getrandbits(1):
        id_vis = int(random.random()*10000+1)
    else :
        id_acc = int(random.random()*10000+1)
    id_prod = int(random.random()*10000+1)
    quanti = int(random.random()*int(products[id_prod-1]['stock']))
    datas[i] = {'ID_compte': id_acc, 'ID_visiteur': id_vis,
    'ID_produit': id_prod, 'quantite': quanti}

keys = datas[0].keys()
with open(file, 'w') as csv_file:
    dict_writer = csv.DictWriter(csv_file, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(datas)
