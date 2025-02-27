%run('clean');
clear all;
close all;
 
s = serial('COM2'); %assigns the object s to serial port
set(s, 'InputBufferSize', 100); %number of bytes in inout buffer
set(s, 'FlowControl', 'None');
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',10);

fopen(s);           %opens the serial port
t=1;
disp('Running');
x=0;
tic
while(t <100)  %Runs for 200 cycles - if you cant see the symbol, it is "less than" sign. so while (t less than 200)
   a =fread(s); %reads the data from the serial port and stores it to the matrix a
   x=[x a'];
   figure(1)
   axis auto;
   grid on;
   plot(x)
   hold on;
   drawnow;
   if size(x,2)>1000
       x=0;
       hold off
   end
   a=0;  
   t=t+1;
end
 toc
fclose(s); %close the serial port
 