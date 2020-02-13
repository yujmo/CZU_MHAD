import matplotlib.pyplot as plt
import numpy as np
from matplotlib.font_manager import FontProperties 
import scipy.io as scio

font = {'family' : 'SimHei',
    'weight' : 'bold',
    'size'  : '16'}
plt.rc('font', **font)      
plt.rc('axes', unicode_minus=False) 

Data = scio.loadmat('a01_s01_e01_sensor.mat')
####################################################################################
#################################################################################
sensors = Data['sensor'][0]

plt.figure(figsize=(60, 55))
####################################################################################
plt.subplot(6,6,1)
plt.text(0.4,0.4,"Skeleton",fontsize=18)
plt.axis('off') 

plt.subplot(6,6,2)
plt.plot([0,1], [1,1], color='red',label='XAcc')
plt.plot([0,1], [2,2], color='green', label='YAcc')
plt.plot([0,1], [3,3], color='blue',  label='ZAcc')
plt.legend()
plt.axis('off') 

plt.subplot(6,6,3)
plt.plot([0,1], [1,1], color='red',label='XGyr')
plt.plot([0,1], [2,2], color='green', label='YGyr')
plt.plot([0,1], [3,3], color='blue',label='ZGyr')
plt.legend()
plt.axis('off') 

plt.subplot(6,6,4)
plt.text(0.4,0.4,"Skeleton",fontsize=18)
plt.axis('off')

plt.subplot(6,6,5)
plt.plot([0,1], [1,1], color='red',label='XAcc')
plt.plot([0,1], [2,2], color='green', label='YAcc')
plt.plot([0,1], [3,3], color='blue',label='ZAcc')
plt.legend()
plt.axis('off') 

plt.subplot(6,6,6)
plt.plot([0,1], [1,1], color='red',label='XGyr')
plt.plot([0,1], [2,2], color='green', label='YGyr')
plt.plot([0,1], [3,3], color='blue',label='ZGyr')
plt.legend()
plt.axis('off') 

####################################################################################
Content00 = sensors[0]
XAcc00,YAcc00,ZAcc00,XGyr00,YGyr00,ZGyr00 = np.split(Content00[:,0:6],6,axis=1)
IdS = range(0,len(XAcc00))

plt.subplot(6,6,7)
plt.text(0.4,0.4,'Chest',fontsize=18)
plt.axis('off')

plt.subplot(6,6,8)
plt.plot(IdS, XAcc00, color='red',label='XAcc')
plt.plot(IdS, YAcc00, color='green', label='YAcc')
plt.plot(IdS, ZAcc00, color='blue',label='ZAcc')

plt.subplot(6,6,9)
plt.plot(IdS, XGyr00, color='red',label='XGyr')
plt.plot(IdS, YGyr00, color='green', label='YGyr')
plt.plot(IdS, ZGyr00, color='blue',label='ZGyr')

Content01 = sensors[1]
XAcc01,YAcc01,ZAcc01,XGyr01,YGyr01,ZGyr01 = np.split(Content01[:,0:6],6,axis=1)
IdS = range(0,len(XAcc01))

plt.subplot(6,6,10)
plt.text(0.4,0.4,'Abdomen',fontsize=18)
plt.axis('off')

plt.subplot(6,6,11)
plt.plot(IdS, XAcc01, color='red',label='XAcc')
plt.plot(IdS, YAcc01, color='green', label='YAcc')
plt.plot(IdS, ZAcc01, color='blue',label='ZAcc')

plt.subplot(6,6,12)
plt.plot(IdS, XGyr01, color='red',label='XGyr')
plt.plot(IdS, YGyr01, color='green', label='YGyr')
plt.plot(IdS, ZGyr01, color='blue',label='ZGyr')

####################################################################################	
Content02 = sensors[2]
XAcc02,YAcc02,ZAcc02,XGyr02,YGyr02,ZGyr02 = np.split(Content02[:,0:6],6,axis=1)
IdS = range(0,len(XAcc02))

plt.subplot(6,6,13)
plt.text(0.4,0.4,'Left elbow',fontsize=18)
plt.axis('off')

plt.subplot(6,6,14)	
plt.plot(IdS, XAcc02, color='red',label='XAcc')
plt.plot(IdS, YAcc02, color='green', label='YAcc')
plt.plot(IdS, ZAcc02, color='blue',label='ZAcc')

plt.subplot(6,6,15)
plt.plot(IdS, XGyr02, color='red',label='XGyr')
plt.plot(IdS, YGyr02, color='green', label='YGyr')
plt.plot(IdS, ZGyr02, color='blue',label='ZGyr')

Content04 = sensors[4]
XAcc04,YAcc04,ZAcc04,XGyr04,YGyr04,ZGyr04 = np.split(Content04[:,0:6],6,axis=1)
IdS = range(0,len(XAcc04))

plt.subplot(6,6,16)
plt.text(0.4,0.4,'Right elbow',fontsize=18)
plt.axis('off')   

plt.subplot(6,6,17)
plt.plot(IdS, XAcc04, color='red',label='XAcc')
plt.plot(IdS, YAcc04, color='green', label='YAcc')
plt.plot(IdS, ZAcc04, color='blue',label='ZAcc')

plt.subplot(6,6,18)
plt.plot(IdS, XGyr04, color='red',label='XGyr')
plt.plot(IdS, YGyr04, color='green', label='YGyr')
plt.plot(IdS, ZGyr04, color='blue',label='ZGyr')

