classdef Slopedata2<Slopedata
    properties
        
        pattern = [...
            40 0
            50 -2
            70 0
            80 1
            130 0
            135 -1
            145 0
            155 -1
            180 0
            200 1
            250 0
            300 -1
            320 0 ...
            ]';
    end
    methods
        function obj = Slopedata2()
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