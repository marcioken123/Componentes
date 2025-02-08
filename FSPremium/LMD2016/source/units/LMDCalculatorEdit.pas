unit LMDCalculatorEdit;
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

LMDCalculatorEdit unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDGraph,
  LMDCustomMaskEdit,
  LMDButtonBase;

type
  { ----------------------- TLMDCalculatorEdit --------------------------------- }
  TLMDCalculatorEdit = class(TLMDCustomMaskEdit)
  private
    FType : TLMDNumberType;
    FCBtn : TLMDUserButtonStyle;
    FOnDlgChange,
    FOnShow,
    FOnClose:TNotifyEvent;
    FCXP: Boolean;
    procedure SetType (aValue : TLMDNumberType);
    procedure ReadOldBtnStyle(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure SetMaskType;
    procedure DoOnBrowseClick (Sender : TObject);
    public
    constructor Create (aOwner : TComponent); override;
    procedure Loaded; override;
    property CalculatorBtnStyle: TLMDUserButtonStyle read FCBtn write FCBtn;
    property CtlXP; // compatibility
  published
    property About;
    property AutoSelect;
    property Bevel;
    property Caret;
    property CharCase;
    property CustomButtons;    
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property Decimals;
    property EditType : TLMDNumberType read FType write SetType default ntFloat;
    property CalcButtonStyle:TLMDUserButtonStyle read FCBtn write FCBtn default ubsExplorer;
    property CalcButtonCtlXP: Boolean read FCXP write FCXP default false;
    property Flat;
    property FocusOnMouseAbove;
    property Font;
    property Font3D;
    property HideSelection;
    property HighlightBack;
    property HighlightText;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property MaxLength;
    property OEMConvert;
    property ReadOnly;
    property Transparent;
    // 7.0
    property OnDlgChange:TNotifyEvent read FOnDlgChange write FOnDlgChange;
    property OnDlgClose:TNotifyEvent read FOnClose write FOnClose;
    property OnDlgShow:TNotifyEvent read FOnShow write FOnShow;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
  end;

  TLMDLabeledCalculatorEdit = class(TLMDCalculatorEdit)
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
  Forms, SysUtils,
  LMDBase, LMDCalculatorDlg;

{ ---------------------------------- private --------------------------------- }
procedure TLMDCalculatorEdit.SetType (aValue : TLMDNumberType);
begin
  if aValue <> FType then
    begin
      FType := aValue;
      SetMaskType;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorEdit.ReadOldBtnStyle(Reader: TReader);
begin
  LMDButtonReadExtStyle(Reader, FCBtn, FCXP);
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDCalculatorEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('CalculatorBtnStyle', ReadOldBtnStyle, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorEdit.SetMaskType;
begin
  case FType of
    ntInteger     : MaskType := meInteger;
    ntFloat       : MaskType := meFloat;
    ntFloatFixed  : MaskType := meFloatFixed;
    ntFloatNumber : MaskType := meFloatNumber;
    ntCurrency    : MaskType := meCurrency;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorEdit.DoOnBrowseClick (Sender : TObject);
var
  cd : TLMDCalculatorDlg;
begin
  if not Focused then SetFocus; //added May 02, JH
  cd := TLMDCalculatorDlg.Create (Application);
  try
    cd.CtlXP:=self.CtlXP;
    cd.CalcButtonCtlXP:=FCXP;
    cd.CalcEditType := FType;
    cd.CalcDecimals := Decimals;
    cd.CalcBtnStyle := FCBtn;
    case FType of
      ntCurrency : cd.Value := AsCurrency;
      ntInteger : cd.Value := AsInteger;
    else
      cd.Value := AsFloat;
    end;
   if Assigned(FOnShow) then FOnShow(cd);
    if cd.Execute then
      try
        Text := FloatToStr(cd.Value);
        if Assigned(FOnDlgChange) then FOnDlgChange(self);
      except
        on Exception do ;
      end;
    if Assigned(FOnClose) then FOnShow(cd);
  finally
    cd.Free;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDCalculatorEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  CustomButtons.Add;
  CustomButtonWidth := 18;
  LMDGetGlyphKind(CustomButtons.Items[0].Glyph, gkCalculator);
  CustomButtons.Items[0].Btn.OnClick := DoOnBrowseClick;
  CustomButtons.Items[0].CtlXP:=false;
  FCBtn := ubsExplorer;
  FType := ntFloat;
  FMaskType := meFloat;
  //FText := '0';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalculatorEdit.Loaded;
begin
  inherited Loaded;
  SetMaskType;
  CustomButtons.Items[0].Btn.OnClick := DoOnBrowseClick;  
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledCalculatorEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
