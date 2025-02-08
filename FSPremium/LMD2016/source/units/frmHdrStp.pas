unit frmHdrStp;
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

frmHdrStp unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ElHeader, ExtCtrls, StdCtrls, ElBtnCtl, ElPopBtn, LMDTypes,
  Types,
  ElXPThemedControl, ElCLabel, ElLabel, ElListBox;

type
  TfrmHeaderSetup = class(TForm)
    pnlSections: TPanel;
    lbxAvailable: TElListBox;
    lbxVisible: TElListBox;
    lblAvailable: TElLabel;
    lblVisible: TElLabel;
    btnAdd: TElPopupButton;
    btnDelete: TElPopupButton;
    btnUp: TElPopupButton;
    btnDown: TElPopupButton;
    btnOk: TElPopupButton;
    btnCancel: TElPopupButton;
    procedure FormShow(Sender: TObject);
    procedure lbxVisibleEnter(Sender: TObject);
    procedure lbxAvailableEnter(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure lbxVisibleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbxVisibleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxVisibleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbxAvailableDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxAvailableMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbxAvailableDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    procedure UpdateButtons;
  public
    procedure LoadHeaderSections(ASections: TElHeaderSections);
    procedure SaveHeaderSections(ASections: TElHeaderSections);
  end;

implementation

{$R *.DFM}
{ TfrmHeaderSetup }

procedure TfrmHeaderSetup.LoadHeaderSections(ASections: TElHeaderSections);
var
  I: integer;
  S: TLMDString;
  Section: TElHeaderSection;
begin
  lbxAvailable.Items.BeginUpdate;
  lbxAvailable.Items.Clear;
  lbxVisible.Items.BeginUpdate;
  lbxVisible.Items.Clear;

  // Setting font to Font of TElHeader, so all characters could be displayed
  if ASections.Owner is TElHeader then
  begin
    lbxAvailable.Font.Name := (ASections.Owner as TElHeader).Font.Name;
    lbxAvailable.SelectedFont.Name := lbxAvailable.Font.Name;
    lbxVisible.Font.Name := lbxAvailable.Font.Name;
    lbxVisible.SelectedFont.Name := lbxVisible.Font.Name;
  end;

  for I := 0 to ASections.Count - 1 do
  begin
    Section := ASections.ItemByPos[I];
    S := Section.Text;
    if S = '' then S := '(Untitled)';
    if Section.Visible then
      lbxVisible.Items.AddObject(S, Section)
    else
      lbxAvailable.Items.AddObject(S, Section);
  end;
  lbxVisible.Items.EndUpdate;
  lbxAvailable.Items.EndUpdate;
end;

procedure TfrmHeaderSetup.UpdateButtons;
begin
  btnAdd.Enabled := lbxAvailable.Focused and (lbxAvailable.ItemIndex > -1);
  btnDelete.Enabled := lbxVisible.Focused and (lbxVisible.ItemIndex > -1);
  btnUp.Enabled := lbxVisible.Focused and (lbxVisible.ItemIndex > 0);
  btnDown.Enabled := lbxVisible.Focused and (lbxVisible.ItemIndex > -1) and
    (lbxVisible.ItemIndex < lbxVisible.Items.Count - 1);
end;

procedure TfrmHeaderSetup.FormShow(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TfrmHeaderSetup.lbxVisibleEnter(Sender: TObject);
begin
  if (lbxVisible.ItemIndex = -1) and (lbxVisible.Items.Count > 0) then
    lbxVisible.ItemIndex := 0;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.lbxAvailableEnter(Sender: TObject);
begin
  if (lbxAvailable.ItemIndex = -1) and (lbxAvailable.Items.Count > 0) then
    lbxAvailable.ItemIndex := 0;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.btnAddClick(Sender: TObject);
var
  Index: integer;
begin
  if lbxAvailable.ItemIndex = -1 then exit;
  Index := lbxAvailable.ItemIndex;
  lbxVisible.ItemIndex := lbxVisible.Items.AddObject(lbxAvailable.Items[Index],
    lbxAvailable.Items.Objects[Index]);
  lbxAvailable.Items.Delete(Index);
  if lbxAvailable.Items.Count > 0 then
    if lbxAvailable.Items.Count <= Index then
      lbxAvailable.ItemIndex := lbxAvailable.Items.Count - 1
    else
      lbxAvailable.ItemIndex := Index;
  lbxAvailable.SetFocus;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.btnDeleteClick(Sender: TObject);
var
  Index: integer;
begin
  if lbxVisible.ItemIndex = -1 then exit;
  Index := lbxVisible.ItemIndex;
  lbxAvailable.ItemIndex := lbxAvailable.Items.AddObject(lbxVisible.Items[Index],
    lbxVisible.Items.Objects[Index]);
  lbxVisible.Items.Delete(Index);
  if lbxVisible.Items.Count > 0 then
    if lbxVisible.Items.Count <= Index then
      lbxVisible.ItemIndex := lbxVisible.Items.Count - 1
    else
      lbxVisible.ItemIndex := Index;
  lbxVisible.SetFocus;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.btnUpClick(Sender: TObject);
var
  Index: integer;
begin
  if lbxVisible.ItemIndex <= 0 then exit;
  Index := lbxVisible.ItemIndex;
  lbxVisible.Items.Exchange(Index, Index - 1);
  lbxVisible.ItemIndex := Index - 1;
  lbxVisible.SetFocus;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.btnDownClick(Sender: TObject);
var
  Index: integer;
begin
  if (lbxVisible.ItemIndex = -1) or (lbxVisible.ItemIndex = lbxVisible.Items.Count - 1) then exit;
  Index := lbxVisible.ItemIndex;
  lbxVisible.Items.Exchange(Index, Index + 1);
  lbxVisible.ItemIndex := Index + 1;
  lbxVisible.SetFocus;
  UpdateButtons;
end;

procedure TfrmHeaderSetup.lbxVisibleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then lbxVisible.BeginDrag(False);
end;

procedure TfrmHeaderSetup.lbxVisibleDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Source = lbxVisible) or (Source = lbxAvailable) then
    Accept := True;
end;

procedure TfrmHeaderSetup.lbxVisibleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index,
  Index1: integer;
begin
  if Source = lbxVisible then
  begin
    Index := lbxVisible.ItemAtPos(Point(X, Y), True);
    if Index <> -1 then
    begin
      lbxVisible.Items.Move(lbxVisible.ItemIndex, Index);
      lbxVisible.ItemIndex := Index;
      UpdateButtons;
    end;
  end
  else
  if Source = lbxAvailable then
  begin
    Index := lbxAvailable.ItemIndex;
    Index1 := lbxVisible.ItemAtPos(Point(X, Y), True);
    if Index1 = -1 then Index1 := lbxVisible.Items.Count;
    lbxVisible.Items.InsertObject(Index1, lbxAvailable.Items[Index],
      lbxAvailable.Items.Objects[Index]);
    lbxVisible.ItemIndex := Index1;

    lbxAvailable.Items.Delete(Index);
    if lbxAvailable.Items.Count > 0 then
      if lbxAvailable.Items.Count <= Index then
        lbxAvailable.ItemIndex := lbxAvailable.Items.Count - 1
      else
        lbxAvailable.ItemIndex := Index;
    lbxAvailable.SetFocus;
    UpdateButtons;
  end;
end;

procedure TfrmHeaderSetup.lbxAvailableDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = lbxVisible);
end;

