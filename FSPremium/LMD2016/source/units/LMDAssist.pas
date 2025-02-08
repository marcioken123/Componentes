unit LMDAssist;
{$I lmdcmps.INC}

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

LMDAssist unit (RM)
-------------------

Asisstant / Wizard component

Changes
-------
Release 8.03 (December 2007)
[+] TLMDAssist: New Options flag - aoSuppressLoadEvent
    Specifies whether OnBeforePage event should be generated when assist control
    is initially shown /loaded from DFM. Flag is set by default, if OnBeforePage
    event should be generated, disable this flag.

Release 8.02 (November 2007)
[+] TLMDAssist: Options property
    Flag: aoAutoBtnSet (default) --> specifies whether Default/Cancel properties
                                     are automatically set
[*] Button captions are now updated by any changes to CustomStrings property

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Menus, StdCtrls, Forms, Messages,
  LMDBase, LMDClass, LMDButton, LMDConst, LMDCustomPanel, LMDCustomControl,
  LMDCustomComboBox;

type

  {********************* TLMDAssist control ***********************************}
  TLMDAssist = class;

  {------------------------- TLMDAssistPage -----------------------------------}
  TLMDAssistPage = class(TLMDCustomPanel)
  private
    FAssistControl:TLMDAssist;
    FInclude: Boolean;
    FOnComplete: TLMDStandardEvent;
    FOnBeforeShowPage,
    FOnAfterShowPage:TNotifyEvent;
    FOnNextPage,
    FOnPrevPage: TLMDStandardEvent;
    procedure SetAssistControl(aValue:TLMDAssist);
    procedure SetInclude(aValue:Boolean);
    procedure SetPageIndex(aValue:Integer);
    function GetPageIndex: Integer;
  protected
    procedure CreateParams(var Params:TCreateParams);override;
    procedure DoThemeChanged;override;
    procedure Loaded;override;
    procedure Paint;override;
    procedure ReadState(Reader:TReader);override;
    property Visible default False;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy; override;
    function CheckCompleted: Boolean;
    property AssistControl: TLMDAssist read FAssistControl write SetAssistControl;
    property Completed:Boolean read CheckCompleted;
  published
    property About;
    property Align default alClient;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;

    property Included:Boolean read FInclude write SetInclude default True;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;

    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;

    // 7.03
    property Transparent;
    // ----
    property ParentBackground default true;

    property OnCompleted: TLMDStandardEvent read FOnComplete write FOnComplete;
    property OnNextPage: TLMDStandardEvent read FOnNextPage write FOnNextPage;
    property OnPrevPage: TLMDStandardEvent read FOnPrevPage write FOnPrevPage;

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
    property OnStartDrag;

    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

    //4.01
    property OnBeforeShowPage:TNotifyEvent read FOnBeforeShowPage write FOnBeforeShowPage;
    property OnAfterShowPage:TNotifyEvent read FOnAfterShowPage write FOnAfterShowPage;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

  // 8.02
  TLMDAssistOption = (aoAutoBtnSet, aoSuppressLoadEvent);
  TLMDAssistOptions = set of TLMDAssistOption;
  // ----

  TLMDAssistButton = (abCustom, abHelp, abCancel);
  TLMDAssistButtons = set of TLMDAssistButton;

  TLMDInternalButtons = (btnCustom, btnhelp, btnPrev, btnNext, btnCancel);
  TLMDInternalButtonStrings=(asCustom, asHelp, asPrev, asNext, asCancel, asFinish, asClose);

  TLMDAssistPageChangeEvent=procedure(Sender:TObject; NewPage:TLMDAssistPage; var Cancel:Boolean) of object;

  {------------------------- TLMDAssist ---------------------------------------}
  TLMDAssist = class(TLMDCustomPanel)
  private
    FActivePage:TLMDAssistPage;
    FButtons: TLMDAssistButtons;
    FBtns:array[TLMDInternalButtons] of TLMDButton;
    FShowLine,
    FCompleted: Boolean;
    FCustomStrings:TStrings;
    FLineMargin,
    FBtnWidth,
    FBtnGap,
    FBtnMargin,
    FBtnHeight:Integer;
    FOnCancel,
    FOnChange,
    FOnCustom:TNotifyEvent;
    FOnComplete:TLMDStandardEvent;
    FOnPageChange:TLMDAssistPageChangeEvent;
    {internal}
    FPages:TList;
    FCRect:TRect;
    FOptions: TLMDAssistOptions;
    procedure SetActivePage(aValue:TLMDAssistPage);
    procedure SetButtons(aValue:TLMDAssistButtons);
    procedure SetBoolean(Index:Integer; aValue:Boolean);
    procedure SetButtonCaption(Index:TLMDInternalButtons; aValue:TLMDInternalButtonStrings);
    procedure SetCustomStrings(aValue:TStrings);
    procedure SetInteger(Index:Integer; aValue:Integer);
    procedure SetMoveBtnState;
    function GetCount:Integer;
    function GetButton(Index:TLMDInternalButtons):TLMDButton;
    function GetButtonCaption(Index:Integer):String;
    function GetPage(Index:Integer):TLMDAssistPage;
    procedure OnBtnsClick(Sender:TObject);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMERASEBKGND(var Message: TWMERASEBKGND); message WM_ERASEBKGND;
    procedure SetOptions(const Value: TLMDAssistOptions);
  protected
    procedure AlignControls(aControl:TControl;var AnRect:TRect);override;
    procedure AssignBtnCaptions;
    procedure AssignBtnProperties;
    procedure CreateParams(var Params: TCreateParams);  override;
    procedure DoCustomStringsChange(Sender:TObject);
    function FindNextPage(CurPage:TLMDAssistPage; GoForward, CheckInclude: Boolean):TLMDAssistPage;
    procedure Loaded;override;
    procedure Paint;override;
    function GetChildOwner: TComponent; override;
  public
    constructor Create(AnOwner: TComponent);  override;
    destructor Destroy;  override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure FirstPage;
    procedure InitPages;
    procedure InsertPage(aValue:TLMDAssistPage);
    procedure LastPage;
    procedure MovePage(OldIndex, NewIndex: Integer);
    procedure NextPage;
    procedure PrevPage;
    procedure RemovePage(aValue:TLMDAssistPage);
    procedure VerifyNext;
    property Count:Integer read GetCount;
    property Completed:Boolean index 0 read FCompleted write SetBoolean;
    {array properties}
    property Button[Index:TLMDInternalButtons]:TLMDButton read GetButton;
    property CtlXP default false;  // compatibility
    property Page[Index:Integer]:TLMDAssistPage read GetPage;
  published
    property About;
    property ActivePage: TLMDAssistPage read FActivePage write SetActivePage;
    property Align default alClient;
    property BtnGap:Integer index 0 read FBtnGap write SetInteger default 8;
    property BtnHeight:Integer index 1 read FBtnHeight write SetInteger default 25;
    property BtnMargin:Integer index 2 read FBtnMargin write SetInteger default 12;
    property BtnWidth:Integer index 3 read FBtnWidth write SetInteger default 75;
    property Color;
    property ParentBackground default false;
    property CustomStrings:TStrings read FCustomStrings write SetCustomStrings;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Buttons:TLMDAssistButtons read FButtons write SetButtons default [abCancel];
    //5.06
    property LineMargin:Integer index 4 read FLineMargin write SetInteger default 4;
    // --
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowLine:Boolean index 1 read FShowLine write SetBoolean default True;
    property TabOrder;
    property TabStop;
    property ThemeMode default ttmNone; // 9.0
    property ThemeGlobalMode;    
    property Visible;
    // 7.03
    property Transparent;
    // 8.02
    property Options:TLMDAssistOptions read FOptions write SetOptions default [aoAutoBtnSet, aoSuppressLoadEvent];
    // -----
    {own events}
    property OnCancelClick: TNotifyEvent read FOnCancel write FOnCancel;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCustomClick: TNotifyEvent read FOnCustom write FOnCustom;
    property OnCompleted: TLMDStandardEvent read FOnComplete write FOnComplete;
    property OnChanging:TLMDAssistPageChangeEvent read FOnPageChange write FOnPageChange;
    {inherited events}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

