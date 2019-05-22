function refresh_latih(object_handle,event)
  dirProcessedFolder = "./data_latih/normalisasi/";
  dirRawFolder = "./data_latih/";
  csvLatih = csv2cell('./data_csv/DataLatih.csv');
  [lenLatihCsvX lenLatihCsvY] = size(csvLatih);
  
  for i = 2:lenLatihCsvX
    filename = csvLatih{i,1};
    latihImg = imread(strcat(dirRawFolder,filename));
    if(isrgb(latihImg))
      imgCanny = rgb2gray(latihImg);
      imgCanny = edge(imgCanny,"canny");
    elseif (isgray(latihImg))
      imgCanny = edge(latihImg,"canny");     
    elseif (isbw(latihImg))
      imgCanny = uint8(255 * latihImg);
      imgCanny = edge(imgCanny,"canny");
    endif
    imgCanny = imresize(imgCanny,[100 200]);
    imwrite(imgCanny,strcat(dirProcessedFolder,filename));
  endfor
  
  knnLatihCsv  = csv2cell('./data_csv/KnnLatih.csv');
  for x = 2:lenLatihCsvX
    filename = csvLatih{x,1};
    knnLatihCsv{x,1}=filename;
    img = im2bw(imread(strcat(dirProcessedFolder,filename)));
    countHorizontal=zeros(1,200);
    countVertical=zeros(1,100);
    for j = 1:200
      for i = 1:100
        if(img(i,j)==1)
          countHorizontal(j) = countHorizontal(j)+1;
        endif
      endfor
      knnLatihCsv{x,j+1} = countHorizontal(j);
    endfor
    
    for j = 1:100
      for i = 1:200
        if(img(j,i)==1)
          countVertical(j) = countVertical(j)+1;
        endif
      endfor
      knnLatihCsv{x,200+1+j} = countVertical(j);
    endfor
    
  endfor
  cell2csv('./data_csv/KnnLatih.csv',knnLatihCsv);
  msgbox("Sukses Refresh Data Latih","Sukses");
  
endfunction