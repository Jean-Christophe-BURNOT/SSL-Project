nu0 = 4000;
Fe=8001;
Fc=4000;
%[x,Fe]= audioread(‘nomfichier.wav’)
[nomfic,Signal,t] = RecordModulation(Fe,2);

porteuse = cos(2*pi*nu0*t);
signalModule = porteuse .* Signal;
%[s]=PasseBas(signalModule,Fe,0.1);
[S,f] = TransFourier(Signal,t);
[Smod,fmod] = TransFourier(signalModule,t);

figure(1);
subplot(211);
plot(f,S,'r');
subplot(212);
plot(fmod, Smod,'r');



%reception du message
signalRecu= fmod; 
%[signalRecu, fe] = audioread('r.wav');  
%transformée de fourrer inverse pour obtenir l'echantillon temporel du
%signal
FrequenceEchantillonage= 8000;
[signalTemporel,t] = TransFourierInv(signalRecu,FrequenceEchantillonage);

%Filtrages eventuels nécéssaire
%démodulation 


z = t;
Fe= FrequenceEchantillonage;
Fc= 4000;

FrenquenceModulation = 4000;
[s]=PasseBas(z,Fe,Fc);

sound(signalRecu)
figure(2);
plot(signalTemporel, s, 'r');



%écoute du message