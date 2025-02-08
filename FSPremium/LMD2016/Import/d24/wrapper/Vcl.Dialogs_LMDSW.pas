unit Vcl.Dialogs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.Dialogs' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Variants, System.TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Windows, Winapi.Messages,
  System.SysUtils, Winapi.CommDlg, Vcl.Printers, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Winapi.ShlObj, Winapi.CommCtrl,
  Vcl.ComCtrls, System.UITypes, Vcl.Dialogs, Winapi.Windows_LMDSW,
  Winapi.Messages_LMDSW, System.SysUtils_LMDSW, Winapi.CommDlg_LMDSW,
  Vcl.Printers_LMDSW, System.Classes_LMDSW, Vcl.Graphics_LMDSW,
  Vcl.Controls_LMDSW, Vcl.Forms_LMDSW, Vcl.StdCtrls_LMDSW, Winapi.ShlObj_LMDSW,
  Winapi.CommCtrl_LMDSW, Vcl.ComCtrls_LMDSW, System.UITypes_LMDSW;


{ Type wrappers }

type
  TCommonDialog_sw = class;
  TOpenDialog_sw = class;
  TSaveDialog_sw = class;
  TColorDialog_sw = class;
  TFontDialog_sw = class;
  TPrinterSetupDialog_sw = class;
  TPrintDialog_sw = class;
  TPageSetupDialog_sw = class;
  TFindDialog_sw = class;
  TReplaceDialog_sw = class;
  EPlatformVersionException_sw = class;
  TFileTypeItem_sw = class;
  TFileTypeItems_sw = class;
  TFavoriteLinkItem_sw = class;
  TFavoriteLinkItemsEnumerator_sw = class;
  TFavoriteLinkItems_sw = class;
  TCustomFileDialog_sw = class;
  TCustomFileOpenDialog_sw = class;
  TFileOpenDialog_sw = class;
  TCustomFileSaveDialog_sw = class;
  TFileSaveDialog_sw = class;
  TTaskDialogProgressBar_sw = class;
  TTaskDialogBaseButtonItem_sw = class;
  TTaskDialogButtonItem_sw = class;
  TTaskDialogRadioButtonItem_sw = class;
  TTaskDialogButtonsEnumerator_sw = class;
  TTaskDialogButtons_sw = class;
  TCustomTaskDialog_sw = class;
  TTaskDialog_sw = class;

  TCommonDialog_sc = class of TCommonDialog;
  TCommonDialog_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCommonDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonDialog;
    class function ClassToVar(AClass: TCommonDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCommonDialog_sc;
  end;

  TOpenOption_sw = System.UITypes_LMDSW.TOpenOption_sw;

  TOpenOptions_sw = System.UITypes_LMDSW.TOpenOptions_sw;

  TOpenOptionEx_sw = System.UITypes_LMDSW.TOpenOptionEx_sw;

  TOpenOptionsEx_sw = System.UITypes_LMDSW.TOpenOptionsEx_sw;

  TFileEditStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFileEditStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileEditStyle;
  end;

  TOFNotifyEx_sw = class(Winapi.CommDlg_LMDSW.TOFNotifyEx_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOFNotifyEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TOFNotifyEx;
  end;

  TIncludeItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const OFN: TOFNotifyEx; var Include: Boolean);
  end;

  TIncludeItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TIncludeItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TIncludeItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TIncludeItemEvent;
  end;

  TOpenDialog_sc = class of TOpenDialog;
  TOpenDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOpenDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenDialog;
    class function ClassToVar(AClass: TOpenDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOpenDialog_sc;
  end;

  TSaveDialog_sc = class of TSaveDialog;
  TSaveDialog_sw = class(TOpenDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSaveDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TSaveDialog;
    class function ClassToVar(AClass: TSaveDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSaveDialog_sc;
  end;

  TColorDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColorDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialogOption;
  end;

  TColorDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TColorDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialogOptions;
  end;

  TColorDialog_sc = class of TColorDialog;
  TColorDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColorDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialog;
    class function ClassToVar(AClass: TColorDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColorDialog_sc;
  end;

  TFontDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogOption;
  end;

  TFontDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogOptions;
  end;

  TFontDialogDevice_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontDialogDevice): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogDevice;
  end;

  TFDApplyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Wnd: HWND);
  end;

  TFDApplyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFDApplyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFDApplyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFDApplyEvent;
  end;

  TFontDialog_sc = class of TFontDialog;
  TFontDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFontDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialog;
    class function ClassToVar(AClass: TFontDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFontDialog_sc;
  end;

  TPrinterSetupDialog_sc = class of TPrinterSetupDialog;
  TPrinterSetupDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrinterSetupDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterSetupDialog;
    class function ClassToVar(AClass: TPrinterSetupDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrinterSetupDialog_sc;
  end;

  TPrintRange_sw = System.UITypes_LMDSW.TPrintRange_sw;

  TPrintDialogOption_sw = System.UITypes_LMDSW.TPrintDialogOption_sw;

  TPrintDialogOptions_sw = System.UITypes_LMDSW.TPrintDialogOptions_sw;

  TPrintDialog_sc = class of TPrintDialog;
  TPrintDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrintDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintDialog;
    class function ClassToVar(AClass: TPrintDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrintDialog_sc;
  end;

  TPrinterOrientation_sw = Vcl.Printers_LMDSW.TPrinterOrientation_sw;

  TPageSetupDialogOption_sw = System.UITypes_LMDSW.TPageSetupDialogOption_sw;

  TPageSetupDialogOptions_sw = System.UITypes_LMDSW.TPageSetupDialogOptions_sw;

  TPrinterKind_sw = System.UITypes_LMDSW.TPrinterKind_sw;

  TPageType_sw = System.UITypes_LMDSW.TPageType_sw;

  TPageMeasureUnits_sw = System.UITypes_LMDSW.TPageMeasureUnits_sw;

  TPageSetupBeforePaintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const PaperSize: SmallInt;
      const Orientation: TPrinterOrientation; const PageType: TPageType;
      var DoneDrawing: Boolean);
  end;

  TPageSetupBeforePaintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPageSetupBeforePaintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupBeforePaintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPageSetupBeforePaintEvent;
  end;

  TPaintPageEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Canvas: TCanvas; PageRect: TRect;
      var DoneDrawing: Boolean);
  end;

  TPaintPageEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPaintPageEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPaintPageEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPaintPageEvent;
  end;

  TPageSetupDialog_sc = class of TPageSetupDialog;
  TPageSetupDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPageSetupDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupDialog;
    class function ClassToVar(AClass: TPageSetupDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPageSetupDialog_sc;
  end;

  TFindOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFindOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindOption;
  end;

  TFindOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFindOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindOptions;
  end;

  TFindDialog_sc = class of TFindDialog;
  TFindDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFindDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindDialog;
    class function ClassToVar(AClass: TFindDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFindDialog_sc;
  end;

  TReplaceDialog_sc = class of TReplaceDialog;
  TReplaceDialog_sw = class(TFindDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TReplaceDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TReplaceDialog;
    class function ClassToVar(AClass: TReplaceDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TReplaceDialog_sc;
  end;

  EPlatformVersionException_sc = class of EPlatformVersionException;
  EPlatformVersionException_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPlatformVersionException): OleVariant;
    class function FromVar(const AValue: OleVariant): EPlatformVersionException;
    class function ClassToVar(AClass: EPlatformVersionException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPlatformVersionException_sc;
  end;

  TFileDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFileDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogOption;
  end;

  TFileDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFileDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogOptions;
  end;

  TFileDialogOverwriteResponse_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFileDialogOverwriteResponse): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogOverwriteResponse;
  end;

  TFileDialogShareViolationResponse_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFileDialogShareViolationResponse): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogShareViolationResponse;
  end;

  TFileDialogCloseEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var CanClose: Boolean);
  end;

  TFileDialogCloseEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFileDialogCloseEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogCloseEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFileDialogCloseEvent;
  end;

  TFileDialogFolderChangingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var CanChange: Boolean);
  end;

  TFileDialogFolderChangingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFileDialogFolderChangingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogFolderChangingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFileDialogFolderChangingEvent;
  end;

  TFileDialogOverwriteEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject;
      var Response: TFileDialogOverwriteResponse);
  end;

  TFileDialogOverwriteEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFileDialogOverwriteEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogOverwriteEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFileDialogOverwriteEvent;
  end;

  TFileDialogShareViolationEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject;
      var Response: TFileDialogShareViolationResponse);
  end;

  TFileDialogShareViolationEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFileDialogShareViolationEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileDialogShareViolationEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFileDialogShareViolationEvent;
  end;

  TFileTypeItem_sc = class of TFileTypeItem;
  TFileTypeItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileTypeItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileTypeItem;
    class function ClassToVar(AClass: TFileTypeItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileTypeItem_sc;
  end;

  TFileTypeItems_sc = class of TFileTypeItems;
  TFileTypeItems_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileTypeItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileTypeItems;
    class function ClassToVar(AClass: TFileTypeItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileTypeItems_sc;
  end;

  TFavoriteLinkItem_sc = class of TFavoriteLinkItem;
  TFavoriteLinkItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFavoriteLinkItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TFavoriteLinkItem;
    class function ClassToVar(AClass: TFavoriteLinkItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFavoriteLinkItem_sc;
  end;

  TFavoriteLinkItemsEnumerator_sc = class of TFavoriteLinkItemsEnumerator;
  TFavoriteLinkItemsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFavoriteLinkItemsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TFavoriteLinkItemsEnumerator;
    class function ClassToVar(AClass: TFavoriteLinkItemsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFavoriteLinkItemsEnumerator_sc;
  end;

  TFavoriteLinkItems_sc = class of TFavoriteLinkItems;
  TFavoriteLinkItems_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFavoriteLinkItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TFavoriteLinkItems;
    class function ClassToVar(AClass: TFavoriteLinkItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFavoriteLinkItems_sc;
  end;

  TCustomFileDialog_sc = class of TCustomFileDialog;
  TCustomFileDialog_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomFileDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFileDialog;
    class function ClassToVar(AClass: TCustomFileDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomFileDialog_sc;
  end;

  TCustomFileOpenDialog_sc = class of TCustomFileOpenDialog;
  TCustomFileOpenDialog_sw = class(TCustomFileDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomFileOpenDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFileOpenDialog;
    class function ClassToVar(AClass: TCustomFileOpenDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomFileOpenDialog_sc;
  end;

  TFileOpenDialog_sc = class of TFileOpenDialog;
  TFileOpenDialog_sw = class(TCustomFileOpenDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileOpenDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileOpenDialog;
    class function ClassToVar(AClass: TFileOpenDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileOpenDialog_sc;
  end;

  TCustomFileSaveDialog_sc = class of TCustomFileSaveDialog;
  TCustomFileSaveDialog_sw = class(TCustomFileDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomFileSaveDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFileSaveDialog;
    class function ClassToVar(AClass: TCustomFileSaveDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomFileSaveDialog_sc;
  end;

  TFileSaveDialog_sc = class of TFileSaveDialog;
  TFileSaveDialog_sw = class(TCustomFileSaveDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileSaveDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileSaveDialog;
    class function ClassToVar(AClass: TFileSaveDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileSaveDialog_sc;
  end;

  TTaskDialogFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTaskDialogFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogFlag;
  end;

  TTaskDialogFlags_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTaskDialogFlags): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogFlags;
  end;

  TTaskDialogCommonButton_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTaskDialogCommonButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogCommonButton;
  end;

  TTaskDialogCommonButtons_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTaskDialogCommonButtons): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogCommonButtons;
  end;

  TTaskDialogIcon_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTaskDialogIcon): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogIcon;
  end;

  TProgressBarState_sw = Vcl.ComCtrls_LMDSW.TProgressBarState_sw;

  TTaskDialogProgressBar_sc = class of TTaskDialogProgressBar;
  TTaskDialogProgressBar_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogProgressBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogProgressBar;
    class function ClassToVar(AClass: TTaskDialogProgressBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogProgressBar_sc;
  end;

  TTaskDialogBaseButtonItem_sc = class of TTaskDialogBaseButtonItem;
  TTaskDialogBaseButtonItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogBaseButtonItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogBaseButtonItem;
    class function ClassToVar(AClass: TTaskDialogBaseButtonItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogBaseButtonItem_sc;
  end;

  TTaskDialogButtonItem_sc = class of TTaskDialogButtonItem;
  TTaskDialogButtonItem_sw = class(TTaskDialogBaseButtonItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogButtonItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogButtonItem;
    class function ClassToVar(AClass: TTaskDialogButtonItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogButtonItem_sc;
  end;

  TTaskDialogRadioButtonItem_sc = class of TTaskDialogRadioButtonItem;
  TTaskDialogRadioButtonItem_sw = class(TTaskDialogBaseButtonItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogRadioButtonItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogRadioButtonItem;
    class function ClassToVar(AClass: TTaskDialogRadioButtonItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogRadioButtonItem_sc;
  end;

  TTaskDialogButtonsEnumerator_sc = class of TTaskDialogButtonsEnumerator;
  TTaskDialogButtonsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogButtonsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogButtonsEnumerator;
    class function ClassToVar(AClass: TTaskDialogButtonsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogButtonsEnumerator_sc;
  end;

  TTaskDialogButtons_sc = class of TTaskDialogButtons;
  TTaskDialogButtons_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialogButtons): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialogButtons;
    class function ClassToVar(AClass: TTaskDialogButtons_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialogButtons_sc;
  end;

  TTaskDlgClickEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ModalResult: TModalResult;
      var CanClose: Boolean);
  end;

  TTaskDlgClickEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTaskDlgClickEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDlgClickEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTaskDlgClickEvent;
  end;

  TTaskDlgTimerEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; TickCount: Cardinal; var Reset: Boolean);
  end;

  TTaskDlgTimerEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTaskDlgTimerEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDlgTimerEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTaskDlgTimerEvent;
  end;

  TCustomTaskDialog_sc = class of TCustomTaskDialog;
  TCustomTaskDialog_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomTaskDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomTaskDialog;
    class function ClassToVar(AClass: TCustomTaskDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomTaskDialog_sc;
  end;

  TTaskDialog_sc = class of TTaskDialog;
  TTaskDialog_sw = class(TCustomTaskDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTaskDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TTaskDialog;
    class function ClassToVar(AClass: TTaskDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTaskDialog_sc;
  end;

  TMsgDlgType_sw = System.UITypes_LMDSW.TMsgDlgType_sw;

  TMsgDlgBtn_sw = System.UITypes_LMDSW.TMsgDlgBtn_sw;

  TMsgDlgButtons_sw = System.UITypes_LMDSW.TMsgDlgButtons_sw;


{ Unit wrapper }

type
  Dialogs_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCommonDialog_sacc = class(TCommonDialog);

{ TCommonDialog_sw }

function TCommonDialog_TemplateModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TemplateModule: HINST read <getter> wr...

  if IsGet then
    Result := HINST_sw.ToVar(TCommonDialog_sacc(TCommonDialog(AObj)).
      TemplateModule)
  else
    TCommonDialog_sacc(TCommonDialog(AObj)).TemplateModule := HINST_sw.FromVar(
      AArgs[0]);
end;

function TCommonDialog_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Execute(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TCommonDialog(AObj).Execute();
    end;
    1:
    begin
      Result := TCommonDialog(AObj).Execute(HWND_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Execute');
  end;
end;

function TCommonDialog_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TCommonDialog(AObj).Handle);
end;

function TCommonDialog_Ctl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ctl3D: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCommonDialog(AObj).Ctl3D
  else
    TCommonDialog(AObj).Ctl3D := Boolean(AArgs[0]);
end;

function TCommonDialog_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TCommonDialog(AObj).HelpContext)
  else
    TCommonDialog(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TCommonDialog_OnClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClose: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialog(AObj).OnClose)
  else
    TCommonDialog(AObj).OnClose := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCommonDialog_OnShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShow: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialog(AObj).OnShow)
  else
    TCommonDialog(AObj).OnShow := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCommonDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCommonDialog';
end;

class function TCommonDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCommonDialog;
end;

class procedure TCommonDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('TemplateModule', TCommonDialog_TemplateModule_si, HINST_sw, True, True, 0, True, False);
  AData.AddFunction('Execute', TCommonDialog_Execute_si, nil, 0, True);
  AData.AddProperty('Handle', TCommonDialog_Handle_si, HWnd_sw, True, False, 0, False, False);
  AData.AddProperty('Ctl3D', TCommonDialog_Ctl3D_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HelpContext', TCommonDialog_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddProperty('OnClose', TCommonDialog_OnClose_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShow', TCommonDialog_OnShow_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCommonDialog_sw.ToVar(const AValue: TCommonDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCommonDialog_sw.FromVar(
  const AValue: OleVariant): TCommonDialog;
begin
  Result := TCommonDialog(ConvFromVar(AValue, TCommonDialog));
end;

class function TCommonDialog_sw.ClassToVar(
  AClass: TCommonDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCommonDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCommonDialog_sc;
begin
  Result := TCommonDialog_sc(ConvClsFromVar(AClass, TCommonDialog));
end;

{ TFileEditStyle_sw }

class function TFileEditStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFileEditStyle';
end;

class procedure TFileEditStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'fsEdit'; Value: Integer({$IFDEF LMDSCT_12}TFileEditStyle.{$ENDIF}fsEdit)),
    (Name: 'fsComboBox'; Value: Integer({$IFDEF LMDSCT_12}TFileEditStyle.{$ENDIF}fsComboBox))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFileEditStyle_sw.ToVar(
  const AValue: TFileEditStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFileEditStyle_sw.FromVar(
  const AValue: OleVariant): TFileEditStyle;
begin
  Result := TFileEditStyle(Integer(AValue));
end;

{ TOFNotifyEx_sw }

class function TOFNotifyEx_sw.GetTypeName: WideString;
begin
  Result := 'TOFNotifyEx';
end;

class function TOFNotifyEx_sw.ToVar(const AValue: TOFNotifyEx): OleVariant;
begin
  Result := Winapi.CommDlg_LMDSW.TOFNotifyEx_sw.ToVar(Winapi.CommDlg.
  TOFNotifyEx(AValue));
end;

class function TOFNotifyEx_sw.FromVar(const AValue: OleVariant): TOFNotifyEx;
begin
  Result := TOFNotifyEx(Winapi.CommDlg_LMDSW.TOFNotifyEx_sw.FromVar(AValue));
end;

{ TIncludeItemEvent_sh }

function TIncludeItemEvent_sh.GetHandler: TMethod;
var
  hdr: TIncludeItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TIncludeItemEvent_sh.Handler(const OFN: TOFNotifyEx;
  var Include: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (const OFN: TOFNotifyEx; var Include: Boolean) ...

  v_1 := Include;
  args[0] := TOFNotifyEx_sw.ToVar(OFN);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Include := Boolean(v_1);
end;

{ TIncludeItemEvent_sw }

class function TIncludeItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TIncludeItemEvent';
end;

class function TIncludeItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TIncludeItemEvent_sh;
end;

class function TIncludeItemEvent_sw.ToVar(
  const AValue: TIncludeItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TIncludeItemEvent_sw.FromVar(
  const AValue: OleVariant): TIncludeItemEvent;
begin
  Result := TIncludeItemEvent(ConvFromVar(AValue));
end;

class function TIncludeItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TIncludeItemEvent;
var
  hdlr: TIncludeItemEvent_sh;
begin
  hdlr   := TIncludeItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TIncludeItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TOpenDialog_sw }

function TOpenDialog_FileEditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileEditStyle: TFileEditStyle read <getter> writ...

  if IsGet then
    Result := TFileEditStyle_sw.ToVar(TOpenDialog(AObj).FileEditStyle)
  else
    TOpenDialog(AObj).FileEditStyle := TFileEditStyle_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Files_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Files: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TOpenDialog(AObj).Files);
end;

function TOpenDialog_HistoryList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HistoryList: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TOpenDialog(AObj).HistoryList)
  else
    TOpenDialog(AObj).HistoryList := TStrings_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_DefaultExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultExt: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).DefaultExt
  else
    TOpenDialog(AObj).DefaultExt := string(AArgs[0]);
end;

function TOpenDialog_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TOpenDialog(AObj).FileName)
  else
    TOpenDialog(AObj).FileName := TFileName_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Filter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Filter: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).Filter
  else
    TOpenDialog(AObj).Filter := string(AArgs[0]);
end;

function TOpenDialog_FilterIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FilterIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).FilterIndex
  else
    TOpenDialog(AObj).FilterIndex := Integer(AArgs[0]);
end;

function TOpenDialog_InitialDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InitialDir: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).InitialDir
  else
    TOpenDialog(AObj).InitialDir := string(AArgs[0]);
end;

function TOpenDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TOpenOptions read <getter> write <setter>;

  if IsGet then
    Result := TOpenOptions_sw.ToVar(TOpenDialog(AObj).Options)
  else
    TOpenDialog(AObj).Options := TOpenOptions_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OptionsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OptionsEx: TOpenOptionsEx read <getter> write <s...

  if IsGet then
    Result := TOpenOptionsEx_sw.ToVar(TOpenDialog(AObj).OptionsEx)
  else
    TOpenDialog(AObj).OptionsEx := TOpenOptionsEx_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).Title
  else
    TOpenDialog(AObj).Title := string(AArgs[0]);
end;

function TOpenDialog_OnCanClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCanClose: TCloseQueryEvent read <getter> write...

  if IsGet then
    Result := TCloseQueryEvent_sw.ToVar(TOpenDialog(AObj).OnCanClose)
  else
    TOpenDialog(AObj).OnCanClose := TCloseQueryEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnFolderChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFolderChange: TNotifyEvent read <getter> write...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnFolderChange)
  else
    TOpenDialog(AObj).OnFolderChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnSelectionChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSelectionChange: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnSelectionChange)
  else
    TOpenDialog(AObj).OnSelectionChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnTypeChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTypeChange: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnTypeChange)
  else
    TOpenDialog(AObj).OnTypeChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnIncludeItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnIncludeItem: TIncludeItemEvent read <getter> w...

  if IsGet then
    Result := TIncludeItemEvent_sw.ToVar(TOpenDialog(AObj).OnIncludeItem)
  else
    TOpenDialog(AObj).OnIncludeItem := TIncludeItemEvent_sw.FromVar(AArgs[0]);
end;

class function TOpenDialog_sw.GetTypeName: WideString;
begin
  Result := 'TOpenDialog';
end;

class function TOpenDialog_sw.GetWrappedClass: TClass;
begin
  Result := TOpenDialog;
end;

class procedure TOpenDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FileEditStyle', TOpenDialog_FileEditStyle_si, TFileEditStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Files', TOpenDialog_Files_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('HistoryList', TOpenDialog_HistoryList_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultExt', TOpenDialog_DefaultExt_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FileName', TOpenDialog_FileName_si, TFileName_sw, True, True, 0, False, False);
  AData.AddProperty('Filter', TOpenDialog_Filter_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FilterIndex', TOpenDialog_FilterIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('InitialDir', TOpenDialog_InitialDir_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TOpenDialog_Options_si, TOpenOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OptionsEx', TOpenDialog_OptionsEx_si, TOpenOptionsEx_sw, True, True, 0, False, False);
  AData.AddProperty('Title', TOpenDialog_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('OnCanClose', TOpenDialog_OnCanClose_si, TCloseQueryEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFolderChange', TOpenDialog_OnFolderChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSelectionChange', TOpenDialog_OnSelectionChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnTypeChange', TOpenDialog_OnTypeChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnIncludeItem', TOpenDialog_OnIncludeItem_si, TIncludeItemEvent_sw, True, True, 0, False, False);
end;

class function TOpenDialog_sw.ToVar(const AValue: TOpenDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOpenDialog_sw.FromVar(const AValue: OleVariant): TOpenDialog;
begin
  Result := TOpenDialog(ConvFromVar(AValue, TOpenDialog));
end;

class function TOpenDialog_sw.ClassToVar(AClass: TOpenDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOpenDialog_sw.ClassFromVar(
  const AClass: OleVariant): TOpenDialog_sc;
begin
  Result := TOpenDialog_sc(ConvClsFromVar(AClass, TOpenDialog));
end;

{ TSaveDialog_sw }

class function TSaveDialog_sw.GetTypeName: WideString;
begin
  Result := 'TSaveDialog';
end;

class function TSaveDialog_sw.GetWrappedClass: TClass;
begin
  Result := TSaveDialog;
end;

class procedure TSaveDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSaveDialog_sw.ToVar(const AValue: TSaveDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSaveDialog_sw.FromVar(const AValue: OleVariant): TSaveDialog;
begin
  Result := TSaveDialog(ConvFromVar(AValue, TSaveDialog));
end;

class function TSaveDialog_sw.ClassToVar(AClass: TSaveDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSaveDialog_sw.ClassFromVar(
  const AClass: OleVariant): TSaveDialog_sc;
begin
  Result := TSaveDialog_sc(ConvClsFromVar(AClass, TSaveDialog));
end;

{ TColorDialogOption_sw }

class function TColorDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialogOption';
end;

class procedure TColorDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'cdFullOpen'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdFullOpen)),
    (Name: 'cdPreventFullOpen'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdPreventFullOpen)),
    (Name: 'cdShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdShowHelp)),
    (Name: 'cdSolidColor'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdSolidColor)),
    (Name: 'cdAnyColor'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdAnyColor))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TColorDialogOption_sw.ToVar(
  const AValue: TColorDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColorDialogOption_sw.FromVar(
  const AValue: OleVariant): TColorDialogOption;
begin
  Result := TColorDialogOption(Integer(AValue));
end;

{ TColorDialogOptions_sw }

class function TColorDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialogOptions';
end;

class function TColorDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TColorDialogOptions);
end;

class function TColorDialogOptions_sw.ToVar(
  const AValue: TColorDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TColorDialogOptions_sw.FromVar(
  const AValue: OleVariant): TColorDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TColorDialog_sw }

function TColorDialog_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TColorDialog(AObj).Color)
  else
    TColorDialog(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TColorDialog_CustomColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomColors: TStrings read <getter> write <sett...

  if IsGet then
    Result := TStrings_sw.ToVar(TColorDialog(AObj).CustomColors)
  else
    TColorDialog(AObj).CustomColors := TStrings_sw.FromVar(AArgs[0]);
end;

function TColorDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TColorDialogOptions read <getter> write...

  if IsGet then
    Result := TColorDialogOptions_sw.ToVar(TColorDialog(AObj).Options)
  else
    TColorDialog(AObj).Options := TColorDialogOptions_sw.FromVar(AArgs[0]);
end;

class function TColorDialog_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialog';
end;

class function TColorDialog_sw.GetWrappedClass: TClass;
begin
  Result := TColorDialog;
end;

class procedure TColorDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Color', TColorDialog_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('CustomColors', TColorDialog_CustomColors_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TColorDialog_Options_si, TColorDialogOptions_sw, True, True, 0, False, False);
end;

class function TColorDialog_sw.ToVar(const AValue: TColorDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColorDialog_sw.FromVar(const AValue: OleVariant): TColorDialog;
begin
  Result := TColorDialog(ConvFromVar(AValue, TColorDialog));
end;

class function TColorDialog_sw.ClassToVar(AClass: TColorDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColorDialog_sw.ClassFromVar(
  const AClass: OleVariant): TColorDialog_sc;
begin
  Result := TColorDialog_sc(ConvClsFromVar(AClass, TColorDialog));
end;

{ TFontDialogOption_sw }

class function TFontDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogOption';
end;

class procedure TFontDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..15] of TLMDEnumerator = (
    (Name: 'fdAnsiOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdAnsiOnly)),
    (Name: 'fdTrueTypeOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdTrueTypeOnly)),
    (Name: 'fdEffects'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdEffects)),
    (Name: 'fdFixedPitchOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdFixedPitchOnly)),
    (Name: 'fdForceFontExist'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdForceFontExist)),
    (Name: 'fdNoFaceSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoFaceSel)),
    (Name: 'fdNoOEMFonts'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoOEMFonts)),
    (Name: 'fdNoSimulations'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoSimulations)),
    (Name: 'fdNoSizeSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoSizeSel)),
    (Name: 'fdNoStyleSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoStyleSel)),
    (Name: 'fdNoVectorFonts'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoVectorFonts)),
    (Name: 'fdShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdShowHelp)),
    (Name: 'fdWysiwyg'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdWysiwyg)),
    (Name: 'fdLimitSize'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdLimitSize)),
    (Name: 'fdScalableOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdScalableOnly)),
    (Name: 'fdApplyButton'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdApplyButton))
  );
begin
  AEnums := @ENUMS;
  ACount := 16;
end;

class function TFontDialogOption_sw.ToVar(
  const AValue: TFontDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontDialogOption_sw.FromVar(
  const AValue: OleVariant): TFontDialogOption;
begin
  Result := TFontDialogOption(Integer(AValue));
end;

{ TFontDialogOptions_sw }

class function TFontDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogOptions';
end;

class function TFontDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontDialogOptions);
end;

class function TFontDialogOptions_sw.ToVar(
  const AValue: TFontDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontDialogOptions_sw.FromVar(
  const AValue: OleVariant): TFontDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFontDialogDevice_sw }

class function TFontDialogDevice_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogDevice';
end;

class procedure TFontDialogDevice_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fdScreen'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdScreen)),
    (Name: 'fdPrinter'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdPrinter)),
    (Name: 'fdBoth'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFontDialogDevice_sw.ToVar(
  const AValue: TFontDialogDevice): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontDialogDevice_sw.FromVar(
  const AValue: OleVariant): TFontDialogDevice;
begin
  Result := TFontDialogDevice(Integer(AValue));
end;

{ TFDApplyEvent_sh }

function TFDApplyEvent_sh.GetHandler: TMethod;
var
  hdr: TFDApplyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFDApplyEvent_sh.Handler(Sender: TObject; Wnd: HWND);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Wnd: HWND) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := HWND_sw.ToVar(Wnd);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TFDApplyEvent_sw }

class function TFDApplyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFDApplyEvent';
end;

class function TFDApplyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFDApplyEvent_sh;
end;

class function TFDApplyEvent_sw.ToVar(const AValue: TFDApplyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFDApplyEvent_sw.FromVar(
  const AValue: OleVariant): TFDApplyEvent;
begin
  Result := TFDApplyEvent(ConvFromVar(AValue));
end;

class function TFDApplyEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TFDApplyEvent;
var
  hdlr: TFDApplyEvent_sh;
begin
  hdlr   := TFDApplyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFDApplyEvent_sw));
  Result := hdlr.Handler;
end;

{ TFontDialog_sw }

function TFontDialog_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TFontDialog(AObj).Font)
  else
    TFontDialog(AObj).Font := TFont_sw.FromVar(AArgs[0]);
end;

function TFontDialog_Device_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Device: TFontDialogDevice read <getter> write <s...

  if IsGet then
    Result := TFontDialogDevice_sw.ToVar(TFontDialog(AObj).Device)
  else
    TFontDialog(AObj).Device := TFontDialogDevice_sw.FromVar(AArgs[0]);
end;

function TFontDialog_MinFontSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinFontSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFontDialog(AObj).MinFontSize
  else
    TFontDialog(AObj).MinFontSize := Integer(AArgs[0]);
end;

function TFontDialog_MaxFontSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxFontSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFontDialog(AObj).MaxFontSize
  else
    TFontDialog(AObj).MaxFontSize := Integer(AArgs[0]);
end;

function TFontDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TFontDialogOptions read <getter> write ...

  if IsGet then
    Result := TFontDialogOptions_sw.ToVar(TFontDialog(AObj).Options)
  else
    TFontDialog(AObj).Options := TFontDialogOptions_sw.FromVar(AArgs[0]);
end;

function TFontDialog_OnApply_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnApply: TFDApplyEvent read <getter> write <sett...

  if IsGet then
    Result := TFDApplyEvent_sw.ToVar(TFontDialog(AObj).OnApply)
  else
    TFontDialog(AObj).OnApply := TFDApplyEvent_sw.FromVar(AArgs[0]);
end;

class function TFontDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialog';
end;

class function TFontDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFontDialog;
end;

class procedure TFontDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Font', TFontDialog_Font_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('Device', TFontDialog_Device_si, TFontDialogDevice_sw, True, True, 0, False, False);
  AData.AddProperty('MinFontSize', TFontDialog_MinFontSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MaxFontSize', TFontDialog_MaxFontSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TFontDialog_Options_si, TFontDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OnApply', TFontDialog_OnApply_si, TFDApplyEvent_sw, True, True, 0, False, False);
end;

class function TFontDialog_sw.ToVar(const AValue: TFontDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFontDialog_sw.FromVar(const AValue: OleVariant): TFontDialog;
begin
  Result := TFontDialog(ConvFromVar(AValue, TFontDialog));
end;

class function TFontDialog_sw.ClassToVar(AClass: TFontDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFontDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFontDialog_sc;
begin
  Result := TFontDialog_sc(ConvClsFromVar(AClass, TFontDialog));
end;

{ TPrinterSetupDialog_sw }

class function TPrinterSetupDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterSetupDialog';
end;

class function TPrinterSetupDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPrinterSetupDialog;
end;

class procedure TPrinterSetupDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TPrinterSetupDialog_sw.ToVar(
  const AValue: TPrinterSetupDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrinterSetupDialog_sw.FromVar(
  const AValue: OleVariant): TPrinterSetupDialog;
begin
  Result := TPrinterSetupDialog(ConvFromVar(AValue, TPrinterSetupDialog));
end;

class function TPrinterSetupDialog_sw.ClassToVar(
  AClass: TPrinterSetupDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrinterSetupDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPrinterSetupDialog_sc;
begin
  Result := TPrinterSetupDialog_sc(ConvClsFromVar(AClass, TPrinterSetupDialog));
end;

{ TPrintDialog_sw }

function TPrintDialog_Collate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Collate: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).Collate
  else
    TPrintDialog(AObj).Collate := Boolean(AArgs[0]);
end;

function TPrintDialog_Copies_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Copies: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).Copies
  else
    TPrintDialog(AObj).Copies := Integer(AArgs[0]);
end;

function TPrintDialog_FromPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FromPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).FromPage
  else
    TPrintDialog(AObj).FromPage := Integer(AArgs[0]);
end;

function TPrintDialog_MinPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).MinPage
  else
    TPrintDialog(AObj).MinPage := Integer(AArgs[0]);
end;

function TPrintDialog_MaxPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).MaxPage
  else
    TPrintDialog(AObj).MaxPage := Integer(AArgs[0]);
end;

function TPrintDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TPrintDialogOptions read <getter> write...

  if IsGet then
    Result := TPrintDialogOptions_sw.ToVar(TPrintDialog(AObj).Options)
  else
    TPrintDialog(AObj).Options := TPrintDialogOptions_sw.FromVar(AArgs[0]);
end;

function TPrintDialog_PrintToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrintToFile: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).PrintToFile
  else
    TPrintDialog(AObj).PrintToFile := Boolean(AArgs[0]);
end;

function TPrintDialog_PrintRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrintRange: TPrintRange read <getter> write <set...

  if IsGet then
    Result := TPrintRange_sw.ToVar(TPrintDialog(AObj).PrintRange)
  else
    TPrintDialog(AObj).PrintRange := TPrintRange_sw.FromVar(AArgs[0]);
end;

function TPrintDialog_ToPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ToPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).ToPage
  else
    TPrintDialog(AObj).ToPage := Integer(AArgs[0]);
end;

class function TPrintDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPrintDialog';
end;

class function TPrintDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPrintDialog;
end;

class procedure TPrintDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Collate', TPrintDialog_Collate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Copies', TPrintDialog_Copies_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FromPage', TPrintDialog_FromPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinPage', TPrintDialog_MinPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MaxPage', TPrintDialog_MaxPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TPrintDialog_Options_si, TPrintDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('PrintToFile', TPrintDialog_PrintToFile_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PrintRange', TPrintDialog_PrintRange_si, TPrintRange_sw, True, True, 0, False, False);
  AData.AddProperty('ToPage', TPrintDialog_ToPage_si, Integer_sw, True, True, 0, False, False);
end;

class function TPrintDialog_sw.ToVar(const AValue: TPrintDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrintDialog_sw.FromVar(const AValue: OleVariant): TPrintDialog;
begin
  Result := TPrintDialog(ConvFromVar(AValue, TPrintDialog));
end;

class function TPrintDialog_sw.ClassToVar(AClass: TPrintDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrintDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPrintDialog_sc;
begin
  Result := TPrintDialog_sc(ConvClsFromVar(AClass, TPrintDialog));
end;

{ TPageSetupBeforePaintEvent_sh }

function TPageSetupBeforePaintEvent_sh.GetHandler: TMethod;
var
  hdr: TPageSetupBeforePaintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPageSetupBeforePaintEvent_sh.Handler(Sender: TObject;
  const PaperSize: SmallInt; const Orientation: TPrinterOrientation;
  const PageType: TPageType; var DoneDrawing: Boolean);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; const PaperSize: SmallInt; co...

  v_1 := DoneDrawing;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := PaperSize;
  args[2] := TPrinterOrientation_sw.ToVar(Orientation);
  args[3] := TPageType_sw.ToVar(PageType);
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DoneDrawing := Boolean(v_1);
end;

{ TPageSetupBeforePaintEvent_sw }

class function TPageSetupBeforePaintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupBeforePaintEvent';
end;

class function TPageSetupBeforePaintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPageSetupBeforePaintEvent_sh;
end;

class function TPageSetupBeforePaintEvent_sw.ToVar(
  const AValue: TPageSetupBeforePaintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPageSetupBeforePaintEvent_sw.FromVar(
  const AValue: OleVariant): TPageSetupBeforePaintEvent;
begin
  Result := TPageSetupBeforePaintEvent(ConvFromVar(AValue));
end;

class function TPageSetupBeforePaintEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TPageSetupBeforePaintEvent;
var
  hdlr: TPageSetupBeforePaintEvent_sh;
begin
  hdlr   := TPageSetupBeforePaintEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TPageSetupBeforePaintEvent_sw));
  Result := hdlr.Handler;
end;

{ TPaintPageEvent_sh }

function TPaintPageEvent_sh.GetHandler: TMethod;
var
  hdr: TPaintPageEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPaintPageEvent_sh.Handler(Sender: TObject; Canvas: TCanvas;
  PageRect: TRect; var DoneDrawing: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Canvas: TCanvas; PageRect: TR...

  v_1 := DoneDrawing;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCanvas_sw.ToVar(Canvas);
  args[2] := TRect_sw.ToVar(PageRect);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DoneDrawing := Boolean(v_1);
end;

{ TPaintPageEvent_sw }

class function TPaintPageEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPaintPageEvent';
end;

class function TPaintPageEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPaintPageEvent_sh;
end;

class function TPaintPageEvent_sw.ToVar(
  const AValue: TPaintPageEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPaintPageEvent_sw.FromVar(
  const AValue: OleVariant): TPaintPageEvent;
begin
  Result := TPaintPageEvent(ConvFromVar(AValue));
end;

class function TPaintPageEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TPaintPageEvent;
var
  hdlr: TPaintPageEvent_sh;
begin
  hdlr   := TPaintPageEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TPaintPageEvent_sw));
  Result := hdlr.Handler;
end;

{ TPageSetupDialog_sw }

function TPageSetupDialog_GetDefaults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetDefaults: Boolean;

  Result := TPageSetupDialog(AObj).GetDefaults();
end;

function TPageSetupDialog_PageSetupDlgRec_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageSetupDlgRec: TPageSetupDlg read <getter>;

  Result := TPageSetupDlg_sw.ToVar(TPageSetupDialog(AObj).PageSetupDlgRec);
end;

function TPageSetupDialog_MinMarginLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginLeft: Integer read <getter> write <sett...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginLeft
  else
    TPageSetupDialog(AObj).MinMarginLeft := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginTop: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginTop
  else
    TPageSetupDialog(AObj).MinMarginTop := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginRight: Integer read <getter> write <set...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginRight
  else
    TPageSetupDialog(AObj).MinMarginRight := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginBottom_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginBottom: Integer read <getter> write <se...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginBottom
  else
    TPageSetupDialog(AObj).MinMarginBottom := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginLeft: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginLeft
  else
    TPageSetupDialog(AObj).MarginLeft := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginTop: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginTop
  else
    TPageSetupDialog(AObj).MarginTop := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginRight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginRight
  else
    TPageSetupDialog(AObj).MarginRight := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginBottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginBottom: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginBottom
  else
    TPageSetupDialog(AObj).MarginBottom := Integer(AArgs[0]);
end;

function TPageSetupDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TPageSetupDialogOptions read <getter> w...

  if IsGet then
    Result := TPageSetupDialogOptions_sw.ToVar(TPageSetupDialog(AObj).Options)
  else
    TPageSetupDialog(AObj).Options := TPageSetupDialogOptions_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_PageWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).PageWidth
  else
    TPageSetupDialog(AObj).PageWidth := Integer(AArgs[0]);
end;

function TPageSetupDialog_PageHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).PageHeight
  else
    TPageSetupDialog(AObj).PageHeight := Integer(AArgs[0]);
end;

function TPageSetupDialog_Units_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Units: TPageMeasureUnits read <getter> write <se...

  if IsGet then
    Result := TPageMeasureUnits_sw.ToVar(TPageSetupDialog(AObj).Units)
  else
    TPageSetupDialog(AObj).Units := TPageMeasureUnits_sw.FromVar(AArgs[0]);
end;

function TPageSetupDialog_BeforePaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforePaint: TPageSetupBeforePaintEvent read <ge...

  if IsGet then
    Result := TPageSetupBeforePaintEvent_sw.ToVar(TPageSetupDialog(AObj).
      BeforePaint)
  else
    TPageSetupDialog(AObj).BeforePaint := TPageSetupBeforePaintEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawFullPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawFullPage: TPaintPageEvent read <getter> wr...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawFullPage)
  else
    TPageSetupDialog(AObj).OnDrawFullPage := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawMinMargin_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawMinMargin: TPaintPageEvent read <getter> w...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawMinMargin)
  else
    TPageSetupDialog(AObj).OnDrawMinMargin := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawMargin: TPaintPageEvent read <getter> writ...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawMargin)
  else
    TPageSetupDialog(AObj).OnDrawMargin := TPaintPageEvent_sw.FromVar(AArgs[0]);
end;

function TPageSetupDialog_OnDrawGreekText_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawGreekText: TPaintPageEvent read <getter> w...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawGreekText)
  else
    TPageSetupDialog(AObj).OnDrawGreekText := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawEnvStamp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawEnvStamp: TPaintPageEvent read <getter> wr...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawEnvStamp)
  else
    TPageSetupDialog(AObj).OnDrawEnvStamp := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawRetAddress_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawRetAddress: TPaintPageEvent read <getter> ...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawRetAddress)
  else
    TPageSetupDialog(AObj).OnDrawRetAddress := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

