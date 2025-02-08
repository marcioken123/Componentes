unit LMDIdeTabOrderDlg;
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

LMDIdeTabOrderDlg unit (YB)
------------------------
LMDTabOrderDialog unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, LMDTypes, LMDSvcPvdr, LMDArrayUtils, LMDDsgModule, LMDDsgDesigner,
  LMDIdeCst, StdCtrls;

type
  {***************************** TLMDTabOrderForm *****************************}

  TLMDTabOrderForm = class(TForm)
    GroupBox1: TGroupBox;
    ListCaption: TLabel;
    ListBox: TListBox;
    UpButton: TSpeedButton;
    DownButton: TSpeedButton;
    OkButton: TButton;
    CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
  private
    FDesigner:    TLMDDesigner;
    FParent:      TWinControl;
    FHasControls: Boolean;

    procedure Init;
    function  HasChildWinControls(AParent: TWinControl): Boolean;
    function  DetectParent: TWinControl;
    function  SortCallback(AIdx1, AIdx2: Integer;
                           AOp: TLMDArrayOperation): Integer;
  public
    constructor Create(ADesigner: TLMDDesigner); reintroduce;
  end;

implementation

{$R *.dfm}

{****************************** TLMDTabOrderForm ******************************}
{------------------------------------------------------------------------------}

constructor TLMDTabOrderForm.Create(ADesigner: TLMDDesigner);
begin
  FDesigner := ADesigner;
  inherited Create(Application);
end;

{------------------------------------------------------------------------------}

procedure TLMDTabOrderForm.Init;
var
  i: Integer;
begin
  FParent := DetectParent;

  ListBox.Items.BeginUpdate;
  try
    for i := 0 to FParent.ControlCount - 1 do
      if FParent.Controls[i] is TWinControl then
      begin
        ListBox.Items.AddObject(FParent.Controls[i].Name,
                                FParent.Controls[i]);
      end;

    FHasControls := (ListBox.Items.Count <> 0);

    if FHasControls then
      LMDArrayShortSort(0, ListBox.Items.Count - 1, SortCallback)
    else
      ListBox.Items.Add(SLMDTabOrderDlgNone);
  finally
    ListBox.Items.EndUpdate;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDTabOrderForm.FormCreate(Sender: TObject);
begin
  Caption              := SLMDTabOrderDlgCaption;
  ListCaption.Caption  := SLMDTabOrderDlgListCaption;
  OkButton.Caption     := SLMDTabOrderDlgOk;
  CancelButton.Caption := SLMDTabOrderDlgCancel;

  Init;
end;
      
{------------------------------------------------------------------------------}

function TLMDTabOrderForm.DetectParent: TWinControl;
var
  ctrl: TControl;
begin
  Result := nil;

  if (FDesigner.Selection.Count = 1) and
     (FDesigner.Selection[0] is TControl) then
  begin
    ctrl := TControl(FDesigner.Selection[0]);
    if (ctrl is TWinControl) and (csAcceptsControls in ctrl.ControlStyle) and
       HasChildWinControls(TWinControl(ctrl)) then
      Result := TWinControl(ctrl)
    else
      Result := ctrl.Parent;
  end;

  if Result = nil then
    Result := FDesigner.Module.Root;
end;
       
{------------------------------------------------------------------------------}

function TLMDTabOrderForm.HasChildWinControls(
  AParent: TWinControl): Boolean;
var
  i: Integer;
begin
  for i := 0 to AParent.ControlCount - 1 do
    if AParent.Controls[i] is TWinControl then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDTabOrderForm.OkButtonClick(Sender: TObject);
var
  i:     Integer;
  ctrl:  TWinControl;
  ctrls: TList;
begin
  if FHasControls then
  begin
    ctrls := TList.Create;
    try
      for i := 0 to ListBox.Items.Count - 1 do
      begin
        ctrl := TWinControl(ListBox.Items.Objects[i]);

        ctrl.TabOrder := i;
        ctrls.Add(ctrl);
      end;

      LMDComponentsChanged(Self, ctrls);
    finally
      ctrls.Free;
    end;
  end;

  ModalResult := mrOk;
end;
   
{------------------------------------------------------------------------------}

procedure TLMDTabOrderForm.UpButtonClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := ListBox.ItemIndex;
  if FHasControls and (idx > 0) then
  begin
    ListBox.Items.Move(idx, idx - 1);
    ListBox.ItemIndex := (idx - 1);
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDTabOrderForm.DownButtonClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := ListBox.ItemIndex;
  if FHasControls and (idx < (ListBox.Items.Count - 1)) then
  begin
    ListBox.Items.Move(idx, idx + 1);
    ListBox.ItemIndex := (idx + 1);
  end;
end;
   
{------------------------------------------------------------------------------}

function TLMDTabOrderForm.SortCallback(AIdx1, AIdx2: Integer;
  AOp: TLMDArrayOperation): Integer;
begin
  Result := 0;

  case AOp of
    aoCompare:  Result := TWinControl(ListBox.Items.Objects[AIdx1]).TabOrder -
                          TWinControl(ListBox.Items.Objects[AIdx2]).TabOrder;
    aoSwap:     ListBox.Items.Exchange(AIdx1, AIdx2);
    aoGetSize:  Result := ListBox.Items.Count;
  else
    Assert(False);
  end;
end;
     
{------------------------------------------------------------------------------}

end.
