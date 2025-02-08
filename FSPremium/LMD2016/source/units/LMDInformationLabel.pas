unit LMDInformationLabel;
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

LMDInformationLabel unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls,
  LMDGraph, LMDClass, LMDSysIn,//TLMDInfoType
  LMDCustomStatusBar, LMD3DCaption, LMDBevel, LMDBaseLabel;

type
  {-------------------------- TLMDInformationLabel ----------------------------}
  TLMDNumberFormat = String;

  TLMDInformationLabel = class(TLMDBaseLabel)
  private
    FInfo : TLMDInfoType;
    FFont3D : TLMD3DCaption;
    FDivide : LongInt;
    FDateTimeFormat : TLMDDateTimeFormat;
    FNumberFormat : TLMDNumberFormat;
    FKeySet : String;
    timerinv,
    FStandartCaption : Boolean;
    FBevel : TLMDBevel;
    FDB,
    FTabs : ShortInt;
    FIntervall: Word;
    FTimerID : TLMDTimer;
    FUseGlobalTimer: Boolean;
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetInfo (aValue : TLMDInfoType);
    procedure SetTabs (aValue : ShortInt);
    procedure SetDB (aValue : ShortInt);
    procedure SetDevide (aValue : LongInt);
    procedure SetDateTimeFormat (aValue : TLMDDateTimeFormat);
    procedure SetNumberFormat (aValue : TLMDNumberFormat);
    procedure SetStandartCaption (aValue : Boolean);
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetUseGlobalTimer(const Value: Boolean);
    procedure GetTimer(Sender:TObject);
  protected
    procedure GetChange (Sender: TObject); override;
    function GetStatusControl: Boolean;override;
    function ReturnCaption(var s : string) : boolean;
    procedure Paint; override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure CorrectBounds; override;
  published
    property About;
    property Align;
    property Info : TLMDInfoType read FInfo write SetInfo;
    property AutoSize;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property Font;
    property InsertTabs:ShortInt read FTabs write SetTabs default 1;
    property DividerValue:LongInt read FDivide write SetDevide default 0;
    property UseStandardCaption:Boolean read FStandartCaption write SetStandartCaption default true;
    property InsertColon : ShortInt read FDB write SetDB default -1;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property DateTimeFormat : TLMDDateTimeFormat read FDateTimeFormat write SetDateTimeFormat;
    property NumberFormat : TLMDNumberFormat read FNumberFormat write SetNumberFormat;
    property Alignment;
    property Caption;
    property Color;
    property Enabled;
    property Transparent;
    // property Options;
    property ParentFont;
    property ParentColor;
    property Hint;
    property ShowHint;
    property ParentShowHint;
    property ShowAccelChar;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write SetUseGlobalTimer default false;
    // ---

    property Visible;
    property Cursor;
    { events }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
     property OnEndDock;
    property OnStartDock;
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
  end;

implementation
uses
  Windows, SysUtils, Consts,
  LMDUtils, LMDGraphUtils, LMDProcs;

function LMDFormatNumber(s, f : String) : String;

{ defined symbols

  0       - number expected

  any other symbol will be displayed as entered
}
var
  i : integer;
begin
  i := Length(s)+1;
  while length (f) > 0 do
    begin
      if (f[Length(f)] <> '0') and (i > 0) then
        Insert (f[Length(f)], s, i)
      else
        if (f[Length(f)] = '0') and (i = 1) then
          Insert ('0', s, 1)
        else
          if (f[Length(f)] <> '0') and (i = 1) then
            Insert (f[Length(f)], s, 1)
          else
           if i > 1 then
             Dec(i);
      Delete (f, Length(f), 1);
    end;
  result := s;
end;

{ ************************ class TLMDInformationLabel *************************}
{ ---------------------------- protected --------------------------------------}

(* ReturnCaption ::= Caption | StandartCaption {tab} [':'] {tab} value [unit]
   tab ::= #9
   value ::= GetSystemInfoString
   unit ::= String
*)

