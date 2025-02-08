unit LMDFormTabControl;
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

LMDFormTabControl unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Controls, Forms, ComCtrls,
  Themes,
  LMDBase, LMDTypes, LMDFormDisplay;

type

  (*$HPPEMIT 'namespace Lmdformtabcontrol' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '//-- type declarations -------------------------------------------------------' *)
  (*$HPPEMIT 'class DELPHICLASS TLMDCustomFormTabControl;' *)
  (*$HPPEMIT 'class PASCALIMPLEMENTATION TLMDCustomFormTabControl : public Comctrls::TCustomTabControl ' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '	typedef Comctrls::TCustomTabControl inherited;	' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '	virtual int __fastcall AddFormExt(Forms::TCustomForm* aValue, bool Display) = 0 ;	' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	int __fastcall AddForm(Forms::TCustomForm* aValue, bool Display);' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TCustomTabControl.Create */ inline __fastcall virtual TLMDCustomFormTabControl(Classes::TComponent* ' *)
  (*$HPPEMIT '		AOwner) : Comctrls::TCustomTabControl(AOwner) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TCustomTabControl.Destroy */ inline __fastcall virtual ~TLMDCustomFormTabControl(void) { }' *)
  (*$HPPEMIT '	#pragma option pop	' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFormTabControl(HWND ParentWindow) : Comctrls::TCustomTabControl(' *)
  (*$HPPEMIT '		ParentWindow) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '};' *)
  
  {**************** Object TLMDCustomFormTabControl ***************************}
  {$EXTERNALSYM TLMDCustomFormTabControl}
  TLMDCustomFormTabControl=class(TCustomTabControl)  // for C++ Builder compatibility
  public
    function AddFormExt(aValue:TCustomForm; Display:Boolean):Integer;virtual;abstract;
    function AddForm(aValue:TCustomForm; Display:Boolean):Integer;
  end;

  {******************* Object TLMDFormTabControl ******************************}
  TLMDFormTabControl=class(TLMDCustomFormTabControl)
  private
    FUseRes,
    FSaveResources:Boolean;
    FAbout:TLMDAboutVar;
    // 4.0
    FList:TList;
    FActiveIndex:Integer;
    FOnChanging:TLMDFormDisplayChangeEvent;
    procedure SetActiveForm(aValue:TCustomForm);
    procedure SetActiveFormIndex(aValue:Integer);
    function GetCount:Integer;
    function GetActiveForm:TCustomForm;
    function GetForms(Index:Integer):TCustomForm;
    function GetFormIndex(Index:TCustomForm):Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    //7.02
    procedure WMThemeChanged(var Message: TCMDialogKey); message WM_ThemeChanged; //added vb aug 2005
    // --
  protected
    function CanChange: Boolean; override;
    procedure Change; override;

    procedure DoThemeChanged; //added vb aug 2005
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    // FormList Support from Version 4
    function AddFormExt(aValue:TCustomForm; Display:Boolean):Integer; override;
    function AddFormClass(aValue:TFormClass; Display:Boolean):Integer;
    function AddFormClassExt(aValue:TFormClass; Display:Boolean; Caption:String):Integer;
    function FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
    procedure HideForm(aValue:TCustomForm);
    procedure MoveForm(aValue:TCustomForm; NewIndex:Integer);
    procedure RemoveForm(aValue:TCustomForm; FreeForm:Boolean);
    procedure SelectNextForm(GoForward: Boolean);
    function SetActiveFormByName(aValue:String):Boolean;

    property ActiveFormIndex:Integer read FActiveIndex write SetActiveFormIndex;
    property ActiveForm:TCustomForm read GetActiveForm write SetActiveForm;
    property FormCount:Integer read GetCount;
    property Forms[index:Integer]:TCustomForm read GetForms;
    property FormIndex[index:TCustomForm]:Integer read GetFormIndex;

    property DisplayRect;
    property Tabs;
    property TabIndex;  // must be after Tabs
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property SaveResources:Boolean read FSaveResources write FSaveResources default False;
    property OnChanging:TLMDFormDisplayChangeEvent read FOnChanging write FOnChanging;
    property UseResForms:Boolean read FUseRes write FUseRes default false;
    // Delphi 3
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property MultiLine;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // Delphi 4
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragKind;
    property Images;
    property MultiSelect;
    property OwnerDraw;
    property ParentBiDiMode;
    property RaggedRight;
    property Style;

    property OnDockDrop;
    property OnDockOver;
    property OnDrawTab;
    property OnEndDock;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;


implementation
uses
  LMDResWinControl;

// Dummy helper class
{------------------------------------------------------------------------------}
{type
  TMyForm=class(TForm)
  public
    property IsControl;
  end;}

{******************* Object TLMDCustomFormTabControl **************************}
{-------------------------- Private -------------------------------------------}
function TLMDCustomFormTabControl.AddForm(aValue:TCustomForm; Display:Boolean):Integer;
begin
  result := AddFormExt(aValue, Display);
end;

{******************* Object TLMDFormTabControl ********************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDFormTabControl.SetActiveForm(aValue:TCustomForm);
var
  tmp:Integer;
begin
  tmp:=FList.IndexOf(aValue);
  if tmp<>-1 then SetActiveFormIndex(tmp);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.SetActiveFormIndex(aValue:Integer);
var
  tmp:TCustomForm;
  cancel:Boolean;
begin
  if aValue<>FActiveIndex then
    begin
      // hide current page
      cancel:=false;
      if Assigned(FOnChanging) then FOnChanging(self, Forms[aValue], cancel);
      if cancel then exit;

      if FActiveIndex<>-1 then
        HideForm(Forms[FActiveIndex]);
      FActiveIndex:=aValue;
      TabIndex:=FActiveIndex;
      if FActiveIndex=-1 then exit;
      // show new page
      tmp:=Forms[FActiveIndex];
      if not tmp.HandleAllocated then tmp.HandleNeeded;
      try
        SetWindowLong(tmp.Handle, GWL_STYLE, WS_CHILD OR WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
        SetWindowLong(tmp.Handle, GWL_EXSTYLE,0);
        Windows.SetParent(tmp.Handle, Handle);

        // positionieren
        tmp.Align:=alClient;
        tmp.BringToFront;
      finally
        tmp.Visible:=True;
        if HandleAllocated and IsWindowVisible(Handle) and not (csLoading in ComponentState) then
          if tmp.ActiveControl<>nil then
            tmp.ActiveControl.SetFocus
          else
            tmp.SetFocus;
       end;
      if Assigned(OnChange) then OnChange(self);
   end;
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.GetCount:Integer;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.GetForms(Index:Integer):TCustomForm;
begin
  result:=nil;
  if Index<FList.Count then result:=TCustomForm(FList[index]);
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.GetFormIndex(Index:TCustomForm):Integer;
begin
  result:=FList.IndexOf(Index);
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.GetActiveForm:TCustomForm;
begin
  result:=nil;
  if (FActiveIndex<>-1) then result:=TCustomForm(FList[FActiveIndex]);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    SelectNextForm(GetKeyState(VK_SHIFT) >= 0);
    Message.Result := 1;
  end else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.WMThemeChanged(var Message: TCMDialogKey);
begin
  Inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  Message.Result:=1;
end;

{-------------------------- Protected -----------------------------------------}
function TLMDFormTabControl.CanChange;
begin
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.Change;
begin
  if TabIndex<>FActiveIndex then SetActiveFormIndex(TabIndex);
  if TabIndex<>FActiveIndex then TabIndex:=FActiveIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.DoThemeChanged;
var
  i: integer;
begin
  if Showing and (ComponentState * [csLoading, csReading] = []) then
    if ActiveForm <> nil then
      with ActiveForm do
        for i :=0 to ControlCount-1 do
          Controls[i].Perform(WM_THEMECHANGED,0,0);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDFormTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSaveResources:=False;
  FList:=TList.Create;
  FActiveIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDFormTabControl.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.AddFormExt(aValue:TCustomForm; Display:Boolean):Integer;
begin
  result:=FList.Add(aValue);
  if result<>-1 then
    with aValue do
      begin
        // prepare Form for use in TLMDFormDisplay
        if not FUseRes then
          Parent:=self;

        Visible:=False;
//        TMyForm(aValue).IsControl:=True;
        with TForm(aValue) do
          begin
            Tabs.Add(Caption);
            BorderStyle:=bsNone;
            BorderIcons:=[];
            if FUseRes then
              BoundsRect:=self.DisplayRect
            else
              Position:=poDefault;
          end;

        if Display then
          ActiveFormIndex:=result
        else
          if FSaveResources then LMDFreeResources(aValue);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.AddFormClass(aValue:TFormClass; Display:Boolean):Integer;

begin
  result:=AddFormExt(aValue.Create(self), Display);
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.AddFormClassExt(aValue:TFormClass; Display:Boolean; Caption:String):Integer;
var
  tmp:TCustomForm;
begin
  if Caption='' then
    result:=AddFormExt(aValue.Create(self), Display)
  else
    begin
      tmp:=aValue.Create(self);
      tmp.Caption:=Caption;
      result:=AddFormExt(tmp, Display);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
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
procedure TLMDFormTabControl.SelectNextForm(GoForward: Boolean);
begin
  SetActiveForm(FindNextForm(ActiveForm, GoForward));
end;

{------------------------------------------------------------------------------}
function TLMDFormTabControl.SetActiveFormByName(aValue:String):Boolean;
var
  i:Integer;
begin
  result:=False;
  for i:=0 to Pred(FList.Count) do
    begin
       if TCustomForm(FList[i]).Caption=aValue then
         begin
           ActiveFormIndex:=i;
           result:=true;
           break;
         end
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.HideForm(aValue:TCustomForm);
var
  index:Integer;
begin
  index:=FList.IndexOf(aValue);
  if FActiveIndex<>index then exit;
  aValue.Align:=alNone;
  aValue.Visible:=False;
  if FSaveResources then LMDFreeResources(aValue);
  FActiveIndex:=-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.MoveForm(aValue:TCustomForm; NewIndex:Integer);
var
  index, oldActiveIndex:Integer;
begin
  index:=FList.IndexOf(aValue);
  if index=-1 then exit;
  oldActiveIndex:=FActiveIndex;
  if FActiveIndex<>-1 then HideForm(ActiveForm);
  FList.Move(index, NewIndex);
  Tabs.Move(index, NewIndex);
  SetActiveFormIndex(oldActiveIndex);
  TabIndex:=FActiveIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormTabControl.RemoveForm(aValue:TCustomForm; FreeForm:Boolean);
var
  index:Integer;
begin
  index:=FList.IndexOf(aValue);
  if Index=-1 then exit;
  if FActiveIndex=index then HideForm(aValue);
  Tabs.Delete(Index);
  FList.Remove(aValue);
  if index>=FList.Count then index:=Pred(FList.Count);
  SetActiveFormIndex(index);
  TabIndex:=FActiveIndex;
  if FreeForm then aValue.Free;
end;

end.
 