class function TPageSetupDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupDialog';
end;

class function TPageSetupDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPageSetupDialog;
end;

class procedure TPageSetupDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetDefaults', TPageSetupDialog_GetDefaults_si, Boolean_sw, 0, False);
  AData.AddProperty('PageSetupDlgRec', TPageSetupDialog_PageSetupDlgRec_si, TPageSetupDlg_sw, True, False, 0, False, False);
  AData.AddProperty('MinMarginLeft', TPageSetupDialog_MinMarginLeft_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginTop', TPageSetupDialog_MinMarginTop_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginRight', TPageSetupDialog_MinMarginRight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginBottom', TPageSetupDialog_MinMarginBottom_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginLeft', TPageSetupDialog_MarginLeft_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginTop', TPageSetupDialog_MarginTop_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginRight', TPageSetupDialog_MarginRight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginBottom', TPageSetupDialog_MarginBottom_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TPageSetupDialog_Options_si, TPageSetupDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('PageWidth', TPageSetupDialog_PageWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PageHeight', TPageSetupDialog_PageHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Units', TPageSetupDialog_Units_si, TPageMeasureUnits_sw, True, True, 0, False, False);
  AData.AddProperty('BeforePaint', TPageSetupDialog_BeforePaint_si, TPageSetupBeforePaintEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawFullPage', TPageSetupDialog_OnDrawFullPage_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawMinMargin', TPageSetupDialog_OnDrawMinMargin_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawMargin', TPageSetupDialog_OnDrawMargin_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawGreekText', TPageSetupDialog_OnDrawGreekText_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawEnvStamp', TPageSetupDialog_OnDrawEnvStamp_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawRetAddress', TPageSetupDialog_OnDrawRetAddress_si, TPaintPageEvent_sw, True, True, 0, False, False);
end;

class function TPageSetupDialog_sw.ToVar(
  const AValue: TPageSetupDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPageSetupDialog_sw.FromVar(
  const AValue: OleVariant): TPageSetupDialog;
begin
  Result := TPageSetupDialog(ConvFromVar(AValue, TPageSetupDialog));
end;

class function TPageSetupDialog_sw.ClassToVar(
  AClass: TPageSetupDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPageSetupDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPageSetupDialog_sc;
begin
  Result := TPageSetupDialog_sc(ConvClsFromVar(AClass, TPageSetupDialog));
end;

{ TFindOption_sw }

class function TFindOption_sw.GetTypeName: WideString;
begin
  Result := 'TFindOption';
end;

class procedure TFindOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'frDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDown)),
    (Name: 'frFindNext'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frFindNext)),
    (Name: 'frHideMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideMatchCase)),
    (Name: 'frHideWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideWholeWord)),
    (Name: 'frHideUpDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideUpDown)),
    (Name: 'frMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frMatchCase)),
    (Name: 'frDisableMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableMatchCase)),
    (Name: 'frDisableUpDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableUpDown)),
    (Name: 'frDisableWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableWholeWord)),
    (Name: 'frReplace'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frReplace)),
    (Name: 'frReplaceAll'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frReplaceAll)),
    (Name: 'frWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frWholeWord)),
    (Name: 'frShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frShowHelp))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TFindOption_sw.ToVar(const AValue: TFindOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFindOption_sw.FromVar(const AValue: OleVariant): TFindOption;
begin
  Result := TFindOption(Integer(AValue));
end;

{ TFindOptions_sw }

class function TFindOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFindOptions';
end;

class function TFindOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFindOptions);
end;

class function TFindOptions_sw.ToVar(const AValue: TFindOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFindOptions_sw.FromVar(const AValue: OleVariant): TFindOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFindDialog_sw }

function TFindDialog_CloseDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseDialog;

  TFindDialog(AObj).CloseDialog();
end;

function TFindDialog_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).Left
  else
    TFindDialog(AObj).Left := Integer(AArgs[0]);
end;

function TFindDialog_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TFindDialog(AObj).Position)
  else
    TFindDialog(AObj).Position := TPoint_sw.FromVar(AArgs[0]);
end;

function TFindDialog_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).Top
  else
    TFindDialog(AObj).Top := Integer(AArgs[0]);
end;

function TFindDialog_FindText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FindText: string read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).FindText
  else
    TFindDialog(AObj).FindText := string(AArgs[0]);
end;

function TFindDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TFindOptions read <getter> write <setter>;

  if IsGet then
    Result := TFindOptions_sw.ToVar(TFindDialog(AObj).Options)
  else
    TFindDialog(AObj).Options := TFindOptions_sw.FromVar(AArgs[0]);
end;

function TFindDialog_OnFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFind: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFindDialog(AObj).OnFind)
  else
    TFindDialog(AObj).OnFind := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TFindDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFindDialog';
end;

class function TFindDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFindDialog;
end;

class procedure TFindDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CloseDialog', TFindDialog_CloseDialog_si, 0, False);
  AData.AddProperty('Left', TFindDialog_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TFindDialog_Position_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TFindDialog_Top_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FindText', TFindDialog_FindText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TFindDialog_Options_si, TFindOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OnFind', TFindDialog_OnFind_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TFindDialog_sw.ToVar(const AValue: TFindDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFindDialog_sw.FromVar(const AValue: OleVariant): TFindDialog;
begin
  Result := TFindDialog(ConvFromVar(AValue, TFindDialog));
end;

class function TFindDialog_sw.ClassToVar(AClass: TFindDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFindDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFindDialog_sc;
begin
  Result := TFindDialog_sc(ConvClsFromVar(AClass, TFindDialog));
end;

{ TReplaceDialog_sw }

class function TReplaceDialog_sw.GetTypeName: WideString;
begin
  Result := 'TReplaceDialog';
end;

class function TReplaceDialog_sw.GetWrappedClass: TClass;
begin
  Result := TReplaceDialog;
end;

class procedure TReplaceDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ReplaceText', False);
  AData.AddPropertyRedecl('OnReplace', False);
end;

class function TReplaceDialog_sw.ToVar(
  const AValue: TReplaceDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TReplaceDialog_sw.FromVar(
  const AValue: OleVariant): TReplaceDialog;
begin
  Result := TReplaceDialog(ConvFromVar(AValue, TReplaceDialog));
end;

class function TReplaceDialog_sw.ClassToVar(
  AClass: TReplaceDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TReplaceDialog_sw.ClassFromVar(
  const AClass: OleVariant): TReplaceDialog_sc;
begin
  Result := TReplaceDialog_sc(ConvClsFromVar(AClass, TReplaceDialog));
end;

{ EPlatformVersionException_sw }

class function EPlatformVersionException_sw.GetTypeName: WideString;
begin
  Result := 'EPlatformVersionException';
end;

class function EPlatformVersionException_sw.GetWrappedClass: TClass;
begin
  Result := EPlatformVersionException;
end;

class procedure EPlatformVersionException_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPlatformVersionException_sw.ToVar(
  const AValue: EPlatformVersionException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPlatformVersionException_sw.FromVar(
  const AValue: OleVariant): EPlatformVersionException;
begin
  Result := EPlatformVersionException(ConvFromVar(AValue, 
    EPlatformVersionException));
end;

class function EPlatformVersionException_sw.ClassToVar(
  AClass: EPlatformVersionException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPlatformVersionException_sw.ClassFromVar(
  const AClass: OleVariant): EPlatformVersionException_sc;
begin
  Result := EPlatformVersionException_sc(ConvClsFromVar(AClass, 
    EPlatformVersionException));
end;

{ TFileDialogOption_sw }

class function TFileDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogOption';
end;

class procedure TFileDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..20] of TLMDEnumerator = (
    (Name: 'fdoOverWritePrompt'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoOverWritePrompt)),
    (Name: 'fdoStrictFileTypes'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoStrictFileTypes)),
    (Name: 'fdoNoChangeDir'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoNoChangeDir)),
    (Name: 'fdoPickFolders'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoPickFolders)),
    (Name: 'fdoForceFileSystem'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoForceFileSystem)),
    (Name: 'fdoAllNonStorageItems'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoAllNonStorageItems)),
    (Name: 'fdoNoValidate'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoNoValidate)),
    (Name: 'fdoAllowMultiSelect'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoAllowMultiSelect)),
    (Name: 'fdoPathMustExist'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoPathMustExist)),
    (Name: 'fdoFileMustExist'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoFileMustExist)),
    (Name: 'fdoCreatePrompt'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoCreatePrompt)),
    (Name: 'fdoShareAware'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoShareAware)),
    (Name: 'fdoNoReadOnlyReturn'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoNoReadOnlyReturn)),
    (Name: 'fdoNoTestFileCreate'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoNoTestFileCreate)),
    (Name: 'fdoHideMRUPlaces'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoHideMRUPlaces)),
    (Name: 'fdoHidePinnedPlaces'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoHidePinnedPlaces)),
    (Name: 'fdoNoDereferenceLinks'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoNoDereferenceLinks)),
    (Name: 'fdoDontAddToRecent'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoDontAddToRecent)),
    (Name: 'fdoForceShowHidden'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoForceShowHidden)),
    (Name: 'fdoDefaultNoMiniMode'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoDefaultNoMiniMode)),
    (Name: 'fdoForcePreviewPaneOn'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOption.{$ENDIF}fdoForcePreviewPaneOn))
  );
