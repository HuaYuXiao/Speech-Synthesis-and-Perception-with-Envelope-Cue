[b1, a1]=butter(4,[400 1000]/(fs/2)); %band-pass
[b2, a2]=butter(4,[400 1000]/(fs/2)); %band-pass
[b3, a3]=butter(4,[400 1000]/(fs/2)); %band-pass
[b4, a4]=butter(4,[400 1000]/(fs/2)); %band-pass

[h1,f1]=freqz(b1,a1,512,fs); % Digital filter frequency response
[h2,f2]=freqz(b2,a2,512,fs); % Digital filter frequency response
[h3,f3]=freqz(b3,a3,512,fs); % Digital filter frequency response
[h4,f4]=freqz(b4,a4,512,fs); % Digital filter frequency response

plot(f1,20*log10(abs(h1)),'LineWidth',2); % in dB scale
hold on;
plot(f2,20*log10(abs(h2)),'LineWidth',2); % in dB scale
hold on;
plot(f3,20*log10(abs(h3)),'LineWidth',2); % in dB scale
hold on;
plot(f4,20*log10(abs(h4)),'LineWidth',2); % in dB scale
hold on;

axis([0 1400 -10 4]);

legend('1','2','4','6','8');
xlabel('Frequency(Hz)');ylabel('Magnitude');

y1=filter(a1,b1,audio);