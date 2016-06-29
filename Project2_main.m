% Mahshid Najafi
% ENEE633 Project 2
% Main Function
%%
clc
clear all 
close all
format long
addpath libsvm-3.17\matlab\
%% Choose the type of effect/data to be studied and startup parameters
run_task=1;
while run_task==1
    choice_data=menu('Please choose what you want to study','Facial Expressions Effect','Pose Effect','Illumination Variation Effect');   
%     if choice_data==1
%         condition_amount=1;
%     else
%         condition_amount=menu('Please choose amount of effect on Test data','Too Little','Little','Average','A lot');
%     end
prompt={'Percent of data assigned as Training Set:'};
name='Training Set Length';
numlines=1;
defaultanswer={'70'};
percTrain=str2num(cell2mat(inputdlg(prompt,name,numlines,defaultanswer)));

    [Training_data,Training_labels,Test_data,Test_labels,c,g]=Data_division_SVM(choice_data,percTrain);
    choice_task=menu('Please choose the method','Linear and kernel SVM','PCA + Linear & Kernel SVM','LDA + Linear & Kernel SVM');
    switch choice_task
        case 1
            Task1=Linear_KernelSVM(Training_data,Training_labels,Test_data,Test_labels,c,g);
        case 2
            Task2=PCA_SVM(Training_data,Training_labels,Test_data,Test_labels,c,g);
        case 3
            Task3=LDA_SVM(Training_data,Training_labels,Test_data,Test_labels,c,g);

%             if choice_data==1
%                 display('Issues with limited Trainging,Please try LDA on pose or Effect data')
%             else

    end
    run_task=menu('Do you want to run another study?','Yes','No');
    
end

display('Done!')