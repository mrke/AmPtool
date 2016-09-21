%% print_results_my_pet_html
% read and write results_my_pet.html

%%
function print_results_my_pet_html(data, prdData, auxData, metaData, txtData, metaPar)
% created 2015/04/11 by Starrlight & Goncalo Marques; modified 2015/08/23
% Starrlight; modified 2016/03/09 Bas Kooijman
% modified 2016/09/21 Starrlight

%% Syntax
% <../print_results_my_pet_html.m *print_results_my_pet_html*> (data, prdData, auxData, metaData, txtData, metaPar)

%% Description
% Prints an html file which compares metapar.model predictions with data
%
% Input:
%
% * data: structure
% * prdData: structure
% * auxData: structure
% * metaData: structure
% * txtData:  structure
% * metaPar: structure


%% Example of use
% [data, auxData, metaData, txtData] = feval(['mydata_',metaData.species]); 
%
% prdData = feval(['predict_',metaData.species], par, data, auxData);
%
% prdData = predict_pseudodata(par, data, prdData); 
%
% load(['results_',entries{i},'.mat']) % load results_my_pet.mat
%
% print_results_my_pet_html(data, prdData, auxData, metaData, txtData, metaPar)

n_author = length(metaData.author); % number of authors

switch n_author
    
    case 1
    txt_author = metaData.author{1};

    case 2
    txt_author = [metaData.author{1}, ', ', metaData.author{2}];

    otherwise    
    txt_author = [metaData.author{1}, ', et al.'];

end

txt_date = [num2str(metaData.date_acc(1)), '/', num2str(metaData.date_acc(2)), '/', num2str(metaData.date_acc(3))]; 

if isfield(metaData,'author_mod_1')
n_author_mod_1 = length(metaData.author_mod_1);

    switch n_author_mod_1
      case 1
      txt_author_mod_1 = metaData.author_mod_1{1};
      case 2
      txt_author_mod_1 = [metaData.author_mod_1{1}, ', ', metaData.author_mod_1{2}];
      otherwise    
      txt_author_mod_1 = [metaData.author_mod_1{1}, ', et al.'];
    end

txt_date_mod_1 = [num2str(metaData.date_mod_1(1)), '/', num2str(metaData.date_mod_1(2)), '/', num2str(metaData.date_mod_1(3))]; 

else
    
txt_author_mod_1 = '';
txt_date_mod_1 =  '';

end  

% remove the underscore in the species name

oid = fopen(['results_', metaData.species, '.html'], 'w+'); % open file for reading and writing, delete existing content
fprintf(oid, '%s\n' ,'<!DOCTYPE html>');
fprintf(oid, '%s\n' ,'<HTML>');
fprintf(oid, '%s\n' ,'  <HEAD>');
fprintf(oid,['    <TITLE>add-my-pet: results ', strrep(metaData.species, '_', ' '), '</TITLE>\n']);
fprintf(oid, '%s'   ,'    <META NAME = "keywords" ');
fprintf(oid, '%s\n' ,'     CONTENT="add-my-pet, Dynamic Energy Budget theory, DEBtool">');

% ------ calls the cascading style sheet (found in subfolder css):
fprintf(oid, '%s\n' ,'<link rel="stylesheet" type="text/css" href="../css/collectionstyle.css">'); 

fprintf(oid, '%s\n' , ' </HEAD>');
fprintf(oid, '%s\n\n','  <BODY>');
  
   
% Print results_my_pet
fprintf(oid, ['<H2>Model: <a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Typified_models" >&nbsp;', metaPar.model,' &nbsp;</a></H2>']);
fprintf(oid,'<p> \n');    
fprintf(oid,['<a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Completeness" >COMPLETE</a>',' = %3.1f <BR>\n'],metaData.COMPLETE);
fprintf(oid,['<a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Add-my-pet_Introduction#Goodness_of_fit_criterion" >MRE</a>',' = %8.3f \n'],metaPar.MRE);   
fprintf(oid,'</p> \n');     % close the paragraph

