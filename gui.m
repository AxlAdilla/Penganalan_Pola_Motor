
%Window Utama
main_f = figure("1","name","Aplikasi Klasifikasi Motor","toolbar","none",...
           "menubar","none");

%Text Oleh blablabla
uicontrol("style","text",'units','normalized',"string",...
          "Oleh : Axl Adilla & Bayu Dwi Yulianto",'units','normalized',...
          "position", [0.5 0.0 0.5 0.1],...
          "backgroundcolor",[1,1,1]);
%text Judul
uicontrol("style","text",'units','normalized',"string",...
          "Aplikasi Klasifikasi Motor dengan KNN",'units','normalized',...
          "position", [0.05 0.85 0.9 0.1],...
          "backgroundcolor",[1,1,1],...
          "fontsize",18);
          
%Btn untuk menjalankan fungsi pelatihan data latih dilakukan jika menambah
%data latih baru
do_pelatihan_btn = uicontrol ("style",'pushbutton',"string",...
                 "Mulai Pelatihan",'units','normalized',...
                "position", [0.2 0.55 0.6 0.2],"callback",@disp_pelatihan);

%Btn untuk menjalankan fungsi pelatihan data latih dilakukan jika menambah
%data latih baru
do_klasifikasi_btn = uicontrol ("style",'pushbutton',"string",...
                 "Mulai Klasifikasi",'units','normalized',...
                "position", [0.2 0.25 0.6 0.2],"callback",@disp_klasifikasi);                