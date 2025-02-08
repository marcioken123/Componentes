unit LMDIdeCreationOrderDlg;
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

LMDIdeCreationOrderDlg unit (YB)
------------------------
LMDCreationOrderDialog unit.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, LMDTypes, LMDSvcPvdr, LMDArrayUtils, LMDDsgModule,
  LMDDsgDesigner, LMDIdeCst, LMDDsgClass;

type
  {************************** TLMDCreationOrderForm ***************************}

  TLMDCreationOrderForm = class(TForm)
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
    FDesigner: TLMDDesigner;
    FHasComps: Boolean;

    procedure Init;
    procedure AddItem(Child: TComponent);
  public
    constructor Create(ADesigner: TLMDDesigner); reintroduce;
  end;

implementation

{$R *.dfm}

type
  TComponentAccess = class(TComponent);

{*************************** TLMDCreationOrderForm ****************************}
{------------------------------------------------------------------------------}

constructor TLMDCreationOrderForm.Create(ADesigner: TLMDDesigner);
begin
  FDesigner := ADesigner;
  inherited Create(Application);
end;

{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.Init;
begin
  ListBox.Items.BeginUpdate;
  try
    TComponentAccess(FDesigner.Module.Root).GetChildren(AddItem,
                                                        FDesigner.Module.Root);
    FHasComps := (ListBox.Items.Count <> 0);

    if not FHasComps then
      ListBox.Items.Add(SLMDCreationOrderDlgNone);
  finally
    ListBox.Items.EndUpdate;
  end;
end;
          
{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.FormCreate(Sender: TObject);
begin
  Caption              := SLMDCreationOrderDlgCaption;
  ListCaption.Caption  := SLMDCreationOrderDlgListCaption;
  OkButton.Caption     := SLMDCreationOrderDlgOk;
  CancelButton.Caption := SLMDCreationOrderDlgCancel;

  Init;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.OkButtonClick(Sender: TObject);
var
  i:     Integer;
  root:  TWinControl;
  comp:  TComponent;
  comps: TList;
begin
  if FHasComps then
  begin
    comps := TList.Create;
    try
      root := FDesigner.Module.Root;

      for i := 0 to ListBox.Items.Count - 1 do
      begin
        comp := TComponent(ListBox.Items.Objects[i]);
        TComponentAccess(root).SetChildOrder(comp, root.ControlCount + i);
        comps.Add(comp);
      end;

      LMDComponentsChanged(Self, comps);
    finally
      comps.Free;
    end;
  end;

  ModalResult := mrOk;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.UpButtonClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := ListBox.ItemIndex;
  if FHasComps and (idx > 0) then
  begin
    ListBox.Items.Move(idx, idx - 1);
    ListBox.ItemIndex := (idx - 1);
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.DownButtonClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := ListBox.ItemIndex;
  if FHasComps and (idx < (ListBox.Items.Count - 1)) then
  begin
    ListBox.Items.Move(idx, idx + 1);
    ListBox.ItemIndex := (idx + 1);
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDCreationOrderForm.AddItem(Child: TComponent);
begin
  if (Child.Owner = FDesigner.Module.Root) and
     not (Child is TControl) then
    ListBox.Items.AddObject(Child.Name, Child);
end;
     
{------------------------------------------------------------------------------}

end.
