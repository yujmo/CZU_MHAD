 
 To be continued...
 <h2 align="center">CZU-MHAD: A multimodal dataset for human action recognition utilizing a depth camera and 10 wearable inertial sensors</h2>

&emsp;&emsp;In order to facilitate the research of multi-modal sensor fusion for human action recognition, this paper provides a multi-modal human action dataset using Kinect depth camera and multile wearable sensors, which is called Changzhou University multi-modal human action dataset (CZU-MHAD). Our dataset contains more wearable sensors, which aims to obtain the position data of human skeleton joints, as well as 3-axis acceleration and 3-axis angular velocity data of corresponding joints. Our dataset provides time synchronous depth video, skeleton joint position, 3-axis acceleration and 3-axis angular velocity data to describe a complete human action.

## 1. Sensors

&emsp;&emsp;The CZU-MHAD uses 1 Microsoft Kinect V2 and 10 wearable sensors MPU9250. These two kinds of sensors are widely used, which have the characteristics of low power consumption, low cost and simple operation. In addition, it does not require too much computing power to process the data collected by the two kind sensors in real time.

### 1.1 Kinect v2

<p align="center"> <img src="images/KinectV2.jpg" width=""/></p>

&emsp;&emsp;The above picture is the Microsoft Kinect V2, which can collect both color and depth images at a sampling frequency of 30 frames per second. Kinect SDK is a software package provided by Microsoft, which can be used to track 25 skeleton joint points and their 3D spatial positions. You can download the Kinect SDK in `https://www.microsoft.com/en-us/download/details.aspx?id=44561`.

<p align="center"> <img src="images/Kinectjoints.jpg" width=""/></p>

&emsp;&emsp;The above image shows 25 skeleton joint points of the human body that Kinect V2 can track. 

### 1.2 MPU9250

&emsp;&emsp;The MPU9250 can capture 3-axis acceleration, 3-axis angular velocity and 3-axis magnetic intensity. 
- Measurement range of MPU9250: 
  - the measurement range of accelerometer is ±16g;
  - the measurement range of angular velocity of the gyroscope is ±2000 degrees/second. 

&emsp;&emsp;CZU-MHAD uses Raspberry PI to interact with MPU9250 through the integrated circuit bus (IIC) interface, realizing the functions of reading, saving and uploading MPU9250 sensor data to the server.The connection between Raspberry PI and MPU9250 is shown in picture. 

<p align="center"> <img src="images/iic.jpg" width=""/></p>

 &emsp;&emsp;You can visit `https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up` to learn more about Raspberry PI.

## 2. Data Acquisition System Architecture

&emsp;&emsp;This section introduces the data acquisition system of CZU-MHAD dataset. CZU-MHAD uses Kinect V2 sensor to collect depth image and joint position data, and uses MPU9250 sensor to collect 3-axis acceleration data and 3-axis angular velocity data. In order to collect the 3-axis acceleration data and the 3-axis angular velocity data of the whole body, a motion data acquisition system including 10 MPU9250 sensors is built-in this paper. The sampling system architecture is shown in following picture.

<p align="center"> <img src="images/sample.jpg" width=""/></p>

&emsp;&emsp;The MPU9250 sensor is controlled by Raspberry PI, Kinect V2 is controlled by a notebook computer, and time synchronization with a NTP server is carried out every time data is collected. After considering the sampling scheme of MHAD and UTD-MHAD, the position of wearable sensors is determined as shown in the following picture.

<p align="center"> <img src="images/timg.jpg" width=""/></p>

&emsp;&emsp;The points marked in red in the figure are the positions of inertial sensors, the left in the figure is the left side of the human body, and the right in the figure is the right side of the human body.

## 2. Information for "CZU-MHAD" dataset.

&emsp;&emsp;The CZU-MHAD dataset contains 22 actions performed by 5 subjects (5 males). Each subject repeated each action >8 times. The CZU-MHAD dataset contains a total of >880 samples. The 22 actions performed are listed in Table. It can be seen that CZU-MHAD includes common gestures (such as Draw fork, Draw circle),daily activities (such as Sur Place, Clap, Bend down), and training actions (such as Left body turning movement, Left lateral movement).

**Describe different actions in English:**

