function [Training_data,Training_labels,Test_data,Test_labels,c,g]=Data_division_SVM(choice_data,percTrain)
% Author: Mahshid Najafi

Input_data=[];
labels=[];
%% Load the data according to your choice
switch choice_data
    case 1
        load('CG_Facial.mat')
        display('You chose to study the facial expression effect!')
        load('data.mat'); % Size images 24x21 and 3 Images per subject
        data=face;
        for i=1:size(data,3)
            Input_data=[Input_data; reshape(data(:,:,i),1,(size(data,1)*size(data,2)))];
            labels=[labels;i*ones(1,3)'];
        end
        I_perSub=3;
        nSubj=200;
        
        pp=round(I_perSub*percTrain/100);
        c=CG(pp,1);
        g=CG(pp,2);
        frontier_image=1;
        %--------------------
    case 2
        load('CG_pose.mat')
        nSubj=68;
        
        display('You chose to study the pose effect!')
        load('pose.mat');% Size images 48x40 and 3 Images per subject
        data=pose;
        for i=1:68
            for j=1:13
                Input_data=[Input_data ; reshape(data(:,:,j,i),1,(size(data,1)*size(data,2)))];
            end
        end
        for i=1:68
            labels=[labels;i*ones(1,13)'];
        end
        I_perSub=13;
        
        pp=round(I_perSub*percTrain/100);
        c=CG(pp,1);
        g=CG(pp,2);
        %--------------------
    case 3
        load('CG_illum.mat')
        nSubj=68;
        
        display('You chose to study the illumination effect!')
        load('illumination.mat');
        data=illum;
        for i=1:68
            Input_data=cat(2,Input_data,data(:,:,i));
            labels=[labels;i*ones(1,21)'];
        end
        Input_data=Input_data';
        I_perSub=21;
        
        pp=round(I_perSub*percTrain/100);
        c=CG(pp,1);
        g=CG(pp,2);
end
%% Normalize the data
ma=max(max(Input_data));
mi=min(min(Input_data));
scaling_factor=max(ma,abs(mi));
Input_data=Input_data./scaling_factor;

Training_data=[];
Training_labels=[];
Test_data=[];
Test_labels=[];
nsamples=size(Input_data,1)/nSubj;

for i=1:nSubj
    Training_data=[Training_data; Input_data((i-1)*nsamples+1:(i-1)*nsamples+pp,:)];
    Training_labels=[Training_labels; labels((i-1)*nsamples+1:(i-1)*nsamples+pp,1)];
    Test_data=[Test_data; Input_data((i-1)*nsamples+pp+1:(i-1)*nsamples+nsamples,:)];
    Test_labels=[Test_labels; labels((i-1)*nsamples+pp+1:(i-1)*nsamples+nsamples,1)];
end




