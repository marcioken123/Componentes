unit LMDTextListBox;
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

LMDTextListBox unit (JH)
------------------------

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
  StdCtrls, LMDCustomImageListBox, LMDTextObject, LMDText;

type
  TLMDTextListBox = class(TLMDCustomImageListBox)
  private
    FText : TLMDTextObject;
    FWordWrap : Boolean;
    FOnGetVariable: TLMDGetVariableEvent;
    procedure SetTextObject (aValue : TLMDTextObject);
  protected
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String;
      aImageIndex: LongInt);
    function DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DoTxtChange (Sender: TObject);
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    published
    property Items;
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;

    property GlyphNumber;
    property GlyphColumn;
    property ItemIndex default -1;
    property ImageList;
    property ListIndex;

    property Layout;
    property ImagesOnly;
    property MultiLine;

    // 6.1 additions
    property Margin;
    property Columns;
    property LargeTextOptions;
    property VerticalScrollBar;
    property HorzGridColor;
    property HorzGridStyle;
    property HorzGridLine;

    property EditOptions;
    // Event for internal edit control
    property OnEditShow;
    property OnEditMeasure;
    property OnEditChange;
    property OnEditHide;

    property AutoComplete;
    property VirtualMode;

    property OnData;
    property OnDataObject;
    property OnDataFind;
  end;

implementation

{ ------------------------------------ private ------------------------------- }
procedure TLMDTextListBox.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ----------------------------------- protected ------------------------------- }
procedure TLMDTextListBox.DoGraphicError(Sender: TObject; aPicture: TPicture;
  const aFileName: String; aImageIndex: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextListBox.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextListBox.DoTxtChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  cRect: TRect;
  s : String;
begin
  if csLoading in ComponentState then exit;
  if Index >= Items.Count then exit;

  cRect := Rect;
  OffsetRect (cRect, -Rect.Left, -Rect.Top);
  s := Items[Index] + #10;
  FText.Parse (s);
  FText.Render (Canvas, Rect, Point (0,0), Canvas.Font, Color, true, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextListBox.MeasureItem(Index: Integer; var Height: Integer);
var
  bRect : TRect;
  s : String;
begin
  if csLoading in ComponentState then exit;
  s := Items[Index] + #10;
  FText.Parse (s);
  bRect := Rect (0, 0, Width, ItemHeight);
  bRect := FText.GetClientRect(Canvas, bRect, Font, true, FWordWrap);
  Height := bRect.Bottom - bRect.Top;
//  Height := 20;
end;

{ ------------------------ public -------------------------------------------- }
constructor TLMDTextListBox.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FWordWrap := true;
  FText := TLMDTextObject.Create(true);
  //FText.OnLinkClick := DoLinkClick;
  FText.OnGraphicError := DoGraphicError;
  FText.OnGetVariable:=DoGetVariable;
  FText.OnChange := DoTxtChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextListBox.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextListBox.Loaded;
begin
  inherited Loaded;
  if lboCalcHeight in Options then RecreateWnd;
end;

end.
