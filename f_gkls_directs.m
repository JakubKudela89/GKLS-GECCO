function [val] = f_gkls_directs(x)
global fhd;

if nargin == 0
    val.nx = 0;
    val.ng = 0;
    val.nh = 0;
    val.xl = @(i) -1;
    val.xu = @(i) 1;
    val.fmin = @(i) 0;
    val.xmin = @(i) 0;
    return
end
x = x';
[m,n] = size(x);

if m > 1 && n> 1 
    for i=1:m
        val(i,1) = fhd(x(i,:));
    end    
else
    val = fhd(x(1,:));
end

end

