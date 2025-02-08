unit LMDStaticText;
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

LMDStaticText unit (RM)
----------------------
Static Text control

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls, Messages, Forms, Themes, LMDGraph,
  LMDBaseLabel, LMDCustomPanelFill;

type
  TLMDStaticText = class (TLMDCustomPanelFill)
  private
    FFocusControl   : TWinControl;
    FShowAccelChar,
    FMultiLine,
    FAutoSize       : Boolean;
    FOptions        : TLMDLabelOptions;

    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetOptions (aValue : TLMDLabelOptions);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
  protected
    function  GetThemedTextColor: TColor;
    procedure GetChange(Sender : TObject); override;
    procedure DrawCaption(aRect:TRect; aAlignment:TLMDAlignment); override;
  public
    constructor Create (aOwner : TComponent); override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    procedure CorrectBounds; virtual;
    function GetOptionsFlag : Word;
    function GetLabelText : String;
    property DockManager;
  published
    // V4 enhancements
    property Anchors;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    property About;
    property Alignment;
    property AutoSize : Boolean index 0 read FAutoSize write SetBoolean default true;
    property BackFX;
    property Bevel;
    property Caption;
    property Color;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FillObject;
    property FocusControl : TWinControl read FFocusControl write FFocusControl;
    property Font;
    property FontFX;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property MultiLine : Boolean index 1 read FMultiLine write SetBoolean default false;
    property Options:TLMDLabelOptions read FOptions write SetOptions;
    property ParentBackground;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar : Boolean index 2 read FShowAccelChar write SetBoolean default true;
    property ShowHint;
    property Transparent;
    property TransparentBorder;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

  end;

implementation

uses
  LMDClass, LMDProcs, LMDGraphUtils;

{ ------------------------------ private ------------------------------------- }
procedure TLMDStaticText.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : if aValue <> FAutoSize then
          begin
            FAutoSize := aValue;
            CorrectBounds;
          end;
    1 : if aValue <> FMultiLine then
          begin
            FMultiLine := aValue;
            CorrectBounds;
          end;
    2 : if aValue <> FShowAccelChar then
          begin
            FShowAccelChar := aValue;
            CorrectBounds;
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.SetOptions(aValue:TLMDLabelOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStaticText.CMHintShow(var Message: TCMHintShow);
var
  HintInfo : PHintInfo;
begin
  inherited;
  if (Hint<>'') or not (loShowLabelHint in FOptions) then exit;
  HintInfo := Message.HintInfo;
  if HintInfo.HintControl = Self then
    HintInfo.HintStr:=GetLabelText;
end;

{------------------------------------------------------------------------------}
procedure TLMDStaticText.CMDialogChar(var Message: TCMDialogChar);
begin
  if not FShowAccelChar then exit;
  if (FFocusControl <> nil) and Enabled and IsAccel(Message.CharCode, Caption) then
    if FFocusControl.CanFocus then
      begin
        FFocusControl.SetFocus;
        Message.Result := 1;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.CMTextChanged(var Message: TMessage);
begin
  CorrectBounds;
  if not AutoSize then
    Invalidate; //added April 02, JH
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDStaticText.GetChange (Sender : TObject);
begin
  CorrectBounds;
  inherited GetChange (Sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
var
  flags:LongInt;
begin
  Canvas.Brush.Style:=bsClear;
  Canvas.Brush.Color:=Color;

  Canvas.Font       := Font;
  Canvas.Font.Color := GetThemedTextColor;

  flags:=GetOptionsFlag;
  flags:=DrawTextBiDiModeFlags(flags);

  if (FontFx.Angle>0) and not (Alignment=agTopLeft) then
    aRect:=LMDAlignTextRect(Alignment, GetLabelText, FontFx, aRect, Font,
                            FShowAccelChar, FMultiLine, flags);

  if not FMultiLine then flags := flags or DT_SINGLELINE;
  if not FShowAccelChar then flags := flags or DT_NOPREFIX;

  flags:=flags or DT_EXPANDTABS or TLMDAlignFlags[aAlignment];
  LMDDrawTextExt(Canvas, Caption, FontFx, aRect, flags,
                 [TLMDDrawTextStyle(Enabled), dtClip], nil);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDStaticText.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  FThemeMode := ttmPlatform;
  FAutoSize := true;
  FFocusControl := nil;
  FShowAccelChar := true;
  FMultiLine := false;
  FOptions := [];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.Loaded;
begin
  inherited Loaded;
  CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStaticText.CorrectBounds;
var
  aRect:TRect;
  flags:LongInt;

begin
  if Parent = nil then exit;
  if AutoSize and not (csLoading in ComponentState) then
    begin
      aRect:=ClientRect;
      flags:=GetOptionsFlag;
      flags:=flags or DrawTextBiDiModeFlags(flags);
      LMDDrawTextCalcExt(Canvas, GetLabelText, FontFX, aRect, Font, MultiLine,
                         FShowAccelChar, Bevel.BevelExtend, flags);
{      if (Parent is TLMDCustomStatusBar) then
        aRect.Right := aRect.Right+TLMDCustomStatusBar(parent).GetControlGap;}
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStaticText.GetOptionsFlag:Word;
const
  OPTFLAGS:array[TLMDLabelOption] of Word = (DT_PATH_ELLIPSIS, DT_END_ELLIPSIS, DT_EDITCONTROL,0);
var
  i:TLMDLabelOption;
begin
  result:=0;
  for i:=Low(TLMDLabelOption) to High(TLMDLabelOption) do
    if i in FOptions then result:=result or OptFlags[i];
  if result<>0 then result:=result or DT_MODIFYSTRING;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStaticText.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled,
                                                  ttlTextLabelNormal);
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(C_STATES[Enabled]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clWindowText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStaticText.GetLabelText : String;
begin
  result := Caption;
end;

end.
