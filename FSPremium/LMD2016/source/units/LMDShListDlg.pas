unit LMDShListDlg;
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

LMDShListDlg unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses

  Forms, StdCtrls, Controls, CheckLst, ExtCtrls, Classes, Windows, ShlObj,
  LMDShBase, LMDShList
  ;

type

  TLMDShellfrmListDialog = class;

  {-------------------- TLMDShellListDialog ---------------------------------}
  TLMDShellListDialog = class(TLMDShellBaseDialog)
  private
    FShellList: TLMDShellList;
    FDialog: TLMDShellfrmListDialog;
    FCaption: String;
    procedure SetShellList(aValue: TLMDShellList);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(aHWND: HWND = 0):Boolean; override;

  published
    property Caption: string read FCaption write FCaption;
    property ShellList: TLMDShellList read FShellList write SetShellList;
  end;

  {-------------------- TLMDShellfrmListDialog ------------------------------}
  TLMDShellfrmListDialog = class(TForm)
    lblInstruction: TLabel;
    lblwidth: TLabel;
    Bevel1: TBevel;
    lb: TCheckListBox;
    chk: TCheckBox;
    btnUp: TButton;
    btnDown: TButton;
    btnDisplay: TButton;
    btnHide: TButton;
    edWidth: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edWidthKeyPress(Sender: TObject; var Key: Char);
    procedure btnClick(Sender: TObject);
    procedure lbClick(Sender: TObject);
    procedure edWidthExit(Sender: TObject);
    procedure lbClickCheck(Sender: TObject);
  private
    FComponent: TLMDShellListDialog;
    fItems: TStrings;
    procedure UpdateListbox;
    procedure UpdateStates;
  public
  end;

implementation

uses
  TypInfo, SysUtils, ComCtrls,
  LMDShPIDL, LMDShMisc, LMDShConsts, LMDProcs;

{$R *.DFM}
{******************** class TLMDShellListDialog ******************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDShellListDialog.SetShellList(aValue: TLMDShellList);
begin
  if aValue<>FShellList then
    FShellList:=aValue;
  if aValue<>nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FShellList<>nil) and (AComponent=FShellList) then
    ShellList:=nil;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellListDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDialog:= nil;
  FCaption:= EmptyStr;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellListDialog.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDShellListDialog.Execute;
var
  i, ii: integer;
  Col: TLMDShellListCustomColumn;
begin
  result:=false;
  if FShellList = nil then Exit;

  // RM
  if ((OwnerHandle=pwOwnerForm) and (Owner is TCustomForm)) and not (csDesigning in ComponentState) then
    FDialog:=TLMDShellfrmListDialog.Create(Owner)
  else
    FDialog:=TLMDShellfrmListDialog.Create(nil);

  try
    if FCaption <> '' then
      FDialog.Caption:=FCaption
    else
      FDialog.Caption:=IDSHELL_SELECTDETAILS;

    FDialog.FComponent:= Self;
    FDialog.UpdateListBox;
    FDialog.UpdateStates;

    if (FDialog.ShowModal = mrOk) then
      begin
        if  not FDialog.chk.Checked
            or (FShellList.DefaultColumns <> FDialog.chk.Checked)  then
          begin
            if  not FDialog.chk.Checked then
              begin
                FShellList.CustomColumns.BeginUpdates;
                try
                  FShellList.CustomColumns.Clear;

                  for i := 0 to FDialog.lb.Items.Count - 1 do
                    if  FDialog.lb.Checked[i] then
                    begin
                      ii := integer(FDialog.lb.Items.Objects[i]);
                      Col := TLMDShellListCustomColumn(FShellList.CustomColumns.Add);
                      Col.Caption := FDialog.fItems[ii];
                      Col.ColID := ii;
                      Col.Width := integer(FDialog.fItems.Objects[ii]);
                    end;
                finally
                  FShellList.CustomColumns.EndUpdates;
                end;
              end;

            if  FShellList.DefaultColumns <> FDialog.chk.Checked  then
              FShellList.DefaultColumns := FDialog.chk.Checked;
//            else
//              FShellList.EnumColumns;

            Result:=True;
          end;
      end;
  finally
    FreeAndNil(FDialog);
  end;
end;

{****************** Form TLMDShellfrmListDialog ******************************}
{------------------------------------------------------------------------------}

type
  TLMDShellListHack = class(TLMDShellList)
  end;

procedure TLMDShellfrmListDialog.UpdateListbox;
  procedure int_AddSD(Lst: TStrings; var SD: TShellDetailsEx; ShellList: TLMDShellList);
  var
    S: string;
    W: integer;
  begin
    //S := String(LMDStrRetToStringEx(nil, SD.Str));
    S := LMDStrRetToStr(nil, SD.Str);

    if  S <> '' then
      W := SD.cxChar * ShellList.Canvas.TextWidth('X')
    else
      W := 0;

    Lst.AddObject(S, TObject(W));
  end;

var
  i, ii, j: Integer;
  SF: IShellFolder;
  SF2: IShellFolder2;
  SD: TShellDetailsEx;
  ISD: IShellDetails;
  ShellList: TLMDShellList;
  Col: TListColumn;
  Cols: TListColumns;
  CC: TLMDShellListCustomColumns;
  aLst: TList;
  PIDL: PItemIDList;
