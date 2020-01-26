% This code generate meaning map for each picture

pics_dir = '..\..\scene_images\';
ratings_dir = '..\..\data\rating_matrices\';
output_dir = '..\..\data\meaning_maps\';


pics_pattern = fullfile(pics_dir, '*.jpg');
pics_info = dir(pics_pattern);

ratings_pattern = fullfile(ratings_dir, '*.mat');
ratings_info = dir(ratings_pattern);


for k = 1 : length(ratings_info)
  filename = ratings_info(k).name; % file name with extension
  [folder, baseFileName, extension] = fileparts(filename); % extract the image name without extension
  sprintf(baseFileName)
  filepath = strcat(ratings_info(k).folder, '\', filename); % full path
  thisdata = load(filepath); 
  rating_array = thisdata.rating_matrix;
  scene_image = imread(strcat(pics_dir,baseFileName,'.jpg'));
  mmap = build_meaning_map(rating_array,scene_image);
  csvwrite(strcat(output_dir,baseFileName,'.csv'),mmap);
end