clear, close all, clc;

%% Data processing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read data from Excel file
data = xlsread('Regression.xlsx', 'emission');

% Declaration of standard variables
y = data(:,end);
X = [ones(length(data),1) data(:,1:end-1)];
[n, k] = size(X);
k = k-1;
alpha = 0.05;

% Plot data
%figure; plotmatrix([y X(:,2:end)],'ro');

% Multivariate linear regression
[b, bint, r, rint, stats] = regress (y, X, alpha);
b
%stats

%% Quantity retrieval %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating the standard error of residuals for regression
S = sqrt(stats(end))

% Get R^2
R2 = stats(1)

% Calculating the standard error of each parameter
C = stats(end)*pinv(X'*X);
seB = sqrt(diag(C));

%% Hypothesis tests %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display the result of the ANOVA for regression
Fstar = stats(2)
Fcrit = finv(1-alpha, k, n-k-1);
hF    = Fstar > Fcrit
pF    = 1-fcdf(Fstar, k, n-k-1)

% Calculate the T* statistics for individual variables
Tstar = b./seB

% Get the critical t value at alpha
tcrit = tinv(1-alpha,n-k-1);

% Get decision and p-value on hypothesis test
hT    = abs(Tstar) > tcrit
pT    = 2.*min(tcdf(Tstar,n-k-1), 1-tcdf(Tstar,n-k-1)) %%%

%% Multicollinearity check %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VIF = [];

for j=2:k+1
  [~, ~, ~, ~, stats2] = regress (X(:,j), [ones(n,1) X(:, [2:j-1 (j+1):k+1] )], alpha);
  VIF(j-1) = 1/(1 - stats2(1));
end

VIF