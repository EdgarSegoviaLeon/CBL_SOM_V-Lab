clear all; clc;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
b1=readmatrix('b1.csv');
b2=readmatrix('b2.csv');
b3=readmatrix('b3.csv');
b4=readmatrix('b4.csv');
b5=readmatrix('b5.csv');
b6=readmatrix('b6.csv');
b7=readmatrix('b7.csv');
b8=readmatrix('b8.csv');
b9=readmatrix('b9.csv');
b10=readmatrix('b10.csv');
b11=readmatrix('b11.csv');
b12=readmatrix('b12.csv');
b13=readmatrix('b13.csv');
b14=readmatrix('b14.csv');
b15=readmatrix('b15.csv');
b16=readmatrix('b16.csv');
b17=readmatrix('b17.csv');
b18=readmatrix('b18.csv');
b19=readmatrix('b19.csv');
b20=readmatrix('b20.csv');
b21=readmatrix('b21.csv');
b22=readmatrix('b22.csv');
b23=readmatrix('b23.csv');
b24=readmatrix('b24.csv');
b=horzcat(b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24);
%------------------------------------------------------------------------

for j=1:24
for i=1:8760-840
y1(i,j)=b(i,j);
y2(i,j)=b(i+(24*7),j);
y3(i,j)=b(i+(24*7*2),j);
y4(i,j)=b(i+(24*7*3),j);
y4(i,j)=b(i+(24*7*4),j);
y5(i,j)=b(i+(24*7*5),j);
end
end
for i=1:840
b(i,:)=[];
end
load =b;
%--------------------------------------------------------------------------
for j=1:24
for i=1:8760-840
yy(1)=y1(i,j);
yy(2)=y1(i,j);
yy(3)=y1(i,j);
yy(4)=y1(i,j);
yy(5)=y1(i,j);
ym(i,j)=min(yy);
yM(i,j)=max(yy);
end
end
%--------------------------------------------------------------------------
for j=1:24
for i=1:8760-840
bb1(i,j)=(y1(i,j)+y2(i,j)+y3(i,j)+y4(i,j)+y5(i,j)-ym(i,j))/4;
end
end
%--------------------------------------------------------------------------
for j=1:24
for i=1:8760-840
bb2(i,j)=(y1(i,j)+y2(i,j)+y3(i,j)+y4(i,j)+y5(i,j)-ym(i,j)-yM(i,j))/3;
end
end
%--------------------------------------------------------------------------

for j=1:24
    s=0;
for i=1:8760-840
e1(i,j)=100*abs((load(i,j)-bb1(i,j))/load(i,j));
s=s+e1(i,j);
end
s=s/(8760-840);
if s<100 mape1(j)=s;

end
if s>100 mape1(j)=0;

end
end
%--------------------------------------------------------------------------

for j=1:24
    s=0;
for i=1:8760-840
e1(i,j)=100*abs((load(i,j)-bb2(i,j))/load(i,j));
s=s+e1(i,j);
end
s=s/(8760-840);
if s<100 mape2(j)=s;
end
if s>100 mape2(j)=0;
end
end
%--------------------------------------------------------------------------

for j=1:24
    s=0;
    l=0;
for i=1:8760-840
e1(i,j)=((load(i,j)-bb1(i,j))^2);
l=l+load(i,j);
s=s+e1(i,j);
end
bm=l/(8760-840);
s=sqrt(s/(8760-840))*100/bm;
if s<100 cvrmse1(j)=s;
end
if s>100 cvrmse1(j)=0;
end
end
%--------------------------------------------------------------------------

for j=1:24
    s=0;
    l=0;
for i=1:8760-840
e1(i,j)=((load(i,j)-bb2(i,j))^2);
l=l+load(i,j);
s=s+e1(i,j);
end
bm=l/(8760-840);
s=sqrt(s/(8760-840))*100/bm;
if s<100 cvrmse2(j)=s;
end
if s>100 cvrmse2(j)=0;
end
end
%--------------------------------------------------------------------------
mape1=mape1.';
mape2=mape2.';
cvrmse1=cvrmse1.';
cvrmse2=cvrmse2.';

error= horzcat(mape1,mape2,cvrmse1,cvrmse2);
error=error.';

%-------------------------------------------------------------------------
net=selforgmap([1 2]);
net=configure(net,error );
plotsompos(net,error);
net=train(net,error);
