unit LMDShPathDlg;
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

LMDShPathDlg unit (DS)
----------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}
interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, Windows, Messages,
  LMDShBase, LMDShConsts, LMDShPathFrame;

type
  TLMDShellCustomPathForm = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    OkBtn: TButton;
    CancelBtn: TButton;
    Panel2: TPanel;
    InstructionLabel: TLabel;
    LMDShellPathFrame1: TLMDShellPathFrame;
    procedure FormShow(Sender: TObject);
  private
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
  end;

  TLMDShellPathDialogOption = (poSizeable, poInstructionField, poShowDeleteInvalidButton,
      poHelpButton, poSpeedFlat, poPathMustExist);
  TLMDShellPathDialogOptions = set of TLMDShellPathDialogOption;

  { *********************** class TLMDShellPathDialog *********************** }
  TLMDShellPathDialog = class(TLMDShellBaseDialog)
  private
    FDelimeter: String;
    FCaption: String;
    FPath: String;
    FInstructionText: String;
    FOptions: TLMDShellPathDialogOptions;
    FRootPath: String;
    FPathKeyValue: String;
    FPathKey: String;
    FPathIdent: String;
    procedure SetCaption(const Value: String);
    procedure SetDelimeter(const Value: String);
    procedure SetPath(const Value: String);
    procedure SetInstructionText(const Value: String);
    procedure SetOptions(const Value: TLMDShellPathDialogOptions);
    procedure SetPathIdent(const Value: String);
    procedure SetPathKey(const Value: String);
    procedure SetPathKeyValue(const Value: String);
    procedure SetRootPath(const Value: String);
  public
    function Execute(aHWND: HWND=0):Boolean;override;
    constructor Create(AOwner: TComponent);override;
  published
    property  Caption:String read FCaption write SetCaption;
    property  Path:String read FPath write SetPath;
    property  Delimeter:String read FDelimeter write SetDelimeter;
    property  Options:TLMDShellPathDialogOptions read FOptions write SetOptions
     default [poSizeable, poShowDeleteInvalidButton, poPathMustExist];
    property  InstructionText:String read FInstructionText write SetInstructionText;
    property  PathKey:String read FPathKey write SetPathKey;
    property  PathKeyValue:String read FPathKeyValue write SetPathKeyValue;
    property  PathIdent:String read FPathIdent write SetPathIdent;
    property  RootPath:String read FRootPath write SetRootPath;
  end;

implementation

{$R *.dfm}

procedure TLMDShellCustomPathForm.FormShow(Sender: TObject);
begin
  LMDShellPathFrame1.UpdateOnShow;
end;

procedure TLMDShellCustomPathForm.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); 
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

{ TLMDShellPathDialog }
{---------------------------- Public ------------------------------------------}
constructor TLMDShellPathDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDelimeter := ';';
  FCaption := sPathCaption;
  FOptions := [poSizeable, poShowDeleteInvalidButton, poPathMustExist];
end;

function TLMDShellPathDialog.Execute(aHWND: HWND): Boolean;
var
  PF : TLMDShellCustomPathForm;
begin

  if (OwnerHandle=pwOwnerForm) and (Owner is TCustomForm) and not (csDesigning in ComponentState) then
    PF := TLMDShellCustomPathForm.Create(Owner)
  else
    PF := TLMDShellCustomPathForm.Create(nil);

  try
    PF.Caption := FCaption;
    PF.LMDShellPathFrame1.szDelimeter := FDelimeter;
    PF.LMDShellPathFrame1.szPathList  := FPath;
    if poInstructionField in FOptions then
      PF.InstructionLabel.Caption := FInstructionText
    else
      PF.Panel2.Visible := False;

    if poSizeable in FOptions then
      PF.BorderStyle := bsSizeable
    else
      PF.BorderStyle := bsDialog;

    if poHelpButton in FOptions then
      PF.BorderIcons := PF.BorderIcons + [biHelp];

    PF.LMDShellPathFrame1.DelInvalidPathsBtn.Visible := (poShowDeleteInvalidButton in FOptions);
    PF.LMDShellPathFrame1.UpBtn.Flat := (poSpeedFlat in FOptions);
    PF.LMDShellPathFrame1.DownBtn.Flat := (poSpeedFlat in FOptions);
    PF.LMDShellPathFrame1.FirstBtn.Flat := (poSpeedFlat in FOptions);
    PF.LMDShellPathFrame1.LastBtn.Flat := (poSpeedFlat in FOptions);
    PF.LMDShellPathFrame1.PathMustExist := (poPathMustExist in FOptions);

    PF.LMDShellPathFrame1.PathKey := FPathKey;
    PF.LMDShellPathFrame1.PathKeyValue := FPathKeyValue;
    PF.LMDShellPathFrame1.PathIdent := FPathIdent;
    PF.LMDShellPathFrame1.CustomRootPath := FRootPath;

    Result := (PF.ShowModal = mrOk);

    if  Result  then
      FPath := PF.LMDShellPathFrame1.szPathList;
  finally
    PF.Free;
  end;
end;

procedure TLMDShellPathDialog.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure TLMDShellPathDialog.SetDelimeter(const Value: String);
begin
  FDelimeter := Value;
end;

procedure TLMDShellPathDialog.SetInstructionText(const Value: String);
begin
  FInstructionText := Value;
end;

procedure TLMDShellPathDialog.SetOptions(const Value: TLMDShellPathDialogOptions);
begin
  FOptions := Value;
end;

procedure TLMDShellPathDialog.SetPath(const Value: String);
begin
  FPath := Value;
end;

procedure TLMDShellPathDialog.SetPathIdent(const Value: String);
begin
  FPathIdent := Value;
end;

procedure TLMDShellPathDialog.SetPathKey(const Value: String);
begin
  FPathKey := Value;
end;

procedure TLMDShellPathDialog.SetPathKeyValue(const Value: String);
begin
  FPathKeyValue := Value;
end;

procedure TLMDShellPathDialog.SetRootPath(const Value: String);
begin
  FRootPath := Value;
end;

end.
