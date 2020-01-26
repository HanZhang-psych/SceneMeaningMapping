function  pathstr = MMap_pathstr

% MMap_PATHSTR -- Path string to the root of the meaning map directory.
%
% pathstr = MMap_pathstr
%
% See also CD, FILEPARTS, FULLFILE, PWD, WORK_PATHSTR.
%
% (c) Visual Cognition Laboratory at the University of California, Davis
%
% 1.0.0 2016-10-14 TRHayes: Wrote it

pathstr = fileparts(which('MMap_pathstr')) ; 
idx = find(pathstr==filesep) ;              
if (filesep~=':')
	cutoff = idx(end) ;
else  % FILEPARTS on Mac OS 9.2 puts one extra trailing ':'
	cutoff = idx(end-1) ;
end
pathstr(cutoff:end) = [] ; 

%--- Return PATHSTR
%%%%% End of file MMap_pathstr.M

