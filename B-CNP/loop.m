function [epath,usvs,mission]=loop(epath,usvs,mission)
    while isempty(epath{usvs(1).mission})==0&&isempty(epath{usvs(2).mission})==0&&isempty(epath{usvs(3).mission})==0&&isempty(epath{usvs(4).mission})==0
        for j=1:length(usvs)
            [usvs(j),epath{usvs(j).mission}]=update(usvs(j),epath{usvs(j).mission});
        end
        for i=1:length(epath)
            mission(i).path=epath(i);
        end
    end

    [num,usvs,mission]=find_non(usvs,epath,mission);
    

    M={};
    r=[];
    for i=1:length(epath)
        if mission(i).finished==0&&mission(i).undertake==0
            M=[M,mission(i)];
            r=[r,i];
        end
    end


    next_m=r(seek(usvs(num),M));

    U=shot(mission(next_m),usvs);
    %U=num;
    usvs(U).mission=next_m;
    usvs(U).sum_m=[usvs(U).sum_m,next_m];
    mission(next_m).undertake=1;
    epath{usvs(U).sum_m(length(usvs(U).sum_m)-1)}=[1,1];
    
%     while usvs(1).undertake==0||usvs(2).undertake==0||usvs(3).undertake==0||usvs(4).undertake==0
%         for i=1:4
%             if usvs(i).undertake==0
%                 num=i;
%             end
%         end     
%         next_m=r(seek(usvs(num),M));
%         U=shot(mission(next_m),usvs);
%         usvs(U).undertake=1;
%         usvs(U).mission=next_m;
%         usvs(U).sum_m=[usvs(U).sum_m,next_m];
%         mission(next_m).undertake=1;
%         epath{usvs(U).sum_m(length(usvs(U).sum_m)-1)}=[1,1];
%     end
end

