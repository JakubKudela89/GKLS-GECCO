clear;clc;
addpath("data\points\")
a = load("points009");

%writematrix(a,'a.csv');
%surf(a(:,1),a(:,2),a(:,3))

x = a(:,1); y = a(:,2); z = a(:,3);

% dt = delaunayTriangulation(x,y) ;
% tri = dt.ConnectivityList ;
% xi = dt.Points(:,1) ; 
% yi = dt.Points(:,2) ; 
% F = scatteredInterpolant(x,y,z);
% zi = F(xi,yi) ;
% trisurf(tri,xi,yi,zi) 
% %view(2)
% shading interp

mdl = scatteredInterpolant(x, y, z);
[xg, yg] = meshgrid(unique(x), unique(y));
zg = mdl(xg, yg);
sup = surf(xg,yg,zg)
shading interp