begin
  AEnums := @ENUMS;
  ACount := 21;
end;

class function TFileDialogOption_sw.ToVar(
  const AValue: TFileDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFileDialogOption_sw.FromVar(
  const AValue: OleVariant): TFileDialogOption;
begin
  Result := TFileDialogOption(Integer(AValue));
end;

{ TFileDialogOptions_sw }

class function TFileDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogOptions';
end;

class function TFileDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFileDialogOptions);
end;

class function TFileDialogOptions_sw.ToVar(
  const AValue: TFileDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFileDialogOptions_sw.FromVar(
  const AValue: OleVariant): TFileDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFileDialogOverwriteResponse_sw }

class function TFileDialogOverwriteResponse_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogOverwriteResponse';
end;

class procedure TFileDialogOverwriteResponse_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'forDefault'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOverwriteResponse.{$ENDIF}forDefault)),
    (Name: 'forAccept'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOverwriteResponse.{$ENDIF}forAccept)),
    (Name: 'forRefuse'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogOverwriteResponse.{$ENDIF}forRefuse))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFileDialogOverwriteResponse_sw.ToVar(
  const AValue: TFileDialogOverwriteResponse): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFileDialogOverwriteResponse_sw.FromVar(
  const AValue: OleVariant): TFileDialogOverwriteResponse;
begin
  Result := TFileDialogOverwriteResponse(Integer(AValue));
end;

{ TFileDialogShareViolationResponse_sw }

class function TFileDialogShareViolationResponse_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogShareViolationResponse';
end;

class procedure TFileDialogShareViolationResponse_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fsrDefault'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogShareViolationResponse.{$ENDIF}fsrDefault)),
    (Name: 'fsrAccept'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogShareViolationResponse.{$ENDIF}fsrAccept)),
    (Name: 'fsrRefuse'; Value: Integer({$IFDEF LMDSCT_12}TFileDialogShareViolationResponse.{$ENDIF}fsrRefuse))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFileDialogShareViolationResponse_sw.ToVar(
  const AValue: TFileDialogShareViolationResponse): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFileDialogShareViolationResponse_sw.FromVar(
  const AValue: OleVariant): TFileDialogShareViolationResponse;
begin
  Result := TFileDialogShareViolationResponse(Integer(AValue));
end;

{ TFileDialogCloseEvent_sh }

function TFileDialogCloseEvent_sh.GetHandler: TMethod;
var
  hdr: TFileDialogCloseEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFileDialogCloseEvent_sh.Handler(Sender: TObject;
  var CanClose: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var CanClose: Boolean) of object

  v_1 := CanClose;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  CanClose := Boolean(v_1);
end;

{ TFileDialogCloseEvent_sw }

class function TFileDialogCloseEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogCloseEvent';
end;

class function TFileDialogCloseEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFileDialogCloseEvent_sh;
end;

class function TFileDialogCloseEvent_sw.ToVar(
  const AValue: TFileDialogCloseEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFileDialogCloseEvent_sw.FromVar(
  const AValue: OleVariant): TFileDialogCloseEvent;
begin
  Result := TFileDialogCloseEvent(ConvFromVar(AValue));
end;

class function TFileDialogCloseEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFileDialogCloseEvent;
var
  hdlr: TFileDialogCloseEvent_sh;
begin
  hdlr   := TFileDialogCloseEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFileDialogCloseEvent_sw));
  Result := hdlr.Handler;
end;

{ TFileDialogFolderChangingEvent_sh }

function TFileDialogFolderChangingEvent_sh.GetHandler: TMethod;
var
  hdr: TFileDialogFolderChangingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFileDialogFolderChangingEvent_sh.Handler(Sender: TObject;
  var CanChange: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var CanChange: Boolean) of ob...

  v_1 := CanChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  CanChange := Boolean(v_1);
end;

{ TFileDialogFolderChangingEvent_sw }

class function TFileDialogFolderChangingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogFolderChangingEvent';
end;

class function TFileDialogFolderChangingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFileDialogFolderChangingEvent_sh;
end;

class function TFileDialogFolderChangingEvent_sw.ToVar(
  const AValue: TFileDialogFolderChangingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFileDialogFolderChangingEvent_sw.FromVar(
  const AValue: OleVariant): TFileDialogFolderChangingEvent;
begin
  Result := TFileDialogFolderChangingEvent(ConvFromVar(AValue));
end;

class function TFileDialogFolderChangingEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFileDialogFolderChangingEvent;
var
  hdlr: TFileDialogFolderChangingEvent_sh;
begin
  hdlr   := TFileDialogFolderChangingEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TFileDialogFolderChangingEvent_sw));
  Result := hdlr.Handler;
end;

{ TFileDialogOverwriteEvent_sh }

function TFileDialogOverwriteEvent_sh.GetHandler: TMethod;
var
  hdr: TFileDialogOverwriteEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFileDialogOverwriteEvent_sh.Handler(Sender: TObject;
  var Response: TFileDialogOverwriteResponse);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Response: TFileDialogOver...

  v_1 := TFileDialogOverwriteResponse_sw.ToVar(Response);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Response := TFileDialogOverwriteResponse_sw.FromVar(v_1);
end;

{ TFileDialogOverwriteEvent_sw }

class function TFileDialogOverwriteEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogOverwriteEvent';
end;

class function TFileDialogOverwriteEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFileDialogOverwriteEvent_sh;
end;

class function TFileDialogOverwriteEvent_sw.ToVar(
  const AValue: TFileDialogOverwriteEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFileDialogOverwriteEvent_sw.FromVar(
  const AValue: OleVariant): TFileDialogOverwriteEvent;
begin
  Result := TFileDialogOverwriteEvent(ConvFromVar(AValue));
end;

class function TFileDialogOverwriteEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFileDialogOverwriteEvent;
var
  hdlr: TFileDialogOverwriteEvent_sh;
begin
  hdlr   := TFileDialogOverwriteEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TFileDialogOverwriteEvent_sw));
  Result := hdlr.Handler;
end;

{ TFileDialogShareViolationEvent_sh }

function TFileDialogShareViolationEvent_sh.GetHandler: TMethod;
var
  hdr: TFileDialogShareViolationEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFileDialogShareViolationEvent_sh.Handler(Sender: TObject;
  var Response: TFileDialogShareViolationResponse);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Response: TFileDialogShar...

  v_1 := TFileDialogShareViolationResponse_sw.ToVar(Response);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Response := TFileDialogShareViolationResponse_sw.FromVar(v_1);
end;

{ TFileDialogShareViolationEvent_sw }

class function TFileDialogShareViolationEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFileDialogShareViolationEvent';
end;

class function TFileDialogShareViolationEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFileDialogShareViolationEvent_sh;
end;

class function TFileDialogShareViolationEvent_sw.ToVar(
  const AValue: TFileDialogShareViolationEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFileDialogShareViolationEvent_sw.FromVar(
  const AValue: OleVariant): TFileDialogShareViolationEvent;
begin
  Result := TFileDialogShareViolationEvent(ConvFromVar(AValue));
end;

class function TFileDialogShareViolationEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFileDialogShareViolationEvent;
var
  hdlr: TFileDialogShareViolationEvent_sh;
begin
  hdlr   := TFileDialogShareViolationEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TFileDialogShareViolationEvent_sw));
  Result := hdlr.Handler;
end;

{ TFileTypeItem_sw }

function TFileTypeItem_DisplayName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayName: string read <getter> write <setter>;

  if IsGet then
    Result := TFileTypeItem(AObj).DisplayName
  else
    TFileTypeItem(AObj).DisplayName := string(AArgs[0]);
end;

function TFileTypeItem_FileMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileMask: string read <getter> write <setter>;

  if IsGet then
    Result := TFileTypeItem(AObj).FileMask
  else
    TFileTypeItem(AObj).FileMask := string(AArgs[0]);
end;

class function TFileTypeItem_sw.GetTypeName: WideString;
begin
  Result := 'TFileTypeItem';
end;

class function TFileTypeItem_sw.GetWrappedClass: TClass;
begin
  Result := TFileTypeItem;
end;

class procedure TFileTypeItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DisplayName', TFileTypeItem_DisplayName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FileMask', TFileTypeItem_FileMask_si, string_sw, True, True, 0, False, False);
end;

