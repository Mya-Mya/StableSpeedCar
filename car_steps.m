function x_s = car_steps(x0,u_s,delta_t,slopedata)
    N = length(u_s);
    x_s = zeros([N 2]);
    x = x0;
    for k=1:N
        u = u_s(k);
        x = car_step(x,u,delta_t,slopedata);
        x_s(k,:) = x;
    end
end