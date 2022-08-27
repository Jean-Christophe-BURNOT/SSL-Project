%%
%PERMET D'ENREGISTRER, COPIE DU FICHIER MODULATION, LIGNE 5/10/11
nu0 = 4000;
Fe=96000;
Fc= 4000;
BP = 8000;
temps = 5;
%[x,Fe]= audioread(‘nomfichier.wav’)
[nomfic,Signal,t] = RecordModulation(Fe,temps);

porteuse = cos(2*pi*nu0*t);

%sfiltr=PasseBas(Signal,Fe,Fc); % filtrage du signal
%smod = sfiltr .* porteuse ./ max(abs(sfiltr)); % modulation du signal filtré

%POUR ENTENDRE
%soundsc(smod, Fe);



%%
%reception du message, demodulation

signalDemodule = porteuse .* Signal;



%Obtention du signal en sortie filtre
[signalDemoduleFiltre]=PasseBas(signalDemodule,Fe,Fc); 



%Ecoute du message
% while 0 == 0
% 
% soundsc(signalDemoduleFiltre,Fe);
% pause(temps);
% end






%%
%AFFICHAGES

%Set up du vecteur temps
%[audio,Fe]=audioread('r.wav');
%audio = audio(:,1)';  %Pour eviter les enregistrements st�r�o
%T=length(audio)*1/Fe;  
%t=0:1/Fe:T-1/Fe; 

 figure(1);
 subplot(211);
 plot(t,Signal);
 legend('Signal reçu en temporel');
 %subplot(212);
 %plot(f,S);
% 
 figure(2);
 [spectre1,f] = TransFourier(Signal,t);
 subplot(211);
 plot(f,abs(spectre1));           %Spectre Signal Module
 legend('Spectre Signal Modulé');
% 
% 
 figure(3);
 [spectre2,f]=TransFourier(signalDemodule, t);
 subplot(211);
 plot(f,spectre2);               %Spectre Signal Demodule
 legend('Spectre Signal Démodulé');
 [spectre3,f]=TransFourier(signalDemoduleFiltre, t);
 subplot(212);
 plot(f,spectre3);               %Spectre Signal Demodule Filtre
 legend('Spectre Signal Démodulé et filtré');