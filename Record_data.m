function varargout = Record_data(varargin)
% RECORD_DATA M-file for Record_data.fig
%      RECORD_DATA, by itself, creates a new RECORD_DATA or raises the existing
%      singleton*.
%
%      H = RECORD_DATA returns the handle to a new RECORD_DATA or the handle to
%      the existing singleton*.
%
%      RECORD_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORD_DATA.M with the given input arguments.
%
%      RECORD_DATA('Property','Value',...) creates a new RECORD_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Record_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Record_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Record_data

% Last Modified by GUIDE v2.5 02-Oct-2012 18:07:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Record_data_OpeningFcn, ...
                   'gui_OutputFcn',  @Record_data_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Record_data is made visible.
function Record_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Record_data (see VARARGIN)

% Choose default command line output for Record_data
handles.output = hObject;
axes(handles.axes1)
imshow('Tittle.png')
axes(handles.axes4)
imshow('EIA.png')
axes(handles.axes5)
imshow('CES.png')
axes(handles.axes6)
imshow('KIRON.png')
axes(handles.axes2)
ylabel('Amplitude (mv)');xlabel('Time (s)');
axes(handles.axes3)
ylabel('Amplitude (mv)');xlabel('Time (s)');

global s  s1  f1  f2 x x1 
s = serial('COM5'); %assigns the object s to serial port5
s1 = serial('COM1'); %assigns the object s1 to serial port1

set(s, 'InputBufferSize', 1000); %number of bytes in inout buffer
set(s, 'FlowControl', 'hardware');
set(s, 'BaudRate', 19200);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',10);

set(s1, 'InputBufferSize', 200); %number of bytes in inout buffer
set(s1, 'FlowControl', 'hardware');
set(s1, 'BaudRate', 9600);
set(s1, 'Parity', 'none');
set(s1, 'DataBits', 8);
set(s1, 'StopBit', 1);
set(s1, 'Timeout',10);

f1=(12:2:98);
f2=(13:2:99);
x=0;
x1=450;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Record_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Record_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function btnSubjectname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnSubjectname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function btnAge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnAge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function btnGender_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnGender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function btnSaturation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnSaturation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function btnPulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnStart.
function btnStart_Callback(hObject, eventdata, handles)
% hObject    handle to btnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global s  s1  f1  f2 x x1
ecg2plot=0;
plet2plot=0;
set(handles.btnStart,'UserData',0) 
fopen(s);           
fopen(s1);
while fread(s,1)~=126
    a=0;
end
a=ones(100,1)*450;
cont=0;
t=1;
n=0;
b=0;
handles.flag=0;

while(get(handles.btnStart,'UserData') ==0) 
    
    if n==7
        plet2plot=0;
        ecg2plot=0;
        axes(handles.axes2)
        cla
        axes(handles.axes3)
        cla
        n=0;
     end
  
%     if length(ecg2plot)>2066
%         ecg2plot=0;
%         cla
%     end
   
%    if length(ecg2plot)>2999
%        ecg2plot(1:100)=[];  
%    end
   if t==1 
     a(2:100) =fread(s,99);
   else
     a =fread(s,100);  
   end
   
   altos=a(f1)*256;
   c=altos+a(f2);
   ecg2plot=[ecg2plot c'];
   x1=[x1 c'];
   axes(handles.axes2)
   plot(ecg2plot);
      
   if get(s1,'BytesAvailable')> 50
      b=fread(s1,get(s1,'BytesAvailable'));
      
   if cont~=0
       b(1:8-cont)=[];
       cont=0;
   end
   aux=b==249;
   aux=find(aux);
   for i=1:length(aux)
   if aux(i)+8<length(b)
       b(aux(i):aux(i)+8)=255;
   else 
       cont=length(b)-aux(i);
       b(aux(i):end)=255;
   end
   end
   aux2=b==255;
   aux2=find(aux2);
   b(aux2)=[];
   plet2plot=[plet2plot b'];
   x=[x b'];
   axes(handles.axes3)
   plot(plet2plot);
   n=n+1;
   end
   
   if get(handles.btnSave,'UserData') ==1
        if get(s1,'BytesAvailable')>0
        b=fread(s1,get(s1,'BytesAvailable'));
        end
        if get(s,'BytesAvailable')>0
        a=fread(s,get(s,'BytesAvailable'));
        end
%         fclose(s); 
%         fclose(s1);
%         fopen(s);           
%         fopen(s1);
        x1=0;
        x=0;
        ecg2plot=0;
        ecg2plot=0;
        handles.flag=1;
        set(handles.btnSave,'UserData',0)
   end
   a=0; 
   b=0;
  t=t+1;
guidata(hObject, handles);
end
fclose(s); 
fclose(s1);
if handles.flag ==1
    assignin('base','ecg_data',x1);
    assignin('base','plet_data',x);
end
guidata(hObject, handles);

% --- Executes on button press in btnStop.
function btnStop_Callback(hObject, eventdata, handles)
% hObject    handle to btnStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.btnStart,'UserData',1);
set(handles.btnSave,'UserData',0)
guidata(hObject, handles);

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.btnSave,'UserData',1)
guidata(hObject, handles);
