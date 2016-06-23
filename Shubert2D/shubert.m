%==============================================================================
% F6: Shubert
%==============================================================================
function fit = shubert(x)
% F6: Shubert
% Variable ranges: x_i in  [−10, 10]^n, i=1,2,...,n
% No. of global peaks: n*3^n
% No. of local peaks: many.

[tmp,D] = size(x);
result = 1;
j = [1:5];
for i=1:D
	result = result * sum(j.*cos((j+1).*x(i)+j));
end
fit = result;
