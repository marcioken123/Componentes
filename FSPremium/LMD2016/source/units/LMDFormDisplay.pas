unit LMDFormDisplay;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDFormDisplay unit
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, Messages, Controls,
  LMDCustomBevelPanel;

type
  // new 4.0
  TLMDFormDisplayChangeEvent=procedure(Sender:TObject; NewForm:TCustomForm; var Cancel:Boolean) of object;
  TLMDFDMessageEvent=procedure(Sender:TObject; var Message:TMessage) of object;
  TLMDFormDisplayPosition=(fdpTopLeft, fdpTopCenter, fdpTopRight,
                           fdpCenterLeft, fdpCenter, fdpCenterRight,
                           fdpBottomLeft, fdpBottomCenter, fdpBottomRight, fdpClient);

  (*$HPPEMIT 'namespace Lmdformdisplay' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT 'class DELPHICLASS TLMDCustomFormDisplay;' *)
  (*$HPPEMIT 'class PASCALIMPLEMENTATION TLMDCustomFormDisplay : public Lmdcustombevelpanel::TLMDCustomBevelPanel ' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;	' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '	virtual int __fastcall AddFormExt(Forms::TCustomForm* aValue, bool Display) = 0 ;	' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	int __fastcall AddForm(Forms::TCustomForm* aValue, bool Display);' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TLMDCustomBevelPanel.Create */ inline __fastcall virtual TLMDCustomFormDisplay(Classes::TComponent* ' *)
  (*$HPPEMIT '		AOwner) : Lmdcustombevelpanel::TLMDCustomBevelPanel(AOwner) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TLMDCustomBevelPanel.Destroy */ inline __fastcall virtual ~TLMDCustomFormDisplay(void) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFormDisplay(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(' *)
  (*$HPPEMIT '		ParentWindow) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '};' *)

  {$EXTERNALSYM TLMDCustomFormDisplay}
  {----------------- TLMDCustomFormDisplay ------------------------------------}
  TLMDCustomFormDisplay = class(TLMDCustomBevelPanel)
  public
    function AddFormExt(aValue:TCustomForm; Display:Boolean):Integer;virtual;abstract;
    function AddForm(aValue:TCustomForm; Display:Boolean):Integer;
  end;

  {--------------------- TLMDFormDisplay --------------------------------------}
  TLMDFormDisplay = class(TLMDCustomFormDisplay)
  private
    FForm:TForm;
    FFormName:String;
    FAssignColor,
    FHook,
    FUseRes,
    FSaveResources:Boolean;
    FOldWndProc:TWndMethod;
    FOnMessage:TLMDFDMessageEvent;

    // 4.0
    FList:TList;
    FActiveIndex:Integer;
    FAutoFocus: Boolean;
    FPosition:TLMDFormDisplayPosition;

    FOnChange:TNotifyEvent;
    FOnChanging:TLMDFormDisplayChangeEvent;

    procedure SetForm(aValue:TForm);
    procedure SetFormName(const aValue:String);
    procedure SetActiveForm(aValue:TCustomForm);
    procedure SetActiveFormIndex(aValue:Integer);
    procedure SetPosition(aValue:TLMDFormDisplayPosition);
    function GetCount:Integer;
    function GetActiveForm:TCustomForm;
    function GetForms(Index:Integer):TCustomForm;
    function GetFormIndex(Index:TCustomForm):Integer;
    procedure CheckFormName(const aValue:String);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFocus;
  protected
    procedure AlignControls(AControl: TControl;var Rect : TRect); override;
    //7.02
    procedure DoThemeChanged; override; //vb aug 2005
    //--
    procedure GetChange(Sender:TObject);override;
    procedure Loaded;override;
    procedure NewWndProc(var Message:TMessage);
    procedure Paint;override;
    procedure Resize;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    // old methods prior Version 4
    function Execute(aForm:TForm):Boolean;
    function ExecuteEnh(aForm:TFormClass):TForm;
    procedure Hide;
    procedure UnLoad;
    property Form:TForm read FForm write SetForm;
    // FormList Support from Version 4
    function AddFormExt(aValue:TCustomForm; Display:Boolean):Integer; override;
    function AddFormClass(aValue:TFormClass; Display:Boolean):Integer;
    function FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
    procedure HideForm(aValue:TCustomForm);
    procedure MoveForm(aValue:TCustomForm; NewIndex:Integer);
    procedure RemoveForm(aValue:TCustomForm; FreeForm:Boolean);
    procedure SelectNextForm(GoForward: Boolean);

    property ActiveFormIndex:Integer read FActiveIndex write SetActiveFormIndex;
    property ActiveForm:TCustomForm read GetActiveForm write SetActiveForm;
    property FormCount:Integer read GetCount;
    property Forms[index:Integer]:TCustomForm read GetForms;
    property FormIndex[index:TCustomForm]:Integer read GetFormIndex;
  published
    property About;
    property Align;
    property Bevel;
    property Color;
    property Enabled;
    property FormName:String read FFormName write SetFormName;
    property HookWindowProc:Boolean read FHook write FHook default false;
    property ParentBackground default false;
    property ParentColor;
    property PopupMenu;
    property SaveResources:Boolean read FSaveResources write FSaveResources default False;
    property TabStop;
    property Visible;
    property UseResForms:Boolean read FUseRes write FUseRes default false;
    property AssignColor:Boolean read FAssignColor write FAssignColor default false;

    // NEW from 4.0
    property Position:TLMDFormDisplayPosition read FPosition write SetPosition default fdpClient;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnChanging:TLMDFormDisplayChangeEvent read FOnChanging write FOnChanging;

    // 7.0
    property OnMessage:TLMDFDMessageEvent read FOnMessage write FOnMessage;
    // ----

    property AutoFocus: Boolean read FAutoFocus write FAutoFocus default True;
    // new introduced properties
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property TabOrder;
    property Transparent;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property Anchors;
    property Constraints;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  TypInfo, SysUtils,
  Themes,
  LMDBase, LMDClass, LMDResWinControl, LMDStrings, LMDGraph, LMDGraphUtils, LMDUtils;

// Dummy helper classes
{------------------------------------------------------------------------------}

type
  TMyForm=class(TCustomForm)
  public
    property IsControl;
    property OnActivate;
    property OnDeactivate;
    property OnHide;
  end;

{******************* Object TLMDCustomFormDisplay *****************************}
{-------------------------- Private -------------------------------------------}
function TLMDCustomFormDisplay.AddForm(aValue:TCustomForm; Display:Boolean):Integer;
begin
  result := AddFormExt(aValue, Display);
end;

{******************* Object TLMDFormDisplay ***********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDFormDisplay.SetForm(aValue:TForm);
begin
  Execute(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.SetFormName(const aValue:String);
begin
  if (aValue<>FFormName) then
    if (csDesigning in ComponentState) or (csReading in ComponentState) then
      FFormName:=aValue
    else
     CheckFormName(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.SetActiveForm(aValue:TCustomForm);
var
  tmp:Integer;
begin
  tmp:=FList.IndexOf(aValue);
  if tmp<>-1 then SetActiveFormIndex(tmp);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormDisplay.SetActiveFormIndex(aValue:Integer);
var
  tmp:TCustomForm;
  cancel:Boolean;
  pf: TCustomForm;
begin
  if aValue<>FActiveIndex then
    begin
      pf := GetParentForm(Self);
      // hide current page
      cancel:=false;
      if Assigned(FOnChanging) then FOnChanging(self,Forms[aValue], cancel);
      if cancel then exit;

      if FActiveIndex<>-1 then
        begin
          if Assigned(pf) and Assigned(pf.Menu) and Assigned(TForm(Forms[FActiveIndex]).Menu) then
            pf.Menu.Unmerge(TForm(Forms[FActiveIndex]).Menu);
          HideForm(Forms[FActiveIndex]);
        end;

      FActiveIndex:=aValue;
      if FActiveIndex=-1 then exit;

      // show new page
      tmp:=Forms[FActiveIndex];
      if Assigned(pf) and Assigned(pf.Menu) and Assigned(TForm(tmp).Menu) then
        pf.Menu.Merge(TForm(tmp).Menu);


      if not tmp.HandleAllocated then tmp.HandleNeeded;
      try
        SetWindowLong(tmp.Handle, GWL_STYLE, WS_CHILD OR WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
        SetWindowLong(tmp.Handle, GWL_EXSTYLE, 0);
        Windows.SetParent(tmp.Handle, Handle);

        // positionieren
        if FPosition=fdpClient then
          tmp.Align:=alClient
        else
          begin
            tmp.Align:=alNone;
            tmp.BoundsRect:=LMDAlignRect(TLMDAlignment(Ord(FPosition)), tmp.ClientRect, BeveledRect);
          end;

        // 7.0
        if FAssignColor then
          tmp.Color:=self.Color;
        // ---

        if FHook then
          begin
            FOldWndProc:=tmp.WindowProc;
            tmp.WindowProc:=NewWndProc;
          end;

        tmp.BringToFront;
      finally
        tmp.Visible:=True;

        if FAutoFocus then
          tmp.SetFocus;

        if Assigned(TMyForm(tmp).OnActivate) then TMyForm(tmp).OnActivate (tmp); //JH, July 2001

        if Assigned(FOnChange) then FOnChange(self);
       end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.SetPosition(aValue:TLMDFormDisplayPosition);
begin
  if aValue<>FPosition then
    begin
      FPosition:=aValue;
      if Assigned(ActiveForm) then
        begin
          if FPosition=fdpClient then
            ActiveForm.Align:=alClient
          else
            ActiveForm.Align:=alNone;
          ReAlign;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.GetCount:Integer;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.GetForms(Index:Integer):TCustomForm;
begin
  result:=nil;
  if Index<FList.Count then result:=TCustomForm(FList[index]);
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.GetFormIndex(Index:TCustomForm):Integer;
begin
  result:=FList.IndexOf(Index);
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.GetActiveForm:TCustomForm;
begin
  result:=nil;
  if (FActiveIndex<>-1) then result:=TCustomForm(FList[FActiveIndex]);
end;

// oldStyle
{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.CheckFormName(const aValue:String);
var
  i:Integer;
  tmp:TForm;
begin
  if (csDesigning in ComponentState) or (csReading in ComponentState) then exit;
  if not LMDAnsiEmpty(aValue) then
    with Screen do
      begin
        tmp:=nil;
        for i:=0 to FormCount-1 do
          if Forms[i].Name=aValue then
            begin
              tmp:=Forms[i];
              break;
            end;
        if tmp<>nil then Execute(tmp);
      end
  else
    Unload;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if TabStop and (ActiveForm<>nil) then
    if ActiveForm.ActiveControl<>nil then ActiveForm.SetFocus;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDFormDisplay.AlignControls (AControl : TControl;var Rect : TRect);
var
  msg: TMessage;//WORD;
begin
  inherited AlignControls(aControl, Rect);
  if csDesigning in ComponentState then exit;
  if (FList.Count>0) and Assigned(ActiveForm) then
    if FPosition<>fdpClient then
      begin
        DisableAlign;
        ActiveForm.BoundsRect:=LMDAlignRect(TLMDAlignment(Ord(FPosition)), ActiveForm.ClientRect, BeveledRect);

        msg.Msg := CM_LMDBACKCHANGED;
        ActiveForm.BroadCast(msg);
        EnableAlign;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.DoThemeChanged;
var
  i: integer;
begin
  if Showing and (ComponentState * [csLoading, csReading] = []) then
    if ActiveForm <> nil then
      with ActiveForm do
        for i :=0 to ControlCount-1 do
          if Controls[i] is TGraphicControl then Controls[i].Perform(WM_THEMECHANGED,0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.GetChange(Sender:TObject);
begin
  inherited GetChange(Sender);
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then exit;
  if (FList.Count>0) and Assigned(ActiveForm) then
    ReAlign
  else
    if Assigned(FForm) then FForm.BoundsRect:=BeveledRect;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.Loaded;
begin
  inherited Loaded;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.NewWndProc(var Message: TMessage);
begin
  if Assigned(FOnMessage) then FOnMessage(self, Message);
  case Message.Msg of
    WM_LBUTTONDOWN,
    WM_SETFOCUS:
      begin
        if Assigned(ActiveForm) then ActiveForm.SetFocus;
      end;
  end;
  if Assigned(FOldWndProc) then FOldWndProc(Message);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.Paint;
begin
  inherited Paint;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.Resize;
begin
  inherited Resize;
  if csDesigning in ComponentState then exit;
  if (FList.Count>0) and Assigned(ActiveForm) then
    ReAlign
  else
    if Assigned(FForm) then FForm.BoundsRect:=BeveledRect;
end;

{-------------------------- Public --------------------------------------------}
// old display method
function TLMDFormDisplay.Execute(aForm:TForm):Boolean;
begin
  result:=False;

  if (aForm=nil) then
    raise Exception.Create('TLMDFormDisplay: Form not instanced!');

  if (aForm=FForm) then exit;
  Unload;
  if csDestroying in ComponentState then exit;
   {more checks...}
  //if not aForm.HandleAllocated then aForm.HandleNeeded;
  try
    //aForm.Visible:=false;
    if not FUseRes then
      aForm.Parent:=self;
    //TMyForm(aForm).IsControl:=True;

    SetWindowLong(aForm.Handle, GWL_STYLE, WS_CHILD OR WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
    SetWindowLong(aForm.Handle, GWL_EXSTYLE,0);
    Windows.SetParent(aForm.Handle, Handle);
    aForm.BoundsRect:=BeveledRect;
    aForm.BringToFront;
    FForm:=aForm;
    FFormName:=aForm.Name;
    result:=true;
  finally
    aForm.Visible:=True;
    aForm.SetFocus;
  end;
end;

// old display method
{------------------------------------------------------------------------------}
function TLMDFormDisplay.ExecuteEnh(aForm:TFormClass):TForm;
begin
  result:=aForm.Create(self);
  if Execute(result) then result:=FForm else result:=nil;
end;

// old Hide method
{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.Hide;
begin
  if FForm<>nil then
    begin
      FForm.Align:=alNone;
      FForm.Visible:=False;
      if FSaveResources then LMDFreeResources(FForm);
      FForm:=nil;
      FFormName:='';
    end;
end;

// Old unload method
{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.UnLoad;
begin
  if FForm<>nil then
    begin
      FForm.Free;
      FForm:=nil;
      FFormName:='';
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDFormDisplay.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle-[csAcceptsControls{$IFDEF LMDCOMP7},csParentBackground{$ENDIF}]+[csOpaque];
  {$IFDEF LMDCOMP7}
  BeginUpdate;
  ParentBackground := false;
  EndUpdate;
  {$ENDIF}
  FSaveResources:=False;
  FForm:=nil;
  //if aOwner is TWinControl then Parent:=TWinControl(aOwner);
  //4.0 --> FormList
  FList:=TList.Create;
  FAutoFocus := true;
  FActiveIndex:=-1;
  FPosition:=fdpClient;
  Bevel.BeginUpdate;
  Bevel.Mode:=bmWindows;
  Bevel.EndUpdate(false);
  FOldWndProc:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDFormDisplay.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.AddFormExt(aValue:TCustomForm; Display:Boolean):Integer;
begin
  result:=FList.Add(aValue);
  if result<>-1 then
    with aValue do
      begin
        // prepare Form for use in TLMDFormDisplay
        if not FUseRes then
          Parent:=self;
        Visible:=False;

        TMyForm(aValue).IsControl:=True;

        with TForm(aValue) do
          begin
            BorderStyle:=bsNone;
            BorderIcons:=[];
            Position:=poDefault;
            TabStop:=False;
          end;
        if Display then
          ActiveFormIndex:=result
        else
          if FSaveResources then LMDFreeResources(aValue);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.AddFormClass(aValue:TFormClass; Display:Boolean):Integer;
begin
  result:=AddFormExt(aValue.Create(self), Display);
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplay.FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
var
  index:integer;
begin
  result:=nil;

  Index:=FList.IndexOf(CurForm);
  if (CurForm=nil) or (Index=-1) then exit;

  if GoForward then
    begin
      Inc(Index);
      while (Index<FList.Count) do
        if Assigned(FList[Index]) then
          begin
            Result:=TCustomForm(FList[Index]);
            Exit;
          end
        else
          Inc(Index)
    end
  else
    begin
      Dec(Index);
      while (Index>=0) do
        if Assigned(FList[Index]) then
          begin
            Result:=TCustomForm(FList[Index]);
            Exit;
          end
        else
          Dec(index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.SelectNextForm(GoForward: Boolean);
begin
  SetActiveForm(FindNextForm(ActiveForm, GoForward));
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.HideForm(aValue:TCustomForm);

var
  index:Integer;
begin
  index:=FList.IndexOf(aValue);
  if FActiveIndex<>index then exit;

  if Assigned (TMyForm(aValue).OnDeactivate) then TMyForm(aValue).OnDeactivate(aValue); //JH July 2001
  if Assigned (TMyForm(aValue).OnHide) then TMyForm(aValue).OnHide(aValue); //JH July 2001

  if FHook then
    begin
//      TMyForm(aValue).WindowProc:=FOldWndProc;
      aValue.WindowProc:=FOldWndProc;
      FOldWndProc:=nil;
    end;

  aValue.Align:=alNone;
  aValue.Visible:=False;
  if FSaveResources then LMDFreeResources(aValue);
  FActiveIndex:=-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.MoveForm(aValue:TCustomForm; NewIndex:Integer);
var
  index, oldActiveIndex:Integer;
begin
  index:=FList.IndexOf(aValue);
  if index=-1 then exit;
  oldActiveIndex:=FActiveIndex;
  if FActiveIndex<>-1 then HideForm(ActiveForm);
  FList.Move(index, NewIndex);
  SetActiveFormIndex(oldActiveIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormDisplay.RemoveForm(aValue:TCustomForm; FreeForm:Boolean);
var
  index:Integer;
begin
  index:=FList.IndexOf(aValue);
  // 5.0, user report
  if index>-1 then
    begin
      if FActiveIndex=index then HideForm(aValue);
      FList.Remove(aValue);
      if FList.Count=0 then
        FActiveIndex:=-1
      else
        if FActiveIndex>(FList.Count-1) then Dec(FActiveIndex);
     if FreeForm then aValue.Free;
    end;
end;

end.