class function TFileTypeItem_sw.ToVar(const AValue: TFileTypeItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileTypeItem_sw.FromVar(
  const AValue: OleVariant): TFileTypeItem;
begin
  Result := TFileTypeItem(ConvFromVar(AValue, TFileTypeItem));
end;

class function TFileTypeItem_sw.ClassToVar(
  AClass: TFileTypeItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileTypeItem_sw.ClassFromVar(
  const AClass: OleVariant): TFileTypeItem_sc;
begin
  Result := TFileTypeItem_sc(ConvClsFromVar(AClass, TFileTypeItem));
end;

{ TFileTypeItems_sw }

function TFileTypeItems_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TFileTypeItem;

  Result := TFileTypeItem_sw.ToVar(TFileTypeItems(AObj).Add());
end;

function TFileTypeItems_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TFileTypeItem read <gette...

  if IsGet then
    Result := TFileTypeItem_sw.ToVar(TFileTypeItems(AObj).Items[Integer(
      AArgs[0])])
  else
    TFileTypeItems(AObj).Items[Integer(AArgs[0])] := TFileTypeItem_sw.FromVar(
      AArgs[1]);
end;

class function TFileTypeItems_sw.GetTypeName: WideString;
begin
  Result := 'TFileTypeItems';
end;

class function TFileTypeItems_sw.GetWrappedClass: TClass;
begin
  Result := TFileTypeItems;
end;

class procedure TFileTypeItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TFileTypeItems_Add_si, TFileTypeItem_sw, 0, False);
  AData.AddProperty('Items', TFileTypeItems_Items_si, TFileTypeItem_sw, True, True, 1, False, True);
end;

class function TFileTypeItems_sw.ToVar(
  const AValue: TFileTypeItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileTypeItems_sw.FromVar(
  const AValue: OleVariant): TFileTypeItems;
begin
  Result := TFileTypeItems(ConvFromVar(AValue, TFileTypeItems));
end;

class function TFileTypeItems_sw.ClassToVar(
  AClass: TFileTypeItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileTypeItems_sw.ClassFromVar(
  const AClass: OleVariant): TFileTypeItems_sc;
begin
  Result := TFileTypeItems_sc(ConvClsFromVar(AClass, TFileTypeItems));
end;

{ TFavoriteLinkItem_sw }

function TFavoriteLinkItem_Location_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Location: string read <getter> write <setter>;

  if IsGet then
    Result := TFavoriteLinkItem(AObj).Location
  else
    TFavoriteLinkItem(AObj).Location := string(AArgs[0]);
end;

class function TFavoriteLinkItem_sw.GetTypeName: WideString;
begin
  Result := 'TFavoriteLinkItem';
end;

class function TFavoriteLinkItem_sw.GetWrappedClass: TClass;
begin
  Result := TFavoriteLinkItem;
end;

class procedure TFavoriteLinkItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Location', TFavoriteLinkItem_Location_si, string_sw, True, True, 0, False, False);
end;

class function TFavoriteLinkItem_sw.ToVar(
  const AValue: TFavoriteLinkItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFavoriteLinkItem_sw.FromVar(
  const AValue: OleVariant): TFavoriteLinkItem;
begin
  Result := TFavoriteLinkItem(ConvFromVar(AValue, TFavoriteLinkItem));
end;

class function TFavoriteLinkItem_sw.ClassToVar(
  AClass: TFavoriteLinkItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFavoriteLinkItem_sw.ClassFromVar(
  const AClass: OleVariant): TFavoriteLinkItem_sc;
begin
  Result := TFavoriteLinkItem_sc(ConvClsFromVar(AClass, TFavoriteLinkItem));
end;

{ TFavoriteLinkItemsEnumerator_sw }

function TFavoriteLinkItemsEnumerator_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ACollection: TFavoriteLinkItems);

  Result := TFavoriteLinkItemsEnumerator_sw.ToVar(
    TFavoriteLinkItemsEnumerator_sc(AObj).Create(TFavoriteLinkItems_sw.FromVar(
    AArgs[0])));
end;

function TFavoriteLinkItemsEnumerator_GetCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TFavoriteLinkItem;

  Result := TFavoriteLinkItem_sw.ToVar(TFavoriteLinkItemsEnumerator(AObj).
    GetCurrent());
end;

function TFavoriteLinkItemsEnumerator_MoveNext_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TFavoriteLinkItemsEnumerator(AObj).MoveNext();
end;

function TFavoriteLinkItemsEnumerator_Current_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TFavoriteLinkItem read <getter>;

  Result := TFavoriteLinkItem_sw.ToVar(TFavoriteLinkItemsEnumerator(AObj).
    Current);
end;

class function TFavoriteLinkItemsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TFavoriteLinkItemsEnumerator';
end;

class function TFavoriteLinkItemsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TFavoriteLinkItemsEnumerator;
end;

class procedure TFavoriteLinkItemsEnumerator_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TFavoriteLinkItemsEnumerator_GetCurrent_si, TFavoriteLinkItem_sw, 0, False);
  AData.AddFunction('MoveNext', TFavoriteLinkItemsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TFavoriteLinkItemsEnumerator_Current_si, TFavoriteLinkItem_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFavoriteLinkItemsEnumerator_Create_si, 1, False);
end;

class function TFavoriteLinkItemsEnumerator_sw.ToVar(
  const AValue: TFavoriteLinkItemsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFavoriteLinkItemsEnumerator_sw.FromVar(
  const AValue: OleVariant): TFavoriteLinkItemsEnumerator;
begin
  Result := TFavoriteLinkItemsEnumerator(ConvFromVar(AValue, 
    TFavoriteLinkItemsEnumerator));
end;

class function TFavoriteLinkItemsEnumerator_sw.ClassToVar(
  AClass: TFavoriteLinkItemsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFavoriteLinkItemsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TFavoriteLinkItemsEnumerator_sc;
begin
  Result := TFavoriteLinkItemsEnumerator_sc(ConvClsFromVar(AClass, 
    TFavoriteLinkItemsEnumerator));
end;

{ TFavoriteLinkItems_sw }

function TFavoriteLinkItems_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TFavoriteLinkItem;

  Result := TFavoriteLinkItem_sw.ToVar(TFavoriteLinkItems(AObj).Add());
end;

function TFavoriteLinkItems_GetEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TFavoriteLinkItemsEnumerator;

  Result := TFavoriteLinkItemsEnumerator_sw.ToVar(TFavoriteLinkItems(AObj).
    GetEnumerator());
end;

function TFavoriteLinkItems_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TFavoriteLinkItem read <g...

  if IsGet then
    Result := TFavoriteLinkItem_sw.ToVar(TFavoriteLinkItems(AObj).Items[Integer(
      AArgs[0])])
  else
    TFavoriteLinkItems(AObj).Items[Integer(AArgs[0])] := TFavoriteLinkItem_sw.
      FromVar(AArgs[1]);
end;

class function TFavoriteLinkItems_sw.GetTypeName: WideString;
begin
  Result := 'TFavoriteLinkItems';
end;

class function TFavoriteLinkItems_sw.GetWrappedClass: TClass;
begin
  Result := TFavoriteLinkItems;
end;

class procedure TFavoriteLinkItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TFavoriteLinkItems_Add_si, TFavoriteLinkItem_sw, 0, False);
  AData.AddFunction('GetEnumerator', TFavoriteLinkItems_GetEnumerator_si, TFavoriteLinkItemsEnumerator_sw, 0, False);
  AData.AddProperty('Items', TFavoriteLinkItems_Items_si, TFavoriteLinkItem_sw, True, True, 1, False, True);
end;

class function TFavoriteLinkItems_sw.ToVar(
  const AValue: TFavoriteLinkItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFavoriteLinkItems_sw.FromVar(
  const AValue: OleVariant): TFavoriteLinkItems;
begin
  Result := TFavoriteLinkItems(ConvFromVar(AValue, TFavoriteLinkItems));
end;

class function TFavoriteLinkItems_sw.ClassToVar(
  AClass: TFavoriteLinkItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFavoriteLinkItems_sw.ClassFromVar(
  const AClass: OleVariant): TFavoriteLinkItems_sc;
begin
  Result := TFavoriteLinkItems_sc(ConvClsFromVar(AClass, TFavoriteLinkItems));
end;

{ TCustomFileDialog_sw }

function TCustomFileDialog_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Execute(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TCustomFileDialog(AObj).Execute();
    end;
    1:
    begin
      Result := TCustomFileDialog(AObj).Execute(HWND_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Execute');
  end;
end;

function TCustomFileDialog_ClientGuid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientGuid: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomFileDialog(AObj).ClientGuid
  else
    TCustomFileDialog(AObj).ClientGuid := string(AArgs[0]);
end;

function TCustomFileDialog_DefaultExtension_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultExtension: string read <getter> write <se...

  if IsGet then
    Result := TCustomFileDialog(AObj).DefaultExtension
  else
    TCustomFileDialog(AObj).DefaultExtension := string(AArgs[0]);
end;

function TCustomFileDialog_DefaultFolder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultFolder: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomFileDialog(AObj).DefaultFolder
  else
    TCustomFileDialog(AObj).DefaultFolder := string(AArgs[0]);
end;

function TCustomFileDialog_FavoriteLinks_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FavoriteLinks: TFavoriteLinkItems read <getter> ...

  if IsGet then
    Result := TFavoriteLinkItems_sw.ToVar(TCustomFileDialog(AObj).FavoriteLinks)
  else
    TCustomFileDialog(AObj).FavoriteLinks := TFavoriteLinkItems_sw.FromVar(
      AArgs[0]);
end;

function TCustomFileDialog_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TCustomFileDialog(AObj).FileName)
  else
    TCustomFileDialog(AObj).FileName := TFileName_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_FileNameLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileNameLabel: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomFileDialog(AObj).FileNameLabel
  else
    TCustomFileDialog(AObj).FileNameLabel := string(AArgs[0]);
end;

function TCustomFileDialog_Files_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Files: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TCustomFileDialog(AObj).Files);
end;

function TCustomFileDialog_FileTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileTypes: TFileTypeItems read <getter> write <s...

  if IsGet then
    Result := TFileTypeItems_sw.ToVar(TCustomFileDialog(AObj).FileTypes)
  else
    TCustomFileDialog(AObj).FileTypes := TFileTypeItems_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_FileTypeIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileTypeIndex: Cardinal read <getter> write <set...

  if IsGet then
    Result := TCustomFileDialog(AObj).FileTypeIndex
  else
    TCustomFileDialog(AObj).FileTypeIndex := Cardinal(AArgs[0]);
end;

function TCustomFileDialog_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TCustomFileDialog(AObj).Handle);
end;

function TCustomFileDialog_OkButtonLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OkButtonLabel: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomFileDialog(AObj).OkButtonLabel
  else
    TCustomFileDialog(AObj).OkButtonLabel := string(AArgs[0]);
end;

function TCustomFileDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TFileDialogOptions read <getter> write ...

  if IsGet then
    Result := TFileDialogOptions_sw.ToVar(TCustomFileDialog(AObj).Options)
  else
    TCustomFileDialog(AObj).Options := TFileDialogOptions_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomFileDialog(AObj).Title
  else
    TCustomFileDialog(AObj).Title := string(AArgs[0]);
end;

function TCustomFileDialog_OnExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnExecute: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomFileDialog(AObj).OnExecute)
  else
    TCustomFileDialog(AObj).OnExecute := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_OnFileOkClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFileOkClick: TFileDialogCloseEvent read <gette...

  if IsGet then
    Result := TFileDialogCloseEvent_sw.ToVar(TCustomFileDialog(AObj).
      OnFileOkClick)
  else
    TCustomFileDialog(AObj).OnFileOkClick := TFileDialogCloseEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomFileDialog_OnFolderChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFolderChange: TNotifyEvent read <getter> write...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomFileDialog(AObj).OnFolderChange)
  else
    TCustomFileDialog(AObj).OnFolderChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_OnFolderChanging_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFolderChanging: TFileDialogFolderChangingEvent...

  if IsGet then
    Result := TFileDialogFolderChangingEvent_sw.ToVar(TCustomFileDialog(AObj).
      OnFolderChanging)
  else
    TCustomFileDialog(AObj).OnFolderChanging := 
      TFileDialogFolderChangingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_OnOverwrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnOverwrite: TFileDialogOverwriteEvent read <get...

  if IsGet then
    Result := TFileDialogOverwriteEvent_sw.ToVar(TCustomFileDialog(AObj).
      OnOverwrite)
  else
    TCustomFileDialog(AObj).OnOverwrite := TFileDialogOverwriteEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomFileDialog_OnSelectionChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSelectionChange: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomFileDialog(AObj).OnSelectionChange)
  else
    TCustomFileDialog(AObj).OnSelectionChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomFileDialog_OnShareViolation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShareViolation: TFileDialogShareViolationEvent...

  if IsGet then
    Result := TFileDialogShareViolationEvent_sw.ToVar(TCustomFileDialog(AObj).
      OnShareViolation)
  else
    TCustomFileDialog(AObj).OnShareViolation := 
      TFileDialogShareViolationEvent_sw.FromVar(AArgs[0]);
end;

function TCustomFileDialog_OnTypeChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTypeChange: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomFileDialog(AObj).OnTypeChange)
  else
    TCustomFileDialog(AObj).OnTypeChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomFileDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFileDialog';
end;

class function TCustomFileDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCustomFileDialog;
end;

class procedure TCustomFileDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Execute', TCustomFileDialog_Execute_si, nil, 0, True);
  AData.AddProperty('ClientGuid', TCustomFileDialog_ClientGuid_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultExtension', TCustomFileDialog_DefaultExtension_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultFolder', TCustomFileDialog_DefaultFolder_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FavoriteLinks', TCustomFileDialog_FavoriteLinks_si, TFavoriteLinkItems_sw, True, True, 0, False, False);
  AData.AddProperty('FileName', TCustomFileDialog_FileName_si, TFileName_sw, True, True, 0, False, False);
  AData.AddProperty('FileNameLabel', TCustomFileDialog_FileNameLabel_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Files', TCustomFileDialog_Files_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('FileTypes', TCustomFileDialog_FileTypes_si, TFileTypeItems_sw, True, True, 0, False, False);
  AData.AddProperty('FileTypeIndex', TCustomFileDialog_FileTypeIndex_si, Cardinal_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TCustomFileDialog_Handle_si, HWnd_sw, True, False, 0, False, False);
  AData.AddProperty('OkButtonLabel', TCustomFileDialog_OkButtonLabel_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TCustomFileDialog_Options_si, TFileDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Title', TCustomFileDialog_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('OnExecute', TCustomFileDialog_OnExecute_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFileOkClick', TCustomFileDialog_OnFileOkClick_si, TFileDialogCloseEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFolderChange', TCustomFileDialog_OnFolderChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFolderChanging', TCustomFileDialog_OnFolderChanging_si, TFileDialogFolderChangingEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnOverwrite', TCustomFileDialog_OnOverwrite_si, TFileDialogOverwriteEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSelectionChange', TCustomFileDialog_OnSelectionChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShareViolation', TCustomFileDialog_OnShareViolation_si, TFileDialogShareViolationEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnTypeChange', TCustomFileDialog_OnTypeChange_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomFileDialog_sw.ToVar(
  const AValue: TCustomFileDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFileDialog_sw.FromVar(
  const AValue: OleVariant): TCustomFileDialog;
begin
  Result := TCustomFileDialog(ConvFromVar(AValue, TCustomFileDialog));
end;

class function TCustomFileDialog_sw.ClassToVar(
  AClass: TCustomFileDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomFileDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCustomFileDialog_sc;
begin
  Result := TCustomFileDialog_sc(ConvClsFromVar(AClass, TCustomFileDialog));
end;

{ TCustomFileOpenDialog_sw }

class function TCustomFileOpenDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFileOpenDialog';
end;

class function TCustomFileOpenDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCustomFileOpenDialog;
end;

class procedure TCustomFileOpenDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomFileOpenDialog_sw.ToVar(
  const AValue: TCustomFileOpenDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFileOpenDialog_sw.FromVar(
  const AValue: OleVariant): TCustomFileOpenDialog;
begin
  Result := TCustomFileOpenDialog(ConvFromVar(AValue, TCustomFileOpenDialog));
end;

class function TCustomFileOpenDialog_sw.ClassToVar(
  AClass: TCustomFileOpenDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomFileOpenDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCustomFileOpenDialog_sc;
begin
  Result := TCustomFileOpenDialog_sc(ConvClsFromVar(AClass, 
    TCustomFileOpenDialog));
end;

{ TFileOpenDialog_sw }

class function TFileOpenDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFileOpenDialog';
end;

class function TFileOpenDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFileOpenDialog;
end;

class procedure TFileOpenDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ClientGuid', False);
  AData.AddPropertyRedecl('DefaultExtension', False);
  AData.AddPropertyRedecl('DefaultFolder', False);
  AData.AddPropertyRedecl('FavoriteLinks', False);
  AData.AddPropertyRedecl('FileName', False);
  AData.AddPropertyRedecl('FileNameLabel', False);
  AData.AddPropertyRedecl('FileTypes', False);
  AData.AddPropertyRedecl('FileTypeIndex', False);
  AData.AddPropertyRedecl('OkButtonLabel', False);
  AData.AddPropertyRedecl('Options', False);
  AData.AddPropertyRedecl('Title', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnFileOkClick', False);
  AData.AddPropertyRedecl('OnFolderChange', False);
  AData.AddPropertyRedecl('OnFolderChanging', False);
  AData.AddPropertyRedecl('OnSelectionChange', False);
  AData.AddPropertyRedecl('OnShareViolation', False);
  AData.AddPropertyRedecl('OnTypeChange', False);
end;

class function TFileOpenDialog_sw.ToVar(
  const AValue: TFileOpenDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileOpenDialog_sw.FromVar(
  const AValue: OleVariant): TFileOpenDialog;
begin
  Result := TFileOpenDialog(ConvFromVar(AValue, TFileOpenDialog));
end;

class function TFileOpenDialog_sw.ClassToVar(
  AClass: TFileOpenDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileOpenDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFileOpenDialog_sc;
begin
  Result := TFileOpenDialog_sc(ConvClsFromVar(AClass, TFileOpenDialog));
end;

{ TCustomFileSaveDialog_sw }

class function TCustomFileSaveDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFileSaveDialog';
end;

class function TCustomFileSaveDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCustomFileSaveDialog;
end;

class procedure TCustomFileSaveDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomFileSaveDialog_sw.ToVar(
  const AValue: TCustomFileSaveDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFileSaveDialog_sw.FromVar(
  const AValue: OleVariant): TCustomFileSaveDialog;
begin
  Result := TCustomFileSaveDialog(ConvFromVar(AValue, TCustomFileSaveDialog));
end;

class function TCustomFileSaveDialog_sw.ClassToVar(
  AClass: TCustomFileSaveDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomFileSaveDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCustomFileSaveDialog_sc;
begin
  Result := TCustomFileSaveDialog_sc(ConvClsFromVar(AClass, 
    TCustomFileSaveDialog));
end;

{ TFileSaveDialog_sw }

class function TFileSaveDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFileSaveDialog';
end;

class function TFileSaveDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFileSaveDialog;
end;

class procedure TFileSaveDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ClientGuid', False);
  AData.AddPropertyRedecl('DefaultExtension', False);
  AData.AddPropertyRedecl('DefaultFolder', False);
  AData.AddPropertyRedecl('FavoriteLinks', False);
  AData.AddPropertyRedecl('FileName', False);
  AData.AddPropertyRedecl('FileNameLabel', False);
  AData.AddPropertyRedecl('FileTypes', False);
  AData.AddPropertyRedecl('FileTypeIndex', False);
  AData.AddPropertyRedecl('OkButtonLabel', False);
  AData.AddPropertyRedecl('Options', False);
  AData.AddPropertyRedecl('Title', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnFileOkClick', False);
  AData.AddPropertyRedecl('OnFolderChange', False);
  AData.AddPropertyRedecl('OnFolderChanging', False);
  AData.AddPropertyRedecl('OnOverwrite', False);
  AData.AddPropertyRedecl('OnSelectionChange', False);
  AData.AddPropertyRedecl('OnShareViolation', False);
  AData.AddPropertyRedecl('OnTypeChange', False);
end;

class function TFileSaveDialog_sw.ToVar(
  const AValue: TFileSaveDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileSaveDialog_sw.FromVar(
  const AValue: OleVariant): TFileSaveDialog;
begin
  Result := TFileSaveDialog(ConvFromVar(AValue, TFileSaveDialog));
end;

class function TFileSaveDialog_sw.ClassToVar(
  AClass: TFileSaveDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileSaveDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFileSaveDialog_sc;
begin
  Result := TFileSaveDialog_sc(ConvClsFromVar(AClass, TFileSaveDialog));
end;

{ TTaskDialogFlag_sw }

class function TTaskDialogFlag_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogFlag';
end;

class procedure TTaskDialogFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..15] of TLMDEnumerator = (
    (Name: 'tfEnableHyperlinks'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfEnableHyperlinks)),
    (Name: 'tfUseHiconMain'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfUseHiconMain)),
    (Name: 'tfUseHiconFooter'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfUseHiconFooter)),
    (Name: 'tfAllowDialogCancellation'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfAllowDialogCancellation)),
    (Name: 'tfUseCommandLinks'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfUseCommandLinks)),
    (Name: 'tfUseCommandLinksNoIcon'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfUseCommandLinksNoIcon)),
    (Name: 'tfExpandFooterArea'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfExpandFooterArea)),
    (Name: 'tfExpandedByDefault'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfExpandedByDefault)),
    (Name: 'tfVerificationFlagChecked'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfVerificationFlagChecked)),
    (Name: 'tfShowProgressBar'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfShowProgressBar)),
    (Name: 'tfShowMarqueeProgressBar'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfShowMarqueeProgressBar)),
    (Name: 'tfCallbackTimer'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfCallbackTimer)),
    (Name: 'tfPositionRelativeToWindow'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfPositionRelativeToWindow)),
    (Name: 'tfRtlLayout'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfRtlLayout)),
    (Name: 'tfNoDefaultRadioButton'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfNoDefaultRadioButton)),
    (Name: 'tfCanBeMinimized'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogFlag.{$ENDIF}tfCanBeMinimized))
  );
