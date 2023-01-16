classdef Adam
    properties
        m = [];
        v = [];
        beta1 = 0.7;
        beta2 = 0.9;
        eta = 0.1;

    end
    
    methods
        function obj = Adam(ndim)
            obj.m = zeros([1 ndim]);
            obj.v = zeros([1 ndim]);
        end
        function [obj,param] = update(obj, param, grad)
            obj.m = obj.beta1*obj.m+(1-obj.beta1)*grad;
            obj.v = obj.beta2*obj.v+(1-obj.beta2)*(grad.^2);
            mbar = obj.m./(1-obj.beta1);
            vbar = obj.v./(1-obj.beta2);
            param = param - mbar.*obj.eta./(sqrt(vbar)+1e-5);
        end
    end
end

