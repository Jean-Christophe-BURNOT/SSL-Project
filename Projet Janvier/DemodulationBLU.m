%%
%PERMET D'ENREGISTRER, COPIE DU FICHIER MODULATION, LIGNE 5/10/11
nu0 = 4000;
Fe=96000;
Fc=4000;
temps = 5;
BP = 8000;
%[x,Fe]= audioread(‘nomfichier.wav’)
[nomfic,Signal,t] = RecordModulation(Fe,temps);

porteuse = cos(2*pi*nu0*t);

%sfiltr=PasseBas(Signal,Fe,Fc); % filtrage du signal
%smod = sfiltr .* porteuse ./ max(abs(sfiltr)); % modulation du signal filtré

%POUR ENTENDRE
%soundsc(smod, Fe);


%%
%reception du message, demodulation


signaltest = porteuse .* Signal ;



%Obtention du signal en sortie filtre
[signalDemoduleFiltre]=PasseBande(Signal,Fe, nu0+0.0001 - BP/2,nu0);  %Donne rien
[signalDemoduleFiltre2]= PasseBande(Signal,Fe,nu0, nu0+BP/2);       %Donne le 1er message
[SignalTest]=PasseBas(signaltest,Fe,Fc);                            %Donne le 1er et le 2ème
%[SignalTest2]=PasseBas(signaltest,nu0,Fc);


signalDemodule = porteuse .* signalDemoduleFiltre ;
signalDemodule2 = porteuse .* signalDemoduleFiltre2 ;


signalSomme = SignalTest - signalDemodule2;


%Ecoute du message
%while 0 == 0

%soundsc(real(signalDemodule),Fe);
%pause(temps);

%soundsc(real(signalDemodule2),Fe);
%pause(temps);

%soundsc(real(SignalTest),Fe);
%pause(temps);

%soundsc(real(signalSomme),Fe);
%pause(temps);

%soundsc(real(SignalTest2),Fe);
%pause(temps);
%end


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
 
 subplot(212);
 [spectre4,f] = TransFourier(Signal,t);
 plot(f,spectre4);
 legend('Signal reçu en fréquentiel');
 %plot(f,S);
% 
 figure(2);
 [spectre1,f] = TransFourier(signalDemodule2,t);
 subplot(211);
 plot(f,abs(spectre1));           %Spectre Signal DeModule 2
 legend('Signal 1 demodule et filtre');
% 
% 
 figure(3);
 [spectre2,f]=TransFourier(signalSomme, t);
 subplot(211);
 plot(f,spectre2);               %Spectre Signal Demodule
 legend('Signal 2 demodule et filtre');
%  [spectre3,f]=TransFourier(signalDemoduleFiltre, t);
%  subplot(212);
%  plot(f,spectre3);               %Spectre Signal Demodule Filtre