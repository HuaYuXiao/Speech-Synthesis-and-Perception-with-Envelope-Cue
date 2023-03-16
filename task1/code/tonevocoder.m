function [ygenerated] = tonevocoder(sig,fs,w_cutoff,N)

% 设计滤波器
[b,a] = butter(4,w_cutoff/(fs/2));

% 分成N段
range = [200,7000];
range_length = 1/0.06*log10(range/165.4+1);%计算200到7000对应的长度
d = (0:N)*(max(range_length)-min(range_length))/N+min(range_length);%N份等均分、计算断点位置
f = 165.4*(10.^(0.06*d)-1); %计算每一个断点频率值
passband = [f(1:N);f(2:N+1)];%每一个的通带位置
bandcenter = mean(passband);%每一个的通带中心频率

% 为每一段频率设计带通滤波器
coeb = zeros(N,9); coea = zeros(N,9);%初始化
y = zeros(length(sig),N);
for i = 1:N
    [coeb(i,:),coea(i,:)] = butter(4,[passband(1,i) passband(2,i)]/(fs/2));%生成滤波器
    y(:,i) = filter(coeb(i,:),coea(i,:),sig);%所在频率实现带通滤波器
end


yrectify = abs(y);
envelope = zeros(length(sig),N);%初始化包络
for i = 1:N
    envelope(:,i) = filter(b,a,yrectify(:,i));%低通滤波器实现语音包络
end

% 获得整合信号
ygenerated = zeros(length(sig),1);%初始花
for i = 1:N
    sinewave = sin(2*pi*bandcenter(i)*[1:length(sig)]/fs);%创建一个频率和中心频率相等的正弦波
    scurrentband = envelope(:,i).*sinewave';%Transpose and use dot product，将创建的正弦波与包络信号相乘
    ygenerated =  ygenerated + scurrentband;%将该频率区间整合出的信号累加到y中，用循环重复N次
end

ygenerated = ygenerated/norm(ygenerated)*norm(sig);%归一化
end