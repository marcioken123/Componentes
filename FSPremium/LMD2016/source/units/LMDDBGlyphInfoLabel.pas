unit LMDDBGlyphInfoLabel;
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

LMDDBGlyphInfoLabel unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,  DB, DBCtrls, Graphics, Messages, Classes, Controls,
  LMDBevel, LMDCustomGlyphLabel, LMDDBBase;

const
  // the bitmap for GlyphInfo
  IDB_DBINFO=16778;

type
  {-------------------------- TLMDDBGlyphInfoLabel ----------------------------}
  TLMDDBGlyphInfoLabel = class(TLMDCustomGlyphLabel, IDataControl)
  private
    //FInfo : TLMDDBInfoTypes;
    FGlyphTransparent,
    FStandartCaption : Boolean;
    FUnits : String;
    FDB,
    FTabs : ShortInt;
    FBevel : TLMDBevel;
    FTransparentColor : TColor;
    FDataLink: TFieldDataLink;
    FGlyph : TBitmap;
    FInternal : Integer;
    procedure SetDataSource(aValue:TDataSource);
    function GetDataSource:TDataSource;
    procedure SetTabs (aValue : ShortInt);
    procedure SetDB (aValue : ShortInt);
    procedure SetUnits (aValue : String);
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetTransparentColor (aValue : TColor);
    procedure SetStandartCaption (aValue : Boolean);
    procedure SetGlyphTransparent (aValue : Boolean);
    procedure DataChange(Sender:TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Paint; override;
    function ReturnCaption(var s : string) : boolean;
    procedure GetChange (Sender: TObject); override;
    function DrawItem (aRect : TRect;draw : Boolean): TRect;
    procedure GetIMLChange(Sender : TObject); override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure CorrectBounds; override;
  published
    property About;
    property Align;
    property AutoSize;
    property Font3D;
    property Font;
    property InsertTabs : ShortInt read FTabs write SetTabs default 1;
    property UseStandardCaption : Boolean read FStandartCaption write SetStandartCaption default true;
    property Units : String read FUnits write SetUnits;
    property InsertDB : ShortInt read FDB write SetDB default -1;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property ImageList;
    property ListIndex;
    property Alignment;
    property Caption;
    property Color;
    property Enabled;
    property Transparent default false;
    property GlyphTransparentColor : TColor read FTransparentColor write SetTransparentColor default clFuchsia;
    property GlyphTransparent : Boolean read FGlyphTransparent write SetGlyphTransparent default true;
    property ParentFont;
    property ParentColor;
    property Hint;
    property ShowHint;
    property ParentShowHint;
    property ShowAccelChar;
    property Visible;
    property Cursor;
    { events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
  end;

implementation

uses
  LMDGraph, LMDProcs, LMDGraphUtils, LMDDBConst, LMDCont;

{ ---------------------------- private ----------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetUnits (aValue : String);
begin
  if aValue <> FUnits then
    begin
      FUnits := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetTransparentColor (aValue : TColor);
begin
  if aValue <> FTransparentColor then
    begin
      FTransparentColor := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetGlyphTransparent (aValue : Boolean);
begin
  if aValue <> FGlyphTransparent then
    begin
      FGlyphTransparent := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetDB (aValue : ShortInt);
begin
  if aValue <> FDB then
    begin
      FDB := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetTabs (aValue : ShortInt);
begin
  if aValue <> FTabs Then
    begin
      FTabs := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetStandartCaption (aValue : Boolean);
begin
  if aValue <> FStandartCaption then
    begin
      FStandartCaption := aValue;
      GetChange (nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.GetChange (Sender: TObject);
begin
  CorrectBounds;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.DataChange(Sender: TObject);
begin
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDDBGlyphInfoLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBGlyphInfoLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------- protected --------------------------------------}
(* ReturnCaption ::= Caption | StandartCaption {tab} [':'] {tab} value [unit]
   tab ::= #9
   value ::= GetSystemInfoString
   unit ::= String
*)

function TLMDDBGlyphInfoLabel.ReturnCaption(var s : string) : boolean;
var
  i : longint;
  s2 : string;

begin
  result := true;
  s := '';
  if not FStandartCaption then
    s := Caption
  else
    s := 'State';

  if FDB = ShortInt(0) then
    s := s+':';
  for i := 1 to FTabs do
    begin
      s := s+#9;
      if FDB = i then
        s := s+':';
    end; { end of for }
  if (ShortInt(FTabs) = ShortInt(0)) and (Caption <> '') then
    s := s + ' ';
  if (FDataLink.DataSource <> nil) and (FDataLink.DataSet <> nil) and (FDataLink.DataSet.Active) then
    case FDataLink.DataSource.State Of
       dsBrowse: begin ImageIndex := 1; s2 := IDS_BROWSING; end;
       dsEdit: begin ImageIndex := 2; s2 := IDS_EDITING; end;
       dsInsert: begin ImageIndex := 3; s2 := IDS_INSERTING; end;
       dsSetKey: begin ImageIndex := 4; s2 := IDS_SETKEY; end;
       dsCalcFields: begin ImageIndex := 5; s2 :=IDS_CALCULATING; end;
       dsFilter: begin ImageIndex := 6; s2 :=IDS_FILTER; end;
    end
  else
    begin
      s2 := IDS_NOTAVAILABLE;
      ImageIndex := 7;
    end;

  If (FDataLink.DataSource <> nil) and (FDataLink.DataSet <> nil) and not FDataLink.DataSet.Active then
    {dsInactive}
    begin
      ImageIndex := 0;
      s2 := IDS_INACTIVE;
    end;

  s := s+s2;

  if FUnits <> '' then
    s := s+FUnits;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.GetIMLChange(Sender : TObject);
begin
  if not IMLEmpty then
    begin
      LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FGlyph);
    end
  else
    begin
      FGlyph.Handle:=LoadBitmap(HInstance, MakeIntResource(IDB_DBINFO));
      FInternal := FGlyph.Width div 8;
    end;
  GetChange(nil)
end;

{ -----------------------------------------------------------------------------}
function TLMDDBGlyphInfoLabel.DrawItem (aRect: TRect;draw : Boolean): TRect;
var
  bRect : TRect;
  s : string;
  ds:TLMDDrawTextStyles;
  flags:LongInt;
begin
  if not ReturnCaption(s) then exit;

  if not IMLEmpty then
    begin
      bRect := Rect(0,0, FGlyph.Width, FGlyph.Height)
    end
  else
    bRect := Rect (ImageIndex*FInternal, 0, FInternal + ImageIndex * FInternal, FGlyph.Height);

  if draw then
    ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled]
  else
    ds:=[TLMDDrawTextStyle(Enabled), dt3DDisabled, dtCalculate];

  if not ShowAccelChar then flags:=DT_NOPREFIX else flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);

  LMDDrawTextAndGlyphExt(Canvas, s, Font3D, aRect, FGlyph.Canvas,
                         bRect, nil, FTransparentColor, Alignment, false { MultiLine},
                         True, FGlyphTransparent, ds, flags);

  InflateRect (bRect, Bevel.BevelExtend*2, Bevel.BevelExtend*2);

  result := bRect;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.CorrectBounds;
