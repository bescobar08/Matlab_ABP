function [results]=ecg1(data,points)
results=[0 0 0 0 0];
for k=1:size(points,1)
    ecg=data(1,points(k,1)-100:points(k,1),points(k,3));
    ecg=ecg.*(ecg>0.4);
    ecg_peak=findpeaks(ecg);
    plet=data(2,points(k,1):points(k,1)+100,points(k,3));
    plet=moving(plet,10);
    [x y]=max(diff(plet));
    if length(ecg_peak)==1
       results(end+1,:)=[y+points(k,1) points(k,1) ecg_peak-101+points(k,1) points(k,2) points(k,3)];
    else
    end    
end
results(1,:)=[];
