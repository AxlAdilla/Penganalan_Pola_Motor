function ekstrak_fitur_latih(object_handle,event,pathImgLatih,namafile_h,input_label_h)
  dirProcessedFolder = "./data_latih/normalisasi/";
  dirRawFolder = "./data_latih/";
  namafile_h = get(namafile_h,'string');
  path_img = get(pathImgLatih,'string');
  input_label = get(input_label_h,'string');
  
  if(length(input_label) == 0)
    msgbox("Jangan Kosongkan Label Dari Data Latih","Isi Label Data","warn");
  else
    latihImg = imread(path_img);
    s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    %find number of random characters to choose from
    numRands = length(s); 

    %specify length of random string to generate
    sLength = 32;

    %generate random string
    randString = s( ceil(rand(1,sLength)*numRands) );
    
    data_latihCsv  = csv2cell('./data_csv/DataLatih.csv');
    [lenLatihCsvX lenLatihCsvY]=size(data_latihCsv);
    new_namafile_h = strcat(randString,num2str(lenLatihCsvX+1),namafile_h(end-3:end));
    imwrite(latihImg,strcat(dirRawFolder,new_namafile_h));
    
    
    data_latihCsv{lenLatihCsvX+1,1}=new_namafile_h;
    data_latihCsv{lenLatihCsvX+1,2}=input_label;
    cell2csv('./data_csv/DataLatih.csv',data_latihCsv);
    
    
    if (isrgb(latihImg))
      imgCanny = rgb2gray(latihImg);
      #imgCanny = edge(imgCanny,"canny");
      imgCanny = deteksiCitra(imgCanny);
    elseif (isgray(latihImg))
      #imgCanny = edge(latihImg,"canny");     
      imgCanny = deteksiCitra(imgCanny);
    elseif (isbw(latihImg))
      imgCanny = uint8(255 * latihImg);
      #imgCanny = edge(imgCanny,"canny");
      imgCanny = deteksiCitra(imgCanny);
    endif
    imgCanny = imresize(imgCanny,[100 200]);
    imwrite(imgCanny,strcat(dirProcessedFolder,new_namafile_h));
    
    knnLatihCsv  = csv2cell('./data_csv/KnnLatih.csv');
    [lenKnnCsvX lenKnnCsvY] = size(knnLatihCsv);
    knnLatihCsv{lenKnnCsvX+1,1}=new_namafile_h;
    
    %integralProjectionCsv = cell(length(dataCsv)+1,(newSize*2)+2);
    countHorizontal=zeros(1,200);
    countVertical=zeros(1,100);
    for j = 1:200
      for i = 1:100
        if(imgCanny(i,j)==1)
          countHorizontal(j) = countHorizontal(j)+1;
        endif
      endfor
      knnLatihCsv{lenKnnCsvX+1,j+1} = countHorizontal(j);
    endfor
    
    for j = 1:100
      for i = 1:200
        if(imgCanny(j,i)==1)
          countVertical(j) = countVertical(j)+1;
        endif
      endfor
      knnLatihCsv{lenKnnCsvX+1,200+1+j} = countVertical(j);
    endfor

    cell2csv('./data_csv/KnnLatih.csv',knnLatihCsv);
    
    figure("menubar","none","toolbar","none");
    imshow(imgCanny);
    uicontrol("style","text","backgroundcolor",[1,1,1],"units",'normalized','string','Ekstraksi Selesai','position',...
    [0.3 0.1 0.5 0.1]);
    
   endif
endfunction 