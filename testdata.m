function varargout = testdata(varargin)
% TESTDATA M-file for testdata.fig
%      TESTDATA, by itself, creates a new TESTDATA or raises the existing
%      singleton*.
%
%      H = TESTDATA returns the handle to a new TESTDATA or the handle to
%      the existing singleton*.
%
%      TESTDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTDATA.M with the given input arguments.
%
%      TESTDATA('Property','Value',...) creates a new TESTDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testdata_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testdata_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testdata

% Last Modified by GUIDE v2.5 01-Sep-2012 19:35:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testdata_OpeningFcn, ...
                   'gui_OutputFcn',  @testdata_OutputFcn, ...
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


% --- Executes just before testdata is made visible.
function testdata_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testdata (see VARARGIN)

% Choose default command line output for testdata
handles.output = hObject;
handles.cont=1;
handles.zoomscale=500;
handles.data=evalin('base','data');
handles.results=evalin('base','results');
handles.peaks_total=evalin('base','peaks_total');
handles.increment=evalin('base','increment');
handles.analysis_type=evalin('base','analysis_type');
axes(handles.axes1)
if handles.results(1,2)>handles.zoomscale
    intervalmin=handles.results(1,2)-handles.zoomscale;
else
    intervalmin=1;
end
if handles.results(1,2)+handles.zoomscale<600000
    intervalmax=handles.results(1,2)+handles.zoomscale;
else
    intervalmax=600000;
end
interval=(intervalmin:intervalmax);
hold on
plot(interval,handles.data(1,interval,handles.results(1,5)));
plot(interval,handles.data(2,interval,handles.results(1,5)),'-k');
plot(interval,handles.data(3,interval,handles.results(1,5))/100,'-g');
point=get(handles.axes1,'YLim');
h1=line([handles.results(1,1) handles.results(1,1)],[point(1) point(2)],'color','red','linewidth',3);
h2=line([handles.results(1,3) handles.results(1,3)],[point(1) point(2)],'color','red','linewidth',3);
set(handles.txtbp,'string',handles.results(1,4));
set(handles.txttrial,'string',handles.results(1,5));
set(handles.txttt,'string',(handles.results(1,1)-handles.results(1,3))*2);
set(handles.txtnum,'string',handles.cont);
hold off
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testdata wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testdata_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnnext.
function btnnext_Callback(hObject, eventdata, handles)
% hObject    handle to btnnext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cont=handles.cont+1;
k=handles.cont;
axes(handles.axes1)
if handles.results(k,2)>handles.zoomscale
    intervalmin=handles.results(k,2)-handles.zoomscale;
else
    intervalmin=1;
end
if handles.results(k,2)+handles.zoomscale<600000
    intervalmax=handles.results(k,2)+handles.zoomscale;
else
    intervalmax=600000;
end
interval=(intervalmin:intervalmax);
plot(interval,handles.data(1,interval,handles.results(k,5)));
hold on
plot(interval,handles.data(2,interval,handles.results(k,5)),'-k');
plot(interval,handles.data(3,interval,handles.results(k,5))/100,'-g');
point=get(handles.axes1,'YLim');
h1=line([handles.results(k,1) handles.results(k,1)],[point(1) point(2)],'color','red','linewidth',3);
h2=line([handles.results(k,3) handles.results(k,3)],[point(1) point(2)],'color','red','linewidth',3);
set(handles.txtbp,'string',handles.results(k,4));
set(handles.txttrial,'string',handles.results(k,5));
set(handles.txttt,'string',((handles.results(k,1)-handles.results(k,3)))*2);
set(handles.txtnum,'string',handles.cont);
hold off
if handles.cont==size(handles.results,1)
    set(handles.btnnext,'enable','off')
    set(handles.btnback,'enable','on')
else
    set(handles.btnnext,'enable','on')
    set(handles.btnback,'enable','on')
end
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in btnback.
function btnback_Callback(hObject, eventdata, handles)
% hObject    handle to btnback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cont=handles.cont-1;
k=handles.cont;
axes(handles.axes1)
if handles.results(k,2)>handles.zoomscale
    intervalmin=handles.results(k,2)-handles.zoomscale;
else
    intervalmin=1;
end
if handles.results(k,2)+handles.zoomscale<600000
    intervalmax=handles.results(k,2)+handles.zoomscale;
else
    intervalmax=600000;
