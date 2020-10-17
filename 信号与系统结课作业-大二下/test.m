%�����ź�
dt = 0.01;
t = -2*pi:dt:2*pi;
ft = (1+cos(t))/2 .*(t>=-pi&t<=pi);
% ��ӡ����
subplot(5,3,1),plot(t,ft);
ylabel('f(t)');
axis([-1.5*pi,1.5*pi,1.1*min(ft),1.1*max(ft)]);
title('�źŲ���');
grid on;
% ��ӡƵ��
N = length(t);
k = -N/2:N/2;
w = k * 12 * pi / N;                       %Ƶ�׷�Χ:-6pi��6pi
F= ft * exp(-j * t' * w) * dt;            %��ԭ�źŽ��и���Ҷ�任
subplot(6,3,3),plot(w,abs(F));
axis([-pi,pi,min(abs(F))-0.2,1.1*max(abs(F))])
title('Ƶ��');
ylabel('F(jw)');
grid on;
%��Բ�ͬ�Ĳ������ڽ��в���
for i = 1:3
	%��������²�ͬ�Ĳ�������
	if i==1
        Ts = 1;
	elseif i==2
    	Ts = pi/2;
	else Ts = 2;
    end
	n = -100*pi:Ts:100*pi;              %������
	f = (1+cos(n))/2.*(n>=-pi&n<=pi);   %ԭ�źŽ��в��������
	subplot(6,3,i+3),stem(n,f,'filled');
    axis([-1.5*pi,1.5*pi,1.1*min(f),1.1*max(f)]);
	str = ['��������Ϊ',num2str(Ts),'�Ĳ����ź�'];
    title(str);
    ylabel('fp(n)');
    grid on;
    N = length(n);
    k = -N/2:N/2;
    w = k * 6 * pi / N;                       %Ƶ�׷�Χ:-3pi��3pi
    F= f * exp(-j * n' * w) * Ts;            %�Բ����źŽ��и���Ҷ�任
    subplot(6,3,i+6),plot(w,abs(F));
    axis([min(w),max(w),min(abs(F))-0.2,1.1*max(abs(F))]);
    str = ['��������Ϊ',num2str(Ts),'��Ƶ��'];
    title(str);
    ylabel('Fp(jw)');
    grid on;
    
    if Ts==pi/2     % Ts==pi/2ʱ�������ؽ�
        continue;
    end
    
    %�ؽ�
    wc = 2.4;
    %�ڲ幫ʽ
    fr = f/pi*Ts*wc*sinc((wc/pi)*(ones(length(n),1)*t - n'*ones(1,length(t))));
    subplot(6,3,i+9),plot(t,fr); 
    axis([-1.5*pi,1.5*pi,1.1*min(fr),1.1*max(fr)]);
    str = ['��������Ϊ',num2str(Ts),'���ؽ��ź�'];
    title(str);
    grid on;
    
    N = length(t);
    k = -N/2:N/2-1;
    w = k * 12 * pi / N;                       %Ƶ�׷�Χ:-6pi��6pi
    Fr= fr * exp(-j * t' * w) * dt;            %��fr�źŽ��и���Ҷ�任
    subplot(6,3,i+12),plot(w,abs(Fr));
    axis([-pi,pi,min(abs(Fr))-0.2,1.1*max(abs(Fr))])
    str = ['��������Ϊ',num2str(Ts),'���ؽ��ź�Ƶ��'];
    title(str);
    ylabel('Fr(jw)');
    grid on;
    
    subplot(6,3,i+15),plot(t,abs(fr-ft));
    axis([-1.5*pi,1.5*pi,-0.01,1.1*max(abs(fr-ft))]);
    str = ['��������Ϊ',num2str(Ts),'�ľ������'];
    title(str);
    grid on;
end
