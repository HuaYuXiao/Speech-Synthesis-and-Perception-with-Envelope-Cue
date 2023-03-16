[sig,fs] = audioread('C_01_01.wav');

%-------------------Task1-------------------
%处理信号
y1_1 = tonevocoder(sig,fs,50,87);
y1_2 = tonevocoder(sig,fs,50,119);
y1_3 = tonevocoder(sig,fs,50,121);
y1_4 = tonevocoder(sig,fs,50,125);
y1_5 = tonevocoder(sig,fs,50,200);

yy= tonevocoder(sig,fs,100,114);

%保存音频
% audiowrite('C_01_01_N=87_f=50Hz.wav',y1_1,fs);
% audiowrite('C_01_01_N=119_f=50Hz.wav',y1_2,fs);
% audiowrite('C_01_01_N=4_f=50Hz.wav',y1_3,fs);
% audiowrite('C_01_01_N=6_f=50Hz.wav',y1_4,fs);
% audiowrite('C_01_01_N=200_f=50Hz.wav',y1_5,fs);

% Check the final effects here
% sound(sig,fs);
% sound(y1_1,fs);
% sound(y1_2,fs);
% sound(y1_3,fs);
% sound(y1_4,fs);
% sound(y1_5,fs);

sound(yy,fs);


%% To get psd
[Pxx0,w0] = pwelch(sig,[],[],1024,fs);
[Pxx1,w1] = pwelch(y1_1,[],[],1024,fs);
[Pxx2,w2] = pwelch(y1_2,[],[],1024,fs);
[Pxx4,w4] = pwelch(y1_3,[],[],1024,fs);
[Pxx6,w6] = pwelch(y1_4,[],[],1024,fs);
[Pxx8,w8] = pwelch(y1_5,[],[],1024,fs);

%%
% figure(1);
% subplot(3,2,1);plot(w0,20*log10(Pxx0));xlabel('frequency/Hz');ylabel('psd/dB');title('original');
% subplot(3,2,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');title('N=87');
% subplot(3,2,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');title('N=119');
% subplot(3,2,4);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');title('N=121');
% subplot(3,2,5);plot(w6,20*log10(Pxx6));xlabel('frequency/Hz');ylabel('psd/dB');title('N=125');
% subplot(3,2,6);plot(w8,20*log10(Pxx8));xlabel('frequency/Hz');ylabel('psd/dB');title('N=200');
% 
% figure(2)
% subplot(3,2,1);plot(sig);xlabel('time/s');ylabel('sig Amp');title('original');
% subplot(3,2,2);plot(y1_1);xlabel('time/s');ylabel('sig Amp');title('N=87');
% subplot(3,2,3);plot(y1_2);xlabel('time/s');ylabel('sig Amp');title('N=119');
% subplot(3,2,4);plot(y1_3);xlabel('time/s');ylabel('sig Amp');title('N=121');
% subplot(3,2,5);plot(y1_4);xlabel('time/s');ylabel('sig Amp');title('N=125');
% subplot(3,2,6);plot(y1_5);xlabel('time/s');ylabel('sig Amp');title('N=200');

figure(3)
subplot(1,2,1);plot(f,fftshift(abs(fft(sig))));xlabel('frequency/Hz');ylabel('sig Amp');title('original')
subplot(1,2,2);plot(f,fftshift(abs(fft(yy))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=114 w=100 ')
