load cyy_a1_t1_depth.mat;
[num_frame rows cols] = size(depth);

for i = 1:num_frame
    ans = depth(i,:,:);
    ans = ans(:);
    ans = reshape(ans,rows,cols);
    imshow(uint8(ans));
    pause(1/30);
end