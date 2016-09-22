%% print_stat_my_pet_html
% Creates my_pet_stat.html 

%%
function print_stat_my_pet_html(metaData, metaPar, par)
% created 2016/03/30 by Starrlight

%% Syntax
% <../print_stat_my_pet_html.m *print_stat_my_pet_html*> (metaData, metaPar, par) 

%% Description
% Read and writes my_pet_stat.html. This pages contains a list of implied model
% properties of my_pet.
%
% Input:
%
% * metaData: structure
% * metaPar: structure
% * par: structure

%% Example of use
% load('results_my_pet.mat');
% print_stat_my_pet_html(metaData, metaPar, par)

f = 1; % ad libitum feeding
[stat, txtStat] = statistics_st(metaPar.model, par, metaData.T_typical, f); 
flds = fieldnmnst_st(stat); % fieldnames of all statistics
[webStatFields, webColStat] = get_statfields(metaPar.model); % which statistics in what order should be printed in the table

oid = fopen([metaData.species,'_stat', '.html'], 'w+'); % % open file for writing, delete existing content


fprintf(oid,['<!DOCTYPE html>']);
fprintf(oid,['<HTML>']);
fprintf(oid,['<HEAD>']);
fprintf(oid,['<TITLE>',metaData.species,'</TITLE>']);
fprintf(oid,['<link rel="stylesheet" type="text/css" href="../sys/style.css">']); 
fprintf(oid,['<script src="../sys/dropdown.js"></script>']);
fprintf(oid,['</HEAD>']);
fprintf(oid,['<BODY>']);
fprintf(oid,['<!--------------------------------------------------------------->']);
fprintf(oid,['<!--   PART 1                                                  -->']);
fprintf(oid,['<!--   TOP PART OF WEBPAGE IS FIXED                            -->']);
fprintf(oid,['<!--   It has the logo and the menu with Javascript            -->']);
fprintf(oid,['<!--  dropdown menus                                           -->']);
fprintf(oid,['<!--  Please put in bold and in fancy the right links          -->']);
fprintf(oid,['<!--------------------------------------------------------------->']);
fprintf(oid,['	<div id="top"> ']);
fprintf(oid,['		<div class="logo">		']);
fprintf(oid,['		   <a href="http://www.bio.vu.nl/thb/deb/deblab/"><img src="../img/bannercycle.png"  height = "60px"></a>']);
fprintf(oid,['		</div>']);
fprintf(oid,['		<div id="navwrapper">']);
fprintf(oid,['			<div class = "dropdown"><button onclick="context()" class="dropbtn">CONTEXT</button>']);
fprintf(oid,['				<div id="contextDropdown" class="dropdown-content">']);
fprintf(oid,['					<a href="../index.html" >Pet Portal</a>']);
fprintf(oid,['					<a href="http://www.debtheory.org/" target="_blank">DEB Portal</a>']);
fprintf(oid,['					<a href="http://www.bio.vu.nl/thb/deb/" target="_blank">DEB info</a>']);
fprintf(oid,['					<a href="http://www.bio.vu.nl/thb/deb/deblab/" target="_blank">DEBlab</a>']);
fprintf(oid,['				</div>']);
fprintf(oid,['			</div>	']);
fprintf(oid,['			<div class = "dropdown"><button onclick="collection()" class="dropbtn">COLLECTION</button>']);
fprintf(oid,['				<div id="collectionDropdown" class="dropdown-content">']);
fprintf(oid,['					<a href="../species_list.html">Species List</a>']);
fprintf(oid,['					<a href="../species_tree.html">Species Tree</a>']);
fprintf(oid,['					<a href="../about.html">About</a>']);
fprintf(oid,['				</div>']);
fprintf(oid,['			</div>	']);
fprintf(oid,['			<div class = "dropdown">']);
fprintf(oid,['			<button onclick= "window.open("http://www.debtheory.org/wiki/index.php?title=Add-my-pet_Introduction", "_blank")" class="dropbtn"> WIKI</a></button>']);
fprintf(oid,['			</div>	']);
fprintf(oid,['		</div>']);
fprintf(oid,['	</div>']);
fprintf(oid,['<!--------------------------------------------------------------->']);
fprintf(oid,['<!--   PART 2                                                  -->']);
fprintf(oid,['<!--   TOP PART OF WEBPAGE IS FIXED                            -->']);
fprintf(oid,['<!--   It has the logo and the menu with Javascript            -->']);
fprintf(oid,['<!--  dropdown menus                                           -->']);
fprintf(oid,['<!--  Please put in bold and in fancy the right links          -->']);
fprintf(oid,['<!--------------------------------------------------------------->']);
fprintf(oid,['	<div id="top2"> ']);
fprintf(oid,['	<h1 class="alignleft2"> &nbsp; &nbsp;']);
fprintf(oid,['	<a href="https://en.wikipedia.org/wiki/Blue_mussel" target="_blank"><i>',metaData.species,':</i></a> ']);
fprintf(oid,['	</h1>']);
fprintf(oid,['		<div id="navwrapper">']);
fprintf(oid,['			<div class = "dropdown"><button onclick="species()" class="dropbtn"><b>Results</b></button>']);
fprintf(oid,['				<div id="speciesDropdown" class="dropdown-content">']);
fprintf(oid,['					<a href="',metaData.species,'.html">Parameters</a>']);
fprintf(oid,['					<a class= "menu"  href="',metaData.species,'_stat.html">Implied properties</a>']);
fprintf(oid,['					<a href="results_',metaData.species,'.html">Predictions & Data</a>']);
fprintf(oid,['				</div>']);
fprintf(oid,['			</div>	']);
fprintf(oid,['			<div class = "dropdown"><button onclick="code()" class="dropbtn">Code</button>']);
fprintf(oid,['				<div id="codeDropdown" class="dropdown-content">']);
fprintf(oid,['					<a href="../entries/',metaData.species,'/mydata_my_pet.m" target="_blank">mydata</a>']);
fprintf(oid,['					<a href="../entries/',metaData.species,'/pars_init_my_pet.m" target="_blank">pars_init</a>']);
fprintf(oid,['					<a href="../entries/',metaData.species,'/predict_my_pet.m" target="_blank">predict</a>']);
fprintf(oid,['					<A HREF="../entries_zip/my_pet_zip.zip" TARGET="_top" onMouseOver="window.status=Close submenu; return true;">  <IMG SRC="../img/folder.png" WIDTH="110px"  BORDER="0" > </A>']);
fprintf(oid,['				</div>']);
fprintf(oid,['			</div>	']);
fprintf(oid,['		</div>']);
fprintf(oid,['	</div>']);
fprintf(oid,['<!-- -------------------------------------------------         -->']);
fprintf(oid,['<!--------------------------------------------------------------->']);
fprintf(oid,['<!--   PART 2                                                  -->']);
fprintf(oid,['<!--   Where all of the text is placed                         -->']);
fprintf(oid,['<!--   use "contentFull" for 1 column                          -->']);
fprintf(oid,['<!--   use "content" if you want two columns"                  -->']);
fprintf(oid,['<!--------------------------------------------------------------->	']);	
fprintf(oid,['		<div id = "main">']);
fprintf(oid,['		<div id = "main-wrapper">    ']);
fprintf(oid,['			<div id="contentFull">']);
fprintf(oid,['			<H1 id = "portaltop">Implied properties for this entry </H1>	']);	
			
