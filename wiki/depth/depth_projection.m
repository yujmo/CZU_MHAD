function [F,S,T] = depth_projection(X)

% X: depth map (3D)

%       y
%       |   
%       |  
%       |_ _ _ x
%      /
%     /
%    z
%

[D rows cols] = size(X);
X2D = reshape(X, rows*cols, D);
max_depth = max(X2D(:));

F = zeros(rows, cols);      % 正视图 
S = zeros(rows, max_depth); % 侧视图
T = zeros(max_depth, cols); % 俯视图

for k = 1:D   
    front = X(k,:,:);
    front = front(:);
    front = reshape(front,rows, cols);
    side = zeros(rows, max_depth);
    top = zeros(max_depth, cols);
    for i = 1:rows
        for j = 1:cols
            if front(i,j) ~= 0
                side(i,front(i,j)) = j;   % side view projection (y-z projection)
                top(front(i,j),j)  = i;    % top view projection  (x-z projection)
            end
        end
    end
    
    if k > 1
        F = F + double(abs(front - front_pre));
        S = S + double(abs(side - side_pre));
        T = T + double(abs(top - top_pre));
    end   
    front_pre = front;
    side_pre  = side;
    top_pre   = top;
end

F = bounding_box(F);
S = bounding_box(S);
T = bounding_box(T);