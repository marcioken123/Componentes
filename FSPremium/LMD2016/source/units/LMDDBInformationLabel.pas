unit LMDDBInformationLabel;
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

LMDDBInformationLabel unit ()
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB, DBCtrls, Messages, Controls, Classes,
  LMD3DCaption, LMDBevel, LMDBaseLabel, LMDDBBase;

type

  TLMDDBInfoTypes = (itDBRecords, itDBCurrentRecord, itDBCurrent_All, itDBState,
                     itDBRecordSize, itDBFieldCount, itDBModified, itDBReadOnly);

  {-------------------------- TLMDInformationLabel ----------------------------}
  TLMDDBInformationLabel = class(TLMDBaseLabel, IDataControl)
  private
    FInfo : TLMDDBInfoTypes;
    FFont3D : TLMD3DCaption;
    FStandartCaption : Boolean;
    FBevel : TLMDBevel;
    FUnits : String;
    FDB,
    FTabs : ShortInt;
    FDataLink: TFieldDataLink;
    procedure SetDataSource(aValue:TDataSource);
    function GetDataSource:TDataSource;
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetInfo (aValue : TLMDDBInfoTypes);
    procedure SetTabs (aValue : ShortInt);
    procedure SetDB (aValue : ShortInt);
    procedure SetUnits (aValue : String);
    procedure SetStandartCaption (aValue : Boolean);
    procedure SetBevel (aValue : TLMDBevel);
    procedure DataChange(Sender:TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    function ReturnCaption(var s : string) : boolean;
    procedure GetChange (Sender: TObject); override;
    procedure Loaded; override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure CorrectBounds; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    procedure Paint; override;
  published
    property About;
    property Align;
    property Info : TLMDDBInfoTypes read FInfo write SetInfo;
    property AutoSize;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property Font;
    property InsertTabs : ShortInt read FTabs write SetTabs default 1;
    property UseStandardCaption : Boolean read FStandartCaption write SetStandartCaption default true;
    property Units : String read FUnits write SetUnits;
    property InsertDB : ShortInt read FDB write SetDB default -1;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property Alignment;
    property Caption;
    property Color;
    property Enabled;
    property Transparent default false;
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

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;

  end;

implementation
uses
  SysUtils,
  LMDProcs, LMDGraph, LMDGraphUtils, LMDDBConst;

{ ---------------------------- protected --------------------------------------}

(* ReturnCaption ::= Caption | StandartCaption {tab} [':'] {tab} value [unit]
   tab ::= #9
   value ::= GetSystemInfoString
   unit ::= String
*)

function TLMDDBInformationLabel.ReturnCaption(var s : string) : boolean;
var
  i : longint;
  s2, s3 : string;

begin
  result := true;
  s := '';
  if not FStandartCaption then
    s := Caption
  else
    case FInfo Of
      itDBRecords : s := IDS_Records;
      itDBCurrentRecord : s := IDS_CURRENTRECORD;
      itDBCurrent_All : s := IDS_CURRENTALL;
      itDBState : s := IDS_STATE;
      itDBRecordSize : s := IDS_RECORDSIZE;
      itDBFieldCount : s := IDS_FIELDS;
      itDBModified : s := IDS_MODIFIED;
      itDBReadOnly : s := IDS_READONLY;
    end;

  if FDB=ShortInt(0) then
    s := s+':';
  for i := 1 to FTabs do
    begin
      s := s+#9;
      if FDB = i then
        s := s+':';
    end; { end of for }
  if (FTabs = ShortInt(0)) and (Caption <> '') then
    s := s + ' ';
  if (FDataLink.DataSource <> nil) and (FDataLink.DataSet <> nil) and (FDataLink.DataSet.Active) then
    case FInfo of
      itDBRecords : s2 := IntToStr(FDataLink.DataSet.RecordCount);
      itDBCurrentRecord : s2 := IntToStr(FDataLink.DataSet.RecNo);
      itDBCurrent_All : begin
                          s2 := IntToStr(FDataLink.DataSet.RecNo);
                          s3 := IntToStr(FDataLink.DataSet.RecordCount);
                          s2 := s2+'/'+s3;
                        end;
      itDBstate : case FDataLink.DataSource.State Of
                    {dsInactive outside if }
                    dsBrowse: s2 := IDS_BROWSING;
                    dsEdit: s2 := IDS_EDITING;
                    dsInsert: s2 := IDS_INSERTING;
                    dsSetKey: s2 := IDS_SETKEY;
                    dsCalcFields: s2 :=IDS_CALCULATING;
                    dsFilter: s2 := IDS_FILTER;

                  end;
      itDBRecordSize : s2 := IntToStr(FDataLink.DataSet.RecordSize);
      itDBFieldCount : s2 := IntToStr(FDataLink.DataSet.FieldCount);
      itDBModified : if FDataLink.{DataSource.}DataSet.Modified then
                       s2 := IDS_YES else s2 := IDS_NO;
      itDBReadOnly : if FDataLink.ReadOnly then
                       s2 := IDS_YES else s2 := IDS_NO;

    end { end of case FInfo }
  else
    s2 := IDS_NOTAVAILABLE;

  if (FDataLink.DataSource <> nil) and (FDataLink.DataSet <> nil) and
      not (FDataLink.DataSet.Active) and (FInfo = itDBstate) then
    begin
      {dsInactive} s2 :=IDS_INACTIVE;
    end;
  s := s+s2;

  if FUnits <> '' then
    s := s+FUnits;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.CorrectBounds;
var
  aRect:TRect;
  s : string;
  flags:LongInt;
begin
   // 7.0.61 Align Test
  if (Align=alNone) and AutoSize and ([csReadingState, csCreating]*ControlState=[]) then
    begin
      aRect:=GetClientRect;
      ReturnCaption (s);
      flags:=0;
      flags:=DrawTextBiDiModeFlags(flags);
      LMDDrawTextCalcExt(Canvas, s, FFont3D, aRect, Font, MultiLine,
                         ShowAccelChar, FBevel.BevelExtend, flags);
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------- private ----------------------------------------}
procedure TLMDDBInformationLabel.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetUnits (aValue : String);
begin
  if aValue <> FUnits then
    begin
      FUnits := aValue;
      GetChange (nil);
    end;
