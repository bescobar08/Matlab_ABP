function [data]=loadmimic(subject_index,min1,min2,signals)
data=zeros(3,600000,(min2-min1)/20);
subject=strcat('mimicdb/',subject_index,'/',subject_index);
time1=convert2date(min1);
time2=convert2date(min2);
for i=1:(min2-min1)/20
data(:,:,i)=rdsamp(subject,'begin',time1,'stop',time2,'sigs',signals,'hires',true,'phys',true);
end