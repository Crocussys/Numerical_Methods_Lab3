function usage()
    mprintf("Lab3 [path]\n\n")
    mprintf("path - Файл точек\n")
endfunction

function ValueError()
    mprintf("Error 3: Invalid value\n")
    return -3
endfunction

function [txt, err]=InFile(file_name)
    [fl, err] = mopen(file_name, 'r')
    if err ~= 0 then
        mprintf("Error 2: File opening error\n")
        return
    end
    txt = mgetl(fl)
    mclose(fl)
endfunction

argv = sciargs()
[m, argc] = size(argv)
if argc >= 3 then
    if argv(3) == "-h" then
        usage()
        return 0
    end
end
if argc < 3 then
    usage()
    mprintf("\nError 1: Not enough arguments")
    return -1
end

[txt, err] = InFile(argv(3))
if err ~= 0 then
    return -2
end
[n, m] = size(txt)
if n < 2 then
    return ValueError()
end
x_str = strsplit(txt(1), " ")
[x_size, m] = size(x_str)
x = strtod(x_str)
for j = 1:x_size do
    if x(j) == %nan then
        return ValueError()
    end
end
y_str = strsplit(txt(2), " ")
[y_size, m] = size(y_str)
if y_size ~= x_size then
    return ValueError()
else
    count = x_size
end
y = strtod(y_str)
for j = 1:y_size do
    if y(j) == %nan then
        return ValueError()
    end
end

x2 = x .* x
x3 = x2 .* x
x4 = x3 .* x
y2 = y .* x
y3 = y2 .* x
M = [count, sum(x), sum(x2);
       sum(x), sum(x2), sum(x3);
       sum(x2), sum(x3), sum(x4)]
N = [sum(y); sum(y2); sum(y3)]
A = inv(M) * N
x_ans = x(1):0.01:x(count)
y_ans = A(1) + A(2) .* x_ans + A(3) .* x_ans .^ 2

plot2d(x_ans, y_ans, style=color("blue"), leg="Аппроксимация");
plot2d(x, y, style=-9, leg="Исходные данные");
g=get('current_axes')
g.children(1).children.mark_foreground = color("red")
g.children(1).children.mark_background = color("red")
xtitle("Аппроксимация", "x", "y");
