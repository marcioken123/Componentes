unit LMDTextCustomLabel;
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

LMDTextCustomLabel unit (JH)
----------------------------

Label component which displays formatted text 

db label: master (first) and child (in descendand label) table! 

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Themes, LMDClass, LMDBaseGraphicControl{Label}, LMDProcs, LMDTextObject,
  LMDGraph, LMDText, LMDTextContainer;

type
  TLMDTextCustomLabel = class(TLMDBaseGraphicControl{Label})
  private
    // RM
    FContainer:TLMDTextContainer;
    FIndex:Integer;
    FChangeLink:TLMDTextChangeLink;
    FCheck:Boolean;
    FAlignment        : TLMDAlignment;
    // ---
    FText         : TLMDTextObject;
    FLines        : TLMDStrings;
    FDBControl,
    FWordWrap     : Boolean;
    FOnLinkClick  : TLMDLinkClickEvent;
    FOnGetVariable: TLMDGetVariableEvent;
    FOnRepeat     : TLMDRepeatEvent;
    procedure SetAlignment (aValue : TLMDAlignment);
    procedure SetWordWrap (aValue : Boolean);
    procedure SetTextObject (aValue : TLMDTextObject);
    procedure SetLines (aValue : TLMDStrings);
    // RM
    procedure SetContainer(aValue:TLMDTextContainer);
    procedure SetIndex(aValue:Integer);
    // --
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
  protected
    procedure AdjustSize; override;  // available from Delphi 5 on

    function  GetLabelText:string; virtual;
    procedure Loaded; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoLinkClick(aButton: TMouseButton; aShift: TShiftState; const aLinkText:string);
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt); virtual;
    function  DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DoRepeat(Sender: TObject; aNumber : LongInt); virtual;
    procedure DoTxtChange(Sender: TObject);
    // RM
    function  GetEmpty:Boolean;override;
    function  LinkEmpty:Boolean;
    // --
    property  Lines : TLMDStrings read FLines write SetLines;
    procedure OnlyReParse;
    procedure Paint; override;
    function  GetThemedTextColor: TColor;
  public
    procedure ReParse;
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    property DBControl:Boolean read FDBControl write FDBControl; {only for internal use}
  published
    property About;
    property Alignment:TLMDAlignment read FAlignment write SetAlignment default agTopLeft;
//    property BackFX;
    property Font;
    property ImageList;
    property ListIndex;
    property ImageIndex;
    property PopupMenu;
    property ParentFont;
    property Hint;
    property ShowHint;
    property Transparent;
    property ParentShowHint;
    property ParentColor;
    property Visible;
    property Align;
    property AutoSize;
    property WordWrap : Boolean read FWordWrap write SetWordWrap default true;
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnLinkClick: TLMDLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
    property OnRepeat: TLMDRepeatEvent read FOnRepeat write FOnRepeat;
    // RM
    property TextContainer:TLMDTextContainer read FContainer write SetContainer;
    property TextIndex:Integer read FIndex write SetIndex default 0;
    property CheckContainerLinks:Boolean read FCheck write FCheck default false;
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
  end;