begin
  AEnums := @ENUMS;
  ACount := 16;
end;

class function TTaskDialogFlag_sw.ToVar(
  const AValue: TTaskDialogFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTaskDialogFlag_sw.FromVar(
  const AValue: OleVariant): TTaskDialogFlag;
begin
  Result := TTaskDialogFlag(Integer(AValue));
end;

{ TTaskDialogFlags_sw }

class function TTaskDialogFlags_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogFlags';
end;

class function TTaskDialogFlags_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTaskDialogFlags);
end;

class function TTaskDialogFlags_sw.ToVar(
  const AValue: TTaskDialogFlags): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTaskDialogFlags_sw.FromVar(
  const AValue: OleVariant): TTaskDialogFlags;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTaskDialogCommonButton_sw }

class function TTaskDialogCommonButton_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogCommonButton';
end;

class procedure TTaskDialogCommonButton_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'tcbOk'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbOk)),
    (Name: 'tcbYes'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbYes)),
    (Name: 'tcbNo'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbNo)),
    (Name: 'tcbCancel'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbCancel)),
    (Name: 'tcbRetry'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbRetry)),
    (Name: 'tcbClose'; Value: Integer({$IFDEF LMDSCT_12}TTaskDialogCommonButton.{$ENDIF}tcbClose))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TTaskDialogCommonButton_sw.ToVar(
  const AValue: TTaskDialogCommonButton): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTaskDialogCommonButton_sw.FromVar(
  const AValue: OleVariant): TTaskDialogCommonButton;
begin
  Result := TTaskDialogCommonButton(Integer(AValue));
end;

{ TTaskDialogCommonButtons_sw }

class function TTaskDialogCommonButtons_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogCommonButtons';
end;

class function TTaskDialogCommonButtons_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTaskDialogCommonButtons);
end;

class function TTaskDialogCommonButtons_sw.ToVar(
  const AValue: TTaskDialogCommonButtons): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTaskDialogCommonButtons_sw.FromVar(
  const AValue: OleVariant): TTaskDialogCommonButtons;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTaskDialogIcon_sw }

class function TTaskDialogIcon_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogIcon';
end;

class function TTaskDialogIcon_sw.ToVar(
  const AValue: TTaskDialogIcon): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTaskDialogIcon_sw.FromVar(
  const AValue: OleVariant): TTaskDialogIcon;
begin
  Result := TTaskDialogIcon(Integer(AValue));
end;

{ TTaskDialogProgressBar_sw }

function TTaskDialogProgressBar_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AClient: TCustomTaskDialog);

  Result := TTaskDialogProgressBar_sw.ToVar(TTaskDialogProgressBar_sc(AObj).
    Create(TCustomTaskDialog_sw.FromVar(AArgs[0])));
end;

function TTaskDialogProgressBar_Initialize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Initialize;

  TTaskDialogProgressBar(AObj).Initialize();
end;

function TTaskDialogProgressBar_MarqueeSpeed_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarqueeSpeed: Cardinal read <getter> write <sett...

  if IsGet then
    Result := TTaskDialogProgressBar(AObj).MarqueeSpeed
  else
    TTaskDialogProgressBar(AObj).MarqueeSpeed := Cardinal(AArgs[0]);
end;

function TTaskDialogProgressBar_Max_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Max: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogProgressBar(AObj).Max
  else
    TTaskDialogProgressBar(AObj).Max := Integer(AArgs[0]);
end;

function TTaskDialogProgressBar_Min_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Min: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogProgressBar(AObj).Min
  else
    TTaskDialogProgressBar(AObj).Min := Integer(AArgs[0]);
end;

function TTaskDialogProgressBar_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogProgressBar(AObj).Position
  else
    TTaskDialogProgressBar(AObj).Position := Integer(AArgs[0]);
end;

function TTaskDialogProgressBar_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TProgressBarState read <getter> write <se...

  if IsGet then
    Result := TProgressBarState_sw.ToVar(TTaskDialogProgressBar(AObj).State)
  else
    TTaskDialogProgressBar(AObj).State := TProgressBarState_sw.FromVar(
      AArgs[0]);
end;

class function TTaskDialogProgressBar_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogProgressBar';
end;

class function TTaskDialogProgressBar_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogProgressBar;
end;

class procedure TTaskDialogProgressBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Initialize', TTaskDialogProgressBar_Initialize_si, 0, False);
  AData.AddProperty('MarqueeSpeed', TTaskDialogProgressBar_MarqueeSpeed_si, Cardinal_sw, True, True, 0, False, False);
  AData.AddProperty('Max', TTaskDialogProgressBar_Max_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Min', TTaskDialogProgressBar_Min_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TTaskDialogProgressBar_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('State', TTaskDialogProgressBar_State_si, TProgressBarState_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTaskDialogProgressBar_Create_si, 1, False);
end;

class function TTaskDialogProgressBar_sw.ToVar(
  const AValue: TTaskDialogProgressBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogProgressBar_sw.FromVar(
  const AValue: OleVariant): TTaskDialogProgressBar;
begin
  Result := TTaskDialogProgressBar(ConvFromVar(AValue, TTaskDialogProgressBar));
end;

class function TTaskDialogProgressBar_sw.ClassToVar(
  AClass: TTaskDialogProgressBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogProgressBar_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogProgressBar_sc;
begin
  Result := TTaskDialogProgressBar_sc(ConvClsFromVar(AClass, 
    TTaskDialogProgressBar));
end;

{ TTaskDialogBaseButtonItem_sw }

function TTaskDialogBaseButtonItem_Click_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Click;

  TTaskDialogBaseButtonItem(AObj).Click();
end;

function TTaskDialogBaseButtonItem_SetInitialState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetInitialState;

  TTaskDialogBaseButtonItem(AObj).SetInitialState();
end;

function TTaskDialogBaseButtonItem_ModalResult_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalResult: TModalResult read <getter> write <s...

  if IsGet then
    Result := TModalResult_sw.ToVar(TTaskDialogBaseButtonItem(AObj).ModalResult)
  else
    TTaskDialogBaseButtonItem(AObj).ModalResult := TModalResult_sw.FromVar(
      AArgs[0]);
end;

function TTaskDialogBaseButtonItem_Caption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogBaseButtonItem(AObj).Caption
  else
    TTaskDialogBaseButtonItem(AObj).Caption := string(AArgs[0]);
end;

function TTaskDialogBaseButtonItem_Default_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Default: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogBaseButtonItem(AObj).Default
  else
    TTaskDialogBaseButtonItem(AObj).Default := Boolean(AArgs[0]);
end;

function TTaskDialogBaseButtonItem_Enabled_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTaskDialogBaseButtonItem(AObj).Enabled
  else
    TTaskDialogBaseButtonItem(AObj).Enabled := Boolean(AArgs[0]);
end;

class function TTaskDialogBaseButtonItem_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogBaseButtonItem';
end;

class function TTaskDialogBaseButtonItem_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogBaseButtonItem;
end;

class procedure TTaskDialogBaseButtonItem_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Click', TTaskDialogBaseButtonItem_Click_si, 0, False);
  AData.AddProcedure('SetInitialState', TTaskDialogBaseButtonItem_SetInitialState_si, 0, False);
  AData.AddProperty('ModalResult', TTaskDialogBaseButtonItem_ModalResult_si, TModalResult_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TTaskDialogBaseButtonItem_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Default', TTaskDialogBaseButtonItem_Default_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TTaskDialogBaseButtonItem_Enabled_si, Boolean_sw, True, True, 0, False, False);
end;

class function TTaskDialogBaseButtonItem_sw.ToVar(
  const AValue: TTaskDialogBaseButtonItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogBaseButtonItem_sw.FromVar(
  const AValue: OleVariant): TTaskDialogBaseButtonItem;
begin
  Result := TTaskDialogBaseButtonItem(ConvFromVar(AValue, 
    TTaskDialogBaseButtonItem));
end;

class function TTaskDialogBaseButtonItem_sw.ClassToVar(
  AClass: TTaskDialogBaseButtonItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogBaseButtonItem_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogBaseButtonItem_sc;
begin
  Result := TTaskDialogBaseButtonItem_sc(ConvClsFromVar(AClass, 
    TTaskDialogBaseButtonItem));
end;

{ TTaskDialogButtonItem_sw }

function TTaskDialogButtonItem_CommandLinkHint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandLinkHint: string read <getter> write <set...

  if IsGet then
    Result := TTaskDialogButtonItem(AObj).CommandLinkHint
  else
    TTaskDialogButtonItem(AObj).CommandLinkHint := string(AArgs[0]);
end;

function TTaskDialogButtonItem_ElevationRequired_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ElevationRequired: Boolean read <getter> write <...

  if IsGet then
    Result := TTaskDialogButtonItem(AObj).ElevationRequired
  else
    TTaskDialogButtonItem(AObj).ElevationRequired := Boolean(AArgs[0]);
end;

class function TTaskDialogButtonItem_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogButtonItem';
end;

class function TTaskDialogButtonItem_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogButtonItem;
end;

class procedure TTaskDialogButtonItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('CommandLinkHint', TTaskDialogButtonItem_CommandLinkHint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ElevationRequired', TTaskDialogButtonItem_ElevationRequired_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ModalResult', False);
end;

class function TTaskDialogButtonItem_sw.ToVar(
  const AValue: TTaskDialogButtonItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogButtonItem_sw.FromVar(
  const AValue: OleVariant): TTaskDialogButtonItem;
begin
  Result := TTaskDialogButtonItem(ConvFromVar(AValue, TTaskDialogButtonItem));
end;

class function TTaskDialogButtonItem_sw.ClassToVar(
  AClass: TTaskDialogButtonItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogButtonItem_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogButtonItem_sc;
begin
  Result := TTaskDialogButtonItem_sc(ConvClsFromVar(AClass, 
    TTaskDialogButtonItem));
end;

{ TTaskDialogRadioButtonItem_sw }

class function TTaskDialogRadioButtonItem_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogRadioButtonItem';
end;

class function TTaskDialogRadioButtonItem_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogRadioButtonItem;
end;

class procedure TTaskDialogRadioButtonItem_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TTaskDialogRadioButtonItem_sw.ToVar(
  const AValue: TTaskDialogRadioButtonItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogRadioButtonItem_sw.FromVar(
  const AValue: OleVariant): TTaskDialogRadioButtonItem;
begin
  Result := TTaskDialogRadioButtonItem(ConvFromVar(AValue, 
    TTaskDialogRadioButtonItem));
end;

class function TTaskDialogRadioButtonItem_sw.ClassToVar(
  AClass: TTaskDialogRadioButtonItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogRadioButtonItem_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogRadioButtonItem_sc;
begin
  Result := TTaskDialogRadioButtonItem_sc(ConvClsFromVar(AClass, 
    TTaskDialogRadioButtonItem));
end;

{ TTaskDialogButtonsEnumerator_sw }

function TTaskDialogButtonsEnumerator_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ACollection: TTaskDialogButtons);

  Result := TTaskDialogButtonsEnumerator_sw.ToVar(
    TTaskDialogButtonsEnumerator_sc(AObj).Create(TTaskDialogButtons_sw.FromVar(
    AArgs[0])));
end;

function TTaskDialogButtonsEnumerator_GetCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TTaskDialogBaseButtonItem;

  Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtonsEnumerator(
    AObj).GetCurrent());
end;

function TTaskDialogButtonsEnumerator_MoveNext_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TTaskDialogButtonsEnumerator(AObj).MoveNext();
end;

function TTaskDialogButtonsEnumerator_Current_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TTaskDialogBaseButtonItem read <getter>;

  Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtonsEnumerator(
    AObj).Current);
end;

class function TTaskDialogButtonsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogButtonsEnumerator';
end;

class function TTaskDialogButtonsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogButtonsEnumerator;
end;

class procedure TTaskDialogButtonsEnumerator_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TTaskDialogButtonsEnumerator_GetCurrent_si, TTaskDialogBaseButtonItem_sw, 0, False);
  AData.AddFunction('MoveNext', TTaskDialogButtonsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TTaskDialogButtonsEnumerator_Current_si, TTaskDialogBaseButtonItem_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTaskDialogButtonsEnumerator_Create_si, 1, False);
end;

class function TTaskDialogButtonsEnumerator_sw.ToVar(
  const AValue: TTaskDialogButtonsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogButtonsEnumerator_sw.FromVar(
  const AValue: OleVariant): TTaskDialogButtonsEnumerator;
begin
  Result := TTaskDialogButtonsEnumerator(ConvFromVar(AValue, 
    TTaskDialogButtonsEnumerator));
end;

class function TTaskDialogButtonsEnumerator_sw.ClassToVar(
  AClass: TTaskDialogButtonsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogButtonsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogButtonsEnumerator_sc;
begin
  Result := TTaskDialogButtonsEnumerator_sc(ConvClsFromVar(AClass, 
    TTaskDialogButtonsEnumerator));
end;

{ TTaskDialogButtons_sw }

function TTaskDialogButtons_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TTaskDialogBaseButtonItem;

  Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtons(AObj).Add());
end;

function TTaskDialogButtons_FindButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindButton(AModalResult: TModalResult): TTaskDia...

  Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtons(AObj).
    FindButton(TModalResult_sw.FromVar(AArgs[0])));
end;

function TTaskDialogButtons_GetEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TTaskDialogButtonsEnumerator;

  Result := TTaskDialogButtonsEnumerator_sw.ToVar(TTaskDialogButtons(AObj).
    GetEnumerator());
end;

function TTaskDialogButtons_SetInitialState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetInitialState;

  TTaskDialogButtons(AObj).SetInitialState();
end;

function TTaskDialogButtons_DefaultButton_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultButton: TTaskDialogBaseButtonItem read <g...

  if IsGet then
    Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtons(AObj).
      DefaultButton)
  else
    TTaskDialogButtons(AObj).DefaultButton := TTaskDialogBaseButtonItem_sw.
      FromVar(AArgs[0]);
end;

function TTaskDialogButtons_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TTaskDialogBaseButtonItem...

  if IsGet then
    Result := TTaskDialogBaseButtonItem_sw.ToVar(TTaskDialogButtons(AObj).
      Items[Integer(AArgs[0])])
  else
    TTaskDialogButtons(AObj).Items[Integer(AArgs[0])] := 
      TTaskDialogBaseButtonItem_sw.FromVar(AArgs[1]);
end;

class function TTaskDialogButtons_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialogButtons';
end;

class function TTaskDialogButtons_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialogButtons;
end;

class procedure TTaskDialogButtons_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TTaskDialogButtons_Add_si, TTaskDialogBaseButtonItem_sw, 0, False);
  AData.AddFunction('FindButton', TTaskDialogButtons_FindButton_si, TTaskDialogBaseButtonItem_sw, 1, False);
  AData.AddFunction('GetEnumerator', TTaskDialogButtons_GetEnumerator_si, TTaskDialogButtonsEnumerator_sw, 0, False);
  AData.AddProcedure('SetInitialState', TTaskDialogButtons_SetInitialState_si, 0, False);
  AData.AddProperty('DefaultButton', TTaskDialogButtons_DefaultButton_si, TTaskDialogBaseButtonItem_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TTaskDialogButtons_Items_si, TTaskDialogBaseButtonItem_sw, True, True, 1, False, True);
end;

class function TTaskDialogButtons_sw.ToVar(
  const AValue: TTaskDialogButtons): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialogButtons_sw.FromVar(
  const AValue: OleVariant): TTaskDialogButtons;
begin
  Result := TTaskDialogButtons(ConvFromVar(AValue, TTaskDialogButtons));
end;

class function TTaskDialogButtons_sw.ClassToVar(
  AClass: TTaskDialogButtons_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialogButtons_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialogButtons_sc;
begin
  Result := TTaskDialogButtons_sc(ConvClsFromVar(AClass, TTaskDialogButtons));
end;

{ TTaskDlgClickEvent_sh }

function TTaskDlgClickEvent_sh.GetHandler: TMethod;
var
  hdr: TTaskDlgClickEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTaskDlgClickEvent_sh.Handler(Sender: TObject;
  ModalResult: TModalResult; var CanClose: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; ModalResult: TModalResult; va...

  v_1 := CanClose;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TModalResult_sw.ToVar(ModalResult);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  CanClose := Boolean(v_1);
end;

{ TTaskDlgClickEvent_sw }

class function TTaskDlgClickEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDlgClickEvent';
end;

class function TTaskDlgClickEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTaskDlgClickEvent_sh;
end;

class function TTaskDlgClickEvent_sw.ToVar(
  const AValue: TTaskDlgClickEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTaskDlgClickEvent_sw.FromVar(
  const AValue: OleVariant): TTaskDlgClickEvent;
begin
  Result := TTaskDlgClickEvent(ConvFromVar(AValue));
end;

class function TTaskDlgClickEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTaskDlgClickEvent;
var
  hdlr: TTaskDlgClickEvent_sh;
begin
  hdlr   := TTaskDlgClickEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTaskDlgClickEvent_sw));
  Result := hdlr.Handler;
end;

{ TTaskDlgTimerEvent_sh }

function TTaskDlgTimerEvent_sh.GetHandler: TMethod;
var
  hdr: TTaskDlgTimerEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTaskDlgTimerEvent_sh.Handler(Sender: TObject; TickCount: Cardinal;
  var Reset: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; TickCount: Cardinal; var Rese...

  v_1 := Reset;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TickCount;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Reset := Boolean(v_1);
end;

{ TTaskDlgTimerEvent_sw }

class function TTaskDlgTimerEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDlgTimerEvent';
end;

class function TTaskDlgTimerEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTaskDlgTimerEvent_sh;
end;

class function TTaskDlgTimerEvent_sw.ToVar(
  const AValue: TTaskDlgTimerEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTaskDlgTimerEvent_sw.FromVar(
  const AValue: OleVariant): TTaskDlgTimerEvent;
begin
  Result := TTaskDlgTimerEvent(ConvFromVar(AValue));
end;

class function TTaskDlgTimerEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTaskDlgTimerEvent;
var
  hdlr: TTaskDlgTimerEvent_sh;
begin
  hdlr   := TTaskDlgTimerEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTaskDlgTimerEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomTaskDialog_sw }

function TCustomTaskDialog_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Execute(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TCustomTaskDialog(AObj).Execute();
    end;
    1:
    begin
      Result := TCustomTaskDialog(AObj).Execute(HWND_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Execute');
  end;
end;

function TCustomTaskDialog_Button_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Button: TTaskDialogButtonItem read <getter> writ...

  if IsGet then
    Result := TTaskDialogButtonItem_sw.ToVar(TCustomTaskDialog(AObj).Button)
  else
    TCustomTaskDialog(AObj).Button := TTaskDialogButtonItem_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_Buttons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Buttons: TTaskDialogButtons read <getter> write ...

  if IsGet then
    Result := TTaskDialogButtons_sw.ToVar(TCustomTaskDialog(AObj).Buttons)
  else
    TCustomTaskDialog(AObj).Buttons := TTaskDialogButtons_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).Caption
  else
    TCustomTaskDialog(AObj).Caption := string(AArgs[0]);
end;

function TCustomTaskDialog_CommonButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommonButtons: TTaskDialogCommonButtons read <ge...

  if IsGet then
    Result := TTaskDialogCommonButtons_sw.ToVar(TCustomTaskDialog(AObj).
      CommonButtons)
  else
    TCustomTaskDialog(AObj).CommonButtons := TTaskDialogCommonButtons_sw.
      FromVar(AArgs[0]);
end;

function TCustomTaskDialog_CustomFooterIcon_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomFooterIcon: TIcon read <getter> write <set...

  if IsGet then
    Result := TIcon_sw.ToVar(TCustomTaskDialog(AObj).CustomFooterIcon)
  else
    TCustomTaskDialog(AObj).CustomFooterIcon := TIcon_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_CustomMainIcon_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomMainIcon: TIcon read <getter> write <setter>;

  if IsGet then
    Result := TIcon_sw.ToVar(TCustomTaskDialog(AObj).CustomMainIcon)
  else
    TCustomTaskDialog(AObj).CustomMainIcon := TIcon_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_DefaultButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultButton: TTaskDialogCommonButton read <get...

  if IsGet then
    Result := TTaskDialogCommonButton_sw.ToVar(TCustomTaskDialog(AObj).
      DefaultButton)
  else
    TCustomTaskDialog(AObj).DefaultButton := TTaskDialogCommonButton_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_ExpandButtonCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpandButtonCaption: string read <getter> write ...

  if IsGet then
    Result := TCustomTaskDialog(AObj).ExpandButtonCaption
  else
    TCustomTaskDialog(AObj).ExpandButtonCaption := string(AArgs[0]);
end;

function TCustomTaskDialog_Expanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expanded: Boolean read <getter>;

  Result := TCustomTaskDialog(AObj).Expanded;
end;

function TCustomTaskDialog_ExpandedText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpandedText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).ExpandedText
  else
    TCustomTaskDialog(AObj).ExpandedText := string(AArgs[0]);
end;

function TCustomTaskDialog_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flags: TTaskDialogFlags read <getter> write <set...

  if IsGet then
    Result := TTaskDialogFlags_sw.ToVar(TCustomTaskDialog(AObj).Flags)
  else
    TCustomTaskDialog(AObj).Flags := TTaskDialogFlags_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_FooterIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FooterIcon: TTaskDialogIcon read <getter> write ...

  if IsGet then
    Result := TTaskDialogIcon_sw.ToVar(TCustomTaskDialog(AObj).FooterIcon)
  else
    TCustomTaskDialog(AObj).FooterIcon := TTaskDialogIcon_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_FooterText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FooterText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).FooterText
  else
    TCustomTaskDialog(AObj).FooterText := string(AArgs[0]);
end;

function TCustomTaskDialog_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TCustomTaskDialog(AObj).Handle);
end;

function TCustomTaskDialog_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).HelpContext
  else
    TCustomTaskDialog(AObj).HelpContext := Integer(AArgs[0]);
end;

function TCustomTaskDialog_MainIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MainIcon: TTaskDialogIcon read <getter> write <s...

  if IsGet then
    Result := TTaskDialogIcon_sw.ToVar(TCustomTaskDialog(AObj).MainIcon)
  else
    TCustomTaskDialog(AObj).MainIcon := TTaskDialogIcon_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_ModalResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalResult: TModalResult read <getter> write <s...

  if IsGet then
    Result := TModalResult_sw.ToVar(TCustomTaskDialog(AObj).ModalResult)
  else
    TCustomTaskDialog(AObj).ModalResult := TModalResult_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_ProgressBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProgressBar: TTaskDialogProgressBar read <getter...

  if IsGet then
    Result := TTaskDialogProgressBar_sw.ToVar(TCustomTaskDialog(AObj).
      ProgressBar)
  else
    TCustomTaskDialog(AObj).ProgressBar := TTaskDialogProgressBar_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_RadioButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RadioButton: TTaskDialogRadioButtonItem read <ge...

  Result := TTaskDialogRadioButtonItem_sw.ToVar(TCustomTaskDialog(AObj).
    RadioButton);
end;

function TCustomTaskDialog_RadioButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RadioButtons: TTaskDialogButtons read <getter> w...

  if IsGet then
    Result := TTaskDialogButtons_sw.ToVar(TCustomTaskDialog(AObj).RadioButtons)
  else
    TCustomTaskDialog(AObj).RadioButtons := TTaskDialogButtons_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).Text
  else
    TCustomTaskDialog(AObj).Text := string(AArgs[0]);
end;

function TCustomTaskDialog_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomTaskDialog(AObj).Title
  else
    TCustomTaskDialog(AObj).Title := string(AArgs[0]);
end;

function TCustomTaskDialog_URL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property URL: string read <getter>;

  Result := TCustomTaskDialog(AObj).URL;
end;

function TCustomTaskDialog_VerificationText_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VerificationText: string read <getter> write <se...

  if IsGet then
    Result := TCustomTaskDialog(AObj).VerificationText
  else
    TCustomTaskDialog(AObj).VerificationText := string(AArgs[0]);
end;

function TCustomTaskDialog_OnButtonClicked_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnButtonClicked: TTaskDlgClickEvent read <getter...

  if IsGet then
    Result := TTaskDlgClickEvent_sw.ToVar(TCustomTaskDialog(AObj).
      OnButtonClicked)
  else
    TCustomTaskDialog(AObj).OnButtonClicked := TTaskDlgClickEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnDialogConstructed_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDialogConstructed: TNotifyEvent read <getter> ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnDialogConstructed)
  else
    TCustomTaskDialog(AObj).OnDialogConstructed := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnDialogCreated_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDialogCreated: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnDialogCreated)
  else
    TCustomTaskDialog(AObj).OnDialogCreated := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnDialogDestroyed_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDialogDestroyed: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnDialogDestroyed)
  else
    TCustomTaskDialog(AObj).OnDialogDestroyed := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnExpanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnExpanded: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnExpanded)
  else
    TCustomTaskDialog(AObj).OnExpanded := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_OnHyperlinkClicked_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHyperlinkClicked: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnHyperlinkClicked)
  else
    TCustomTaskDialog(AObj).OnHyperlinkClicked := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnNavigated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnNavigated: TNotifyEvent read <getter> write <s...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).OnNavigated)
  else
    TCustomTaskDialog(AObj).OnNavigated := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_OnRadioButtonClicked_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnRadioButtonClicked: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).
      OnRadioButtonClicked)
  else
    TCustomTaskDialog(AObj).OnRadioButtonClicked := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomTaskDialog_OnTimer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTimer: TTaskDlgTimerEvent read <getter> write ...

  if IsGet then
    Result := TTaskDlgTimerEvent_sw.ToVar(TCustomTaskDialog(AObj).OnTimer)
  else
    TCustomTaskDialog(AObj).OnTimer := TTaskDlgTimerEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTaskDialog_OnVerificationClicked_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnVerificationClicked: TNotifyEvent read <getter...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTaskDialog(AObj).
      OnVerificationClicked)
  else
    TCustomTaskDialog(AObj).OnVerificationClicked := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomTaskDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCustomTaskDialog';
