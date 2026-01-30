function thetadot = estimate_dynamics(t, theta, omega, d, theta_star, g)
 % True signal : u = m_star * w(t) + d(t)
 u = theta_star * omega + d; 
 err = theta * omega - u;
 thetadot = -g * err * omega;
end