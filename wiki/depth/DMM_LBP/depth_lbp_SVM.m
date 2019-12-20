%% 环境变量
clear all; clc;
NumAct         = 15;    % 动作的个数
max_subject    = 5;     % 测试人数
max_experiment = 8;     % 每个每动作的测试次数

row = 424;col = 512;

%% 样本矩阵构建
file_dir = 'depth_mat\';
ActionNum = ['a01','a02', 'a03', 'a04', 'a05', 'a06', 'a07', 'a08', 'a09','a10','a11','a12', 'a13', 'a14', 'a17'];
fix_size_front = [212;256];
fix_size_side  = [212;128];
fix_size_top   = [128;256];

TargetSet = ActionNum;TotalNum = max_subject * max_experiment * NumAct;
D = 1065;TotalFeature = zeros(D,TotalNum);

%% 提取样本的DMM特征
subject_ind = cell(1,NumAct); %
frequency_ind   = cell(1,NumAct);
OneActionSample = zeros(1,NumAct); % 计算

for i = 1:NumAct
    action = TargetSet((i-1)*3+1:i*3);
    action_dir = strcat(file_dir,action,'\');
    fpath = fullfile(action_dir, '*.mat');
    depth_dir = dir(fpath);
    sub_ind  = zeros(1,length(depth_dir));
    freq_ind = zeros(1,length(depth_dir));
    for j = 1:length(depth_dir)
        depth_name = depth_dir(j).name;
        sub_num = str2double(depth_name(6:7));
        sub_ind(j) = sub_num;
        freq_num    = str2double(depth_name(10:11));
        freq_ind(j) = freq_num;
        
        fprintf("load: %s\n",strcat(action_dir,depth_name));
        
%         load(strcat(action_dir,depth_name));
%         depth = depth(:,:,:);
%         [front, side, top] = depth_projection(depth);
%         front = resize_feature(front,fix_size_front);
%         front = reshape(front,212,256);
%         
%         side = resize_feature(side,fix_size_side);
%         side = reshape(side,212,128);
%         
%         top = resize_feature(top,fix_size_top);
%         top = reshape(top,128,256);
%         
%         frontFeatureVector = get_LBP_fea_global(front, f_row_blk, f_col_blk, radius, num_point, mapping);
%         sideFeatureVector = get_LBP_fea_global(side, s_row_blk, s_col_blk, radius, num_point, mapping);
%         topFeatureVector = get_LBP_fea_global(top, t_row_blk, t_col_blk, radius, num_point, mapping);
%         
%         F = [NormalizeFea(frontFeatureVector,0); NormalizeFea(sideFeatureVector,0); NormalizeFea(topFeatureVector,0)]; % data normalization [-1, 1]
%         
%         TotalFeature(:,sum(OneActionSample)+j) = [F];
    end
    OneActionSample(i) = length(depth_dir);
    subject_ind{i} = sub_ind;
    frequency_ind{i} = freq_ind;
end
% TotalFeature = TotalFeature(:,1:sum(OneActionSample));
% save('TotalDepthFeature.mat','TotalFeature');
load TotalDepthFeature.mat

%% 分割训练、测试数据
total_trial = 20;                 % 循环测试次数
for random_human = 0:1
    if random_human == 1
        ratio = [1/3, 1/2, 2/3];
    end
    if random_human == 0
        ratio = [6/8, 5/8, 4/8, 3/8];
    end
    for ratio_i= 1:length(ratio)
        IND_sub  = cell(total_trial,NumAct);  % 循环次数 * 动作个数
        IND_freq = cell(total_trial,NumAct);  % 循环次数 * 动作个数
        F_train_size = zeros(1,NumAct);   % 训练样本的数量
        F_test_size  = zeros(1,NumAct);   % 测试样本的数量
        
        for trial = 1:total_trial
            F_train = [];
            F_test = [];
            count = 0;
            for i = 1:NumAct
                F = TotalFeature(:,count+1:count + OneActionSample(i));
                
                ID_sub  = subject_ind{i};
                ID_freq = frequency_ind{i};
                human_index = [2,1,5,3,4]; % unique 去掉矩阵中重复的元素 % randperm 打乱序列

               % human_index = randperm(length(unique(ID_sub)));           % unique 去掉矩阵中重复的元素    % randperm 打乱序列
                freq_index  = randperm(length(unique(ID_freq)));          % unique 去掉矩阵中重复的元素    % randperm 打乱序列
                
                if random_human == 1
                    train_index = human_index(1:ceil(length(human_index) * ratio(ratio_i)));
                    for k = 1:length(train_index)
                        ID_sub(ID_sub == train_index(k)) = 0;
                    end
                    F_train = [F_train F(:,ID_sub==0)];
                    F_test  = [F_test  F(:,ID_sub>0)];
                    
                    F_train_size(i) = sum(ID_sub==0);
                    F_test_size(i)  = size(F,2) - F_train_size(i);
                    count = count + OneActionSample(i);
                end
                if random_human == 0
                    train_index = freq_index(1:ceil(length(freq_index) * ratio(ratio_i)));
                    for k = 1:length(train_index)
                        ID_freq(ID_freq == train_index(k)) = 0;
                    end
                    F_train = [F_train F(:,ID_freq==0)];
                    F_test  = [F_test  F(:,ID_freq>0)];
                    
                    F_train_size(i) = sum(ID_freq==0);
                    F_test_size(i)  = size(F,2) - F_train_size(i);
                    count = count + OneActionSample(i);
                end
            end
            
            %%%%% PCA on training samples and test samples
            Dim = size(F_train,2) - round(size(F_train,2) * 0.15);
            disc_set = Eigenface_f(single(F_train),Dim);
            F_train = disc_set' * F_train;
            F_test  = disc_set' * F_test;
            F_train = F_train ./ (repmat(sqrt(sum(F_train .* F_train)), [Dim,1]));
            F_test  = F_test  ./ (repmat(sqrt(sum(F_test  .* F_test)), [Dim,1]));
            
            B = 1:1:15;
            train_labels = repmat(B,unique(F_train_size),1);
            train_labels = train_labels(:);
            test_labels = repmat(B,unique(F_test_size),1);
            test_labels = test_labels(:);

            tic;
            cmd = ['-c ',num2str(32),' -g ',num2str(0.125)];
            Model = libsvmtrain(train_labels,F_train',cmd);
            [predicted_label,accuracy,decision_values] = libsvmpredict(test_labels,F_test',Model);
            accuracy(trial) = accuracy(1);
            ttt1 = toc;
            
        end
        
        strs = strcat('|random_human:',num2str(random_human),'|ratio参数：',num2str(ratio(ratio_i)),'|识别率:',num2str(mean(accuracy)),'|分类时间:',num2str(ttt1),'|训练次数:',num2str(trial),'\n');
        fprintf(strs);
    end
end