####################################################################################
Content03 = sensors[3]
XAcc03,YAcc03,ZAcc03,XGyr03,YGyr03,ZGyr03 = np.split(Content03[:,0:6],6,axis=1)
IdS = range(0,len(XAcc03))

plt.subplot(6,6,19)
plt.text(0.4,0.4,'Left wrist',fontsize=18)
plt.axis('off')

plt.subplot(6,6,20)	
plt.plot(IdS, XAcc03, color='red',label='XAcc')
plt.plot(IdS, YAcc03, color='green', label='YAcc')
plt.plot(IdS, ZAcc03, color='blue',label='ZAcc')

plt.subplot(6,6,21)
plt.plot(IdS, XGyr03, color='red',label='XGyr')
plt.plot(IdS, YGyr03, color='green', label='YGyr')
plt.plot(IdS, ZGyr03, color='blue',label='ZGyr')

Content05 = sensors[5]
XAcc05,YAcc05,ZAcc05,XGyr05,YGyr05,ZGyr05 = np.split(Content05[:,0:6],6,axis=1)
IdS = range(0,len(XAcc05))

plt.subplot(6,6,22)
plt.text(0.4,0.4,'Right wrist',fontsize=18)
plt.axis('off')

plt.subplot(6,6,23)
plt.plot(IdS, XAcc05, color='red',label='XAcc')
plt.plot(IdS, YAcc05, color='green', label='YAcc')
plt.plot(IdS, ZAcc05, color='blue',label='ZAcc')

plt.subplot(6,6,24)
plt.plot(IdS, XGyr05, color='red',label='XGyr')
plt.plot(IdS, YGyr05, color='green', label='YGyr')
plt.plot(IdS, ZGyr05, color='blue',label='ZGyr')

####################################################################################
Content06 = sensors[6]
XAcc06,YAcc06,ZAcc06,XGyr06,YGyr06,ZGyr06 = np.split(Content06[:,0:6],6,axis=1)
IdS = range(0,len(XAcc06))

plt.subplot(6,6,25)
plt.text(0.4,0.4,'Left knee',fontsize=18)
plt.axis('off')

plt.subplot(6,6,26)
plt.plot(IdS, XAcc06, color='red',label='XAcc')
plt.plot(IdS, YAcc06, color='green', label='YAcc')
plt.plot(IdS, ZAcc06, color='blue',label='ZAcc')

plt.subplot(6,6,27)
plt.plot(IdS, XGyr06, color='red',label='XGyr')
plt.plot(IdS, YGyr06, color='green', label='YGyr')
plt.plot(IdS, ZGyr06, color='blue', label='ZGyr')

Content08 = sensors[8]
XAcc08,YAcc08,ZAcc08,XGyr08,YGyr08,ZGyr08 = np.split(Content08[:,0:6],6,axis=1)
IdS = range(0,len(XAcc08))

plt.subplot(6,6,28)
plt.text(0.4,0.4,'Right knee',fontsize=18)
plt.axis('off')

plt.subplot(6,6,29)
plt.plot(IdS, XAcc08, color='red',label='XAcc')
plt.plot(IdS, YAcc08, color='green', label='YAcc')
plt.plot(IdS, ZAcc08, color='blue',label='ZAcc')

plt.subplot(6,6,30)
plt.plot(IdS, XGyr08, color='red',label='XGyr')
plt.plot(IdS, YGyr08, color='green', label='YGyr')
plt.plot(IdS, ZGyr08, color='blue',label='ZGyr')

####################################################################################
Content07 = sensors[7]
XAcc07,YAcc07,ZAcc07,XGyr07,YGyr07,ZGyr07 = np.split(Content07[:,0:6],6,axis=1)
IdS = range(0,len(XAcc07))

plt.subplot(6,6,31)
plt.text(0.4,0.4,'Left ankle',fontsize=18)
plt.axis('off')

plt.subplot(6,6,32)
plt.plot(IdS, XAcc07, color='red',label='XAcc')
plt.plot(IdS, YAcc07, color='green', label='YAcc')
plt.plot(IdS, ZAcc07, color='blue',  label='ZAcc')

plt.subplot(6,6,33)
plt.plot(IdS, XGyr07, color='red',label='XGyr')
plt.plot(IdS, YGyr07, color='green', label='YGyr')
plt.plot(IdS, ZGyr07, color='blue',label='ZGyr')

Content09 = sensors[9]
XAcc09,YAcc09,ZAcc09,XGyr09,YGyr09,ZGyr09 = np.split(Content09[:,0:6],6,axis=1)
IdS = range(0,len(XAcc09))

plt.subplot(6,6,34)
plt.text(0.4,0.4,'Right ankle',fontsize=18)
plt.axis('off')

plt.subplot(6,6,35)	
plt.plot(IdS, XAcc09, color='red',label='XAcc')
plt.plot(IdS, YAcc09, color='green', label='YAcc')
plt.plot(IdS, ZAcc09, color='blue',label='ZAcc')

plt.subplot(6,6,36)
plt.plot(IdS, XGyr09, color='red',label='XGyr')
plt.plot(IdS, YGyr09, color='green', label='YGyr')
plt.plot(IdS, ZGyr09, color='blue',label='ZGyr')

plt.show()