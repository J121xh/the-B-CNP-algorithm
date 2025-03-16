function U=shot(M,obj)
for m=1:4
    if obj(m).undertake==0
        dis(m)=distance2(obj(m),M);
    else
        path=M.path;
        path_length=length(path);
        dis(m)=distance2(obj(m),M)+path_length;
    end
end
U=find(dis==min(dis));
end