| ID  | Action name            | ID   | Action name                 |  ID | Action name          |  ID | Action name |
| --- | ---                    | ---  |        ---                  | --- | ---                  | --- | --- |
| 1   | Right high wave        |  7   | Draw fork with right hand   |  13 | Right foot kick side |  19 | Left body turning movement |
| 2   | Left high wave         |  8   | Draw fork with left  hand         |  14 | Left foot kick side  |  20 | Right body turning movement |
| 3   | Right horizontal wave  |  9   | Draw circle with right hand |  15 | Clap                 |  21 | Left lateral movement |
| 4   | Left horizontal wave   |  10  | Draw circle with left hand  |  16 | Bend down            |  22 | Right lateral movement | 
| 5   | Hammer with right hand |  11  | Right foot kick foward      |  17 | Wave up and down     |     |  |
| 6   | Grasp with right hand  |  12  | Left foot kick foward       |  18 | Sur Place            |     |  |

**Describe different actions in Chinese:**:

| ID  | Action name            | ID   | Action name                 |  ID | Action name          |  ID | Action name |
| --- | ---                    | ---  |        ---                  | --- | ---                  | --- | --- |
| 1   | 右高挥手        |  7   | 右手画×   |  13 |  右脚侧踢 |  19  |   左体转 |
| 2   | 左高挥手         |  8   | 左手画×         |  14 |左脚侧踢  |  20 |    右体转 |
| 3   | 右水平挥手  |  9   | 右手画○ |  15 | 拍手                          |             21 |   左体侧 |
| 4   | 左水平挥手   |  10  | 左手画○  |  16  |  弯腰          |  22 |右体侧 | 
| 5   | 锤(右手) |  11  | 右脚前踢      |  17 | 上下挥手     |     |  |
| 6   | 抓(右手)  |  12  | 左脚前踢      |  18 | 原地踏步            |   | |

## 3.  How to download the dataset

&emsp;&emsp; We offer two ways to download our CZU-MHAD dataset:
 
1. BaiduDisk(百度网盘)

&emsp;&emsp; Link: https://pan.baidu.com/s/1b5-rUJcs5fha39Z6U6uQ0Q &emsp;&emsp; Code: wsza

<p align="center"> <img src="images/baiduDisk.png" width=""/></p>

&emsp;&emsp;In the `CZU-MHAD`, you will see three subfolders: `depth images`, `sensors` and  `skeleton`. The `depth images` contains the depth images captured by Kinect V2. The `skeleton` contains the position data of skeleton joint points captured by Kinect V2. The `sensors` contains the data of 3-axis acceleration and 3-axis angular velocity captured by MPU9250. 

+ In `depth images`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `depth images/cyy`, the subject's name is cui yao yao(cyy). In `depth images/cyy`, you will see 22 subfolders, each containing different actions, such as `depth images/cyy/action_1`. In `depth images/cyy/action_1`, the depth image sequences of different times are stored, such as `depth images/cyy/action_1/time_1`. In `depth images/cyy/action_1/time_1/`, this folder contains many depth images. We use the time stamp to name the picture. Such as `depth images/cyy/action_1/time_1/0723150846409936.png`, this picture was taken at 15:08:46:409:936 on July 23.
 
![](images/QQ20200215160052.png)
 
+ In `skeleton`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `skeleton/cyy`, the subject's name is cui yao yao(cyy). In `skeleton/cyy`, you will see 22 subfolders, each subfolder containing different actions, such as `skeleton/cyy/action_1`. In `skeleton/cyy/action_1`, the skeleton sequences of different times are stored, such as `skeleton/cyy/action_1/time_1`. In `skeleton/cyy/action_1/time_1`, each line contains the 3D position data of 25 joints of the whole body at a time,  so there are 100 columns of data (100 = (3 + 1) * 25). Why 3 + 1? Because when we collect data, we add a time stamp after the 3D position data of each joint point to segment different joint points. Such as `0.004343 -0.552928 2.553481 723150846385874.000000`, the first three data are 3D position data (x, y, z), and the last data is the timestamp.
Such as `723150846385874.00000`, this data was taken at 15:08:46:385:874 on July 23.

![](images/QQ20200215220913.png)

![](images/QQ20200215220914.png)

+ In `sensors`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `sensors/cyy`, the subject's name is cui yao yao(cyy). In `sensors/cyy`, you will see 22 subfolders, each containing different actions, such as `sensors/cyy/action_1/`.In `sensors/cyy/action_1`, the wearable sensors data sequences of different times are stored, such as `sensors/cyy/action_1/time_1/`. In `sensors/cyy/action_1/time_1/`, this folder contains 10 files. Each file stores data collected by a sensor. Such as `sensors/cyy/action_1/time_1/pi00`, this file stores the triaxial acceleration and angular velocity data collected by the 0-th sensor.

![](images/QQ20200215220915.png)

