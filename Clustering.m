%Personal Setting
clc;
clear;
perimeter = 3; %thinkness of the perimeter. eg. 1 means there are 9 data points; 2 means there are 25 data points
numberOfCluster = 3;


%Log curve Fitting
load('RxPwrdBGrid.mat');
fittingResult = [];
for n = 1:60 %This figure has to be 60, as there are 60 seats in the carbin 
    %n is the transmitter
    for m = 1:60 %This figure has to be 60, as there are 60 seats in the carbin
        %m is the receiver
        if n ~= m
            seatXR = xyzSeats(m,2); %Seat coordinate which sends the signal
            seatYR = xyzSeats(m,3);
            [a,b, seatNumber] = fitting (perimeter, seatXR, seatYR, n); % n is used to find suitable cell in mat
            oneFittingResult = [a,b,seatNumber,m];
            fittingResult = [fittingResult; oneFittingResult];
        end
    end
    disp ([n]);
end
save fittingResult.mat

%Clustering: Kmeans
load fittingResult
[idx, C, SUMD] = kmeans(fittingResult(:,1:2),numberOfCluster,'MaxIter',100,'Distance','cityblock');
finalResult = [idx fittingResult]
save finalResult

%{
%Clustering: hierarchical
load fittingResult
Y = pdist(fittingResult(:,1:2),'cityblock');
squareform(Y);
Z = linkage(Y,'average');
C = cophenet(Z,Y)
I = inconsistent(Z)
disp(dendrogram(Z))
T = cluster(Z,'maxclust',10);
finalResult = [T fittingResult];
%}

figure;
%plotting clustering
for n = 1:3540
    if finalResult(n,1) == 1;
        plot (finalResult(n,2),finalResult(n,3),'r*');
        hold on;
    elseif finalResult(n,1) == 2;
        plot (finalResult(n,2),finalResult(n,3),'b*');
        hold on;
    elseif finalResult(n,1) == 3;
        plot (finalResult(n,2),finalResult(n,3),'g*');
        hold on;
    elseif finalResult(n,1) == 4;
        plot (finalResult(n,2),finalResult(n,3),'c*');
        hold on;
    elseif finalResult(n,1) == 5;
        plot (finalResult(n,2),finalResult(n,3),'m*');
        hold on;
    else finalResult(n,1) == 6;
        plot (finalResult(n,2),finalResult(n,3),'y*');
        hold on;
    end
end
hold on;
plot(C(:,1), C(:,2),'d','MarkerSize',5);
xlabel 'k1';
ylabel 'k2';
title 'Cluster: K1, K2';
hold off;


%{
% Calculating Cost Function
disp('SUMD');
disp(SUMD);
J = 0;
for n = 1: numberOfCluster
    J = J + SUMD(n,1);
end
J = 1/3540 * J;
disp (J);
%}

%Plotting cluster on plane cabin
figure;
for n = 1:60
    startNum = (n-1) * 59 + 1;
    endNum = startNum + 59 - 1;
    for m = startNum : endNum
        if finalResult(m,1) == 1;
            %plot (finalResult(n,2),finalResult(n,3),'k*');
            seatNumber1 = finalResult(m,5);
            plot (xyzSeats(seatNumber1,2),xyzSeats(seatNumber1,3),'r*');    
            %disp(seatNumber1);
            hold on;
        elseif finalResult(m,1) == 2;
            seatNumber2 = finalResult(m,5);
            plot (xyzSeats(seatNumber2,2),xyzSeats(seatNumber2,3),'b*');
            %disp(seatNumber2);
            hold on;
        elseif finalResult(m,1) == 3;
            seatNumber3 = finalResult(m,5);
            plot (xyzSeats(seatNumber3,2),xyzSeats(seatNumber3,3),'g*');
            %disp(seatNumber3);
            hold on;
        elseif finalResult(m,1) == 4;
            seatNumber4 = finalResult(m,5);
            plot (xyzSeats(seatNumber4,2),xyzSeats(seatNumber4,3),'k*');
            %disp(seatNumber3);
            hold on;
        elseif finalResult(m,1) == 5;
            seatNumber5 = finalResult(m,5);
            plot (xyzSeats(seatNumber5,2),xyzSeats(seatNumber5,3),'c*');
            %disp(seatNumber3);
            hold on;
        else finalResult(m,1) == 6;
            seatNumber6 = finalResult(m,5);
            plot (xyzSeats(seatNumber6,2),xyzSeats(seatNumber6,3),'y*');
            %disp(seatNumber3);
        hold on;
        end
    end
    nStr = num2str(n);
    hold off;

    filename = strcat ('fig', nStr, '.png');
    saveas (gcf,filename);
end

hold off;
