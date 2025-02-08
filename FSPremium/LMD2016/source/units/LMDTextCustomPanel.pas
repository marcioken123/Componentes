unit LMDTextCustomPanel;
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

LMDTextCustomPanel unit (JH)
----------------------------

Panel component which displays formatted text

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Themes,
  LMDClass, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDProcs,
  LMDGraphUtils, LMDCustomParentPanel, LMDCustomPanelFill, LMDTextObject,
  LMDGraph, LMDText, LMDTextContainer;

type
  TLMDTextCustomPanel = class(TLMDCustomPanelFill)
  private
    // RM
    FContainer:TLMDTextContainer;
    FIndex:Integer;
    FChangeLink:TLMDTextChangeLink;
    FCheck:Boolean;
    // ---
    FBaseURL         : string;
    FText            : TLMDTextObject;
    FLines           : TLMDStrings;
    FWordWrap        : Boolean;
    FDrawFont        : TFont;
    FOnLinkClick     : TLMDLinkClickEvent;
    FOnGetVariable   : TLMDGetVariableEvent;
    FOnRepeat        : TLMDRepeatEvent;
    FOnControlCreated: TLMDEmbdControlEvent;

    procedure SetTextObject (aValue : TLMDTextObject);
    procedure SetLines (aValue : TLMDStrings);
    // RM
    procedure SetContainer(aValue:TLMDTextContainer);
    procedure SetIndex(aValue:Integer);
    // --
  protected
    //procedure AdjustSize; override; //Todo?
    // modified for Container Support!
    procedure DoLinkClick(aButton: TMouseButton; aShift: TShiftState; const aLinkText: string);
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
    function DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DoRepeat(Sender: TObject; aNumber : LongInt);
    procedure DoControlCreated (Sender: TObject; AControl: TControl; const AName: string); virtual;
    procedure DrawCaption(aRect: TRect; aAlignment:TLMDAlignment); override;
    function  GetThemedTextColor: TColor;

    // modfied for container support!
    procedure DoTxtChange (Sender: TObject); virtual;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetParent(AParent: TWinControl); override;
    // RM
    function  GetEmpty:Boolean;override;
    function  GetTextLines:TLMDStrings;
    function  LinkEmpty:Boolean;
    // --
    property WordWrap : Boolean read FWordWrap write FWordWrap default true;
    property AutoSize;
    property Lines : TLMDStrings read FLines write SetLines;
    property OnLinkClick: TLMDLinkClickEvent read FOnLinkClick write FOnLinkClick;
  public
    procedure ReParse;
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure LoadFromFile(const FileName: string);
    // RM
    property TextContainer:TLMDTextContainer read FContainer write SetContainer;
    property TextIndex:Integer read FIndex write SetIndex default 0;
    property CheckContainerLinks:Boolean read FCheck write FCheck default false;
    // ---
  published
    property About;
    property BackFX;
    property Bevel;
    property Color;
    property Font;
    property ImageList;
    property ListIndex;
    property ImageIndex;
    property FillObject;
    property PopupMenu;
    property ParentFont;
    property Hint;
    property ShowHint;
    property Transparent;
    property ParentShowHint;
    property ParentColor;
    property Visible;
    property Align;

    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
    property OnControlCreated : TLMDEmbdControlEvent read FOnControlCreated write FOnControlCreated;
    property OnRepeat: TLMDRepeatEvent read FOnRepeat write FOnRepeat;

   // V4 enhancements
    property Anchors;
    property Constraints;
    property UseDockManager default True;
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

    // default events
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  dialogs;
  {$I C2.INC}
{$ENDIF}