&emsp;&emsp;In `sensors/cyy/action_1/time_1/pi00`, each line contains the triaxial acceleration data, triaxial angular velocity data and a time stamp, so there are 7 columns of data (7 = 3 + 3 + 1). 
    
![](images/QQ20200215220916.png)

2. GitHub(Updating...)

![](images/toolfk-github.png) 

&emsp;&emsp; Link: https://pan.baidu.com/s/1b5-rUJcs5fha39Z6U6uQ0Q &emsp;&emsp; Code: wsza

![](images/baiduDisk.png)

&emsp;&emsp;In the `CZU-MHAD`, you will see three subfolders: `depth images`, `sensors` and  `skeleton`. The `depth images` contains the depth images captured by Kinect V2. The `skeleton` contains the position data of skeleton joint points captured by Kinect V2. The `sensors` contains the data of 3-axis acceleration and 3-axis angular velocity captured by MPU9250. 

+ In `depth images`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `depth images/cyy`, the subject's name is cui yao yao(cyy). In `depth images/cyy`, you will see 22 subfolders, each containing different actions, such as `depth images/cyy/action_1`. In `depth images/cyy/action_1`, the depth image sequences of different times are stored, such as `depth images/cyy/action_1/time_1`. In `depth images/cyy/action_1/time_1/`, this folder contains many depth images. We use the time stamp to name the picture. Such as `depth images/cyy/action_1/time_1/0723150846409936.png`, this picture was taken at 15:08:46:409:936 on July 23.
 
![](images/QQ20200215160052.png)
 
+ In `skeleton`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `skeleton/cyy`, the subject's name is cui yao yao(cyy). In `skeleton/cyy`, you will see 22 subfolders, each subfolder containing different actions, such as `skeleton/cyy/action_1`. In `skeleton/cyy/action_1`, the skeleton sequences of different times are stored, such as `skeleton/cyy/action_1/time_1`. In `skeleton/cyy/action_1/time_1`, each line contains the 3D position data of 25 joints of the whole body at a time,  so there are 100 columns of data (100 = (3 + 1) * 25). Why 3 + 1? Because when we collect data, we add a time stamp after the 3D position data of each joint point to segment different joint points. Such as `0.004343 -0.552928 2.553481 723150846385874.000000`, the first three data are 3D position data (x, y, z), and the last data is the timestamp.
Such as `723150846385874.00000`, this data was taken at 15:08:46:385:874 on July 23.

![](images/QQ20200215220913.png)

![](images/QQ20200215220914.png)

+ In `sensors`, you will see multiple subfolders. The names of these subfolders are the first spelling of the names of different subjects, such as `sensors/cyy`, the subject's name is cui yao yao(cyy). In `sensors/cyy`, you will see 22 subfolders, each containing different actions, such as `sensors/cyy/action_1/`.In `sensors/cyy/action_1`, the wearable sensors data sequences of different times are stored, such as `sensors/cyy/action_1/time_1/`. In `sensors/cyy/action_1/time_1/`, this folder contains 10 files. Each file stores data collected by a sensor. Such as `sensors/cyy/action_1/time_1/pi00`, this file stores the triaxial acceleration and angular velocity data collected by the 0-th sensor.

![](images/QQ20200215220915.png)

&emsp;&emsp;In `sensors/cyy/action_1/time_1/pi00`, each line contains the triaxial acceleration data, triaxial angular velocity data and a time stamp, so there are 7 columns of data (7 = 3 + 3 + 1). 
    
![](images/QQ20200215220916.png)

## 4. Sample codes

We will provide sample code and convert the original data file to `.mat` file tomorrow.

## 5. Citation

To use our dataset, please refer to the following paper:

* Mo Yujian, Hou Zhenjie, Chang Xingzhi, Liang Jiuzhen, Chen Chen, Huan Juan. Structural feature representation and fusion of behavior recognition oriented human spatial cooperative motion[J]. Journal of Beijing University of Aeronautics and Astronautics,2019,(12):2495-2505.

## Mailing List
 
&emsp;&emsp;If you are interested to recieve news, updates, and future events about this dataset, please email me. 
+ Email: yujmo94@gmail.com | linus@unix.cn.com | 1103137684@qq.com
+ QQ: 1103137684
+ Wechat: m1103137

## Thanks(致谢)
1. cui yao yao(崔瑶瑶) 
2. gao liang(高亮)
3. ji hong cheng(吉鸿呈) 
4. mo yu jian(莫宇剑)
5. chao xin(巢新)
6. qin yin hua(秦银华)
7. zhang yu heng(张宇恒)
8. shi yu hang(石宇航)
