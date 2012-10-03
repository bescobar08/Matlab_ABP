function [peaks_corrected]=correct_peaks(peaks_index,abp,index)
peaks_corrected=0;
for j=2:length(peaks_index)-1
    abp_portion=abp(peaks_index(j,1)-20:peaks_index(j,1)+20,index);
    aux=findpeaks(abp_portion)-1;
    if ~isempty(aux)
        if length(aux)>1
            [a1 aux]=max(abp_portion(aux));
        end
        aux=peaks_index(j)-20+aux;
        peaks_corrected(end+1)=aux;
    end
end    
peaks_corrected(1)=[];
peaks_corrected=peaks_corrected';