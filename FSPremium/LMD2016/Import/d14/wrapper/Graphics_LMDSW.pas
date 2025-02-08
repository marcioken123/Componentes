unit Graphics_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Graphics' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, SysUtils, Classes, Graphics, Windows_LMDSW,
  SysUtils_LMDSW, Classes_LMDSW;


{ Type wrappers }

type
  EInvalidGraphic_sw = class;
  EInvalidGraphicOperation_sw = class;
  TGraphicsObject_sw = class;
  TFont_sw = class;
  TPen_sw = class;
  TBrush_sw = class;
  TFontRecall_sw = class;
  TPenRecall_sw = class;
  TBrushRecall_sw = class;
  TCustomCanvas_sw = class;
  TCanvas_sw = class;
  TGraphic_sw = class;
  TGraphicClass_sw = class;
  TPicture_sw = class;
  TMetafileCanvas_sw = class;
  TSharedImage_sw = class;
  TMetafileImage_sw = class;
  TMetafile_sw = class;
  TBitmapImage_sw = class;
  TBitmap_sw = class;
  TIconImage_sw = class;
  TIcon_sw = class;
  TWICImage_sw = class;

  TColor_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TColor): OleVariant;
    class function FromVar(const AValue: OleVariant): TColor;
  end;

  TCursorOrIcon_sw = class(TLMDRecordWrapper)
  private
    FValue: TCursorOrIcon;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCursorOrIcon): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorOrIcon;
  end;

  TIconRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TIconRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIconRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TIconRec;
  end;

  HMETAFILE_sw = THandle_sw;

  HENHMETAFILE_sw = THandle_sw;

  EInvalidGraphic_sc = class of EInvalidGraphic;
  EInvalidGraphic_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidGraphic): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidGraphic;
    class function ClassToVar(AClass: EInvalidGraphic_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidGraphic_sc;
  end;

  EInvalidGraphicOperation_sc = class of EInvalidGraphicOperation;
  EInvalidGraphicOperation_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidGraphicOperation): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidGraphicOperation;
    class function ClassToVar(AClass: EInvalidGraphicOperation_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidGraphicOperation_sc;
  end;

  TResData_sw = class(TLMDRecordWrapper)
  private
    FValue: TResData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TResData): OleVariant;
    class function FromVar(const AValue: OleVariant): TResData;
  end;

  TFontPitch_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontPitch): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontPitch;
  end;

  TFontName_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFontName): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontName;
  end;

  TFontCharset_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFontCharset): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontCharset;
  end;

  TFontStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStyle;
  end;

  TFontStyles_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStyles;
  end;

  TFontDataName_sw = string_sw;

  TFontStylesBase_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontStylesBase): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStylesBase;
  end;

  TFontData_sw = class(TLMDRecordWrapper)
  private
    FValue: TFontData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFontData): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontData;
  end;

  TPenStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPenStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TPenStyle;
  end;

  TPenMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPenMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TPenMode;
  end;

  TPenData_sw = class(TLMDRecordWrapper)
  private
    FValue: TPenData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPenData): OleVariant;
    class function FromVar(const AValue: OleVariant): TPenData;
  end;

  TBrushStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBrushStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrushStyle;
  end;

  TBrushData_sw = class(TLMDRecordWrapper)
  private
    FValue: TBrushData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TBrushData): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrushData;
  end;

  TResource_sw = class(TLMDRecordWrapper)
  private
    FValue: TResource;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TResource): OleVariant;
    class function FromVar(const AValue: OleVariant): TResource;
  end;

  TGraphicsObject_sc = class of TGraphicsObject;
  TGraphicsObject_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGraphicsObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TGraphicsObject;
    class function ClassToVar(AClass: TGraphicsObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGraphicsObject_sc;
  end;

  TFont_sc = class of TFont;
  TFont_sw = class(TGraphicsObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFont): OleVariant;
    class function FromVar(const AValue: OleVariant): TFont;
    class function ClassToVar(AClass: TFont_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFont_sc;
  end;

  TPen_sc = class of TPen;
  TPen_sw = class(TGraphicsObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPen): OleVariant;
    class function FromVar(const AValue: OleVariant): TPen;
    class function ClassToVar(AClass: TPen_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPen_sc;
  end;

  TBrush_sc = class of TBrush;
  TBrush_sw = class(TGraphicsObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBrush): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrush;
    class function ClassToVar(AClass: TBrush_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBrush_sc;
  end;

  TFontRecall_sc = class of TFontRecall;
  TFontRecall_sw = class(TRecall_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFontRecall): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontRecall;
    class function ClassToVar(AClass: TFontRecall_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFontRecall_sc;
  end;

  TPenRecall_sc = class of TPenRecall;
  TPenRecall_sw = class(TRecall_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPenRecall): OleVariant;
    class function FromVar(const AValue: OleVariant): TPenRecall;
    class function ClassToVar(AClass: TPenRecall_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPenRecall_sc;
  end;

  TBrushRecall_sc = class of TBrushRecall;
  TBrushRecall_sw = class(TRecall_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBrushRecall): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrushRecall;
    class function ClassToVar(AClass: TBrushRecall_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBrushRecall_sc;
  end;

  TFillStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFillStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFillStyle;
  end;

  TFillMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFillMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TFillMode;
  end;

  TCopyMode_sw = Longint_sw;

  TCanvasStates_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCanvasStates): OleVariant;
    class function FromVar(const AValue: OleVariant): TCanvasStates;
  end;

  TCanvasState_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TCanvasState): OleVariant;
    class function FromVar(const AValue: OleVariant): TCanvasState;
  end;

  TCanvasOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCanvasOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TCanvasOrientation;
  end;

  TTextFormats_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTextFormats): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextFormats;
  end;

  TTextFormat_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTextFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextFormat;
  end;

  TCustomCanvas_sc = class of TCustomCanvas;
  TCustomCanvas_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomCanvas): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomCanvas;
    class function ClassToVar(AClass: TCustomCanvas_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomCanvas_sc;
  end;

  TCanvas_sc = class of TCanvas;
  TCanvas_sw = class(TCustomCanvas_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCanvas): OleVariant;
    class function FromVar(const AValue: OleVariant): TCanvas;
    class function ClassToVar(AClass: TCanvas_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCanvas_sc;
  end;

  TProgressStage_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TProgressStage): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressStage;
  end;

  TProgressEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Stage: TProgressStage; PercentDone: Byte;
      RedrawNow: Boolean; const R: TRect; const Msg: string);
  end;

  TProgressEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TProgressEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TProgressEvent;
  end;

  TGraphic_sc = class of TGraphic;
  TGraphic_sw = class(TInterfacedPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGraphic): OleVariant;
    class function FromVar(const AValue: OleVariant): TGraphic;
    class function ClassToVar(AClass: TGraphic_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGraphic_sc;
  end;

  TGraphicClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TGraphicClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TGraphicClass;
  end;

  TPicture_sc = class of TPicture;
  TPicture_sw = class(TInterfacedPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPicture): OleVariant;
    class function FromVar(const AValue: OleVariant): TPicture;
    class function ClassToVar(AClass: TPicture_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPicture_sc;
  end;

  TMetafileCanvas_sc = class of TMetafileCanvas;
  TMetafileCanvas_sw = class(TCanvas_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMetafileCanvas): OleVariant;
    class function FromVar(const AValue: OleVariant): TMetafileCanvas;
    class function ClassToVar(AClass: TMetafileCanvas_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMetafileCanvas_sc;
  end;

  TSharedImage_sc = class of TSharedImage;
  TSharedImage_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSharedImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TSharedImage;
    class function ClassToVar(AClass: TSharedImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSharedImage_sc;
  end;

  TMetafileImage_sc = class of TMetafileImage;
  TMetafileImage_sw = class(TSharedImage_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMetafileImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TMetafileImage;
    class function ClassToVar(AClass: TMetafileImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMetafileImage_sc;
  end;

  TMetafile_sc = class of TMetafile;
  TMetafile_sw = class(TGraphic_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMetafile): OleVariant;
    class function FromVar(const AValue: OleVariant): TMetafile;
    class function ClassToVar(AClass: TMetafile_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMetafile_sc;
  end;

  TBitmapImage_sc = class of TBitmapImage;
  TBitmapImage_sw = class(TSharedImage_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBitmapImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitmapImage;
    class function ClassToVar(AClass: TBitmapImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBitmapImage_sc;
  end;

  TBitmapHandleType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBitmapHandleType): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitmapHandleType;
  end;

  TPixelFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPixelFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TPixelFormat;
  end;

  TAlphaFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAlphaFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlphaFormat;
  end;

  TTransparentMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTransparentMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TTransparentMode;
  end;

  TBitmap_sc = class of TBitmap;
  TBitmap_sw = class(TGraphic_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBitmap): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitmap;
    class function ClassToVar(AClass: TBitmap_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBitmap_sc;
  end;

  TIconImage_sc = class of TIconImage;
  TIconImage_sw = class(TSharedImage_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIconImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TIconImage;
    class function ClassToVar(AClass: TIconImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIconImage_sc;
  end;

  TIcon_sc = class of TIcon;
  TIcon_sw = class(TGraphic_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIcon): OleVariant;
    class function FromVar(const AValue: OleVariant): TIcon;
    class function ClassToVar(AClass: TIcon_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIcon_sc;
  end;

  TWICImageFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TWICImageFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TWICImageFormat;
  end;

  TWICImage_sc = class of TWICImage;
  TWICImage_sw = class(TGraphic_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWICImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TWICImage;
    class function ClassToVar(AClass: TWICImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWICImage_sc;
  end;


{ Unit wrapper }

type
  Graphics_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TSharedImage_sacc = class(TSharedImage);

{ TColor_sw }

class function TColor_sw.GetTypeName: WideString;
begin
  Result := 'TColor';
end;

class function TColor_sw.ToVar(const AValue: TColor): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColor_sw.FromVar(const AValue: OleVariant): TColor;
begin
  Result := TColor(Integer(AValue));
end;

{ TCursorOrIcon_sw }

function TCursorOrIcon_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: Word;

  if IsGet then
    Result := TCursorOrIcon_sw(AObj).FValue.Reserved
  else
    TCursorOrIcon_sw(AObj).FValue.Reserved := Word(AArgs[0]);
end;

function TCursorOrIcon_wType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wType: Word;

  if IsGet then
    Result := TCursorOrIcon_sw(AObj).FValue.wType
  else
    TCursorOrIcon_sw(AObj).FValue.wType := Word(AArgs[0]);
end;

function TCursorOrIcon_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Word;

  if IsGet then
    Result := TCursorOrIcon_sw(AObj).FValue.Count
  else
    TCursorOrIcon_sw(AObj).FValue.Count := Word(AArgs[0]);
end;

function TCursorOrIcon_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCursorOrIcon_sw.Create as IDispatch;
end;

function TCursorOrIcon_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCursorOrIcon;

  // Implicit record copy method.
  Result := TCursorOrIcon_sw.ToVar(TCursorOrIcon(AObj));
end;

class function TCursorOrIcon_sw.GetTypeName: WideString;
begin
  Result := 'TCursorOrIcon';
end;

function TCursorOrIcon_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCursorOrIcon_sw.Create;
  TCursorOrIcon_sw(Result).FValue := FValue;
end;

class procedure TCursorOrIcon_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Reserved', TCursorOrIcon_Reserved_si, Word_sw);
  AData.AddField('wType', TCursorOrIcon_wType_si, Word_sw);
  AData.AddField('Count', TCursorOrIcon_Count_si, Word_sw);
  AData.AddFunction('Copy', TCursorOrIcon_Copy_si, TCursorOrIcon_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCursorOrIcon_Create_si, 0, False);
end;

class function TCursorOrIcon_sw.ToVar(const AValue: TCursorOrIcon): OleVariant;
var
  wrpr: TCursorOrIcon_sw;
begin
  wrpr        := TCursorOrIcon_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCursorOrIcon_sw.FromVar(
  const AValue: OleVariant): TCursorOrIcon;
begin
  Result := TCursorOrIcon_sw(ConvFromVar(AValue)).FValue;
end;

{ TIconRec_sw }

function TIconRec_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Width: Byte;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.Width
  else
    TIconRec_sw(AObj).FValue.Width := Byte(AArgs[0]);
end;

function TIconRec_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Height: Byte;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.Height
  else
    TIconRec_sw(AObj).FValue.Height := Byte(AArgs[0]);
end;

function TIconRec_Colors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Colors: Word;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.Colors
  else
    TIconRec_sw(AObj).FValue.Colors := Word(AArgs[0]);
end;

function TIconRec_Reserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved1: Word;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.Reserved1
  else
    TIconRec_sw(AObj).FValue.Reserved1 := Word(AArgs[0]);
end;

function TIconRec_Reserved2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved2: Word;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.Reserved2
  else
    TIconRec_sw(AObj).FValue.Reserved2 := Word(AArgs[0]);
end;

function TIconRec_DIBSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DIBSize: Longint;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.DIBSize
  else
    TIconRec_sw(AObj).FValue.DIBSize := Longint(AArgs[0]);
end;

function TIconRec_DIBOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DIBOffset: Longint;

  if IsGet then
    Result := TIconRec_sw(AObj).FValue.DIBOffset
  else
    TIconRec_sw(AObj).FValue.DIBOffset := Longint(AArgs[0]);
end;

function TIconRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TIconRec_sw.Create as IDispatch;
end;

function TIconRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TIconRec;

  // Implicit record copy method.
  Result := TIconRec_sw.ToVar(TIconRec(AObj));
end;

class function TIconRec_sw.GetTypeName: WideString;
begin
  Result := 'TIconRec';
end;

function TIconRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIconRec_sw.Create;
  TIconRec_sw(Result).FValue := FValue;
end;

class procedure TIconRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Width', TIconRec_Width_si, Byte_sw);
  AData.AddField('Height', TIconRec_Height_si, Byte_sw);
  AData.AddField('Colors', TIconRec_Colors_si, Word_sw);
  AData.AddField('Reserved1', TIconRec_Reserved1_si, Word_sw);
  AData.AddField('Reserved2', TIconRec_Reserved2_si, Word_sw);
  AData.AddField('DIBSize', TIconRec_DIBSize_si, Longint_sw);
  AData.AddField('DIBOffset', TIconRec_DIBOffset_si, Longint_sw);
  AData.AddFunction('Copy', TIconRec_Copy_si, TIconRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TIconRec_Create_si, 0, False);
end;

class function TIconRec_sw.ToVar(const AValue: TIconRec): OleVariant;
var
  wrpr: TIconRec_sw;
begin
  wrpr        := TIconRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIconRec_sw.FromVar(const AValue: OleVariant): TIconRec;
begin
  Result := TIconRec_sw(ConvFromVar(AValue)).FValue;
end;

{ EInvalidGraphic_sw }

class function EInvalidGraphic_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidGraphic';
end;

class function EInvalidGraphic_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidGraphic;
end;

class procedure EInvalidGraphic_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidGraphic_sw.ToVar(
  const AValue: EInvalidGraphic): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidGraphic_sw.FromVar(
  const AValue: OleVariant): EInvalidGraphic;
begin
  Result := EInvalidGraphic(ConvFromVar(AValue, EInvalidGraphic));
end;

class function EInvalidGraphic_sw.ClassToVar(
  AClass: EInvalidGraphic_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidGraphic_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidGraphic_sc;
begin
  Result := EInvalidGraphic_sc(ConvClsFromVar(AClass, EInvalidGraphic));
end;

{ EInvalidGraphicOperation_sw }

class function EInvalidGraphicOperation_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidGraphicOperation';
end;

class function EInvalidGraphicOperation_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidGraphicOperation;
end;

class procedure EInvalidGraphicOperation_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidGraphicOperation_sw.ToVar(
  const AValue: EInvalidGraphicOperation): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidGraphicOperation_sw.FromVar(
  const AValue: OleVariant): EInvalidGraphicOperation;
begin
  Result := EInvalidGraphicOperation(ConvFromVar(AValue, 
    EInvalidGraphicOperation));
end;

class function EInvalidGraphicOperation_sw.ClassToVar(
  AClass: EInvalidGraphicOperation_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidGraphicOperation_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidGraphicOperation_sc;
begin
  Result := EInvalidGraphicOperation_sc(ConvClsFromVar(AClass, 
    EInvalidGraphicOperation));
end;

{ TResData_sw }

function TResData_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(TResData_sw(AObj).FValue.Handle)
  else
    TResData_sw(AObj).FValue.Handle := THandle_sw.FromVar(AArgs[0]);
end;

function TResData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TResData_sw.Create as IDispatch;
end;

function TResData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TResData;

  // Implicit record copy method.
  Result := TResData_sw.ToVar(TResData(AObj));
end;

class function TResData_sw.GetTypeName: WideString;
begin
  Result := 'TResData';
end;

function TResData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TResData_sw.Create;
  TResData_sw(Result).FValue := FValue;
end;

class procedure TResData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TResData_Handle_si, THandle_sw);
  AData.AddFunction('Copy', TResData_Copy_si, TResData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TResData_Create_si, 0, False);
end;

class function TResData_sw.ToVar(const AValue: TResData): OleVariant;
var
  wrpr: TResData_sw;
begin
  wrpr        := TResData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TResData_sw.FromVar(const AValue: OleVariant): TResData;
begin
  Result := TResData_sw(ConvFromVar(AValue)).FValue;
end;

{ TFontPitch_sw }

class function TFontPitch_sw.GetTypeName: WideString;
begin
  Result := 'TFontPitch';
end;

class procedure TFontPitch_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fpDefault'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpDefault)),
    (Name: 'fpVariable'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpVariable)),
    (Name: 'fpFixed'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpFixed))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFontPitch_sw.ToVar(const AValue: TFontPitch): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontPitch_sw.FromVar(const AValue: OleVariant): TFontPitch;
begin
  Result := TFontPitch(Integer(AValue));
end;

{ TFontName_sw }

class function TFontName_sw.GetTypeName: WideString;
begin
  Result := 'TFontName';
end;

class function TFontName_sw.ToVar(const AValue: TFontName): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TFontName_sw.FromVar(const AValue: OleVariant): TFontName;
begin
  Result := TFontName(string_sw.FromVar(AValue));
end;

{ TFontCharset_sw }

class function TFontCharset_sw.GetTypeName: WideString;
begin
  Result := 'TFontCharset';
end;

class function TFontCharset_sw.ToVar(const AValue: TFontCharset): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontCharset_sw.FromVar(const AValue: OleVariant): TFontCharset;
begin
  Result := TFontCharset(Integer(AValue));
end;

{ TFontStyle_sw }

class function TFontStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFontStyle';
end;

class procedure TFontStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'fsBold'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsBold)),
    (Name: 'fsItalic'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsItalic)),
    (Name: 'fsUnderline'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsUnderline)),
    (Name: 'fsStrikeOut'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsStrikeOut))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TFontStyle_sw.ToVar(const AValue: TFontStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontStyle_sw.FromVar(const AValue: OleVariant): TFontStyle;
begin
  Result := TFontStyle(Integer(AValue));
end;

{ TFontStyles_sw }

class function TFontStyles_sw.GetTypeName: WideString;
begin
  Result := 'TFontStyles';
end;

class function TFontStyles_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontStyles);
end;

class function TFontStyles_sw.ToVar(const AValue: TFontStyles): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontStyles_sw.FromVar(const AValue: OleVariant): TFontStyles;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFontStylesBase_sw }

class function TFontStylesBase_sw.GetTypeName: WideString;
begin
  Result := 'TFontStylesBase';
end;

class function TFontStylesBase_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontStylesBase);
end;

class function TFontStylesBase_sw.ToVar(
  const AValue: TFontStylesBase): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontStylesBase_sw.FromVar(
  const AValue: OleVariant): TFontStylesBase;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFontData_sw }

function TFontData_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: HFont;

  if IsGet then
    Result := HFont_sw.ToVar(TFontData_sw(AObj).FValue.Handle)
  else
    TFontData_sw(AObj).FValue.Handle := HFont_sw.FromVar(AArgs[0]);
end;

function TFontData_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Height: Integer;

  if IsGet then
    Result := TFontData_sw(AObj).FValue.Height
  else
    TFontData_sw(AObj).FValue.Height := Integer(AArgs[0]);
end;

function TFontData_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Orientation: Integer;

  if IsGet then
    Result := TFontData_sw(AObj).FValue.Orientation
  else
    TFontData_sw(AObj).FValue.Orientation := Integer(AArgs[0]);
end;

function TFontData_Pitch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Pitch: TFontPitch;

  if IsGet then
    Result := TFontPitch_sw.ToVar(TFontData_sw(AObj).FValue.Pitch)
  else
    TFontData_sw(AObj).FValue.Pitch := TFontPitch_sw.FromVar(AArgs[0]);
end;

function TFontData_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Style: TFontStylesBase;

  if IsGet then
    Result := TFontStylesBase_sw.ToVar(TFontData_sw(AObj).FValue.Style)
  else
    TFontData_sw(AObj).FValue.Style := TFontStylesBase_sw.FromVar(AArgs[0]);
end;

function TFontData_Charset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Charset: TFontCharset;

  if IsGet then
    Result := TFontCharset_sw.ToVar(TFontData_sw(AObj).FValue.Charset)
  else
    TFontData_sw(AObj).FValue.Charset := TFontCharset_sw.FromVar(AArgs[0]);
end;

function TFontData_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: TFontDataName;

  if IsGet then
    Result := TFontDataName_sw.ToVar(TFontData_sw(AObj).FValue.Name)
  else
    TFontData_sw(AObj).FValue.Name := TFontDataName_sw.FromVar(AArgs[0]);
end;

function TFontData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TFontData_sw.Create as IDispatch;
end;

function TFontData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TFontData;

  // Implicit record copy method.
  Result := TFontData_sw.ToVar(TFontData(AObj));
end;

class function TFontData_sw.GetTypeName: WideString;
begin
  Result := 'TFontData';
end;

function TFontData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFontData_sw.Create;
  TFontData_sw(Result).FValue := FValue;
end;

class procedure TFontData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TFontData_Handle_si, HFont_sw);
  AData.AddField('Height', TFontData_Height_si, Integer_sw);
  AData.AddField('Orientation', TFontData_Orientation_si, Integer_sw);
  AData.AddField('Pitch', TFontData_Pitch_si, TFontPitch_sw);
  AData.AddField('Style', TFontData_Style_si, TFontStylesBase_sw);
  AData.AddField('Charset', TFontData_Charset_si, TFontCharset_sw);
  AData.AddField('Name', TFontData_Name_si, TFontDataName_sw);
  AData.AddFunction('Copy', TFontData_Copy_si, TFontData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFontData_Create_si, 0, False);
end;

class function TFontData_sw.ToVar(const AValue: TFontData): OleVariant;
var
  wrpr: TFontData_sw;
begin
  wrpr        := TFontData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFontData_sw.FromVar(const AValue: OleVariant): TFontData;
begin
  Result := TFontData_sw(ConvFromVar(AValue)).FValue;
end;

{ TPenStyle_sw }

class function TPenStyle_sw.GetTypeName: WideString;
begin
  Result := 'TPenStyle';
end;

class procedure TPenStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'psSolid'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psSolid)),
    (Name: 'psDash'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDash)),
    (Name: 'psDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDot)),
    (Name: 'psDashDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDashDot)),
    (Name: 'psDashDotDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDashDotDot)),
    (Name: 'psClear'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psClear)),
    (Name: 'psInsideFrame'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psInsideFrame)),
    (Name: 'psUserStyle'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psUserStyle)),
    (Name: 'psAlternate'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psAlternate))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TPenStyle_sw.ToVar(const AValue: TPenStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPenStyle_sw.FromVar(const AValue: OleVariant): TPenStyle;
begin
  Result := TPenStyle(Integer(AValue));
end;

{ TPenMode_sw }

class function TPenMode_sw.GetTypeName: WideString;
begin
  Result := 'TPenMode';
end;

class procedure TPenMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..15] of TLMDEnumerator = (
    (Name: 'pmBlack'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmBlack)),
    (Name: 'pmWhite'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmWhite)),
    (Name: 'pmNop'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNop)),
    (Name: 'pmNot'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNot)),
    (Name: 'pmCopy'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmCopy)),
    (Name: 'pmNotCopy'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNotCopy)),
    (Name: 'pmMergePenNot'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMergePenNot)),
    (Name: 'pmMaskPenNot'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMaskPenNot)),
    (Name: 'pmMergeNotPen'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMergeNotPen)),
    (Name: 'pmMaskNotPen'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMaskNotPen)),
    (Name: 'pmMerge'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMerge)),
    (Name: 'pmNotMerge'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNotMerge)),
    (Name: 'pmMask'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmMask)),
    (Name: 'pmNotMask'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNotMask)),
    (Name: 'pmXor'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmXor)),
    (Name: 'pmNotXor'; Value: Integer({$IFDEF LMDSCT_12}TPenMode.{$ENDIF}pmNotXor))
  );