% % get predictions to compare with data: 
% [data, auxData, metaData, txtData] = feval(['mydata_',metaData.species]); 
% prdData = feval(['predict_',metaData.species], par, data, auxData);

% appends new field to prdData with predictions for the pseudo data:
% (the reason is that the predicted values for the pseudo data are not
%   returned by predict_my_pet and this has to do with compatibility with the
%   multimetadata.species parameter estimation):
% prdData = predict_pseudodata(par, data, prdData);

% make structure for 'real' and predicted pseudodata:
pseudo = data.psd;
prdPseudo = prdData.psd;
psTxtData.units = txtData.units.psd;
psTxtData.label = txtData.label.psd;

% remove pseudodata:
data        = rmfield_wtxt(data, 'psd');
prdData    = rmfield_wtxt(prdData, 'psd');
txtData    = rmfield_wtxt(txtData, 'psd');


%  make table for zero-variate data set:
fprintf(oid, '      <TABLE id="t01">\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TH colspan="7"><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Zero-variate_data" >Zero-variate</a> data</TH></TR>\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TD><b>Data</b></TD><TD><b>Observed</b></TD><TD><b>Predicted</b></TD><TD><b>(RE)</b></TD><TD><b>Unit</b></TD><TD><b>Description</b></TD><TD><b>Reference</b></TD></TR>\n');
[nm, nst] = fieldnmnst_st(data); % cell array of string with fieldnames of data

 for j = 1:nst
    [~, k] = size(data.(nm{j})); % number of data points per set
    if k == 1       
        name = nm{j};
        dta   = data.(nm{j}); 
         prdta = prdData.(nm{j});
        re    = metaPar.RE(j); 
        unit  = txtData.units.(nm{j});
        des   = txtData.label.(nm{j});
        n = iscell(txtData.bibkey.(nm{j}));  % if 1 then there are several references for this data
        if n % if there are several references
            n = length(txtData.bibkey.(nm{j})); % number of references
            REF = [];
            for i = 1:n
                ref = txtData.bibkey.(nm{j}){i};
                if i == 1
                    REF = [REF,' ',ref];
                else
                    REF = [REF,', ',ref];
                end
            end
        else
            REF = txtData.bibkey.(nm{j});      
        end
        fprintf(oid, '    <TR > <TD>%s</TD><TD>%3.4g</TD> <TD>%3.4g</TD> <TD>(%3.4g)</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD></TR>\n',...
        name, dta, prdta, re, unit, des, REF);
    end
 end
fprintf(oid, '    <TR><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TF></TR>\n');
fprintf(oid, '    </TABLE>\n');  

% ------------------------------------------------------------------------


% print table with uni-variate data :
if isempty(metaData.data_1) == 0
fprintf(oid, '      <TABLE id="t01">\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TH colspan="6"><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Univariate_data" >Uni-variate</a> data </TH></TR>\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TD><b>Dataset</b></TD><TD><b>Figure</b></TD><TD><b>(RE)</b></TD><TD><b>Independent variable</b></TD><TD><b>Dependent variable</b></TD><TD><b>Reference</b></TD></TR>\n');  
 
% select the positions of univariate data 
uniData = [];
  for j = 1:nst
      eval(['[aux, k] = size(data.', nm{j}, ');']) % number of data points per set 
      if k >1 
         uniData = [uniData;j]; 
      end
  end
