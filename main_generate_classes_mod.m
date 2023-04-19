%% script for generating matlab functions from the gkls generator - the mod class
% the script generates 50 classes of 50 problems each, with random parameters (with a fixed seed for replicability)
%% generate mex from c code

% codegen generate -args {1,2,3,4,5,6,7} main.c

%% call generated function

clear;clc; dist_all = []; radius_all = []; num_min_all = []; test_function_all = [];
rng(1,'twister'); % seed

% dimensions
dim = 10;
num_points = 100;
problems = 50;

for i=1:problems
    % number of minims
    dist = rand();   % d in [0,1] 
    radius = dist/(randi(9)+1); % r in [d/2,d/10]
    num_min = round(10^(1+2*rand()));    % n_min in [10^1,10^3]
    test_function = randi(2); % coinflip for D and ND
    suffix = sprintf('_nr%02i',i);
    dist_all(i) = dist; radius_all(i) = radius; num_min_all(i) = num_min; test_function_all(i) = test_function;
    switch test_function
        case 1
            name = ['f_mod_dim',num2str(dim),suffix];
        case 2
            name = ['f_mod_dim',num2str(dim),suffix];
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

end