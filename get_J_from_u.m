function J = get_J_from_u(u_s,slopedata,delta_t,x0,vref)
    
    x_s = car_steps(x0,u_s,delta_t,slopedata);
    v_s = x_s(:,2)';
    L_s = 0.5*((v_s-vref).^2 + u_s.^2);
    J = sum(L_s);
    
%     N = length(u_s);
%     J = 0;
%     x = x0;
%     for k =2:N
%         z = x(1);
%         v = x(2);
%         u = u_s(k);
%         s = slopedata.s(z);
% 
%         loss = 0.5*((v-vref)^2 + u^2);
%         J = J + loss;
% 
%         dotx = [v u-s];
%         x = x + dotx * delta_t;
%     end
end