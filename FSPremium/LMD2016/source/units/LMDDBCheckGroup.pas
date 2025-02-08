unit LMDDBCheckGroup;
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

LMDDBCheckGroup unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  DBCtrls,
  Classes,
  Messages,
  Controls,
  LMDCustomCheckGroup,
  LMDDBBase;

type
  {---------------------------- TLMDDBCheckGroup ------------------------------}
  TLMDDBCheckGroup = class (TLMDCustomCheckGroup, IDataControl)
  private
    FDataLink : TFieldDataLink;
    function GetDataField : String;
    function GetDataSource : TDataSource;
    function GetReadOnly : Boolean;reintroduce;
    procedure SetReadOnly (aValue : Boolean);
    procedure SetDataSource (aValue : TDataSource);
    procedure SetDataField (const aValue : String);
    procedure DataChange (Sender : TObject);
    procedure UpdateData(Sender: TObject);
//    procedure EditingChange(Sender: TObject);
    procedure CMExit (var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Click; override;
    function GetFieldValue:LongInt;override;
    procedure KeyPress (var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    property Value;
  published
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    property About;
    property Alignment;
    property Bevel;
    property Caption;
    property CaptionFont;
    property CaptionFont3D;
    property CaptionOffset;
    property CaptionParentFont;
    property Columns;
    property FocusStyle;
    property FocusColor;
    property UseFocusColor;
    property Font;
    property Font3D;
    property GlyphImageIndex;
    property GlyphImageList;
    property GlyphListIndex;
    property GlyphNumber;
    property GlyphTransparent;
    property GlyphTransparentColor;
    property ImageIndex;
    property ImageList;
    property ItemHeight;
    property ItemOffset;
    property Items;
    property ListIndex;
    property ShowAccelChar;
    property Transparent;
    property UseBitmap;

    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation

uses
  LMDProcs;

{ ------------------------------- private -------------------------------------}
function TLMDDBCheckGroup.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBCheckGroup.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBCheckGroup.GetReadOnly : Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.SetReadOnly (aValue : Boolean);
begin
  FDataLink.ReadOnly := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.SetDataSource (aValue : TDataSource);
begin
  FDataLink.DataSource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.SetDataField (const aValue : String);
begin
  FDataLink.FieldName := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.DataChange(Sender:TObject);
begin
  if (FDataLink.Field<>nil) and not (FDataLink.Field.IsNull) then
    Value:=FDataLink.Field.AsInteger
  else
    Value:=0;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsInteger:=Value; { Value, Text }
end;

{ -----------------------------------------------------------------------------}
{procedure TLMDDBCheckGroup.EditingChange(Sender: TObject);
begin
   ReadOnly := not FDataLink.Editing;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckGroup.WMPaint(var Message: TWMPaint);
{var
  i:Integer;
  tmp,v:LongInt;}
begin
  inherited;
  {if csPaintCopy in ControlState then
    begin
      v:=GetFieldValue;

      for i:=0 to Pred(Buttons.Count) do
        begin
          tmp:=LMDExp(2, i);
          Caption:=inttostr(Ord(tmp and v = tmp)+1);
          TLMDCheckBox(Buttons[i]).PaintToControl(Ord(tmp and v = tmp)+1);
        end
     end
  else
    Caption:='0';}
end;

{ -----------------------------------------------------------------------------}

procedure TLMDDBCheckGroup.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
end;

{ ------------------------------- protected -----------------------------------}
procedure TLMDDBCheckGroup.Click;
begin
  inherited Click;
  FDataLink.Modified;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBCheckGroup.GetFieldValue:LongInt;
begin
  if csPaintCopy in ControlState then
    begin
      if (FDataLink.Field<>nil) and not (FDataLink.Field.IsNull) then
        Result:=FDataLink.Field.AsInteger
      else
        Result:=0;
    end
  else
    result:=Value;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBCheckGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

{ ------------------------------- public --------------------------------------}
constructor TLMDDBCheckGroup.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  ControlStyle:=ControlStyle{+[csReplicatable]};
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBCheckGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckGroup.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
