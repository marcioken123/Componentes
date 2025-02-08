unit LMDDBMaskEdit;
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

LMDDBMaskEdit unit (JH)
-----------------------

Masked date edit control, will autodetect needed masktype!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, db,  dbctrls,
  LMDCustomMaskEdit, LMDBaseEdit, LMDCustomEdit, LMDDBBase;

type
  TLMDDBMaskEdit = class(TLMDCustomMaskEdit, IDataControl)
  private
    FAutoMask : Boolean; //Retrieve mask from database?
    FDataLink : TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    //2nd ReadOnly mode, for overlaying database readonly (=false) state
    FReadOnly    : Boolean;
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

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure ChangedText (At : Integer); override;
    procedure BeforeChangeText; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DrawEditText(from : Integer); override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    property AutoMask : Boolean read FAutoMask write FAutoMask default true;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
//    property Mask stored not AutoMask;
  published
    property Alignment;
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    //redefined property ReadOnly, only visible on this inheritance level
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property TabOnEnter;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
  end;

  TLMDDBLabeledMaskEdit = class(TLMDDBMaskEdit)
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
procedure TLMDDBMaskEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      Alignment := FDataLink.Field.Alignment;
      case FDataLink.Field.DataType of
        ftAutoInc,
        ftSmallint,
        ftInteger{,
        ftLargeInt}: MaskType := meInteger;
        ftWord     : MaskType := meWord;
        ftFloat    : MaskType := meFloat;
        ftBCD,  //vb jul 2005
        ftCurrency : MaskType := meCurrency;
        ftDate     : MaskType := meDate;
        ftTime     : MaskType := meTime;
        ftString   : begin
                       MaskType := meMask;
                       //Note: The conversion done here is not 1:1
                       //a user has to check whether the conversion done is OK!!
                       if FAutoMask then
                         Mask := convertVCLMask2LMDMask (FDataLink.Field.EditMask);
                     end;
        ftDateTime :;
      end;
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
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';

  if Assigned(FOnDataChange) then FOnDataChange(Sender);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing or FReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.UpdateData(Sender: TObject);
begin
  If FDataLink.Field is TBCDField then      //vb jul 2005
    FDataLink.Field.AsCurrency := AsCurrency
  else
    FDataLink.Field.Text := Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.CMEnter (var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.CMExit (var Msg : TCMExit);
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
procedure TLMDDBMaskEdit.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    begin
      FDataLink.FieldName:=aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBMaskEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBMaskEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.BeforeChangeText;
begin
  FDatalink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
  EditingChange(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
  if [csReading, csLoading]*ComponentState<>[] then exit;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
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
    32..255: if not FReadOnly then
               if not ((ssCtrl in Shift) and (KeyCode in [65,67,97,99])) then //vb
                 FDataLink.Edit;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDDBMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := false;
  FReadOnly := false;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FAutoMask := true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBMaskEdit.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.Paint;
begin
  inherited Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMaskEdit.DrawEditText (from : Integer);
begin
{  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawText (from);}

  if Focused or not (csPaintCopy in ControlState) then
    inherited DrawEditText (from)
  else //just draw the text, but do not copy the string into
       //internal edit string
    if (FDataLink.Field <> nil) then
      DrawEditText (from, FDataLink.Field.DisplayText);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMaskEdit.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
