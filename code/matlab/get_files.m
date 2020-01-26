function fileNames = get_files(source,names)

% GET_FILES - Utility function to get all file names in source directory.
%
% See also import_patch_data

% (c) Visual Cognition Laboratory at the University of California, Davis
% http://jhenderson.org/vclab/Lab.html
%
% 1.0.0 2017-07-11 TRHayes: Wrote it

if (nargin<2)
    names = 0 ;
end
if names==0
    slist = dir(source) ;
    slist = slist(arrayfun(@(x) x.name(1), slist) ~= '.');
    isfile = ~[slist.isdir] ;
    fileNames = {slist(isfile).name} ;
else
    slist = dir(source) ;
    slist = slist(arrayfun(@(x) x.name(1), slist) ~= '.');
    isfile = ~[slist.isdir] ;
    fileNames = {slist(isfile).name} ;
    for k=1:length(fileNames)
        [~,fileNames{k}] = fileparts(fileNames{k}) ;
    end
end