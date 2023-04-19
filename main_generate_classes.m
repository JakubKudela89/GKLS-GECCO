%% script for generating matlab functions from the gkls generator - simple and hard classes
clear;clc;close all;
%% generate mex from c code

% codegen generate -args {1,2,3,4,5,6,7} main.c

%% call generated function

% dimensions
dim = 5; % classes simple and hard in dim 5
%dim = 10; % class simple and hard in dim 10
num_points = 100; % not relevant 

% number of minims
num_min = 10; % same for all classes

% distanc / radius
dist = 2/3; % same for all classes

radius = .3; % classes simple in dim 5 and 10
%radius = .2; % classes hard in dim 5 and 10

% number of generated files to data folder
problems = 100;

% 1: for D-type test function
% 2: for ND-type test function
% 3: for D2-type test function
test_function = 1; % same for all classes

suffix = 'simple'; % classes hard in dim 5 and 10
%suffix = 'hard'; % classes hard in dim 5 and 10

switch test_function
    case 1
        name = ['f_D_dim',num2str(dim),'_numMin',num2str(num_min),'_nrProbs',num2str(problems),suffix];
    case 2
        name = ['f_ND_dim',num2str(dim),'_numMin',num2str(num_min),'_nrProbs',num2str(problems),suffix]
    case 3
        name = ['f_D2_dim',num2str(dim),'_numMin',num2str(num_min),'_nrProbs',num2str(problems),suffix]
end

% call mex generated function
error_msg = generate_mex(dim,num_min,dist,radius,problems,test_function,num_points);

switch error_msg
    case 0
        disp('GLKS OK');
    case 1
        disp('GKLS_DIM_ERROR');
    case 2
        disp('GKLS_NUM_MINIMA_ERROR');
    case 3
        disp('GKLS_FUNC_NUMBER_ERROR');
    case 4
        disp('GKLS_BOUNDARY_ERROR  ');
    case 5
        disp('GKLS_GLOBAL_MIN_VALUE_ERROR');
    case 6
        disp('GKLS_GLOBAL_DIST_ERROR');
    case 7
        disp('GKLS_GLOBAL_RADIUS_ERROR');
    case 8
        disp('GKLS_MEMORY_ERROR');
    case 9
        disp('GKLS_DERIV_EVAL_ERROR');
    case 10
        disp('GKLS_GREAT_DIM');
    case 11
        disp('GKLS_RHO_ERROR');
    case 12
        disp('GKLS_PEAK_ERROR');
    case 13
        disp('GKLS_GLOBAL_BASIN_INTERSECTION');
    case 14
        disp('GKLS_PARABOLA_MIN_COINCIDENCE_ERROR');
    case 15
        disp('GKLS_LOCAL_MIN_COINCIDENCE_ERROR');
    case 16
        disp('GKLS_FLOATING_POINT_ERROR');
    otherwise
        disp('!! Uncaught error !!')
end


create_matlab_functions(dim,num_min,problems,name,test_function,dist,radius)

