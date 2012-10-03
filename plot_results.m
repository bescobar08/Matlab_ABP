function plot_results(results)
[I J]=sort(results(:,4),1,'ascend');
results=results(J,:);
t_t=[results(:,4) results(:,1)-results(:,3)];
[x y]=sort(t_t(:,1),1,'descend');
f=[x t_t(y,2)];
figure('Name','Sorted Analysis')
subplot(1,2,1)
plot(f(:,1),f(:,2)*2,'b.');
ylabel('Transit Time (ms)');xlabel('Systolic BP');
subplot(1,2,2)
plot(sort(results(:,4),1,'ascend'),'b.');
xlabel('Number of points');ylabel('Systolic BP');


