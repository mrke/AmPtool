%% prt_my_pet_eco
% writes html table with model, COMPLETE, MRE, SMRE  and eco-codes

%%
function prt_my_pet_eco(species, model, COMPLETE, MRE, SMSE, destinationFolder)
% created 2018/05/05 by Bas Kooijman

%% Syntax
% <prt_my_pet_eco *prt_my_pet_eco*>(species, model, MRE, SMSE, COMPLETE, destinationFolder, filenm)

%% Description
% Writes html table with model, MRE, SMRE, COMPLETE and eco-codes. 
%
% Input:
%
% * species: character string with species name
% * model: character string with model name
% * MRE: scalar with Mean Relative Error
% * SMSE: scalar with Symmetric Mean Squared Error
% * COMPLETE: scalar with COMPLETE level
% * destinationFolder: specification of destination folder 

%% Remarks
% Intended use is writing a snippet for my_pet_res.html. Make sure that eco-labels are updated using get_eco_types.
% This latter function reads codes and labels in url AmPeco.html.
% This function is also called by update_eco.

global eco_types

if length(eco_types) == 0 
  get_eco_types;
end

oid = fopen([destinationFolder, species, '_res.html'], 'a'); % open file for appending

[climate, ecozone, habitat, embryo, migrate, food] = get_eco(species);

% write eco-labels in hover-text of eco-codes in html
% climate
n_C = length(climate); code_C = '';
for i = 1:n_C
  code_C = [code_C, '<a href="" title="', eco_types.climate.(climate{i}), '">', climate{i}, '</a>, '];
end
code_C(end - (0:1)) = [];
% ecozone
n_E = length(ecozone); code_E = '';
for i = 1:n_E
  code_E = [code_E, '<a href="" title="', eco_types.ecozone.(ecozone{i}), '">', ecozone{i}, '</a>, '];
end
code_E(end - (0:1)) = []; 
% habitat
n_H = length(habitat); code_H = '';
for i = 1:n_H
  code = habitat{i}; label = [eco_types.habitat.(code(3:end)), ' for stage ', code(1:2)];
  code_H = [code_H, '<a href="" title="', label, '">', code, '</a>, '];
end
code_H(end - (0:1)) = [];
% embryo environment
n_B = length(embryo); code_B = '';
for i = 1:n_B
  code_B = [code_B, '<a href="" title="', eco_types.embryo.(embryo{i}), '">', embryo{i}, '</a>, '];
end
code_B(end - (0:1)) = []; 
% migrate/torpor
n_M = length(migrate); code_M = '';
for i = 1:n_M
  code_M = [code_M, '<a href="" title="', eco_types.migrate.(migrate{i}), '">', migrate{i}, '</a>, '];
end
if n_M > 0
  code_M(end - (0:1)) = [];
end
% food
n_F = length(food); code_F = '';
for i = 1:n_F
  code = food{i}; label = [eco_types.food.(code(3:end)), ' for stage ', code(1:2)];
  code_F = [code_F, '<a href="" title="', label, '">', code, '</a>, '];
end
code_F(end - (0:1)) = []; 

% write table in html
fprintf(oid, '      <table>\n');    
fprintf(oid, '        <tr>\n');    
fprintf(oid,['          <td width=250><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Typified_models">Model: </a>', model,'</td>\n']);    
fprintf(oid, '          <td></td><td width=250></td>\n');    
fprintf(oid, '          <td></td><td width=250></td>\n');    
fprintf(oid, '        </tr>\n');    
fprintf(oid, '        <tr>\n');    
fprintf(oid,['          <td><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Completeness" >COMPLETE</a>',' = %3.1f </td>\n'], COMPLETE);
fprintf(oid,['          <td><a href="../../AmPeco.html#C" target="_blank">climate: </a></td> <td>', code_C, '</td>\n']);
fprintf(oid,['          <td><a href="../../AmPeco.html#B" target="_blank">embryo:  </a></td> <td>', code_B, '</td>\n']);
fprintf(oid, '        </tr>\n');    
fprintf(oid, '        <tr>\n');    
fprintf(oid,['          <td><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Mean_relative_error" >MRE</a>',' = %8.3f </td>\n'], MRE);   
fprintf(oid,['          <td><a href="../../AmPeco.html#E" target="_blank">ecozone: </a></td> <td>', code_E, '</td>\n']);
fprintf(oid,['          <td><a href="../../AmPeco.html#M" target="_blank">migrate: </a></td> <td>', code_M, '</td>\n']);
fprintf(oid, '        </tr>\n');    
fprintf(oid, '        <tr>\n');    
fprintf(oid,['          <td><a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Symmetric_mean_squared_error" >SMSE</a>',' = %8.3f </td>\n'], SMSE);   
fprintf(oid,['          <td><a href="../../AmPeco.html#H" target="_blank">habitat: </a></td> <td>', code_H, '</td>\n']);
fprintf(oid,['          <td><a href="../../AmPeco.html#F" target="_blank">food: </a></td> <td>', code_F, '</td>\n']);
fprintf(oid, '        </tr>\n');    
fprintf(oid, '      </table>\n\n');     

fclose(oid);
