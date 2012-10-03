function [results]=datapeaks(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%% Input Arguments %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  1.data: 3 Dim matrix. (signals X time) X hour_index                %%%
%%%  2.n_points: Number of points per set of Blood Presure              %%%
%%%  3.n_sets: Number of intervals between Max(abp) & Min (Threshold )  %%%
%%%  4.thershold: Minimun value for ABP                                 %%%
%%%  5. data_edited2: Results from Edit_data. Data points excluded from %%%
%%%                  analysis.                                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=varargin{1};
n_points=varargin{2};
n_sets=varargin{3};
threshold=varargin{4};
if size(varargin,2)==5
    data_edited2=varargin{5};
end
if size(varargin,2)==6
    analysis_type=varargin{6};
else
    analysis_type='default';
end
abp(:,:)=data(3,:,:);
% abp=moving(abp,4);
s_abp=moving(abp,30);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
for j=1:size(s_abp,2)
    peaks_index=findpeaks(s_abp(:,j))-1;
    if size(varargin,2)==5
        if ~isempty(data_edited2{j})
             for k=1:size(data_edited2{j},1)
                 data2delete= find(peaks_index>data_edited2{j}(k,1)...
                 & peaks_index<data_edited2{j}(k,2));
                 peaks_index(data2delete)=[];
             end
        end
    end
    [peaks_corrected]=correct_peaks(peaks_index,abp,j);
    hour_index=ones(size(peaks_corrected,1),1)*j;
    peaks_value=abp(peaks_corrected,j);
    peaks=[peaks_corrected peaks_value hour_index];
    if j==1
       peaks_total=peaks;
    else
        peaks_total=cat(1,peaks_total,peaks);
    end
end
sorted_peaks=sort(peaks_total(:,2),1,'descend');
interval_max=mean(sorted_peaks(1:round(size(peaks_total,1)*0.001),1)); 
interval= interval_max -threshold; 
increment=(threshold:interval/n_sets:interval_max);
%%
output=0;
for k=1:n_sets
    n_intervals=find(peaks_total(:,2)>increment(k) & peaks_total(:,2)...
        <increment(k+1));
    if  length(n_intervals)<n_points
        output=cat(1,output,n_intervals);
    else
        permutations=randperm(length(n_intervals));
        output=cat(1,output,n_intervals(permutations(1:n_points)));
    end
end
output(1)=[];
selected_points=peaks_total(output,:);
points=selected_points;
%% 
results=[0 0 0 0 0];
for k=1:size(points,1)
    ecg=data(1,points(k,1)-200:points(k,1),points(k,3));
    ecg_peak=findpeaks(ecg);
    [a b]=max(ecg(ecg_peak));
    plet=data(2,points(k,1):points(k,1)+150,points(k,3));
%     plet=moving(plet,4);
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
     results(end+1,:)=[plet_peak(y)+points(k,1)-1 points(k,1) ecg_peak(b)-201+points(k,1) points(k,2) points(k,3)];
    end
      
end
results(1,:)=[];
%%
[I J]=sort(results(:,4),1,'ascend');
results=results(J,:);
plot_results(results)
assignin('base','peaks_total',peaks_total);
assignin('base','increment',increment);
assignin('base','analysis_type',analysis_type);
