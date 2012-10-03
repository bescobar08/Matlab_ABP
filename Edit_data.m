function varargout = Edit_data(varargin)
% EDIT_DATA M-file for Edit_data.fig
%      EDIT_DATA, by itself, creates a new EDIT_DATA or raises the existing
%      singleton*.
%
%      H = EDIT_DATA returns the handle to a new EDIT_DATA or the handle to
%      the existing singleton*.
%
%      EDIT_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_DATA.M with the given input arguments.
%
%      EDIT_DATA('Property','Value',...) creates a new EDIT_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Edit_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Edit_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Edit_data

% Last Modified by GUIDE v2.5 01-Sep-2012 17:29:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Edit_data_OpeningFcn, ...
                   'gui_OutputFcn',  @Edit_data_OutputFcn, ...
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


% --- Executes just before Edit_data is made visible.
function Edit_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Edit_data (see VARARGIN)

% Choose default command line output for Edit_data
handles.output = hObject;
handles.cont=1;
handles.plotnum=3;
handles.nedits=1;
handles.data=evalin('base','data');
%handles.data2edit=evalin('base','data_edited');
handles.data2edit=cell(1,size(handles.data,3));
axes(handles.axes1)
plot(handles.data(3,:,1));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Edit_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Edit_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnsave.
function btnsave_Callback(hObject, eventdata, handles)
% hObject    handle to btnsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);


% --- Executes on button press in btnedit.
function btnedit_Callback(hObject, eventdata, handles)
% hObject    handle to btnedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)
point=get(handles.axes1,'YLim');
[x1 y1]=ginput(1);
h1=line([x1 x1],[point(1) point(2)],'color','red','linewidth',3);
[x2 y2]=ginput(1);
h2=line([x2 x2],[point(1) point(2)],'color','red','linewidth',3);
handles.data2edit{handles.cont}(end+1,:)=[x1 x2];
assignin('base','data_edited',handles.data2edit);
guidata(hObject, handles);


% --- Executes on button press in btnback.
function btnback_Callback(hObject, eventdata, handles)
% hObject    handle to btnback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cont=handles.cont-1;
axes(handles.axes1)
plot(handles.data(handles.plotnum,:,handles.cont));
set(handles.txtnum,'string',handles.cont);

if ~isempty(handles.data2edit{handles.cont})
    point=get(handles.axes1,'YLim');
    for k=1:size(handles.data2edit{handles.cont},1)
        linename=line([handles.data2edit{handles.cont}(k,1) handles.data2edit{handles.cont}(k,1)],...
        [point(1) point(2)],'color','red','linewidth',3);
        linename2=line([handles.data2edit{handles.cont}(k,2) handles.data2edit{handles.cont}(k,2)],...
        [point(1) point(2)],'color','red','linewidth',3);
    end
end

if handles.cont==1
    set(handles.btnback,'enable','off')
    set(handles.btnnext,'enable','on')
else
    set(handles.btnback,'enable','on')
    set(handles.btnnext,'enable','on')
end
guidata(hObject, handles);

% --- Executes on button press in btnnext.
function btnnext_Callback(hObject, eventdata, handles)
% hObject    handle to btnnext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cont=handles.cont+1;
axes(handles.axes1)
set(handles.txtnum,'string',handles.cont);
plot(handles.data(handles.plotnum,:,handles.cont));

if ~isempty(handles.data2edit{handles.cont})
    point=get(handles.axes1,'YLim');
    for k=1:size(handles.data2edit{handles.cont},1)
        linename=line([handles.data2edit{handles.cont}(k,1) handles.data2edit{handles.cont}(k,1)],...
        [point(1) point(2)],'color','red','linewidth',3);
        linename2=line([handles.data2edit{handles.cont}(k,2) handles.data2edit{handles.cont}(k,2)],...
        [point(1) point(2)],'color','red','linewidth',3);
    end
end

if handles.cont==size(handles.data,3)
    set(handles.btnnext,'enable','off')
    set(handles.btnback,'enable','on')
else
    set(handles.btnnext,'enable','on')
    set(handles.btnback,'enable','on')
end
guidata(hObject, handles);


% --- Executes on button press in btndelete.
function btndelete_Callback(hObject, eventdata, handles)
% hObject    handle to btndelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data2edit{handles.cont}(:,:)=[];
axes(handles.axes1)
plot(handles.data(3,:,handles.cont));
assignin('base','data_edited',handles.data2edit);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function txtnum_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnecg.
function btnecg_Callback(hObject, eventdata, handles)
% hObject    handle to btnecg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btnecg
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.btnbp,'Value',0);
    set(handles.btnplet,'Value',0);
    handles.plotnum=1;
end
    guidata(hObject, handles);

% --- Executes on button press in btnplet.
function btnplet_Callback(hObject, eventdata, handles)
% hObject    handle to btnplet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btnplet
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.btnecg,'Value',0);
    set(handles.btnbp,'Value',0);
    handles.plotnum=2;
end
    guidata(hObject, handles);

% --- Executes on button press in btnbp.
function btnbp_Callback(hObject, eventdata, handles)
% hObject    handle to btnbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btnbp
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.btnecg,'Value',0);
    set(handles.btnplet,'Value',0);
    handles.plotnum=3;
end
    guidata(hObject, handles);
