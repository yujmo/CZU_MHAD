function x = resize_feature(y,fix_size)

x = imresize(y, [fix_size(1) fix_size(2)], 'bicubic');
x = x(:);
mask = x;
if min(x) < 0
    x = x + abs(min(x)) * 2;
end
x(mask==0) = 0;
x = (x-min(x)) ./ (max(x)-min(x));