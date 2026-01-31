function ls_estimate_dot = recursive_ls(t, x, omega, lambda, y)
    % unpacking theta and P
    theta = x(1);
    P = x(2);

    % Ensuring P is symmetric
    P = (P + P') / 2;
    
    % Calculating error value
    err = omega' * theta - y;
    
    % Covariance update
    Pdot = lambda * P - P * (omega * omega') * P;

    % State update
    thetadot = -P * omega * err;

    % Exctacting values
    ls_estimate_dot = [thetadot; Pdot];
end