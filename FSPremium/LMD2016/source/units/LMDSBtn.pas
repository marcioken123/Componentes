unit LMDSBtn;
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

LMDSBtn unit ()
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls, ImgList, LMDPNGImage,
  LMDClass, LMDGraph, LMDButtonLayout, LMDSpeedButton, LMDFXCaption;

type
  TLMDOnCustomBtnClick = procedure (Sender : TObject;index : Integer) of object;

  {---------------------TLMDSpecialButton--------------------------------------}
  TLMDSpecialButton = class (TCollectionItem)
  private
    FHint,
    FCaption : String;
    FGlyph   : TBitmap;
    FCursor  : TCursor;
    FGroupIndex : Integer;
    FParentFont,
    FEnabled : Boolean;
    FOnClick : TLMDOnCustomBtnClick;
    FLayout  : TLMDButtonLayout;
    FFont    : TFont;
    FFontFX  : TLMDFXCaption;
    FThemeMode: TLMDThemeMode;
    FPngGlyph: TLMDPngObject;
    FUsePngGlyph: boolean;

    procedure SetEnabled (aValue : Boolean);
    procedure SetString (index : integer;aValue : String);
    procedure SetGlyph (aValue : TBitmap);
    procedure SetBtn (aValue : TLMDSpeedButton);
    procedure SetCursor (aValue : TCursor);
    procedure SetLayout (aValue : TLMDButtonLayout);
    procedure SetFont (aValue : TFont);
    procedure SetFontFX (aValue : TLMDFXCaption);
    procedure SetInteger (aValue : Integer);
    procedure SetParentFont (aValue : Boolean);
    function GetParentFont : Boolean;
    procedure DoOnClick (Sender : TObject);
    procedure GetChange (Sender : TObject);
    function GetPressed: Boolean;
    procedure SetPressed(const Value: Boolean);
    procedure SetCtlXP(const Value: Boolean);
    function GetCtlXP: Boolean;
    function GetAllowAllUp: Boolean;
    procedure SetAllowAllUp(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure ReadCtlXP(Reader:TReader);
    function GetImageIndex: integer;
    function GetImageList: TCustomImageList;
    function GetListIndex: integer;
    procedure SetImageIndex(const Value: integer);
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetListIndex(const Value: integer);
    procedure SetPngGlyph(const Value: TLMDPngObject);
    procedure SetUsePngGlyph(const Value: boolean);
    function GetUsePngGlyph: boolean;
  protected
    FBtn     : TLMDSpeedButton;
    procedure DefineProperties(Filer:TFiler); override;
    procedure CreateButtonControl; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure DoClick;
    property Btn : TLMDSpeedButton read FBtn write SetBtn;
    property Pressed:Boolean read GetPressed write SetPressed default false;
    property CtlXP:Boolean read GetCtlXP write SetCtlXP default false;  // compatibility
  published
    property AllowAllUp:Boolean read GetAllowAllUp write SetAllowAllUp default false;
    property Caption : String index 0 read FCaption write SetString;
    property Cursor : TCursor read FCursor write SetCursor default crArrow;
    property Hint : String index 1 read FHint write SetString;
    property Glyph : TBitmap read FGlyph write SetGlyph;
    property Enabled : Boolean read FEnabled write SetEnabled default true;
    property Layout : TLMDButtonLayout read FLayout write SetLayout;
    property ParentFont : Boolean read GetParentFont write SetParentFont default true;
    property PngGlyph: TLMDPngObject read FPngGlyph write SetPngGlyph;
    property Font : TFont read FFont write SetFont;
    property FontFX : TLMDFXCaption read FFontFX write SetFontFX;
    property GroupIndex : Integer read FGroupIndex write SetInteger default 0;
    property Index;
    property DisplayName;
    property ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmNone;

    property ImageList: TCustomImageList read GetImageList write SetImageList;
    property ImageIndex : integer read GetImageIndex write SetImageIndex;
    property ListIndex: integer read GetListIndex write SetListIndex; 
    //property ThemeGlobalMode;
    property OnClick : TLMDOnCustomBtnClick read FOnClick write FOnClick;
    property UsePngGlyph  : boolean read GetUsePngGlyph write SetUsePngGlyph;
  end;

  {---------------------TLMDSpecialButtons-------------------------------------}
  TLMDSpecialButtons = class (TCollection)
  private
    FOwner  : TWinControl;
    FInform : Boolean;
    FOnChange:TNotifyEvent;
    function GetItem(Index: Integer): TLMDSpecialButton;
    procedure SetItem(Index: Integer; Value: TLMDSpecialButton);
  protected
    procedure Change;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    function GetButtonClass: TCollectionItemClass; virtual;
  public
    constructor Create(Owner : TWinControl; inform : Boolean); virtual;
    destructor Destroy; override;
    function Add: TLMDSpecialButton; virtual;
    property Items[Index: Integer]: TLMDSpecialButton read GetItem write SetItem; default;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
  SysUtils, Variants, Messages,
  LMDCustomEdit, LMDButtonPanel;

  type
    TLMDCEditCracker = class (TLMDCustomEdit)
    public
    end;

{ *************** TLMDSpecialButton ******************************************** }
{ --------------- private ---------------------------------------------------- }
procedure TLMDSpecialButton.SetString (index : Integer;aValue : String);
begin
  case index of
    0 : begin
          FCaption := aValue;
          FBtn.Caption := FCaption;
        end;
    1 : begin
          FHint := aValue;
          FBtn.Hint := FHint;
        end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetThemeMode(const Value: TLMDThemeMode);
begin
  FThemeMode := Value;
  if Assigned(FBtn) then
    FBtn.ThemeMode := Value;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetGlyph (aValue : TBitmap);
begin
  FGlyph.Assign (aValue);
  FBtn.Glyph:= (FGlyph);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetAllowAllUp(const Value: Boolean);
begin
  FBtn.AllowAllUp:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetBtn (aValue : TLMDSpeedButton);
begin
  FBtn.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetEnabled (aValue : Boolean);
begin
  FEnabled := aValue;
  FBtn.Enabled := FEnabled;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetCursor (aValue : TCursor);
begin
  FCursor := aValue;
  FBtn.Cursor := FCursor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetLayout (aValue : TLMDButtonLayout);
begin
  FLayout.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetFontFX (aValue : TLMDFXCaption);
begin
  FFontFX.Assign (aValue);
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetInteger (aValue : Integer);
begin
  FGroupIndex := aValue;
  FBtn.GroupIndex := aValue;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetParentFont (aValue : Boolean);
begin
  FParentFont := aValue;
  FBtn.ParentFont := aValue;
end;

{ ----------------------------------------------------------------------------- }
function TLMDSpecialButton.GetParentFont : Boolean;
begin
  result := FBtn.ParentFont;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.DoOnClick (Sender : TObject);
begin
  if Assigned (FOnClick) then FOnClick (self, index);
  if TLMDSpecialButtons(Collection).GetOwner is TLMDCustomEdit then
    TLMDCEditCracker((TLMDSpecialButtons(Collection).GetOwner as TLMDCustomEdit)).DoAClick (FBtn, index);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetAllowAllUp: Boolean;
begin
  result:=FBtn.AllowAllUp;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.GetChange (Sender : TObject);
begin
  FBtn.Glyph := FGlyph;
  FBtn.ButtonLayout.Assign (FLayout);
  FBtn.FontFX.Assign (FFontFX);
  FBtn.Font.Assign (FFont);
  FBtn.PngGlyph := FPngGlyph;
  FBtn.UsePngGlyph := FUsePngGlyph;
  Changed (false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetCtlXP: Boolean;
begin
  result:= FBtn.ThemeMode = ttmPlatForm;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetPressed: Boolean;
begin
  result:=FBtn.Pressed;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.ReadCtlXP(Reader: TReader);
begin
  SetCtlXP(Reader.ReadBoolean);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetPressed(const Value: Boolean);
begin
 FBtn.Pressed:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetCtlXP(const Value: Boolean);
begin
  if Value <> GetCtlXP then
    FBtn.ThemeMode := LMDCtlXP[Value];
end;

{ ---------------------- protected ------------------------------------------- }
procedure TLMDSpecialButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDSpecialButton.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FThemeMode := ttmNone;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GetChange;
  FPngGlyph := TLMDPngObject.Create;
  FPngGlyph.OnChange := GetChange;
  FEnabled := true;
  FCursor := crArrow;
  FLayout := TLMDButtonLayout.Create;
  FLayout.OnChange := GetChange;
  FGroupIndex := 0;

  FFont := TFont.Create;
  FFont.OnChange := GetChange;

  FParentFont := true;

  FFontFX := TLMDFXCaption.Create;
  FFontFX.OnChange := GetChange;

  CreateButtonControl;  
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialButton.Destroy;
begin
  FFontFX.OnChange := nil;
  FFontFX.Free;
  FFont.OnChange := nil;
  FFont.Free;
  FLayout.OnChange := nil;
  FLayout.Free;
  if Assigned(FBtn) then
  begin
  FBtn.OnClick := nil;
    FreeAndNil(FBtn);
  end;
  FGlyph.OnChange := nil;
  FGlyph.Free;
  FPngGlyph.OnChange := nil;
  FPngGlyph.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.Assign(Source: TPersistent);
var
  S: TLMDSpecialButton;
begin
  if Source = self then exit;
  if (Source is TLMDSpecialButton) then
    begin
      S := TLMDSpecialButton(Source);
      Caption := S.Caption;
      Hint := S.Hint;
      Glyph.Assign (S.Glyph);
      Enabled := S.Enabled;
      Cursor :=  S.Cursor;
      GroupIndex := S.GroupIndex;
      Layout.Assign (S.Layout);
      Font.Assign (S.Font);
      FontFX.Assign (S.FontFX);
      ParentFont := S.ParentFont;
      FOnClick := S.OnClick;
      UsePngGlyph := S.UsePngGlyph;
      PngGlyph.Assign(S.PngGlyph);
      if FBtn <> nil then
        FBtn.PngGlyph := PngGlyph;
      ImageList := S.ImageList;
      ImageIndex := S.ImageIndex;
      ListIndex := S.ListIndex;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.DoClick;
begin
  DoOnClick (FBtn);
end;

{ ******************* TLMDSpecialButtons ************************************* }
function TLMDSpecialButtons.GetItem(Index: Integer): TLMDSpecialButton;
begin
  result := TLMDSpecialButton(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButtons.SetItem(Index: Integer; Value: TLMDSpecialButton);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButtons.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButtons.Update(Item: TCollectionItem);
begin
  Change;
  if FInform and (FOwner is TLMDButtonPanel) then
    TLMDButtonPanel(FOwner).SetBorders;
  if FInform and (FOwner is TLMDCustomEdit) then
    if FOwner.HandleAllocated then
      begin
        PostMessage(FOwner.Handle, WM_SIZE, SIZE_RESTORED, 0);
      end;
//  if Item <> nil then
//    FNavigator.SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButtons.Change;
begin
  if Assigned(FOnChange) then FOnChange(self);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSpecialButtons.Create(Owner: TWinControl; Inform : Boolean);
begin
  inherited Create(GetButtonClass);
  FOwner := Owner;
  FInform := Inform;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialButtons.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButtons.Add: TLMDSpecialButton;
begin
  result := TLMDSpecialButton(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetImageIndex: integer;
begin
  result := FBtn.ImageIndex;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetImageList: TCustomImageList;
begin
  result := FBtn.ImageList;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButton.GetListIndex: integer;
begin
  result := FBtn.ListIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetImageIndex(const Value: integer);
begin
  FBtn.ImageIndex := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetImageList(const Value: TCustomImageList);
begin
  FBtn.ImageList := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetListIndex(const Value: integer);
begin
  FBtn.ListIndex := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetPngGlyph(const Value: TLMDPngObject);
begin
  FPngGlyph.Assign (Value);
  FBtn.PngGlyph := FPngGlyph;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetUsePngGlyph(const Value: boolean);
begin
  FUsePngGlyph := Value;
  FBtn.UsePngGlyph := FUsePngGlyph;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButtons.GetButtonClass: TCollectionItemClass;
begin
  result := TLMDSpecialButton;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.CreateButtonControl;
begin
  FBtn := TLMDSpeedButton.Create(TWinControl(TLMDSpecialButtons(Collection).GetOwner));
  //FBtn.CtlXP:=False;
  FBtn.ThemeMode := ThemeMode;
  FBtn.Parent := TWinControl(TLMDSpecialButtons(Collection).GetOwner);
  FBtn.OnClick := DoOnClick;
  FBtn.Enabled := true;
  FBtn.Color := clBtnFace;
  FBtn.Cursor := crArrow;
  FBtn.Tag := index;
  FBtn.HideHint := false;
end;


function TLMDSpecialButton.GetUsePngGlyph: boolean;
begin
  result := FUsePngGlyph;
end;

end.
