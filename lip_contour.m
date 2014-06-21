for z=0:43
lip=imread(sprintf('result%d.jpg',z));
lip=im2bw(lip,150/250);
%lip=uint8(lip)*255;
imshow(lip);


[x,y]=size(lip);

x=int64(x); %because size return double value
y=int64(y);


% detecting most left point of contour


k=1; % indeces for array that save all mostright point (their x is same otherwise their y )
can2=0;
most_right=[];

for j=y :-1:1
    for i=1 : x
        if lip(i,j) ==0
            right_x=i;
            right_y=j;
            right=[right_x,right_y];
            can2=1;
           most_right=[most_right;right];
            k=k+1;
        end
    end
    if  can2==1
        break;
    end
end
   
[x,y]=size(most_right);
x=int64(x);

averageofmostright=[most_right(int64(x/2),1),most_right(int64(x/2),2)];
uppermostright=[most_right(1,1),most_right(1,2)];
bottommostright=[most_right(x,1),most_right(x,2)];

 

    
 [x,y]=size(lip);

x=int64(x); %because size return double value
y=int64(y);
  


k=1; % indeces for array that save all most left point (their x is same otherwise their y )
can1=0;
can2=0;
most_left=[];

for j=1 : y
    for i=1 : x
        if lip(i,j) ==0
            left_x=i;
            left_y=j;
            left=[left_x,left_y];
            can2=1;
           most_left=[most_left;left];
            k=k+1;
        end
    end
    if  can2==1
        break;
    end
end
   
[x,y]=size(most_left);
x=int64(x);

averageofmostleft=[most_left(int64(x/2),1),most_left(int64(x/2),2)];
uppermostleft=[most_left(1,1),most_left(1,2)];
bottommostleft=[most_left(x,1),most_left(x,2)];



%% use  line equation with two point of leftmost and right most
parameter=8;  %  eqauls 0.2 centimeter

%% find a left and Top point of lip

point_x=averageofmostleft(1,2)+parameter;

point_y=function_line_equation(point_x,averageofmostright,averageofmostleft);

%%___________________________________________________________________________

nearest_point=nearest([point_x,point_y],lip);


j=nearest_point(1,1);
i=nearest_point(1,2);
i=int64(i);
j=int64(j);

    
while( 1)
    if lip(i,j)==0 && lip(i-1,j)==1
        start=[i,j];
        break;
    end
    if(lip(i,j)==1)
        i=i+1;
    else
        i=i-1;
    end
end
%main_start=start;


j=nearest_point(1,1);
i=nearest_point(1,2);
i=int64(i);
j=int64(j);
while( 1)
    if lip(i,j)==0 && lip(i+1,j)==1
        main_start=[i,j];
        break;
    end
    
    i=i+1;
end

%%____________________________________________________________________________
%try to go up and up to reach most up and left 

parametr2=2;% pixel means 0.05 
up=1;
up_point_x=0;
up_point_y=0;

while(up == 1)
save=[up_point_y,up_point_x];
up_point_x=start(1,2)+parametr2;
up_point_y=start(1,1);


height=size(lip);
height=height(1,1);
j=up_point_x;
i= up_point_y;
i=int64(i);
k=int64(i);
j=int64(j);
up=-1;

while( 1)
    if(i-1==0)
        up=0;
        break;
    end
    if(k+1==height)
        up=1;
    end
    
    if lip(i,j)==0 && lip(i-1,j)==1
        start=[i,j];
        up=1;
        break;
    end
    if lip(k,j)==0 && lip(k+1,j)==1
        start=[k,j];
        up=0;
        break;
    end
           i=i-1;
            k=k+1;
   
end
end

topleft=save;
%%___________________________________________________________

%calculatin  bottomleft

parametr2=2;% pixel means 0.05 
bottom=1;
bottom_point_x=0;
bottom_point_y=0;

while(bottom == 1)
save=[bottom_point_y,bottom_point_x];
bottom_point_x=main_start(1,2)+parametr2;
bottom_point_y=main_start(1,1);


