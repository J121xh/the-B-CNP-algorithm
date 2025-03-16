clc
clear

P= imread('temp11.png'); 
try
    P=rgb2gray(P);
    P=im2bw(P);
catch
    P=im2bw(P);
end
S=P;
%expansion the obstcle

P=expansion(S);
P=expansion(P);

P=expansion(P);

   
x=zeros(size(P,1),1);
sidy=cell(size(P,1),1);
eidy=cell(size(P,1),1);
idy=[];
for i=1:size(P,1)
    [x(i),sidy{i,1},eidy{i,1}]=rowFreeSpace(P(i,:));
end

[idx,no_of_cells]=FindCell(x,P);

dist=10;
path=findPath2(P,idx,no_of_cells,sidy,eidy,dist);

usv_count=4;
path_num=length(path);
usvs=USV.empty;
start_pos=[105,20;233,57;1,207;106,217];
for i=1:path_num
    mission(i)=Mission(path{i});
end
for j=1:usv_count
    usvs(j)=USV(start_pos(j,1),start_pos(j,2));
    m=seek(usvs(j),mission);
    usvs(j).mission=m;
    usvs(j).undertake=1;
    mission(m).undertake=1;
    usvs(j).sum_m=[usvs(j).sum_m;m];
end
epath=path;
while isempty(epath{usvs(1).mission})==0&&isempty(epath{usvs(2).mission})==0&&isempty(epath{usvs(3).mission})==0&&isempty(epath{usvs(4).mission})==0
    for j=1:usv_count
    [usvs(j),epath{usvs(j).mission}]=update(usvs(j),epath{usvs(j).mission});
    end
    for i=1:length(path)
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
usvs(U).undertake=1;
usvs(U).mission=next_m;
usvs(U).sum_m=[usvs(U).sum_m,next_m];
mission(next_m).undertake=1;

epath{m}=[1,1];

A=1:length(epath);
sum_mission=[];
while sum(ismember(sum_mission,A))~=length(A)
    [epath,usvs,mission]=loop(epath,usvs,mission);
    sum_mission=[];
    for p=1:usv_count
        sum_mission=[sum_mission,usvs(p).sum_m];
    end
end
imshow(S);
hold on;
for j=1:usv_count
    u_path{j}=[];
    for i=1:length(usvs(j).sum_m)
        u_path{j}=[u_path{j};path{usvs(j).sum_m(i)}];
    end
    plot(u_path{j}(:,1),u_path{j}(:,2))
end






