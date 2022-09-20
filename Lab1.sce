function [summ]=sinx(x, n)
    summ = 0;
    for i = 0:n do
        summ = summ + (-1).^i * x.^(2*i+1) / factorial(2*i+1)
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
    n = n + 1;
    clf();
    plot2d(x, [sx' y'], rect=[-13, -5, 13, 5], style=[5, 2], leg="Разложение синуса в ряд Тейлора с количеством членов: " + string(n) + "@Истинный синус");
    xtitle("Разница между синусом и его разложением в ряду Тейлора", "x", "y");
    sleep(1000);
end;
mprintf('%f\n', n);
