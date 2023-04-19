function create_matlab_functions(dim,num_min,problems,name,test_function,dist,radius)
    addpath("data/func_info/")
    addpath("data/local_minimizers/")
    
    rho = zeros(num_min,problems);
    
    for j=1:problems
        str = sprintf('test%03i.txt',j);
        fileID = fopen(str,'r');
        A = fscanf(fileID,"%s");
        fclose(fileID);      
        for i=1:num_min 
            s = ['rho\[',num2str(i),'\]='];
            [a,b] = regexp(A,s);
            rho(i,j) = str2num(A(b+1:b+12));
        end    
        GKLS_minima(j).rho = rho(:,j);
        str = sprintf('lmin%03i',j);
        lmin = load(str);
        local_minimizers_pos= lmin(:,1:dim);
        local_minimizers_f = lmin(:,dim+1);
        GKLS_minima(j).f = local_minimizers_f;
        GKLS_minima(j).local_min = local_minimizers_pos;
    end
    
    str = [name,'.m'];
    fileID = fopen(str,'w');
    fprintf(fileID, 'function [val,GKLS_minima] = %s(x,id)\n\n',name);
    fprintf(fileID, '%% generated %i problems in dimension %i with %i local minima, distanc = %f, and radius = %f\n\n', problems, dim, num_min, dist, radius);
    fprintf(fileID, 'GKLS_dim = %i;\n',dim);
    fprintf(fileID, 'GKLS_num_minima = %i;\n',num_min);
    fprintf(fileID, 'switch id\n');    
    for j=1:problems
    fprintf(fileID, 'case %i\n',j);    
        fprintf(fileID, 'GKLS_minima.rho = [');
        for i = 1:num_min-1
            fprintf(fileID,'\t %f;\n',GKLS_minima(j).rho(i));
        end
        fprintf(fileID,'\t %f];\n',GKLS_minima(j).rho(num_min));
    
        fprintf(fileID, 'GKLS_minima.f = [');
        for i = 1:num_min-1
            fprintf(fileID,'\t %f;\n',GKLS_minima(j).f(i));
        end
        fprintf(fileID,'\t %f];\n',GKLS_minima(j).f(num_min));
    
        fprintf(fileID, 'GKLS_minima.local_min = [');
        for i = 1:num_min-1
            fprintf(fileID,'\t');
            for k=1:dim
                fprintf(fileID,' %f,',GKLS_minima(j).local_min(i,k));
            end
            fprintf(fileID,';\n');
        end
        fprintf(fileID,'\t');
            for k=1:dim
                fprintf(fileID,'%f, ',GKLS_minima(j).local_min(num_min,k));
            end
        fprintf(fileID,'];\n');
    end    
    fprintf(fileID,'\n end\n');
    
    switch test_function
        case 1
            fprintf(fileID,'[val] = func_eval_D(GKLS_dim,GKLS_num_minima,GKLS_minima,x);\n');
        case 2
            fprintf(fileID,'[val] = func_eval_ND(GKLS_dim,GKLS_num_minima,GKLS_minima,x);\n');
        case 3
            fprintf(fileID,'[val] = func_eval_D2(GKLS_dim,GKLS_num_minima,GKLS_minima,x);\n');
    end
    fprintf(fileID,'\n end');
    fclose(fileID);
end
