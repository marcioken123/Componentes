unit LMDCustomButtonGroup;
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

LMDCustomButtonGroup unit (RM)
------------------------------
Base class for all button group components (CheckGroup, RadioGroup etc.)

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ImgList,
  LMDCont, LMDBaseController, LMDGraph, LMD3DCaption, LMDButtonControl,
  LMDGlyphTextLayout, LMDCustomGroupBox, LMDCustomImageList;

type
  TLMDChildHelpContextID = (ciDefault, ciSameAsParent, ciAutoNumbered);
  TLMDChildBtnClick = procedure (Sender: TObject; ButtonIndex:Integer) of object;

  TLMDCustomButtonGroup = class(TLMDCustomGroupBox)
  private
    FBtnAlignment      : TLMDGlyphTextLayout;
    FItemHeight,
    FitemOffset        : Integer;
    FColumns           : Integer;
    FFlatGlyphs,
    FGlyphFlat,
    FUseBitmap,
    FUseFocusColor,
    FReadOnly          : Boolean;
    FFont3D            : TLMD3DCaption;
    FFocusStyle        : TLMDGlyphTextFocusStyle;
    FFocusColor        : TColor;
    FOnChange          : TLMDChildBtnClick;

    {second imagelist support}
    FGlyphImageList    : TCustomImageList;
    FGlyphListIndex    : Integer;
    FGlyphChangeLink   : TChangeLink;
    FIgnoreItemCount   : Boolean;
    FMultiLine         : Boolean;
    procedure SetGlyphImageList(aValue:TCustomImageList);
    procedure SetGlyphIndex(index, aValue:Integer);
    {saving}
    procedure ReadGIdent(Reader:TReader);
    procedure WriteGIdent(Writer:TWriter);
    function  CheckGCont:Boolean;
    function HasGControl:Boolean;
    {----  }
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetColumns(aValue: Integer);
    procedure SetItems(aValue: TStringList);
    procedure SetItemHeight(aValue:Integer);
    procedure SetItemOffset(aValue:Integer);
    procedure SetID(aValue:TLMDChildHelpContextID);
    procedure SetFocusColor(aValue:TColor);
    procedure SetUseFocusColor(aValue:Boolean);
    procedure SetGlyphFlat(aValue:Boolean);
    procedure SetIgnore(const aValue:Boolean);
    procedure SetGlyphSize(aValue:Byte);
    procedure SetFlatGlyphs (aValue : Boolean);
    procedure SetBtnAlignment (aValue : TLMDGlyphTextLayout);
    procedure SetMultiline(const Value: Boolean);
    procedure SetTransparent(aValue:Boolean);
    procedure SetFocusStyle(aValue:TLMDGlyphTextFocusStyle);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetTransparentColor(aValue:TColor);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FUpdating,
    FGlyphTransparent,
    FReading           : Boolean;
    FResult            : LongInt;
    FButtons           : TList;
    FGlyphIndex        : Integer;
    FItems             : TStringList;
    FGlyphSize         : Byte;
    FTransparentColor  : TColor;
    FID                : TLMDChildHelpContextID;

    // 6.1
    procedure DoThemeChanged;override;
    // ---

    procedure ArrangeButtons;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure ReadState(Reader: TReader); override;
    procedure GetChange(Sender:TObject);override;
    procedure Loaded;override;
    procedure SetButtonCount(aValue: Integer); virtual; abstract;
    procedure UpdateButtons; virtual; abstract;
    function GetFieldValue:LongInt; virtual;

    {second imagelist support}
    function IMLGlyphEmpty:Boolean;
    procedure GetIMLGlyphChange(Sender:TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;

    {end}
    property Columns: Integer read FColumns write SetColumns default 1;

    {additional settings for internal buttons}
    property FocusStyle:TLMDGlyphTextFocusStyle read FFocusStyle write SetFocusStyle default fcText;
    property GlyphTransparent:Boolean read FGlyphTransparent write SetTransparent default false;
    property GlyphTransparentColor:TColor read FTransparentColor write SetTransparentColor default clOlive;
    property GlyphSize:Byte read FGlyphSize write SetGlyphSize;
    property GlyphFlat:Boolean read FGlyphFlat write SetGlyphFlat default false;

    property UseBitmap:Boolean read FUseBitmap write FUseBitmap default false;
    {-----}
    property ItemHeight: Integer read FItemHeight write SetItemHeight default -1;
    property ItemOffset: Integer read FItemOffset write SetItemOffset default 4;
    // 6.1
    property IgnoreValue:Boolean read FIgnoreItemCount write SetIgnore default false;
    // ---
    property FlatGlyphs : Boolean read FFlatGlyphs write SetFlatGlyphs default false;
    //allow formatting of buttoncontrol glyph and text within a group
    property BtnAlignment : TLMDGlyphTextLayout read FBtnAlignment write SetBtnAlignment;

    // 7.1
    property MultiLine:Boolean read FMultiLine write SetMultiline default true;
    // ----
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    // 6.1
    //procedure BeginUpdate;  // allows changes without generating OnChange events
    procedure EndUpdate(aValue:Boolean=false);override;
    // ---

    function CanModify: Boolean; virtual;
    property Buttons:TList read FButtons;
    //internal functions
    procedure RegisterButton (btn : TLMDButtonControl);
    procedure UnRegisterButton (btn : TLMDButtonControl);

    property Bevel;
    property Items: TStringList read FItems write SetItems;
    property GlyphImageList:TCustomImageList read FGlyphImageList write SetGlyphImageList stored HasGControl;
    property GlyphImageIndex:Integer index 0 read FGlyphIndex write SetGlyphIndex default 0;
    property GlyphListIndex:Integer index 1 read FGlyphListIndex write SetGlyphIndex default 0;
    property Font;
    property Font3D:TLMD3DCaption read FFont3D write SetFont3D;
    property Caption;
    property CaptionFont;
    property CaptionFont3D;
    property HelpContextBtn:TLMDChildHelpContextID read FID write SetID default ciDefault;
    property Transparent;
    property ImageList;
    property ImageIndex;
    property ListIndex;

    property ReadOnly:Boolean read FReadOnly write FReadOnly default false;
    property UseFocusColor:Boolean read FUseFocusColor write SetUseFocusColor default false;
    property FocusColor:TColor read FFocusColor write SetFocusColor default clGray;
    property OnChange:TLMDChildBtnClick read FOnChange write FOnChange;
  end;

implementation

uses
  RtlConsts, Types, Consts, SysUtils,
  LMDClass, LMDBase, LMDCustomRadioGroup, LMDCustomCheckGroup, LMDCustomCheckBox, LMDProcs;

{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomButtonGroup.SetColumns(aValue: Integer);
begin
  if aValue<1 then aValue:=1;
  if aValue>32 then aValue:=32;
  if FColumns<>aValue then
    begin
      FColumns:=aValue;
      ArrangeButtons;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetItems(aValue: TStringList);
begin
  FItems.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetMultiline(const Value: Boolean);
begin
  if Value<>FMultiLine then
    begin
      FMultiLine := Value;
      ArrangeButtons;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetItemHeight(aValue: Integer);
begin
  if aValue<>FItemHeight then
    begin
      FItemHeight:=aValue;
      ArrangeButtons;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetItemOffset(aValue: Integer);
begin
  if aValue<>FItemOffset then
    begin
      FItemOffset:=aValue;
      ArrangeButtons;
    end;
end;

{imagelist}
{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetGlyphImageList(aValue:TCustomImageList);
begin
  if FGlyphImageList<>nil then
    FGlyphImageList.UnRegisterChanges(FGlyphChangeLink);
  FGlyphImageList:=aValue;
  if FGlyphImageList<>nil then
    begin
      FGlyphImageList.RegisterChanges(FGlyphChangeLink);
      FGlyphImageList.FreeNotification(Self);
    end;
  GetIMLGlyphChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetIgnore(const aValue:Boolean);
begin
  if FIgnoreItemCount<>aValue then
    begin
       FIgnoreItemCount:=aValue;
       If FIgnoreItemCount then
         FResult:=0;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.SetGlyphIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FGlyphIndex) or (aValue<0) then exit else FGlyphIndex:=aValue;
    1: if (aValue=FGlyphListIndex) or (aValue<0) then exit else FGlyphListIndex:=aValue;
  end;
  if FGlyphImageList<>nil then
    GetIMLGlyphChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.ReadGIdent(Reader:TReader);
begin
  SetGlyphImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.WriteGIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FGlyphImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.CheckGCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FGlyphImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.HasGControl:Boolean;
begin
  result:=(FGlyphImageList<>nil) and (FGlyphImageList.Owner<>LMDContainer);
end;

{end of imagelist}
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetTransparent(aValue:Boolean);
begin
  if aValue<>FGlyphTransparent then
    begin
      FGlyphTransparent:=aValue;
      GetIMLGlyphChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetFocusStyle(aValue:TLMDGlyphTextFocusStyle);
begin
  if aValue<>FFocusStyle then
    begin
      FFocusStyle:=aValue;
      if not (csDesigning in ComponentState) then GetIMLGlyphChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetFocusColor(aValue:TColor);
begin
  if aValue<>FFocusColor then
    begin
      FFocusColor:=aValue;
      if not (csDesigning in ComponentState) then GetIMLGlyphChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetUseFocusColor(aValue:Boolean);
begin
  if aValue<>FUseFocusColor then
    begin
      FUseFocusColor:=aValue;
      if not (csDesigning in ComponentState) then GetIMLGlyphChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetID;
var
  i:Integer;
begin
  if aValue<>FID then
    begin
      FID:=aValue;
      for i:=0 to Pred(FButtons.Count) do
         case FID of
           ciDefault:TLMDButtonControl(FButtons[i]).HelpContext:=0;
           ciSameAsParent:TLMDButtonControl(FButtons[i]).HelpContext:=self.HelpContext;
           ciAutoNumbered:TLMDButtonControl(FButtons[i]).HelpContext:=self.HelpContext+i+1;
         end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetGlyphFlat(aValue:Boolean);
var
  i:Integer;
begin
  if aValue<>FGlyphFlat then
    begin
      FGlyphFlat:=aValue;
      if not (csLoading in ComponentState) and IMLEmpty then
      for i:=0 to Pred(FButtons.Count) do
        TLMDButtonControl(FButtons[i]).GlyphFlat:=FGlyphFlat;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetGlyphSize(aValue:Byte);
var
  i:Integer;
begin
  if aValue<>FGlyphSize then
    begin
      FGlyphSize:=aValue;
      if not (csLoading in ComponentState) and IMLEmpty then
        begin
          for i:=0 to Pred(FButtons.Count) do
            TLMDButtonControl(FButtons[i]).GlyphSize:=FGlyphSize;
          ArrangeButtons;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetFlatGlyphs (aValue : Boolean);
var
  i : Integer;
begin
  if aValue <> FFlatGlyphs then
    begin
      FFlatGlyphs:=aValue;
      if not (csLoading in ComponentState) then
        begin
          for i:=0 to Pred(FButtons.Count) do
            TLMDButtonControl(FButtons[i]).Flat:=FFlatGlyphs;
          ArrangeButtons;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetBtnAlignment (aValue : TLMDGlyphTextLayout);
var
  i : Integer;
begin
  FBtnAlignment.Assign (aValue);
  //let's iterate throught all buttons and set the new layout
  for i:=0 to Pred(FButtons.Count) do
    TLMDButtonControl(FButtons[i]).Alignment.Assign (FBtnAlignment);
  //rearrange the buttons
  ArrangeButtons;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetFont3D (aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.SetTransparentColor(aValue:TColor);
begin
  if aValue<> FTransparentColor then
    begin
      FTransparentColor:=aValue;
      GetIMLGlyphChange(nil);
    end
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.ButtonClick(Sender: TObject);
var
  oResult,
  i:Integer;

  procedure Change;
  begin
    If not isUpdating then
      if Assigned(FOnChange) then FOnChange(self, FButtons.IndexOf(Sender));
  end;

begin
  if not FUpdating then
    begin

      oResult := FResult;
      if self is TLMDCustomRadioGroup then
        FResult:=FButtons.IndexOf(Sender)
      else
        begin
          FResult:=0;

          // 6.1
          if FIgnoreItemCount then
            begin
              Change;
              exit;
            end;
          for i:=0 to Pred(FButtons.Count) do
            if TLMDCustomCheckBox(FButtons[i]).Checked then Inc(FResult, LMDExp(2, i));
        end;
      if oResult <> FResult then
        begin
          Click;
          Change;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
begin
  inherited;
  for i:=0 to Pred(FButtons.Count) do
    TLMDButtonControl(FButtons[i]).Enabled:=Enabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

{-------------------------------- protected -----------------------------------}
procedure TLMDCustomButtonGroup.ArrangeButtons;
var
  i, w, h, bpc, bw, bh:Integer;
  aRect:TRect;
begin
  if FReading or (FButtons=nil) or (FButtons.Count=0) or IsUpdating then exit;
  i:=BevelExt;
  if Caption<>'' then h:=CaptionHeight else h:=0;
  case Alignment of
    gcaTopLeft,gcaTopCenter,gcaTopRight:
      aRect:=Rect(i, LMDMax([i, h]), Width-i, Height-i);
    gcaBottomLeft,gcaBottomCenter,gcaBottomRight:
      aRect:=Rect(i, i, Width-i, Height-LMDMax([i, h]));
    gcaLeftBottom,gcaLeftCenter,gcaLeftTop:
       aRect:=Rect(LMDMax([i, h]), i, Width-i, Height-i);
    gcaRightTop,gcaRightCenter,gcaRightBottom:
       aRect:=Rect(i, i, Width-LMDMax([i, h]), Height-i);
  end;

  InflateRect(aRect, -1, -1);

  w:=aRect.Right-aRect.Left-FItemOffset;
  h:=aRect.Bottom-aRect.Top-2;

  bpc:=(FButtons.Count+FColumns - 1) div FColumns;
  bw:=(w div FColumns)-1;
  if ItemHeight>-1 then bh:=FItemHeight else bh:=h div bpc;
  aRect.Top:=aRect.Top+1+(bh mod bpc) div 2;

  for i:=0 to Pred(FButtons.Count) do
    with TLMDButtonControl(FButtons[I]) do
      begin
        SetBounds((i div bpc)*bw+aRect.Left+FItemOffset, (i mod bpc)*bh+aRect.Top, bw, bh);
        Visible:=True;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  h:Integer;
begin
  result:=True;
  if (FButtons.Count=0) or (ItemHeight<1) then
    begin
      result:=false;
      exit;
    end;
  if Caption='' then h:=DblbevelExt else h:=CaptionHeight+Bevelext;
  NewHeight:=FButtons.Count*(ItemHeight+1)+h;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.CanModify: Boolean;
begin
  Result:=not FReadOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Glyph'+IDS_INTERNAL, ReadGIdent, WriteGIdent, CheckGCont);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.DoThemeChanged;
var
  i:Integer;
begin
  // RM - Themes
  //inherited DoThemeChanged;
  Invalidate;
  UpdateButtons;
  for i:=0 to ComponentCount-1 do
    TLMDButtonControl(Components[i]).Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.GetChange(Sender: TObject);
begin
  inherited GetChange(Sender);
  ArrangeButtons;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.IMLGlyphEmpty:Boolean;
begin
  result:=not ((FGlyphImageList<>nil) and LMDIMLIsValidItem(FGlyphImageList, FGlyphListIndex, FGlyphIndex));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.GetIMLGlyphChange(Sender:TObject);
var
  i:Integer;
begin
  UpdateButtons;
  if FReading then exit;
  GetChange(sender);
  for i:=0 to ComponentCount-1 do
    TLMDButtonControl(Components[i]).Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FGlyphImageList) then SetGlyphImageList(nil);
end ;
{------------------------------------------------------------------------------}

procedure TLMDCustomButtonGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroup.GetFieldValue:LongInt;
begin
  result:=FResult;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.Loaded;
begin
  inherited Loaded;
  UpdateButtons;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
    begin
      if self is TLMDCustomRadioGroup then
        if FResult>=FItems.Count then
          FResult:=Pred(FItems.Count);
      // 5.05 (RM)
      if self is TLMDCustomCheckGroup then
        if (not FIgnoreItemCount) and (FItems.Count>31) then    // 6.1
           raise Exception.CreateFmt(SListCountError, [FItems.Count]);
      if csLoading in ComponentState then exit;
      UpdateButtons;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroup.ReadState(Reader: TReader);
begin
  FReading:=True;
  inherited ReadState(Reader);
  FReading:=False;
end;

{-------------------------------- public --------------------------------------}
constructor TLMDCustomButtonGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetIMLGlyphChange;
  FTransparentColor:=clOlive;
  FMultiLine:=True;
  FFocusStyle:=fcText;
  FFocusColor:=clGray;
  FUseFocusColor:=false;
  FButtons:=TList.Create;
  FItems:=TStringList.Create;
  FItemHeight:=-1;
  FItemOffset:=4;
  //TStringlist(FItems).OnChange:=ItemsChange;
  FItems.OnChange:=ItemsChange;
  FColumns:=1;
  FFlatGlyphs := false;
  FResult:=-1;
  {imagelist}
  FGlyphListIndex:=0;
  FGlyphIndex:=0;
  FGlyphImageList:=nil;
  FGlyphChangeLink:=TChangeLink.Create;
  FGlyphChangeLink.OnChange:=GetIMLGlyphChange;

  FBtnAlignment := TLMDGlyphTextLayout.Create;
  FBtnAlignment.Alignment := agCenterLeft;
  FBtnAlignment.OnChange:= GetIMLGlyphChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomButtonGroup.Destroy;
begin
  SetButtonCount(0);

  FBtnAlignment.Free;

  FGlyphChangeLink.OnChange:=nil;
  FGlyphChangeLink.Free;

  FFont3D.OnChange := nil;
  FFont3D.Free;

  TStringList(FItems).OnChange:=nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.EndUpdate(aValue:Boolean=false);
begin
  inherited EndUpdate(false);
  if aValue then
    begin
      ArrangeButtons;
      if Assigned(FOnChange) then FOnChange(self, -1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.RegisterButton (btn : TLMDButtonControl);
begin
  FButtons.Add (btn);
  if self is TLMDCustomRadioGroup then
    btn.OnClick := ButtonClick
  else
    btn.OnChange := ButtonClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomButtonGroup.UnRegisterButton (btn : TLMDButtonControl);
begin
  FButtons.Remove (btn);
end;

end.
