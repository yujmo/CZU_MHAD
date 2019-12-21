# DMMs-based LBP features
&emsp;&emsp;A computationally efficient action recognition framework using depth motion maps (DMMs)-based local binary patterns (LBPs).
## DMMs calculation

&emsp;&emsp;Given a depth video sequence with $N$ frames, each frame in the video is projected onto three orthogonal Cartesian planes to form three 2D projected maps, denoted by $map_f$ , $map_s$, and $map_t$. DMMs are then generated as follows:
$$
D M M_{\{f, s, t\}}=\sum_{j=1}^{N-1}\left|\operatorname{map}_{\{f, s, t\}}^{j+1}-\operatorname{map}_{\{f, s, t\}}^{j}\right|
$$

&emsp;&emsp;Where $j$ is the frame index. A bounding box is set to extract the non-zero region (region of interest) in each DMM.

## DMMs-based LBP features
&emsp;&emsp;The LBP operator is a simple yet effective gray scale and rotation invariant texture operator that has been used in various applications. It labels pixels in an image with decimal numbers that encode local texture information. Given a pixel (scalar value) $g_c$ in an image, its neighbor set contains pixels that are equally spaced on a circle of radius $r(r>0)$ with the center at $g_c$. If the coordinates of $g_c$ are $(0, 0)$ and $m$ neighbors $\left\{g_{i}\right\}_{i=0}^{m-1}$ are considered, the coordinates of $g_i$ are $(-r \sin (2 \pi i / m), r \cos (2 \pi i / m))$. The gray values of circular neighbors that do not fall in the image grids are estimated by bilinear interpolation. The LBP is created by thresholding the neighbors $\left\{g_{i}\right\}_{i=0}^{m-1}$ with the center pixel $g_c$ to generate an $m$-bit binary number. The resulting LBP for $g_c$ can be expressed in decimal form as follows: 
$$
L B P_{m, r}\left(g_{c}\right)=\sum_{i=0}^{m-1} U\left(g_{i}-g_{c}\right) 2^{i}
$$

&emsp;&emsp;Where $U\left(g_{i}-g_{c}\right)=1$ if $g_i$ ≥ $g_c$ and $U\left(g_{i}-g_{c}\right)=0$ if $g_{i}<g_{c}$. Although the LBP operator produces $2^{m}$ different binary patterns, a subset of these patterns, named uniform patterns, is able to describe image texture. After obtaining the LBP codes for pixels in an image, an occurrence histogram is computed over an image or a region to represent the texture information.

## Running the demos and results
1. Depth_LBP_CRC.m 
    &emsp;&emsp;"DMMs-based LBP features are extracted from depth images and classified by CRC classifier".

    + Human Random
        | $\frac{1}{3}$ | $\frac{1}{2}$ | $\frac{2}{3}$ |
        | :-: | :-: | :-: | 
        | 75.76% | 87.22% | 93.18% | 

    + Frequency Random
        | $\frac{3}{8}$ | $\frac{4}{8}$ | $\frac{5}{8}$ | $\frac{6}{8}$ |
        | :-: | :-: | :-: | :-: |
        | 95.82% | 96.50% | 97.05% | 97.02% | 



2. Depth_lLBP_Discriminant_Analysis.m
3. Depth_LBP_KNN.m
4. Depth_LBP_Naive_bayes.m
5. Depth_LBP_RandomF.m


## Cited paper
    C. Chen, R. Jafari and N. Kehtarnavaz, "Action Recognition from Depth Sequences Using Depth Motion Maps-Based Local Binary Patterns," 2015 IEEE Winter Conference on Applications of Computer Vision, Waikoloa, HI, 2015, pp. 1092-1099.
    doi: 10.1109/WACV.2015.150

## URL  of the Cited paper 
    http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7046004&isnumber=7045853
