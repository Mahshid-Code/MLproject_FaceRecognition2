function [Accuracy_SVM]=Linear_KernelSVM(Training_data,Training_labels,Test_data,Test_labels,c,g)
format long


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

