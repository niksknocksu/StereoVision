clear all
imaqreset
clc
close all
nik1 = videoinput('winvideo',1,'I420_640X480');
nik2 = videoinput('winvideo',2,'I420_640X480');
%preview(nik1);
%preview(nik2);
dist = 237.1; %baseline
f = 252.256; %mm
snap1 = getsnapshot(nik1);
snap2 = getsnapshot(nik2);
snap1 = rgb2gray(snap1);
snap2 = rgb2gray(snap2);
%imshow(snap);
Rmin = 15;
Rmax = 40;
%sharpened = imsharpen(snap,'Radius',2,'Amount',7);
[center1, radius1] = imfindcircles(snap1,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',.925);
[center2, radius2] = imfindcircles(snap2,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',.925);
figure
subplot(1,2,1)
imshow(snap1);
viscircles(center1, radius1,'edgecolor','b');
subplot (1,2,2)
imshow(snap2);
viscircles(center2, radius2,'edgecolor','r');
dist_estim = (f* dist*3.77)/(center1(:,1) - center2(:,1));
rgb = insertText(snap1,center1,num2str(dist_estim));
figure
imshow(rgb);
disp(dist_estim);