begin
  if not Assigned(FComponent) or not Assigned(FComponent.ShellList) then
    Exit;

  ShellList := FComponent.ShellList;

  Cols := TLMDShellListHack(ShellList).Columns;

  if  not Assigned(Cols)  then
    exit;

  if  Assigned(fItems)  then
    fItems.Clear
  else
    fItems := TStringList.Create;

  FillChar(SD, SizeOf(SD), 0);

  chk.Checked := ShellList.DefaultColumns;
  PIDL := ShellList.Folder.ActiveFolder.AbsoluteID;
  SF := GetIShellFolder(PIDL);
  CC := ShellList.CustomColumns;

  ii := 0;
  lb.Items.Clear;

  if  not Supports(SF, IShellFolder2, SF2)  then
    SF2 := nil;

  if Assigned(SF2) then // Have IShellFolder2 interface
  begin
    while Succeeded(SF2.GetDetailsOf(nil, ii, SD)) do
    begin
      int_AddSD(fItems, SD, ShellList);
      Inc(ii);
    end;

    SF2 := nil;
  end
  else
  begin
    ii := 0;
    ISD := GetIShellDetails(SF, PIDL);

    if Assigned(ISD) then
      while Succeeded(ISD.GetDetailsOf(nil, ii, SD)) do
      begin
        int_AddSD(fItems, SD, ShellList);
        Inc(ii);
      end
  end;

  lb.Items.BeginUpdate;
  aLst := TList.Create;

  try
    for i := 0 to Cols.Count - 1 do
    begin
      Col := Cols[i];
      ii := Col.Tag;

      if  not ShellList.DefaultColumns  then
        ii := CC[ii].ColID;

      if  (ii >= 0) and (ii < fItems.Count)  then
      begin
        aLst.Add(TObject(ii));
        j := lb.Items.AddObject(fItems[ii], TObject(ii));
        fItems.Objects[ii] := TObject(Col.Width);
        lb.Checked[j] := True;
      end;
    end;

    for i := 0 to fItems.Count - 1 do
      if  (aLst.IndexOf(TObject(i)) < 0) and (fItems[i] <> '')  then
        lb.Items.AddObject(fItems[i], TObject(i));
  finally
    aLst.Free;
    lb.Items.EndUpdate;
  end;

  if (lb.Items.Count>0) and not chk.Checked then
    begin
      lb.ItemEnabled[0]:=false;
      if lb.Items.Count>1 then lb.ItemIndex:=1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.FormCreate(Sender: TObject);
begin
  chk.Caption:=IDSHELL_DEFAULTCOLUMNS;
  btnUp.Caption:=IDSHELL_BUTTONUP;
  btnDown.Caption:=IDSHELL_BUTTONDOWN;
  btnOK.Caption:=IDSHELL_OK;
  btnCancel.Caption:=IDSHELL_CANCEL;
  btnDisplay.Caption:=IDSHELL_DISPLAY;
  btnHide.Caption:=IDSHELL_HIDE;
  lblInstruction.Caption:=IDSHELL_COLINSTRUCTION;
  lblWidth.Caption:=IDSHELL_WIDTHCAPTION;
  fItems := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.FormDestroy(Sender: TObject);
begin
  fItems.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.edWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if not (AnsiChar(Key) in ['0'..'9', chr(VK_BACK)]) then
    Key := #0;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.btnClick(Sender: TObject);
var
  tmp, II:Integer;
begin
  II := lb.ItemIndex;

  if II < 0 then exit;

  tmp := ii;

  if (sender = btnHide) or (sender = btnDisplay) then
    lb.Checked[ii] := not lb.Checked[ii]
  else
  if sender=btnUp then
    tmp := ii - 1
  else
  if sender=btnDown then
    tmp := ii + 1;

  if  ii <> tmp then
    begin
      lb.Items.Move(ii, tmp);
      lb.ItemIndex := tmp;
    end;

  UpdateStates;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.UpdateStates;
var
  ii, N: integer;
begin
  ii := lb.ItemIndex;
  N := lb.Items.Count;
  lb.Enabled := not chk.Checked and (N > 0);
  btnUp.Enabled := lb.Enabled and (ii > 1);
  btnDown.Enabled := lb.Enabled and (ii > 0) and (ii < (N - 1));
  btnDisplay.Enabled := lb.Enabled and (ii > 0) and (not lb.Checked[ii]) ;
  btnHide.Enabled := lb.Enabled and (ii > 0) and lb.Checked[ii];
  lblWidth.Enabled := lb.Enabled and (ii >= 0);
  edWidth.Enabled := lblwidth.Enabled;

  if ii >= 0  then
    edWidth.Text := IntToStr(integer(fItems.Objects[integer(lb.Items.Objects[ii])]))
  else
    edWidth.Text := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.lbClick(Sender: TObject);
begin
  if  lb.Items.Count > 0  then
  begin
    if  lb.ItemEnabled[0] then
      lb.ItemEnabled[0] := false;

    if  chk.Checked then
      lb.ItemIndex := -1
    else
    if  lb.ItemIndex < 0  then
    begin
      lb.ItemIndex := 0;
    end;
  end;

  UpdateStates;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellfrmListDialog.edWidthExit(Sender: TObject);
var
  ii: integer;
begin
  if  not (csDestroying in self.ComponentState) then
    begin
      ii := lb.ItemIndex;

      if  ii >= 0 then
        ii := integer(lb.Items.Objects[ii]);

      if  ii >= 0 then
        fItems.Objects[ii] := TObject(StrToIntDef(edWidth.Text,
              integer(fItems.Objects[ii])));
    end;
end;

procedure TLMDShellfrmListDialog.lbClickCheck(Sender: TObject);
begin
  lb.Checked[0]:=True;
end;

end.

