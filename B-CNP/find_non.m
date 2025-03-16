function [num,usvs,mission]=find_non(usvs,epath,mission)
    for k=1:length(epath)
        if isempty(epath{k})==1
            finished_m=k;
        end
    end
    for h=1:length(usvs)
        if usvs(h).mission==finished_m
            num=h;
        end
    end
    usvs(num).mission=0;
    usvs(num).undertake=0;
    mission(finished_m).finished=1;
    mission(finished_m).undertake=0;
end