end;

class function TCustomTaskDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCustomTaskDialog;
end;

class procedure TCustomTaskDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Execute', TCustomTaskDialog_Execute_si, nil, 0, True);
  AData.AddProperty('Button', TCustomTaskDialog_Button_si, TTaskDialogButtonItem_sw, True, True, 0, False, False);
  AData.AddProperty('Buttons', TCustomTaskDialog_Buttons_si, TTaskDialogButtons_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TCustomTaskDialog_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('CommonButtons', TCustomTaskDialog_CommonButtons_si, TTaskDialogCommonButtons_sw, True, True, 0, False, False);
  AData.AddProperty('CustomFooterIcon', TCustomTaskDialog_CustomFooterIcon_si, TIcon_sw, True, True, 0, False, False);
  AData.AddProperty('CustomMainIcon', TCustomTaskDialog_CustomMainIcon_si, TIcon_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultButton', TCustomTaskDialog_DefaultButton_si, TTaskDialogCommonButton_sw, True, True, 0, False, False);
  AData.AddProperty('ExpandButtonCaption', TCustomTaskDialog_ExpandButtonCaption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Expanded', TCustomTaskDialog_Expanded_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ExpandedText', TCustomTaskDialog_ExpandedText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Flags', TCustomTaskDialog_Flags_si, TTaskDialogFlags_sw, True, True, 0, False, False);
  AData.AddProperty('FooterIcon', TCustomTaskDialog_FooterIcon_si, TTaskDialogIcon_sw, True, True, 0, False, False);
  AData.AddProperty('FooterText', TCustomTaskDialog_FooterText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TCustomTaskDialog_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('HelpContext', TCustomTaskDialog_HelpContext_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MainIcon', TCustomTaskDialog_MainIcon_si, TTaskDialogIcon_sw, True, True, 0, False, False);
  AData.AddProperty('ModalResult', TCustomTaskDialog_ModalResult_si, TModalResult_sw, True, True, 0, False, False);
  AData.AddProperty('ProgressBar', TCustomTaskDialog_ProgressBar_si, TTaskDialogProgressBar_sw, True, True, 0, False, False);
  AData.AddProperty('RadioButton', TCustomTaskDialog_RadioButton_si, TTaskDialogRadioButtonItem_sw, True, False, 0, False, False);
  AData.AddProperty('RadioButtons', TCustomTaskDialog_RadioButtons_si, TTaskDialogButtons_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TCustomTaskDialog_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Title', TCustomTaskDialog_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('URL', TCustomTaskDialog_URL_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('VerificationText', TCustomTaskDialog_VerificationText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('OnButtonClicked', TCustomTaskDialog_OnButtonClicked_si, TTaskDlgClickEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDialogConstructed', TCustomTaskDialog_OnDialogConstructed_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDialogCreated', TCustomTaskDialog_OnDialogCreated_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDialogDestroyed', TCustomTaskDialog_OnDialogDestroyed_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnExpanded', TCustomTaskDialog_OnExpanded_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnHyperlinkClicked', TCustomTaskDialog_OnHyperlinkClicked_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnNavigated', TCustomTaskDialog_OnNavigated_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnRadioButtonClicked', TCustomTaskDialog_OnRadioButtonClicked_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnTimer', TCustomTaskDialog_OnTimer_si, TTaskDlgTimerEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnVerificationClicked', TCustomTaskDialog_OnVerificationClicked_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomTaskDialog_sw.ToVar(
  const AValue: TCustomTaskDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomTaskDialog_sw.FromVar(
  const AValue: OleVariant): TCustomTaskDialog;
begin
  Result := TCustomTaskDialog(ConvFromVar(AValue, TCustomTaskDialog));
end;

class function TCustomTaskDialog_sw.ClassToVar(
  AClass: TCustomTaskDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomTaskDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCustomTaskDialog_sc;
begin
  Result := TCustomTaskDialog_sc(ConvClsFromVar(AClass, TCustomTaskDialog));
end;

{ TTaskDialog_sw }

class function TTaskDialog_sw.GetTypeName: WideString;
begin
  Result := 'TTaskDialog';
end;

class function TTaskDialog_sw.GetWrappedClass: TClass;
begin
  Result := TTaskDialog;
end;

class procedure TTaskDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Buttons', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('CommonButtons', False);
  AData.AddPropertyRedecl('CustomFooterIcon', False);
  AData.AddPropertyRedecl('CustomMainIcon', False);
  AData.AddPropertyRedecl('DefaultButton', False);
  AData.AddPropertyRedecl('ExpandButtonCaption', False);
  AData.AddPropertyRedecl('ExpandedText', False);
  AData.AddPropertyRedecl('Flags', False);
  AData.AddPropertyRedecl('FooterIcon', False);
  AData.AddPropertyRedecl('FooterText', False);
  AData.AddPropertyRedecl('HelpContext', False);
  AData.AddPropertyRedecl('MainIcon', False);
  AData.AddPropertyRedecl('ProgressBar', False);
  AData.AddPropertyRedecl('RadioButtons', False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('Title', False);
  AData.AddPropertyRedecl('VerificationText', False);
  AData.AddPropertyRedecl('OnButtonClicked', False);
  AData.AddPropertyRedecl('OnDialogConstructed', False);
  AData.AddPropertyRedecl('OnDialogCreated', False);
  AData.AddPropertyRedecl('OnDialogDestroyed', False);
  AData.AddPropertyRedecl('OnExpanded', False);
  AData.AddPropertyRedecl('OnHyperlinkClicked', False);
  AData.AddPropertyRedecl('OnNavigated', False);
  AData.AddPropertyRedecl('OnRadioButtonClicked', False);
  AData.AddPropertyRedecl('OnTimer', False);
  AData.AddPropertyRedecl('OnVerificationClicked', False);
end;

class function TTaskDialog_sw.ToVar(const AValue: TTaskDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTaskDialog_sw.FromVar(const AValue: OleVariant): TTaskDialog;
begin
  Result := TTaskDialog(ConvFromVar(AValue, TTaskDialog));
end;

class function TTaskDialog_sw.ClassToVar(AClass: TTaskDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTaskDialog_sw.ClassFromVar(
  const AClass: OleVariant): TTaskDialog_sc;
begin
  Result := TTaskDialog_sc(ConvClsFromVar(AClass, TTaskDialog));
end;

{ Dialogs_sw }

function Dialogs_MaxCustomColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxCustomColors = <value>;

  Result := MaxCustomColors;
end;

function Dialogs_ofReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofReadOnly = <value>;

  Result := TOpenOption_sw.ToVar(ofReadOnly);
end;

function Dialogs_ofOverwritePrompt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofOverwritePrompt = <value>;

  Result := TOpenOption_sw.ToVar(ofOverwritePrompt);
end;

function Dialogs_ofHideReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofHideReadOnly = <value>;

  Result := TOpenOption_sw.ToVar(ofHideReadOnly);
end;

function Dialogs_ofNoChangeDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoChangeDir = <value>;

  Result := TOpenOption_sw.ToVar(ofNoChangeDir);
end;

function Dialogs_ofShowHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofShowHelp = <value>;

  Result := TOpenOption_sw.ToVar(ofShowHelp);
end;

function Dialogs_ofNoValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoValidate = <value>;

  Result := TOpenOption_sw.ToVar(ofNoValidate);
end;

function Dialogs_ofAllowMultiSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofAllowMultiSelect = <value>;

  Result := TOpenOption_sw.ToVar(ofAllowMultiSelect);
end;

function Dialogs_ofExtensionDifferent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofExtensionDifferent = <value>;

  Result := TOpenOption_sw.ToVar(ofExtensionDifferent);
end;

function Dialogs_ofPathMustExist_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofPathMustExist = <value>;

  Result := TOpenOption_sw.ToVar(ofPathMustExist);
end;

function Dialogs_ofFileMustExist_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofFileMustExist = <value>;

  Result := TOpenOption_sw.ToVar(ofFileMustExist);
end;

function Dialogs_ofCreatePrompt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofCreatePrompt = <value>;

  Result := TOpenOption_sw.ToVar(ofCreatePrompt);
end;

function Dialogs_ofShareAware_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofShareAware = <value>;

  Result := TOpenOption_sw.ToVar(ofShareAware);
end;

function Dialogs_ofNoReadOnlyReturn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoReadOnlyReturn = <value>;

  Result := TOpenOption_sw.ToVar(ofNoReadOnlyReturn);
end;

function Dialogs_ofNoTestFileCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoTestFileCreate = <value>;

  Result := TOpenOption_sw.ToVar(ofNoTestFileCreate);
end;

function Dialogs_ofNoNetworkButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoNetworkButton = <value>;

  Result := TOpenOption_sw.ToVar(ofNoNetworkButton);
end;

function Dialogs_ofNoLongNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoLongNames = <value>;

  Result := TOpenOption_sw.ToVar(ofNoLongNames);
end;

function Dialogs_ofOldStyleDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofOldStyleDialog = <value>;

  Result := TOpenOption_sw.ToVar(ofOldStyleDialog);
end;

function Dialogs_ofNoDereferenceLinks_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofNoDereferenceLinks = <value>;

  Result := TOpenOption_sw.ToVar(ofNoDereferenceLinks);
end;

function Dialogs_ofEnableIncludeNotify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofEnableIncludeNotify = <value>;

  Result := TOpenOption_sw.ToVar(ofEnableIncludeNotify);
end;

function Dialogs_ofEnableSizing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofEnableSizing = <value>;

  Result := TOpenOption_sw.ToVar(ofEnableSizing);
end;

function Dialogs_ofDontAddToRecent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofDontAddToRecent = <value>;

  Result := TOpenOption_sw.ToVar(ofDontAddToRecent);
end;

function Dialogs_ofForceShowHidden_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofForceShowHidden = <value>;

  Result := TOpenOption_sw.ToVar(ofForceShowHidden);
end;

function Dialogs_ofExNoPlacesBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ofExNoPlacesBar = <value>;

  Result := TOpenOptionEx_sw.ToVar(ofExNoPlacesBar);
end;

function Dialogs_prAllPages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const prAllPages = <value>;

  Result := TPrintRange_sw.ToVar(prAllPages);
end;

function Dialogs_prSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const prSelection = <value>;

  Result := TPrintRange_sw.ToVar(prSelection);
end;

function Dialogs_prPageNums_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const prPageNums = <value>;

  Result := TPrintRange_sw.ToVar(prPageNums);
end;

function Dialogs_poPrintToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poPrintToFile = <value>;

  Result := TPrintDialogOption_sw.ToVar(poPrintToFile);
end;

function Dialogs_poPageNums_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poPageNums = <value>;

  Result := TPrintDialogOption_sw.ToVar(poPageNums);
end;

function Dialogs_poSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poSelection = <value>;

  Result := TPrintDialogOption_sw.ToVar(poSelection);
end;

function Dialogs_poWarning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poWarning = <value>;

  Result := TPrintDialogOption_sw.ToVar(poWarning);
end;

function Dialogs_poHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poHelp = <value>;

  Result := TPrintDialogOption_sw.ToVar(poHelp);
end;

function Dialogs_poDisablePrintToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poDisablePrintToFile = <value>;

  Result := TPrintDialogOption_sw.ToVar(poDisablePrintToFile);
end;

function Dialogs_psoDefaultMinMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDefaultMinMargins = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDefaultMinMargins);
end;

function Dialogs_psoDisableMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDisableMargins = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDisableMargins);
end;

function Dialogs_psoDisableOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDisableOrientation = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDisableOrientation);
end;

function Dialogs_psoDisablePagePainting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDisablePagePainting = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDisablePagePainting);
end;

function Dialogs_psoDisablePaper_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDisablePaper = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDisablePaper);
end;

function Dialogs_psoDisablePrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoDisablePrinter = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoDisablePrinter);
end;

function Dialogs_psoMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoMargins = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoMargins);
end;

function Dialogs_psoMinMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoMinMargins = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoMinMargins);
end;

function Dialogs_psoShowHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoShowHelp = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoShowHelp);
end;

function Dialogs_psoWarning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoWarning = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoWarning);
end;

function Dialogs_psoNoNetworkButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const psoNoNetworkButton = <value>;

  Result := TPageSetupDialogOption_sw.ToVar(psoNoNetworkButton);
end;

function Dialogs_pkDotMatrix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pkDotMatrix = <value>;

  Result := TPrinterKind_sw.ToVar(pkDotMatrix);
end;

function Dialogs_pkHPPCL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pkHPPCL = <value>;

  Result := TPrinterKind_sw.ToVar(pkHPPCL);
end;

function Dialogs_ptEnvelope_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ptEnvelope = <value>;

  Result := TPageType_sw.ToVar(ptEnvelope);
end;

function Dialogs_ptPaper_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ptPaper = <value>;

  Result := TPageType_sw.ToVar(ptPaper);
end;

function Dialogs_pmDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pmDefault = <value>;

  Result := TPageMeasureUnits_sw.ToVar(pmDefault);
end;

function Dialogs_pmMillimeters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pmMillimeters = <value>;

  Result := TPageMeasureUnits_sw.ToVar(pmMillimeters);
end;

function Dialogs_pmInches_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pmInches = <value>;

  Result := TPageMeasureUnits_sw.ToVar(pmInches);
end;

function Dialogs_mtWarning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mtWarning = <value>;

  Result := TMsgDlgType_sw.ToVar(mtWarning);
end;

function Dialogs_mtError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mtError = <value>;

  Result := TMsgDlgType_sw.ToVar(mtError);
end;

function Dialogs_mtInformation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mtInformation = <value>;

  Result := TMsgDlgType_sw.ToVar(mtInformation);
end;

function Dialogs_mtConfirmation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mtConfirmation = <value>;

  Result := TMsgDlgType_sw.ToVar(mtConfirmation);
end;

function Dialogs_mtCustom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mtCustom = <value>;

  Result := TMsgDlgType_sw.ToVar(mtCustom);
end;

function Dialogs_mbYes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYes = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbYes);
end;

