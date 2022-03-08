clear; close all; clc;
% this script loads the result of contour plots for each model and merges
% them all together into one common figure

%%% load all the model simulations
load('ModelA_results.mat','Q','V','palv','pvasc','dpac')
QA = Q; VA = V; palvA = palv; pvascA = pvasc; dpacA = dpac;
clear Q V palv pvasc dpac
load('ModelB_results.mat','Q','V','palv','pvasc','dpac')
QB = Q; VB = V; palvB = palv; pvascB = pvasc; dpacB = dpac;
clear Q V palv pvasc dpac
load('ModelC_results.mat','Q','V','palv','pvasc','dpac')
QC = Q; VC = V; palvC = palv; pvascC = pvasc; dpacC = dpac;
clear Q V palv pvasc dpac
load('ModelD_results.mat','Q','V','palv','pvasc','dpac')
QD = Q; VD = V; palvD = palv; pvascD = pvasc; dpacD = dpac;
clear Q V palv pvasc dpac
load('ModelE_results.mat','Q','V','palv','pvasc','dpac')
QE = Q; VE = V; palvE = palv; pvascE = pvasc; dpacE = dpac;
clear Q V palv pvasc dpac
load('ModelF_results.mat')
QF = Q; VF = V; palvF = palv; pvascF = pvasc; dpacF = dpac;
clear Q V palv pvasc dpac

%%% load exercise data
load('ExerciseData','CO_data','V_data')

%%% load optimization results
load('ModelA_optimization_v2_results.mat','JA','DA')
load('ModelB_optimization_v2_results.mat','JB','DB')
load('ModelC_optimization_v2_results.mat','JC','DC')
load('ModelD_optimization_v2_results.mat','JD','DD')
load('ModelE_optimization_v2_results.mat','JE','DE')
load('ModelF_optimization_v2_results.mat','JF','DF')

%%% ploting cost as a function of D
DAp = 500; DBp = 2200;%1e4;
DCp = 80; DDp = 380;%436.54;
DEp = 6.4e3; DFp = 536.36; %best fit D

JAp = interp1(DA, JA, DAp);
JBp = interp1(DB, JB, DBp);
JCp = interp1(DC, JC, DCp);
JDp = interp1(DD, JD, DDp);%3.05e3;
JEp = interp1(DE, JE, DEp);
JFp = interp1(DF, JF, DFp);

ylimv = [1e1 1e6];

figure;
subplot(2,3,1)
loglog(DA,JA,DAp,JAp,'ro','linewidth',2,'markersize',7)
title('Model A Cost')
ylabel('J')
set(gca,'fontsize',18)
ylim(ylimv)

subplot(2,3,2)
loglog(DB,JB,DBp,JBp,'ro','linewidth',2,'markersize',7)
title('Model B Cost')
set(gca,'fontsize',18)
ylim(ylimv)
xlim([min(DB) max(DB)])

subplot(2,3,3)
loglog(DC,JC,DCp,JCp,'ro','linewidth',2,'markersize',7)
title('Model C Cost')
set(gca,'fontsize',18)
ylim(ylimv)

subplot(2,3,4)
loglog(DD,JD,DDp,JDp,'ro','linewidth',2,'markersize',7)
title('Model D Cost')
ylabel('J')
xlabel('D')
set(gca,'fontsize',18)
ylim(ylimv)
xlim([min(DD) max(DD)])

subplot(2,3,5)
loglog(DE,JE,DEp,JEp,'ro','linewidth',2,'markersize',7)
title('Model E Cost')
xlabel('D')
set(gca,'fontsize',18)
ylim(ylimv)

subplot(2,3,6)
loglog(DF,JF,DFp,JFp,'ro','linewidth',2,'markersize',7)
title('Model F Cost')
xlabel('D')
set(gca,'fontsize',18)
xlim([1e2 1e3])
ylim(ylimv)

%%%%

CON = 10:10:150;
CON2 = 0:2:12;
CONfit = 125;
x = 0:70;

xl = 40;
yl = 70;
lw = 1.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Models A-D
figure;
subplot(3,4,1)
contour(QA,VA,palvA,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model A')
ylabel('Air Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,5)
contour(QA,VA,pvascA,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
hold on
contour(QA,VA,pvascA,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
set(gca,'fontsize',18)
ylabel('Air Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,9)
contour(QA(:,1:81),VA(:,1:81),dpacA(:,1:81),CON2,'ShowText','on','linewidth',lw)
contour(QA,VA,dpacA,CON2,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
ylabel('Air Flow (L/min)')
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,2)
contour(QB,VB,palvB,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model B')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,6)
contour(QB,VB,pvascB,CON,'ShowText','on','linewidth',lw)
hold on
contour(QB,VA,pvascB,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlim([0 xl])
ylim([0 yl])

subplot(3,4,10)
contour(QB,VB,dpacB,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,3)
contour(QC,VC,palvC,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model C')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,7)
contour(QC,VC,pvascC,CON,'ShowText','on','linewidth',lw)
hold on
contour(QC,VC,pvascC,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlim([0 xl])
ylim([0 yl])

subplot(3,4,11)
contour(QC(:,1:81),VC(:,1:81),dpacC(:,1:81),CON2,'ShowText','on','linewidth',lw)
hold on
contour(QC,VC,dpacC,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,4)
contour(QD,VD,palvD,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model D')
xlim([0 xl])
ylim([0 yl])

subplot(3,4,8)
contour(QD,VD,pvascD,CON,'ShowText','on','linewidth',lw)
hold on
contour(QD,VD,pvascD,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlim([0 xl])
ylim([0 yl])

subplot(3,4,12)
contour(QD,VD,dpacD,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Models E-F



figure;
subplot(3,2,1)
contour(QE,VE,palvE,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model E')
xlim([0 xl])
ylim([0 yl])

subplot(3,2,3)
contour(QE,VE,pvascE,CON,'ShowText','on','linewidth',lw)
hold on
contour(QE,VE,pvascE,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlim([0 xl])
ylim([0 yl])

subplot(3,2,5)
contour(QE,VE,dpacE,CON2,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

subplot(3,2,2)
contour(QF,VF,palvF,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
title('Model F')
xlim([0 xl])
ylim([0 yl])

subplot(3,2,4)
contour(QF,VF,pvascF,CON,'ShowText','on','linewidth',lw)
hold on
contour(QF,VF,pvascF,[CONfit CONfit], 'ShowText','on','linewidth',2,'EdgeColor',[0 0 0])
hold on
plot(CO_data,V_data,'ko','linewidth',2,'markersize',10)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlim([0 xl])
ylim([0 yl])

subplot(3,2,6)
contour(QF,VF,dpacF,CON,'ShowText','on','linewidth',lw)
hold on
plot(x,x,'k--','linewidth',lw)
set(gca,'fontsize',18)
xlabel('Blood Flow (L/min)')
xlim([0 xl])
ylim([0 yl])

