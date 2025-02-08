unit LMDShPathFrame;
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

LMDShPathFrame unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, StdCtrls, Controls, Classes, Buttons, Windows;

type
  TLMDShellPathFrame = class(TFrame)
    PathListBox: TListBox;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    DeleteBtn: TButton;
    AddBtn: TButton;
    ReplaceBtn: TButton;
    PathEdit: TEdit;
    BrowseBtn: TButton;
    DelInvalidPathsBtn: TButton;
    FirstBtn: TSpeedButton;
    LastBtn: TSpeedButton;
    procedure PathListBoxClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure PathEditChange(Sender: TObject);
    procedure ReplaceBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure BrowseBtnClick(Sender: TObject);
    procedure DelInvalidPathsBtnClick(Sender: TObject);
    procedure PathListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FirstBtnClick(Sender: TObject);
    procedure LastBtnClick(Sender: TObject);
    procedure PathListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PathListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PathListBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    FszDelimeter: String;
    FPathIdent: String;
    FPathKey: String;
    FPathKeyValue: String;
    FCustomRootPath: string;
    FPathMustExist: Boolean;
    function GetPath: String;
    procedure SetPath(const Value: String);
    procedure SetszDelimeter(const Value: String);
    procedure SetPathIdent(const Value: String);
    procedure SetPathKey(const Value: String);
    function GetRootPath: String;
    procedure SetPathKeyValue(const Value: String);
    procedure SetCustomRootPath(const Value: string);
  public
    { Public declarations }
    iDrag       : Integer;
    constructor Create(AOwner: TComponent); override;
    procedure   UpdateBtn;
    procedure   UpdateOnShow;
    procedure   Clear;
    function    GetFillPath(const szPath:String):String;
    function    GetSmartPath(const szPath:String):String;
    property    RootPath:String read GetRootPath;
    property    szPathList:String read GetPath write SetPath;
    property    szDelimeter:String read FszDelimeter write SetszDelimeter;
    property    PathKey:String read FPathKey write SetPathKey;
    property    PathKeyValue:String read FPathKeyValue write SetPathKeyValue;
    property    PathIdent:String read FPathIdent write SetPathIdent;
    property    CustomRootPath:string read FCustomRootPath write SetCustomRootPath;
    property    PathMustExist: Boolean read FPathMustExist write FPathMustExist default True;
  end;

implementation

uses
  SysUtils, Dialogs, FileCtrl, Graphics, Registry,

  LMDShConsts, LMDShBrwDlg, LMDShDlg;

{$R *.dfm}

{ TLMDShellPathFrame }
procedure TLMDShellPathFrame.UpdateBtn;
var
  sPath, fPath: string;
  ii: integer;
begin
  ii := PathListBox.ItemIndex;
  sPath := GetSmartPath(Trim(PathEdit.Text));
  fPath := GetFillPath(Trim(PathEdit.Text));
  UpBtn.Enabled := ii > 0;
  DownBtn.Enabled := (ii >= 0) and (ii < (PathListBox.Items.Count - 1));
  AddBtn.Enabled := (sPath <> '') and (PathListBox.Items.IndexOf(sPath) < 0)
    and (PathListBox.Items.IndexOf(fPath) < 0)
    and (not PathMustExist or DirectoryExists(fPath));
  ReplaceBtn.Enabled := AddBtn.Enabled and (ii >= 0);
  DeleteBtn.Enabled := (ii >= 0);
  LastBtn.Enabled := DownBtn.Enabled;
  FirstBtn.Enabled := UpBtn.Enabled;
end;

procedure TLMDShellPathFrame.PathListBoxClick(Sender: TObject);
begin
  if PathListBox.ItemIndex >= 0 then
    PathEdit.Text := GetFillPath(PathListBox.Items[PathListBox.ItemIndex])
  else
    PathEdit.Text := '';
  UpdateBtn;
end;

procedure TLMDShellPathFrame.UpBtnClick(Sender: TObject);
begin
  if PathListBox.ItemIndex>0 then
  begin
    PathListBox.Items.Exchange(PathListBox.ItemIndex,PathListBox.ItemIndex-1);
    UpdateBtn;
  end;
