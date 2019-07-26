# -*- coding: utf-8 -*-  
import os,re
import numpy as np
import bisect
import matplotlib.pyplot as plt

from matplotlib.font_manager import FontProperties 

font = {'family' : 'SimHei',
    'weight' : 'bold',
    'size'  : '32'}
plt.rc('font', **font)      
plt.rc('axes', unicode_minus=False) 


plt.figure(figsize=(20, 20))
Content05 = np.loadtxt('pi05')
XAcc05,YAcc05,ZAcc05 = np.split(Content05[:,3:6],3,axis=1)
IdS = range(0,len(XAcc05))

plt.plot(IdS, XAcc05, color='red',   label='Gyr-X',marker='o')
plt.plot(IdS, YAcc05, color='green', label='Gyr-Y',marker='*')
plt.plot(IdS, ZAcc05, color='blue',  label='Gyr-Z',marker='>')
#plt.yticks([-2,-1.5,-1,-0.5,0,0.5,1])

plt.title("angular velocity data drawing")
plt.xlabel('Sample number')
plt.ylabel('angular velocity')
plt.grid(ls='--')
plt.legend()
plt.savefig('test.png')  

plt.close()