function open_image_latih(object_handle,event,pathImgLatih)
  getPath = get(pathImgLatih,'string');
  img = imread(getPath);
  figure('menubar','none','toolbar','none');
  imshow(img);
endfunction