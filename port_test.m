%run('clean');
clear all;
close all;
 
s = serial('COM5'); %assigns the object s to serial port
s1 = serial('COM1'); %assigns the object s to serial port

set(s, 'InputBufferSize', 1000); %number of bytes in inout buffer
set(s, 'FlowControl', 'hardware');
set(s, 'BaudRate', 19200);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',10);

set(s1, 'InputBufferSize', 100); %number of bytes in inout buffer
set(s1, 'FlowControl', 'hardware');
set(s1, 'BaudRate', 9600);
set(s1, 'Parity', 'none');
set(s1, 'DataBits', 8);
set(s1, 'StopBit', 1);
set(s1, 'Timeout',10);
 
fopen(s);           
fopen(s1);
t=1;
disp('Running');
x=0;
x1=450;
flag=1;
f1=(12:2:98);
f2=(13:2:99);

while fread(s,1)~=126
    a=0;
end
a=zeros(100,1);
cont=0;
tic
while(t <100) 

   if t==1 
     a(2:100) =fread(s,99);
   else
     a =fread(s,100);  
   end
   
   altos=a(f1)*256;
   c=altos+a(f2);
   x1=[x1 c'];
   subplot(2,1,1)
   plot(x1)
   hold on;
   drawnow;
   
   if get(s1,'BytesAvailable')> 50
      b=fread(s1,get(s1,'BytesAvailable'));
   if cont~=0
       b(1:8-cont)=[];
       cont=0;
   end
   aux=b==249;
   aux=find(aux);
   for i=1:length(aux)
   if aux(i)+8<length(b)
       b(aux(i):aux(i)+8)=255;
   else 
       cont=length(b)-aux(i);
       b(aux(i):end)=255;
   end
   end
   aux2=b==255;
   aux2=find(aux2);
   b(aux2)=[];
    axis auto;
   grid on;
   x=[x b'];
   subplot(2,1,2)
   plot(x);
   hold on;
   drawnow;
   end
      
      
%    for i=1:length(b)
%        if b(i)==249 && flag==1
%        b(i:end)=[];    
%        flag=0;
%        break
%        end
%        if b(i)==248 && flag==0
%        b=b(i+1:end);
%        flag=1;
%        break
%        end
%    end
%    if flag==0
%     b(:)=[];
%    end
% if ~isempty(b)
%    axis auto;
%    grid on;
%    x=[x b'];
%    subplot(2,1,2)
%    plot(x);
%    hold on;
%    drawnow;

   % end 
    a=0; 
    b=0;
    t=t+1;
end
b=fread(s1,get(s1,'BytesAvailable'));
 toc
fclose(s); %close the serial port
fclose(s1); 