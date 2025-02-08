unit LMDDBExtSpinEdit;
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

LMDDBExtSpinEdit unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, db,  dbctrls,
  LMDBaseEdit, LMDCustomEdit, LMDCustomExtSpinEdit, LMDCustomMaskEdit,
  LMDDBBase;

type
  TLMDDBExtSpinEdit = class(TLMDCustomExtSpinEdit, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    FUseDBMinMax: boolean;
    FUseZeroLogic: boolean;    
    FUseDBDecimals: boolean;
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
    procedure SetUseZeroLogic(const Value: boolean);
    procedure SetUseDBMinMax(const Value: boolean);
    procedure SetUseDBDecimals(const Value: boolean);

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure BeforeChangeText; override;
    procedure ChangedText (At : Integer); override;
    procedure DoInc(Sender : TObject);override;
    procedure DoDec(Sender : TObject);override;
    procedure DrawEditText(from : Integer); override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    property Value stored false;
    property InfiniteMax;
    property InfiniteMin;
  published
    property Alignment;
    property Decimals;
    property CurrencySettings;
    property ReadOnly;
    property TabOnEnter;

    property LargeStep;
    property FractionStep;

    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property UseDBMinMax: boolean read FUseDBMinMax write SetUseDBMinMax default true;
    property UseDBDecimals: boolean read FUseDBDecimals write SetUseDBDecimals default true;
    property UseZeroLogic: boolean read FUseZeroLogic write SetUseZeroLogic default true;
    property MaxValue;
    property MinValue;
  end;

  TLMDDBLabeledExtSpinEdit = class(TLMDDBExtSpinEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  LMDProcs;

{ ------------------------- Private ------------------------------------------ }
procedure TLMDDBExtSpinEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      Alignment := FDataLink.Field.Alignment;
      if UseDBMinMax then
        case FDataLink.Field.DataType of
          ftSmallint,
          ftInteger:  begin
                         EditType := ntInteger;
                         MinValue := TIntegerField(FDataLink.Field).MinValue;
                         MaxValue := TIntegerField(FDataLink.Field).MaxValue;
                       end;
          ftLargeInt: begin
                         EditType := ntInteger;
                         MinValue := TLargeintField(FDataLink.Field).MinValue;
                         MaxValue := TLargeintField(FDataLink.Field).MaxValue;
                       end;
          ftWord     : begin
                         EditType := ntInteger;
                         MinValue := TWordField(FDataLink.Field).MinValue;
                         MaxValue := TWordField(FDataLink.Field).MaxValue;
                       end;
          ftBCD      : begin
                         EditType := ntFloatFixed;
                         MinValue := TBCDField(FDataLink.Field).MinValue;
                         MaxValue := TBCDField(FDataLink.Field).MaxValue;
                         Decimals := TBCDField(FDataLink.Field).Precision;
                       end;
          ftCurrency,
          ftFloat    : begin
                         if TFloatField(FDataLink.Field).Currency then
                           EditType := ntCurrency
                         else
                           EditType := ntFloat;
                         MinValue := TFloatField(FDataLink.Field).MinValue;
                         MaxValue := TFloatField(FDataLink.Field).MaxValue;
                         if UseDBDecimals then
                         Decimals := TFloatField(FDataLink.Field).Precision;
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
    Text := '';

  if Assigned(FOnDataChange) then FOnDataChange(Sender);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsFloat := AsFloat; //VB Aug 2006
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.CMEnter (var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.CMExit (var Msg : TCMExit);
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
procedure TLMDDBExtSpinEdit.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExtSpinEdit.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExtSpinEdit.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExtSpinEdit.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBExtSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBExtSpinEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.DoDec(Sender: TObject);
begin
  FDataLink.Edit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.DoInc(Sender: TObject);
begin
  FDataLink.Edit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.BeforeChangeText;
begin
  FDatalink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
  if ([csReading, csLoading]*ComponentState<>[]) or isUpdating then
    exit;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
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
constructor TLMDDBExtSpinEdit.Create(AOwner: TComponent);
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
destructor TLMDDBExtSpinEdit.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.Paint;
begin
  inherited Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExtSpinEdit.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledExtSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.SetUseDBDecimals(const Value: boolean);
begin
  if FUseDBDecimals <> Value then
  begin
    FUseDBDecimals := Value;
    DataChange(self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.SetUseDBMinMax(const Value: boolean);
begin
  if FUseDBMinMax <> Value then
    begin
      FUseDBMinMax := Value;
      DataChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExtSpinEdit.SetUseZeroLogic(const Value: boolean);
begin
  FUseZeroLogic := Value;
end;

end.
