function [metrix]=expansion(metrix)
[m,n]=size(metrix);
G=[];
for i=2:m-1
    for j=2:n-1
        if metrix(i+1,j)+metrix(i-1,j)+metrix(i,j+1)+metrix(i,j-1)>0&&metrix(i,j)==0
            G(i,j)=2;
        end
    end
end
for i=2:m-1
    if metrix(i,1)==0&&metrix(i-1,1)+metrix(i+1,1)>0
        G(i,1)=2;
    end
    if metrix(i,n)==0&&metrix(i-1,n)+metrix(i+1,n)>0
        G(i,n)=2;
    end
end
for j=2:n-1
    if metrix(1,j)==0&&metrix(1,j-1)+metrix(1,j+1)>0
        G(1,j)=2;
    end
    if metrix(m,j)==0&&metrix(m,j-1)+metrix(m,j+1)>0
        G(m,j)=2;
    end
end

[ROW,COL]=find(G~=0);
t=size(ROW);
for i=1:t
    if ROW(i)==1||COL(i)==1
        metrix(ROW(i)+1,COL(i))=0;
        metrix(ROW(i),COL(i)+1)=0;
        metrix(ROW(i)+1,COL(i)+1)=0;
    elseif ROW(i)==m||COL(i)==n
        metrix(ROW(i)-1,COL(i))=0;
        metrix(ROW(i),COL(i)-1)=0;
        metrix(ROW(i)-1,COL(i)-1)=0;
    else
    metrix(ROW(i)+1,COL(i))=0;
    metrix(ROW(i)-1,COL(i))=0;
    metrix(ROW(i),COL(i)-1)=0;
    metrix(ROW(i),COL(i)+1)=0;
    metrix(ROW(i)-1,COL(i)-1)=0;
    metrix(ROW(i)+1,COL(i)+1)=0;
    metrix(ROW(i)+1,COL(i)-1)=0;
    metrix(ROW(i)-1,COL(i)+1)=0;
    end
    
end
end