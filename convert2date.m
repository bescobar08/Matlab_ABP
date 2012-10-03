function time=convert2date(value)
hours=fix(value/60);
minutes=mod(value,60);
if hours <9
    hours=strcat('0',num2str(hours));
else
   hours=num2str(hours); 
end
if minutes <9
    minutes=strcat('0',num2str(minutes));
else
   minutes=num2str(minutes); 
end
time=strcat(hours,':',minutes,':','00');
