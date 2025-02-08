{ Summary
  This unit contains the event class definitions required to use custom controls in the TJSEditDialog
  wrapper functions that are declared in the JSDialogs unit.                                          }
unit JSEditEvents;

interface

{$I lmddlgcmps.inc}

uses
    JSEditDialog
  , Classes
  , Controls
  , ComCtrls
  , StdCtrls
  , JSTypes
  ;

const
  { Summary
    Index value used to specify that no Index has been selected in the dialog } 
  JSED_IGNORE_INDEX = -2;
  
type
  { Summary
    Base class for all event classes
    Description
    Base class that all event classes must descend from.
    Descendants must override the virtual methods that implement custom processing. }
  TJSEditEvents = class
  public
    { Summary
      Override to specify the edit control class that this event supports. }
    procedure GetEditControlClass(Sender: TObject; const Index: Integer; var ControlClass: TControlClass); virtual;
    { Summary
      Override to specify the edit value the edit control returns. }
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); virtual;
    { Summary
      Override to initialise specific properties on the edit control. }
    procedure InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer); virtual;
    { Summary
      Override to specify the initial value of the edit control. }
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); virtual;
    { Summary
      Override to specify the height of the edit control. }
    procedure GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Height: Integer); virtual;
  end;

  { Summary
    TJSEditEventClass defines the metaclass for TJSDialog.
    Description
    TJSEditEventClass is the metaclass for TJSEditEvent. Its value is the class reference for
    TJSEditEventClass or for one of its descendants.                                          }
  TJSEditEventClass = class of TJSEditEvents;

  { Summary
    Event class for use with the etMemo edit type.
    Description
    Event class for use with the etMemo edit type. }
  TJSMemoEvents = class(TJSEditEvents)
  public
    procedure GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Height: Integer); override;
  end;

  { Summary
    Event class for use with the etCombobox edit type.
    Description
    Event class for use with the etCombobox edit type. }
  TJSComboEvents = class(TJSEditEvents)
  protected
    FFixedList: Boolean;
    FSelectedIndex: Integer;
  public
    constructor Create(const AFixedList: Boolean; const ASelectedIndex: Integer); reintroduce; virtual;
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); override;
    procedure InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer); override;
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); override;
    { Summary
      Specifies the SelectedIndex value of the edit control. }
    property SelectedIndex: Integer read FSelectedIndex;
  end;

  { Summary
    TJSComboEventClass defines the metaclass for TJSComboEvent.
    Description
    TJSComboEventClass is the metaclass for TJSComboEvent. Its value is the class reference for
    TJSComboEvent or for one of its descendants.                                                }
  TJSComboEventClass = class of TJSComboEvents;

  { Summary
    Event class for use with the etListBox edit type.
    Description
    Event class for use with the etListBox edit type. }
  TJSListEvents = class(TJSEditEvents)
  protected
    FSelectedIndex: Integer;
    FIgnoreIndex: Boolean;
  public
    constructor Create(const ASelectedIndex: Integer); reintroduce; virtual;
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); override;
    procedure InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer); override;
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); override;
    procedure GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Height: Integer); override;
    { Summary
      Specifies the SelectedIndex value of the edit control. }
    property SelectedIndex: Integer read FSelectedIndex;
  end;

  { Summary
    TJSListEventClass defines the metaclass for TJSListEvent.
    Description
    TJSListEventClass is the metaclass for TJSListEvent. Its value is the class reference for TJSListEvent
    or for one of its descendants.                                                                         }
  TJSListEventClass = class of TJSListEvents;

  { Summary
    Event class for use with the etDate edit type.
    Description
    Event class for use with the etDate edit type. }
  TJSDateEvents = class(TJSEditEvents)
  public
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); override;
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); override;
  end;

  { Summary
    Event class for use with the etTime edit type.
    Description
    Event class for use with the etTime edit type. }
  TJSTimeEvents = class(TJSEditEvents)
  public
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); override;
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); override;
  end;

  { Summary
    Event class for use with the etCalendar edit type.
    Description
    Event class for use with the etCalendar edit type. }
  TJSCalendarEvents = class(TJSEditEvents)
  public
    procedure GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString); override;
    procedure SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString); override;
  end;

{ Summary
  Register event classes.
  Description
  Use this method to register your own event class to be used when a specific wrapper function is called. }
procedure RegisterEventClass(const AEditType: TJSEditType; AEventClass: TJSEditEventClass);
{ Summary
  Returns the event class for the edit type.
  Description
  Returns the event class for the edit type. }
function GetEventClass(const AEditType: TJSEditType): TJSEditEventClass;

implementation

uses
    SysUtils
  ;

type
  TJSRegisteredEvents = class
  private
    FEvents: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEvent(const AEditType: TJSEditType): TJSEditEventClass;
    procedure SetEvent(const AEditType: TJSEditType; AEventClass: TJSEditEventClass);
  end;

var
  FEditEvents: TJSRegisteredEvents;

procedure RegisterEventClass(const AEditType: TJSEditType; AEventClass: TJSEditEventClass);
begin
  FEditEvents.SetEvent(AEditType, AEventClass);
end;

function GetEventClass(const AEditType: TJSEditType): TJSEditEventClass;
begin
  result := FEditEvents.GetEvent(AEditType);
end;

{ TJSRegisteredEvents }