var
  bRect : TRect;
begin
  // 7.0.61 Align Test
  if (Align=alNone) and AutoSize and not (csReading in ComponentState) then
    begin
      bRect := DrawItem (ClientRect, false);
      SetBounds(Left, Top, bRect.Right, bRect.Bottom);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBGlyphInfoLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ----------------------------- public ----------------------------------------}
procedure TLMDDBGlyphInfoLabel.Paint;
var
  aRect:TRect;
begin
  if  (csLoading in ComponentState) then exit;

  if not Transparent then FillControl;

  aRect:=GetClientRect;

 {If Bevel-Settings - draw them!}
 if Bevel.BevelExtend<>0 then
   begin
     aRect:=Bevel.PaintBevel(Canvas, aRect, (Bevel.BorderColor=Color) or Transparent);
   end;

  DrawItem (aRect, True);
end;

{ -----------------------------------------------------------------------------}
constructor TLMDDBGlyphInfoLabel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  BeginUpdate;
  try
    DisableTransMode;
    FDataLink := TFieldDataLink.Create;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnActiveChange := DataChange;
    FDataLink.OnUpdateData := DataChange;
    FDataLink.OnEditingChange := DataChange;
    FBevel := TLMDBevel.Create;
    FBevel.OnChange := GetChange;
    FGlyph := TBitmap.Create;
    FGlyph.Handle:=LoadBitmap(HInstance, MakeIntResource(IDB_DBINFO));
    FInternal := FGlyph.Width div 8;
    FTransparentColor := clFuchsia;
    FGlyphTransparent := True;
    FTabs := 1;
    FDB := -1;
    FStandartCaption := True;
  finally
    EndUpdate(false);
  end;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBGlyphInfoLabel.Destroy;
begin
  FGlyph.Free;
  FBevel.OnChange := nil;
  FBevel.Free;
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBGlyphInfoLabel.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