function Dialogs_mbNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbNo = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbNo);
end;

function Dialogs_mbOK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbOK = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbOK);
end;

function Dialogs_mbCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbCancel = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbCancel);
end;

function Dialogs_mbAbort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAbort = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbAbort);
end;

function Dialogs_mbRetry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbRetry = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbRetry);
end;

function Dialogs_mbIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbIgnore = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbIgnore);
end;

function Dialogs_mbAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAll = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbAll);
end;

function Dialogs_mbNoToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbNoToAll = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbNoToAll);
end;

function Dialogs_mbYesToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesToAll = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbYesToAll);
end;

function Dialogs_mbHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbHelp = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbHelp);
end;

function Dialogs_mbClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbClose = <value>;

  Result := TMsgDlgBtn_sw.ToVar(mbClose);
end;

function Dialogs_TCommonDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonDialog = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCommonDialog_sw);
end;

function Dialogs_TOpenOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOption = System.UITypes.TOpenOption;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOption_sw);
end;

function Dialogs_TOpenOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptions = System.UITypes.TOpenOptions;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptions_sw);
end;

function Dialogs_TOpenOptionEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionEx = System.UITypes.TOpenOptionEx;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionEx_sw);
end;

function Dialogs_TOpenOptionsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionsEx = System.UITypes.TOpenOptionsEx;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionsEx_sw);
end;

function Dialogs_TFileEditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileEditStyle = (fsEdit, fsComboBox);

  Result := TLMDUnitWrapper.TypeToVar(TFileEditStyle_sw);
end;

function Dialogs_TOFNotifyEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyEx = Winapi.CommDlg.TOFNotifyEx;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyEx_sw);
end;

function Dialogs_TIncludeItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIncludeItemEvent = procedure (const OFN: TOFNotifyE...

  Result := TLMDUnitWrapper.TypeToVar(TIncludeItemEvent_sw);
end;

function Dialogs_TOpenDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TOpenDialog_sw);
end;

function Dialogs_TSaveDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSaveDialog = class(TOpenDialog);

  Result := TLMDUnitWrapper.TypeToVar(TSaveDialog_sw);
end;

function Dialogs_TColorDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialogOption = (cdFullOpen, cdPreventFullOpen,...

  Result := TLMDUnitWrapper.TypeToVar(TColorDialogOption_sw);
end;

function Dialogs_TColorDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialogOptions = set of TColorDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TColorDialogOptions_sw);
end;

function Dialogs_TColorDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TColorDialog_sw);
end;

function Dialogs_TFontDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogOption = (fdAnsiOnly, fdTrueTypeOnly, fdE...

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogOption_sw);
end;

function Dialogs_TFontDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogOptions = set of TFontDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogOptions_sw);
end;

function Dialogs_TFontDialogDevice_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogDevice = (fdScreen, fdPrinter, fdBoth);

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogDevice_sw);
end;

function Dialogs_TFDApplyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFDApplyEvent = procedure (Sender: TObject; Wnd: HWN...

  Result := TLMDUnitWrapper.TypeToVar(TFDApplyEvent_sw);
end;

function Dialogs_TFontDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFontDialog_sw);
end;

function Dialogs_TPrinterSetupDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterSetupDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterSetupDialog_sw);
end;

function Dialogs_TPrintRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintRange = System.UITypes.TPrintRange;

  Result := TLMDUnitWrapper.TypeToVar(TPrintRange_sw);
end;

function Dialogs_TPrintDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOption = System.UITypes.TPrintDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOption_sw);
end;

function Dialogs_TPrintDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOptions = System.UITypes.TPrintDialogOpt...

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOptions_sw);
end;

function Dialogs_TPrintDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialog_sw);
end;

function Dialogs_TPrinterOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterOrientation = Vcl.Printers.TPrinterOrientation;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterOrientation_sw);
end;

function Dialogs_TPageSetupDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOption = System.UITypes.TPageSetupDi...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOption_sw);
end;

function Dialogs_TPageSetupDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOptions = System.UITypes.TPageSetupD...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOptions_sw);
end;

function Dialogs_TPrinterKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterKind = System.UITypes.TPrinterKind;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterKind_sw);
end;

function Dialogs_TPageType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageType = System.UITypes.TPageType;

  Result := TLMDUnitWrapper.TypeToVar(TPageType_sw);
end;

function Dialogs_TPageMeasureUnits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageMeasureUnits = System.UITypes.TPageMeasureUnits;

  Result := TLMDUnitWrapper.TypeToVar(TPageMeasureUnits_sw);
end;

function Dialogs_TPageSetupBeforePaintEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupBeforePaintEvent = procedure (Sender: TObj...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupBeforePaintEvent_sw);
end;

function Dialogs_TPaintPageEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPaintPageEvent = procedure (Sender: TObject; Canvas...

  Result := TLMDUnitWrapper.TypeToVar(TPaintPageEvent_sw);
end;

function Dialogs_TPageSetupDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialog_sw);
end;

function Dialogs_TFindOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindOption = (frDown, frFindNext, frHideMatchCase, ...

  Result := TLMDUnitWrapper.TypeToVar(TFindOption_sw);
end;

function Dialogs_TFindOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindOptions = set of TFindOption;

  Result := TLMDUnitWrapper.TypeToVar(TFindOptions_sw);
end;

function Dialogs_TFindDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFindDialog_sw);
end;

function Dialogs_TReplaceDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReplaceDialog = class(TFindDialog);

  Result := TLMDUnitWrapper.TypeToVar(TReplaceDialog_sw);
end;

function Dialogs_EPlatformVersionException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPlatformVersionException = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPlatformVersionException_sw);
end;

function Dialogs_TFileDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogOption = (fdoOverWritePrompt, fdoStrictFi...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogOption_sw);
end;

function Dialogs_TFileDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogOptions = set of TFileDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogOptions_sw);
end;

function Dialogs_TFileDialogOverwriteResponse_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogOverwriteResponse = (forDefault, forAccep...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogOverwriteResponse_sw);
end;

function Dialogs_TFileDialogShareViolationResponse_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogShareViolationResponse = (fsrDefault, fsr...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogShareViolationResponse_sw);
end;

function Dialogs_TFileDialogCloseEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogCloseEvent = procedure (Sender: TObject; ...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogCloseEvent_sw);
end;

function Dialogs_TFileDialogFolderChangingEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogFolderChangingEvent = procedure (Sender: ...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogFolderChangingEvent_sw);
end;

function Dialogs_TFileDialogOverwriteEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogOverwriteEvent = procedure (Sender: TObje...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogOverwriteEvent_sw);
end;

function Dialogs_TFileDialogShareViolationEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileDialogShareViolationEvent = procedure (Sender: ...

  Result := TLMDUnitWrapper.TypeToVar(TFileDialogShareViolationEvent_sw);
end;

function Dialogs_TFileTypeItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileTypeItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TFileTypeItem_sw);
end;

function Dialogs_TFileTypeItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileTypeItems = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TFileTypeItems_sw);
end;

function Dialogs_TFavoriteLinkItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFavoriteLinkItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TFavoriteLinkItem_sw);
end;

function Dialogs_TFavoriteLinkItemsEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFavoriteLinkItemsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TFavoriteLinkItemsEnumerator_sw);
end;

function Dialogs_TFavoriteLinkItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFavoriteLinkItems = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TFavoriteLinkItems_sw);
end;

function Dialogs_TCustomFileDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFileDialog = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomFileDialog_sw);
end;

function Dialogs_TCustomFileOpenDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFileOpenDialog = class(TCustomFileDialog);

  Result := TLMDUnitWrapper.TypeToVar(TCustomFileOpenDialog_sw);
end;

function Dialogs_TFileOpenDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileOpenDialog = class(TCustomFileOpenDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFileOpenDialog_sw);
end;

function Dialogs_TCustomFileSaveDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFileSaveDialog = class(TCustomFileDialog);

  Result := TLMDUnitWrapper.TypeToVar(TCustomFileSaveDialog_sw);
end;

function Dialogs_TFileSaveDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileSaveDialog = class(TCustomFileSaveDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFileSaveDialog_sw);
end;

function Dialogs_tdiNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tdiNone = <value>;

  Result := tdiNone;
end;

function Dialogs_tdiWarning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tdiWarning = <value>;

  Result := tdiWarning;
end;

function Dialogs_tdiError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tdiError = <value>;

  Result := tdiError;
end;

function Dialogs_tdiInformation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tdiInformation = <value>;

  Result := tdiInformation;
end;

function Dialogs_tdiShield_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tdiShield = <value>;

  Result := tdiShield;
end;

function Dialogs_TTaskDialogFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogFlag = (tfEnableHyperlinks, tfUseHiconMai...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogFlag_sw);
end;

function Dialogs_TTaskDialogFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogFlags = set of TTaskDialogFlag;

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogFlags_sw);
end;

function Dialogs_TTaskDialogCommonButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogCommonButton = (tcbOk, tcbYes, tcbNo, tcb...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogCommonButton_sw);
end;

function Dialogs_TTaskDialogCommonButtons_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogCommonButtons = set of TTaskDialogCommonB...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogCommonButtons_sw);
end;

function Dialogs_TTaskDialogIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogIcon = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogIcon_sw);
end;

function Dialogs_TProgressBarState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressBarState = Vcl.ComCtrls.TProgressBarState;

  Result := TLMDUnitWrapper.TypeToVar(TProgressBarState_sw);
end;

function Dialogs_TTaskDialogProgressBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogProgressBar = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogProgressBar_sw);
end;

function Dialogs_TTaskDialogBaseButtonItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogBaseButtonItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogBaseButtonItem_sw);
end;

function Dialogs_TTaskDialogButtonItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogButtonItem = class(TTaskDialogBaseButtonI...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogButtonItem_sw);
end;

function Dialogs_TTaskDialogRadioButtonItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogRadioButtonItem = class(TTaskDialogBaseBu...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogRadioButtonItem_sw);
end;

function Dialogs_TTaskDialogButtonsEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogButtonsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogButtonsEnumerator_sw);
end;

function Dialogs_TTaskDialogButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialogButtons = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialogButtons_sw);
end;

function Dialogs_TTaskDlgClickEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDlgClickEvent = procedure (Sender: TObject; Mod...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDlgClickEvent_sw);
end;

function Dialogs_TTaskDlgTimerEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDlgTimerEvent = procedure (Sender: TObject; Tic...

  Result := TLMDUnitWrapper.TypeToVar(TTaskDlgTimerEvent_sw);
end;

function Dialogs_TCustomTaskDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomTaskDialog = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomTaskDialog_sw);
end;

function Dialogs_TTaskDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTaskDialog = class(TCustomTaskDialog);

  Result := TLMDUnitWrapper.TypeToVar(TTaskDialog_sw);
end;

function Dialogs_TMsgDlgType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgType = System.UITypes.TMsgDlgType;

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgType_sw);
end;

function Dialogs_TMsgDlgBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgBtn = System.UITypes.TMsgDlgBtn;

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgBtn_sw);
end;

function Dialogs_TMsgDlgButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgButtons = System.UITypes.TMsgDlgButtons;

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgButtons_sw);
end;

function Dialogs_mbYesNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesNo = <value>;

  Result := LMDSetToVar(SizeOf(mbYesNo), mbYesNo);
end;

function Dialogs_mbYesNoCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesNoCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbYesNoCancel), mbYesNoCancel);
end;

function Dialogs_mbYesAllNoAllCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesAllNoAllCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbYesAllNoAllCancel), mbYesAllNoAllCancel);
end;

function Dialogs_mbOKCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbOKCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbOKCancel), mbOKCancel);
end;

function Dialogs_mbAbortRetryIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAbortRetryIgnore = <value>;

  Result := LMDSetToVar(SizeOf(mbAbortRetryIgnore), mbAbortRetryIgnore);
end;

function Dialogs_mbAbortIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAbortIgnore = <value>;

  Result := LMDSetToVar(SizeOf(mbAbortIgnore), mbAbortIgnore);
end;

function Dialogs_CreateMessageDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CreateMessageDialog(...); overload;

  case AArgsSize of
    3:
    begin
      Result := TForm_sw.ToVar(Vcl.Dialogs.CreateMessageDialog(string(AArgs[0]),
        TMsgDlgType_sw.FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2])));
    end;
    4:
    begin
      Result := TForm_sw.ToVar(Vcl.Dialogs.CreateMessageDialog(string(AArgs[0]),
        TMsgDlgType_sw.FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]),
        TMsgDlgBtn_sw.FromVar(AArgs[3])));
    end;
  else
    WrongArgCountError('CreateMessageDialog');
  end;
end;

function Dialogs_MessageDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MessageDlg(...); overload;

  case AArgsSize of
    4:
    begin
      Result := Vcl.Dialogs.MessageDlg(string(AArgs[0]), TMsgDlgType_sw.FromVar(
        AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]));
    end;
    5:
    begin
      Result := Vcl.Dialogs.MessageDlg(string(AArgs[0]), TMsgDlgType_sw.FromVar(
        AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]),
        TMsgDlgBtn_sw.FromVar(AArgs[4]));
    end;
  else
    WrongArgCountError('MessageDlg');
  end;
end;

function Dialogs_MessageDlgPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MessageDlgPos(...); overload;

  case AArgsSize of
    6:
    begin
      Result := Vcl.Dialogs.MessageDlgPos(string(AArgs[0]), TMsgDlgType_sw.
        FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]),
        Integer(AArgs[4]), Integer(AArgs[5]));
    end;
    7:
    begin
      Result := Vcl.Dialogs.MessageDlgPos(string(AArgs[0]), TMsgDlgType_sw.
        FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]),
        Integer(AArgs[4]), Integer(AArgs[5]), TMsgDlgBtn_sw.FromVar(AArgs[6]));
    end;
  else
    WrongArgCountError('MessageDlgPos');
  end;
end;

function Dialogs_MessageDlgPosHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MessageDlgPosHelp(...); overload;

  case AArgsSize of
    7:
    begin
      Result := Vcl.Dialogs.MessageDlgPosHelp(string(AArgs[0]), TMsgDlgType_sw.
        FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]),
        Integer(AArgs[4]), Integer(AArgs[5]), string(AArgs[6]));
    end;
    8:
    begin
      Result := Vcl.Dialogs.MessageDlgPosHelp(string(AArgs[0]), TMsgDlgType_sw.
        FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]),
        Integer(AArgs[4]), Integer(AArgs[5]), string(AArgs[6]), TMsgDlgBtn_sw.
        FromVar(AArgs[7]));
    end;
  else
    WrongArgCountError('MessageDlgPosHelp');
  end;
end;

function Dialogs_TaskMessageDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TaskMessageDlg(...); overload;

  case AArgsSize of
    5:
    begin
      Result := Vcl.Dialogs.TaskMessageDlg(string(AArgs[0]), string(AArgs[1]), 
        TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(AArgs[3]),
        Longint(AArgs[4]));
    end;
    6:
    begin
      Result := Vcl.Dialogs.TaskMessageDlg(string(AArgs[0]), string(AArgs[1]), 
        TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(AArgs[3]),
        Longint(AArgs[4]), TMsgDlgBtn_sw.FromVar(AArgs[5]));
    end;
  else
    WrongArgCountError('TaskMessageDlg');
  end;
end;

function Dialogs_TaskMessageDlgPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TaskMessageDlgPos(...); overload;

  case AArgsSize of
    7:
    begin
      Result := Vcl.Dialogs.TaskMessageDlgPos(string(AArgs[0]), string(
        AArgs[1]), TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(
        AArgs[3]), Longint(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]));
    end;
    8:
    begin
      Result := Vcl.Dialogs.TaskMessageDlgPos(string(AArgs[0]), string(
        AArgs[1]), TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(
        AArgs[3]), Longint(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
        TMsgDlgBtn_sw.FromVar(AArgs[7]));
    end;
  else
    WrongArgCountError('TaskMessageDlgPos');
  end;
end;

function Dialogs_TaskMessageDlgPosHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TaskMessageDlgPosHelp(...); overload;

  case AArgsSize of
    8:
    begin
      Result := Vcl.Dialogs.TaskMessageDlgPosHelp(string(AArgs[0]), string(
        AArgs[1]), TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(
        AArgs[3]), Longint(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
        string(AArgs[7]));
    end;
    9:
    begin
      Result := Vcl.Dialogs.TaskMessageDlgPosHelp(string(AArgs[0]), string(
        AArgs[1]), TMsgDlgType_sw.FromVar(AArgs[2]), TMsgDlgButtons_sw.FromVar(
        AArgs[3]), Longint(AArgs[4]), Integer(AArgs[5]), Integer(AArgs[6]),
        string(AArgs[7]), TMsgDlgBtn_sw.FromVar(AArgs[8]));
    end;
  else
    WrongArgCountError('TaskMessageDlgPosHelp');
  end;
end;

function Dialogs_ShowMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowMessage(const Msg: string);

  Vcl.Dialogs.ShowMessage(string(AArgs[0]));
end;

function Dialogs_ShowMessagePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowMessagePos(const Msg: string; X: Integer; Y...

  Vcl.Dialogs.ShowMessagePos(string(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]));
end;

function Dialogs_InputBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InputBox(const ACaption: string; const APrompt: ...

  Result := Vcl.Dialogs.InputBox(string(AArgs[0]), string(AArgs[1]), string(
    AArgs[2]));
end;

function Dialogs_InputQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // procedure/function InputQuery(...); overload;

  v_1 := string(AArgs[2]);
  Result := Vcl.Dialogs.InputQuery(string(AArgs[0]), string(AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function Dialogs_PromptForFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function PromptForFileName(var AFileName: string; const A...

  case AArgsSize of
    1:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1);
      AssignRefParam(AArgs[0], v_1);
    end;
    2:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1, string(AArgs[1]));
      AssignRefParam(AArgs[0], v_1);
    end;
    3:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]));
      AssignRefParam(AArgs[0], v_1);
    end;
    4:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]));
      AssignRefParam(AArgs[0], v_1);
    end;
    5:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]), string(AArgs[4]));
      AssignRefParam(AArgs[0], v_1);
    end;
    6:
    begin
      v_1 := string(AArgs[0]);
      Result := Vcl.Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]), string(AArgs[4]), Boolean(AArgs[5]));
      AssignRefParam(AArgs[0], v_1);
    end;
  else
    WrongArgCountError('PromptForFileName');
  end;
end;

function Dialogs_ForceCurrentDirectory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ForceCurrentDirectory: Boolean;

  if IsGet then
    Result := Vcl.Dialogs.ForceCurrentDirectory
  else
    Vcl.Dialogs.ForceCurrentDirectory := Boolean(AArgs[0]);
end;

function Dialogs_UseLatestCommonDialogs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UseLatestCommonDialogs: Boolean;

  if IsGet then
    Result := Vcl.Dialogs.UseLatestCommonDialogs
  else
    Vcl.Dialogs.UseLatestCommonDialogs := Boolean(AArgs[0]);
end;

class function Dialogs_sw.GetUnitName: WideString;
begin
  Result := 'Dialogs';