fprintf(oid,['<!--------------------------------------------------------------->']);


% % print out text before the tables
% fprintf(oid, '<H2>Implied properties for this entry</H2>');
fprintf(oid, ['<H2>Model: <a class="link" target = "_blank" href="http://www.debtheory.org/wiki/index.php?title=Typified_models" >&nbsp;', metaPar.model,' &nbsp;</a></H2>']);

    
% print the table with the properties :    
fprintf(oid, '    <TABLE id = "t01">\n');
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TH colspan="4">Implied properties at typical temperature (%g deg. C)</TH></TR>\n', K2C(metaData.T_typical));
fprintf(oid, '    <TR BGCOLOR = "#FFE7C6"><TH>symbol</TH><TH> value</TH><TH> units</TH><TH> description</TH></TR>\n');
  for i = 1:length(webStatFields)
    fprintf(oid, '    <TR BGCOLOR = "%s"> <TD>%s</TD> <TD>%g</TD> <TD>%s</TD><TD>%s</TD></TR>\n',...
          webColStat.(webStatFields{i}), webStatFields{i}, stat.(webStatFields{i}), ...
       txtStat.units.(webStatFields{i}), txtStat.label.(webStatFields{i}));
  end
fprintf(oid, '    </TABLE>\n'); 
% end
fprintf(oid, '</div> <!-- end of content -->\n');
	
fprintf(oid, '			<div id="footer">\n');
fprintf(oid, '				<div class="aligncenter" style="padding:20px">\n');
fprintf(oid, '				&#169; 2016 Add-my-pet\n');
fprintf(oid, '				</div>\n');
fprintf(oid, '			</div>\n');
fprintf(oid, '		</div> <!-- main wrapper -->\n');
fprintf(oid, '	</div> <!-- main -->\n');


fprintf(oid, '</BODY>\n');
fprintf(oid, '</HTML>\n');




% fprintf(oid, '  </BODY>\n');
% fprintf(oid, '  </HTML>\n');
% fclose(oid);




