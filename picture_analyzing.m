%%  ai Project - lip detecting
%% programmer : /\/ /\ S t /\ R /\ /\/  |-| /\ |< i m i 90521121
%%  this is testing for opening image
%{
dirData = dir('*.jpg');         %# Get the selected file data
fileNames = {dirData.name};     %# Create a cell array of file names
for iFile = 1:numel(fileNames)  %# Loop over the file names
  newName = sprintf('image%d.jpg',iFile);  %# Make the new name
  movefile(fileNames{iFile},newName);        %# Rename the file
end
%}
for k=1:43   

face=imread(sprintf('Image %d.jpg',k));
%imwrite(face,sprintf('Image %d.jpg',k));

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
 imshow(sub_face);
 imwrite(sub_face,'1.jpg');
%% constract

sub_face=im2bw(sub_face,0.5);
sub_face=uint8(sub_face)*255;
 imshow(sub_face);
   imwrite(sub_face,'2.jpg');
  %% complement the image
  complement=~(sub_face);
  imshow(complement);
  complement=uint8(complement)*255;
 % face=complement;
   imwrite(complement,'3.jpg');
  %% clear edges
  
  
  face_clear=imextendedmax(complement,80);
     imwrite(face,'4.jpg');
  %imshow(face_clear);
  
  face=imimposemin(sub_face,face_clear);
  %imshow(face);
 
  imwrite(face,'5.jpg');
  
  %% morphology step 5 and step 6

  face=bwmorph(face,'fill');
  
    imwrite(face,'6.jpg');
 % imshow(face);
  
 %{
 SE=ones(15,20);
  edit=imerode(face,SE);
  close=imdilate(edit,SE);
  imshow(close);
  %}
 face=bwareaopen(face,5050);
   imwrite(face,'8.jpg');
% imshow(face);
 x=face;
  j=fspecial('motion',10);
  
  h=fspecial('disk',4);
  
  x=imfilter(x,h,'replicate');
   x=imfilter(x,j,'replicate');
     imwrite(x,'9.jpg');
 % imshow(x);
  
  
  
  face=x;
  
  face=imcomplement(face);
    imwrite(face,'10.jpg');
%  imshow(face);
  
  face=imfill(face,'holes');
    imwrite(face,'11.jpg');
  %imshow(face);
  
  %%traversing on image
 % for i=0 
  
 face=imcomplement(face);
   imwrite(face,'12.jpg');
 
 
 %%body of croping in this section we want to crop lip from the face
 
imwrite(face,sprintf('1result%d.jpg',k));
end
  
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



