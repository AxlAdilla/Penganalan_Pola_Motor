%csvFile  = cell(1,301);
%csvFile{1,1}="nama";
%cell2csv('./data_csv/KnnLatih.csv',csvFile);

%csvFile = csv2cell('./data_csv/KnnLatih.csv');

%s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

%find number of random characters to choose from
%numRands = length(s); 

%specify length of random string to generate
%sLength = 32;

%generate random string
%randString = s( ceil(rand(1,sLength)*numRands) )
%figure(1);
%b=imread('./data_latih/normalisasi/BX8U0BbVyjugldxEF22Om0p60sDsRzwn370.jpg');
%imshow(b);
%isgray(b)
%b=im2bw(b);


%figure(2);
%c=imread('./data_latih/normalisasi/b9hSq43vXhOf7UerX88c0AkcHKyjHJ0v368.jpg');
%imshow(c);
%isgray(c)

%figure(3);
%a=imread('./data_latih/axgBfCYijmBakjZfdj2qdvsItnjzkil7367.jpg');
%if(isrgb(a))
%  disp("rgb");
%  imgCanny = rgb2gray(a);
%  imgCanny = edge(imgCanny,"canny");
%elseif (isgray(a))
%  disp("gray");
%  imgCanny = edge(a,"canny");     
%elseif (isbw(a))
%  disp("bw");
%  imgCanny = uint8(255 * a);
%  imgCanny = edge(imgCanny,"canny");
%endif
%imgCanny = imresize(imgCanny,[100 200]);
%imshow(imgCanny);

%aCell = num2cell(imgCanny);
%bCell = num2cell(b);
%cCell = num2cell(c);
%cell2csv('a.csv',aCell);
%cell2csv('b.csv',bCell);
%cell2csv('c.csv',cCell);

%knn_latihCsv  = csv2cell('./data_csv/KnnLatih.csv');
%knn_latihCsv{2,6}

%knnData = csv2cell('./data_csv/KnnDataClassify.csv');
%knnData{2,2}
%array = cell2mat(knnData(2,2:end));
%sorted=sort(array);

dataLatih = csv2cell('./data_csv/DataLatih.csv');
knnData = csv2cell('./data_csv/KnnDataClassify.csv');
[lenKnnLatihCsvX lenKnnLatihCsvY]=size(knnData);
[lenDataLatihCsvX lenDataLatihCsvY]=size(dataLatih);
array = cell2mat(knnData(2,2:end));
sorted=sort(array);
sorted(1,1:3)
    
for i=1:3
  tampil(i).filename = "";
  tampil(i).skor = 99999;
  tampil(i).label = "";
endfor

for i=1:3
  for j=2:lenKnnLatihCsvY  
    knnDataTest = knnData{2,j}
    sortedTest = sorted(1,i)
    if (knnData{2,j}==sorted(1,i))
      filename_test = knnData{1,j}
      skor_test = knnData{2,j}
      tampil(i).filename = knnData{1,j};
      tampil(i).skor = knnData{2,j};
      for k=2:lenDataLatihCsvX
        filename_test = knnData{1,j}
        filename_all_test = dataLatih{k,1}
        if(strcmp(knnData{1,j},dataLatih{k,1}))
          datalatihlabel_test = dataLatih{k,2}
          tampil(i).label =  dataLatih{k,2};
        endif
      endfor
    endif
  endfor
endfor