begin
  AEnums := @ENUMS;
  ACount := 16;
end;

class function TPenMode_sw.ToVar(const AValue: TPenMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPenMode_sw.FromVar(const AValue: OleVariant): TPenMode;
begin
  Result := TPenMode(Integer(AValue));
end;

{ TPenData_sw }

function TPenData_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: HPen;

  if IsGet then
    Result := HPen_sw.ToVar(TPenData_sw(AObj).FValue.Handle)
  else
    TPenData_sw(AObj).FValue.Handle := HPen_sw.FromVar(AArgs[0]);
end;

function TPenData_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Color: TColor;

  if IsGet then
    Result := TColor_sw.ToVar(TPenData_sw(AObj).FValue.Color)
  else
    TPenData_sw(AObj).FValue.Color := TColor_sw.FromVar(AArgs[0]);
end;

function TPenData_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Width: Integer;

  if IsGet then
    Result := TPenData_sw(AObj).FValue.Width
  else
    TPenData_sw(AObj).FValue.Width := Integer(AArgs[0]);
end;

function TPenData_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Style: TPenStyle;

  if IsGet then
    Result := TPenStyle_sw.ToVar(TPenData_sw(AObj).FValue.Style)
  else
    TPenData_sw(AObj).FValue.Style := TPenStyle_sw.FromVar(AArgs[0]);
end;

function TPenData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPenData_sw.Create as IDispatch;
end;

function TPenData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPenData;

  // Implicit record copy method.
  Result := TPenData_sw.ToVar(TPenData(AObj));
end;

class function TPenData_sw.GetTypeName: WideString;
begin
  Result := 'TPenData';
end;

function TPenData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPenData_sw.Create;
  TPenData_sw(Result).FValue := FValue;
end;

class procedure TPenData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TPenData_Handle_si, HPen_sw);
  AData.AddField('Color', TPenData_Color_si, TColor_sw);
  AData.AddField('Width', TPenData_Width_si, Integer_sw);
  AData.AddField('Style', TPenData_Style_si, TPenStyle_sw);
  AData.AddFunction('Copy', TPenData_Copy_si, TPenData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPenData_Create_si, 0, False);
end;

class function TPenData_sw.ToVar(const AValue: TPenData): OleVariant;
var
  wrpr: TPenData_sw;
begin
  wrpr        := TPenData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPenData_sw.FromVar(const AValue: OleVariant): TPenData;
begin
  Result := TPenData_sw(ConvFromVar(AValue)).FValue;
end;

{ TBrushStyle_sw }

class function TBrushStyle_sw.GetTypeName: WideString;
begin
  Result := 'TBrushStyle';
end;

class procedure TBrushStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'bsSolid'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsSolid)),
    (Name: 'bsClear'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsClear)),
    (Name: 'bsHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsHorizontal)),
    (Name: 'bsVertical'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsVertical)),
    (Name: 'bsFDiagonal'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsFDiagonal)),
    (Name: 'bsBDiagonal'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsBDiagonal)),
    (Name: 'bsCross'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsCross)),
    (Name: 'bsDiagCross'; Value: Integer({$IFDEF LMDSCT_12}TBrushStyle.{$ENDIF}bsDiagCross))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TBrushStyle_sw.ToVar(const AValue: TBrushStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBrushStyle_sw.FromVar(const AValue: OleVariant): TBrushStyle;
begin
  Result := TBrushStyle(Integer(AValue));
end;

{ TBrushData_sw }

function TBrushData_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: HBrush;

  if IsGet then
    Result := HBrush_sw.ToVar(TBrushData_sw(AObj).FValue.Handle)
  else
    TBrushData_sw(AObj).FValue.Handle := HBrush_sw.FromVar(AArgs[0]);
end;

function TBrushData_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Color: TColor;

  if IsGet then
    Result := TColor_sw.ToVar(TBrushData_sw(AObj).FValue.Color)
  else
    TBrushData_sw(AObj).FValue.Color := TColor_sw.FromVar(AArgs[0]);
end;

function TBrushData_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Bitmap: TBitmap;

  if IsGet then
    Result := TBitmap_sw.ToVar(TBrushData_sw(AObj).FValue.Bitmap)
  else
    TBrushData_sw(AObj).FValue.Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TBrushData_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Style: TBrushStyle;

  if IsGet then
    Result := TBrushStyle_sw.ToVar(TBrushData_sw(AObj).FValue.Style)
  else
    TBrushData_sw(AObj).FValue.Style := TBrushStyle_sw.FromVar(AArgs[0]);
end;

function TBrushData_OwnsBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OwnsBitmap: Boolean;

  if IsGet then
    Result := TBrushData_sw(AObj).FValue.OwnsBitmap
  else
    TBrushData_sw(AObj).FValue.OwnsBitmap := Boolean(AArgs[0]);
end;

function TBrushData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TBrushData_sw.Create as IDispatch;
end;

function TBrushData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TBrushData;

  // Implicit record copy method.
  Result := TBrushData_sw.ToVar(TBrushData(AObj));
end;

class function TBrushData_sw.GetTypeName: WideString;
begin
  Result := 'TBrushData';
end;

function TBrushData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TBrushData_sw.Create;
  TBrushData_sw(Result).FValue := FValue;
end;

class procedure TBrushData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TBrushData_Handle_si, HBrush_sw);
  AData.AddField('Color', TBrushData_Color_si, TColor_sw);
  AData.AddField('Bitmap', TBrushData_Bitmap_si, TBitmap_sw);
  AData.AddField('Style', TBrushData_Style_si, TBrushStyle_sw);
  AData.AddField('OwnsBitmap', TBrushData_OwnsBitmap_si, Boolean_sw);
  AData.AddFunction('Copy', TBrushData_Copy_si, TBrushData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBrushData_Create_si, 0, False);
end;

class function TBrushData_sw.ToVar(const AValue: TBrushData): OleVariant;
var
  wrpr: TBrushData_sw;
begin
  wrpr        := TBrushData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TBrushData_sw.FromVar(const AValue: OleVariant): TBrushData;
begin
  Result := TBrushData_sw(ConvFromVar(AValue)).FValue;
end;

{ TResource_sw }

function TResource_RefCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RefCount: Integer;

  if IsGet then
    Result := TResource_sw(AObj).FValue.RefCount
  else
    TResource_sw(AObj).FValue.RefCount := Integer(AArgs[0]);
end;

function TResource_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(TResource_sw(AObj).FValue.Handle)
  else
    TResource_sw(AObj).FValue.Handle := THandle_sw.FromVar(AArgs[0]);
end;

function TResource_HashCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HashCode: Word;

  if IsGet then
    Result := TResource_sw(AObj).FValue.HashCode
  else
    TResource_sw(AObj).FValue.HashCode := Word(AArgs[0]);
end;

function TResource_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Data: TResData;

  if IsGet then
    Result := TResData_sw.ToVar(TResource_sw(AObj).FValue.Data)
  else
    TResource_sw(AObj).FValue.Data := TResData_sw.FromVar(AArgs[0]);
end;

function TResource_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Font: TFontData;

  if IsGet then
    Result := TFontData_sw.ToVar(TResource_sw(AObj).FValue.Font)
  else
    TResource_sw(AObj).FValue.Font := TFontData_sw.FromVar(AArgs[0]);
end;

function TResource_Pen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Pen: TPenData;

  if IsGet then
    Result := TPenData_sw.ToVar(TResource_sw(AObj).FValue.Pen)
  else
    TResource_sw(AObj).FValue.Pen := TPenData_sw.FromVar(AArgs[0]);
end;

function TResource_Brush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Brush: TBrushData;

  if IsGet then
    Result := TBrushData_sw.ToVar(TResource_sw(AObj).FValue.Brush)
  else
    TResource_sw(AObj).FValue.Brush := TBrushData_sw.FromVar(AArgs[0]);
end;

function TResource_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TResource_sw.Create as IDispatch;
end;

function TResource_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TResource;

  // Implicit record copy method.
  Result := TResource_sw.ToVar(TResource(AObj));
end;

class function TResource_sw.GetTypeName: WideString;
begin
  Result := 'TResource';
end;

function TResource_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TResource_sw.Create;
  TResource_sw(Result).FValue := FValue;
end;

class procedure TResource_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('RefCount', TResource_RefCount_si, Integer_sw);
  AData.AddField('Handle', TResource_Handle_si, THandle_sw);
  AData.AddField('HashCode', TResource_HashCode_si, Word_sw);
  AData.AddField('Data', TResource_Data_si, TResData_sw);
  AData.AddField('Font', TResource_Font_si, TFontData_sw);
  AData.AddField('Pen', TResource_Pen_si, TPenData_sw);
  AData.AddField('Brush', TResource_Brush_si, TBrushData_sw);
  AData.AddFunction('Copy', TResource_Copy_si, TResource_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TResource_Create_si, 0, False);
end;

class function TResource_sw.ToVar(const AValue: TResource): OleVariant;
var
  wrpr: TResource_sw;
begin
  wrpr        := TResource_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TResource_sw.FromVar(const AValue: OleVariant): TResource;
begin
  Result := TResource_sw(ConvFromVar(AValue)).FValue;
end;

{ TGraphicsObject_sw }

function TGraphicsObject_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TGraphicsObject(AObj).HandleAllocated();
end;

function TGraphicsObject_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TGraphicsObject(AObj).OnChange)
  else
    TGraphicsObject(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TGraphicsObject_sw.GetTypeName: WideString;
begin
  Result := 'TGraphicsObject';
end;

class function TGraphicsObject_sw.GetWrappedClass: TClass;
begin
  Result := TGraphicsObject;
end;

class procedure TGraphicsObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('HandleAllocated', TGraphicsObject_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProperty('OnChange', TGraphicsObject_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TGraphicsObject_sw.ToVar(
  const AValue: TGraphicsObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGraphicsObject_sw.FromVar(
  const AValue: OleVariant): TGraphicsObject;
begin
  Result := TGraphicsObject(ConvFromVar(AValue, TGraphicsObject));
end;

class function TGraphicsObject_sw.ClassToVar(
  AClass: TGraphicsObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGraphicsObject_sw.ClassFromVar(
  const AClass: OleVariant): TGraphicsObject_sc;
begin
  Result := TGraphicsObject_sc(ConvClsFromVar(AClass, TGraphicsObject));
end;

{ TFont_sw }

function TFont_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TFont_sw.ToVar(TFont_sc(AObj).Create());
end;

function TFont_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HFont read <getter> write <setter>;

  if IsGet then
    Result := HFont_sw.ToVar(TFont(AObj).Handle)
  else
    TFont(AObj).Handle := HFont_sw.FromVar(AArgs[0]);
end;

function TFont_PixelsPerInch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PixelsPerInch: Integer read <getter> write <sett...

  if IsGet then
    Result := TFont(AObj).PixelsPerInch
  else
    TFont(AObj).PixelsPerInch := Integer(AArgs[0]);
end;

function TFont_Charset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Charset: TFontCharset read <getter> write <setter>;

  if IsGet then
    Result := TFontCharset_sw.ToVar(TFont(AObj).Charset)
  else
    TFont(AObj).Charset := TFontCharset_sw.FromVar(AArgs[0]);
end;

function TFont_Color_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TFont(AObj).Color)
  else
    TFont(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TFont_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFont(AObj).Height
  else
    TFont(AObj).Height := Integer(AArgs[0]);
end;

function TFont_Name_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Name: TFontName read <getter> write <setter>;

  if IsGet then
    Result := TFontName_sw.ToVar(TFont(AObj).Name)
  else
    TFont(AObj).Name := TFontName_sw.FromVar(AArgs[0]);
end;

function TFont_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFont(AObj).Orientation
  else
    TFont(AObj).Orientation := Integer(AArgs[0]);
end;

function TFont_Pitch_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Pitch: TFontPitch read <getter> write <setter>;

  if IsGet then
    Result := TFontPitch_sw.ToVar(TFont(AObj).Pitch)
  else
    TFont(AObj).Pitch := TFontPitch_sw.FromVar(AArgs[0]);
end;

function TFont_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFont(AObj).Size
  else
    TFont(AObj).Size := Integer(AArgs[0]);
end;

function TFont_Style_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Style: TFontStyles read <getter> write <setter>;

  if IsGet then
    Result := TFontStyles_sw.ToVar(TFont(AObj).Style)
  else
    TFont(AObj).Style := TFontStyles_sw.FromVar(AArgs[0]);
end;

class function TFont_sw.GetTypeName: WideString;
begin
  Result := 'TFont';
end;

class function TFont_sw.GetWrappedClass: TClass;
begin
  Result := TFont;
end;

class procedure TFont_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Handle', TFont_Handle_si, HFont_sw, True, True, 0, False, False);
  AData.AddProperty('PixelsPerInch', TFont_PixelsPerInch_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Charset', TFont_Charset_si, TFontCharset_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TFont_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TFont_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Name', TFont_Name_si, TFontName_sw, True, True, 0, False, False);
  AData.AddProperty('Orientation', TFont_Orientation_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Pitch', TFont_Pitch_si, TFontPitch_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TFont_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TFont_Style_si, TFontStyles_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFont_Create_si, 0, False);
end;

class function TFont_sw.ToVar(const AValue: TFont): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFont_sw.FromVar(const AValue: OleVariant): TFont;
begin
  Result := TFont(ConvFromVar(AValue, TFont));
end;

class function TFont_sw.ClassToVar(AClass: TFont_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFont_sw.ClassFromVar(const AClass: OleVariant): TFont_sc;
begin
  Result := TFont_sc(ConvClsFromVar(AClass, TFont));
end;

{ TPen_sw }

function TPen_Create_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TPen_sw.ToVar(TPen_sc(AObj).Create());
end;

function TPen_Handle_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Handle: HPen read <getter> write <setter>;

  if IsGet then
    Result := HPen_sw.ToVar(TPen(AObj).Handle)
  else
    TPen(AObj).Handle := HPen_sw.FromVar(AArgs[0]);
end;

function TPen_Color_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TPen(AObj).Color)
  else
    TPen(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TPen_Mode_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Mode: TPenMode read <getter> write <setter>;

  if IsGet then
    Result := TPenMode_sw.ToVar(TPen(AObj).Mode)
  else
    TPen(AObj).Mode := TPenMode_sw.FromVar(AArgs[0]);
end;

function TPen_Style_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Style: TPenStyle read <getter> write <setter>;

  if IsGet then
    Result := TPenStyle_sw.ToVar(TPen(AObj).Style)
  else
    TPen(AObj).Style := TPenStyle_sw.FromVar(AArgs[0]);
end;

function TPen_Width_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPen(AObj).Width
  else
    TPen(AObj).Width := Integer(AArgs[0]);
end;

class function TPen_sw.GetTypeName: WideString;
begin
  Result := 'TPen';
end;

class function TPen_sw.GetWrappedClass: TClass;
begin
  Result := TPen;
end;

class procedure TPen_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Handle', TPen_Handle_si, HPen_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TPen_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Mode', TPen_Mode_si, TPenMode_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TPen_Style_si, TPenStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TPen_Width_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TPen_Create_si, 0, False);
end;

class function TPen_sw.ToVar(const AValue: TPen): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPen_sw.FromVar(const AValue: OleVariant): TPen;
begin
  Result := TPen(ConvFromVar(AValue, TPen));
end;

class function TPen_sw.ClassToVar(AClass: TPen_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPen_sw.ClassFromVar(const AClass: OleVariant): TPen_sc;
begin
  Result := TPen_sc(ConvClsFromVar(AClass, TPen));
end;

{ TBrush_sw }

function TBrush_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TBrush_sw.ToVar(TBrush_sc(AObj).Create());
end;

function TBrush_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bitmap: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TBrush(AObj).Bitmap)
  else
    TBrush(AObj).Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TBrush_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HBrush read <getter> write <setter>;

  if IsGet then
    Result := HBrush_sw.ToVar(TBrush(AObj).Handle)
  else
    TBrush(AObj).Handle := HBrush_sw.FromVar(AArgs[0]);
end;

function TBrush_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TBrush(AObj).Color)
  else
    TBrush(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TBrush_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TBrushStyle read <getter> write <setter>;

  if IsGet then
    Result := TBrushStyle_sw.ToVar(TBrush(AObj).Style)
  else
    TBrush(AObj).Style := TBrushStyle_sw.FromVar(AArgs[0]);
end;

class function TBrush_sw.GetTypeName: WideString;
begin
  Result := 'TBrush';
end;

class function TBrush_sw.GetWrappedClass: TClass;
begin
  Result := TBrush;
end;

class procedure TBrush_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Bitmap', TBrush_Bitmap_si, TBitmap_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TBrush_Handle_si, HBrush_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TBrush_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TBrush_Style_si, TBrushStyle_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TBrush_Create_si, 0, False);
end;

class function TBrush_sw.ToVar(const AValue: TBrush): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBrush_sw.FromVar(const AValue: OleVariant): TBrush;
begin
  Result := TBrush(ConvFromVar(AValue, TBrush));
end;

class function TBrush_sw.ClassToVar(AClass: TBrush_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBrush_sw.ClassFromVar(const AClass: OleVariant): TBrush_sc;
begin
  Result := TBrush_sc(ConvClsFromVar(AClass, TBrush));
end;

{ TFontRecall_sw }

function TFontRecall_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AFont: TFont);

  Result := TFontRecall_sw.ToVar(TFontRecall_sc(AObj).Create(TFont_sw.FromVar(
    AArgs[0])));
end;

class function TFontRecall_sw.GetTypeName: WideString;
begin
  Result := 'TFontRecall';
end;

class function TFontRecall_sw.GetWrappedClass: TClass;
begin
  Result := TFontRecall;
end;

class procedure TFontRecall_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TFontRecall_Create_si, 1, False);
end;

class function TFontRecall_sw.ToVar(const AValue: TFontRecall): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFontRecall_sw.FromVar(const AValue: OleVariant): TFontRecall;
begin
  Result := TFontRecall(ConvFromVar(AValue, TFontRecall));
end;

class function TFontRecall_sw.ClassToVar(AClass: TFontRecall_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFontRecall_sw.ClassFromVar(
  const AClass: OleVariant): TFontRecall_sc;
begin
  Result := TFontRecall_sc(ConvClsFromVar(AClass, TFontRecall));
end;

{ TPenRecall_sw }

function TPenRecall_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(APen: TPen);

  Result := TPenRecall_sw.ToVar(TPenRecall_sc(AObj).Create(TPen_sw.FromVar(
    AArgs[0])));
end;

class function TPenRecall_sw.GetTypeName: WideString;
begin
  Result := 'TPenRecall';
end;

class function TPenRecall_sw.GetWrappedClass: TClass;
begin
  Result := TPenRecall;
end;

class procedure TPenRecall_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TPenRecall_Create_si, 1, False);
end;

class function TPenRecall_sw.ToVar(const AValue: TPenRecall): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPenRecall_sw.FromVar(const AValue: OleVariant): TPenRecall;
begin
  Result := TPenRecall(ConvFromVar(AValue, TPenRecall));
end;

class function TPenRecall_sw.ClassToVar(AClass: TPenRecall_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPenRecall_sw.ClassFromVar(
  const AClass: OleVariant): TPenRecall_sc;
begin
  Result := TPenRecall_sc(ConvClsFromVar(AClass, TPenRecall));
end;

{ TBrushRecall_sw }

function TBrushRecall_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ABrush: TBrush);

  Result := TBrushRecall_sw.ToVar(TBrushRecall_sc(AObj).Create(TBrush_sw.
    FromVar(AArgs[0])));
end;

class function TBrushRecall_sw.GetTypeName: WideString;
begin
  Result := 'TBrushRecall';
end;

class function TBrushRecall_sw.GetWrappedClass: TClass;
begin
  Result := TBrushRecall;
end;

class procedure TBrushRecall_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TBrushRecall_Create_si, 1, False);
end;

class function TBrushRecall_sw.ToVar(const AValue: TBrushRecall): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBrushRecall_sw.FromVar(const AValue: OleVariant): TBrushRecall;
begin
  Result := TBrushRecall(ConvFromVar(AValue, TBrushRecall));
end;

class function TBrushRecall_sw.ClassToVar(AClass: TBrushRecall_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBrushRecall_sw.ClassFromVar(
  const AClass: OleVariant): TBrushRecall_sc;
begin
  Result := TBrushRecall_sc(ConvClsFromVar(AClass, TBrushRecall));
end;

{ TFillStyle_sw }

class function TFillStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFillStyle';
end;

class procedure TFillStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'fsSurface'; Value: Integer({$IFDEF LMDSCT_12}TFillStyle.{$ENDIF}fsSurface)),
    (Name: 'fsBorder'; Value: Integer({$IFDEF LMDSCT_12}TFillStyle.{$ENDIF}fsBorder))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFillStyle_sw.ToVar(const AValue: TFillStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFillStyle_sw.FromVar(const AValue: OleVariant): TFillStyle;
begin
  Result := TFillStyle(Integer(AValue));
end;

{ TFillMode_sw }

class function TFillMode_sw.GetTypeName: WideString;
begin
  Result := 'TFillMode';
end;

class procedure TFillMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'fmAlternate'; Value: Integer({$IFDEF LMDSCT_12}TFillMode.{$ENDIF}fmAlternate)),
    (Name: 'fmWinding'; Value: Integer({$IFDEF LMDSCT_12}TFillMode.{$ENDIF}fmWinding))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFillMode_sw.ToVar(const AValue: TFillMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFillMode_sw.FromVar(const AValue: OleVariant): TFillMode;
begin
  Result := TFillMode(Integer(AValue));
end;

{ TCanvasStates_sw }

class function TCanvasStates_sw.GetTypeName: WideString;
begin
  Result := 'TCanvasStates';
end;

class procedure TCanvasStates_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'csHandleValid'; Value: Integer({$IFDEF LMDSCT_12}TCanvasStates.{$ENDIF}csHandleValid)),
    (Name: 'csFontValid'; Value: Integer({$IFDEF LMDSCT_12}TCanvasStates.{$ENDIF}csFontValid)),
    (Name: 'csPenValid'; Value: Integer({$IFDEF LMDSCT_12}TCanvasStates.{$ENDIF}csPenValid)),
    (Name: 'csBrushValid'; Value: Integer({$IFDEF LMDSCT_12}TCanvasStates.{$ENDIF}csBrushValid))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TCanvasStates_sw.ToVar(const AValue: TCanvasStates): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCanvasStates_sw.FromVar(
  const AValue: OleVariant): TCanvasStates;
begin
  Result := TCanvasStates(Integer(AValue));
end;

{ TCanvasState_sw }

class function TCanvasState_sw.GetTypeName: WideString;
begin
  Result := 'TCanvasState';
end;

class function TCanvasState_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TCanvasState);
end;

class function TCanvasState_sw.ToVar(const AValue: TCanvasState): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TCanvasState_sw.FromVar(const AValue: OleVariant): TCanvasState;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCanvasOrientation_sw }

class function TCanvasOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TCanvasOrientation';
end;

class procedure TCanvasOrientation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'coLeftToRight'; Value: Integer({$IFDEF LMDSCT_12}TCanvasOrientation.{$ENDIF}coLeftToRight)),
    (Name: 'coRightToLeft'; Value: Integer({$IFDEF LMDSCT_12}TCanvasOrientation.{$ENDIF}coRightToLeft))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TCanvasOrientation_sw.ToVar(
  const AValue: TCanvasOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCanvasOrientation_sw.FromVar(
  const AValue: OleVariant): TCanvasOrientation;
begin
  Result := TCanvasOrientation(Integer(AValue));
end;

{ TTextFormats_sw }

class function TTextFormats_sw.GetTypeName: WideString;
begin
  Result := 'TTextFormats';
end;

class procedure TTextFormats_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..17] of TLMDEnumerator = (
    (Name: 'tfBottom'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfBottom)),
    (Name: 'tfCalcRect'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfCalcRect)),
    (Name: 'tfCenter'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfCenter)),
    (Name: 'tfEditControl'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfEditControl)),
    (Name: 'tfEndEllipsis'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfEndEllipsis)),
    (Name: 'tfPathEllipsis'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfPathEllipsis)),
    (Name: 'tfExpandTabs'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfExpandTabs)),
    (Name: 'tfExternalLeading'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfExternalLeading)),
    (Name: 'tfLeft'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfLeft)),
    (Name: 'tfModifyString'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfModifyString)),
    (Name: 'tfNoClip'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfNoClip)),
    (Name: 'tfNoPrefix'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfNoPrefix)),
    (Name: 'tfRight'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfRight)),
    (Name: 'tfRtlReading'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfRtlReading)),
    (Name: 'tfSingleLine'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfSingleLine)),
    (Name: 'tfTop'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfTop)),
    (Name: 'tfVerticalCenter'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfVerticalCenter)),
    (Name: 'tfWordBreak'; Value: Integer({$IFDEF LMDSCT_12}TTextFormats.{$ENDIF}tfWordBreak))
  );
