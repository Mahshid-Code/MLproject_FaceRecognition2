function Task2=PCA_LinearSVM(Training_data,Training_labels,Test_data,Test_labels,c,g)

% PCA followed by Linear SVM

%%
format long
CV=Training_data'*Training_data;
[V l]=eig(CV);
PCA_matrix=V(:,end-size(Training_data,1)+2:end);
Training_PCA=Training_data*PCA_matrix;
Test_PCA=Test_data*PCA_matrix;
%% Apply SVM

kernel_type={'linear: u''*v','polynomial: (gamma*u''*v + coef0)^degree',...
    'radial basis function: exp(-gamma*|u-v|^2)','sigmoid: tanh(gamma*u''*v + coef0)'};
for t=1:4
    if t>2
        parameters= ['-b ',num2str(0),' -c ' num2str(c) ,' -g ' num2str(g), ' -t ' num2str(t-1)];
    else
        parameters= [' -t ' num2str(t-1)];
    end
    SvmStruct = svmtrain( Training_labels,Training_PCA ,parameters);
    display('*****************************')
    display('*****************************')
    display(['Kernel Type is ' kernel_type{t}])
    display('Results:')
    [Classification_Test_labels, Accuracy_SVM,Prob_estimations] = svmpredict(Test_labels, Test_PCA,SvmStruct);
    display('*****************************')
    display('*****************************')
    if t<4
        display('Please press a key to continue...')
        pause
    end
    
end



Task2=Accuracy_SVM;

