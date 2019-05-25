function tepi = deteksiCitra(grayImg)
  im = im2double (grayImg);

  k = [1/256 4/256 6/256 4/256 1/256
     4/256 16/256 24/256 16/256 4/256
     6/256 24/256 36/256 24/256 6/256
     4/256 16/256 24/256 16/256 4/256
     1/256 4/256 6/256 4/256 1/256];

  img = convn(im,k,'valid');


  Gx=[-1 0 1;-1 0 1;-1 0 1];
  Gy=[-1 -1 -1;0 0 0;1 1 1];

  Ix=convn(img,Gx,'valid');
  Iy=convn(img,Gy,'valid');
  Iedge = sqrt(Ix.^2 + Iy.^2);
  edgeImg = uint8(255*Iedge);
  bw = im2bw(edgeImg);

  tepi = bw;
endfunction