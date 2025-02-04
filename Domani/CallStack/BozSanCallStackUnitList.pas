unit BozSanCallStackUnitList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormUnitList = class(TForm)
    Panel1: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    LvUnits: TListView;
    BtnSel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BtnSelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
    WizardFunction;

procedure TFormUnitList.FormCreate(Sender: TObject);
var
    i: Integer;
    Item: TListItem;
    s: String;
begin
    if GetActiveProject = NIL then
    	raise Exception.Create('No projects open');

    LvUnits.Items.BeginUpdate;
    try
        GetProjectModules;
        LvUnits.Items.Clear;
        for i := 0 to InfoModuleList.Count - 1 do
            begin

            s := InfoModuleList[i].FileName;
            if comparetext(ExtractFileExt(s), '.pas') = 0 then
                begin
                Item := LvUnits.Items.Add;
                Item.Caption := ExtractFileName(s);
                Item.SubItems.Add(s);
                Item.Checked := FALSE;
                end;
            end;
    finally
        LvUnits.Items.EndUpdate;
    end;
end;

procedure TFormUnitList.BtnSelClick(Sender: TObject);
var
    bSel: boolean;
    i: Integer;
begin

    bSel := BtnSel.Caption = 'Select All';
    for i := 0 to LvUnits.Items.Count - 1 do
        LvUnits.Items[i].Checked := bSel;
    if bSel then
        BtnSel.Caption := 'Unselect All'
    else
        BtnSel.Caption := 'Select All';
end;

end.
