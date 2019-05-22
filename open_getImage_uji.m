function open_getImage_uji(object_handle,event,pathImgUji,do_showimage_uji_btn,namafile_uji_h)
  [fname, fpath, fltidx] = uigetfile({"*.gif;*.png;*.jpg", "Supported Picture Formats"});
  if isequal(fname,0)
   disp('User selected Cancel');
  else
    set(pathImgUji,'string',strcat(fpath,fname));
    set(namafile_uji_h,'string',fname);
    set(do_showimage_uji_btn,'visible','on');
  endif  
endfunction