end;

class procedure Dialogs_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('MaxCustomColors', Dialogs_MaxCustomColors_si, nil, VarType(Vcl.Dialogs.MaxCustomColors));
  AData.AddConstant('ofReadOnly', Dialogs_ofReadOnly_si, TOpenOption_sw);
  AData.AddConstant('ofOverwritePrompt', Dialogs_ofOverwritePrompt_si, TOpenOption_sw);
  AData.AddConstant('ofHideReadOnly', Dialogs_ofHideReadOnly_si, TOpenOption_sw);
  AData.AddConstant('ofNoChangeDir', Dialogs_ofNoChangeDir_si, TOpenOption_sw);
  AData.AddConstant('ofShowHelp', Dialogs_ofShowHelp_si, TOpenOption_sw);
  AData.AddConstant('ofNoValidate', Dialogs_ofNoValidate_si, TOpenOption_sw);
  AData.AddConstant('ofAllowMultiSelect', Dialogs_ofAllowMultiSelect_si, TOpenOption_sw);
  AData.AddConstant('ofExtensionDifferent', Dialogs_ofExtensionDifferent_si, TOpenOption_sw);
  AData.AddConstant('ofPathMustExist', Dialogs_ofPathMustExist_si, TOpenOption_sw);
  AData.AddConstant('ofFileMustExist', Dialogs_ofFileMustExist_si, TOpenOption_sw);
  AData.AddConstant('ofCreatePrompt', Dialogs_ofCreatePrompt_si, TOpenOption_sw);
  AData.AddConstant('ofShareAware', Dialogs_ofShareAware_si, TOpenOption_sw);
  AData.AddConstant('ofNoReadOnlyReturn', Dialogs_ofNoReadOnlyReturn_si, TOpenOption_sw);
  AData.AddConstant('ofNoTestFileCreate', Dialogs_ofNoTestFileCreate_si, TOpenOption_sw);
  AData.AddConstant('ofNoNetworkButton', Dialogs_ofNoNetworkButton_si, TOpenOption_sw);
  AData.AddConstant('ofNoLongNames', Dialogs_ofNoLongNames_si, TOpenOption_sw);
  AData.AddConstant('ofOldStyleDialog', Dialogs_ofOldStyleDialog_si, TOpenOption_sw);
  AData.AddConstant('ofNoDereferenceLinks', Dialogs_ofNoDereferenceLinks_si, TOpenOption_sw);
  AData.AddConstant('ofEnableIncludeNotify', Dialogs_ofEnableIncludeNotify_si, TOpenOption_sw);
  AData.AddConstant('ofEnableSizing', Dialogs_ofEnableSizing_si, TOpenOption_sw);
  AData.AddConstant('ofDontAddToRecent', Dialogs_ofDontAddToRecent_si, TOpenOption_sw);
  AData.AddConstant('ofForceShowHidden', Dialogs_ofForceShowHidden_si, TOpenOption_sw);
  AData.AddConstant('ofExNoPlacesBar', Dialogs_ofExNoPlacesBar_si, TOpenOptionEx_sw);
  AData.AddConstant('prAllPages', Dialogs_prAllPages_si, TPrintRange_sw);
  AData.AddConstant('prSelection', Dialogs_prSelection_si, TPrintRange_sw);
  AData.AddConstant('prPageNums', Dialogs_prPageNums_si, TPrintRange_sw);
  AData.AddConstant('poPrintToFile', Dialogs_poPrintToFile_si, TPrintDialogOption_sw);
  AData.AddConstant('poPageNums', Dialogs_poPageNums_si, TPrintDialogOption_sw);
  AData.AddConstant('poSelection', Dialogs_poSelection_si, TPrintDialogOption_sw);
  AData.AddConstant('poWarning', Dialogs_poWarning_si, TPrintDialogOption_sw);
  AData.AddConstant('poHelp', Dialogs_poHelp_si, TPrintDialogOption_sw);
  AData.AddConstant('poDisablePrintToFile', Dialogs_poDisablePrintToFile_si, TPrintDialogOption_sw);
  AData.AddConstant('psoDefaultMinMargins', Dialogs_psoDefaultMinMargins_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoDisableMargins', Dialogs_psoDisableMargins_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoDisableOrientation', Dialogs_psoDisableOrientation_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoDisablePagePainting', Dialogs_psoDisablePagePainting_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoDisablePaper', Dialogs_psoDisablePaper_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoDisablePrinter', Dialogs_psoDisablePrinter_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoMargins', Dialogs_psoMargins_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoMinMargins', Dialogs_psoMinMargins_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoShowHelp', Dialogs_psoShowHelp_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoWarning', Dialogs_psoWarning_si, TPageSetupDialogOption_sw);
  AData.AddConstant('psoNoNetworkButton', Dialogs_psoNoNetworkButton_si, TPageSetupDialogOption_sw);
  AData.AddConstant('pkDotMatrix', Dialogs_pkDotMatrix_si, TPrinterKind_sw);
  AData.AddConstant('pkHPPCL', Dialogs_pkHPPCL_si, TPrinterKind_sw);
  AData.AddConstant('ptEnvelope', Dialogs_ptEnvelope_si, TPageType_sw);
  AData.AddConstant('ptPaper', Dialogs_ptPaper_si, TPageType_sw);
  AData.AddConstant('pmDefault', Dialogs_pmDefault_si, TPageMeasureUnits_sw);
  AData.AddConstant('pmMillimeters', Dialogs_pmMillimeters_si, TPageMeasureUnits_sw);
  AData.AddConstant('pmInches', Dialogs_pmInches_si, TPageMeasureUnits_sw);
  AData.AddConstant('mtWarning', Dialogs_mtWarning_si, TMsgDlgType_sw);
  AData.AddConstant('mtError', Dialogs_mtError_si, TMsgDlgType_sw);
  AData.AddConstant('mtInformation', Dialogs_mtInformation_si, TMsgDlgType_sw);
  AData.AddConstant('mtConfirmation', Dialogs_mtConfirmation_si, TMsgDlgType_sw);
  AData.AddConstant('mtCustom', Dialogs_mtCustom_si, TMsgDlgType_sw);
  AData.AddConstant('mbYes', Dialogs_mbYes_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbNo', Dialogs_mbNo_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbOK', Dialogs_mbOK_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbCancel', Dialogs_mbCancel_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbAbort', Dialogs_mbAbort_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbRetry', Dialogs_mbRetry_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbIgnore', Dialogs_mbIgnore_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbAll', Dialogs_mbAll_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbNoToAll', Dialogs_mbNoToAll_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbYesToAll', Dialogs_mbYesToAll_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbHelp', Dialogs_mbHelp_si, TMsgDlgBtn_sw);
  AData.AddConstant('mbClose', Dialogs_mbClose_si, TMsgDlgBtn_sw);
  AData.AddType(TCommonDialog_sw, Dialogs_TCommonDialog_si);
  AData.AddType(TOpenOption_sw, Dialogs_TOpenOption_si);
  AData.AddType(TOpenOptions_sw, Dialogs_TOpenOptions_si);
  AData.AddType(TOpenOptionEx_sw, Dialogs_TOpenOptionEx_si);
  AData.AddType(TOpenOptionsEx_sw, Dialogs_TOpenOptionsEx_si);
  AData.AddType(TFileEditStyle_sw, Dialogs_TFileEditStyle_si);
  AData.AddType(TOFNotifyEx_sw, Dialogs_TOFNotifyEx_si);
  AData.AddType(TIncludeItemEvent_sw, Dialogs_TIncludeItemEvent_si);
  AData.AddType(TOpenDialog_sw, Dialogs_TOpenDialog_si);
  AData.AddType(TSaveDialog_sw, Dialogs_TSaveDialog_si);
  AData.AddType(TColorDialogOption_sw, Dialogs_TColorDialogOption_si);
  AData.AddType(TColorDialogOptions_sw, Dialogs_TColorDialogOptions_si);
  AData.AddType(TColorDialog_sw, Dialogs_TColorDialog_si);
  AData.AddType(TFontDialogOption_sw, Dialogs_TFontDialogOption_si);
  AData.AddType(TFontDialogOptions_sw, Dialogs_TFontDialogOptions_si);
  AData.AddType(TFontDialogDevice_sw, Dialogs_TFontDialogDevice_si);
  AData.AddType(TFDApplyEvent_sw, Dialogs_TFDApplyEvent_si);
  AData.AddType(TFontDialog_sw, Dialogs_TFontDialog_si);
  AData.AddType(TPrinterSetupDialog_sw, Dialogs_TPrinterSetupDialog_si);
  AData.AddType(TPrintRange_sw, Dialogs_TPrintRange_si);
  AData.AddType(TPrintDialogOption_sw, Dialogs_TPrintDialogOption_si);
  AData.AddType(TPrintDialogOptions_sw, Dialogs_TPrintDialogOptions_si);
  AData.AddType(TPrintDialog_sw, Dialogs_TPrintDialog_si);
  AData.AddType(TPrinterOrientation_sw, Dialogs_TPrinterOrientation_si);
  AData.AddType(TPageSetupDialogOption_sw, Dialogs_TPageSetupDialogOption_si);
  AData.AddType(TPageSetupDialogOptions_sw, Dialogs_TPageSetupDialogOptions_si);
  AData.AddType(TPrinterKind_sw, Dialogs_TPrinterKind_si);
  AData.AddType(TPageType_sw, Dialogs_TPageType_si);
  AData.AddType(TPageMeasureUnits_sw, Dialogs_TPageMeasureUnits_si);
  AData.AddType(TPageSetupBeforePaintEvent_sw, Dialogs_TPageSetupBeforePaintEvent_si);
  AData.AddType(TPaintPageEvent_sw, Dialogs_TPaintPageEvent_si);
  AData.AddType(TPageSetupDialog_sw, Dialogs_TPageSetupDialog_si);
  AData.AddType(TFindOption_sw, Dialogs_TFindOption_si);
  AData.AddType(TFindOptions_sw, Dialogs_TFindOptions_si);
  AData.AddType(TFindDialog_sw, Dialogs_TFindDialog_si);
  AData.AddType(TReplaceDialog_sw, Dialogs_TReplaceDialog_si);
  AData.AddType(EPlatformVersionException_sw, Dialogs_EPlatformVersionException_si);
  AData.AddType(TFileDialogOption_sw, Dialogs_TFileDialogOption_si);
  AData.AddType(TFileDialogOptions_sw, Dialogs_TFileDialogOptions_si);
  AData.AddType(TFileDialogOverwriteResponse_sw, Dialogs_TFileDialogOverwriteResponse_si);
  AData.AddType(TFileDialogShareViolationResponse_sw, Dialogs_TFileDialogShareViolationResponse_si);
  AData.AddType(TFileDialogCloseEvent_sw, Dialogs_TFileDialogCloseEvent_si);
  AData.AddType(TFileDialogFolderChangingEvent_sw, Dialogs_TFileDialogFolderChangingEvent_si);
  AData.AddType(TFileDialogOverwriteEvent_sw, Dialogs_TFileDialogOverwriteEvent_si);
  AData.AddType(TFileDialogShareViolationEvent_sw, Dialogs_TFileDialogShareViolationEvent_si);
  AData.AddType(TFileTypeItem_sw, Dialogs_TFileTypeItem_si);
  AData.AddType(TFileTypeItems_sw, Dialogs_TFileTypeItems_si);
  AData.AddType(TFavoriteLinkItem_sw, Dialogs_TFavoriteLinkItem_si);
  AData.AddType(TFavoriteLinkItemsEnumerator_sw, Dialogs_TFavoriteLinkItemsEnumerator_si);
  AData.AddType(TFavoriteLinkItems_sw, Dialogs_TFavoriteLinkItems_si);
  AData.AddType(TCustomFileDialog_sw, Dialogs_TCustomFileDialog_si);
  AData.AddType(TCustomFileOpenDialog_sw, Dialogs_TCustomFileOpenDialog_si);
  AData.AddType(TFileOpenDialog_sw, Dialogs_TFileOpenDialog_si);
  AData.AddType(TCustomFileSaveDialog_sw, Dialogs_TCustomFileSaveDialog_si);
  AData.AddType(TFileSaveDialog_sw, Dialogs_TFileSaveDialog_si);
  AData.AddConstant('tdiNone', Dialogs_tdiNone_si, nil, VarType(Vcl.Dialogs.tdiNone));
  AData.AddConstant('tdiWarning', Dialogs_tdiWarning_si, nil, VarType(Vcl.Dialogs.tdiWarning));
  AData.AddConstant('tdiError', Dialogs_tdiError_si, nil, VarType(Vcl.Dialogs.tdiError));
  AData.AddConstant('tdiInformation', Dialogs_tdiInformation_si, nil, VarType(Vcl.Dialogs.tdiInformation));
  AData.AddConstant('tdiShield', Dialogs_tdiShield_si, nil, VarType(Vcl.Dialogs.tdiShield));
  AData.AddType(TTaskDialogFlag_sw, Dialogs_TTaskDialogFlag_si);
  AData.AddType(TTaskDialogFlags_sw, Dialogs_TTaskDialogFlags_si);
  AData.AddType(TTaskDialogCommonButton_sw, Dialogs_TTaskDialogCommonButton_si);
  AData.AddType(TTaskDialogCommonButtons_sw, Dialogs_TTaskDialogCommonButtons_si);
  AData.AddType(TTaskDialogIcon_sw, Dialogs_TTaskDialogIcon_si);
  AData.AddType(TProgressBarState_sw, Dialogs_TProgressBarState_si);
  AData.AddType(TTaskDialogProgressBar_sw, Dialogs_TTaskDialogProgressBar_si);
  AData.AddType(TTaskDialogBaseButtonItem_sw, Dialogs_TTaskDialogBaseButtonItem_si);
  AData.AddType(TTaskDialogButtonItem_sw, Dialogs_TTaskDialogButtonItem_si);
  AData.AddType(TTaskDialogRadioButtonItem_sw, Dialogs_TTaskDialogRadioButtonItem_si);
  AData.AddType(TTaskDialogButtonsEnumerator_sw, Dialogs_TTaskDialogButtonsEnumerator_si);
  AData.AddType(TTaskDialogButtons_sw, Dialogs_TTaskDialogButtons_si);
  AData.AddType(TTaskDlgClickEvent_sw, Dialogs_TTaskDlgClickEvent_si);
  AData.AddType(TTaskDlgTimerEvent_sw, Dialogs_TTaskDlgTimerEvent_si);
  AData.AddType(TCustomTaskDialog_sw, Dialogs_TCustomTaskDialog_si);
  AData.AddType(TTaskDialog_sw, Dialogs_TTaskDialog_si);
  AData.AddType(TMsgDlgType_sw, Dialogs_TMsgDlgType_si);
  AData.AddType(TMsgDlgBtn_sw, Dialogs_TMsgDlgBtn_si);
  AData.AddType(TMsgDlgButtons_sw, Dialogs_TMsgDlgButtons_si);
  AData.AddConstant('mbYesNo', Dialogs_mbYesNo_si, nil, varInteger);
  AData.AddConstant('mbYesNoCancel', Dialogs_mbYesNoCancel_si, nil, varInteger);
  AData.AddConstant('mbYesAllNoAllCancel', Dialogs_mbYesAllNoAllCancel_si, nil, varInteger);
  AData.AddConstant('mbOKCancel', Dialogs_mbOKCancel_si, nil, varInteger);
  AData.AddConstant('mbAbortRetryIgnore', Dialogs_mbAbortRetryIgnore_si, nil, varInteger);
  AData.AddConstant('mbAbortIgnore', Dialogs_mbAbortIgnore_si, nil, varInteger);
  AData.AddFunction('CreateMessageDialog', Dialogs_CreateMessageDialog_si, nil, 3, True);
  AData.AddFunction('MessageDlg', Dialogs_MessageDlg_si, nil, 4, True);
  AData.AddFunction('MessageDlgPos', Dialogs_MessageDlgPos_si, nil, 6, True);
  AData.AddFunction('MessageDlgPosHelp', Dialogs_MessageDlgPosHelp_si, nil, 7, True);
  AData.AddFunction('TaskMessageDlg', Dialogs_TaskMessageDlg_si, nil, 5, True);
  AData.AddFunction('TaskMessageDlgPos', Dialogs_TaskMessageDlgPos_si, nil, 7, True);
  AData.AddFunction('TaskMessageDlgPosHelp', Dialogs_TaskMessageDlgPosHelp_si, nil, 8, True);
  AData.AddProcedure('ShowMessage', Dialogs_ShowMessage_si, 1, False);
  AData.AddProcedure('ShowMessagePos', Dialogs_ShowMessagePos_si, 3, False);
  AData.AddFunction('InputBox', Dialogs_InputBox_si, string_sw, 3, False);
  AData.AddFunction('InputQuery', Dialogs_InputQuery_si, nil, 3, False);
  AData.AddFunction('PromptForFileName', Dialogs_PromptForFileName_si, Boolean_sw, 1, True);
  AData.AddVariable('ForceCurrentDirectory', Dialogs_ForceCurrentDirectory_si, Boolean_sw);
  AData.AddVariable('UseLatestCommonDialogs', Dialogs_UseLatestCommonDialogs_si, Boolean_sw);
end;

class function Dialogs_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Dialogs_sw);
end;

initialization
  RegisterUnitWrapper(Dialogs_sw);
  RegisterClassWrapper(TCommonDialog_sw);
  RegisterClassWrapper(TOpenDialog_sw);
  RegisterClassWrapper(TSaveDialog_sw);
  RegisterClassWrapper(TColorDialog_sw);
  RegisterClassWrapper(TFontDialog_sw);
  RegisterClassWrapper(TPrinterSetupDialog_sw);
  RegisterClassWrapper(TPrintDialog_sw);
  RegisterClassWrapper(TPageSetupDialog_sw);
  RegisterClassWrapper(TFindDialog_sw);
  RegisterClassWrapper(TReplaceDialog_sw);
  RegisterClassWrapper(EPlatformVersionException_sw);
  RegisterClassWrapper(TFileTypeItem_sw);
  RegisterClassWrapper(TFileTypeItems_sw);
  RegisterClassWrapper(TFavoriteLinkItem_sw);
  RegisterClassWrapper(TFavoriteLinkItemsEnumerator_sw);
  RegisterClassWrapper(TFavoriteLinkItems_sw);
  RegisterClassWrapper(TCustomFileDialog_sw);
  RegisterClassWrapper(TCustomFileOpenDialog_sw);
  RegisterClassWrapper(TFileOpenDialog_sw);
  RegisterClassWrapper(TCustomFileSaveDialog_sw);
  RegisterClassWrapper(TFileSaveDialog_sw);
  RegisterClassWrapper(TTaskDialogProgressBar_sw);
  RegisterClassWrapper(TTaskDialogBaseButtonItem_sw);
  RegisterClassWrapper(TTaskDialogButtonItem_sw);
  RegisterClassWrapper(TTaskDialogRadioButtonItem_sw);
  RegisterClassWrapper(TTaskDialogButtonsEnumerator_sw);
  RegisterClassWrapper(TTaskDialogButtons_sw);
  RegisterClassWrapper(TCustomTaskDialog_sw);
  RegisterClassWrapper(TTaskDialog_sw);
  RegisterEventWrapper(TypeInfo(TIncludeItemEvent), TIncludeItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TFDApplyEvent), TFDApplyEvent_sw);
  RegisterEventWrapper(TypeInfo(TPageSetupBeforePaintEvent), TPageSetupBeforePaintEvent_sw);
  RegisterEventWrapper(TypeInfo(TPaintPageEvent), TPaintPageEvent_sw);
  RegisterEventWrapper(TypeInfo(TFileDialogCloseEvent), TFileDialogCloseEvent_sw);
  RegisterEventWrapper(TypeInfo(TFileDialogFolderChangingEvent), TFileDialogFolderChangingEvent_sw);
  RegisterEventWrapper(TypeInfo(TFileDialogOverwriteEvent), TFileDialogOverwriteEvent_sw);
  RegisterEventWrapper(TypeInfo(TFileDialogShareViolationEvent), TFileDialogShareViolationEvent_sw);
  RegisterEventWrapper(TypeInfo(TTaskDlgClickEvent), TTaskDlgClickEvent_sw);
  RegisterEventWrapper(TypeInfo(TTaskDlgTimerEvent), TTaskDlgTimerEvent_sw);

end.
