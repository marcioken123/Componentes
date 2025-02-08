unit ExtCtrls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ExtCtrls' unit.
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
  Menus, Graphics, StdCtrls, ExtCtrls, Messages_LMDSW, Windows_LMDSW,
  SysUtils_LMDSW, Classes_LMDSW, Controls_LMDSW, Forms_LMDSW, Menus_LMDSW,
  Graphics_LMDSW, StdCtrls_LMDSW;


{ Type wrappers }

type
  TShape_sw = class;
  TPaintBox_sw = class;
  TImage_sw = class;
  TBevel_sw = class;
  TTimer_sw = class;
  TCustomPanel_sw = class;
  TPanel_sw = class;
  TPage_sw = class;
  TNotebook_sw = class;
  THeader_sw = class;
  TCustomRadioGroup_sw = class;
  TRadioGroup_sw = class;
  TSplitter_sw = class;
  TCustomControlBar_sw = class;
  TControlBar_sw = class;
  TBoundLabel_sw = class;
  TCustomLabeledEdit_sw = class;
  TLabeledEdit_sw = class;
  TCustomColorBox_sw = class;
  TColorBox_sw = class;
  TCustomColorListBox_sw = class;
  TColorListBox_sw = class;

  TShapeType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TShapeType): OleVariant;
    class function FromVar(const AValue: OleVariant): TShapeType;
  end;

  TShape_sc = class of TShape;
  TShape_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TShape): OleVariant;
    class function FromVar(const AValue: OleVariant): TShape;
    class function ClassToVar(AClass: TShape_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TShape_sc;
  end;

  TPaintBox_sc = class of TPaintBox;
  TPaintBox_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPaintBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TPaintBox;
    class function ClassToVar(AClass: TPaintBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPaintBox_sc;
  end;

  TImage_sc = class of TImage;
  TImage_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TImage;
    class function ClassToVar(AClass: TImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TImage_sc;
  end;

  TBevelStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBevelStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelStyle;
  end;

  TBevelShape_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBevelShape): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelShape;
  end;

  TBevel_sc = class of TBevel;
  TBevel_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBevel): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevel;
    class function ClassToVar(AClass: TBevel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBevel_sc;
  end;

  TTimer_sc = class of TTimer;
  TTimer_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTimer): OleVariant;
    class function FromVar(const AValue: OleVariant): TTimer;
    class function ClassToVar(AClass: TTimer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTimer_sc;
  end;

  TPanelBevel_sw = TBevelCut_sw;

  TCustomPanel_sc = class of TCustomPanel;
  TCustomPanel_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomPanel): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomPanel;
    class function ClassToVar(AClass: TCustomPanel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomPanel_sc;
  end;

  TPanel_sc = class of TPanel;
  TPanel_sw = class(TCustomPanel_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPanel): OleVariant;
    class function FromVar(const AValue: OleVariant): TPanel;
    class function ClassToVar(AClass: TPanel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPanel_sc;
  end;

  TPage_sc = class of TPage;
  TPage_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPage): OleVariant;
    class function FromVar(const AValue: OleVariant): TPage;
    class function ClassToVar(AClass: TPage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPage_sc;
  end;

  TNotebook_sc = class of TNotebook;
  TNotebook_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNotebook): OleVariant;
    class function FromVar(const AValue: OleVariant): TNotebook;
    class function ClassToVar(AClass: TNotebook_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNotebook_sc;
  end;

  TSectionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ASection: Integer; AWidth: Integer);
  end;

  TSectionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSectionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSectionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSectionEvent;
  end;

  THeader_sc = class of THeader;
  THeader_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THeader): OleVariant;
    class function FromVar(const AValue: OleVariant): THeader;
    class function ClassToVar(AClass: THeader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THeader_sc;
  end;

  TCustomRadioGroup_sc = class of TCustomRadioGroup;
  TCustomRadioGroup_sw = class(TCustomGroupBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomRadioGroup): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomRadioGroup;
    class function ClassToVar(AClass: TCustomRadioGroup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomRadioGroup_sc;
  end;

  TRadioGroup_sc = class of TRadioGroup;
  TRadioGroup_sw = class(TCustomRadioGroup_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TRadioGroup): OleVariant;
    class function FromVar(const AValue: OleVariant): TRadioGroup;
    class function ClassToVar(AClass: TRadioGroup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TRadioGroup_sc;
  end;

  NaturalNumber_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: NaturalNumber): OleVariant;
    class function FromVar(const AValue: OleVariant): NaturalNumber;
  end;

  TSplitterCanResizeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
  end;

  TSplitterCanResizeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSplitterCanResizeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSplitterCanResizeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSplitterCanResizeEvent;
  end;

  TCanResizeEvent_sw = TSplitterCanResizeEvent_sw;

  TResizeStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TResizeStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TResizeStyle;
  end;

  TSplitter_sc = class of TSplitter;
  TSplitter_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSplitter): OleVariant;
    class function FromVar(const AValue: OleVariant): TSplitter;
    class function ClassToVar(AClass: TSplitter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSplitter_sc;
  end;

  TBandPaintOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBandPaintOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandPaintOption;
  end;

  TBandPaintOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TBandPaintOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandPaintOptions;
  end;

  TBandDragEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl; var Drag: Boolean);
  end;

  TBandDragEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBandDragEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandDragEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBandDragEvent;
  end;

  TBandInfoEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl; var Insets: TRect;
      var PreferredSize: Integer; var RowCount: Integer);
  end;

  TBandInfoEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBandInfoEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandInfoEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBandInfoEvent;
  end;

  TBandMoveEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl; var ARect: TRect);
  end;

  TBandMoveEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBandMoveEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandMoveEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBandMoveEvent;
  end;

  TBeginBandMoveEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl;
      var AllowMove: Boolean);
  end;

  TBeginBandMoveEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBeginBandMoveEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBeginBandMoveEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBeginBandMoveEvent;
  end;

  TEndBandMoveEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl);
  end;

  TEndBandMoveEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TEndBandMoveEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TEndBandMoveEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TEndBandMoveEvent;
  end;

  TBandPaintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Control: TControl; Canvas: TCanvas;
      var ARect: TRect; var Options: TBandPaintOptions);
  end;

  TBandPaintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBandPaintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBandPaintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBandPaintEvent;
  end;

  TRowSize_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRowSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TRowSize;
  end;

  TCustomControlBar_sc = class of TCustomControlBar;
  TCustomControlBar_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomControlBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomControlBar;
    class function ClassToVar(AClass: TCustomControlBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomControlBar_sc;
  end;

  TControlBar_sc = class of TControlBar;
  TControlBar_sw = class(TCustomControlBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControlBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlBar;
    class function ClassToVar(AClass: TControlBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControlBar_sc;
  end;

  TBoundLabel_sc = class of TBoundLabel;
  TBoundLabel_sw = class(TCustomLabel_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBoundLabel): OleVariant;
    class function FromVar(const AValue: OleVariant): TBoundLabel;
    class function ClassToVar(AClass: TBoundLabel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBoundLabel_sc;
  end;

  TLabelPosition_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TLabelPosition): OleVariant;
    class function FromVar(const AValue: OleVariant): TLabelPosition;
  end;

  TCustomLabeledEdit_sc = class of TCustomLabeledEdit;
  TCustomLabeledEdit_sw = class(TCustomEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomLabeledEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomLabeledEdit;
    class function ClassToVar(AClass: TCustomLabeledEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomLabeledEdit_sc;
  end;

  TLabeledEdit_sc = class of TLabeledEdit;
  TLabeledEdit_sw = class(TCustomLabeledEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLabeledEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TLabeledEdit;
    class function ClassToVar(AClass: TLabeledEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLabeledEdit_sc;
  end;

  TColorBoxStyles_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColorBoxStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorBoxStyles;
  end;

  TColorBoxStyle_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TColorBoxStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorBoxStyle;
  end;

  TGetColorsEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomColorBox; Items: TStrings);
  end;

  TGetColorsEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetColorsEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetColorsEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetColorsEvent;
  end;

  TCustomColorBox_sc = class of TCustomColorBox;
  TCustomColorBox_sw = class(TCustomComboBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomColorBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomColorBox;
    class function ClassToVar(AClass: TCustomColorBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomColorBox_sc;
  end;

  TColorBox_sc = class of TColorBox;
  TColorBox_sw = class(TCustomColorBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColorBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorBox;
    class function ClassToVar(AClass: TColorBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColorBox_sc;
  end;

  TLBGetColorsEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomColorListBox; Items: TStrings);
  end;

  TLBGetColorsEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLBGetColorsEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLBGetColorsEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLBGetColorsEvent;
  end;

  TCustomColorListBox_sc = class of TCustomColorListBox;
  TCustomColorListBox_sw = class(TCustomListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomColorListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomColorListBox;
    class function ClassToVar(AClass: TCustomColorListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomColorListBox_sc;
  end;

  TColorListBox_sc = class of TColorListBox;
  TColorListBox_sw = class(TCustomColorListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColorListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorListBox;
    class function ClassToVar(AClass: TColorListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColorListBox_sc;
  end;


{ Unit wrapper }

type
  ExtCtrls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomPanel_sacc = class(TCustomPanel);
  TCustomRadioGroup_sacc = class(TCustomRadioGroup);
  TCustomControlBar_sacc = class(TCustomControlBar);

{ TShapeType_sw }

class function TShapeType_sw.GetTypeName: WideString;
begin
  Result := 'TShapeType';
end;

class procedure TShapeType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'stRectangle'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stRectangle)),
    (Name: 'stSquare'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stSquare)),
    (Name: 'stRoundRect'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stRoundRect)),
    (Name: 'stRoundSquare'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stRoundSquare)),
    (Name: 'stEllipse'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stEllipse)),
    (Name: 'stCircle'; Value: Integer({$IFDEF LMDSCT_12}TShapeType.{$ENDIF}stCircle))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TShapeType_sw.ToVar(const AValue: TShapeType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TShapeType_sw.FromVar(const AValue: OleVariant): TShapeType;
begin
  Result := TShapeType(Integer(AValue));
end;

{ TShape_sw }

function TShape_StyleChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StyleChanged(Sender: TObject);

  TShape(AObj).StyleChanged(TObject_sw.FromVar(AArgs[0]));
end;

function TShape_Brush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Brush: TBrush read <getter> write <setter>;

  if IsGet then
    Result := TBrush_sw.ToVar(TShape(AObj).Brush)
  else
    TShape(AObj).Brush := TBrush_sw.FromVar(AArgs[0]);
end;

function TShape_Pen_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Pen: TPen read <getter> write <setter>;

  if IsGet then
    Result := TPen_sw.ToVar(TShape(AObj).Pen)
  else
    TShape(AObj).Pen := TPen_sw.FromVar(AArgs[0]);
end;

function TShape_Shape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Shape: TShapeType read <getter> write <setter>;

  if IsGet then
    Result := TShapeType_sw.ToVar(TShape(AObj).Shape)
  else
    TShape(AObj).Shape := TShapeType_sw.FromVar(AArgs[0]);
end;

class function TShape_sw.GetTypeName: WideString;
begin
  Result := 'TShape';
end;

class function TShape_sw.GetWrappedClass: TClass;
begin
  Result := TShape;
end;

class procedure TShape_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('StyleChanged', TShape_StyleChanged_si, 1, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('Brush', TShape_Brush_si, TBrush_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('Pen', TShape_Pen_si, TPen_sw, True, True, 0, False, False);
  AData.AddProperty('Shape', TShape_Shape_si, TShapeType_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TShape_sw.ToVar(const AValue: TShape): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TShape_sw.FromVar(const AValue: OleVariant): TShape;
begin
  Result := TShape(ConvFromVar(AValue, TShape));
end;

class function TShape_sw.ClassToVar(AClass: TShape_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TShape_sw.ClassFromVar(const AClass: OleVariant): TShape_sc;
begin
  Result := TShape_sc(ConvClsFromVar(AClass, TShape));
end;

{ TPaintBox_sw }

function TPaintBox_OnPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPaint: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TPaintBox(AObj).OnPaint)
  else
    TPaintBox(AObj).OnPaint := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TPaintBox_sw.GetTypeName: WideString;
begin
  Result := 'TPaintBox';
end;

class function TPaintBox_sw.GetWrappedClass: TClass;
begin
  Result := TPaintBox;
end;

class procedure TPaintBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddProperty('OnPaint', TPaintBox_OnPaint_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TPaintBox_sw.ToVar(const AValue: TPaintBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPaintBox_sw.FromVar(const AValue: OleVariant): TPaintBox;
begin
  Result := TPaintBox(ConvFromVar(AValue, TPaintBox));
end;

class function TPaintBox_sw.ClassToVar(AClass: TPaintBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPaintBox_sw.ClassFromVar(
  const AClass: OleVariant): TPaintBox_sc;
begin
  Result := TPaintBox_sc(ConvClsFromVar(AClass, TPaintBox));
end;

{ TImage_sw }

function TImage_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TImage(AObj).Canvas);
end;

function TImage_Center_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Center: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImage(AObj).Center
  else
    TImage(AObj).Center := Boolean(AArgs[0]);
end;

function TImage_IncrementalDisplay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IncrementalDisplay: Boolean read <getter> write ...

  if IsGet then
    Result := TImage(AObj).IncrementalDisplay
  else
    TImage(AObj).IncrementalDisplay := Boolean(AArgs[0]);
end;

function TImage_Picture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Picture: TPicture read <getter> write <setter>;

  if IsGet then
    Result := TPicture_sw.ToVar(TImage(AObj).Picture)
  else
    TImage(AObj).Picture := TPicture_sw.FromVar(AArgs[0]);
end;

function TImage_Proportional_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Proportional: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImage(AObj).Proportional
  else
    TImage(AObj).Proportional := Boolean(AArgs[0]);
end;

function TImage_Stretch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Stretch: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImage(AObj).Stretch
  else
    TImage(AObj).Stretch := Boolean(AArgs[0]);
end;

function TImage_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImage(AObj).Transparent
  else
    TImage(AObj).Transparent := Boolean(AArgs[0]);
end;

class function TImage_sw.GetTypeName: WideString;
begin
  Result := 'TImage';
end;

class function TImage_sw.GetWrappedClass: TClass;
begin
  Result := TImage;
end;

class procedure TImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TImage_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddProperty('Center', TImage_Center_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('IncrementalDisplay', TImage_IncrementalDisplay_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('Picture', TImage_Picture_si, TPicture_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Proportional', TImage_Proportional_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Stretch', TImage_Stretch_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Transparent', TImage_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TImage_sw.ToVar(const AValue: TImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TImage_sw.FromVar(const AValue: OleVariant): TImage;
begin
  Result := TImage(ConvFromVar(AValue, TImage));
end;

class function TImage_sw.ClassToVar(AClass: TImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TImage_sw.ClassFromVar(const AClass: OleVariant): TImage_sc;
begin
  Result := TImage_sc(ConvClsFromVar(AClass, TImage));
end;

{ TBevelStyle_sw }

class function TBevelStyle_sw.GetTypeName: WideString;
begin
  Result := 'TBevelStyle';
end;

class procedure TBevelStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'bsLowered'; Value: Integer({$IFDEF LMDSCT_12}TBevelStyle.{$ENDIF}bsLowered)),
    (Name: 'bsRaised'; Value: Integer({$IFDEF LMDSCT_12}TBevelStyle.{$ENDIF}bsRaised))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TBevelStyle_sw.ToVar(const AValue: TBevelStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelStyle_sw.FromVar(const AValue: OleVariant): TBevelStyle;
begin
  Result := TBevelStyle(Integer(AValue));
end;

{ TBevelShape_sw }

class function TBevelShape_sw.GetTypeName: WideString;
begin
  Result := 'TBevelShape';
end;

class procedure TBevelShape_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'bsBox'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsBox)),
    (Name: 'bsFrame'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsFrame)),
    (Name: 'bsTopLine'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsTopLine)),
    (Name: 'bsBottomLine'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsBottomLine)),
    (Name: 'bsLeftLine'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsLeftLine)),
    (Name: 'bsRightLine'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsRightLine)),
    (Name: 'bsSpacer'; Value: Integer({$IFDEF LMDSCT_12}TBevelShape.{$ENDIF}bsSpacer))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TBevelShape_sw.ToVar(const AValue: TBevelShape): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelShape_sw.FromVar(const AValue: OleVariant): TBevelShape;
begin
  Result := TBevelShape(Integer(AValue));
end;

{ TBevel_sw }

function TBevel_Shape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Shape: TBevelShape read <getter> write <setter>;

  if IsGet then
    Result := TBevelShape_sw.ToVar(TBevel(AObj).Shape)
  else
    TBevel(AObj).Shape := TBevelShape_sw.FromVar(AArgs[0]);
end;

function TBevel_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TBevelStyle read <getter> write <setter>;

  if IsGet then
    Result := TBevelStyle_sw.ToVar(TBevel(AObj).Style)
  else
    TBevel(AObj).Style := TBevelStyle_sw.FromVar(AArgs[0]);
end;

class function TBevel_sw.GetTypeName: WideString;
begin
  Result := 'TBevel';
end;

class function TBevel_sw.GetWrappedClass: TClass;
begin
  Result := TBevel;
end;

class procedure TBevel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('Shape', TBevel_Shape_si, TBevelShape_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Style', TBevel_Style_si, TBevelStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
end;

class function TBevel_sw.ToVar(const AValue: TBevel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBevel_sw.FromVar(const AValue: OleVariant): TBevel;
begin
  Result := TBevel(ConvFromVar(AValue, TBevel));
end;

class function TBevel_sw.ClassToVar(AClass: TBevel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBevel_sw.ClassFromVar(const AClass: OleVariant): TBevel_sc;
begin
  Result := TBevel_sc(ConvClsFromVar(AClass, TBevel));
end;

{ TTimer_sw }

function TTimer_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTimer(AObj).Enabled
  else
    TTimer(AObj).Enabled := Boolean(AArgs[0]);
end;

function TTimer_Interval_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Interval: Cardinal read <getter> write <setter>;

  if IsGet then
    Result := TTimer(AObj).Interval
  else
    TTimer(AObj).Interval := Cardinal(AArgs[0]);
end;

function TTimer_OnTimer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTimer: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TTimer(AObj).OnTimer)
  else
    TTimer(AObj).OnTimer := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TTimer_sw.GetTypeName: WideString;
begin
  Result := 'TTimer';
end;

class function TTimer_sw.GetWrappedClass: TClass;
begin
  Result := TTimer;
end;

class procedure TTimer_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Enabled', TTimer_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Interval', TTimer_Interval_si, Cardinal_sw, True, True, 0, False, False);
  AData.AddProperty('OnTimer', TTimer_OnTimer_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TTimer_sw.ToVar(const AValue: TTimer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTimer_sw.FromVar(const AValue: OleVariant): TTimer;
begin
  Result := TTimer(ConvFromVar(AValue, TTimer));
end;

class function TTimer_sw.ClassToVar(AClass: TTimer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTimer_sw.ClassFromVar(const AClass: OleVariant): TTimer_sc;
begin
  Result := TTimer_sc(ConvClsFromVar(AClass, TTimer));
end;

{ TCustomPanel_sw }

function TCustomPanel_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Alignment: TAlignment read <getter> wr...

  if IsGet then
    Result := TAlignment_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      Alignment)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).Alignment := TAlignment_sw.FromVar(
      AArgs[0]);
end;

function TCustomPanel_BevelInner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelInner: TPanelBevel read <getter> ...

  if IsGet then
    Result := TPanelBevel_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      BevelInner)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).BevelInner := TPanelBevel_sw.FromVar(
      AArgs[0]);
end;

function TCustomPanel_BevelOuter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelOuter: TPanelBevel read <getter> ...

  if IsGet then
    Result := TPanelBevel_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      BevelOuter)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).BevelOuter := TPanelBevel_sw.FromVar(
      AArgs[0]);
end;

function TCustomPanel_BevelWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelWidth: TBevelWidth read <getter> ...

  if IsGet then
    Result := TBevelWidth_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      BevelWidth)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).BevelWidth := TBevelWidth_sw.FromVar(
      AArgs[0]);
end;

function TCustomPanel_BorderWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderWidth: TBorderWidth read <getter...

  if IsGet then
    Result := TBorderWidth_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      BorderWidth)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).BorderWidth := TBorderWidth_sw.
      FromVar(AArgs[0]);
end;

function TCustomPanel_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomPanel_sacc(TCustomPanel(AObj)).
      BorderStyle)
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).BorderStyle := TBorderStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomPanel_FullRepaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FullRepaint: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomPanel_sacc(TCustomPanel(AObj)).FullRepaint
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).FullRepaint := Boolean(AArgs[0]);
end;

function TCustomPanel_Locked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Locked: Boolean read <getter> write <s...

  if IsGet then
    Result := TCustomPanel_sacc(TCustomPanel(AObj)).Locked
  else
    TCustomPanel_sacc(TCustomPanel(AObj)).Locked := Boolean(AArgs[0]);
end;

class function TCustomPanel_sw.GetTypeName: WideString;
begin
  Result := 'TCustomPanel';
end;

class function TCustomPanel_sw.GetWrappedClass: TClass;
begin
  Result := TCustomPanel;
end;

class procedure TCustomPanel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TCustomPanel_Alignment_si, TAlignment_sw, True, True, 0, True, False);
  AData.AddProperty('BevelInner', TCustomPanel_BevelInner_si, TPanelBevel_sw, True, True, 0, True, False);
  AData.AddProperty('BevelOuter', TCustomPanel_BevelOuter_si, TPanelBevel_sw, True, True, 0, True, False);
  AData.AddProperty('BevelWidth', TCustomPanel_BevelWidth_si, TBevelWidth_sw, True, True, 0, True, False);
  AData.AddProperty('BorderWidth', TCustomPanel_BorderWidth_si, TBorderWidth_sw, True, True, 0, True, False);
  AData.AddProperty('BorderStyle', TCustomPanel_BorderStyle_si, TBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('FullRepaint', TCustomPanel_FullRepaint_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Locked', TCustomPanel_Locked_si, Boolean_sw, True, True, 0, True, False);
  AData.AddPropertyRedecl('ParentBackground', False);
end;

class function TCustomPanel_sw.ToVar(const AValue: TCustomPanel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomPanel_sw.FromVar(const AValue: OleVariant): TCustomPanel;
begin
  Result := TCustomPanel(ConvFromVar(AValue, TCustomPanel));
end;

class function TCustomPanel_sw.ClassToVar(AClass: TCustomPanel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomPanel_sw.ClassFromVar(
  const AClass: OleVariant): TCustomPanel_sc;
begin
  Result := TCustomPanel_sc(ConvClsFromVar(AClass, TCustomPanel));
end;

{ TPanel_sw }

class function TPanel_sw.GetTypeName: WideString;
begin
  Result := 'TPanel';
end;

class function TPanel_sw.GetWrappedClass: TClass;
begin
  Result := TPanel;
end;

class procedure TPanel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('DockManager', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('UseDockManager', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('FullRepaint', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Locked', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('VerticalAlignment', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TPanel_sw.ToVar(const AValue: TPanel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPanel_sw.FromVar(const AValue: OleVariant): TPanel;
begin
  Result := TPanel(ConvFromVar(AValue, TPanel));
end;

class function TPanel_sw.ClassToVar(AClass: TPanel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPanel_sw.ClassFromVar(const AClass: OleVariant): TPanel_sc;
begin
  Result := TPanel_sc(ConvClsFromVar(AClass, TPanel));
end;

{ TPage_sw }

class function TPage_sw.GetTypeName: WideString;
begin
  Result := 'TPage';
end;

class function TPage_sw.GetWrappedClass: TClass;
begin
  Result := TPage;
end;

class procedure TPage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
end;

class function TPage_sw.ToVar(const AValue: TPage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPage_sw.FromVar(const AValue: OleVariant): TPage;
begin
  Result := TPage(ConvFromVar(AValue, TPage));
end;

class function TPage_sw.ClassToVar(AClass: TPage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPage_sw.ClassFromVar(const AClass: OleVariant): TPage_sc;
begin
  Result := TPage_sc(ConvClsFromVar(AClass, TPage));
end;

{ TNotebook_sw }

function TNotebook_ActivePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActivePage: string read <getter> write <setter>;

  if IsGet then
    Result := TNotebook(AObj).ActivePage
  else
    TNotebook(AObj).ActivePage := string(AArgs[0]);
end;

function TNotebook_PageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TNotebook(AObj).PageIndex
  else
    TNotebook(AObj).PageIndex := Integer(AArgs[0]);
end;

function TNotebook_Pages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pages: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TNotebook(AObj).Pages)
  else
    TNotebook(AObj).Pages := TStrings_sw.FromVar(AArgs[0]);
end;

function TNotebook_OnPageChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPageChanged: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TNotebook(AObj).OnPageChanged)
  else
    TNotebook(AObj).OnPageChanged := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TNotebook_sw.GetTypeName: WideString;
begin
  Result := 'TNotebook';
end;

class function TNotebook_sw.GetWrappedClass: TClass;
begin
  Result := TNotebook;
end;

class procedure TNotebook_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActivePage', TNotebook_ActivePage_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('PageIndex', TNotebook_PageIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Pages', TNotebook_Pages_si, TStrings_sw, True, True, 0, False, False);
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
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddProperty('OnPageChanged', TNotebook_OnPageChanged_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TNotebook_sw.ToVar(const AValue: TNotebook): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNotebook_sw.FromVar(const AValue: OleVariant): TNotebook;
begin
  Result := TNotebook(ConvFromVar(AValue, TNotebook));
end;

class function TNotebook_sw.ClassToVar(AClass: TNotebook_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNotebook_sw.ClassFromVar(
  const AClass: OleVariant): TNotebook_sc;
begin
  Result := TNotebook_sc(ConvClsFromVar(AClass, TNotebook));
end;

{ TSectionEvent_sh }

function TSectionEvent_sh.GetHandler: TMethod;
var
  hdr: TSectionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSectionEvent_sh.Handler(Sender: TObject; ASection: Integer;
  AWidth: Integer);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; ASection: Integer; AWidth: In...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := ASection;
  args[2] := AWidth;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TSectionEvent_sw }

class function TSectionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSectionEvent';
end;

class function TSectionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSectionEvent_sh;
end;

class function TSectionEvent_sw.ToVar(const AValue: TSectionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSectionEvent_sw.FromVar(
  const AValue: OleVariant): TSectionEvent;
begin
  Result := TSectionEvent(ConvFromVar(AValue));
end;

class function TSectionEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TSectionEvent;
var
  hdlr: TSectionEvent_sh;
begin
  hdlr   := TSectionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSectionEvent_sw));
  Result := hdlr.Handler;
end;

{ THeader_sw }

function THeader_SectionWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SectionWidth[X: Integer]: Integer read <getter> ...

  if IsGet then
    Result := THeader(AObj).SectionWidth[Integer(AArgs[0])]
  else
    THeader(AObj).SectionWidth[Integer(AArgs[0])] := Integer(AArgs[1]);
end;

function THeader_AllowResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowResize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeader(AObj).AllowResize
  else
    THeader(AObj).AllowResize := Boolean(AArgs[0]);
end;

function THeader_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TBorderStyle read <getter> write <s...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(THeader(AObj).BorderStyle)
  else
    THeader(AObj).BorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

function THeader_Sections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sections: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(THeader(AObj).Sections)
  else
    THeader(AObj).Sections := TStrings_sw.FromVar(AArgs[0]);
end;

function THeader_OnSizing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSizing: TSectionEvent read <getter> write <set...

  if IsGet then
    Result := TSectionEvent_sw.ToVar(THeader(AObj).OnSizing)
  else
    THeader(AObj).OnSizing := TSectionEvent_sw.FromVar(AArgs[0]);
end;

function THeader_OnSized_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSized: TSectionEvent read <getter> write <sett...

  if IsGet then
    Result := TSectionEvent_sw.ToVar(THeader(AObj).OnSized)
  else
    THeader(AObj).OnSized := TSectionEvent_sw.FromVar(AArgs[0]);
end;

class function THeader_sw.GetTypeName: WideString;
begin
  Result := 'THeader';
end;

class function THeader_sw.GetWrappedClass: TClass;
begin
  Result := THeader;
end;

class procedure THeader_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('SectionWidth', THeader_SectionWidth_si, Integer_sw, True, True, 1, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddProperty('AllowResize', THeader_AllowResize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('BorderStyle', THeader_BorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Sections', THeader_Sections_si, TStrings_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddProperty('OnSizing', THeader_OnSizing_si, TSectionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSized', THeader_OnSized_si, TSectionEvent_sw, True, True, 0, False, False);
end;

class function THeader_sw.ToVar(const AValue: THeader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THeader_sw.FromVar(const AValue: OleVariant): THeader;
begin
  Result := THeader(ConvFromVar(AValue, THeader));
end;

class function THeader_sw.ClassToVar(AClass: THeader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THeader_sw.ClassFromVar(const AClass: OleVariant): THeader_sc;
begin
  Result := THeader_sc(ConvClsFromVar(AClass, THeader));
end;

{ TCustomRadioGroup_sw }

function TCustomRadioGroup_Columns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Columns: Integer read <getter> write <...

  if IsGet then
    Result := TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).Columns
  else
    TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).Columns := Integer(
      AArgs[0]);
end;

function TCustomRadioGroup_ItemIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ItemIndex: Integer read <getter> write...

  if IsGet then
    Result := TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).ItemIndex
  else
    TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).ItemIndex := Integer(
      AArgs[0]);
end;

function TCustomRadioGroup_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Items: TStrings read <getter> write <s...

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).
      Items)
  else
    TCustomRadioGroup_sacc(TCustomRadioGroup(AObj)).Items := TStrings_sw.
      FromVar(AArgs[0]);
end;

function TCustomRadioGroup_Buttons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Buttons[Index: Integer]: TRadioButton read <gett...

  Result := TRadioButton_sw.ToVar(TCustomRadioGroup(AObj).Buttons[Integer(
    AArgs[0])]);
end;

class function TCustomRadioGroup_sw.GetTypeName: WideString;
begin
  Result := 'TCustomRadioGroup';
end;

class function TCustomRadioGroup_sw.GetWrappedClass: TClass;
begin
  Result := TCustomRadioGroup;
end;

class procedure TCustomRadioGroup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Columns', TCustomRadioGroup_Columns_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('ItemIndex', TCustomRadioGroup_ItemIndex_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Items', TCustomRadioGroup_Items_si, TStrings_sw, True, True, 0, True, False);
  AData.AddProperty('Buttons', TCustomRadioGroup_Buttons_si, TRadioButton_sw, True, False, 1, False, False);
end;

class function TCustomRadioGroup_sw.ToVar(
  const AValue: TCustomRadioGroup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomRadioGroup_sw.FromVar(
  const AValue: OleVariant): TCustomRadioGroup;
begin
  Result := TCustomRadioGroup(ConvFromVar(AValue, TCustomRadioGroup));
end;

class function TCustomRadioGroup_sw.ClassToVar(
  AClass: TCustomRadioGroup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomRadioGroup_sw.ClassFromVar(
  const AClass: OleVariant): TCustomRadioGroup_sc;
begin
  Result := TCustomRadioGroup_sc(ConvClsFromVar(AClass, TCustomRadioGroup));
end;

{ TRadioGroup_sw }

class function TRadioGroup_sw.GetTypeName: WideString;
begin
  Result := 'TRadioGroup';
end;

class function TRadioGroup_sw.GetWrappedClass: TClass;
begin
  Result := TRadioGroup;
end;

class procedure TRadioGroup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ItemIndex', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentBackground', False);
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
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TRadioGroup_sw.ToVar(const AValue: TRadioGroup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TRadioGroup_sw.FromVar(const AValue: OleVariant): TRadioGroup;
begin
  Result := TRadioGroup(ConvFromVar(AValue, TRadioGroup));
end;

class function TRadioGroup_sw.ClassToVar(AClass: TRadioGroup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TRadioGroup_sw.ClassFromVar(
  const AClass: OleVariant): TRadioGroup_sc;
begin
  Result := TRadioGroup_sc(ConvClsFromVar(AClass, TRadioGroup));
end;

{ NaturalNumber_sw }

class function NaturalNumber_sw.GetTypeName: WideString;
begin
  Result := 'NaturalNumber';
end;

class function NaturalNumber_sw.ToVar(const AValue: NaturalNumber): OleVariant;
begin
  Result := Integer(AValue);
end;

class function NaturalNumber_sw.FromVar(
  const AValue: OleVariant): NaturalNumber;
begin
  Result := NaturalNumber(Integer(AValue));
end;

{ TSplitterCanResizeEvent_sh }

function TSplitterCanResizeEvent_sh.GetHandler: TMethod;
var
  hdr: TSplitterCanResizeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSplitterCanResizeEvent_sh.Handler(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Sender: TObject; var NewSize: Integer; var Acc...

  v_1 := NewSize;
  v_2 := Accept;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  args[2] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  NewSize := Integer(v_1);
  Accept := Boolean(v_2);
end;

{ TSplitterCanResizeEvent_sw }

class function TSplitterCanResizeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSplitterCanResizeEvent';
end;

class function TSplitterCanResizeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSplitterCanResizeEvent_sh;
end;

class function TSplitterCanResizeEvent_sw.ToVar(
  const AValue: TSplitterCanResizeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSplitterCanResizeEvent_sw.FromVar(
  const AValue: OleVariant): TSplitterCanResizeEvent;
begin
  Result := TSplitterCanResizeEvent(ConvFromVar(AValue));
end;

class function TSplitterCanResizeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TSplitterCanResizeEvent;
var
  hdlr: TSplitterCanResizeEvent_sh;
begin
  hdlr   := TSplitterCanResizeEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TSplitterCanResizeEvent_sw));
  Result := hdlr.Handler;
end;

{ TResizeStyle_sw }

class function TResizeStyle_sw.GetTypeName: WideString;
begin
  Result := 'TResizeStyle';
end;

class procedure TResizeStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'rsNone'; Value: Integer({$IFDEF LMDSCT_12}TResizeStyle.{$ENDIF}rsNone)),
    (Name: 'rsLine'; Value: Integer({$IFDEF LMDSCT_12}TResizeStyle.{$ENDIF}rsLine)),
    (Name: 'rsUpdate'; Value: Integer({$IFDEF LMDSCT_12}TResizeStyle.{$ENDIF}rsUpdate)),
    (Name: 'rsPattern'; Value: Integer({$IFDEF LMDSCT_12}TResizeStyle.{$ENDIF}rsPattern))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TResizeStyle_sw.ToVar(const AValue: TResizeStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TResizeStyle_sw.FromVar(const AValue: OleVariant): TResizeStyle;
begin
  Result := TResizeStyle(Integer(AValue));
end;

{ TSplitter_sw }

function TSplitter_AutoSnap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSnap: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSplitter(AObj).AutoSnap
  else
    TSplitter(AObj).AutoSnap := Boolean(AArgs[0]);
end;

function TSplitter_Beveled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Beveled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSplitter(AObj).Beveled
  else
    TSplitter(AObj).Beveled := Boolean(AArgs[0]);
end;

function TSplitter_MinSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinSize: NaturalNumber read <getter> write <sett...

  if IsGet then
    Result := NaturalNumber_sw.ToVar(TSplitter(AObj).MinSize)
  else
    TSplitter(AObj).MinSize := NaturalNumber_sw.FromVar(AArgs[0]);
end;

function TSplitter_ResizeStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResizeStyle: TResizeStyle read <getter> write <s...

  if IsGet then
    Result := TResizeStyle_sw.ToVar(TSplitter(AObj).ResizeStyle)
  else
    TSplitter(AObj).ResizeStyle := TResizeStyle_sw.FromVar(AArgs[0]);
end;

function TSplitter_OnCanResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCanResize: TCanResizeEvent read <getter> write...

  if IsGet then
    Result := TCanResizeEvent_sw.ToVar(TSplitter(AObj).OnCanResize)
  else
    TSplitter(AObj).OnCanResize := TCanResizeEvent_sw.FromVar(AArgs[0]);
end;

function TSplitter_OnMoved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMoved: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TSplitter(AObj).OnMoved)
  else
    TSplitter(AObj).OnMoved := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TSplitter_OnPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPaint: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TSplitter(AObj).OnPaint)
  else
    TSplitter(AObj).OnPaint := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TSplitter_sw.GetTypeName: WideString;
begin
  Result := 'TSplitter';
end;

class function TSplitter_sw.GetWrappedClass: TClass;
begin
  Result := TSplitter;
end;

class procedure TSplitter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddProperty('AutoSnap', TSplitter_AutoSnap_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Beveled', TSplitter_Beveled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Cursor', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('MinSize', TSplitter_MinSize_si, NaturalNumber_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddProperty('ResizeStyle', TSplitter_ResizeStyle_si, TResizeStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddProperty('OnCanResize', TSplitter_OnCanResize_si, TCanResizeEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMoved', TSplitter_OnMoved_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnPaint', TSplitter_OnPaint_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TSplitter_sw.ToVar(const AValue: TSplitter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSplitter_sw.FromVar(const AValue: OleVariant): TSplitter;
begin
  Result := TSplitter(ConvFromVar(AValue, TSplitter));
end;

class function TSplitter_sw.ClassToVar(AClass: TSplitter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSplitter_sw.ClassFromVar(
  const AClass: OleVariant): TSplitter_sc;
begin
  Result := TSplitter_sc(ConvClsFromVar(AClass, TSplitter));
end;

{ TBandPaintOption_sw }

class function TBandPaintOption_sw.GetTypeName: WideString;
begin
  Result := 'TBandPaintOption';
end;

class procedure TBandPaintOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'bpoGrabber'; Value: Integer({$IFDEF LMDSCT_12}TBandPaintOption.{$ENDIF}bpoGrabber)),
    (Name: 'bpoFrame'; Value: Integer({$IFDEF LMDSCT_12}TBandPaintOption.{$ENDIF}bpoFrame))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TBandPaintOption_sw.ToVar(
  const AValue: TBandPaintOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBandPaintOption_sw.FromVar(
  const AValue: OleVariant): TBandPaintOption;
begin
  Result := TBandPaintOption(Integer(AValue));
end;

{ TBandPaintOptions_sw }

class function TBandPaintOptions_sw.GetTypeName: WideString;
begin
  Result := 'TBandPaintOptions';
end;

class function TBandPaintOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TBandPaintOptions);
end;

class function TBandPaintOptions_sw.ToVar(
  const AValue: TBandPaintOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TBandPaintOptions_sw.FromVar(
  const AValue: OleVariant): TBandPaintOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TBandDragEvent_sh }

function TBandDragEvent_sh.GetHandler: TMethod;
var
  hdr: TBandDragEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBandDragEvent_sh.Handler(Sender: TObject; Control: TControl;
  var Drag: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl; var Drag: ...

  v_1 := Drag;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Drag := Boolean(v_1);
end;

{ TBandDragEvent_sw }

class function TBandDragEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBandDragEvent';
end;

class function TBandDragEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBandDragEvent_sh;
end;

class function TBandDragEvent_sw.ToVar(
  const AValue: TBandDragEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBandDragEvent_sw.FromVar(
  const AValue: OleVariant): TBandDragEvent;
begin
  Result := TBandDragEvent(ConvFromVar(AValue));
end;

class function TBandDragEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TBandDragEvent;
var
  hdlr: TBandDragEvent_sh;
begin
  hdlr   := TBandDragEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBandDragEvent_sw));
  Result := hdlr.Handler;
end;

{ TBandInfoEvent_sh }

function TBandInfoEvent_sh.GetHandler: TMethod;
var
  hdr: TBandInfoEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBandInfoEvent_sh.Handler(Sender: TObject; Control: TControl;
  var Insets: TRect; var PreferredSize: Integer; var RowCount: Integer);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl; var Insets...

  v_1 := TRect_sw.ToVar(Insets);
  v_2 := PreferredSize;
  v_3 := RowCount;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := MakeVarRef(v_1);
  args[3] := MakeVarRef(v_2);
  args[4] := MakeVarRef(v_3);
  Self.Owner.RunProc(Self.ProcName, args);
  Insets := TRect_sw.FromVar(v_1);
  PreferredSize := Integer(v_2);
  RowCount := Integer(v_3);
end;

{ TBandInfoEvent_sw }

class function TBandInfoEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBandInfoEvent';
end;

class function TBandInfoEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBandInfoEvent_sh;
end;

class function TBandInfoEvent_sw.ToVar(
  const AValue: TBandInfoEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBandInfoEvent_sw.FromVar(
  const AValue: OleVariant): TBandInfoEvent;
begin
  Result := TBandInfoEvent(ConvFromVar(AValue));
end;

class function TBandInfoEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TBandInfoEvent;
var
  hdlr: TBandInfoEvent_sh;
begin
  hdlr   := TBandInfoEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBandInfoEvent_sw));
  Result := hdlr.Handler;
end;

{ TBandMoveEvent_sh }

function TBandMoveEvent_sh.GetHandler: TMethod;
var
  hdr: TBandMoveEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBandMoveEvent_sh.Handler(Sender: TObject; Control: TControl;
  var ARect: TRect);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl; var ARect:...

  v_1 := TRect_sw.ToVar(ARect);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ARect := TRect_sw.FromVar(v_1);
end;

{ TBandMoveEvent_sw }

class function TBandMoveEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBandMoveEvent';
end;

class function TBandMoveEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBandMoveEvent_sh;
end;

class function TBandMoveEvent_sw.ToVar(
  const AValue: TBandMoveEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBandMoveEvent_sw.FromVar(
  const AValue: OleVariant): TBandMoveEvent;
begin
  Result := TBandMoveEvent(ConvFromVar(AValue));
end;

class function TBandMoveEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TBandMoveEvent;
var
  hdlr: TBandMoveEvent_sh;
begin
  hdlr   := TBandMoveEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBandMoveEvent_sw));
  Result := hdlr.Handler;
end;

{ TBeginBandMoveEvent_sh }

function TBeginBandMoveEvent_sh.GetHandler: TMethod;
var
  hdr: TBeginBandMoveEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBeginBandMoveEvent_sh.Handler(Sender: TObject; Control: TControl;
  var AllowMove: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl; var AllowM...

  v_1 := AllowMove;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowMove := Boolean(v_1);
end;

{ TBeginBandMoveEvent_sw }

class function TBeginBandMoveEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBeginBandMoveEvent';
end;

class function TBeginBandMoveEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBeginBandMoveEvent_sh;
end;

class function TBeginBandMoveEvent_sw.ToVar(
  const AValue: TBeginBandMoveEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBeginBandMoveEvent_sw.FromVar(
  const AValue: OleVariant): TBeginBandMoveEvent;
begin
  Result := TBeginBandMoveEvent(ConvFromVar(AValue));
end;

class function TBeginBandMoveEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TBeginBandMoveEvent;
var
  hdlr: TBeginBandMoveEvent_sh;
begin
  hdlr   := TBeginBandMoveEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBeginBandMoveEvent_sw));
  Result := hdlr.Handler;
end;

{ TEndBandMoveEvent_sh }

function TEndBandMoveEvent_sh.GetHandler: TMethod;
var
  hdr: TEndBandMoveEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TEndBandMoveEvent_sh.Handler(Sender: TObject; Control: TControl);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TEndBandMoveEvent_sw }

class function TEndBandMoveEvent_sw.GetTypeName: WideString;
begin
  Result := 'TEndBandMoveEvent';
end;

class function TEndBandMoveEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TEndBandMoveEvent_sh;
end;

class function TEndBandMoveEvent_sw.ToVar(
  const AValue: TEndBandMoveEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TEndBandMoveEvent_sw.FromVar(
  const AValue: OleVariant): TEndBandMoveEvent;
begin
  Result := TEndBandMoveEvent(ConvFromVar(AValue));
end;

class function TEndBandMoveEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TEndBandMoveEvent;
var
  hdlr: TEndBandMoveEvent_sh;
begin
  hdlr   := TEndBandMoveEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TEndBandMoveEvent_sw));
  Result := hdlr.Handler;
end;

{ TBandPaintEvent_sh }

function TBandPaintEvent_sh.GetHandler: TMethod;
var
  hdr: TBandPaintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBandPaintEvent_sh.Handler(Sender: TObject; Control: TControl;
  Canvas: TCanvas; var ARect: TRect; var Options: TBandPaintOptions);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Sender: TObject; Control: TControl; Canvas: TC...

  v_1 := TRect_sw.ToVar(ARect);
  v_2 := TBandPaintOptions_sw.ToVar(Options);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := TCanvas_sw.ToVar(Canvas);
  args[3] := MakeVarRef(v_1);
  args[4] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  ARect := TRect_sw.FromVar(v_1);
  Options := TBandPaintOptions_sw.FromVar(v_2);
end;

{ TBandPaintEvent_sw }

class function TBandPaintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBandPaintEvent';
end;

class function TBandPaintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBandPaintEvent_sh;
end;

class function TBandPaintEvent_sw.ToVar(
  const AValue: TBandPaintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBandPaintEvent_sw.FromVar(
  const AValue: OleVariant): TBandPaintEvent;
begin
  Result := TBandPaintEvent(ConvFromVar(AValue));
end;

class function TBandPaintEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TBandPaintEvent;
var
  hdlr: TBandPaintEvent_sh;
begin
  hdlr   := TBandPaintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBandPaintEvent_sw));
  Result := hdlr.Handler;
end;

{ TRowSize_sw }

class function TRowSize_sw.GetTypeName: WideString;
begin
  Result := 'TRowSize';
end;

class function TRowSize_sw.ToVar(const AValue: TRowSize): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TRowSize_sw.FromVar(const AValue: OleVariant): TRowSize;
begin
  Result := TRowSize(Integer(AValue));
end;

{ TCustomControlBar_sw }

function TCustomControlBar_StickControls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StickControls;

  TCustomControlBar(AObj).StickControls();
end;

function TCustomControlBar_Picture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Picture: TPicture read <getter> write <setter>;

  if IsGet then
    Result := TPicture_sw.ToVar(TCustomControlBar(AObj).Picture)
  else
    TCustomControlBar(AObj).Picture := TPicture_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_AutoDock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoDock: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomControlBar_sacc(TCustomControlBar(AObj)).AutoDock
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).AutoDock := Boolean(
      AArgs[0]);
end;

function TCustomControlBar_AutoDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoDrag: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomControlBar_sacc(TCustomControlBar(AObj)).AutoDrag
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).AutoDrag := Boolean(
      AArgs[0]);
end;

function TCustomControlBar_RowSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RowSize: TRowSize read <getter> write ...

  if IsGet then
    Result := TRowSize_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(AObj)).
      RowSize)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).RowSize := TRowSize_sw.
      FromVar(AArgs[0]);
