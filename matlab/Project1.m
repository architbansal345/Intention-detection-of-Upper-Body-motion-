clear all;
clc;
dt = 0.1;
ts = 15;
t = 0:dt:ts;
a = arduino('COM7','uno');
c = 0;
e =0 ;
averg=0;
figure(1)
for i = 1:length(t)
    b(i) = readVoltage(a,'A0');
    if i > 1
       c(i) = (b(i) - b(i-1))/dt;
    end
    if i>15
        x=0;
        for poi = 0:14
            x=x+c(i-poi);
        end
        averg(i-15) = x/15;
        if(averg(i-15)>0.5)
        end
    end
    %Plot for the time series
    subplot(2,2,1) 
    plot(t(1:length(b)),b)
    axis([0 ts 0 6])
    title('Voltage vs Time ( Sample wt. 2Kg) ')
    xlabel('time intervals ( in sec)') 
    ylabel('Voltage values')
    %Plot for the derivative of the time series
    subplot(2,2,2)
    plot(t(1:length(c)),c);
    axis([0 ts -10 10]); 
    title('Derivative of Voltage vs Time (Sample wt. 2Kg) ')
    xlabel('Time intervals ( in sec)') 
    ylabel('Derivtive of Voltage')
    %Moving average of the Derivative
    subplot(2,2,3)
    plot(t(1:length(averg)),averg)
    axis([0 ts -2 2]);
    title('Moving average of Derivative ')
    xlabel('Time') 
    ylabel('Moving Average')
    txt1 = 'Static';
    text2= 'Upper Movement';
    %the value of 0.2 has been brought up by studying the analytics part of
    %the project.
    if i>15
        if -0.2<averg(i-15) && averg(i-15)<0.2
            text(13,1.7,'Static','HorizontalAlignment','right', 'FontSize', 14, 'Color', 'green')
        end
        if averg(i-15)>0.2
            text(13,1.7,'Upper Movement','HorizontalAlignment','right', 'FontSize', 14, 'Color', 'red')       
        end
        if averg(i-15)<-0.2
            text(13,1.7,'Lower Movement','HorizontalAlignment','right', 'FontSize', 14, 'Color', 'blue')
        end
    end
    grid on;   
end
writematrix(b,'./Moving_Average.csv');