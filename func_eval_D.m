function [val] = func_eval_D(GKLS_dim,GKLS_num_minima,GKLS_minima,x)
    GKLS_MAX_VALUE = 1E+100;
    GKLS_domain_left = -1;
    GKLS_domain_right = 1;
    GKLS_PRECISION = 1.0E-10;

    for i=0:GKLS_dim-1
        if ( (x(i+1) < GKLS_domain_left-GKLS_PRECISION) || (x(i+1) > GKLS_domain_right+GKLS_PRECISION) )
            val = GKLS_MAX_VALUE;
            return;
        end
    end
    index = 1;
    while ((index<GKLS_num_minima) && (norm(GKLS_minima.local_min(index+1,:)-x) > GKLS_minima.rho(index+1)) )
        index = index + 1;
    end
    if (index == GKLS_num_minima)
        norm_val = norm(GKLS_minima.local_min(0+1,:)-x);
        val = (norm_val * norm_val + GKLS_minima.f(0+1));
        return
    end
    if ( norm(x - GKLS_minima.local_min(index+1,:)) < GKLS_PRECISION )    
        val = GKLS_minima.f(index+1);
        return
    end
    norm_val = norm(GKLS_minima.local_min(0+1,:) - GKLS_minima.local_min(index+1,:));
    a = norm_val * norm_val + GKLS_minima.f(0+1) - GKLS_minima.f(index+1);
    rho = GKLS_minima.rho(index+1);
    norm_val = norm(GKLS_minima.local_min(index+1,:) - x);
    scal = 0.0;
    for i=0:GKLS_dim-1
        scal = scal + (x(i+1) - GKLS_minima.local_min(index+1,i+1)) * ...
            (GKLS_minima.local_min(0+1,i+1) - GKLS_minima.local_min(index+1,i+1));
    end
    val = (2.0/rho/rho * scal / norm_val - 2.0*a/rho/rho/rho)*norm_val*norm_val*norm_val + ...
        (1.0-4.0*scal/norm_val/rho + 3.0*a/rho/rho)*norm_val*norm_val + GKLS_minima.f(index+1);
end

