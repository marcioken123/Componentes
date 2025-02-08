unit LMDCalculatorDlg;
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

LMDCalculatorDlg unit (JH)
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Forms,
  LMDGraph,
  LMDEmbeddedObject,
  LMDCustomMaskEdit, //TLMDNumberType
  LMDCalculator,
  LMDButtonBase,
  LMDBaseDialog;

type
  TLMDCalculatorDlg = class (TLMDBaseDialog)
  private
    FReturnValue : Extended;
    FBtnStyle    : TLMDUserButtonStyle;
    FDispStyle   : TLMDEmbeddedObject;
    FEditType    : TLMDNumberType;
    FDecimals    : Integer;
    FCalc        : TObject;
    FCXP         : Boolean;

    procedure SetDisplayStyle (aValue : TLMDEmbeddedObject);
    procedure DoOnKeyPress (Sender : TObject; var Key : Char);
    procedure ReadStyle(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoCustomize(Sender:TObject);override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function Execute:Boolean;override;
    function ExecuteEnh(aForm:TForm):Boolean;
    property CalcBtnStyle : TLMDUserButtonStyle read FBtnStyle write FBtnStyle;
    property CtlXP;  // compatibility
  published
    property About;
    property CalcButtonStyle:TLMDUserButtonStyle read FBtnStyle write FBtnStyle default ubsExplorer;
    property CalcButtonCtlXP: Boolean read FCXP write FCXP default false;
    property CalcDecimals : Integer read FDecimals write FDecimals default 1;
    property CalcDisplayStyle : TLMDEmbeddedObject read FDispStyle write SetDisplayStyle;
    property CalcEditType : TLMDNumberType read FEditType write FEditType default ntFloat;
    property CaptionFill;
    property CaptionTitle;
    property Colors;
    property CustomButton;
    property Effect;
    property Hints;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property Position;
    property RelatePos;
    property ShowHints;
    property ThemeMode;
    property ThemeGlobalMode;
    property Value : Extended read FReturnValue write FReturnValue;

    property OnCustomClick;
    property OnCustomize;
  end;

implementation

uses
  Graphics, StdCtrls, Controls, TypInfo,
  LMDFormStyler, LMDBack, LMDButton, LMDConst;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorDlg.SetDisplayStyle (aValue : TLMDEmbeddedObject);
begin
  FDispStyle.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorDlg.DoOnKeyPress (Sender : TObject; var Key : Char);
begin
  if key <> #13 then
    TLMDCalculator(FCalc).DoKey (key);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorDlg.ReadStyle(Reader: TReader);
var
  tmp:Boolean;
begin
  tmp:=CtlXP;
  LMDButtonReadExtStyle(Reader, FBtnStyle, tmp);
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCalculatorDlg.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('CalcBtnStyle', ReadStyle, nil, false);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorDlg.DoCustomize(Sender: TObject);
var
  i:Integer;
begin
  with TForm(Sender) do
  for i:=0 to ComponentCount-1 do
    if Components[i] is TLMDCalculator then
      TLMDCalculator(Components[i]).CtlXP := FCXP;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCalculatorDlg.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FBtnStyle := ubsExplorer;
  FReturnValue := 0;
  FDispStyle := TLMDEmbeddedObject.Create;
  FEditType := ntFloat;
  FDecimals := 1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCalculatorDlg.Destroy;
begin
  FDispStyle.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalculatorDlg.Execute:Boolean;
begin
  result := ExecuteEnh (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalculatorDlg.ExecuteEnh(aForm:TForm):Boolean;
var
  cd     : TForm;
  calc   : TLMDCalculator;
  custom,
  ok,
  cancel : TLMDButton;
  fs     : TLMDFormStyler;
  b      : TLMDBack;
  calcW,
  calcH,
  bw,
  w,
  h,
  i      : Integer;

  function theGreater (i1, i2 : Integer) : Integer;
  begin
    result := i1;
    if i2 > i1 then
      result := i2;
  end;

begin
  result := false;
  cd := TForm.Create(nil);
  try
    with cd do
      begin
        calcW := 127;
        calcH := 217;
        w := calcW + 120;
        h := calcH + 20 + GetSystemMetrics (SM_CYCAPTION); //changed from +40 to +20 + GetSystemM, JH 28.11.01
        BorderStyle:=bsDialog;
        Font.Color:=clWindowText;
        Font.Name:='MS Sans Serif';
        Font.Height:=-11;
        Position:=poDefault;
        PixelsPerInch:=96;
        Height := h;
        OnKeyPress:=DoOnKeyPress;
        //get needed btn size
        bw := 80;

        bw := theGreater (bw, Canvas.TextWidth (IDS_CANCEL) + 6);
        bw := theGreater (bw, Canvas.TextWidth (CustomButton) + 6);

        i := calcW + bw + 20;

        if i > w then w := i + 10;

        //set form width
        Width := w;

        //i := h - 29 * 3;

        ok:=TLMDButton.Create(cd);
        with ok do
          begin
            Parent:=cd;
            Width:=bw;
            Height:=24;
            Left:=w - bw - 15;
            Top:=calcH + 35 -29*3;
            ModalResult:=1;
            Caption:='OK';
            Default:=True;
            Cancel:=True;
            TabOrder:=0;
            OnKeyPress:=DoOnKeyPress;
          end;

        //i := ok.Left + ok.Width;

        cancel:=TLMDButton.Create(cd);
        with cancel do
          begin
            Parent:=cd;
            Width:=bw;
            Height:=24;
            Left:=w - bw - 15;
            Top:=ok.Top + ok.Height + 5;
            ModalResult:=mrCancel;
            Caption:=IDS_CANCEL;
            Cancel:=True;
            TabOrder:=1;
            OnKeyPress:=DoOnKeyPress;
          end;

        //i := cancel.Left + cancel.Width;

        custom:=TLMDButton.Create(cd);
        with custom do
          begin
            Parent:=cd;
            Width:=bw;
            Height:=24;
            Left:=w - bw - 15;
            Top:=ok.Top -5 - Height;
            TabOrder:=2;
            OnKeyPress:=DoOnKeyPress;
          end;

        calc := TLMDCalculator.Create (cd);
        with calc do
          begin
            Parent := cd;
            Left := 10;
            Top := 10;
            Width := calcW;
            Height := calcH;
            TabOrder := 0;
            Transparent := true;
            Bevel.Mode := bmStandard;
            Bevel.StandardStyle := lsSingleRaised;
            BtnStyle := FBtnStyle;
            DisplaySettings.Assign (FDispStyle);
            EditType := ntFloat;
            Decimals := FDecimals;
            Value := FReturnValue;
            CtlXP := FCXP;
          end;
          FCalc := calc;
//        FCalc := Pointer(calc);

        if ShowHints and (Hints.Count>0) then
          begin
            ShowHint:=True;
            ok.Hint:=Hints[0];
            if Hints.Count>1 then cancel.Hint:=Hints[1];
            if Hints.Count>2 then calc.Hint:=Hints[2];
            if Hints.Count>3 then custom.Hint:=Hints[3];
          end;

        fs:=TLMDFormStyler.Create(cd);
        fs.Enabled:=False;

        b:=TLMDBack.Create(cd);
        b.Enabled:=False;
      end;

      if BaseExecute(cd, aForm, Custom,  fs, b, IDS_INPUTCAPTION)=mrOK then
        begin
          result := true;
          FReturnValue := calc.Value;
        end
      else
        FReturnValue := 0;
  finally
    //free all
    FCalc := nil;
    cd.Free;
  end;
end;

end.
