%% prt_menuBar_species
% prints the menu bar which is used for the pages which are specific for a
% given species

%%
function  prt_menuBar_species(oid, species, fileName)
% created 2016/11/02 by Starrlight 

%% Syntax
% <../prt_menuBar_species.m *prt_menuBar_species*> (oid, species, fileName)

%% Description
% Prints the menu bar to a given html file
%
% Input:
%
% * oid: string, id of file that the function writes to
% * species: string, name of the species (Genera_species)
% * fileName: string, name of html file we are writing to

%% Remarks
% Indent of 4 spaces used for menuBar_species.html

%% Example of use
% prt_menuBar_species(oid, metaData.species)

fprintf(oid, '    <div class = "dropdown"><button onclick="species()" class="dropbtn"><b>Results</b></button>\n');
fprintf(oid, '      <div id="speciesDropdown" class="dropdown-content">\n');

if strcmp(fileName,[species,'.html'])
  fprintf(oid,['        <a class= "menu"  href="',species,'.html">Parameters</a>\n']);
else
  fprintf(oid,['        <a  href="',species,'.html">Parameters</a>\n']);
end

if strcmp(fileName,[species,'_stat.html'])
  fprintf(oid,['        <a class= "menu" href="',species,'_stat.html">Implied properties</a>\n']);
else
  fprintf(oid,['        <a href="',species,'_stat.html">Implied properties</a>\n']);    
end

if strcmp(fileName,['results_',species,'.html'])
  fprintf(oid,['        <a class= "menu" href="results_',species,'.html">Predictions & Data</a>\n']);
else
  fprintf(oid,['        <a href="results_',species,'.html">Predictions & Data</a>\n']);
end

fprintf(oid, '      </div>\n');
fprintf(oid, '    </div>\n\n');

fprintf(oid, '    <div class = "dropdown"><button onclick="code()" class="dropbtn">Code</button>\n');
fprintf(oid, '      <div id="codeDropdown" class="dropdown-content">\n');
fprintf(oid,['        <a href="../entries/',species,'/mydata_',species,'.m" target="_blank">mydata</a>\n']);
fprintf(oid,['        <a href="../entries/',species,'/pars_init_',species,'.m" target="_blank">pars_init</a>\n']);
fprintf(oid,['        <a href="../entries/',species,'/predict_',species,'.m" target="_blank">predict</a>\n']);
fprintf(oid,['        <a HREF="../entries_zip/',species,'_zip.zip" TARGET="_top" onMouseOver="window.status=Close submenu; return true;">\n']);
fprintf(oid, '          <IMG SRC="../img/folder.png" WIDTH="110px"  BORDER="0" ></a>\n');
fprintf(oid, '      </div>\n');
fprintf(oid, '    </div>\n\n');

end
