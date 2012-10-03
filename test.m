signal=data(1,3000:3999,12);
% clear data
wn      = 10/(125/2);
[a,b]    = butter(4,wn,'low');
signal=filtfilt(a,b,signal);
imf = emd(signal);
t=(0:0.008:7.992);
for k=1:length(imf)
    imf1(:,k)=imf{k};
end
imf=imf1;
Ts=0.008;
idx = 1:size(imf,1);
h = hilbert([imf-repmat(mean(imf),size(imf,1),1);zeros(size(imf))]);
h = h(idx,:);
amp   = abs(h);
phase = unwrap(angle(h));
omega = abs(diff(phase))/(2*pi*(Ts*1000)/(length(t)-1));
omega = [omega(1,:); omega];
sig = real((sum(amp.*exp(1i*phase),2)));

% for k = 1:length(imf)
%    x(k,:) = imf{k}.*imf{k};
%    aux=hilbert(imf{k});
%    y(k,:)=imag(aux).^2;
%    c(k,:)=sqrt(x(k,:)+y(k,:));
%    th   = angle(aux);
%    d{k} = diff(th)/Ts/(2*pi);
%    w(k,:)=simpsons(d{k},1,length(imf));
%    sol(k,:)=real(c(k,:)*exp(1i*w(k,:)));
%    figure(k); plot(sol(k,:));
% end
% total=sum(sol,1);