{************************ TLMDTextCustomPanel *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDTextCustomPanel.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.SetLines (aValue : TLMDStrings);
begin
  FLines.Assign (aValue);
end;

// RM
{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.SetContainer(aValue:TLMDTextContainer);
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
procedure TLMDTextCustomPanel.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    begin
      FIndex:=aValue;
      if Assigned(FContainer) then DoTxtChange(nil);
    end;
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDTextCustomPanel.DoLinkClick(aButton: TMouseButton; aShift: TShiftState;
  const aLinkText: string);
var
  tmp:Integer;
  C: string;
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
    end
  else
  if  FCheck and (FBaseURL <> '') then
    begin
      GetDir(0, C);
      try
        ChDir(FBaseURL);

        if  FileExists(aLinkText) then
          self.LoadFromFile(aLinkText);
      finally
        ChDir(C);
      end;
    end;

  if Assigned (FOnLinkClick) then
    FOnLinkClick (aButton, aShift, aLinkText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.DoGraphicError(Sender: TObject; aPicture: TPicture;
  const aFileName: String; aImageIndex: LongInt);
var
  C: string;
begin
  if  FBaseURL <> ''  then
    begin
      GetDir(0, C);
      try
        ChDir(FBaseURL);

        if  FileExists(aFileName) then
          aPicture.LoadFromFile(aFileName);
      finally
        ChDir(C);
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextCustomPanel.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.DoRepeat(Sender: TObject; aNumber : LongInt);
begin
  if Assigned (FOnRepeat) then FOnRepeat (Sender, aNumber);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.DoControlCreated (Sender: TObject; AControl: TControl;
  const AName: string);
begin
  if Assigned (FOnControlCreated) then FOnControlCreated (self, AControl, AName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
var
  cRect,
  bRect : TRect;
begin
  cRect := aRect;
  OffsetRect (cRect, -aRect.Left, -aRect.Top);
  bRect := FText.GetClientRect(Canvas, cRect, Font, false, FWordWrap);
  bRect := LMDAlignRect (Alignment, bRect, aRect);

  FDrawFont.Assign(Font);
  FDrawFont.Color := GetThemedTextColor;

  FText.Render(Canvas, aRect, bRect.TopLeft, FDrawFont,
               Color, AutoSize, FWordWrap)
end;

// RM
{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.DoTxtChange (Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  FText.Parent := self;
  FText.Parse(GetTextLines);
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextCustomPanel.LinkEmpty:Boolean;
begin
  result:=not ((FContainer<>nil) and (FIndex<FContainer.Count));
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextCustomPanel.GetTextLines:TLMDStrings;
begin
  if LinkEmpty then
    result:=FLines
  else
    result:=FContainer.Items[FIndex].Lines;
end;

function TLMDTextCustomPanel.GetThemedTextColor: TColor;
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
procedure TLMDTextCustomPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
  FText.MouseMove (self, Shift, X, Y, AutoSize, FWordWrap, Font, Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  FText.MouseDown (self, Button, Shift, X, Y,AutoSize, FWordWrap, Font, Canvas);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomPanel.SetParent(AParent: TWinControl);
begin
  inherited SetParent (AParent);
  //FText.Parent := AParent;
end;

{ ------------------------ public -------------------------------------------- }
procedure TLMDTextCustomPanel.ReParse;
begin
  DoTxtChange(self);
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextCustomPanel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);

  FWordWrap := true;
  FContainer:=nil;
  FIndex:=0;

  FText := TLMDTextObject.CreateExt (self, parent);
  FText.OnLinkClick := DoLinkClick;
  FText.OnGraphicError := DoGraphicError;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
  FText.OnControlCreated := DoControlCreated;
  FText.OnRepeat := DoRepeat;

  FLines := TLMDStrings.Create;
  FLines.OnChange := DoTxtChange;

  FDrawFont := TFont.Create;

  // RM
  FChangeLink:=TLMDTextChangeLink.Create;
  FChangeLink.OnChange:=DoTxtChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextCustomPanel.Destroy;
begin
  FreeAndNil(FChangeLink);
  FreeAndNil(FLines);
  FreeAndNil(FText);
  FreeAndNil(FDrawFont);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDTextCustomPanel.GetEmpty;
begin
  result:=inherited GetEmpty and (FLines.Count=0) and LinkEmpty;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDTextCustomPanel.Loaded;
begin
  inherited Loaded;
  DoTxtChange (nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDTextCustomPanel.LoadFromFile(const FileName: string);
begin
  FBaseURL := ExtractFilePath(ExpandFileName(FileName));
  FLines.LoadFromFile(FileName);
end;

{ ---------------------------------------------------------------------------- }

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