{------------------------------------------------------------------------------}
function TLMDInformationLabel.ReturnCaption(var s : string) : boolean;
var
  i : byte;
  s2 : string;
begin
  result := true;
  s := '';
  if not FStandartCaption then
    s := Caption
  else
    s:=LMDSIInfoToString(FInfo);

  if FDB = ShortInt(0) then
    s := s+':';
  for i := 1 to FTabs do
    begin
      s := s+#9;
      if FDB = ShortInt(i) then
        s := s+':';
    end;
  if (FTabs = ShortInt(0)) and (Caption <> '') then
    s := s + ' ';
  s2 := GetSystemInfoString (FInfo, FDivide, FDateTimeFormat);
  if (FInfo In [itScroll, itNumLock, itCapsLock, itCurrentDateTime]) and timerinv then
    begin
      if s2 <> FKeySet Then
        FKeySet := s2
      else
        result := false;
    end;
 { add formatting rules to the output }
 if (FInfo In [itCurrentDiskFree32, itCurrentDiskSize32,
               itVersion, itColorDepth, itScreenSaverDelay,
               itMemSize, itFreeSysRes, itFreeGDIRes,
               itFreeUserRes, itMajorVerNr32, itBuildNr32,
               itMemLoaded32, itMemFree32, itMemPageFree32,
               itMemPageTotal32, itMemVirtFree32, itMemVirtTotal32,
               itPlatformID32, itProcessorCont32, itDOSVersion, itCPUSpeed]) and
       (FNumberFormat <> '')  then
    s2 := LMDFormatNumber (s2, FNumberFormat);

  s := s+s2;

{  if FUnits <> '' then
    s := s+FUnits;}
  timerinv := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDInformationLabel.CorrectBounds;
var
  aRect:TRect;
  s : string;
  flags:LongInt;
begin
   // 7.0.61 Align Test
  if (Align=alNone) and AutoSize and not (csReading in ComponentState) then
    begin
      aRect:=GetClientRect;
      ReturnCaption (s);
      flags:=GetOptionsFlag;
      flags:=flags or DrawTextBiDiModeFlags(flags);
      LMDDrawTextCalcExt(Canvas, s, FFont3D, aRect, Font, MultiLine,
                         ShowAccelChar, FBevel.BevelExtend, flags);
      if (Parent is TLMDCustomStatusBar) then
        aRect.Right := aRect.Right+TLMDCustomStatusBar(parent).GetControlGap;
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.GetTimer(Sender:TObject);
var
  s : string;
begin
  if not FTimerID.Enabled then exit;
  timerinv := true;
  if ReturnCaption(s) then
    GetChange (nil);
end;

{ ---------------------------- private ----------------------------------------}
procedure TLMDInformationLabel.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{ -----------------------------------------------------------------------------}
{procedure TLMDInformationLabel.SetUnits (aValue : String);
begin
  if aValue <> FUnits then
    begin
      FUnits := aValue;
      GetChange (nil);
    end;
end;}

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetDB (aValue : ShortInt);
begin
  if aValue <> FDB then
    begin
      FDB := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetTabs (aValue : ShortInt);
begin
  if aValue <> FTabs Then
    begin
      FTabs := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetUseGlobalTimer(const Value: Boolean);
begin
  if FUseGlobalTimer<>Value then
    begin
      FUseGlobalTimer := Value;
      FTimerID.GlobalMode:=FUseGlobalTimer;
      if FUseGlobalTimer then
        FTimerID.Interval:=500  // avoids "jumping"
      else
        FTimerID.Interval:=1000;
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetDevide (aValue : LongInt);
begin
  if aValue <> FDivide Then
    begin
      FDivide := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetStandartCaption (aValue : Boolean);
begin
  if aValue <> FStandartCaption then
    begin
      FstandartCaption := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetDateTimeFormat (aValue : TLMDDateTimeFormat);
