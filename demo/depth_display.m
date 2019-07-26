load('a01_s01_e01_depth.mat');
[d rows cols] = size(depth);
for i=1:d
    img = depth(i,:,:);
    img = reshape(img,rows,cols);
    imshow(img);
    pause(0.1);
end