begin
  AEnums := @ENUMS;
  ACount := 18;
end;

class function TTextFormats_sw.ToVar(const AValue: TTextFormats): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTextFormats_sw.FromVar(const AValue: OleVariant): TTextFormats;
begin
  Result := TTextFormats(Integer(AValue));
end;

{ TTextFormat_sw }

class function TTextFormat_sw.GetTypeName: WideString;
begin
  Result := 'TTextFormat';
end;

class function TTextFormat_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTextFormat);
end;

class function TTextFormat_sw.ToVar(const AValue: TTextFormat): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTextFormat_sw.FromVar(const AValue: OleVariant): TTextFormat;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCustomCanvas_sw }

function TCustomCanvas_Arc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Arc(X1: Integer; Y1: Integer; X2: Integer; Y2: ...

  TCustomCanvas(AObj).Arc(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(
    AArgs[6]), Integer(AArgs[7]));
end;

function TCustomCanvas_BrushCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap; c...

  TCustomCanvas(AObj).BrushCopy(TRect_sw.FromVar(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), TRect_sw.FromVar(AArgs[2]), TColor_sw.FromVar(AArgs[3]));
end;

function TCustomCanvas_Chord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Chord(X1: Integer; Y1: Integer; X2: Integer; Y2...

  TCustomCanvas(AObj).Chord(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(
    AArgs[6]), Integer(AArgs[7]));
end;

function TCustomCanvas_Draw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Draw(...); overload;

  case AArgsSize of
    3:
    begin
      TCustomCanvas(AObj).Draw(Integer(AArgs[0]), Integer(AArgs[1]), 
        TGraphic_sw.FromVar(AArgs[2]));
    end;
    4:
    begin
      TCustomCanvas(AObj).Draw(Integer(AArgs[0]), Integer(AArgs[1]), 
        TGraphic_sw.FromVar(AArgs[2]), Byte(AArgs[3]));
    end;
  else
    WrongArgCountError('Draw');
  end;
end;

function TCustomCanvas_DrawFocusRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawFocusRect(const Rect: TRect);

  TCustomCanvas(AObj).DrawFocusRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCustomCanvas_Ellipse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Ellipse(...); overload;

  case AArgsSize of
    4:
    begin
      TCustomCanvas(AObj).Ellipse(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
        AArgs[2]), Integer(AArgs[3]));
    end;
    1:
    begin
      TCustomCanvas(AObj).Ellipse(TRect_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Ellipse');
  end;
end;

function TCustomCanvas_FillRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FillRect(const Rect: TRect);

  TCustomCanvas(AObj).FillRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCustomCanvas_FloodFill_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FloodFill(X: Integer; Y: Integer; Color: TColor...

  TCustomCanvas(AObj).FloodFill(Integer(AArgs[0]), Integer(AArgs[1]), TColor_sw.
    FromVar(AArgs[2]), TFillStyle_sw.FromVar(AArgs[3]));
end;

function TCustomCanvas_FrameRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FrameRect(const Rect: TRect);

  TCustomCanvas(AObj).FrameRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCustomCanvas_LineTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LineTo(X: Integer; Y: Integer);

  TCustomCanvas(AObj).LineTo(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomCanvas_Lock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Lock;

  TCustomCanvas(AObj).Lock();
end;

function TCustomCanvas_MoveTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MoveTo(X: Integer; Y: Integer);

  TCustomCanvas(AObj).MoveTo(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomCanvas_Pie_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Pie(X1: Integer; Y1: Integer; X2: Integer; Y2: ...

  TCustomCanvas(AObj).Pie(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(
    AArgs[6]), Integer(AArgs[7]));
end;

function TCustomCanvas_Rectangle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Rectangle(...); overload;

  case AArgsSize of
    4:
    begin
      TCustomCanvas(AObj).Rectangle(Integer(AArgs[0]), Integer(AArgs[1]), 
        Integer(AArgs[2]), Integer(AArgs[3]));
    end;
    1:
    begin
      TCustomCanvas(AObj).Rectangle(TRect_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Rectangle');
  end;
end;

function TCustomCanvas_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TCustomCanvas(AObj).Refresh();
end;

function TCustomCanvas_RoundRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RoundRect(...); overload;

  case AArgsSize of
    6:
    begin
      TCustomCanvas(AObj).RoundRect(Integer(AArgs[0]), Integer(AArgs[1]), 
        Integer(AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), Integer(
        AArgs[5]));
    end;
    3:
    begin
      TCustomCanvas(AObj).RoundRect(TRect_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('RoundRect');
  end;
end;

function TCustomCanvas_StretchDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StretchDraw(const Rect: TRect; Graphic: TGraphic);

  TCustomCanvas(AObj).StretchDraw(TRect_sw.FromVar(AArgs[0]), TGraphic_sw.
    FromVar(AArgs[1]));
end;

function TCustomCanvas_TextExtent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextExtent(const Text: string): TSize;

  Result := TSize_sw.ToVar(TCustomCanvas(AObj).TextExtent(string(AArgs[0])));
end;

function TCustomCanvas_TextHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextHeight(const Text: string): Integer;

  Result := TCustomCanvas(AObj).TextHeight(string(AArgs[0]));
end;

function TCustomCanvas_TextOut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure TextOut(X: Integer; Y: Integer; const Text: str...

  TCustomCanvas(AObj).TextOut(Integer(AArgs[0]), Integer(AArgs[1]), string(
    AArgs[2]));
end;

function TCustomCanvas_TextRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
  v_2: string;
begin
  // procedure/function TextRect(...); overload;

  case AArgsSize of
    2:
    begin
      v_1 := TRect_sw.FromVar(AArgs[0]);
      v_2 := string(AArgs[1]);
      TCustomCanvas(AObj).TextRect(v_1, v_2);
      AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
      AssignRefParam(AArgs[1], v_2);
    end;
    3:
    begin
      v_1 := TRect_sw.FromVar(AArgs[0]);
      v_2 := string(AArgs[1]);
      TCustomCanvas(AObj).TextRect(v_1, v_2, TTextFormat_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
      AssignRefParam(AArgs[1], v_2);
    end;
    4:
    begin
      TCustomCanvas(AObj).TextRect(TRect_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), string(AArgs[3]));
    end;
  else
    WrongArgCountError('TextRect');
  end;
end;

function TCustomCanvas_TextWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextWidth(const Text: string): Integer;

  Result := TCustomCanvas(AObj).TextWidth(string(AArgs[0]));
end;

function TCustomCanvas_TryLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TryLock: Boolean;

  Result := TCustomCanvas(AObj).TryLock();
end;

function TCustomCanvas_Unlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Unlock;

  TCustomCanvas(AObj).Unlock();
end;

function TCustomCanvas_ClipRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClipRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TCustomCanvas(AObj).ClipRect);
end;

function TCustomCanvas_LockCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LockCount: Integer read <getter>;

  Result := TCustomCanvas(AObj).LockCount;
end;

function TCustomCanvas_CanvasOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanvasOrientation: TCanvasOrientation read <gett...

  Result := TCanvasOrientation_sw.ToVar(TCustomCanvas(AObj).CanvasOrientation);
end;

function TCustomCanvas_PenPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PenPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TCustomCanvas(AObj).PenPos)
  else
    TCustomCanvas(AObj).PenPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TCustomCanvas_Pixels_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pixels[X: Integer; Y: Integer]: TColor read <get...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomCanvas(AObj).Pixels[Integer(AArgs[0]), 
      Integer(AArgs[1])])
  else
    TCustomCanvas(AObj).Pixels[Integer(AArgs[0]), Integer(AArgs[1])] := 
      TColor_sw.FromVar(AArgs[2]);
end;

function TCustomCanvas_TextFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TextFlags: Longint read <getter> write <setter>;

  if IsGet then
    Result := TCustomCanvas(AObj).TextFlags
  else
    TCustomCanvas(AObj).TextFlags := Longint(AArgs[0]);
end;

function TCustomCanvas_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCanvas(AObj).OnChange)
  else
    TCustomCanvas(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomCanvas_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChanging: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomCanvas(AObj).OnChanging)
  else
    TCustomCanvas(AObj).OnChanging := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomCanvas_sw.GetTypeName: WideString;
begin
  Result := 'TCustomCanvas';
end;

class function TCustomCanvas_sw.GetWrappedClass: TClass;
begin
  Result := TCustomCanvas;
end;

class procedure TCustomCanvas_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Arc', TCustomCanvas_Arc_si, 8, False);
  AData.AddProcedure('BrushCopy', TCustomCanvas_BrushCopy_si, 4, False);
  AData.AddProcedure('Chord', TCustomCanvas_Chord_si, 8, False);
  AData.AddProcedure('Draw', TCustomCanvas_Draw_si, 3, True);
  AData.AddProcedure('DrawFocusRect', TCustomCanvas_DrawFocusRect_si, 1, False);
  AData.AddProcedure('Ellipse', TCustomCanvas_Ellipse_si, 1, True);
  AData.AddProcedure('FillRect', TCustomCanvas_FillRect_si, 1, False);
  AData.AddProcedure('FloodFill', TCustomCanvas_FloodFill_si, 4, False);
  AData.AddProcedure('FrameRect', TCustomCanvas_FrameRect_si, 1, False);
  AData.AddProcedure('LineTo', TCustomCanvas_LineTo_si, 2, False);
  AData.AddProcedure('Lock', TCustomCanvas_Lock_si, 0, False);
  AData.AddProcedure('MoveTo', TCustomCanvas_MoveTo_si, 2, False);
  AData.AddProcedure('Pie', TCustomCanvas_Pie_si, 8, False);
  AData.AddProcedure('Rectangle', TCustomCanvas_Rectangle_si, 1, True);
  AData.AddProcedure('Refresh', TCustomCanvas_Refresh_si, 0, False);
  AData.AddProcedure('RoundRect', TCustomCanvas_RoundRect_si, 3, True);
  AData.AddProcedure('StretchDraw', TCustomCanvas_StretchDraw_si, 2, False);
  AData.AddFunction('TextExtent', TCustomCanvas_TextExtent_si, TSize_sw, 1, False);
  AData.AddFunction('TextHeight', TCustomCanvas_TextHeight_si, Integer_sw, 1, False);
  AData.AddProcedure('TextOut', TCustomCanvas_TextOut_si, 3, False);
  AData.AddProcedure('TextRect', TCustomCanvas_TextRect_si, 2, True);
  AData.AddFunction('TextWidth', TCustomCanvas_TextWidth_si, Integer_sw, 1, False);
  AData.AddFunction('TryLock', TCustomCanvas_TryLock_si, Boolean_sw, 0, False);
  AData.AddProcedure('Unlock', TCustomCanvas_Unlock_si, 0, False);
  AData.AddProperty('ClipRect', TCustomCanvas_ClipRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('LockCount', TCustomCanvas_LockCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('CanvasOrientation', TCustomCanvas_CanvasOrientation_si, TCanvasOrientation_sw, True, False, 0, False, False);
  AData.AddProperty('PenPos', TCustomCanvas_PenPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Pixels', TCustomCanvas_Pixels_si, TColor_sw, True, True, 2, False, False);
  AData.AddProperty('TextFlags', TCustomCanvas_TextFlags_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TCustomCanvas_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnChanging', TCustomCanvas_OnChanging_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomCanvas_sw.ToVar(const AValue: TCustomCanvas): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomCanvas_sw.FromVar(
  const AValue: OleVariant): TCustomCanvas;
begin
  Result := TCustomCanvas(ConvFromVar(AValue, TCustomCanvas));
end;

class function TCustomCanvas_sw.ClassToVar(
  AClass: TCustomCanvas_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomCanvas_sw.ClassFromVar(
  const AClass: OleVariant): TCustomCanvas_sc;
begin
  Result := TCustomCanvas_sc(ConvClsFromVar(AClass, TCustomCanvas));
end;

{ TCanvas_sw }

function TCanvas_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TCanvas_sw.ToVar(TCanvas_sc(AObj).Create());
end;

function TCanvas_CopyRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyRect(const Dest: TRect; Canvas: TCanvas; co...

  TCanvas(AObj).CopyRect(TRect_sw.FromVar(AArgs[0]), TCanvas_sw.FromVar(
    AArgs[1]), TRect_sw.FromVar(AArgs[2]));
end;

function TCanvas_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TCanvas(AObj).HandleAllocated();
end;

function TCanvas_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HDC read <getter> write <setter>;

  if IsGet then
    Result := HDC_sw.ToVar(TCanvas(AObj).Handle)
  else
    TCanvas(AObj).Handle := HDC_sw.FromVar(AArgs[0]);
end;

function TCanvas_Brush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Brush: TBrush read <getter> write <setter>;

  if IsGet then
    Result := TBrush_sw.ToVar(TCanvas(AObj).Brush)
  else
    TCanvas(AObj).Brush := TBrush_sw.FromVar(AArgs[0]);
end;

function TCanvas_CopyMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CopyMode: TCopyMode read <getter> write <setter>;

  if IsGet then
    Result := TCopyMode_sw.ToVar(TCanvas(AObj).CopyMode)
  else
    TCanvas(AObj).CopyMode := TCopyMode_sw.FromVar(AArgs[0]);
end;

function TCanvas_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TCanvas(AObj).Font)
  else
    TCanvas(AObj).Font := TFont_sw.FromVar(AArgs[0]);
end;

function TCanvas_Pen_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Pen: TPen read <getter> write <setter>;

  if IsGet then
    Result := TPen_sw.ToVar(TCanvas(AObj).Pen)
  else
    TCanvas(AObj).Pen := TPen_sw.FromVar(AArgs[0]);
end;

class function TCanvas_sw.GetTypeName: WideString;
begin
  Result := 'TCanvas';
end;

class function TCanvas_sw.GetWrappedClass: TClass;
begin
  Result := TCanvas;
end;

class procedure TCanvas_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CopyRect', TCanvas_CopyRect_si, 3, False);
  AData.AddFunction('HandleAllocated', TCanvas_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProperty('Handle', TCanvas_Handle_si, HDC_sw, True, True, 0, False, False);
  AData.AddProperty('Brush', TCanvas_Brush_si, TBrush_sw, True, True, 0, False, False);
  AData.AddProperty('CopyMode', TCanvas_CopyMode_si, TCopyMode_sw, True, True, 0, False, False);
  AData.AddProperty('Font', TCanvas_Font_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('Pen', TCanvas_Pen_si, TPen_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TCanvas_Create_si, 0, False);
end;

class function TCanvas_sw.ToVar(const AValue: TCanvas): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCanvas_sw.FromVar(const AValue: OleVariant): TCanvas;
begin
  Result := TCanvas(ConvFromVar(AValue, TCanvas));
end;

class function TCanvas_sw.ClassToVar(AClass: TCanvas_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCanvas_sw.ClassFromVar(const AClass: OleVariant): TCanvas_sc;
begin
  Result := TCanvas_sc(ConvClsFromVar(AClass, TCanvas));
end;

{ TProgressStage_sw }

class function TProgressStage_sw.GetTypeName: WideString;
begin
  Result := 'TProgressStage';
end;

class procedure TProgressStage_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'psStarting'; Value: Integer({$IFDEF LMDSCT_12}TProgressStage.{$ENDIF}psStarting)),
    (Name: 'psRunning'; Value: Integer({$IFDEF LMDSCT_12}TProgressStage.{$ENDIF}psRunning)),
    (Name: 'psEnding'; Value: Integer({$IFDEF LMDSCT_12}TProgressStage.{$ENDIF}psEnding))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TProgressStage_sw.ToVar(
  const AValue: TProgressStage): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProgressStage_sw.FromVar(
  const AValue: OleVariant): TProgressStage;
begin
  Result := TProgressStage(Integer(AValue));
end;

{ TProgressEvent_sh }

function TProgressEvent_sh.GetHandler: TMethod;
var
  hdr: TProgressEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TProgressEvent_sh.Handler(Sender: TObject; Stage: TProgressStage;
  PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
var
  args: array[0..5] of OleVariant;
begin
  // procedure (Sender: TObject; Stage: TProgressStage; Percen...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TProgressStage_sw.ToVar(Stage);
  args[2] := PercentDone;
  args[3] := RedrawNow;
  args[4] := TRect_sw.ToVar(R);
  args[5] := Msg;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TProgressEvent_sw }

class function TProgressEvent_sw.GetTypeName: WideString;
begin
  Result := 'TProgressEvent';
end;

class function TProgressEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TProgressEvent_sh;
end;

class function TProgressEvent_sw.ToVar(
  const AValue: TProgressEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TProgressEvent_sw.FromVar(
  const AValue: OleVariant): TProgressEvent;
begin
  Result := TProgressEvent(ConvFromVar(AValue));
end;

class function TProgressEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TProgressEvent;
var
  hdlr: TProgressEvent_sh;
begin
  hdlr   := TProgressEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TProgressEvent_sw));
  Result := hdlr.Handler;
end;

{ TGraphic_sw }

function TGraphic_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TGraphic_sw.ToVar(TGraphic_sc(AObj).Create());
end;

function TGraphic_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const Filename: string);

  TGraphic(AObj).LoadFromFile(string(AArgs[0]));
end;

function TGraphic_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const Filename: string);

  TGraphic(AObj).SaveToFile(string(AArgs[0]));
end;

function TGraphic_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TGraphic(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TGraphic_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream);

  TGraphic(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TGraphic_LoadFromClipboardFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromClipboardFormat(AFormat: Word; AData: T...

  TGraphic(AObj).LoadFromClipboardFormat(Word(AArgs[0]), THandle_sw.FromVar(
    AArgs[1]), HPALETTE_sw.FromVar(AArgs[2]));
end;

function TGraphic_SaveToClipboardFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: THandle;
  v_3: HPALETTE;
begin
  // procedure SaveToClipboardFormat(var AFormat: Word; var AD...

  v_1 := Word(AArgs[0]);
  v_2 := THandle_sw.FromVar(AArgs[1]);
  v_3 := HPALETTE_sw.FromVar(AArgs[2]);
  TGraphic(AObj).SaveToClipboardFormat(v_1, v_2, v_3);
  AssignRefParam(AArgs[0], v_1);
  AssignRefParam(AArgs[1], THandle_sw.ToVar(v_2));
  AssignRefParam(AArgs[2], HPALETTE_sw.ToVar(v_3));
end;

function TGraphic_SetSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetSize(AWidth: Integer; AHeight: Integer);

  TGraphic(AObj).SetSize(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TGraphic_Empty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Empty: Boolean read <getter>;

  Result := TGraphic(AObj).Empty;
end;

function TGraphic_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGraphic(AObj).Height
  else
    TGraphic(AObj).Height := Integer(AArgs[0]);
end;

function TGraphic_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Modified: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TGraphic(AObj).Modified
  else
    TGraphic(AObj).Modified := Boolean(AArgs[0]);
end;

function TGraphic_Palette_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Palette: HPALETTE read <getter> write <setter>;

  if IsGet then
    Result := HPALETTE_sw.ToVar(TGraphic(AObj).Palette)
  else
    TGraphic(AObj).Palette := HPALETTE_sw.FromVar(AArgs[0]);
end;

function TGraphic_PaletteModified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PaletteModified: Boolean read <getter> write <se...

  if IsGet then
    Result := TGraphic(AObj).PaletteModified
  else
    TGraphic(AObj).PaletteModified := Boolean(AArgs[0]);
end;

function TGraphic_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TGraphic(AObj).Transparent
  else
    TGraphic(AObj).Transparent := Boolean(AArgs[0]);
end;

function TGraphic_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGraphic(AObj).Width
  else
    TGraphic(AObj).Width := Integer(AArgs[0]);
end;

function TGraphic_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TGraphic(AObj).OnChange)
  else
    TGraphic(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TGraphic_OnProgress_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnProgress: TProgressEvent read <getter> write <...

  if IsGet then
    Result := TProgressEvent_sw.ToVar(TGraphic(AObj).OnProgress)
  else
    TGraphic(AObj).OnProgress := TProgressEvent_sw.FromVar(AArgs[0]);
end;

function TGraphic_SupportsPartialTransparency_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SupportsPartialTransparency: Boolean read <getter>;

  Result := TGraphic(AObj).SupportsPartialTransparency;
end;

class function TGraphic_sw.GetTypeName: WideString;
begin
  Result := 'TGraphic';
end;

class function TGraphic_sw.GetWrappedClass: TClass;
begin
  Result := TGraphic;
end;

class procedure TGraphic_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('LoadFromFile', TGraphic_LoadFromFile_si, 1, False);
  AData.AddProcedure('SaveToFile', TGraphic_SaveToFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TGraphic_LoadFromStream_si, 1, False);
  AData.AddProcedure('SaveToStream', TGraphic_SaveToStream_si, 1, False);
  AData.AddProcedure('LoadFromClipboardFormat', TGraphic_LoadFromClipboardFormat_si, 3, False);
  AData.AddProcedure('SaveToClipboardFormat', TGraphic_SaveToClipboardFormat_si, 3, False);
  AData.AddProcedure('SetSize', TGraphic_SetSize_si, 2, False);
  AData.AddProperty('Empty', TGraphic_Empty_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Height', TGraphic_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Modified', TGraphic_Modified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Palette', TGraphic_Palette_si, HPALETTE_sw, True, True, 0, False, False);
  AData.AddProperty('PaletteModified', TGraphic_PaletteModified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Transparent', TGraphic_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TGraphic_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TGraphic_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnProgress', TGraphic_OnProgress_si, TProgressEvent_sw, True, True, 0, False, False);
  AData.AddProperty('SupportsPartialTransparency', TGraphic_SupportsPartialTransparency_si, Boolean_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TGraphic_Create_si, 0, False);
end;

class function TGraphic_sw.ToVar(const AValue: TGraphic): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGraphic_sw.FromVar(const AValue: OleVariant): TGraphic;
begin
  Result := TGraphic(ConvFromVar(AValue, TGraphic));
end;

class function TGraphic_sw.ClassToVar(AClass: TGraphic_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGraphic_sw.ClassFromVar(const AClass: OleVariant): TGraphic_sc;
begin
  Result := TGraphic_sc(ConvClsFromVar(AClass, TGraphic));
end;

{ TGraphicClass_sw }

class function TGraphicClass_sw.GetTypeName: WideString;
begin
  Result := 'TGraphicClass';
end;

class function TGraphicClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TGraphic;
end;

class function TGraphicClass_sw.ToVar(const AValue: TGraphicClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGraphicClass_sw.FromVar(
  const AValue: OleVariant): TGraphicClass;
begin
  Result := TGraphicClass(ConvFromVar(AValue, TGraphic));
end;

{ TPicture_sw }

function TPicture_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TPicture_sw.ToVar(TPicture_sc(AObj).Create());
end;

function TPicture_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const Filename: string);

  TPicture(AObj).LoadFromFile(string(AArgs[0]));
end;

function TPicture_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const Filename: string);

  TPicture(AObj).SaveToFile(string(AArgs[0]));
end;

function TPicture_LoadFromClipboardFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromClipboardFormat(AFormat: Word; AData: T...

  TPicture(AObj).LoadFromClipboardFormat(Word(AArgs[0]), THandle_sw.FromVar(
    AArgs[1]), HPALETTE_sw.FromVar(AArgs[2]));
end;

function TPicture_SaveToClipboardFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: THandle;
  v_3: HPALETTE;
begin
  // procedure SaveToClipboardFormat(var AFormat: Word; var AD...

  v_1 := Word(AArgs[0]);
  v_2 := THandle_sw.FromVar(AArgs[1]);
  v_3 := HPALETTE_sw.FromVar(AArgs[2]);
  TPicture(AObj).SaveToClipboardFormat(v_1, v_2, v_3);
  AssignRefParam(AArgs[0], v_1);
  AssignRefParam(AArgs[1], THandle_sw.ToVar(v_2));
  AssignRefParam(AArgs[2], HPALETTE_sw.ToVar(v_3));
end;

function TPicture_SupportsClipboardFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function SupportsClipboardFormat(AFormat: Word): Bo...

  Result := TPicture_sc(AObj).SupportsClipboardFormat(Word(AArgs[0]));
end;

function TPicture_RegisterFileFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RegisterFileFormat(const AExtension: stri...

  TPicture_sc(AObj).RegisterFileFormat(string(AArgs[0]), string(AArgs[1]), 
    TGraphicClass_sw.FromVar(AArgs[2]));
end;

function TPicture_RegisterClipboardFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RegisterClipboardFormat(AFormat: Word; AG...

  TPicture_sc(AObj).RegisterClipboardFormat(Word(AArgs[0]), TGraphicClass_sw.
    FromVar(AArgs[1]));
end;

function TPicture_UnregisterGraphicClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure UnregisterGraphicClass(AClass: TGraphicCl...

  TPicture_sc(AObj).UnregisterGraphicClass(TGraphicClass_sw.FromVar(AArgs[0]));
end;

function TPicture_RegisterFileFormatRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RegisterFileFormatRes(const AExtension: s...

  TPicture_sc(AObj).RegisterFileFormatRes(string(AArgs[0]), Integer(AArgs[1]), 
    TGraphicClass_sw.FromVar(AArgs[2]));
end;

function TPicture_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bitmap: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TPicture(AObj).Bitmap)
  else
    TPicture(AObj).Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TPicture_Graphic_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Graphic: TGraphic read <getter> write <setter>;

  if IsGet then
    Result := TGraphic_sw.ToVar(TPicture(AObj).Graphic)
  else
    TPicture(AObj).Graphic := TGraphic_sw.FromVar(AArgs[0]);
end;

function TPicture_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter>;

  Result := TPicture(AObj).Height;
end;

function TPicture_Icon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Icon: TIcon read <getter> write <setter>;

  if IsGet then
    Result := TIcon_sw.ToVar(TPicture(AObj).Icon)
  else
    TPicture(AObj).Icon := TIcon_sw.FromVar(AArgs[0]);
end;

function TPicture_Metafile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Metafile: TMetafile read <getter> write <setter>;

  if IsGet then
    Result := TMetafile_sw.ToVar(TPicture(AObj).Metafile)
  else
    TPicture(AObj).Metafile := TMetafile_sw.FromVar(AArgs[0]);
end;

function TPicture_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter>;

  Result := TPicture(AObj).Width;
end;

function TPicture_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TPicture(AObj).OnChange)
  else
    TPicture(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TPicture_OnProgress_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnProgress: TProgressEvent read <getter> write <...

  if IsGet then
    Result := TProgressEvent_sw.ToVar(TPicture(AObj).OnProgress)
  else
    TPicture(AObj).OnProgress := TProgressEvent_sw.FromVar(AArgs[0]);
end;

class function TPicture_sw.GetTypeName: WideString;
begin
  Result := 'TPicture';
end;

class function TPicture_sw.GetWrappedClass: TClass;
begin
  Result := TPicture;
end;

class procedure TPicture_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('LoadFromFile', TPicture_LoadFromFile_si, 1, False);
  AData.AddProcedure('SaveToFile', TPicture_SaveToFile_si, 1, False);
  AData.AddProcedure('LoadFromClipboardFormat', TPicture_LoadFromClipboardFormat_si, 3, False);
  AData.AddProcedure('SaveToClipboardFormat', TPicture_SaveToClipboardFormat_si, 3, False);
  AData.AddProperty('Bitmap', TPicture_Bitmap_si, TBitmap_sw, True, True, 0, False, False);
  AData.AddProperty('Graphic', TPicture_Graphic_si, TGraphic_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TPicture_Height_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Icon', TPicture_Icon_si, TIcon_sw, True, True, 0, False, False);
  AData.AddProperty('Metafile', TPicture_Metafile_si, TMetafile_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TPicture_Width_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OnChange', TPicture_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnProgress', TPicture_OnProgress_si, TProgressEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TPicture_Create_si, 0, False);
  AData.AddClassFunction('SupportsClipboardFormat', TPicture_SupportsClipboardFormat_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('RegisterFileFormat', TPicture_RegisterFileFormat_si, 3, False);
  AData.AddClassProcedure('RegisterClipboardFormat', TPicture_RegisterClipboardFormat_si, 2, False);
  AData.AddClassProcedure('UnregisterGraphicClass', TPicture_UnregisterGraphicClass_si, 1, False);
  AData.AddClassProcedure('RegisterFileFormatRes', TPicture_RegisterFileFormatRes_si, 3, False);
end;

class function TPicture_sw.ToVar(const AValue: TPicture): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPicture_sw.FromVar(const AValue: OleVariant): TPicture;
begin
  Result := TPicture(ConvFromVar(AValue, TPicture));
end;

class function TPicture_sw.ClassToVar(AClass: TPicture_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPicture_sw.ClassFromVar(const AClass: OleVariant): TPicture_sc;
begin
  Result := TPicture_sc(ConvClsFromVar(AClass, TPicture));
end;

{ TMetafileCanvas_sw }

function TMetafileCanvas_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AMetafile: TMetafile; ReferenceDevice:...

  Result := TMetafileCanvas_sw.ToVar(TMetafileCanvas_sc(AObj).Create(
    TMetafile_sw.FromVar(AArgs[0]), HDC_sw.FromVar(AArgs[1])));
end;

function TMetafileCanvas_CreateWithComment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateWithComment(AMetafile: TMetafile; Refer...

  Result := TMetafileCanvas_sw.ToVar(TMetafileCanvas_sc(AObj).CreateWithComment(
    TMetafile_sw.FromVar(AArgs[0]), HDC_sw.FromVar(AArgs[1]), string(AArgs[2]),
    string(AArgs[3])));
end;

class function TMetafileCanvas_sw.GetTypeName: WideString;
begin
  Result := 'TMetafileCanvas';
end;

class function TMetafileCanvas_sw.GetWrappedClass: TClass;
begin
  Result := TMetafileCanvas;
end;

class procedure TMetafileCanvas_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TMetafileCanvas_Create_si, 2, False);
  AData.AddConstructor('CreateWithComment', TMetafileCanvas_CreateWithComment_si, 4, False);
end;

class function TMetafileCanvas_sw.ToVar(
  const AValue: TMetafileCanvas): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMetafileCanvas_sw.FromVar(
  const AValue: OleVariant): TMetafileCanvas;
begin
  Result := TMetafileCanvas(ConvFromVar(AValue, TMetafileCanvas));
end;

class function TMetafileCanvas_sw.ClassToVar(
  AClass: TMetafileCanvas_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMetafileCanvas_sw.ClassFromVar(
  const AClass: OleVariant): TMetafileCanvas_sc;
begin
  Result := TMetafileCanvas_sc(ConvClsFromVar(AClass, TMetafileCanvas));
end;

{ TSharedImage_sw }

function TSharedImage_RefCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RefCount: Integer read <getter>;

  Result := TSharedImage_sacc(TSharedImage(AObj)).RefCount;
end;

class function TSharedImage_sw.GetTypeName: WideString;
begin
  Result := 'TSharedImage';
end;

class function TSharedImage_sw.GetWrappedClass: TClass;
begin
  Result := TSharedImage;
end;

class procedure TSharedImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('RefCount', TSharedImage_RefCount_si, Integer_sw, True, False, 0, True, False);
end;

class function TSharedImage_sw.ToVar(const AValue: TSharedImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSharedImage_sw.FromVar(const AValue: OleVariant): TSharedImage;
begin
  Result := TSharedImage(ConvFromVar(AValue, TSharedImage));
end;

class function TSharedImage_sw.ClassToVar(AClass: TSharedImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSharedImage_sw.ClassFromVar(
  const AClass: OleVariant): TSharedImage_sc;
begin
  Result := TSharedImage_sc(ConvClsFromVar(AClass, TSharedImage));
end;

{ TMetafileImage_sw }

class function TMetafileImage_sw.GetTypeName: WideString;
begin
  Result := 'TMetafileImage';
end;

class function TMetafileImage_sw.GetWrappedClass: TClass;
begin
  Result := TMetafileImage;
end;

class procedure TMetafileImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TMetafileImage_sw.ToVar(
  const AValue: TMetafileImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMetafileImage_sw.FromVar(
  const AValue: OleVariant): TMetafileImage;
begin
  Result := TMetafileImage(ConvFromVar(AValue, TMetafileImage));
end;

class function TMetafileImage_sw.ClassToVar(
  AClass: TMetafileImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMetafileImage_sw.ClassFromVar(
  const AClass: OleVariant): TMetafileImage_sc;
begin
  Result := TMetafileImage_sc(ConvClsFromVar(AClass, TMetafileImage));
end;

{ TMetafile_sw }

function TMetafile_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TMetafile(AObj).Clear();
end;

function TMetafile_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TMetafile(AObj).HandleAllocated();
end;

function TMetafile_ReleaseHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReleaseHandle: HENHMETAFILE;

  Result := HENHMETAFILE_sw.ToVar(TMetafile(AObj).ReleaseHandle());
end;

function TMetafile_CreatedBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CreatedBy: string read <getter>;

  Result := TMetafile(AObj).CreatedBy;
end;

function TMetafile_Description_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Description: string read <getter>;

  Result := TMetafile(AObj).Description;
end;

function TMetafile_Enhanced_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enhanced: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TMetafile(AObj).Enhanced
  else
    TMetafile(AObj).Enhanced := Boolean(AArgs[0]);
end;

function TMetafile_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HENHMETAFILE read <getter> write <setter>;

  if IsGet then
    Result := HENHMETAFILE_sw.ToVar(TMetafile(AObj).Handle)
  else
    TMetafile(AObj).Handle := HENHMETAFILE_sw.FromVar(AArgs[0]);
end;

function TMetafile_MMWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MMWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TMetafile(AObj).MMWidth
  else
    TMetafile(AObj).MMWidth := Integer(AArgs[0]);
end;

function TMetafile_MMHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MMHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TMetafile(AObj).MMHeight
  else
    TMetafile(AObj).MMHeight := Integer(AArgs[0]);
end;

function TMetafile_Inch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Inch: Word read <getter> write <setter>;

  if IsGet then
    Result := TMetafile(AObj).Inch
  else
    TMetafile(AObj).Inch := Word(AArgs[0]);
end;

class function TMetafile_sw.GetTypeName: WideString;
begin
  Result := 'TMetafile';
end;

class function TMetafile_sw.GetWrappedClass: TClass;
begin
  Result := TMetafile;
end;

class procedure TMetafile_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TMetafile_Clear_si, 0, False);
  AData.AddFunction('HandleAllocated', TMetafile_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddFunction('ReleaseHandle', TMetafile_ReleaseHandle_si, HENHMETAFILE_sw, 0, False);
  AData.AddProperty('CreatedBy', TMetafile_CreatedBy_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('Description', TMetafile_Description_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('Enhanced', TMetafile_Enhanced_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TMetafile_Handle_si, HENHMETAFILE_sw, True, True, 0, False, False);
  AData.AddProperty('MMWidth', TMetafile_MMWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MMHeight', TMetafile_MMHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Inch', TMetafile_Inch_si, Word_sw, True, True, 0, False, False);
end;

class function TMetafile_sw.ToVar(const AValue: TMetafile): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMetafile_sw.FromVar(const AValue: OleVariant): TMetafile;
begin
  Result := TMetafile(ConvFromVar(AValue, TMetafile));
end;

class function TMetafile_sw.ClassToVar(AClass: TMetafile_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMetafile_sw.ClassFromVar(
  const AClass: OleVariant): TMetafile_sc;
begin
  Result := TMetafile_sc(ConvClsFromVar(AClass, TMetafile));
end;

{ TBitmapImage_sw }

class function TBitmapImage_sw.GetTypeName: WideString;
begin
  Result := 'TBitmapImage';
end;

class function TBitmapImage_sw.GetWrappedClass: TClass;
begin
  Result := TBitmapImage;
end;

class procedure TBitmapImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBitmapImage_sw.ToVar(const AValue: TBitmapImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBitmapImage_sw.FromVar(const AValue: OleVariant): TBitmapImage;
begin
  Result := TBitmapImage(ConvFromVar(AValue, TBitmapImage));
end;

class function TBitmapImage_sw.ClassToVar(AClass: TBitmapImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBitmapImage_sw.ClassFromVar(
  const AClass: OleVariant): TBitmapImage_sc;
begin
  Result := TBitmapImage_sc(ConvClsFromVar(AClass, TBitmapImage));
end;

{ TBitmapHandleType_sw }

class function TBitmapHandleType_sw.GetTypeName: WideString;
begin
  Result := 'TBitmapHandleType';
end;

class procedure TBitmapHandleType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'bmDIB'; Value: Integer({$IFDEF LMDSCT_12}TBitmapHandleType.{$ENDIF}bmDIB)),
    (Name: 'bmDDB'; Value: Integer({$IFDEF LMDSCT_12}TBitmapHandleType.{$ENDIF}bmDDB))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TBitmapHandleType_sw.ToVar(
  const AValue: TBitmapHandleType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBitmapHandleType_sw.FromVar(
  const AValue: OleVariant): TBitmapHandleType;
begin
  Result := TBitmapHandleType(Integer(AValue));
end;

{ TPixelFormat_sw }

class function TPixelFormat_sw.GetTypeName: WideString;
begin
  Result := 'TPixelFormat';
end;

class procedure TPixelFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'pfDevice'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pfDevice)),
    (Name: 'pf1bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf1bit)),
    (Name: 'pf4bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf4bit)),
    (Name: 'pf8bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf8bit)),
    (Name: 'pf15bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf15bit)),
    (Name: 'pf16bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf16bit)),
    (Name: 'pf24bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf24bit)),
    (Name: 'pf32bit'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pf32bit)),
    (Name: 'pfCustom'; Value: Integer({$IFDEF LMDSCT_12}TPixelFormat.{$ENDIF}pfCustom))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TPixelFormat_sw.ToVar(const AValue: TPixelFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPixelFormat_sw.FromVar(const AValue: OleVariant): TPixelFormat;
begin
  Result := TPixelFormat(Integer(AValue));
end;

{ TAlphaFormat_sw }

class function TAlphaFormat_sw.GetTypeName: WideString;
begin
  Result := 'TAlphaFormat';
end;

class procedure TAlphaFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'afIgnored'; Value: Integer({$IFDEF LMDSCT_12}TAlphaFormat.{$ENDIF}afIgnored)),
    (Name: 'afDefined'; Value: Integer({$IFDEF LMDSCT_12}TAlphaFormat.{$ENDIF}afDefined)),
    (Name: 'afPremultiplied'; Value: Integer({$IFDEF LMDSCT_12}TAlphaFormat.{$ENDIF}afPremultiplied))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TAlphaFormat_sw.ToVar(const AValue: TAlphaFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAlphaFormat_sw.FromVar(const AValue: OleVariant): TAlphaFormat;
begin
  Result := TAlphaFormat(Integer(AValue));
end;

{ TTransparentMode_sw }

class function TTransparentMode_sw.GetTypeName: WideString;
begin
  Result := 'TTransparentMode';
end;

class procedure TTransparentMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tmAuto'; Value: Integer({$IFDEF LMDSCT_12}TTransparentMode.{$ENDIF}tmAuto)),
    (Name: 'tmFixed'; Value: Integer({$IFDEF LMDSCT_12}TTransparentMode.{$ENDIF}tmFixed))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTransparentMode_sw.ToVar(
  const AValue: TTransparentMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTransparentMode_sw.FromVar(
  const AValue: OleVariant): TTransparentMode;
begin
  Result := TTransparentMode(Integer(AValue));
end;

{ TBitmap_sw }

function TBitmap_Dormant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Dormant;

  TBitmap(AObj).Dormant();
end;

function TBitmap_FreeImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeImage;

  TBitmap(AObj).FreeImage();
end;

function TBitmap_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TBitmap(AObj).HandleAllocated();
end;

function TBitmap_Mask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Mask(TransparentColor: TColor);

  TBitmap(AObj).Mask(TColor_sw.FromVar(AArgs[0]));
end;

function TBitmap_ReleaseHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReleaseHandle: HBITMAP;

  Result := HBITMAP_sw.ToVar(TBitmap(AObj).ReleaseHandle());
end;

function TBitmap_ReleaseMaskHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReleaseMaskHandle: HBITMAP;

  Result := HBITMAP_sw.ToVar(TBitmap(AObj).ReleaseMaskHandle());
end;

function TBitmap_ReleasePalette_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReleasePalette: HPALETTE;

  Result := HPALETTE_sw.ToVar(TBitmap(AObj).ReleasePalette());
end;

function TBitmap_LoadFromResourceName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromResourceName(Instance: THandle; const R...

  TBitmap(AObj).LoadFromResourceName(THandle_sw.FromVar(AArgs[0]), string(
    AArgs[1]));
end;

function TBitmap_LoadFromResourceID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromResourceID(Instance: THandle; ResID: In...

  TBitmap(AObj).LoadFromResourceID(THandle_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function TBitmap_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TBitmap(AObj).Canvas);
end;

function TBitmap_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HBITMAP read <getter> write <setter>;

  if IsGet then
    Result := HBITMAP_sw.ToVar(TBitmap(AObj).Handle)
  else
    TBitmap(AObj).Handle := HBITMAP_sw.FromVar(AArgs[0]);
end;

function TBitmap_HandleType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HandleType: TBitmapHandleType read <getter> writ...

  if IsGet then
    Result := TBitmapHandleType_sw.ToVar(TBitmap(AObj).HandleType)
  else
    TBitmap(AObj).HandleType := TBitmapHandleType_sw.FromVar(AArgs[0]);
end;

function TBitmap_IgnorePalette_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IgnorePalette: Boolean read <getter> write <sett...

  if IsGet then
    Result := TBitmap(AObj).IgnorePalette
  else
    TBitmap(AObj).IgnorePalette := Boolean(AArgs[0]);
end;

function TBitmap_MaskHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaskHandle: HBITMAP read <getter> write <setter>;

  if IsGet then
    Result := HBITMAP_sw.ToVar(TBitmap(AObj).MaskHandle)
  else
    TBitmap(AObj).MaskHandle := HBITMAP_sw.FromVar(AArgs[0]);
end;

function TBitmap_Monochrome_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Monochrome: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TBitmap(AObj).Monochrome
  else
    TBitmap(AObj).Monochrome := Boolean(AArgs[0]);
end;

function TBitmap_PixelFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PixelFormat: TPixelFormat read <getter> write <s...

  if IsGet then
    Result := TPixelFormat_sw.ToVar(TBitmap(AObj).PixelFormat)
  else
    TBitmap(AObj).PixelFormat := TPixelFormat_sw.FromVar(AArgs[0]);
end;

function TBitmap_TransparentColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TransparentColor: TColor read <getter> write <se...

  if IsGet then
    Result := TColor_sw.ToVar(TBitmap(AObj).TransparentColor)
  else
    TBitmap(AObj).TransparentColor := TColor_sw.FromVar(AArgs[0]);
end;

function TBitmap_TransparentMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TransparentMode: TTransparentMode read <getter> ...

  if IsGet then
    Result := TTransparentMode_sw.ToVar(TBitmap(AObj).TransparentMode)
  else
    TBitmap(AObj).TransparentMode := TTransparentMode_sw.FromVar(AArgs[0]);
end;

function TBitmap_AlphaFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AlphaFormat: TAlphaFormat read <getter> write <s...

  if IsGet then
    Result := TAlphaFormat_sw.ToVar(TBitmap(AObj).AlphaFormat)
  else
    TBitmap(AObj).AlphaFormat := TAlphaFormat_sw.FromVar(AArgs[0]);
end;

class function TBitmap_sw.GetTypeName: WideString;
begin
  Result := 'TBitmap';
end;

class function TBitmap_sw.GetWrappedClass: TClass;
begin
  Result := TBitmap;
end;

class procedure TBitmap_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Dormant', TBitmap_Dormant_si, 0, False);
  AData.AddProcedure('FreeImage', TBitmap_FreeImage_si, 0, False);
  AData.AddFunction('HandleAllocated', TBitmap_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProcedure('Mask', TBitmap_Mask_si, 1, False);
  AData.AddFunction('ReleaseHandle', TBitmap_ReleaseHandle_si, HBITMAP_sw, 0, False);
  AData.AddFunction('ReleaseMaskHandle', TBitmap_ReleaseMaskHandle_si, HBITMAP_sw, 0, False);
  AData.AddFunction('ReleasePalette', TBitmap_ReleasePalette_si, HPALETTE_sw, 0, False);
  AData.AddProcedure('LoadFromResourceName', TBitmap_LoadFromResourceName_si, 2, False);
  AData.AddProcedure('LoadFromResourceID', TBitmap_LoadFromResourceID_si, 2, False);
  AData.AddProperty('Canvas', TBitmap_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TBitmap_Handle_si, HBITMAP_sw, True, True, 0, False, False);
  AData.AddProperty('HandleType', TBitmap_HandleType_si, TBitmapHandleType_sw, True, True, 0, False, False);
  AData.AddProperty('IgnorePalette', TBitmap_IgnorePalette_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaskHandle', TBitmap_MaskHandle_si, HBITMAP_sw, True, True, 0, False, False);
  AData.AddProperty('Monochrome', TBitmap_Monochrome_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PixelFormat', TBitmap_PixelFormat_si, TPixelFormat_sw, True, True, 0, False, False);
  AData.AddProperty('TransparentColor', TBitmap_TransparentColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TransparentMode', TBitmap_TransparentMode_si, TTransparentMode_sw, True, True, 0, False, False);
  AData.AddProperty('AlphaFormat', TBitmap_AlphaFormat_si, TAlphaFormat_sw, True, True, 0, False, False);
end;

class function TBitmap_sw.ToVar(const AValue: TBitmap): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBitmap_sw.FromVar(const AValue: OleVariant): TBitmap;
begin
  Result := TBitmap(ConvFromVar(AValue, TBitmap));
end;

class function TBitmap_sw.ClassToVar(AClass: TBitmap_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBitmap_sw.ClassFromVar(const AClass: OleVariant): TBitmap_sc;
begin
  Result := TBitmap_sc(ConvClsFromVar(AClass, TBitmap));
end;

{ TIconImage_sw }

class function TIconImage_sw.GetTypeName: WideString;
begin
  Result := 'TIconImage';
end;

class function TIconImage_sw.GetWrappedClass: TClass;
begin
  Result := TIconImage;
end;

class procedure TIconImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TIconImage_sw.ToVar(const AValue: TIconImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIconImage_sw.FromVar(const AValue: OleVariant): TIconImage;
begin
  Result := TIconImage(ConvFromVar(AValue, TIconImage));
end;

class function TIconImage_sw.ClassToVar(AClass: TIconImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIconImage_sw.ClassFromVar(
  const AClass: OleVariant): TIconImage_sc;
begin
  Result := TIconImage_sc(ConvClsFromVar(AClass, TIconImage));
end;

{ TIcon_sw }

function TIcon_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TIcon(AObj).HandleAllocated();
end;

function TIcon_ReleaseHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReleaseHandle: HICON;

  Result := HICON_sw.ToVar(TIcon(AObj).ReleaseHandle());
end;

function TIcon_LoadFromResourceName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromResourceName(Instance: THandle; const R...

  TIcon(AObj).LoadFromResourceName(THandle_sw.FromVar(AArgs[0]), string(
    AArgs[1]));
end;

function TIcon_LoadFromResourceID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromResourceID(Instance: THandle; ResID: In...

  TIcon(AObj).LoadFromResourceID(THandle_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function TIcon_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HICON read <getter> write <setter>;

  if IsGet then
    Result := HICON_sw.ToVar(TIcon(AObj).Handle)
  else
    TIcon(AObj).Handle := HICON_sw.FromVar(AArgs[0]);
end;

class function TIcon_sw.GetTypeName: WideString;
begin
  Result := 'TIcon';
end;

class function TIcon_sw.GetWrappedClass: TClass;
begin
  Result := TIcon;
end;

class procedure TIcon_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('HandleAllocated', TIcon_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddFunction('ReleaseHandle', TIcon_ReleaseHandle_si, HICON_sw, 0, False);
  AData.AddProcedure('LoadFromResourceName', TIcon_LoadFromResourceName_si, 2, False);
  AData.AddProcedure('LoadFromResourceID', TIcon_LoadFromResourceID_si, 2, False);
  AData.AddProperty('Handle', TIcon_Handle_si, HICON_sw, True, True, 0, False, False);
end;

class function TIcon_sw.ToVar(const AValue: TIcon): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIcon_sw.FromVar(const AValue: OleVariant): TIcon;
begin
  Result := TIcon(ConvFromVar(AValue, TIcon));
end;

class function TIcon_sw.ClassToVar(AClass: TIcon_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIcon_sw.ClassFromVar(const AClass: OleVariant): TIcon_sc;
begin
  Result := TIcon_sc(ConvClsFromVar(AClass, TIcon));
end;

{ TWICImageFormat_sw }

class function TWICImageFormat_sw.GetTypeName: WideString;
begin
  Result := 'TWICImageFormat';
end;

class procedure TWICImageFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'wifBmp'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifBmp)),
    (Name: 'wifPng'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifPng)),
    (Name: 'wifJpeg'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifJpeg)),
    (Name: 'wifGif'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifGif)),
    (Name: 'wifTiff'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifTiff)),
    (Name: 'wifWMPhoto'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifWMPhoto)),
    (Name: 'wifOther'; Value: Integer({$IFDEF LMDSCT_12}TWICImageFormat.{$ENDIF}wifOther))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TWICImageFormat_sw.ToVar(
  const AValue: TWICImageFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TWICImageFormat_sw.FromVar(
  const AValue: OleVariant): TWICImageFormat;
begin
  Result := TWICImageFormat(Integer(AValue));
end;

{ TWICImage_sw }

function TWICImage_ImageFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageFormat: TWICImageFormat read <getter> write...

  if IsGet then
    Result := TWICImageFormat_sw.ToVar(TWICImage(AObj).ImageFormat)
  else
    TWICImage(AObj).ImageFormat := TWICImageFormat_sw.FromVar(AArgs[0]);
end;

function TWICImage_EncoderContainerFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EncoderContainerFormat: TGUID read <getter> writ...

  if IsGet then
    Result := TGUID_sw.ToVar(TWICImage(AObj).EncoderContainerFormat)
  else
    TWICImage(AObj).EncoderContainerFormat := TGUID_sw.FromVar(AArgs[0]);
end;

class function TWICImage_sw.GetTypeName: WideString;
begin
  Result := 'TWICImage';
end;

class function TWICImage_sw.GetWrappedClass: TClass;
begin
  Result := TWICImage;
end;

class procedure TWICImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ImageFormat', TWICImage_ImageFormat_si, TWICImageFormat_sw, True, True, 0, False, False);
  AData.AddProperty('EncoderContainerFormat', TWICImage_EncoderContainerFormat_si, TGUID_sw, True, True, 0, False, False);
end;

class function TWICImage_sw.ToVar(const AValue: TWICImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWICImage_sw.FromVar(const AValue: OleVariant): TWICImage;
begin
  Result := TWICImage(ConvFromVar(AValue, TWICImage));
end;

class function TWICImage_sw.ClassToVar(AClass: TWICImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWICImage_sw.ClassFromVar(
  const AClass: OleVariant): TWICImage_sc;
begin
  Result := TWICImage_sc(ConvClsFromVar(AClass, TWICImage));
end;

{ Graphics_sw }

function Graphics_TColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColor = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TColor_sw);
end;

function Graphics_clSystemColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clSystemColor = <value>;

  Result := clSystemColor;
end;

function Graphics_clScrollBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clScrollBar = <value>;

  Result := TColor_sw.ToVar(clScrollBar);
end;

function Graphics_clBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBackground = <value>;

  Result := TColor_sw.ToVar(clBackground);
end;

function Graphics_clActiveCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clActiveCaption = <value>;

  Result := TColor_sw.ToVar(clActiveCaption);
end;

function Graphics_clInactiveCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clInactiveCaption = <value>;

  Result := TColor_sw.ToVar(clInactiveCaption);
end;

function Graphics_clMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMenu = <value>;

  Result := TColor_sw.ToVar(clMenu);
end;

function Graphics_clWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWindow = <value>;

  Result := TColor_sw.ToVar(clWindow);
end;

function Graphics_clWindowFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWindowFrame = <value>;

  Result := TColor_sw.ToVar(clWindowFrame);
end;

function Graphics_clMenuText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMenuText = <value>;

  Result := TColor_sw.ToVar(clMenuText);
end;

function Graphics_clWindowText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWindowText = <value>;

  Result := TColor_sw.ToVar(clWindowText);
end;

function Graphics_clCaptionText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clCaptionText = <value>;

  Result := TColor_sw.ToVar(clCaptionText);
end;

function Graphics_clActiveBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clActiveBorder = <value>;

  Result := TColor_sw.ToVar(clActiveBorder);
end;

function Graphics_clInactiveBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clInactiveBorder = <value>;

  Result := TColor_sw.ToVar(clInactiveBorder);
end;

function Graphics_clAppWorkSpace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clAppWorkSpace = <value>;

  Result := TColor_sw.ToVar(clAppWorkSpace);
end;

function Graphics_clHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clHighlight = <value>;

  Result := TColor_sw.ToVar(clHighlight);
end;

function Graphics_clHighlightText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clHighlightText = <value>;

  Result := TColor_sw.ToVar(clHighlightText);
end;

function Graphics_clBtnFace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBtnFace = <value>;

  Result := TColor_sw.ToVar(clBtnFace);
end;

function Graphics_clBtnShadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBtnShadow = <value>;

  Result := TColor_sw.ToVar(clBtnShadow);
end;

function Graphics_clGrayText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clGrayText = <value>;

  Result := TColor_sw.ToVar(clGrayText);
end;

function Graphics_clBtnText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBtnText = <value>;

  Result := TColor_sw.ToVar(clBtnText);
end;

function Graphics_clInactiveCaptionText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clInactiveCaptionText = <value>;

  Result := TColor_sw.ToVar(clInactiveCaptionText);
end;

function Graphics_clBtnHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBtnHighlight = <value>;

  Result := TColor_sw.ToVar(clBtnHighlight);
end;

function Graphics_cl3DDkShadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cl3DDkShadow = <value>;

  Result := TColor_sw.ToVar(cl3DDkShadow);
end;

function Graphics_cl3DLight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cl3DLight = <value>;

  Result := TColor_sw.ToVar(cl3DLight);
end;

function Graphics_clInfoText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clInfoText = <value>;

  Result := TColor_sw.ToVar(clInfoText);
end;

function Graphics_clInfoBk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clInfoBk = <value>;

  Result := TColor_sw.ToVar(clInfoBk);
end;

function Graphics_clHotLight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clHotLight = <value>;

  Result := TColor_sw.ToVar(clHotLight);
end;

function Graphics_clGradientActiveCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clGradientActiveCaption = <value>;

  Result := TColor_sw.ToVar(clGradientActiveCaption);
end;

function Graphics_clGradientInactiveCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clGradientInactiveCaption = <value>;

  Result := TColor_sw.ToVar(clGradientInactiveCaption);
end;

function Graphics_clMenuHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMenuHighlight = <value>;

  Result := TColor_sw.ToVar(clMenuHighlight);
end;

function Graphics_clMenuBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMenuBar = <value>;

  Result := TColor_sw.ToVar(clMenuBar);
end;

function Graphics_clBlack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBlack = <value>;

  Result := TColor_sw.ToVar(clBlack);
end;

function Graphics_clMaroon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMaroon = <value>;

  Result := TColor_sw.ToVar(clMaroon);
end;

function Graphics_clGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clGreen = <value>;

  Result := TColor_sw.ToVar(clGreen);
end;

function Graphics_clOlive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clOlive = <value>;

  Result := TColor_sw.ToVar(clOlive);
end;

function Graphics_clNavy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clNavy = <value>;

  Result := TColor_sw.ToVar(clNavy);
end;

function Graphics_clPurple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clPurple = <value>;

  Result := TColor_sw.ToVar(clPurple);
end;

function Graphics_clTeal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clTeal = <value>;

  Result := TColor_sw.ToVar(clTeal);
end;

function Graphics_clGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clGray = <value>;

  Result := TColor_sw.ToVar(clGray);
end;

function Graphics_clSilver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clSilver = <value>;

  Result := TColor_sw.ToVar(clSilver);
end;

function Graphics_clRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clRed = <value>;

  Result := TColor_sw.ToVar(clRed);
end;

function Graphics_clLime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clLime = <value>;

  Result := TColor_sw.ToVar(clLime);
end;

function Graphics_clYellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clYellow = <value>;

  Result := TColor_sw.ToVar(clYellow);
end;

function Graphics_clBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clBlue = <value>;

  Result := TColor_sw.ToVar(clBlue);
end;

function Graphics_clFuchsia_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clFuchsia = <value>;

  Result := TColor_sw.ToVar(clFuchsia);
end;

function Graphics_clAqua_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clAqua = <value>;

  Result := TColor_sw.ToVar(clAqua);
end;

function Graphics_clLtGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clLtGray = <value>;

  Result := TColor_sw.ToVar(clLtGray);
end;

function Graphics_clDkGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clDkGray = <value>;

  Result := TColor_sw.ToVar(clDkGray);
end;

function Graphics_clWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWhite = <value>;

  Result := TColor_sw.ToVar(clWhite);
end;

function Graphics_StandardColorsCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const StandardColorsCount = <value>;

  Result := StandardColorsCount;
end;

function Graphics_clMoneyGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMoneyGreen = <value>;

  Result := TColor_sw.ToVar(clMoneyGreen);
end;

function Graphics_clSkyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clSkyBlue = <value>;

  Result := TColor_sw.ToVar(clSkyBlue);
end;

function Graphics_clCream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clCream = <value>;

  Result := TColor_sw.ToVar(clCream);
end;

function Graphics_clMedGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clMedGray = <value>;

  Result := TColor_sw.ToVar(clMedGray);
end;

function Graphics_ExtendedColorsCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ExtendedColorsCount = <value>;

  Result := ExtendedColorsCount;
end;

function Graphics_clNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clNone = <value>;

  Result := TColor_sw.ToVar(clNone);
end;

function Graphics_clDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clDefault = <value>;

  Result := TColor_sw.ToVar(clDefault);
end;

function Graphics_clWebSnow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSnow = <value>;

  Result := clWebSnow;
end;

function Graphics_clWebFloralWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebFloralWhite = <value>;

  Result := clWebFloralWhite;
end;

function Graphics_clWebLavenderBlush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLavenderBlush = <value>;

  Result := clWebLavenderBlush;
end;

function Graphics_clWebOldLace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOldLace = <value>;

  Result := clWebOldLace;
end;

function Graphics_clWebIvory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebIvory = <value>;

  Result := clWebIvory;
end;

function Graphics_clWebCornSilk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCornSilk = <value>;

  Result := clWebCornSilk;
end;

function Graphics_clWebBeige_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBeige = <value>;

  Result := clWebBeige;
end;

function Graphics_clWebAntiqueWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebAntiqueWhite = <value>;

  Result := clWebAntiqueWhite;
end;

function Graphics_clWebWheat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebWheat = <value>;

  Result := clWebWheat;
end;

function Graphics_clWebAliceBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebAliceBlue = <value>;

  Result := clWebAliceBlue;
end;

function Graphics_clWebGhostWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGhostWhite = <value>;

  Result := clWebGhostWhite;
end;

function Graphics_clWebLavender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLavender = <value>;

  Result := clWebLavender;
end;

function Graphics_clWebSeashell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSeashell = <value>;

  Result := clWebSeashell;
end;

function Graphics_clWebLightYellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightYellow = <value>;

  Result := clWebLightYellow;
end;

function Graphics_clWebPapayaWhip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPapayaWhip = <value>;

  Result := clWebPapayaWhip;
end;

function Graphics_clWebNavajoWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebNavajoWhite = <value>;

  Result := clWebNavajoWhite;
end;

function Graphics_clWebMoccasin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMoccasin = <value>;

  Result := clWebMoccasin;
end;

function Graphics_clWebBurlywood_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBurlywood = <value>;

  Result := clWebBurlywood;
end;

function Graphics_clWebAzure_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebAzure = <value>;

  Result := clWebAzure;
end;

function Graphics_clWebMintcream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMintcream = <value>;

  Result := clWebMintcream;
end;

function Graphics_clWebHoneydew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebHoneydew = <value>;

  Result := clWebHoneydew;
end;

function Graphics_clWebLinen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLinen = <value>;

  Result := clWebLinen;
end;

function Graphics_clWebLemonChiffon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLemonChiffon = <value>;

  Result := clWebLemonChiffon;
end;

function Graphics_clWebBlanchedAlmond_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBlanchedAlmond = <value>;

  Result := clWebBlanchedAlmond;
end;

function Graphics_clWebBisque_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBisque = <value>;

  Result := clWebBisque;
end;

function Graphics_clWebPeachPuff_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPeachPuff = <value>;

  Result := clWebPeachPuff;
end;

function Graphics_clWebTan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebTan = <value>;

  Result := clWebTan;
end;

function Graphics_clWebYellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebYellow = <value>;

  Result := clWebYellow;
end;

function Graphics_clWebDarkOrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkOrange = <value>;

  Result := clWebDarkOrange;
end;

function Graphics_clWebRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebRed = <value>;

  Result := clWebRed;
end;

function Graphics_clWebDarkRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkRed = <value>;

  Result := clWebDarkRed;
end;

function Graphics_clWebMaroon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMaroon = <value>;

  Result := clWebMaroon;
end;

function Graphics_clWebIndianRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebIndianRed = <value>;

  Result := clWebIndianRed;
end;

function Graphics_clWebSalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSalmon = <value>;

  Result := clWebSalmon;
end;

function Graphics_clWebCoral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCoral = <value>;

  Result := clWebCoral;
end;

function Graphics_clWebGold_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGold = <value>;

  Result := clWebGold;
end;

function Graphics_clWebTomato_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebTomato = <value>;

  Result := clWebTomato;
end;

function Graphics_clWebCrimson_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCrimson = <value>;

  Result := clWebCrimson;
end;

function Graphics_clWebBrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBrown = <value>;

  Result := clWebBrown;
end;

function Graphics_clWebChocolate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebChocolate = <value>;

  Result := clWebChocolate;
end;

function Graphics_clWebSandyBrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSandyBrown = <value>;

  Result := clWebSandyBrown;
end;

function Graphics_clWebLightSalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightSalmon = <value>;

  Result := clWebLightSalmon;
end;

function Graphics_clWebLightCoral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightCoral = <value>;

  Result := clWebLightCoral;
end;

function Graphics_clWebOrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOrange = <value>;

  Result := clWebOrange;
end;

function Graphics_clWebOrangeRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOrangeRed = <value>;

  Result := clWebOrangeRed;
end;

function Graphics_clWebFirebrick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebFirebrick = <value>;

  Result := clWebFirebrick;
end;

function Graphics_clWebSaddleBrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSaddleBrown = <value>;

  Result := clWebSaddleBrown;
end;

function Graphics_clWebSienna_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSienna = <value>;

  Result := clWebSienna;
end;

function Graphics_clWebPeru_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPeru = <value>;

  Result := clWebPeru;
end;

function Graphics_clWebDarkSalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkSalmon = <value>;

  Result := clWebDarkSalmon;
end;

function Graphics_clWebRosyBrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebRosyBrown = <value>;

  Result := clWebRosyBrown;
end;

function Graphics_clWebPaleGoldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPaleGoldenrod = <value>;

  Result := clWebPaleGoldenrod;
end;

function Graphics_clWebLightGoldenrodYellow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightGoldenrodYellow = <value>;

  Result := clWebLightGoldenrodYellow;
end;

function Graphics_clWebOlive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOlive = <value>;

  Result := clWebOlive;
end;

function Graphics_clWebForestGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebForestGreen = <value>;

  Result := clWebForestGreen;
end;

function Graphics_clWebGreenYellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGreenYellow = <value>;

  Result := clWebGreenYellow;
end;

function Graphics_clWebChartreuse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebChartreuse = <value>;

  Result := clWebChartreuse;
end;

function Graphics_clWebLightGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightGreen = <value>;

  Result := clWebLightGreen;
end;

function Graphics_clWebAquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebAquamarine = <value>;

  Result := clWebAquamarine;
end;

function Graphics_clWebSeaGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSeaGreen = <value>;

  Result := clWebSeaGreen;
end;

function Graphics_clWebGoldenRod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGoldenRod = <value>;

  Result := clWebGoldenRod;
end;

function Graphics_clWebKhaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebKhaki = <value>;

  Result := clWebKhaki;
end;

function Graphics_clWebOliveDrab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOliveDrab = <value>;

  Result := clWebOliveDrab;
end;

function Graphics_clWebGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGreen = <value>;

  Result := clWebGreen;
end;

function Graphics_clWebYellowGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebYellowGreen = <value>;

  Result := clWebYellowGreen;
end;

function Graphics_clWebLawnGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLawnGreen = <value>;

  Result := clWebLawnGreen;
end;

function Graphics_clWebPaleGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPaleGreen = <value>;

  Result := clWebPaleGreen;
end;

function Graphics_clWebMediumAquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumAquamarine = <value>;

  Result := clWebMediumAquamarine;
end;

function Graphics_clWebMediumSeaGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumSeaGreen = <value>;

  Result := clWebMediumSeaGreen;
end;

function Graphics_clWebDarkGoldenRod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkGoldenRod = <value>;

  Result := clWebDarkGoldenRod;
end;

function Graphics_clWebDarkKhaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkKhaki = <value>;

  Result := clWebDarkKhaki;
end;

function Graphics_clWebDarkOliveGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkOliveGreen = <value>;

  Result := clWebDarkOliveGreen;
end;

function Graphics_clWebDarkgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkgreen = <value>;

  Result := clWebDarkgreen;
end;

function Graphics_clWebLimeGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLimeGreen = <value>;

  Result := clWebLimeGreen;
end;

function Graphics_clWebLime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLime = <value>;

  Result := clWebLime;
end;

function Graphics_clWebSpringGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSpringGreen = <value>;

  Result := clWebSpringGreen;
end;

function Graphics_clWebMediumSpringGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumSpringGreen = <value>;

  Result := clWebMediumSpringGreen;
end;

function Graphics_clWebDarkSeaGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkSeaGreen = <value>;

  Result := clWebDarkSeaGreen;
end;

function Graphics_clWebLightSeaGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightSeaGreen = <value>;

  Result := clWebLightSeaGreen;
end;

function Graphics_clWebPaleTurquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPaleTurquoise = <value>;

  Result := clWebPaleTurquoise;
end;

function Graphics_clWebLightCyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightCyan = <value>;

  Result := clWebLightCyan;
end;

function Graphics_clWebLightBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightBlue = <value>;

  Result := clWebLightBlue;
end;

function Graphics_clWebLightSkyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightSkyBlue = <value>;

  Result := clWebLightSkyBlue;
end;

function Graphics_clWebCornFlowerBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCornFlowerBlue = <value>;

  Result := clWebCornFlowerBlue;
end;

function Graphics_clWebDarkBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkBlue = <value>;

  Result := clWebDarkBlue;
end;

function Graphics_clWebIndigo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebIndigo = <value>;

  Result := clWebIndigo;
end;

function Graphics_clWebMediumTurquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumTurquoise = <value>;

  Result := clWebMediumTurquoise;
end;

function Graphics_clWebTurquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebTurquoise = <value>;

  Result := clWebTurquoise;
end;

function Graphics_clWebCyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCyan = <value>;

  Result := clWebCyan;
end;

function Graphics_clWebAqua_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebAqua = <value>;

  Result := clWebAqua;
end;

function Graphics_clWebPowderBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPowderBlue = <value>;

  Result := clWebPowderBlue;
end;

function Graphics_clWebSkyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSkyBlue = <value>;

  Result := clWebSkyBlue;
end;

function Graphics_clWebRoyalBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebRoyalBlue = <value>;

  Result := clWebRoyalBlue;
end;

function Graphics_clWebMediumBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumBlue = <value>;

  Result := clWebMediumBlue;
end;

function Graphics_clWebMidnightBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMidnightBlue = <value>;

  Result := clWebMidnightBlue;
end;

function Graphics_clWebDarkTurquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkTurquoise = <value>;

  Result := clWebDarkTurquoise;
end;

function Graphics_clWebCadetBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebCadetBlue = <value>;

  Result := clWebCadetBlue;
end;

function Graphics_clWebDarkCyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkCyan = <value>;

  Result := clWebDarkCyan;
end;

function Graphics_clWebTeal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebTeal = <value>;

  Result := clWebTeal;
end;

function Graphics_clWebDeepskyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDeepskyBlue = <value>;

  Result := clWebDeepskyBlue;
end;

function Graphics_clWebDodgerBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDodgerBlue = <value>;

  Result := clWebDodgerBlue;
end;

function Graphics_clWebBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBlue = <value>;

  Result := clWebBlue;
end;

function Graphics_clWebNavy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebNavy = <value>;

  Result := clWebNavy;
end;

function Graphics_clWebDarkViolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkViolet = <value>;

  Result := clWebDarkViolet;
end;

function Graphics_clWebDarkOrchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkOrchid = <value>;

  Result := clWebDarkOrchid;
end;

function Graphics_clWebMagenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMagenta = <value>;

  Result := clWebMagenta;
end;

function Graphics_clWebFuchsia_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebFuchsia = <value>;

  Result := clWebFuchsia;
end;

function Graphics_clWebDarkMagenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkMagenta = <value>;

  Result := clWebDarkMagenta;
end;

function Graphics_clWebMediumVioletRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumVioletRed = <value>;

  Result := clWebMediumVioletRed;
end;

function Graphics_clWebPaleVioletRed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPaleVioletRed = <value>;

  Result := clWebPaleVioletRed;
end;

function Graphics_clWebBlueViolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBlueViolet = <value>;

  Result := clWebBlueViolet;
end;

function Graphics_clWebMediumOrchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumOrchid = <value>;

  Result := clWebMediumOrchid;
end;

function Graphics_clWebMediumPurple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumPurple = <value>;

  Result := clWebMediumPurple;
end;

function Graphics_clWebPurple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPurple = <value>;

  Result := clWebPurple;
end;

function Graphics_clWebDeepPink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDeepPink = <value>;

  Result := clWebDeepPink;
end;

function Graphics_clWebLightPink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightPink = <value>;

  Result := clWebLightPink;
end;

function Graphics_clWebViolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebViolet = <value>;

  Result := clWebViolet;
end;

function Graphics_clWebOrchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebOrchid = <value>;

  Result := clWebOrchid;
end;

function Graphics_clWebPlum_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPlum = <value>;

  Result := clWebPlum;
end;

function Graphics_clWebThistle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebThistle = <value>;

  Result := clWebThistle;
end;

function Graphics_clWebHotPink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebHotPink = <value>;

  Result := clWebHotPink;
end;

function Graphics_clWebPink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebPink = <value>;

  Result := clWebPink;
end;

function Graphics_clWebLightSteelBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightSteelBlue = <value>;

  Result := clWebLightSteelBlue;
end;

function Graphics_clWebMediumSlateBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMediumSlateBlue = <value>;

  Result := clWebMediumSlateBlue;
end;

function Graphics_clWebLightSlateGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightSlateGray = <value>;

  Result := clWebLightSlateGray;
end;

function Graphics_clWebWhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebWhite = <value>;

  Result := clWebWhite;
end;

function Graphics_clWebLightgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebLightgrey = <value>;

  Result := clWebLightgrey;
end;

function Graphics_clWebGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGray = <value>;

  Result := clWebGray;
end;

function Graphics_clWebSteelBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSteelBlue = <value>;

  Result := clWebSteelBlue;
end;

function Graphics_clWebSlateBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSlateBlue = <value>;

  Result := clWebSlateBlue;
end;

function Graphics_clWebSlateGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSlateGray = <value>;

  Result := clWebSlateGray;
end;

function Graphics_clWebWhiteSmoke_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebWhiteSmoke = <value>;

  Result := clWebWhiteSmoke;
end;

function Graphics_clWebSilver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebSilver = <value>;

  Result := clWebSilver;
end;

function Graphics_clWebDimGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDimGray = <value>;

  Result := clWebDimGray;
end;

function Graphics_clWebMistyRose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebMistyRose = <value>;

  Result := clWebMistyRose;
end;

function Graphics_clWebDarkSlateBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkSlateBlue = <value>;

  Result := clWebDarkSlateBlue;
end;

function Graphics_clWebDarkSlategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkSlategray = <value>;

  Result := clWebDarkSlategray;
end;

function Graphics_clWebGainsboro_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebGainsboro = <value>;

  Result := clWebGainsboro;
end;

function Graphics_clWebDarkGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebDarkGray = <value>;

  Result := clWebDarkGray;
end;

function Graphics_clWebBlack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const clWebBlack = <value>;

  Result := clWebBlack;
end;

function Graphics_WebColorsCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WebColorsCount = <value>;

  Result := WebColorsCount;
end;

function Graphics_cmBlackness_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmBlackness = <value>;

  Result := cmBlackness;
end;

function Graphics_cmDstInvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmDstInvert = <value>;

  Result := cmDstInvert;
end;

function Graphics_cmMergeCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmMergeCopy = <value>;

  Result := cmMergeCopy;
end;

function Graphics_cmMergePaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmMergePaint = <value>;

  Result := cmMergePaint;
end;

function Graphics_cmNotSrcCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmNotSrcCopy = <value>;

  Result := cmNotSrcCopy;
end;

function Graphics_cmNotSrcErase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmNotSrcErase = <value>;

  Result := cmNotSrcErase;
end;

function Graphics_cmPatCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmPatCopy = <value>;

  Result := cmPatCopy;
end;

function Graphics_cmPatInvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmPatInvert = <value>;

  Result := cmPatInvert;
end;

function Graphics_cmPatPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmPatPaint = <value>;

  Result := cmPatPaint;
end;

function Graphics_cmSrcAnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmSrcAnd = <value>;

  Result := cmSrcAnd;
end;

function Graphics_cmSrcCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmSrcCopy = <value>;

  Result := cmSrcCopy;
end;

function Graphics_cmSrcErase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmSrcErase = <value>;

  Result := cmSrcErase;
end;

function Graphics_cmSrcInvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmSrcInvert = <value>;

  Result := cmSrcInvert;
end;

function Graphics_cmSrcPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmSrcPaint = <value>;

  Result := cmSrcPaint;
end;

function Graphics_cmWhiteness_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cmWhiteness = <value>;

  Result := cmWhiteness;
end;

function Graphics_rc3_StockIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rc3_StockIcon = <value>;

  Result := rc3_StockIcon;
end;

function Graphics_rc3_Icon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rc3_Icon = <value>;

  Result := rc3_Icon;
end;

function Graphics_rc3_Cursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rc3_Cursor = <value>;

  Result := rc3_Cursor;
end;

function Graphics_TCursorOrIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorOrIcon = record;

  Result := TLMDUnitWrapper.TypeToVar(TCursorOrIcon_sw);
end;

function Graphics_TIconRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIconRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TIconRec_sw);
end;

function Graphics_HMETAFILE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMETAFILE = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HMETAFILE_sw);
end;

function Graphics_HENHMETAFILE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HENHMETAFILE = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HENHMETAFILE_sw);
end;

function Graphics_EInvalidGraphic_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidGraphic = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidGraphic_sw);
end;

function Graphics_EInvalidGraphicOperation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidGraphicOperation = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidGraphicOperation_sw);
end;

function Graphics_TResData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResData = record;

  Result := TLMDUnitWrapper.TypeToVar(TResData_sw);
end;

function Graphics_TFontPitch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontPitch = (fpDefault, fpVariable, fpFixed);

  Result := TLMDUnitWrapper.TypeToVar(TFontPitch_sw);
end;

function Graphics_TFontName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFontName_sw);
end;

function Graphics_TFontCharset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontCharset = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TFontCharset_sw);
end;

function Graphics_TFontStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrik...

  Result := TLMDUnitWrapper.TypeToVar(TFontStyle_sw);
end;

function Graphics_TFontStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStyles = set of TFontStyle;

  Result := TLMDUnitWrapper.TypeToVar(TFontStyles_sw);
end;

function Graphics_TFontDataName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDataName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFontDataName_sw);
end;

function Graphics_TFontStylesBase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStylesBase = set of TFontStyle;

  Result := TLMDUnitWrapper.TypeToVar(TFontStylesBase_sw);
end;

function Graphics_TFontData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontData = record;

  Result := TLMDUnitWrapper.TypeToVar(TFontData_sw);
end;

function Graphics_TPenStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPenStyle = (psSolid, psDash, psDot, psDashDot, psDa...

  Result := TLMDUnitWrapper.TypeToVar(TPenStyle_sw);
end;

function Graphics_TPenMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPenMode = (pmBlack, pmWhite, pmNop, pmNot, pmCopy, ...

  Result := TLMDUnitWrapper.TypeToVar(TPenMode_sw);
end;

function Graphics_TPenData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPenData = record;

  Result := TLMDUnitWrapper.TypeToVar(TPenData_sw);
end;

function Graphics_TBrushStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrushStyle = (bsSolid, bsClear, bsHorizontal, bsVer...

  Result := TLMDUnitWrapper.TypeToVar(TBrushStyle_sw);
end;

function Graphics_TBrushData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrushData = record;

  Result := TLMDUnitWrapper.TypeToVar(TBrushData_sw);
end;

function Graphics_TResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResource = record;

  Result := TLMDUnitWrapper.TypeToVar(TResource_sw);
end;

function Graphics_TGraphicsObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGraphicsObject = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TGraphicsObject_sw);
end;

function Graphics_TFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFont = class(TGraphicsObject);

  Result := TLMDUnitWrapper.TypeToVar(TFont_sw);
end;

function Graphics_TPen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPen = class(TGraphicsObject);

  Result := TLMDUnitWrapper.TypeToVar(TPen_sw);
end;

function Graphics_TBrush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrush = class(TGraphicsObject);

  Result := TLMDUnitWrapper.TypeToVar(TBrush_sw);
end;

function Graphics_TFontRecall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontRecall = class(TRecall);

  Result := TLMDUnitWrapper.TypeToVar(TFontRecall_sw);
end;

function Graphics_TPenRecall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPenRecall = class(TRecall);

  Result := TLMDUnitWrapper.TypeToVar(TPenRecall_sw);
end;

function Graphics_TBrushRecall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrushRecall = class(TRecall);

  Result := TLMDUnitWrapper.TypeToVar(TBrushRecall_sw);
end;

function Graphics_TFillStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFillStyle = (fsSurface, fsBorder);

  Result := TLMDUnitWrapper.TypeToVar(TFillStyle_sw);
end;

function Graphics_TFillMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFillMode = (fmAlternate, fmWinding);

  Result := TLMDUnitWrapper.TypeToVar(TFillMode_sw);
end;

function Graphics_TCopyMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCopyMode = Longint;

  Result := TLMDUnitWrapper.TypeToVar(TCopyMode_sw);
end;

function Graphics_TCanvasStates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvasStates = (csHandleValid, csFontValid, csPenVa...

  Result := TLMDUnitWrapper.TypeToVar(TCanvasStates_sw);
end;

function Graphics_TCanvasState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvasState = set of TCanvasStates;

  Result := TLMDUnitWrapper.TypeToVar(TCanvasState_sw);
end;

function Graphics_TCanvasOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvasOrientation = (coLeftToRight, coRightToLeft);

  Result := TLMDUnitWrapper.TypeToVar(TCanvasOrientation_sw);
end;

function Graphics_TTextFormats_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextFormats = (tfBottom, tfCalcRect, tfCenter, tfEd...

  Result := TLMDUnitWrapper.TypeToVar(TTextFormats_sw);
end;

function Graphics_TTextFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextFormat = set of TTextFormats;

  Result := TLMDUnitWrapper.TypeToVar(TTextFormat_sw);
end;

function Graphics_TCustomCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomCanvas = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomCanvas_sw);
end;

function Graphics_TCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvas = class(TCustomCanvas);

  Result := TLMDUnitWrapper.TypeToVar(TCanvas_sw);
end;

function Graphics_TProgressStage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressStage = (psStarting, psRunning, psEnding);

  Result := TLMDUnitWrapper.TypeToVar(TProgressStage_sw);
end;

function Graphics_TProgressEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressEvent = procedure (Sender: TObject; Stage: ...

  Result := TLMDUnitWrapper.TypeToVar(TProgressEvent_sw);
end;

function Graphics_TGraphic_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGraphic = class(TInterfacedPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TGraphic_sw);
end;

function Graphics_TGraphicClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGraphicClass = class of TGraphic;

  Result := TLMDUnitWrapper.TypeToVar(TGraphicClass_sw);
end;

function Graphics_TPicture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPicture = class(TInterfacedPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TPicture_sw);
end;

function Graphics_TMetafileCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMetafileCanvas = class(TCanvas);

  Result := TLMDUnitWrapper.TypeToVar(TMetafileCanvas_sw);
end;

function Graphics_TSharedImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSharedImage = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TSharedImage_sw);
end;

function Graphics_TMetafileImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMetafileImage = class(TSharedImage);

  Result := TLMDUnitWrapper.TypeToVar(TMetafileImage_sw);
end;

function Graphics_TMetafile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMetafile = class(TGraphic);

  Result := TLMDUnitWrapper.TypeToVar(TMetafile_sw);
end;

function Graphics_TBitmapImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitmapImage = class(TSharedImage);

  Result := TLMDUnitWrapper.TypeToVar(TBitmapImage_sw);
end;

function Graphics_TBitmapHandleType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitmapHandleType = (bmDIB, bmDDB);

  Result := TLMDUnitWrapper.TypeToVar(TBitmapHandleType_sw);
end;

function Graphics_TPixelFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPixelFormat = (pfDevice, pf1bit, pf4bit, pf8bit, pf...

  Result := TLMDUnitWrapper.TypeToVar(TPixelFormat_sw);
end;

function Graphics_TAlphaFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlphaFormat = (afIgnored, afDefined, afPremultiplied);

  Result := TLMDUnitWrapper.TypeToVar(TAlphaFormat_sw);
end;

function Graphics_TTransparentMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTransparentMode = (tmAuto, tmFixed);

  Result := TLMDUnitWrapper.TypeToVar(TTransparentMode_sw);
end;

function Graphics_TBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitmap = class(TGraphic);

  Result := TLMDUnitWrapper.TypeToVar(TBitmap_sw);
end;

function Graphics_TIconImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIconImage = class(TSharedImage);

  Result := TLMDUnitWrapper.TypeToVar(TIconImage_sw);
end;

function Graphics_TIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIcon = class(TGraphic);

  Result := TLMDUnitWrapper.TypeToVar(TIcon_sw);
end;

function Graphics_TWICImageFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWICImageFormat = (wifBmp, wifPng, wifJpeg, wifGif, ...

  Result := TLMDUnitWrapper.TypeToVar(TWICImageFormat_sw);
end;

function Graphics_TWICImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWICImage = class(TGraphic);

  Result := TLMDUnitWrapper.TypeToVar(TWICImage_sw);
end;

function Graphics_DefFontData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefFontData: TFontData;

  if IsGet then
    Result := TFontData_sw.ToVar(Graphics.DefFontData)
  else
    Graphics.DefFontData := TFontData_sw.FromVar(AArgs[0]);
end;

function Graphics_SystemPalette16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SystemPalette16: HPalette;

  if IsGet then
    Result := HPalette_sw.ToVar(Graphics.SystemPalette16)
  else
    Graphics.SystemPalette16 := HPalette_sw.FromVar(AArgs[0]);
end;

function Graphics_DDBsOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DDBsOnly: Boolean;

  if IsGet then
    Result := Graphics.DDBsOnly
  else
    Graphics.DDBsOnly := Boolean(AArgs[0]);
end;

function Graphics_GraphicFilter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GraphicFilter(GraphicClass: TGraphicClass): string;

  Result := Graphics.GraphicFilter(TGraphicClass_sw.FromVar(AArgs[0]));
end;

function Graphics_GraphicExtension_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GraphicExtension(GraphicClass: TGraphicClass): s...

  Result := Graphics.GraphicExtension(TGraphicClass_sw.FromVar(AArgs[0]));
end;

function Graphics_GraphicFileMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GraphicFileMask(GraphicClass: TGraphicClass): st...

  Result := Graphics.GraphicFileMask(TGraphicClass_sw.FromVar(AArgs[0]));
end;

function Graphics_ColorToRGB_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorToRGB(Color: TColor): Longint;

  Result := Graphics.ColorToRGB(TColor_sw.FromVar(AArgs[0]));
end;

function Graphics_ColorToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorToString(Color: TColor): string;

  Result := Graphics.ColorToString(TColor_sw.FromVar(AArgs[0]));
end;

function Graphics_StringToColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StringToColor(const S: string): TColor;

  Result := TColor_sw.ToVar(Graphics.StringToColor(string(AArgs[0])));
end;

function Graphics_GetColorValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetColorValues(Proc: TGetStrProc);

  Graphics.GetColorValues(TGetStrProc_sw.FromVar(AArgs[0]));
end;

function Graphics_ColorToIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function ColorToIdent(Color: Longint; var Ident: string):...

  v_1 := string(AArgs[1]);
  Result := Graphics.ColorToIdent(Longint(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Graphics_IdentToColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Longint;
begin
  // function IdentToColor(const Ident: string; var Color: Lon...

  v_1 := Longint(AArgs[1]);
  Result := Graphics.IdentToColor(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Graphics_GetCharsetValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetCharsetValues(Proc: TGetStrProc);

  Graphics.GetCharsetValues(TGetStrProc_sw.FromVar(AArgs[0]));
end;

function Graphics_CharsetToIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function CharsetToIdent(Charset: Longint; var Ident: stri...

  v_1 := string(AArgs[1]);
  Result := Graphics.CharsetToIdent(Longint(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Graphics_IdentToCharset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Longint;
begin
  // function IdentToCharset(const Ident: string; var Charset:...

  v_1 := Longint(AArgs[1]);
  Result := Graphics.IdentToCharset(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Graphics_GetDIBSizes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: DWORD;
  v_2: DWORD;
begin
  // procedure GetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize...

  v_1 := DWORD_sw.FromVar(AArgs[1]);
  v_2 := DWORD_sw.FromVar(AArgs[2]);
  Graphics.GetDIBSizes(HBITMAP_sw.FromVar(AArgs[0]), v_1, v_2);
  AssignRefParam(AArgs[1], DWORD_sw.ToVar(v_1));
  AssignRefParam(AArgs[2], DWORD_sw.ToVar(v_2));
end;

function Graphics_CopyPalette_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CopyPalette(Palette: HPALETTE): HPALETTE;

  Result := HPALETTE_sw.ToVar(Graphics.CopyPalette(HPALETTE_sw.FromVar(
    AArgs[0])));
end;

function Graphics_PaletteChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PaletteChanged;

  Graphics.PaletteChanged();
end;

function Graphics_FreeMemoryContexts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeMemoryContexts;

  Graphics.FreeMemoryContexts();
end;

function Graphics_GetDefFontCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetDefFontCharSet: TFontCharSet;

  Result := TFontCharSet_sw.ToVar(Graphics.GetDefFontCharSet());
end;

function Graphics_TransparentStretchBlt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TransparentStretchBlt(DstDC: HDC; DstX: Integer;...

  Result := Graphics.TransparentStretchBlt(HDC_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), HDC_sw.
    FromVar(AArgs[5]), Integer(AArgs[6]), Integer(AArgs[7]), Integer(AArgs[8]),
    Integer(AArgs[9]), HDC_sw.FromVar(AArgs[10]), Integer(AArgs[11]), Integer(
    AArgs[12]));
end;

function Graphics_CreateGrayMappedBmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateGrayMappedBmp(Handle: HBITMAP): HBITMAP;

  Result := HBITMAP_sw.ToVar(Graphics.CreateGrayMappedBmp(HBITMAP_sw.FromVar(
    AArgs[0])));
end;

function Graphics_AllocPatternBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AllocPatternBitmap(BkColor: TColor; FgColor: TCo...

  Result := TBitmap_sw.ToVar(Graphics.AllocPatternBitmap(TColor_sw.FromVar(
    AArgs[0]), TColor_sw.FromVar(AArgs[1])));
end;

function Graphics_BytesPerScanline_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BytesPerScanline(PixelsPerScanline: Longint; Bit...

  Result := Graphics.BytesPerScanline(Longint(AArgs[0]), Longint(AArgs[1]), 
    Longint(AArgs[2]));
end;

class function Graphics_sw.GetUnitName: WideString;
begin
  Result := 'Graphics';
end;

class procedure Graphics_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TColor_sw, Graphics_TColor_si);
  AData.AddConstant('clSystemColor', Graphics_clSystemColor_si, nil, VarType(Graphics.clSystemColor));
  AData.AddConstant('clScrollBar', Graphics_clScrollBar_si, TColor_sw);
  AData.AddConstant('clBackground', Graphics_clBackground_si, TColor_sw);
  AData.AddConstant('clActiveCaption', Graphics_clActiveCaption_si, TColor_sw);
  AData.AddConstant('clInactiveCaption', Graphics_clInactiveCaption_si, TColor_sw);
  AData.AddConstant('clMenu', Graphics_clMenu_si, TColor_sw);
  AData.AddConstant('clWindow', Graphics_clWindow_si, TColor_sw);
  AData.AddConstant('clWindowFrame', Graphics_clWindowFrame_si, TColor_sw);
  AData.AddConstant('clMenuText', Graphics_clMenuText_si, TColor_sw);
  AData.AddConstant('clWindowText', Graphics_clWindowText_si, TColor_sw);
  AData.AddConstant('clCaptionText', Graphics_clCaptionText_si, TColor_sw);
  AData.AddConstant('clActiveBorder', Graphics_clActiveBorder_si, TColor_sw);
  AData.AddConstant('clInactiveBorder', Graphics_clInactiveBorder_si, TColor_sw);
  AData.AddConstant('clAppWorkSpace', Graphics_clAppWorkSpace_si, TColor_sw);
  AData.AddConstant('clHighlight', Graphics_clHighlight_si, TColor_sw);
  AData.AddConstant('clHighlightText', Graphics_clHighlightText_si, TColor_sw);
  AData.AddConstant('clBtnFace', Graphics_clBtnFace_si, TColor_sw);
  AData.AddConstant('clBtnShadow', Graphics_clBtnShadow_si, TColor_sw);
  AData.AddConstant('clGrayText', Graphics_clGrayText_si, TColor_sw);
  AData.AddConstant('clBtnText', Graphics_clBtnText_si, TColor_sw);
  AData.AddConstant('clInactiveCaptionText', Graphics_clInactiveCaptionText_si, TColor_sw);
  AData.AddConstant('clBtnHighlight', Graphics_clBtnHighlight_si, TColor_sw);
  AData.AddConstant('cl3DDkShadow', Graphics_cl3DDkShadow_si, TColor_sw);
  AData.AddConstant('cl3DLight', Graphics_cl3DLight_si, TColor_sw);
  AData.AddConstant('clInfoText', Graphics_clInfoText_si, TColor_sw);
  AData.AddConstant('clInfoBk', Graphics_clInfoBk_si, TColor_sw);
  AData.AddConstant('clHotLight', Graphics_clHotLight_si, TColor_sw);
  AData.AddConstant('clGradientActiveCaption', Graphics_clGradientActiveCaption_si, TColor_sw);
  AData.AddConstant('clGradientInactiveCaption', Graphics_clGradientInactiveCaption_si, TColor_sw);
  AData.AddConstant('clMenuHighlight', Graphics_clMenuHighlight_si, TColor_sw);
  AData.AddConstant('clMenuBar', Graphics_clMenuBar_si, TColor_sw);
  AData.AddConstant('clBlack', Graphics_clBlack_si, TColor_sw);
  AData.AddConstant('clMaroon', Graphics_clMaroon_si, TColor_sw);
  AData.AddConstant('clGreen', Graphics_clGreen_si, TColor_sw);
  AData.AddConstant('clOlive', Graphics_clOlive_si, TColor_sw);
  AData.AddConstant('clNavy', Graphics_clNavy_si, TColor_sw);
  AData.AddConstant('clPurple', Graphics_clPurple_si, TColor_sw);
  AData.AddConstant('clTeal', Graphics_clTeal_si, TColor_sw);
  AData.AddConstant('clGray', Graphics_clGray_si, TColor_sw);
  AData.AddConstant('clSilver', Graphics_clSilver_si, TColor_sw);
  AData.AddConstant('clRed', Graphics_clRed_si, TColor_sw);
  AData.AddConstant('clLime', Graphics_clLime_si, TColor_sw);
  AData.AddConstant('clYellow', Graphics_clYellow_si, TColor_sw);
  AData.AddConstant('clBlue', Graphics_clBlue_si, TColor_sw);
  AData.AddConstant('clFuchsia', Graphics_clFuchsia_si, TColor_sw);
  AData.AddConstant('clAqua', Graphics_clAqua_si, TColor_sw);
  AData.AddConstant('clLtGray', Graphics_clLtGray_si, TColor_sw);
  AData.AddConstant('clDkGray', Graphics_clDkGray_si, TColor_sw);
  AData.AddConstant('clWhite', Graphics_clWhite_si, TColor_sw);
  AData.AddConstant('StandardColorsCount', Graphics_StandardColorsCount_si, nil, VarType(Graphics.StandardColorsCount));
  AData.AddConstant('clMoneyGreen', Graphics_clMoneyGreen_si, TColor_sw);
  AData.AddConstant('clSkyBlue', Graphics_clSkyBlue_si, TColor_sw);
  AData.AddConstant('clCream', Graphics_clCream_si, TColor_sw);
  AData.AddConstant('clMedGray', Graphics_clMedGray_si, TColor_sw);
  AData.AddConstant('ExtendedColorsCount', Graphics_ExtendedColorsCount_si, nil, VarType(Graphics.ExtendedColorsCount));
  AData.AddConstant('clNone', Graphics_clNone_si, TColor_sw);
  AData.AddConstant('clDefault', Graphics_clDefault_si, TColor_sw);
  AData.AddConstant('clWebSnow', Graphics_clWebSnow_si, nil, VarType(Graphics.clWebSnow));
  AData.AddConstant('clWebFloralWhite', Graphics_clWebFloralWhite_si, nil, VarType(Graphics.clWebFloralWhite));
  AData.AddConstant('clWebLavenderBlush', Graphics_clWebLavenderBlush_si, nil, VarType(Graphics.clWebLavenderBlush));
  AData.AddConstant('clWebOldLace', Graphics_clWebOldLace_si, nil, VarType(Graphics.clWebOldLace));
  AData.AddConstant('clWebIvory', Graphics_clWebIvory_si, nil, VarType(Graphics.clWebIvory));
  AData.AddConstant('clWebCornSilk', Graphics_clWebCornSilk_si, nil, VarType(Graphics.clWebCornSilk));
  AData.AddConstant('clWebBeige', Graphics_clWebBeige_si, nil, VarType(Graphics.clWebBeige));
  AData.AddConstant('clWebAntiqueWhite', Graphics_clWebAntiqueWhite_si, nil, VarType(Graphics.clWebAntiqueWhite));
  AData.AddConstant('clWebWheat', Graphics_clWebWheat_si, nil, VarType(Graphics.clWebWheat));
  AData.AddConstant('clWebAliceBlue', Graphics_clWebAliceBlue_si, nil, VarType(Graphics.clWebAliceBlue));
  AData.AddConstant('clWebGhostWhite', Graphics_clWebGhostWhite_si, nil, VarType(Graphics.clWebGhostWhite));
  AData.AddConstant('clWebLavender', Graphics_clWebLavender_si, nil, VarType(Graphics.clWebLavender));
  AData.AddConstant('clWebSeashell', Graphics_clWebSeashell_si, nil, VarType(Graphics.clWebSeashell));
  AData.AddConstant('clWebLightYellow', Graphics_clWebLightYellow_si, nil, VarType(Graphics.clWebLightYellow));
  AData.AddConstant('clWebPapayaWhip', Graphics_clWebPapayaWhip_si, nil, VarType(Graphics.clWebPapayaWhip));
  AData.AddConstant('clWebNavajoWhite', Graphics_clWebNavajoWhite_si, nil, VarType(Graphics.clWebNavajoWhite));
  AData.AddConstant('clWebMoccasin', Graphics_clWebMoccasin_si, nil, VarType(Graphics.clWebMoccasin));
  AData.AddConstant('clWebBurlywood', Graphics_clWebBurlywood_si, nil, VarType(Graphics.clWebBurlywood));
  AData.AddConstant('clWebAzure', Graphics_clWebAzure_si, nil, VarType(Graphics.clWebAzure));
  AData.AddConstant('clWebMintcream', Graphics_clWebMintcream_si, nil, VarType(Graphics.clWebMintcream));
  AData.AddConstant('clWebHoneydew', Graphics_clWebHoneydew_si, nil, VarType(Graphics.clWebHoneydew));
  AData.AddConstant('clWebLinen', Graphics_clWebLinen_si, nil, VarType(Graphics.clWebLinen));
  AData.AddConstant('clWebLemonChiffon', Graphics_clWebLemonChiffon_si, nil, VarType(Graphics.clWebLemonChiffon));
  AData.AddConstant('clWebBlanchedAlmond', Graphics_clWebBlanchedAlmond_si, nil, VarType(Graphics.clWebBlanchedAlmond));
  AData.AddConstant('clWebBisque', Graphics_clWebBisque_si, nil, VarType(Graphics.clWebBisque));
  AData.AddConstant('clWebPeachPuff', Graphics_clWebPeachPuff_si, nil, VarType(Graphics.clWebPeachPuff));
  AData.AddConstant('clWebTan', Graphics_clWebTan_si, nil, VarType(Graphics.clWebTan));
  AData.AddConstant('clWebYellow', Graphics_clWebYellow_si, nil, VarType(Graphics.clWebYellow));
  AData.AddConstant('clWebDarkOrange', Graphics_clWebDarkOrange_si, nil, VarType(Graphics.clWebDarkOrange));
  AData.AddConstant('clWebRed', Graphics_clWebRed_si, nil, VarType(Graphics.clWebRed));
  AData.AddConstant('clWebDarkRed', Graphics_clWebDarkRed_si, nil, VarType(Graphics.clWebDarkRed));
  AData.AddConstant('clWebMaroon', Graphics_clWebMaroon_si, nil, VarType(Graphics.clWebMaroon));
  AData.AddConstant('clWebIndianRed', Graphics_clWebIndianRed_si, nil, VarType(Graphics.clWebIndianRed));
  AData.AddConstant('clWebSalmon', Graphics_clWebSalmon_si, nil, VarType(Graphics.clWebSalmon));
  AData.AddConstant('clWebCoral', Graphics_clWebCoral_si, nil, VarType(Graphics.clWebCoral));
  AData.AddConstant('clWebGold', Graphics_clWebGold_si, nil, VarType(Graphics.clWebGold));
  AData.AddConstant('clWebTomato', Graphics_clWebTomato_si, nil, VarType(Graphics.clWebTomato));
  AData.AddConstant('clWebCrimson', Graphics_clWebCrimson_si, nil, VarType(Graphics.clWebCrimson));
  AData.AddConstant('clWebBrown', Graphics_clWebBrown_si, nil, VarType(Graphics.clWebBrown));
  AData.AddConstant('clWebChocolate', Graphics_clWebChocolate_si, nil, VarType(Graphics.clWebChocolate));
  AData.AddConstant('clWebSandyBrown', Graphics_clWebSandyBrown_si, nil, VarType(Graphics.clWebSandyBrown));
  AData.AddConstant('clWebLightSalmon', Graphics_clWebLightSalmon_si, nil, VarType(Graphics.clWebLightSalmon));
  AData.AddConstant('clWebLightCoral', Graphics_clWebLightCoral_si, nil, VarType(Graphics.clWebLightCoral));
  AData.AddConstant('clWebOrange', Graphics_clWebOrange_si, nil, VarType(Graphics.clWebOrange));
  AData.AddConstant('clWebOrangeRed', Graphics_clWebOrangeRed_si, nil, VarType(Graphics.clWebOrangeRed));
  AData.AddConstant('clWebFirebrick', Graphics_clWebFirebrick_si, nil, VarType(Graphics.clWebFirebrick));
  AData.AddConstant('clWebSaddleBrown', Graphics_clWebSaddleBrown_si, nil, VarType(Graphics.clWebSaddleBrown));
  AData.AddConstant('clWebSienna', Graphics_clWebSienna_si, nil, VarType(Graphics.clWebSienna));
  AData.AddConstant('clWebPeru', Graphics_clWebPeru_si, nil, VarType(Graphics.clWebPeru));
  AData.AddConstant('clWebDarkSalmon', Graphics_clWebDarkSalmon_si, nil, VarType(Graphics.clWebDarkSalmon));
  AData.AddConstant('clWebRosyBrown', Graphics_clWebRosyBrown_si, nil, VarType(Graphics.clWebRosyBrown));
  AData.AddConstant('clWebPaleGoldenrod', Graphics_clWebPaleGoldenrod_si, nil, VarType(Graphics.clWebPaleGoldenrod));
  AData.AddConstant('clWebLightGoldenrodYellow', Graphics_clWebLightGoldenrodYellow_si, nil, VarType(Graphics.clWebLightGoldenrodYellow));
  AData.AddConstant('clWebOlive', Graphics_clWebOlive_si, nil, VarType(Graphics.clWebOlive));
  AData.AddConstant('clWebForestGreen', Graphics_clWebForestGreen_si, nil, VarType(Graphics.clWebForestGreen));
  AData.AddConstant('clWebGreenYellow', Graphics_clWebGreenYellow_si, nil, VarType(Graphics.clWebGreenYellow));
  AData.AddConstant('clWebChartreuse', Graphics_clWebChartreuse_si, nil, VarType(Graphics.clWebChartreuse));
  AData.AddConstant('clWebLightGreen', Graphics_clWebLightGreen_si, nil, VarType(Graphics.clWebLightGreen));
  AData.AddConstant('clWebAquamarine', Graphics_clWebAquamarine_si, nil, VarType(Graphics.clWebAquamarine));
  AData.AddConstant('clWebSeaGreen', Graphics_clWebSeaGreen_si, nil, VarType(Graphics.clWebSeaGreen));
  AData.AddConstant('clWebGoldenRod', Graphics_clWebGoldenRod_si, nil, VarType(Graphics.clWebGoldenRod));
  AData.AddConstant('clWebKhaki', Graphics_clWebKhaki_si, nil, VarType(Graphics.clWebKhaki));
  AData.AddConstant('clWebOliveDrab', Graphics_clWebOliveDrab_si, nil, VarType(Graphics.clWebOliveDrab));
  AData.AddConstant('clWebGreen', Graphics_clWebGreen_si, nil, VarType(Graphics.clWebGreen));
  AData.AddConstant('clWebYellowGreen', Graphics_clWebYellowGreen_si, nil, VarType(Graphics.clWebYellowGreen));
  AData.AddConstant('clWebLawnGreen', Graphics_clWebLawnGreen_si, nil, VarType(Graphics.clWebLawnGreen));
  AData.AddConstant('clWebPaleGreen', Graphics_clWebPaleGreen_si, nil, VarType(Graphics.clWebPaleGreen));
  AData.AddConstant('clWebMediumAquamarine', Graphics_clWebMediumAquamarine_si, nil, VarType(Graphics.clWebMediumAquamarine));
  AData.AddConstant('clWebMediumSeaGreen', Graphics_clWebMediumSeaGreen_si, nil, VarType(Graphics.clWebMediumSeaGreen));
  AData.AddConstant('clWebDarkGoldenRod', Graphics_clWebDarkGoldenRod_si, nil, VarType(Graphics.clWebDarkGoldenRod));
  AData.AddConstant('clWebDarkKhaki', Graphics_clWebDarkKhaki_si, nil, VarType(Graphics.clWebDarkKhaki));
  AData.AddConstant('clWebDarkOliveGreen', Graphics_clWebDarkOliveGreen_si, nil, VarType(Graphics.clWebDarkOliveGreen));
  AData.AddConstant('clWebDarkgreen', Graphics_clWebDarkgreen_si, nil, VarType(Graphics.clWebDarkgreen));
  AData.AddConstant('clWebLimeGreen', Graphics_clWebLimeGreen_si, nil, VarType(Graphics.clWebLimeGreen));
  AData.AddConstant('clWebLime', Graphics_clWebLime_si, nil, VarType(Graphics.clWebLime));
  AData.AddConstant('clWebSpringGreen', Graphics_clWebSpringGreen_si, nil, VarType(Graphics.clWebSpringGreen));
  AData.AddConstant('clWebMediumSpringGreen', Graphics_clWebMediumSpringGreen_si, nil, VarType(Graphics.clWebMediumSpringGreen));
  AData.AddConstant('clWebDarkSeaGreen', Graphics_clWebDarkSeaGreen_si, nil, VarType(Graphics.clWebDarkSeaGreen));
  AData.AddConstant('clWebLightSeaGreen', Graphics_clWebLightSeaGreen_si, nil, VarType(Graphics.clWebLightSeaGreen));
  AData.AddConstant('clWebPaleTurquoise', Graphics_clWebPaleTurquoise_si, nil, VarType(Graphics.clWebPaleTurquoise));
  AData.AddConstant('clWebLightCyan', Graphics_clWebLightCyan_si, nil, VarType(Graphics.clWebLightCyan));
  AData.AddConstant('clWebLightBlue', Graphics_clWebLightBlue_si, nil, VarType(Graphics.clWebLightBlue));
  AData.AddConstant('clWebLightSkyBlue', Graphics_clWebLightSkyBlue_si, nil, VarType(Graphics.clWebLightSkyBlue));
  AData.AddConstant('clWebCornFlowerBlue', Graphics_clWebCornFlowerBlue_si, nil, VarType(Graphics.clWebCornFlowerBlue));
  AData.AddConstant('clWebDarkBlue', Graphics_clWebDarkBlue_si, nil, VarType(Graphics.clWebDarkBlue));
  AData.AddConstant('clWebIndigo', Graphics_clWebIndigo_si, nil, VarType(Graphics.clWebIndigo));
  AData.AddConstant('clWebMediumTurquoise', Graphics_clWebMediumTurquoise_si, nil, VarType(Graphics.clWebMediumTurquoise));
  AData.AddConstant('clWebTurquoise', Graphics_clWebTurquoise_si, nil, VarType(Graphics.clWebTurquoise));
  AData.AddConstant('clWebCyan', Graphics_clWebCyan_si, nil, VarType(Graphics.clWebCyan));
  AData.AddConstant('clWebAqua', Graphics_clWebAqua_si, nil, VarType(Graphics.clWebAqua));
  AData.AddConstant('clWebPowderBlue', Graphics_clWebPowderBlue_si, nil, VarType(Graphics.clWebPowderBlue));
  AData.AddConstant('clWebSkyBlue', Graphics_clWebSkyBlue_si, nil, VarType(Graphics.clWebSkyBlue));
  AData.AddConstant('clWebRoyalBlue', Graphics_clWebRoyalBlue_si, nil, VarType(Graphics.clWebRoyalBlue));
  AData.AddConstant('clWebMediumBlue', Graphics_clWebMediumBlue_si, nil, VarType(Graphics.clWebMediumBlue));
  AData.AddConstant('clWebMidnightBlue', Graphics_clWebMidnightBlue_si, nil, VarType(Graphics.clWebMidnightBlue));
  AData.AddConstant('clWebDarkTurquoise', Graphics_clWebDarkTurquoise_si, nil, VarType(Graphics.clWebDarkTurquoise));
  AData.AddConstant('clWebCadetBlue', Graphics_clWebCadetBlue_si, nil, VarType(Graphics.clWebCadetBlue));
  AData.AddConstant('clWebDarkCyan', Graphics_clWebDarkCyan_si, nil, VarType(Graphics.clWebDarkCyan));
  AData.AddConstant('clWebTeal', Graphics_clWebTeal_si, nil, VarType(Graphics.clWebTeal));
  AData.AddConstant('clWebDeepskyBlue', Graphics_clWebDeepskyBlue_si, nil, VarType(Graphics.clWebDeepskyBlue));
  AData.AddConstant('clWebDodgerBlue', Graphics_clWebDodgerBlue_si, nil, VarType(Graphics.clWebDodgerBlue));
  AData.AddConstant('clWebBlue', Graphics_clWebBlue_si, nil, VarType(Graphics.clWebBlue));
  AData.AddConstant('clWebNavy', Graphics_clWebNavy_si, nil, VarType(Graphics.clWebNavy));
  AData.AddConstant('clWebDarkViolet', Graphics_clWebDarkViolet_si, nil, VarType(Graphics.clWebDarkViolet));
  AData.AddConstant('clWebDarkOrchid', Graphics_clWebDarkOrchid_si, nil, VarType(Graphics.clWebDarkOrchid));
  AData.AddConstant('clWebMagenta', Graphics_clWebMagenta_si, nil, VarType(Graphics.clWebMagenta));
  AData.AddConstant('clWebFuchsia', Graphics_clWebFuchsia_si, nil, VarType(Graphics.clWebFuchsia));
  AData.AddConstant('clWebDarkMagenta', Graphics_clWebDarkMagenta_si, nil, VarType(Graphics.clWebDarkMagenta));
  AData.AddConstant('clWebMediumVioletRed', Graphics_clWebMediumVioletRed_si, nil, VarType(Graphics.clWebMediumVioletRed));
  AData.AddConstant('clWebPaleVioletRed', Graphics_clWebPaleVioletRed_si, nil, VarType(Graphics.clWebPaleVioletRed));
  AData.AddConstant('clWebBlueViolet', Graphics_clWebBlueViolet_si, nil, VarType(Graphics.clWebBlueViolet));
  AData.AddConstant('clWebMediumOrchid', Graphics_clWebMediumOrchid_si, nil, VarType(Graphics.clWebMediumOrchid));
  AData.AddConstant('clWebMediumPurple', Graphics_clWebMediumPurple_si, nil, VarType(Graphics.clWebMediumPurple));
  AData.AddConstant('clWebPurple', Graphics_clWebPurple_si, nil, VarType(Graphics.clWebPurple));
  AData.AddConstant('clWebDeepPink', Graphics_clWebDeepPink_si, nil, VarType(Graphics.clWebDeepPink));
  AData.AddConstant('clWebLightPink', Graphics_clWebLightPink_si, nil, VarType(Graphics.clWebLightPink));
  AData.AddConstant('clWebViolet', Graphics_clWebViolet_si, nil, VarType(Graphics.clWebViolet));
  AData.AddConstant('clWebOrchid', Graphics_clWebOrchid_si, nil, VarType(Graphics.clWebOrchid));
  AData.AddConstant('clWebPlum', Graphics_clWebPlum_si, nil, VarType(Graphics.clWebPlum));
  AData.AddConstant('clWebThistle', Graphics_clWebThistle_si, nil, VarType(Graphics.clWebThistle));
  AData.AddConstant('clWebHotPink', Graphics_clWebHotPink_si, nil, VarType(Graphics.clWebHotPink));
  AData.AddConstant('clWebPink', Graphics_clWebPink_si, nil, VarType(Graphics.clWebPink));
  AData.AddConstant('clWebLightSteelBlue', Graphics_clWebLightSteelBlue_si, nil, VarType(Graphics.clWebLightSteelBlue));
  AData.AddConstant('clWebMediumSlateBlue', Graphics_clWebMediumSlateBlue_si, nil, VarType(Graphics.clWebMediumSlateBlue));
  AData.AddConstant('clWebLightSlateGray', Graphics_clWebLightSlateGray_si, nil, VarType(Graphics.clWebLightSlateGray));
  AData.AddConstant('clWebWhite', Graphics_clWebWhite_si, nil, VarType(Graphics.clWebWhite));
  AData.AddConstant('clWebLightgrey', Graphics_clWebLightgrey_si, nil, VarType(Graphics.clWebLightgrey));
  AData.AddConstant('clWebGray', Graphics_clWebGray_si, nil, VarType(Graphics.clWebGray));
  AData.AddConstant('clWebSteelBlue', Graphics_clWebSteelBlue_si, nil, VarType(Graphics.clWebSteelBlue));
  AData.AddConstant('clWebSlateBlue', Graphics_clWebSlateBlue_si, nil, VarType(Graphics.clWebSlateBlue));
  AData.AddConstant('clWebSlateGray', Graphics_clWebSlateGray_si, nil, VarType(Graphics.clWebSlateGray));
  AData.AddConstant('clWebWhiteSmoke', Graphics_clWebWhiteSmoke_si, nil, VarType(Graphics.clWebWhiteSmoke));
  AData.AddConstant('clWebSilver', Graphics_clWebSilver_si, nil, VarType(Graphics.clWebSilver));
  AData.AddConstant('clWebDimGray', Graphics_clWebDimGray_si, nil, VarType(Graphics.clWebDimGray));
  AData.AddConstant('clWebMistyRose', Graphics_clWebMistyRose_si, nil, VarType(Graphics.clWebMistyRose));
  AData.AddConstant('clWebDarkSlateBlue', Graphics_clWebDarkSlateBlue_si, nil, VarType(Graphics.clWebDarkSlateBlue));
  AData.AddConstant('clWebDarkSlategray', Graphics_clWebDarkSlategray_si, nil, VarType(Graphics.clWebDarkSlategray));
  AData.AddConstant('clWebGainsboro', Graphics_clWebGainsboro_si, nil, VarType(Graphics.clWebGainsboro));
  AData.AddConstant('clWebDarkGray', Graphics_clWebDarkGray_si, nil, VarType(Graphics.clWebDarkGray));
  AData.AddConstant('clWebBlack', Graphics_clWebBlack_si, nil, VarType(Graphics.clWebBlack));
  AData.AddConstant('WebColorsCount', Graphics_WebColorsCount_si, nil, VarType(Graphics.WebColorsCount));
  AData.AddConstant('cmBlackness', Graphics_cmBlackness_si, Cardinal_sw);
  AData.AddConstant('cmDstInvert', Graphics_cmDstInvert_si, Cardinal_sw);
  AData.AddConstant('cmMergeCopy', Graphics_cmMergeCopy_si, Cardinal_sw);
  AData.AddConstant('cmMergePaint', Graphics_cmMergePaint_si, Cardinal_sw);
  AData.AddConstant('cmNotSrcCopy', Graphics_cmNotSrcCopy_si, Cardinal_sw);
  AData.AddConstant('cmNotSrcErase', Graphics_cmNotSrcErase_si, Cardinal_sw);
  AData.AddConstant('cmPatCopy', Graphics_cmPatCopy_si, Cardinal_sw);
  AData.AddConstant('cmPatInvert', Graphics_cmPatInvert_si, Cardinal_sw);
  AData.AddConstant('cmPatPaint', Graphics_cmPatPaint_si, Cardinal_sw);
  AData.AddConstant('cmSrcAnd', Graphics_cmSrcAnd_si, Cardinal_sw);
  AData.AddConstant('cmSrcCopy', Graphics_cmSrcCopy_si, Cardinal_sw);
  AData.AddConstant('cmSrcErase', Graphics_cmSrcErase_si, Cardinal_sw);
  AData.AddConstant('cmSrcInvert', Graphics_cmSrcInvert_si, Cardinal_sw);
  AData.AddConstant('cmSrcPaint', Graphics_cmSrcPaint_si, Cardinal_sw);
  AData.AddConstant('cmWhiteness', Graphics_cmWhiteness_si, Cardinal_sw);
  AData.AddConstant('rc3_StockIcon', Graphics_rc3_StockIcon_si, nil, VarType(Graphics.rc3_StockIcon));
  AData.AddConstant('rc3_Icon', Graphics_rc3_Icon_si, nil, VarType(Graphics.rc3_Icon));
  AData.AddConstant('rc3_Cursor', Graphics_rc3_Cursor_si, nil, VarType(Graphics.rc3_Cursor));
  AData.AddType(TCursorOrIcon_sw, Graphics_TCursorOrIcon_si);
  AData.AddType(TIconRec_sw, Graphics_TIconRec_si);
  AData.AddType(HMETAFILE_sw, Graphics_HMETAFILE_si);
  AData.AddType(HENHMETAFILE_sw, Graphics_HENHMETAFILE_si);
  AData.AddType(EInvalidGraphic_sw, Graphics_EInvalidGraphic_si);
  AData.AddType(EInvalidGraphicOperation_sw, Graphics_EInvalidGraphicOperation_si);
  AData.AddType(TResData_sw, Graphics_TResData_si);
  AData.AddType(TFontPitch_sw, Graphics_TFontPitch_si);
  AData.AddType(TFontName_sw, Graphics_TFontName_si);
  AData.AddType(TFontCharset_sw, Graphics_TFontCharset_si);
  AData.AddType(TFontStyle_sw, Graphics_TFontStyle_si);
  AData.AddType(TFontStyles_sw, Graphics_TFontStyles_si);
  AData.AddType(TFontDataName_sw, Graphics_TFontDataName_si);
  AData.AddType(TFontStylesBase_sw, Graphics_TFontStylesBase_si);
  AData.AddType(TFontData_sw, Graphics_TFontData_si);
  AData.AddType(TPenStyle_sw, Graphics_TPenStyle_si);
  AData.AddType(TPenMode_sw, Graphics_TPenMode_si);
  AData.AddType(TPenData_sw, Graphics_TPenData_si);
  AData.AddType(TBrushStyle_sw, Graphics_TBrushStyle_si);
  AData.AddType(TBrushData_sw, Graphics_TBrushData_si);
  AData.AddType(TResource_sw, Graphics_TResource_si);
  AData.AddType(TGraphicsObject_sw, Graphics_TGraphicsObject_si);
  AData.AddType(TFont_sw, Graphics_TFont_si);
  AData.AddType(TPen_sw, Graphics_TPen_si);
  AData.AddType(TBrush_sw, Graphics_TBrush_si);
  AData.AddType(TFontRecall_sw, Graphics_TFontRecall_si);
  AData.AddType(TPenRecall_sw, Graphics_TPenRecall_si);
  AData.AddType(TBrushRecall_sw, Graphics_TBrushRecall_si);
  AData.AddType(TFillStyle_sw, Graphics_TFillStyle_si);
  AData.AddType(TFillMode_sw, Graphics_TFillMode_si);
  AData.AddType(TCopyMode_sw, Graphics_TCopyMode_si);
  AData.AddType(TCanvasStates_sw, Graphics_TCanvasStates_si);
  AData.AddType(TCanvasState_sw, Graphics_TCanvasState_si);
  AData.AddType(TCanvasOrientation_sw, Graphics_TCanvasOrientation_si);
  AData.AddType(TTextFormats_sw, Graphics_TTextFormats_si);
  AData.AddType(TTextFormat_sw, Graphics_TTextFormat_si);
  AData.AddType(TCustomCanvas_sw, Graphics_TCustomCanvas_si);
  AData.AddType(TCanvas_sw, Graphics_TCanvas_si);
  AData.AddType(TProgressStage_sw, Graphics_TProgressStage_si);
  AData.AddType(TProgressEvent_sw, Graphics_TProgressEvent_si);
  AData.AddType(TGraphic_sw, Graphics_TGraphic_si);
  AData.AddType(TGraphicClass_sw, Graphics_TGraphicClass_si);
  AData.AddType(TPicture_sw, Graphics_TPicture_si);
  AData.AddType(TMetafileCanvas_sw, Graphics_TMetafileCanvas_si);
  AData.AddType(TSharedImage_sw, Graphics_TSharedImage_si);
  AData.AddType(TMetafileImage_sw, Graphics_TMetafileImage_si);
  AData.AddType(TMetafile_sw, Graphics_TMetafile_si);
  AData.AddType(TBitmapImage_sw, Graphics_TBitmapImage_si);
  AData.AddType(TBitmapHandleType_sw, Graphics_TBitmapHandleType_si);
  AData.AddType(TPixelFormat_sw, Graphics_TPixelFormat_si);
  AData.AddType(TAlphaFormat_sw, Graphics_TAlphaFormat_si);
  AData.AddType(TTransparentMode_sw, Graphics_TTransparentMode_si);
  AData.AddType(TBitmap_sw, Graphics_TBitmap_si);
  AData.AddType(TIconImage_sw, Graphics_TIconImage_si);
  AData.AddType(TIcon_sw, Graphics_TIcon_si);
  AData.AddType(TWICImageFormat_sw, Graphics_TWICImageFormat_si);
  AData.AddType(TWICImage_sw, Graphics_TWICImage_si);
  AData.AddVariable('DefFontData', Graphics_DefFontData_si, TFontData_sw);
  AData.AddVariable('SystemPalette16', Graphics_SystemPalette16_si, HPalette_sw);
  AData.AddVariable('DDBsOnly', Graphics_DDBsOnly_si, Boolean_sw);
  AData.AddFunction('GraphicFilter', Graphics_GraphicFilter_si, string_sw, 1, False);
  AData.AddFunction('GraphicExtension', Graphics_GraphicExtension_si, string_sw, 1, False);
  AData.AddFunction('GraphicFileMask', Graphics_GraphicFileMask_si, string_sw, 1, False);
  AData.AddFunction('ColorToRGB', Graphics_ColorToRGB_si, Longint_sw, 1, False);
  AData.AddFunction('ColorToString', Graphics_ColorToString_si, string_sw, 1, False);
  AData.AddFunction('StringToColor', Graphics_StringToColor_si, TColor_sw, 1, False);
  AData.AddProcedure('GetColorValues', Graphics_GetColorValues_si, 1, False);
  AData.AddFunction('ColorToIdent', Graphics_ColorToIdent_si, Boolean_sw, 2, False);
  AData.AddFunction('IdentToColor', Graphics_IdentToColor_si, Boolean_sw, 2, False);
  AData.AddProcedure('GetCharsetValues', Graphics_GetCharsetValues_si, 1, False);
  AData.AddFunction('CharsetToIdent', Graphics_CharsetToIdent_si, Boolean_sw, 2, False);
  AData.AddFunction('IdentToCharset', Graphics_IdentToCharset_si, Boolean_sw, 2, False);
  AData.AddProcedure('GetDIBSizes', Graphics_GetDIBSizes_si, 3, False);
  AData.AddFunction('CopyPalette', Graphics_CopyPalette_si, HPALETTE_sw, 1, False);
  AData.AddProcedure('PaletteChanged', Graphics_PaletteChanged_si, 0, False);
  AData.AddProcedure('FreeMemoryContexts', Graphics_FreeMemoryContexts_si, 0, False);
  AData.AddFunction('GetDefFontCharSet', Graphics_GetDefFontCharSet_si, TFontCharSet_sw, 0, False);
  AData.AddFunction('TransparentStretchBlt', Graphics_TransparentStretchBlt_si, Boolean_sw, 13, False);
  AData.AddFunction('CreateGrayMappedBmp', Graphics_CreateGrayMappedBmp_si, HBITMAP_sw, 1, False);
  AData.AddFunction('AllocPatternBitmap', Graphics_AllocPatternBitmap_si, TBitmap_sw, 2, False);
  AData.AddFunction('BytesPerScanline', Graphics_BytesPerScanline_si, Longint_sw, 3, False);
end;

class function Graphics_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Graphics_sw);
end;

initialization
  RegisterUnitWrapper(Graphics_sw);
  RegisterClassWrapper(EInvalidGraphic_sw);
  RegisterClassWrapper(EInvalidGraphicOperation_sw);
  RegisterClassWrapper(TGraphicsObject_sw);
  RegisterClassWrapper(TFont_sw);
  RegisterClassWrapper(TPen_sw);
  RegisterClassWrapper(TBrush_sw);
  RegisterClassWrapper(TFontRecall_sw);
  RegisterClassWrapper(TPenRecall_sw);
  RegisterClassWrapper(TBrushRecall_sw);
  RegisterClassWrapper(TCustomCanvas_sw);
  RegisterClassWrapper(TCanvas_sw);
  RegisterClassWrapper(TGraphic_sw);
  RegisterClassWrapper(TPicture_sw);
  RegisterClassWrapper(TMetafileCanvas_sw);
  RegisterClassWrapper(TSharedImage_sw);
  RegisterClassWrapper(TMetafileImage_sw);
  RegisterClassWrapper(TMetafile_sw);
  RegisterClassWrapper(TBitmapImage_sw);
  RegisterClassWrapper(TBitmap_sw);
  RegisterClassWrapper(TIconImage_sw);
  RegisterClassWrapper(TIcon_sw);
  RegisterClassWrapper(TWICImage_sw);
  RegisterEventWrapper(TypeInfo(TProgressEvent), TProgressEvent_sw);

end.
