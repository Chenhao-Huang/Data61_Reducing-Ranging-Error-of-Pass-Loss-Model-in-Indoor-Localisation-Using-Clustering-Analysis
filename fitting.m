function [k1,k2,seatNumber1] = fitting(perimeter, seatXR, seatYR, seatNumberSendSignal)
%Personal Setting
%perimeter = 4 %thinkness of the perimeter. eg. 1 means there are 9 data points; 2 means there are 25 data points

%Loading Data

load('RxPwrdBGrid.mat');
%seat1 = [xyzSeats(1,2) xyzSeats(1,3)];
seat1RRS = RxPwrdB{1,seatNumberSendSignal};
    %Find seat index in xVals and yVals, based on x and y cordinates
interA = abs (xVals - seatXR); 
seat1X = find (interA == min(interA));
interB = abs (yVals - seatYR);
seat1Y = find (interB == min(interB));
    %retrive data points
startIndexX = seat1X - perimeter;
startIndexY = seat1Y - perimeter;
endIndexX = seat1X + perimeter;
endIndexY = seat1Y + perimeter;
RRSRaw = seat1RRS(startIndexX : endIndexX, startIndexY : endIndexY);
RRS = reshape(RRSRaw, [(2*perimeter+1)^2,1]);
RRS( (length(RRS) + 1) / 2 ) = [];
dLength = 0;
for n = startIndexY : endIndexY
    for m = startIndexX : endIndexX
        distance = sqrt ( (n - seat1Y)^2 + (m - seat1X)^2 ) * 0.1; %0.1 is the distance between each x/y value
        if distance ~= 0
            d(dLength+1) = distance;
            dLength = dLength + 1;
        end
    end
end
d = reshape(d, [length(d),1]);
%disp (d);

%{
RRS=[35.4226; 32.8165; 30.3023; 41.3384; 2424; 34.6893; 36.2731; 33.6492; 32.8968];
d=[0.1414; 0.1000; 0.1414; 0.1000; 0 ;0.1000; 0.1414; 0.1000; 0.1000];
%}

%Fitting
K0 = [1.000,1.000];
K = nlinfit(d,RRS,@logLoss,K0);
k1 = K(1);
k2 = K(2);

seatNumber1 = seatNumberSendSignal;
%Plotting
%{
d1 = min(d):0.001:max(d);
RRS1 = K(1)+K(2).*log(d1);
plot(d,RRS,'.',d1,RRS1)
legend('Data Points' , 'Fitting Curve')
%}
end

