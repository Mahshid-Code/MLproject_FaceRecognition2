function LDA_Matrix = LDA_calc(LDA_input,Lables)
%LDA
nLDA=max(Lables)-1; %LDA dimention is #of classes-1
% SW
mean_w=(mean(LDA_input'))';
mean_sub=[];
for i=1:max(Lables)
    Ind=find(Lables==i);
    if length(Ind)==1
      m=LDA_input(:,Ind);
    else
     m=(mean(LDA_input(:,Ind)'))';
    end
    mean_sub=cat(2,mean_sub,m);
    for j=1:length(Ind)
        normLDA_input(:,Ind(j))=LDA_input(:,Ind(j))-m;
    end
end
for i=1:max(Lables)
    Ind = find(Lables==i);
    if i==1 SW = normLDA_input(:,Ind)*normLDA_input(:,Ind)';
    else SW = SW + normLDA_input(:,Ind)*normLDA_input(:,Ind)';
    end
    
end
%SB
m_1=bsxfun(@minus,mean_sub,mean_w);
SB=2*m_1*m_1';
[V lambda]=eig(SB,SW);
U=abs(diag(lambda));
U=[U (1:length(U))'];
U=sortrows(U,1);
LDA_Matrix=V(:,U(end-nLDA+1:end,2));

