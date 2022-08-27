nu0 = 4000;
Fe=8001;
Fc=4000;
%[x,Fe]= audioread(‘nomfichier.wav’)
[nomfic,Signal,t] = RecordModulation(Fe,2);

porteuse = cos(2*pi*nu0*t);
signalModule = porteuse .* Signal;
[s]=PasseBas(signalModule,Fe,0.1);
[S,f] = TransFourier(Signal,t);
[Smod,fmod] = TransFourier(s,t);

figure(1);
subplot(211);
plot(f,S,'r');
subplot(212);
plot(fmod, Smod,'r');