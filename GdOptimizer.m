classdef GdOptimizer

    properties
        slopedata;
        x0;
        delta_t;
        max_k;
        vref;

        k_s;
        u_s;
        x_s;
        lambda_s;
        Honu_s;
        Honu_integral;

        penalty_for_u;

        adam;
    end
    
    methods
        function obj = GdOptimizer(x0,delta_t,max_k,vref,slopedata)
            obj.x0 = x0;
            obj.delta_t = delta_t;
            obj.max_k = max_k;
            obj.k_s = 1:max_k;
            obj.vref = vref;
            obj.slopedata = slopedata;

            obj.penalty_for_u = 1e3;

            obj.adam = Adam(max_k);

            obj = obj.step1;
            obj = obj.step2;
        end

        function obj = step1(obj)
            % 適当な u を決める
            obj.u_s = zeros([1, obj.max_k]);
            
        end

        function obj = step2(obj)
            % dotx = f(x) より、 x を k=1:max_k について解く
            obj.x_s = car_steps(obj.x0,obj.u_s,obj.delta_t,obj.slopedata);
        end

        function obj = step3(obj)
            % lambda(k_final) = phi_on_x (x(k_final))
            % dotlambda = - H_on_x より、
            % lambda を k=max_k:1 について解く

            obj.lambda_s = zeros([obj.max_k 2]);

            v_final = obj.x_s(obj.max_k,2);
            lambda_final = [0 v_final-obj.vref];
            
            obj.lambda_s(obj.max_k,:) =lambda_final;

            for k = obj.max_k-1:-1:1
                lambda = obj.lambda_s(k+1,:);
                v = obj.x_s(k,2);
                dotlambda = - [0 v-obj.vref+lambda(1)];
                prevlambda = lambda - obj.delta_t*dotlambda;
                obj.lambda_s(k,:) = prevlambda;
            end
        end

        function obj = step4(obj)
            % H_on_u を求める
            obj.Honu_s = ...
                obj.lambda_s(:,2)'+ ...
                2*obj.penalty_for_u*obj.u_s.*(obj.u_s.^2>0.04);
            obj.Honu_integral = sum(obj.Honu_s.^2);
        end

        function obj = step5(obj)
            % u -= alpha * H_on_u
            [obj.adam, obj.u_s] = obj.adam.update(obj.u_s,obj.Honu_s);
        end

        function obj = epoch(obj)
            obj = obj.step3;
            obj = obj.step4;
            obj = obj.step5;
            obj = obj.step2;
        end

        function obj = epochs(obj,num_epochs)
            for i=1:num_epochs
                obj = obj.epoch;
            end
        end

    end
end

