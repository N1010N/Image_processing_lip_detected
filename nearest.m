%% this script for detecting a position of point assign to line --> in or out  of lip area ---> return nearest point to the my point in lip area

function  point2=nearest(point1,lip)
            parameter=2; % this parametr must test and training
           i=point1(1,1);
            j=point1(1,2);
            height=size(lip);
            height=height(1,1);
            k=j;
            if lip(j,i)==1
                while(lip(j,i)==1 && lip(k,i)==1)
      
                          j=j-parameter;
                         k=k+parameter;
                     if(j==0 || k==height+1)
                        display('we cant find');
                        break;
                    end
                end
                
                  if lip(j,i)==0
                      point2=[i,j];
                 elseif lip(k,i)==0
                    point2=[i,k];
                 else
                       point2=[-1,-1]; 
                 end
            
        else
                point2=point1;
            
       end
            
                
end
            

