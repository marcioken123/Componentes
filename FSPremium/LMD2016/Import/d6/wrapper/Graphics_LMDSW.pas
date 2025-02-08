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
  Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Types, SysUtils, Classes, Graphics,
  Windows_LMDSW, Types_LMDSW, SysUtils_LMDSW, Classes_LMDSW;


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

  TColor_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TColor): OleVariant;
    class function FromVar(const AValue: OleVariant): TColor;
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

  TFontDataName_sw = string_sw;

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

  TCanvas_sc = class of TCanvas;
  TCanvas_sw = class(TPersistent_sw)
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
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'psSolid'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psSolid)),
    (Name: 'psDash'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDash)),
    (Name: 'psDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDot)),
    (Name: 'psDashDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDashDot)),
    (Name: 'psDashDotDot'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psDashDotDot)),
    (Name: 'psClear'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psClear)),
    (Name: 'psInsideFrame'; Value: Integer({$IFDEF LMDSCT_12}TPenStyle.{$ENDIF}psInsideFrame))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
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

{ TCanvas_sw }

function TCanvas_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TCanvas_sw.ToVar(TCanvas_sc(AObj).Create());
end;

function TCanvas_Arc_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Arc(X1: Integer; Y1: Integer; X2: Integer; Y2: ...

  TCanvas(AObj).Arc(Integer(AArgs[0]), Integer(AArgs[1]), Integer(AArgs[2]), 
    Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
    Integer(AArgs[7]));
end;

function TCanvas_BrushCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap; c...

  TCanvas(AObj).BrushCopy(TRect_sw.FromVar(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), TRect_sw.FromVar(AArgs[2]), TColor_sw.FromVar(AArgs[3]));
end;

function TCanvas_Chord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Chord(X1: Integer; Y1: Integer; X2: Integer; Y2...

  TCanvas(AObj).Chord(Integer(AArgs[0]), Integer(AArgs[1]), Integer(AArgs[2]), 
    Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
    Integer(AArgs[7]));
end;

function TCanvas_CopyRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyRect(const Dest: TRect; Canvas: TCanvas; co...

  TCanvas(AObj).CopyRect(TRect_sw.FromVar(AArgs[0]), TCanvas_sw.FromVar(
    AArgs[1]), TRect_sw.FromVar(AArgs[2]));
end;

function TCanvas_Draw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Draw(X: Integer; Y: Integer; Graphic: TGraphic);

  TCanvas(AObj).Draw(Integer(AArgs[0]), Integer(AArgs[1]), TGraphic_sw.FromVar(
    AArgs[2]));
end;

function TCanvas_DrawFocusRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawFocusRect(const Rect: TRect);

  TCanvas(AObj).DrawFocusRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCanvas_Ellipse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Ellipse(...); overload;

  case AArgsSize of
    4:
    begin
      TCanvas(AObj).Ellipse(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
        AArgs[2]), Integer(AArgs[3]));
    end;
    1:
    begin
      TCanvas(AObj).Ellipse(TRect_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Ellipse');
  end;
end;

function TCanvas_FillRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FillRect(const Rect: TRect);

  TCanvas(AObj).FillRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCanvas_FloodFill_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FloodFill(X: Integer; Y: Integer; Color: TColor...

  TCanvas(AObj).FloodFill(Integer(AArgs[0]), Integer(AArgs[1]), TColor_sw.
    FromVar(AArgs[2]), TFillStyle_sw.FromVar(AArgs[3]));
end;

function TCanvas_FrameRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FrameRect(const Rect: TRect);

  TCanvas(AObj).FrameRect(TRect_sw.FromVar(AArgs[0]));
end;

function TCanvas_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TCanvas(AObj).HandleAllocated();
end;

function TCanvas_LineTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LineTo(X: Integer; Y: Integer);

  TCanvas(AObj).LineTo(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCanvas_Lock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Lock;

  TCanvas(AObj).Lock();
end;

function TCanvas_MoveTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MoveTo(X: Integer; Y: Integer);

  TCanvas(AObj).MoveTo(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCanvas_Pie_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Pie(X1: Integer; Y1: Integer; X2: Integer; Y2: ...

  TCanvas(AObj).Pie(Integer(AArgs[0]), Integer(AArgs[1]), Integer(AArgs[2]), 
    Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
    Integer(AArgs[7]));
end;

function TCanvas_Rectangle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Rectangle(...); overload;

  case AArgsSize of
    4:
    begin
      TCanvas(AObj).Rectangle(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
        AArgs[2]), Integer(AArgs[3]));
    end;
    1:
    begin
      TCanvas(AObj).Rectangle(TRect_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Rectangle');
  end;
end;

function TCanvas_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TCanvas(AObj).Refresh();
end;

function TCanvas_RoundRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RoundRect(X1: Integer; Y1: Integer; X2: Integer...

  TCanvas(AObj).RoundRect(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]), Integer(AArgs[4]), Integer(AArgs[5]));
end;

function TCanvas_StretchDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StretchDraw(const Rect: TRect; Graphic: TGraphic);

  TCanvas(AObj).StretchDraw(TRect_sw.FromVar(AArgs[0]), TGraphic_sw.FromVar(
    AArgs[1]));
end;

function TCanvas_TextExtent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextExtent(const Text: string): TSize;

  Result := TSize_sw.ToVar(TCanvas(AObj).TextExtent(string(AArgs[0])));
end;

function TCanvas_TextHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextHeight(const Text: string): Integer;

  Result := TCanvas(AObj).TextHeight(string(AArgs[0]));
end;

function TCanvas_TextOut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure TextOut(X: Integer; Y: Integer; const Text: str...

  TCanvas(AObj).TextOut(Integer(AArgs[0]), Integer(AArgs[1]), string(AArgs[2]));
end;

function TCanvas_TextRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure TextRect(Rect: TRect; X: Integer; Y: Integer; c...

  TCanvas(AObj).TextRect(TRect_sw.FromVar(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), string(AArgs[3]));
end;

function TCanvas_TextWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TextWidth(const Text: string): Integer;

  Result := TCanvas(AObj).TextWidth(string(AArgs[0]));
end;

function TCanvas_TryLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TryLock: Boolean;

  Result := TCanvas(AObj).TryLock();
end;

function TCanvas_Unlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Unlock;

  TCanvas(AObj).Unlock();
end;

function TCanvas_ClipRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClipRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TCanvas(AObj).ClipRect);
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

function TCanvas_LockCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LockCount: Integer read <getter>;

  Result := TCanvas(AObj).LockCount;
end;

function TCanvas_CanvasOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanvasOrientation: TCanvasOrientation read <gett...

  Result := TCanvasOrientation_sw.ToVar(TCanvas(AObj).CanvasOrientation);
end;

function TCanvas_PenPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PenPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TCanvas(AObj).PenPos)
  else
    TCanvas(AObj).PenPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TCanvas_Pixels_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pixels[X: Integer; Y: Integer]: TColor read <get...

  if IsGet then
    Result := TColor_sw.ToVar(TCanvas(AObj).Pixels[Integer(AArgs[0]), Integer(
      AArgs[1])])
  else
    TCanvas(AObj).Pixels[Integer(AArgs[0]), Integer(AArgs[1])] := TColor_sw.
      FromVar(AArgs[2]);
end;

function TCanvas_TextFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TextFlags: Longint read <getter> write <setter>;

  if IsGet then
    Result := TCanvas(AObj).TextFlags
  else
    TCanvas(AObj).TextFlags := Longint(AArgs[0]);
end;

function TCanvas_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCanvas(AObj).OnChange)
  else
    TCanvas(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCanvas_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChanging: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCanvas(AObj).OnChanging)
  else
    TCanvas(AObj).OnChanging := TNotifyEvent_sw.FromVar(AArgs[0]);
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

  AData.AddProcedure('Arc', TCanvas_Arc_si, 8, False);
  AData.AddProcedure('BrushCopy', TCanvas_BrushCopy_si, 4, False);
  AData.AddProcedure('Chord', TCanvas_Chord_si, 8, False);
  AData.AddProcedure('CopyRect', TCanvas_CopyRect_si, 3, False);
  AData.AddProcedure('Draw', TCanvas_Draw_si, 3, False);
  AData.AddProcedure('DrawFocusRect', TCanvas_DrawFocusRect_si, 1, False);
  AData.AddProcedure('Ellipse', TCanvas_Ellipse_si, 1, True);
  AData.AddProcedure('FillRect', TCanvas_FillRect_si, 1, False);
  AData.AddProcedure('FloodFill', TCanvas_FloodFill_si, 4, False);
  AData.AddProcedure('FrameRect', TCanvas_FrameRect_si, 1, False);
  AData.AddFunction('HandleAllocated', TCanvas_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProcedure('LineTo', TCanvas_LineTo_si, 2, False);
  AData.AddProcedure('Lock', TCanvas_Lock_si, 0, False);
  AData.AddProcedure('MoveTo', TCanvas_MoveTo_si, 2, False);
  AData.AddProcedure('Pie', TCanvas_Pie_si, 8, False);
  AData.AddProcedure('Rectangle', TCanvas_Rectangle_si, 1, True);
  AData.AddProcedure('Refresh', TCanvas_Refresh_si, 0, False);
  AData.AddProcedure('RoundRect', TCanvas_RoundRect_si, 6, False);
  AData.AddProcedure('StretchDraw', TCanvas_StretchDraw_si, 2, False);
  AData.AddFunction('TextExtent', TCanvas_TextExtent_si, TSize_sw, 1, False);
  AData.AddFunction('TextHeight', TCanvas_TextHeight_si, Integer_sw, 1, False);
  AData.AddProcedure('TextOut', TCanvas_TextOut_si, 3, False);
  AData.AddProcedure('TextRect', TCanvas_TextRect_si, 4, False);
  AData.AddFunction('TextWidth', TCanvas_TextWidth_si, Integer_sw, 1, False);
  AData.AddFunction('TryLock', TCanvas_TryLock_si, Boolean_sw, 0, False);
  AData.AddProcedure('Unlock', TCanvas_Unlock_si, 0, False);
  AData.AddProperty('ClipRect', TCanvas_ClipRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TCanvas_Handle_si, HDC_sw, True, True, 0, False, False);
  AData.AddProperty('LockCount', TCanvas_LockCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('CanvasOrientation', TCanvas_CanvasOrientation_si, TCanvasOrientation_sw, True, False, 0, False, False);
  AData.AddProperty('PenPos', TCanvas_PenPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Pixels', TCanvas_Pixels_si, TColor_sw, True, True, 2, False, False);
  AData.AddProperty('TextFlags', TCanvas_TextFlags_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TCanvas_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnChanging', TCanvas_OnChanging_si, TNotifyEvent_sw, True, True, 0, False, False);
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
  AData.AddProperty('Empty', TGraphic_Empty_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Height', TGraphic_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Modified', TGraphic_Modified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Palette', TGraphic_Palette_si, HPALETTE_sw, True, True, 0, False, False);
  AData.AddProperty('PaletteModified', TGraphic_PaletteModified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Transparent', TGraphic_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TGraphic_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TGraphic_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnProgress', TGraphic_OnProgress_si, TProgressEvent_sw, True, True, 0, False, False);

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

function TPicture_RegisterFileFormatRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RegisterFileFormatRes(const AExtension: s...

  TPicture_sc(AObj).RegisterFileFormatRes(string(AArgs[0]), Integer(AArgs[1]), 
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
  AData.AddClassProcedure('RegisterFileFormatRes', TPicture_RegisterFileFormatRes_si, 3, False);
  AData.AddClassProcedure('RegisterClipboardFormat', TPicture_RegisterClipboardFormat_si, 2, False);
  AData.AddClassProcedure('UnregisterGraphicClass', TPicture_UnregisterGraphicClass_si, 1, False);
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
  AData.AddProcedure('LoadFromResourceName', TBitmap_LoadFromResourceName_si, 2, False);
  AData.AddProcedure('LoadFromResourceID', TBitmap_LoadFromResourceID_si, 2, False);
  AData.AddProcedure('Mask', TBitmap_Mask_si, 1, False);
  AData.AddFunction('ReleaseHandle', TBitmap_ReleaseHandle_si, HBITMAP_sw, 0, False);
  AData.AddFunction('ReleaseMaskHandle', TBitmap_ReleaseMaskHandle_si, HBITMAP_sw, 0, False);
  AData.AddFunction('ReleasePalette', TBitmap_ReleasePalette_si, HPALETTE_sw, 0, False);
  AData.AddProperty('Canvas', TBitmap_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TBitmap_Handle_si, HBITMAP_sw, True, True, 0, False, False);
  AData.AddProperty('HandleType', TBitmap_HandleType_si, TBitmapHandleType_sw, True, True, 0, False, False);
  AData.AddProperty('IgnorePalette', TBitmap_IgnorePalette_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaskHandle', TBitmap_MaskHandle_si, HBITMAP_sw, True, True, 0, False, False);
  AData.AddProperty('Monochrome', TBitmap_Monochrome_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PixelFormat', TBitmap_PixelFormat_si, TPixelFormat_sw, True, True, 0, False, False);
  AData.AddProperty('TransparentColor', TBitmap_TransparentColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TransparentMode', TBitmap_TransparentMode_si, TTransparentMode_sw, True, True, 0, False, False);
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

{ Graphics_sw }

function Graphics_TColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColor = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TColor_sw);
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

function Graphics_TFontDataName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDataName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFontDataName_sw);
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

function Graphics_TCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvas = class(TPersistent);

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
  AData.AddConstant('clGradientActiveCaption', Graphics_clGradientActiveCaption_si, TColor_sw);
  AData.AddConstant('clGradientInactiveCaption', Graphics_clGradientInactiveCaption_si, TColor_sw);
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
  AData.AddType(HMETAFILE_sw, Graphics_HMETAFILE_si);
  AData.AddType(HENHMETAFILE_sw, Graphics_HENHMETAFILE_si);
  AData.AddType(EInvalidGraphic_sw, Graphics_EInvalidGraphic_si);
  AData.AddType(EInvalidGraphicOperation_sw, Graphics_EInvalidGraphicOperation_si);
  AData.AddType(TResData_sw, Graphics_TResData_si);
  AData.AddType(TFontPitch_sw, Graphics_TFontPitch_si);
  AData.AddType(TFontName_sw, Graphics_TFontName_si);
  AData.AddType(TFontCharset_sw, Graphics_TFontCharset_si);
  AData.AddType(TFontDataName_sw, Graphics_TFontDataName_si);
  AData.AddType(TFontStyle_sw, Graphics_TFontStyle_si);
  AData.AddType(TFontStyles_sw, Graphics_TFontStyles_si);
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
  AData.AddType(TTransparentMode_sw, Graphics_TTransparentMode_si);
  AData.AddType(TBitmap_sw, Graphics_TBitmap_si);
  AData.AddType(TIconImage_sw, Graphics_TIconImage_si);
  AData.AddType(TIcon_sw, Graphics_TIcon_si);
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
  RegisterEventWrapper(TypeInfo(TProgressEvent), TProgressEvent_sw);

end.
