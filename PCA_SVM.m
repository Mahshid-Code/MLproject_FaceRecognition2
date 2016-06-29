function Task2=PCA_LinearSVM(Training_data,Training_labels,Test_data,Test_labels,c,g)

% Mahshid Najafi
% ENEE633 Project 2
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


% nSubj=size(Control_data,2);
% nPixel=size(Control_data,1);
% IperSubj=size(Control_data,3);
% if nPixel==1920
%     nROW=48;
% else
%     nROW=23;
% end
% Training_data=[];
% Training_labels=[];
%
% for i=1:IperSubj
%     Training_data=cat(2,Training_data,squeeze(Control_data(:,:,i)));
%         Training_labels=[Training_labels [1:nSubj]];
%
% end
%
% % Training_data=squeeze(Control_data(:,:,frontier_image));
%
% % Plot samples of average face and eigen faces
% % figure,
% Avg_face=mean(Training_data,2);
% % colormap('Gray')
% % imagesc(reshape(Avg_face,nROW,[]));
% % title('Average Face')
% % axis off;
%
% %%
% A=Training_data-repmat(Avg_face,1,size(Training_data,2));
% L = A'*A;
% prompt={'Enter the Number of Components to be considered:'};
% name='Number of Components';
% numlines=1;
% defaultanswer={'70'};
% nPCA=str2num(cell2mat(inputdlg(prompt,name,numlines,defaultanswer)));
% Training_PCA_matrix=pca(Training_data*Training_data','NumComponents' ,nPCA)';
% % Training_PCA_matrix=pca(A,'NumComponents' ,nPCA)';
%
% % figure,
% % colormap('Gray')
% % for i=1:9
% %     subplot(3,3,i)
% %     imagesc(reshape(Training_PCA_matrix(i+1,:),nROW,[]));
% %     if i==2
% %         title('Samples of Eigen Faces');
% %     end
% %     axis off;
% % end
%
%
%
% %%
% Training_PCA=Training_PCA_matrix*A;
% Training_PCA_mu=[];
% Training_PCA_cov=zeros(nPCA,nPCA,nSubj);
% for i=1:nSubj
%     Training_PCA_cov(:,:,i) = 1/(IperSubj-1).*squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj))*squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj))';
%     Training_PCA_mu= [Training_PCA_mu squeeze(mean(squeeze(Training_PCA(:,(i-1)*IperSubj+1:i*IperSubj)),2))];
% end
% Test_labels=[1:nSubj]';
%
%         Test_data=Effect_data-repmat(Avg_face,1,nSubj);
%         Test_PCA=Training_PCA_matrix*Test_data;
%

Task2=Accuracy_SVM;

