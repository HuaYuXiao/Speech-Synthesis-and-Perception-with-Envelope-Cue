clear;clc;

[audio,fs]=audioread('C_01_01.wav');%声音读取

n=length(audio);
T=1/fs;%采样间隔

f=(-n/2:n/2-1)/n*fs;%频率轴

audiof=abs(fft(audio,n));

figure(1);
plot(f,fftshift(audiof));
title('初始信号频谱');xlabel('频率/Hz');ylabel('幅度');
grid;

%设计IIR低通滤波器
order=4;%低通滤波器的阶数
cutoff=[20 50 100 400];%低通滤波器的截止频率
    
Fp=200;Fs=7000;

type=4;

%频率图
figure(2);
for i=1:type
    wp=2*pi*Fp/fs;
    ws=2*pi*Fs/fs;%求出待设计的模拟滤波器的边界频率
    
    [N,wn]=buttord(wp,ws,order,cutoff(1,i),'s');
    [b,a]=butter(N,wn,'s');%S域频率响应的参数即：滤波器的传输函数
    
    [bz,az]=bilinear(b,a,0.5);%利用双线性变换实现频率响应S域到Z域的变换
    
    z=filter(bz,az,audio);%滤波后的信号频谱
    result=abs(fft(z));
    
    %绘出滤波音频频域波
    subplot(2,2,i);
    plot(f,fftshift(result));
    title(sprintf("%dHz低通滤波后的信号频谱", cutoff(1,i)));xlabel('频率/Hz');ylabel('幅度');
    grid;
end

%fft图
figure(3);
for i=1:type
    y=tonevocoder(audio,fs,cutoff(1,i),order);
        %保存音频
    audiowrite(sprintf('%dHz低通滤波后的信号.wav', cutoff(1,i)),y,fs);

    subplot(2,2,i);
    plot(f,fftshift(abs(fft(y))));
    xlabel('频率/Hz');ylabel('幅度');title(sprintf("%dHz低通滤波后的信号频谱", cutoff(1,i)))
end

%包络图
figure(4);
for i=1:type
    y=tonevocoder(audio,fs,cutoff(1,i),order);
    [Pxx,w] = pwelch(y,[],[],1024,fs);
    
    subplot(2,2,i);plot(w,20*log10(Pxx));
    xlabel('频率/Hz');ylabel('psd/dB');title(sprintf("%dHz低通滤波后的信号频谱", cutoff(1,i)));
end

%波形图
figure(5);
for i=1:type
    y=tonevocoder(audio,fs,cutoff(1,i),order);
    subplot(2,2,i);plot(y);
    xlabel('time/ms');ylabel('幅度');title(sprintf("%dHz低通滤波后的信号波形图", cutoff(1,i)));
end

%拓展部分
figure(6);
for i=1:6
    y=tonevocoder(audio,fs,1200*i,order);
    audiowrite(sprintf("%dHz低通滤波后的信号频谱.wav", 1200*i),y,fs);
    [Pxx,w] = pwelch(y,[],[],1024,fs);

    subplot(2,3,i);
    plot(w,20*log10(Pxx));
    xlabel('频率/Hz');ylabel('psd/dB');title(sprintf("%dHz低通滤波后的信号频谱", 1200*i));
end

figure(7);
for i=1:6
    y=tonevocoder(audio,fs,1200*i,order);
    subplot(2,3,i);
    plot(y);
    xlabel('time/ms');ylabel('幅度');title(sprintf("%dHz低通滤波后的信号波形图", 1200*i));
end

%函数申明
function [y] = tonevocoder(audio,fs,cutoff,N)
    % 设计滤波器
    [b,a] = butter(4,cutoff/(fs/2));
    
    % 分成N段
    Fp=200;Fs=7000;

    range = [Fp,Fs];
    range_length = 1/0.06*log10(range/165.4+1);%计算200到7000对应的长度
    d = (0:N)*(max(range_length)-min(range_length))/N+min(range_length);%N份等均分、计算断点位置
    f = 165.4*(10.^(0.06*d)-1); %计算每一个断点频率值
    passband = [f(1:N);f(2:N+1)];%每一个的通带位置
    bandcenter = mean(passband);%每一个的通带中心频率
    
    % 为每一段频率设计带通滤波器
    coeb = zeros(N,9); 
    coea = zeros(N,9);%初始化

    y = zeros(length(audio),N);
    for i = 1:N
        [coeb(i,:),coea(i,:)] = butter(4,[passband(1,i) passband(2,i)]/(fs/2));%生成滤波器
        y(:,i) = filter(coeb(i,:),coea(i,:),audio);%所在频率实现带通滤波器
    end
    
    yrectify = abs(y);%整流滤波
    envelope=zeros(length(audio),N);%包络
    for i=1:N
        envelope(:,i) = filter(b,a,yrectify(:,i));%低通滤波器实现语音包络
    end
    
    % 获得整合信号
    y = zeros(length(audio),1);%初始化
    for i = 1:N
        sinewave = sin(2*pi*bandcenter(i)*[1:length(audio)]/fs);%创建一个频率和中心频率相等的正弦波
        scurrentband = envelope(:,i).*sinewave';%Transpose and use dot product，将创建的正弦波与包络信号相乘
        y=y+scurrentband;%将该频率区间整合出的信号累加到y中，用循环重复N次
    end
    
    y=y/norm(y)*norm(audio);%归一化
end