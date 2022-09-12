function [summ]=sinx(x, n)
    summ = 0;
    for i = 0:n do
        summ = summ + (-1)^i * x^(2*i+1) / factorial(2*i+1)
    end;
endfunction;

e = 0.0001;
n = 0;
x = -4*%pi:0.1:4*%pi;
y = sin(x);
m = 1;
while m > e do
    sx = sinx(x, n);
    m = max(abs(y - sx));
    plot2d(x, sx, rect=[-13, -5, 13, 5]);
    n = n + 1;
end;
if n ~= 0 then
    n = n - 1;
end;
mprintf('%f\n', n);
plot2d(x, y, rect=[-13, -5, 13, 5]);
