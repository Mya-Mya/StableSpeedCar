classdef Slopedata
    properties
        
        pattern = [...
            40 0
            50 -2
            55 0
            70 1
            90 0
            140 -1
            145 0
            155 -1
            160 0
            200 1
            250 0
            400 -1
            450 0 ...
            ]';
    end
    methods
        function obj = Slopedata()
        end
        function s = s(obj, z)
            for x = obj.pattern
                if x(1)>z
                    s = x(2);
                    return
                end
            end
            s = 0;
        end
        function sonz = sonz(obj,z)
            sonz = 0;
        end
    end
end