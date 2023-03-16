%%% setup
N = 114; % number of bands
maxF = 7000; % highest frequency
minF = 200; % lowest frequency
cFreq = 5; % cut-off frequency of LPF
order = 4; % butter order
wavFile = "C_01_01.wav"; % name of the .wav file
SNR = -5;

maxLen = log10(maxF/165.4+1)/0.06;
minLen = log10(minF/165.4+1)/0.06;
split=165.4*(10.^(0.06*((maxLen-minLen)/N*[0:N] + minLen))-1);

[y,fs]=audioread(wavFile);
[b,a]=butter(order,[split(1),split(2)]/(fs/2));
bs=zeros(N,size(b,2));
as=zeros(N,size(a,2));
for i = 1:N
    [b,a]=butter(order,[split(i),split(i+1)]/(fs/2));
    bs(i,:)=b;
    as(i,:)=a;
end

%%% check BP by freqz
% hold on 
% for i = 1:N
%     [h,f]=freqz(bs(i,1:bLen),as(i,1:aLen),512,fs);
%     plot(f,abs(h))
% end
% xlim([0,8000])

%%% BP filter test
% ith = 1;
% tmp = filter(bs(ith,:),as(ith,:),y);
% hold on
% plot(y,'Color',[0,0,1,0.02]);
% plot(tmp,'Color',[1,0,0,0.2]);

[bLPF, aLPF] = butter(order,cFreq/(fs/2));

%%% check LPF filter
% ith = 5;
% tmp = filter(bs(ith,:),as(ith,:),y);
% hold on
% plot(tmp,'Color',[0,0,1,0.02])
% plot(filter(bLPF,aLPF,abs(tmp)));

[Pxx,w]=pwelch(repmat(y,10),[],[],512,fs);
b = fir2(3000,w/(fs/2),sqrt(Pxx/max(Pxx)));
%%% check generated power spectral density by freqz
% subplot(2,1,1)
% plot(w,Pxx)
% [h,wh]=freqz(b,1,128);
% subplot(2,1,2)
% plot(wh,abs(h))

yNoice = filter(b,1,1-2*rand(1,size(y,1)));
yNoice = yNoice/norm(yNoice)*norm(y)/10^(SNR/20);


y=y+yNoice.';

ysum = zeros(size(y));
for i = 1:N
    ysum = ysum + filter(bLPF,aLPF,abs(filter(bs(i,:),as(i,:),y))).*...
        sin(pi*(split(i)+split(i+1))*linspace(0,size(y,1)/fs,size(y,1)))';
end
ysum = ysum*norm(y)/norm(ysum);
%%% check synthesized sound
% subplot(2,1,1)
% plot(ysum)
% subplot(2,1,2)
% plot(y)


sound(ysum,fs)
audiowrite("T4_N=114_f=100.wav",ysum, fs);