n_uniData = length(uniData); 
% number of each figure in the absense of grouped plots
% in this case there is the same amount of figures as grouped plots
ID = (1:n_uniData)';   % fig number = index of uniData 
   
 if isfield(metaData,'grp')
     
   n_GrpPlots = length(metaData.grp.sets);  % number of grouped plots
                
   uniDataNames = cell(0);  % initiate cell array with names of all uni variate data sets:
   for i = 1:n_uniData
     uniDataNames{i} = nm{uniData(i)};
   end
   
   % fill selection-matrix to identify grp plot members
   % it assumes that all univariate datasets occur in exactly 1 figure
   % sequence of data-sets in grp plots doesn't need to match sequence in uniData 
   sel = zeros(n_uniData,n_GrpPlots);          % initiate selection grp plot members
   for j = 1:n_GrpPlots                        % scan grouped plots
     set_j =  metaData.grp.sets{j}';           % cell-string with names of datasets in grp j  
     for i = 1: length(set_j)                  % scan datasets in grp j
       sel(:,j) = sel(:,j) + strcmp(uniDataNames,set_j{i})'; % add tot grp plot members 
     end
   end
   sel_tot = sum(sel,2) == 1;                  % booleans with grp plot members in uniData in any grp plot
   sel = sel == 1;                             % booleans with grp plot members in uniData in grp 1,2,..
   
   j_grp = (1:n_GrpPlots)';                    % compose grp id's
   ID = zeros(n_uniData,1);                    % initiate fig id
   if sel_tot(1)                               % first unidata set is member of grp plots
     ID(sel(:,j_grp(sel(1,:)))) = 1;           % set all members of that grp
   else                                        % first unidataset not a member of any grp plot
     ID(1) = 1;                                % 
   end
   for i = 2:n_uniData                         % scan other uniData sets
     if sel_tot(i) && ID(i) == 0               % new member of grp data
       ID(sel(:,j_grp(sel(i,:)))) = ID(i - 1) + 1; % set all members of that grp
     elseif ID(i) == 0                        % not a member of any grp data
       ID(i) = ID(i - 1) + 1;                  % increase fig id counter
     end
   end
               
 end
 
% print out columns in the univariate data set table:
     for j = 1: n_uniData % for each univariate data set
        label  = nm{uniData(j)}; % "Data set"
        re     = metaPar.RE(uniData(j)); % "relative error"
        ivar   = txtData.label.(nm{uniData(j)}){1}; % independant variable
        dvar   = txtData.label.(nm{uniData(j)}){2}; % dependant variable

        if ID(j) < 10
        fig   = ['see <A href = "../entries/',metaData.species,'/results_',metaData.species,'_0',num2str(ID(j)),'.png"> Fig. ',num2str(ID(j)),'</A>'];
        else
        fig   = ['see <A href = "../entries/',metaData.species,'results_',metaData.species,'_',num2str(ID(j)),'.png"> Fig. ',num2str(ID(j)),'</A>'];
        end        
      n = iscell(txtData.bibkey.(nm{uniData(j)}));
      if n
      n = length(txtData.bibkey.(nm{uniData(j)}));
      REF = [];
        for i = 1:n
        ref = txtData.bibkey.(nm{uniData(j)}){i};
          if i == 1
          REF = [REF,' ',ref];
          else
          REF = [REF,', ',ref];
          end
        end
      else
      REF = txtData.bibkey.(nm{uniData(j)});    
      end
      fprintf(oid, '    <TR > <TD>%s</TD> <TD>%s</TD> <TD>(%3.4g)</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD></TR>\n',...
      label, fig, re, ivar, dvar, REF);        
    end
 fprintf(oid, '    <TR><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD></TR>\n');
 fprintf(oid, '    </TABLE>\n'); 
end
% ---------------------------------------------------------------------------- 

% Print table with pseudo-data:
[nm, nst] = fieldnmnst_st(pseudo);
fprintf(oid, '      <TABLE id="t01">\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TH colspan="5"> Pseudo-data </TH></TR>\n');
fprintf(oid, ['    <TR BGCOLOR = "#FFE7C6"><TD><B>Data</B></TD><TD><B>Generalised animal</B></TD><TD><B>',strrep(metaData.species, '_', ' '),'</B></TD><TD><B>Unit</B></TD><TD><B>Description</B></TD></TR>\n']);
  for j = 1:nst
       name = nm{j};
       dta   = pseudo.(nm{j});
       prdta = prdPseudo.(nm{j});
       unit  = psTxtData.units.(nm{j});
       des   = psTxtData.label.(nm{j});
       fprintf(oid, '<TR ><TD>%s</TD> <TD>%3.4g</TD> <TD>%3.4g</TD><TD>%s</TD><TD>%s</TD></TR>\n',...
       name, dta, prdta, unit, des);       
  end
 fprintf(oid, '    </TABLE>\n'); 
 