begin
  if aValue <> FDateTimeFormat then
    begin
      FDateTimeFormat := aValue;
      if FInfo In [itCurrentDateTime] then
        GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetNumberFormat (aValue : TLMDNumberFormat);
begin
  if aValue <> FNumberFormat then
    begin
      FNumberFormat := aValue;
      if FInfo In [itCurrentDiskFree32, itCurrentDiskSize32,
                   itVersion, itColorDepth, itScreenSaverDelay,
                   itMemSize, itFreeSysRes, itFreeGDIRes,
                   itFreeUserRes, itMajorVerNr32, itBuildNr32,
                   itMemLoaded32, itMemFree32, itMemPageFree32,
                   itMemPageTotal32, itMemVirtFree32, itMemVirtTotal32,
                   itPlatformID32, itProcessorCont32, itDOSVersion] then
        GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDInformationLabel.SetInfo (aValue : TLMDInfoType);
begin
  if aValue <> FInfo Then
    begin
      FInfo := aValue;
      Case FInfo Of
        itCurrentDateTime : begin
                              FTimerID.Interval:=1000;
                              FTImerId.Enabled:=true;
                            end;
        itNumLock,
        itCapsLock,
        itScroll      : begin
                          FTimerID.Interval:=250;
                          FTImerId.Enabled:=true;
                        end;
      else
        begin
          FTImerId.Enabled:=false;
        end
      end;
      if (csDesigning in ComponentState) then FTImerID.Enabled:=false;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDInformationLabel.GetChange (Sender: TObject);
begin
  CorrectBounds;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDInformationLabel.GetStatusControl: Boolean;
begin
  result:=true;
end;

{ ----------------------------- public ----------------------------------------}
procedure TLMDInformationLabel.Paint;
var
  aRect:TRect;
  flags :Word;
  s : String;
begin
  if (csLoading in ComponentState) then
    exit;

  if not ReturnCaption(s) then
    exit;

  {check, if TransparentFlag is set - if no, fill the client-rect...}
  if not Transparent then FillControl;

  aRect:=ClientRect;
  if (parent is TLMDCustomStatusBar) then
    aRect.Left := aRect.Left+(parent as TLMDCustomStatusBar).GetControlGap;

  aRect := FBevel.PaintBevel (self.Canvas, aRect, Transparent);

  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);

  if not MultiLine then
    flags:=flags or DT_SINGLELINE
  else
    if not (Alignment in [agTopLeft, agTopCenter, agTopRight]) then
      aRect:=LMDAlignTextRect(Alignment, s, Font3D, aRect, Font,
                              MultiLine, ShowAccelChar, flags);

  {Flags for DrawText}
  flags:=flags or DT_EXPANDTABS or DT_WORDBREAK or
         TLMDAlignFlags[Alignment] or GetOptionsFlag;

  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

  Canvas.Brush.Color := Color;
  Canvas.Font.Color  := GetThemedTextColor;

  LMDDrawTextExt(Canvas, s, Font3D, aRect, flags,
                [TLMDDrawTextStyle(Enabled)], nil);
end;

{ ------------------------------ public ---------------------------------------}
constructor TLMDInformationLabel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  timerinv := false;
  FKeySet := '';
  FIntervall := 1;
  FTabs := 1;
  FDB := -1;
  FDivide := 0;
  FDateTimeFormat := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat;
  FStandartCaption := True;

  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := FontChange;

  FBevel := TLMDBevel.Create;
  FBevel.OnChange := GetChange;

  {get a global timer-id}
  FTimerId:=TLMDTimer.Create(1000, GetTimer, false);
end;

{ -----------------------------------------------------------------------------}
destructor TLMDInformationLabel.Destroy;
begin
  FreeAndNil(FTimerID);
  FFont3D.OnChange := nil;
  FreeAndNil(FFont3D);
  FBevel.OnChange := nil;
  FreeAndNil(FBevel);
  inherited Destroy;
end;

end.

