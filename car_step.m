function nextx = car_step(x,u,delta_t,slopedata)
    z = x(1);
    v = x(2);
    s = slopedata.s(z);

    dotx = [v u+s];
    nextx = x + dotx*delta_t;
end