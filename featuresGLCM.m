%{
Extracting Gray level co-occurnaces matrix statistical descriptors (GLCM) Features.
This script output is a matrix for GLCM features of all the images. Features are
'contrast','homogeneity','Correlation','Energy'
%}

MyFiles = 'C:\Users\Fares\Desktop\datasetscan\data';
if ~isdir(MyFiles)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', MyFiles);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(MyFiles, '*.jpg');
Myimages = dir(filePattern);

%mydataPCA = [];
mydataGLCM = [];
for k = 1:length(Myimages)
  %process the CXR image  
  baseFileName = Myimages(k).name;
  fullFileName = fullfile(MyFiles, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  CXR_Image = imread(fullFileName);
  CXR_Image = imresize(CXR_Image, [100 100]);
  CXR_Image = rgb2gray(CXR_Image);
  CXR_Image = im2double(CXR_Image);
  GLCM_values = graycomatrix(CXR_Image)
  GLCM_stats = graycoprops(GLCM_values,{'contrast','homogeneity','Correlation','Energy'});
  ImageArray = struct2array(GLCM_stats);
  mydataGLCM = [mydataGLCM, ImageArray(:)];
%   ImageArray = pca(CXR_Image);
%   mydataPCA = [mydataPCA, ImageArray(:)];
end
%save('imagematrixPCA.mat','mydataPCA');
save('imagematrixGLCM.mat','mydataGLCM');