function varargout = QuizMaker(varargin)
% QUIZMAKER MATLAB code for QuizMaker.fig
%      QUIZMAKER, by itself, creates a new QUIZMAKER or raises the existing
%      singleton*.
%
%      H = QUIZMAKER returns the handle to a new QUIZMAKER or the handle to
%      the existing singleton*.
%
%      QUIZMAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUIZMAKER.M with the given input arguments.
%
%      QUIZMAKER('Property','Value',...) creates a new QUIZMAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QuizMaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QuizMaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QuizMaker

% Last Modified by GUIDE v2.5 26-Apr-2018 10:15:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuizMaker_OpeningFcn, ...
                   'gui_OutputFcn',  @QuizMaker_OutputFcn, ...
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


% --- Executes just before QuizMaker is made visible.
function QuizMaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuizMaker (see VARARGIN)

% Need to have a different port for each server/client connection
handles.ServerA = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
% handles.ServerA.BytesAvailableFcn = {@BytesAvailableFcn,handles};
handles.ServerA.BytesAvailableFcn = {@BytesAvailableFcn,handles};
handles.ServerA.BytesAvailableFcnMode = 'terminator';
set(handles.IPEdit,'String','127.0.0.1');
set(handles.PortEdit,'String','10000');
set(handles.DisconnectPushbutton,'Enable','off');
set(handles.StartPushbutton,'Enable','off');
addpath('Directory');
Files = GetFileNames('Quiz*.csv');
set(handles.QuizPopup, 'String', Files );






% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QuizMaker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QuizMaker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;



function IPEdit_Callback(hObject, eventdata, handles)
% hObject    handle to IPEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IPEdit as text
%        str2double(get(hObject,'String')) returns contents of IPEdit as a double


% --- Executes during object creation, after setting all properties.
function IPEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IPEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in QuizList.
function QuizList_Callback(hObject, eventdata, handles)
% hObject    handle to QuizList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns QuizList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from QuizList


% --- Executes during object creation, after setting all properties.
function QuizList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to QuizList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function QuizPreviewEdit_Callback(hObject, eventdata, handles)
% hObject    handle to QuizPreviewEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of QuizPreviewEdit as text
%        str2double(get(hObject,'String')) returns contents of QuizPreviewEdit as a double


% --- Executes during object creation, after setting all properties.
function QuizPreviewEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to QuizPreviewEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ConnectPushbutton.
function ConnectPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

IPAddress = get(handles.IPEdit,'String');
Port = get(handles.PortEdit,'String');
handles.ClientA = tcpip(IPAddress, str2num(Port), 'NetworkRole', 'client');

switch true
    case strcmpi(handles.ServerA.Status,'open')
        fclose(handles.ServerA);
        set(handles.ConnectPushbutton,'enable','off');
        % need to come up with a slightly different way to do this in the
        % future as Matlab does not update the GUI until this thread
        % returns.
        drawnow;        
        fopen(handles.ServerA);                
        set(handles.DisconnectPushbutton,'enable','on');
        set(handles.StartPushbutton,'enable','on');
        set(handles.IPEdit,'enable','off');
        set(handles.PortEdit,'enable','off');
        
    case strcmpi(handles.ServerA.Status,'closed');
        set(handles.ConnectPushbutton,'enable','off');
        % need to come up with a slightly different way to do this in the
        % future as Matlab does not update the GUI until this thread
        % returns.
        drawnow;
        fopen(handles.ServerA);
        set(handles.DisconnectPushbutton,'enable','on');
        set(handles.StartPushbutton,'enable','on');
        set(handles.IPEdit,'enable','off');
        set(handles.PortEdit,'enable','off');        
       
    otherwise
        set(handles.ConnectPushbutton,'enable','on');
        set(handles.DisconnectPushbutton,'enable','off');
        set(handles.StartPushbutton,'enable','off');
        set(handles.IPEdit,'enable','on');
        set(handles.PortEdit,'enable','on');                

        % need more error checking here!
        msgbox('Error: Failed to start!')        
end;


% --- Executes on button press in StartPushbutton.
function StartPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StartPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Message = get(handles.QuizPreviewEdit,'String');
% contents=cellstr(get(handles.QuizPopup,'String'));
% NewContents=contents{get(handles.QuizPopup,'value')};

Message = [handles.NewContents char(10)];




fwrite(handles.ServerA,Message);


% History = cellstr(get(handles.HistoryEdit,'String'));
% NewHistory{1} = ['Server: ' Message];
% for HistoryIndex = 1 : 1 : size(History,1)
%     NewHistory{HistoryIndex + 1} = History{HistoryIndex};
% end
% 
% set(handles.HistoryEdit,'String', NewHistory); % update HistoryEdit



function PortEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PortEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PortEdit as text
%        str2double(get(hObject,'String')) returns contents of PortEdit as a double


% --- Executes during object creation, after setting all properties.
function PortEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PortEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DisconnectPushbutton.
function DisconnectPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DisconnectPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.DisconnectPushbutton,'enable','off')
fclose(handles.ServerA);
set(handles.ConnectPushbutton,'enable','on')
set(handles.StartPushbutton,'enable','off')
set(handles.IPEdit,'enable','on');
set(handles.PortEdit,'enable','on');        



% --- Executes on selection change in QuizPopup.
function QuizPopup_Callback(hObject, eventdata, handles)
% hObject    handle to QuizPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


contents = cellstr(get(hObject,'String')) 
CurrentQuiz = contents{get(hObject,'Value')}
FileID = fopen(CurrentQuiz);
Contents2 = textscan( FileID, '%s', 'delimiter', '\n' );
fclose(FileID)
NewContents = '';
for Index = 1 : 1 : length( Contents2{1}) 
    NewContents = [ NewContents ',' Contents2{1}{Index} ];
end
handles.NewContents = NewContents;
Contents = fileread( CurrentQuiz );
set(handles.QuizPreviewEdit,'string', Contents);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function QuizPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to QuizPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BytesAvailableFcn(hObject, event, handles)
Message = char(fread(handles.ServerA,handles.ServerA.BytesAvailable))';
% disp('Hello?');
disp(Message);

QuizPreview = cellstr(get(handles.QuizPreviewEdit,'String'));

% NewHistory{1} = ['Client: ' Message];
% for HistoryIndex = 1 : 1 : size(History,1)
%     NewHistory{HistoryIndex + 1} = History{HistoryIndex};
% end

set(handles.HistoryEdit,'String', QuizPreview); % update HistoryEdit


% --- Executes during object creation, after setting all properties.
function ConnectPushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConnectPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
