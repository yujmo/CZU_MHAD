function fea = get_LBP_fea2(img, row_blk, col_blk, radius, num_point, mapping)

% get lbp histogram block by block

[m,n] = size(img);

xsize = round(m/row_blk);
ysize = round(n/col_blk);

xolap = round(xsize/2); % overlap, half of the block size
yolap = round(ysize/2); 

m = 2 * xolap * row_blk;
n = 2 * yolap * col_blk;

img = imresize(img, [m,n], 'bicubic');

fea = [];
for i = 1:xolap:m-xolap-1
    for j = 1:yolap:n-yolap-1
        blk = img(i:i+2*xolap-1, j:j+2*yolap-1);
        H = lbp(blk,radius,num_point,mapping,'h');
        fea = [fea; H(:)];
    end
end




