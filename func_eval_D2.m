function [val] = func_eval_D2(GKLS_dim,GKLS_num_minima,GKLS_minima,x)
    % does not work!! delta is wrong
    GKLS_MAX_VALUE = 1E+100;
    GKLS_domain_left = -1;
    GKLS_domain_right = 1;
    GKLS_PRECISION = 1.0E-10;
    GKLS_DELTA_MAX_VALUE = 10.0;
    delta = GKLS_DELTA_MAX_VALUE/2;

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
    val = ( (-6.0*scal/norm_val/rho + 6.0*a/rho/rho + 1.0 - delta/2.0) * ...
                                 norm_val * norm_val / rho / rho  + ...
          (16.0*scal/norm_val/rho - 15.0*a/rho/rho - 3.0 + 1.5*delta) * norm_val/rho + ...
          (-12.0*scal/norm_val/rho + 10.0*a/rho/rho + 3.0 - 1.5*delta)) * ...
          norm_val * norm_val * norm_val / rho + ...
          0.5*delta*norm_val*norm_val + GKLS_minima.f(index+1);
end

