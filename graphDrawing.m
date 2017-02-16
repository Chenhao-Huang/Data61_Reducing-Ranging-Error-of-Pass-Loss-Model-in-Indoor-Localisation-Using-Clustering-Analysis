clc;
clear;
load('finalResult.mat');
load('RxPwrdBGrid.mat');
distanceSet1 = [];
distanceSet2 = [];
distanceSet3 = [];
for m = 1:3540
    if finalResult(m,1) == 1;
        senderNum = finalResult(m,4);
        receiverNum = finalResult (m,5);
        senderX = xyzSeats(senderNum,2);
        senderY = xyzSeats(senderNum,3);
        receiverX = xyzSeats (receiverNum, 2);
        receiverY = xyzSeats (receiverNum, 3);
        d = sqrt( (senderX - receiverX)^2 + (senderY - receiverY)^2);
        distanceSet1 = [distanceSet1; d];
    end
end
disp ('distanceSet1');
%disp (distanceSet1);
disp (max(distanceSet1));
disp (min(distanceSet1));
[n1, x1] = hist(distanceSet1,10,'r');

figure;
for m = 1:3540
    if finalResult(m,1) == 2;
        senderNum = finalResult(m,4);
        receiverNum = finalResult (m,5);
        senderX = xyzSeats(senderNum,2);
        senderY = xyzSeats(senderNum,3);
        receiverX = xyzSeats (receiverNum, 2);
        receiverY = xyzSeats (receiverNum, 3);
        d = sqrt( (senderX - receiverX)^2 + (senderY - receiverY)^2);
        distanceSet2 = [distanceSet2; d];
    end
end
disp ('distanceSet2');
%disp (distanceSet2);
disp (max(distanceSet2));
disp (min(distanceSet2));
[n2, x2] = hist(distanceSet2,10,'r');

figure;
for m = 1:3540
    if finalResult(m,1) == 3;
        senderNum = finalResult(m,4);
        receiverNum = finalResult (m,5);
        senderX = xyzSeats(senderNum,2);
        senderY = xyzSeats(senderNum,3);
        receiverX = xyzSeats (receiverNum, 2);
        receiverY = xyzSeats (receiverNum, 3);
        d = sqrt( (senderX - receiverX)^2 + (senderY - receiverY)^2);
        distanceSet3 = [distanceSet3; d];
    end
end
disp ('distanceSet3');
%disp (distanceSet3);
disp (max(distanceSet3));
disp (min(distanceSet3));
[n3, x3] = hist(distanceSet3,10,'r');

close all

%{
%Bar Chart
bar(x1,n1,'r')
hold on;
%[n2,x2] = hist(distanceSet2);
bar(x2,n2,'b')
%[n3,x3] = hist(distanceSet3);
bar(x3,n3,'g')
hold off
%}

%curve
values1=spcrv([[x1(1) x1 x1(end)];[n1(1) n1 n1(end)]],3,1000);
values2=spcrv([[x2(1) x2 x2(end)];[n2(1) n2 n2(end)]],3,1000);
values3=spcrv([[x3(1) x3 x3(end)];[n3(1) n3 n3(end)]],3,1000);
plot(values1(1,:),values1(2,:),'r',values2(1,:),values2(2,:),'b',values3(1,:),values3(2,:),'g')