end;

procedure TLMDShellPathFrame.DownBtnClick(Sender: TObject);
begin
  if PathListBox.ItemIndex<(PathListBox.Items.Count-1) then
  begin
    PathListBox.Items.Exchange(PathListBox.ItemIndex,PathListBox.ItemIndex+1);
    UpdateBtn;
  end;
end;

procedure TLMDShellPathFrame.PathEditChange(Sender: TObject);
begin
  UpdateBtn;
end;

procedure TLMDShellPathFrame.ReplaceBtnClick(Sender: TObject);
begin
  if  PathListBox.ItemIndex >= 0  then
    PathListBox.Items[PathListBox.ItemIndex] := GetSmartPath(Trim(PathEdit.Text));

  UpdateBtn;
end;

procedure TLMDShellPathFrame.AddBtnClick(Sender: TObject);
var
  szPath : String;
begin
  szPath := GetSmartPath(Trim(PathEdit.Text));

  if  PathListBox.Items.IndexOf(szPath) >= 0  then
    MessageDlg(sDuplicatedPath, mtError, [mbOk], 0)
  else
    PathListBox.Items.Add(szPath);

  UpdateBtn;
end;

procedure TLMDShellPathFrame.DeleteBtnClick(Sender: TObject);
var
  i : Integer;
begin
  i := PathListBox.ItemIndex;
  if PathListBox.Items.Count=1 then
     i := -1
  else
    if PathListBox.Items.Count-1=i then
      Dec(i);
  PathListBox.Items.Delete(PathListBox.ItemIndex);
  PathListBox.ItemIndex := i;
  UpdateBtn;
end;

function TLMDShellPathFrame.GetPath: String;
begin
  Result := StringReplace(Trim(PathListBox.Items.Text), #13#10, FszDelimeter,
    [rfReplaceAll]);
//  Result := ReplaceStr(PathListBox.Items.Text, #13#10, FszDelimeter);
end;

procedure TLMDShellPathFrame.SetPath(const Value: String);
begin
  PathListBox.Items.Text := StringReplace(Trim(Value), FszDelimeter, #13#10,
    [rfReplaceAll]);
//  PathListBox.Items.text:=ReplaceStr(Value,FszDelimeter,#13#10);
  PathEdit.Text := '';
end;

procedure TLMDShellPathFrame.SetszDelimeter(const Value: String);
begin
  FszDelimeter := Value;
end;

constructor TLMDShellPathFrame.Create(AOwner: TComponent);
begin
  inherited;
  FszDelimeter  := ';';
  FPathMustExist := True;
end;

procedure TLMDShellPathFrame.BrowseBtnClick(Sender: TObject);
begin
  with TLMDShellSysBrowseDialog.Create(Self) do
    try
      SelectedPath := PathEdit.Text;

      if Execute(Handle) then
        PathEdit.Text := SelectedPath;
    finally
      Free;
    end;
end;

procedure TLMDShellPathFrame.UpdateOnShow;
begin
  UpdateBtn;
end;

procedure TLMDShellPathFrame.Clear;
begin
  PathListBox.Items.Clear;
  PathEdit.Text := '';
end;

procedure TLMDShellPathFrame.DelInvalidPathsBtnClick(Sender: TObject);
var
  i : Integer;
begin
  i :=0;

  while i < PathListBox.Items.Count do
  begin
    if DirectoryExists(PathListBox.Items[i]) then
      Inc(i)
    else
      PathListBox.Items.Delete(i);
  end;
  PathListBox.ItemIndex := 0;
end;

procedure TLMDShellPathFrame.PathListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Color : TColor;
  S: string;
begin
  if  Index >= 0  then
    S := PathListBox.Items[Index]
  else
    S := '';

  with PathListBox.Canvas do
  begin
    FillRect(Rect);
    Color := PathListBox.Canvas.Font.Color;
    if PathMustExist and not DirectoryExists(GetFillPath(S)) then
      PathListBox.Canvas.Font.Color := clGrayText;
    TextOut(Rect.Left, Rect.Top, S);
    PathListBox.Canvas.Font.Color := Color;
  end;
end;

