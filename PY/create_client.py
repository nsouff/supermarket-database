from faker import Faker
import csv
from random import seed
from random import random
import os

file = '../CSV/users.csv'
seed()


if os.path.exists(file):
    os.remove(file)

data = Faker()
size = 10000
users = [None for i in range(size)]
for i in range(size):
    firstname, lastname = data.name().split(' ', 1)
    users[i] = {'nom': lastname, 'prenom': firstname, 'adresse': data.address().replace('\n', ", "), 'mail': (firstname+'.'+lastname+'@exemple.com').lower(), 'age': int(random()*86 + 13) }

keys = users[0].keys()
with open(file, 'w') as csv_file:
    dict_writer = csv.DictWriter(csv_file, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(users)
