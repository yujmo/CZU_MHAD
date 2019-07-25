# -*- coding: utf-8 -*-
import os
import hashlib


def get_FileSize(filePath):
  fsize = os.path.getsize(filePath)
  return fsize

allfiles = []
def gci(filepath):
  files = os.listdir(filepath)
  for fi in files:
    fi_d = os.path.join(filepath,fi)
    if os.path.isdir(fi_d):
      gci(fi_d)
    else:
      allfiles.append(fi_d)

gci('skeleton')

with open('hash.key','a+') as f:
  f.write("fileName \t hash Value \t file size(b) \n")
  for file_i in allfiles:
    with open(file_i,'r') as ff:
      content = ff.read()
      md5 = hashlib.md5()
      md5.update(content)
      ee = file_i + "\t" + str(md5.hexdigest()) + "\t" + str(get_FileSize(file_i)) + "\n"
      f.write(ee)   
