function open_getImage_latih(object_handle,event,path_h,show_btn_h,label_input_label_h,input_label_h,namafile_h)
  [fname, fpath, fltidx] = uigetfile({"*.gif;*.png;*.jpg", "Supported Picture Formats"});
  if isequal(fname,0)
   disp('User selected Cancel');
  else
    set(path_h,'string',strcat(fpath,fname));
    set(namafile_h,'string',fname);
    set(show_btn_h,'visible','on');
    set(label_input_label_h,'visible','on');
    set(input_label_h,'visible','on');
  endif  
endfunction