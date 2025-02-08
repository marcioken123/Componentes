unit LMDShListFilterDlg;
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

LMDShListFilterDlg unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  LMDShBase,
  LMDShList,
  LMDShConsts;

type
  TLMDfrmShellListFilterDialog = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    hcb: TComboBox;
    Label1: TLabel;
    rg: TRadioGroup;
  private
  public
  end;

  { ******************* class TLMDShellListFilterDialog ********************** }
  TLMDShellListFilterDialog=class(TLMDShellBaseDialog)
  private
    FAuto,
    Fon,
    FDirs:Boolean;
    FFilter,
    FCaption,
    FInstructionText:String;
    FShellList: TLMDShellList;
    FHistory:TStringList;
    FCount:Integer;
    procedure SetShellList(aValue: TLMDShellList);
    procedure SetHistoryList(aValue:TStringList);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure GetChange(Sender:TObject);override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(aHWND:HWND=0):Boolean; override;
    property Filter:String read FFilter write FFilter;
    property FilterActive:Boolean read FOn write FOn;
    property FilterDirs:Boolean read FDirs write FDirs;
  published
    property AutoEnabled:Boolean read FAuto write FAuto default true;
    property Caption: string read FCaption write FCaption;
    property InstructionText:string read FInstructionText write FInstructionText;
    property ShellList: TLMDShellList read FShellList write SetShellList;
    property HistoryList:TStringList read FHistory write SetHistoryList;
    property HistoryCount:Integer read FCount write FCount default 10;
  end;

implementation

{$R *.dfm}
{ ******************** TLMDShellListFilterDialog  **************************** }
{----------------------------- Private ----------------------------------------}
procedure TLMDShellListFilterDialog.SetShellList(aValue: TLMDShellList);
begin
  if aValue<>FShellList then
    FShellList:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListFilterDialog.SetHistoryList(aValue:TStringList);
begin
  FHistory.Assign(aValue);
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDShellListFilterDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FShellList<>nil) and (AComponent=FShellList) then
    FShellList := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListFilterDialog.GetChange(Sender:TObject);
begin
  while FCount<FHistory.Count do
    FHistory.Delete(FHistory.Count-1);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellListFilterDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FAuto:=True;
  FCaption:= EmptyStr;
  FInstructionText:=EmptyStr;
  FCount:=10;
  FHistory:=TStringList.Create;
  FHistory.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellListFilterDialog.Destroy;
begin
  FreeAndNil(FHistory);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDShellListFilterDialog.Execute;
var
  FDialog:TLMDfrmShellListFilterDialog;
  i:Integer;
begin
  result:=false;
  if FAuto and (FShellList=nil) then Exit;

  // RM
  if ((OwnerHandle=pwOwnerForm) and (Owner is TCustomForm)) and not (csDesigning in ComponentState) then
    FDialog:=TLMDfrmShellListFilterDialog.Create(Owner)
  else
    FDialog:=TLMDfrmShellListFilterDialog.Create(nil);

  with FDialog do
    try
      // String resources
      if FCaption <> EmptyStr then FDialog.Caption := FCaption else FDialog.Caption:=IDSHELL_Filters;
      if FInstructionText<>EmptyStr then Label1.Caption:=FInstructionText else Label1.Caption:=IDSHELL_FilterInstruction;
      rg.Items.Text:=IDSHELL_FilterOptions;
      rg.Caption:=IDSHELL_ApplyFilter;
      btnOk.Caption:=IDSHELL_OK;
      btnCancel.Caption:=IDSHELL_CANCEL;
      groupbox1.Caption:=IDSHELL_SpecifyFilter;

      if FAuto then
        begin
          FOn:=FShellList.Filtered;
          FDirs:=FShellList.FilterDirs;
          FFilter:=FShellList.FileFilter;
        end;

      // settings in Dialog
      hcb.Items:=FHistory;
      rg.ItemIndex:=0;
      If FOn then
        if FDirs then rg.ItemIndex:=2 else rg.ItemIndex:=1;
      if FFilter=EmptyStr then hcb.Text:='*.*' else hcb.Text:=FFilter;

      Result:=ShowModal=mrOk;
      if Result then
        begin
          FFilter:=hcb.Text;
          FOn:=rg.ItemIndex>0;
          FDirs:=rg.ItemIndex=2;

          if FAuto then
            begin
              FShellList.FileFilter:=FFilter;
              FShellList.Filtered:=FOn;
              FShellList.FilterDirs:=FDirs;
            end;

          // Update History?
          If FFilter<>'' then
            begin
              i:=FHistory.IndexOf(FFilter);
              if i=-1 then
                FHistory.Insert(0, FFilter)
              else
                FHistory.Move(i, 0);
            end;
        end;
    finally
      FreeAndNil(FDialog);
    end;
end;

end.
