function [Accuracy_SVM]=Linear_KernelSVM(Training_data,Training_labels,Test_data,Test_labels,c,g)
format long
% nSubj=size(Control_data,2);
% nPixel=size(Control_data,1);
% IperSubj=size(Control_data,3);
% if nPixel==1920
%     nROW=48;
% else
%     nROW=23;
% end
% nTest=size(Effect_data,3);
% Training_data=[];
% Training_labels=[];
% % Training_group(1:68:end)=1;
% for i=1:IperSubj
%     Training_data=cat(2,Training_data,squeeze(Control_data(:,:,i)));
%     Training_labels=[Training_labels [1:nSubj]];
%     
% end
% Test_labels=[1:nSubj]';
% Test_data=Effect_data';

%% Apply SVM
% libsvm toolbox parameter options are set to default except kernel type:
% All available kernel types are considered
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
kernel_type={'linear: u''*v','polynomial: (gamma*u''*v + coef0)^degree',...
    'radial basis function: exp(-gamma*|u-v|^2)','sigmoid: tanh(gamma*u''*v + coef0)'};
for t=1:4
if t>1
    parameters= ['-b ',num2str(0),' -c ' num2str(c) ,' -g ' num2str(g), ' -t ' num2str(t-1)];
else
    parameters= [' -t ' num2str(t-1)];
end
%     [X,Y,Z,hC] = modsel(Training_labels',Training_data');
    SvmStruct = svmtrain( Training_labels,Training_data ,parameters);
    display('*****************************')
    display('*****************************')
    display(['Kernel Type is ' kernel_type{t}])
    display('Results:')
    [Classification_Test_labels, Accuracy_SVM,Prob_estimations] = svmpredict(Test_labels, Test_data,SvmStruct);
    display('*****************************')
    display('*****************************')
    if t<4
        display('Please press a key to continue...')
        pause
    end
end
    
end

