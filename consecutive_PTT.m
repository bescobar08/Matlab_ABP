function [c_results]=consecutive_PTT(data,data_edited,analysis_type)
hour=1;
n=0;
while n==0
    if isempty(data_edited{hour})
       hour=hour+1;
    else
       n=1;
       index1=data_edited{hour}(1,1);
       index2=data_edited{hour}(1,2);
    end
end
data=data(:,round(index1):round(index2),hour);
abp=data(3,:);
s_abp=moving(abp,30);
peaks_index=findpeaks(s_abp)-1;
[peaks_total]=correct_peaks_c(peaks_index,abp);
results=[0 0 0 0 0];
if peaks_total(1)<300
    peaks_total(1)=[];
end
for k=2:size(peaks_total,1)-2
    ecg=data(1,peaks_total(k)-300:peaks_total(k));
    ecg_peak=findpeaks(ecg);
    [a b]=max(ecg(ecg_peak));
    plet=data(2,peaks_total(k):peaks_total(k)+300);
    switch lower(analysis_type)
        case {'peak','default'}
            plet_peak=findpeaks(plet);
            [x y]=max(plet(plet_peak));
        case {'middle'}
            plet=moving(plet,10);
            [x y]=max(diff(plet));
            plet_peak=y;
            y=1;
        case {'foot'}
            plet_peak=findpeaks(-plet);
            [x y]=min(plet(plet_peak));
    end
    if ~isempty(ecg_peak)&& ~isempty(y)
     results(end+1,:)=[plet_peak(y)+peaks_total(k)-1 peaks_total(k) ecg_peak(b)-301+peaks_total(k) abp(peaks_total(k)) hour];
    end
      
end
results(1,:)=[];
results(:,6)=results(:,1)-results(:,3);
% [I J]=sort(results(:,4),1,'ascend');
% results=results(J,:);
plot_results(results)
figure('Name','Non-Sorted Analysis')
subplot(1,2,2);
plot(results(:,4),'b.')
xlabel('Point Number');ylabel('Systolic BP');
subplot(1,2,1);
plot(results(:,6)*8,'b.')
xlabel('Point Number');ylabel('Transit Time (ms)');
figure()
hold on
plot(data(1,:));
plot(data(2,:),'-k');
plot(data(3,:)/100,'-g');
point=get(gca,'YLim');
colors_index=repmat({'red','blue','green'},1,round(size(results,1))+1);
colors_index=colors_index(1:size(results,1));
for k=1:size(results,1)
h1=line([results(k,1) results(k,1)],[point(1) point(2)],'color',colors_index{k},'linewidth',3);
h2=line([results(k,3) results(k,3)],[point(1) point(2)],'color',colors_index{k},'linewidth',3);
h2=line([results(k,2) results(k,2)],[point(1) point(2)],'color',colors_index{k},'linewidth',3);
end
c_results=results;