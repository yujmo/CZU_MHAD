# -*- coding: utf-8 -*-
import os
with open("hash_ori",'r') as f1:
    module = f1.readlines()
    module_dict = {line.split()[1]:line.split()[0] for line in module}

with open("hash_new",'r') as f2:
    new = f2.readlines()
    new_dict = {line.split()[1]:line.split()[0] for line in new}

for key in set(module_dict) - set(new_dict):
    print(str(module_dict[key]) + "  is not/error in your download, please check it!")
