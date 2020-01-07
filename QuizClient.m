function varargout = QuizClient(varargin)
% QUIZCLIENT MATLAB code for QuizClient.fig
%      QUIZCLIENT, by itself, creates a new QUIZCLIENT or raises the existing
%      singleton*.
%
%      H = QUIZCLIENT returns the handle to a new QUIZCLIENT or the handle to
%      the existing singleton*.
%
%      QUIZCLIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUIZCLIENT.M with the given input arguments.
%
%      QUIZCLIENT('Property','Value',...) creates a new QUIZCLIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QuizClient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QuizClient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QuizClient

% Last Modified by GUIDE v2.5 20-Apr-2018 21:21:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuizClient_OpeningFcn, ...
                   'gui_OutputFcn',  @QuizClient_OutputFcn, ...
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


% --- Executes just before QuizClient is made visible.
function QuizClient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuizClient (see VARARGIN)

% Choose default command line output for QuizClient
handles.output = hObject;

% Need to have a different port for each server/client connection
handles.ClientA = tcpip('127.0.0.1', 10000, 'NetworkRole', 'client');
% handles.ClientA.BytesAvailableFcn = {@BytesAvailableFcn,handles};
handles.ClientA.BytesAvailableFcn = {@BytesAvailableFcn,handles};
handles.ClientA.BytesAvailableFcnMode = 'terminator';
set(handles.IPEdit,'String','127.0.0.1');
set(handles.PortEdit,'String','10000');
set(handles.DisconnectPushbutton,'Enable','off');
set(handles.SubmitPushbutton,'Enable','off');
set(handles.BackPushbutton,'Enable','off');
set(handles.NextPushbutton,'Enable','off');
set(handles.AnswerEdit,'Enable','off');
set(handles.SubmitPushbutton,'enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QuizClient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QuizClient_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function NumberEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NumberEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberEdit as text
%        str2double(get(hObject,'String')) returns contents of NumberEdit as a double


% --- Executes during object creation, after setting all properties.
function NumberEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ProblemEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ProblemEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ProblemEdit as text
%        str2double(get(hObject,'String')) returns contents of ProblemEdit as a double


% --- Executes during object creation, after setting all properties.
function ProblemEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProblemEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartPushbutton.
function StartPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StartPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Username = get(handles.UsernameEdit,'String');
if (isempty(Username) == true)
    msgbox('Error: No Username was provided!');
else
    % creates an empty file...
    FileID = fopen([Username '.csv'],'w');
    fprintf(FileID,'%s','');
    fclose(FileID);
    
    set(handles.StartPushbutton,'enable','off');
    set(handles.UsernameEdit,'enable','off');
    set(handles.SubmitPushbutton,'enable','off');
    
    set(handles.AnswerEdit,'enable','on');
    set(handles.NextPushbutton,'enable','on');
    
Number = str2num(get(handles.NumberEdit,'String'));
Username = get(handles.UsernameEdit,'String');
Question = get(handles.ProblemEdit,'String');
Answer = get(handles.AnswerEdit,'String');

end
 


% --- Executes on button press in SubmitPushbutton.
function SubmitPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SubmitPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
QuestionNumber = str2num(get(handles.NumberEdit,'string'));
Message=get(handles.StorageEdit,'string');



B = strsplit(Message(1,1:end),',')
Questions = {};
for Index = 2 : 3 : length(B)
    Count = size(Questions ,1 ) +1
    Questions{ Count,1 } = B{ Index }
    Questions{ Count,2 } = B{ Index +1 }
    Questions{ Count,3 } = B{ Index +2 }
end

% if  QuestionNumber == size(Questions,1)
%     set(handles.SubmitPushbutton,'Enable','on');
% else
%     set(handles.SubmitPushbutton,'Enable','off');
% end

Username = get(handles.UsernameEdit,'string');
% 
FileID = fopen([Username '.csv'],'r')
Contents = textscan(FileID,'%s%s%s','Delimiter',',');
fclose(FileID);
% 
Number = str2num(get(handles.NumberEdit,'String'));
Question = get(handles.ProblemEdit,'String');
Username = get(handles.UsernameEdit,'String');
Answer = get(handles.AnswerEdit,'String');

Contents{1,1}{Number} = num2str(Number);
Contents{1,2}{Number} = Question;
Contents{1,3}{Number} = Answer;




% 
FileID = fopen([Username '.csv'],'w')
for Index = 1:length(Contents{1,1})
    fprintf(FileID,'%s,%s,%s\n',char(Contents{1,1}{Index}),char(Contents{1,2}{Index}),char(Contents{1,3}{Index}))
end;
fclose(FileID);
set(handles.NextPushbutton,'enable','off');
set(handles.BackPushbutton,'enable','off');

Grade = 0;
for Index = 1 : 1 : size(Questions,1);
  A = strcmp(Contents{3}{Index},Questions{Index,3});
  if A == true
      Grade = Grade + 1;
  else
      Grade = Grade + 0 ;
  end
end
Score = round((Grade/size(Questions,1))*100);
msgbox(sprintf('Finish!!\n Score = %d out of 100',Score));


% Message = get(handles.QuizPreviewEdit,'String');
% Message = [Message char(10)];


% fwrite(handles.ServerA,Message);



function AnswerEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AnswerEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AnswerEdit as text
%        str2double(get(hObject,'String')) returns contents of AnswerEdit as a double


% --- Executes during object creation, after setting all properties.
function AnswerEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnswerEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NextPushbutton.
function NextPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NextPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Message=get(handles.StorageEdit,'string');
% Username = get(handles.UsernameEdit,'String');

Number = str2num(get(handles.NumberEdit,'String'));
Question = get(handles.ProblemEdit,'String');
Username = get(handles.UsernameEdit,'String');
Answer = get(handles.AnswerEdit,'String');

FileID = fopen([Username '.csv'],'r')
Contents = textscan(FileID,'%s%s%s','Delimiter',',');
fclose(FileID);

Contents{1,1}{Number} = num2str(Number);
Contents{1,2}{Number} = Question;
Contents{1,3}{Number} = Answer;


B = strsplit(Message(1,1:end),',')
Questions = {};
for Index = 2 : 3 : length(B)
    Count = size(Questions ,1 ) +1
    Questions{ Count,1 } = B{ Index }
    Questions{ Count,2 } = B{ Index +1 }
    Questions{ Count,3 } = B{ Index +2 }
end

QuestionNumber = str2num(get(handles.NumberEdit,'string'))+1;

set(handles.NumberEdit,'string',num2str(QuestionNumber))
set(handles.ProblemEdit,'string',Questions{QuestionNumber,2})
set(handles.HiddenEdit,'string',Questions{QuestionNumber,3})


FileID = fopen([Username '.csv'],'w')
for Index = 1:length(Contents{1,1})
    fprintf(FileID,'%s,%s,%s\n',char(Contents{1,1}{Index}),char(Contents{1,2}{Index}),char(Contents{1,3}{Index}))
end;
fclose(FileID);

Number = str2num(get(handles.NumberEdit,'String'));
if (length(Contents{1,1}) >= (Number))
    set(handles.AnswerEdit,'String',Contents{1,3}{Number})
else
    set(handles.AnswerEdit,'String','');
end;


if QuestionNumber == size(Questions,1)
    set(handles.NextPushbutton,'Enable','off');
    set(handles.SubmitPushbutton,'enable','on');
else
    set(handles.NextPushbutton,'Enable','on');
    set(handles.SubmitPushbutton,'enable','off');
end
set(handles.BackPushbutton,'Enable','on');




% --- Executes on button press in BackPushbutton.
function BackPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to BackPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Message=get(handles.StorageEdit,'string');
% Username = get(handles.UsernameEdit,'String');
Number = str2num(get(handles.NumberEdit,'String'));
Question = get(handles.ProblemEdit,'String');
Username = get(handles.UsernameEdit,'String');
Answer = get(handles.AnswerEdit,'String');

FileID = fopen([Username '.csv'],'r')
Contents = textscan(FileID,'%s%s%s','Delimiter',',');
fclose(FileID);



B = strsplit(Message(1,1:end),',')
Questions = {};
for Index = 2 : 3 : length(B)
    Count = size(Questions ,1 ) +1
    Questions{ Count,1 } = B{ Index }
    Questions{ Count,2 } = B{ Index +1 }
    Questions{ Count,3 } = B{ Index +2 }
end


Contents{1,1}{Number} = num2str(Number);
Contents{1,2}{Number} = Question;
Contents{1,3}{Number} = Answer;

FileID = fopen([Username '.csv'],'w')
for Index = 1:length(Contents{1,1})
    fprintf(FileID,'%s,%s,%s\n',char(Contents{1,1}{Index}),char(Contents{1,2}{Index}),char(Contents{1,3}{Index}))
end;
fclose(FileID);

QuestionNumber = str2num(get(handles.NumberEdit,'string'))-1;

set(handles.NumberEdit,'string',num2str(QuestionNumber))
set(handles.ProblemEdit,'string',Questions{QuestionNumber,2})
set(handles.HiddenEdit,'string',Questions{QuestionNumber,3})

Number = str2num(get(handles.NumberEdit,'String'));
if (length(Contents{1,1}) >= (Number))
    set(handles.AnswerEdit,'String',Contents{1,3}{Number})
else
    set(handles.AnswerEdit,'String','');
end;

 

if QuestionNumber == 1
    set(handles.BackPushbutton,'Enable','off');
else
    set(handles.BackPushbutton,'Enable','on');
end
set(handles.NextPushbutton,'Enable','on');
set(handles.SubmitPushbutton,'enable','off');







function UsernameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to UsernameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UsernameEdit as text
%        str2double(get(hObject,'String')) returns contents of UsernameEdit as a double


% --- Executes during object creation, after setting all properties.
function UsernameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UsernameEdit (see GCBO)
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
handles.Client = tcpip(IPAddress, str2num(Port), 'NetworkRole', 'server');

switch true
    case strcmpi(handles.ClientA.Status,'open')
        fclose(handles.ClientA);
        set(handles.ConnectPushbutton,'enable','off');
        % need to come up with a slightly different way to do this in the
        % future as Matlab does not update the GUI until this thread
        % returns.
        drawnow;        
        fopen(handles.ClientA);        
        set(handles.DisconnectPushbutton,'enable','on');
        set(handles.SubmitPushbutton,'enable','off');
        set(handles.IPEdit,'enable','off');
        set(handles.PortEdit,'enable','off');        
        
    case strcmpi(handles.ClientA.Status,'closed');
        set(handles.ConnectPushbutton,'enable','off');
        % need to come up with a slightly different way to do this in the
        % future as Matlab does not update the GUI until this thread
        % returns.
        drawnow;
        fopen(handles.ClientA);
        set(handles.DisconnectPushbutton,'enable','on');
        set(handles.SubmitPushbutton,'enable','on');
        set(handles.IPEdit,'enable','off');
        set(handles.PortEdit,'enable','off');        
        
    otherwise
        set(handles.ConnectPushbutton,'enable','on');
        set(handles.DisconnectPushbutton,'enable','off');
        set(handles.SubmitPushbutton,'enable','off');
        set(handles.IPEdit,'enable','on');
        set(handles.PortEdit,'enable','on');        
             
        % need more error checking here!
        msgbox('Error: Failed to start!')        
end;



% --- Executes on button press in DisconnectPushbutton.
function DisconnectPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DisconnectPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.DisconnectPushbutton,'enable','off')
fclose(handles.ClientA);
set(handles.ConnectPushbutton,'enable','on')
set(handles.SubmitPushbutton,'enable','off')
set(handles.IPEdit,'enable','on');
set(handles.PortEdit,'enable','on');        
set(handles.StorageEdit,'string','');




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