height=size(lip);
height=height(1,1);
j=bottom_point_x;
i= bottom_point_y;
i=int64(i);
k=int64(i);
j=int64(j);
bottom=-1;

while( 1)
    if(i+1==height)
        bottom=0;
        break;
    end
    if(k-1==0)
        bottom=1;
    end
    
    if lip(i,j)==0 && lip(i+1,j)==1
        main_start=[i,j];
        bottom=1;
        break;
    end
    if lip(k,j)==0 && lip(k-1,j)==1
        main_start=[k,j];
        bottom=0;
        break;
    end
           i=i+1;
            k=k-1;
   
end
end


bottomleft=save;




%%________________________________find two points in____

%% use  line equation with two point of leftmost and right most
parameter=-8;  %  eqauls 0.2 centimeter

%% find a right and Top point of lip

point_x=averageofmostright(1,2)+parameter;

point_y=function_line_equation(point_x,averageofmostright,averageofmostleft);

%%___________________________________________________________________________

nearest_point=nearest([point_x,point_y],lip);


j=nearest_point(1,1);
i=nearest_point(1,2);
i=int64(i);
j=int64(j);
while( 1)
    if lip(i,j)==0 && lip(i-1,j)==1
        start=[i,j];
        break;
    end
    i=i-1;
end
%main_start=start;



j=nearest_point(1,1);
i=nearest_point(1,2);
i=int64(i);
j=int64(j);
while( 1)
    if lip(i,j)==0 && lip(i+1,j)==1
        main_start=[i,j];
        break;
    end
    i=i+1;
end

%%____________________________________________________________________________
%try to go up and up to reach most up and right 

parametr2=-2;% pixel means 0.05 
up=1;
up_point_x=0;
up_point_y=0;

while(up == 1)
save=[up_point_y,up_point_x];
up_point_x=start(1,2)+parametr2;
up_point_y=start(1,1);


height=size(lip);
height=height(1,1);
j=up_point_x;
i= up_point_y;
i=int64(i);
k=int64(i);
j=int64(j);
up=-1;

while( 1)
    if(i-1==0)
        up=0;
        break;
    end
    if(k+1==height)
        up=1;
    end
    
    if lip(i,j)==0 && lip(i-1,j)==1
        start=[i,j];
        up=1;
        break;
    end
    if lip(k,j)==0 && lip(k+1,j)==1
        start=[k,j];
        up=0;
        break;
    end
           i=i-1;
            k=k+1;
   
end
end

topright=save;
%%___________________________________________________________

%calculatin  bottomright

parametr2=-2;% pixel means 0.05 
bottom=1;
bottom_point_x=0;
bottom_point_y=0;

while(bottom == 1)
save=[bottom_point_y,bottom_point_x];
bottom_point_x=main_start(1,2)+parametr2;
bottom_point_y=main_start(1,1);


height=size(lip);
height=height(1,1);
j=bottom_point_x;
i= bottom_point_y;
i=int64(i);
k=int64(i);
j=int64(j);
bottom=-1;

while( 1)
    if(i+1==height)
        bottom=0;
        break;
    end
    if(k-1==0)
        bottom=1;
    end
    
    if lip(i,j)==0 && lip(i+1,j)==1
        main_start=[i,j];
        bottom=1;
        break;
    end
    if lip(k,j)==0 && lip(k-1,j)==1
        main_start=[k,j];
        bottom=0;
        break;
    end
           i=i+1;
            k=k-1;
   
end
end


bottomright=save;


result=[];
result=[result;averageofmostleft];
result=[result;averageofmostright];
result=[result;topleft];
result=[result;topright];
result=[result;bottomleft];
result=[result;bottomright];

lip=uint8(lip)*255;
for i=1:6

   lip= insertShape(lip, 'FilledCircle', [double(result(i,2)) double( result(i,1)) 6    ],'Color','blue');


end


imwrite(lip,sprintf('result%d.jpg',z));

end








