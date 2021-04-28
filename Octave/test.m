
n=5; %Number of samples
k=6;%Number of subgroups
K=20;%Number of Xbar chart points

Xbar=[];

for i=1:K
 
 %Generate some random samples
 %in matrix of n by k
 X=gaussrnd(n,k,0,1);
 
 %Get the Xbar chart points
 mean(X,1);
 Xbar(i,:)=ans;
 
 % Get the CLs
CL(i) = mean(ans);
UCL(i) = CL(i) + 3*sigma/sqrt(n);
LCL(i) = CL(i) - 3*sigma/sqrt(n);

  
end
%graphics_toolkit ("gnuplot");
%setenv("GNUTERM","qt")

figure; hold on;
stairs(1:k*K, kron(mean(UCL),ones(1,k*K)), 'r');
stairs(1:k*K, kron(mean(CL),ones(1,k*K)), 'g');
stairs(1:k*K, kron(mean(LCL),ones(1,k*K)), 'b');
plot(1:k*K, Xbar(:)', 'k-');
