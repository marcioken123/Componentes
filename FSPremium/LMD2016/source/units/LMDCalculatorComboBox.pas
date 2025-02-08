unit LMDCalculatorComboBox;
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

LMDCalculatorComboBox unit ()
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  LMDGraph,
  LMDCalculator,
  LMDButtonBase,
  LMDCustomExtCombo;

type
  {********************* TLMDCalculatorComboBox *******************************}
  TLMDCalculatorComboBox = class (TLMDCustomExtCombo)
  private
    FOld : Extended;
    FCBtn : TLMDUserButtonStyle;
    FCXP: Boolean;
    function GetCalculator:TLMDCalculator;
    function GetValue: Double;
    procedure SetDValue(const Value: Double);
    procedure SetCBtn(const Value: TLMDUserButtonStyle);
    procedure SetCXP(const Value: Boolean);
    procedure ReadOldBtnStyle(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoCalc (Sender : TObject);
    procedure DoWork (Sender : TObject; s : String);
    procedure CreateControl; override;
    procedure ModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;
    procedure Loaded; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure Init; override;
    property Text stored false;
    property Calculator:TLMDCalculator read GetCalculator;
    property Value:Double read GetValue write SetDValue;
    property CalculatorBtnStyle: TLMDUserButtonStyle read FCBtn write SetCBtn;
  published
    property CalcButtonStyle: TLMDUserButtonStyle read FCBtn write SetCBtn default ubsExplorer;
    property CalcButtonCtlXP: Boolean read FCXP write SetCXP default false;
  end;

  {********************* TLMDLabeledCalculatorComboBox ************************}
  TLMDLabeledCalculatorComboBox = class(TLMDCalculatorComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Graphics,
  SysUtils,
  LMDCustomMaskEdit;

{********************** TLMDCalculatorComboBox ********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCalculatorComboBox.SetDValue(const Value: Double);
begin
  inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalculatorComboBox.GetValue: Double;
begin
  result:=AsFloat;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalculatorComboBox.GetCalculator:TLMDCalculator;
begin
  result:=TLMDCalculator(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.SetCBtn(const Value: TLMDUserButtonStyle);
begin
  if FCBtn<>Value then
    begin
      FCBtn := Value;
      if Assigned(FControl) then
        ModifyControl;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.SetCXP(const Value: Boolean);
begin
  if FCXP<>Value then
    begin
       FCXP := Value;
       if Assigned(FControl) then
         ModifyControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCalculatorComboBox.ReadOldBtnStyle(Reader: TReader);
var
  tmp:Boolean;
begin
  tmp:=CalcButtonCtlXP;
  LMDButtonReadExtStyle(Reader, FCBtn, tmp);
  if tmp<>CalcButtonCtlXP then CalcButtonCtlXP:=tmp;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCalculatorComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('CalculatorBtnStyle', ReadOldBtnStyle, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.DoCalc (Sender : TObject);
begin
  Close (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.DoWork (Sender : TObject; s : String);
begin
  Text := '0';
  SelectAll;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.CreateControl;
begin
  FControl := TLMDCalculator.Create (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.ModifyControl;
begin
  with (FControl as TLMDCalculator) do
    begin
      Bevel.Mode := bmStandard;
      Bevel.StandardStyle := lsSingle;
      BtnStyle := FCBtn;
      CtlXP := FCXP;
      OnCalc := DoCalc;
      OnWork := DoWork;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.DisplayControl;
begin
  SelectAll;
  with (FControl as TLMDCalculator) do Value:=self.Value;
  //FControl.SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.BeforeDropDown;
begin
  FOld := AsFloat;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.Cancel;
begin
  Text := FloatToStr(FOld);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.Accept;
begin
  Text := FloatToStr ((FControl as TLMDCalculator).Value);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.Loaded;
begin
  inherited Loaded;
  MaskType := meFloat;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCalculatorComboBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FCBtn := ubsExplorer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorComboBox.Init;
begin
  MaskType := meFloat;
end;

{********************* TLMDLabeledCalculatorComboBox **************************}
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledCalculatorComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
