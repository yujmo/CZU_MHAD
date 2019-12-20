

% DMM-LBP descriptor for human action recognition using depth sequences
% This code implements the feature-level fusion
% Test Dataset: MSRGesture3D Dataset

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


addpath('E:\activity recognition\dataset\MSRGesture3D'); % replace this directory before run the code!

prefix = 'sub_depth_';

total_subject = 10;%10个人
max_num = 36;%每个人最多36个动作 
total_file = 333;  % total 336 files, but 3 have no depth data(08_13,08_14,08_15)

    
frame_remove = 0; 

fix_size_front = [118;133]; fix_size_side = [118;29]; fix_size_top = [29;133];%三视图的大小
f_row_blk = 4; f_col_blk = 5;
s_row_blk = 4; s_col_blk = 2;
t_row_blk = 2; t_col_blk = 5;


num_point = 10; % number of sampling points
radius = 1;%半径
mapping = getmapping(num_point,'u2'); 

C = 12;  % total classes
NumAct = C;
TotalFeature = [];
sub_index = [];
sample_label = [];



for i = 1:total_subject
    
    if i < total_subject
        num_subject = strcat('0', num2str(i), '_');
    else
        num_subject = strcat(num2str(i), '_');
    end
    
    for j = 1:max_num
        
        if j < 10
            filename = strcat(prefix, num_subject, '0', num2str(j), '.mat');
        else
            filename = strcat(prefix, num_subject, num2str(j), '.mat');%文件名
        end
        
        if exist(filename, 'file')
            load(filename);
            depth = depth_part(:,:,frame_remove+1:end-frame_remove);
            clear depth_part
            
            %%% extract feature
            
            [front, side, top] = depth_projection(depth);
          
            front = resize_feature(front,fix_size_front);
            side  = resize_feature(side,fix_size_side);
            top   = resize_feature(top,fix_size_top);
                   
            %F1 = get_LBP_fea_global(front, f_row_blk, f_col_blk, radius, num_point, mapping);
            F1 = get_LBP_fea2(front, f_row_blk, f_col_blk, radius, num_point, mapping);
            
            %F2 = get_LBP_fea_global(side, s_row_blk, s_col_blk, radius, num_point, mapping);
            F2 = get_LBP_fea2(side, s_row_blk, s_col_blk, radius, num_point, mapping);
            
            %F3 = get_LBP_fea_global(top, t_row_blk, t_col_blk, radius, num_point, mapping);
            F3 = get_LBP_fea2(top, t_row_blk, t_col_blk, radius, num_point, mapping);
            
            
            F = [NormalizeFea(F1,0); NormalizeFea(F2,0); NormalizeFea(F3,0)];
            
            TotalFeature = [TotalFeature, F];
            
            sub_index = [sub_index, i];
            
            %%%% record sample label
            sample_label = [sample_label, ceil(j/3)];            
        end        
    end   
end

TotalFeature = NormalizeFea(TotalFeature,0);
    


%% \\ leave-one-subject-out cross validation

test_acc = zeros(total_subject,1);
size_test = zeros(total_subject,1);
RBF_C = [100, 10, 100000, 10000, 100, 100, 100, 1000, 10000, 100];
RBF_Gamma = [5.2, 0.3, 29.2, 149.4, 1.6, 1.0, 19.8, 3.0, 6.4, 2.2];


for i = 1:total_subject
    F_test = TotalFeature(:,sub_index==i);
    F_train = TotalFeature;
    F_train(:,sub_index==i) = [];
    yTe = sample_label(sub_index==i);
    yTr = sample_label;
    yTr(sub_index==i) = [];   
    
    F_train1 = []; F_test1 = []; yTr1 = []; yTe1 = [];
    F_train_size = []; F_test_size = [];
    for j = 1:C
        F_train1 = [F_train1, F_train(:,yTr==j)];
        F_test1 = [F_test1, F_test(:,yTe==j)];
        yTr1 = [yTr1, j*ones(1, length(find(yTr==j)))];
        yTe1 = [yTe1, j*ones(1, length(find(yTe==j)))];
        F_train_size = [F_train_size, length(find(yTr==j))];
        F_test_size = [F_test_size, length(find(yTe==j))];
    end
    F_train = F_train1;
    F_test = F_test1;
    yTr = yTr1;
    yTe = yTe1;
    size_test(i) = size(F_test,2);
    clear F_train1 F_test1 yTr1 yTe1
    
    %%%%% PCA on training samples and test samples
    Dim = size(F_train,2) - 10;   
    disc_set = Eigenface_f(F_train,Dim);
    F_train = disc_set'*F_train;
    F_test  = disc_set'*F_test;
    F_train = F_train./(repmat(sqrt(sum(F_train.*F_train)), [Dim,1]));
    F_test  = F_test./(repmat(sqrt(sum(F_test.*F_test)), [Dim,1]));

    train_data = [yTr',F_train'];
    test_data = [yTe',F_test'];
    
    %%%%%% KELM classification %%%%%%%
    [TrainingTime, TestingTime, TrainAC, TestAC, TY] = elm_kernel(train_data, test_data, 1, RBF_C(i), 'RBF_kernel',RBF_Gamma(i));
    test_acc(i) = TestAC;
    
end
%%
overall_acc = sum(test_acc.*size_test)/sum(size_test);
fprintf('Overall accuracy = %f; Mean accuracy = %f\n', overall_acc, mean(test_acc));

test_acc



