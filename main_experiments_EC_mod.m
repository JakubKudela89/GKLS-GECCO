%% computational experiments with EC methods on the mod classes
% it takes the first problems from the first class, second problem from the
% second class, and so on (in total 50 problems are considered)

clear;clc;close all;
addpath("algos/LSHADE");addpath("algos/AGSK");
addpath("generated_classes\mod\");
rng(1,'Twister');

nr_problems = 50;

res_LSHADE = cell(nr_problems, 1);
res_AGSK =  cell(nr_problems, 1);
res_HSES =  cell(nr_problems, 1);

for i=1:nr_problems
    str = sprintf('@(x,i) f_mod_dim5_nr%02i(x,i)',i); problem_size = 5; str2save = ['res_mod5_EC','.mat'];
    %str = sprintf('@(x,i) f_mod_dim10_nr%02i(x,i)',i); problem_size = 10; str2save = ['res_mod10_EC','.mat'];
    f = str2func(str);
    fhd = @(x) f(x,i)+1;
    for j=1:1
        max_nfes = 50000*problem_size;
        pop_size = 10*problem_size;
        optimum = 0;
        lb = -1; ub = 1;
        fprintf('runing LSHADE, problem %u, run %u, ',i,j);
        [best_val, best_sol, res_LSHADE_str] = run_lshade(fhd,problem_size,max_nfes,pop_size,optimum,lb,ub);
        fprintf('result LSHADE %e \n',best_val);
        res_LSHADE{i,j} = res_LSHADE_str;

        fprintf('runing AGSK, problem %u, run %u, ',i,j);
        res_AGSK_str = AGSK(fhd,problem_size,max_nfes,lb,ub);
        fprintf('result AGSK %e \n',res_AGSK_str.bestval);
        res_AGSK{i,j} = res_AGSK_str;

  end
end

save(str2save);
