classdef Mission
    
    properties
        position1;
        position2;
        undertake=0;
        finished=0;
        label;
        path;
    end
    
    methods
        function obj=Mission(path)
            len=length(path);
            if len>1
            obj.position1=[path(1,1),path(1,2)];
            obj.position2=[path(len,1),path(len,2)];
            obj.path=path;
            end
        end
        
        function choosed=choose(usv,obj_num)
            if usv.mission==obj_num
                choosed=1;
            end
        end
        
        function obj=updata(obj)
            if obj.path==empty
                obj.finished=1;
            else
                obj.path([1:10],:)=[];
            end
        end
            
    end
    
end

