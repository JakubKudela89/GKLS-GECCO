%% computational experiments with BIRMIN on the simple and hard classes

clear;clc;close all;
addpath("algos\");
addpath("generated_classes\simple_hard\");
rng(1,'Twister');

nr_problems = 100;

res_DIR = cell(nr_problems, 1);

for i=1:nr_problems
    global fhd;
        fhd = @(x) f_D_dim5_numMin10_nrProbs100simple(x,i)+1; problem_size = 5; str = ['res_simple5_BIRMIN','.mat'];
%     fhd = @(x) f_D_dim5_numMin10_nrProbs100hard(x,i)+1; problem_size = 5; str = ['res_hard5_BIRMIN','.mat'];
%     fhd = @(x) f_D_dim10_numMin10_nrProbs100simple(x,i)+1; problem_size = 10; str = ['res_simple10_BIRMIN','.mat'];
%     fhd = @(x) f_D_dim10_numMin10_nrProbs100hard(x,i)+1; problem_size = 10; str = ['res_hard10_BIRMIN','.mat'];
    for j=1:1
        max_nfes = 50000*problem_size;
        pop_size = 10*problem_size;
        optimum = 0;
        lb = -1; ub = 1;
        Problem.f = 'f_gkls_directs';
        opts.dimension = problem_size;
        opts.maxevals = max_nfes;
        opts.testflag = 1;
        opts.globalmin = 0;
        opts.tol = 1e-10;
        opts.maxits   = max_nfes; % Maximum number of iterations.
        opts.showits  = 1;       % Print iteration stats.
    % -------------------------------------------------------------------------
      
    [Fmin, Xmin, history] = dBIRMIN(Problem, opts);
    res_DIR{i,j} = history;
  end
end
save(str);