implementation
uses
  Types, Variants, Themes,
  LMDProcs, LMDThemes;

var
  asRegistered:Boolean;

{********************** class TLMDAssistPage **********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDAssistPage.SetAssistControl(aValue:TLMDAssist);
begin
  if FAssistControl<>aValue then
    begin
      if Assigned(FAssistControl) then FAssistControl.RemovePage(Self);
      if aValue<>nil then aValue.InsertPage(Self);
      FAssistControl:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.SetInclude(aValue:Boolean);
begin
  if (FInclude<>aValue) then
    begin
      FInclude:=aValue;
      if Assigned(FAssistControl) then
        with FAssistControl do
          if (ActivePage=Self) and not aValue then
            if (Count=1) then ActivePage:=nil else ActivePage:=Page[LMDMin([Pred(Count), PageIndex])];
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.SetPageIndex(aValue:Integer);
begin
  if Assigned(FAssistControl) then FAssistControl.MovePage(PageIndex, aValue);
end;

{------------------------------------------------------------------------------}
function TLMDAssistPage.GetPageIndex: Integer;
begin
  result:=-1;
  if Assigned(FAssistControl) then result:=FAssistControl.FPages.IndexOf(Self)
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDAssistPage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.DoThemeChanged;
begin
  if Assigned(FAssistControl) then
    FThemeMode := FAssistControl.ThemeMode;
  CheckOpaqueState;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.Loaded;
begin
  inherited;
  if Assigned(FAssistControl) then
    FThemeMode := FAssistControl.ThemeMode;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.Paint;
begin
  inherited;
  if csDesigning in ComponentState then
    with Canvas do
      begin
        pen.Color:=clBlack;
        Pen.Style := psDash;
        Brush.Style := bsClear;
        Rectangle(0, 0, Width, Height);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPage.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if (Reader.Parent is TLMDAssist) then
    AssistControl:=TLMDAssist(Reader.Parent);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDAssistPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csDoubleClicks, csAcceptsControls];
  Align:=alClient;
  FInclude:=True;
  Visible:=False;