end;

function TLMDDBInformationLabel.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetDB (aValue : ShortInt);
begin
  if aValue <> FDB then
    begin
      FDB := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetTabs (aValue : ShortInt);
begin
  if aValue <> FTabs Then
    begin
      FTabs := aValue;
      GetChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetStandartCaption (aValue : Boolean);
begin
  if aValue <> FStandartCaption then
    begin
      FstandartCaption := aValue;
      GetChange (nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetInfo (aValue : TLMDDBInfoTypes);
begin
  if aValue <> FInfo Then
    begin
      FInfo := aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.GetChange (Sender: TObject);
begin
  CorrectBounds;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.Loaded;
begin
  inherited Loaded;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.DataChange(Sender: TObject);
begin
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBInformationLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    begin
      FDataLink.DataSource:=aValue;
    end;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBInformationLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBInformationLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- public ----------------------------------------}
procedure TLMDDBInformationLabel.Paint;
var
  aRect:TRect;
  flags :Word;
  s : String;
begin
  if  (csLoading in ComponentState) then exit;

  if not ReturnCaption(s) then exit;

  try
    {check, if TransparentFlag is set - if no, fill the client-rect...}
    if not Transparent then FillControl;
    aRect:=ClientRect;
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
    flags:=flags or DT_EXPANDTABS or DT_WORDBREAK or TLMDAlignFlags[Alignment];
    if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
    Canvas.Brush.Color:=Color;
    Canvas.Font.Color:=Font.Color;
    LMDDrawTextExt(Canvas, s, Font3D, aRect, flags,
                  [TLMDDrawTextStyle(Enabled)], nil);
  finally
  end;
end;

{ -----------------------------------------------------------------------------}
constructor TLMDDBInformationLabel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  BeginUpdate;
  try
    DisableTransMode;
    FDataLink := TFieldDataLink.Create;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnActiveChange := GetChange;
    FTabs := 1;
    FDB := -1;
    FStandartCaption := True;
    FFont3D := TLMD3DCaption.Create;
    FFont3D.OnChange := FontChange;
    FBevel := TLMDBevel.Create;
    FBevel.OnChange := GetChange;
  finally
    EndUpdate(false);
  end;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBInformationLabel.Destroy;
begin
  FFont3D.OnChange := nil;
  FFont3D.Free;
  FBevel.OnChange := nil;
  FBevel.Free;
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TLMDDBInformationLabel.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBInformationLabel.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
