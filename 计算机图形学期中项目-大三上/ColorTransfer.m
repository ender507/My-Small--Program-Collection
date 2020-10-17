%% ����ͼƬ�ļ�
img1 = 'a.jpg';
img2 = 'b.png';
img1 = imread(img1);
img2 = imread(img2);
% ������ֵ��Ϊ������
img1 = im2double(img1);
img2 = im2double(img2);
% ��ʾ����ԭͼ
figure(1);
imshow(img1);
figure(2);
imshow(img2);

%% ��img1��RGB�ռ�ӳ�䵽l-alpha-beta�ռ� 
[wid1, hei1, dep1] = size(img1);
for i = 1:wid1
   for j = 1:hei1 
       % RGB -> LMS
       tmp = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1228 0.8444] * ...
       [img1(i,j,1);img1(i,j,2);img1(i,j,3)];
       % LMS -> lab
       tmp = [sqrt(1/3) 0 0;0 sqrt(1/6) 0;0 0 sqrt(1/2)] * ...
       [1 1 1;1 1 -2;1 -1 0] * ...
       [log10(tmp(1));log10(tmp(2));log10(tmp(3))];
       img1(i,j,1) = tmp(1);
       img1(i,j,2) = tmp(2);
       img1(i,j,3) = tmp(3);
   end
end

%% ��img2��RGB�ռ�ӳ�䵽l-alpha-beta�ռ�
[wid2, hei2, dep2] = size(img2);
for i = 1:wid2
   for j = 1:hei2 
       % RGB -> LMS
       tmp = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1228 0.8444] * ...
       [img2(i,j,1);img2(i,j,2);img2(i,j,3)];
       % LMS -> lab
       tmp = [sqrt(1/3) 0 0;0 sqrt(1/6) 0;0 0 sqrt(1/2)] * ...
       [1 1 1;1 1 -2;1 -1 0] * ...
       [log10(tmp(1));log10(tmp(2));log10(tmp(3))];
       img2(i,j,1) = tmp(1);
       img2(i,j,2) = tmp(2);
       img2(i,j,3) = tmp(3);
   end
end

%% �����ֵ�ͱ�׼��
mean_l1 = mean2(img1(:,:,1));
mean_alpha1 = mean2(img1(:,:,2));
mean_beta1 = mean2(img1(:,:,3));
mean_l2 = mean2(img2(:,:,1));
mean_alpha2 = mean2(img2(:,:,2));
mean_beta2 = mean2(img2(:,:,3));
var_l1 = std2(img1(:,:,1));
var_alpha1 = std2(img1(:,:,2));
var_beta1 = std2(img1(:,:,3));
var_l2 = std2(img2(:,:,1));
var_alpha2 = std2(img2(:,:,2));
var_beta2 = std2(img2(:,:,3));

%% ����ͼ��任
% Ŀ��ͼ���ֵ��Ϊ0
img1(:,:,1) = img1(:,:,1) - mean_l1;
img1(:,:,2) = img1(:,:,2) - mean_alpha1;
img1(:,:,3) = img1(:,:,3) - mean_beta1;
% Ŀ��ͼ�񷽲��ΪԴͼ�񷽲�
img1(:,:,1) = img1(:,:,1) * var_l2/var_l1;
img1(:,:,2) = img1(:,:,2) * var_alpha2/var_alpha1;
img1(:,:,3) = img1(:,:,3) * var_beta2/var_beta1;
% Ŀ��ͼ���ֵ��ΪԴͼ���ֵ
img1(:,:,1) = img1(:,:,1) + mean_l2;
img3 = img1(:,:,:);
img3(:,:,2) = img3(:,:,2) + mean_alpha2;
img3(:,:,3) = img3(:,:,3) + mean_beta2;


%% ��img1��l-alpha-beta�ռ仹ԭ��RGB�ռ�
for i = 1:wid1
   for j = 1:hei1 
       % lab -> LMS
       tmp1 = [1 1 1;1 1 -1;1 -2 0] * ...
       [sqrt(1/3) 0 0;0 sqrt(1/6) 0;0 0 sqrt(1/2)] * ...
       [img1(i,j,1);img1(i,j,2);img1(i,j,3)];
       tmp2 = [1 1 1;1 1 -1;1 -2 0] * ...
       [sqrt(1/3) 0 0;0 sqrt(1/6) 0;0 0 sqrt(1/2)] * ...
       [img3(i,j,1);img3(i,j,2);img3(i,j,3)];
       % LMS -> RGB
       tmp1 = [4.4679 -3.5873 0.1193;-1.2186 2.3809 -0.1624;0.0497 -0.2439 1.2045] * ...
           [10^tmp1(1);10^tmp1(2);10^tmp1(3)];
       img1(i,j,1) = tmp1(1);
       img1(i,j,2) = tmp1(2);
       img1(i,j,3) = tmp1(3);
       tmp2 = [4.4679 -3.5873 0.1193;-1.2186 2.3809 -0.1624;0.0497 -0.2439 1.2045] * ...
           [10^tmp2(1);10^tmp2(2);10^tmp2(3)];
       img3(i,j,1) = tmp2(1);
       img3(i,j,2) = tmp2(2);
       img3(i,j,3) = tmp2(3);
   end
end
%% ��ӡ���
% alpha-beta��ֵ��img2һ�µ�ͼƬ
figure(3);
imshow(img3);
% alpha-beta��ֵΪ0��ͼƬ
figure(4);
imshow(img1);

