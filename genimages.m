%
% this script generates a sequenced of horizontal and vertical
% graycode images of size (1024 x 768) and writes them out to
% the subdirectory "gray"
%

% first build a table of the gray code sequence for each of
% integers 0..1023
X = dec2gray(0:1023,10);

% write out the horizontal code
for i = 1:10
  % the image
  I = repmat(X(:,i),1,768);
  % and its inverse
  I2 = 1-I;
  imwrite(I',sprintf('gray/%2.2d.jpg',i),'jpg','Quality',99);
  imwrite(I2',sprintf('gray/%2.2d_i.jpg',i),'jpg','Quality',99);
end

%now write out the vertical code
X = dec2gray(0:767,10);
for i = 1:10
  I = repmat(X(:,i),1,1024);
  I2 = 1-I;
  imwrite(I,sprintf('gray/%2.2d.jpg',i+10),'jpg','Quality',99);
  imwrite(I2,sprintf('gray/%2.2d_i.jpg',i+10),'jpg','Quality',99);
end

