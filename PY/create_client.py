from faker import Faker
import csv
from random import seed
from random import random
import os

file = '../CSV/users.csv'
seed()

name_csv = '../CSV/SSA_Names_DB.csv'
surname_csv = '../CSV/Common_Surnames_Census_2000.csv'

names = surnames = None
with open(name_csv, 'r') as f:
    names = list(csv.DictReader(f, delimiter=';'))
with open(surname_csv, 'r') as f:
    surnames = list(csv.DictReader(f, delimiter=';'))




if os.path.exists(file):
    os.remove(file)

data = Faker()
size = 10000
users = [None for i in range(size)]
for i in range(size):
    firstname, lastname = names[i]['Name'], surnames[i]['name']
    users[i] = {'nom': lastname, 'prenom': firstname, 'adresse': data.address().replace('\n', ", "), 'mail': (firstname+'.'+lastname+'@exemple.com').lower(), 'age': int(random()*86 + 13) }

keys = users[0].keys()
with open(file, 'w') as csv_file:
    dict_writer = csv.DictWriter(csv_file, keys, delimiter=';')
    dict_writer.writeheader()
    dict_writer.writerows(users)