end;

function TCustomControlBar_RowSnap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RowSnap: Boolean read <getter> write <...

  if IsGet then
    Result := TCustomControlBar_sacc(TCustomControlBar(AObj)).RowSnap
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).RowSnap := Boolean(
      AArgs[0]);
end;

function TCustomControlBar_OnBandDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBandDrag: TBandDragEvent read <gette...

  if IsGet then
    Result := TBandDragEvent_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(
      AObj)).OnBandDrag)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnBandDrag := 
      TBandDragEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnBandInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBandInfo: TBandInfoEvent read <gette...

  if IsGet then
    Result := TBandInfoEvent_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(
      AObj)).OnBandInfo)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnBandInfo := 
      TBandInfoEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnBandMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBandMove: TBandMoveEvent read <gette...

  if IsGet then
    Result := TBandMoveEvent_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(
      AObj)).OnBandMove)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnBandMove := 
      TBandMoveEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnBandPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBandPaint: TBandPaintEvent read <get...

  if IsGet then
    Result := TBandPaintEvent_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(
      AObj)).OnBandPaint)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnBandPaint := 
      TBandPaintEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnBeginBandMove_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBeginBandMove: TBeginBandMoveEvent r...

  if IsGet then
    Result := TBeginBandMoveEvent_sw.ToVar(TCustomControlBar_sacc(
      TCustomControlBar(AObj)).OnBeginBandMove)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnBeginBandMove := 
      TBeginBandMoveEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnEndBandMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEndBandMove: TEndBandMoveEvent read ...

  if IsGet then
    Result := TEndBandMoveEvent_sw.ToVar(TCustomControlBar_sacc(
      TCustomControlBar(AObj)).OnEndBandMove)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnEndBandMove := 
      TEndBandMoveEvent_sw.FromVar(AArgs[0]);
