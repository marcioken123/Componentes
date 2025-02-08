unit LMDEditDBLookup;
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

LMDEditDBLookup unit (JH)
-------------------------

normal non - db connected edit control. Possible text can be looked up in
connected database

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  db, dbctrls, LMDBaseEdit, LMDCustomEdit;

type
  //tmLookup: lookup only, non existing entries are not allowed
  //tmFree: lookup, no problem if not available (anything can be entered)
  //tmLookupnew: lookup, if not existing and control is left entry is added
  TLMDTypeMode = (tmLookup, tmFree, tmLookupNew);

  TLMDNewEntryQueryEvent = procedure (Sender: TObject; value: String; var accept: Boolean) of object;

  TLMDEditDBLookup = class(TLMDCustomEdit)
  private
    FLookupDataLink: TFieldDataLink;
    FTypeMode      : TLMDTypeMode;
    FOnDataChange  : TNotifyEvent;
    FOnNewEntry    : TLMDNewEntryQueryEvent;
    procedure SetLDataField(const aValue:string);
    procedure SetLDataSource(aValue:TDataSource);
    function GetLDataField:string;
    function GetLDataSource:TDataSource;
    function GetLField:TField;
//    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
//    procedure EditingChange (Sender : TObject);
//    procedure UpDateData (Sender : TObject);
    procedure CMEnter (var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg : TCMExit); message CM_EXIT;
    procedure WMChar(var Msg : TWMChar); message WM_CHAR;
  protected
    procedure DataChange (Sender : TObject); virtual;
    procedure lookup; virtual;

    procedure ChangedText (At : Integer); override;
    procedure BeforeChangeText; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DrawEditText(from : Integer); override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LookupField: TField read GetLField;
  published
    property Alignment;
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property ReadOnly;
    property LookupDataField: string read GetLDataField write SetLDataField;
    property LookupDataSource: TDataSource read GetLDataSource write SetLDataSource;
    property Options;
    property TypeMode: TLMDTypeMode read FTypeMode write FTypeMode default tmFree;
    property OnNewEntry: TLMDNewEntryQueryEvent read FOnNewEntry write FOnNewEntry;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnBtnClick;
  end;

implementation

uses
  LMDProcs, LMDStrings;

{ ------------------------- Private ------------------------------------------ }
procedure TLMDEditDBLookup.DataChange(Sender: TObject);
begin
(*  if FDataLink.Field<>nil then
    begin
      MaxLength := FDataLink.Field.Size;
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
      Text := '';*)

  if Assigned(FOnDataChange) then FOnDataChange(Sender);

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDEditDBLookup.EditingChange(Sender: TObject);
begin
  //inherited ReadOnly := not FDataLink.Editing;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDEditDBLookup.UpdateData(Sender: TObject);
begin
  //FLookupDataLink.Field.Text := Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.CMEnter (var Msg : TCMEnter);
begin
  //FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.CMExit (var Msg : TCMExit);
var
  q: Boolean;
begin
{  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  FDataLink.Reset;}
  //something has been entered which had not been in the lookup source so far
  //let's try to add it ...
  if FTypeMode = tmLookupNew then
    begin

      lookup; //try to lookup current content

      //check whether text is already in the database
      q := not (Text = FLookupDataLink.Field.Text);

      //if q then current text new for lookup source, ask back
      if q then
        if Assigned (FOnNewEntry) then FOnNewEntry (self, Text, q);
      //new text, and probably asked back returned true
      if q then
        begin
          //insert a new record into the lookup dataset
          FLookupDataLink.DataSet.Insert;
          //assign current control's text to the the record
          FLookupDataLink.Field.Text := Text;
          //save the new record
          FLookupDataLink.DataSet.Post;
        end;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.WMChar(var Msg : TWMChar);
begin
  inherited;
  lookup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.SetLDataField(const aValue: string);
begin
  if aValue<>FLookupDataLink.FieldName then
    FLookupDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.SetLDataSource(aValue:TDataSource);
begin
  if aValue<>FLookupDataLink.DataSource then
    FLookupDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDEditDBLookup.GetLDataField:string;
begin
  result:=FLookupDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDEditDBLookup.GetLField:TField;
begin
  result:=FLookupDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDEditDBLookup.GetLDataSource:TDataSource;
begin
  result:=FLookupDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
(*procedure TLMDEditDBLookup.CMGetDataLink(var Message: TMessage);
begin
  Message.Result:=LRESULT(FLookupDataLink);
end;*)

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDEditDBLookup.lookup;
var
  l : Integer;
begin
  with FLookupDataLink.DataSet do
  begin
    //find entry in database which matches most the given text
    Locate(FLookupDataLink.Field.FieldName, Text, [loCaseInsensitive, loPartialKey]);
    //remember length of current input
    l := Length(Text);
    //check whether current input matches database text
    if Text = System.Copy (FLookupDataLink.Field.Text, 1, l) then
    begin
      Text := FLookupDataLink.Field.Text;
      CurrentChar := l+1;
      SelStart := l+1;
      SelLength := Length(Text) - l;
    end
    else
    case FTypeMode of
      //invalid text has been entered, not allowed, replace with allowed string
      tmLookup: Text := FLookupDataLink.Field.Text;
      tmFree,
      tmLookupNew:; //do nothing here, check again on control focus exit
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FLookupDataLink<>nil) and (AComponent=LookupDataSource) then
    LookupDataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.BeforeChangeText;
begin
  FLookupDataLink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_UP : begin
              FLookupDataLink.DataSet.Prior;
              Text := FLookupDataLink.Field.Text;
              SelectAll;
            end;
    VK_DOWN : begin
              FLookupDataLink.DataSet.Next;
              Text := FLookupDataLink.Field.Text;
              SelectAll;
            end;
    VK_ESCAPE : begin
//                  FDataLink.Reset;
                  SelectAll;
                  KeyCode := 0;
                end;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDEditDBLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FLookupDataLink := TFieldDataLink.Create;
  FLookupDataLink.Control := Self;
  //FLookupDataLink.OnDataChange := DataChange;
  //FLookupDataLink.OnEditingChange := EditingChange;
  //FLookupDataLink.OnUpdateData := UpdateData;
  FTypeMode := tmFree;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDEditDBLookup.Destroy;
begin
  FLookupDataLink.OnDataChange:=nil;
  FLookupDataLink.Free;
  FLookupDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.Paint;
begin
  inherited Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditDBLookup.DrawEditText (from : Integer);
begin
  {if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;}
  inherited DrawEditText (from);
end;

end.
