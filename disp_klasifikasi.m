function disp_klasifikasi(object_handle,event)
  %Menambah figure baru
  klasifikasi_f = figure("3","name","Mulai Klasifikasi Motor","toolbar","none",...
                                "menubar","none");
  pathImgUji = uicontrol ("style","text",'units','normalized',"string",...
                "Buka Image Latih",'units','normalized',...
                "position", [0.1 0.8 0.7 0.1],...
                "backgroundcolor",[1,1,1],...
                "horizontalalignment","left","fontsize",10);
                
  namafile_uji_h = uicontrol ("visible","off","style","text",'units','normalized',"string",...
                "",'units','normalized',...
                "position", [0.1 0.8 0.7 0.1],...
                "backgroundcolor",[1,1,1],...
                "horizontalalignment","left","fontsize",10);
                
  %agar bisa ditampilkan
  do_showimage_uji_btn = uicontrol ("style",'pushbutton',"string",...
                "Lihat Gambar",'units','normalized',...
                "visible","off","fontsize",8,...
                "position", [0.8 0.825 0.15 0.05],"callback",{@open_image_latih,pathImgUji});
                
                
  %Btn untuk load image
  do_getimage_latih_btn = uicontrol ("style",'pushbutton',"string",...
                "Buka File Image",'units','normalized',...
                "position", [0.1 0.9 0.2 0.06],"callback",{@open_getImage_uji,...
                pathImgUji,do_showimage_uji_btn,namafile_uji_h});
                
  do_klasifikasi_latih_btn = uicontrol ("style",'pushbutton',"string",...
                "Klasifikasi","fontsize",18,'units','normalized',...
                "position", [0.25 0.25 0.5 0.3],"callback",{@go_classify,...
                pathImgUji,namafile_uji_h});
endfunction