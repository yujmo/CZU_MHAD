clear;clc
% DMM-LBP descriptor for human action recognition using depth sequences
% This code implements the feature-level fusion
% Test Dataset: MSRAction3D Dataset

% If you have any question, feel free to contact me
% Chen Chen, chenchen870713@gmail.com
% https://sites.google.com/site/chenresearchsite/
% http://www.utdallas.edu/~cxc123730/


%%%% =======================================================================================================================

% If you use the code, please cite the following publications:

% [1] Chen Chen, Kui Liu, Nasser Kehtarnavaz, "Real-Time Human Action Recognition Based on Depth Motion Maps,"
% Journal of Real-Time Image Processing, 2013, doi: 10.1007/s11554-013-0370-1

% [2] Chen Chen, Roozbeh Jafari, and Nasser Kehtarnavaz, "Action Recognition from Depth Sequences Using Depth Motion Maps-based Local Binary 
% Patterns," in Proceedings of the IEEE Winter Conference on Applications of Computer Vision (WACV 2015), 
% Waikoloa Beach, HI, January 6-9, 2015.

%%%% ========================================================================================================================


NumAct = 20;          % number of actions in each subset
row = 240;
col = 320;
num_subject = 10;    % maximum number of subjects for one action
num_experiment = 3;  % maximum number of experiments performed by one subject

frame_remove = 2;    % remove the first and last a few frame (static posture)
                     % please refer to [2] for details
                     % This parameter can be tuned for optimal recognition
                     % performance.
                     
fix_size_front = [102;54]; fix_size_side = [102;75]; fix_size_top = [75;54];

  
%% Depth feature extraction

TotalFeature = [];
sub_index = [];
sample_label = [];


%%%% LBP parameters
num_point = 4; % number of sampling points
radius = 1;
mapping = getmapping(num_point,'u2'); 

f_row_blk = 4;
f_col_blk = 2;

s_row_blk = 4;
s_col_blk = 3;

t_row_blk = 3;
t_col_blk = 2;
tic
load Action3D_sample_list
% 1:length(sample_list)
AS=[1:334,361:533,537:545,547,548,550,553:557];
for i = AS%Test Accuracy = 0.905138
        
    % replace the following file directory with the directory where depth
    % files are located
    depth_name = sprintf('D:/MRS_action3D/MSR-Action3D(深度.mat)/%s_sdepth.mat',sample_list{i});
    
    if exist(depth_name,'file')        
        
        %%% //  extract depth feature
        
        load(depth_name);

        depth = depth(:,:,frame_remove+1:end-frame_remove);   %去掉前面2祯和最后两帧    
        [front, side, top] = depth_projection(depth);
%         imshow(front,[]);
        front = resize_feature(front,fix_size_front);
        side  = resize_feature(side,fix_size_side);
        top   = resize_feature(top,fix_size_top);
%         figure;
%         imshow(front,[]);
        
        %因为用的是投影图，所以即使视频帧数不同，不影响计算的特征向量的维数，因为投影图的大小是相同的
        F1 = get_LBP_fea_global(front, f_row_blk, f_col_blk, radius, num_point, mapping);
        F2 = get_LBP_fea_global(side, s_row_blk, s_col_blk, radius, num_point, mapping);
        F3 = get_LBP_fea_global(top, t_row_blk, t_col_blk, radius, num_point, mapping);

        F = [NormalizeFea(F1,0); NormalizeFea(F2,0); NormalizeFea(F3,0)]; % data normalization [-1, 1]
        TotalFeature = [TotalFeature, F];
        clear depth

        %%%% record subject index   记录人标签
        sub_index = [sub_index, str2double(sample_list{i}(6:7))];
        %%%% record sample label   记录行为标签
        sample_label = [sample_label, str2double(sample_list{i}(2:3))];
              
    end

    
end
        

TotalFeature = NormalizeFea(TotalFeature,0);


%% test

train_index = [1 3 4 6 7 9 10]; % training subject numbers
F_train_size = zeros(1,NumAct);
F_test_size  = zeros(1,NumAct);
F_train = [];
F_test = [];
yTr = [];
yTe = [];

for i = 1:NumAct 
    F = TotalFeature(:,sample_label==i);%行为是sample_label的所有特征
    ID = sub_index(sample_label==i);
    for k = 1:length(train_index)
        ID(ID==train_index(k)) = 0;
    end
    F_train = [F_train F(:,ID==0)];
    F_test  = [F_test F(:,ID>0)];
    F_train_size(i) = sum(ID==0);
    F_test_size(i)  = size(F,2) - F_train_size(i);
    yTr = [yTr; i*ones(F_train_size(i), 1)];
    yTe = [yTe; i*ones(F_test_size(i), 1)];
end


%%%%% PCA on training samples and test samples

Dim = size(F_train,2) - 10; 
disc_set = Eigenface_f(F_train,Dim);
F_train = disc_set'*F_train;
F_test  = disc_set'*F_test;
F_train = F_train./(repmat(sqrt(sum(F_train.*F_train)), [Dim,1]));
F_test  = F_test./(repmat(sqrt(sum(F_test.*F_test)), [Dim,1]));


train_data = [yTr,F_train'];
test_data = [yTe,F_test'];


%%%%%% KELM Classification %%%%%%%
para_C = 1000; % RBF kernel parameters tuned via 5-fold cross validation using training data
gamma = 10.5;

[TrainingTime, TestingTime, TrainAC, TestAC, TY] = elm_kernel(train_data, test_data, 1, para_C, 'RBF_kernel',gamma);
fprintf('Test Accuracy = %f\n', TestAC);


toc

