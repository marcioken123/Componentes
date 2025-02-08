unit LMDBaseGraphicControl;
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

LMDBaseGraphicControl unit (RM)
-------------------------------
LMD graphic controls can be transparent without the special LMD transparency
technology - but some controls require many repaints of the parent control for
getting a "clean" background. This can be avoided by using a LMD container
control as background.
Note: A graphiccontrol descendant cannot be used as background for other components!

Changes
-------
Release 9.0 (June 2008)
 - ThemeMode property introduced

Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Controls, Classes, Messages, Windows, Graphics, ImgList, Types,
  intfLMDBackground, intfLMDBase, LMDCustomImageList,
  Themes,
  LMDBitmapEffectObject, LMDBaseController, LMDCont,
  LMDBaseControl, LMDClass, LMDTypes;

type

  TLMDOnBoundsChangeEvent=procedure(Sender:TObject; State:TLMDBoundsChangeStates) of object;

  TLMDBaseGraphicControl=class(TLMDBaseControl, ILMDBackground)
  private
    FOnBoundsChange: TLMDOnBoundsChangeEvent;
    FUpdateCount   : Integer;
    FTransparent   : Boolean;
    FImageList     : TCustomImageList;
    FIndex,
    FListIndex     : Integer;
    FChangeLink    : TChangeLink;
    FBackFX        : TLMDBitmapEffectObject;
    FThemeGlobalMode: Boolean;
    FParentThemeMode: boolean;
    procedure SetTransparent(aValue:Boolean);
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetIndex(index, aValue:Integer);
    procedure SetBackFX (aValue : TLMDBitmapEffectObject);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean);
    {saving}
    procedure ReadCtlXP(Reader: TReader);
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    procedure CMTRANSPARENTCHANGED(var Message: TMessage); message CM_TRANSPARENTCHANGED;
    procedure CMLMDThemeChanged(var Message: TMessage); message CM_LMDTHEMECHANGED;
    procedure WMThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FThemeMode     : TLMDThemeMode;
    Painting       : Boolean;
    // V8
    function CheckOptimized:Boolean;virtual;
    procedure DisableTransMode;
    procedure InvalidateControl;
    // ---
    // old theme interface methods
    procedure set_CtlXP (aValue: Boolean);
    function get_CtlXP: Boolean;

    // Theme Support - changed from release 9.0
    // ----------------------------------------
    //handle theme changes
    procedure DoThemeChanged; virtual;
    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;

    procedure BoundsChange(State:TLMDBoundsChangeStates);virtual;
    procedure GetChange(Sender:TObject);virtual;

    // V8
    procedure DefineProperties(Filer:TFiler);override;
    procedure GetIMLChange(Sender:TObject);virtual;
    function GetScreenRect(aRect:TRect):TRect;
    procedure Loaded;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure SetImageIndex(aValue:Integer);
    // ---

    // Properties
    property OnBoundsChange:TLMDOnBoundsChangeEvent read FOnBoundsChange write FOnBoundsChange;
    property Transparent:Boolean read FTransparent write SetTransparent default True;
    // 9.0
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmNone;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property CtlXP:Boolean read get_CtlXP write set_CtlXP default false;
    // 8.0
    property BackFX : TLMDBitmapEffectObject read FBackFX write SetBackFX;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex:Integer index 0 read FIndex write SetIndex default 0;
    property ListIndex:Integer index 1 read FListIndex write SetIndex default 0;
  public
    constructor Create(aOwner:TComponent);override;

    destructor Destroy;override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);override;
    //usually property setters call GetChange if a property has been changed
    //this behaviour can be stopped by using the BeginUpdate procedure
    //EndUpdate will reanble the GetChange procedure, and if repaint is true
    //will call GetChange for doing any necessary visual updates
    procedure BeginUpdate;
    function IsUpdating:Boolean;
    procedure EndUpdate(repaint: Boolean);
    // Theme Support - changed from release 9.0
    function IsThemed: Boolean; // any other than ttmNone
    procedure Click; override;
    //new V7
    function BackBitmap: TBitmap; virtual;
    function BackBitmapCheck: Boolean; virtual;
    function BackDrawArea (Canvas: TCanvas; const dest: TRect; const src: TPoint;
                           flags: Word=0): Boolean; virtual;
    function isTransparentSet: Boolean; virtual;
    function BackMapPoint (const aValue: TPoint): TPoint; virtual;
    function BackBitmapPalette: HPalette; virtual;
    procedure BackUpdate; virtual;
    function BackControl (index: Integer): TControl; virtual;
    function BackControlCount: Integer; virtual;
    // ---

    //new V8
    function IMLEmpty:Boolean;
    // -----
  published
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}

  end;

implementation
uses
  LMDThemes, TypInfo;

{******************* Class TLMDControl ****************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDBaseGraphicControl.set_CtlXP (aValue: Boolean);
begin
 if aValue <> Get_CtlXP then
   ThemeMode := LMDCtlXP[aValue];
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicControl.get_CtlXP: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicControl.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.SetIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FIndex) or (aValue < -1) then exit else FIndex:=aValue;
    1: if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  end;
  if FImageList<>nil then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.SetBackFX (aValue : TLMDBitmapEffectObject);
