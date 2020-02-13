load a01_s01_e01.mat;
[num_frame rows cols] = size(depth);

for i = 1:num_frame
    ans = depth(i,:,:);
    ans = ans(:);
    ans = reshape(ans,rows,cols);
    imshow(ans);
    pause(1/30);
end