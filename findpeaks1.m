function n = findpeaks1(x)
% Find peaks.
% n = findpeaks(x)

n    = diff(x,1,1) > 0;
n1   = find(diff(n',1,1)<0);
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;