begin
  FBackFX.Assign (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.ReadCtlXP(Reader: TReader);
begin
  Set_CtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicControl.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicControl.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
        DoThemeChanged;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicControl.SetTransparent(aValue:Boolean);
begin
  if FTransparent<>aValue then
    begin
      if aValue then
        ControlStyle:=ControlStyle-[csOpaque]
      else
        ControlStyle:=ControlStyle+[csOpaque];
      FTransparent:=aValue;
      Perform(CM_TRANSPARENTCHANGED,0,0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.CMLMDThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.WMThemeChanged(var Message: TMessage);
begin
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  Message.result:=1;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.CMTRANSPARENTCHANGED(var Message: TMessage);
begin
  if Visible then
    InvalidateControl;
end;

{------------------------- Protected ------------------------------------------}
function TLMDBaseGraphicControl.CheckOptimized:Boolean;
begin
  result := FTransparent and LMDBackBitmapCheck (Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.DisableTransMode;
begin
  FTransparent:=False;
  ControlStyle:=ControlStyle+[csOpaque];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.DoThemeChanged;
begin
  //If ControlSupportsXP then
  if ThemeMode <> ttmNone then
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.BoundsChange(State:TLMDBoundsChangeStates);
begin
  if Assigned(FOnBoundsChange) then FOnBoundsChange(Self, State);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.GetChange(Sender:TObject);
begin
  if (FUpdateCount > 0) or ([csLoading, csReading, csDestroying]*ComponentState<>[]) then
     exit;
  InvalidateControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.InvalidateControl;
begin
  if IsUpdating  or (not Assigned(Parent)) or not Parent.HandleAllocated then exit;
  if FTransparent then
    Invalidate
  else
    Paint;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.GetIMLChange(Sender:TObject);
begin
  GetChange(sender);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.GetScreenRect(aRect:TRect):TRect;
begin
  with aRect do
    begin
     result.TopLeft:=ClientToScreen(Point(Left,Top));
     result.BottomRight:=ClientToScreen(Point(Right,Bottom));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.Loaded;
begin
  inherited Loaded;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(ImageList) or
     LMDIsGlobalIdent(ImageList) then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) and (aComponent is TCustomImageList) then
    begin
      if (aComponent=FImageList) then SetImageList(nil);
      if not (csDestroying in ComponentState) and (aComponent=FBackFX.AlphaBlend.ImageList) then
        FBackFX.AlphaBlend.ImageList := nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.SetImageIndex(aValue:Integer);
begin
  FIndex:=aValue;
  {-> no changes}
end;

{------------------------- Public----------------------------------------------}
constructor TLMDBaseGraphicControl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle-[csOpaque]+[csReplicatable];
  FParentThemeMode := true;
  FThemeMode := ttmNone;
  FUpdateCount := 0;
  FTransparent:=True;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FBackFX := TLMDBitmapEffectObject.Create;
  FChangeLink.OnChange:=GetIMLChange;
  FBackFX.OnChange := GetChange;
  //SetBounds(Left, Top, 30, 30);
  Height:=30;
  Width:=30;
  FListIndex:=0;
  FIndex:=0;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseGraphicControl.Destroy;
begin
  FChangeLink.OnChange:=nil;
  FBackFX.OnChange := nil;
  FBackFX.Free;
  FChangeLink.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  temp:TLMDBoundsChangeStates;
  tmpR:TRect;
begin
  tmpr:=Rect(Left, Top, Width, Height);
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
  temp := [];
  with tmpr do
  begin
    if (self.Left <> Left) or (self.Top <> Top) then
      temp := [bcPos];
    if (Width <> Right) or (Height <> Bottom) then
      temp := temp + [bcSize];
  end;
  if (temp <> []) and not (csLoading in ComponentState) then
    BoundsChange(temp);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.BeginUpdate;
begin
  inc(FUpdateCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.EndUpdate(repaint: Boolean);
begin
  Dec (FUpdateCount);
  if FUpdateCount = 0 then
    if repaint then GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.IsUpdating:Boolean;
begin
  result:=FUpdateCount>0;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackBitmap: TBitmap;
begin
  result := LMDBackBitmap (self);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackBitmapCheck: Boolean;
begin
  result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackDrawArea(Canvas: TCanvas; const
  dest: TRect; const src: TPoint; flags:Word): Boolean;
begin
  if BackBitmap <> nil then
    with BackMapPoint (src) do
      Canvas.CopyRect(dest, BackBitmap.Canvas, Bounds (X, Y,
                      dest.Right - dest.Left, dest.Bottom - dest.Top));
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.isTransparentSet: Boolean;
begin
  result := FTransparent;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackMapPoint (const aValue: TPoint): TPoint;
begin
  if BackBitmapCheck then
    result := LMDBackMapPoint (self, aValue)
  else
    result := aValue;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackBitmapPalette: HPalette;
begin
  result:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.BackUpdate;
begin
  if not Visible then exit;
  if not (csLoading in ComponentState) and CheckOptimized then
    GetChange(nil);
  FBackFX.DestroyBuffer;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackControl (index: Integer): TControl;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.BackControlCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicControl.Click;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicControl.IMLEmpty:Boolean;
begin
  result:=not LMDIMLIsValidItem(ImageList, ListIndex, ImageIndex);
end;

end.
