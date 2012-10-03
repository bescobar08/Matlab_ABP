function varargout = show_results(varargin)
% SHOW_RESULTS M-file for show_results.fig
%      SHOW_RESULTS, by itself, creates a new SHOW_RESULTS or raises the existing
%      singleton*.
%
%      H = SHOW_RESULTS returns the handle to a new SHOW_RESULTS or the handle to
%      the existing singleton*.
%
%      SHOW_RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_RESULTS.M with the given input arguments.
%
%      SHOW_RESULTS('Property','Value',...) creates a new SHOW_RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show_results

% Last Modified by GUIDE v2.5 04-Sep-2012 23:12:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @show_results_OpeningFcn, ...
                   'gui_OutputFcn',  @show_results_OutputFcn, ...
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


% --- Executes just before show_results is made visible.
function show_results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to show_results (see VARARGIN)

% Choose default command line output for show_results
handles.output = hObject;
handles.initialdirectory=pwd;
handles.cont=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes show_results wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = show_results_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnback.
function btnback_Callback(hObject, eventdata, handles)
% hObject    handle to btnback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cont=handles.cont-1;
if isdir(strcat('results',num2str(handles.cont)))
cd(strcat(handles.initialdirectory,'/',strcat('results',num2str(handles.cont))))
data2plot=importdata('all_results.mat');
results=data2plot.new_results;
cd(handles.initialdirectory);
[I J]=sort(results(:,4),1,'ascend');
results=results(J,:);
t_t=[results(:,4) results(:,1)-results(:,3)];
[x y]=sort(t_t(:,1),1,'descend');
f=[x t_t(y,2)];
axes(handles.axes1)
plot(f(:,1),f(:,2)*8,'b.');
ylabel('Transit Time (ms)');xlabel('Systolic BP');
axes(handles.axes2)
plot(sort(results(:,4),1,'ascend'),'b.');
xlabel('Number of points');ylabel('Systolic BP');
set(handles.txtsubject,'string',strcat('Subject ',' ',num2str(handles.cont)))
end
guidata(hObject, handles);

% --- Executes on button press in btnnext.
function btnnext_Callback(hObject, eventdata, handles)
% hObject    handle to btnnext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cont=handles.cont+1;
if isdir(strcat('results',num2str(handles.cont)))
cd(strcat(handles.initialdirectory,'/',strcat('results',num2str(handles.cont))))
data2plot=importdata('all_results.mat');
results=data2plot.new_results;
cd(handles.initialdirectory);
[I J]=sort(results(:,4),1,'ascend');
results=results(J,:);
t_t=[results(:,4) results(:,1)-results(:,3)];
[x y]=sort(t_t(:,1),1,'descend');
f=[x t_t(y,2)];
axes(handles.axes1)
plot(f(:,1),f(:,2)*8,'b.');
ylabel('Transit Time (ms)');xlabel('Systolic BP');
axes(handles.axes2)
plot(sort(results(:,4),1,'ascend'),'b.');
xlabel('Number of points');ylabel('Systolic BP');
set(handles.txtsubject,'string',strcat('Subject ',' ',num2str(handles.cont)))
end
guidata(hObject, handles);



function txtsubject_Callback(hObject, eventdata, handles)
% hObject    handle to txtsubject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtsubject as text
%        str2double(get(hObject,'String')) returns contents of txtsubject as a double


% --- Executes during object creation, after setting all properties.
function txtsubject_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtsubject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