function BytesAvailableFcn(hObject, event, handles)
Message = char(fread(handles.ClientA,handles.ClientA.BytesAvailable))';
% disp('Hello?');
% disp(Message);

% QuizPreview = cellstr(get(handles.QuizPreviewEdit,'String'));

% NewHistory{1} = ['Client: ' Message];
% for HistoryIndex = 1 : 1 : size(History,1)
%     NewHistory{HistoryIndex + 1} = History{HistoryIndex};
% end
set(handles.StorageEdit,'string',Message);
B = strsplit(Message,',')
Questions = {};
for Index = 2 : 3 : length(B)
    Count = size(Questions ,1 ) +1
    Questions{ Count,1 } = B{ Index }
    Questions{ Count,2 } = B{ Index +1 }
    Questions{ Count,3 } = B{ Index +2 }
end
set(handles.NumberEdit,'string', Questions{1,1})
set(handles.ProblemEdit,'string',Questions{1,2})
set(handles.HiddenEdit,'String', Questions{1,3}); % update HistoryEdit


function HiddenEdit_Callback(hObject, eventdata, handles)
% hObject    handle to HiddenEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HiddenEdit as text
%        str2double(get(hObject,'String')) returns contents of HiddenEdit as a double


% --- Executes during object creation, after setting all properties.
function HiddenEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HiddenEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StorageEdit_Callback(hObject, eventdata, handles)
% hObject    handle to StorageEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StorageEdit as text
%        str2double(get(hObject,'String')) returns contents of StorageEdit as a double


% --- Executes during object creation, after setting all properties.
function StorageEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StorageEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