end;

function TCustomControlBar_OnPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnPaint: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomControlBar_sacc(TCustomControlBar(
      AObj)).OnPaint)
  else
    TCustomControlBar_sacc(TCustomControlBar(AObj)).OnPaint := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

class function TCustomControlBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomControlBar';
end;

class function TCustomControlBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomControlBar;
end;

class procedure TCustomControlBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('StickControls', TCustomControlBar_StickControls_si, 0, False);
  AData.AddProperty('Picture', TCustomControlBar_Picture_si, TPicture_sw, True, True, 0, False, False);
  AData.AddProperty('AutoDock', TCustomControlBar_AutoDock_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('AutoDrag', TCustomControlBar_AutoDrag_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('RowSize', TCustomControlBar_RowSize_si, TRowSize_sw, True, True, 0, True, False);
  AData.AddProperty('RowSnap', TCustomControlBar_RowSnap_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnBandDrag', TCustomControlBar_OnBandDrag_si, TBandDragEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnBandInfo', TCustomControlBar_OnBandInfo_si, TBandInfoEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnBandMove', TCustomControlBar_OnBandMove_si, TBandMoveEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnBandPaint', TCustomControlBar_OnBandPaint_si, TBandPaintEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnBeginBandMove', TCustomControlBar_OnBeginBandMove_si, TBeginBandMoveEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEndBandMove', TCustomControlBar_OnEndBandMove_si, TEndBandMoveEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnPaint', TCustomControlBar_OnPaint_si, TNotifyEvent_sw, True, True, 0, True, False);
end;

class function TCustomControlBar_sw.ToVar(
  const AValue: TCustomControlBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomControlBar_sw.FromVar(
  const AValue: OleVariant): TCustomControlBar;
begin
  Result := TCustomControlBar(ConvFromVar(AValue, TCustomControlBar));
end;

class function TCustomControlBar_sw.ClassToVar(
  AClass: TCustomControlBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomControlBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomControlBar_sc;
begin
  Result := TCustomControlBar_sc(ConvClsFromVar(AClass, TCustomControlBar));
end;

{ TControlBar_sw }

class function TControlBar_sw.GetTypeName: WideString;
begin
  Result := 'TControlBar';
end;

class function TControlBar_sw.GetWrappedClass: TClass;
begin
  Result := TControlBar;
end;

class procedure TControlBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoDock', False);
  AData.AddPropertyRedecl('AutoDrag', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('Picture', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('RowSize', False);
  AData.AddPropertyRedecl('RowSnap', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddPropertyRedecl('OnBandDrag', False);
  AData.AddPropertyRedecl('OnBandInfo', False);
  AData.AddPropertyRedecl('OnBandMove', False);
  AData.AddPropertyRedecl('OnBandPaint', False);
  AData.AddPropertyRedecl('OnBeginBandMove', False);
  AData.AddPropertyRedecl('OnEndBandMove', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnPaint', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TControlBar_sw.ToVar(const AValue: TControlBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlBar_sw.FromVar(const AValue: OleVariant): TControlBar;
begin
  Result := TControlBar(ConvFromVar(AValue, TControlBar));
end;

class function TControlBar_sw.ClassToVar(AClass: TControlBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControlBar_sw.ClassFromVar(
  const AClass: OleVariant): TControlBar_sc;
begin
  Result := TControlBar_sc(ConvClsFromVar(AClass, TControlBar));
end;

{ TBoundLabel_sw }

function TBoundLabel_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBoundLabel(AObj).Height
  else
    TBoundLabel(AObj).Height := Integer(AArgs[0]);
end;

function TBoundLabel_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter>;

  Result := TBoundLabel(AObj).Left;
end;

function TBoundLabel_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter>;

  Result := TBoundLabel(AObj).Top;
end;

function TBoundLabel_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBoundLabel(AObj).Width
  else
    TBoundLabel(AObj).Width := Integer(AArgs[0]);
end;

class function TBoundLabel_sw.GetTypeName: WideString;
begin
  Result := 'TBoundLabel';
end;

class function TBoundLabel_sw.GetWrappedClass: TClass;
begin
  Result := TBoundLabel;
end;

class procedure TBoundLabel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('Height', TBoundLabel_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Left', TBoundLabel_Left_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowAccelChar', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Top', TBoundLabel_Top_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Transparent', False);
  AData.AddPropertyRedecl('Layout', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddProperty('Width', TBoundLabel_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TBoundLabel_sw.ToVar(const AValue: TBoundLabel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBoundLabel_sw.FromVar(const AValue: OleVariant): TBoundLabel;
begin
  Result := TBoundLabel(ConvFromVar(AValue, TBoundLabel));
end;

class function TBoundLabel_sw.ClassToVar(AClass: TBoundLabel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBoundLabel_sw.ClassFromVar(
  const AClass: OleVariant): TBoundLabel_sc;
begin
  Result := TBoundLabel_sc(ConvClsFromVar(AClass, TBoundLabel));
end;

{ TLabelPosition_sw }

class function TLabelPosition_sw.GetTypeName: WideString;
begin
  Result := 'TLabelPosition';
end;

class procedure TLabelPosition_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'lpAbove'; Value: Integer({$IFDEF LMDSCT_12}TLabelPosition.{$ENDIF}lpAbove)),
    (Name: 'lpBelow'; Value: Integer({$IFDEF LMDSCT_12}TLabelPosition.{$ENDIF}lpBelow)),
    (Name: 'lpLeft'; Value: Integer({$IFDEF LMDSCT_12}TLabelPosition.{$ENDIF}lpLeft)),
    (Name: 'lpRight'; Value: Integer({$IFDEF LMDSCT_12}TLabelPosition.{$ENDIF}lpRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TLabelPosition_sw.ToVar(
  const AValue: TLabelPosition): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TLabelPosition_sw.FromVar(
  const AValue: OleVariant): TLabelPosition;
begin
  Result := TLabelPosition(Integer(AValue));
end;

{ TCustomLabeledEdit_sw }

function TCustomLabeledEdit_SetupInternalLabel_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetupInternalLabel;

  TCustomLabeledEdit(AObj).SetupInternalLabel();
end;

function TCustomLabeledEdit_EditLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditLabel: TBoundLabel read <getter>;

  Result := TBoundLabel_sw.ToVar(TCustomLabeledEdit(AObj).EditLabel);
end;

function TCustomLabeledEdit_LabelPosition_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LabelPosition: TLabelPosition read <getter> writ...

  if IsGet then
    Result := TLabelPosition_sw.ToVar(TCustomLabeledEdit(AObj).LabelPosition)
  else
    TCustomLabeledEdit(AObj).LabelPosition := TLabelPosition_sw.FromVar(
      AArgs[0]);
end;

function TCustomLabeledEdit_LabelSpacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LabelSpacing: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomLabeledEdit(AObj).LabelSpacing
  else
    TCustomLabeledEdit(AObj).LabelSpacing := Integer(AArgs[0]);
end;

class function TCustomLabeledEdit_sw.GetTypeName: WideString;
begin
  Result := 'TCustomLabeledEdit';
end;

class function TCustomLabeledEdit_sw.GetWrappedClass: TClass;
begin
  Result := TCustomLabeledEdit;
end;

class procedure TCustomLabeledEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SetupInternalLabel', TCustomLabeledEdit_SetupInternalLabel_si, 0, False);
  AData.AddProperty('EditLabel', TCustomLabeledEdit_EditLabel_si, TBoundLabel_sw, True, False, 0, False, False);
  AData.AddProperty('LabelPosition', TCustomLabeledEdit_LabelPosition_si, TLabelPosition_sw, True, True, 0, False, False);
  AData.AddProperty('LabelSpacing', TCustomLabeledEdit_LabelSpacing_si, Integer_sw, True, True, 0, False, False);
end;

class function TCustomLabeledEdit_sw.ToVar(
  const AValue: TCustomLabeledEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomLabeledEdit_sw.FromVar(
  const AValue: OleVariant): TCustomLabeledEdit;
begin
  Result := TCustomLabeledEdit(ConvFromVar(AValue, TCustomLabeledEdit));
end;

class function TCustomLabeledEdit_sw.ClassToVar(
  AClass: TCustomLabeledEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomLabeledEdit_sw.ClassFromVar(
  const AClass: OleVariant): TCustomLabeledEdit_sc;
begin
  Result := TCustomLabeledEdit_sc(ConvClsFromVar(AClass, TCustomLabeledEdit));
end;

{ TLabeledEdit_sw }

class function TLabeledEdit_sw.GetTypeName: WideString;
begin
  Result := 'TLabeledEdit';
end;

class function TLabeledEdit_sw.GetWrappedClass: TClass;
begin
  Result := TLabeledEdit;
end;

class procedure TLabeledEdit_sw.DoInit(AData: TLMDClassWrapperData);
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
  AData.AddPropertyRedecl('EditLabel', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('LabelPosition', False);
  AData.AddPropertyRedecl('LabelSpacing', False);
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
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TLabeledEdit_sw.ToVar(const AValue: TLabeledEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLabeledEdit_sw.FromVar(const AValue: OleVariant): TLabeledEdit;
begin
  Result := TLabeledEdit(ConvFromVar(AValue, TLabeledEdit));
end;

class function TLabeledEdit_sw.ClassToVar(AClass: TLabeledEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLabeledEdit_sw.ClassFromVar(
  const AClass: OleVariant): TLabeledEdit_sc;
begin
  Result := TLabeledEdit_sc(ConvClsFromVar(AClass, TLabeledEdit));
end;

{ TColorBoxStyles_sw }

class function TColorBoxStyles_sw.GetTypeName: WideString;
begin
  Result := 'TColorBoxStyles';
end;

class procedure TColorBoxStyles_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'cbStandardColors'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbStandardColors)),
    (Name: 'cbExtendedColors'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbExtendedColors)),
    (Name: 'cbSystemColors'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbSystemColors)),
    (Name: 'cbIncludeNone'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbIncludeNone)),
    (Name: 'cbIncludeDefault'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbIncludeDefault)),
    (Name: 'cbCustomColor'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbCustomColor)),
    (Name: 'cbPrettyNames'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbPrettyNames)),
    (Name: 'cbCustomColors'; Value: Integer({$IFDEF LMDSCT_12}TColorBoxStyles.{$ENDIF}cbCustomColors))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TColorBoxStyles_sw.ToVar(
  const AValue: TColorBoxStyles): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColorBoxStyles_sw.FromVar(
  const AValue: OleVariant): TColorBoxStyles;
begin
  Result := TColorBoxStyles(Integer(AValue));
end;

{ TColorBoxStyle_sw }

class function TColorBoxStyle_sw.GetTypeName: WideString;
begin
  Result := 'TColorBoxStyle';
end;

class function TColorBoxStyle_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TColorBoxStyle);
end;

class function TColorBoxStyle_sw.ToVar(
  const AValue: TColorBoxStyle): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TColorBoxStyle_sw.FromVar(
  const AValue: OleVariant): TColorBoxStyle;
begin
  ConvFromVar(AValue, @Result);
end;

{ TGetColorsEvent_sh }

function TGetColorsEvent_sh.GetHandler: TMethod;
var
  hdr: TGetColorsEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetColorsEvent_sh.Handler(Sender: TCustomColorBox; Items: TStrings);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TCustomColorBox; Items: TStrings) of o...

  args[0] := TCustomColorBox_sw.ToVar(Sender);
  args[1] := TStrings_sw.ToVar(Items);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetColorsEvent_sw }

class function TGetColorsEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetColorsEvent';
end;

class function TGetColorsEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetColorsEvent_sh;
end;

class function TGetColorsEvent_sw.ToVar(
  const AValue: TGetColorsEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetColorsEvent_sw.FromVar(
  const AValue: OleVariant): TGetColorsEvent;
begin
  Result := TGetColorsEvent(ConvFromVar(AValue));
end;

class function TGetColorsEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetColorsEvent;
var
  hdlr: TGetColorsEvent_sh;
begin
  hdlr   := TGetColorsEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetColorsEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomColorBox_sw }

function TCustomColorBox_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TColorBoxStyle read <getter> write <setter>;

  if IsGet then
    Result := TColorBoxStyle_sw.ToVar(TCustomColorBox(AObj).Style)
  else
    TCustomColorBox(AObj).Style := TColorBoxStyle_sw.FromVar(AArgs[0]);
end;

function TCustomColorBox_Colors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Colors[Index: Integer]: TColor read <getter>;

  Result := TColor_sw.ToVar(TCustomColorBox(AObj).Colors[Integer(AArgs[0])]);
end;

function TCustomColorBox_ColorNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ColorNames[Index: Integer]: string read <getter>;

  Result := TCustomColorBox(AObj).ColorNames[Integer(AArgs[0])];
end;

function TCustomColorBox_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorBox(AObj).Selected)
  else
    TCustomColorBox(AObj).Selected := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorBox_DefaultColorColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultColorColor: TColor read <getter> write <s...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorBox(AObj).DefaultColorColor)
  else
    TCustomColorBox(AObj).DefaultColorColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorBox_NoneColorColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NoneColorColor: TColor read <getter> write <sett...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorBox(AObj).NoneColorColor)
  else
    TCustomColorBox(AObj).NoneColorColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorBox_OnGetColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetColors: TGetColorsEvent read <getter> write...

  if IsGet then
    Result := TGetColorsEvent_sw.ToVar(TCustomColorBox(AObj).OnGetColors)
  else
    TCustomColorBox(AObj).OnGetColors := TGetColorsEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomColorBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomColorBox';
end;

class function TCustomColorBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomColorBox;
end;

class procedure TCustomColorBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Style', TCustomColorBox_Style_si, TColorBoxStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Colors', TCustomColorBox_Colors_si, TColor_sw, True, False, 1, False, False);
  AData.AddProperty('ColorNames', TCustomColorBox_ColorNames_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('Selected', TCustomColorBox_Selected_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultColorColor', TCustomColorBox_DefaultColorColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('NoneColorColor', TCustomColorBox_NoneColorColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetColors', TCustomColorBox_OnGetColors_si, TGetColorsEvent_sw, True, True, 0, False, False);
end;

class function TCustomColorBox_sw.ToVar(
  const AValue: TCustomColorBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomColorBox_sw.FromVar(
  const AValue: OleVariant): TCustomColorBox;
begin
  Result := TCustomColorBox(ConvFromVar(AValue, TCustomColorBox));
end;

class function TCustomColorBox_sw.ClassToVar(
  AClass: TCustomColorBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomColorBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomColorBox_sc;
begin
  Result := TCustomColorBox_sc(ConvClsFromVar(AClass, TCustomColorBox));
end;

{ TColorBox_sw }

class function TColorBox_sw.GetTypeName: WideString;
begin
  Result := 'TColorBox';
end;

class function TColorBox_sw.GetWrappedClass: TClass;
begin
  Result := TColorBox;
end;

class procedure TColorBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('AutoDropDown', False);
  AData.AddPropertyRedecl('DefaultColorColor', False);
  AData.AddPropertyRedecl('NoneColorColor', False);
  AData.AddPropertyRedecl('Selected', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DropDownCount', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ItemHeight', False);
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
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnCloseUp', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDropDown', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetColors', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnSelect', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TColorBox_sw.ToVar(const AValue: TColorBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColorBox_sw.FromVar(const AValue: OleVariant): TColorBox;
begin
  Result := TColorBox(ConvFromVar(AValue, TColorBox));
end;

class function TColorBox_sw.ClassToVar(AClass: TColorBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColorBox_sw.ClassFromVar(
  const AClass: OleVariant): TColorBox_sc;
begin
  Result := TColorBox_sc(ConvClsFromVar(AClass, TColorBox));
end;

{ TLBGetColorsEvent_sh }

function TLBGetColorsEvent_sh.GetHandler: TMethod;
var
  hdr: TLBGetColorsEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLBGetColorsEvent_sh.Handler(Sender: TCustomColorListBox;
  Items: TStrings);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TCustomColorListBox; Items: TStrings) ...

  args[0] := TCustomColorListBox_sw.ToVar(Sender);
  args[1] := TStrings_sw.ToVar(Items);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLBGetColorsEvent_sw }

class function TLBGetColorsEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLBGetColorsEvent';
end;

class function TLBGetColorsEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLBGetColorsEvent_sh;
end;

class function TLBGetColorsEvent_sw.ToVar(
  const AValue: TLBGetColorsEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLBGetColorsEvent_sw.FromVar(
  const AValue: OleVariant): TLBGetColorsEvent;
begin
  Result := TLBGetColorsEvent(ConvFromVar(AValue));
end;

class function TLBGetColorsEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TLBGetColorsEvent;
var
  hdlr: TLBGetColorsEvent_sh;
begin
  hdlr   := TLBGetColorsEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLBGetColorsEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomColorListBox_sw }

function TCustomColorListBox_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TColorBoxStyle read <getter> write <setter>;

  if IsGet then
    Result := TColorBoxStyle_sw.ToVar(TCustomColorListBox(AObj).Style)
  else
    TCustomColorListBox(AObj).Style := TColorBoxStyle_sw.FromVar(AArgs[0]);
end;

function TCustomColorListBox_Colors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Colors[Index: Integer]: TColor read <getter>;

  Result := TColor_sw.ToVar(TCustomColorListBox(AObj).Colors[Integer(
    AArgs[0])]);
end;

function TCustomColorListBox_ColorNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ColorNames[Index: Integer]: string read <getter>;

  Result := TCustomColorListBox(AObj).ColorNames[Integer(AArgs[0])];
end;

function TCustomColorListBox_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorListBox(AObj).Selected)
  else
    TCustomColorListBox(AObj).Selected := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorListBox_DefaultColorColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultColorColor: TColor read <getter> write <s...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorListBox(AObj).DefaultColorColor)
  else
    TCustomColorListBox(AObj).DefaultColorColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorListBox_NoneColorColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NoneColorColor: TColor read <getter> write <sett...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomColorListBox(AObj).NoneColorColor)
  else
    TCustomColorListBox(AObj).NoneColorColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomColorListBox_OnGetColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetColors: TLBGetColorsEvent read <getter> wri...

  if IsGet then
    Result := TLBGetColorsEvent_sw.ToVar(TCustomColorListBox(AObj).OnGetColors)
  else
    TCustomColorListBox(AObj).OnGetColors := TLBGetColorsEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomColorListBox_sw.GetTypeName: WideString;
begin
  Result := 'TCustomColorListBox';
end;

class function TCustomColorListBox_sw.GetWrappedClass: TClass;
begin
  Result := TCustomColorListBox;
end;

class procedure TCustomColorListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Style', TCustomColorListBox_Style_si, TColorBoxStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Colors', TCustomColorListBox_Colors_si, TColor_sw, True, False, 1, False, False);
  AData.AddProperty('ColorNames', TCustomColorListBox_ColorNames_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('Selected', TCustomColorListBox_Selected_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultColorColor', TCustomColorListBox_DefaultColorColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('NoneColorColor', TCustomColorListBox_NoneColorColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetColors', TCustomColorListBox_OnGetColors_si, TLBGetColorsEvent_sw, True, True, 0, False, False);
end;

class function TCustomColorListBox_sw.ToVar(
  const AValue: TCustomColorListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomColorListBox_sw.FromVar(
  const AValue: OleVariant): TCustomColorListBox;
begin
  Result := TCustomColorListBox(ConvFromVar(AValue, TCustomColorListBox));
end;

class function TCustomColorListBox_sw.ClassToVar(
  AClass: TCustomColorListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomColorListBox_sw.ClassFromVar(
  const AClass: OleVariant): TCustomColorListBox_sc;
begin
  Result := TCustomColorListBox_sc(ConvClsFromVar(AClass, TCustomColorListBox));
end;

{ TColorListBox_sw }

class function TColorListBox_sw.GetTypeName: WideString;
begin
  Result := 'TColorListBox';
end;

class function TColorListBox_sw.GetWrappedClass: TClass;
begin
  Result := TColorListBox;
end;

class procedure TColorListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('DefaultColorColor', False);
  AData.AddPropertyRedecl('NoneColorColor', False);
  AData.AddPropertyRedecl('Selected', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ItemHeight', False);
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
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetColors', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TColorListBox_sw.ToVar(const AValue: TColorListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColorListBox_sw.FromVar(
  const AValue: OleVariant): TColorListBox;
begin
  Result := TColorListBox(ConvFromVar(AValue, TColorListBox));
end;

class function TColorListBox_sw.ClassToVar(
  AClass: TColorListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColorListBox_sw.ClassFromVar(
  const AClass: OleVariant): TColorListBox_sc;
begin
  Result := TColorListBox_sc(ConvClsFromVar(AClass, TColorListBox));
end;

{ ExtCtrls_sw }

function ExtCtrls_TShapeType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShapeType = (stRectangle, stSquare, stRoundRect, st...

  Result := TLMDUnitWrapper.TypeToVar(TShapeType_sw);
end;

function ExtCtrls_TShape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShape = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TShape_sw);
end;

function ExtCtrls_TPaintBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPaintBox = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TPaintBox_sw);
end;

function ExtCtrls_TImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImage = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TImage_sw);
end;

function ExtCtrls_TBevelStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelStyle = (bsLowered, bsRaised);

  Result := TLMDUnitWrapper.TypeToVar(TBevelStyle_sw);
end;

function ExtCtrls_TBevelShape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelShape = (bsBox, bsFrame, bsTopLine, bsBottomLi...

  Result := TLMDUnitWrapper.TypeToVar(TBevelShape_sw);
end;

function ExtCtrls_TBevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevel = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TBevel_sw);
end;

function ExtCtrls_TTimer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTimer = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TTimer_sw);
end;

function ExtCtrls_TPanelBevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPanelBevel = TBevelCut;

  Result := TLMDUnitWrapper.TypeToVar(TPanelBevel_sw);
end;

function ExtCtrls_TCustomPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomPanel = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomPanel_sw);
end;

function ExtCtrls_TPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPanel = class(TCustomPanel);

  Result := TLMDUnitWrapper.TypeToVar(TPanel_sw);
end;

function ExtCtrls_TPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPage = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TPage_sw);
end;

function ExtCtrls_TNotebook_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNotebook = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TNotebook_sw);
end;

function ExtCtrls_TSectionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSectionEvent = procedure (Sender: TObject; ASection...

  Result := TLMDUnitWrapper.TypeToVar(TSectionEvent_sw);
end;

function ExtCtrls_THeader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeader = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(THeader_sw);
end;

function ExtCtrls_TCustomRadioGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomRadioGroup = class(TCustomGroupBox);

  Result := TLMDUnitWrapper.TypeToVar(TCustomRadioGroup_sw);
end;

function ExtCtrls_TRadioGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRadioGroup = class(TCustomRadioGroup);

  Result := TLMDUnitWrapper.TypeToVar(TRadioGroup_sw);
end;

function ExtCtrls_NaturalNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type NaturalNumber = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(NaturalNumber_sw);
end;

function ExtCtrls_TSplitterCanResizeEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSplitterCanResizeEvent = procedure (Sender: TObject...

  Result := TLMDUnitWrapper.TypeToVar(TSplitterCanResizeEvent_sw);
end;

function ExtCtrls_TCanResizeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanResizeEvent = TSplitterCanResizeEvent;

  Result := TLMDUnitWrapper.TypeToVar(TCanResizeEvent_sw);
end;

function ExtCtrls_TResizeStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResizeStyle = (rsNone, rsLine, rsUpdate, rsPattern);

  Result := TLMDUnitWrapper.TypeToVar(TResizeStyle_sw);
end;

function ExtCtrls_TSplitter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSplitter = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TSplitter_sw);
end;

function ExtCtrls_TBandPaintOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandPaintOption = (bpoGrabber, bpoFrame);

  Result := TLMDUnitWrapper.TypeToVar(TBandPaintOption_sw);
end;

function ExtCtrls_TBandPaintOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandPaintOptions = set of TBandPaintOption;

  Result := TLMDUnitWrapper.TypeToVar(TBandPaintOptions_sw);
end;

function ExtCtrls_TBandDragEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandDragEvent = procedure (Sender: TObject; Control...

  Result := TLMDUnitWrapper.TypeToVar(TBandDragEvent_sw);
end;

function ExtCtrls_TBandInfoEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandInfoEvent = procedure (Sender: TObject; Control...

  Result := TLMDUnitWrapper.TypeToVar(TBandInfoEvent_sw);
end;

function ExtCtrls_TBandMoveEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandMoveEvent = procedure (Sender: TObject; Control...

  Result := TLMDUnitWrapper.TypeToVar(TBandMoveEvent_sw);
end;

function ExtCtrls_TBeginBandMoveEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBeginBandMoveEvent = procedure (Sender: TObject; Co...

  Result := TLMDUnitWrapper.TypeToVar(TBeginBandMoveEvent_sw);
end;

function ExtCtrls_TEndBandMoveEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEndBandMoveEvent = procedure (Sender: TObject; Cont...

  Result := TLMDUnitWrapper.TypeToVar(TEndBandMoveEvent_sw);
end;

function ExtCtrls_TBandPaintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBandPaintEvent = procedure (Sender: TObject; Contro...

  Result := TLMDUnitWrapper.TypeToVar(TBandPaintEvent_sw);
end;

function ExtCtrls_TRowSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRowSize = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TRowSize_sw);
end;

function ExtCtrls_TCustomControlBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomControlBar = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomControlBar_sw);
end;

function ExtCtrls_TControlBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlBar = class(TCustomControlBar);

  Result := TLMDUnitWrapper.TypeToVar(TControlBar_sw);
end;

function ExtCtrls_TBoundLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBoundLabel = class(TCustomLabel);

  Result := TLMDUnitWrapper.TypeToVar(TBoundLabel_sw);
end;

function ExtCtrls_TLabelPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLabelPosition = (lpAbove, lpBelow, lpLeft, lpRight);

  Result := TLMDUnitWrapper.TypeToVar(TLabelPosition_sw);
end;

function ExtCtrls_TCustomLabeledEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomLabeledEdit = class(TCustomEdit);

  Result := TLMDUnitWrapper.TypeToVar(TCustomLabeledEdit_sw);
end;

function ExtCtrls_TLabeledEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLabeledEdit = class(TCustomLabeledEdit);

  Result := TLMDUnitWrapper.TypeToVar(TLabeledEdit_sw);
end;

function ExtCtrls_NoColorSelected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NoColorSelected = <value>;

  Result := TColor_sw.ToVar(NoColorSelected);
end;

function ExtCtrls_TColorBoxStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorBoxStyles = (cbStandardColors, cbExtendedColor...

  Result := TLMDUnitWrapper.TypeToVar(TColorBoxStyles_sw);
end;

function ExtCtrls_TColorBoxStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorBoxStyle = set of TColorBoxStyles;

  Result := TLMDUnitWrapper.TypeToVar(TColorBoxStyle_sw);
end;

function ExtCtrls_TGetColorsEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetColorsEvent = procedure (Sender: TCustomColorBox...

  Result := TLMDUnitWrapper.TypeToVar(TGetColorsEvent_sw);
end;

function ExtCtrls_TCustomColorBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomColorBox = class(TCustomComboBox);

  Result := TLMDUnitWrapper.TypeToVar(TCustomColorBox_sw);
end;

function ExtCtrls_TColorBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorBox = class(TCustomColorBox);

  Result := TLMDUnitWrapper.TypeToVar(TColorBox_sw);
end;

function ExtCtrls_TLBGetColorsEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLBGetColorsEvent = procedure (Sender: TCustomColorL...

  Result := TLMDUnitWrapper.TypeToVar(TLBGetColorsEvent_sw);
end;

function ExtCtrls_TCustomColorListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomColorListBox = class(TCustomListBox);

  Result := TLMDUnitWrapper.TypeToVar(TCustomColorListBox_sw);
end;

function ExtCtrls_TColorListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorListBox = class(TCustomColorListBox);

  Result := TLMDUnitWrapper.TypeToVar(TColorListBox_sw);
end;

function ExtCtrls_Frame3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure Frame3D(Canvas: TCanvas; var Rect: TRect; TopCo...

  v_1 := TRect_sw.FromVar(AArgs[1]);
  ExtCtrls.Frame3D(TCanvas_sw.FromVar(AArgs[0]), v_1, TColor_sw.FromVar(
    AArgs[2]), TColor_sw.FromVar(AArgs[3]), Integer(AArgs[4]));
  AssignRefParam(AArgs[1], TRect_sw.ToVar(v_1));
end;

function ExtCtrls_NotebookHandlesNeeded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NotebookHandlesNeeded(Notebook: TNotebook);

  ExtCtrls.NotebookHandlesNeeded(TNotebook_sw.FromVar(AArgs[0]));
end;

class function ExtCtrls_sw.GetUnitName: WideString;
begin
  Result := 'ExtCtrls';
end;

class procedure ExtCtrls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TShapeType_sw, ExtCtrls_TShapeType_si);
  AData.AddType(TShape_sw, ExtCtrls_TShape_si);
  AData.AddType(TPaintBox_sw, ExtCtrls_TPaintBox_si);
  AData.AddType(TImage_sw, ExtCtrls_TImage_si);
  AData.AddType(TBevelStyle_sw, ExtCtrls_TBevelStyle_si);
  AData.AddType(TBevelShape_sw, ExtCtrls_TBevelShape_si);
  AData.AddType(TBevel_sw, ExtCtrls_TBevel_si);
  AData.AddType(TTimer_sw, ExtCtrls_TTimer_si);
  AData.AddType(TPanelBevel_sw, ExtCtrls_TPanelBevel_si);
  AData.AddType(TCustomPanel_sw, ExtCtrls_TCustomPanel_si);
  AData.AddType(TPanel_sw, ExtCtrls_TPanel_si);
  AData.AddType(TPage_sw, ExtCtrls_TPage_si);
  AData.AddType(TNotebook_sw, ExtCtrls_TNotebook_si);
  AData.AddType(TSectionEvent_sw, ExtCtrls_TSectionEvent_si);
  AData.AddType(THeader_sw, ExtCtrls_THeader_si);
  AData.AddType(TCustomRadioGroup_sw, ExtCtrls_TCustomRadioGroup_si);
  AData.AddType(TRadioGroup_sw, ExtCtrls_TRadioGroup_si);
  AData.AddType(NaturalNumber_sw, ExtCtrls_NaturalNumber_si);
  AData.AddType(TSplitterCanResizeEvent_sw, ExtCtrls_TSplitterCanResizeEvent_si);
  AData.AddType(TCanResizeEvent_sw, ExtCtrls_TCanResizeEvent_si);
  AData.AddType(TResizeStyle_sw, ExtCtrls_TResizeStyle_si);
  AData.AddType(TSplitter_sw, ExtCtrls_TSplitter_si);
  AData.AddType(TBandPaintOption_sw, ExtCtrls_TBandPaintOption_si);
  AData.AddType(TBandPaintOptions_sw, ExtCtrls_TBandPaintOptions_si);
  AData.AddType(TBandDragEvent_sw, ExtCtrls_TBandDragEvent_si);
  AData.AddType(TBandInfoEvent_sw, ExtCtrls_TBandInfoEvent_si);
  AData.AddType(TBandMoveEvent_sw, ExtCtrls_TBandMoveEvent_si);
  AData.AddType(TBeginBandMoveEvent_sw, ExtCtrls_TBeginBandMoveEvent_si);
  AData.AddType(TEndBandMoveEvent_sw, ExtCtrls_TEndBandMoveEvent_si);
  AData.AddType(TBandPaintEvent_sw, ExtCtrls_TBandPaintEvent_si);
  AData.AddType(TRowSize_sw, ExtCtrls_TRowSize_si);
  AData.AddType(TCustomControlBar_sw, ExtCtrls_TCustomControlBar_si);
  AData.AddType(TControlBar_sw, ExtCtrls_TControlBar_si);
  AData.AddType(TBoundLabel_sw, ExtCtrls_TBoundLabel_si);
  AData.AddType(TLabelPosition_sw, ExtCtrls_TLabelPosition_si);
  AData.AddType(TCustomLabeledEdit_sw, ExtCtrls_TCustomLabeledEdit_si);
  AData.AddType(TLabeledEdit_sw, ExtCtrls_TLabeledEdit_si);
  AData.AddConstant('NoColorSelected', ExtCtrls_NoColorSelected_si, TColor_sw);
  AData.AddType(TColorBoxStyles_sw, ExtCtrls_TColorBoxStyles_si);
  AData.AddType(TColorBoxStyle_sw, ExtCtrls_TColorBoxStyle_si);
  AData.AddType(TGetColorsEvent_sw, ExtCtrls_TGetColorsEvent_si);
  AData.AddType(TCustomColorBox_sw, ExtCtrls_TCustomColorBox_si);
  AData.AddType(TColorBox_sw, ExtCtrls_TColorBox_si);
  AData.AddType(TLBGetColorsEvent_sw, ExtCtrls_TLBGetColorsEvent_si);
  AData.AddType(TCustomColorListBox_sw, ExtCtrls_TCustomColorListBox_si);
  AData.AddType(TColorListBox_sw, ExtCtrls_TColorListBox_si);
  AData.AddProcedure('Frame3D', ExtCtrls_Frame3D_si, 5, False);
  AData.AddProcedure('NotebookHandlesNeeded', ExtCtrls_NotebookHandlesNeeded_si, 1, False);
end;

class function ExtCtrls_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ExtCtrls_sw);
end;

initialization
  RegisterUnitWrapper(ExtCtrls_sw);
  RegisterClassWrapper(TShape_sw);
  RegisterClassWrapper(TPaintBox_sw);
  RegisterClassWrapper(TImage_sw);
  RegisterClassWrapper(TBevel_sw);
  RegisterClassWrapper(TTimer_sw);
  RegisterClassWrapper(TCustomPanel_sw);
  RegisterClassWrapper(TPanel_sw);
  RegisterClassWrapper(TPage_sw);
  RegisterClassWrapper(TNotebook_sw);
  RegisterClassWrapper(THeader_sw);
  RegisterClassWrapper(TCustomRadioGroup_sw);
  RegisterClassWrapper(TRadioGroup_sw);
  RegisterClassWrapper(TSplitter_sw);
  RegisterClassWrapper(TCustomControlBar_sw);
  RegisterClassWrapper(TControlBar_sw);
  RegisterClassWrapper(TBoundLabel_sw);
  RegisterClassWrapper(TCustomLabeledEdit_sw);
  RegisterClassWrapper(TLabeledEdit_sw);
  RegisterClassWrapper(TCustomColorBox_sw);
  RegisterClassWrapper(TColorBox_sw);
  RegisterClassWrapper(TCustomColorListBox_sw);
  RegisterClassWrapper(TColorListBox_sw);
  RegisterEventWrapper(TypeInfo(TSectionEvent), TSectionEvent_sw);
  RegisterEventWrapper(TypeInfo(TSplitterCanResizeEvent), TSplitterCanResizeEvent_sw);
  RegisterEventWrapper(TypeInfo(TBandDragEvent), TBandDragEvent_sw);
  RegisterEventWrapper(TypeInfo(TBandInfoEvent), TBandInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TBandMoveEvent), TBandMoveEvent_sw);
  RegisterEventWrapper(TypeInfo(TBeginBandMoveEvent), TBeginBandMoveEvent_sw);
  RegisterEventWrapper(TypeInfo(TEndBandMoveEvent), TEndBandMoveEvent_sw);
  RegisterEventWrapper(TypeInfo(TBandPaintEvent), TBandPaintEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetColorsEvent), TGetColorsEvent_sw);
  RegisterEventWrapper(TypeInfo(TLBGetColorsEvent), TLBGetColorsEvent_sw);

end.
