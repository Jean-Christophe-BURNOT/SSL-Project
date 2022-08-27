nu0 = 4000;
Fe=96000;
Fc=4000;
T=5;
%[x,Fe]= audioread(‘nomfichier.wav’)
[nomfic,Signal,t] = RecordModulation(Fe,T);
[nomfic2,Signal2,t2] = RecordModulation(Fe,T);

porteuse = cos(2*pi*nu0*t);

sfiltr=PasseBas(Signal,Fe,Fc); % filtrage du signal 1
sfiltr2=PasseBas(Signal2,Fe,Fc); % filtrage du signal 2
% smod = sfiltr .* porteuse ./ max(abs(sfiltr)); % modulation du signal filtré
smod=(sfiltr .* porteuse - imag(hilbert(sfiltr)) .* sin(2*pi*nu0*t))./max(abs(sfiltr));
smod2=(sfiltr2 .* porteuse + imag(hilbert(sfiltr2)) .* sin(2*pi*nu0*t))./max(abs(sfiltr2));
smodTot = smod + smod2;

% while 0==0
%     soundsc(smod, Fe);
%     pause(T);
% end

[S,f] = TransFourier(Signal,t);
[Sfiltr,ffiltr] = TransFourier(sfiltr,t);
[Smod,fmod] = TransFourier(smod, t);
[SmodTot,fmodTot] = TransFourier(smodTot, t);

figure(1);
subplot(211);
plot(t,Signal);
subplot(212);
plot(f,S);

figure(2);
subplot(211);
plot(t,sfiltr);
subplot(212);
plot(ffiltr,Sfiltr);

figure(3);
subplot(211);
plot(t,smod);
subplot(212);
plot(fmod,Smod);

figure(4);
plot(fmodTot,SmodTot);
