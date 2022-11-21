clear variables


ani_time_length = 5;
Xi = zeros(7, 7, ani_time_length);
Yi = zeros(7, 7, ani_time_length);
Zi = zeros(7, 7, ani_time_length);
point1 = zeros(1, 3);
point2 = zeros(1, 3);
point3 = zeros(1, 3);

r = 3;


for i = 1:1:ani_time_length
    length1 = i;
    length2 = i;
    length3 = i;

    yaw_angle = 5;
    %points of PAMs plane
    p1 = [r*cos(yaw_angle) r*sin(yaw_angle) length1];
    p2 = [r*cos(yaw_angle+120) r*sin(yaw_angle+120) length2];
    p3 = [r*cos(yaw_angle+240) r*sin(yaw_angle+240) length3];
    
    point1(i, 1) = p1(1);
    point1(i, 2) = p1(2);
    point1(i, 3) = p1(3);

    point2(i, 1) = p2(1);
    point2(i, 2) = p2(2);
    point2(i, 3) = p2(3);

    point3(i, 1) = p3(1);
    point3(i, 2) = p3(2);
    point3(i, 3) = p3(3);
    

    %plane calculation
    v1 = p1 - p2;
    v2 = p1 - p3;
    normal = cross(v1,v2);
    
    %plane of form Ax +By + Cz + D = 0
    d = p1(1)*normal(1) + p1(2)*normal(2) + p1(3)*normal(3);
    d = -d;
    x = -r:r; y = -r:r;
    [X,Y] = meshgrid(x,y);
    Z = (-d - (normal(1)*X) - (normal(2)*Y))/normal(3);

    Xi(:, :, i) = X;
    Yi(:, :, i) = Y;
    Zi(:, :, i) = Z;
    
    
end

%plots plane
figure; 
for i = 1:1:ani_time_length
    h = surf(X,Y,Z);
    zlim([0,10])
    grid on;
    xlabel('X axis'), ylabel('Y axis'), zlabel('Z axis')
    set(gca,'CameraPosition',[5 5 2]);
    hold on
    
    set(h, 'xdata', Xi(:, :, i), 'ydata', Yi(:, :, i), 'zdata',Zi(:, :, i))
    line1 = plot3([point1(i, 1) point1(i, 1)],[point1(i,2) point1(i,2)],[0 point1(i,3)],'r-', 'LineWidth',3);
    line2 = plot3([point2(i, 1) point2(i, 1)],[point2(i,2) point2(i,2)],[0 point2(i,3)],'r-', 'LineWidth',3);
    line3 = plot3([point3(i, 1) point3(i, 1)],[point3(i,2) point3(i,2)],[0 point3(i,3)],'r-', 'LineWidth',3);
    pause(0.1)
    drawnow
    hold off
end

%https://uk.mathworks.com/matlabcentral/fileexchange/37879-circle-plane-in-3d