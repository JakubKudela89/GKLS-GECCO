%% computational experiments with EC methods on the simple and hard classes

clear;clc;close all;
addpath("algos/LSHADE");addpath("algos/AGSK"); 
addpath("generated_classes\simple_hard\");
rng(1,'Twister');

nr_problems = 100; % 100 problems in each class

res_LSHADE = cell(nr_problems, 1);
res_AGSK =  cell(nr_problems, 1);
res_HSES =  cell(nr_problems, 1);

for i=1:nr_problems
    % choose a class to run the algorithms on
    fhd = @(x) f_D_dim5_numMin10_nrProbs100simple(x,i)+1; problem_size = 5; str = ['res_5_simple_EC','.mat'];
%     fhd = @(x) f_D_dim5_numMin10_nrProbs100hard(x,i)+1; problem_size = 5; str = ['res_5_hard_EC','.mat'];
%     fhd = @(x) f_D_dim10_numMin10_nrProbs100simple(x,i)+1; problem_size = 10; str = ['res_10_simple_EC','.mat'];
%     fhd = @(x) f_D_dim10_numMin10_nrProbs100hard(x,i)+1; problem_size = 10; str = ['res_5_hard_EC','.mat'];
    for j=1:1 % single repetition

        problem_size = 5;
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

% save the results
save(str);