implementation
uses
  LMDGraphUtils;
{************************ TLMDTextCustomLabel *********************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDTextCustomLabel.SetAlignment(aValue:TLMDAlignment);
begin
  if aValue<>FAlignment then
    begin
      FAlignment:=aValue;
      DoTxtChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.SetWordWrap (aValue : Boolean);
begin
  if FWordWrap <> aValue then
    begin
      FWordWrap := aValue;
      DoTxtChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.SetLines (aValue : TLMDStrings);
begin
  FLines.Assign (aValue);
end;
// RM
{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.SetContainer(aValue:TLMDTextContainer);
begin
  if FContainer<>nil then
    FContainer.UnRegisterChanges(FChangeLink);
  FContainer:=aValue;
  if FContainer<>nil then
    begin
      FContainer.RegisterChanges(FChangeLink);
      FContainer.FreeNotification(Self);
    end;
  DoTxtChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    begin
      FIndex:=aValue;
      if Assigned(FContainer) then DoTxtChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.CMFontChanged(var Message:TMessage);
begin
  inherited;
  Invalidate;
end;

{ -------------------------- protected --------------------------------------- }
function TLMDTextCustomLabel.GetLabelText:string;
begin
  if LinkEmpty then
    result:=FLines.Text
  else
    result:=FContainer.Items[FIndex].Lines.Text;
end;

function TLMDTextCustomLabel.GetThemedTextColor: TColor;
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

{------------------------------------------------------------------------------}
function TLMDTextCustomLabel.GetEmpty:Boolean;
begin
  result:=Transparent and (GetLabelText='');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
  FText.MouseMove (self, Shift, X, Y, AutoSize, FWordWrap, Font, Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  FText.MouseDown (self, Button, Shift, X, Y,AutoSize, FWordWrap, Font, Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.DoLinkClick(aButton: TMouseButton; aShift: TShiftState;
  const aLinkText: string);
var
  tmp:Integer;
begin
  // RM !!
  if FCheck and not LinkEmpty then
    begin
      tmp:=FContainer.GetNamedIndex(aLinkText);
      if tmp>-1 then
        begin
          TextIndex:=tmp;
          Exit;
        end;
    end;
  if Assigned (FOnLinkClick) then
    FOnLinkClick (aButton, aShift, aLinkText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.DoGraphicError(Sender: TObject; aPicture: TPicture;
           const aFileName: String; aImageIndex: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextCustomLabel.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.DoRepeat (Sender: TObject; aNumber : LongInt);
begin
  if Assigned (FOnRepeat) then FOnRepeat (self, aNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.AdjustSize;
var
  aRect : TRect;
begin
  if (not AutoSize) {or (csLoading in ComponentState)} then exit;
  aRect := ClientRect;
  aRect := FText.GetClientRect (Canvas, aRect, Font, true, false);
  //make the rect one pixel larger than the text will need
  //otherwise the size will be somewhat to small
  InflateRect (aRect, 2, 2);
  SetBounds (Left, Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.DoTxtChange (Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  OnlyReParse;
  InvalidateControl;
  AdjustSize;
end;

{ ---------------------------------------------------------------------------- }
function  TLMDTextCustomLabel.LinkEmpty:Boolean;
begin
  result:=not ((FContainer<>nil) and (FIndex<FContainer.Count));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.OnlyReParse;
begin
  FText.Parse (GetLabelText);
end;

{ ------------------------ public -------------------------------------------- }
procedure TLMDTextCustomLabel.ReParse;
begin
  DoTxtChange(self);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextCustomLabel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FAlignment := agTopLeft;
  FWordWrap := true;

  FText := TLMDTextObject.Create;
  FText.OnLinkClick := DoLinkClick;
  FText.OnGraphicError := DoGraphicError;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
  FText.OnRepeat := DoRepeat;

  FLines := TLMDStrings.Create;
  FLines.OnChange := DoTxtChange;

  // RM
  FChangeLink:=TLMDTextChangeLink.Create;
  FChangeLink.OnChange:=DoTxtChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextCustomLabel.Destroy;
begin
  FreeAndNil(FChangeLink);
  FreeAndNil(FLines);
  FreeAndNil(FText);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.Paint;
var
  cRect,
  aRect,
  bRect:  TRect;
  myFont: TFont;
begin
  if GetEmpty then
  begin
    inherited Paint;
    Exit;
  end;

  myFont := TFont.Create;
  try
    myFont.Assign(self.Font);
    myFont.Color := GetThemedTextColor;
    Canvas.Font  := myFont;

    if not Transparent then
      FillControl;
    aRect := ClientRect;
    cRect := aRect;
    OffsetRect(cRect, -aRect.Left, -aRect.Top);
    bRect := FText.GetClientRect(Canvas, cRect, Font, false, FWordWrap);
    bRect := LMDAlignRect(Alignment, bRect, aRect);

    FText.Render(Canvas, aRect, bRect.TopLeft, myFont, Color, false, FWordWrap)
  finally
    myFont.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomLabel.Loaded;
begin
  inherited Loaded;
  DoTxtChange (nil);
end;

end.
