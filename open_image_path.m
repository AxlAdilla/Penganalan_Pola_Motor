function open_image_path(object_handle,event,pathImgLatih)
  getPath = pathImgLatih;
  img = imread(getPath);
  figure('menubar','none','toolbar','none');
  imshow(img);
endfunction