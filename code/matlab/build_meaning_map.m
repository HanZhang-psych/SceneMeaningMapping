function meaning_map = build_meaning_map(rating_array,scene_image)

% BUILD_MEANING_MAP - Generates a meaning map based on the aggregated 
%                     Likert patch rating data from the fine and coarse 
%                     spatial scales.
%
% rating_array: Image height x Width x 2 (spatial scales) cell array.
% scene_image(optional): If scene image is included then it will be plotted
%                        side-by-side with the generated meaning map.
%
% For each spatial scale (i.e., fine and coarse) the corresponding rating 
% array contains the patch Likert ratings assigned to each pixel in the 
% scene image aggregated across all raters (3 unique raters per patch).
% Note due to the overlap between patches most pixels will contain more
% than 3 unique ratings. See meaning_map_example.mat for an instance of a
% rating_array and corresponding scene.
%
% See also imgaussfilt

% (c) Visual Cognition Laboratory at the University of California, Davis
%
% 2.0.0 2019-09-26 TRHayes: Streamlined for OSF release
% 1.0.0 2016-05-01 TRHayes: Wrote it

%% 010: Sanity-check input rating cell array

%--Check that both spatial scale patch ratings are present
assert(size(rating_array,3)==2,...
       'Error: rating_array should be an HxWx2 cell array') ;

%--If scene_image is included, check that it is the same size as array
if (nargin>1)
    assert(size(scene_image,1)==size(rating_array,1)) ;
    assert(size(scene_image,2)==size(rating_array,2)) ;
end

%-- Check that all values match set of possible Likert ratings
likert_set = [1 2 3 4 5 6] ;
for k=1:size(rating_array,3)
    curr_array = rating_array(:,:,k) ;
    member_check = cellfun(@(x) sum(ismember(x,likert_set))==length(x),...
                           curr_array) ;
    assert(sum(member_check(:))==size(member_check,1)*size(member_check,2),...
           'Error: rating_array contains values outside Likert set') ;
end

%% 020: Generate meaning map from aggregated patch ratings

%--First average ratings at each pixel within each spatial scale
spatial_average_map = zeros(size(rating_array)) ;
for k=1:size(rating_array,3)
    spatial_average_map(:,:,k) = cellfun(@mean,rating_array(:,:,k)) ;
end

%--Second average 2 spatial scale maps together so each is equally weighted
average_meaning_map = mean(spatial_average_map,3) ;

%--Third smooth the map a little to reduce patch size artifacts.
meaning_map= imgaussfilt(average_meaning_map,10) ; 

if (nargin>1)
   imshowpair(scene_image,meaning_map,'montage') ;
end

%--- Return image meaning map
%%%%% END OF FUNCTION BUILD_MEANING_MAP.M