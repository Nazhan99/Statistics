n = 5; % Number of samples
k = 6; % Number of subgroups
K = 20; % Number of Xbar chart points

sigma = [];
Xbar = [];

for i=1:K

% Generate some random samples
% in matrix of n by k
if i<round(K/2)
  X = gaussrnd(n,k,0,1);
else
  X=laprnd(n,k,0.9,1);
end

% Get the Xbar chart point
mean(X,1);
Xbar(i,:) = ans;

R = max(X) - min(X);
sigma = mean(R)./2.326;

% Get the CLs
CL(i) = mean(ans);
UCL(i) = CL(i) + 3*sigma/sqrt(n);
LCL(i) = CL(i) - 3*sigma/sqrt(n);

end

figure; hold on;

%stairs(1:k*K, kron(UCL,ones(1,k)), 'r'); % Subgroup control line
%stairs(1:k*K, kron(CL,ones(1,k)), 'g'); % Subgroup control line
%stairs(1:k*K, kron(LCL,ones(1,k)), 'b'); % Subgroup control line

stairs(1:k*K, kron(mean(UCL(1:10)),ones(1,k*K)), 'r'); % Average control line
stairs(1:k*K, kron((2/3)*mean(UCL(1:10)),ones(1,k*K)), 'r--'); % Average control line
stairs(1:k*K, kron((1/3)*mean(UCL(1:10)),ones(1,k*K)), 'r:'); % Average control line
stairs(1:k*K, kron(mean(CL),ones(1,k*K)), 'g'); % Average control line
stairs(1:k*K, kron((1/3)*mean(LCL(1:10)),ones(1,k*K)), 'b:'); % Average control line
stairs(1:k*K, kron((2/3)*mean(LCL(1:10)),ones(1,k*K)), 'b--'); % Average control line
stairs(1:k*K, kron(mean(LCL(1:10)),ones(1,k*K)), 'b'); % Average control line
plot(1:k*K, reshape(Xbar',[],1), 'k-o','MarkerFaceColor','k','MarkerSize',5.0);