constructor TJSRegisteredEvents.Create;
begin
  FEvents := TList.Create;
  FEvents.Add(TJSEditEvents); // etNone
  FEvents.Add(TJSEditEvents); // etEdit
  FEvents.Add(TJSMemoEvents); // etMemo
  FEvents.Add(TJSComboEvents); // etComboBox
  FEvents.Add(TJSListEvents); // etListBox
  FEvents.Add(TJSDateEvents); // etDate
  FEvents.Add(TJSTimeEvents); // etTime
  FEvents.Add(TJSCalendarEvents); // etCalendar
  FEvents.Add(TJSEditEvents); // etCustom
  FEvents.Add(nil); // etCheckListBox
  FEvents.Add(nil); // etRTF
  FEvents.Add(nil); // etHTML
  FEvents.Add(TJSComboEvents); // etEditComboBox
end;

destructor TJSRegisteredEvents.Destroy;
begin
  FEvents.Free;
  inherited;
end;

function TJSRegisteredEvents.GetEvent(const AEditType: TJSEditType): TJSEditEventClass;
begin
  if ord(AEditType) > FEvents.Count	- 1 then
    result := TJSEditEvents
  else
    result := TJSEditEventClass(FEvents[ord(AEditType)]);
end;

procedure TJSRegisteredEvents.SetEvent(const AEditType: TJSEditType; AEventClass: TJSEditEventClass);
begin
  FEvents[ord(AEditType)] := AEventClass;
end;

{$IFDEF VER130}
function StrToTimeDef(const S: string; const Default: TDateTime): TDateTime;
begin
  try
    result := StrToTime(S);
  except
    result := Default;
  end;
end;

function StrToDateTimeDef(const S: string; const Default: TDateTime): TDateTime;
begin
  try
    result := StrToDateTime(S);
  except
    result := Default;
  end;
end;

function StrToDateDef(const S: string; const Default: TDateTime): TDateTime;
begin
  try
    result := StrToDate(S);
  except
    result := Default;
  end;
end;
{$ENDIF VER130}

{ TJSDateEvents }

procedure TJSDateEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString);
begin
  Value := DateToStr((AControl as TDateTimePicker).Date);
end;

procedure TJSDateEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  (AControl as TDateTimePicker).DateTime := StrToDateTimeDef(Value, now);
end;

{ TJSEditEvents }

procedure TJSEditEvents.GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Height: Integer);
begin
  // no implementation
end;

procedure TJSEditEvents.GetEditControlClass(Sender: TObject; const Index: Integer; var ControlClass: TControlClass);
begin
  // use the default control classes
  ControlClass := nil;
end;

procedure TJSEditEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Value: TJSString);
begin
  // no implementation
end;

procedure TJSEditEvents.InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer);
begin
  // no implementation
end;

procedure TJSEditEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  // no implementation
end;

{ TJSTimeEvents }

procedure TJSTimeEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString);
begin
  Value := TimeToStr((AControl as TDateTimePicker).Time);
end;

procedure TJSTimeEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  (AControl as TDateTimePicker).Time := StrToTimeDef(Value, now);
end;

{ TJSCalendarEvents }

procedure TJSCalendarEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Value: TJSString);
begin
  Value := DateToStr((AControl as TMonthCalendar).Date);
end;

procedure TJSCalendarEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  (AControl as TMonthCalendar).Date := StrToDateDef(Value, now);
end;

{ TJSComboEvents }

const
  CBStyle: array [Boolean] of TComboBoxStyle = (csDropDown, csDropDownList);

constructor TJSComboEvents.Create(const AFixedList: Boolean; const ASelectedIndex: Integer);
begin
  inherited Create;
  FFixedList := AFixedList;
  FSelectedIndex := ASelectedIndex;
end;

procedure TJSComboEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Value: TJSString);
begin
  FSelectedIndex := (AControl as TComboBox).ItemIndex;
end;

procedure TJSComboEvents.InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer);
begin
  (AControl as TComboBox).Style := CBStyle[FFixedList];
end;

procedure TJSComboEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  (AControl as TComboBox).ItemIndex := FSelectedIndex;
end;

{ TJSMemoEvents }

procedure TJSMemoEvents.GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Height: Integer);
begin
  Height := 125;
end;

{ TJSListEvents }

constructor TJSListEvents.Create(const ASelectedIndex: Integer);
begin
  inherited Create;
  FSelectedIndex := ASelectedIndex;
  FIgnoreIndex := ASelectedIndex = JSED_IGNORE_INDEX;
end;

procedure TJSListEvents.GetControlHeightHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Height: Integer);
begin
  Height := 125;
end;

procedure TJSListEvents.GetEditValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  var Value: TJSString);
begin
  if FIgnoreIndex then
  begin
    if TListBox(AControl).ItemIndex > -1 then
      Value := TListBox(AControl).Items[TListBox(AControl).ItemIndex]
    else
      Value := '';
  end
  else
    FSelectedIndex := TListBox(AControl).ItemIndex;
end;

procedure TJSListEvents.InitialiseEditHandler(Sender: TObject; AControl: TControl; const Index: Integer);
begin
  //
end;

procedure TJSListEvents.SetDefaultValueHandler(Sender: TObject; AControl: TControl; const Index: Integer;
  const Value: TJSString);
begin
  if FSelectedIndex <> JSED_IGNORE_INDEX then
    TListBox(AControl).ItemIndex := FSelectedIndex
  else
    TListBox(AControl).ItemIndex := TListBox(AControl).Items.IndexOf(Value);
end;

initialization
  FEditEvents := TJSRegisteredEvents.Create;

finalization
  FEditEvents.Free;

end.
