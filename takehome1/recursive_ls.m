function ls_estimate_dot = recursive_ls(t, x, omega, lambda, y)
    theta = x(1);
    P = x(2);
    
    err = omega' * theta - y;

    Pdot = lambda * P - P * (omega * omega') * P;
    thetadot = -P * omega * err;
    ls_estimate_dot = [thetadot; Pdot];
end