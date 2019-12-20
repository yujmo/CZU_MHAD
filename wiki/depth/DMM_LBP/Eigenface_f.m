function disc_set=Eigenface_f(Train_SET,Eigen_NUM)
%------------------------------------------------------------------------
% Eigenface computing function

[NN,Train_NUM]=size(Train_SET);

if NN<=Train_NUM % not small sample size case
    
   Mean_Image=mean(Train_SET,2);  
   Train_SET=Train_SET-Mean_Image*ones(1,Train_NUM);
   R=Train_SET*Train_SET'/(Train_NUM-1);
   
   [V,S]=Find_K_Max_Eigen(R,Eigen_NUM);
   disc_value=S;
   disc_set=V;

else % for small sample size case
     
  Train_SET=Train_SET-(mean(Train_SET,2))*ones(1,Train_NUM);
  R=Train_SET'*Train_SET/(Train_NUM-1);
  [V,S]=Find_K_Max_Eigen(R,Eigen_NUM);
  clear R
  disc_set=zeros(NN,Eigen_NUM);
  Train_SET=Train_SET/sqrt(Train_NUM-1);
  
  for k=1:Eigen_NUM
    a = Train_SET*V(:,k);
    b = (1/sqrt(S(k)));
    disc_set(:,k)=b*a;
  end

end

function [Eigen_Vector,Eigen_Value]=Find_K_Max_Eigen(Matrix,Eigen_NUM)

[NN,NN]=size(Matrix);
[V,S]=eig(Matrix);        %Note this is equivalent to; [V,S]=eig(St,SL); also equivalent to [V,S]=eig(Sn,St); %

S=diag(S);
[S,index]=sort(S);

Eigen_Vector=zeros(NN,Eigen_NUM);
Eigen_Value=zeros(1,Eigen_NUM);

p=NN;
for t=1:Eigen_NUM
    Eigen_Vector(:,t)=V(:,index(p));
    Eigen_Value(t)=S(p);
    p=p-1;
end



