function [peaks_corrected]=correct_peaks_c(peaks_index,abp)
peaks_corrected=0;
for j=2:length(peaks_index)-1
    abp_portion=abp(peaks_index(j)-20:peaks_index(j)+20);
    aux=findpeaks(abp_portion)-1;
    if ~isempty(aux)
        if length(aux)>1
            [a1 b1]=max(abp_portion(aux));
        else
            b1=1;
        end
        aux=peaks_index(j)-20+aux(b1);
        peaks_corrected(end+1)=aux;
    end
end    
peaks_corrected(1)=[];
peaks_corrected=peaks_corrected';