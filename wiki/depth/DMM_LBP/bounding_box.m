function y = bounding_box(img)

[row col] = size(img);


for i = 1:row
    if sum(img(i,:)) > 0
        top = i;
        break
    end
end

for i = row:(-1):1
    if sum(img(i,:)) > 0
        bottom = i;
        break
    end
end

for i = 1:col
    if sum(img(:,i)) > 0
        left = i;
        break
    end
end

for i = col:(-1):1
    if sum(img(:,i)) > 0
        right = i;
        break
    end
end

y = img(top:bottom, left:right);