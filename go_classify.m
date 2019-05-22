function go_classify(object_handle,event,pathImgUji,namafile_uji_h)
  namafile = get(namafile_uji_h,'string');
  path_img = get(pathImgUji,'string');
  dataRawDir='./data_latih/';

  if(length(path_img)==0)
    msgbox("Jangan Kosongkan  Citra Uji","Isi Citra Uji","warn");
  else
    ujiImg = imread(path_img);
    if (isrgb(ujiImg))
      imgCanny = rgb2gray(ujiImg);
      imgCanny = edge(imgCanny,"canny");
    elseif (isgray(ujiImg))
      imgCanny = edge(ujiImg,"canny");     
    elseif (isbw(ujiImg))
      imgCanny = uint8(255 * ujiImg);
      imgCanny = edge(imgCanny,"canny");
    endif
    imgCanny = imresize(imgCanny,[100 200]);
    
    integralProjectionUji = cell(1,301);
    integralProjectionUji{1,1} = namafile;
    countHorizontal=zeros(1,200);
    countVertical=zeros(1,100);
    for j = 1:200
      for i = 1:100
        if(imgCanny(i,j)==1)
          countHorizontal(j) = countHorizontal(j)+1;
        endif
      endfor
      integralProjectionUji{2,j+1} = countHorizontal(j);
    endfor
    
    for j = 1:100
      for i = 1:200
        if(imgCanny(j,i)==1)
          countVertical(j) = countVertical(j)+1;
        endif
      endfor
      integralProjectionUji{2,200+1+j} = countVertical(j);
    endfor
    
    data_latihCsv  = csv2cell('./data_csv/DataLatih.csv');
    [lenLatihCsvX lenLatihCsvY] = size(data_latihCsv);
    knn_latihCsv  = csv2cell('./data_csv/KnnLatih.csv');
    [lenKnnLatihCsvX lenKnnLatihCsvY] = size(knn_latihCsv);
    
    knnLenY = lenLatihCsvX;
    knnData = cell(2,knnLenY);
    knnData{1,1}='nama';
    knnData{2,1}=namafile;
    for i=2:knnLenY
      knnData{1,i}=data_latihCsv{i,1};
    endfor
        
    for x=2:lenKnnLatihCsvX
      error = 0;
      for i=2:lenKnnLatihCsvY
        error = error + (knn_latihCsv{x,i}-integralProjectionUji{2,i}).^2;
      endfor
      knnData{2,x} = sqrt(error);
    endfor
    
    cell2csv('./data_csv/KnnDataClassify.csv',knnData);
    dataLatih = csv2cell('./data_csv/DataLatih.csv');
    knnData = csv2cell('./data_csv/KnnDataClassify.csv');
    [lenKnnLatihCsvX lenKnnLatihCsvY]=size(knnData);
    [lenDataLatihCsvX lenDataLatihCsvY]=size(dataLatih);
    array = cell2mat(knnData(2,2:end));
    sorted=sort(array);
    
        
    for i=1:3
      tampil(i).filename = "";
      tampil(i).skor = 99999;
      tampil(i).label = "";
    endfor

    for i=1:3
      for j=2:lenKnnLatihCsvY  
        if (knnData{2,j}==sorted(1,i))
          tampil(i).filename = knnData{1,j};
          tampil(i).skor = knnData{2,j};
          for k=2:lenDataLatihCsvX
            if(strcmp(knnData{1,j},dataLatih{k,1}))
              tampil(i).label =  dataLatih{k,2};
            endif
          endfor
        endif
      endfor
    endfor
    
    if(strcmp(tampil(1).label,tampil(2).label))
      kelompokMotor = tampil(1).label;
    elseif(strcmp(tampil(1).label,tampil(3).label))
      kelompokMotor = tampil(1).label;
    elseif(strcmp(tampil(3).label,tampil(2).label))
      kelompokMotor = tampil(3).label;
    else
      kelompokMotor = tampil(1).label;
    endif
    
    msgbox("Proses Klasifikasi sudah selesai","Sukses");
    
    klasifikasi_out_f = figure("4","name","Hasil Output","toolbar","none",...
                                "menubar","none");
                                
    hasil_h = uicontrol("style","text",'units','normalized',"string",...
          "Aplikasi Klasifikasi Motor dengan KNN",'units','normalized',...
          "position", [0.05 0.85 0.9 0.1],...
          "backgroundcolor",[1,1,1],...
          "fontsize",18);
    
    namafile_hasil_h = uicontrol ("style","text",'units','normalized',"string",...
                namafile,'units','normalized',...
                "position", [0.1 0.725 0.7 0.1],...
                "backgroundcolor",[1,1,1],...
                "horizontalalignment","left","fontsize",10);
                
    do_showimage_hasil_btn = uicontrol ("style",'pushbutton',"string",...
                "Lihat Gambar",'units','normalized',...
                "visible","on","fontsize",8,...
                "position", [0.5 0.75 0.15 0.05],"callback",{@open_image_latih,pathImgUji});
    uicontrol("style","text",'units','normalized',"string",...
          "Gambar Masukan Serupa dengan gambar berikut",'units','normalized',...
          "position", [0.05 0.62 0.9 0.07],...
          "backgroundcolor",[1,1,1],...
          "fontsize",12);            
    for i=1:3
      uicontrol ("style","text",'units','normalized',"string",...
                tampil(i).filename,'units','normalized',...
                "position", [0.1+(i-1)/4  0.5 0.7 0.1],...
                "backgroundcolor",[1,1,1],...
                "horizontalalignment","left","fontsize",10);
      uicontrol ("style",'pushbutton',"string",...
                "Lihat Gambar",'units','normalized',...
                "visible","on","fontsize",8,...
                "position", [0.1+(i-1)/4 0.475 0.15 0.05],"callback",{@open_image_path,strcat(dataRawDir,tampil(i).filename)});
      uicontrol ("style","text",'units','normalized',"string",...
                tampil(i).label,'units','normalized',...
                "position", [0.1+(i-1)/4  0.425 0.7 0.05],...
                "backgroundcolor",[1,1,1],...
                "horizontalalignment","left","fontsize",10);
    endfor
    uicontrol("style","text",'units','normalized',"string",...
          strcat("Gambar Masukan termasuk Kelompok \n",kelompokMotor),'units','normalized',...
          "position", [0.05 0.25 0.9 0.1],...
          "backgroundcolor",[1,1,1],...
          "fontsize",14); 
    
  endif  
endfunction