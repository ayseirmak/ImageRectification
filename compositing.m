clc
clear


I1 = imread("I1.jpg");
I2 = imread("I2.jpg");
[row,colum,rgb]=size(I2);
[row4,colum4,rgb4]=size(I1);
converted=I1;

imshow(converted);
[xc_list,yc_list]=ginput(4);
display(xc_list);
display(yc_list);
BL=imresize(I2,[row4,colum4]);
[rowb,columb,rgb4]=size(BL);

xo_list=[1;size(BL,2);1;size(BL,2)];
yo_list=[1;1;size(BL,1);size(BL,1)];

xo1=xo_list(1,1);
xo2=xo_list(2,1);
xo3=xo_list(3,1);
xo4=xo_list(4,1);

yo1=yo_list(1,1);
yo2=yo_list(2,1);
yo3=yo_list(3,1);
yo4=yo_list(4,1);

xc1=xc_list(1,1);
xc2=xc_list(2,1);
xc3=xc_list(3,1);
xc4=xc_list(4,1);

yc1=yc_list(1,1);
yc2=yc_list(2,1);
yc3=yc_list(3,1);
yc4=yc_list(4,1);

M=[
    xo1,yo1,1,0,0,0,-xo1*xc1,-yo1*xc1;
    0,0,0,xo1,yo1,1,-xo1*yc1,-yo1*yc1;
    xo2,yo2,1,0,0,0,-xo2*xc2,-yo2*xc2;
    0,0,0,xo2,yo2,1,-xo2*yc2,-yo2*yc2;
    xo3,yo3,1,0,0,0,-xo3*xc3,-yo3*xc3;
    0,0,0,xo3,yo3,1,-xo3*yc3,-yo3*yc3;
    xo4,yo4,1,0,0,0,-xo4*xc4,-yo4*xc4;
    0,0,0,xo4,yo4,1,-xo4*yc4,-yo4*yc4;
];
b=[xc1;
   yc1;
   xc2;
   yc2;
   xc3;
   yc3;
   xc4;
   yc4;];
if(det(M)==0)
    [U,S,V] = svd(M);
     h = V(:, end);
else
    h=M\b;
end
h(9,1)=1;
h2=[h(1,1) h(2,1) h(3,1);
    h(4,1) h(5,1) h(6,1);
    h(7,1) h(8,1),1];

for rgb = 1:3
    for r=1:rowb
        for c=1:columb
            cn=(h2(1,1)*c+h2(1,2)*r+h2(1,3))/(h2(3,1)*c+h2(3,2)*r+h2(3,3));
            rn=(h2(2,1)*c+h2(2,2)*r+h2(2,3))/(h2(3,1)*c+h2(3,2)*r+h2(3,3));
            rn=round(rn);
            cn=round(cn);
            if(rn==0)
                rn=1;
            end
            if(cn==0)
                cn=1;
            end
            converted(rn,cn,rgb)=BL(r,c,rgb);
        end
    end
end
imshow(converted);
