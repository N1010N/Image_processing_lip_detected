%%  ai Project - lip detecting
%% programmer : /\/ /\ S t /\ R /\ /\/  |-| /\ |< i m i 90521121
%%  this is testing for opening image


face=imread('2.jpg');
iptsetpref ImshowBorder tight
imshow(face)


%%
%{
%%top hat filtering
top_hat=imtophat(face,strel('disk',15));
figure,imshow(top_hat);


%% bottom hot filtering

bottom_hot=imbothat(face,strel('disk',15));
figure,imshow(bottom_hot);


%}
%% subtract these two images

  sub_face=imsubtract(imadd(face,imtophat(face,strel('disk',15))),imbothat(face,strel('disk',15)));
  figure,imshow(sub_face);
%% constract

sub_face=im2bw(sub_face,150/250);
sub_face=uint8(sub_face)*255;
figure,imshow(sub_face);
  
  %% complement the image
  complement=~(sub_face);
  figure,imshow(complement);
  complement=uint8(complement)*255;
 % face=complement;
  
  %% clear edges
  
  
  face_clear=imextendedmax(complement,80);
  figure,imshow(face_clear);
  
  face=imimposemin(sub_face,face_clear);
  figure,imshow(face);
 
  
  
  %% morphology step 5 and step 6

  face=bwmorph(face,'fill');
  
  figure,imshow(face);
  
  SE=ones(15,20);
  edit=imerode(face,SE);
  close=imdilate(edit,SE);
  figure,imshow(close);
  
  x=bwareaopen(close,5050);
  j=fspecial('motion',10);
  
  h=fspecial('disk',4);
  
  x=imfilter(x,h,'replicate');
   x=imfilter(x,j,'replicate');
  figure,imshow(x);
  
  
  %%traversing on image
 % for i=0 
  
  
%%
%{
 props = regionprops( logical( face, 4 ), 'Area', 'PixelIdxList' );
 smallRegions = [props(:).Area] < minNumPixels; % select the small regions
 face( [props( smallRegions ).PixelIdxList ] ) = 0; % reset small regions
  figure, imshow(face);
  %}
  
  
 %% figure,imshow(face);


 %%
 %{
 cropped=imcrop(face,[117  ,166,159,100]);
    imshow(cropped)
 thresh=150;
 lanes=im2bw(face,thresh/255);
 imshow(lanes)
 
 test=fspecial('motion',20,45);
 lanes=imfilter(lanes,test,'replicate');
 imshow(lanes)

 lanes=bwareaopen(lanes,100);
 imshow(lanes)
 
medfilt2(lanes,[100,100])
figure,imshow(lanes)
    display(lanes);
    %}

%%%%starting traverse on a face%%%%%%



