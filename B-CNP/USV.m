classdef USV

    properties
        position;
        velocity;
        label;
        undertake=0;
        mission;
        sum_m=[];
    end
    
    methods
        
        function obj = USV(position_x,  position_y)
            obj.position = [0 0];
            obj.velocity = 10;
            obj.position = [position_x, position_y];
        end
        
        function dis=distance(obj1,obj2)
            dis=sqrt((obj1.position(1)-obj2.position(1))^2+(obj1.position(2)-obj2.position(2))^2);
        end
        
        function dis=distance2(obj,M)
            dis1=sqrt((obj.position(1)-M.position1(1))^2+(obj.position(2)-M.position1(2))^2);
            dis2=sqrt((obj.position(1)-M.position2(1))^2+(obj.position(2)-M.position2(2))^2);
            dis=min(dis1,dis2);
        end
        
        function mission=seek(obj,M)
            for i=1:length(M)
                dis(i)=distance2(obj,M(i));
            end
            mission=find(dis==min(dis));
        end
        
        function U=shot(M,obj)
            for j=1:4
                if obj(j).undertake==0
                    dis(j)=distance2(obj(j),M);
                else
                    path_length=length(epath{obj(j).mission});
                    dis(j)=distance2(obj(j),M)+path_length;%£¿£¿£¿£¿£¿
                end
            end
            U=find(dis==min(dis));
        end
        
        function path_length=pl(obj,path)
            pos_in_path=find(obj.position(1)==path{1,1}(:,1)&&obj.position(2)==path{1,1}(:,2));
            path_length=length(path)-pos_in_path;
        end
        
        function [obj,path]=update(obj,path)
            if length(path)>10||length(path)==10
                obj.position=[path(10,1),path(10,2)];
                path([1:obj.velocity],:)=[];
            else
                obj.position=[path(size(path,1),1),path(size(path,1),2)];
                path=[];
            end
        end
        
    end
    
end