procedure TfrmHeaderSetup.lbxAvailableMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then lbxAvailable.BeginDrag(False);
end;

procedure TfrmHeaderSetup.lbxAvailableDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index: integer;
begin
  if Source = lbxVisible then
  begin
    Index := lbxVisible.ItemIndex;

    lbxAvailable.ItemIndex := lbxAvailable.Items.AddObject(lbxVisible.Items[Index],
      lbxVisible.Items.Objects[Index]);
    lbxVisible.Items.Delete(Index);
    if lbxVisible.Items.Count > 0 then
      if lbxVisible.Items.Count <= Index then
        lbxVisible.ItemIndex := lbxVisible.Items.Count - 1
      else
        lbxVisible.ItemIndex := Index;
    lbxVisible.SetFocus;
    UpdateButtons;
  end;
end;

procedure TfrmHeaderSetup.SaveHeaderSections(ASections: TElHeaderSections);
var
  I, K: integer;
  Section: TElHeaderSection;
begin
  K := 0;
  for I := 0 to lbxVisible.Items.Count - 1 do
  begin
    Section := TElHeaderSection(lbxVisible.Items.Objects[I]);
    ASections.MoveSection(Section, K);
    Section.Visible := True;
    Inc(K);
  end;
  for I := 0 to lbxAvailable.Items.Count - 1 do
  begin
    Section := TElHeaderSection(lbxAvailable.Items.Objects[I]);
    ASections.MoveSection(Section, K);
    Section.Visible := False;
    Inc(K);
  end;
end;

end.
