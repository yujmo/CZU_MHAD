load a01_s01_e01_skeleton.mat;

total_joint = 25; 
J = [1,  1,  1,  2,  3,  3,  5  ,5   ,6  ,7  ,7   ,8   ,9  ,9  ,10  ,11  ,11  ,12  ,13  ,14  ,15  ,17  ,18  ,19;
     2,  13, 17, 21, 4,  21, 6  ,21  ,7  ,8  ,23  ,22  ,21 ,10 ,11  ,12  ,25  ,24  ,14  ,15  ,16  ,18  ,19  ,20];
 
[num_frame,~] = size(skeleton);
for i = 1:num_frame 
    joint = skeleton(i,:);
    ee = reshape(joint,4,25)';
    h = plot3(ee(:,1), ee(:,3), ee(:,2), 'r.', 'MarkerSize', 15);
    xlabel('X');ylabel('Z');zlabel('Y');
    set(gca,'DataAspectRatio',[1 1 1])
    for j = 1:size(J,2)
        point1 = ee(J(1,j),1:3);
        point2 = ee(J(2,j),1:3);
        line([point1(1),point2(1)], [point1(3),point2(3)], [point1(2),point2(2)], 'LineWidth',2);
    end
    axis([-1 1 2 3 -1 1]);
    grid on;
        
    axis tight;
    set(gcf,'nextplot','replacechildren','Position', [10, 10, 400, 1000]);
    pause(1/20);
    
end