%  work in progress : (it is to make a link to html page with all of the
%  figure on it)
%  if isempty(metaData.data_1) == 0
%  print_unidata_my_pet_html(metaData, metaPar)
%  end
%  

% ----------------------------------------------------------
% Facts:
if isfield(metaData, 'facts') 
fprintf(oid, '<H3 style="clear:both" class="pet">Facts</H3>\n');
fprintf(oid,'<ul> \n');     % open the unordered list
[nm, nst] = fieldnmnst_st(metaData.facts);
  for i = 1:nst
  fprintf(oid, '<li>\n'); % open bullet point
  str1 = metaData.facts.(nm{i});
    if isfield(txtData.bibkey,nm{i})
    str2 = metaData.bibkey.(nm{i});
    fprintf(oid, [str1,' (',str2,') \n']);
    else
    fprintf(oid, [str1,'\n']);  
    end
  fprintf(oid, '</li>\n' ); % close bullet point
  end
fprintf(oid,'</ul> \n');     % open the unordered list    
end
% ----------------------------------------------------------

% ----------------------------------------------------------
% Discussion:
if isfield(metaData, 'discussion') == 1
fprintf(oid, '<H3 style="clear:both" class="pet">Discussion</H3>\n');
fprintf(oid,'<ul> \n');     % open the unordered list
[nm, nst] = fieldnmnst_st(metaData.discussion);
    for i = 1:nst
    fprintf(oid, '<li>\n'); % open bullet point
    str = metaData.discussion.(nm{i});
      if isfield(txtData.bibkey,nm{i})
      str2 = metaData.bibkey.(nm{i});
      fprintf(oid, [str,' (',str2,') \n']);
      else
      fprintf(oid, [str, '\n']);
      end
    fprintf(oid, '</li>\n' ); % close bullet point
    end
fprintf(oid,'</ul> \n');     % open the unordered list      
end
% ----------------------------------------------------------

% ----------------------------------------------------------
% Acknowledgment:
if isfield(metaData, 'acknowledgment') == 1
    fprintf(oid, '<H3 style="clear:both" class="pet">Acknowledgment</H3>\n');
    fprintf(oid,'<ul> \n');     % open the unordered list
    
        fprintf(oid, '<li>\n'); % open bullet point
        str = metaData.acknowledgment;
        fprintf(oid, [str, '\n']);
        fprintf(oid, '</li>\n' ); % close bullet point
   
    fprintf(oid,'</ul> \n');     % open the unordered list      
end
% ----------------------------------------------------------

% ----------------------------------------------------------
% Bibliography:
fprintf(oid, '<H3 style="clear:both" class="pet">Bibliography</H3>\n');
[nm, nst] = fieldnmnst_st(metaData.biblist);
    for i = 1:nst
    fprintf(oid, '<li>\n'); % open bullet point
    fprintf(oid, [nm{i}, '\n']);
    fprintf(oid, '</li>\n' ); % close bullet point
    end
fprintf(oid,'</ul> \n');     % open the unordered list   
fprintf(oid, '<p>\n');
fprintf(oid, ['<A class="link" href = "bib_',metaData.species,'.bib" target = "_blank">Bibtex files with references for this entry </A> <BR> \n']);
fprintf(oid, '</p>\n' );
% ----------------------------------------------------------
  
% ----------------------------------------------------------
% Authors and last data of modification
fprintf(oid, '<HR> \n');
fprintf(oid,['    <H3 ALIGN="CENTER">', txt_author, ', ', txt_date, ...
        ' (last modified by ', txt_author_mod_1, '\n', txt_date_mod_1,')','</H3>\n']);
% ----------------------------------------------------------
 
% close results_my_pet.html  
fprintf(oid, '  </BODY>\n');
fprintf(oid, '  </HTML>\n');
fclose(oid);
% ----------------------------------------------------------