procedure TLMDShellPathFrame.FirstBtnClick(Sender: TObject);
begin
  if PathListBox.ItemIndex>0 then
  begin
    PathListBox.Items.Move(PathListBox.ItemIndex,0);
    PathListBox.ItemIndex := 0;
    UpdateBtn;
  end;
end;

procedure TLMDShellPathFrame.LastBtnClick(Sender: TObject);
begin
  if PathListBox.ItemIndex<(PathListBox.Items.Count-1) then
  begin
    PathListBox.Items.Move(PathListBox.ItemIndex,PathListBox.Items.Count-1);
    PathListBox.ItemIndex := PathListBox.Items.Count-1;
    UpdateBtn;
  end;
end;

procedure TLMDShellPathFrame.PathListBoxDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Sender=Source) then
    Accept := (iDrag>=0) and (PathListBox.ItemAtPos(Point(X,Y), False)>=0);
end;

procedure TLMDShellPathFrame.PathListBoxDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  i : Integer;
begin
  if (Sender = Source) and (iDrag >= 0) then
  begin
    i := PathListBox.ItemAtPos(Point(X,Y), False);

    if i >= 0 then
    begin
      if  i >= PathListBox.Items.Count  then
        begin
          PathListBox.Items.Add(PathListBox.Items[iDrag]);
          PathListBox.Items.Delete(iDrag);
          i := PathListBox.Items.Count - 1;
        end
      else
        PathListBox.Items.Move(iDrag, i);

      PathListBox.ItemIndex := i;
    end;
  end;

  iDrag := -1;
end;

procedure TLMDShellPathFrame.PathListBoxStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iDrag := PathListBox.ItemIndex;
end;

procedure TLMDShellPathFrame.SetPathIdent(const Value: String);
begin
  FPathIdent := Value;
end;

procedure TLMDShellPathFrame.SetPathKey(const Value: String);
begin
  FPathKey := Value;
end;

function TLMDShellPathFrame.GetRootPath: String;
var
  Reg : TRegistry;
begin
  Result := '';
  if FPathKey<>'' then
  begin
    Reg := TRegistry.Create;
    try
      Reg.Access := KEY_READ;
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey(FPathKey, False) then
        Result := Reg.ReadString(FPathKeyValue)
      else
        Result := CustomRootPath;
    finally
      Reg.Free;
    end;
  end
  else
    Result := CustomRootPath;
end;

procedure TLMDShellPathFrame.SetPathKeyValue(const Value: String);
begin
  FPathKeyValue := Value;
end;

function TLMDShellPathFrame.GetFillPath(const szPath: String): String;
begin
  if (FPathIdent<>'') and (UpperCase(Copy(szPath,1,Length(FPathIdent)))=FPathIdent) and (RootPath<>'') then
  begin
    Result := RootPath+Copy(szPath,Length(FPathIdent)+1,Length(szPath));
  end
  else
    Result := szPath;
end;

function TLMDShellPathFrame.GetSmartPath(const szPath: String): String;
var
  RP : String;
begin
  Result := szPath;
  RP := GetRootPath;
  if (FPathIdent<>'') and (RP<>'') then
  begin
    if (Copy(szPath,1,Length(RP)+1)=RP+'\') then
    begin
      Result := FPathIdent+Copy(szPath,Length(RP)+1,Length(szPath));
    end;
  end;
end;

procedure TLMDShellPathFrame.SetCustomRootPath(const Value: string);
begin
  FCustomRootPath := Value;
end;

procedure TLMDShellPathFrame.FrameResize(Sender: TObject);
var
  H, dH: integer;
begin
  dH := DownBtn.Top - (UpBtn.Top + UpBtn.Height);
  H := (LastBtn.Top + LastBtn.Height) - FirstBtn.Top;
  FirstBtn.Top := PathListBox.Top + (PathListBox.Height - H) div 2;

  if  FirstBtn.Top < PathListBox.Top  then
    FirstBtn.Top := PathListBox.Top;
    UpBtn.Top := FirstBtn.Top + FirstBtn.Height;
  DownBtn.Top := UpBtn.Top + UpBtn.Height + dH;
  LastBtn.Top := DownBtn.Top + DownBtn.Height;
end;

end.