end
interval=(intervalmin:intervalmax);
plot(interval,handles.data(1,interval,handles.results(k,5)));
hold on
plot(interval,handles.data(2,interval,handles.results(k,5)),'-k');
plot(interval,handles.data(3,interval,handles.results(k,5))/100,'-g');
point=get(handles.axes1,'YLim');
h1=line([handles.results(k,1) handles.results(k,1)],[point(1) point(2)],'color','red','linewidth',3);
h2=line([handles.results(k,3) handles.results(k,3)],[point(1) point(2)],'color','red','linewidth',3);
set(handles.txtbp,'string',handles.results(k,4));
set(handles.txttrial,'string',handles.results(k,5));
set(handles.txttt,'string',((handles.results(k,1)-handles.results(k,3)))*2);
set(handles.txtnum,'string',handles.cont);
hold off
if handles.cont==1
    set(handles.btnback,'enable','off')
    set(handles.btnnext,'enable','on')
else
    set(handles.btnback,'enable','on')
    set(handles.btnnext,'enable','on')
end
% Update handles structure
guidata(hObject, handles);

function txtbp_Callback(hObject, eventdata, handles)
% hObject    handle to txtbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtbp as text
%        str2double(get(hObject,'String')) returns contents of txtbp as a double


% --- Executes during object creation, after setting all properties.
function txtbp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txttrial_Callback(hObject, eventdata, handles)
% hObject    handle to txttrial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txttrial as text
%        str2double(get(hObject,'String')) returns contents of txttrial as a double

% --- Executes during object creation, after setting all properties.
function txttrial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txttrial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txttt_Callback(hObject, eventdata, handles)
% hObject    handle to txttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txttt as text
%        str2double(get(hObject,'String')) returns contents of txttt as a double


% --- Executes during object creation, after setting all properties.
function txttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtnum_Callback(hObject, eventdata, handles)
% hObject    handle to txtnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtnum as text
%        str2double(get(hObject,'String')) returns contents of txtnum as a double


% --- Executes during object creation, after setting all properties.
function txtnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnsave.
function btnsave_Callback(hObject, eventdata, handles)
% hObject    handle to btnsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.results(str2double(get(handles.txtnum,'string')),:)=handles.new_point;
guidata(hObject, handles);

% --- Executes on button press in btnchange.
function btnchange_Callback(hObject, eventdata, handles)
% hObject    handle to btnchange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
peaks_total=handles.peaks_total;
increment=handles.increment;
sbp=handles.results(handles.cont,4);
k=find(increment>sbp);
k=k(1)-1;
n_interval=find(peaks_total(:,2)>increment(k) & peaks_total(:,2)<increment(k+1));
permutations=randperm(length(n_interval));
new_point=permutations(1);
new_point=peaks_total(n_interval(new_point),:);
ecg=handles.data(1,new_point(1,1)-400:new_point(1,1),new_point(1,3));
ecg_peak=findpeaks(ecg);
[a b]=max(ecg(ecg_peak));
plet=handles.data(2,new_point(1,1):new_point(1,1)+240,new_point(1,3));
plet=moving(plet,4);
switch lower(handles.analysis_type)
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
     axes(handles.axes1)
    if new_point(1,1)>handles.zoomscale
        intervalmin= new_point(1,1)-handles.zoomscale;
    else
        intervalmin=1;
    end
    if new_point(1,1)+handles.zoomscale<600000
       intervalmax=new_point(1,1)+handles.zoomscale;
    else
        intervalmax=600000;
    end
interval=(intervalmin:intervalmax);
plot(interval,handles.data(1,interval,new_point(1,3)));
hold on
plot(interval,handles.data(2,interval,new_point(1,3)),'-k');
plot(interval,handles.data(3,interval,new_point(1,3))/100,'-g');
point=get(handles.axes1,'YLim');
h1=line([ecg_peak(b)+new_point(1,1)-101 ecg_peak(b)+new_point(1,1)-101],...
    [point(1) point(2)],'color','red','linewidth',3);
h2=line([plet_peak(y)+new_point(1,1) plet_peak(y)+new_point(1,1)],...
    [point(1) point(2)],'color','red','linewidth',3);
set(handles.txtbp,'string',new_point(1,2));
set(handles.txttrial,'string',new_point(1,3));
set(handles.txttt,'string',((plet_peak(y)+new_point(1,1))-(ecg_peak(b)+new_point(1,1)-101))*2);
set(handles.txtnum,'string',handles.cont);
hold off
end
handles.new_point=[plet_peak(y)+new_point(1,1) new_point(1,1)...
    ecg_peak(b)-401+new_point(1,1) new_point(1,2) new_point(1,3)];
guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
assignin('base','new_results',handles.results);
delete(hObject);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.zoomscale=get(hObject,'Value');
set(handles.txtzoom,'string',handles.zoomscale);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function txtzoom_Callback(hObject, eventdata, handles)
% hObject    handle to txtzoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtzoom as text
%        str2double(get(hObject,'String')) returns contents of txtzoom as a double


% --- Executes during object creation, after setting all properties.
function txtzoom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtzoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
