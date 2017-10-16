%% prt_patterns
% generates  plots for patterns for display on patterns.html

%%
function prt_patterns
%% created 2016/12/31 by Bas Kooijman

%% Syntax
% <../prt_patterns *prt_patterns*>

%% Description
% generates plots for patterns for display on patterns.html

%
% Output: 
%
% * png-files written in ../img/patterns: 

%% Remarks
% For presentation on the web, copy png files to 
% /home/websites/www.bio.vu.nl/webroot/thb/deb/deblab/add_my_pet/img/patterns
% Display in entries_admin/patterns.html

close all

% log W-log dW
shstat_options('default');
shstat_options('x_label', 'on');
shstat_options('y_label', 'on');
cWdW = read_allStat('c_T', 'W_dWm', 'dWm'); c_T = cWdW(:,1); W = cWdW(:,2); dW = cWdW(:,3);
[Hfig Hleg] = shstat([W, dW ./ c_T], legend_sauria, datestr(datenum(date),'yyyy/mm/dd')); 
set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) 
xlabel('_{10}log weight at max growth, g')      
ylabel('_{10}log max growth at T_{ref}, g/d')

saveas(Hfig, '../../img/patterns/logW-logdW.png')
saveas(Hleg, '../../img/patterns/legends_logW-logdW.png')
close all

% log W-log J_O
shstat_options('default');
shstat_options('x_label', 'on');
shstat_options('y_label', 'on');
cWJO = read_allStat('c_T', 'Ww_i', 'J_Oi'); c_T = cWJO(:,1); W = cWJO(:,2); JO = cWJO(:,3);
[Hfig Hleg] = shstat([W, JO ./ c_T], legend_RSED, datestr(datenum(date),'yyyy/mm/dd')); 
set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) 
xlabel('_{10}log max adult weight, g')      
ylabel('_{10}log O_2 consumption at T_{ref}, mol/d')

saveas(Hfig, '../../img/patterns/logW-logJO.png')
saveas(Hleg, '../../img/patterns/legends_logW-logJO.png')
close all

% log V_m - log [E_m]
shstat_options('default');
LiEm = read_allStat('L_i', 'E_m'); L_i = LiEm(:,1); E_m = LiEm(:,2);
[Hfig, Hleg] = shstat([L_i.^3, E_m], legend_shark, datestr(datenum(date),'yyyy/mm/dd')); 
    
figure(Hfig) % add labels to figure, because this is not done by shstat in numerical mode
xlabel('_{10}log ultimate structural volume, cm^3')      
ylabel('_{10}log max reserve capacity, J/cm^3')

saveas(Hfig, '../../img/patterns/logV-logEm.png')
saveas(Hleg, '../../img/patterns/legends_logV-logEm.png')
close all

% log V_m - log [p_M] ([p_M] is given at T_ref)
shstat_options('default');
LipM = read_allStat('L_i', 'p_M'); L_i = LipM(:,1); p_M = LipM(:,2); 
[Hfig, Hleg] = shstat([L_i.^3, p_M], legend_RSED, datestr(datenum(date),'yyyy/mm/dd')); 
    
figure(Hfig) % add labels to figure, because this is not done by shstat in numerical mode
xlabel('_{10}log ultimate structural volume, cm^3')      
ylabel('_{10}log spec som maintenance at T_{ref}, J/d.cm^3')

saveas(Hfig, '../../img/patterns/logV-logpM.png')
saveas(Hleg, '../../img/patterns/legends_logV-logpM.png')
close all

% low p_M- log RW
shstat_options('default');
WRpMcT = read_allStat('Wd_b', 'R_i', 'p_M', 'c_T'); Wd_b = WRpMcT(:,1); R_i = WRpMcT(:,2); p_M = WRpMcT(:,3); c_T = WRpMcT(:,4);
[Hfig Hleg] = shstat([p_M ./ c_T, Wd_b .* R_i ./ c_T], legend_RSED, datestr(datenum(date),'yyyy/mm/dd')); 

figure(Hfig) 
xlabel('_{10}log spec som maintenance at T_{ref}, J/d.cm^3')      
ylabel('_{10}log spec max reprod rate \times weight at birth at T_{ref}, g/d')

saveas(Hfig, '../../img/patterns/logpM-logRW.png')
saveas(Hleg, '../../img/patterns/legends_logpM-logRW.png')
close all

% log p_M-log dW/W
shstat_options('default');
WdWpMcT = read_allStat('W_dWm', 'dWm', 'p_M', 'c_T'); W_dWm = WdWpMcT(:,1); dWm = WdWpMcT(:,2); p_M = WdWpMcT(:,3); c_T = WdWpMcT(:,4);
[Hfig Hleg] = shstat([p_M ./ c_T, dWm ./ W_dWm ./ c_T], legend_RSED, datestr(datenum(date),'yyyy/mm/dd')); 
%set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) 
xlabel('_{10}log spec som maintenance at T_{ref}, J/d.cm^3')      
ylabel('_{10}log spec max growth rate at T_{ref}, 1/d')

saveas(Hfig, '../../img/patterns/logpM-logdWW.png')
saveas(Hleg, '../../img/patterns/legends_logpM-logdWW.png')
close all

% log ss-kap
shstat_options('default');
shstat_options('y_transform', 'none');
shstat_options('x_label', 'on');
shstat_options('y_label', 'on');
[Hfig Hleg] = shstat({'s_s', 'kap'}, legend_RSED, datestr(datenum(date),'yyyy/mm/dd')); 
set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) % add items to figure
kap = linspace(1e-6,1,100); ss = kap.^2 .* (1 - kap); 
plot(log10(ss), kap, 'k', 'Linewidth', 2)
ylim([0 1]);
saveas(Hfig, '../../img/patterns/logss-kap.png')
saveas(Hleg, '../../img/patterns/legends_logss-kap.png')

close all

% ss-kap
shstat_options('x_transform', 'none');
shstat_options('y_transform', 'none');
shstat_options('x_label', 'on');
shstat_options('y_label', 'on');
[Hfig Hleg] = shstat({'s_s', 'kap'}, legend_vert, datestr(datenum(date),'yyyy/mm/dd')); 
set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) % add items to figure
kap = linspace(0, 1, 100); ss = kap.^2 .* (1 - kap); 
plot(ss, kap, 'k', 'Linewidth', 2)
xlim([0 4/27]); ylim([0 1]);
saveas(Hfig, '../../img/patterns/ss-kap.png')
saveas(Hleg, '../../img/patterns/legends_ss-kap.png')

close all
