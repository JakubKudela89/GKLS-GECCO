%% computational experiments with BIRMIN on the mod classes
% it takes the first problems from the first class, second problem from the
% second class, and so on (in total 50 problems are considered)

clear;clc;close all;
addpath("algos/"); addpath("generated_classes\mod\");
rng(1,'Twister');

nr_problems = 50;

res_DIR = cell(nr_problems, 1);


for i=1:nr_problems
    global fhd;
    str = sprintf('@(x,i) f_mod_dim5_nr%02i(x,i)',i); problem_size = 5; str2save = ['res_mod5_BIRMIN','.mat'];
    %str = sprintf('@(x,i) f_mod_dim10_nr%02i(x,i)',i); problem_size = 10; str2save = ['res_mod10_BIRMIN','.mat'];
    f = str2func(str);
    fhd = @(x) f(x,i)+1;
    for j=1:1
        max_nfes = 50000*problem_size;
        pop_size = 10*problem_size;
        optimum = 0;
        lb = -1; ub = 1;
        Problem.f = 'f_gkls_directs';
        opts.dimension = problem_size;
        opts.testflag = 1;
        opts.globalmin = 0;
        opts.tol = 1e-10;
        opts.maxevals = max_nfes;
        opts.maxits   = max_nfes; % Maximum number of iterations.
        opts.showits  = 1;       % Print iteration stats.
    % -------------------------------------------------------------------------
    
    
    [Fmin, Xmin, history] = dBIRMIN(Problem, opts);
    res_DIR{i,j} = history;
  end
end
save(str2save);
