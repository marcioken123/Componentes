unit LMDDBSpinEdit;
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

LMDDBSpinEdit unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, db, dbctrls,
  LMDSpinEdit, LMDCustomMaskEdit, LMDDBBase;

type
  TLMDDBSpinEdit = class(TLMDCustomSpinEdit, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    FUseDBMinMax: boolean;
    FUseZeroLogic: boolean;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure DataChange (Sender : TObject);
    procedure EditingChange (Sender : TObject);
    procedure UpDateData (Sender : TObject);
    procedure CMEnter (var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg : TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure SetUseDBMinMax(const Value: boolean);
    procedure SetUseZeroLogic(const Value: boolean);

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure BeforeChangeText; override;
    procedure Change; override;
    procedure DrawEditText(from : Integer); override;
    procedure DoInc(Sender : TObject);override;
    procedure DoDec(Sender : TObject);override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
    property Value stored false;
    property InfiniteMax;
    property InfiniteMin;
  published
    property Alignment;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property ReadOnly;
    property UseDBMinMax: boolean read FUseDBMinMax write SetUseDBMinMax default true;
    property UseZeroLogic: boolean read FUseZeroLogic write SetUseZeroLogic default true;
  end;

  TLMDDBLabeledSpinEdit = class(TLMDDBSpinEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation
{ ------------------------- Private ------------------------------------------ }
procedure TLMDDBSpinEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      EditType := ntInteger;
      Alignment := FDataLink.Field.Alignment;

      if UseDBMinMax then
        case FDataLink.Field.DataType of
          ftSmallint,
          ftInteger : begin
                         MinValue := TIntegerField(FDataLink.Field).MinValue;
                         MaxValue := TIntegerField(FDataLink.Field).MaxValue;
                      end;
          ftLargeInt: begin
                         MinValue := TLargeintField(FDataLink.Field).MinValue;
                         MaxValue := TLargeintField(FDataLink.Field).MaxValue;
                      end;
          ftWord     : begin
                         MinValue := TWordField(FDataLink.Field).MinValue;
                         MaxValue := TWordField(FDataLink.Field).MaxValue;
                       end;
          ftBCD      : begin
                         MinValue := trunc(TBCDField(FDataLink.Field).MinValue);
                         MaxValue := trunc(TBCDField(FDataLink.Field).MaxValue);
                       end;
          ftCurrency,
          ftFloat    : begin
                         MinValue := trunc(TFloatField(FDataLink.Field).MinValue);
                         MaxValue := trunc(TFloatField(FDataLink.Field).MaxValue);
                       end;
        end;


      //0 means here infinite
      if UseZeroLogic then
        begin
          InfiniteMin := (MinValue=0);
          InfiniteMax := (MaxValue=0);
        end;  

      //
      if Focused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        begin
          Text := FDataLink.Field.DisplayText;
          if FDataLink.Editing {and FDataLink.Modified} then
            Modified := True;
        end;
    end
  else
    Text :='';
  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

function TLMDDBSpinEdit.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSpinEdit.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBSpinEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := AsString;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.CMEnter(var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.CMExit(var Msg : TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSpinEdit.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSpinEdit.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSpinEdit.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBSpinEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.BeforeChangeText;
begin
  FDatalink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.DoDec(Sender: TObject);
begin
  FDatalink.Edit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.DoInc(Sender: TObject);
begin
  FDatalink.Edit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_ESCAPE : begin
                  FDataLink.Reset;
                  SelectAll;
                  KeyCode := 0;
                end;
{    VK_BACK,
    ^H, ^V, ^X,
    VK_DELETE : begin
                  FDataLink.Edit;
                end;}
    VK_BACK,
    32..255: if not ((ssCtrl in Shift) and (KeyCode in [65,67,97,99])) then //vb
               FDataLink.Edit;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDDBSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FUseDBMinMax := true;
  FUseZeroLogic := true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBSpinEdit.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSpinEdit.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.SetUseDBMinMax(const Value: boolean);
begin
  if FUseDBMinMax <> Value then
    begin
      FUseDBMinMax := Value;
      DataChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSpinEdit.SetUseZeroLogic(const Value: boolean);
begin
  FUseZeroLogic := Value;
end;

end.