end;


{------------------------------------------------------------------------------}
destructor TLMDAssistPage.Destroy;
begin
  AssistControl:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDAssistPage.CheckCompleted:Boolean;
begin
  result:=false;
  if Assigned(FOnComplete) then FOnComplete(Self, result);
  result:=not result;
end;

{************************** class TLMDAssist **********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDAssist.SetActivePage(aValue:TLMDAssistPage);
var
  tmp:Boolean;

  function FireEvent:Boolean;
  begin
    result:=not IsUpdating and (([csLoading, csDestroying]*ComponentState=[]) or
                                 (not (aoSuppressLoadEvent in FOptions)));
  end;

begin
  if (aValue=nil) then
    begin
      if Assigned(FActivePage) and Assigned(FActivePage.FOnAfterShowPage) then
        FActivePage.FOnAfterShowPage(FActivePage);
      FActivePage:=nil;
      exit;
    end;

  if (aValue=FActivePage) or (FPages.Indexof(aValue)=-1) then exit;

  tmp:=False;
  if Assigned(FOnPageChange) and FireEvent then
    FOnPageChange(self, aValue, tmp);
  if tmp then exit;

  with aValue do
    begin
      DisableAlign;
      Visible:=True;

      BringToFront;
      if not (csDesigning in ComponentState) then
        if CanFocus then SelectFirst;

      if Assigned(FActivePage) then
        begin
          if Assigned(FActivePage.FOnAfterShowPage) and FireEvent then
            FActivePage.FOnAfterShowPage(FActivePage);
          FActivePage.Visible:=False;
        end;

      if Assigned(aValue.FOnBeforeShowPage) and FireEvent then
        aValue.FOnBeforeShowPage(aValue);
      FActivePage:=aValue;

      SetMoveBtnState;

      if (FindNextPage(FActivePage, True, True) = nil) then
        FBtns[btnNext].Tag:=Ord(asFinish)
      else
        SetButtonCaption(btnNext, asNext);

      EnableAlign;
      if Assigned(FOnChange) and FireEvent then
        FOnChange(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetButtons(aValue: TLMDAssistButtons);
begin
  if (aValue<>FButtons) then
    begin
      FButtons:=aValue;
      FBtns[btnCustom].Visible:=abCustom in FButtons;
      FBtns[btnHelp].Visible:=abHelp in FButtons;
      FBtns[btnCancel].Visible:=abCancel in FButtons;
      if not (csLoading in ComponentState) then ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetBoolean(Index:Integer; aValue:Boolean);
begin
  case Index of
    0:begin
        if (aValue<>FCompleted) then
          begin
            FCompleted:=aValue;
            if FCompleted then
              begin
                Fbtns[btnPrev].Enabled := False;
                Fbtns[btnNext].Enabled:=not (abCancel in FButtons);

                if (abCancel in FButtons) then
                  begin
                    with FBtns[btnCancel] do
                      begin
                        Cancel:=False;
                        SetButtonCaption(btnCancel, asClose);
                        Default:=(aoAutoBtnSet in FOptions);  // true
                        ModalResult:=mrOK;
                      end;
                    SetButtonCaption(btnNext, asFinish);
                  end
                else
                  SetButtonCaption(btnNext, asClose);
              end
            else
              begin
               SetMoveBtnState;
                with FBtns[btnCancel] do
                  begin
                    Cancel:=(aoAutoBtnSet in FOptions);  // true
                    SetButtonCaption(btnCancel, asCancel);
                    Default:=false;
                    ModalResult:=mrCancel;
                  end;
              end;
          end;
      end;
    1:if aValue<>FShowLine then
        begin
          FShowLine:=aValue;
          Invalidate;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetCustomStrings(aValue:TStrings);
begin
  FCustomStrings.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetButtonCaption(Index:TLMDInternalButtons; aValue:TLMDInternalButtonStrings);
begin
  FBtns[Index].Tag:=Ord(aValue);
  FBtns[Index].Caption:=GetButtonCaption(Ord(aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetInteger(Index:Integer; aValue:Integer);
begin
  case Index of
    0: if aValue=FBtnGap then exit else FBtnGap:=aValue;
    1: if aValue=FBtnHeight then exit else FBtnHeight:=aValue;
    2: if aValue=FBtnMargin then exit else FBtnMargin:=aValue;
    3: if aValue=FBtnWidth then exit else FBtnWidth:=aValue;
    4: if aValue=FLineMargin then exit else FLineMargin:=aValue;
  end;
  if not (csLoading in ComponentState) then AssignBtnProperties;
  Invalidate;
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetMoveBtnState;
begin
  FBtns[btnPrev].Enabled:=Enabled and
    ((not FCompleted) and (FindNextPage(FActivePage, False, True) <> nil));
  FBtns[btnNext].Enabled:=Enabled and
    (((not FCompleted) or (not (abCancel in Buttons))) and Assigned(FActivePage) and ActivePage.Completed);

  if (FindNextPage(FActivePage, True, True) = nil) then
    SetButtonCaption(btnNext, asFinish)
  else
    SetButtonCaption(btnNext, asNext);
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.SetOptions(const Value: TLMDAssistOptions);
begin
  if FOptions <> Value then
    begin
      FOptions := Value;
      if [csLoading, csDestroying]*ComponentState = [] then
        AssignBtnProperties;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDAssist.GetButton(Index:TLMDInternalButtons):TLMDButton;
begin
  Result:=FBtns[Index];
end;

{------------------------------------------------------------------------------}
function TLMDAssist.GetButtonCaption(Index:Integer):String;
const
  ResAssistStrings:array[TLMDInternalButtonStrings] of String=('',IDS_HELP, IDS_BACK,
                   IDS_NEXT, IDS_CANCEL, IDS_FINISH, IDS_CLOSE);

begin
  result:='';
  if (FCustomStrings.Count>Index) and (FCustomStrings[index]<>'') then
    result:=FCustomStrings[index]
  else
    if index<>0 then
      result:=resAssistStrings[TLMDInternalButtonStrings(index)];
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.AssignBtnCaptions;
var
  i:TLMDInternalButtons;
begin
  for i:=Low(TLMDInternalButtons) to High(TLMDInternalButtons) do
    FBtns[i].Caption:=GetButtonCaption(integer(Fbtns[i].Tag));
end;

{------------------------------------------------------------------------------}
function TLMDAssist.GetCount: Integer;
begin
  Result:=FPages.Count;
end;

{------------------------------------------------------------------------------}
function TLMDAssist.GetPage(Index:Integer):TLMDAssistPage;
begin
  Result:=TLMDAssistPage(FPages[Index]);
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.OnBtnsClick(Sender:TObject);
var
  tmp:TWinControl;
  tb:Boolean;
begin
  if sender=FBtns[btnHelp] then
    begin
      tmp:=ActivePage;
      {find next control with helpcontext<>0}
      while (tmp<>nil) and (tmp.HelpContext=0) do tmp:=tmp.Parent;
      if Assigned(tmp) then Application.HelpContext(tmp.HelpContext) else Application.HelpContext(0);
    end
  else if sender=FBtns[btnPrev] then PrevPage
  else if sender=FBtns[btnCancel] then
    begin
      if Assigned(FOnCancel) then FOnCancel(self)
    end
  else if sender=FBtns[btnCustom] then
    begin
      if Assigned(FOnCustom) then FOnCustom(self)
    end
  else if sender=FBtns[btnNext] then
  if (FActivePage <> nil) and (FCompleted or FActivePage.Completed) then
    if (not FCompleted) and (FindNextPage(ActivePage, True, True) <> nil) then
      NextPage
    else
      begin
        tb:=false;
        if Assigned(FOnComplete) then FOnComplete(Self, tb);
        Completed:=not tb;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  SetMoveBtnState;
  FBtns[btnCancel].Enabled:=Enabled;
  FBtns[btnHelp].Enabled:=Enabled;
  FBtns[btnCustom].Enabled:=Enabled;
end;


{------------------------------------------------------------------------------}
procedure TLMDAssist.WMERASEBKGND(var Message: TWMERASEBKGND);
{$IFNDEF LMDCOMP7}
var
  aRect:TRect;
{$ENDIF}
begin
  {$IFNDEF LMDCOMP7}
  if IsThemed {and IsNotOpaque} then
    begin
      aRect:=ClientRect;
      InflateRect(aRect, 4, 4);
      LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, ttPane, aRect);
      Message.Result := 1;
    end
  else
  {$ENDIF}
    inherited;
end;


{----------------------------- Protected --------------------------------------}
procedure TLMDAssist.AlignControls(aControl:TControl;var AnRect:TRect);
var
  i:TLMDInternalButtons;
  aRect:Trect;
begin
  aRect:=AnRect;
  AnRect:=Rect(AnRect.Left+2, AnRect.Top+2, AnRect.Right-2,
               AnRect.Bottom-(FBtnHeight+2*FBtnMargin));
  FCRect:=AnRect;
  inherited AlignControls(aControl, AnRect);
  aRect.Top:=AnRect.Bottom+1;
  aRect.Right:=aRect.Right-6;

  for i:=High(TLMDInternalButtons) downto Low(TLMDInternalButtons) do
    if FBtns[i].Visible then
      begin
        FBtns[i].BoundsRect:=Rect(aRect.Right-FbtnWidth,
                                          aRect.Top+(FBtnMargin+2),
                                          aRect.Right, aRect.Bottom-(FBtnMargin-2));
        aRect.Right:=FBtns[i].Left;
        if i in [btnPrev, btnCancel, btnHelp] then aRect.Right:=aRect.Right-FBtnGap;
      end
    else
      FBtns[i].BoundsRect:=Rect(-20,0,0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.AssignBtnProperties;
var
  i:TLMDInternalButtons;
begin
  for i:=Low(TLMDInternalButtons) to High(TLMDInternalButtons) do
    with FBtns[i] do
      begin
        Width:=FBtnWidth;
        Height:=FBtnHeight;

        case i of
          btnHelp: Tag:=Ord(asHelp);
          btnNext:
            begin
              Tag:=Ord(asNext);
              Default:=(aoAutoBtnSet in FOptions); //true
            end;
          btnPrev: tag:=Ord(asPrev);
          btnCancel:
            begin
              tag:=Ord(asCancel);
              Cancel:=(aoAutoBtnSet in FOptions); // true
              ModalResult:=mrCancel;
            end;
        end;
      end;
  AssignBtnCaptions;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.DoCustomStringsChange(Sender: TObject);
begin
  if [csLoading, csDestroying]*ComponentState=[] then
    AssignBtnCaptions;
end;

{------------------------------------------------------------------------------}
function TLMDAssist.FindNextPage(CurPage:TLMDAssistPage; GoForward, CheckInclude: Boolean): TLMDAssistPage;
var
  Index:Integer;
begin
  result:=nil;
  Index:=FPages.IndexOf(CurPage);
  if (CurPage=nil) or (Index=-1) then exit;

  if GoForward then
    begin
      Inc(Index);
      while (Index<FPages.Count) do
        if (not CheckInclude) or TLMDAssistPage(FPages[Index]).Included then
          begin
            Result:=TLMDAssistPage(FPages[Index]);
            Exit;
          end
        else
          Inc(Index)
    end
  else
    begin
      Dec(Index);
      while (Index>=0) do
        if (not CheckInclude) or TLMDAssistPage(FPages[Index]).Included then
          begin
            Result:=TLMDAssistPage(FPages[Index]);
            Exit;
          end
        else
          Dec(index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.Loaded;
begin
  inherited Loaded;
  AssignBtnProperties;
  if not (csDesigning in ComponentState) then InitPages;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i:Integer;
begin
  for i:=0 to Pred(FPages.Count) do Proc(TComponent(FPages[i]));
end;

{------------------------------------------------------------------------------}
function TLMDAssist.GetChildOwner: TComponent;
begin
  result:=inherited GetChildOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.Paint;
var
  aRect:TRect;
  lTheme: TLMDThemeMode;

  procedure DrawBackGround;
  begin
    aRect:=ClientRect;
    InflateRect(aRect, 4, 4);
    LMDThemeServices.DrawElement(lTheme, Canvas.Handle, ttPane, aRect);
  end;

begin
  // 7.1
  lTheme := UseThemeMode;
  if lTheme = ttmNone then
    inherited
  else
    if IsNotOpaque then inherited else DrawBackGround;

  if FShowLine then
    begin
      with FCRect do
        aRect:=Rect(Left+FLineMargin, Bottom+1, Right-FLineMargin, Bottom+3);
      DrawEdge(Canvas.Handle, aRect, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_TOP);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.VerifyNext;
begin
  SetMoveBtnState;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDAssist.Create(AnOwner: TComponent);
var
  i:TLMDInternalButtons;
begin
  inherited Create(AnOwner);
  //ControlStyle:=ControlStyle-[csAcceptsControls,csParentBackground]+[csOpaque];
  ControlStyle:=ControlStyle-[csAcceptsControls{$IFDEF LMDCOMP7},csParentBackground{$ENDIF}]
                            +[csOpaque];
  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;
  {$ENDIF}

  FThemeMode := ttmNone;
  FOptions := [aoAutoBtnSet, aoSuppressLoadEvent];
  Align:=alClient;

  FCustomStrings := TStringList.Create;
  TStringList(FCustomStrings).OnChange := DoCustomStringsChange;

  FPages:=TList.Create;
  if not asRegistered then
    begin
      RegisterClass(TLMDAssistPage);
      asRegistered:=true;
    end;

  FBtnHeight:=25;
  FBtnWidth:=75;
  FBtnMargin:=12;
  FBtnGap:=8;
  FShowLine:=True;
  FLineMargin:=4;
  FButtons:=[abCancel];

  {Buttons --------------}
  for i:=Low(TLMDInternalButtons) to High(TLMDInternalButtons) do
    begin
      FBtns[i]:=TLMDButton.Create(Self);
      with FBtns[i] do
        begin
          Parent:=Self;
          TabOrder:=Ord(i);
          OnClick:=OnBtnsClick;
          {specials}
          case i of
            btnCustom:
              begin
                Tag:=0;
                Visible:=False;
              end;
            btnHelp:
              begin
                Visible:=False;
                Tag:=Ord(asHelp);
              end;
            btnNext:
              begin
                Tag:=Ord(asNext);
                Default:=True;
              end;
            btnPrev: Tag:=Ord(asPrev);
            btnCancel:
              begin
                Cancel:=True;
                Tag:=Ord(asCancel);
                ModalResult:=mrCancel;
              end;
          end;
        end;
    end;
  if csDesigning in ComponentState then
    AssignBtnCaptions;
end;

{------------------------------------------------------------------------------}
destructor TLMDAssist.Destroy;
begin
  FreeAndNil(FPages);
  TStringList(FCustomStrings).OnChange := nil;
  FreeAndNil(FCustomStrings);
  inherited Destroy;
end;

{public page handling methods}
{------------------------------------------------------------------------------}
procedure TLMDAssist.FirstPage;
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=0;
      while i<Count do
        if TLMDAssistPage(FPages[i]).Included then
          begin
            ActivePage:=TLMDAssistPage(FPages[i]);
            exit;
          end
        else
          Inc(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.InitPages;
begin
  BeginUpdate;
  try
    FirstPage;
    SetMoveBtnState;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.InsertPage(aValue:TLMDAssistPage);
begin
  if aValue=nil then
    exit
  else
    if FPages.IndexOf(aValue)=-1 then FPages.Add(aValue);

  aValue.Parent:=Self;
  if not (csLoading in ComponentState) then ActivePage:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.LastPage;
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=Pred(Count);
      while i>=0 do
        if TLMDAssistPage(FPages[i]).Included then
          begin
            ActivePage:=TLMDAssistPage(FPages[i]);
            exit;
          end
        else
          Dec(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.MovePage(OldIndex, NewIndex: Integer);
begin
  FPages.Move(OldIndex, NewIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.NextPage;
var
  tmp:TLMDAssistPage;
  bCancel: boolean;
begin
  bCancel := false;
  if Assigned(ActivePage.FOnNextPage) then
    ActivePage.FOnNextPage(Self, bCancel);
  if bCancel then exit;
  tmp:=FindNextPage(ActivePage, True, True);
  if Assigned(tmp) then ActivePage:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.PrevPage;
var
  tmp:TLMDAssistPage;
  bCancel:Boolean;
begin
  bCancel := false;
  if Assigned(ActivePage.FOnPrevPage) then
    ActivePage.FOnPrevPage(Self, bCancel);
  if bCancel then exit;
  tmp:=FindNextPage(ActivePage, False, True);
  if Assigned(tmp) then ActivePage:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssist.RemovePage(aValue:TLMDAssistPage);
var
  Index:Integer;
  tmp:TLMDAssistPage;
begin
  if not Assigned(FPages) then
    Index:=-1
  else
    Index:=FPages.IndexOf(aValue);

  if Index<>-1 then
    begin
      if FPages.Count>0 then
        begin
          tmp:=FindNextPage(aValue, True, False);
          if tmp=nil then
            tmp:=FindNextPage(aValue, False, False);
          ActivePage:=tmp;
        end;
      FPages.Delete(Index);
      aValue.FAssistControl:=nil;
    end;

  if Assigned(FPages) and not (csDestroying in ComponentState) then
    if FPages.Count=0 then ActivePage:=nil;
end;

initialization
  asRegistered:=False;
end.

