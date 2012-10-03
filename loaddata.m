initialdirectory=pwd;
subjectdirectory=uigetdir;
if subjectdirectory==0
   subjectdirectory=initialdirectory;       %%%%%%%%% folder selection %%%%%%%%%%%%%%% 
   return
end
cd(subjectdirectory);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basicinfo=importdata(cat(2,subjectdirectory,'\info\info.txt'));     %%%%%%%% info of files/trials %%%%%
alltrials=ls;
alltrials=alltrials(3:size(alltrials,1),:);     %%%%% remove the garbage %%%%
for i=size(alltrials,1):-1:1
    if isdir(alltrials(i,:))== 1   %%%%%%%% remove the folders and retain only the .mat files %%%
         alltrials(i,:)=[];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=zeros(3,450000,size(alltrials,1));
h_wait = waitbar(0,'Please wait...',...
         'Position',[250,320,270,50]);                %%%%%% create the wait bar
         
for k=1:size(alltrials,1)
    if ishandle(h_wait)
       waitbar(k/size(alltrials,1),h_wait)
    else               
       break
    end
    hdata = importdata(alltrials(k,:));    %%% import data from the corresponding rows %%%
    data(1,:,k)=(hdata(basicinfo.data(1,1),:)-basicinfo.data(2,1))/basicinfo.data(3,1);  %%%ECG (II lead)
    data(2,:,k)=(hdata(basicinfo.data(1,2),:)-basicinfo.data(2,2))/basicinfo.data(3,2);  %%%PLET
    data(3,:,k)=(hdata(basicinfo.data(1,3),:)-basicinfo.data(2,3))/basicinfo.data(3,3);  %%%ABP (arterial blood pressure)
end
if ishandle(h_wait)        
   delete(h_wait)
end
cd(initialdirectory)
clear basicinfo h_wait hdata initialdirectory i k prompt subjectdirectory alltrials