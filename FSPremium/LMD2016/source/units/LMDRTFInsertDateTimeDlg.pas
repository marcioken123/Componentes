unit LMDRTFInsertDateTimeDlg;
{$I LMDCmps.inc}

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

LMDRTFInsertDateTimeDlg unit (RM)
---------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  LMDRTFBase, LMDRTFRichEdit;

type

  { ********************** TfrmLMDRichInsertDateTimeDlg ********************** }
  TfrmLMDRichInsertDateTimeDlg = class(TForm)
    AvailableFormatsLabel: TLabel;
    ListBox: TListBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
  private
  public
    procedure AddItems(aList:TStrings);
  end;

  { ********************** TLMDRichInsertDateTimeDialog ********************** }
  TLMDRichInsertDateTimeDialog = class(TLMDRichBaseDialog)
  private
    FControl:TLMDCustomRichEdit;
    FSelectedValue:String;
    FLast:Integer;
    FFormats:TStrings;
    procedure SetControl(const Value: TLMDCustomRichEdit);
    procedure SetFormats(const Value: TStrings);
  protected
     procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;override;
    property SelectedValue:String read FSelectedValue;
  published
    property RichEditControl:TLMDCustomRichEdit read FControl write SetControl;
    property DateTimeFormats:TStrings read FFormats write SetFormats;
    property OnHelpClick;
    property OnCustomize;
    property Options;
  end;

var
  frmLMDRichInsertDateTimeDlg: TfrmLMDRichInsertDateTimeDlg;

implementation
uses
  LMDRTFConst;
{$R *.dfm}
{------------------------------------------------------------------------------}
procedure TfrmLMDRichInsertDateTimeDlg.AddItems(aList:TStrings);
var
  i:Integer;

  procedure AddFormat(const s:String);
  begin
    if ListBox.Items.IndexOf(s)=-1 then
      ListBox.Items.Add(s);
  end;

begin
  if aList.Count>0 then
    begin
      for i:=0 to aList.Count-1 do
        AddFormat(FormatDateTime(aList[i], Now));
      exit;
    end;

  // Default Format Strings
  // Dates
  AddFormat(FormatDateTime({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat, Now));
  AddFormat(FormatDateTime({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDateFormat, Now));
  AddFormat(FormatDateTime('dd/mm/yyyy', Now));
  AddFormat(FormatDateTime('dd. mmm yyyy', Now));
  AddFormat(FormatDateTime('dd/mm/yyyy', Now));
  AddFormat(FormatDateTime('dd/mm/yy', Now));
  AddFormat(FormatDateTime('yyyy-mm-dd', Now));
  AddFormat(FormatDateTime('yyyy-m-d', Now));
  AddFormat(FormatDateTime('dddd, mmmm d, yyyy', Now));

  // Time
  AddFormat(FormatDateTime('hh:nn:ss', Now));
  AddFormat(FormatDateTime('h:nn:ss', Now));
  AddFormat(FormatDateTime('hh:nn', Now));
  AddFormat(FormatDateTime('h:nn am/pm', Now));
  AddFormat(FormatDateTime({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat, Now));
  AddFormat(FormatDateTime({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongTimeFormat, Now));
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRichInsertDateTimeDlg.ListBoxClick(Sender: TObject);
begin
  btnOk.Enabled:=ListBox.ItemIndex<>-1;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRichInsertDateTimeDlg.ListBoxDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRichInsertDateTimeDlg.FormCreate(Sender: TObject);

begin
  btnOk.Caption := IDRTF_OK;
  btnHelp.Caption:=IDRTF_HELP;
  btnCancel.Caption := IDRTF_CANCEL;
  AvailableFormatsLabel.Caption:=IDRTF_AVAILABLEFORMATS;
  Caption:=IDRTF_DATETIME;
end;

{ ************************** TLMDRichInsertDateTimeDialog ******************** }
{ ----------------------------- private -------------------------------------- }
procedure TLMDRichInsertDateTimeDialog.SetControl(const Value: TLMDCustomRichEdit);
begin
  if Value <> FControl then
    begin
      FControl:= Value;
      if Value <> nil then
        Value.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichInsertDateTimeDialog.SetFormats(const Value: TStrings);
begin
  FFormats.Assign(Value);
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDRichInsertDateTimeDialog.Notification(AComponent: TComponent;Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then RichEditControl:= nil;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichInsertDateTimeDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFormats:=TStringList.Create;
  Flast:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDRichInsertDateTimeDialog.Destroy;
begin
  FreeAndNil(FFormats);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDRichInsertDateTimeDialog.Execute(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
var
  dlg:TfrmLMDRichInsertDateTimeDlg;
  tmp:Integer;
begin
  result:=false;
  dlg:=TfrmLMDRichInsertDateTimeDlg.Create(nil);
  with dlg do
    try
      PrepareDialog(dlg, aOwner, x, y);
      FSelectedValue:='';
      if rdoShowHelpButton in Options then
        begin
          btnHelp.Visible:=True;
          if Assigned(OnHelpClick) then btnHelp.OnClick:=OnHelpClick;
        end;

      AddItems(FFormats);
      if (FLast<>-1) and (Flast<ListBox.Items.Count) then
        ListBox.ItemIndex:=FLast
      else if ListBox.Items.Count>0 then
         ListBox.ItemIndex:=0;
      btnOk.Enabled:=ListBox.ItemIndex<>-1;
      if ShowModal=mrOk then
        begin
           if (ListBox.ItemIndex=-1) or (csDesigning in ComponentState) then exit; 
           result:=true;
           FSelectedValue:=ListBox.Items[ListBox.ItemIndex];
           Flast:=ListBox.ItemIndex;
           if Assigned(RichEditControl) then
             begin
               if not RichEditControl.Visible then exit;
               tmp:=RichEditControl.SelStart;
               RichEditControl.SelText := FSelectedValue;
               RichEditControl.SelStart:=tmp+Length(FSelectedValue);
               if RichEditControl.CanFocus then
                 RichEditControl.SetFocus;
              end;
        end;
    finally
      free
    end;
end;

end.
