import datetime
import csv
import random
import os

file = '../CSV/variationPrix.csv'

products_file = '../CSV/products.csv'

if not os.path.exists(products_file):
    print(products_file + ' must exists ...')
    exit()

if os.path.exists(file):
    os.remove(file)

products = None

with open(products_file, 'r') as f:
    products = list(csv.DictReader(f, delimiter=';'))

nb_var = 10
nb_prod = len(products)
datas = [None for _ in range(nb_var*nb_prod)]

i = 0
for p in products:
    id_prod = (i // 10) + 1
    orig_price = float(p['prix'])
    for j in range(nb_var):
        price = orig_price + (random.random()*0.2 - 0.1)*orig_price
        date = datetime.datetime.today() - datetime.timedelta(days=10*(j+1))
        datas[i] = {'dateChangement': date, 'nouveauPrix': price,
        'ID_produit': id_prod}
        i+=1
keys = datas[0].keys()
with open(file, 'w') as csv_file:
    dict_writer = csv.DictWriter(csv_file, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(datas)
