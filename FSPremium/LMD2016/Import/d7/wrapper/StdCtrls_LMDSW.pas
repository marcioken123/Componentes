unit StdCtrls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'StdCtrls' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Messages, Windows, SysUtils, Classes, Controls, Forms,
  Menus, Graphics, StdCtrls, Messages_LMDSW, Windows_LMDSW, SysUtils_LMDSW,
  Classes_LMDSW, Controls_LMDSW, Forms_LMDSW, Menus_LMDSW, Graphics_LMDSW;


{ Type wrappers }

type
  TCustomGroupBox_sw = class;
  TGroupBox_sw = class;
  TCustomLabel_sw = class;
  TLabel_sw = class;
  TCustomEdit_sw = class;
  TEdit_sw = class;
  TCustomMemo_sw = class;
  TMemo_sw = class;
  TCustomComboBoxStrings_sw = class;
  TCustomComboBoxStringsClass_sw = class;
  TCustomCombo_sw = class;
  TCustomComboBox_sw = class;
  TComboBox_sw = class;
  TButtonActionLink_sw = class;
  TButtonActionLinkClass_sw = class;
  TButtonControl_sw = class;
  TButton_sw = class;
  TCustomCheckBox_sw = class;
  TCheckBox_sw = class;
  TRadioButton_sw = class;
  TCustomListBox_sw = class;
  TListBox_sw = class;
  TScrollBar_sw = class;
  TCustomStaticText_sw = class;
  TStaticText_sw = class;

  TCustomGroupBox_sc = class of TCustomGroupBox;
  TCustomGroupBox_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGroupBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGroupBox;
    class function ClassToVar(AClass: TCustomGroupBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGroupBox_sc;
  end;

  TGroupBox_sc = class of TGroupBox;
  TGroupBox_sw = class(TCustomGroupBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGroupBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TGroupBox;
    class function ClassToVar(AClass: TGroupBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGroupBox_sc;
  end;

  TTextLayout_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTextLayout): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextLayout;
  end;

  TCustomLabel_sc = class of TCustomLabel;
  TCustomLabel_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomLabel): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomLabel;
    class function ClassToVar(AClass: TCustomLabel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomLabel_sc;
  end;

  TLabel_sc = class of TLabel;
  TLabel_sw = class(TCustomLabel_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLabel): OleVariant;
    class function FromVar(const AValue: OleVariant): TLabel;
    class function ClassToVar(AClass: TLabel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLabel_sc;
  end;

  TEditCharCase_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEditCharCase): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditCharCase;
  end;

  TCustomEdit_sc = class of TCustomEdit;
  TCustomEdit_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomEdit;
    class function ClassToVar(AClass: TCustomEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomEdit_sc;
  end;

  TEdit_sc = class of TEdit;
  TEdit_sw = class(TCustomEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TEdit;
    class function ClassToVar(AClass: TEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEdit_sc;
  end;

  TScrollStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollStyle;
  end;

  TCustomMemo_sc = class of TCustomMemo;
  TCustomMemo_sw = class(TCustomEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMemo): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMemo;
    class function ClassToVar(AClass: TCustomMemo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMemo_sc;
  end;

  TMemo_sc = class of TMemo;
  TMemo_sw = class(TCustomMemo_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMemo): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemo;
    class function ClassToVar(AClass: TMemo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMemo_sc;
  end;

  TMeasureItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Control: TWinControl; Index: Integer;
      var Height: Integer);
  end;

  TMeasureItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMeasureItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMeasureItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMeasureItemEvent;
  end;

  TCustomComboBoxStrings_sc = class of TCustomComboBoxStrings;
  TCustomComboBoxStrings_sw = class(TStrings_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomComboBoxStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomComboBoxStrings;
    class function ClassToVar(AClass: TCustomComboBoxStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomComboBoxStrings_sc;
  end;

  TCustomComboBoxStringsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomComboBoxStringsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomComboBoxStringsClass;
  end;

  TCustomCombo_sc = class of TCustomCombo;
  TCustomCombo_sw = class(TCustomListControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomCombo): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomCombo;
    class function ClassToVar(AClass: TCustomCombo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomCombo_sc;
  end;

  TComboBoxStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TComboBoxStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxStyle;
  end;

  TCustomComboBox_sc = class of TCustomComboBox;
  TCustomComboBox_sw = class(TCustomCombo_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomComboBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomComboBox;
    class function ClassToVar(AClass: TCustomComboBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomComboBox_sc;
  end;

  TComboBox_sc = class of TComboBox;
  TComboBox_sw = class(TCustomComboBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBox;
    class function ClassToVar(AClass: TComboBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboBox_sc;
  end;

  TButtonActionLink_sc = class of TButtonActionLink;
  TButtonActionLink_sw = class(TWinControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TButtonActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonActionLink;
    class function ClassToVar(AClass: TButtonActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TButtonActionLink_sc;
  end;

  TButtonActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TButtonActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonActionLinkClass;
  end;

  TButtonControl_sc = class of TButtonControl;
  TButtonControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TButtonControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonControl;
    class function ClassToVar(AClass: TButtonControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TButtonControl_sc;
  end;

  TButton_sc = class of TButton;
  TButton_sw = class(TButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TButton;
    class function ClassToVar(AClass: TButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TButton_sc;
  end;

  TCheckBoxState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCheckBoxState): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckBoxState;
  end;

  TCustomCheckBox_sc = class of TCustomCheckBox;
  TCustomCheckBox_sw = class(TButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomCheckBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomCheckBox;
    class function ClassToVar(AClass: TCustomCheckBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomCheckBox_sc;
  end;

  TCheckBox_sc = class of TCheckBox;
  TCheckBox_sw = class(TCustomCheckBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCheckBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckBox;
    class function ClassToVar(AClass: TCheckBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCheckBox_sc;
  end;

  TRadioButton_sc = class of TRadioButton;
  TRadioButton_sw = class(TButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TRadioButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TRadioButton;
    class function ClassToVar(AClass: TRadioButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TRadioButton_sc;
  end;

  TListBoxStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListBoxStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TListBoxStyle;
  end;

  TLBGetDataEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Control: TWinControl; Index: Integer; var Data: string);
  end;

  TLBGetDataEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLBGetDataEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLBGetDataEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLBGetDataEvent;
  end;

  TLBGetDataObjectEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Control: TWinControl; Index: Integer;
      var DataObject: TObject);
  end;

  TLBGetDataObjectEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLBGetDataObjectEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLBGetDataObjectEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLBGetDataObjectEvent;
  end;

  TLBFindDataEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(Control: TWinControl; FindString: string): Integer;
  end;

  TLBFindDataEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLBFindDataEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLBFindDataEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLBFindDataEvent;
  end;

  TCustomListBox_sc = class of TCustomListBox;
  TCustomListBox_sw = class(TCustomMultiSelectListControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomListBox;
    class function ClassToVar(AClass: TCustomListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomListBox_sc;
  end;

  TListBox_sc = class of TListBox;
  TListBox_sw = class(TCustomListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TListBox;
    class function ClassToVar(AClass: TListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListBox_sc;
  end;

  TScrollCode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollCode): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollCode;
  end;

  TScrollEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
  end;

  TScrollEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TScrollEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TScrollEvent;
  end;

  TScrollBar_sc = class of TScrollBar;
  TScrollBar_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TScrollBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollBar;
    class function ClassToVar(AClass: TScrollBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TScrollBar_sc;
  end;

  TStaticBorderStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStaticBorderStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TStaticBorderStyle;
  end;

  TCustomStaticText_sc = class of TCustomStaticText;
  TCustomStaticText_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomStaticText): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomStaticText;
    class function ClassToVar(AClass: TCustomStaticText_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomStaticText_sc;
  end;

  TStaticText_sc = class of TStaticText;
  TStaticText_sw = class(TCustomStaticText_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStaticText): OleVariant;
    class function FromVar(const AValue: OleVariant): TStaticText;
    class function ClassToVar(AClass: TStaticText_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStaticText_sc;
  end;


{ Unit wrapper }

type
  StdCtrls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomLabel_sacc = class(TCustomLabel);
  TCustomEdit_sacc = class(TCustomEdit);
  TCustomMemo_sacc = class(TCustomMemo);
  TCustomComboBoxStrings_sacc = class(TCustomComboBoxStrings);
  TCustomCombo_sacc = class(TCustomCombo);
  TCustomComboBox_sacc = class(TCustomComboBox);
  TButtonControl_sacc = class(TButtonControl);
  TCustomCheckBox_sacc = class(TCustomCheckBox);
  TCustomListBox_sacc = class(TCustomListBox);
  TCustomStaticText_sacc = class(TCustomStaticText);

{ TCustomGroupBox_sw }

class function TCustomGroupBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGroupBox';
end;

class function TCustomGroupBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGroupBox;
end;

class procedure TCustomGroupBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomGroupBox_sw.ToVar(
  const AValue: TCustomGroupBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGroupBox_sw.FromVar(
  const AValue: OleVariant): TCustomGroupBox;
begin
  Result := TCustomGroupBox(ConvFromVar(AValue, TCustomGroupBox));
end;

class function TCustomGroupBox_sw.ClassToVar(
  AClass: TCustomGroupBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGroupBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGroupBox_sc;
begin
  Result := TCustomGroupBox_sc(ConvClsFromVar(AClass, TCustomGroupBox));
end;

{ TGroupBox_sw }

class function TGroupBox_sw.GetTypeName: WideString;
begin
  Result := 'TGroupBox';
end;

class function TGroupBox_sw.GetWrappedClass: TClass;
begin
  Result := TGroupBox;
end;

class procedure TGroupBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TGroupBox_sw.ToVar(const AValue: TGroupBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGroupBox_sw.FromVar(const AValue: OleVariant): TGroupBox;
begin
  Result := TGroupBox(ConvFromVar(AValue, TGroupBox));
end;

class function TGroupBox_sw.ClassToVar(AClass: TGroupBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGroupBox_sw.ClassFromVar(
  const AClass: OleVariant): TGroupBox_sc;
begin
  Result := TGroupBox_sc(ConvClsFromVar(AClass, TGroupBox));
end;

{ TTextLayout_sw }

class function TTextLayout_sw.GetTypeName: WideString;
begin
  Result := 'TTextLayout';
end;

class procedure TTextLayout_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'tlTop'; Value: Integer({$IFDEF LMDSCT_12}TTextLayout.{$ENDIF}tlTop)),
    (Name: 'tlCenter'; Value: Integer({$IFDEF LMDSCT_12}TTextLayout.{$ENDIF}tlCenter)),
    (Name: 'tlBottom'; Value: Integer({$IFDEF LMDSCT_12}TTextLayout.{$ENDIF}tlBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TTextLayout_sw.ToVar(const AValue: TTextLayout): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTextLayout_sw.FromVar(const AValue: OleVariant): TTextLayout;
begin
  Result := TTextLayout(Integer(AValue));
end;

{ TCustomLabel_sw }

function TCustomLabel_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Alignment: TAlignment read <getter> wr...

  if IsGet then
    Result := TAlignment_sw.ToVar(TCustomLabel_sacc(TCustomLabel(AObj)).
      Alignment)
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).Alignment := TAlignment_sw.FromVar(
      AArgs[0]);
end;

function TCustomLabel_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSize: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomLabel_sacc(TCustomLabel(AObj)).AutoSize
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).AutoSize := Boolean(AArgs[0]);
end;

function TCustomLabel_FocusControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FocusControl: TWinControl read <getter...

  if IsGet then
    Result := TWinControl_sw.ToVar(TCustomLabel_sacc(TCustomLabel(AObj)).
      FocusControl)
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).FocusControl := TWinControl_sw.
      FromVar(AArgs[0]);
end;

function TCustomLabel_ShowAccelChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowAccelChar: Boolean read <getter> w...

  if IsGet then
    Result := TCustomLabel_sacc(TCustomLabel(AObj)).ShowAccelChar
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).ShowAccelChar := Boolean(AArgs[0]);
end;

function TCustomLabel_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Transparent: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomLabel_sacc(TCustomLabel(AObj)).Transparent
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).Transparent := Boolean(AArgs[0]);
end;

function TCustomLabel_Layout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Layout: TTextLayout read <getter> writ...

  if IsGet then
    Result := TTextLayout_sw.ToVar(TCustomLabel_sacc(TCustomLabel(AObj)).Layout)
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).Layout := TTextLayout_sw.FromVar(
      AArgs[0]);
end;

function TCustomLabel_WordWrap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WordWrap: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomLabel_sacc(TCustomLabel(AObj)).WordWrap
  else
    TCustomLabel_sacc(TCustomLabel(AObj)).WordWrap := Boolean(AArgs[0]);
end;

function TCustomLabel_OnMouseEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMouseEnter: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomLabel(AObj).OnMouseEnter)
  else
    TCustomLabel(AObj).OnMouseEnter := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomLabel_OnMouseLeave_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMouseLeave: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomLabel(AObj).OnMouseLeave)
  else
    TCustomLabel(AObj).OnMouseLeave := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomLabel_sw.GetTypeName: WideString;
begin
  Result := 'TCustomLabel';
end;

class function TCustomLabel_sw.GetWrappedClass: TClass;
begin
  Result := TCustomLabel;
end;

class procedure TCustomLabel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TCustomLabel_Alignment_si, TAlignment_sw, True, True, 0, True, False);
  AData.AddProperty('AutoSize', TCustomLabel_AutoSize_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('FocusControl', TCustomLabel_FocusControl_si, TWinControl_sw, True, True, 0, True, False);
  AData.AddProperty('ShowAccelChar', TCustomLabel_ShowAccelChar_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Transparent', TCustomLabel_Transparent_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Layout', TCustomLabel_Layout_si, TTextLayout_sw, True, True, 0, True, False);
  AData.AddProperty('WordWrap', TCustomLabel_WordWrap_si, Boolean_sw, True, True, 0, True, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Canvas', False);
  AData.AddProperty('OnMouseEnter', TCustomLabel_OnMouseEnter_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMouseLeave', TCustomLabel_OnMouseLeave_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomLabel_sw.ToVar(const AValue: TCustomLabel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomLabel_sw.FromVar(const AValue: OleVariant): TCustomLabel;
begin
  Result := TCustomLabel(ConvFromVar(AValue, TCustomLabel));
end;

class function TCustomLabel_sw.ClassToVar(AClass: TCustomLabel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomLabel_sw.ClassFromVar(
  const AClass: OleVariant): TCustomLabel_sc;
begin
  Result := TCustomLabel_sc(ConvClsFromVar(AClass, TCustomLabel));
end;

{ TLabel_sw }

class function TLabel_sw.GetTypeName: WideString;
begin
  Result := 'TLabel';
end;

class function TLabel_sw.GetWrappedClass: TClass;
begin
  Result := TLabel;
end;

class procedure TLabel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('FocusControl', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowAccelChar', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Transparent', False);
  AData.AddPropertyRedecl('Layout', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TLabel_sw.ToVar(const AValue: TLabel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLabel_sw.FromVar(const AValue: OleVariant): TLabel;
begin
  Result := TLabel(ConvFromVar(AValue, TLabel));
end;

class function TLabel_sw.ClassToVar(AClass: TLabel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLabel_sw.ClassFromVar(const AClass: OleVariant): TLabel_sc;
begin
  Result := TLabel_sc(ConvClsFromVar(AClass, TLabel));
end;

{ TEditCharCase_sw }

class function TEditCharCase_sw.GetTypeName: WideString;
begin
  Result := 'TEditCharCase';
end;

class procedure TEditCharCase_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ecNormal'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecNormal)),
    (Name: 'ecUpperCase'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecUpperCase)),
    (Name: 'ecLowerCase'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecLowerCase))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TEditCharCase_sw.ToVar(const AValue: TEditCharCase): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEditCharCase_sw.FromVar(
  const AValue: OleVariant): TEditCharCase;
begin
  Result := TEditCharCase(Integer(AValue));
end;

{ TCustomEdit_sw }

function TCustomEdit_AutoSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSelect: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).AutoSelect
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).AutoSelect := Boolean(AArgs[0]);
end;

function TCustomEdit_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSize: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).AutoSize
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).AutoSize := Boolean(AArgs[0]);
end;

function TCustomEdit_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomEdit_sacc(TCustomEdit(AObj)).
      BorderStyle)
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).BorderStyle := TBorderStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomEdit_CharCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CharCase: TEditCharCase read <getter> ...

  if IsGet then
    Result := TEditCharCase_sw.ToVar(TCustomEdit_sacc(TCustomEdit(AObj)).
      CharCase)
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).CharCase := TEditCharCase_sw.FromVar(
      AArgs[0]);
end;

function TCustomEdit_HideSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HideSelection: Boolean read <getter> w...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).HideSelection
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).HideSelection := Boolean(AArgs[0]);
end;

function TCustomEdit_MaxLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MaxLength: Integer read <getter> write...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).MaxLength
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).MaxLength := Integer(AArgs[0]);
end;

function TCustomEdit_OEMConvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OEMConvert: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).OEMConvert
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).OEMConvert := Boolean(AArgs[0]);
end;

function TCustomEdit_PasswordChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PasswordChar: Char read <getter> write...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).PasswordChar
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).PasswordChar := Char(Integer(AArgs[0]));
end;

function TCustomEdit_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomEdit_sacc(TCustomEdit(AObj)).ReadOnly
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).ReadOnly := Boolean(AArgs[0]);
end;

function TCustomEdit_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomEdit_sacc(TCustomEdit(AObj)).
      OnChange)
  else
    TCustomEdit_sacc(TCustomEdit(AObj)).OnChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomEdit_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TCustomEdit(AObj).Clear();
end;

function TCustomEdit_ClearSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearSelection;

  TCustomEdit(AObj).ClearSelection();
end;

function TCustomEdit_CopyToClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyToClipboard;

  TCustomEdit(AObj).CopyToClipboard();
end;

function TCustomEdit_CutToClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CutToClipboard;

  TCustomEdit(AObj).CutToClipboard();
end;

function TCustomEdit_PasteFromClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PasteFromClipboard;

  TCustomEdit(AObj).PasteFromClipboard();
end;

function TCustomEdit_Undo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Undo;

  TCustomEdit(AObj).Undo();
end;

function TCustomEdit_ClearUndo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearUndo;

  TCustomEdit(AObj).ClearUndo();
end;

function TCustomEdit_SelectAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SelectAll;

  TCustomEdit(AObj).SelectAll();
end;

function TCustomEdit_CanUndo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanUndo: Boolean read <getter>;

  Result := TCustomEdit(AObj).CanUndo;
end;

function TCustomEdit_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Modified: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomEdit(AObj).Modified
  else
    TCustomEdit(AObj).Modified := Boolean(AArgs[0]);
end;

function TCustomEdit_SelLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelLength: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomEdit(AObj).SelLength
  else
    TCustomEdit(AObj).SelLength := Integer(AArgs[0]);
end;

function TCustomEdit_SelStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelStart: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomEdit(AObj).SelStart
  else
    TCustomEdit(AObj).SelStart := Integer(AArgs[0]);
end;

function TCustomEdit_SelText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomEdit(AObj).SelText
  else
    TCustomEdit(AObj).SelText := string(AArgs[0]);
end;

class function TCustomEdit_sw.GetTypeName: WideString;
begin
  Result := 'TCustomEdit';
end;

class function TCustomEdit_sw.GetWrappedClass: TClass;
begin
  Result := TCustomEdit;
end;

class procedure TCustomEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoSelect', TCustomEdit_AutoSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('AutoSize', TCustomEdit_AutoSize_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('BorderStyle', TCustomEdit_BorderStyle_si, TBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('CharCase', TCustomEdit_CharCase_si, TEditCharCase_sw, True, True, 0, True, False);
  AData.AddProperty('HideSelection', TCustomEdit_HideSelection_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MaxLength', TCustomEdit_MaxLength_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('OEMConvert', TCustomEdit_OEMConvert_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('PasswordChar', TCustomEdit_PasswordChar_si, Char_sw, True, True, 0, True, False);
  AData.AddProperty('ReadOnly', TCustomEdit_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomEdit_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProcedure('Clear', TCustomEdit_Clear_si, 0, False);
  AData.AddProcedure('ClearSelection', TCustomEdit_ClearSelection_si, 0, False);
  AData.AddProcedure('CopyToClipboard', TCustomEdit_CopyToClipboard_si, 0, False);
  AData.AddProcedure('CutToClipboard', TCustomEdit_CutToClipboard_si, 0, False);
  AData.AddProcedure('PasteFromClipboard', TCustomEdit_PasteFromClipboard_si, 0, False);
  AData.AddProcedure('Undo', TCustomEdit_Undo_si, 0, False);
  AData.AddProcedure('ClearUndo', TCustomEdit_ClearUndo_si, 0, False);
  AData.AddProcedure('SelectAll', TCustomEdit_SelectAll_si, 0, False);
  AData.AddProperty('CanUndo', TCustomEdit_CanUndo_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Modified', TCustomEdit_Modified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SelLength', TCustomEdit_SelLength_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SelStart', TCustomEdit_SelStart_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SelText', TCustomEdit_SelText_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('TabStop', False);
end;

class function TCustomEdit_sw.ToVar(const AValue: TCustomEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomEdit_sw.FromVar(const AValue: OleVariant): TCustomEdit;
begin
  Result := TCustomEdit(ConvFromVar(AValue, TCustomEdit));
end;

class function TCustomEdit_sw.ClassToVar(AClass: TCustomEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomEdit_sw.ClassFromVar(
  const AClass: OleVariant): TCustomEdit_sc;
begin
  Result := TCustomEdit_sc(ConvClsFromVar(AClass, TCustomEdit));
end;

{ TEdit_sw }

class function TEdit_sw.GetTypeName: WideString;
begin
  Result := 'TEdit';
end;

class function TEdit_sw.GetWrappedClass: TClass;
begin
  Result := TEdit;
end;

class procedure TEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSelect', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('CharCase', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('OEMConvert', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PasswordChar', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TEdit_sw.ToVar(const AValue: TEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEdit_sw.FromVar(const AValue: OleVariant): TEdit;
begin
  Result := TEdit(ConvFromVar(AValue, TEdit));
end;

class function TEdit_sw.ClassToVar(AClass: TEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEdit_sw.ClassFromVar(const AClass: OleVariant): TEdit_sc;
begin
  Result := TEdit_sc(ConvClsFromVar(AClass, TEdit));
end;

{ TScrollStyle_sw }

class function TScrollStyle_sw.GetTypeName: WideString;
begin
  Result := 'TScrollStyle';
end;

class procedure TScrollStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'ssNone'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssNone)),
    (Name: 'ssHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssHorizontal)),
    (Name: 'ssVertical'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssVertical)),
    (Name: 'ssBoth'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TScrollStyle_sw.ToVar(const AValue: TScrollStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollStyle_sw.FromVar(const AValue: OleVariant): TScrollStyle;
begin
  Result := TScrollStyle(Integer(AValue));
end;

{ TCustomMemo_sw }

function TCustomMemo_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Alignment: TAlignment read <getter> wr...

  if IsGet then
    Result := TAlignment_sw.ToVar(TCustomMemo_sacc(TCustomMemo(AObj)).Alignment)
  else
    TCustomMemo_sacc(TCustomMemo(AObj)).Alignment := TAlignment_sw.FromVar(
      AArgs[0]);
end;

function TCustomMemo_ScrollBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ScrollBars: TScrollStyle read <getter>...

  if IsGet then
    Result := TScrollStyle_sw.ToVar(TCustomMemo_sacc(TCustomMemo(AObj)).
      ScrollBars)
  else
    TCustomMemo_sacc(TCustomMemo(AObj)).ScrollBars := TScrollStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomMemo_WantReturns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WantReturns: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomMemo_sacc(TCustomMemo(AObj)).WantReturns
  else
    TCustomMemo_sacc(TCustomMemo(AObj)).WantReturns := Boolean(AArgs[0]);
end;

function TCustomMemo_WantTabs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WantTabs: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomMemo_sacc(TCustomMemo(AObj)).WantTabs
  else
    TCustomMemo_sacc(TCustomMemo(AObj)).WantTabs := Boolean(AArgs[0]);
end;

function TCustomMemo_WordWrap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WordWrap: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomMemo_sacc(TCustomMemo(AObj)).WordWrap
  else
    TCustomMemo_sacc(TCustomMemo(AObj)).WordWrap := Boolean(AArgs[0]);
end;

function TCustomMemo_CaretPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaretPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TCustomMemo(AObj).CaretPos)
  else
    TCustomMemo(AObj).CaretPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TCustomMemo_Lines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Lines: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomMemo(AObj).Lines)
  else
    TCustomMemo(AObj).Lines := TStrings_sw.FromVar(AArgs[0]);
end;

class function TCustomMemo_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMemo';
end;

class function TCustomMemo_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMemo;
end;

class procedure TCustomMemo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TCustomMemo_Alignment_si, TAlignment_sw, True, True, 0, True, False);
  AData.AddProperty('ScrollBars', TCustomMemo_ScrollBars_si, TScrollStyle_sw, True, True, 0, True, False);
  AData.AddProperty('WantReturns', TCustomMemo_WantReturns_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('WantTabs', TCustomMemo_WantTabs_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('WordWrap', TCustomMemo_WordWrap_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('CaretPos', TCustomMemo_CaretPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Lines', TCustomMemo_Lines_si, TStrings_sw, True, True, 0, False, False);
end;

class function TCustomMemo_sw.ToVar(const AValue: TCustomMemo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMemo_sw.FromVar(const AValue: OleVariant): TCustomMemo;
begin
  Result := TCustomMemo(ConvFromVar(AValue, TCustomMemo));
end;

class function TCustomMemo_sw.ClassToVar(AClass: TCustomMemo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMemo_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMemo_sc;
begin
  Result := TCustomMemo_sc(ConvClsFromVar(AClass, TCustomMemo));
end;

{ TMemo_sw }

class function TMemo_sw.GetTypeName: WideString;
begin
  Result := 'TMemo';
end;

class function TMemo_sw.GetWrappedClass: TClass;
begin
  Result := TMemo;
end;

class procedure TMemo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('Lines', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('OEMConvert', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('ScrollBars', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WantReturns', False);
  AData.AddPropertyRedecl('WantTabs', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TMemo_sw.ToVar(const AValue: TMemo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMemo_sw.FromVar(const AValue: OleVariant): TMemo;
begin
  Result := TMemo(ConvFromVar(AValue, TMemo));
end;

class function TMemo_sw.ClassToVar(AClass: TMemo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMemo_sw.ClassFromVar(const AClass: OleVariant): TMemo_sc;
begin
  Result := TMemo_sc(ConvClsFromVar(AClass, TMemo));
end;

{ TMeasureItemEvent_sh }

function TMeasureItemEvent_sh.GetHandler: TMethod;
var
  hdr: TMeasureItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMeasureItemEvent_sh.Handler(Control: TWinControl; Index: Integer;
  var Height: Integer);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Control: TWinControl; Index: Integer; var Heig...

  v_1 := Height;
  args[0] := TWinControl_sw.ToVar(Control);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Height := Integer(v_1);
end;

{ TMeasureItemEvent_sw }

class function TMeasureItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMeasureItemEvent';
end;

class function TMeasureItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMeasureItemEvent_sh;
end;

class function TMeasureItemEvent_sw.ToVar(
  const AValue: TMeasureItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMeasureItemEvent_sw.FromVar(
  const AValue: OleVariant): TMeasureItemEvent;
begin
  Result := TMeasureItemEvent(ConvFromVar(AValue));
end;

class function TMeasureItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TMeasureItemEvent;
var
  hdlr: TMeasureItemEvent_sh;
begin
  hdlr   := TMeasureItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMeasureItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomComboBoxStrings_sw }

function TCustomComboBoxStrings_ComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ComboBox: TCustomCombo read <getter> w...

  if IsGet then
    Result := TCustomCombo_sw.ToVar(TCustomComboBoxStrings_sacc(
      TCustomComboBoxStrings(AObj)).ComboBox)
  else
    TCustomComboBoxStrings_sacc(TCustomComboBoxStrings(AObj)).ComboBox := 
      TCustomCombo_sw.FromVar(AArgs[0]);
end;

class function TCustomComboBoxStrings_sw.GetTypeName: WideString;
begin
  Result := 'TCustomComboBoxStrings';
end;

class function TCustomComboBoxStrings_sw.GetWrappedClass: TClass;
begin
  Result := TCustomComboBoxStrings;
end;

class procedure TCustomComboBoxStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ComboBox', TCustomComboBoxStrings_ComboBox_si, TCustomCombo_sw, True, True, 0, True, False);
end;

class function TCustomComboBoxStrings_sw.ToVar(
  const AValue: TCustomComboBoxStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomComboBoxStrings_sw.FromVar(
  const AValue: OleVariant): TCustomComboBoxStrings;
begin
  Result := TCustomComboBoxStrings(ConvFromVar(AValue, TCustomComboBoxStrings));
end;

class function TCustomComboBoxStrings_sw.ClassToVar(
  AClass: TCustomComboBoxStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomComboBoxStrings_sw.ClassFromVar(
  const AClass: OleVariant): TCustomComboBoxStrings_sc;
begin
  Result := TCustomComboBoxStrings_sc(ConvClsFromVar(AClass, 
    TCustomComboBoxStrings));
end;

{ TCustomComboBoxStringsClass_sw }

class function TCustomComboBoxStringsClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomComboBoxStringsClass';
end;

class function TCustomComboBoxStringsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomComboBoxStrings;
end;

class function TCustomComboBoxStringsClass_sw.ToVar(
  const AValue: TCustomComboBoxStringsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomComboBoxStringsClass_sw.FromVar(
  const AValue: OleVariant): TCustomComboBoxStringsClass;
begin
  Result := TCustomComboBoxStringsClass(ConvFromVar(AValue, 
    TCustomComboBoxStrings));
end;

{ TCustomCombo_sw }

function TCustomCombo_DropDownCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DropDownCount: Integer read <getter> w...

  if IsGet then
    Result := TCustomCombo_sacc(TCustomCombo(AObj)).DropDownCount
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).DropDownCount := Integer(AArgs[0]);
end;

function TCustomCombo_EditHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property EditHandle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).EditHandle);
end;

function TCustomCombo_ItemCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ItemCount: Integer read <getter>;

  Result := TCustomCombo_sacc(TCustomCombo(AObj)).ItemCount;
end;

function TCustomCombo_ItemHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ItemHeight: Integer read <getter> writ...

  if IsGet then
    Result := TCustomCombo_sacc(TCustomCombo(AObj)).ItemHeight
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).ItemHeight := Integer(AArgs[0]);
end;

function TCustomCombo_ListHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListHandle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).ListHandle);
end;

function TCustomCombo_MaxLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MaxLength: Integer read <getter> write...

  if IsGet then
    Result := TCustomCombo_sacc(TCustomCombo(AObj)).MaxLength
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).MaxLength := Integer(AArgs[0]);
end;

function TCustomCombo_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).
      OnChange)
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).OnChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomCombo_OnDropDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDropDown: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).
      OnDropDown)
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).OnDropDown := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomCombo_OnSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSelect: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).
      OnSelect)
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).OnSelect := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomCombo_OnCloseUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCloseUp: TNotifyEvent read <getter> ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCombo_sacc(TCustomCombo(AObj)).
      OnCloseUp)
  else
    TCustomCombo_sacc(TCustomCombo(AObj)).OnCloseUp := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomCombo_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomCombo(AObj).Canvas);
end;

function TCustomCombo_DroppedDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DroppedDown: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomCombo(AObj).DroppedDown
  else
    TCustomCombo(AObj).DroppedDown := Boolean(AArgs[0]);
end;

function TCustomCombo_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomCombo(AObj).Items)
  else
    TCustomCombo(AObj).Items := TStrings_sw.FromVar(AArgs[0]);
end;

function TCustomCombo_SelLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelLength: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomCombo(AObj).SelLength
  else
    TCustomCombo(AObj).SelLength := Integer(AArgs[0]);
end;

function TCustomCombo_SelStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelStart: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomCombo(AObj).SelStart
  else
    TCustomCombo(AObj).SelStart := Integer(AArgs[0]);
end;

class function TCustomCombo_sw.GetTypeName: WideString;
begin
  Result := 'TCustomCombo';
end;

class function TCustomCombo_sw.GetWrappedClass: TClass;
begin
  Result := TCustomCombo;
end;

class procedure TCustomCombo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DropDownCount', TCustomCombo_DropDownCount_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('EditHandle', TCustomCombo_EditHandle_si, HWnd_sw, True, False, 0, True, False);
  AData.AddProperty('ItemCount', TCustomCombo_ItemCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('ItemHeight', TCustomCombo_ItemHeight_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('ListHandle', TCustomCombo_ListHandle_si, HWnd_sw, True, False, 0, True, False);
  AData.AddProperty('MaxLength', TCustomCombo_MaxLength_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomCombo_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDropDown', TCustomCombo_OnDropDown_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnSelect', TCustomCombo_OnSelect_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCloseUp', TCustomCombo_OnCloseUp_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('Canvas', TCustomCombo_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('DroppedDown', TCustomCombo_DroppedDown_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TCustomCombo_Items_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('SelLength', TCustomCombo_SelLength_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SelStart', TCustomCombo_SelStart_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabStop', False);
end;

class function TCustomCombo_sw.ToVar(const AValue: TCustomCombo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomCombo_sw.FromVar(const AValue: OleVariant): TCustomCombo;
begin
  Result := TCustomCombo(ConvFromVar(AValue, TCustomCombo));
end;

class function TCustomCombo_sw.ClassToVar(AClass: TCustomCombo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomCombo_sw.ClassFromVar(
  const AClass: OleVariant): TCustomCombo_sc;
begin
  Result := TCustomCombo_sc(ConvClsFromVar(AClass, TCustomCombo));
end;

{ TComboBoxStyle_sw }

class function TComboBoxStyle_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxStyle';
end;

class procedure TComboBoxStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'csDropDown'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxStyle.{$ENDIF}csDropDown)),
    (Name: 'csSimple'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxStyle.{$ENDIF}csSimple)),
    (Name: 'csDropDownList'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxStyle.{$ENDIF}csDropDownList)),
    (Name: 'csOwnerDrawFixed'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxStyle.{$ENDIF}csOwnerDrawFixed)),
    (Name: 'csOwnerDrawVariable'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxStyle.{$ENDIF}csOwnerDrawVariable))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TComboBoxStyle_sw.ToVar(
  const AValue: TComboBoxStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TComboBoxStyle_sw.FromVar(
  const AValue: OleVariant): TComboBoxStyle;
begin
  Result := TComboBoxStyle(Integer(AValue));
end;

{ TCustomComboBox_sw }

function TCustomComboBox_Sorted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Sorted: Boolean read <getter> write <s...

  if IsGet then
    Result := TCustomComboBox_sacc(TCustomComboBox(AObj)).Sorted
  else
    TCustomComboBox_sacc(TCustomComboBox(AObj)).Sorted := Boolean(AArgs[0]);
end;

function TCustomComboBox_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Style: TComboBoxStyle read <getter> wr...

  if IsGet then
    Result := TComboBoxStyle_sw.ToVar(TCustomComboBox_sacc(TCustomComboBox(
      AObj)).Style)
  else
    TCustomComboBox_sacc(TCustomComboBox(AObj)).Style := TComboBoxStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomComboBox_OnMeasureItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMeasureItem: TMeasureItemEvent read ...

  if IsGet then
    Result := TMeasureItemEvent_sw.ToVar(TCustomComboBox_sacc(TCustomComboBox(
      AObj)).OnMeasureItem)
  else
    TCustomComboBox_sacc(TCustomComboBox(AObj)).OnMeasureItem := 
      TMeasureItemEvent_sw.FromVar(AArgs[0]);
end;

function TCustomComboBox_AutoComplete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoComplete: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomComboBox(AObj).AutoComplete
  else
    TCustomComboBox(AObj).AutoComplete := Boolean(AArgs[0]);
end;

function TCustomComboBox_AutoCloseUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCloseUp: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomComboBox(AObj).AutoCloseUp
  else
    TCustomComboBox(AObj).AutoCloseUp := Boolean(AArgs[0]);
end;

function TCustomComboBox_AutoDropDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoDropDown: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomComboBox(AObj).AutoDropDown
  else
    TCustomComboBox(AObj).AutoDropDown := Boolean(AArgs[0]);
end;

function TCustomComboBox_CharCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CharCase: TEditCharCase read <getter> write <set...

  if IsGet then
    Result := TEditCharCase_sw.ToVar(TCustomComboBox(AObj).CharCase)
  else
    TCustomComboBox(AObj).CharCase := TEditCharCase_sw.FromVar(AArgs[0]);
end;

function TCustomComboBox_SelText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomComboBox(AObj).SelText
  else
    TCustomComboBox(AObj).SelText := string(AArgs[0]);
end;

class function TCustomComboBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomComboBox';
end;

class function TCustomComboBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomComboBox;
end;

class procedure TCustomComboBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Sorted', TCustomComboBox_Sorted_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Style', TCustomComboBox_Style_si, TComboBoxStyle_sw, True, True, 0, True, False);
  AData.AddProperty('OnMeasureItem', TCustomComboBox_OnMeasureItem_si, TMeasureItemEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AutoComplete', TCustomComboBox_AutoComplete_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoCloseUp', TCustomComboBox_AutoCloseUp_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoDropDown', TCustomComboBox_AutoDropDown_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CharCase', TCustomComboBox_CharCase_si, TEditCharCase_sw, True, True, 0, False, False);
  AData.AddProperty('SelText', TCustomComboBox_SelText_si, string_sw, True, True, 0, False, False);
end;

class function TCustomComboBox_sw.ToVar(
  const AValue: TCustomComboBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomComboBox_sw.FromVar(
  const AValue: OleVariant): TCustomComboBox;
begin
  Result := TCustomComboBox(ConvFromVar(AValue, TCustomComboBox));
end;

class function TCustomComboBox_sw.ClassToVar(
  AClass: TCustomComboBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomComboBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomComboBox_sc;
begin
  Result := TCustomComboBox_sc(ConvClsFromVar(AClass, TCustomComboBox));
end;

{ TComboBox_sw }

class function TComboBox_sw.GetTypeName: WideString;
begin
  Result := 'TComboBox';
end;

class function TComboBox_sw.GetWrappedClass: TClass;
begin
  Result := TComboBox;
end;

class procedure TComboBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('AutoDropDown', False);
  AData.AddPropertyRedecl('AutoCloseUp', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('CharCase', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('DropDownCount', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('ItemHeight', False);
  AData.AddPropertyRedecl('ItemIndex', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Sorted', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnCloseUp', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnDropDown', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMeasureItem', False);
  AData.AddPropertyRedecl('OnSelect', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('Items', False);
end;

class function TComboBox_sw.ToVar(const AValue: TComboBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboBox_sw.FromVar(const AValue: OleVariant): TComboBox;
begin
  Result := TComboBox(ConvFromVar(AValue, TComboBox));
end;

class function TComboBox_sw.ClassToVar(AClass: TComboBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboBox_sw.ClassFromVar(
  const AClass: OleVariant): TComboBox_sc;
begin
  Result := TComboBox_sc(ConvClsFromVar(AClass, TComboBox));
end;

{ TButtonActionLink_sw }

class function TButtonActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TButtonActionLink';
end;

class function TButtonActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TButtonActionLink;
end;

class procedure TButtonActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TButtonActionLink_sw.ToVar(
  const AValue: TButtonActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TButtonActionLink_sw.FromVar(
  const AValue: OleVariant): TButtonActionLink;
begin
  Result := TButtonActionLink(ConvFromVar(AValue, TButtonActionLink));
end;

class function TButtonActionLink_sw.ClassToVar(
  AClass: TButtonActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TButtonActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TButtonActionLink_sc;
begin
  Result := TButtonActionLink_sc(ConvClsFromVar(AClass, TButtonActionLink));
end;

{ TButtonActionLinkClass_sw }

class function TButtonActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TButtonActionLinkClass';
end;

class function TButtonActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TButtonActionLink;
end;

class function TButtonActionLinkClass_sw.ToVar(
  const AValue: TButtonActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TButtonActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TButtonActionLinkClass;
begin
  Result := TButtonActionLinkClass(ConvFromVar(AValue, TButtonActionLink));
end;

{ TButtonControl_sw }

function TButtonControl_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Checked: Boolean read <getter> write <...

  if IsGet then
    Result := TButtonControl_sacc(TButtonControl(AObj)).Checked
  else
    TButtonControl_sacc(TButtonControl(AObj)).Checked := Boolean(AArgs[0]);
end;

function TButtonControl_ClicksDisabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ClicksDisabled: Boolean read <getter> ...

  if IsGet then
    Result := TButtonControl_sacc(TButtonControl(AObj)).ClicksDisabled
  else
    TButtonControl_sacc(TButtonControl(AObj)).ClicksDisabled := Boolean(
      AArgs[0]);
end;

function TButtonControl_WordWrap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WordWrap: Boolean read <getter> write ...

  if IsGet then
    Result := TButtonControl_sacc(TButtonControl(AObj)).WordWrap
  else
    TButtonControl_sacc(TButtonControl(AObj)).WordWrap := Boolean(AArgs[0]);
end;

class function TButtonControl_sw.GetTypeName: WideString;
begin
  Result := 'TButtonControl';
end;

class function TButtonControl_sw.GetWrappedClass: TClass;
begin
  Result := TButtonControl;
end;

class procedure TButtonControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Checked', TButtonControl_Checked_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ClicksDisabled', TButtonControl_ClicksDisabled_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('WordWrap', TButtonControl_WordWrap_si, Boolean_sw, True, True, 0, True, False);
end;

class function TButtonControl_sw.ToVar(
  const AValue: TButtonControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TButtonControl_sw.FromVar(
  const AValue: OleVariant): TButtonControl;
begin
  Result := TButtonControl(ConvFromVar(AValue, TButtonControl));
end;

class function TButtonControl_sw.ClassToVar(
  AClass: TButtonControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TButtonControl_sw.ClassFromVar(
  const AClass: OleVariant): TButtonControl_sc;
begin
  Result := TButtonControl_sc(ConvClsFromVar(AClass, TButtonControl));
end;

{ TButton_sw }

function TButton_Cancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cancel: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TButton(AObj).Cancel
  else
    TButton(AObj).Cancel := Boolean(AArgs[0]);
end;

function TButton_Default_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Default: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TButton(AObj).Default
  else
    TButton(AObj).Default := Boolean(AArgs[0]);
end;

function TButton_ModalResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalResult: TModalResult read <getter> write <s...

  if IsGet then
    Result := TModalResult_sw.ToVar(TButton(AObj).ModalResult)
  else
    TButton(AObj).ModalResult := TModalResult_sw.FromVar(AArgs[0]);
end;

class function TButton_sw.GetTypeName: WideString;
begin
  Result := 'TButton';
end;

class function TButton_sw.GetWrappedClass: TClass;
begin
  Result := TButton;
end;

class procedure TButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddProperty('Cancel', TButton_Cancel_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('Default', TButton_Default_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('ModalResult', TButton_ModalResult_si, TModalResult_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TButton_sw.ToVar(const AValue: TButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TButton_sw.FromVar(const AValue: OleVariant): TButton;
begin
  Result := TButton(ConvFromVar(AValue, TButton));
end;

class function TButton_sw.ClassToVar(AClass: TButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TButton_sw.ClassFromVar(const AClass: OleVariant): TButton_sc;
begin
  Result := TButton_sc(ConvClsFromVar(AClass, TButton));
end;

{ TCheckBoxState_sw }

class function TCheckBoxState_sw.GetTypeName: WideString;
begin
  Result := 'TCheckBoxState';
end;

class procedure TCheckBoxState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'cbUnchecked'; Value: Integer({$IFDEF LMDSCT_12}TCheckBoxState.{$ENDIF}cbUnchecked)),
    (Name: 'cbChecked'; Value: Integer({$IFDEF LMDSCT_12}TCheckBoxState.{$ENDIF}cbChecked)),
    (Name: 'cbGrayed'; Value: Integer({$IFDEF LMDSCT_12}TCheckBoxState.{$ENDIF}cbGrayed))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TCheckBoxState_sw.ToVar(
  const AValue: TCheckBoxState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCheckBoxState_sw.FromVar(
  const AValue: OleVariant): TCheckBoxState;
begin
  Result := TCheckBoxState(Integer(AValue));
end;

{ TCustomCheckBox_sw }

function TCustomCheckBox_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Alignment: TLeftRight read <getter> wr...

  if IsGet then
    Result := TLeftRight_sw.ToVar(TCustomCheckBox_sacc(TCustomCheckBox(AObj)).
      Alignment)
  else
    TCustomCheckBox_sacc(TCustomCheckBox(AObj)).Alignment := TLeftRight_sw.
      FromVar(AArgs[0]);
end;

function TCustomCheckBox_AllowGrayed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AllowGrayed: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomCheckBox_sacc(TCustomCheckBox(AObj)).AllowGrayed
  else
    TCustomCheckBox_sacc(TCustomCheckBox(AObj)).AllowGrayed := Boolean(
      AArgs[0]);
end;

function TCustomCheckBox_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property State: TCheckBoxState read <getter> wr...

  if IsGet then
    Result := TCheckBoxState_sw.ToVar(TCustomCheckBox_sacc(TCustomCheckBox(
      AObj)).State)
  else
    TCustomCheckBox_sacc(TCustomCheckBox(AObj)).State := TCheckBoxState_sw.
      FromVar(AArgs[0]);
end;

class function TCustomCheckBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomCheckBox';
end;

class function TCustomCheckBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomCheckBox;
end;

class procedure TCustomCheckBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TCustomCheckBox_Alignment_si, TLeftRight_sw, True, True, 0, True, False);
  AData.AddProperty('AllowGrayed', TCustomCheckBox_AllowGrayed_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('State', TCustomCheckBox_State_si, TCheckBoxState_sw, True, True, 0, True, False);
  AData.AddPropertyRedecl('TabStop', False);
end;

class function TCustomCheckBox_sw.ToVar(
  const AValue: TCustomCheckBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomCheckBox_sw.FromVar(
  const AValue: OleVariant): TCustomCheckBox;
begin
  Result := TCustomCheckBox(ConvFromVar(AValue, TCustomCheckBox));
end;

class function TCustomCheckBox_sw.ClassToVar(
  AClass: TCustomCheckBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomCheckBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomCheckBox_sc;
begin
  Result := TCustomCheckBox_sc(ConvClsFromVar(AClass, TCustomCheckBox));
end;

{ TCheckBox_sw }

class function TCheckBox_sw.GetTypeName: WideString;
begin
  Result := 'TCheckBox';
end;

class function TCheckBox_sw.GetWrappedClass: TClass;
begin
  Result := TCheckBox;
end;

class procedure TCheckBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('AllowGrayed', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Checked', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('State', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TCheckBox_sw.ToVar(const AValue: TCheckBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckBox_sw.FromVar(const AValue: OleVariant): TCheckBox;
begin
  Result := TCheckBox(ConvFromVar(AValue, TCheckBox));
end;

class function TCheckBox_sw.ClassToVar(AClass: TCheckBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCheckBox_sw.ClassFromVar(
  const AClass: OleVariant): TCheckBox_sc;
begin
  Result := TCheckBox_sc(ConvClsFromVar(AClass, TCheckBox));
end;

{ TRadioButton_sw }

function TRadioButton_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TLeftRight read <getter> write <setter>;

  if IsGet then
    Result := TLeftRight_sw.ToVar(TRadioButton(AObj).Alignment)
  else
    TRadioButton(AObj).Alignment := TLeftRight_sw.FromVar(AArgs[0]);
end;

class function TRadioButton_sw.GetTypeName: WideString;
begin
  Result := 'TRadioButton';
end;

class function TRadioButton_sw.GetWrappedClass: TClass;
begin
  Result := TRadioButton;
end;

class procedure TRadioButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action', False);
  AData.AddProperty('Alignment', TRadioButton_Alignment_si, TLeftRight_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Checked', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TRadioButton_sw.ToVar(const AValue: TRadioButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TRadioButton_sw.FromVar(const AValue: OleVariant): TRadioButton;
begin
  Result := TRadioButton(ConvFromVar(AValue, TRadioButton));
end;

class function TRadioButton_sw.ClassToVar(AClass: TRadioButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TRadioButton_sw.ClassFromVar(
  const AClass: OleVariant): TRadioButton_sc;
begin
  Result := TRadioButton_sc(ConvClsFromVar(AClass, TRadioButton));
end;

{ TListBoxStyle_sw }

class function TListBoxStyle_sw.GetTypeName: WideString;
begin
  Result := 'TListBoxStyle';
end;

class procedure TListBoxStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'lbStandard'; Value: Integer({$IFDEF LMDSCT_12}TListBoxStyle.{$ENDIF}lbStandard)),
    (Name: 'lbOwnerDrawFixed'; Value: Integer({$IFDEF LMDSCT_12}TListBoxStyle.{$ENDIF}lbOwnerDrawFixed)),
    (Name: 'lbOwnerDrawVariable'; Value: Integer({$IFDEF LMDSCT_12}TListBoxStyle.{$ENDIF}lbOwnerDrawVariable)),
    (Name: 'lbVirtual'; Value: Integer({$IFDEF LMDSCT_12}TListBoxStyle.{$ENDIF}lbVirtual)),
    (Name: 'lbVirtualOwnerDraw'; Value: Integer({$IFDEF LMDSCT_12}TListBoxStyle.{$ENDIF}lbVirtualOwnerDraw))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TListBoxStyle_sw.ToVar(const AValue: TListBoxStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListBoxStyle_sw.FromVar(
  const AValue: OleVariant): TListBoxStyle;
begin
  Result := TListBoxStyle(Integer(AValue));
end;

{ TLBGetDataEvent_sh }

function TLBGetDataEvent_sh.GetHandler: TMethod;
var
  hdr: TLBGetDataEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLBGetDataEvent_sh.Handler(Control: TWinControl; Index: Integer;
  var Data: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Control: TWinControl; Index: Integer; var Data...

  v_1 := Data;
  args[0] := TWinControl_sw.ToVar(Control);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Data := string(v_1);
end;

{ TLBGetDataEvent_sw }

class function TLBGetDataEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLBGetDataEvent';
end;

class function TLBGetDataEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLBGetDataEvent_sh;
end;

class function TLBGetDataEvent_sw.ToVar(
  const AValue: TLBGetDataEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLBGetDataEvent_sw.FromVar(
  const AValue: OleVariant): TLBGetDataEvent;
begin
  Result := TLBGetDataEvent(ConvFromVar(AValue));
end;

class function TLBGetDataEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLBGetDataEvent;
var
  hdlr: TLBGetDataEvent_sh;
begin
  hdlr   := TLBGetDataEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLBGetDataEvent_sw));
  Result := hdlr.Handler;
end;

{ TLBGetDataObjectEvent_sh }

function TLBGetDataObjectEvent_sh.GetHandler: TMethod;
var
  hdr: TLBGetDataObjectEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLBGetDataObjectEvent_sh.Handler(Control: TWinControl; Index: Integer;
  var DataObject: TObject);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Control: TWinControl; Index: Integer; var Data...

  v_1 := TObject_sw.ToVar(DataObject);
  args[0] := TWinControl_sw.ToVar(Control);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DataObject := TObject_sw.FromVar(v_1);
end;

{ TLBGetDataObjectEvent_sw }

class function TLBGetDataObjectEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLBGetDataObjectEvent';
end;

class function TLBGetDataObjectEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLBGetDataObjectEvent_sh;
end;

class function TLBGetDataObjectEvent_sw.ToVar(
  const AValue: TLBGetDataObjectEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLBGetDataObjectEvent_sw.FromVar(
  const AValue: OleVariant): TLBGetDataObjectEvent;
begin
  Result := TLBGetDataObjectEvent(ConvFromVar(AValue));
end;

class function TLBGetDataObjectEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLBGetDataObjectEvent;
var
  hdlr: TLBGetDataObjectEvent_sh;
begin
  hdlr   := TLBGetDataObjectEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLBGetDataObjectEvent_sw));
  Result := hdlr.Handler;
end;

{ TLBFindDataEvent_sh }

function TLBFindDataEvent_sh.GetHandler: TMethod;
var
  hdr: TLBFindDataEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TLBFindDataEvent_sh.Handler(Control: TWinControl;
  FindString: string): Integer;
var
  args: array[0..1] of OleVariant;
begin
  // function (Control: TWinControl; FindString: string): Inte...

  args[0] := TWinControl_sw.ToVar(Control);
  args[1] := FindString;
  Result := Integer(Self.Owner.RunProc(Self.ProcName, args));
end;

{ TLBFindDataEvent_sw }

class function TLBFindDataEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLBFindDataEvent';
end;

class function TLBFindDataEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLBFindDataEvent_sh;
end;

class function TLBFindDataEvent_sw.ToVar(
  const AValue: TLBFindDataEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLBFindDataEvent_sw.FromVar(
  const AValue: OleVariant): TLBFindDataEvent;
begin
  Result := TLBFindDataEvent(ConvFromVar(AValue));
end;

class function TLBFindDataEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLBFindDataEvent;
var
  hdlr: TLBFindDataEvent_sh;
begin
  hdlr   := TLBFindDataEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLBFindDataEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomListBox_sw }

function TCustomListBox_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomListBox_sacc(TCustomListBox(AObj)).
      BorderStyle)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).BorderStyle := TBorderStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomListBox_Columns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Columns: Integer read <getter> write <...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).Columns
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).Columns := Integer(AArgs[0]);
end;

function TCustomListBox_ExtendedSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ExtendedSelect: Boolean read <getter> ...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).ExtendedSelect
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).ExtendedSelect := Boolean(
      AArgs[0]);
end;

function TCustomListBox_IntegralHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IntegralHeight: Boolean read <getter> ...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).IntegralHeight
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).IntegralHeight := Boolean(
      AArgs[0]);
end;

function TCustomListBox_ItemHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ItemHeight: Integer read <getter> writ...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).ItemHeight
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).ItemHeight := Integer(AArgs[0]);
end;

function TCustomListBox_Sorted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Sorted: Boolean read <getter> write <s...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).Sorted
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).Sorted := Boolean(AArgs[0]);
end;

function TCustomListBox_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Style: TListBoxStyle read <getter> wri...

  if IsGet then
    Result := TListBoxStyle_sw.ToVar(TCustomListBox_sacc(TCustomListBox(AObj)).
      Style)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).Style := TListBoxStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomListBox_TabWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabWidth: Integer read <getter> write ...

  if IsGet then
    Result := TCustomListBox_sacc(TCustomListBox(AObj)).TabWidth
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).TabWidth := Integer(AArgs[0]);
end;

function TCustomListBox_OnMeasureItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMeasureItem: TMeasureItemEvent read ...

  if IsGet then
    Result := TMeasureItemEvent_sw.ToVar(TCustomListBox_sacc(TCustomListBox(
      AObj)).OnMeasureItem)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).OnMeasureItem := 
      TMeasureItemEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListBox_OnData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnData: TLBGetDataEvent read <getter> ...

  if IsGet then
    Result := TLBGetDataEvent_sw.ToVar(TCustomListBox_sacc(TCustomListBox(
      AObj)).OnData)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).OnData := TLBGetDataEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListBox_OnDataObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDataObject: TLBGetDataObjectEvent re...

  if IsGet then
    Result := TLBGetDataObjectEvent_sw.ToVar(TCustomListBox_sacc(TCustomListBox(
      AObj)).OnDataObject)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).OnDataObject := 
      TLBGetDataObjectEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListBox_OnDataFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDataFind: TLBFindDataEvent read <get...

  if IsGet then
    Result := TLBFindDataEvent_sw.ToVar(TCustomListBox_sacc(TCustomListBox(
      AObj)).OnDataFind)
  else
    TCustomListBox_sacc(TCustomListBox(AObj)).OnDataFind := TLBFindDataEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListBox_ItemAtPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;

  Result := TCustomListBox(AObj).ItemAtPos(TPoint_sw.FromVar(AArgs[0]), Boolean(
    AArgs[1]));
end;

function TCustomListBox_ItemRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ItemRect(Index: Integer): TRect;

  Result := TRect_sw.ToVar(TCustomListBox(AObj).ItemRect(Integer(AArgs[0])));
end;

function TCustomListBox_AutoComplete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoComplete: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListBox(AObj).AutoComplete
  else
    TCustomListBox(AObj).AutoComplete := Boolean(AArgs[0]);
end;

function TCustomListBox_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomListBox(AObj).Canvas);
end;

function TCustomListBox_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomListBox(AObj).Count
  else
    TCustomListBox(AObj).Count := Integer(AArgs[0]);
end;

function TCustomListBox_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomListBox(AObj).Items)
  else
    TCustomListBox(AObj).Items := TStrings_sw.FromVar(AArgs[0]);
end;

function TCustomListBox_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected[Index: Integer]: Boolean read <getter> ...

  if IsGet then
    Result := TCustomListBox(AObj).Selected[Integer(AArgs[0])]
  else
    TCustomListBox(AObj).Selected[Integer(AArgs[0])] := Boolean(AArgs[1]);
end;

function TCustomListBox_ScrollWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ScrollWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomListBox(AObj).ScrollWidth
  else
    TCustomListBox(AObj).ScrollWidth := Integer(AArgs[0]);
end;

function TCustomListBox_TopIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TopIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomListBox(AObj).TopIndex
  else
    TCustomListBox(AObj).TopIndex := Integer(AArgs[0]);
end;

class function TCustomListBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomListBox';
end;

class function TCustomListBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomListBox;
end;

class procedure TCustomListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BorderStyle', TCustomListBox_BorderStyle_si, TBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('Columns', TCustomListBox_Columns_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('ExtendedSelect', TCustomListBox_ExtendedSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('IntegralHeight', TCustomListBox_IntegralHeight_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ItemHeight', TCustomListBox_ItemHeight_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Sorted', TCustomListBox_Sorted_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Style', TCustomListBox_Style_si, TListBoxStyle_sw, True, True, 0, True, False);
  AData.AddProperty('TabWidth', TCustomListBox_TabWidth_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('OnMeasureItem', TCustomListBox_OnMeasureItem_si, TMeasureItemEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnData', TCustomListBox_OnData_si, TLBGetDataEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDataObject', TCustomListBox_OnDataObject_si, TLBGetDataObjectEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDataFind', TCustomListBox_OnDataFind_si, TLBFindDataEvent_sw, True, True, 0, True, False);
  AData.AddFunction('ItemAtPos', TCustomListBox_ItemAtPos_si, Integer_sw, 2, False);
  AData.AddFunction('ItemRect', TCustomListBox_ItemRect_si, TRect_sw, 1, False);
  AData.AddProperty('AutoComplete', TCustomListBox_AutoComplete_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Canvas', TCustomListBox_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('Count', TCustomListBox_Count_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TCustomListBox_Items_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('Selected', TCustomListBox_Selected_si, Boolean_sw, True, True, 1, False, False);
  AData.AddProperty('ScrollWidth', TCustomListBox_ScrollWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('TopIndex', TCustomListBox_TopIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabStop', False);
end;

class function TCustomListBox_sw.ToVar(
  const AValue: TCustomListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomListBox_sw.FromVar(
  const AValue: OleVariant): TCustomListBox;
begin
  Result := TCustomListBox(ConvFromVar(AValue, TCustomListBox));
end;

class function TCustomListBox_sw.ClassToVar(
  AClass: TCustomListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomListBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomListBox_sc;
begin
  Result := TCustomListBox_sc(ConvClsFromVar(AClass, TCustomListBox));
end;

{ TListBox_sw }

class function TListBox_sw.GetTypeName: WideString;
begin
  Result := 'TListBox';
end;

class function TListBox_sw.GetWrappedClass: TClass;
begin
  Result := TListBox;
end;

class procedure TListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('ExtendedSelect', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('IntegralHeight', False);
  AData.AddPropertyRedecl('ItemHeight', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('MultiSelect', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ScrollWidth', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Sorted', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('TabWidth', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnData', False);
  AData.AddPropertyRedecl('OnDataFind', False);
  AData.AddPropertyRedecl('OnDataObject', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMeasureItem', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TListBox_sw.ToVar(const AValue: TListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListBox_sw.FromVar(const AValue: OleVariant): TListBox;
begin
  Result := TListBox(ConvFromVar(AValue, TListBox));
end;

class function TListBox_sw.ClassToVar(AClass: TListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListBox_sw.ClassFromVar(const AClass: OleVariant): TListBox_sc;
begin
  Result := TListBox_sc(ConvClsFromVar(AClass, TListBox));
end;

{ TScrollCode_sw }

class function TScrollCode_sw.GetTypeName: WideString;
begin
  Result := 'TScrollCode';
end;

class procedure TScrollCode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'scLineUp'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scLineUp)),
    (Name: 'scLineDown'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scLineDown)),
    (Name: 'scPageUp'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPageUp)),
    (Name: 'scPageDown'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPageDown)),
    (Name: 'scPosition'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPosition)),
    (Name: 'scTrack'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scTrack)),
    (Name: 'scTop'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scTop)),
    (Name: 'scBottom'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scBottom)),
    (Name: 'scEndScroll'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scEndScroll))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TScrollCode_sw.ToVar(const AValue: TScrollCode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollCode_sw.FromVar(const AValue: OleVariant): TScrollCode;
begin
  Result := TScrollCode(Integer(AValue));
end;

{ TScrollEvent_sh }

function TScrollEvent_sh.GetHandler: TMethod;
var
  hdr: TScrollEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TScrollEvent_sh.Handler(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; ScrollCode: TScrollCode; var ...

  v_1 := ScrollPos;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TScrollCode_sw.ToVar(ScrollCode);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ScrollPos := Integer(v_1);
end;

{ TScrollEvent_sw }

class function TScrollEvent_sw.GetTypeName: WideString;
begin
  Result := 'TScrollEvent';
end;

class function TScrollEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TScrollEvent_sh;
end;

class function TScrollEvent_sw.ToVar(const AValue: TScrollEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TScrollEvent_sw.FromVar(const AValue: OleVariant): TScrollEvent;
begin
  Result := TScrollEvent(ConvFromVar(AValue));
end;

class function TScrollEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TScrollEvent;
var
  hdlr: TScrollEvent_sh;
begin
  hdlr   := TScrollEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TScrollEvent_sw));
  Result := hdlr.Handler;
end;

{ TScrollBar_sw }

function TScrollBar_SetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetParams(APosition: Integer; AMin: Integer; AM...

  TScrollBar(AObj).SetParams(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]));
end;

function TScrollBar_Kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Kind: TScrollBarKind read <getter> write <setter>;

  if IsGet then
    Result := TScrollBarKind_sw.ToVar(TScrollBar(AObj).Kind)
  else
    TScrollBar(AObj).Kind := TScrollBarKind_sw.FromVar(AArgs[0]);
end;

function TScrollBar_LargeChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LargeChange: TScrollBarInc read <getter> write <...

  if IsGet then
    Result := TScrollBarInc_sw.ToVar(TScrollBar(AObj).LargeChange)
  else
    TScrollBar(AObj).LargeChange := TScrollBarInc_sw.FromVar(AArgs[0]);
end;

function TScrollBar_Max_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Max: Integer read <getter> write <setter>;

  if IsGet then
    Result := TScrollBar(AObj).Max
  else
    TScrollBar(AObj).Max := Integer(AArgs[0]);
end;

function TScrollBar_Min_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Min: Integer read <getter> write <setter>;

  if IsGet then
    Result := TScrollBar(AObj).Min
  else
    TScrollBar(AObj).Min := Integer(AArgs[0]);
end;

function TScrollBar_PageSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TScrollBar(AObj).PageSize
  else
    TScrollBar(AObj).PageSize := Integer(AArgs[0]);
end;

function TScrollBar_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TScrollBar(AObj).Position
  else
    TScrollBar(AObj).Position := Integer(AArgs[0]);
end;

function TScrollBar_SmallChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SmallChange: TScrollBarInc read <getter> write <...

  if IsGet then
    Result := TScrollBarInc_sw.ToVar(TScrollBar(AObj).SmallChange)
  else
    TScrollBar(AObj).SmallChange := TScrollBarInc_sw.FromVar(AArgs[0]);
end;

function TScrollBar_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TScrollBar(AObj).OnChange)
  else
    TScrollBar(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TScrollBar_OnScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnScroll: TScrollEvent read <getter> write <sett...

  if IsGet then
    Result := TScrollEvent_sw.ToVar(TScrollBar(AObj).OnScroll)
  else
    TScrollBar(AObj).OnScroll := TScrollEvent_sw.FromVar(AArgs[0]);
end;

class function TScrollBar_sw.GetTypeName: WideString;
begin
  Result := 'TScrollBar';
end;

class function TScrollBar_sw.GetWrappedClass: TClass;
begin
  Result := TScrollBar;
end;

class procedure TScrollBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SetParams', TScrollBar_SetParams_si, 3, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('Kind', TScrollBar_Kind_si, TScrollBarKind_sw, True, True, 0, False, False);
  AData.AddProperty('LargeChange', TScrollBar_LargeChange_si, TScrollBarInc_sw, True, True, 0, False, False);
  AData.AddProperty('Max', TScrollBar_Max_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Min', TScrollBar_Min_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PageSize', TScrollBar_PageSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Position', TScrollBar_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('SmallChange', TScrollBar_SmallChange_si, TScrollBarInc_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddProperty('OnChange', TScrollBar_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddProperty('OnScroll', TScrollBar_OnScroll_si, TScrollEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TScrollBar_sw.ToVar(const AValue: TScrollBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TScrollBar_sw.FromVar(const AValue: OleVariant): TScrollBar;
begin
  Result := TScrollBar(ConvFromVar(AValue, TScrollBar));
end;

class function TScrollBar_sw.ClassToVar(AClass: TScrollBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TScrollBar_sw.ClassFromVar(
  const AClass: OleVariant): TScrollBar_sc;
begin
  Result := TScrollBar_sc(ConvClsFromVar(AClass, TScrollBar));
end;

{ TStaticBorderStyle_sw }

class function TStaticBorderStyle_sw.GetTypeName: WideString;
begin
  Result := 'TStaticBorderStyle';
end;

class procedure TStaticBorderStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'sbsNone'; Value: Integer({$IFDEF LMDSCT_12}TStaticBorderStyle.{$ENDIF}sbsNone)),
    (Name: 'sbsSingle'; Value: Integer({$IFDEF LMDSCT_12}TStaticBorderStyle.{$ENDIF}sbsSingle)),
    (Name: 'sbsSunken'; Value: Integer({$IFDEF LMDSCT_12}TStaticBorderStyle.{$ENDIF}sbsSunken))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TStaticBorderStyle_sw.ToVar(
  const AValue: TStaticBorderStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStaticBorderStyle_sw.FromVar(
  const AValue: OleVariant): TStaticBorderStyle;
begin
  Result := TStaticBorderStyle(Integer(AValue));
end;

{ TCustomStaticText_sw }

function TCustomStaticText_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Alignment: TAlignment read <getter> wr...

  if IsGet then
    Result := TAlignment_sw.ToVar(TCustomStaticText_sacc(TCustomStaticText(
      AObj)).Alignment)
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).Alignment := TAlignment_sw.
      FromVar(AArgs[0]);
end;

function TCustomStaticText_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSize: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomStaticText_sacc(TCustomStaticText(AObj)).AutoSize
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).AutoSize := Boolean(
      AArgs[0]);
end;

function TCustomStaticText_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TStaticBorderStyle read <...

  if IsGet then
    Result := TStaticBorderStyle_sw.ToVar(TCustomStaticText_sacc(
      TCustomStaticText(AObj)).BorderStyle)
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).BorderStyle := 
      TStaticBorderStyle_sw.FromVar(AArgs[0]);
end;

function TCustomStaticText_FocusControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FocusControl: TWinControl read <getter...

  if IsGet then
    Result := TWinControl_sw.ToVar(TCustomStaticText_sacc(TCustomStaticText(
      AObj)).FocusControl)
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).FocusControl := 
      TWinControl_sw.FromVar(AArgs[0]);
end;

function TCustomStaticText_ShowAccelChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowAccelChar: Boolean read <getter> w...

  if IsGet then
    Result := TCustomStaticText_sacc(TCustomStaticText(AObj)).ShowAccelChar
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).ShowAccelChar := Boolean(
      AArgs[0]);
end;

function TCustomStaticText_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Transparent: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomStaticText_sacc(TCustomStaticText(AObj)).Transparent
  else
    TCustomStaticText_sacc(TCustomStaticText(AObj)).Transparent := Boolean(
      AArgs[0]);
end;

class function TCustomStaticText_sw.GetTypeName: WideString;
begin
  Result := 'TCustomStaticText';
end;

class function TCustomStaticText_sw.GetWrappedClass: TClass;
begin
  Result := TCustomStaticText;
end;

class procedure TCustomStaticText_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TCustomStaticText_Alignment_si, TAlignment_sw, True, True, 0, True, False);
  AData.AddProperty('AutoSize', TCustomStaticText_AutoSize_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('BorderStyle', TCustomStaticText_BorderStyle_si, TStaticBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('FocusControl', TCustomStaticText_FocusControl_si, TWinControl_sw, True, True, 0, True, False);
  AData.AddProperty('ShowAccelChar', TCustomStaticText_ShowAccelChar_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Transparent', TCustomStaticText_Transparent_si, Boolean_sw, True, True, 0, True, False);
end;

class function TCustomStaticText_sw.ToVar(
  const AValue: TCustomStaticText): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomStaticText_sw.FromVar(
  const AValue: OleVariant): TCustomStaticText;
begin
  Result := TCustomStaticText(ConvFromVar(AValue, TCustomStaticText));
end;

class function TCustomStaticText_sw.ClassToVar(
  AClass: TCustomStaticText_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomStaticText_sw.ClassFromVar(
  const AClass: OleVariant): TCustomStaticText_sc;
begin
  Result := TCustomStaticText_sc(ConvClsFromVar(AClass, TCustomStaticText));
end;

{ TStaticText_sw }

class function TStaticText_sw.GetTypeName: WideString;
begin
  Result := 'TStaticText';
end;

class function TStaticText_sw.GetWrappedClass: TClass;
begin
  Result := TStaticText;
end;

class procedure TStaticText_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('FocusControl', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowAccelChar', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Transparent', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TStaticText_sw.ToVar(const AValue: TStaticText): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStaticText_sw.FromVar(const AValue: OleVariant): TStaticText;
begin
  Result := TStaticText(ConvFromVar(AValue, TStaticText));
end;

class function TStaticText_sw.ClassToVar(AClass: TStaticText_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStaticText_sw.ClassFromVar(
  const AClass: OleVariant): TStaticText_sc;
begin
  Result := TStaticText_sc(ConvClsFromVar(AClass, TStaticText));
end;

{ StdCtrls_sw }

function StdCtrls_TCustomGroupBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGroupBox = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGroupBox_sw);
end;

function StdCtrls_TGroupBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGroupBox = class(TCustomGroupBox);

  Result := TLMDUnitWrapper.TypeToVar(TGroupBox_sw);
end;

function StdCtrls_TTextLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextLayout = (tlTop, tlCenter, tlBottom);

  Result := TLMDUnitWrapper.TypeToVar(TTextLayout_sw);
end;

function StdCtrls_TCustomLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomLabel = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomLabel_sw);
end;

function StdCtrls_TLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLabel = class(TCustomLabel);

  Result := TLMDUnitWrapper.TypeToVar(TLabel_sw);
end;

function StdCtrls_TEditCharCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditCharCase = (ecNormal, ecUpperCase, ecLowerCase);

  Result := TLMDUnitWrapper.TypeToVar(TEditCharCase_sw);
end;

function StdCtrls_TCustomEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomEdit = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomEdit_sw);
end;

function StdCtrls_TEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEdit = class(TCustomEdit);

  Result := TLMDUnitWrapper.TypeToVar(TEdit_sw);
end;

function StdCtrls_TScrollStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollStyle = (ssNone, ssHorizontal, ssVertical, ss...

  Result := TLMDUnitWrapper.TypeToVar(TScrollStyle_sw);
end;

function StdCtrls_TCustomMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMemo = class(TCustomEdit);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMemo_sw);
end;

function StdCtrls_TMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemo = class(TCustomMemo);

  Result := TLMDUnitWrapper.TypeToVar(TMemo_sw);
end;

function StdCtrls_TMeasureItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMeasureItemEvent = procedure (Control: TWinControl;...

  Result := TLMDUnitWrapper.TypeToVar(TMeasureItemEvent_sw);
end;

function StdCtrls_TCustomComboBoxStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomComboBoxStrings = class(TStrings);

  Result := TLMDUnitWrapper.TypeToVar(TCustomComboBoxStrings_sw);
end;

function StdCtrls_TCustomComboBoxStringsClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomComboBoxStringsClass = class of TCustomComboB...

  Result := TLMDUnitWrapper.TypeToVar(TCustomComboBoxStringsClass_sw);
end;

function StdCtrls_TCustomCombo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomCombo = class(TCustomListControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomCombo_sw);
end;

function StdCtrls_TComboBoxStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxStyle = (csDropDown, csSimple, csDropDownLi...

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxStyle_sw);
end;

function StdCtrls_TCustomComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomComboBox = class(TCustomCombo);

  Result := TLMDUnitWrapper.TypeToVar(TCustomComboBox_sw);
end;

function StdCtrls_TComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBox = class(TCustomComboBox);

  Result := TLMDUnitWrapper.TypeToVar(TComboBox_sw);
end;

function StdCtrls_TButtonActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonActionLink = class(TWinControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TButtonActionLink_sw);
end;

function StdCtrls_TButtonActionLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonActionLinkClass = class of TButtonActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TButtonActionLinkClass_sw);
end;

function StdCtrls_TButtonControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TButtonControl_sw);
end;

function StdCtrls_TButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButton = class(TButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TButton_sw);
end;

function StdCtrls_TCheckBoxState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckBoxState = (cbUnchecked, cbChecked, cbGrayed);

  Result := TLMDUnitWrapper.TypeToVar(TCheckBoxState_sw);
end;

function StdCtrls_TCustomCheckBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomCheckBox = class(TButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomCheckBox_sw);
end;

function StdCtrls_TCheckBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckBox = class(TCustomCheckBox);

  Result := TLMDUnitWrapper.TypeToVar(TCheckBox_sw);
end;

function StdCtrls_TRadioButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRadioButton = class(TButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TRadioButton_sw);
end;

function StdCtrls_TListBoxStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListBoxStyle = (lbStandard, lbOwnerDrawFixed, lbOwn...

  Result := TLMDUnitWrapper.TypeToVar(TListBoxStyle_sw);
end;

function StdCtrls_TLBGetDataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLBGetDataEvent = procedure (Control: TWinControl; I...

  Result := TLMDUnitWrapper.TypeToVar(TLBGetDataEvent_sw);
end;

function StdCtrls_TLBGetDataObjectEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLBGetDataObjectEvent = procedure (Control: TWinCont...

  Result := TLMDUnitWrapper.TypeToVar(TLBGetDataObjectEvent_sw);
end;

function StdCtrls_TLBFindDataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLBFindDataEvent = function (Control: TWinControl; F...

  Result := TLMDUnitWrapper.TypeToVar(TLBFindDataEvent_sw);
end;

function StdCtrls_TCustomListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomListBox = class(TCustomMultiSelectListControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomListBox_sw);
end;

function StdCtrls_TListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListBox = class(TCustomListBox);

  Result := TLMDUnitWrapper.TypeToVar(TListBox_sw);
end;

function StdCtrls_TScrollCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollCode = (scLineUp, scLineDown, scPageUp, scPag...

  Result := TLMDUnitWrapper.TypeToVar(TScrollCode_sw);
end;

function StdCtrls_TScrollEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollEvent = procedure (Sender: TObject; ScrollCod...

  Result := TLMDUnitWrapper.TypeToVar(TScrollEvent_sw);
end;

function StdCtrls_TScrollBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollBar = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TScrollBar_sw);
end;

function StdCtrls_TStaticBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStaticBorderStyle = (sbsNone, sbsSingle, sbsSunken);

  Result := TLMDUnitWrapper.TypeToVar(TStaticBorderStyle_sw);
end;

function StdCtrls_TCustomStaticText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomStaticText = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomStaticText_sw);
end;

function StdCtrls_TStaticText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStaticText = class(TCustomStaticText);

  Result := TLMDUnitWrapper.TypeToVar(TStaticText_sw);
end;

class function StdCtrls_sw.GetUnitName: WideString;
begin
  Result := 'StdCtrls';
end;

class procedure StdCtrls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomGroupBox_sw, StdCtrls_TCustomGroupBox_si);
  AData.AddType(TGroupBox_sw, StdCtrls_TGroupBox_si);
  AData.AddType(TTextLayout_sw, StdCtrls_TTextLayout_si);
  AData.AddType(TCustomLabel_sw, StdCtrls_TCustomLabel_si);
  AData.AddType(TLabel_sw, StdCtrls_TLabel_si);
  AData.AddType(TEditCharCase_sw, StdCtrls_TEditCharCase_si);
  AData.AddType(TCustomEdit_sw, StdCtrls_TCustomEdit_si);
  AData.AddType(TEdit_sw, StdCtrls_TEdit_si);
  AData.AddType(TScrollStyle_sw, StdCtrls_TScrollStyle_si);
  AData.AddType(TCustomMemo_sw, StdCtrls_TCustomMemo_si);
  AData.AddType(TMemo_sw, StdCtrls_TMemo_si);
  AData.AddType(TMeasureItemEvent_sw, StdCtrls_TMeasureItemEvent_si);
  AData.AddType(TCustomComboBoxStrings_sw, StdCtrls_TCustomComboBoxStrings_si);
  AData.AddType(TCustomComboBoxStringsClass_sw, StdCtrls_TCustomComboBoxStringsClass_si);
  AData.AddType(TCustomCombo_sw, StdCtrls_TCustomCombo_si);
  AData.AddType(TComboBoxStyle_sw, StdCtrls_TComboBoxStyle_si);
  AData.AddType(TCustomComboBox_sw, StdCtrls_TCustomComboBox_si);
  AData.AddType(TComboBox_sw, StdCtrls_TComboBox_si);
  AData.AddType(TButtonActionLink_sw, StdCtrls_TButtonActionLink_si);
  AData.AddType(TButtonActionLinkClass_sw, StdCtrls_TButtonActionLinkClass_si);
  AData.AddType(TButtonControl_sw, StdCtrls_TButtonControl_si);
  AData.AddType(TButton_sw, StdCtrls_TButton_si);
  AData.AddType(TCheckBoxState_sw, StdCtrls_TCheckBoxState_si);
  AData.AddType(TCustomCheckBox_sw, StdCtrls_TCustomCheckBox_si);
  AData.AddType(TCheckBox_sw, StdCtrls_TCheckBox_si);
  AData.AddType(TRadioButton_sw, StdCtrls_TRadioButton_si);
  AData.AddType(TListBoxStyle_sw, StdCtrls_TListBoxStyle_si);
  AData.AddType(TLBGetDataEvent_sw, StdCtrls_TLBGetDataEvent_si);
  AData.AddType(TLBGetDataObjectEvent_sw, StdCtrls_TLBGetDataObjectEvent_si);
  AData.AddType(TLBFindDataEvent_sw, StdCtrls_TLBFindDataEvent_si);
  AData.AddType(TCustomListBox_sw, StdCtrls_TCustomListBox_si);
  AData.AddType(TListBox_sw, StdCtrls_TListBox_si);
  AData.AddType(TScrollCode_sw, StdCtrls_TScrollCode_si);
  AData.AddType(TScrollEvent_sw, StdCtrls_TScrollEvent_si);
  AData.AddType(TScrollBar_sw, StdCtrls_TScrollBar_si);
  AData.AddType(TStaticBorderStyle_sw, StdCtrls_TStaticBorderStyle_si);
  AData.AddType(TCustomStaticText_sw, StdCtrls_TCustomStaticText_si);
  AData.AddType(TStaticText_sw, StdCtrls_TStaticText_si);
end;

class function StdCtrls_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(StdCtrls_sw);
end;

initialization
  RegisterUnitWrapper(StdCtrls_sw);
  RegisterClassWrapper(TCustomGroupBox_sw);
  RegisterClassWrapper(TGroupBox_sw);
  RegisterClassWrapper(TCustomLabel_sw);
  RegisterClassWrapper(TLabel_sw);
  RegisterClassWrapper(TCustomEdit_sw);
  RegisterClassWrapper(TEdit_sw);
  RegisterClassWrapper(TCustomMemo_sw);
  RegisterClassWrapper(TMemo_sw);
  RegisterClassWrapper(TCustomComboBoxStrings_sw);
  RegisterClassWrapper(TCustomCombo_sw);
  RegisterClassWrapper(TCustomComboBox_sw);
  RegisterClassWrapper(TComboBox_sw);
  RegisterClassWrapper(TButtonActionLink_sw);
  RegisterClassWrapper(TButtonControl_sw);
  RegisterClassWrapper(TButton_sw);
  RegisterClassWrapper(TCustomCheckBox_sw);
  RegisterClassWrapper(TCheckBox_sw);
  RegisterClassWrapper(TRadioButton_sw);
  RegisterClassWrapper(TCustomListBox_sw);
  RegisterClassWrapper(TListBox_sw);
  RegisterClassWrapper(TScrollBar_sw);
  RegisterClassWrapper(TCustomStaticText_sw);
  RegisterClassWrapper(TStaticText_sw);
  RegisterEventWrapper(TypeInfo(TMeasureItemEvent), TMeasureItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TLBGetDataEvent), TLBGetDataEvent_sw);
  RegisterEventWrapper(TypeInfo(TLBGetDataObjectEvent), TLBGetDataObjectEvent_sw);
  RegisterEventWrapper(TypeInfo(TLBFindDataEvent), TLBFindDataEvent_sw);
  RegisterEventWrapper(TypeInfo(TScrollEvent), TScrollEvent_sw);

end.
