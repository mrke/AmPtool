%% run_collection
% generates files for AmP website 

%%
function run_collection(speciesList)
% created 2016/11/13 Bas Kooijman and Starrlight Augustine

%% Syntax
% <../run_collection.m *run_collection*> (entries)

%% Description
% * creates html pages for all of the different species in add_my_pet/entries
% * place the html and bib pages in entries_web and delete from entries
% * create zipped folder in entries_zip
%
% Input:
%
% * entries: optional cell array with species names to run
% * if no input the it run for the whole colelction

%% Remarks
% if you only have one species make sure that you input it as a cell array
% e.g. {'Danio_rerio'}

%% Example of use
% run_collection
% run prt_about to create ../about.html
% run prt_species_list_html to create ../species_list.html
% run prt_species_tree_taxa to create ../sys/species_tree_taxa.js files

entries = select('Animalia');

if exist('speciesList','var')
    n = zeros(1,length(speciesList));
    for i = 1:length(speciesList);
    n(i) =  find(strcmp(entries,speciesList) ==1);
    end
else
    n = 1:length(entries);
end
    
WD = pwd; % store current path
% 

destinationFolder = '../entries_web/';

for i = n  
  fprintf('%g/ %g : %s \n',i,n(i), entries{i}) % report progress to screen 
  cd(['../entries/',entries{i}]) % goto entry i 
  delete('*.cache', '*.wn') % delete html and bib files  
  load(['results_',entries{i},'.mat']) % load results_my_pet.mat
  [data, auxData, metaData, txtData] = feval(['mydata_',metaData.species]); 
  prdData = feval(['predict_',metaData.species], par, data, auxData);
  prdData = predict_pseudodata(par, data, prdData); % appends new field to prdData with predictions for the pseudo data:
  cd(WD)
  prt_my_pet_bib(metaData.species,metaData.biblist, destinationFolder) % print bib file
  prt_my_pet_par(metaData, metaPar, par, txtPar, destinationFolder) % make html with parameters
  prt_my_pet_stat(metaData, metaPar, par, destinationFolder) % make html with implied properties
  prt_my_pet_res(data, prdData, auxData, metaData, txtData, metaPar, destinationFolder) % make html with results
  cd('../entries_zip' ); % goto directory with all of the zipped entries
  zip_my_pet(entries{i}, '../entries'); % zip the entry
  cd(WD)  % goto original path    
end
    
% cd(WD)