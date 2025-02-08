unit Vcl.ComCtrls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.ComCtrls' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Messages, Winapi.Windows,
  System.SysUtils, Winapi.CommCtrl, Vcl.Forms, Vcl.Controls, Vcl.Menus,
  Vcl.Graphics, Vcl.StdCtrls, Winapi.RichEdit, Vcl.ToolWin, Vcl.ImgList,
  System.Classes, Vcl.ExtCtrls, Vcl.ListActns, Winapi.ShlObj, Vcl.GraphUtil,
  System.UITypes, Vcl.ComCtrls, Winapi.Messages_LMDSW, Winapi.Windows_LMDSW,
  System.SysUtils_LMDSW, Winapi.CommCtrl_LMDSW, Vcl.Forms_LMDSW,
  Vcl.Controls_LMDSW, Vcl.Menus_LMDSW, Vcl.Graphics_LMDSW, Vcl.StdCtrls_LMDSW,
  Winapi.RichEdit_LMDSW, Vcl.ToolWin_LMDSW, Vcl.ImgList_LMDSW,
  System.Classes_LMDSW, Vcl.ExtCtrls_LMDSW, Vcl.ListActns_LMDSW,
  Winapi.ShlObj_LMDSW, Vcl.GraphUtil_LMDSW, System.UITypes_LMDSW;


{ Type wrappers }

type
  TCustomTabControl_sw = class;
  TTabControl_sw = class;
  TTabSheet_sw = class;
  TPageControl_sw = class;
  TStatusPanelClass_sw = class;
  TStatusPanel_sw = class;
  TStatusPanels_sw = class;
  TCustomStatusBar_sw = class;
  TStatusBar_sw = class;
  THeaderSectionClass_sw = class;
  THeaderSection_sw = class;
  THeaderSections_sw = class;
  TCustomHeaderControl_sw = class;
  THeaderControl_sw = class;
  TTreeNodeClass_sw = class;
  TTreeNode_sw = class;
  TTreeNodesEnumerator_sw = class;
  TTreeNodes_sw = class;
  ETreeViewError_sw = class;
  TCustomTreeView_sw = class;
  TTreeView_sw = class;
  TTrackBar_sw = class;
  TProgressBar_sw = class;
  TTextAttributes_sw = class;
  TParaAttributes_sw = class;
  TConversion_sw = class;
  TConversionClass_sw = class;
  TCustomRichEdit_sw = class;
  TRichEdit_sw = class;
  TCustomUpDown_sw = class;
  TUpDown_sw = class;
  TCustomHotKey_sw = class;
  THotKey_sw = class;
  TListGroup_sw = class;
  TListGroups_sw = class;
  TListColumn_sw = class;
  TListColumns_sw = class;
  TListItemClass_sw = class;
  TListItem_sw = class;
  TListItemsEnumerator_sw = class;
  TListItems_sw = class;
  TWorkArea_sw = class;
  TWorkAreas_sw = class;
  TIconOptions_sw = class;
  TCustomListView_sw = class;
  TListView_sw = class;
  TListViewActionLink_sw = class;
  TAnimate_sw = class;
  TToolButtonActionLink_sw = class;
  TToolButtonActionLinkClass_sw = class;
  TToolButton_sw = class;
  TToolBarEnumerator_sw = class;
  TToolBar_sw = class;
  TToolBarDockObject_sw = class;
  TCoolBand_sw = class;
  TCoolBands_sw = class;
  TCoolBar_sw = class;
  ECommonCalendarError_sw = class;
  TMonthCalColors_sw = class;
  TCommonCalendar_sw = class;
  EMonthCalError_sw = class;
  TMonthCalendar_sw = class;
  EDateTimeError_sw = class;
  TDateTimePicker_sw = class;
  TPageScroller_sw = class;
  TComboExItem_sw = class;
  TComboExItems_sw = class;
  TComboExItemsClass_sw = class;
  TComboExItemClass_sw = class;
  TComboBoxExStrings_sw = class;
  TComboBoxExStringsClass_sw = class;
  TCustomComboBoxEx_sw = class;
  TComboBoxEx_sw = class;
  TComboBoxExActionLink_sw = class;

  THitTest_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: THitTest): OleVariant;
    class function FromVar(const AValue: OleVariant): THitTest;
  end;

  THitTests_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: THitTests): OleVariant;
    class function FromVar(const AValue: OleVariant): THitTests;
  end;

  TTabChangingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var AllowChange: Boolean);
  end;

  TTabChangingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTabChangingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabChangingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTabChangingEvent;
  end;

  TTabPosition_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTabPosition): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabPosition;
  end;

  TTabStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTabStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabStyle;
  end;

  TDrawTabEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
  end;

  TDrawTabEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDrawTabEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDrawTabEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDrawTabEvent;
  end;

  TTabGetImageEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
  end;

  TTabGetImageEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTabGetImageEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabGetImageEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTabGetImageEvent;
  end;

  TCustomTabControl_sc = class of TCustomTabControl;
  TCustomTabControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomTabControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomTabControl;
    class function ClassToVar(AClass: TCustomTabControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomTabControl_sc;
  end;

  TTabControl_sc = class of TTabControl;
  TTabControl_sw = class(TCustomTabControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTabControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabControl;
    class function ClassToVar(AClass: TTabControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTabControl_sc;
  end;

  TTabSheet_sc = class of TTabSheet;
  TTabSheet_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTabSheet): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabSheet;
    class function ClassToVar(AClass: TTabSheet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTabSheet_sc;
  end;

  TPageControl_sc = class of TPageControl;
  TPageControl_sw = class(TCustomTabControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPageControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageControl;
    class function ClassToVar(AClass: TPageControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPageControl_sc;
  end;

  TStatusPanelStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStatusPanelStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusPanelStyle;
  end;

  TStatusPanelBevel_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStatusPanelBevel): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusPanelBevel;
  end;

  TStatusPanelClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TStatusPanelClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusPanelClass;
  end;

  TStatusPanel_sc = class of TStatusPanel;
  TStatusPanel_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStatusPanel): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusPanel;
    class function ClassToVar(AClass: TStatusPanel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStatusPanel_sc;
  end;

  TStatusPanels_sc = class of TStatusPanels;
  TStatusPanels_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStatusPanels): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusPanels;
    class function ClassToVar(AClass: TStatusPanels_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStatusPanels_sc;
  end;

  TCustomDrawPanelEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(StatusBar: TCustomStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  end;

  TCustomDrawPanelEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCustomDrawPanelEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDrawPanelEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCustomDrawPanelEvent;
  end;

  TSBCreatePanelClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomStatusBar;
      var PanelClass: TStatusPanelClass);
  end;

  TSBCreatePanelClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSBCreatePanelClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSBCreatePanelClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSBCreatePanelClassEvent;
  end;

  TCustomStatusBar_sc = class of TCustomStatusBar;
  TCustomStatusBar_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomStatusBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomStatusBar;
    class function ClassToVar(AClass: TCustomStatusBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomStatusBar_sc;
  end;

  TDrawPanelEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  end;

  TDrawPanelEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDrawPanelEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDrawPanelEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDrawPanelEvent;
  end;

  TStatusBar_sc = class of TStatusBar;
  TStatusBar_sw = class(TCustomStatusBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStatusBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TStatusBar;
    class function ClassToVar(AClass: TStatusBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStatusBar_sc;
  end;

  TCustomDrawTarget_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCustomDrawTarget): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDrawTarget;
  end;

  TCustomDrawStage_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCustomDrawStage): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDrawStage;
  end;

  THeaderSectionStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: THeaderSectionStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderSectionStyle;
  end;

  THeaderSectionClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: THeaderSectionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderSectionClass;
  end;

  THeaderSection_sc = class of THeaderSection;
  THeaderSection_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THeaderSection): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderSection;
    class function ClassToVar(AClass: THeaderSection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THeaderSection_sc;
  end;

  THeaderSections_sc = class of THeaderSections;
  THeaderSections_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THeaderSections): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderSections;
    class function ClassToVar(AClass: THeaderSections_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THeaderSections_sc;
  end;

  TSectionTrackState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSectionTrackState): OleVariant;
    class function FromVar(const AValue: OleVariant): TSectionTrackState;
  end;

  TCustomDrawSectionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: TCustomHeaderControl;
      Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
  end;

  TCustomDrawSectionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCustomDrawSectionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDrawSectionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCustomDrawSectionEvent;
  end;

  TCustomSectionNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: TCustomHeaderControl;
      Section: THeaderSection);
  end;

  TCustomSectionNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCustomSectionNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomSectionNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCustomSectionNotifyEvent;
  end;

  TCustomSectionTrackEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: TCustomHeaderControl;
      Section: THeaderSection; Width: Integer; State: TSectionTrackState);
  end;

  TCustomSectionTrackEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCustomSectionTrackEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomSectionTrackEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCustomSectionTrackEvent;
  end;

  TSectionDragEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; FromSection: THeaderSection;
      ToSection: THeaderSection; var AllowDrag: Boolean);
  end;

  TSectionDragEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSectionDragEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSectionDragEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSectionDragEvent;
  end;

  TCustomHCCreateSectionClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomHeaderControl;
      var SectionClass: THeaderSectionClass);
  end;

  TCustomHCCreateSectionClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCustomHCCreateSectionClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHCCreateSectionClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCustomHCCreateSectionClassEvent;
  end;

  THeaderStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: THeaderStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderStyle;
  end;

  TCustomHeaderControl_sc = class of TCustomHeaderControl;
  TCustomHeaderControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomHeaderControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHeaderControl;
    class function ClassToVar(AClass: TCustomHeaderControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomHeaderControl_sc;
  end;

  TDrawSectionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: THeaderControl; Section: THeaderSection;
      const Rect: TRect; Pressed: Boolean);
  end;

  TDrawSectionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDrawSectionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDrawSectionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDrawSectionEvent;
  end;

  TSectionNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: THeaderControl; Section: THeaderSection);
  end;

  TSectionNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSectionNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSectionNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSectionNotifyEvent;
  end;

  TSectionTrackEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(HeaderControl: THeaderControl; Section: THeaderSection;
      Width: Integer; State: TSectionTrackState);
  end;

  TSectionTrackEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSectionTrackEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSectionTrackEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSectionTrackEvent;
  end;

  THCCreateSectionClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: THeaderControl;
      var SectionClass: THeaderSectionClass);
  end;

  THCCreateSectionClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: THCCreateSectionClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): THCCreateSectionClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): THCCreateSectionClassEvent;
  end;

  THeaderControl_sc = class of THeaderControl;
  THeaderControl_sw = class(TCustomHeaderControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THeaderControl): OleVariant;
    class function FromVar(const AValue: OleVariant): THeaderControl;
    class function ClassToVar(AClass: THeaderControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THeaderControl_sc;
  end;

  TNodeState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNodeState): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeState;
  end;

  TNodeAttachMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNodeAttachMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeAttachMode;
  end;

  TAddMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAddMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TAddMode;
  end;

  TNodeInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeInfo;
  end;

  TNodeDataInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeDataInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeDataInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataInfo;
  end;

  TNodeDataInfoX86_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeDataInfoX86;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeDataInfoX86): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataInfoX86;
  end;

  TNodeDataInfo2_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeDataInfo2;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeDataInfo2): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataInfo2;
  end;

  TNodeDataInfo2x86_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeDataInfo2x86;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeDataInfo2x86): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataInfo2x86;
  end;

  TNodeDataInfo2x64_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeDataInfo2x64;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeDataInfo2x64): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataInfo2x64;
  end;

  TNodeDataType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNodeDataType): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeDataType;
  end;

  TTVItemStateEx_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTVItemStateEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVItemStateEx;
  end;

  TTVItemStateExSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTVItemStateExSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVItemStateExSet;
  end;

  TTreeNodeClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TTreeNodeClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TTreeNodeClass;
  end;

  TTreeNode_sc = class of TTreeNode;
  TTreeNode_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTreeNode): OleVariant;
    class function FromVar(const AValue: OleVariant): TTreeNode;
    class function ClassToVar(AClass: TTreeNode_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTreeNode_sc;
  end;

  TTreeNodesEnumerator_sc = class of TTreeNodesEnumerator;
  TTreeNodesEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTreeNodesEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TTreeNodesEnumerator;
    class function ClassToVar(AClass: TTreeNodesEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTreeNodesEnumerator_sc;
  end;

  TNodeCache_sw = class(TLMDRecordWrapper)
  private
    FValue: TNodeCache;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TNodeCache): OleVariant;
    class function FromVar(const AValue: OleVariant): TNodeCache;
  end;

  TTreeNodes_sc = class of TTreeNodes;
  TTreeNodes_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTreeNodes): OleVariant;
    class function FromVar(const AValue: OleVariant): TTreeNodes;
    class function ClassToVar(AClass: TTreeNodes_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTreeNodes_sc;
  end;

  TSortType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSortType): OleVariant;
    class function FromVar(const AValue: OleVariant): TSortType;
  end;

  TMultiSelectStyles_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMultiSelectStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TMultiSelectStyles;
  end;

  TMultiSelectStyle_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TMultiSelectStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TMultiSelectStyle;
  end;

  ETreeViewError_sc = class of ETreeViewError;
  ETreeViewError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ETreeViewError): OleVariant;
    class function FromVar(const AValue: OleVariant): ETreeViewError;
    class function ClassToVar(AClass: ETreeViewError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ETreeViewError_sc;
  end;

  TTVChangingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
  end;

  TTVChangingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVChangingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVChangingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVChangingEvent;
  end;

  TTVChangedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode);
  end;

  TTVChangedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVChangedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVChangedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVChangedEvent;
  end;

  TTVEditingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
  end;

  TTVEditingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVEditingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVEditingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVEditingEvent;
  end;

  TTVEditedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode; var S: string);
  end;

  TTVEditedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVEditedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVEditedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVEditedEvent;
  end;

  TTVExpandingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
  end;

  TTVExpandingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVExpandingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVExpandingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVExpandingEvent;
  end;

  TTVCollapsingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
  end;

  TTVCollapsingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVCollapsingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVCollapsingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVCollapsingEvent;
  end;

  TTVExpandedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node: TTreeNode);
  end;

  TTVExpandedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVExpandedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVExpandedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVExpandedEvent;
  end;

  TTVCompareEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Node1: TTreeNode; Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
  end;

  TTVCompareEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVCompareEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVCompareEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVCompareEvent;
  end;

  TTVHintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const Node: TTreeNode; var Hint: string);
  end;

  TTVHintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVHintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVHintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVHintEvent;
  end;

  TTVCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomTreeView; const ARect: TRect;
      var DefaultDraw: Boolean);
  end;

  TTVCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVCustomDrawEvent;
  end;

  TTVAdvancedCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomTreeView; const ARect: TRect;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  end;

  TTVAdvancedCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVAdvancedCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVAdvancedCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVAdvancedCustomDrawEvent;
  end;

  TTVCreateNodeClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
  end;

  TTVCreateNodeClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTVCreateNodeClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTVCreateNodeClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTVCreateNodeClassEvent;
  end;

  TCustomTreeView_sc = class of TCustomTreeView;
  TCustomTreeView_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomTreeView): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomTreeView;
    class function ClassToVar(AClass: TCustomTreeView_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomTreeView_sc;
  end;

  TTreeView_sc = class of TTreeView;
  TTreeView_sw = class(TCustomTreeView_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTreeView): OleVariant;
    class function FromVar(const AValue: OleVariant): TTreeView;
    class function ClassToVar(AClass: TTreeView_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTreeView_sc;
  end;

  TTrackBarOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTrackBarOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TTrackBarOrientation;
  end;

  TTickMark_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTickMark): OleVariant;
    class function FromVar(const AValue: OleVariant): TTickMark;
  end;

  TTickStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTickStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TTickStyle;
  end;

  TPositionToolTip_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPositionToolTip): OleVariant;
    class function FromVar(const AValue: OleVariant): TPositionToolTip;
  end;

  TTrackBar_sc = class of TTrackBar;
  TTrackBar_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTrackBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TTrackBar;
    class function ClassToVar(AClass: TTrackBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTrackBar_sc;
  end;

  TProgressRange_sw = Integer_sw;

  TProgressBarOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TProgressBarOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressBarOrientation;
  end;

  TProgressBarStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TProgressBarStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressBarStyle;
  end;

  TProgressBarState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TProgressBarState): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressBarState;
  end;

  TProgressBar_sc = class of TProgressBar;
  TProgressBar_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TProgressBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TProgressBar;
    class function ClassToVar(AClass: TProgressBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TProgressBar_sc;
  end;

  TAttributeType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAttributeType): OleVariant;
    class function FromVar(const AValue: OleVariant): TAttributeType;
  end;

  TConsistentAttribute_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TConsistentAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TConsistentAttribute;
  end;

  TConsistentAttributes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TConsistentAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TConsistentAttributes;
  end;

  TTextAttributes_sc = class of TTextAttributes;
  TTextAttributes_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTextAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextAttributes;
    class function ClassToVar(AClass: TTextAttributes_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTextAttributes_sc;
  end;

  TNumberingStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNumberingStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TNumberingStyle;
  end;

  TParaAttributes_sc = class of TParaAttributes;
  TParaAttributes_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParaAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TParaAttributes;
    class function ClassToVar(AClass: TParaAttributes_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParaAttributes_sc;
  end;

  TRichEditResizeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Rect: TRect);
  end;

  TRichEditResizeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRichEditResizeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TRichEditResizeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TRichEditResizeEvent;
  end;

  TRichEditProtectChange_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; StartPos: Integer; EndPos: Integer;
      var AllowChange: Boolean);
  end;

  TRichEditProtectChange_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRichEditProtectChange): OleVariant;
    class function FromVar(const AValue: OleVariant): TRichEditProtectChange;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TRichEditProtectChange;
  end;

  TRichEditSaveClipboard_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; NumObjects: Integer; NumChars: Integer;
      var SaveClipboard: Boolean);
  end;

  TRichEditSaveClipboard_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRichEditSaveClipboard): OleVariant;
    class function FromVar(const AValue: OleVariant): TRichEditSaveClipboard;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TRichEditSaveClipboard;
  end;

  TSearchType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSearchType): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchType;
  end;

  TSearchTypes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TSearchTypes): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchTypes;
  end;

  TConversion_sc = class of TConversion;
  TConversion_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TConversion): OleVariant;
    class function FromVar(const AValue: OleVariant): TConversion;
    class function ClassToVar(AClass: TConversion_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TConversion_sc;
  end;

  TConversionClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TConversionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TConversionClass;
  end;

  TConversionFormat_sw = class(TLMDRecordWrapper)
  private
    FValue: TConversionFormat;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TConversionFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TConversionFormat;
  end;

  TRichEditStreamInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TRichEditStreamInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TRichEditStreamInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TRichEditStreamInfo;
  end;

  TCustomRichEdit_sc = class of TCustomRichEdit;
  TCustomRichEdit_sw = class(TCustomMemo_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomRichEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomRichEdit;
    class function ClassToVar(AClass: TCustomRichEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomRichEdit_sc;
  end;

  TRichEdit_sc = class of TRichEdit;
  TRichEdit_sw = class(TCustomRichEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TRichEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TRichEdit;
    class function ClassToVar(AClass: TRichEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TRichEdit_sc;
  end;

  TUDAlignButton_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUDAlignButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDAlignButton;
  end;

  TUDOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUDOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDOrientation;
  end;

  TUDBtnType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUDBtnType): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDBtnType;
  end;

  TUpDownDirection_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUpDownDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpDownDirection;
  end;

  TUDClickEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Button: TUDBtnType);
  end;

  TUDClickEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUDClickEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDClickEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUDClickEvent;
  end;

  TUDChangingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var AllowChange: Boolean);
  end;

  TUDChangingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUDChangingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDChangingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUDChangingEvent;
  end;

  TUDChangingEventEx_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
  end;

  TUDChangingEventEx_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUDChangingEventEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TUDChangingEventEx;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUDChangingEventEx;
  end;

  TCustomUpDown_sc = class of TCustomUpDown;
  TCustomUpDown_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomUpDown): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomUpDown;
    class function ClassToVar(AClass: TCustomUpDown_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomUpDown_sc;
  end;

  TUpDown_sc = class of TUpDown;
  TUpDown_sw = class(TCustomUpDown_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TUpDown): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpDown;
    class function ClassToVar(AClass: TUpDown_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TUpDown_sc;
  end;

  THKModifier_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: THKModifier): OleVariant;
    class function FromVar(const AValue: OleVariant): THKModifier;
  end;

  THKModifiers_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: THKModifiers): OleVariant;
    class function FromVar(const AValue: OleVariant): THKModifiers;
  end;

  THKInvalidKey_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: THKInvalidKey): OleVariant;
    class function FromVar(const AValue: OleVariant): THKInvalidKey;
  end;

  THKInvalidKeys_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: THKInvalidKeys): OleVariant;
    class function FromVar(const AValue: OleVariant): THKInvalidKeys;
  end;

  TCustomHotKey_sc = class of TCustomHotKey;
  TCustomHotKey_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomHotKey): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHotKey;
    class function ClassToVar(AClass: TCustomHotKey_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomHotKey_sc;
  end;

  THotKey_sc = class of THotKey;
  THotKey_sw = class(TCustomHotKey_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THotKey): OleVariant;
    class function FromVar(const AValue: OleVariant): THotKey;
    class function ClassToVar(AClass: THotKey_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THotKey_sc;
  end;

  TWidth_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWidth): OleVariant;
    class function FromVar(const AValue: OleVariant): TWidth;
  end;

  TListGroupState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListGroupState): OleVariant;
    class function FromVar(const AValue: OleVariant): TListGroupState;
  end;

  TListGroupStateSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TListGroupStateSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TListGroupStateSet;
  end;

  TListGroup_sc = class of TListGroup;
  TListGroup_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListGroup): OleVariant;
    class function FromVar(const AValue: OleVariant): TListGroup;
    class function ClassToVar(AClass: TListGroup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListGroup_sc;
  end;

  TListGroups_sc = class of TListGroups;
  TListGroups_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListGroups): OleVariant;
    class function FromVar(const AValue: OleVariant): TListGroups;
    class function ClassToVar(AClass: TListGroups_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListGroups_sc;
  end;

  TListColumn_sc = class of TListColumn;
  TListColumn_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListColumn): OleVariant;
    class function FromVar(const AValue: OleVariant): TListColumn;
    class function ClassToVar(AClass: TListColumn_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListColumn_sc;
  end;

  TListColumns_sc = class of TListColumns;
  TListColumns_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListColumns): OleVariant;
    class function FromVar(const AValue: OleVariant): TListColumns;
    class function ClassToVar(AClass: TListColumns_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListColumns_sc;
  end;

  TDisplayCode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDisplayCode): OleVariant;
    class function FromVar(const AValue: OleVariant): TDisplayCode;
  end;

  TListItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TListItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TListItemClass;
  end;

  TListItem_sc = class of TListItem;
  TListItem_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TListItem;
    class function ClassToVar(AClass: TListItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListItem_sc;
  end;

  TListItemsEnumerator_sc = class of TListItemsEnumerator;
  TListItemsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListItemsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TListItemsEnumerator;
    class function ClassToVar(AClass: TListItemsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListItemsEnumerator_sc;
  end;

  TListItems_sc = class of TListItems;
  TListItems_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TListItems;
    class function ClassToVar(AClass: TListItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListItems_sc;
  end;

  TWorkArea_sc = class of TWorkArea;
  TWorkArea_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWorkArea): OleVariant;
    class function FromVar(const AValue: OleVariant): TWorkArea;
    class function ClassToVar(AClass: TWorkArea_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWorkArea_sc;
  end;

  TWorkAreas_sc = class of TWorkAreas;
  TWorkAreas_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWorkAreas): OleVariant;
    class function FromVar(const AValue: OleVariant): TWorkAreas;
    class function ClassToVar(AClass: TWorkAreas_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWorkAreas_sc;
  end;

  TIconArrangement_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TIconArrangement): OleVariant;
    class function FromVar(const AValue: OleVariant): TIconArrangement;
  end;

  TIconOptions_sc = class of TIconOptions;
  TIconOptions_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIconOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TIconOptions;
    class function ClassToVar(AClass: TIconOptions_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIconOptions_sc;
  end;

  TListArrangement_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListArrangement): OleVariant;
    class function FromVar(const AValue: OleVariant): TListArrangement;
  end;

  TViewStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TViewStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TViewStyle;
  end;

  TItemState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TItemState): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemState;
  end;

  TItemStates_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TItemStates): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemStates;
  end;

  TItemChange_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TItemChange): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemChange;
  end;

  TItemFind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TItemFind): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemFind;
  end;

  TSearchDirection_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSearchDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchDirection;
  end;

  TListHotTrackStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListHotTrackStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TListHotTrackStyle;
  end;

  TListHotTrackStyles_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TListHotTrackStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TListHotTrackStyles;
  end;

  TItemRequests_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TItemRequests): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemRequests;
  end;

  TItemRequest_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TItemRequest): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemRequest;
  end;

  TLVDeletedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem);
  end;

  TLVDeletedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVDeletedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVDeletedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVDeletedEvent;
  end;

  TLVEditingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
  end;

  TLVEditingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVEditingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVEditingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVEditingEvent;
  end;

  TLVEditedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; var S: string);
  end;

  TLVEditedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVEditedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVEditedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVEditedEvent;
  end;

  TLVChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; Change: TItemChange);
  end;

  TLVChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVChangeEvent;
  end;

  TLVChangingEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; Change: TItemChange;
      var AllowChange: Boolean);
  end;

  TLVChangingEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVChangingEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVChangingEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVChangingEvent;
  end;

  TLVColumnClickEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Column: TListColumn);
  end;

  TLVColumnClickEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVColumnClickEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVColumnClickEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVColumnClickEvent;
  end;

  TLVColumnRClickEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Column: TListColumn; Point: TPoint);
  end;

  TLVColumnRClickEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVColumnRClickEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVColumnRClickEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVColumnRClickEvent;
  end;

  TLVCompareEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item1: TListItem; Item2: TListItem;
      Data: Integer; var Compare: Integer);
  end;

  TLVCompareEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVCompareEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVCompareEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVCompareEvent;
  end;

  TLVNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem);
  end;

  TLVNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVNotifyEvent;
  end;

  TLVSelectItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; Selected: Boolean);
  end;

  TLVSelectItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVSelectItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVSelectItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVSelectItemEvent;
  end;

  TLVCheckedItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem);
  end;

  TLVCheckedItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVCheckedItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVCheckedItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVCheckedItemEvent;
  end;

  TLVCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListView; const ARect: TRect;
      var DefaultDraw: Boolean);
  end;

  TLVCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVCustomDrawEvent;
  end;

  TLVAdvancedCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListView; const ARect: TRect;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  end;

  TLVAdvancedCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVAdvancedCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVAdvancedCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVAdvancedCustomDrawEvent;
  end;

  TLVOwnerDataEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem);
  end;

  TLVOwnerDataEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVOwnerDataEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVOwnerDataEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVOwnerDataEvent;
  end;

  TLVOwnerDataHintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; StartIndex: Integer; EndIndex: Integer);
  end;

  TLVOwnerDataHintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVOwnerDataHintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVOwnerDataHintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVOwnerDataHintEvent;
  end;

  TLVOwnerDataStateChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; StartIndex: Integer; EndIndex: Integer;
      OldState: TItemStates; NewState: TItemStates);
  end;

  TLVOwnerDataStateChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVOwnerDataStateChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVOwnerDataStateChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVOwnerDataStateChangeEvent;
  end;

  TLVSubItemImageEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; SubItem: Integer;
      var ImageIndex: Integer);
  end;

  TLVSubItemImageEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVSubItemImageEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVSubItemImageEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVSubItemImageEvent;
  end;

  TLVInfoTipEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Item: TListItem; var InfoTip: string);
  end;

  TLVInfoTipEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVInfoTipEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVInfoTipEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVInfoTipEvent;
  end;

  TLVCreateItemClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TCustomListView; var ItemClass: TListItemClass);
  end;

  TLVCreateItemClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLVCreateItemClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLVCreateItemClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLVCreateItemClassEvent;
  end;

  TCustomListView_sc = class of TCustomListView;
  TCustomListView_sw = class(TCustomMultiSelectListControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomListView): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomListView;
    class function ClassToVar(AClass: TCustomListView_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomListView_sc;
  end;

  TListView_sc = class of TListView;
  TListView_sw = class(TCustomListView_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListView): OleVariant;
    class function FromVar(const AValue: OleVariant): TListView;
    class function ClassToVar(AClass: TListView_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListView_sc;
  end;

  TListViewActionLink_sc = class of TListViewActionLink;
  TListViewActionLink_sw = class(TListActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListViewActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TListViewActionLink;
    class function ClassToVar(AClass: TListViewActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListViewActionLink_sc;
  end;

  TCommonAVI_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCommonAVI): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonAVI;
  end;

  TAnimateParams_sw = class(TLMDRecordWrapper)
  private
    FValue: TAnimateParams;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TAnimateParams): OleVariant;
    class function FromVar(const AValue: OleVariant): TAnimateParams;
  end;

  TAnimateResId_sw = NativeInt_sw;

  TAnimate_sc = class of TAnimate;
  TAnimate_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAnimate): OleVariant;
    class function FromVar(const AValue: OleVariant): TAnimate;
    class function ClassToVar(AClass: TAnimate_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAnimate_sc;
  end;

  TToolButtonStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TToolButtonStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolButtonStyle;
  end;

  TToolButtonState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TToolButtonState): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolButtonState;
  end;

  TToolButtonActionLink_sc = class of TToolButtonActionLink;
  TToolButtonActionLink_sw = class(TControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolButtonActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolButtonActionLink;
    class function ClassToVar(AClass: TToolButtonActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolButtonActionLink_sc;
  end;

  TToolButtonActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TToolButtonActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolButtonActionLinkClass;
  end;

  TToolButton_sc = class of TToolButton;
  TToolButton_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolButton;
    class function ClassToVar(AClass: TToolButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolButton_sc;
  end;

  TTBDrawingStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTBDrawingStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBDrawingStyle;
  end;

  TTBCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
  end;

  TTBCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTBCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTBCustomDrawEvent;
  end;

  TTBAdvancedCustomDrawEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TToolBar; const ARect: TRect;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  end;

  TTBAdvancedCustomDrawEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTBAdvancedCustomDrawEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBAdvancedCustomDrawEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTBAdvancedCustomDrawEvent;
  end;

  TTBCustomizeQueryEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TToolbar; Index: Integer; var Allow: Boolean);
  end;

  TTBCustomizeQueryEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTBCustomizeQueryEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBCustomizeQueryEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTBCustomizeQueryEvent;
  end;

  TTBNewButtonEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TToolbar; Index: Integer;
      var Button: TToolButton);
  end;

  TTBNewButtonEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTBNewButtonEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBNewButtonEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTBNewButtonEvent;
  end;

  TTBButtonEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TToolbar; Button: TToolButton);
  end;

  TTBButtonEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTBButtonEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TTBButtonEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TTBButtonEvent;
  end;

  TToolBarEnumerator_sc = class of TToolBarEnumerator;
  TToolBarEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolBarEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolBarEnumerator;
    class function ClassToVar(AClass: TToolBarEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolBarEnumerator_sc;
  end;

  TToolBar_sc = class of TToolBar;
  TToolBar_sw = class(TToolWindow_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolBar;
    class function ClassToVar(AClass: TToolBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolBar_sc;
  end;

  TToolBarDockObject_sc = class of TToolBarDockObject;
  TToolBarDockObject_sw = class(TDragDockObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolBarDockObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolBarDockObject;
    class function ClassToVar(AClass: TToolBarDockObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolBarDockObject_sc;
  end;

  TCoolBand_sc = class of TCoolBand;
  TCoolBand_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCoolBand): OleVariant;
    class function FromVar(const AValue: OleVariant): TCoolBand;
    class function ClassToVar(AClass: TCoolBand_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCoolBand_sc;
  end;

  TCoolBands_sc = class of TCoolBands;
  TCoolBands_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCoolBands): OleVariant;
    class function FromVar(const AValue: OleVariant): TCoolBands;
    class function ClassToVar(AClass: TCoolBands_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCoolBands_sc;
  end;

  TCoolBandMaximize_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCoolBandMaximize): OleVariant;
    class function FromVar(const AValue: OleVariant): TCoolBandMaximize;
  end;

  TCoolBar_sc = class of TCoolBar;
  TCoolBar_sw = class(TToolWindow_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCoolBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCoolBar;
    class function ClassToVar(AClass: TCoolBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCoolBar_sc;
  end;

  ECommonCalendarError_sc = class of ECommonCalendarError;
  ECommonCalendarError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ECommonCalendarError): OleVariant;
    class function FromVar(const AValue: OleVariant): ECommonCalendarError;
    class function ClassToVar(AClass: ECommonCalendarError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ECommonCalendarError_sc;
  end;

  ECommonCalExceptClass_sw = ExceptClass_sw;

  TMonthCalColors_sc = class of TMonthCalColors;
  TMonthCalColors_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMonthCalColors): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonthCalColors;
    class function ClassToVar(AClass: TMonthCalColors_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMonthCalColors_sc;
  end;

  TCalDayOfWeek_sw = System.UITypes_LMDSW.TCalDayOfWeek_sw;

  TOnGetMonthInfoEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Month: LongWord;
      var MonthBoldInfo: LongWord);
  end;

  TOnGetMonthInfoEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOnGetMonthInfoEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TOnGetMonthInfoEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TOnGetMonthInfoEvent;
  end;

  TOnGetMonthBoldInfoEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Month: LongWord; Year: LongWord;
      var MonthBoldInfo: LongWord);
  end;

  TOnGetMonthBoldInfoEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOnGetMonthBoldInfoEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TOnGetMonthBoldInfoEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TOnGetMonthBoldInfoEvent;
  end;

  TCommonCalendar_sc = class of TCommonCalendar;
  TCommonCalendar_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCommonCalendar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonCalendar;
    class function ClassToVar(AClass: TCommonCalendar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCommonCalendar_sc;
  end;

  EMonthCalError_sc = class of EMonthCalError;
  EMonthCalError_sw = class(ECommonCalendarError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EMonthCalError): OleVariant;
    class function FromVar(const AValue: OleVariant): EMonthCalError;
    class function ClassToVar(AClass: EMonthCalError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EMonthCalError_sc;
  end;

  TMonthCalendar_sc = class of TMonthCalendar;
  TMonthCalendar_sw = class(TCommonCalendar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMonthCalendar): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonthCalendar;
    class function ClassToVar(AClass: TMonthCalendar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMonthCalendar_sc;
  end;

  EDateTimeError_sc = class of EDateTimeError;
  EDateTimeError_sw = class(ECommonCalendarError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDateTimeError): OleVariant;
    class function FromVar(const AValue: OleVariant): EDateTimeError;
    class function ClassToVar(AClass: EDateTimeError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDateTimeError_sc;
  end;

  TDateTimeKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDateTimeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTimeKind;
  end;

  TDTDateMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDTDateMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TDTDateMode;
  end;

  TDTDateFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDTDateFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TDTDateFormat;
  end;

  TDTCalAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDTCalAlignment): OleVariant;
    class function FromVar(const AValue: OleVariant): TDTCalAlignment;
  end;

  TDTParseInputEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const UserString: string;
      var DateAndTime: TDateTime; var AllowChange: Boolean);
  end;

  TDTParseInputEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDTParseInputEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDTParseInputEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDTParseInputEvent;
  end;

  TDateTimeColors_sw = TMonthCalColors_sw;

  TDateTimePicker_sc = class of TDateTimePicker;
  TDateTimePicker_sw = class(TCommonCalendar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDateTimePicker): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTimePicker;
    class function ClassToVar(AClass: TDateTimePicker_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDateTimePicker_sc;
  end;

  TPageScrollerOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageScrollerOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageScrollerOrientation;
  end;

  TPageScrollerButton_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageScrollerButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageScrollerButton;
  end;

  TPageScrollerButtonState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageScrollerButtonState): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageScrollerButtonState;
  end;

  TPageScroller_sc = class of TPageScroller;
  TPageScroller_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPageScroller): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageScroller;
    class function ClassToVar(AClass: TPageScroller_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPageScroller_sc;
  end;

  TComboExItem_sc = class of TComboExItem;
  TComboExItem_sw = class(TListControlItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboExItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboExItem;
    class function ClassToVar(AClass: TComboExItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboExItem_sc;
  end;

  TComboExItems_sc = class of TComboExItems;
  TComboExItems_sw = class(TListControlItems_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboExItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboExItems;
    class function ClassToVar(AClass: TComboExItems_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboExItems_sc;
  end;

  TComboExItemsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TComboExItemsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboExItemsClass;
  end;

  TComboExItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TComboExItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboExItemClass;
  end;

  TComboBoxExStrings_sc = class of TComboBoxExStrings;
  TComboBoxExStrings_sw = class(TCustomComboBoxStrings_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboBoxExStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExStrings;
    class function ClassToVar(AClass: TComboBoxExStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboBoxExStrings_sc;
  end;

  TComboBoxExStringsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TComboBoxExStringsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExStringsClass;
  end;

  TComboBoxExStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TComboBoxExStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExStyle;
  end;

  TComboBoxExStyleEx_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TComboBoxExStyleEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExStyleEx;
  end;

  TComboBoxExStyles_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TComboBoxExStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExStyles;
  end;

  TAutoCompleteOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAutoCompleteOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TAutoCompleteOption;
  end;

  TAutoCompleteOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TAutoCompleteOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TAutoCompleteOptions;
  end;

  TCustomComboBoxEx_sc = class of TCustomComboBoxEx;
  TCustomComboBoxEx_sw = class(TCustomCombo_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomComboBoxEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomComboBoxEx;
    class function ClassToVar(AClass: TCustomComboBoxEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomComboBoxEx_sc;
  end;

  TComboBoxEx_sc = class of TComboBoxEx;
  TComboBoxEx_sw = class(TCustomComboBoxEx_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboBoxEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxEx;
    class function ClassToVar(AClass: TComboBoxEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboBoxEx_sc;
  end;

  TComboBoxExActionLink_sc = class of TComboBoxExActionLink;
  TComboBoxExActionLink_sw = class(TListActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComboBoxExActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TComboBoxExActionLink;
    class function ClassToVar(AClass: TComboBoxExActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComboBoxExActionLink_sc;
  end;


{ Unit wrapper }

type
  ComCtrls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomTabControl_sacc = class(TCustomTabControl);
  TTreeNodes_sacc = class(TTreeNodes);
  TCustomTreeView_sacc = class(TCustomTreeView);
  TCustomRichEdit_sacc = class(TCustomRichEdit);
  TCustomUpDown_sacc = class(TCustomUpDown);
  TCustomHotKey_sacc = class(TCustomHotKey);
  TCustomListView_sacc = class(TCustomListView);
  TCommonCalendar_sacc = class(TCommonCalendar);

{ THitTest_sw }

class function THitTest_sw.GetTypeName: WideString;
begin
  Result := 'THitTest';
end;

class procedure THitTest_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..11] of TLMDEnumerator = (
    (Name: 'htAbove'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htAbove)),
    (Name: 'htBelow'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htBelow)),
    (Name: 'htNowhere'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htNowhere)),
    (Name: 'htOnItem'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnItem)),
    (Name: 'htOnButton'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnButton)),
    (Name: 'htOnIcon'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnIcon)),
    (Name: 'htOnIndent'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnIndent)),
    (Name: 'htOnLabel'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnLabel)),
    (Name: 'htOnRight'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnRight)),
    (Name: 'htOnStateIcon'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htOnStateIcon)),
    (Name: 'htToLeft'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htToLeft)),
    (Name: 'htToRight'; Value: Integer({$IFDEF LMDSCT_12}THitTest.{$ENDIF}htToRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 12;
end;

class function THitTest_sw.ToVar(const AValue: THitTest): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THitTest_sw.FromVar(const AValue: OleVariant): THitTest;
begin
  Result := THitTest(Integer(AValue));
end;

{ THitTests_sw }

class function THitTests_sw.GetTypeName: WideString;
begin
  Result := 'THitTests';
end;

class function THitTests_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(THitTests);
end;

class function THitTests_sw.ToVar(const AValue: THitTests): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function THitTests_sw.FromVar(const AValue: OleVariant): THitTests;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTabChangingEvent_sh }

function TTabChangingEvent_sh.GetHandler: TMethod;
var
  hdr: TTabChangingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTabChangingEvent_sh.Handler(Sender: TObject;
  var AllowChange: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var AllowChange: Boolean) of ...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TTabChangingEvent_sw }

class function TTabChangingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTabChangingEvent';
end;

class function TTabChangingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTabChangingEvent_sh;
end;

class function TTabChangingEvent_sw.ToVar(
  const AValue: TTabChangingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTabChangingEvent_sw.FromVar(
  const AValue: OleVariant): TTabChangingEvent;
begin
  Result := TTabChangingEvent(ConvFromVar(AValue));
end;

class function TTabChangingEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTabChangingEvent;
var
  hdlr: TTabChangingEvent_sh;
begin
  hdlr   := TTabChangingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTabChangingEvent_sw));
  Result := hdlr.Handler;
end;

{ TTabPosition_sw }

class function TTabPosition_sw.GetTypeName: WideString;
begin
  Result := 'TTabPosition';
end;

class procedure TTabPosition_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'tpTop'; Value: Integer({$IFDEF LMDSCT_12}TTabPosition.{$ENDIF}tpTop)),
    (Name: 'tpBottom'; Value: Integer({$IFDEF LMDSCT_12}TTabPosition.{$ENDIF}tpBottom)),
    (Name: 'tpLeft'; Value: Integer({$IFDEF LMDSCT_12}TTabPosition.{$ENDIF}tpLeft)),
    (Name: 'tpRight'; Value: Integer({$IFDEF LMDSCT_12}TTabPosition.{$ENDIF}tpRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TTabPosition_sw.ToVar(const AValue: TTabPosition): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTabPosition_sw.FromVar(const AValue: OleVariant): TTabPosition;
begin
  Result := TTabPosition(Integer(AValue));
end;

{ TTabStyle_sw }

class function TTabStyle_sw.GetTypeName: WideString;
begin
  Result := 'TTabStyle';
end;

class procedure TTabStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'tsTabs'; Value: Integer({$IFDEF LMDSCT_12}TTabStyle.{$ENDIF}tsTabs)),
    (Name: 'tsButtons'; Value: Integer({$IFDEF LMDSCT_12}TTabStyle.{$ENDIF}tsButtons)),
    (Name: 'tsFlatButtons'; Value: Integer({$IFDEF LMDSCT_12}TTabStyle.{$ENDIF}tsFlatButtons))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TTabStyle_sw.ToVar(const AValue: TTabStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTabStyle_sw.FromVar(const AValue: OleVariant): TTabStyle;
begin
  Result := TTabStyle(Integer(AValue));
end;

{ TDrawTabEvent_sh }

function TDrawTabEvent_sh.GetHandler: TMethod;
var
  hdr: TDrawTabEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDrawTabEvent_sh.Handler(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Control: TCustomTabControl; TabIndex: Integer;...

  args[0] := TCustomTabControl_sw.ToVar(Control);
  args[1] := TabIndex;
  args[2] := TRect_sw.ToVar(Rect);
  args[3] := Active;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDrawTabEvent_sw }

class function TDrawTabEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDrawTabEvent';
end;

class function TDrawTabEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDrawTabEvent_sh;
end;

class function TDrawTabEvent_sw.ToVar(const AValue: TDrawTabEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDrawTabEvent_sw.FromVar(
  const AValue: OleVariant): TDrawTabEvent;
begin
  Result := TDrawTabEvent(ConvFromVar(AValue));
end;

class function TDrawTabEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDrawTabEvent;
var
  hdlr: TDrawTabEvent_sh;
begin
  hdlr   := TDrawTabEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDrawTabEvent_sw));
  Result := hdlr.Handler;
end;

{ TTabGetImageEvent_sh }

function TTabGetImageEvent_sh.GetHandler: TMethod;
var
  hdr: TTabGetImageEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTabGetImageEvent_sh.Handler(Sender: TObject; TabIndex: Integer;
  var ImageIndex: Integer);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; TabIndex: Integer; var ImageI...

  v_1 := ImageIndex;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TabIndex;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ImageIndex := Integer(v_1);
end;

{ TTabGetImageEvent_sw }

class function TTabGetImageEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTabGetImageEvent';
end;

class function TTabGetImageEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTabGetImageEvent_sh;
end;

class function TTabGetImageEvent_sw.ToVar(
  const AValue: TTabGetImageEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTabGetImageEvent_sw.FromVar(
  const AValue: OleVariant): TTabGetImageEvent;
begin
  Result := TTabGetImageEvent(ConvFromVar(AValue));
end;

class function TTabGetImageEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTabGetImageEvent;
var
  hdlr: TTabGetImageEvent_sh;
begin
  hdlr   := TTabGetImageEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTabGetImageEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomTabControl_sw }

function TCustomTabControl_DisplayRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DisplayRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(AObj)).
    DisplayRect);
end;

function TCustomTabControl_HotTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HotTrack: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).HotTrack
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).HotTrack := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Images: TCustomImageList read <getter>...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomTabControl_sacc(
      TCustomTabControl(AObj)).Images)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).Images := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomTabControl_MultiLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiLine: Boolean read <getter> write...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).MultiLine
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).MultiLine := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_MultiSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiSelect: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).MultiSelect
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).MultiSelect := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_OwnerDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OwnerDraw: Boolean read <getter> write...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).OwnerDraw
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).OwnerDraw := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_RaggedRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RaggedRight: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).RaggedRight
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).RaggedRight := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_ScrollOpposite_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ScrollOpposite: Boolean read <getter> ...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).ScrollOpposite
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).ScrollOpposite := Boolean(
      AArgs[0]);
end;

function TCustomTabControl_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Style: TTabStyle read <getter> write <...

  if IsGet then
    Result := TTabStyle_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(
      AObj)).Style)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).Style := TTabStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomTabControl_TabHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabHeight: Smallint read <getter> writ...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).TabHeight
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).TabHeight := Smallint(
      AArgs[0]);
end;

function TCustomTabControl_TabIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabIndex: Integer read <getter> write ...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).TabIndex
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).TabIndex := Integer(
      AArgs[0]);
end;

function TCustomTabControl_TabPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabPosition: TTabPosition read <getter...

  if IsGet then
    Result := TTabPosition_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(
      AObj)).TabPosition)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).TabPosition := 
      TTabPosition_sw.FromVar(AArgs[0]);
end;

function TCustomTabControl_Tabs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Tabs: TStrings read <getter> write <se...

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(AObj)).
      Tabs)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).Tabs := TStrings_sw.FromVar(
      AArgs[0]);
end;

function TCustomTabControl_TabWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabWidth: Smallint read <getter> write...

  if IsGet then
    Result := TCustomTabControl_sacc(TCustomTabControl(AObj)).TabWidth
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).TabWidth := Smallint(
      AArgs[0]);
end;

function TCustomTabControl_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(
      AObj)).OnChange)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).OnChange := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTabControl_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChanging: TTabChangingEvent read <ge...

  if IsGet then
    Result := TTabChangingEvent_sw.ToVar(TCustomTabControl_sacc(
      TCustomTabControl(AObj)).OnChanging)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).OnChanging := 
      TTabChangingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTabControl_OnDrawTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDrawTab: TDrawTabEvent read <getter>...

  if IsGet then
    Result := TDrawTabEvent_sw.ToVar(TCustomTabControl_sacc(TCustomTabControl(
      AObj)).OnDrawTab)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).OnDrawTab := 
      TDrawTabEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTabControl_OnGetImageIndex_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetImageIndex: TTabGetImageEvent rea...

  if IsGet then
    Result := TTabGetImageEvent_sw.ToVar(TCustomTabControl_sacc(
      TCustomTabControl(AObj)).OnGetImageIndex)
  else
    TCustomTabControl_sacc(TCustomTabControl(AObj)).OnGetImageIndex := 
      TTabGetImageEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTabControl_IndexOfTabAt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfTabAt(X: Integer; Y: Integer): Integer;

  Result := TCustomTabControl(AObj).IndexOfTabAt(Integer(AArgs[0]), Integer(
    AArgs[1]));
end;

function TCustomTabControl_GetHitTestInfoAt_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHitTestInfoAt(X: Integer; Y: Integer): THitTe...

  Result := THitTests_sw.ToVar(TCustomTabControl(AObj).GetHitTestInfoAt(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function TCustomTabControl_TabRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TabRect(Index: Integer): TRect;

  Result := TRect_sw.ToVar(TCustomTabControl(AObj).TabRect(Integer(AArgs[0])));
end;

function TCustomTabControl_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RowCount: Integer;

  Result := TCustomTabControl(AObj).RowCount();
end;

function TCustomTabControl_ScrollTabs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ScrollTabs(Delta: Integer);

  TCustomTabControl(AObj).ScrollTabs(Integer(AArgs[0]));
end;

function TCustomTabControl_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomTabControl(AObj).Canvas);
end;

class function TCustomTabControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomTabControl';
end;

class function TCustomTabControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomTabControl;
end;

class procedure TCustomTabControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DisplayRect', TCustomTabControl_DisplayRect_si, TRect_sw, True, False, 0, True, False);
  AData.AddProperty('HotTrack', TCustomTabControl_HotTrack_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Images', TCustomTabControl_Images_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('MultiLine', TCustomTabControl_MultiLine_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MultiSelect', TCustomTabControl_MultiSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OwnerDraw', TCustomTabControl_OwnerDraw_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('RaggedRight', TCustomTabControl_RaggedRight_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ScrollOpposite', TCustomTabControl_ScrollOpposite_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Style', TCustomTabControl_Style_si, TTabStyle_sw, True, True, 0, True, False);
  AData.AddProperty('TabHeight', TCustomTabControl_TabHeight_si, Smallint_sw, True, True, 0, True, False);
  AData.AddProperty('TabIndex', TCustomTabControl_TabIndex_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('TabPosition', TCustomTabControl_TabPosition_si, TTabPosition_sw, True, True, 0, True, False);
  AData.AddProperty('Tabs', TCustomTabControl_Tabs_si, TStrings_sw, True, True, 0, True, False);
  AData.AddProperty('TabWidth', TCustomTabControl_TabWidth_si, Smallint_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomTabControl_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChanging', TCustomTabControl_OnChanging_si, TTabChangingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDrawTab', TCustomTabControl_OnDrawTab_si, TDrawTabEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetImageIndex', TCustomTabControl_OnGetImageIndex_si, TTabGetImageEvent_sw, True, True, 0, True, False);
  AData.AddFunction('IndexOfTabAt', TCustomTabControl_IndexOfTabAt_si, Integer_sw, 2, False);
  AData.AddFunction('GetHitTestInfoAt', TCustomTabControl_GetHitTestInfoAt_si, THitTests_sw, 2, False);
  AData.AddFunction('TabRect', TCustomTabControl_TabRect_si, TRect_sw, 1, False);
  AData.AddFunction('RowCount', TCustomTabControl_RowCount_si, Integer_sw, 0, False);
  AData.AddProcedure('ScrollTabs', TCustomTabControl_ScrollTabs_si, 1, False);
  AData.AddProperty('Canvas', TCustomTabControl_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('TabStop', False);
end;

class function TCustomTabControl_sw.ToVar(
  const AValue: TCustomTabControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomTabControl_sw.FromVar(
  const AValue: OleVariant): TCustomTabControl;
begin
  Result := TCustomTabControl(ConvFromVar(AValue, TCustomTabControl));
end;

class function TCustomTabControl_sw.ClassToVar(
  AClass: TCustomTabControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomTabControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomTabControl_sc;
begin
  Result := TCustomTabControl_sc(ConvClsFromVar(AClass, TCustomTabControl));
end;

{ TTabControl_sw }

class function TTabControl_sw.GetTypeName: WideString;
begin
  Result := 'TTabControl';
end;

class function TTabControl_sw.GetWrappedClass: TClass;
begin
  Result := TTabControl;
end;

class procedure TTabControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('DisplayRect', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HotTrack', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('MultiLine', False);
  AData.AddPropertyRedecl('MultiSelect', False);
  AData.AddPropertyRedecl('OwnerDraw', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('RaggedRight', False);
  AData.AddPropertyRedecl('ScrollOpposite', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('TabHeight', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabPosition', False);
  AData.AddPropertyRedecl('Tabs', False);
  AData.AddPropertyRedecl('TabIndex', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('TabWidth', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnChanging', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawTab', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetImageIndex', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TTabControl_sw.ToVar(const AValue: TTabControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTabControl_sw.FromVar(const AValue: OleVariant): TTabControl;
begin
  Result := TTabControl(ConvFromVar(AValue, TTabControl));
end;

class function TTabControl_sw.ClassToVar(AClass: TTabControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTabControl_sw.ClassFromVar(
  const AClass: OleVariant): TTabControl_sc;
begin
  Result := TTabControl_sc(ConvClsFromVar(AClass, TTabControl));
end;

{ TTabSheet_sw }

function TTabSheet_PageControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageControl: TPageControl read <getter> write <s...

  if IsGet then
    Result := TPageControl_sw.ToVar(TTabSheet(AObj).PageControl)
  else
    TTabSheet(AObj).PageControl := TPageControl_sw.FromVar(AArgs[0]);
end;

function TTabSheet_TabIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabIndex: Integer read <getter>;

  Result := TTabSheet(AObj).TabIndex;
end;

function TTabSheet_Highlighted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Highlighted: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTabSheet(AObj).Highlighted
  else
    TTabSheet(AObj).Highlighted := Boolean(AArgs[0]);
end;

function TTabSheet_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TTabSheet(AObj).ImageIndex)
  else
    TTabSheet(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TTabSheet_PageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTabSheet(AObj).PageIndex
  else
    TTabSheet(AObj).PageIndex := Integer(AArgs[0]);
end;

function TTabSheet_TabVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabVisible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTabSheet(AObj).TabVisible
  else
    TTabSheet(AObj).TabVisible := Boolean(AArgs[0]);
end;

function TTabSheet_OnHide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHide: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TTabSheet(AObj).OnHide)
  else
    TTabSheet(AObj).OnHide := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TTabSheet_OnShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShow: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TTabSheet(AObj).OnShow)
  else
    TTabSheet(AObj).OnShow := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TTabSheet_sw.GetTypeName: WideString;
begin
  Result := 'TTabSheet';
end;

class function TTabSheet_sw.GetWrappedClass: TClass;
begin
  Result := TTabSheet;
end;

class procedure TTabSheet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('PageControl', TTabSheet_PageControl_si, TPageControl_sw, True, True, 0, False, False);
  AData.AddProperty('TabIndex', TTabSheet_TabIndex_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddProperty('Highlighted', TTabSheet_Highlighted_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TTabSheet_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Left', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('PageIndex', TTabSheet_PageIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('TabVisible', TTabSheet_TabVisible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Top', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddProperty('OnHide', TTabSheet_OnHide_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddProperty('OnShow', TTabSheet_OnShow_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TTabSheet_sw.ToVar(const AValue: TTabSheet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTabSheet_sw.FromVar(const AValue: OleVariant): TTabSheet;
begin
  Result := TTabSheet(ConvFromVar(AValue, TTabSheet));
end;

class function TTabSheet_sw.ClassToVar(AClass: TTabSheet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTabSheet_sw.ClassFromVar(
  const AClass: OleVariant): TTabSheet_sc;
begin
  Result := TTabSheet_sc(ConvClsFromVar(AClass, TTabSheet));
end;

{ TPageControl_sw }

function TPageControl_FindNextPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindNextPage(CurPage: TTabSheet; GoForward: Bool...

  Result := TTabSheet_sw.ToVar(TPageControl(AObj).FindNextPage(TTabSheet_sw.
    FromVar(AArgs[0]), Boolean(AArgs[1]), Boolean(AArgs[2])));
end;

function TPageControl_SelectNextPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SelectNextPage(GoForward: Boolean; CheckTabVisi...

  case AArgsSize of
    1:
    begin
      TPageControl(AObj).SelectNextPage(Boolean(AArgs[0]));
    end;
    2:
    begin
      TPageControl(AObj).SelectNextPage(Boolean(AArgs[0]), Boolean(AArgs[1]));
    end;
  else
    WrongArgCountError('SelectNextPage');
  end;
end;

function TPageControl_ActivePageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActivePageIndex: Integer read <getter> write <se...

  if IsGet then
    Result := TPageControl(AObj).ActivePageIndex
  else
    TPageControl(AObj).ActivePageIndex := Integer(AArgs[0]);
end;

function TPageControl_PageCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageCount: Integer read <getter>;

  Result := TPageControl(AObj).PageCount;
end;

function TPageControl_Pages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pages[Index: Integer]: TTabSheet read <getter>;

  Result := TTabSheet_sw.ToVar(TPageControl(AObj).Pages[Integer(AArgs[0])]);
end;

function TPageControl_ActivePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActivePage: TTabSheet read <getter> write <setter>;

  if IsGet then
    Result := TTabSheet_sw.ToVar(TPageControl(AObj).ActivePage)
  else
    TPageControl(AObj).ActivePage := TTabSheet_sw.FromVar(AArgs[0]);
end;

class function TPageControl_sw.GetTypeName: WideString;
begin
  Result := 'TPageControl';
end;

class function TPageControl_sw.GetWrappedClass: TClass;
begin
  Result := TPageControl;
end;

class procedure TPageControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('FindNextPage', TPageControl_FindNextPage_si, TTabSheet_sw, 3, False);
  AData.AddProcedure('SelectNextPage', TPageControl_SelectNextPage_si, 1, True);
  AData.AddProperty('ActivePageIndex', TPageControl_ActivePageIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PageCount', TPageControl_PageCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Pages', TPageControl_Pages_si, TTabSheet_sw, True, False, 1, False, False);
  AData.AddProperty('ActivePage', TPageControl_ActivePage_si, TTabSheet_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HotTrack', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('MultiLine', False);
  AData.AddPropertyRedecl('OwnerDraw', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('RaggedRight', False);
  AData.AddPropertyRedecl('ScrollOpposite', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('TabHeight', False);
  AData.AddPropertyRedecl('TabIndex', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabPosition', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('TabWidth', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnChanging', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawTab', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetImageIndex', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TPageControl_sw.ToVar(const AValue: TPageControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPageControl_sw.FromVar(const AValue: OleVariant): TPageControl;
begin
  Result := TPageControl(ConvFromVar(AValue, TPageControl));
end;

class function TPageControl_sw.ClassToVar(AClass: TPageControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPageControl_sw.ClassFromVar(
  const AClass: OleVariant): TPageControl_sc;
begin
  Result := TPageControl_sc(ConvClsFromVar(AClass, TPageControl));
end;

{ TStatusPanelStyle_sw }

class function TStatusPanelStyle_sw.GetTypeName: WideString;
begin
  Result := 'TStatusPanelStyle';
end;

class procedure TStatusPanelStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'psText'; Value: Integer({$IFDEF LMDSCT_12}TStatusPanelStyle.{$ENDIF}psText)),
    (Name: 'psOwnerDraw'; Value: Integer({$IFDEF LMDSCT_12}TStatusPanelStyle.{$ENDIF}psOwnerDraw))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TStatusPanelStyle_sw.ToVar(
  const AValue: TStatusPanelStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStatusPanelStyle_sw.FromVar(
  const AValue: OleVariant): TStatusPanelStyle;
begin
  Result := TStatusPanelStyle(Integer(AValue));
end;

{ TStatusPanelBevel_sw }

class function TStatusPanelBevel_sw.GetTypeName: WideString;
begin
  Result := 'TStatusPanelBevel';
end;

class procedure TStatusPanelBevel_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pbNone'; Value: Integer({$IFDEF LMDSCT_12}TStatusPanelBevel.{$ENDIF}pbNone)),
    (Name: 'pbLowered'; Value: Integer({$IFDEF LMDSCT_12}TStatusPanelBevel.{$ENDIF}pbLowered)),
    (Name: 'pbRaised'; Value: Integer({$IFDEF LMDSCT_12}TStatusPanelBevel.{$ENDIF}pbRaised))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TStatusPanelBevel_sw.ToVar(
  const AValue: TStatusPanelBevel): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStatusPanelBevel_sw.FromVar(
  const AValue: OleVariant): TStatusPanelBevel;
begin
  Result := TStatusPanelBevel(Integer(AValue));
end;

{ TStatusPanelClass_sw }

class function TStatusPanelClass_sw.GetTypeName: WideString;
begin
  Result := 'TStatusPanelClass';
end;

class function TStatusPanelClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TStatusPanel;
end;

class function TStatusPanelClass_sw.ToVar(
  const AValue: TStatusPanelClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStatusPanelClass_sw.FromVar(
  const AValue: OleVariant): TStatusPanelClass;
begin
  Result := TStatusPanelClass(ConvFromVar(AValue, TStatusPanel));
end;

{ TStatusPanel_sw }

function TStatusPanel_ParentBiDiModeChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ParentBiDiModeChanged;

  TStatusPanel(AObj).ParentBiDiModeChanged();
end;

function TStatusPanel_UseRightToLeftAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftAlignment: Boolean;

  Result := TStatusPanel(AObj).UseRightToLeftAlignment();
end;

function TStatusPanel_UseRightToLeftReading_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftReading: Boolean;

  Result := TStatusPanel(AObj).UseRightToLeftReading();
end;

function TStatusPanel_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TStatusPanel(AObj).Alignment)
  else
    TStatusPanel(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TStatusPanel_Bevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bevel: TStatusPanelBevel read <getter> write <se...

  if IsGet then
    Result := TStatusPanelBevel_sw.ToVar(TStatusPanel(AObj).Bevel)
  else
    TStatusPanel(AObj).Bevel := TStatusPanelBevel_sw.FromVar(AArgs[0]);
end;

function TStatusPanel_BiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiMode: TBiDiMode read <getter> write <setter>;

  if IsGet then
    Result := TBiDiMode_sw.ToVar(TStatusPanel(AObj).BiDiMode)
  else
    TStatusPanel(AObj).BiDiMode := TBiDiMode_sw.FromVar(AArgs[0]);
end;

function TStatusPanel_ParentBiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentBiDiMode: Boolean read <getter> write <set...

  if IsGet then
    Result := TStatusPanel(AObj).ParentBiDiMode
  else
    TStatusPanel(AObj).ParentBiDiMode := Boolean(AArgs[0]);
end;

function TStatusPanel_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TStatusPanelStyle read <getter> write <se...

  if IsGet then
    Result := TStatusPanelStyle_sw.ToVar(TStatusPanel(AObj).Style)
  else
    TStatusPanel(AObj).Style := TStatusPanelStyle_sw.FromVar(AArgs[0]);
end;

function TStatusPanel_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TStatusPanel(AObj).Text
  else
    TStatusPanel(AObj).Text := string(AArgs[0]);
end;

function TStatusPanel_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TStatusPanel(AObj).Width
  else
    TStatusPanel(AObj).Width := Integer(AArgs[0]);
end;

class function TStatusPanel_sw.GetTypeName: WideString;
begin
  Result := 'TStatusPanel';
end;

class function TStatusPanel_sw.GetWrappedClass: TClass;
begin
  Result := TStatusPanel;
end;

class procedure TStatusPanel_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ParentBiDiModeChanged', TStatusPanel_ParentBiDiModeChanged_si, 0, False);
  AData.AddFunction('UseRightToLeftAlignment', TStatusPanel_UseRightToLeftAlignment_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftReading', TStatusPanel_UseRightToLeftReading_si, Boolean_sw, 0, False);
  AData.AddProperty('Alignment', TStatusPanel_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('Bevel', TStatusPanel_Bevel_si, TStatusPanelBevel_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiMode', TStatusPanel_BiDiMode_si, TBiDiMode_sw, True, True, 0, False, False);
  AData.AddProperty('ParentBiDiMode', TStatusPanel_ParentBiDiMode_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TStatusPanel_Style_si, TStatusPanelStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TStatusPanel_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TStatusPanel_Width_si, Integer_sw, True, True, 0, False, False);
end;

class function TStatusPanel_sw.ToVar(const AValue: TStatusPanel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStatusPanel_sw.FromVar(const AValue: OleVariant): TStatusPanel;
begin
  Result := TStatusPanel(ConvFromVar(AValue, TStatusPanel));
end;

class function TStatusPanel_sw.ClassToVar(AClass: TStatusPanel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStatusPanel_sw.ClassFromVar(
  const AClass: OleVariant): TStatusPanel_sc;
begin
  Result := TStatusPanel_sc(ConvClsFromVar(AClass, TStatusPanel));
end;

{ TStatusPanels_sw }

function TStatusPanels_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(StatusBar: TCustomStatusBar);

  Result := TStatusPanels_sw.ToVar(TStatusPanels_sc(AObj).Create(
    TCustomStatusBar_sw.FromVar(AArgs[0])));
end;

function TStatusPanels_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TStatusPanel;

  Result := TStatusPanel_sw.ToVar(TStatusPanels(AObj).Add());
end;

function TStatusPanels_AddItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddItem(Item: TStatusPanel; Index: Integer): TSt...

  Result := TStatusPanel_sw.ToVar(TStatusPanels(AObj).AddItem(TStatusPanel_sw.
    FromVar(AArgs[0]), Integer(AArgs[1])));
end;

function TStatusPanels_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): TStatusPanel;

  Result := TStatusPanel_sw.ToVar(TStatusPanels(AObj).Insert(Integer(
    AArgs[0])));
end;

function TStatusPanels_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TStatusPanel read <getter...

  if IsGet then
    Result := TStatusPanel_sw.ToVar(TStatusPanels(AObj).Items[Integer(
      AArgs[0])])
  else
    TStatusPanels(AObj).Items[Integer(AArgs[0])] := TStatusPanel_sw.FromVar(
      AArgs[1]);
end;

class function TStatusPanels_sw.GetTypeName: WideString;
begin
  Result := 'TStatusPanels';
end;

class function TStatusPanels_sw.GetWrappedClass: TClass;
begin
  Result := TStatusPanels;
end;

class procedure TStatusPanels_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TStatusPanels_Add_si, TStatusPanel_sw, 0, False);
  AData.AddFunction('AddItem', TStatusPanels_AddItem_si, TStatusPanel_sw, 2, False);
  AData.AddFunction('Insert', TStatusPanels_Insert_si, TStatusPanel_sw, 1, False);
  AData.AddProperty('Items', TStatusPanels_Items_si, TStatusPanel_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TStatusPanels_Create_si, 1, False);
end;

class function TStatusPanels_sw.ToVar(const AValue: TStatusPanels): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStatusPanels_sw.FromVar(
  const AValue: OleVariant): TStatusPanels;
begin
  Result := TStatusPanels(ConvFromVar(AValue, TStatusPanels));
end;

class function TStatusPanels_sw.ClassToVar(
  AClass: TStatusPanels_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStatusPanels_sw.ClassFromVar(
  const AClass: OleVariant): TStatusPanels_sc;
begin
  Result := TStatusPanels_sc(ConvClsFromVar(AClass, TStatusPanels));
end;

{ TCustomDrawPanelEvent_sh }

function TCustomDrawPanelEvent_sh.GetHandler: TMethod;
var
  hdr: TCustomDrawPanelEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCustomDrawPanelEvent_sh.Handler(StatusBar: TCustomStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (StatusBar: TCustomStatusBar; Panel: TStatusPan...

  args[0] := TCustomStatusBar_sw.ToVar(StatusBar);
  args[1] := TStatusPanel_sw.ToVar(Panel);
  args[2] := TRect_sw.ToVar(Rect);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TCustomDrawPanelEvent_sw }

class function TCustomDrawPanelEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDrawPanelEvent';
end;

class function TCustomDrawPanelEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCustomDrawPanelEvent_sh;
end;

class function TCustomDrawPanelEvent_sw.ToVar(
  const AValue: TCustomDrawPanelEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCustomDrawPanelEvent_sw.FromVar(
  const AValue: OleVariant): TCustomDrawPanelEvent;
begin
  Result := TCustomDrawPanelEvent(ConvFromVar(AValue));
end;

class function TCustomDrawPanelEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCustomDrawPanelEvent;
var
  hdlr: TCustomDrawPanelEvent_sh;
begin
  hdlr   := TCustomDrawPanelEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TCustomDrawPanelEvent_sw));
  Result := hdlr.Handler;
end;

{ TSBCreatePanelClassEvent_sh }

function TSBCreatePanelClassEvent_sh.GetHandler: TMethod;
var
  hdr: TSBCreatePanelClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSBCreatePanelClassEvent_sh.Handler(Sender: TCustomStatusBar;
  var PanelClass: TStatusPanelClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomStatusBar; var PanelClass: TSta...

  v_1 := TStatusPanelClass_sw.ToVar(PanelClass);
  args[0] := TCustomStatusBar_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  PanelClass := TStatusPanelClass_sw.FromVar(v_1);
end;

{ TSBCreatePanelClassEvent_sw }

class function TSBCreatePanelClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSBCreatePanelClassEvent';
end;

class function TSBCreatePanelClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSBCreatePanelClassEvent_sh;
end;

class function TSBCreatePanelClassEvent_sw.ToVar(
  const AValue: TSBCreatePanelClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSBCreatePanelClassEvent_sw.FromVar(
  const AValue: OleVariant): TSBCreatePanelClassEvent;
begin
  Result := TSBCreatePanelClassEvent(ConvFromVar(AValue));
end;

class function TSBCreatePanelClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TSBCreatePanelClassEvent;
var
  hdlr: TSBCreatePanelClassEvent_sh;
begin
  hdlr   := TSBCreatePanelClassEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TSBCreatePanelClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomStatusBar_sw }

function TCustomStatusBar_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomStatusBar(AObj).Canvas);
end;

function TCustomStatusBar_AutoHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoHint: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomStatusBar(AObj).AutoHint
  else
    TCustomStatusBar(AObj).AutoHint := Boolean(AArgs[0]);
end;

function TCustomStatusBar_Panels_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Panels: TStatusPanels read <getter> write <setter>;

  if IsGet then
    Result := TStatusPanels_sw.ToVar(TCustomStatusBar(AObj).Panels)
  else
    TCustomStatusBar(AObj).Panels := TStatusPanels_sw.FromVar(AArgs[0]);
end;

function TCustomStatusBar_SimplePanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SimplePanel: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomStatusBar(AObj).SimplePanel
  else
    TCustomStatusBar(AObj).SimplePanel := Boolean(AArgs[0]);
end;

function TCustomStatusBar_SimpleText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SimpleText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomStatusBar(AObj).SimpleText
  else
    TCustomStatusBar(AObj).SimpleText := string(AArgs[0]);
end;

function TCustomStatusBar_SizeGrip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SizeGrip: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomStatusBar(AObj).SizeGrip
  else
    TCustomStatusBar(AObj).SizeGrip := Boolean(AArgs[0]);
end;

function TCustomStatusBar_UseSystemFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseSystemFont: Boolean read <getter> write <sett...

  if IsGet then
    Result := TCustomStatusBar(AObj).UseSystemFont
  else
    TCustomStatusBar(AObj).UseSystemFont := Boolean(AArgs[0]);
end;

function TCustomStatusBar_OnCreatePanelClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCreatePanelClass: TSBCreatePanelClassEvent rea...

  if IsGet then
    Result := TSBCreatePanelClassEvent_sw.ToVar(TCustomStatusBar(AObj).
      OnCreatePanelClass)
  else
    TCustomStatusBar(AObj).OnCreatePanelClass := TSBCreatePanelClassEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomStatusBar_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHint: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomStatusBar(AObj).OnHint)
  else
    TCustomStatusBar(AObj).OnHint := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomStatusBar_OnDrawPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawPanel: TCustomDrawPanelEvent read <getter>...

  if IsGet then
    Result := TCustomDrawPanelEvent_sw.ToVar(TCustomStatusBar(AObj).OnDrawPanel)
  else
    TCustomStatusBar(AObj).OnDrawPanel := TCustomDrawPanelEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomStatusBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomStatusBar';
end;

class function TCustomStatusBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomStatusBar;
end;

class procedure TCustomStatusBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TCustomStatusBar_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('AutoHint', TCustomStatusBar_AutoHint_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Panels', TCustomStatusBar_Panels_si, TStatusPanels_sw, True, True, 0, False, False);
  AData.AddProperty('SimplePanel', TCustomStatusBar_SimplePanel_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SimpleText', TCustomStatusBar_SimpleText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('SizeGrip', TCustomStatusBar_SizeGrip_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('UseSystemFont', TCustomStatusBar_UseSystemFont_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnCreatePanelClass', TCustomStatusBar_OnCreatePanelClass_si, TSBCreatePanelClassEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnHint', TCustomStatusBar_OnHint_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawPanel', TCustomStatusBar_OnDrawPanel_si, TCustomDrawPanelEvent_sw, True, True, 0, False, False);
end;

class function TCustomStatusBar_sw.ToVar(
  const AValue: TCustomStatusBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomStatusBar_sw.FromVar(
  const AValue: OleVariant): TCustomStatusBar;
begin
  Result := TCustomStatusBar(ConvFromVar(AValue, TCustomStatusBar));
end;

class function TCustomStatusBar_sw.ClassToVar(
  AClass: TCustomStatusBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomStatusBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomStatusBar_sc;
begin
  Result := TCustomStatusBar_sc(ConvClsFromVar(AClass, TCustomStatusBar));
end;

{ TDrawPanelEvent_sh }

function TDrawPanelEvent_sh.GetHandler: TMethod;
var
  hdr: TDrawPanelEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDrawPanelEvent_sh.Handler(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (StatusBar: TStatusBar; Panel: TStatusPanel; co...

  args[0] := TStatusBar_sw.ToVar(StatusBar);
  args[1] := TStatusPanel_sw.ToVar(Panel);
  args[2] := TRect_sw.ToVar(Rect);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDrawPanelEvent_sw }

class function TDrawPanelEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDrawPanelEvent';
end;

class function TDrawPanelEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDrawPanelEvent_sh;
end;

class function TDrawPanelEvent_sw.ToVar(
  const AValue: TDrawPanelEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDrawPanelEvent_sw.FromVar(
  const AValue: OleVariant): TDrawPanelEvent;
begin
  Result := TDrawPanelEvent(ConvFromVar(AValue));
end;

class function TDrawPanelEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDrawPanelEvent;
var
  hdlr: TDrawPanelEvent_sh;
begin
  hdlr   := TDrawPanelEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDrawPanelEvent_sw));
  Result := hdlr.Handler;
end;

{ TStatusBar_sw }

function TStatusBar_OnDrawPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawPanel: TDrawPanelEvent read <getter> write...

  if IsGet then
    Result := TDrawPanelEvent_sw.ToVar(TStatusBar(AObj).OnDrawPanel)
  else
    TStatusBar(AObj).OnDrawPanel := TDrawPanelEvent_sw.FromVar(AArgs[0]);
end;

class function TStatusBar_sw.GetTypeName: WideString;
begin
  Result := 'TStatusBar';
end;

class function TStatusBar_sw.GetWrappedClass: TClass;
begin
  Result := TStatusBar;
end;

class procedure TStatusBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('AutoHint', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Panels', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('SimplePanel', False);
  AData.AddPropertyRedecl('SimpleText', False);
  AData.AddPropertyRedecl('SizeGrip', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('UseSystemFont', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnCreatePanelClass', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddProperty('OnDrawPanel', TStatusBar_OnDrawPanel_si, TDrawPanelEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TStatusBar_sw.ToVar(const AValue: TStatusBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStatusBar_sw.FromVar(const AValue: OleVariant): TStatusBar;
begin
  Result := TStatusBar(ConvFromVar(AValue, TStatusBar));
end;

class function TStatusBar_sw.ClassToVar(AClass: TStatusBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStatusBar_sw.ClassFromVar(
  const AClass: OleVariant): TStatusBar_sc;
begin
  Result := TStatusBar_sc(ConvClsFromVar(AClass, TStatusBar));
end;

{ TCustomDrawTarget_sw }

class function TCustomDrawTarget_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDrawTarget';
end;

class procedure TCustomDrawTarget_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'dtControl'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawTarget.{$ENDIF}dtControl)),
    (Name: 'dtItem'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawTarget.{$ENDIF}dtItem)),
    (Name: 'dtSubItem'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawTarget.{$ENDIF}dtSubItem))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TCustomDrawTarget_sw.ToVar(
  const AValue: TCustomDrawTarget): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCustomDrawTarget_sw.FromVar(
  const AValue: OleVariant): TCustomDrawTarget;
begin
  Result := TCustomDrawTarget(Integer(AValue));
end;

{ TCustomDrawStage_sw }

class function TCustomDrawStage_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDrawStage';
end;

class procedure TCustomDrawStage_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'cdPrePaint'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawStage.{$ENDIF}cdPrePaint)),
    (Name: 'cdPostPaint'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawStage.{$ENDIF}cdPostPaint)),
    (Name: 'cdPreErase'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawStage.{$ENDIF}cdPreErase)),
    (Name: 'cdPostErase'; Value: Integer({$IFDEF LMDSCT_12}TCustomDrawStage.{$ENDIF}cdPostErase))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TCustomDrawStage_sw.ToVar(
  const AValue: TCustomDrawStage): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCustomDrawStage_sw.FromVar(
  const AValue: OleVariant): TCustomDrawStage;
begin
  Result := TCustomDrawStage(Integer(AValue));
end;

{ THeaderSectionStyle_sw }

class function THeaderSectionStyle_sw.GetTypeName: WideString;
begin
  Result := 'THeaderSectionStyle';
end;

class procedure THeaderSectionStyle_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'hsText'; Value: Integer({$IFDEF LMDSCT_12}THeaderSectionStyle.{$ENDIF}hsText)),
    (Name: 'hsOwnerDraw'; Value: Integer({$IFDEF LMDSCT_12}THeaderSectionStyle.{$ENDIF}hsOwnerDraw))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function THeaderSectionStyle_sw.ToVar(
  const AValue: THeaderSectionStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THeaderSectionStyle_sw.FromVar(
  const AValue: OleVariant): THeaderSectionStyle;
begin
  Result := THeaderSectionStyle(Integer(AValue));
end;

{ THeaderSectionClass_sw }

class function THeaderSectionClass_sw.GetTypeName: WideString;
begin
  Result := 'THeaderSectionClass';
end;

class function THeaderSectionClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := THeaderSection;
end;

class function THeaderSectionClass_sw.ToVar(
  const AValue: THeaderSectionClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THeaderSectionClass_sw.FromVar(
  const AValue: OleVariant): THeaderSectionClass;
begin
  Result := THeaderSectionClass(ConvFromVar(AValue, THeaderSection));
end;

{ THeaderSection_sw }

function THeaderSection_ParentBiDiModeChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ParentBiDiModeChanged;

  THeaderSection(AObj).ParentBiDiModeChanged();
end;

function THeaderSection_UseRightToLeftAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftAlignment: Boolean;

  Result := THeaderSection(AObj).UseRightToLeftAlignment();
end;

function THeaderSection_UseRightToLeftReading_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftReading: Boolean;

  Result := THeaderSection(AObj).UseRightToLeftReading();
end;

function THeaderSection_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter>;

  Result := THeaderSection(AObj).Left;
end;

function THeaderSection_Right_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Right: Integer read <getter>;

  Result := THeaderSection(AObj).Right;
end;

function THeaderSection_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(THeaderSection(AObj).Alignment)
  else
    THeaderSection(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function THeaderSection_AllowClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowClick: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).AllowClick
  else
    THeaderSection(AObj).AllowClick := Boolean(AArgs[0]);
end;

function THeaderSection_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).AutoSize
  else
    THeaderSection(AObj).AutoSize := Boolean(AArgs[0]);
end;

function THeaderSection_BiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiMode: TBiDiMode read <getter> write <setter>;

  if IsGet then
    Result := TBiDiMode_sw.ToVar(THeaderSection(AObj).BiDiMode)
  else
    THeaderSection(AObj).BiDiMode := TBiDiMode_sw.FromVar(AArgs[0]);
end;

function THeaderSection_CheckBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CheckBox: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).CheckBox
  else
    THeaderSection(AObj).CheckBox := Boolean(AArgs[0]);
end;

function THeaderSection_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).Checked
  else
    THeaderSection(AObj).Checked := Boolean(AArgs[0]);
end;

function THeaderSection_FixedWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedWidth: Boolean read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).FixedWidth
  else
    THeaderSection(AObj).FixedWidth := Boolean(AArgs[0]);
end;

function THeaderSection_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(THeaderSection(AObj).ImageIndex)
  else
    THeaderSection(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function THeaderSection_MaxWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).MaxWidth
  else
    THeaderSection(AObj).MaxWidth := Integer(AArgs[0]);
end;

function THeaderSection_MinWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).MinWidth
  else
    THeaderSection(AObj).MinWidth := Integer(AArgs[0]);
end;

function THeaderSection_ParentBiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentBiDiMode: Boolean read <getter> write <set...

  if IsGet then
    Result := THeaderSection(AObj).ParentBiDiMode
  else
    THeaderSection(AObj).ParentBiDiMode := Boolean(AArgs[0]);
end;

function THeaderSection_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: THeaderSectionStyle read <getter> write <...

  if IsGet then
    Result := THeaderSectionStyle_sw.ToVar(THeaderSection(AObj).Style)
  else
    THeaderSection(AObj).Style := THeaderSectionStyle_sw.FromVar(AArgs[0]);
end;

function THeaderSection_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).Text
  else
    THeaderSection(AObj).Text := string(AArgs[0]);
end;

function THeaderSection_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := THeaderSection(AObj).Width
  else
    THeaderSection(AObj).Width := Integer(AArgs[0]);
end;

class function THeaderSection_sw.GetTypeName: WideString;
begin
  Result := 'THeaderSection';
end;

class function THeaderSection_sw.GetWrappedClass: TClass;
begin
  Result := THeaderSection;
end;

class procedure THeaderSection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ParentBiDiModeChanged', THeaderSection_ParentBiDiModeChanged_si, 0, False);
  AData.AddFunction('UseRightToLeftAlignment', THeaderSection_UseRightToLeftAlignment_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftReading', THeaderSection_UseRightToLeftReading_si, Boolean_sw, 0, False);
  AData.AddProperty('Left', THeaderSection_Left_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Right', THeaderSection_Right_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Alignment', THeaderSection_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('AllowClick', THeaderSection_AllowClick_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoSize', THeaderSection_AutoSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiMode', THeaderSection_BiDiMode_si, TBiDiMode_sw, True, True, 0, False, False);
  AData.AddProperty('CheckBox', THeaderSection_CheckBox_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Checked', THeaderSection_Checked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FixedWidth', THeaderSection_FixedWidth_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', THeaderSection_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('MaxWidth', THeaderSection_MaxWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinWidth', THeaderSection_MinWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ParentBiDiMode', THeaderSection_ParentBiDiMode_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Style', THeaderSection_Style_si, THeaderSectionStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Text', THeaderSection_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Width', THeaderSection_Width_si, Integer_sw, True, True, 0, False, False);
end;

class function THeaderSection_sw.ToVar(
  const AValue: THeaderSection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THeaderSection_sw.FromVar(
  const AValue: OleVariant): THeaderSection;
begin
  Result := THeaderSection(ConvFromVar(AValue, THeaderSection));
end;

class function THeaderSection_sw.ClassToVar(
  AClass: THeaderSection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THeaderSection_sw.ClassFromVar(
  const AClass: OleVariant): THeaderSection_sc;
begin
  Result := THeaderSection_sc(ConvClsFromVar(AClass, THeaderSection));
end;

{ THeaderSections_sw }

function THeaderSections_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(HeaderControl: TCustomHeaderControl);

  Result := THeaderSections_sw.ToVar(THeaderSections_sc(AObj).Create(
    TCustomHeaderControl_sw.FromVar(AArgs[0])));
end;

function THeaderSections_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: THeaderSection;

  Result := THeaderSection_sw.ToVar(THeaderSections(AObj).Add());
end;

function THeaderSections_AddItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddItem(Item: THeaderSection; Index: Integer): T...

  Result := THeaderSection_sw.ToVar(THeaderSections(AObj).AddItem(
    THeaderSection_sw.FromVar(AArgs[0]), Integer(AArgs[1])));
end;

function THeaderSections_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): THeaderSection;

  Result := THeaderSection_sw.ToVar(THeaderSections(AObj).Insert(Integer(
    AArgs[0])));
end;

function THeaderSections_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: THeaderSection read <gett...

  if IsGet then
    Result := THeaderSection_sw.ToVar(THeaderSections(AObj).Items[Integer(
      AArgs[0])])
  else
    THeaderSections(AObj).Items[Integer(AArgs[0])] := THeaderSection_sw.FromVar(
      AArgs[1]);
end;

class function THeaderSections_sw.GetTypeName: WideString;
begin
  Result := 'THeaderSections';
end;

class function THeaderSections_sw.GetWrappedClass: TClass;
begin
  Result := THeaderSections;
end;

class procedure THeaderSections_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', THeaderSections_Add_si, THeaderSection_sw, 0, False);
  AData.AddFunction('AddItem', THeaderSections_AddItem_si, THeaderSection_sw, 2, False);
  AData.AddFunction('Insert', THeaderSections_Insert_si, THeaderSection_sw, 1, False);
  AData.AddProperty('Items', THeaderSections_Items_si, THeaderSection_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', THeaderSections_Create_si, 1, False);
end;

class function THeaderSections_sw.ToVar(
  const AValue: THeaderSections): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THeaderSections_sw.FromVar(
  const AValue: OleVariant): THeaderSections;
begin
  Result := THeaderSections(ConvFromVar(AValue, THeaderSections));
end;

class function THeaderSections_sw.ClassToVar(
  AClass: THeaderSections_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THeaderSections_sw.ClassFromVar(
  const AClass: OleVariant): THeaderSections_sc;
begin
  Result := THeaderSections_sc(ConvClsFromVar(AClass, THeaderSections));
end;

{ TSectionTrackState_sw }

class function TSectionTrackState_sw.GetTypeName: WideString;
begin
  Result := 'TSectionTrackState';
end;

class procedure TSectionTrackState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'tsTrackBegin'; Value: Integer({$IFDEF LMDSCT_12}TSectionTrackState.{$ENDIF}tsTrackBegin)),
    (Name: 'tsTrackMove'; Value: Integer({$IFDEF LMDSCT_12}TSectionTrackState.{$ENDIF}tsTrackMove)),
    (Name: 'tsTrackEnd'; Value: Integer({$IFDEF LMDSCT_12}TSectionTrackState.{$ENDIF}tsTrackEnd))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TSectionTrackState_sw.ToVar(
  const AValue: TSectionTrackState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSectionTrackState_sw.FromVar(
  const AValue: OleVariant): TSectionTrackState;
begin
  Result := TSectionTrackState(Integer(AValue));
end;

{ TCustomDrawSectionEvent_sh }

function TCustomDrawSectionEvent_sh.GetHandler: TMethod;
var
  hdr: TCustomDrawSectionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCustomDrawSectionEvent_sh.Handler(
  HeaderControl: TCustomHeaderControl; Section: THeaderSection; const Rect: TRect;
  Pressed: Boolean);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (HeaderControl: TCustomHeaderControl; Section: ...

  args[0] := TCustomHeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  args[2] := TRect_sw.ToVar(Rect);
  args[3] := Pressed;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TCustomDrawSectionEvent_sw }

class function TCustomDrawSectionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDrawSectionEvent';
end;

class function TCustomDrawSectionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCustomDrawSectionEvent_sh;
end;

class function TCustomDrawSectionEvent_sw.ToVar(
  const AValue: TCustomDrawSectionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCustomDrawSectionEvent_sw.FromVar(
  const AValue: OleVariant): TCustomDrawSectionEvent;
begin
  Result := TCustomDrawSectionEvent(ConvFromVar(AValue));
end;

class function TCustomDrawSectionEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCustomDrawSectionEvent;
var
  hdlr: TCustomDrawSectionEvent_sh;
begin
  hdlr   := TCustomDrawSectionEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TCustomDrawSectionEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomSectionNotifyEvent_sh }

function TCustomSectionNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TCustomSectionNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCustomSectionNotifyEvent_sh.Handler(
  HeaderControl: TCustomHeaderControl; Section: THeaderSection);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (HeaderControl: TCustomHeaderControl; Section: ...

  args[0] := TCustomHeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TCustomSectionNotifyEvent_sw }

class function TCustomSectionNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCustomSectionNotifyEvent';
end;

class function TCustomSectionNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCustomSectionNotifyEvent_sh;
end;

class function TCustomSectionNotifyEvent_sw.ToVar(
  const AValue: TCustomSectionNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCustomSectionNotifyEvent_sw.FromVar(
  const AValue: OleVariant): TCustomSectionNotifyEvent;
begin
  Result := TCustomSectionNotifyEvent(ConvFromVar(AValue));
end;

class function TCustomSectionNotifyEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCustomSectionNotifyEvent;
var
  hdlr: TCustomSectionNotifyEvent_sh;
begin
  hdlr   := TCustomSectionNotifyEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TCustomSectionNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomSectionTrackEvent_sh }

function TCustomSectionTrackEvent_sh.GetHandler: TMethod;
var
  hdr: TCustomSectionTrackEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCustomSectionTrackEvent_sh.Handler(
  HeaderControl: TCustomHeaderControl; Section: THeaderSection; Width: Integer;
  State: TSectionTrackState);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (HeaderControl: TCustomHeaderControl; Section: ...

  args[0] := TCustomHeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  args[2] := Width;
  args[3] := TSectionTrackState_sw.ToVar(State);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TCustomSectionTrackEvent_sw }

class function TCustomSectionTrackEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCustomSectionTrackEvent';
end;

class function TCustomSectionTrackEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCustomSectionTrackEvent_sh;
end;

class function TCustomSectionTrackEvent_sw.ToVar(
  const AValue: TCustomSectionTrackEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCustomSectionTrackEvent_sw.FromVar(
  const AValue: OleVariant): TCustomSectionTrackEvent;
begin
  Result := TCustomSectionTrackEvent(ConvFromVar(AValue));
end;

class function TCustomSectionTrackEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCustomSectionTrackEvent;
var
  hdlr: TCustomSectionTrackEvent_sh;
begin
  hdlr   := TCustomSectionTrackEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TCustomSectionTrackEvent_sw));
  Result := hdlr.Handler;
end;

{ TSectionDragEvent_sh }

function TSectionDragEvent_sh.GetHandler: TMethod;
var
  hdr: TSectionDragEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSectionDragEvent_sh.Handler(Sender: TObject;
  FromSection: THeaderSection; ToSection: THeaderSection;
  var AllowDrag: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; FromSection: THeaderSection; ...

  v_1 := AllowDrag;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := THeaderSection_sw.ToVar(FromSection);
  args[2] := THeaderSection_sw.ToVar(ToSection);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowDrag := Boolean(v_1);
end;

{ TSectionDragEvent_sw }

class function TSectionDragEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSectionDragEvent';
end;

class function TSectionDragEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSectionDragEvent_sh;
end;

class function TSectionDragEvent_sw.ToVar(
  const AValue: TSectionDragEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSectionDragEvent_sw.FromVar(
  const AValue: OleVariant): TSectionDragEvent;
begin
  Result := TSectionDragEvent(ConvFromVar(AValue));
end;

class function TSectionDragEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TSectionDragEvent;
var
  hdlr: TSectionDragEvent_sh;
begin
  hdlr   := TSectionDragEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSectionDragEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomHCCreateSectionClassEvent_sh }

function TCustomHCCreateSectionClassEvent_sh.GetHandler: TMethod;
var
  hdr: TCustomHCCreateSectionClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCustomHCCreateSectionClassEvent_sh.Handler(
  Sender: TCustomHeaderControl; var SectionClass: THeaderSectionClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomHeaderControl; var SectionClass...

  v_1 := THeaderSectionClass_sw.ToVar(SectionClass);
  args[0] := TCustomHeaderControl_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  SectionClass := THeaderSectionClass_sw.FromVar(v_1);
end;

{ TCustomHCCreateSectionClassEvent_sw }

class function TCustomHCCreateSectionClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHCCreateSectionClassEvent';
end;

class function TCustomHCCreateSectionClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCustomHCCreateSectionClassEvent_sh;
end;

class function TCustomHCCreateSectionClassEvent_sw.ToVar(
  const AValue: TCustomHCCreateSectionClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCustomHCCreateSectionClassEvent_sw.FromVar(
  const AValue: OleVariant): TCustomHCCreateSectionClassEvent;
begin
  Result := TCustomHCCreateSectionClassEvent(ConvFromVar(AValue));
end;

class function TCustomHCCreateSectionClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCustomHCCreateSectionClassEvent;
var
  hdlr: TCustomHCCreateSectionClassEvent_sh;
begin
  hdlr   := TCustomHCCreateSectionClassEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TCustomHCCreateSectionClassEvent_sw));
  Result := hdlr.Handler;
end;

{ THeaderStyle_sw }

class function THeaderStyle_sw.GetTypeName: WideString;
begin
  Result := 'THeaderStyle';
end;

class procedure THeaderStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'hsButtons'; Value: Integer({$IFDEF LMDSCT_12}THeaderStyle.{$ENDIF}hsButtons)),
    (Name: 'hsFlat'; Value: Integer({$IFDEF LMDSCT_12}THeaderStyle.{$ENDIF}hsFlat))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function THeaderStyle_sw.ToVar(const AValue: THeaderStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THeaderStyle_sw.FromVar(const AValue: OleVariant): THeaderStyle;
begin
  Result := THeaderStyle(Integer(AValue));
end;

{ TCustomHeaderControl_sw }

function TCustomHeaderControl_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomHeaderControl(AObj).Canvas);
end;

function TCustomHeaderControl_DragReorder_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragReorder: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).DragReorder
  else
    TCustomHeaderControl(AObj).DragReorder := Boolean(AArgs[0]);
end;

function TCustomHeaderControl_FullDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FullDrag: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).FullDrag
  else
    TCustomHeaderControl(AObj).FullDrag := Boolean(AArgs[0]);
end;

function TCustomHeaderControl_HotTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HotTrack: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).HotTrack
  else
    TCustomHeaderControl(AObj).HotTrack := Boolean(AArgs[0]);
end;

function TCustomHeaderControl_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomHeaderControl(AObj).Images)
  else
    TCustomHeaderControl(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomHeaderControl_Sections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sections: THeaderSections read <getter> write <s...

  if IsGet then
    Result := THeaderSections_sw.ToVar(TCustomHeaderControl(AObj).Sections)
  else
    TCustomHeaderControl(AObj).Sections := THeaderSections_sw.FromVar(AArgs[0]);
end;

function TCustomHeaderControl_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: THeaderStyle read <getter> write <setter>;

  if IsGet then
    Result := THeaderStyle_sw.ToVar(TCustomHeaderControl(AObj).Style)
  else
    TCustomHeaderControl(AObj).Style := THeaderStyle_sw.FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnCreateSectionClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCreateSectionClass: TCustomHCCreateSectionClas...

  if IsGet then
    Result := TCustomHCCreateSectionClassEvent_sw.ToVar(TCustomHeaderControl(
      AObj).OnCreateSectionClass)
  else
    TCustomHeaderControl(AObj).OnCreateSectionClass := 
      TCustomHCCreateSectionClassEvent_sw.FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnDrawSection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawSection: TCustomDrawSectionEvent read <get...

  if IsGet then
    Result := TCustomDrawSectionEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnDrawSection)
  else
    TCustomHeaderControl(AObj).OnDrawSection := TCustomDrawSectionEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnSectionClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionClick: TCustomSectionNotifyEvent read <...

  if IsGet then
    Result := TCustomSectionNotifyEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnSectionClick)
  else
    TCustomHeaderControl(AObj).OnSectionClick := TCustomSectionNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnSectionCheck_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionCheck: TCustomSectionNotifyEvent read <...

  if IsGet then
    Result := TCustomSectionNotifyEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnSectionCheck)
  else
    TCustomHeaderControl(AObj).OnSectionCheck := TCustomSectionNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnSectionDrag_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionDrag: TSectionDragEvent read <getter> w...

  if IsGet then
    Result := TSectionDragEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnSectionDrag)
  else
    TCustomHeaderControl(AObj).OnSectionDrag := TSectionDragEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomHeaderControl_OnSectionEndDrag_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionEndDrag: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomHeaderControl(AObj).OnSectionEndDrag)
  else
    TCustomHeaderControl(AObj).OnSectionEndDrag := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomHeaderControl_OnSectionResize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionResize: TCustomSectionNotifyEvent read ...

  if IsGet then
    Result := TCustomSectionNotifyEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnSectionResize)
  else
    TCustomHeaderControl(AObj).OnSectionResize := TCustomSectionNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomHeaderControl_OnSectionTrack_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionTrack: TCustomSectionTrackEvent read <g...

  if IsGet then
    Result := TCustomSectionTrackEvent_sw.ToVar(TCustomHeaderControl(AObj).
      OnSectionTrack)
  else
    TCustomHeaderControl(AObj).OnSectionTrack := TCustomSectionTrackEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomHeaderControl_CheckBoxes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CheckBoxes: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).CheckBoxes
  else
    TCustomHeaderControl(AObj).CheckBoxes := Boolean(AArgs[0]);
end;

function TCustomHeaderControl_NoSizing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NoSizing: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).NoSizing
  else
    TCustomHeaderControl(AObj).NoSizing := Boolean(AArgs[0]);
end;

function TCustomHeaderControl_OverFlow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OverFlow: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomHeaderControl(AObj).OverFlow
  else
    TCustomHeaderControl(AObj).OverFlow := Boolean(AArgs[0]);
end;

class function TCustomHeaderControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHeaderControl';
end;

class function TCustomHeaderControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomHeaderControl;
end;

class procedure TCustomHeaderControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TCustomHeaderControl_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DragReorder', TCustomHeaderControl_DragReorder_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FullDrag', TCustomHeaderControl_FullDrag_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HotTrack', TCustomHeaderControl_HotTrack_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('Images', TCustomHeaderControl_Images_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('Sections', TCustomHeaderControl_Sections_si, THeaderSections_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TCustomHeaderControl_Style_si, THeaderStyle_sw, True, True, 0, False, False);
  AData.AddProperty('OnCreateSectionClass', TCustomHeaderControl_OnCreateSectionClass_si, TCustomHCCreateSectionClassEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawSection', TCustomHeaderControl_OnDrawSection_si, TCustomDrawSectionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionClick', TCustomHeaderControl_OnSectionClick_si, TCustomSectionNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionCheck', TCustomHeaderControl_OnSectionCheck_si, TCustomSectionNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionDrag', TCustomHeaderControl_OnSectionDrag_si, TSectionDragEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionEndDrag', TCustomHeaderControl_OnSectionEndDrag_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionResize', TCustomHeaderControl_OnSectionResize_si, TCustomSectionNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionTrack', TCustomHeaderControl_OnSectionTrack_si, TCustomSectionTrackEvent_sw, True, True, 0, False, False);
  AData.AddProperty('CheckBoxes', TCustomHeaderControl_CheckBoxes_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('NoSizing', TCustomHeaderControl_NoSizing_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OverFlow', TCustomHeaderControl_OverFlow_si, Boolean_sw, True, True, 0, False, False);
end;

class function TCustomHeaderControl_sw.ToVar(
  const AValue: TCustomHeaderControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomHeaderControl_sw.FromVar(
  const AValue: OleVariant): TCustomHeaderControl;
begin
  Result := TCustomHeaderControl(ConvFromVar(AValue, TCustomHeaderControl));
end;

class function TCustomHeaderControl_sw.ClassToVar(
  AClass: TCustomHeaderControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomHeaderControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomHeaderControl_sc;
begin
  Result := TCustomHeaderControl_sc(ConvClsFromVar(AClass, 
    TCustomHeaderControl));
end;

{ TDrawSectionEvent_sh }

function TDrawSectionEvent_sh.GetHandler: TMethod;
var
  hdr: TDrawSectionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDrawSectionEvent_sh.Handler(HeaderControl: THeaderControl;
  Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (HeaderControl: THeaderControl; Section: THeade...

  args[0] := THeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  args[2] := TRect_sw.ToVar(Rect);
  args[3] := Pressed;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDrawSectionEvent_sw }

class function TDrawSectionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDrawSectionEvent';
end;

class function TDrawSectionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDrawSectionEvent_sh;
end;

class function TDrawSectionEvent_sw.ToVar(
  const AValue: TDrawSectionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDrawSectionEvent_sw.FromVar(
  const AValue: OleVariant): TDrawSectionEvent;
begin
  Result := TDrawSectionEvent(ConvFromVar(AValue));
end;

class function TDrawSectionEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TDrawSectionEvent;
var
  hdlr: TDrawSectionEvent_sh;
begin
  hdlr   := TDrawSectionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDrawSectionEvent_sw));
  Result := hdlr.Handler;
end;

{ TSectionNotifyEvent_sh }

function TSectionNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TSectionNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSectionNotifyEvent_sh.Handler(HeaderControl: THeaderControl;
  Section: THeaderSection);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (HeaderControl: THeaderControl; Section: THeade...

  args[0] := THeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TSectionNotifyEvent_sw }

class function TSectionNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSectionNotifyEvent';
end;

class function TSectionNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSectionNotifyEvent_sh;
end;

class function TSectionNotifyEvent_sw.ToVar(
  const AValue: TSectionNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSectionNotifyEvent_sw.FromVar(
  const AValue: OleVariant): TSectionNotifyEvent;
begin
  Result := TSectionNotifyEvent(ConvFromVar(AValue));
end;

class function TSectionNotifyEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TSectionNotifyEvent;
var
  hdlr: TSectionNotifyEvent_sh;
begin
  hdlr   := TSectionNotifyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSectionNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TSectionTrackEvent_sh }

function TSectionTrackEvent_sh.GetHandler: TMethod;
var
  hdr: TSectionTrackEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSectionTrackEvent_sh.Handler(HeaderControl: THeaderControl;
  Section: THeaderSection; Width: Integer; State: TSectionTrackState);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (HeaderControl: THeaderControl; Section: THeade...

  args[0] := THeaderControl_sw.ToVar(HeaderControl);
  args[1] := THeaderSection_sw.ToVar(Section);
  args[2] := Width;
  args[3] := TSectionTrackState_sw.ToVar(State);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TSectionTrackEvent_sw }

class function TSectionTrackEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSectionTrackEvent';
end;

class function TSectionTrackEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSectionTrackEvent_sh;
end;

class function TSectionTrackEvent_sw.ToVar(
  const AValue: TSectionTrackEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSectionTrackEvent_sw.FromVar(
  const AValue: OleVariant): TSectionTrackEvent;
begin
  Result := TSectionTrackEvent(ConvFromVar(AValue));
end;

class function TSectionTrackEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TSectionTrackEvent;
var
  hdlr: TSectionTrackEvent_sh;
begin
  hdlr   := TSectionTrackEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSectionTrackEvent_sw));
  Result := hdlr.Handler;
end;

{ THCCreateSectionClassEvent_sh }

function THCCreateSectionClassEvent_sh.GetHandler: TMethod;
var
  hdr: THCCreateSectionClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure THCCreateSectionClassEvent_sh.Handler(Sender: THeaderControl;
  var SectionClass: THeaderSectionClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: THeaderControl; var SectionClass: THea...

  v_1 := THeaderSectionClass_sw.ToVar(SectionClass);
  args[0] := THeaderControl_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  SectionClass := THeaderSectionClass_sw.FromVar(v_1);
end;

{ THCCreateSectionClassEvent_sw }

class function THCCreateSectionClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'THCCreateSectionClassEvent';
end;

class function THCCreateSectionClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := THCCreateSectionClassEvent_sh;
end;

class function THCCreateSectionClassEvent_sw.ToVar(
  const AValue: THCCreateSectionClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function THCCreateSectionClassEvent_sw.FromVar(
  const AValue: OleVariant): THCCreateSectionClassEvent;
begin
  Result := THCCreateSectionClassEvent(ConvFromVar(AValue));
end;

class function THCCreateSectionClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): THCCreateSectionClassEvent;
var
  hdlr: THCCreateSectionClassEvent_sh;
begin
  hdlr   := THCCreateSectionClassEvent_sh(AScriptControl.GetEventHandler(
    AProcName, THCCreateSectionClassEvent_sw));
  Result := hdlr.Handler;
end;

{ THeaderControl_sw }

function THeaderControl_OnDrawSection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawSection: TDrawSectionEvent read <getter> w...

  if IsGet then
    Result := TDrawSectionEvent_sw.ToVar(THeaderControl(AObj).OnDrawSection)
  else
    THeaderControl(AObj).OnDrawSection := TDrawSectionEvent_sw.FromVar(
      AArgs[0]);
end;

function THeaderControl_OnSectionClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionClick: TSectionNotifyEvent read <getter...

  if IsGet then
    Result := TSectionNotifyEvent_sw.ToVar(THeaderControl(AObj).OnSectionClick)
  else
    THeaderControl(AObj).OnSectionClick := TSectionNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function THeaderControl_OnSectionResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionResize: TSectionNotifyEvent read <gette...

  if IsGet then
    Result := TSectionNotifyEvent_sw.ToVar(THeaderControl(AObj).OnSectionResize)
  else
    THeaderControl(AObj).OnSectionResize := TSectionNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function THeaderControl_OnSectionTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSectionTrack: TSectionTrackEvent read <getter>...

  if IsGet then
    Result := TSectionTrackEvent_sw.ToVar(THeaderControl(AObj).OnSectionTrack)
  else
    THeaderControl(AObj).OnSectionTrack := TSectionTrackEvent_sw.FromVar(
      AArgs[0]);
end;

class function THeaderControl_sw.GetTypeName: WideString;
begin
  Result := 'THeaderControl';
end;

class function THeaderControl_sw.GetWrappedClass: TClass;
begin
  Result := THeaderControl;
end;

class procedure THeaderControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('DragReorder', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('FullDrag', False);
  AData.AddPropertyRedecl('HotTrack', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Sections', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnCreateSectionClass', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddProperty('OnDrawSection', THeaderControl_OnDrawSection_si, TDrawSectionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionClick', THeaderControl_OnSectionClick_si, TSectionNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionResize', THeaderControl_OnSectionResize_si, TSectionNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSectionTrack', THeaderControl_OnSectionTrack_si, TSectionTrackEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnSectionDrag', False);
  AData.AddPropertyRedecl('OnSectionEndDrag', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function THeaderControl_sw.ToVar(
  const AValue: THeaderControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THeaderControl_sw.FromVar(
  const AValue: OleVariant): THeaderControl;
begin
  Result := THeaderControl(ConvFromVar(AValue, THeaderControl));
end;

class function THeaderControl_sw.ClassToVar(
  AClass: THeaderControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THeaderControl_sw.ClassFromVar(
  const AClass: OleVariant): THeaderControl_sc;
begin
  Result := THeaderControl_sc(ConvClsFromVar(AClass, THeaderControl));
end;

{ TNodeState_sw }

class function TNodeState_sw.GetTypeName: WideString;
begin
  Result := 'TNodeState';
end;

class procedure TNodeState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'nsCut'; Value: Integer({$IFDEF LMDSCT_12}TNodeState.{$ENDIF}nsCut)),
    (Name: 'nsDropHilited'; Value: Integer({$IFDEF LMDSCT_12}TNodeState.{$ENDIF}nsDropHilited)),
    (Name: 'nsFocused'; Value: Integer({$IFDEF LMDSCT_12}TNodeState.{$ENDIF}nsFocused)),
    (Name: 'nsSelected'; Value: Integer({$IFDEF LMDSCT_12}TNodeState.{$ENDIF}nsSelected)),
    (Name: 'nsExpanded'; Value: Integer({$IFDEF LMDSCT_12}TNodeState.{$ENDIF}nsExpanded))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TNodeState_sw.ToVar(const AValue: TNodeState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNodeState_sw.FromVar(const AValue: OleVariant): TNodeState;
begin
  Result := TNodeState(Integer(AValue));
end;

{ TNodeAttachMode_sw }

class function TNodeAttachMode_sw.GetTypeName: WideString;
begin
  Result := 'TNodeAttachMode';
end;

class procedure TNodeAttachMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'naAdd'; Value: Integer({$IFDEF LMDSCT_12}TNodeAttachMode.{$ENDIF}naAdd)),
    (Name: 'naAddFirst'; Value: Integer({$IFDEF LMDSCT_12}TNodeAttachMode.{$ENDIF}naAddFirst)),
    (Name: 'naAddChild'; Value: Integer({$IFDEF LMDSCT_12}TNodeAttachMode.{$ENDIF}naAddChild)),
    (Name: 'naAddChildFirst'; Value: Integer({$IFDEF LMDSCT_12}TNodeAttachMode.{$ENDIF}naAddChildFirst)),
    (Name: 'naInsert'; Value: Integer({$IFDEF LMDSCT_12}TNodeAttachMode.{$ENDIF}naInsert))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TNodeAttachMode_sw.ToVar(
  const AValue: TNodeAttachMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNodeAttachMode_sw.FromVar(
  const AValue: OleVariant): TNodeAttachMode;
begin
  Result := TNodeAttachMode(Integer(AValue));
end;

{ TAddMode_sw }

class function TAddMode_sw.GetTypeName: WideString;
begin
  Result := 'TAddMode';
end;

class procedure TAddMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'taAddFirst'; Value: Integer({$IFDEF LMDSCT_12}TAddMode.{$ENDIF}taAddFirst)),
    (Name: 'taAdd'; Value: Integer({$IFDEF LMDSCT_12}TAddMode.{$ENDIF}taAdd)),
    (Name: 'taInsert'; Value: Integer({$IFDEF LMDSCT_12}TAddMode.{$ENDIF}taInsert))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TAddMode_sw.ToVar(const AValue: TAddMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAddMode_sw.FromVar(const AValue: OleVariant): TAddMode;
begin
  Result := TAddMode(Integer(AValue));
end;

{ TNodeInfo_sw }

function TNodeInfo_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.ImageIndex
  else
    TNodeInfo_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeInfo_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.SelectedIndex
  else
    TNodeInfo_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeInfo_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.StateIndex
  else
    TNodeInfo_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeInfo_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.OverlayIndex
  else
    TNodeInfo_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeInfo_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Data: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.Data
  else
    TNodeInfo_sw(AObj).FValue.Data := Integer(AArgs[0]);
end;

function TNodeInfo_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.Count
  else
    TNodeInfo_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeInfo_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Text: string;

  if IsGet then
    Result := TNodeInfo_sw(AObj).FValue.Text
  else
    TNodeInfo_sw(AObj).FValue.Text := string(AArgs[0]);
end;

function TNodeInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeInfo_sw.Create as IDispatch;
end;

function TNodeInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeInfo;

  // Implicit record copy method.
  Result := TNodeInfo_sw.ToVar(TNodeInfo(AObj));
end;

class function TNodeInfo_sw.GetTypeName: WideString;
begin
  Result := 'TNodeInfo';
end;

function TNodeInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeInfo_sw.Create;
  TNodeInfo_sw(Result).FValue := FValue;
end;

class procedure TNodeInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeInfo_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeInfo_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeInfo_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeInfo_OverlayIndex_si, Integer_sw);
  AData.AddField('Data', TNodeInfo_Data_si, Integer_sw);
  AData.AddField('Count', TNodeInfo_Count_si, Integer_sw);
  AData.AddField('Text', TNodeInfo_Text_si, string_sw);
  AData.AddFunction('Copy', TNodeInfo_Copy_si, TNodeInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeInfo_Create_si, 0, False);
end;

class function TNodeInfo_sw.ToVar(const AValue: TNodeInfo): OleVariant;
var
  wrpr: TNodeInfo_sw;
begin
  wrpr        := TNodeInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeInfo_sw.FromVar(const AValue: OleVariant): TNodeInfo;
begin
  Result := TNodeInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataInfo_sw }

function TNodeDataInfo_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.ImageIndex
  else
    TNodeDataInfo_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.SelectedIndex
  else
    TNodeDataInfo_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.StateIndex
  else
    TNodeDataInfo_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.OverlayIndex
  else
    TNodeDataInfo_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.Count
  else
    TNodeDataInfo_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeDataInfo_TextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TextLen: Byte;

  if IsGet then
    Result := TNodeDataInfo_sw(AObj).FValue.TextLen
  else
    TNodeDataInfo_sw(AObj).FValue.TextLen := Byte(AArgs[0]);
end;

function TNodeDataInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeDataInfo_sw.Create as IDispatch;
end;

function TNodeDataInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeDataInfo;

  // Implicit record copy method.
  Result := TNodeDataInfo_sw.ToVar(TNodeDataInfo(AObj));
end;

class function TNodeDataInfo_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataInfo';
end;

function TNodeDataInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeDataInfo_sw.Create;
  TNodeDataInfo_sw(Result).FValue := FValue;
end;

class procedure TNodeDataInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeDataInfo_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeDataInfo_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeDataInfo_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeDataInfo_OverlayIndex_si, Integer_sw);
  AData.AddField('Count', TNodeDataInfo_Count_si, Integer_sw);
  AData.AddField('TextLen', TNodeDataInfo_TextLen_si, Byte_sw);
  AData.AddFunction('Copy', TNodeDataInfo_Copy_si, TNodeDataInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeDataInfo_Create_si, 0, False);
end;

class function TNodeDataInfo_sw.ToVar(const AValue: TNodeDataInfo): OleVariant;
var
  wrpr: TNodeDataInfo_sw;
begin
  wrpr        := TNodeDataInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeDataInfo_sw.FromVar(
  const AValue: OleVariant): TNodeDataInfo;
begin
  Result := TNodeDataInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataInfoX86_sw }

function TNodeDataInfoX86_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.ImageIndex
  else
    TNodeDataInfoX86_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.SelectedIndex
  else
    TNodeDataInfoX86_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.StateIndex
  else
    TNodeDataInfoX86_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.OverlayIndex
  else
    TNodeDataInfoX86_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Data: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.Data
  else
    TNodeDataInfoX86_sw(AObj).FValue.Data := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.Count
  else
    TNodeDataInfoX86_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeDataInfoX86_TextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TextLen: Byte;

  if IsGet then
    Result := TNodeDataInfoX86_sw(AObj).FValue.TextLen
  else
    TNodeDataInfoX86_sw(AObj).FValue.TextLen := Byte(AArgs[0]);
end;

function TNodeDataInfoX86_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeDataInfoX86_sw.Create as IDispatch;
end;

function TNodeDataInfoX86_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeDataInfoX86;

  // Implicit record copy method.
  Result := TNodeDataInfoX86_sw.ToVar(TNodeDataInfoX86(AObj));
end;

class function TNodeDataInfoX86_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataInfoX86';
end;

function TNodeDataInfoX86_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeDataInfoX86_sw.Create;
  TNodeDataInfoX86_sw(Result).FValue := FValue;
end;

class procedure TNodeDataInfoX86_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeDataInfoX86_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeDataInfoX86_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeDataInfoX86_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeDataInfoX86_OverlayIndex_si, Integer_sw);
  AData.AddField('Data', TNodeDataInfoX86_Data_si, Integer_sw);
  AData.AddField('Count', TNodeDataInfoX86_Count_si, Integer_sw);
  AData.AddField('TextLen', TNodeDataInfoX86_TextLen_si, Byte_sw);
  AData.AddFunction('Copy', TNodeDataInfoX86_Copy_si, TNodeDataInfoX86_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeDataInfoX86_Create_si, 0, False);
end;

class function TNodeDataInfoX86_sw.ToVar(
  const AValue: TNodeDataInfoX86): OleVariant;
var
  wrpr: TNodeDataInfoX86_sw;
begin
  wrpr        := TNodeDataInfoX86_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeDataInfoX86_sw.FromVar(
  const AValue: OleVariant): TNodeDataInfoX86;
begin
  Result := TNodeDataInfoX86_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataInfo2_sw }

function TNodeDataInfo2_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.ImageIndex
  else
    TNodeDataInfo2_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.SelectedIndex
  else
    TNodeDataInfo2_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.StateIndex
  else
    TNodeDataInfo2_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.OverlayIndex
  else
    TNodeDataInfo2_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2_ExpandedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExpandedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.ExpandedIndex
  else
    TNodeDataInfo2_sw(AObj).FValue.ExpandedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.Count
  else
    TNodeDataInfo2_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeDataInfo2_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Enabled: Byte;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.Enabled
  else
    TNodeDataInfo2_sw(AObj).FValue.Enabled := Byte(AArgs[0]);
end;

function TNodeDataInfo2_TextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TextLen: Byte;

  if IsGet then
    Result := TNodeDataInfo2_sw(AObj).FValue.TextLen
  else
    TNodeDataInfo2_sw(AObj).FValue.TextLen := Byte(AArgs[0]);
end;

function TNodeDataInfo2_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeDataInfo2_sw.Create as IDispatch;
end;

function TNodeDataInfo2_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeDataInfo2;

  // Implicit record copy method.
  Result := TNodeDataInfo2_sw.ToVar(TNodeDataInfo2(AObj));
end;

class function TNodeDataInfo2_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataInfo2';
end;

function TNodeDataInfo2_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeDataInfo2_sw.Create;
  TNodeDataInfo2_sw(Result).FValue := FValue;
end;

class procedure TNodeDataInfo2_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeDataInfo2_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeDataInfo2_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeDataInfo2_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeDataInfo2_OverlayIndex_si, Integer_sw);
  AData.AddField('ExpandedIndex', TNodeDataInfo2_ExpandedIndex_si, Integer_sw);
  AData.AddField('Count', TNodeDataInfo2_Count_si, Integer_sw);
  AData.AddField('Enabled', TNodeDataInfo2_Enabled_si, Byte_sw);
  AData.AddField('TextLen', TNodeDataInfo2_TextLen_si, Byte_sw);
  AData.AddFunction('Copy', TNodeDataInfo2_Copy_si, TNodeDataInfo2_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeDataInfo2_Create_si, 0, False);
end;

class function TNodeDataInfo2_sw.ToVar(
  const AValue: TNodeDataInfo2): OleVariant;
var
  wrpr: TNodeDataInfo2_sw;
begin
  wrpr        := TNodeDataInfo2_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeDataInfo2_sw.FromVar(
  const AValue: OleVariant): TNodeDataInfo2;
begin
  Result := TNodeDataInfo2_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataInfo2x86_sw }

function TNodeDataInfo2x86_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.ImageIndex
  else
    TNodeDataInfo2x86_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.SelectedIndex
  else
    TNodeDataInfo2x86_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.StateIndex
  else
    TNodeDataInfo2x86_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.OverlayIndex
  else
    TNodeDataInfo2x86_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_ExpandedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExpandedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.ExpandedIndex
  else
    TNodeDataInfo2x86_sw(AObj).FValue.ExpandedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Data: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.Data
  else
    TNodeDataInfo2x86_sw(AObj).FValue.Data := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.Count
  else
    TNodeDataInfo2x86_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeDataInfo2x86_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Enabled: Byte;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.Enabled
  else
    TNodeDataInfo2x86_sw(AObj).FValue.Enabled := Byte(AArgs[0]);
end;

function TNodeDataInfo2x86_TextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TextLen: Byte;

  if IsGet then
    Result := TNodeDataInfo2x86_sw(AObj).FValue.TextLen
  else
    TNodeDataInfo2x86_sw(AObj).FValue.TextLen := Byte(AArgs[0]);
end;

function TNodeDataInfo2x86_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeDataInfo2x86_sw.Create as IDispatch;
end;

function TNodeDataInfo2x86_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeDataInfo2x86;

  // Implicit record copy method.
  Result := TNodeDataInfo2x86_sw.ToVar(TNodeDataInfo2x86(AObj));
end;

class function TNodeDataInfo2x86_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataInfo2x86';
end;

function TNodeDataInfo2x86_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeDataInfo2x86_sw.Create;
  TNodeDataInfo2x86_sw(Result).FValue := FValue;
end;

class procedure TNodeDataInfo2x86_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeDataInfo2x86_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeDataInfo2x86_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeDataInfo2x86_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeDataInfo2x86_OverlayIndex_si, Integer_sw);
  AData.AddField('ExpandedIndex', TNodeDataInfo2x86_ExpandedIndex_si, Integer_sw);
  AData.AddField('Data', TNodeDataInfo2x86_Data_si, Integer_sw);
  AData.AddField('Count', TNodeDataInfo2x86_Count_si, Integer_sw);
  AData.AddField('Enabled', TNodeDataInfo2x86_Enabled_si, Byte_sw);
  AData.AddField('TextLen', TNodeDataInfo2x86_TextLen_si, Byte_sw);
  AData.AddFunction('Copy', TNodeDataInfo2x86_Copy_si, TNodeDataInfo2x86_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeDataInfo2x86_Create_si, 0, False);
end;

class function TNodeDataInfo2x86_sw.ToVar(
  const AValue: TNodeDataInfo2x86): OleVariant;
var
  wrpr: TNodeDataInfo2x86_sw;
begin
  wrpr        := TNodeDataInfo2x86_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeDataInfo2x86_sw.FromVar(
  const AValue: OleVariant): TNodeDataInfo2x86;
begin
  Result := TNodeDataInfo2x86_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataInfo2x64_sw }

function TNodeDataInfo2x64_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImageIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.ImageIndex
  else
    TNodeDataInfo2x64_sw(AObj).FValue.ImageIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SelectedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.SelectedIndex
  else
    TNodeDataInfo2x64_sw(AObj).FValue.SelectedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var StateIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.StateIndex
  else
    TNodeDataInfo2x64_sw(AObj).FValue.StateIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OverlayIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.OverlayIndex
  else
    TNodeDataInfo2x64_sw(AObj).FValue.OverlayIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_ExpandedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExpandedIndex: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.ExpandedIndex
  else
    TNodeDataInfo2x64_sw(AObj).FValue.ExpandedIndex := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Data: Int64;

  if IsGet then
    Result := Int64_sw.ToVar(TNodeDataInfo2x64_sw(AObj).FValue.Data)
  else
    TNodeDataInfo2x64_sw(AObj).FValue.Data := Int64_sw.FromVar(AArgs[0]);
end;

function TNodeDataInfo2x64_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Integer;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.Count
  else
    TNodeDataInfo2x64_sw(AObj).FValue.Count := Integer(AArgs[0]);
end;

function TNodeDataInfo2x64_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Enabled: Byte;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.Enabled
  else
    TNodeDataInfo2x64_sw(AObj).FValue.Enabled := Byte(AArgs[0]);
end;

function TNodeDataInfo2x64_TextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TextLen: Byte;

  if IsGet then
    Result := TNodeDataInfo2x64_sw(AObj).FValue.TextLen
  else
    TNodeDataInfo2x64_sw(AObj).FValue.TextLen := Byte(AArgs[0]);
end;

function TNodeDataInfo2x64_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeDataInfo2x64_sw.Create as IDispatch;
end;

function TNodeDataInfo2x64_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeDataInfo2x64;

  // Implicit record copy method.
  Result := TNodeDataInfo2x64_sw.ToVar(TNodeDataInfo2x64(AObj));
end;

class function TNodeDataInfo2x64_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataInfo2x64';
end;

function TNodeDataInfo2x64_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeDataInfo2x64_sw.Create;
  TNodeDataInfo2x64_sw(Result).FValue := FValue;
end;

class procedure TNodeDataInfo2x64_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ImageIndex', TNodeDataInfo2x64_ImageIndex_si, Integer_sw);
  AData.AddField('SelectedIndex', TNodeDataInfo2x64_SelectedIndex_si, Integer_sw);
  AData.AddField('StateIndex', TNodeDataInfo2x64_StateIndex_si, Integer_sw);
  AData.AddField('OverlayIndex', TNodeDataInfo2x64_OverlayIndex_si, Integer_sw);
  AData.AddField('ExpandedIndex', TNodeDataInfo2x64_ExpandedIndex_si, Integer_sw);
  AData.AddField('Data', TNodeDataInfo2x64_Data_si, Int64_sw);
  AData.AddField('Count', TNodeDataInfo2x64_Count_si, Integer_sw);
  AData.AddField('Enabled', TNodeDataInfo2x64_Enabled_si, Byte_sw);
  AData.AddField('TextLen', TNodeDataInfo2x64_TextLen_si, Byte_sw);
  AData.AddFunction('Copy', TNodeDataInfo2x64_Copy_si, TNodeDataInfo2x64_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeDataInfo2x64_Create_si, 0, False);
end;

class function TNodeDataInfo2x64_sw.ToVar(
  const AValue: TNodeDataInfo2x64): OleVariant;
var
  wrpr: TNodeDataInfo2x64_sw;
begin
  wrpr        := TNodeDataInfo2x64_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeDataInfo2x64_sw.FromVar(
  const AValue: OleVariant): TNodeDataInfo2x64;
begin
  Result := TNodeDataInfo2x64_sw(ConvFromVar(AValue)).FValue;
end;

{ TNodeDataType_sw }

class function TNodeDataType_sw.GetTypeName: WideString;
begin
  Result := 'TNodeDataType';
end;

class procedure TNodeDataType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'ndtDefault'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndtDefault)),
    (Name: 'ndtDefault2'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndtDefault2)),
    (Name: 'ndt32bit'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndt32bit)),
    (Name: 'ndt64bit'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndt64bit)),
    (Name: 'ndt232bit'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndt232bit)),
    (Name: 'ndt264bit'; Value: Integer({$IFDEF LMDSCT_12}TNodeDataType.{$ENDIF}ndt264bit))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TNodeDataType_sw.ToVar(const AValue: TNodeDataType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNodeDataType_sw.FromVar(
  const AValue: OleVariant): TNodeDataType;
begin
  Result := TNodeDataType(Integer(AValue));
end;

{ TTVItemStateEx_sw }

class function TTVItemStateEx_sw.GetTypeName: WideString;
begin
  Result := 'TTVItemStateEx';
end;

class procedure TTVItemStateEx_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tviDisabled'; Value: Integer({$IFDEF LMDSCT_12}TTVItemStateEx.{$ENDIF}tviDisabled)),
    (Name: 'tviFlat'; Value: Integer({$IFDEF LMDSCT_12}TTVItemStateEx.{$ENDIF}tviFlat))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTVItemStateEx_sw.ToVar(
  const AValue: TTVItemStateEx): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTVItemStateEx_sw.FromVar(
  const AValue: OleVariant): TTVItemStateEx;
begin
  Result := TTVItemStateEx(Integer(AValue));
end;

{ TTVItemStateExSet_sw }

class function TTVItemStateExSet_sw.GetTypeName: WideString;
begin
  Result := 'TTVItemStateExSet';
end;

class function TTVItemStateExSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTVItemStateExSet);
end;

class function TTVItemStateExSet_sw.ToVar(
  const AValue: TTVItemStateExSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTVItemStateExSet_sw.FromVar(
  const AValue: OleVariant): TTVItemStateExSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTreeNodeClass_sw }

class function TTreeNodeClass_sw.GetTypeName: WideString;
begin
  Result := 'TTreeNodeClass';
end;

class function TTreeNodeClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TTreeNode;
end;

class function TTreeNodeClass_sw.ToVar(
  const AValue: TTreeNodeClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTreeNodeClass_sw.FromVar(
  const AValue: OleVariant): TTreeNodeClass;
begin
  Result := TTreeNodeClass(ConvFromVar(AValue, TTreeNode));
end;

{ TTreeNode_sw }

function TTreeNode_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TTreeNodes);

  Result := TTreeNode_sw.ToVar(TTreeNode_sc(AObj).Create(TTreeNodes_sw.FromVar(
    AArgs[0])));
end;

function TTreeNode_AlphaSort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AlphaSort(ARecurse: Boolean): Boolean;

  case AArgsSize of
    0:
    begin
      Result := TTreeNode(AObj).AlphaSort();
    end;
    1:
    begin
      Result := TTreeNode(AObj).AlphaSort(Boolean(AArgs[0]));
    end;
  else
    WrongArgCountError('AlphaSort');
  end;
end;

function TTreeNode_Collapse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Collapse(Recurse: Boolean);

  TTreeNode(AObj).Collapse(Boolean(AArgs[0]));
end;

function TTreeNode_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete;

  TTreeNode(AObj).Delete();
end;

function TTreeNode_DeleteChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteChildren;

  TTreeNode(AObj).DeleteChildren();
end;

function TTreeNode_DisplayRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DisplayRect(TextOnly: Boolean): TRect;

  Result := TRect_sw.ToVar(TTreeNode(AObj).DisplayRect(Boolean(AArgs[0])));
end;

function TTreeNode_EditText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EditText: Boolean;

  Result := TTreeNode(AObj).EditText();
end;

function TTreeNode_EndEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndEdit(Cancel: Boolean);

  TTreeNode(AObj).EndEdit(Boolean(AArgs[0]));
end;

function TTreeNode_Expand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Expand(Recurse: Boolean);

  TTreeNode(AObj).Expand(Boolean(AArgs[0]));
end;

function TTreeNode_getFirstChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function getFirstChild: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).getFirstChild());
end;

function TTreeNode_GetHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHandle: HWND;

  Result := HWND_sw.ToVar(TTreeNode(AObj).GetHandle());
end;

function TTreeNode_GetLastChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLastChild: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetLastChild());
end;

function TTreeNode_GetNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNext: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetNext());
end;

function TTreeNode_GetNextChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNextChild(Value: TTreeNode): TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetNextChild(TTreeNode_sw.
    FromVar(AArgs[0])));
end;

function TTreeNode_getNextSibling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function getNextSibling: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).getNextSibling());
end;

function TTreeNode_GetNextVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNextVisible: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetNextVisible());
end;

function TTreeNode_GetPrev_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPrev: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetPrev());
end;

function TTreeNode_GetPrevChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPrevChild(Value: TTreeNode): TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetPrevChild(TTreeNode_sw.
    FromVar(AArgs[0])));
end;

function TTreeNode_getPrevSibling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function getPrevSibling: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).getPrevSibling());
end;

function TTreeNode_GetPrevVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPrevVisible: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).GetPrevVisible());
end;

function TTreeNode_HasAsParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasAsParent(Value: TTreeNode): Boolean;

  Result := TTreeNode(AObj).HasAsParent(TTreeNode_sw.FromVar(AArgs[0]));
end;

function TTreeNode_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(Value: TTreeNode): Integer;

  Result := TTreeNode(AObj).IndexOf(TTreeNode_sw.FromVar(AArgs[0]));
end;

function TTreeNode_MakeVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MakeVisible;

  TTreeNode(AObj).MakeVisible();
end;

function TTreeNode_MoveTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MoveTo(Destination: TTreeNode; Mode: TNodeAttac...

  TTreeNode(AObj).MoveTo(TTreeNode_sw.FromVar(AArgs[0]), TNodeAttachMode_sw.
    FromVar(AArgs[1]));
end;

function TTreeNode_IsFirstNode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsFirstNode: Boolean;

  Result := TTreeNode(AObj).IsFirstNode();
end;

function TTreeNode_AbsoluteIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AbsoluteIndex: Integer read <getter>;

  Result := TTreeNode(AObj).AbsoluteIndex;
end;

function TTreeNode_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TTreeNode(AObj).Count;
end;

function TTreeNode_Cut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cut: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Cut
  else
    TTreeNode(AObj).Cut := Boolean(AArgs[0]);
end;

function TTreeNode_Deleting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Deleting: Boolean read <getter>;

  Result := TTreeNode(AObj).Deleting;
end;

function TTreeNode_Focused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Focused: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Focused
  else
    TTreeNode(AObj).Focused := Boolean(AArgs[0]);
end;

function TTreeNode_DropTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropTarget: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).DropTarget
  else
    TTreeNode(AObj).DropTarget := Boolean(AArgs[0]);
end;

function TTreeNode_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Selected
  else
    TTreeNode(AObj).Selected := Boolean(AArgs[0]);
end;

function TTreeNode_Expanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expanded: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Expanded
  else
    TTreeNode(AObj).Expanded := Boolean(AArgs[0]);
end;

function TTreeNode_ExpandedImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpandedImageIndex: TImageIndex read <getter> wr...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TTreeNode(AObj).ExpandedImageIndex)
  else
    TTreeNode(AObj).ExpandedImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TTreeNode_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TTreeNode(AObj).Handle);
end;

function TTreeNode_HasChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HasChildren: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).HasChildren
  else
    TTreeNode(AObj).HasChildren := Boolean(AArgs[0]);
end;

function TTreeNode_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TTreeNode(AObj).ImageIndex)
  else
    TTreeNode(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TTreeNode_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter>;

  Result := TTreeNode(AObj).Index;
end;

function TTreeNode_IsVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsVisible: Boolean read <getter>;

  Result := TTreeNode(AObj).IsVisible;
end;

function TTreeNode_Item_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Item[Index: Integer]: TTreeNode read <getter> wr...

  if IsGet then
    Result := TTreeNode_sw.ToVar(TTreeNode(AObj).Item[Integer(AArgs[0])])
  else
    TTreeNode(AObj).Item[Integer(AArgs[0])] := TTreeNode_sw.FromVar(AArgs[1]);
end;

function TTreeNode_Level_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Level: Integer read <getter>;

  Result := TTreeNode(AObj).Level;
end;

function TTreeNode_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OverlayIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).OverlayIndex
  else
    TTreeNode(AObj).OverlayIndex := Integer(AArgs[0]);
end;

function TTreeNode_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TTreeNodes read <getter>;

  Result := TTreeNodes_sw.ToVar(TTreeNode(AObj).Owner);
end;

function TTreeNode_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parent: TTreeNode read <getter>;

  Result := TTreeNode_sw.ToVar(TTreeNode(AObj).Parent);
end;

function TTreeNode_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedIndex: Integer read <getter> write <sett...

  if IsGet then
    Result := TTreeNode(AObj).SelectedIndex
  else
    TTreeNode(AObj).SelectedIndex := Integer(AArgs[0]);
end;

function TTreeNode_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Enabled
  else
    TTreeNode(AObj).Enabled := Boolean(AArgs[0]);
end;

function TTreeNode_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StateIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).StateIndex
  else
    TTreeNode(AObj).StateIndex := Integer(AArgs[0]);
end;

function TTreeNode_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode(AObj).Text
  else
    TTreeNode(AObj).Text := string(AArgs[0]);
end;

function TTreeNode_TreeView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TreeView: TCustomTreeView read <getter>;

  Result := TCustomTreeView_sw.ToVar(TTreeNode(AObj).TreeView);
end;

class function TTreeNode_sw.GetTypeName: WideString;
begin
  Result := 'TTreeNode';
end;

class function TTreeNode_sw.GetWrappedClass: TClass;
begin
  Result := TTreeNode;
end;

class procedure TTreeNode_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AlphaSort', TTreeNode_AlphaSort_si, Boolean_sw, 0, True);
  AData.AddProcedure('Collapse', TTreeNode_Collapse_si, 1, False);
  AData.AddProcedure('Delete', TTreeNode_Delete_si, 0, False);
  AData.AddProcedure('DeleteChildren', TTreeNode_DeleteChildren_si, 0, False);
  AData.AddFunction('DisplayRect', TTreeNode_DisplayRect_si, TRect_sw, 1, False);
  AData.AddFunction('EditText', TTreeNode_EditText_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndEdit', TTreeNode_EndEdit_si, 1, False);
  AData.AddProcedure('Expand', TTreeNode_Expand_si, 1, False);
  AData.AddFunction('getFirstChild', TTreeNode_getFirstChild_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetHandle', TTreeNode_GetHandle_si, HWND_sw, 0, False);
  AData.AddFunction('GetLastChild', TTreeNode_GetLastChild_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetNext', TTreeNode_GetNext_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetNextChild', TTreeNode_GetNextChild_si, TTreeNode_sw, 1, False);
  AData.AddFunction('getNextSibling', TTreeNode_getNextSibling_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetNextVisible', TTreeNode_GetNextVisible_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetPrev', TTreeNode_GetPrev_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetPrevChild', TTreeNode_GetPrevChild_si, TTreeNode_sw, 1, False);
  AData.AddFunction('getPrevSibling', TTreeNode_getPrevSibling_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetPrevVisible', TTreeNode_GetPrevVisible_si, TTreeNode_sw, 0, False);
  AData.AddFunction('HasAsParent', TTreeNode_HasAsParent_si, Boolean_sw, 1, False);
  AData.AddFunction('IndexOf', TTreeNode_IndexOf_si, Integer_sw, 1, False);
  AData.AddProcedure('MakeVisible', TTreeNode_MakeVisible_si, 0, False);
  AData.AddProcedure('MoveTo', TTreeNode_MoveTo_si, 2, False);
  AData.AddFunction('IsFirstNode', TTreeNode_IsFirstNode_si, Boolean_sw, 0, False);
  AData.AddProperty('AbsoluteIndex', TTreeNode_AbsoluteIndex_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Count', TTreeNode_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Cut', TTreeNode_Cut_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Deleting', TTreeNode_Deleting_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Focused', TTreeNode_Focused_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DropTarget', TTreeNode_DropTarget_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Selected', TTreeNode_Selected_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Expanded', TTreeNode_Expanded_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ExpandedImageIndex', TTreeNode_ExpandedImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TTreeNode_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('HasChildren', TTreeNode_HasChildren_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TTreeNode_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Index', TTreeNode_Index_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('IsVisible', TTreeNode_IsVisible_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Item', TTreeNode_Item_si, TTreeNode_sw, True, True, 1, False, True);
  AData.AddProperty('Level', TTreeNode_Level_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OverlayIndex', TTreeNode_OverlayIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Owner', TTreeNode_Owner_si, TTreeNodes_sw, True, False, 0, False, False);
  AData.AddProperty('Parent', TTreeNode_Parent_si, TTreeNode_sw, True, False, 0, False, False);
  AData.AddProperty('SelectedIndex', TTreeNode_SelectedIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TTreeNode_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('StateIndex', TTreeNode_StateIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TTreeNode_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('TreeView', TTreeNode_TreeView_si, TCustomTreeView_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTreeNode_Create_si, 1, False);
end;

class function TTreeNode_sw.ToVar(const AValue: TTreeNode): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTreeNode_sw.FromVar(const AValue: OleVariant): TTreeNode;
begin
  Result := TTreeNode(ConvFromVar(AValue, TTreeNode));
end;

class function TTreeNode_sw.ClassToVar(AClass: TTreeNode_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTreeNode_sw.ClassFromVar(
  const AClass: OleVariant): TTreeNode_sc;
begin
  Result := TTreeNode_sc(ConvClsFromVar(AClass, TTreeNode));
end;

{ TTreeNodesEnumerator_sw }

function TTreeNodesEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ATreeNodes: TTreeNodes);

  Result := TTreeNodesEnumerator_sw.ToVar(TTreeNodesEnumerator_sc(AObj).Create(
    TTreeNodes_sw.FromVar(AArgs[0])));
end;

function TTreeNodesEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNodesEnumerator(AObj).GetCurrent());
end;

function TTreeNodesEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TTreeNodesEnumerator(AObj).MoveNext();
end;

function TTreeNodesEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TTreeNode read <getter>;

  Result := TTreeNode_sw.ToVar(TTreeNodesEnumerator(AObj).Current);
end;

class function TTreeNodesEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TTreeNodesEnumerator';
end;

class function TTreeNodesEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TTreeNodesEnumerator;
end;

class procedure TTreeNodesEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TTreeNodesEnumerator_GetCurrent_si, TTreeNode_sw, 0, False);
  AData.AddFunction('MoveNext', TTreeNodesEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TTreeNodesEnumerator_Current_si, TTreeNode_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTreeNodesEnumerator_Create_si, 1, False);
end;

class function TTreeNodesEnumerator_sw.ToVar(
  const AValue: TTreeNodesEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTreeNodesEnumerator_sw.FromVar(
  const AValue: OleVariant): TTreeNodesEnumerator;
begin
  Result := TTreeNodesEnumerator(ConvFromVar(AValue, TTreeNodesEnumerator));
end;

class function TTreeNodesEnumerator_sw.ClassToVar(
  AClass: TTreeNodesEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTreeNodesEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TTreeNodesEnumerator_sc;
begin
  Result := TTreeNodesEnumerator_sc(ConvClsFromVar(AClass, 
    TTreeNodesEnumerator));
end;

{ TNodeCache_sw }

function TNodeCache_CacheNode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CacheNode: TTreeNode;

  if IsGet then
    Result := TTreeNode_sw.ToVar(TNodeCache_sw(AObj).FValue.CacheNode)
  else
    TNodeCache_sw(AObj).FValue.CacheNode := TTreeNode_sw.FromVar(AArgs[0]);
end;

function TNodeCache_CacheIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CacheIndex: Integer;

  if IsGet then
    Result := TNodeCache_sw(AObj).FValue.CacheIndex
  else
    TNodeCache_sw(AObj).FValue.CacheIndex := Integer(AArgs[0]);
end;

function TNodeCache_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TNodeCache_sw.Create as IDispatch;
end;

function TNodeCache_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TNodeCache;

  // Implicit record copy method.
  Result := TNodeCache_sw.ToVar(TNodeCache(AObj));
end;

class function TNodeCache_sw.GetTypeName: WideString;
begin
  Result := 'TNodeCache';
end;

function TNodeCache_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TNodeCache_sw.Create;
  TNodeCache_sw(Result).FValue := FValue;
end;

class procedure TNodeCache_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('CacheNode', TNodeCache_CacheNode_si, TTreeNode_sw);
  AData.AddField('CacheIndex', TNodeCache_CacheIndex_si, Integer_sw);
  AData.AddFunction('Copy', TNodeCache_Copy_si, TNodeCache_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TNodeCache_Create_si, 0, False);
end;

class function TNodeCache_sw.ToVar(const AValue: TNodeCache): OleVariant;
var
  wrpr: TNodeCache_sw;
begin
  wrpr        := TNodeCache_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TNodeCache_sw.FromVar(const AValue: OleVariant): TNodeCache;
begin
  Result := TNodeCache_sw(ConvFromVar(AValue)).FValue;
end;

{ TTreeNodes_sw }

function TTreeNodes_Reading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Reading: Boolean read <getter>;

  Result := TTreeNodes_sacc(TTreeNodes(AObj)).Reading;
end;

function TTreeNodes_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomTreeView);

  Result := TTreeNodes_sw.ToVar(TTreeNodes_sc(AObj).Create(TCustomTreeView_sw.
    FromVar(AArgs[0])));
end;

function TTreeNodes_AddChildFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddChildFirst(Parent: TTreeNode; const S: string...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).AddChildFirst(TTreeNode_sw.
    FromVar(AArgs[0]), string(AArgs[1])));
end;

function TTreeNodes_AddChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddChild(Parent: TTreeNode; const S: string): TT...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).AddChild(TTreeNode_sw.FromVar(
    AArgs[0]), string(AArgs[1])));
end;

function TTreeNodes_AddFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddFirst(Sibling: TTreeNode; const S: string): T...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).AddFirst(TTreeNode_sw.FromVar(
    AArgs[0]), string(AArgs[1])));
end;

function TTreeNodes_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(Sibling: TTreeNode; const S: string): TTreeN...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).Add(TTreeNode_sw.FromVar(
    AArgs[0]), string(AArgs[1])));
end;

function TTreeNodes_AlphaSort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AlphaSort(ARecurse: Boolean): Boolean;

  case AArgsSize of
    0:
    begin
      Result := TTreeNodes(AObj).AlphaSort();
    end;
    1:
    begin
      Result := TTreeNodes(AObj).AlphaSort(Boolean(AArgs[0]));
    end;
  else
    WrongArgCountError('AlphaSort');
  end;
end;

function TTreeNodes_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TTreeNodes(AObj).BeginUpdate();
end;

function TTreeNodes_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TTreeNodes(AObj).Clear();
end;

function TTreeNodes_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Node: TTreeNode);

  TTreeNodes(AObj).Delete(TTreeNode_sw.FromVar(AArgs[0]));
end;

function TTreeNodes_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TTreeNodes(AObj).EndUpdate();
end;

function TTreeNodes_GetFirstNode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetFirstNode: TTreeNode;

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).GetFirstNode());
end;

function TTreeNodes_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TTreeNodesEnumerator;

  Result := TTreeNodesEnumerator_sw.ToVar(TTreeNodes(AObj).GetEnumerator());
end;

function TTreeNodes_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Sibling: TTreeNode; const S: string): TTr...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).Insert(TTreeNode_sw.FromVar(
    AArgs[0]), string(AArgs[1])));
end;

function TTreeNodes_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TTreeNodes(AObj).Count;
end;

function TTreeNodes_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TTreeNodes(AObj).Handle);
end;

function TTreeNodes_Item_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Item[Index: Integer]: TTreeNode read <getter>; d...

  Result := TTreeNode_sw.ToVar(TTreeNodes(AObj).Item[Integer(AArgs[0])]);
end;

function TTreeNodes_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TCustomTreeView read <getter>;

  Result := TCustomTreeView_sw.ToVar(TTreeNodes(AObj).Owner);
end;

class function TTreeNodes_sw.GetTypeName: WideString;
begin
  Result := 'TTreeNodes';
end;

class function TTreeNodes_sw.GetWrappedClass: TClass;
begin
  Result := TTreeNodes;
end;

class procedure TTreeNodes_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Reading', TTreeNodes_Reading_si, Boolean_sw, True, False, 0, True, False);
  AData.AddFunction('AddChildFirst', TTreeNodes_AddChildFirst_si, TTreeNode_sw, 2, False);
  AData.AddFunction('AddChild', TTreeNodes_AddChild_si, TTreeNode_sw, 2, False);
  AData.AddFunction('AddFirst', TTreeNodes_AddFirst_si, TTreeNode_sw, 2, False);
  AData.AddFunction('Add', TTreeNodes_Add_si, TTreeNode_sw, 2, False);
  AData.AddFunction('AlphaSort', TTreeNodes_AlphaSort_si, Boolean_sw, 0, True);
  AData.AddProcedure('BeginUpdate', TTreeNodes_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TTreeNodes_Clear_si, 0, False);
  AData.AddProcedure('Delete', TTreeNodes_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TTreeNodes_EndUpdate_si, 0, False);
  AData.AddFunction('GetFirstNode', TTreeNodes_GetFirstNode_si, TTreeNode_sw, 0, False);
  AData.AddFunction('GetEnumerator', TTreeNodes_GetEnumerator_si, TTreeNodesEnumerator_sw, 0, False);
  AData.AddFunction('Insert', TTreeNodes_Insert_si, TTreeNode_sw, 2, False);
  AData.AddProperty('Count', TTreeNodes_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TTreeNodes_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('Item', TTreeNodes_Item_si, TTreeNode_sw, True, False, 1, False, True);
  AData.AddProperty('Owner', TTreeNodes_Owner_si, TCustomTreeView_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTreeNodes_Create_si, 1, False);
end;

class function TTreeNodes_sw.ToVar(const AValue: TTreeNodes): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTreeNodes_sw.FromVar(const AValue: OleVariant): TTreeNodes;
begin
  Result := TTreeNodes(ConvFromVar(AValue, TTreeNodes));
end;

class function TTreeNodes_sw.ClassToVar(AClass: TTreeNodes_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTreeNodes_sw.ClassFromVar(
  const AClass: OleVariant): TTreeNodes_sc;
begin
  Result := TTreeNodes_sc(ConvClsFromVar(AClass, TTreeNodes));
end;

{ TSortType_sw }

class function TSortType_sw.GetTypeName: WideString;
begin
  Result := 'TSortType';
end;

class procedure TSortType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'stNone'; Value: Integer({$IFDEF LMDSCT_12}TSortType.{$ENDIF}stNone)),
    (Name: 'stData'; Value: Integer({$IFDEF LMDSCT_12}TSortType.{$ENDIF}stData)),
    (Name: 'stText'; Value: Integer({$IFDEF LMDSCT_12}TSortType.{$ENDIF}stText)),
    (Name: 'stBoth'; Value: Integer({$IFDEF LMDSCT_12}TSortType.{$ENDIF}stBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TSortType_sw.ToVar(const AValue: TSortType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSortType_sw.FromVar(const AValue: OleVariant): TSortType;
begin
  Result := TSortType(Integer(AValue));
end;

{ TMultiSelectStyles_sw }

class function TMultiSelectStyles_sw.GetTypeName: WideString;
begin
  Result := 'TMultiSelectStyles';
end;

class procedure TMultiSelectStyles_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'msControlSelect'; Value: Integer({$IFDEF LMDSCT_12}TMultiSelectStyles.{$ENDIF}msControlSelect)),
    (Name: 'msShiftSelect'; Value: Integer({$IFDEF LMDSCT_12}TMultiSelectStyles.{$ENDIF}msShiftSelect)),
    (Name: 'msVisibleOnly'; Value: Integer({$IFDEF LMDSCT_12}TMultiSelectStyles.{$ENDIF}msVisibleOnly)),
    (Name: 'msSiblingOnly'; Value: Integer({$IFDEF LMDSCT_12}TMultiSelectStyles.{$ENDIF}msSiblingOnly))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TMultiSelectStyles_sw.ToVar(
  const AValue: TMultiSelectStyles): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMultiSelectStyles_sw.FromVar(
  const AValue: OleVariant): TMultiSelectStyles;
begin
  Result := TMultiSelectStyles(Integer(AValue));
end;

{ TMultiSelectStyle_sw }

class function TMultiSelectStyle_sw.GetTypeName: WideString;
begin
  Result := 'TMultiSelectStyle';
end;

class function TMultiSelectStyle_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TMultiSelectStyle);
end;

class function TMultiSelectStyle_sw.ToVar(
  const AValue: TMultiSelectStyle): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TMultiSelectStyle_sw.FromVar(
  const AValue: OleVariant): TMultiSelectStyle;
begin
  ConvFromVar(AValue, @Result);
end;

{ ETreeViewError_sw }

class function ETreeViewError_sw.GetTypeName: WideString;
begin
  Result := 'ETreeViewError';
end;

class function ETreeViewError_sw.GetWrappedClass: TClass;
begin
  Result := ETreeViewError;
end;

class procedure ETreeViewError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ETreeViewError_sw.ToVar(
  const AValue: ETreeViewError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ETreeViewError_sw.FromVar(
  const AValue: OleVariant): ETreeViewError;
begin
  Result := ETreeViewError(ConvFromVar(AValue, ETreeViewError));
end;

class function ETreeViewError_sw.ClassToVar(
  AClass: ETreeViewError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ETreeViewError_sw.ClassFromVar(
  const AClass: OleVariant): ETreeViewError_sc;
begin
  Result := ETreeViewError_sc(ConvClsFromVar(AClass, ETreeViewError));
end;

{ TTVChangingEvent_sh }

function TTVChangingEvent_sh.GetHandler: TMethod;
var
  hdr: TTVChangingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVChangingEvent_sh.Handler(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode; var AllowCha...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TTVChangingEvent_sw }

class function TTVChangingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVChangingEvent';
end;

class function TTVChangingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVChangingEvent_sh;
end;

class function TTVChangingEvent_sw.ToVar(
  const AValue: TTVChangingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVChangingEvent_sw.FromVar(
  const AValue: OleVariant): TTVChangingEvent;
begin
  Result := TTVChangingEvent(ConvFromVar(AValue));
end;

class function TTVChangingEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVChangingEvent;
var
  hdlr: TTVChangingEvent_sh;
begin
  hdlr   := TTVChangingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVChangingEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVChangedEvent_sh }

function TTVChangedEvent_sh.GetHandler: TMethod;
var
  hdr: TTVChangedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVChangedEvent_sh.Handler(Sender: TObject; Node: TTreeNode);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TTVChangedEvent_sw }

class function TTVChangedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVChangedEvent';
end;

class function TTVChangedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVChangedEvent_sh;
end;

class function TTVChangedEvent_sw.ToVar(
  const AValue: TTVChangedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVChangedEvent_sw.FromVar(
  const AValue: OleVariant): TTVChangedEvent;
begin
  Result := TTVChangedEvent(ConvFromVar(AValue));
end;

class function TTVChangedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVChangedEvent;
var
  hdlr: TTVChangedEvent_sh;
begin
  hdlr   := TTVChangedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVChangedEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVEditingEvent_sh }

function TTVEditingEvent_sh.GetHandler: TMethod;
var
  hdr: TTVEditingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVEditingEvent_sh.Handler(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode; var AllowEdi...

  v_1 := AllowEdit;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowEdit := Boolean(v_1);
end;

{ TTVEditingEvent_sw }

class function TTVEditingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVEditingEvent';
end;

class function TTVEditingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVEditingEvent_sh;
end;

class function TTVEditingEvent_sw.ToVar(
  const AValue: TTVEditingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVEditingEvent_sw.FromVar(
  const AValue: OleVariant): TTVEditingEvent;
begin
  Result := TTVEditingEvent(ConvFromVar(AValue));
end;

class function TTVEditingEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVEditingEvent;
var
  hdlr: TTVEditingEvent_sh;
begin
  hdlr   := TTVEditingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVEditingEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVEditedEvent_sh }

function TTVEditedEvent_sh.GetHandler: TMethod;
var
  hdr: TTVEditedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVEditedEvent_sh.Handler(Sender: TObject; Node: TTreeNode;
  var S: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode; var S: strin...

  v_1 := S;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  S := string(v_1);
end;

{ TTVEditedEvent_sw }

class function TTVEditedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVEditedEvent';
end;

class function TTVEditedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVEditedEvent_sh;
end;

class function TTVEditedEvent_sw.ToVar(
  const AValue: TTVEditedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVEditedEvent_sw.FromVar(
  const AValue: OleVariant): TTVEditedEvent;
begin
  Result := TTVEditedEvent(ConvFromVar(AValue));
end;

class function TTVEditedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVEditedEvent;
var
  hdlr: TTVEditedEvent_sh;
begin
  hdlr   := TTVEditedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVEditedEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVExpandingEvent_sh }

function TTVExpandingEvent_sh.GetHandler: TMethod;
var
  hdr: TTVExpandingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVExpandingEvent_sh.Handler(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode; var AllowExp...

  v_1 := AllowExpansion;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowExpansion := Boolean(v_1);
end;

{ TTVExpandingEvent_sw }

class function TTVExpandingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVExpandingEvent';
end;

class function TTVExpandingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVExpandingEvent_sh;
end;

class function TTVExpandingEvent_sw.ToVar(
  const AValue: TTVExpandingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVExpandingEvent_sw.FromVar(
  const AValue: OleVariant): TTVExpandingEvent;
begin
  Result := TTVExpandingEvent(ConvFromVar(AValue));
end;

class function TTVExpandingEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTVExpandingEvent;
var
  hdlr: TTVExpandingEvent_sh;
begin
  hdlr   := TTVExpandingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVExpandingEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVCollapsingEvent_sh }

function TTVCollapsingEvent_sh.GetHandler: TMethod;
var
  hdr: TTVCollapsingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVCollapsingEvent_sh.Handler(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode; var AllowCol...

  v_1 := AllowCollapse;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowCollapse := Boolean(v_1);
end;

{ TTVCollapsingEvent_sw }

class function TTVCollapsingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVCollapsingEvent';
end;

class function TTVCollapsingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVCollapsingEvent_sh;
end;

class function TTVCollapsingEvent_sw.ToVar(
  const AValue: TTVCollapsingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVCollapsingEvent_sw.FromVar(
  const AValue: OleVariant): TTVCollapsingEvent;
begin
  Result := TTVCollapsingEvent(ConvFromVar(AValue));
end;

class function TTVCollapsingEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTVCollapsingEvent;
var
  hdlr: TTVCollapsingEvent_sh;
begin
  hdlr   := TTVCollapsingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVCollapsingEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVExpandedEvent_sh }

function TTVExpandedEvent_sh.GetHandler: TMethod;
var
  hdr: TTVExpandedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVExpandedEvent_sh.Handler(Sender: TObject; Node: TTreeNode);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Node: TTreeNode) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TTVExpandedEvent_sw }

class function TTVExpandedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVExpandedEvent';
end;

class function TTVExpandedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVExpandedEvent_sh;
end;

class function TTVExpandedEvent_sw.ToVar(
  const AValue: TTVExpandedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVExpandedEvent_sw.FromVar(
  const AValue: OleVariant): TTVExpandedEvent;
begin
  Result := TTVExpandedEvent(ConvFromVar(AValue));
end;

class function TTVExpandedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVExpandedEvent;
var
  hdlr: TTVExpandedEvent_sh;
begin
  hdlr   := TTVExpandedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVExpandedEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVCompareEvent_sh }

function TTVCompareEvent_sh.GetHandler: TMethod;
var
  hdr: TTVCompareEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVCompareEvent_sh.Handler(Sender: TObject; Node1: TTreeNode;
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Node1: TTreeNode; Node2: TTre...

  v_1 := Compare;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node1);
  args[2] := TTreeNode_sw.ToVar(Node2);
  args[3] := Data;
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Compare := Integer(v_1);
end;

{ TTVCompareEvent_sw }

class function TTVCompareEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVCompareEvent';
end;

class function TTVCompareEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVCompareEvent_sh;
end;

class function TTVCompareEvent_sw.ToVar(
  const AValue: TTVCompareEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVCompareEvent_sw.FromVar(
  const AValue: OleVariant): TTVCompareEvent;
begin
  Result := TTVCompareEvent(ConvFromVar(AValue));
end;

class function TTVCompareEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVCompareEvent;
var
  hdlr: TTVCompareEvent_sh;
begin
  hdlr   := TTVCompareEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVCompareEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVHintEvent_sh }

function TTVHintEvent_sh.GetHandler: TMethod;
var
  hdr: TTVHintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVHintEvent_sh.Handler(Sender: TObject; const Node: TTreeNode;
  var Hint: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; const Node: TTreeNode; var Hi...

  v_1 := Hint;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TTreeNode_sw.ToVar(Node);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Hint := string(v_1);
end;

{ TTVHintEvent_sw }

class function TTVHintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVHintEvent';
end;

class function TTVHintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVHintEvent_sh;
end;

class function TTVHintEvent_sw.ToVar(const AValue: TTVHintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVHintEvent_sw.FromVar(const AValue: OleVariant): TTVHintEvent;
begin
  Result := TTVHintEvent(ConvFromVar(AValue));
end;

class function TTVHintEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVHintEvent;
var
  hdlr: TTVHintEvent_sh;
begin
  hdlr   := TTVHintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVHintEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVCustomDrawEvent_sh }

function TTVCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TTVCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVCustomDrawEvent_sh.Handler(Sender: TCustomTreeView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomTreeView; const ARect: TRect; v...

  v_1 := DefaultDraw;
  args[0] := TCustomTreeView_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TTVCustomDrawEvent_sw }

class function TTVCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVCustomDrawEvent';
end;

class function TTVCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVCustomDrawEvent_sh;
end;

class function TTVCustomDrawEvent_sw.ToVar(
  const AValue: TTVCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TTVCustomDrawEvent;
begin
  Result := TTVCustomDrawEvent(ConvFromVar(AValue));
end;

class function TTVCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTVCustomDrawEvent;
var
  hdlr: TTVCustomDrawEvent_sh;
begin
  hdlr   := TTVCustomDrawEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTVCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVAdvancedCustomDrawEvent_sh }

function TTVAdvancedCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TTVAdvancedCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVAdvancedCustomDrawEvent_sh.Handler(Sender: TCustomTreeView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomTreeView; const ARect: TRect; S...

  v_1 := DefaultDraw;
  args[0] := TCustomTreeView_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := TCustomDrawStage_sw.ToVar(Stage);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TTVAdvancedCustomDrawEvent_sw }

class function TTVAdvancedCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVAdvancedCustomDrawEvent';
end;

class function TTVAdvancedCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVAdvancedCustomDrawEvent_sh;
end;

class function TTVAdvancedCustomDrawEvent_sw.ToVar(
  const AValue: TTVAdvancedCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVAdvancedCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TTVAdvancedCustomDrawEvent;
begin
  Result := TTVAdvancedCustomDrawEvent(ConvFromVar(AValue));
end;

class function TTVAdvancedCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVAdvancedCustomDrawEvent;
var
  hdlr: TTVAdvancedCustomDrawEvent_sh;
begin
  hdlr   := TTVAdvancedCustomDrawEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TTVAdvancedCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TTVCreateNodeClassEvent_sh }

function TTVCreateNodeClassEvent_sh.GetHandler: TMethod;
var
  hdr: TTVCreateNodeClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTVCreateNodeClassEvent_sh.Handler(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomTreeView; var NodeClass: TTreeN...

  v_1 := TTreeNodeClass_sw.ToVar(NodeClass);
  args[0] := TCustomTreeView_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  NodeClass := TTreeNodeClass_sw.FromVar(v_1);
end;

{ TTVCreateNodeClassEvent_sw }

class function TTVCreateNodeClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTVCreateNodeClassEvent';
end;

class function TTVCreateNodeClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTVCreateNodeClassEvent_sh;
end;

class function TTVCreateNodeClassEvent_sw.ToVar(
  const AValue: TTVCreateNodeClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTVCreateNodeClassEvent_sw.FromVar(
  const AValue: OleVariant): TTVCreateNodeClassEvent;
begin
  Result := TTVCreateNodeClassEvent(ConvFromVar(AValue));
end;

class function TTVCreateNodeClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TTVCreateNodeClassEvent;
var
  hdlr: TTVCreateNodeClassEvent_sh;
begin
  hdlr   := TTVCreateNodeClassEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TTVCreateNodeClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomTreeView_sw }

function TCustomTreeView_AutoExpand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoExpand: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).AutoExpand
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).AutoExpand := Boolean(AArgs[0]);
end;

function TCustomTreeView_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(AObj)).
      BorderStyle)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).BorderStyle := TBorderStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_ChangeDelay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ChangeDelay: Integer read <getter> wri...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ChangeDelay
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ChangeDelay := Integer(
      AArgs[0]);
end;

function TCustomTreeView_CreateWndRestores_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CreateWndRestores: Boolean read <gette...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).CreateWndRestores
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).CreateWndRestores := Boolean(
      AArgs[0]);
end;

function TCustomTreeView_HideSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HideSelection: Boolean read <getter> w...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).HideSelection
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).HideSelection := Boolean(
      AArgs[0]);
end;

function TCustomTreeView_HotTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HotTrack: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).HotTrack
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).HotTrack := Boolean(AArgs[0]);
end;

function TCustomTreeView_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Images: TCustomImageList read <getter>...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).Images)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).Images := TCustomImageList_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_Indent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Indent: Integer read <getter> write <s...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).Indent
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).Indent := Integer(AArgs[0]);
end;

function TCustomTreeView_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Items: TTreeNodes read <getter> write ...

  if IsGet then
    Result := TTreeNodes_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(AObj)).
      Items)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).Items := TTreeNodes_sw.FromVar(
      AArgs[0]);
end;

function TCustomTreeView_MultiSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiSelect: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).MultiSelect
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).MultiSelect := Boolean(
      AArgs[0]);
end;

function TCustomTreeView_MultiSelectStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiSelectStyle: TMultiSelectStyle re...

  if IsGet then
    Result := TMultiSelectStyle_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).MultiSelectStyle)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).MultiSelectStyle := 
      TMultiSelectStyle_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_Reading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Reading: Boolean read <getter>;

  Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).Reading;
end;

function TCustomTreeView_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ReadOnly
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ReadOnly := Boolean(AArgs[0]);
end;

function TCustomTreeView_RightClickSelect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RightClickSelect: Boolean read <getter...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).RightClickSelect
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).RightClickSelect := Boolean(
      AArgs[0]);
end;

function TCustomTreeView_RowSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RowSelect: Boolean read <getter> write...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).RowSelect
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).RowSelect := Boolean(AArgs[0]);
end;

function TCustomTreeView_ShowButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowButtons: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowButtons
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowButtons := Boolean(
      AArgs[0]);
end;

function TCustomTreeView_ShowLines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowLines: Boolean read <getter> write...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowLines
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowLines := Boolean(AArgs[0]);
end;

function TCustomTreeView_ShowRoot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowRoot: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowRoot
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ShowRoot := Boolean(AArgs[0]);
end;

function TCustomTreeView_SortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SortType: TSortType read <getter> writ...

  if IsGet then
    Result := TSortType_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(AObj)).
      SortType)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).SortType := TSortType_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_StateImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property StateImages: TCustomImageList read <ge...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).StateImages)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).StateImages := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_ToolTips_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ToolTips: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomTreeView_sacc(TCustomTreeView(AObj)).ToolTips
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).ToolTips := Boolean(AArgs[0]);
end;

function TCustomTreeView_OnAddition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAddition: TTVExpandedEvent read <get...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnAddition)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnAddition := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnAdvancedCustomDraw_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAdvancedCustomDraw: TTVAdvancedCusto...

  if IsGet then
    Result := TTVAdvancedCustomDrawEvent_sw.ToVar(TCustomTreeView_sacc(
      TCustomTreeView(AObj)).OnAdvancedCustomDraw)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnAdvancedCustomDraw := 
      TTVAdvancedCustomDrawEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCancelEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCancelEdit: TTVChangedEvent read <ge...

  if IsGet then
    Result := TTVChangedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnCancelEdit)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCancelEdit := 
      TTVChangedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TTVChangedEvent read <getter...

  if IsGet then
    Result := TTVChangedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnChange)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnChange := TTVChangedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChanging: TTVChangingEvent read <get...

  if IsGet then
    Result := TTVChangingEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnChanging)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnChanging := 
      TTVChangingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCollapsed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCollapsed: TTVExpandedEvent read <ge...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnCollapsed)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCollapsed := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCollapsing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCollapsing: TTVCollapsingEvent read ...

  if IsGet then
    Result := TTVCollapsingEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnCollapsing)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCollapsing := 
      TTVCollapsingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCompare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCompare: TTVCompareEvent read <gette...

  if IsGet then
    Result := TTVCompareEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnCompare)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCompare := TTVCompareEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCustomDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCustomDraw: TTVCustomDrawEvent read ...

  if IsGet then
    Result := TTVCustomDrawEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnCustomDraw)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCustomDraw := 
      TTVCustomDrawEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnDeletion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDeletion: TTVExpandedEvent read <get...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnDeletion)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnDeletion := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnEditing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEditing: TTVEditingEvent read <gette...

  if IsGet then
    Result := TTVEditingEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnEditing)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnEditing := TTVEditingEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_OnEdited_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEdited: TTVEditedEvent read <getter>...

  if IsGet then
    Result := TTVEditedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnEdited)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnEdited := TTVEditedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_OnExpanding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnExpanding: TTVExpandingEvent read <g...

  if IsGet then
    Result := TTVExpandingEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnExpanding)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnExpanding := 
      TTVExpandingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnExpanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnExpanded: TTVExpandedEvent read <get...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnExpanded)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnExpanded := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnGetImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetImageIndex: TTVExpandedEvent read...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnGetImageIndex)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnGetImageIndex := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnGetSelectedIndex_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetSelectedIndex: TTVExpandedEvent r...

  if IsGet then
    Result := TTVExpandedEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(
      AObj)).OnGetSelectedIndex)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnGetSelectedIndex := 
      TTVExpandedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnHint: TTVHintEvent read <getter> wri...

  if IsGet then
    Result := TTVHintEvent_sw.ToVar(TCustomTreeView_sacc(TCustomTreeView(AObj)).
      OnHint)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnHint := TTVHintEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomTreeView_OnCreateNodeClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCreateNodeClass: TTVCreateNodeClassE...

  if IsGet then
    Result := TTVCreateNodeClassEvent_sw.ToVar(TCustomTreeView_sacc(
      TCustomTreeView(AObj)).OnCreateNodeClass)
  else
    TCustomTreeView_sacc(TCustomTreeView(AObj)).OnCreateNodeClass := 
      TTVCreateNodeClassEvent_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_AlphaSort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AlphaSort(ARecurse: Boolean): Boolean;

  case AArgsSize of
    0:
    begin
      Result := TCustomTreeView(AObj).AlphaSort();
    end;
    1:
    begin
      Result := TCustomTreeView(AObj).AlphaSort(Boolean(AArgs[0]));
    end;
  else
    WrongArgCountError('AlphaSort');
  end;
end;

function TCustomTreeView_FullCollapse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FullCollapse;

  TCustomTreeView(AObj).FullCollapse();
end;

function TCustomTreeView_FullExpand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FullExpand;

  TCustomTreeView(AObj).FullExpand();
end;

function TCustomTreeView_GetHitTestInfoAt_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHitTestInfoAt(X: Integer; Y: Integer): THitTe...

  Result := THitTests_sw.ToVar(TCustomTreeView(AObj).GetHitTestInfoAt(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function TCustomTreeView_GetNodeAt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNodeAt(X: Integer; Y: Integer): TTreeNode;

  Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).GetNodeAt(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function TCustomTreeView_IsEditing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEditing: Boolean;

  Result := TCustomTreeView(AObj).IsEditing();
end;

function TCustomTreeView_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function LoadFromFile(...); overload;

  case AArgsSize of
    1:
    begin
      TCustomTreeView(AObj).LoadFromFile(string(AArgs[0]));
    end;
    2:
    begin
      TCustomTreeView(AObj).LoadFromFile(string(AArgs[0]), TEncoding_sw.FromVar(
        AArgs[1]));
    end;
  else
    WrongArgCountError('LoadFromFile');
  end;
end;

function TCustomTreeView_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function LoadFromStream(...); overload;

  case AArgsSize of
    1:
    begin
      TCustomTreeView(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomTreeView(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]), 
        TEncoding_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('LoadFromStream');
  end;
end;

function TCustomTreeView_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SaveToFile(...); overload;

  case AArgsSize of
    1:
    begin
      TCustomTreeView(AObj).SaveToFile(string(AArgs[0]));
    end;
    2:
    begin
      TCustomTreeView(AObj).SaveToFile(string(AArgs[0]), TEncoding_sw.FromVar(
        AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToFile');
  end;
end;

function TCustomTreeView_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SaveToStream(...); overload;

  case AArgsSize of
    1:
    begin
      TCustomTreeView(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomTreeView(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]), 
        TEncoding_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToStream');
  end;
end;

function TCustomTreeView_Select_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Select(...); overload;

  TCustomTreeView(AObj).Select(TList_sw.FromVar(AArgs[0]));
end;

function TCustomTreeView_Deselect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Deselect(Node: TTreeNode);

  TCustomTreeView(AObj).Deselect(TTreeNode_sw.FromVar(AArgs[0]));
end;

function TCustomTreeView_Subselect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Subselect(Node: TTreeNode; Validate: Boolean);

  case AArgsSize of
    1:
    begin
      TCustomTreeView(AObj).Subselect(TTreeNode_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomTreeView(AObj).Subselect(TTreeNode_sw.FromVar(AArgs[0]), Boolean(
        AArgs[1]));
    end;
  else
    WrongArgCountError('Subselect');
  end;
end;

function TCustomTreeView_ClearSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearSelection(KeepPrimary: Boolean);

  case AArgsSize of
    0:
    begin
      TCustomTreeView(AObj).ClearSelection();
    end;
    1:
    begin
      TCustomTreeView(AObj).ClearSelection(Boolean(AArgs[0]));
    end;
  else
    WrongArgCountError('ClearSelection');
  end;
end;

function TCustomTreeView_GetSelections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetSelections(AList: TList): TTreeNode;

  Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).GetSelections(TList_sw.
    FromVar(AArgs[0])));
end;

function TCustomTreeView_FindNextToSelect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindNextToSelect: TTreeNode;

  Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).FindNextToSelect());
end;

function TCustomTreeView_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomTreeView(AObj).Canvas);
end;

function TCustomTreeView_DropTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropTarget: TTreeNode read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).DropTarget)
  else
    TCustomTreeView(AObj).DropTarget := TTreeNode_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: TTreeNode read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).Selected)
  else
    TCustomTreeView(AObj).Selected := TTreeNode_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_TopItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TopItem: TTreeNode read <getter> write <setter>;

  if IsGet then
    Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).TopItem)
  else
    TCustomTreeView(AObj).TopItem := TTreeNode_sw.FromVar(AArgs[0]);
end;

function TCustomTreeView_SelectionCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectionCount: Cardinal read <getter>;

  Result := TCustomTreeView(AObj).SelectionCount;
end;

function TCustomTreeView_Selections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selections[Index: Integer]: TTreeNode read <gett...

  Result := TTreeNode_sw.ToVar(TCustomTreeView(AObj).Selections[Integer(
    AArgs[0])]);
end;

class function TCustomTreeView_sw.GetTypeName: WideString;
begin
  Result := 'TCustomTreeView';
end;

class function TCustomTreeView_sw.GetWrappedClass: TClass;
begin
  Result := TCustomTreeView;
end;

class procedure TCustomTreeView_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoExpand', TCustomTreeView_AutoExpand_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('BorderStyle', TCustomTreeView_BorderStyle_si, TBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('ChangeDelay', TCustomTreeView_ChangeDelay_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('CreateWndRestores', TCustomTreeView_CreateWndRestores_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('HideSelection', TCustomTreeView_HideSelection_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('HotTrack', TCustomTreeView_HotTrack_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Images', TCustomTreeView_Images_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('Indent', TCustomTreeView_Indent_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Items', TCustomTreeView_Items_si, TTreeNodes_sw, True, True, 0, True, False);
  AData.AddProperty('MultiSelect', TCustomTreeView_MultiSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MultiSelectStyle', TCustomTreeView_MultiSelectStyle_si, TMultiSelectStyle_sw, True, True, 0, True, False);
  AData.AddProperty('Reading', TCustomTreeView_Reading_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('ReadOnly', TCustomTreeView_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('RightClickSelect', TCustomTreeView_RightClickSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('RowSelect', TCustomTreeView_RowSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowButtons', TCustomTreeView_ShowButtons_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowLines', TCustomTreeView_ShowLines_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowRoot', TCustomTreeView_ShowRoot_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('SortType', TCustomTreeView_SortType_si, TSortType_sw, True, True, 0, True, False);
  AData.AddProperty('StateImages', TCustomTreeView_StateImages_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('ToolTips', TCustomTreeView_ToolTips_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnAddition', TCustomTreeView_OnAddition_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnAdvancedCustomDraw', TCustomTreeView_OnAdvancedCustomDraw_si, TTVAdvancedCustomDrawEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCancelEdit', TCustomTreeView_OnCancelEdit_si, TTVChangedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomTreeView_OnChange_si, TTVChangedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChanging', TCustomTreeView_OnChanging_si, TTVChangingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCollapsed', TCustomTreeView_OnCollapsed_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCollapsing', TCustomTreeView_OnCollapsing_si, TTVCollapsingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCompare', TCustomTreeView_OnCompare_si, TTVCompareEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCustomDraw', TCustomTreeView_OnCustomDraw_si, TTVCustomDrawEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDeletion', TCustomTreeView_OnDeletion_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEditing', TCustomTreeView_OnEditing_si, TTVEditingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEdited', TCustomTreeView_OnEdited_si, TTVEditedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnExpanding', TCustomTreeView_OnExpanding_si, TTVExpandingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnExpanded', TCustomTreeView_OnExpanded_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetImageIndex', TCustomTreeView_OnGetImageIndex_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetSelectedIndex', TCustomTreeView_OnGetSelectedIndex_si, TTVExpandedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnHint', TCustomTreeView_OnHint_si, TTVHintEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCreateNodeClass', TCustomTreeView_OnCreateNodeClass_si, TTVCreateNodeClassEvent_sw, True, True, 0, True, False);
  AData.AddFunction('AlphaSort', TCustomTreeView_AlphaSort_si, Boolean_sw, 0, True);
  AData.AddProcedure('FullCollapse', TCustomTreeView_FullCollapse_si, 0, False);
  AData.AddProcedure('FullExpand', TCustomTreeView_FullExpand_si, 0, False);
  AData.AddFunction('GetHitTestInfoAt', TCustomTreeView_GetHitTestInfoAt_si, THitTests_sw, 2, False);
  AData.AddFunction('GetNodeAt', TCustomTreeView_GetNodeAt_si, TTreeNode_sw, 2, False);
  AData.AddFunction('IsEditing', TCustomTreeView_IsEditing_si, Boolean_sw, 0, False);
  AData.AddProcedure('LoadFromFile', TCustomTreeView_LoadFromFile_si, 1, True);
  AData.AddProcedure('LoadFromStream', TCustomTreeView_LoadFromStream_si, 1, True);
  AData.AddProcedure('SaveToFile', TCustomTreeView_SaveToFile_si, 1, True);
  AData.AddProcedure('SaveToStream', TCustomTreeView_SaveToStream_si, 1, True);
  AData.AddProcedure('Select', TCustomTreeView_Select_si, 1, False);
  AData.AddProcedure('Deselect', TCustomTreeView_Deselect_si, 1, False);
  AData.AddProcedure('Subselect', TCustomTreeView_Subselect_si, 1, True);
  AData.AddProcedure('ClearSelection', TCustomTreeView_ClearSelection_si, 0, True);
  AData.AddFunction('GetSelections', TCustomTreeView_GetSelections_si, TTreeNode_sw, 1, False);
  AData.AddFunction('FindNextToSelect', TCustomTreeView_FindNextToSelect_si, TTreeNode_sw, 0, False);
  AData.AddProperty('Canvas', TCustomTreeView_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('DropTarget', TCustomTreeView_DropTarget_si, TTreeNode_sw, True, True, 0, False, False);
  AData.AddProperty('Selected', TCustomTreeView_Selected_si, TTreeNode_sw, True, True, 0, False, False);
  AData.AddProperty('TopItem', TCustomTreeView_TopItem_si, TTreeNode_sw, True, True, 0, False, False);
  AData.AddProperty('SelectionCount', TCustomTreeView_SelectionCount_si, Cardinal_sw, True, False, 0, False, False);
  AData.AddProperty('Selections', TCustomTreeView_Selections_si, TTreeNode_sw, True, False, 1, False, False);
end;

class function TCustomTreeView_sw.ToVar(
  const AValue: TCustomTreeView): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomTreeView_sw.FromVar(
  const AValue: OleVariant): TCustomTreeView;
begin
  Result := TCustomTreeView(ConvFromVar(AValue, TCustomTreeView));
end;

class function TCustomTreeView_sw.ClassToVar(
  AClass: TCustomTreeView_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomTreeView_sw.ClassFromVar(
  const AClass: OleVariant): TCustomTreeView_sc;
begin
  Result := TCustomTreeView_sc(ConvClsFromVar(AClass, TCustomTreeView));
end;

{ TTreeView_sw }

class function TTreeView_sw.GetTypeName: WideString;
begin
  Result := 'TTreeView';
end;

class function TTreeView_sw.GetWrappedClass: TClass;
begin
  Result := TTreeView;
end;

class procedure TTreeView_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoExpand', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('ChangeDelay', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('HotTrack', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('Indent', False);
  AData.AddPropertyRedecl('MultiSelect', False);
  AData.AddPropertyRedecl('MultiSelectStyle', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('RightClickSelect', False);
  AData.AddPropertyRedecl('RowSelect', False);
  AData.AddPropertyRedecl('ShowButtons', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('ShowLines', False);
  AData.AddPropertyRedecl('ShowRoot', False);
  AData.AddPropertyRedecl('SortType', False);
  AData.AddPropertyRedecl('StateImages', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('ToolTips', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnAddition', False);
  AData.AddPropertyRedecl('OnAdvancedCustomDraw', False);
  AData.AddPropertyRedecl('OnAdvancedCustomDrawItem', False);
  AData.AddPropertyRedecl('OnCancelEdit', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnChanging', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnCollapsed', False);
  AData.AddPropertyRedecl('OnCollapsing', False);
  AData.AddPropertyRedecl('OnCompare', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnCreateNodeClass', False);
  AData.AddPropertyRedecl('OnCustomDraw', False);
  AData.AddPropertyRedecl('OnCustomDrawItem', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDeletion', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEdited', False);
  AData.AddPropertyRedecl('OnEditing', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnExpanding', False);
  AData.AddPropertyRedecl('OnExpanded', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetImageIndex', False);
  AData.AddPropertyRedecl('OnGetSelectedIndex', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('Items', False);
end;

class function TTreeView_sw.ToVar(const AValue: TTreeView): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTreeView_sw.FromVar(const AValue: OleVariant): TTreeView;
begin
  Result := TTreeView(ConvFromVar(AValue, TTreeView));
end;

class function TTreeView_sw.ClassToVar(AClass: TTreeView_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTreeView_sw.ClassFromVar(
  const AClass: OleVariant): TTreeView_sc;
begin
  Result := TTreeView_sc(ConvClsFromVar(AClass, TTreeView));
end;

{ TTrackBarOrientation_sw }

class function TTrackBarOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TTrackBarOrientation';
end;

class procedure TTrackBarOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'trHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TTrackBarOrientation.{$ENDIF}trHorizontal)),
    (Name: 'trVertical'; Value: Integer({$IFDEF LMDSCT_12}TTrackBarOrientation.{$ENDIF}trVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTrackBarOrientation_sw.ToVar(
  const AValue: TTrackBarOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTrackBarOrientation_sw.FromVar(
  const AValue: OleVariant): TTrackBarOrientation;
begin
  Result := TTrackBarOrientation(Integer(AValue));
end;

{ TTickMark_sw }

class function TTickMark_sw.GetTypeName: WideString;
begin
  Result := 'TTickMark';
end;

class procedure TTickMark_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'tmBottomRight'; Value: Integer({$IFDEF LMDSCT_12}TTickMark.{$ENDIF}tmBottomRight)),
    (Name: 'tmTopLeft'; Value: Integer({$IFDEF LMDSCT_12}TTickMark.{$ENDIF}tmTopLeft)),
    (Name: 'tmBoth'; Value: Integer({$IFDEF LMDSCT_12}TTickMark.{$ENDIF}tmBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TTickMark_sw.ToVar(const AValue: TTickMark): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTickMark_sw.FromVar(const AValue: OleVariant): TTickMark;
begin
  Result := TTickMark(Integer(AValue));
end;

{ TTickStyle_sw }

class function TTickStyle_sw.GetTypeName: WideString;
begin
  Result := 'TTickStyle';
end;

class procedure TTickStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'tsNone'; Value: Integer({$IFDEF LMDSCT_12}TTickStyle.{$ENDIF}tsNone)),
    (Name: 'tsAuto'; Value: Integer({$IFDEF LMDSCT_12}TTickStyle.{$ENDIF}tsAuto)),
    (Name: 'tsManual'; Value: Integer({$IFDEF LMDSCT_12}TTickStyle.{$ENDIF}tsManual))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TTickStyle_sw.ToVar(const AValue: TTickStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTickStyle_sw.FromVar(const AValue: OleVariant): TTickStyle;
begin
  Result := TTickStyle(Integer(AValue));
end;

{ TPositionToolTip_sw }

class function TPositionToolTip_sw.GetTypeName: WideString;
begin
  Result := 'TPositionToolTip';
end;

class procedure TPositionToolTip_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'ptNone'; Value: Integer({$IFDEF LMDSCT_12}TPositionToolTip.{$ENDIF}ptNone)),
    (Name: 'ptTop'; Value: Integer({$IFDEF LMDSCT_12}TPositionToolTip.{$ENDIF}ptTop)),
    (Name: 'ptLeft'; Value: Integer({$IFDEF LMDSCT_12}TPositionToolTip.{$ENDIF}ptLeft)),
    (Name: 'ptBottom'; Value: Integer({$IFDEF LMDSCT_12}TPositionToolTip.{$ENDIF}ptBottom)),
    (Name: 'ptRight'; Value: Integer({$IFDEF LMDSCT_12}TPositionToolTip.{$ENDIF}ptRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TPositionToolTip_sw.ToVar(
  const AValue: TPositionToolTip): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPositionToolTip_sw.FromVar(
  const AValue: OleVariant): TPositionToolTip;
begin
  Result := TPositionToolTip(Integer(AValue));
end;

{ TTrackBar_sw }

function TTrackBar_SetTick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetTick(Value: Integer);

  TTrackBar(AObj).SetTick(Integer(AArgs[0]));
end;

function TTrackBar_LineSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LineSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).LineSize
  else
    TTrackBar(AObj).LineSize := Integer(AArgs[0]);
end;

function TTrackBar_Max_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Max: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).Max
  else
    TTrackBar(AObj).Max := Integer(AArgs[0]);
end;

function TTrackBar_Min_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Min: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).Min
  else
    TTrackBar(AObj).Min := Integer(AArgs[0]);
end;

function TTrackBar_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TTrackBarOrientation read <getter> ...

  if IsGet then
    Result := TTrackBarOrientation_sw.ToVar(TTrackBar(AObj).Orientation)
  else
    TTrackBar(AObj).Orientation := TTrackBarOrientation_sw.FromVar(AArgs[0]);
end;

function TTrackBar_PageSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).PageSize
  else
    TTrackBar(AObj).PageSize := Integer(AArgs[0]);
end;

function TTrackBar_Frequency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Frequency: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).Frequency
  else
    TTrackBar(AObj).Frequency := Integer(AArgs[0]);
end;

function TTrackBar_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).Position
  else
    TTrackBar(AObj).Position := Integer(AArgs[0]);
end;

function TTrackBar_PositionToolTip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PositionToolTip: TPositionToolTip read <getter> ...

  if IsGet then
    Result := TPositionToolTip_sw.ToVar(TTrackBar(AObj).PositionToolTip)
  else
    TTrackBar(AObj).PositionToolTip := TPositionToolTip_sw.FromVar(AArgs[0]);
end;

function TTrackBar_SliderVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SliderVisible: Boolean read <getter> write <sett...

  if IsGet then
    Result := TTrackBar(AObj).SliderVisible
  else
    TTrackBar(AObj).SliderVisible := Boolean(AArgs[0]);
end;

function TTrackBar_SelEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelEnd: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).SelEnd
  else
    TTrackBar(AObj).SelEnd := Integer(AArgs[0]);
end;

function TTrackBar_SelStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelStart: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).SelStart
  else
    TTrackBar(AObj).SelStart := Integer(AArgs[0]);
end;

function TTrackBar_ShowSelRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowSelRange: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).ShowSelRange
  else
    TTrackBar(AObj).ShowSelRange := Boolean(AArgs[0]);
end;

function TTrackBar_ThumbLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ThumbLength: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTrackBar(AObj).ThumbLength
  else
    TTrackBar(AObj).ThumbLength := Integer(AArgs[0]);
end;

function TTrackBar_TickMarks_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TickMarks: TTickMark read <getter> write <setter>;

  if IsGet then
    Result := TTickMark_sw.ToVar(TTrackBar(AObj).TickMarks)
  else
    TTrackBar(AObj).TickMarks := TTickMark_sw.FromVar(AArgs[0]);
end;

function TTrackBar_TickStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TickStyle: TTickStyle read <getter> write <setter>;

  if IsGet then
    Result := TTickStyle_sw.ToVar(TTrackBar(AObj).TickStyle)
  else
    TTrackBar(AObj).TickStyle := TTickStyle_sw.FromVar(AArgs[0]);
end;

function TTrackBar_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TTrackBar(AObj).OnChange)
  else
    TTrackBar(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TTrackBar_sw.GetTypeName: WideString;
begin
  Result := 'TTrackBar';
end;

class function TTrackBar_sw.GetWrappedClass: TClass;
begin
  Result := TTrackBar;
end;

class procedure TTrackBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SetTick', TTrackBar_SetTick_si, 1, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('LineSize', TTrackBar_LineSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Max', TTrackBar_Max_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Min', TTrackBar_Min_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Orientation', TTrackBar_Orientation_si, TTrackBarOrientation_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('PageSize', TTrackBar_PageSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Frequency', TTrackBar_Frequency_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TTrackBar_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PositionToolTip', TTrackBar_PositionToolTip_si, TPositionToolTip_sw, True, True, 0, False, False);
  AData.AddProperty('SliderVisible', TTrackBar_SliderVisible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SelEnd', TTrackBar_SelEnd_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SelStart', TTrackBar_SelStart_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('ShowSelRange', TTrackBar_ShowSelRange_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddProperty('ThumbLength', TTrackBar_ThumbLength_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('TickMarks', TTrackBar_TickMarks_si, TTickMark_sw, True, True, 0, False, False);
  AData.AddProperty('TickStyle', TTrackBar_TickStyle_si, TTickStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddProperty('OnChange', TTrackBar_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TTrackBar_sw.ToVar(const AValue: TTrackBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTrackBar_sw.FromVar(const AValue: OleVariant): TTrackBar;
begin
  Result := TTrackBar(ConvFromVar(AValue, TTrackBar));
end;

class function TTrackBar_sw.ClassToVar(AClass: TTrackBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTrackBar_sw.ClassFromVar(
  const AClass: OleVariant): TTrackBar_sc;
begin
  Result := TTrackBar_sc(ConvClsFromVar(AClass, TTrackBar));
end;

{ TProgressBarOrientation_sw }

class function TProgressBarOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TProgressBarOrientation';
end;

class procedure TProgressBarOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'pbHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarOrientation.{$ENDIF}pbHorizontal)),
    (Name: 'pbVertical'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarOrientation.{$ENDIF}pbVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TProgressBarOrientation_sw.ToVar(
  const AValue: TProgressBarOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProgressBarOrientation_sw.FromVar(
  const AValue: OleVariant): TProgressBarOrientation;
begin
  Result := TProgressBarOrientation(Integer(AValue));
end;

{ TProgressBarStyle_sw }

class function TProgressBarStyle_sw.GetTypeName: WideString;
begin
  Result := 'TProgressBarStyle';
end;

class procedure TProgressBarStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'pbstNormal'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarStyle.{$ENDIF}pbstNormal)),
    (Name: 'pbstMarquee'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarStyle.{$ENDIF}pbstMarquee))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TProgressBarStyle_sw.ToVar(
  const AValue: TProgressBarStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProgressBarStyle_sw.FromVar(
  const AValue: OleVariant): TProgressBarStyle;
begin
  Result := TProgressBarStyle(Integer(AValue));
end;

{ TProgressBarState_sw }

class function TProgressBarState_sw.GetTypeName: WideString;
begin
  Result := 'TProgressBarState';
end;

class procedure TProgressBarState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pbsNormal'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarState.{$ENDIF}pbsNormal)),
    (Name: 'pbsError'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarState.{$ENDIF}pbsError)),
    (Name: 'pbsPaused'; Value: Integer({$IFDEF LMDSCT_12}TProgressBarState.{$ENDIF}pbsPaused))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TProgressBarState_sw.ToVar(
  const AValue: TProgressBarState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProgressBarState_sw.FromVar(
  const AValue: OleVariant): TProgressBarState;
begin
  Result := TProgressBarState(Integer(AValue));
end;

{ TProgressBar_sw }

function TProgressBar_StepIt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StepIt;

  TProgressBar(AObj).StepIt();
end;

function TProgressBar_StepBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StepBy(Delta: Integer);

  TProgressBar(AObj).StepBy(Integer(AArgs[0]));
end;

function TProgressBar_Min_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Min: Integer read <getter> write <setter>;

  if IsGet then
    Result := TProgressBar(AObj).Min
  else
    TProgressBar(AObj).Min := Integer(AArgs[0]);
end;

function TProgressBar_Max_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Max: Integer read <getter> write <setter>;

  if IsGet then
    Result := TProgressBar(AObj).Max
  else
    TProgressBar(AObj).Max := Integer(AArgs[0]);
end;

function TProgressBar_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TProgressBarOrientation read <gette...

  if IsGet then
    Result := TProgressBarOrientation_sw.ToVar(TProgressBar(AObj).Orientation)
  else
    TProgressBar(AObj).Orientation := TProgressBarOrientation_sw.FromVar(
      AArgs[0]);
end;

function TProgressBar_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TProgressBar(AObj).Position
  else
    TProgressBar(AObj).Position := Integer(AArgs[0]);
end;

function TProgressBar_Smooth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Smooth: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TProgressBar(AObj).Smooth
  else
    TProgressBar(AObj).Smooth := Boolean(AArgs[0]);
end;

function TProgressBar_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TProgressBarStyle read <getter> write <se...

  if IsGet then
    Result := TProgressBarStyle_sw.ToVar(TProgressBar(AObj).Style)
  else
    TProgressBar(AObj).Style := TProgressBarStyle_sw.FromVar(AArgs[0]);
end;

function TProgressBar_MarqueeInterval_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarqueeInterval: Integer read <getter> write <se...

  if IsGet then
    Result := TProgressBar(AObj).MarqueeInterval
  else
    TProgressBar(AObj).MarqueeInterval := Integer(AArgs[0]);
end;

function TProgressBar_BarColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BarColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TProgressBar(AObj).BarColor)
  else
    TProgressBar(AObj).BarColor := TColor_sw.FromVar(AArgs[0]);
end;

function TProgressBar_BackgroundColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BackgroundColor: TColor read <getter> write <set...

  if IsGet then
    Result := TColor_sw.ToVar(TProgressBar(AObj).BackgroundColor)
  else
    TProgressBar(AObj).BackgroundColor := TColor_sw.FromVar(AArgs[0]);
end;

function TProgressBar_SmoothReverse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SmoothReverse: Boolean read <getter> write <sett...

  if IsGet then
    Result := TProgressBar(AObj).SmoothReverse
  else
    TProgressBar(AObj).SmoothReverse := Boolean(AArgs[0]);
end;

function TProgressBar_Step_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Step: Integer read <getter> write <setter>;

  if IsGet then
    Result := TProgressBar(AObj).Step
  else
    TProgressBar(AObj).Step := Integer(AArgs[0]);
end;

function TProgressBar_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TProgressBarState read <getter> write <se...

  if IsGet then
    Result := TProgressBarState_sw.ToVar(TProgressBar(AObj).State)
  else
    TProgressBar(AObj).State := TProgressBarState_sw.FromVar(AArgs[0]);
end;

class function TProgressBar_sw.GetTypeName: WideString;
begin
  Result := 'TProgressBar';
end;

class function TProgressBar_sw.GetWrappedClass: TClass;
begin
  Result := TProgressBar;
end;

class procedure TProgressBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('StepIt', TProgressBar_StepIt_si, 0, False);
  AData.AddProcedure('StepBy', TProgressBar_StepBy_si, 1, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('Min', TProgressBar_Min_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Max', TProgressBar_Max_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Orientation', TProgressBar_Orientation_si, TProgressBarOrientation_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Position', TProgressBar_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Smooth', TProgressBar_Smooth_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TProgressBar_Style_si, TProgressBarStyle_sw, True, True, 0, False, False);
  AData.AddProperty('MarqueeInterval', TProgressBar_MarqueeInterval_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('BarColor', TProgressBar_BarColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('BackgroundColor', TProgressBar_BackgroundColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('SmoothReverse', TProgressBar_SmoothReverse_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Step', TProgressBar_Step_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('State', TProgressBar_State_si, TProgressBarState_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TProgressBar_sw.ToVar(const AValue: TProgressBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TProgressBar_sw.FromVar(const AValue: OleVariant): TProgressBar;
begin
  Result := TProgressBar(ConvFromVar(AValue, TProgressBar));
end;

class function TProgressBar_sw.ClassToVar(AClass: TProgressBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TProgressBar_sw.ClassFromVar(
  const AClass: OleVariant): TProgressBar_sc;
begin
  Result := TProgressBar_sc(ConvClsFromVar(AClass, TProgressBar));
end;

{ TAttributeType_sw }

class function TAttributeType_sw.GetTypeName: WideString;
begin
  Result := 'TAttributeType';
end;

class procedure TAttributeType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'atSelected'; Value: Integer({$IFDEF LMDSCT_12}TAttributeType.{$ENDIF}atSelected)),
    (Name: 'atDefaultText'; Value: Integer({$IFDEF LMDSCT_12}TAttributeType.{$ENDIF}atDefaultText))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TAttributeType_sw.ToVar(
  const AValue: TAttributeType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAttributeType_sw.FromVar(
  const AValue: OleVariant): TAttributeType;
begin
  Result := TAttributeType(Integer(AValue));
end;

{ TConsistentAttribute_sw }

class function TConsistentAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TConsistentAttribute';
end;

class procedure TConsistentAttribute_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'caBold'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caBold)),
    (Name: 'caColor'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caColor)),
    (Name: 'caFace'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caFace)),
    (Name: 'caItalic'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caItalic)),
    (Name: 'caSize'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caSize)),
    (Name: 'caStrikeOut'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caStrikeOut)),
    (Name: 'caUnderline'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caUnderline)),
    (Name: 'caProtected'; Value: Integer({$IFDEF LMDSCT_12}TConsistentAttribute.{$ENDIF}caProtected))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TConsistentAttribute_sw.ToVar(
  const AValue: TConsistentAttribute): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TConsistentAttribute_sw.FromVar(
  const AValue: OleVariant): TConsistentAttribute;
begin
  Result := TConsistentAttribute(Integer(AValue));
end;

{ TConsistentAttributes_sw }

class function TConsistentAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TConsistentAttributes';
end;

class function TConsistentAttributes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TConsistentAttributes);
end;

class function TConsistentAttributes_sw.ToVar(
  const AValue: TConsistentAttributes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TConsistentAttributes_sw.FromVar(
  const AValue: OleVariant): TConsistentAttributes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTextAttributes_sw }

function TTextAttributes_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomRichEdit; AttributeType...

  Result := TTextAttributes_sw.ToVar(TTextAttributes_sc(AObj).Create(
    TCustomRichEdit_sw.FromVar(AArgs[0]), TAttributeType_sw.FromVar(AArgs[1])));
end;

function TTextAttributes_Charset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Charset: TFontCharset read <getter> write <setter>;

  if IsGet then
    Result := TFontCharset_sw.ToVar(TTextAttributes(AObj).Charset)
  else
    TTextAttributes(AObj).Charset := TFontCharset_sw.FromVar(AArgs[0]);
end;

function TTextAttributes_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TTextAttributes(AObj).Color)
  else
    TTextAttributes(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TTextAttributes_ConsistentAttributes_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConsistentAttributes: TConsistentAttributes read...

  Result := TConsistentAttributes_sw.ToVar(TTextAttributes(AObj).
    ConsistentAttributes);
end;

function TTextAttributes_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: TFontName read <getter> write <setter>;

  if IsGet then
    Result := TFontName_sw.ToVar(TTextAttributes(AObj).Name)
  else
    TTextAttributes(AObj).Name := TFontName_sw.FromVar(AArgs[0]);
end;

function TTextAttributes_Pitch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pitch: TFontPitch read <getter> write <setter>;

  if IsGet then
    Result := TFontPitch_sw.ToVar(TTextAttributes(AObj).Pitch)
  else
    TTextAttributes(AObj).Pitch := TFontPitch_sw.FromVar(AArgs[0]);
end;

function TTextAttributes_Protected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Protected: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTextAttributes(AObj).Protected
  else
    TTextAttributes(AObj).Protected := Boolean(AArgs[0]);
end;

function TTextAttributes_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTextAttributes(AObj).Size
  else
    TTextAttributes(AObj).Size := Integer(AArgs[0]);
end;

function TTextAttributes_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TFontStyles read <getter> write <setter>;

  if IsGet then
    Result := TFontStyles_sw.ToVar(TTextAttributes(AObj).Style)
  else
    TTextAttributes(AObj).Style := TFontStyles_sw.FromVar(AArgs[0]);
end;

function TTextAttributes_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTextAttributes(AObj).Height
  else
    TTextAttributes(AObj).Height := Integer(AArgs[0]);
end;

class function TTextAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TTextAttributes';
end;

class function TTextAttributes_sw.GetWrappedClass: TClass;
begin
  Result := TTextAttributes;
end;

class procedure TTextAttributes_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Charset', TTextAttributes_Charset_si, TFontCharset_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TTextAttributes_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('ConsistentAttributes', TTextAttributes_ConsistentAttributes_si, TConsistentAttributes_sw, True, False, 0, False, False);
  AData.AddProperty('Name', TTextAttributes_Name_si, TFontName_sw, True, True, 0, False, False);
  AData.AddProperty('Pitch', TTextAttributes_Pitch_si, TFontPitch_sw, True, True, 0, False, False);
  AData.AddProperty('Protected', TTextAttributes_Protected_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TTextAttributes_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TTextAttributes_Style_si, TFontStyles_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TTextAttributes_Height_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TTextAttributes_Create_si, 2, False);
end;

class function TTextAttributes_sw.ToVar(
  const AValue: TTextAttributes): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTextAttributes_sw.FromVar(
  const AValue: OleVariant): TTextAttributes;
begin
  Result := TTextAttributes(ConvFromVar(AValue, TTextAttributes));
end;

class function TTextAttributes_sw.ClassToVar(
  AClass: TTextAttributes_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTextAttributes_sw.ClassFromVar(
  const AClass: OleVariant): TTextAttributes_sc;
begin
  Result := TTextAttributes_sc(ConvClsFromVar(AClass, TTextAttributes));
end;

{ TNumberingStyle_sw }

class function TNumberingStyle_sw.GetTypeName: WideString;
begin
  Result := 'TNumberingStyle';
end;

class procedure TNumberingStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'nsNone'; Value: Integer({$IFDEF LMDSCT_12}TNumberingStyle.{$ENDIF}nsNone)),
    (Name: 'nsBullet'; Value: Integer({$IFDEF LMDSCT_12}TNumberingStyle.{$ENDIF}nsBullet))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TNumberingStyle_sw.ToVar(
  const AValue: TNumberingStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNumberingStyle_sw.FromVar(
  const AValue: OleVariant): TNumberingStyle;
begin
  Result := TNumberingStyle(Integer(AValue));
end;

{ TParaAttributes_sw }

function TParaAttributes_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomRichEdit);

  Result := TParaAttributes_sw.ToVar(TParaAttributes_sc(AObj).Create(
    TCustomRichEdit_sw.FromVar(AArgs[0])));
end;

function TParaAttributes_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TParaAttributes(AObj).Alignment)
  else
    TParaAttributes(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TParaAttributes_FirstIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FirstIndent: Longint read <getter> write <setter>;

  if IsGet then
    Result := TParaAttributes(AObj).FirstIndent
  else
    TParaAttributes(AObj).FirstIndent := Longint(AArgs[0]);
end;

function TParaAttributes_LeftIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LeftIndent: Longint read <getter> write <setter>;

  if IsGet then
    Result := TParaAttributes(AObj).LeftIndent
  else
    TParaAttributes(AObj).LeftIndent := Longint(AArgs[0]);
end;

function TParaAttributes_Numbering_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Numbering: TNumberingStyle read <getter> write <...

  if IsGet then
    Result := TNumberingStyle_sw.ToVar(TParaAttributes(AObj).Numbering)
  else
    TParaAttributes(AObj).Numbering := TNumberingStyle_sw.FromVar(AArgs[0]);
end;

function TParaAttributes_RightIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RightIndent: Longint read <getter> write <setter>;

  if IsGet then
    Result := TParaAttributes(AObj).RightIndent
  else
    TParaAttributes(AObj).RightIndent := Longint(AArgs[0]);
end;

function TParaAttributes_Tab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Tab[Index: Byte]: Longint read <getter> write <s...

  if IsGet then
    Result := TParaAttributes(AObj).Tab[Byte(AArgs[0])]
  else
    TParaAttributes(AObj).Tab[Byte(AArgs[0])] := Longint(AArgs[1]);
end;

function TParaAttributes_TabCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TParaAttributes(AObj).TabCount
  else
    TParaAttributes(AObj).TabCount := Integer(AArgs[0]);
end;

class function TParaAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TParaAttributes';
end;

class function TParaAttributes_sw.GetWrappedClass: TClass;
begin
  Result := TParaAttributes;
end;

class procedure TParaAttributes_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Alignment', TParaAttributes_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('FirstIndent', TParaAttributes_FirstIndent_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('LeftIndent', TParaAttributes_LeftIndent_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('Numbering', TParaAttributes_Numbering_si, TNumberingStyle_sw, True, True, 0, False, False);
  AData.AddProperty('RightIndent', TParaAttributes_RightIndent_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('Tab', TParaAttributes_Tab_si, Longint_sw, True, True, 1, False, False);
  AData.AddProperty('TabCount', TParaAttributes_TabCount_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TParaAttributes_Create_si, 1, False);
end;

class function TParaAttributes_sw.ToVar(
  const AValue: TParaAttributes): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParaAttributes_sw.FromVar(
  const AValue: OleVariant): TParaAttributes;
begin
  Result := TParaAttributes(ConvFromVar(AValue, TParaAttributes));
end;

class function TParaAttributes_sw.ClassToVar(
  AClass: TParaAttributes_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParaAttributes_sw.ClassFromVar(
  const AClass: OleVariant): TParaAttributes_sc;
begin
  Result := TParaAttributes_sc(ConvClsFromVar(AClass, TParaAttributes));
end;

{ TRichEditResizeEvent_sh }

function TRichEditResizeEvent_sh.GetHandler: TMethod;
var
  hdr: TRichEditResizeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TRichEditResizeEvent_sh.Handler(Sender: TObject; Rect: TRect);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Rect: TRect) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(Rect);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TRichEditResizeEvent_sw }

class function TRichEditResizeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TRichEditResizeEvent';
end;

class function TRichEditResizeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TRichEditResizeEvent_sh;
end;

class function TRichEditResizeEvent_sw.ToVar(
  const AValue: TRichEditResizeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TRichEditResizeEvent_sw.FromVar(
  const AValue: OleVariant): TRichEditResizeEvent;
begin
  Result := TRichEditResizeEvent(ConvFromVar(AValue));
end;

class function TRichEditResizeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TRichEditResizeEvent;
var
  hdlr: TRichEditResizeEvent_sh;
begin
  hdlr   := TRichEditResizeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TRichEditResizeEvent_sw));
  Result := hdlr.Handler;
end;

{ TRichEditProtectChange_sh }

function TRichEditProtectChange_sh.GetHandler: TMethod;
var
  hdr: TRichEditProtectChange;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TRichEditProtectChange_sh.Handler(Sender: TObject; StartPos: Integer;
  EndPos: Integer; var AllowChange: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; StartPos: Integer; EndPos: In...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := StartPos;
  args[2] := EndPos;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TRichEditProtectChange_sw }

class function TRichEditProtectChange_sw.GetTypeName: WideString;
begin
  Result := 'TRichEditProtectChange';
end;

class function TRichEditProtectChange_sw.GetScriptHandlerClass: TClass;
begin
  Result := TRichEditProtectChange_sh;
end;

class function TRichEditProtectChange_sw.ToVar(
  const AValue: TRichEditProtectChange): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TRichEditProtectChange_sw.FromVar(
  const AValue: OleVariant): TRichEditProtectChange;
begin
  Result := TRichEditProtectChange(ConvFromVar(AValue));
end;

class function TRichEditProtectChange_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TRichEditProtectChange;
var
  hdlr: TRichEditProtectChange_sh;
begin
  hdlr   := TRichEditProtectChange_sh(AScriptControl.GetEventHandler(AProcName, 
    TRichEditProtectChange_sw));
  Result := hdlr.Handler;
end;

{ TRichEditSaveClipboard_sh }

function TRichEditSaveClipboard_sh.GetHandler: TMethod;
var
  hdr: TRichEditSaveClipboard;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TRichEditSaveClipboard_sh.Handler(Sender: TObject;
  NumObjects: Integer; NumChars: Integer; var SaveClipboard: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; NumObjects: Integer; NumChars...

  v_1 := SaveClipboard;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := NumObjects;
  args[2] := NumChars;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  SaveClipboard := Boolean(v_1);
end;

{ TRichEditSaveClipboard_sw }

class function TRichEditSaveClipboard_sw.GetTypeName: WideString;
begin
  Result := 'TRichEditSaveClipboard';
end;

class function TRichEditSaveClipboard_sw.GetScriptHandlerClass: TClass;
begin
  Result := TRichEditSaveClipboard_sh;
end;

class function TRichEditSaveClipboard_sw.ToVar(
  const AValue: TRichEditSaveClipboard): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TRichEditSaveClipboard_sw.FromVar(
  const AValue: OleVariant): TRichEditSaveClipboard;
begin
  Result := TRichEditSaveClipboard(ConvFromVar(AValue));
end;

class function TRichEditSaveClipboard_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TRichEditSaveClipboard;
var
  hdlr: TRichEditSaveClipboard_sh;
begin
  hdlr   := TRichEditSaveClipboard_sh(AScriptControl.GetEventHandler(AProcName, 
    TRichEditSaveClipboard_sw));
  Result := hdlr.Handler;
end;

{ TSearchType_sw }

class function TSearchType_sw.GetTypeName: WideString;
begin
  Result := 'TSearchType';
end;

class procedure TSearchType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'stWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TSearchType.{$ENDIF}stWholeWord)),
    (Name: 'stMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TSearchType.{$ENDIF}stMatchCase))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TSearchType_sw.ToVar(const AValue: TSearchType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSearchType_sw.FromVar(const AValue: OleVariant): TSearchType;
begin
  Result := TSearchType(Integer(AValue));
end;

{ TSearchTypes_sw }

class function TSearchTypes_sw.GetTypeName: WideString;
begin
  Result := 'TSearchTypes';
end;

class function TSearchTypes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TSearchTypes);
end;

class function TSearchTypes_sw.ToVar(const AValue: TSearchTypes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TSearchTypes_sw.FromVar(const AValue: OleVariant): TSearchTypes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TConversion_sw }

function TConversion_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TConversion_sw.ToVar(TConversion_sc(AObj).Create());
end;

class function TConversion_sw.GetTypeName: WideString;
begin
  Result := 'TConversion';
end;

class function TConversion_sw.GetWrappedClass: TClass;
begin
  Result := TConversion;
end;

class procedure TConversion_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TConversion_Create_si, 0, False);
end;

class function TConversion_sw.ToVar(const AValue: TConversion): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TConversion_sw.FromVar(const AValue: OleVariant): TConversion;
begin
  Result := TConversion(ConvFromVar(AValue, TConversion));
end;

class function TConversion_sw.ClassToVar(AClass: TConversion_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TConversion_sw.ClassFromVar(
  const AClass: OleVariant): TConversion_sc;
begin
  Result := TConversion_sc(ConvClsFromVar(AClass, TConversion));
end;

{ TConversionClass_sw }

class function TConversionClass_sw.GetTypeName: WideString;
begin
  Result := 'TConversionClass';
end;

class function TConversionClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TConversion;
end;

class function TConversionClass_sw.ToVar(
  const AValue: TConversionClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TConversionClass_sw.FromVar(
  const AValue: OleVariant): TConversionClass;
begin
  Result := TConversionClass(ConvFromVar(AValue, TConversion));
end;

{ TConversionFormat_sw }

function TConversionFormat_ConversionClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ConversionClass: TConversionClass;

  if IsGet then
    Result := TConversionClass_sw.ToVar(TConversionFormat_sw(AObj).FValue.
      ConversionClass)
  else
    TConversionFormat_sw(AObj).FValue.ConversionClass := TConversionClass_sw.
      FromVar(AArgs[0]);
end;

function TConversionFormat_Extension_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Extension: string;

  if IsGet then
    Result := TConversionFormat_sw(AObj).FValue.Extension
  else
    TConversionFormat_sw(AObj).FValue.Extension := string(AArgs[0]);
end;

function TConversionFormat_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TConversionFormat_sw.Create as IDispatch;
end;

function TConversionFormat_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TConversionFormat;

  // Implicit record copy method.
  Result := TConversionFormat_sw.ToVar(TConversionFormat(AObj));
end;

class function TConversionFormat_sw.GetTypeName: WideString;
begin
  Result := 'TConversionFormat';
end;

function TConversionFormat_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TConversionFormat_sw.Create;
  TConversionFormat_sw(Result).FValue := FValue;
end;

class procedure TConversionFormat_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ConversionClass', TConversionFormat_ConversionClass_si, TConversionClass_sw);
  AData.AddField('Extension', TConversionFormat_Extension_si, string_sw);
  AData.AddFunction('Copy', TConversionFormat_Copy_si, TConversionFormat_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TConversionFormat_Create_si, 0, False);
end;

class function TConversionFormat_sw.ToVar(
  const AValue: TConversionFormat): OleVariant;
var
  wrpr: TConversionFormat_sw;
begin
  wrpr        := TConversionFormat_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TConversionFormat_sw.FromVar(
  const AValue: OleVariant): TConversionFormat;
begin
  Result := TConversionFormat_sw(ConvFromVar(AValue)).FValue;
end;

{ TRichEditStreamInfo_sw }

function TRichEditStreamInfo_Converter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Converter: TConversion;

  if IsGet then
    Result := TConversion_sw.ToVar(TRichEditStreamInfo_sw(AObj).FValue.
      Converter)
  else
    TRichEditStreamInfo_sw(AObj).FValue.Converter := TConversion_sw.FromVar(
      AArgs[0]);
end;

function TRichEditStreamInfo_Stream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Stream: TStream;

  if IsGet then
    Result := TStream_sw.ToVar(TRichEditStreamInfo_sw(AObj).FValue.Stream)
  else
    TRichEditStreamInfo_sw(AObj).FValue.Stream := TStream_sw.FromVar(AArgs[0]);
end;

function TRichEditStreamInfo_PlainText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PlainText: Boolean;

  if IsGet then
    Result := TRichEditStreamInfo_sw(AObj).FValue.PlainText
  else
    TRichEditStreamInfo_sw(AObj).FValue.PlainText := Boolean(AArgs[0]);
end;

function TRichEditStreamInfo_Encoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Encoding: TEncoding;

  if IsGet then
    Result := TEncoding_sw.ToVar(TRichEditStreamInfo_sw(AObj).FValue.Encoding)
  else
    TRichEditStreamInfo_sw(AObj).FValue.Encoding := TEncoding_sw.FromVar(
      AArgs[0]);
end;

function TRichEditStreamInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TRichEditStreamInfo_sw.Create as IDispatch;
end;

function TRichEditStreamInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TRichEditStreamInfo;

  // Implicit record copy method.
  Result := TRichEditStreamInfo_sw.ToVar(TRichEditStreamInfo(AObj));
end;

class function TRichEditStreamInfo_sw.GetTypeName: WideString;
begin
  Result := 'TRichEditStreamInfo';
end;

function TRichEditStreamInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TRichEditStreamInfo_sw.Create;
  TRichEditStreamInfo_sw(Result).FValue := FValue;
end;

class procedure TRichEditStreamInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Converter', TRichEditStreamInfo_Converter_si, TConversion_sw);
  AData.AddField('Stream', TRichEditStreamInfo_Stream_si, TStream_sw);
  AData.AddField('PlainText', TRichEditStreamInfo_PlainText_si, Boolean_sw);
  AData.AddField('Encoding', TRichEditStreamInfo_Encoding_si, TEncoding_sw);
  AData.AddFunction('Copy', TRichEditStreamInfo_Copy_si, TRichEditStreamInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRichEditStreamInfo_Create_si, 0, False);
end;

class function TRichEditStreamInfo_sw.ToVar(
  const AValue: TRichEditStreamInfo): OleVariant;
var
  wrpr: TRichEditStreamInfo_sw;
begin
  wrpr        := TRichEditStreamInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TRichEditStreamInfo_sw.FromVar(
  const AValue: OleVariant): TRichEditStreamInfo;
begin
  Result := TRichEditStreamInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TCustomRichEdit_sw }

function TCustomRichEdit_HideSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HideSelection: Boolean read <getter> w...

  if IsGet then
    Result := TCustomRichEdit_sacc(TCustomRichEdit(AObj)).HideSelection
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).HideSelection := Boolean(
      AArgs[0]);
end;

function TCustomRichEdit_HideScrollBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HideScrollBars: Boolean read <getter> ...

  if IsGet then
    Result := TCustomRichEdit_sacc(TCustomRichEdit(AObj)).HideScrollBars
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).HideScrollBars := Boolean(
      AArgs[0]);
end;

function TCustomRichEdit_Lines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Lines: TStrings read <getter> write <s...

  if IsGet then
    Result := TStrings_sw.ToVar(TCustomRichEdit_sacc(TCustomRichEdit(AObj)).
      Lines)
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).Lines := TStrings_sw.FromVar(
      AArgs[0]);
end;

function TCustomRichEdit_OnSaveClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSaveClipboard: TRichEditSaveClipboar...

  if IsGet then
    Result := TRichEditSaveClipboard_sw.ToVar(TCustomRichEdit_sacc(
      TCustomRichEdit(AObj)).OnSaveClipboard)
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).OnSaveClipboard := 
      TRichEditSaveClipboard_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_OnSelectionChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSelectionChange: TNotifyEvent read <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomRichEdit_sacc(TCustomRichEdit(AObj)).
      OnSelectionChange)
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).OnSelectionChange := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_OnProtectChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnProtectChange: TRichEditProtectChang...

  if IsGet then
    Result := TRichEditProtectChange_sw.ToVar(TCustomRichEdit_sacc(
      TCustomRichEdit(AObj)).OnProtectChange)
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).OnProtectChange := 
      TRichEditProtectChange_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_OnResizeRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnResizeRequest: TRichEditResizeEvent ...

  if IsGet then
    Result := TRichEditResizeEvent_sw.ToVar(TCustomRichEdit_sacc(
      TCustomRichEdit(AObj)).OnResizeRequest)
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).OnResizeRequest := 
      TRichEditResizeEvent_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_PlainText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PlainText: Boolean read <getter> write...

  if IsGet then
    Result := TCustomRichEdit_sacc(TCustomRichEdit(AObj)).PlainText
  else
    TCustomRichEdit_sacc(TCustomRichEdit(AObj)).PlainText := Boolean(AArgs[0]);
end;

function TCustomRichEdit_FindText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindText(const SearchStr: string; StartPos: Inte...

  Result := TCustomRichEdit(AObj).FindText(string(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]), TSearchTypes_sw.FromVar(AArgs[3]));
end;

function TCustomRichEdit_Print_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Print(const Caption: string);

  TCustomRichEdit(AObj).Print(string(AArgs[0]));
end;

function TCustomRichEdit_RegisterConversionFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RegisterConversionFormat(const AExtension...

  TCustomRichEdit_sc(AObj).RegisterConversionFormat(string(AArgs[0]), 
    TConversionClass_sw.FromVar(AArgs[1]));
end;

function TCustomRichEdit_ActiveLineNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveLineNo: DWORD read <getter>;

  Result := DWORD_sw.ToVar(TCustomRichEdit(AObj).ActiveLineNo);
end;

function TCustomRichEdit_DefaultConverter_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultConverter: TConversionClass read <getter>...

  if IsGet then
    Result := TConversionClass_sw.ToVar(TCustomRichEdit(AObj).DefaultConverter)
  else
    TCustomRichEdit(AObj).DefaultConverter := TConversionClass_sw.FromVar(
      AArgs[0]);
end;

function TCustomRichEdit_DefAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefAttributes: TTextAttributes read <getter> wri...

  if IsGet then
    Result := TTextAttributes_sw.ToVar(TCustomRichEdit(AObj).DefAttributes)
  else
    TCustomRichEdit(AObj).DefAttributes := TTextAttributes_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_SelAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelAttributes: TTextAttributes read <getter> wri...

  if IsGet then
    Result := TTextAttributes_sw.ToVar(TCustomRichEdit(AObj).SelAttributes)
  else
    TCustomRichEdit(AObj).SelAttributes := TTextAttributes_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_PageRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageRect: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TCustomRichEdit(AObj).PageRect)
  else
    TCustomRichEdit(AObj).PageRect := TRect_sw.FromVar(AArgs[0]);
end;

function TCustomRichEdit_Paragraph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Paragraph: TParaAttributes read <getter>;

  Result := TParaAttributes_sw.ToVar(TCustomRichEdit(AObj).Paragraph);
end;

class function TCustomRichEdit_sw.GetTypeName: WideString;
begin
  Result := 'TCustomRichEdit';
end;

class function TCustomRichEdit_sw.GetWrappedClass: TClass;
begin
  Result := TCustomRichEdit;
end;

class procedure TCustomRichEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('HideSelection', TCustomRichEdit_HideSelection_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('HideScrollBars', TCustomRichEdit_HideScrollBars_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Lines', TCustomRichEdit_Lines_si, TStrings_sw, True, True, 0, True, False);
  AData.AddProperty('OnSaveClipboard', TCustomRichEdit_OnSaveClipboard_si, TRichEditSaveClipboard_sw, True, True, 0, True, False);
  AData.AddProperty('OnSelectionChange', TCustomRichEdit_OnSelectionChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnProtectChange', TCustomRichEdit_OnProtectChange_si, TRichEditProtectChange_sw, True, True, 0, True, False);
  AData.AddProperty('OnResizeRequest', TCustomRichEdit_OnResizeRequest_si, TRichEditResizeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('PlainText', TCustomRichEdit_PlainText_si, Boolean_sw, True, True, 0, True, False);
  AData.AddFunction('FindText', TCustomRichEdit_FindText_si, Integer_sw, 4, False);
  AData.AddProcedure('Print', TCustomRichEdit_Print_si, 1, False);
  AData.AddProperty('ActiveLineNo', TCustomRichEdit_ActiveLineNo_si, DWORD_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultConverter', TCustomRichEdit_DefaultConverter_si, TConversionClass_sw, True, True, 0, False, False);
  AData.AddProperty('DefAttributes', TCustomRichEdit_DefAttributes_si, TTextAttributes_sw, True, True, 0, False, False);
  AData.AddProperty('SelAttributes', TCustomRichEdit_SelAttributes_si, TTextAttributes_sw, True, True, 0, False, False);
  AData.AddProperty('PageRect', TCustomRichEdit_PageRect_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('Paragraph', TCustomRichEdit_Paragraph_si, TParaAttributes_sw, True, False, 0, False, False);

  { Class members }

  AData.AddClassProcedure('RegisterConversionFormat', TCustomRichEdit_RegisterConversionFormat_si, 2, False);
end;

class function TCustomRichEdit_sw.ToVar(
  const AValue: TCustomRichEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomRichEdit_sw.FromVar(
  const AValue: OleVariant): TCustomRichEdit;
begin
  Result := TCustomRichEdit(ConvFromVar(AValue, TCustomRichEdit));
end;

class function TCustomRichEdit_sw.ClassToVar(
  AClass: TCustomRichEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomRichEdit_sw.ClassFromVar(
  const AClass: OleVariant): TCustomRichEdit_sc;
begin
  Result := TCustomRichEdit_sc(ConvClsFromVar(AClass, TCustomRichEdit));
end;

{ TRichEdit_sw }

class function TRichEdit_sw.GetTypeName: WideString;
begin
  Result := 'TRichEdit';
end;

class function TRichEdit_sw.GetWrappedClass: TClass;
begin
  Result := TRichEdit;
end;

class procedure TRichEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('HideScrollBars', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Lines', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PlainText', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('ScrollBars', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WantTabs', False);
  AData.AddPropertyRedecl('WantReturns', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('StyleElements', False);
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
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnProtectChange', False);
  AData.AddPropertyRedecl('OnResizeRequest', False);
  AData.AddPropertyRedecl('OnSaveClipboard', False);
  AData.AddPropertyRedecl('OnSelectionChange', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TRichEdit_sw.ToVar(const AValue: TRichEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TRichEdit_sw.FromVar(const AValue: OleVariant): TRichEdit;
begin
  Result := TRichEdit(ConvFromVar(AValue, TRichEdit));
end;

class function TRichEdit_sw.ClassToVar(AClass: TRichEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TRichEdit_sw.ClassFromVar(
  const AClass: OleVariant): TRichEdit_sc;
begin
  Result := TRichEdit_sc(ConvClsFromVar(AClass, TRichEdit));
end;

{ TUDAlignButton_sw }

class function TUDAlignButton_sw.GetTypeName: WideString;
begin
  Result := 'TUDAlignButton';
end;

class procedure TUDAlignButton_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'udLeft'; Value: Integer({$IFDEF LMDSCT_12}TUDAlignButton.{$ENDIF}udLeft)),
    (Name: 'udRight'; Value: Integer({$IFDEF LMDSCT_12}TUDAlignButton.{$ENDIF}udRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TUDAlignButton_sw.ToVar(
  const AValue: TUDAlignButton): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUDAlignButton_sw.FromVar(
  const AValue: OleVariant): TUDAlignButton;
begin
  Result := TUDAlignButton(Integer(AValue));
end;

{ TUDOrientation_sw }

class function TUDOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TUDOrientation';
end;

class procedure TUDOrientation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'udHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TUDOrientation.{$ENDIF}udHorizontal)),
    (Name: 'udVertical'; Value: Integer({$IFDEF LMDSCT_12}TUDOrientation.{$ENDIF}udVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TUDOrientation_sw.ToVar(
  const AValue: TUDOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUDOrientation_sw.FromVar(
  const AValue: OleVariant): TUDOrientation;
begin
  Result := TUDOrientation(Integer(AValue));
end;

{ TUDBtnType_sw }

class function TUDBtnType_sw.GetTypeName: WideString;
begin
  Result := 'TUDBtnType';
end;

class procedure TUDBtnType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'btNext'; Value: Integer({$IFDEF LMDSCT_12}TUDBtnType.{$ENDIF}btNext)),
    (Name: 'btPrev'; Value: Integer({$IFDEF LMDSCT_12}TUDBtnType.{$ENDIF}btPrev))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TUDBtnType_sw.ToVar(const AValue: TUDBtnType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUDBtnType_sw.FromVar(const AValue: OleVariant): TUDBtnType;
begin
  Result := TUDBtnType(Integer(AValue));
end;

{ TUpDownDirection_sw }

class function TUpDownDirection_sw.GetTypeName: WideString;
begin
  Result := 'TUpDownDirection';
end;

class procedure TUpDownDirection_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'updNone'; Value: Integer({$IFDEF LMDSCT_12}TUpDownDirection.{$ENDIF}updNone)),
    (Name: 'updUp'; Value: Integer({$IFDEF LMDSCT_12}TUpDownDirection.{$ENDIF}updUp)),
    (Name: 'updDown'; Value: Integer({$IFDEF LMDSCT_12}TUpDownDirection.{$ENDIF}updDown))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TUpDownDirection_sw.ToVar(
  const AValue: TUpDownDirection): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUpDownDirection_sw.FromVar(
  const AValue: OleVariant): TUpDownDirection;
begin
  Result := TUpDownDirection(Integer(AValue));
end;

{ TUDClickEvent_sh }

function TUDClickEvent_sh.GetHandler: TMethod;
var
  hdr: TUDClickEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUDClickEvent_sh.Handler(Sender: TObject; Button: TUDBtnType);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Button: TUDBtnType) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TUDBtnType_sw.ToVar(Button);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TUDClickEvent_sw }

class function TUDClickEvent_sw.GetTypeName: WideString;
begin
  Result := 'TUDClickEvent';
end;

class function TUDClickEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUDClickEvent_sh;
end;

class function TUDClickEvent_sw.ToVar(const AValue: TUDClickEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUDClickEvent_sw.FromVar(
  const AValue: OleVariant): TUDClickEvent;
begin
  Result := TUDClickEvent(ConvFromVar(AValue));
end;

class function TUDClickEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TUDClickEvent;
var
  hdlr: TUDClickEvent_sh;
begin
  hdlr   := TUDClickEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TUDClickEvent_sw));
  Result := hdlr.Handler;
end;

{ TUDChangingEvent_sh }

function TUDChangingEvent_sh.GetHandler: TMethod;
var
  hdr: TUDChangingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUDChangingEvent_sh.Handler(Sender: TObject;
  var AllowChange: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var AllowChange: Boolean) of ...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TUDChangingEvent_sw }

class function TUDChangingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TUDChangingEvent';
end;

class function TUDChangingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUDChangingEvent_sh;
end;

class function TUDChangingEvent_sw.ToVar(
  const AValue: TUDChangingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUDChangingEvent_sw.FromVar(
  const AValue: OleVariant): TUDChangingEvent;
begin
  Result := TUDChangingEvent(ConvFromVar(AValue));
end;

class function TUDChangingEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TUDChangingEvent;
var
  hdlr: TUDChangingEvent_sh;
begin
  hdlr   := TUDChangingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TUDChangingEvent_sw));
  Result := hdlr.Handler;
end;

{ TUDChangingEventEx_sh }

function TUDChangingEventEx_sh.GetHandler: TMethod;
var
  hdr: TUDChangingEventEx;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUDChangingEventEx_sh.Handler(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var AllowChange: Boolean; New...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  args[2] := NewValue;
  args[3] := TUpDownDirection_sw.ToVar(Direction);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TUDChangingEventEx_sw }

class function TUDChangingEventEx_sw.GetTypeName: WideString;
begin
  Result := 'TUDChangingEventEx';
end;

class function TUDChangingEventEx_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUDChangingEventEx_sh;
end;

class function TUDChangingEventEx_sw.ToVar(
  const AValue: TUDChangingEventEx): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUDChangingEventEx_sw.FromVar(
  const AValue: OleVariant): TUDChangingEventEx;
begin
  Result := TUDChangingEventEx(ConvFromVar(AValue));
end;

class function TUDChangingEventEx_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TUDChangingEventEx;
var
  hdlr: TUDChangingEventEx_sh;
begin
  hdlr   := TUDChangingEventEx_sh(AScriptControl.GetEventHandler(AProcName, 
    TUDChangingEventEx_sw));
  Result := hdlr.Handler;
end;

{ TCustomUpDown_sw }

function TCustomUpDown_AlignButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AlignButton: TUDAlignButton read <gett...

  if IsGet then
    Result := TUDAlignButton_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(AObj)).
      AlignButton)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).AlignButton := TUDAlignButton_sw.
      FromVar(AArgs[0]);
end;

function TCustomUpDown_ArrowKeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ArrowKeys: Boolean read <getter> write...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).ArrowKeys
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).ArrowKeys := Boolean(AArgs[0]);
end;

function TCustomUpDown_Associate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Associate: TWinControl read <getter> w...

  if IsGet then
    Result := TWinControl_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(AObj)).
      Associate)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Associate := TWinControl_sw.FromVar(
      AArgs[0]);
end;

function TCustomUpDown_Min_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Min: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Min
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Min := Integer(AArgs[0]);
end;

function TCustomUpDown_Max_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Max: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Max
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Max := Integer(AArgs[0]);
end;

function TCustomUpDown_Increment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Increment: Integer read <getter> write...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Increment
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Increment := Integer(AArgs[0]);
end;

function TCustomUpDown_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Orientation: TUDOrientation read <gett...

  if IsGet then
    Result := TUDOrientation_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(AObj)).
      Orientation)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Orientation := TUDOrientation_sw.
      FromVar(AArgs[0]);
end;

function TCustomUpDown_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Position: Integer read <getter> write ...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Position
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Position := Integer(AArgs[0]);
end;

function TCustomUpDown_Thousands_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Thousands: Boolean read <getter> write...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Thousands
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Thousands := Boolean(AArgs[0]);
end;

function TCustomUpDown_Wrap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Wrap: Boolean read <getter> write <set...

  if IsGet then
    Result := TCustomUpDown_sacc(TCustomUpDown(AObj)).Wrap
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).Wrap := Boolean(AArgs[0]);
end;

function TCustomUpDown_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChanging: TUDChangingEvent read <get...

  if IsGet then
    Result := TUDChangingEvent_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(AObj)).
      OnChanging)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).OnChanging := TUDChangingEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomUpDown_OnChangingEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChangingEx: TUDChangingEventEx read ...

  if IsGet then
    Result := TUDChangingEventEx_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(
      AObj)).OnChangingEx)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).OnChangingEx := 
      TUDChangingEventEx_sw.FromVar(AArgs[0]);
end;

function TCustomUpDown_OnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnClick: TUDClickEvent read <getter> w...

  if IsGet then
    Result := TUDClickEvent_sw.ToVar(TCustomUpDown_sacc(TCustomUpDown(AObj)).
      OnClick)
  else
    TCustomUpDown_sacc(TCustomUpDown(AObj)).OnClick := TUDClickEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomUpDown_sw.GetTypeName: WideString;
begin
  Result := 'TCustomUpDown';
end;

class function TCustomUpDown_sw.GetWrappedClass: TClass;
begin
  Result := TCustomUpDown;
end;

class procedure TCustomUpDown_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AlignButton', TCustomUpDown_AlignButton_si, TUDAlignButton_sw, True, True, 0, True, False);
  AData.AddProperty('ArrowKeys', TCustomUpDown_ArrowKeys_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Associate', TCustomUpDown_Associate_si, TWinControl_sw, True, True, 0, True, False);
  AData.AddProperty('Min', TCustomUpDown_Min_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Max', TCustomUpDown_Max_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Increment', TCustomUpDown_Increment_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Orientation', TCustomUpDown_Orientation_si, TUDOrientation_sw, True, True, 0, True, False);
  AData.AddProperty('Position', TCustomUpDown_Position_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Thousands', TCustomUpDown_Thousands_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Wrap', TCustomUpDown_Wrap_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnChanging', TCustomUpDown_OnChanging_si, TUDChangingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChangingEx', TCustomUpDown_OnChangingEx_si, TUDChangingEventEx_sw, True, True, 0, True, False);
  AData.AddProperty('OnClick', TCustomUpDown_OnClick_si, TUDClickEvent_sw, True, True, 0, True, False);
end;

class function TCustomUpDown_sw.ToVar(const AValue: TCustomUpDown): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomUpDown_sw.FromVar(
  const AValue: OleVariant): TCustomUpDown;
begin
  Result := TCustomUpDown(ConvFromVar(AValue, TCustomUpDown));
end;

class function TCustomUpDown_sw.ClassToVar(
  AClass: TCustomUpDown_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomUpDown_sw.ClassFromVar(
  const AClass: OleVariant): TCustomUpDown_sc;
begin
  Result := TCustomUpDown_sc(ConvClsFromVar(AClass, TCustomUpDown));
end;

{ TUpDown_sw }

class function TUpDown_sw.GetTypeName: WideString;
begin
  Result := 'TUpDown';
end;

class function TUpDown_sw.GetWrappedClass: TClass;
begin
  Result := TUpDown;
end;

class procedure TUpDown_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AlignButton', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('Associate', False);
  AData.AddPropertyRedecl('ArrowKeys', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('Min', False);
  AData.AddPropertyRedecl('Max', False);
  AData.AddPropertyRedecl('Increment', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Orientation', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('Position', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Thousands', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Wrap', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnChanging', False);
  AData.AddPropertyRedecl('OnChangingEx', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
end;

class function TUpDown_sw.ToVar(const AValue: TUpDown): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TUpDown_sw.FromVar(const AValue: OleVariant): TUpDown;
begin
  Result := TUpDown(ConvFromVar(AValue, TUpDown));
end;

class function TUpDown_sw.ClassToVar(AClass: TUpDown_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TUpDown_sw.ClassFromVar(const AClass: OleVariant): TUpDown_sc;
begin
  Result := TUpDown_sc(ConvClsFromVar(AClass, TUpDown));
end;

{ THKModifier_sw }

class function THKModifier_sw.GetTypeName: WideString;
begin
  Result := 'THKModifier';
end;

class procedure THKModifier_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'hkShift'; Value: Integer({$IFDEF LMDSCT_12}THKModifier.{$ENDIF}hkShift)),
    (Name: 'hkCtrl'; Value: Integer({$IFDEF LMDSCT_12}THKModifier.{$ENDIF}hkCtrl)),
    (Name: 'hkAlt'; Value: Integer({$IFDEF LMDSCT_12}THKModifier.{$ENDIF}hkAlt)),
    (Name: 'hkExt'; Value: Integer({$IFDEF LMDSCT_12}THKModifier.{$ENDIF}hkExt))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function THKModifier_sw.ToVar(const AValue: THKModifier): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THKModifier_sw.FromVar(const AValue: OleVariant): THKModifier;
begin
  Result := THKModifier(Integer(AValue));
end;

{ THKModifiers_sw }

class function THKModifiers_sw.GetTypeName: WideString;
begin
  Result := 'THKModifiers';
end;

class function THKModifiers_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(THKModifiers);
end;

class function THKModifiers_sw.ToVar(const AValue: THKModifiers): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function THKModifiers_sw.FromVar(const AValue: OleVariant): THKModifiers;
begin
  ConvFromVar(AValue, @Result);
end;

{ THKInvalidKey_sw }

class function THKInvalidKey_sw.GetTypeName: WideString;
begin
  Result := 'THKInvalidKey';
end;

class procedure THKInvalidKey_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'hcNone'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcNone)),
    (Name: 'hcShift'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcShift)),
    (Name: 'hcCtrl'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcCtrl)),
    (Name: 'hcAlt'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcAlt)),
    (Name: 'hcShiftCtrl'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcShiftCtrl)),
    (Name: 'hcShiftAlt'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcShiftAlt)),
    (Name: 'hcCtrlAlt'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcCtrlAlt)),
    (Name: 'hcShiftCtrlAlt'; Value: Integer({$IFDEF LMDSCT_12}THKInvalidKey.{$ENDIF}hcShiftCtrlAlt))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function THKInvalidKey_sw.ToVar(const AValue: THKInvalidKey): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THKInvalidKey_sw.FromVar(
  const AValue: OleVariant): THKInvalidKey;
begin
  Result := THKInvalidKey(Integer(AValue));
end;

{ THKInvalidKeys_sw }

class function THKInvalidKeys_sw.GetTypeName: WideString;
begin
  Result := 'THKInvalidKeys';
end;

class function THKInvalidKeys_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(THKInvalidKeys);
end;

class function THKInvalidKeys_sw.ToVar(
  const AValue: THKInvalidKeys): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function THKInvalidKeys_sw.FromVar(
  const AValue: OleVariant): THKInvalidKeys;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCustomHotKey_sw }

function TCustomHotKey_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSize: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomHotKey_sacc(TCustomHotKey(AObj)).AutoSize
  else
    TCustomHotKey_sacc(TCustomHotKey(AObj)).AutoSize := Boolean(AArgs[0]);
end;

function TCustomHotKey_InvalidKeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property InvalidKeys: THKInvalidKeys read <gett...

  if IsGet then
    Result := THKInvalidKeys_sw.ToVar(TCustomHotKey_sacc(TCustomHotKey(AObj)).
      InvalidKeys)
  else
    TCustomHotKey_sacc(TCustomHotKey(AObj)).InvalidKeys := THKInvalidKeys_sw.
      FromVar(AArgs[0]);
end;

function TCustomHotKey_Modifiers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Modifiers: THKModifiers read <getter> ...

  if IsGet then
    Result := THKModifiers_sw.ToVar(TCustomHotKey_sacc(TCustomHotKey(AObj)).
      Modifiers)
  else
    TCustomHotKey_sacc(TCustomHotKey(AObj)).Modifiers := THKModifiers_sw.
      FromVar(AArgs[0]);
end;

function TCustomHotKey_HotKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HotKey: TShortCut read <getter> write ...

  if IsGet then
    Result := TShortCut_sw.ToVar(TCustomHotKey_sacc(TCustomHotKey(AObj)).HotKey)
  else
    TCustomHotKey_sacc(TCustomHotKey(AObj)).HotKey := TShortCut_sw.FromVar(
      AArgs[0]);
end;

function TCustomHotKey_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomHotKey_sacc(TCustomHotKey(AObj)).
      OnChange)
  else
    TCustomHotKey_sacc(TCustomHotKey(AObj)).OnChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomHotKey_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHotKey';
end;

class function TCustomHotKey_sw.GetWrappedClass: TClass;
begin
  Result := TCustomHotKey;
end;

class procedure TCustomHotKey_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoSize', TCustomHotKey_AutoSize_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('InvalidKeys', TCustomHotKey_InvalidKeys_si, THKInvalidKeys_sw, True, True, 0, True, False);
  AData.AddProperty('Modifiers', TCustomHotKey_Modifiers_si, THKModifiers_sw, True, True, 0, True, False);
  AData.AddProperty('HotKey', TCustomHotKey_HotKey_si, TShortCut_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomHotKey_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
end;

class function TCustomHotKey_sw.ToVar(const AValue: TCustomHotKey): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomHotKey_sw.FromVar(
  const AValue: OleVariant): TCustomHotKey;
begin
  Result := TCustomHotKey(ConvFromVar(AValue, TCustomHotKey));
end;

class function TCustomHotKey_sw.ClassToVar(
  AClass: TCustomHotKey_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomHotKey_sw.ClassFromVar(
  const AClass: OleVariant): TCustomHotKey_sc;
begin
  Result := TCustomHotKey_sc(ConvClsFromVar(AClass, TCustomHotKey));
end;

{ THotKey_sw }

class function THotKey_sw.GetTypeName: WideString;
begin
  Result := 'THotKey';
end;

class function THotKey_sw.GetWrappedClass: TClass;
begin
  Result := THotKey;
end;

class procedure THotKey_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('HotKey', False);
  AData.AddPropertyRedecl('InvalidKeys', False);
  AData.AddPropertyRedecl('Modifiers', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
end;

class function THotKey_sw.ToVar(const AValue: THotKey): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THotKey_sw.FromVar(const AValue: OleVariant): THotKey;
begin
  Result := THotKey(ConvFromVar(AValue, THotKey));
end;

class function THotKey_sw.ClassToVar(AClass: THotKey_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THotKey_sw.ClassFromVar(const AClass: OleVariant): THotKey_sc;
begin
  Result := THotKey_sc(ConvClsFromVar(AClass, THotKey));
end;

{ TWidth_sw }

class function TWidth_sw.GetTypeName: WideString;
begin
  Result := 'TWidth';
end;

class function TWidth_sw.ToVar(const AValue: TWidth): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TWidth_sw.FromVar(const AValue: OleVariant): TWidth;
begin
  Result := TWidth(Integer(AValue));
end;

{ TListGroupState_sw }

class function TListGroupState_sw.GetTypeName: WideString;
begin
  Result := 'TListGroupState';
end;

class procedure TListGroupState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'lgsNormal'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsNormal)),
    (Name: 'lgsHidden'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsHidden)),
    (Name: 'lgsCollapsed'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsCollapsed)),
    (Name: 'lgsNoHeader'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsNoHeader)),
    (Name: 'lgsCollapsible'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsCollapsible)),
    (Name: 'lgsFocused'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsFocused)),
    (Name: 'lgsSelected'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsSelected)),
    (Name: 'lgsSubseted'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsSubseted)),
    (Name: 'lgsSubSetLinkFocused'; Value: Integer({$IFDEF LMDSCT_12}TListGroupState.{$ENDIF}lgsSubSetLinkFocused))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TListGroupState_sw.ToVar(
  const AValue: TListGroupState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListGroupState_sw.FromVar(
  const AValue: OleVariant): TListGroupState;
begin
  Result := TListGroupState(Integer(AValue));
end;

{ TListGroupStateSet_sw }

class function TListGroupStateSet_sw.GetTypeName: WideString;
begin
  Result := 'TListGroupStateSet';
end;

class function TListGroupStateSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TListGroupStateSet);
end;

class function TListGroupStateSet_sw.ToVar(
  const AValue: TListGroupStateSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TListGroupStateSet_sw.FromVar(
  const AValue: OleVariant): TListGroupStateSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TListGroup_sw }

function TListGroup_Header_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Header: string read <getter> write <setter>;

  if IsGet then
    Result := TListGroup(AObj).Header
  else
    TListGroup(AObj).Header := string(AArgs[0]);
end;

function TListGroup_Footer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Footer: string read <getter> write <setter>;

  if IsGet then
    Result := TListGroup(AObj).Footer
  else
    TListGroup(AObj).Footer := string(AArgs[0]);
end;

function TListGroup_GroupID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupID: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListGroup(AObj).GroupID
  else
    TListGroup(AObj).GroupID := Integer(AArgs[0]);
end;

function TListGroup_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TListGroupStateSet read <getter> write <s...

  if IsGet then
    Result := TListGroupStateSet_sw.ToVar(TListGroup(AObj).State)
  else
    TListGroup(AObj).State := TListGroupStateSet_sw.FromVar(AArgs[0]);
end;

function TListGroup_HeaderAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HeaderAlign: TAlignment read <getter> write <set...

  if IsGet then
    Result := TAlignment_sw.ToVar(TListGroup(AObj).HeaderAlign)
  else
    TListGroup(AObj).HeaderAlign := TAlignment_sw.FromVar(AArgs[0]);
end;

function TListGroup_FooterAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FooterAlign: TAlignment read <getter> write <set...

  if IsGet then
    Result := TAlignment_sw.ToVar(TListGroup(AObj).FooterAlign)
  else
    TListGroup(AObj).FooterAlign := TAlignment_sw.FromVar(AArgs[0]);
end;

function TListGroup_Subtitle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Subtitle: string read <getter> write <setter>;

  if IsGet then
    Result := TListGroup(AObj).Subtitle
  else
    TListGroup(AObj).Subtitle := string(AArgs[0]);
end;

function TListGroup_TitleImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TitleImage: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListGroup(AObj).TitleImage)
  else
    TListGroup(AObj).TitleImage := TImageIndex_sw.FromVar(AArgs[0]);
end;

class function TListGroup_sw.GetTypeName: WideString;
begin
  Result := 'TListGroup';
end;

class function TListGroup_sw.GetWrappedClass: TClass;
begin
  Result := TListGroup;
end;

class procedure TListGroup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Header', TListGroup_Header_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Footer', TListGroup_Footer_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('GroupID', TListGroup_GroupID_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('State', TListGroup_State_si, TListGroupStateSet_sw, True, True, 0, False, False);
  AData.AddProperty('HeaderAlign', TListGroup_HeaderAlign_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('FooterAlign', TListGroup_FooterAlign_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('Subtitle', TListGroup_Subtitle_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('TitleImage', TListGroup_TitleImage_si, TImageIndex_sw, True, True, 0, False, False);
end;

class function TListGroup_sw.ToVar(const AValue: TListGroup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListGroup_sw.FromVar(const AValue: OleVariant): TListGroup;
begin
  Result := TListGroup(ConvFromVar(AValue, TListGroup));
end;

class function TListGroup_sw.ClassToVar(AClass: TListGroup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListGroup_sw.ClassFromVar(
  const AClass: OleVariant): TListGroup_sc;
begin
  Result := TListGroup_sc(ConvClsFromVar(AClass, TListGroup));
end;

{ TListGroups_sw }

function TListGroups_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomListView);

  Result := TListGroups_sw.ToVar(TListGroups_sc(AObj).Create(TCustomListView_sw.
    FromVar(AArgs[0])));
end;

function TListGroups_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TListGroup;

  Result := TListGroup_sw.ToVar(TListGroups(AObj).Add());
end;

function TListGroups_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Owner: TCustomListView;

  Result := TCustomListView_sw.ToVar(TListGroups(AObj).Owner());
end;

function TListGroups_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TListGroup read <getter> ...

  if IsGet then
    Result := TListGroup_sw.ToVar(TListGroups(AObj).Items[Integer(AArgs[0])])
  else
    TListGroups(AObj).Items[Integer(AArgs[0])] := TListGroup_sw.FromVar(
      AArgs[1]);
end;

function TListGroups_NextGroupID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NextGroupID: Integer read <getter>;

  Result := TListGroups(AObj).NextGroupID;
end;

class function TListGroups_sw.GetTypeName: WideString;
begin
  Result := 'TListGroups';
end;

class function TListGroups_sw.GetWrappedClass: TClass;
begin
  Result := TListGroups;
end;

class procedure TListGroups_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TListGroups_Add_si, TListGroup_sw, 0, False);
  AData.AddFunction('Owner', TListGroups_Owner_si, TCustomListView_sw, 0, False);
  AData.AddProperty('Items', TListGroups_Items_si, TListGroup_sw, True, True, 1, False, True);
  AData.AddProperty('NextGroupID', TListGroups_NextGroupID_si, Integer_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TListGroups_Create_si, 1, False);
end;

class function TListGroups_sw.ToVar(const AValue: TListGroups): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListGroups_sw.FromVar(const AValue: OleVariant): TListGroups;
begin
  Result := TListGroups(ConvFromVar(AValue, TListGroups));
end;

class function TListGroups_sw.ClassToVar(AClass: TListGroups_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListGroups_sw.ClassFromVar(
  const AClass: OleVariant): TListGroups_sc;
begin
  Result := TListGroups_sc(ConvClsFromVar(AClass, TListGroups));
end;

{ TListColumn_sw }

function TListColumn_WidthType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WidthType: TWidth read <getter>;

  Result := TWidth_sw.ToVar(TListColumn(AObj).WidthType);
end;

function TListColumn_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TListColumn(AObj).Alignment)
  else
    TListColumn(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TListColumn_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListColumn(AObj).AutoSize
  else
    TListColumn(AObj).AutoSize := Boolean(AArgs[0]);
end;

function TListColumn_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TListColumn(AObj).Caption
  else
    TListColumn(AObj).Caption := string(AArgs[0]);
end;

function TListColumn_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListColumn(AObj).ImageIndex)
  else
    TListColumn(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TListColumn_MaxWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxWidth: TWidth read <getter> write <setter>;

  if IsGet then
    Result := TWidth_sw.ToVar(TListColumn(AObj).MaxWidth)
  else
    TListColumn(AObj).MaxWidth := TWidth_sw.FromVar(AArgs[0]);
end;

function TListColumn_MinWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinWidth: TWidth read <getter> write <setter>;

  if IsGet then
    Result := TWidth_sw.ToVar(TListColumn(AObj).MinWidth)
  else
    TListColumn(AObj).MinWidth := TWidth_sw.FromVar(AArgs[0]);
end;

function TListColumn_Tag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Tag: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListColumn(AObj).Tag
  else
    TListColumn(AObj).Tag := Integer(AArgs[0]);
end;

function TListColumn_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: TWidth read <getter> write <setter>;

  if IsGet then
    Result := TWidth_sw.ToVar(TListColumn(AObj).Width)
  else
    TListColumn(AObj).Width := TWidth_sw.FromVar(AArgs[0]);
end;

class function TListColumn_sw.GetTypeName: WideString;
begin
  Result := 'TListColumn';
end;

class function TListColumn_sw.GetWrappedClass: TClass;
begin
  Result := TListColumn;
end;

class procedure TListColumn_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('WidthType', TListColumn_WidthType_si, TWidth_sw, True, False, 0, False, False);
  AData.AddProperty('Alignment', TListColumn_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('AutoSize', TListColumn_AutoSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TListColumn_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TListColumn_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('MaxWidth', TListColumn_MaxWidth_si, TWidth_sw, True, True, 0, False, False);
  AData.AddProperty('MinWidth', TListColumn_MinWidth_si, TWidth_sw, True, True, 0, False, False);
  AData.AddProperty('Tag', TListColumn_Tag_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TListColumn_Width_si, TWidth_sw, True, True, 0, False, False);
end;

class function TListColumn_sw.ToVar(const AValue: TListColumn): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListColumn_sw.FromVar(const AValue: OleVariant): TListColumn;
begin
  Result := TListColumn(ConvFromVar(AValue, TListColumn));
end;

class function TListColumn_sw.ClassToVar(AClass: TListColumn_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListColumn_sw.ClassFromVar(
  const AClass: OleVariant): TListColumn_sc;
begin
  Result := TListColumn_sc(ConvClsFromVar(AClass, TListColumn));
end;

{ TListColumns_sw }

function TListColumns_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomListView);

  Result := TListColumns_sw.ToVar(TListColumns_sc(AObj).Create(
    TCustomListView_sw.FromVar(AArgs[0])));
end;

function TListColumns_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TListColumn;

  Result := TListColumn_sw.ToVar(TListColumns(AObj).Add());
end;

function TListColumns_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Owner: TCustomListView;

  Result := TCustomListView_sw.ToVar(TListColumns(AObj).Owner());
end;

function TListColumns_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TListColumn read <getter>...

  if IsGet then
    Result := TListColumn_sw.ToVar(TListColumns(AObj).Items[Integer(AArgs[0])])
  else
    TListColumns(AObj).Items[Integer(AArgs[0])] := TListColumn_sw.FromVar(
      AArgs[1]);
end;

class function TListColumns_sw.GetTypeName: WideString;
begin
  Result := 'TListColumns';
end;

class function TListColumns_sw.GetWrappedClass: TClass;
begin
  Result := TListColumns;
end;

class procedure TListColumns_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TListColumns_Add_si, TListColumn_sw, 0, False);
  AData.AddFunction('Owner', TListColumns_Owner_si, TCustomListView_sw, 0, False);
  AData.AddProperty('Items', TListColumns_Items_si, TListColumn_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TListColumns_Create_si, 1, False);
end;

class function TListColumns_sw.ToVar(const AValue: TListColumns): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListColumns_sw.FromVar(const AValue: OleVariant): TListColumns;
begin
  Result := TListColumns(ConvFromVar(AValue, TListColumns));
end;

class function TListColumns_sw.ClassToVar(AClass: TListColumns_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListColumns_sw.ClassFromVar(
  const AClass: OleVariant): TListColumns_sc;
begin
  Result := TListColumns_sc(ConvClsFromVar(AClass, TListColumns));
end;

{ TDisplayCode_sw }

class function TDisplayCode_sw.GetTypeName: WideString;
begin
  Result := 'TDisplayCode';
end;

class procedure TDisplayCode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'drBounds'; Value: Integer({$IFDEF LMDSCT_12}TDisplayCode.{$ENDIF}drBounds)),
    (Name: 'drIcon'; Value: Integer({$IFDEF LMDSCT_12}TDisplayCode.{$ENDIF}drIcon)),
    (Name: 'drLabel'; Value: Integer({$IFDEF LMDSCT_12}TDisplayCode.{$ENDIF}drLabel)),
    (Name: 'drSelectBounds'; Value: Integer({$IFDEF LMDSCT_12}TDisplayCode.{$ENDIF}drSelectBounds))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TDisplayCode_sw.ToVar(const AValue: TDisplayCode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDisplayCode_sw.FromVar(const AValue: OleVariant): TDisplayCode;
begin
  Result := TDisplayCode(Integer(AValue));
end;

{ TListItemClass_sw }

class function TListItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TListItemClass';
end;

class function TListItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TListItem;
end;

class function TListItemClass_sw.ToVar(
  const AValue: TListItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListItemClass_sw.FromVar(
  const AValue: OleVariant): TListItemClass;
begin
  Result := TListItemClass(ConvFromVar(AValue, TListItem));
end;

{ TListItem_sw }

function TListItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TListItems);

  Result := TListItem_sw.ToVar(TListItem_sc(AObj).Create(TListItems_sw.FromVar(
    AArgs[0])));
end;

function TListItem_CancelEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelEdit;

  TListItem(AObj).CancelEdit();
end;

function TListItem_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete;

  TListItem(AObj).Delete();
end;

function TListItem_DisplayRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DisplayRect(Code: TDisplayCode): TRect;

  Result := TRect_sw.ToVar(TListItem(AObj).DisplayRect(TDisplayCode_sw.FromVar(
    AArgs[0])));
end;

function TListItem_EditCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EditCaption: Boolean;

  Result := TListItem(AObj).EditCaption();
end;

function TListItem_GetPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPosition: TPoint;

  Result := TPoint_sw.ToVar(TListItem(AObj).GetPosition());
end;

function TListItem_MakeVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MakeVisible(PartialOK: Boolean);

  TListItem(AObj).MakeVisible(Boolean(AArgs[0]));
end;

function TListItem_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TListItem(AObj).Update();
end;

function TListItem_SetPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetPosition(const Value: TPoint);

  TListItem(AObj).SetPosition(TPoint_sw.FromVar(AArgs[0]));
end;

function TListItem_WorkArea_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WorkArea: Integer;

  Result := TListItem(AObj).WorkArea();
end;

function TListItem_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Caption
  else
    TListItem(AObj).Caption := string(AArgs[0]);
end;

function TListItem_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Checked
  else
    TListItem(AObj).Checked := Boolean(AArgs[0]);
end;

function TListItem_Cut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cut: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Cut
  else
    TListItem(AObj).Cut := Boolean(AArgs[0]);
end;

function TListItem_Deleting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Deleting: Boolean read <getter>;

  Result := TListItem(AObj).Deleting;
end;

function TListItem_DropTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropTarget: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).DropTarget
  else
    TListItem(AObj).DropTarget := Boolean(AArgs[0]);
end;

function TListItem_Focused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Focused: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Focused
  else
    TListItem(AObj).Focused := Boolean(AArgs[0]);
end;

function TListItem_GroupID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupID: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).GroupID
  else
    TListItem(AObj).GroupID := Integer(AArgs[0]);
end;

function TListItem_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TListItem(AObj).Handle);
end;

function TListItem_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListItem(AObj).ImageIndex)
  else
    TListItem(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TListItem_Indent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Indent: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Indent
  else
    TListItem(AObj).Indent := Integer(AArgs[0]);
end;

function TListItem_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter>;

  Result := TListItem(AObj).Index;
end;

function TListItem_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Left
  else
    TListItem(AObj).Left := Integer(AArgs[0]);
end;

function TListItem_ListView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ListView: TCustomListView read <getter>;

  Result := TCustomListView_sw.ToVar(TListItem(AObj).ListView);
end;

function TListItem_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TListItems read <getter>;

  Result := TListItems_sw.ToVar(TListItem(AObj).Owner);
end;

function TListItem_OverlayIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OverlayIndex: TImageIndex read <getter> write <s...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListItem(AObj).OverlayIndex)
  else
    TListItem(AObj).OverlayIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TListItem_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TListItem(AObj).Position)
  else
    TListItem(AObj).Position := TPoint_sw.FromVar(AArgs[0]);
end;

function TListItem_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Selected
  else
    TListItem(AObj).Selected := Boolean(AArgs[0]);
end;

function TListItem_StateIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StateIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TListItem(AObj).StateIndex)
  else
    TListItem(AObj).StateIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TListItem_SubItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SubItems: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TListItem(AObj).SubItems)
  else
    TListItem(AObj).SubItems := TStrings_sw.FromVar(AArgs[0]);
end;

function TListItem_SubItemImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SubItemImages[Index: Integer]: Integer read <get...

  if IsGet then
    Result := TListItem(AObj).SubItemImages[Integer(AArgs[0])]
  else
    TListItem(AObj).SubItemImages[Integer(AArgs[0])] := Integer(AArgs[1]);
end;

function TListItem_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListItem(AObj).Top
  else
    TListItem(AObj).Top := Integer(AArgs[0]);
end;

class function TListItem_sw.GetTypeName: WideString;
begin
  Result := 'TListItem';
end;

class function TListItem_sw.GetWrappedClass: TClass;
begin
  Result := TListItem;
end;

class procedure TListItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CancelEdit', TListItem_CancelEdit_si, 0, False);
  AData.AddProcedure('Delete', TListItem_Delete_si, 0, False);
  AData.AddFunction('DisplayRect', TListItem_DisplayRect_si, TRect_sw, 1, False);
  AData.AddFunction('EditCaption', TListItem_EditCaption_si, Boolean_sw, 0, False);
  AData.AddFunction('GetPosition', TListItem_GetPosition_si, TPoint_sw, 0, False);
  AData.AddProcedure('MakeVisible', TListItem_MakeVisible_si, 1, False);
  AData.AddProcedure('Update', TListItem_Update_si, 0, False);
  AData.AddProcedure('SetPosition', TListItem_SetPosition_si, 1, False);
  AData.AddFunction('WorkArea', TListItem_WorkArea_si, Integer_sw, 0, False);
  AData.AddProperty('Caption', TListItem_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Checked', TListItem_Checked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Cut', TListItem_Cut_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Deleting', TListItem_Deleting_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('DropTarget', TListItem_DropTarget_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Focused', TListItem_Focused_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('GroupID', TListItem_GroupID_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TListItem_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('ImageIndex', TListItem_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Indent', TListItem_Indent_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Index', TListItem_Index_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Left', TListItem_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ListView', TListItem_ListView_si, TCustomListView_sw, True, False, 0, False, False);
  AData.AddProperty('Owner', TListItem_Owner_si, TListItems_sw, True, False, 0, False, False);
  AData.AddProperty('OverlayIndex', TListItem_OverlayIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TListItem_Position_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Selected', TListItem_Selected_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('StateIndex', TListItem_StateIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('SubItems', TListItem_SubItems_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('SubItemImages', TListItem_SubItemImages_si, Integer_sw, True, True, 1, False, False);
  AData.AddProperty('Top', TListItem_Top_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TListItem_Create_si, 1, False);
end;

class function TListItem_sw.ToVar(const AValue: TListItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListItem_sw.FromVar(const AValue: OleVariant): TListItem;
begin
  Result := TListItem(ConvFromVar(AValue, TListItem));
end;

class function TListItem_sw.ClassToVar(AClass: TListItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListItem_sw.ClassFromVar(
  const AClass: OleVariant): TListItem_sc;
begin
  Result := TListItem_sc(ConvClsFromVar(AClass, TListItem));
end;

{ TListItemsEnumerator_sw }

function TListItemsEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AListItems: TListItems);

  Result := TListItemsEnumerator_sw.ToVar(TListItemsEnumerator_sc(AObj).Create(
    TListItems_sw.FromVar(AArgs[0])));
end;

function TListItemsEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TListItem;

  Result := TListItem_sw.ToVar(TListItemsEnumerator(AObj).GetCurrent());
end;

function TListItemsEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TListItemsEnumerator(AObj).MoveNext();
end;

function TListItemsEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TListItem read <getter>;

  Result := TListItem_sw.ToVar(TListItemsEnumerator(AObj).Current);
end;

class function TListItemsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TListItemsEnumerator';
end;

class function TListItemsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TListItemsEnumerator;
end;

class procedure TListItemsEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TListItemsEnumerator_GetCurrent_si, TListItem_sw, 0, False);
  AData.AddFunction('MoveNext', TListItemsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TListItemsEnumerator_Current_si, TListItem_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TListItemsEnumerator_Create_si, 1, False);
end;

class function TListItemsEnumerator_sw.ToVar(
  const AValue: TListItemsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListItemsEnumerator_sw.FromVar(
  const AValue: OleVariant): TListItemsEnumerator;
begin
  Result := TListItemsEnumerator(ConvFromVar(AValue, TListItemsEnumerator));
end;

class function TListItemsEnumerator_sw.ClassToVar(
  AClass: TListItemsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListItemsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TListItemsEnumerator_sc;
begin
  Result := TListItemsEnumerator_sc(ConvClsFromVar(AClass, 
    TListItemsEnumerator));
end;

{ TListItems_sw }

function TListItems_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomListView);

  Result := TListItems_sw.ToVar(TListItems_sc(AObj).Create(TCustomListView_sw.
    FromVar(AArgs[0])));
end;

function TListItems_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TListItem;

  Result := TListItem_sw.ToVar(TListItems(AObj).Add());
end;

function TListItems_AddItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddItem(Item: TListItem; Index: Integer): TListI...

  case AArgsSize of
    1:
    begin
      Result := TListItem_sw.ToVar(TListItems(AObj).AddItem(TListItem_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TListItem_sw.ToVar(TListItems(AObj).AddItem(TListItem_sw.
        FromVar(AArgs[0]), Integer(AArgs[1])));
    end;
  else
    WrongArgCountError('AddItem');
  end;
end;

function TListItems_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TListItems(AObj).BeginUpdate();
end;

function TListItems_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TListItems(AObj).Clear();
end;

function TListItems_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TListItems(AObj).Delete(Integer(AArgs[0]));
end;

function TListItems_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TListItems(AObj).EndUpdate();
end;

function TListItems_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TListItemsEnumerator;

  Result := TListItemsEnumerator_sw.ToVar(TListItems(AObj).GetEnumerator());
end;

function TListItems_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(Value: TListItem): Integer;

  Result := TListItems(AObj).IndexOf(TListItem_sw.FromVar(AArgs[0]));
end;

function TListItems_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): TListItem;

  Result := TListItem_sw.ToVar(TListItems(AObj).Insert(Integer(AArgs[0])));
end;

function TListItems_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter> write <setter>;

  if IsGet then
    Result := TListItems(AObj).Count
  else
    TListItems(AObj).Count := Integer(AArgs[0]);
end;

function TListItems_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TListItems(AObj).Handle);
end;

function TListItems_Item_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Item[Index: Integer]: TListItem read <getter> wr...

  if IsGet then
    Result := TListItem_sw.ToVar(TListItems(AObj).Item[Integer(AArgs[0])])
  else
    TListItems(AObj).Item[Integer(AArgs[0])] := TListItem_sw.FromVar(AArgs[1]);
end;

function TListItems_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TCustomListView read <getter>;

  Result := TCustomListView_sw.ToVar(TListItems(AObj).Owner);
end;

class function TListItems_sw.GetTypeName: WideString;
begin
  Result := 'TListItems';
end;

class function TListItems_sw.GetWrappedClass: TClass;
begin
  Result := TListItems;
end;

class procedure TListItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TListItems_Add_si, TListItem_sw, 0, False);
  AData.AddFunction('AddItem', TListItems_AddItem_si, TListItem_sw, 1, True);
  AData.AddProcedure('BeginUpdate', TListItems_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TListItems_Clear_si, 0, False);
  AData.AddProcedure('Delete', TListItems_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TListItems_EndUpdate_si, 0, False);
  AData.AddFunction('GetEnumerator', TListItems_GetEnumerator_si, TListItemsEnumerator_sw, 0, False);
  AData.AddFunction('IndexOf', TListItems_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('Insert', TListItems_Insert_si, TListItem_sw, 1, False);
  AData.AddProperty('Count', TListItems_Count_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TListItems_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('Item', TListItems_Item_si, TListItem_sw, True, True, 1, False, True);
  AData.AddProperty('Owner', TListItems_Owner_si, TCustomListView_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TListItems_Create_si, 1, False);
end;

class function TListItems_sw.ToVar(const AValue: TListItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListItems_sw.FromVar(const AValue: OleVariant): TListItems;
begin
  Result := TListItems(ConvFromVar(AValue, TListItems));
end;

class function TListItems_sw.ClassToVar(AClass: TListItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListItems_sw.ClassFromVar(
  const AClass: OleVariant): TListItems_sc;
begin
  Result := TListItems_sc(ConvClsFromVar(AClass, TListItems));
end;

{ TWorkArea_sw }

function TWorkArea_Rect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Rect: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TWorkArea(AObj).Rect)
  else
    TWorkArea(AObj).Rect := TRect_sw.FromVar(AArgs[0]);
end;

function TWorkArea_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TWorkArea(AObj).Color)
  else
    TWorkArea(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

class function TWorkArea_sw.GetTypeName: WideString;
begin
  Result := 'TWorkArea';
end;

class function TWorkArea_sw.GetWrappedClass: TClass;
begin
  Result := TWorkArea;
end;

class procedure TWorkArea_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Rect', TWorkArea_Rect_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TWorkArea_Color_si, TColor_sw, True, True, 0, False, False);
end;

class function TWorkArea_sw.ToVar(const AValue: TWorkArea): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWorkArea_sw.FromVar(const AValue: OleVariant): TWorkArea;
begin
  Result := TWorkArea(ConvFromVar(AValue, TWorkArea));
end;

class function TWorkArea_sw.ClassToVar(AClass: TWorkArea_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWorkArea_sw.ClassFromVar(
  const AClass: OleVariant): TWorkArea_sc;
begin
  Result := TWorkArea_sc(ConvClsFromVar(AClass, TWorkArea));
end;

{ TWorkAreas_sw }

function TWorkAreas_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TWorkArea;

  Result := TWorkArea_sw.ToVar(TWorkAreas(AObj).Add());
end;

function TWorkAreas_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TWorkAreas(AObj).Delete(Integer(AArgs[0]));
end;

function TWorkAreas_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): TWorkArea;

  Result := TWorkArea_sw.ToVar(TWorkAreas(AObj).Insert(Integer(AArgs[0])));
end;

function TWorkAreas_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TWorkArea read <getter> w...

  if IsGet then
    Result := TWorkArea_sw.ToVar(TWorkAreas(AObj).Items[Integer(AArgs[0])])
  else
    TWorkAreas(AObj).Items[Integer(AArgs[0])] := TWorkArea_sw.FromVar(AArgs[1]);
end;

class function TWorkAreas_sw.GetTypeName: WideString;
begin
  Result := 'TWorkAreas';
end;

class function TWorkAreas_sw.GetWrappedClass: TClass;
begin
  Result := TWorkAreas;
end;

class procedure TWorkAreas_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TWorkAreas_Add_si, TWorkArea_sw, 0, False);
  AData.AddProcedure('Delete', TWorkAreas_Delete_si, 1, False);
  AData.AddFunction('Insert', TWorkAreas_Insert_si, TWorkArea_sw, 1, False);
  AData.AddProperty('Items', TWorkAreas_Items_si, TWorkArea_sw, True, True, 1, False, True);
end;

class function TWorkAreas_sw.ToVar(const AValue: TWorkAreas): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWorkAreas_sw.FromVar(const AValue: OleVariant): TWorkAreas;
begin
  Result := TWorkAreas(ConvFromVar(AValue, TWorkAreas));
end;

class function TWorkAreas_sw.ClassToVar(AClass: TWorkAreas_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWorkAreas_sw.ClassFromVar(
  const AClass: OleVariant): TWorkAreas_sc;
begin
  Result := TWorkAreas_sc(ConvClsFromVar(AClass, TWorkAreas));
end;

{ TIconArrangement_sw }

class function TIconArrangement_sw.GetTypeName: WideString;
begin
  Result := 'TIconArrangement';
end;

class procedure TIconArrangement_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'iaTop'; Value: Integer({$IFDEF LMDSCT_12}TIconArrangement.{$ENDIF}iaTop)),
    (Name: 'iaLeft'; Value: Integer({$IFDEF LMDSCT_12}TIconArrangement.{$ENDIF}iaLeft))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TIconArrangement_sw.ToVar(
  const AValue: TIconArrangement): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TIconArrangement_sw.FromVar(
  const AValue: OleVariant): TIconArrangement;
begin
  Result := TIconArrangement(Integer(AValue));
end;

{ TIconOptions_sw }

function TIconOptions_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCustomListView);

  Result := TIconOptions_sw.ToVar(TIconOptions_sc(AObj).Create(
    TCustomListView_sw.FromVar(AArgs[0])));
end;

function TIconOptions_Arrangement_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Arrangement: TIconArrangement read <getter> writ...

  if IsGet then
    Result := TIconArrangement_sw.ToVar(TIconOptions(AObj).Arrangement)
  else
    TIconOptions(AObj).Arrangement := TIconArrangement_sw.FromVar(AArgs[0]);
end;

function TIconOptions_AutoArrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoArrange: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TIconOptions(AObj).AutoArrange
  else
    TIconOptions(AObj).AutoArrange := Boolean(AArgs[0]);
end;

function TIconOptions_WrapText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WrapText: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TIconOptions(AObj).WrapText
  else
    TIconOptions(AObj).WrapText := Boolean(AArgs[0]);
end;

class function TIconOptions_sw.GetTypeName: WideString;
begin
  Result := 'TIconOptions';
end;

class function TIconOptions_sw.GetWrappedClass: TClass;
begin
  Result := TIconOptions;
end;

class procedure TIconOptions_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Arrangement', TIconOptions_Arrangement_si, TIconArrangement_sw, True, True, 0, False, False);
  AData.AddProperty('AutoArrange', TIconOptions_AutoArrange_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('WrapText', TIconOptions_WrapText_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TIconOptions_Create_si, 1, False);
end;

class function TIconOptions_sw.ToVar(const AValue: TIconOptions): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIconOptions_sw.FromVar(const AValue: OleVariant): TIconOptions;
begin
  Result := TIconOptions(ConvFromVar(AValue, TIconOptions));
end;

class function TIconOptions_sw.ClassToVar(AClass: TIconOptions_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIconOptions_sw.ClassFromVar(
  const AClass: OleVariant): TIconOptions_sc;
begin
  Result := TIconOptions_sc(ConvClsFromVar(AClass, TIconOptions));
end;

{ TListArrangement_sw }

class function TListArrangement_sw.GetTypeName: WideString;
begin
  Result := 'TListArrangement';
end;

class procedure TListArrangement_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'arAlignBottom'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arAlignBottom)),
    (Name: 'arAlignLeft'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arAlignLeft)),
    (Name: 'arAlignRight'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arAlignRight)),
    (Name: 'arAlignTop'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arAlignTop)),
    (Name: 'arDefault'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arDefault)),
    (Name: 'arSnapToGrid'; Value: Integer({$IFDEF LMDSCT_12}TListArrangement.{$ENDIF}arSnapToGrid))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TListArrangement_sw.ToVar(
  const AValue: TListArrangement): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListArrangement_sw.FromVar(
  const AValue: OleVariant): TListArrangement;
begin
  Result := TListArrangement(Integer(AValue));
end;

{ TViewStyle_sw }

class function TViewStyle_sw.GetTypeName: WideString;
begin
  Result := 'TViewStyle';
end;

class procedure TViewStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'vsIcon'; Value: Integer({$IFDEF LMDSCT_12}TViewStyle.{$ENDIF}vsIcon)),
    (Name: 'vsSmallIcon'; Value: Integer({$IFDEF LMDSCT_12}TViewStyle.{$ENDIF}vsSmallIcon)),
    (Name: 'vsList'; Value: Integer({$IFDEF LMDSCT_12}TViewStyle.{$ENDIF}vsList)),
    (Name: 'vsReport'; Value: Integer({$IFDEF LMDSCT_12}TViewStyle.{$ENDIF}vsReport))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TViewStyle_sw.ToVar(const AValue: TViewStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TViewStyle_sw.FromVar(const AValue: OleVariant): TViewStyle;
begin
  Result := TViewStyle(Integer(AValue));
end;

{ TItemState_sw }

class function TItemState_sw.GetTypeName: WideString;
begin
  Result := 'TItemState';
end;

class procedure TItemState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'isNone'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isNone)),
    (Name: 'isCut'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isCut)),
    (Name: 'isDropHilited'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isDropHilited)),
    (Name: 'isFocused'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isFocused)),
    (Name: 'isSelected'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isSelected)),
    (Name: 'isActivating'; Value: Integer({$IFDEF LMDSCT_12}TItemState.{$ENDIF}isActivating))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TItemState_sw.ToVar(const AValue: TItemState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TItemState_sw.FromVar(const AValue: OleVariant): TItemState;
begin
  Result := TItemState(Integer(AValue));
end;

{ TItemStates_sw }

class function TItemStates_sw.GetTypeName: WideString;
begin
  Result := 'TItemStates';
end;

class function TItemStates_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TItemStates);
end;

class function TItemStates_sw.ToVar(const AValue: TItemStates): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TItemStates_sw.FromVar(const AValue: OleVariant): TItemStates;
begin
  ConvFromVar(AValue, @Result);
end;

{ TItemChange_sw }

class function TItemChange_sw.GetTypeName: WideString;
begin
  Result := 'TItemChange';
end;

class procedure TItemChange_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ctText'; Value: Integer({$IFDEF LMDSCT_12}TItemChange.{$ENDIF}ctText)),
    (Name: 'ctImage'; Value: Integer({$IFDEF LMDSCT_12}TItemChange.{$ENDIF}ctImage)),
    (Name: 'ctState'; Value: Integer({$IFDEF LMDSCT_12}TItemChange.{$ENDIF}ctState))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TItemChange_sw.ToVar(const AValue: TItemChange): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TItemChange_sw.FromVar(const AValue: OleVariant): TItemChange;
begin
  Result := TItemChange(Integer(AValue));
end;

{ TItemFind_sw }

class function TItemFind_sw.GetTypeName: WideString;
begin
  Result := 'TItemFind';
end;

class procedure TItemFind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'ifData'; Value: Integer({$IFDEF LMDSCT_12}TItemFind.{$ENDIF}ifData)),
    (Name: 'ifPartialString'; Value: Integer({$IFDEF LMDSCT_12}TItemFind.{$ENDIF}ifPartialString)),
    (Name: 'ifExactString'; Value: Integer({$IFDEF LMDSCT_12}TItemFind.{$ENDIF}ifExactString)),
    (Name: 'ifNearest'; Value: Integer({$IFDEF LMDSCT_12}TItemFind.{$ENDIF}ifNearest))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TItemFind_sw.ToVar(const AValue: TItemFind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TItemFind_sw.FromVar(const AValue: OleVariant): TItemFind;
begin
  Result := TItemFind(Integer(AValue));
end;

{ TSearchDirection_sw }

class function TSearchDirection_sw.GetTypeName: WideString;
begin
  Result := 'TSearchDirection';
end;

class procedure TSearchDirection_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'sdLeft'; Value: Integer({$IFDEF LMDSCT_12}TSearchDirection.{$ENDIF}sdLeft)),
    (Name: 'sdRight'; Value: Integer({$IFDEF LMDSCT_12}TSearchDirection.{$ENDIF}sdRight)),
    (Name: 'sdAbove'; Value: Integer({$IFDEF LMDSCT_12}TSearchDirection.{$ENDIF}sdAbove)),
    (Name: 'sdBelow'; Value: Integer({$IFDEF LMDSCT_12}TSearchDirection.{$ENDIF}sdBelow)),
    (Name: 'sdAll'; Value: Integer({$IFDEF LMDSCT_12}TSearchDirection.{$ENDIF}sdAll))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TSearchDirection_sw.ToVar(
  const AValue: TSearchDirection): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSearchDirection_sw.FromVar(
  const AValue: OleVariant): TSearchDirection;
begin
  Result := TSearchDirection(Integer(AValue));
end;

{ TListHotTrackStyle_sw }

class function TListHotTrackStyle_sw.GetTypeName: WideString;
begin
  Result := 'TListHotTrackStyle';
end;

class procedure TListHotTrackStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'htHandPoint'; Value: Integer({$IFDEF LMDSCT_12}TListHotTrackStyle.{$ENDIF}htHandPoint)),
    (Name: 'htUnderlineCold'; Value: Integer({$IFDEF LMDSCT_12}TListHotTrackStyle.{$ENDIF}htUnderlineCold)),
    (Name: 'htUnderlineHot'; Value: Integer({$IFDEF LMDSCT_12}TListHotTrackStyle.{$ENDIF}htUnderlineHot))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TListHotTrackStyle_sw.ToVar(
  const AValue: TListHotTrackStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListHotTrackStyle_sw.FromVar(
  const AValue: OleVariant): TListHotTrackStyle;
begin
  Result := TListHotTrackStyle(Integer(AValue));
end;

{ TListHotTrackStyles_sw }

class function TListHotTrackStyles_sw.GetTypeName: WideString;
begin
  Result := 'TListHotTrackStyles';
end;

class function TListHotTrackStyles_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TListHotTrackStyles);
end;

class function TListHotTrackStyles_sw.ToVar(
  const AValue: TListHotTrackStyles): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TListHotTrackStyles_sw.FromVar(
  const AValue: OleVariant): TListHotTrackStyles;
begin
  ConvFromVar(AValue, @Result);
end;

{ TItemRequests_sw }

class function TItemRequests_sw.GetTypeName: WideString;
begin
  Result := 'TItemRequests';
end;

class procedure TItemRequests_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'irText'; Value: Integer({$IFDEF LMDSCT_12}TItemRequests.{$ENDIF}irText)),
    (Name: 'irImage'; Value: Integer({$IFDEF LMDSCT_12}TItemRequests.{$ENDIF}irImage)),
    (Name: 'irParam'; Value: Integer({$IFDEF LMDSCT_12}TItemRequests.{$ENDIF}irParam)),
    (Name: 'irState'; Value: Integer({$IFDEF LMDSCT_12}TItemRequests.{$ENDIF}irState)),
    (Name: 'irIndent'; Value: Integer({$IFDEF LMDSCT_12}TItemRequests.{$ENDIF}irIndent))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TItemRequests_sw.ToVar(const AValue: TItemRequests): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TItemRequests_sw.FromVar(
  const AValue: OleVariant): TItemRequests;
begin
  Result := TItemRequests(Integer(AValue));
end;

{ TItemRequest_sw }

class function TItemRequest_sw.GetTypeName: WideString;
begin
  Result := 'TItemRequest';
end;

class function TItemRequest_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TItemRequest);
end;

class function TItemRequest_sw.ToVar(const AValue: TItemRequest): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TItemRequest_sw.FromVar(const AValue: OleVariant): TItemRequest;
begin
  ConvFromVar(AValue, @Result);
end;

{ TLVDeletedEvent_sh }

function TLVDeletedEvent_sh.GetHandler: TMethod;
var
  hdr: TLVDeletedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVDeletedEvent_sh.Handler(Sender: TObject; Item: TListItem);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVDeletedEvent_sw }

class function TLVDeletedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVDeletedEvent';
end;

class function TLVDeletedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVDeletedEvent_sh;
end;

class function TLVDeletedEvent_sw.ToVar(
  const AValue: TLVDeletedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVDeletedEvent_sw.FromVar(
  const AValue: OleVariant): TLVDeletedEvent;
begin
  Result := TLVDeletedEvent(ConvFromVar(AValue));
end;

class function TLVDeletedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVDeletedEvent;
var
  hdlr: TLVDeletedEvent_sh;
begin
  hdlr   := TLVDeletedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVDeletedEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVEditingEvent_sh }

function TLVEditingEvent_sh.GetHandler: TMethod;
var
  hdr: TLVEditingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVEditingEvent_sh.Handler(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; var AllowEdi...

  v_1 := AllowEdit;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowEdit := Boolean(v_1);
end;

{ TLVEditingEvent_sw }

class function TLVEditingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVEditingEvent';
end;

class function TLVEditingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVEditingEvent_sh;
end;

class function TLVEditingEvent_sw.ToVar(
  const AValue: TLVEditingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVEditingEvent_sw.FromVar(
  const AValue: OleVariant): TLVEditingEvent;
begin
  Result := TLVEditingEvent(ConvFromVar(AValue));
end;

class function TLVEditingEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVEditingEvent;
var
  hdlr: TLVEditingEvent_sh;
begin
  hdlr   := TLVEditingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVEditingEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVEditedEvent_sh }

function TLVEditedEvent_sh.GetHandler: TMethod;
var
  hdr: TLVEditedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVEditedEvent_sh.Handler(Sender: TObject; Item: TListItem;
  var S: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; var S: strin...

  v_1 := S;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  S := string(v_1);
end;

{ TLVEditedEvent_sw }

class function TLVEditedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVEditedEvent';
end;

class function TLVEditedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVEditedEvent_sh;
end;

class function TLVEditedEvent_sw.ToVar(
  const AValue: TLVEditedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVEditedEvent_sw.FromVar(
  const AValue: OleVariant): TLVEditedEvent;
begin
  Result := TLVEditedEvent(ConvFromVar(AValue));
end;

class function TLVEditedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVEditedEvent;
var
  hdlr: TLVEditedEvent_sh;
begin
  hdlr   := TLVEditedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVEditedEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVChangeEvent_sh }

function TLVChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TLVChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVChangeEvent_sh.Handler(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; Change: TIte...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := TItemChange_sw.ToVar(Change);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVChangeEvent_sw }

class function TLVChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVChangeEvent';
end;

class function TLVChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVChangeEvent_sh;
end;

class function TLVChangeEvent_sw.ToVar(
  const AValue: TLVChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVChangeEvent_sw.FromVar(
  const AValue: OleVariant): TLVChangeEvent;
begin
  Result := TLVChangeEvent(ConvFromVar(AValue));
end;

class function TLVChangeEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVChangeEvent;
var
  hdlr: TLVChangeEvent_sh;
begin
  hdlr   := TLVChangeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVChangingEvent_sh }

function TLVChangingEvent_sh.GetHandler: TMethod;
var
  hdr: TLVChangingEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVChangingEvent_sh.Handler(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; Change: TIte...

  v_1 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := TItemChange_sw.ToVar(Change);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  AllowChange := Boolean(v_1);
end;

{ TLVChangingEvent_sw }

class function TLVChangingEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVChangingEvent';
end;

class function TLVChangingEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVChangingEvent_sh;
end;

class function TLVChangingEvent_sw.ToVar(
  const AValue: TLVChangingEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVChangingEvent_sw.FromVar(
  const AValue: OleVariant): TLVChangingEvent;
begin
  Result := TLVChangingEvent(ConvFromVar(AValue));
end;

class function TLVChangingEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVChangingEvent;
var
  hdlr: TLVChangingEvent_sh;
begin
  hdlr   := TLVChangingEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVChangingEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVColumnClickEvent_sh }

function TLVColumnClickEvent_sh.GetHandler: TMethod;
var
  hdr: TLVColumnClickEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVColumnClickEvent_sh.Handler(Sender: TObject; Column: TListColumn);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Column: TListColumn) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListColumn_sw.ToVar(Column);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVColumnClickEvent_sw }

class function TLVColumnClickEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVColumnClickEvent';
end;

class function TLVColumnClickEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVColumnClickEvent_sh;
end;

class function TLVColumnClickEvent_sw.ToVar(
  const AValue: TLVColumnClickEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVColumnClickEvent_sw.FromVar(
  const AValue: OleVariant): TLVColumnClickEvent;
begin
  Result := TLVColumnClickEvent(ConvFromVar(AValue));
end;

class function TLVColumnClickEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVColumnClickEvent;
var
  hdlr: TLVColumnClickEvent_sh;
begin
  hdlr   := TLVColumnClickEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVColumnClickEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVColumnRClickEvent_sh }

function TLVColumnRClickEvent_sh.GetHandler: TMethod;
var
  hdr: TLVColumnRClickEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVColumnRClickEvent_sh.Handler(Sender: TObject; Column: TListColumn;
  Point: TPoint);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; Column: TListColumn; Point: T...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListColumn_sw.ToVar(Column);
  args[2] := TPoint_sw.ToVar(Point);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVColumnRClickEvent_sw }

class function TLVColumnRClickEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVColumnRClickEvent';
end;

class function TLVColumnRClickEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVColumnRClickEvent_sh;
end;

class function TLVColumnRClickEvent_sw.ToVar(
  const AValue: TLVColumnRClickEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVColumnRClickEvent_sw.FromVar(
  const AValue: OleVariant): TLVColumnRClickEvent;
begin
  Result := TLVColumnRClickEvent(ConvFromVar(AValue));
end;

class function TLVColumnRClickEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVColumnRClickEvent;
var
  hdlr: TLVColumnRClickEvent_sh;
begin
  hdlr   := TLVColumnRClickEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVColumnRClickEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVCompareEvent_sh }

function TLVCompareEvent_sh.GetHandler: TMethod;
var
  hdr: TLVCompareEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVCompareEvent_sh.Handler(Sender: TObject; Item1: TListItem;
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item1: TListItem; Item2: TLis...

  v_1 := Compare;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item1);
  args[2] := TListItem_sw.ToVar(Item2);
  args[3] := Data;
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Compare := Integer(v_1);
end;

{ TLVCompareEvent_sw }

class function TLVCompareEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVCompareEvent';
end;

class function TLVCompareEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVCompareEvent_sh;
end;

class function TLVCompareEvent_sw.ToVar(
  const AValue: TLVCompareEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVCompareEvent_sw.FromVar(
  const AValue: OleVariant): TLVCompareEvent;
begin
  Result := TLVCompareEvent(ConvFromVar(AValue));
end;

class function TLVCompareEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVCompareEvent;
var
  hdlr: TLVCompareEvent_sh;
begin
  hdlr   := TLVCompareEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVCompareEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVNotifyEvent_sh }

function TLVNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TLVNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVNotifyEvent_sh.Handler(Sender: TObject; Item: TListItem);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVNotifyEvent_sw }

class function TLVNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVNotifyEvent';
end;

class function TLVNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVNotifyEvent_sh;
end;

class function TLVNotifyEvent_sw.ToVar(
  const AValue: TLVNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVNotifyEvent_sw.FromVar(
  const AValue: OleVariant): TLVNotifyEvent;
begin
  Result := TLVNotifyEvent(ConvFromVar(AValue));
end;

class function TLVNotifyEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVNotifyEvent;
var
  hdlr: TLVNotifyEvent_sh;
begin
  hdlr   := TLVNotifyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVSelectItemEvent_sh }

function TLVSelectItemEvent_sh.GetHandler: TMethod;
var
  hdr: TLVSelectItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVSelectItemEvent_sh.Handler(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; Selected: Bo...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := Selected;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVSelectItemEvent_sw }

class function TLVSelectItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVSelectItemEvent';
end;

class function TLVSelectItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVSelectItemEvent_sh;
end;

class function TLVSelectItemEvent_sw.ToVar(
  const AValue: TLVSelectItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVSelectItemEvent_sw.FromVar(
  const AValue: OleVariant): TLVSelectItemEvent;
begin
  Result := TLVSelectItemEvent(ConvFromVar(AValue));
end;

class function TLVSelectItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TLVSelectItemEvent;
var
  hdlr: TLVSelectItemEvent_sh;
begin
  hdlr   := TLVSelectItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVSelectItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVCheckedItemEvent_sh }

function TLVCheckedItemEvent_sh.GetHandler: TMethod;
var
  hdr: TLVCheckedItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVCheckedItemEvent_sh.Handler(Sender: TObject; Item: TListItem);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVCheckedItemEvent_sw }

class function TLVCheckedItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVCheckedItemEvent';
end;

class function TLVCheckedItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVCheckedItemEvent_sh;
end;

class function TLVCheckedItemEvent_sw.ToVar(
  const AValue: TLVCheckedItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVCheckedItemEvent_sw.FromVar(
  const AValue: OleVariant): TLVCheckedItemEvent;
begin
  Result := TLVCheckedItemEvent(ConvFromVar(AValue));
end;

class function TLVCheckedItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVCheckedItemEvent;
var
  hdlr: TLVCheckedItemEvent_sh;
begin
  hdlr   := TLVCheckedItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVCheckedItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVCustomDrawEvent_sh }

function TLVCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TLVCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVCustomDrawEvent_sh.Handler(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomListView; const ARect: TRect; v...

  v_1 := DefaultDraw;
  args[0] := TCustomListView_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TLVCustomDrawEvent_sw }

class function TLVCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVCustomDrawEvent';
end;

class function TLVCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVCustomDrawEvent_sh;
end;

class function TLVCustomDrawEvent_sw.ToVar(
  const AValue: TLVCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TLVCustomDrawEvent;
begin
  Result := TLVCustomDrawEvent(ConvFromVar(AValue));
end;

class function TLVCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TLVCustomDrawEvent;
var
  hdlr: TLVCustomDrawEvent_sh;
begin
  hdlr   := TLVCustomDrawEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVAdvancedCustomDrawEvent_sh }

function TLVAdvancedCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TLVAdvancedCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVAdvancedCustomDrawEvent_sh.Handler(Sender: TCustomListView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomListView; const ARect: TRect; S...

  v_1 := DefaultDraw;
  args[0] := TCustomListView_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := TCustomDrawStage_sw.ToVar(Stage);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TLVAdvancedCustomDrawEvent_sw }

class function TLVAdvancedCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVAdvancedCustomDrawEvent';
end;

class function TLVAdvancedCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVAdvancedCustomDrawEvent_sh;
end;

class function TLVAdvancedCustomDrawEvent_sw.ToVar(
  const AValue: TLVAdvancedCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVAdvancedCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TLVAdvancedCustomDrawEvent;
begin
  Result := TLVAdvancedCustomDrawEvent(ConvFromVar(AValue));
end;

class function TLVAdvancedCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVAdvancedCustomDrawEvent;
var
  hdlr: TLVAdvancedCustomDrawEvent_sh;
begin
  hdlr   := TLVAdvancedCustomDrawEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TLVAdvancedCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVOwnerDataEvent_sh }

function TLVOwnerDataEvent_sh.GetHandler: TMethod;
var
  hdr: TLVOwnerDataEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVOwnerDataEvent_sh.Handler(Sender: TObject; Item: TListItem);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVOwnerDataEvent_sw }

class function TLVOwnerDataEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVOwnerDataEvent';
end;

class function TLVOwnerDataEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVOwnerDataEvent_sh;
end;

class function TLVOwnerDataEvent_sw.ToVar(
  const AValue: TLVOwnerDataEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVOwnerDataEvent_sw.FromVar(
  const AValue: OleVariant): TLVOwnerDataEvent;
begin
  Result := TLVOwnerDataEvent(ConvFromVar(AValue));
end;

class function TLVOwnerDataEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TLVOwnerDataEvent;
var
  hdlr: TLVOwnerDataEvent_sh;
begin
  hdlr   := TLVOwnerDataEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVOwnerDataEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVOwnerDataHintEvent_sh }

function TLVOwnerDataHintEvent_sh.GetHandler: TMethod;
var
  hdr: TLVOwnerDataHintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVOwnerDataHintEvent_sh.Handler(Sender: TObject; StartIndex: Integer;
  EndIndex: Integer);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; StartIndex: Integer; EndIndex...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := StartIndex;
  args[2] := EndIndex;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVOwnerDataHintEvent_sw }

class function TLVOwnerDataHintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVOwnerDataHintEvent';
end;

class function TLVOwnerDataHintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVOwnerDataHintEvent_sh;
end;

class function TLVOwnerDataHintEvent_sw.ToVar(
  const AValue: TLVOwnerDataHintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVOwnerDataHintEvent_sw.FromVar(
  const AValue: OleVariant): TLVOwnerDataHintEvent;
begin
  Result := TLVOwnerDataHintEvent(ConvFromVar(AValue));
end;

class function TLVOwnerDataHintEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVOwnerDataHintEvent;
var
  hdlr: TLVOwnerDataHintEvent_sh;
begin
  hdlr   := TLVOwnerDataHintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVOwnerDataHintEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVOwnerDataStateChangeEvent_sh }

function TLVOwnerDataStateChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TLVOwnerDataStateChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVOwnerDataStateChangeEvent_sh.Handler(Sender: TObject;
  StartIndex: Integer; EndIndex: Integer; OldState: TItemStates;
  NewState: TItemStates);
var
  args: array[0..4] of OleVariant;
begin
  // procedure (Sender: TObject; StartIndex: Integer; EndIndex...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := StartIndex;
  args[2] := EndIndex;
  args[3] := TItemStates_sw.ToVar(OldState);
  args[4] := TItemStates_sw.ToVar(NewState);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLVOwnerDataStateChangeEvent_sw }

class function TLVOwnerDataStateChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVOwnerDataStateChangeEvent';
end;

class function TLVOwnerDataStateChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVOwnerDataStateChangeEvent_sh;
end;

class function TLVOwnerDataStateChangeEvent_sw.ToVar(
  const AValue: TLVOwnerDataStateChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVOwnerDataStateChangeEvent_sw.FromVar(
  const AValue: OleVariant): TLVOwnerDataStateChangeEvent;
begin
  Result := TLVOwnerDataStateChangeEvent(ConvFromVar(AValue));
end;

class function TLVOwnerDataStateChangeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVOwnerDataStateChangeEvent;
var
  hdlr: TLVOwnerDataStateChangeEvent_sh;
begin
  hdlr   := TLVOwnerDataStateChangeEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TLVOwnerDataStateChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVSubItemImageEvent_sh }

function TLVSubItemImageEvent_sh.GetHandler: TMethod;
var
  hdr: TLVSubItemImageEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVSubItemImageEvent_sh.Handler(Sender: TObject; Item: TListItem;
  SubItem: Integer; var ImageIndex: Integer);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; SubItem: Int...

  v_1 := ImageIndex;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := SubItem;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ImageIndex := Integer(v_1);
end;

{ TLVSubItemImageEvent_sw }

class function TLVSubItemImageEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVSubItemImageEvent';
end;

class function TLVSubItemImageEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVSubItemImageEvent_sh;
end;

class function TLVSubItemImageEvent_sw.ToVar(
  const AValue: TLVSubItemImageEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVSubItemImageEvent_sw.FromVar(
  const AValue: OleVariant): TLVSubItemImageEvent;
begin
  Result := TLVSubItemImageEvent(ConvFromVar(AValue));
end;

class function TLVSubItemImageEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVSubItemImageEvent;
var
  hdlr: TLVSubItemImageEvent_sh;
begin
  hdlr   := TLVSubItemImageEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVSubItemImageEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVInfoTipEvent_sh }

function TLVInfoTipEvent_sh.GetHandler: TMethod;
var
  hdr: TLVInfoTipEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVInfoTipEvent_sh.Handler(Sender: TObject; Item: TListItem;
  var InfoTip: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Item: TListItem; var InfoTip:...

  v_1 := InfoTip;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TListItem_sw.ToVar(Item);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  InfoTip := string(v_1);
end;

{ TLVInfoTipEvent_sw }

class function TLVInfoTipEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVInfoTipEvent';
end;

class function TLVInfoTipEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVInfoTipEvent_sh;
end;

class function TLVInfoTipEvent_sw.ToVar(
  const AValue: TLVInfoTipEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVInfoTipEvent_sw.FromVar(
  const AValue: OleVariant): TLVInfoTipEvent;
begin
  Result := TLVInfoTipEvent(ConvFromVar(AValue));
end;

class function TLVInfoTipEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVInfoTipEvent;
var
  hdlr: TLVInfoTipEvent_sh;
begin
  hdlr   := TLVInfoTipEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLVInfoTipEvent_sw));
  Result := hdlr.Handler;
end;

{ TLVCreateItemClassEvent_sh }

function TLVCreateItemClassEvent_sh.GetHandler: TMethod;
var
  hdr: TLVCreateItemClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLVCreateItemClassEvent_sh.Handler(Sender: TCustomListView;
  var ItemClass: TListItemClass);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TCustomListView; var ItemClass: TListI...

  v_1 := TListItemClass_sw.ToVar(ItemClass);
  args[0] := TCustomListView_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ItemClass := TListItemClass_sw.FromVar(v_1);
end;

{ TLVCreateItemClassEvent_sw }

class function TLVCreateItemClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLVCreateItemClassEvent';
end;

class function TLVCreateItemClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLVCreateItemClassEvent_sh;
end;

class function TLVCreateItemClassEvent_sw.ToVar(
  const AValue: TLVCreateItemClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLVCreateItemClassEvent_sw.FromVar(
  const AValue: OleVariant): TLVCreateItemClassEvent;
begin
  Result := TLVCreateItemClassEvent(ConvFromVar(AValue));
end;

class function TLVCreateItemClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TLVCreateItemClassEvent;
var
  hdlr: TLVCreateItemClassEvent_sh;
begin
  hdlr   := TLVCreateItemClassEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TLVCreateItemClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomListView_sw }

function TCustomListView_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      BorderStyle)
  else
    TCustomListView_sacc(TCustomListView(AObj)).BorderStyle := TBorderStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_Groups_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Groups: TListGroups read <getter> writ...

  if IsGet then
    Result := TListGroups_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      Groups)
  else
    TCustomListView_sacc(TCustomListView(AObj)).Groups := TListGroups_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_Columns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Columns: TListColumns read <getter> wr...

  if IsGet then
    Result := TListColumns_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      Columns)
  else
    TCustomListView_sacc(TCustomListView(AObj)).Columns := TListColumns_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_ColumnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ColumnClick: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).ColumnClick
  else
    TCustomListView_sacc(TCustomListView(AObj)).ColumnClick := Boolean(
      AArgs[0]);
end;

function TCustomListView_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).ReadOnly
  else
    TCustomListView_sacc(TCustomListView(AObj)).ReadOnly := Boolean(AArgs[0]);
end;

function TCustomListView_HideSelection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HideSelection: Boolean read <getter> w...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).HideSelection
  else
    TCustomListView_sacc(TCustomListView(AObj)).HideSelection := Boolean(
      AArgs[0]);
end;

function TCustomListView_IconOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IconOptions: TIconOptions read <getter...

  if IsGet then
    Result := TIconOptions_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      IconOptions)
  else
    TCustomListView_sacc(TCustomListView(AObj)).IconOptions := TIconOptions_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_AllocBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AllocBy: Integer read <getter> write <...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).AllocBy
  else
    TCustomListView_sacc(TCustomListView(AObj)).AllocBy := Integer(AArgs[0]);
end;

function TCustomListView_GroupView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GroupView: Boolean read <getter> write...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).GroupView
  else
    TCustomListView_sacc(TCustomListView(AObj)).GroupView := Boolean(AArgs[0]);
end;

function TCustomListView_HoverTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HoverTime: Integer read <getter> write...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).HoverTime
  else
    TCustomListView_sacc(TCustomListView(AObj)).HoverTime := Integer(AArgs[0]);
end;

function TCustomListView_LargeImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property LargeImages: TCustomImageList read <ge...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).LargeImages)
  else
    TCustomListView_sacc(TCustomListView(AObj)).LargeImages := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomListView_GroupHeaderImages_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GroupHeaderImages: TCustomImageList re...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).GroupHeaderImages)
  else
    TCustomListView_sacc(TCustomListView(AObj)).GroupHeaderImages := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomListView_MultiSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiSelect: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).MultiSelect
  else
    TCustomListView_sacc(TCustomListView(AObj)).MultiSelect := Boolean(
      AArgs[0]);
end;

function TCustomListView_OwnerData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OwnerData: Boolean read <getter> write...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).OwnerData
  else
    TCustomListView_sacc(TCustomListView(AObj)).OwnerData := Boolean(AArgs[0]);
end;

function TCustomListView_OwnerDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OwnerDraw: Boolean read <getter> write...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).OwnerDraw
  else
    TCustomListView_sacc(TCustomListView(AObj)).OwnerDraw := Boolean(AArgs[0]);
end;

function TCustomListView_OnAdvancedCustomDraw_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAdvancedCustomDraw: TLVAdvancedCusto...

  if IsGet then
    Result := TLVAdvancedCustomDrawEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnAdvancedCustomDraw)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnAdvancedCustomDraw := 
      TLVAdvancedCustomDrawEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TLVChangeEvent read <getter>...

  if IsGet then
    Result := TLVChangeEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnChange)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnChange := TLVChangeEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChanging: TLVChangingEvent read <get...

  if IsGet then
    Result := TLVChangingEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnChanging)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnChanging := 
      TLVChangingEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnColumnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColumnClick: TLVColumnClickEvent rea...

  if IsGet then
    Result := TLVColumnClickEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnColumnClick)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnColumnClick := 
      TLVColumnClickEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnColumnDragged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColumnDragged: TNotifyEvent read <ge...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      OnColumnDragged)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnColumnDragged := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnColumnRightClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColumnRightClick: TLVColumnRClickEve...

  if IsGet then
    Result := TLVColumnRClickEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnColumnRightClick)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnColumnRightClick := 
      TLVColumnRClickEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnCompare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCompare: TLVCompareEvent read <gette...

  if IsGet then
    Result := TLVCompareEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnCompare)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnCompare := TLVCompareEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnCreateItemClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCreateItemClass: TLVCreateItemClassE...

  if IsGet then
    Result := TLVCreateItemClassEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnCreateItemClass)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnCreateItemClass := 
      TLVCreateItemClassEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnCustomDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCustomDraw: TLVCustomDrawEvent read ...

  if IsGet then
    Result := TLVCustomDrawEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnCustomDraw)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnCustomDraw := 
      TLVCustomDrawEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnData: TLVOwnerDataEvent read <getter...

  if IsGet then
    Result := TLVOwnerDataEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnData)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnData := TLVOwnerDataEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnDataHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDataHint: TLVOwnerDataHintEvent read...

  if IsGet then
    Result := TLVOwnerDataHintEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnDataHint)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnDataHint := 
      TLVOwnerDataHintEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnDataStateChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDataStateChange: TLVOwnerDataStateCh...

  if IsGet then
    Result := TLVOwnerDataStateChangeEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnDataStateChange)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnDataStateChange := 
      TLVOwnerDataStateChangeEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnDeletion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDeletion: TLVDeletedEvent read <gett...

  if IsGet then
    Result := TLVDeletedEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnDeletion)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnDeletion := 
      TLVDeletedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnEdited_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEdited: TLVEditedEvent read <getter>...

  if IsGet then
    Result := TLVEditedEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnEdited)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnEdited := TLVEditedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnEditing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEditing: TLVEditingEvent read <gette...

  if IsGet then
    Result := TLVEditingEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnEditing)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnEditing := TLVEditingEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnInfoTip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnInfoTip: TLVInfoTipEvent read <gette...

  if IsGet then
    Result := TLVInfoTipEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnInfoTip)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnInfoTip := TLVInfoTipEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnInsert: TLVDeletedEvent read <getter...

  if IsGet then
    Result := TLVDeletedEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnInsert)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnInsert := TLVDeletedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_OnGetImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetImageIndex: TLVNotifyEvent read <...

  if IsGet then
    Result := TLVNotifyEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnGetImageIndex)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnGetImageIndex := 
      TLVNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnGetSubItemImage_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetSubItemImage: TLVSubItemImageEven...

  if IsGet then
    Result := TLVSubItemImageEvent_sw.ToVar(TCustomListView_sacc(
      TCustomListView(AObj)).OnGetSubItemImage)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnGetSubItemImage := 
      TLVSubItemImageEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnSelectItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSelectItem: TLVSelectItemEvent read ...

  if IsGet then
    Result := TLVSelectItemEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnSelectItem)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnSelectItem := 
      TLVSelectItemEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_OnItemChecked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnItemChecked: TLVCheckedItemEvent rea...

  if IsGet then
    Result := TLVCheckedItemEvent_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).OnItemChecked)
  else
    TCustomListView_sacc(TCustomListView(AObj)).OnItemChecked := 
      TLVCheckedItemEvent_sw.FromVar(AArgs[0]);
end;

function TCustomListView_Reading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Reading: Boolean read <getter>;

  Result := TCustomListView_sacc(TCustomListView(AObj)).Reading;
end;

function TCustomListView_ShowColumnHeaders_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowColumnHeaders: Boolean read <gette...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).ShowColumnHeaders
  else
    TCustomListView_sacc(TCustomListView(AObj)).ShowColumnHeaders := Boolean(
      AArgs[0]);
end;

function TCustomListView_ShowWorkAreas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowWorkAreas: Boolean read <getter> w...

  if IsGet then
    Result := TCustomListView_sacc(TCustomListView(AObj)).ShowWorkAreas
  else
    TCustomListView_sacc(TCustomListView(AObj)).ShowWorkAreas := Boolean(
      AArgs[0]);
end;

function TCustomListView_SmallImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SmallImages: TCustomImageList read <ge...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).SmallImages)
  else
    TCustomListView_sacc(TCustomListView(AObj)).SmallImages := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomListView_SortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SortType: TSortType read <getter> writ...

  if IsGet then
    Result := TSortType_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      SortType)
  else
    TCustomListView_sacc(TCustomListView(AObj)).SortType := TSortType_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_StateImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property StateImages: TCustomImageList read <ge...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomListView_sacc(TCustomListView(
      AObj)).StateImages)
  else
    TCustomListView_sacc(TCustomListView(AObj)).StateImages := 
      TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomListView_ViewStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ViewStyle: TViewStyle read <getter> wr...

  if IsGet then
    Result := TViewStyle_sw.ToVar(TCustomListView_sacc(TCustomListView(AObj)).
      ViewStyle)
  else
    TCustomListView_sacc(TCustomListView(AObj)).ViewStyle := TViewStyle_sw.
      FromVar(AArgs[0]);
end;

function TCustomListView_AlphaSort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AlphaSort: Boolean;

  Result := TCustomListView(AObj).AlphaSort();
end;

function TCustomListView_Arrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Arrange(Code: TListArrangement);

  TCustomListView(AObj).Arrange(TListArrangement_sw.FromVar(AArgs[0]));
end;

function TCustomListView_FindCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindCaption(StartIndex: Integer; Value: string; ...

  Result := TListItem_sw.ToVar(TCustomListView(AObj).FindCaption(Integer(
    AArgs[0]), string(AArgs[1]), Boolean(AArgs[2]), Boolean(AArgs[3]), Boolean(
    AArgs[4])));
end;

function TCustomListView_GetHitTestInfoAt_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHitTestInfoAt(X: Integer; Y: Integer): THitTe...

  Result := THitTests_sw.ToVar(TCustomListView(AObj).GetHitTestInfoAt(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function TCustomListView_GetItemAt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetItemAt(X: Integer; Y: Integer): TListItem;

  Result := TListItem_sw.ToVar(TCustomListView(AObj).GetItemAt(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function TCustomListView_GetNearestItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNearestItem(Point: TPoint; Direction: TSearch...

  Result := TListItem_sw.ToVar(TCustomListView(AObj).GetNearestItem(TPoint_sw.
    FromVar(AArgs[0]), TSearchDirection_sw.FromVar(AArgs[1])));
end;

function TCustomListView_GetNextItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNextItem(StartItem: TListItem; Direction: TSe...

  Result := TListItem_sw.ToVar(TCustomListView(AObj).GetNextItem(TListItem_sw.
    FromVar(AArgs[0]), TSearchDirection_sw.FromVar(AArgs[1]), TItemStates_sw.
    FromVar(AArgs[2])));
end;

function TCustomListView_GetSearchString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetSearchString: string;

  Result := TCustomListView(AObj).GetSearchString();
end;

function TCustomListView_IsEditing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEditing: Boolean;

  Result := TCustomListView(AObj).IsEditing();
end;

function TCustomListView_Scroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Scroll(DX: Integer; DY: Integer);

  TCustomListView(AObj).Scroll(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomListView_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomListView(AObj).Canvas);
end;

function TCustomListView_Checkboxes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checkboxes: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListView(AObj).Checkboxes
  else
    TCustomListView(AObj).Checkboxes := Boolean(AArgs[0]);
end;

function TCustomListView_Column_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Column[Index: Integer]: TListColumn read <getter>;

  Result := TListColumn_sw.ToVar(TCustomListView(AObj).Column[Integer(
    AArgs[0])]);
end;

function TCustomListView_DropTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropTarget: TListItem read <getter> write <setter>;

  if IsGet then
    Result := TListItem_sw.ToVar(TCustomListView(AObj).DropTarget)
  else
    TCustomListView(AObj).DropTarget := TListItem_sw.FromVar(AArgs[0]);
end;

function TCustomListView_FlatScrollBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FlatScrollBars: Boolean read <getter> write <set...

  if IsGet then
    Result := TCustomListView(AObj).FlatScrollBars
  else
    TCustomListView(AObj).FlatScrollBars := Boolean(AArgs[0]);
end;

function TCustomListView_FullDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FullDrag: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListView(AObj).FullDrag
  else
    TCustomListView(AObj).FullDrag := Boolean(AArgs[0]);
end;

function TCustomListView_GridLines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GridLines: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListView(AObj).GridLines
  else
    TCustomListView(AObj).GridLines := Boolean(AArgs[0]);
end;

function TCustomListView_HotTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HotTrack: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListView(AObj).HotTrack
  else
    TCustomListView(AObj).HotTrack := Boolean(AArgs[0]);
end;

function TCustomListView_HotTrackStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HotTrackStyles: TListHotTrackStyles read <getter...

  if IsGet then
    Result := TListHotTrackStyles_sw.ToVar(TCustomListView(AObj).HotTrackStyles)
  else
    TCustomListView(AObj).HotTrackStyles := TListHotTrackStyles_sw.FromVar(
      AArgs[0]);
end;

function TCustomListView_ItemFocused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemFocused: TListItem read <getter> write <sett...

  if IsGet then
    Result := TListItem_sw.ToVar(TCustomListView(AObj).ItemFocused)
  else
    TCustomListView(AObj).ItemFocused := TListItem_sw.FromVar(AArgs[0]);
end;

function TCustomListView_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items: TListItems read <getter> write <setter>;

  if IsGet then
    Result := TListItems_sw.ToVar(TCustomListView(AObj).Items)
  else
    TCustomListView(AObj).Items := TListItems_sw.FromVar(AArgs[0]);
end;

function TCustomListView_RowSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowSelect: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomListView(AObj).RowSelect
  else
    TCustomListView(AObj).RowSelect := Boolean(AArgs[0]);
end;

function TCustomListView_SelCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelCount: Integer read <getter>;

  Result := TCustomListView(AObj).SelCount;
end;

function TCustomListView_Selected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Selected: TListItem read <getter> write <setter>;

  if IsGet then
    Result := TListItem_sw.ToVar(TCustomListView(AObj).Selected)
  else
    TCustomListView(AObj).Selected := TListItem_sw.FromVar(AArgs[0]);
end;

function TCustomListView_StringWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StringWidth(S: string): Integer;

  Result := TCustomListView(AObj).StringWidth(string(AArgs[0]));
end;

function TCustomListView_UpdateItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateItems(FirstIndex: Integer; LastIndex: Int...

  TCustomListView(AObj).UpdateItems(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomListView_TopItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TopItem: TListItem read <getter>;

  Result := TListItem_sw.ToVar(TCustomListView(AObj).TopItem);
end;

function TCustomListView_ViewOrigin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ViewOrigin: TPoint read <getter>;

  Result := TPoint_sw.ToVar(TCustomListView(AObj).ViewOrigin);
end;

function TCustomListView_VisibleRowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VisibleRowCount: Integer read <getter>;

  Result := TCustomListView(AObj).VisibleRowCount;
end;

function TCustomListView_BoundingRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BoundingRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TCustomListView(AObj).BoundingRect);
end;

function TCustomListView_WorkAreas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreas: TWorkAreas read <getter>;

  Result := TWorkAreas_sw.ToVar(TCustomListView(AObj).WorkAreas);
end;

class function TCustomListView_sw.GetTypeName: WideString;
begin
  Result := 'TCustomListView';
end;

class function TCustomListView_sw.GetWrappedClass: TClass;
begin
  Result := TCustomListView;
end;

class procedure TCustomListView_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BorderStyle', TCustomListView_BorderStyle_si, TBorderStyle_sw, True, True, 0, True, False);
  AData.AddProperty('Groups', TCustomListView_Groups_si, TListGroups_sw, True, True, 0, True, False);
  AData.AddProperty('Columns', TCustomListView_Columns_si, TListColumns_sw, True, True, 0, True, False);
  AData.AddProperty('ColumnClick', TCustomListView_ColumnClick_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ReadOnly', TCustomListView_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('HideSelection', TCustomListView_HideSelection_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('IconOptions', TCustomListView_IconOptions_si, TIconOptions_sw, True, True, 0, True, False);
  AData.AddProperty('AllocBy', TCustomListView_AllocBy_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('GroupView', TCustomListView_GroupView_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('HoverTime', TCustomListView_HoverTime_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('LargeImages', TCustomListView_LargeImages_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('GroupHeaderImages', TCustomListView_GroupHeaderImages_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('MultiSelect', TCustomListView_MultiSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OwnerData', TCustomListView_OwnerData_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OwnerDraw', TCustomListView_OwnerDraw_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnAdvancedCustomDraw', TCustomListView_OnAdvancedCustomDraw_si, TLVAdvancedCustomDrawEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TCustomListView_OnChange_si, TLVChangeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnChanging', TCustomListView_OnChanging_si, TLVChangingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnColumnClick', TCustomListView_OnColumnClick_si, TLVColumnClickEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnColumnDragged', TCustomListView_OnColumnDragged_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnColumnRightClick', TCustomListView_OnColumnRightClick_si, TLVColumnRClickEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCompare', TCustomListView_OnCompare_si, TLVCompareEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCreateItemClass', TCustomListView_OnCreateItemClass_si, TLVCreateItemClassEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCustomDraw', TCustomListView_OnCustomDraw_si, TLVCustomDrawEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnData', TCustomListView_OnData_si, TLVOwnerDataEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDataHint', TCustomListView_OnDataHint_si, TLVOwnerDataHintEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDataStateChange', TCustomListView_OnDataStateChange_si, TLVOwnerDataStateChangeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDeletion', TCustomListView_OnDeletion_si, TLVDeletedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEdited', TCustomListView_OnEdited_si, TLVEditedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEditing', TCustomListView_OnEditing_si, TLVEditingEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnInfoTip', TCustomListView_OnInfoTip_si, TLVInfoTipEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnInsert', TCustomListView_OnInsert_si, TLVDeletedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetImageIndex', TCustomListView_OnGetImageIndex_si, TLVNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetSubItemImage', TCustomListView_OnGetSubItemImage_si, TLVSubItemImageEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnSelectItem', TCustomListView_OnSelectItem_si, TLVSelectItemEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnItemChecked', TCustomListView_OnItemChecked_si, TLVCheckedItemEvent_sw, True, True, 0, True, False);
  AData.AddProperty('Reading', TCustomListView_Reading_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('ShowColumnHeaders', TCustomListView_ShowColumnHeaders_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowWorkAreas', TCustomListView_ShowWorkAreas_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('SmallImages', TCustomListView_SmallImages_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('SortType', TCustomListView_SortType_si, TSortType_sw, True, True, 0, True, False);
  AData.AddProperty('StateImages', TCustomListView_StateImages_si, TCustomImageList_sw, True, True, 0, True, False);
  AData.AddProperty('ViewStyle', TCustomListView_ViewStyle_si, TViewStyle_sw, True, True, 0, True, False);
  AData.AddFunction('AlphaSort', TCustomListView_AlphaSort_si, Boolean_sw, 0, False);
  AData.AddProcedure('Arrange', TCustomListView_Arrange_si, 1, False);
  AData.AddFunction('FindCaption', TCustomListView_FindCaption_si, TListItem_sw, 5, False);
  AData.AddFunction('GetHitTestInfoAt', TCustomListView_GetHitTestInfoAt_si, THitTests_sw, 2, False);
  AData.AddFunction('GetItemAt', TCustomListView_GetItemAt_si, TListItem_sw, 2, False);
  AData.AddFunction('GetNearestItem', TCustomListView_GetNearestItem_si, TListItem_sw, 2, False);
  AData.AddFunction('GetNextItem', TCustomListView_GetNextItem_si, TListItem_sw, 3, False);
  AData.AddFunction('GetSearchString', TCustomListView_GetSearchString_si, string_sw, 0, False);
  AData.AddFunction('IsEditing', TCustomListView_IsEditing_si, Boolean_sw, 0, False);
  AData.AddProcedure('Scroll', TCustomListView_Scroll_si, 2, False);
  AData.AddProperty('Canvas', TCustomListView_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('Checkboxes', TCustomListView_Checkboxes_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Column', TCustomListView_Column_si, TListColumn_sw, True, False, 1, False, False);
  AData.AddProperty('DropTarget', TCustomListView_DropTarget_si, TListItem_sw, True, True, 0, False, False);
  AData.AddProperty('FlatScrollBars', TCustomListView_FlatScrollBars_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FullDrag', TCustomListView_FullDrag_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('GridLines', TCustomListView_GridLines_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HotTrack', TCustomListView_HotTrack_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HotTrackStyles', TCustomListView_HotTrackStyles_si, TListHotTrackStyles_sw, True, True, 0, False, False);
  AData.AddProperty('ItemFocused', TCustomListView_ItemFocused_si, TListItem_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TCustomListView_Items_si, TListItems_sw, True, True, 0, False, False);
  AData.AddProperty('RowSelect', TCustomListView_RowSelect_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SelCount', TCustomListView_SelCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Selected', TCustomListView_Selected_si, TListItem_sw, True, True, 0, False, False);
  AData.AddFunction('StringWidth', TCustomListView_StringWidth_si, Integer_sw, 1, False);
  AData.AddProcedure('UpdateItems', TCustomListView_UpdateItems_si, 2, False);
  AData.AddProperty('TopItem', TCustomListView_TopItem_si, TListItem_sw, True, False, 0, False, False);
  AData.AddProperty('ViewOrigin', TCustomListView_ViewOrigin_si, TPoint_sw, True, False, 0, False, False);
  AData.AddProperty('VisibleRowCount', TCustomListView_VisibleRowCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('BoundingRect', TCustomListView_BoundingRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreas', TCustomListView_WorkAreas_si, TWorkAreas_sw, True, False, 0, False, False);
end;

class function TCustomListView_sw.ToVar(
  const AValue: TCustomListView): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomListView_sw.FromVar(
  const AValue: OleVariant): TCustomListView;
begin
  Result := TCustomListView(ConvFromVar(AValue, TCustomListView));
end;

class function TCustomListView_sw.ClassToVar(
  AClass: TCustomListView_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomListView_sw.ClassFromVar(
  const AClass: OleVariant): TCustomListView_sc;
begin
  Result := TCustomListView_sc(ConvClsFromVar(AClass, TCustomListView));
end;

{ TListView_sw }

class function TListView_sw.GetTypeName: WideString;
begin
  Result := 'TListView';
end;

class function TListView_sw.GetWrappedClass: TClass;
begin
  Result := TListView;
end;

class procedure TListView_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('AllocBy', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Checkboxes', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('ColumnClick', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('FlatScrollBars', False);
  AData.AddPropertyRedecl('FullDrag', False);
  AData.AddPropertyRedecl('GridLines', False);
  AData.AddPropertyRedecl('Groups', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('HotTrack', False);
  AData.AddPropertyRedecl('HotTrackStyles', False);
  AData.AddPropertyRedecl('HoverTime', False);
  AData.AddPropertyRedecl('IconOptions', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('LargeImages', False);
  AData.AddPropertyRedecl('MultiSelect', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OwnerData', False);
  AData.AddPropertyRedecl('OwnerDraw', False);
  AData.AddPropertyRedecl('GroupHeaderImages', False);
  AData.AddPropertyRedecl('GroupView', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('RowSelect', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowColumnHeaders', False);
  AData.AddPropertyRedecl('ShowWorkAreas', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('SmallImages', False);
  AData.AddPropertyRedecl('SortType', False);
  AData.AddPropertyRedecl('StateImages', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('ViewStyle', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnAdvancedCustomDraw', False);
  AData.AddPropertyRedecl('OnAdvancedCustomDrawItem', False);
  AData.AddPropertyRedecl('OnAdvancedCustomDrawSubItem', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnChanging', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnColumnClick', False);
  AData.AddPropertyRedecl('OnColumnDragged', False);
  AData.AddPropertyRedecl('OnColumnRightClick', False);
  AData.AddPropertyRedecl('OnCompare', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnCustomDraw', False);
  AData.AddPropertyRedecl('OnCustomDrawItem', False);
  AData.AddPropertyRedecl('OnCustomDrawSubItem', False);
  AData.AddPropertyRedecl('OnCreateItemClass', False);
  AData.AddPropertyRedecl('OnData', False);
  AData.AddPropertyRedecl('OnDataFind', False);
  AData.AddPropertyRedecl('OnDataHint', False);
  AData.AddPropertyRedecl('OnDataStateChange', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDeletion', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnEdited', False);
  AData.AddPropertyRedecl('OnEditing', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetImageIndex', False);
  AData.AddPropertyRedecl('OnGetSubItemImage', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnInfoTip', False);
  AData.AddPropertyRedecl('OnInsert', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnSelectItem', False);
  AData.AddPropertyRedecl('OnItemChecked', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TListView_sw.ToVar(const AValue: TListView): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListView_sw.FromVar(const AValue: OleVariant): TListView;
begin
  Result := TListView(ConvFromVar(AValue, TListView));
end;

class function TListView_sw.ClassToVar(AClass: TListView_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListView_sw.ClassFromVar(
  const AClass: OleVariant): TListView_sc;
begin
  Result := TListView_sc(ConvClsFromVar(AClass, TListView));
end;

{ TListViewActionLink_sw }

class function TListViewActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TListViewActionLink';
end;

class function TListViewActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TListViewActionLink;
end;

class procedure TListViewActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TListViewActionLink_sw.ToVar(
  const AValue: TListViewActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListViewActionLink_sw.FromVar(
  const AValue: OleVariant): TListViewActionLink;
begin
  Result := TListViewActionLink(ConvFromVar(AValue, TListViewActionLink));
end;

class function TListViewActionLink_sw.ClassToVar(
  AClass: TListViewActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListViewActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TListViewActionLink_sc;
begin
  Result := TListViewActionLink_sc(ConvClsFromVar(AClass, TListViewActionLink));
end;

{ TCommonAVI_sw }

class function TCommonAVI_sw.GetTypeName: WideString;
begin
  Result := 'TCommonAVI';
end;

class procedure TCommonAVI_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'aviNone'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviNone)),
    (Name: 'aviFindFolder'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviFindFolder)),
    (Name: 'aviFindFile'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviFindFile)),
    (Name: 'aviFindComputer'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviFindComputer)),
    (Name: 'aviCopyFiles'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviCopyFiles)),
    (Name: 'aviCopyFile'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviCopyFile)),
    (Name: 'aviRecycleFile'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviRecycleFile)),
    (Name: 'aviEmptyRecycle'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviEmptyRecycle)),
    (Name: 'aviDeleteFile'; Value: Integer({$IFDEF LMDSCT_12}TCommonAVI.{$ENDIF}aviDeleteFile))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TCommonAVI_sw.ToVar(const AValue: TCommonAVI): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCommonAVI_sw.FromVar(const AValue: OleVariant): TCommonAVI;
begin
  Result := TCommonAVI(Integer(AValue));
end;

{ TAnimateParams_sw }

function TAnimateParams_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FileName: string;

  if IsGet then
    Result := TAnimateParams_sw(AObj).FValue.FileName
  else
    TAnimateParams_sw(AObj).FValue.FileName := string(AArgs[0]);
end;

function TAnimateParams_CommonAVI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CommonAVI: TCommonAVI;

  if IsGet then
    Result := TCommonAVI_sw.ToVar(TAnimateParams_sw(AObj).FValue.CommonAVI)
  else
    TAnimateParams_sw(AObj).FValue.CommonAVI := TCommonAVI_sw.FromVar(AArgs[0]);
end;

function TAnimateParams_ResHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResHandle: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(TAnimateParams_sw(AObj).FValue.ResHandle)
  else
    TAnimateParams_sw(AObj).FValue.ResHandle := THandle_sw.FromVar(AArgs[0]);
end;

function TAnimateParams_ResName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResName: string;

  if IsGet then
    Result := TAnimateParams_sw(AObj).FValue.ResName
  else
    TAnimateParams_sw(AObj).FValue.ResName := string(AArgs[0]);
end;

function TAnimateParams_ResId_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResId: Integer;

  if IsGet then
    Result := TAnimateParams_sw(AObj).FValue.ResId
  else
    TAnimateParams_sw(AObj).FValue.ResId := Integer(AArgs[0]);
end;

function TAnimateParams_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TAnimateParams_sw.Create as IDispatch;
end;

function TAnimateParams_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TAnimateParams;

  // Implicit record copy method.
  Result := TAnimateParams_sw.ToVar(TAnimateParams(AObj));
end;

class function TAnimateParams_sw.GetTypeName: WideString;
begin
  Result := 'TAnimateParams';
end;

function TAnimateParams_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TAnimateParams_sw.Create;
  TAnimateParams_sw(Result).FValue := FValue;
end;

class procedure TAnimateParams_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('FileName', TAnimateParams_FileName_si, string_sw);
  AData.AddField('CommonAVI', TAnimateParams_CommonAVI_si, TCommonAVI_sw);
  AData.AddField('ResHandle', TAnimateParams_ResHandle_si, THandle_sw);
  AData.AddField('ResName', TAnimateParams_ResName_si, string_sw);
  AData.AddField('ResId', TAnimateParams_ResId_si, Integer_sw);
  AData.AddFunction('Copy', TAnimateParams_Copy_si, TAnimateParams_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TAnimateParams_Create_si, 0, False);
end;

class function TAnimateParams_sw.ToVar(
  const AValue: TAnimateParams): OleVariant;
var
  wrpr: TAnimateParams_sw;
begin
  wrpr        := TAnimateParams_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TAnimateParams_sw.FromVar(
  const AValue: OleVariant): TAnimateParams;
begin
  Result := TAnimateParams_sw(ConvFromVar(AValue)).FValue;
end;

{ TAnimate_sw }

function TAnimate_FrameCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FrameCount: Integer read <getter>;

  Result := TAnimate(AObj).FrameCount;
end;

function TAnimate_FrameHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FrameHeight: Integer read <getter>;

  Result := TAnimate(AObj).FrameHeight;
end;

function TAnimate_FrameWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FrameWidth: Integer read <getter>;

  Result := TAnimate(AObj).FrameWidth;
end;

function TAnimate_Open_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Open: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Open
  else
    TAnimate(AObj).Open := Boolean(AArgs[0]);
end;

function TAnimate_Play_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Play(FromFrame: Word; ToFrame: Word; Count: Int...

  TAnimate(AObj).Play(Word(AArgs[0]), Word(AArgs[1]), Integer(AArgs[2]));
end;

function TAnimate_Reset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Reset;

  TAnimate(AObj).Reset();
end;

function TAnimate_Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Seek(Frame: Smallint);

  TAnimate(AObj).Seek(Smallint(AArgs[0]));
end;

function TAnimate_Stop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Stop;

  TAnimate(AObj).Stop();
end;

function TAnimate_ResHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResHandle: THandle read <getter> write <setter>;

  if IsGet then
    Result := THandle_sw.ToVar(TAnimate(AObj).ResHandle)
  else
    TAnimate(AObj).ResHandle := THandle_sw.FromVar(AArgs[0]);
end;

function TAnimate_ResId_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResId: Integer read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).ResId
  else
    TAnimate(AObj).ResId := Integer(AArgs[0]);
end;

function TAnimate_ResName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResName: string read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).ResName
  else
    TAnimate(AObj).ResName := string(AArgs[0]);
end;

function TAnimate_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Active
  else
    TAnimate(AObj).Active := Boolean(AArgs[0]);
end;

function TAnimate_Center_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Center: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Center
  else
    TAnimate(AObj).Center := Boolean(AArgs[0]);
end;

function TAnimate_CommonAVI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommonAVI: TCommonAVI read <getter> write <setter>;

  if IsGet then
    Result := TCommonAVI_sw.ToVar(TAnimate(AObj).CommonAVI)
  else
    TAnimate(AObj).CommonAVI := TCommonAVI_sw.FromVar(AArgs[0]);
end;

function TAnimate_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: string read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).FileName
  else
    TAnimate(AObj).FileName := string(AArgs[0]);
end;

function TAnimate_Repetitions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Repetitions: Integer read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Repetitions
  else
    TAnimate(AObj).Repetitions := Integer(AArgs[0]);
end;

function TAnimate_StartFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StartFrame: Smallint read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).StartFrame
  else
    TAnimate(AObj).StartFrame := Smallint(AArgs[0]);
end;

function TAnimate_StopFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StopFrame: Smallint read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).StopFrame
  else
    TAnimate(AObj).StopFrame := Smallint(AArgs[0]);
end;

function TAnimate_Timers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Timers: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Timers
  else
    TAnimate(AObj).Timers := Boolean(AArgs[0]);
end;

function TAnimate_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAnimate(AObj).Transparent
  else
    TAnimate(AObj).Transparent := Boolean(AArgs[0]);
end;

function TAnimate_OnOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnOpen: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TAnimate(AObj).OnOpen)
  else
    TAnimate(AObj).OnOpen := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TAnimate_OnClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClose: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TAnimate(AObj).OnClose)
  else
    TAnimate(AObj).OnClose := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TAnimate_OnStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStart: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TAnimate(AObj).OnStart)
  else
    TAnimate(AObj).OnStart := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TAnimate_OnStop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStop: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TAnimate(AObj).OnStop)
  else
    TAnimate(AObj).OnStop := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TAnimate_sw.GetTypeName: WideString;
begin
  Result := 'TAnimate';
end;

class function TAnimate_sw.GetWrappedClass: TClass;
begin
  Result := TAnimate;
end;

class procedure TAnimate_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FrameCount', TAnimate_FrameCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('FrameHeight', TAnimate_FrameHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('FrameWidth', TAnimate_FrameWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Open', TAnimate_Open_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProcedure('Play', TAnimate_Play_si, 3, False);
  AData.AddProcedure('Reset', TAnimate_Reset_si, 0, False);
  AData.AddProcedure('Seek', TAnimate_Seek_si, 1, False);
  AData.AddProcedure('Stop', TAnimate_Stop_si, 0, False);
  AData.AddProperty('ResHandle', TAnimate_ResHandle_si, THandle_sw, True, True, 0, False, False);
  AData.AddProperty('ResId', TAnimate_ResId_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ResName', TAnimate_ResName_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddProperty('Active', TAnimate_Active_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddProperty('Center', TAnimate_Center_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddProperty('CommonAVI', TAnimate_CommonAVI_si, TCommonAVI_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddProperty('FileName', TAnimate_FileName_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('Repetitions', TAnimate_Repetitions_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('StartFrame', TAnimate_StartFrame_si, Smallint_sw, True, True, 0, False, False);
  AData.AddProperty('StopFrame', TAnimate_StopFrame_si, Smallint_sw, True, True, 0, False, False);
  AData.AddProperty('Timers', TAnimate_Timers_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddProperty('Transparent', TAnimate_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddProperty('OnOpen', TAnimate_OnOpen_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnClose', TAnimate_OnClose_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddProperty('OnStart', TAnimate_OnStart_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnStop', TAnimate_OnStop_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TAnimate_sw.ToVar(const AValue: TAnimate): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAnimate_sw.FromVar(const AValue: OleVariant): TAnimate;
begin
  Result := TAnimate(ConvFromVar(AValue, TAnimate));
end;

class function TAnimate_sw.ClassToVar(AClass: TAnimate_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAnimate_sw.ClassFromVar(const AClass: OleVariant): TAnimate_sc;
begin
  Result := TAnimate_sc(ConvClsFromVar(AClass, TAnimate));
end;

{ TToolButtonStyle_sw }

class function TToolButtonStyle_sw.GetTypeName: WideString;
begin
  Result := 'TToolButtonStyle';
end;

class procedure TToolButtonStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'tbsButton'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsButton)),
    (Name: 'tbsCheck'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsCheck)),
    (Name: 'tbsDropDown'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsDropDown)),
    (Name: 'tbsSeparator'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsSeparator)),
    (Name: 'tbsDivider'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsDivider)),
    (Name: 'tbsTextButton'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonStyle.{$ENDIF}tbsTextButton))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TToolButtonStyle_sw.ToVar(
  const AValue: TToolButtonStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TToolButtonStyle_sw.FromVar(
  const AValue: OleVariant): TToolButtonStyle;
begin
  Result := TToolButtonStyle(Integer(AValue));
end;

{ TToolButtonState_sw }

class function TToolButtonState_sw.GetTypeName: WideString;
begin
  Result := 'TToolButtonState';
end;

class procedure TToolButtonState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'tbsChecked'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsChecked)),
    (Name: 'tbsPressed'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsPressed)),
    (Name: 'tbsEnabled'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsEnabled)),
    (Name: 'tbsHidden'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsHidden)),
    (Name: 'tbsIndeterminate'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsIndeterminate)),
    (Name: 'tbsWrap'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsWrap)),
    (Name: 'tbsEllipses'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsEllipses)),
    (Name: 'tbsMarked'; Value: Integer({$IFDEF LMDSCT_12}TToolButtonState.{$ENDIF}tbsMarked))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TToolButtonState_sw.ToVar(
  const AValue: TToolButtonState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TToolButtonState_sw.FromVar(
  const AValue: OleVariant): TToolButtonState;
begin
  Result := TToolButtonState(Integer(AValue));
end;

{ TToolButtonActionLink_sw }

class function TToolButtonActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TToolButtonActionLink';
end;

class function TToolButtonActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TToolButtonActionLink;
end;

class procedure TToolButtonActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TToolButtonActionLink_sw.ToVar(
  const AValue: TToolButtonActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolButtonActionLink_sw.FromVar(
  const AValue: OleVariant): TToolButtonActionLink;
begin
  Result := TToolButtonActionLink(ConvFromVar(AValue, TToolButtonActionLink));
end;

class function TToolButtonActionLink_sw.ClassToVar(
  AClass: TToolButtonActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolButtonActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TToolButtonActionLink_sc;
begin
  Result := TToolButtonActionLink_sc(ConvClsFromVar(AClass, 
    TToolButtonActionLink));
end;

{ TToolButtonActionLinkClass_sw }

class function TToolButtonActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TToolButtonActionLinkClass';
end;

class function TToolButtonActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TToolButtonActionLink;
end;

class function TToolButtonActionLinkClass_sw.ToVar(
  const AValue: TToolButtonActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolButtonActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TToolButtonActionLinkClass;
begin
  Result := TToolButtonActionLinkClass(ConvFromVar(AValue, 
    TToolButtonActionLink));
end;

{ TToolButton_sw }

function TToolButton_CheckMenuDropdown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CheckMenuDropdown: Boolean;

  Result := TToolButton(AObj).CheckMenuDropdown();
end;

function TToolButton_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter>;

  Result := TToolButton(AObj).Index;
end;

function TToolButton_AllowAllUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowAllUp: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).AllowAllUp
  else
    TToolButton(AObj).AllowAllUp := Boolean(AArgs[0]);
end;

function TToolButton_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).AutoSize
  else
    TToolButton(AObj).AutoSize := Boolean(AArgs[0]);
end;

function TToolButton_Down_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Down: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).Down
  else
    TToolButton(AObj).Down := Boolean(AArgs[0]);
end;

function TToolButton_DropdownMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropdownMenu: TPopupMenu read <getter> write <se...

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TToolButton(AObj).DropdownMenu)
  else
    TToolButton(AObj).DropdownMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

function TToolButton_EnableDropdown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EnableDropdown: Boolean read <getter> write <set...

  if IsGet then
    Result := TToolButton(AObj).EnableDropdown
  else
    TToolButton(AObj).EnableDropdown := Boolean(AArgs[0]);
end;

function TToolButton_Grouped_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Grouped: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).Grouped
  else
    TToolButton(AObj).Grouped := Boolean(AArgs[0]);
end;

function TToolButton_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TToolButton(AObj).ImageIndex)
  else
    TToolButton(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TToolButton_Indeterminate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Indeterminate: Boolean read <getter> write <sett...

  if IsGet then
    Result := TToolButton(AObj).Indeterminate
  else
    TToolButton(AObj).Indeterminate := Boolean(AArgs[0]);
end;

function TToolButton_Marked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Marked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).Marked
  else
    TToolButton(AObj).Marked := Boolean(AArgs[0]);
end;

function TToolButton_MenuItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MenuItem: TMenuItem read <getter> write <setter>;

  if IsGet then
    Result := TMenuItem_sw.ToVar(TToolButton(AObj).MenuItem)
  else
    TToolButton(AObj).MenuItem := TMenuItem_sw.FromVar(AArgs[0]);
end;

function TToolButton_Wrap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Wrap: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolButton(AObj).Wrap
  else
    TToolButton(AObj).Wrap := Boolean(AArgs[0]);
end;

function TToolButton_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TToolButtonStyle read <getter> write <set...

  if IsGet then
    Result := TToolButtonStyle_sw.ToVar(TToolButton(AObj).Style)
  else
    TToolButton(AObj).Style := TToolButtonStyle_sw.FromVar(AArgs[0]);
end;

class function TToolButton_sw.GetTypeName: WideString;
begin
  Result := 'TToolButton';
end;

class function TToolButton_sw.GetWrappedClass: TClass;
begin
  Result := TToolButton;
end;

class procedure TToolButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('CheckMenuDropdown', TToolButton_CheckMenuDropdown_si, Boolean_sw, 0, False);
  AData.AddProperty('Index', TToolButton_Index_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Action', False);
  AData.AddProperty('AllowAllUp', TToolButton_AllowAllUp_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoSize', TToolButton_AutoSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddProperty('Down', TToolButton_Down_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DropdownMenu', TToolButton_DropdownMenu_si, TPopupMenu_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('EnableDropdown', TToolButton_EnableDropdown_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Grouped', TToolButton_Grouped_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddProperty('ImageIndex', TToolButton_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Indeterminate', TToolButton_Indeterminate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Marked', TToolButton_Marked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MenuItem', TToolButton_MenuItem_si, TMenuItem_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Wrap', TToolButton_Wrap_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Style', TToolButton_Style_si, TToolButtonStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TToolButton_sw.ToVar(const AValue: TToolButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolButton_sw.FromVar(const AValue: OleVariant): TToolButton;
begin
  Result := TToolButton(ConvFromVar(AValue, TToolButton));
end;

class function TToolButton_sw.ClassToVar(AClass: TToolButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolButton_sw.ClassFromVar(
  const AClass: OleVariant): TToolButton_sc;
begin
  Result := TToolButton_sc(ConvClsFromVar(AClass, TToolButton));
end;

{ TTBDrawingStyle_sw }

class function TTBDrawingStyle_sw.GetTypeName: WideString;
begin
  Result := 'TTBDrawingStyle';
end;

class procedure TTBDrawingStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dsNormal'; Value: Integer({$IFDEF LMDSCT_12}TTBDrawingStyle.{$ENDIF}dsNormal)),
    (Name: 'dsGradient'; Value: Integer({$IFDEF LMDSCT_12}TTBDrawingStyle.{$ENDIF}dsGradient))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTBDrawingStyle_sw.ToVar(
  const AValue: TTBDrawingStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTBDrawingStyle_sw.FromVar(
  const AValue: OleVariant): TTBDrawingStyle;
begin
  Result := TTBDrawingStyle(Integer(AValue));
end;

{ TTBCustomDrawEvent_sh }

function TTBCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TTBCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTBCustomDrawEvent_sh.Handler(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TToolBar; const ARect: TRect; var Defa...

  v_1 := DefaultDraw;
  args[0] := TToolBar_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TTBCustomDrawEvent_sw }

class function TTBCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTBCustomDrawEvent';
end;

class function TTBCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTBCustomDrawEvent_sh;
end;

class function TTBCustomDrawEvent_sw.ToVar(
  const AValue: TTBCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTBCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TTBCustomDrawEvent;
begin
  Result := TTBCustomDrawEvent(ConvFromVar(AValue));
end;

class function TTBCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTBCustomDrawEvent;
var
  hdlr: TTBCustomDrawEvent_sh;
begin
  hdlr   := TTBCustomDrawEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTBCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TTBAdvancedCustomDrawEvent_sh }

function TTBAdvancedCustomDrawEvent_sh.GetHandler: TMethod;
var
  hdr: TTBAdvancedCustomDrawEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTBAdvancedCustomDrawEvent_sh.Handler(Sender: TToolBar;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TToolBar; const ARect: TRect; Stage: T...

  v_1 := DefaultDraw;
  args[0] := TToolBar_sw.ToVar(Sender);
  args[1] := TRect_sw.ToVar(ARect);
  args[2] := TCustomDrawStage_sw.ToVar(Stage);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DefaultDraw := Boolean(v_1);
end;

{ TTBAdvancedCustomDrawEvent_sw }

class function TTBAdvancedCustomDrawEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTBAdvancedCustomDrawEvent';
end;

class function TTBAdvancedCustomDrawEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTBAdvancedCustomDrawEvent_sh;
end;

class function TTBAdvancedCustomDrawEvent_sw.ToVar(
  const AValue: TTBAdvancedCustomDrawEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTBAdvancedCustomDrawEvent_sw.FromVar(
  const AValue: OleVariant): TTBAdvancedCustomDrawEvent;
begin
  Result := TTBAdvancedCustomDrawEvent(ConvFromVar(AValue));
end;

class function TTBAdvancedCustomDrawEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TTBAdvancedCustomDrawEvent;
var
  hdlr: TTBAdvancedCustomDrawEvent_sh;
begin
  hdlr   := TTBAdvancedCustomDrawEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TTBAdvancedCustomDrawEvent_sw));
  Result := hdlr.Handler;
end;

{ TTBCustomizeQueryEvent_sh }

function TTBCustomizeQueryEvent_sh.GetHandler: TMethod;
var
  hdr: TTBCustomizeQueryEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTBCustomizeQueryEvent_sh.Handler(Sender: TToolbar; Index: Integer;
  var Allow: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TToolbar; Index: Integer; var Allow: B...

  v_1 := Allow;
  args[0] := TToolbar_sw.ToVar(Sender);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Allow := Boolean(v_1);
end;

{ TTBCustomizeQueryEvent_sw }

class function TTBCustomizeQueryEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTBCustomizeQueryEvent';
end;

class function TTBCustomizeQueryEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTBCustomizeQueryEvent_sh;
end;

class function TTBCustomizeQueryEvent_sw.ToVar(
  const AValue: TTBCustomizeQueryEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTBCustomizeQueryEvent_sw.FromVar(
  const AValue: OleVariant): TTBCustomizeQueryEvent;
begin
  Result := TTBCustomizeQueryEvent(ConvFromVar(AValue));
end;

class function TTBCustomizeQueryEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TTBCustomizeQueryEvent;
var
  hdlr: TTBCustomizeQueryEvent_sh;
begin
  hdlr   := TTBCustomizeQueryEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTBCustomizeQueryEvent_sw));
  Result := hdlr.Handler;
end;

{ TTBNewButtonEvent_sh }

function TTBNewButtonEvent_sh.GetHandler: TMethod;
var
  hdr: TTBNewButtonEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTBNewButtonEvent_sh.Handler(Sender: TToolbar; Index: Integer;
  var Button: TToolButton);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TToolbar; Index: Integer; var Button: ...

  v_1 := TToolButton_sw.ToVar(Button);
  args[0] := TToolbar_sw.ToVar(Sender);
  args[1] := Index;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Button := TToolButton_sw.FromVar(v_1);
end;

{ TTBNewButtonEvent_sw }

class function TTBNewButtonEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTBNewButtonEvent';
end;

class function TTBNewButtonEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTBNewButtonEvent_sh;
end;

class function TTBNewButtonEvent_sw.ToVar(
  const AValue: TTBNewButtonEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTBNewButtonEvent_sw.FromVar(
  const AValue: OleVariant): TTBNewButtonEvent;
begin
  Result := TTBNewButtonEvent(ConvFromVar(AValue));
end;

class function TTBNewButtonEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TTBNewButtonEvent;
var
  hdlr: TTBNewButtonEvent_sh;
begin
  hdlr   := TTBNewButtonEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTBNewButtonEvent_sw));
  Result := hdlr.Handler;
end;

{ TTBButtonEvent_sh }

function TTBButtonEvent_sh.GetHandler: TMethod;
var
  hdr: TTBButtonEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TTBButtonEvent_sh.Handler(Sender: TToolbar; Button: TToolButton);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TToolbar; Button: TToolButton) of object

  args[0] := TToolbar_sw.ToVar(Sender);
  args[1] := TToolButton_sw.ToVar(Button);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TTBButtonEvent_sw }

class function TTBButtonEvent_sw.GetTypeName: WideString;
begin
  Result := 'TTBButtonEvent';
end;

class function TTBButtonEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TTBButtonEvent_sh;
end;

class function TTBButtonEvent_sw.ToVar(
  const AValue: TTBButtonEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TTBButtonEvent_sw.FromVar(
  const AValue: OleVariant): TTBButtonEvent;
begin
  Result := TTBButtonEvent(ConvFromVar(AValue));
end;

class function TTBButtonEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TTBButtonEvent;
var
  hdlr: TTBButtonEvent_sh;
begin
  hdlr   := TTBButtonEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TTBButtonEvent_sw));
  Result := hdlr.Handler;
end;

{ TToolBarEnumerator_sw }

function TToolBarEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AToolBar: TToolBar);

  Result := TToolBarEnumerator_sw.ToVar(TToolBarEnumerator_sc(AObj).Create(
    TToolBar_sw.FromVar(AArgs[0])));
end;

function TToolBarEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TToolButton;

  Result := TToolButton_sw.ToVar(TToolBarEnumerator(AObj).GetCurrent());
end;

function TToolBarEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TToolBarEnumerator(AObj).MoveNext();
end;

function TToolBarEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TToolButton read <getter>;

  Result := TToolButton_sw.ToVar(TToolBarEnumerator(AObj).Current);
end;

class function TToolBarEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TToolBarEnumerator';
end;

class function TToolBarEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TToolBarEnumerator;
end;

class procedure TToolBarEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TToolBarEnumerator_GetCurrent_si, TToolButton_sw, 0, False);
  AData.AddFunction('MoveNext', TToolBarEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TToolBarEnumerator_Current_si, TToolButton_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TToolBarEnumerator_Create_si, 1, False);
end;

class function TToolBarEnumerator_sw.ToVar(
  const AValue: TToolBarEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolBarEnumerator_sw.FromVar(
  const AValue: OleVariant): TToolBarEnumerator;
begin
  Result := TToolBarEnumerator(ConvFromVar(AValue, TToolBarEnumerator));
end;

class function TToolBarEnumerator_sw.ClassToVar(
  AClass: TToolBarEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolBarEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TToolBarEnumerator_sc;
begin
  Result := TToolBarEnumerator_sc(ConvClsFromVar(AClass, TToolBarEnumerator));
end;

{ TToolBar_sw }

function TToolBar_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TToolBarEnumerator;

  Result := TToolBarEnumerator_sw.ToVar(TToolBar(AObj).GetEnumerator());
end;

function TToolBar_TrackMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TrackMenu(Button: TToolButton): Boolean;

  Result := TToolBar(AObj).TrackMenu(TToolButton_sw.FromVar(AArgs[0]));
end;

function TToolBar_ButtonCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonCount: Integer read <getter>;

  Result := TToolBar(AObj).ButtonCount;
end;

function TToolBar_Buttons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Buttons[Index: Integer]: TToolButton read <getter>;

  Result := TToolButton_sw.ToVar(TToolBar(AObj).Buttons[Integer(AArgs[0])]);
end;

function TToolBar_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TToolBar(AObj).Canvas);
end;

function TToolBar_CustomizeKeyName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomizeKeyName: string read <getter> write <se...

  if IsGet then
    Result := TToolBar(AObj).CustomizeKeyName
  else
    TToolBar(AObj).CustomizeKeyName := string(AArgs[0]);
end;

function TToolBar_CustomizeValueName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomizeValueName: string read <getter> write <...

  if IsGet then
    Result := TToolBar(AObj).CustomizeValueName
  else
    TToolBar(AObj).CustomizeValueName := string(AArgs[0]);
end;

function TToolBar_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowCount: Integer read <getter>;

  Result := TToolBar(AObj).RowCount;
end;

function TToolBar_ButtonHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).ButtonHeight
  else
    TToolBar(AObj).ButtonHeight := Integer(AArgs[0]);
end;

function TToolBar_ButtonWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).ButtonWidth
  else
    TToolBar(AObj).ButtonWidth := Integer(AArgs[0]);
end;

function TToolBar_Customizable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Customizable: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).Customizable
  else
    TToolBar(AObj).Customizable := Boolean(AArgs[0]);
end;

function TToolBar_DisabledImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisabledImages: TCustomImageList read <getter> w...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TToolBar(AObj).DisabledImages)
  else
    TToolBar(AObj).DisabledImages := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TToolBar_DrawingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DrawingStyle: TTBDrawingStyle read <getter> writ...

  if IsGet then
    Result := TTBDrawingStyle_sw.ToVar(TToolBar(AObj).DrawingStyle)
  else
    TToolBar(AObj).DrawingStyle := TTBDrawingStyle_sw.FromVar(AArgs[0]);
end;

function TToolBar_Flat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flat: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).Flat
  else
    TToolBar(AObj).Flat := Boolean(AArgs[0]);
end;

function TToolBar_GradientEndColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GradientEndColor: TColor read <getter> write <se...

  if IsGet then
    Result := TColor_sw.ToVar(TToolBar(AObj).GradientEndColor)
  else
    TToolBar(AObj).GradientEndColor := TColor_sw.FromVar(AArgs[0]);
end;

function TToolBar_GradientStartColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GradientStartColor: TColor read <getter> write <...

  if IsGet then
    Result := TColor_sw.ToVar(TToolBar(AObj).GradientStartColor)
  else
    TToolBar(AObj).GradientStartColor := TColor_sw.FromVar(AArgs[0]);
end;

function TToolBar_HideClippedButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HideClippedButtons: Boolean read <getter> write ...

  if IsGet then
    Result := TToolBar(AObj).HideClippedButtons
  else
    TToolBar(AObj).HideClippedButtons := Boolean(AArgs[0]);
end;

function TToolBar_HotImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HotImages: TCustomImageList read <getter> write ...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TToolBar(AObj).HotImages)
  else
    TToolBar(AObj).HotImages := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TToolBar_HotTrackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HotTrackColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TToolBar(AObj).HotTrackColor)
  else
    TToolBar(AObj).HotTrackColor := TColor_sw.FromVar(AArgs[0]);
end;

function TToolBar_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TToolBar(AObj).Images)
  else
    TToolBar(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TToolBar_Indent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Indent: Integer read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).Indent
  else
    TToolBar(AObj).Indent := Integer(AArgs[0]);
end;

function TToolBar_List_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property List: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).List
  else
    TToolBar(AObj).List := Boolean(AArgs[0]);
end;

function TToolBar_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Menu: TMainMenu read <getter> write <setter>;

  if IsGet then
    Result := TMainMenu_sw.ToVar(TToolBar(AObj).Menu)
  else
    TToolBar(AObj).Menu := TMainMenu_sw.FromVar(AArgs[0]);
end;

function TToolBar_GradientDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GradientDirection: TGradientDirection read <gett...

  if IsGet then
    Result := TGradientDirection_sw.ToVar(TToolBar(AObj).GradientDirection)
  else
    TToolBar(AObj).GradientDirection := TGradientDirection_sw.FromVar(AArgs[0]);
end;

function TToolBar_ShowCaptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowCaptions: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).ShowCaptions
  else
    TToolBar(AObj).ShowCaptions := Boolean(AArgs[0]);
end;

function TToolBar_AllowTextButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowTextButtons: Boolean read <getter> write <s...

  if IsGet then
    Result := TToolBar(AObj).AllowTextButtons
  else
    TToolBar(AObj).AllowTextButtons := Boolean(AArgs[0]);
end;

function TToolBar_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).Transparent
  else
    TToolBar(AObj).Transparent := Boolean(AArgs[0]);
end;

function TToolBar_Wrapable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Wrapable: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TToolBar(AObj).Wrapable
  else
    TToolBar(AObj).Wrapable := Boolean(AArgs[0]);
end;

function TToolBar_OnAdvancedCustomDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnAdvancedCustomDraw: TTBAdvancedCustomDrawEvent...

  if IsGet then
    Result := TTBAdvancedCustomDrawEvent_sw.ToVar(TToolBar(AObj).
      OnAdvancedCustomDraw)
  else
    TToolBar(AObj).OnAdvancedCustomDraw := TTBAdvancedCustomDrawEvent_sw.
      FromVar(AArgs[0]);
end;

function TToolBar_OnCustomDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomDraw: TTBCustomDrawEvent read <getter> w...

  if IsGet then
    Result := TTBCustomDrawEvent_sw.ToVar(TToolBar(AObj).OnCustomDraw)
  else
    TToolBar(AObj).OnCustomDraw := TTBCustomDrawEvent_sw.FromVar(AArgs[0]);
end;

function TToolBar_OnCustomizeAdded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeAdded: TTBButtonEvent read <getter> w...

  if IsGet then
    Result := TTBButtonEvent_sw.ToVar(TToolBar(AObj).OnCustomizeAdded)
  else
    TToolBar(AObj).OnCustomizeAdded := TTBButtonEvent_sw.FromVar(AArgs[0]);
end;

function TToolBar_OnCustomizeCanInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeCanInsert: TTBCustomizeQueryEvent rea...

  if IsGet then
    Result := TTBCustomizeQueryEvent_sw.ToVar(TToolBar(AObj).
      OnCustomizeCanInsert)
  else
    TToolBar(AObj).OnCustomizeCanInsert := TTBCustomizeQueryEvent_sw.FromVar(
      AArgs[0]);
end;

function TToolBar_OnCustomizeCanDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeCanDelete: TTBCustomizeQueryEvent rea...

  if IsGet then
    Result := TTBCustomizeQueryEvent_sw.ToVar(TToolBar(AObj).
      OnCustomizeCanDelete)
  else
    TToolBar(AObj).OnCustomizeCanDelete := TTBCustomizeQueryEvent_sw.FromVar(
      AArgs[0]);
end;

function TToolBar_OnCustomized_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomized: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TToolBar(AObj).OnCustomized)
  else
    TToolBar(AObj).OnCustomized := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TToolBar_OnCustomizeDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeDelete: TTBButtonEvent read <getter> ...

  if IsGet then
    Result := TTBButtonEvent_sw.ToVar(TToolBar(AObj).OnCustomizeDelete)
  else
    TToolBar(AObj).OnCustomizeDelete := TTBButtonEvent_sw.FromVar(AArgs[0]);
end;

function TToolBar_OnCustomizing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizing: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TToolBar(AObj).OnCustomizing)
  else
    TToolBar(AObj).OnCustomizing := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TToolBar_OnCustomizeNewButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeNewButton: TTBNewButtonEvent read <ge...

  if IsGet then
    Result := TTBNewButtonEvent_sw.ToVar(TToolBar(AObj).OnCustomizeNewButton)
  else
    TToolBar(AObj).OnCustomizeNewButton := TTBNewButtonEvent_sw.FromVar(
      AArgs[0]);
end;

function TToolBar_OnCustomizeReset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCustomizeReset: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TToolBar(AObj).OnCustomizeReset)
  else
    TToolBar(AObj).OnCustomizeReset := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TToolBar_sw.GetTypeName: WideString;
begin
  Result := 'TToolBar';
end;

class function TToolBar_sw.GetWrappedClass: TClass;
begin
  Result := TToolBar;
end;

class procedure TToolBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetEnumerator', TToolBar_GetEnumerator_si, TToolBarEnumerator_sw, 0, False);
  AData.AddFunction('TrackMenu', TToolBar_TrackMenu_si, Boolean_sw, 1, False);
  AData.AddProperty('ButtonCount', TToolBar_ButtonCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Buttons', TToolBar_Buttons_si, TToolButton_sw, True, False, 1, False, False);
  AData.AddProperty('Canvas', TToolBar_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('CustomizeKeyName', TToolBar_CustomizeKeyName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('CustomizeValueName', TToolBar_CustomizeValueName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('RowCount', TToolBar_RowCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddProperty('ButtonHeight', TToolBar_ButtonHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ButtonWidth', TToolBar_ButtonWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('Customizable', TToolBar_Customizable_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DisabledImages', TToolBar_DisabledImages_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DrawingStyle', TToolBar_DrawingStyle_si, TTBDrawingStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('EdgeBorders', False);
  AData.AddPropertyRedecl('EdgeInner', False);
  AData.AddPropertyRedecl('EdgeOuter', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('Flat', TToolBar_Flat_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('GradientEndColor', TToolBar_GradientEndColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('GradientStartColor', TToolBar_GradientStartColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddProperty('HideClippedButtons', TToolBar_HideClippedButtons_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HotImages', TToolBar_HotImages_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddProperty('HotTrackColor', TToolBar_HotTrackColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Images', TToolBar_Images_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddProperty('Indent', TToolBar_Indent_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('List', TToolBar_List_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Menu', TToolBar_Menu_si, TMainMenu_sw, True, True, 0, False, False);
  AData.AddProperty('GradientDirection', TToolBar_GradientDirection_si, TGradientDirection_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ShowCaptions', TToolBar_ShowCaptions_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AllowTextButtons', TToolBar_AllowTextButtons_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddProperty('Transparent', TToolBar_Transparent_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddProperty('Wrapable', TToolBar_Wrapable_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnAdvancedCustomDraw', TToolBar_OnAdvancedCustomDraw_si, TTBAdvancedCustomDrawEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddProperty('OnCustomDraw', TToolBar_OnCustomDraw_si, TTBCustomDrawEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeAdded', TToolBar_OnCustomizeAdded_si, TTBButtonEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeCanInsert', TToolBar_OnCustomizeCanInsert_si, TTBCustomizeQueryEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeCanDelete', TToolBar_OnCustomizeCanDelete_si, TTBCustomizeQueryEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomized', TToolBar_OnCustomized_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeDelete', TToolBar_OnCustomizeDelete_si, TTBButtonEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizing', TToolBar_OnCustomizing_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeNewButton', TToolBar_OnCustomizeNewButton_si, TTBNewButtonEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCustomizeReset', TToolBar_OnCustomizeReset_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TToolBar_sw.ToVar(const AValue: TToolBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolBar_sw.FromVar(const AValue: OleVariant): TToolBar;
begin
  Result := TToolBar(ConvFromVar(AValue, TToolBar));
end;

class function TToolBar_sw.ClassToVar(AClass: TToolBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolBar_sw.ClassFromVar(const AClass: OleVariant): TToolBar_sc;
begin
  Result := TToolBar_sc(ConvClsFromVar(AClass, TToolBar));
end;

{ TToolBarDockObject_sw }

class function TToolBarDockObject_sw.GetTypeName: WideString;
begin
  Result := 'TToolBarDockObject';
end;

class function TToolBarDockObject_sw.GetWrappedClass: TClass;
begin
  Result := TToolBarDockObject;
end;

class procedure TToolBarDockObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TToolBarDockObject_sw.ToVar(
  const AValue: TToolBarDockObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolBarDockObject_sw.FromVar(
  const AValue: OleVariant): TToolBarDockObject;
begin
  Result := TToolBarDockObject(ConvFromVar(AValue, TToolBarDockObject));
end;

class function TToolBarDockObject_sw.ClassToVar(
  AClass: TToolBarDockObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolBarDockObject_sw.ClassFromVar(
  const AClass: OleVariant): TToolBarDockObject_sc;
begin
  Result := TToolBarDockObject_sc(ConvClsFromVar(AClass, TToolBarDockObject));
end;

{ TCoolBand_sw }

function TCoolBand_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter>;

  Result := TCoolBand(AObj).Height;
end;

function TCoolBand_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bitmap: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TCoolBand(AObj).Bitmap)
  else
    TCoolBand(AObj).Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TCoolBand_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TBorderStyle read <getter> write <s...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCoolBand(AObj).BorderStyle)
  else
    TCoolBand(AObj).BorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

function TCoolBand_Break_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Break: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).Break
  else
    TCoolBand(AObj).Break := Boolean(AArgs[0]);
end;

function TCoolBand_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCoolBand(AObj).Color)
  else
    TCoolBand(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TCoolBand_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TWinControl read <getter> write <setter>;

  if IsGet then
    Result := TWinControl_sw.ToVar(TCoolBand(AObj).Control)
  else
    TCoolBand(AObj).Control := TWinControl_sw.FromVar(AArgs[0]);
end;

function TCoolBand_FixedBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedBackground: Boolean read <getter> write <se...

  if IsGet then
    Result := TCoolBand(AObj).FixedBackground
  else
    TCoolBand(AObj).FixedBackground := Boolean(AArgs[0]);
end;

function TCoolBand_FixedSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).FixedSize
  else
    TCoolBand(AObj).FixedSize := Boolean(AArgs[0]);
end;

function TCoolBand_HorizontalOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HorizontalOnly: Boolean read <getter> write <set...

  if IsGet then
    Result := TCoolBand(AObj).HorizontalOnly
  else
    TCoolBand(AObj).HorizontalOnly := Boolean(AArgs[0]);
end;

function TCoolBand_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TCoolBand(AObj).ImageIndex)
  else
    TCoolBand(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TCoolBand_MinHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).MinHeight
  else
    TCoolBand(AObj).MinHeight := Integer(AArgs[0]);
end;

function TCoolBand_MinWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).MinWidth
  else
    TCoolBand(AObj).MinWidth := Integer(AArgs[0]);
end;

function TCoolBand_ParentColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentColor: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).ParentColor
  else
    TCoolBand(AObj).ParentColor := Boolean(AArgs[0]);
end;

function TCoolBand_ParentBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentBitmap: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).ParentBitmap
  else
    TCoolBand(AObj).ParentBitmap := Boolean(AArgs[0]);
end;

function TCoolBand_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).Text
  else
    TCoolBand(AObj).Text := string(AArgs[0]);
end;

function TCoolBand_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).Visible
  else
    TCoolBand(AObj).Visible := Boolean(AArgs[0]);
end;

function TCoolBand_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCoolBand(AObj).Width
  else
    TCoolBand(AObj).Width := Integer(AArgs[0]);
end;

class function TCoolBand_sw.GetTypeName: WideString;
begin
  Result := 'TCoolBand';
end;

class function TCoolBand_sw.GetWrappedClass: TClass;
begin
  Result := TCoolBand;
end;

class procedure TCoolBand_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Height', TCoolBand_Height_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Bitmap', TCoolBand_Bitmap_si, TBitmap_sw, True, True, 0, False, False);
  AData.AddProperty('BorderStyle', TCoolBand_BorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Break', TCoolBand_Break_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TCoolBand_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Control', TCoolBand_Control_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddProperty('FixedBackground', TCoolBand_FixedBackground_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FixedSize', TCoolBand_FixedSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HorizontalOnly', TCoolBand_HorizontalOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TCoolBand_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('MinHeight', TCoolBand_MinHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinWidth', TCoolBand_MinWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ParentColor', TCoolBand_ParentColor_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ParentBitmap', TCoolBand_ParentBitmap_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TCoolBand_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TCoolBand_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TCoolBand_Width_si, Integer_sw, True, True, 0, False, False);
end;

class function TCoolBand_sw.ToVar(const AValue: TCoolBand): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCoolBand_sw.FromVar(const AValue: OleVariant): TCoolBand;
begin
  Result := TCoolBand(ConvFromVar(AValue, TCoolBand));
end;

class function TCoolBand_sw.ClassToVar(AClass: TCoolBand_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCoolBand_sw.ClassFromVar(
  const AClass: OleVariant): TCoolBand_sc;
begin
  Result := TCoolBand_sc(ConvClsFromVar(AClass, TCoolBand));
end;

{ TCoolBands_sw }

function TCoolBands_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(CoolBar: TCoolBar);

  Result := TCoolBands_sw.ToVar(TCoolBands_sc(AObj).Create(TCoolBar_sw.FromVar(
    AArgs[0])));
end;

function TCoolBands_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TCoolBand;

  Result := TCoolBand_sw.ToVar(TCoolBands(AObj).Add());
end;

function TCoolBands_FindBand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindBand(AControl: TControl): TCoolBand;

  Result := TCoolBand_sw.ToVar(TCoolBands(AObj).FindBand(TControl_sw.FromVar(
    AArgs[0])));
end;

function TCoolBands_CoolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CoolBar: TCoolBar read <getter>;

  Result := TCoolBar_sw.ToVar(TCoolBands(AObj).CoolBar);
end;

function TCoolBands_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TCoolBand read <getter> w...

  if IsGet then
    Result := TCoolBand_sw.ToVar(TCoolBands(AObj).Items[Integer(AArgs[0])])
  else
    TCoolBands(AObj).Items[Integer(AArgs[0])] := TCoolBand_sw.FromVar(AArgs[1]);
end;

class function TCoolBands_sw.GetTypeName: WideString;
begin
  Result := 'TCoolBands';
end;

class function TCoolBands_sw.GetWrappedClass: TClass;
begin
  Result := TCoolBands;
end;

class procedure TCoolBands_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TCoolBands_Add_si, TCoolBand_sw, 0, False);
  AData.AddFunction('FindBand', TCoolBands_FindBand_si, TCoolBand_sw, 1, False);
  AData.AddProperty('CoolBar', TCoolBands_CoolBar_si, TCoolBar_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TCoolBands_Items_si, TCoolBand_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TCoolBands_Create_si, 1, False);
end;

class function TCoolBands_sw.ToVar(const AValue: TCoolBands): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCoolBands_sw.FromVar(const AValue: OleVariant): TCoolBands;
begin
  Result := TCoolBands(ConvFromVar(AValue, TCoolBands));
end;

class function TCoolBands_sw.ClassToVar(AClass: TCoolBands_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCoolBands_sw.ClassFromVar(
  const AClass: OleVariant): TCoolBands_sc;
begin
  Result := TCoolBands_sc(ConvClsFromVar(AClass, TCoolBands));
end;

{ TCoolBandMaximize_sw }

class function TCoolBandMaximize_sw.GetTypeName: WideString;
begin
  Result := 'TCoolBandMaximize';
end;

class procedure TCoolBandMaximize_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'bmNone'; Value: Integer({$IFDEF LMDSCT_12}TCoolBandMaximize.{$ENDIF}bmNone)),
    (Name: 'bmClick'; Value: Integer({$IFDEF LMDSCT_12}TCoolBandMaximize.{$ENDIF}bmClick)),
    (Name: 'bmDblClick'; Value: Integer({$IFDEF LMDSCT_12}TCoolBandMaximize.{$ENDIF}bmDblClick))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TCoolBandMaximize_sw.ToVar(
  const AValue: TCoolBandMaximize): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCoolBandMaximize_sw.FromVar(
  const AValue: OleVariant): TCoolBandMaximize;
begin
  Result := TCoolBandMaximize(Integer(AValue));
end;

{ TCoolBar_sw }

function TCoolBar_BandBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BandBorderStyle: TBorderStyle read <getter> writ...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCoolBar(AObj).BandBorderStyle)
  else
    TCoolBar(AObj).BandBorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

function TCoolBar_BandMaximize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BandMaximize: TCoolBandMaximize read <getter> wr...

  if IsGet then
    Result := TCoolBandMaximize_sw.ToVar(TCoolBar(AObj).BandMaximize)
  else
    TCoolBar(AObj).BandMaximize := TCoolBandMaximize_sw.FromVar(AArgs[0]);
end;

function TCoolBar_Bands_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bands: TCoolBands read <getter> write <setter>;

  if IsGet then
    Result := TCoolBands_sw.ToVar(TCoolBar(AObj).Bands)
  else
    TCoolBar(AObj).Bands := TCoolBands_sw.FromVar(AArgs[0]);
end;

function TCoolBar_FixedSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedSize: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBar(AObj).FixedSize
  else
    TCoolBar(AObj).FixedSize := Boolean(AArgs[0]);
end;

function TCoolBar_FixedOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedOrder: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBar(AObj).FixedOrder
  else
    TCoolBar(AObj).FixedOrder := Boolean(AArgs[0]);
end;

function TCoolBar_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCoolBar(AObj).Images)
  else
    TCoolBar(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCoolBar_Bitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bitmap: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TCoolBar(AObj).Bitmap)
  else
    TCoolBar(AObj).Bitmap := TBitmap_sw.FromVar(AArgs[0]);
end;

function TCoolBar_ShowText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowText: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBar(AObj).ShowText
  else
    TCoolBar(AObj).ShowText := Boolean(AArgs[0]);
end;

function TCoolBar_Vertical_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Vertical: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCoolBar(AObj).Vertical
  else
    TCoolBar(AObj).Vertical := Boolean(AArgs[0]);
end;

function TCoolBar_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCoolBar(AObj).OnChange)
  else
    TCoolBar(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCoolBar_sw.GetTypeName: WideString;
begin
  Result := 'TCoolBar';
end;

class function TCoolBar_sw.GetWrappedClass: TClass;
begin
  Result := TCoolBar;
end;

class procedure TCoolBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddProperty('BandBorderStyle', TCoolBar_BandBorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddProperty('BandMaximize', TCoolBar_BandMaximize_si, TCoolBandMaximize_sw, True, True, 0, False, False);
  AData.AddProperty('Bands', TCoolBar_Bands_si, TCoolBands_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('EdgeBorders', False);
  AData.AddPropertyRedecl('EdgeInner', False);
  AData.AddPropertyRedecl('EdgeOuter', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('FixedSize', TCoolBar_FixedSize_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FixedOrder', TCoolBar_FixedOrder_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('Images', TCoolBar_Images_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddProperty('Bitmap', TCoolBar_Bitmap_si, TBitmap_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('ShowText', TCoolBar_ShowText_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddProperty('Vertical', TCoolBar_Vertical_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddProperty('OnChange', TCoolBar_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TCoolBar_sw.ToVar(const AValue: TCoolBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCoolBar_sw.FromVar(const AValue: OleVariant): TCoolBar;
begin
  Result := TCoolBar(ConvFromVar(AValue, TCoolBar));
end;

class function TCoolBar_sw.ClassToVar(AClass: TCoolBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCoolBar_sw.ClassFromVar(const AClass: OleVariant): TCoolBar_sc;
begin
  Result := TCoolBar_sc(ConvClsFromVar(AClass, TCoolBar));
end;

{ ECommonCalendarError_sw }

class function ECommonCalendarError_sw.GetTypeName: WideString;
begin
  Result := 'ECommonCalendarError';
end;

class function ECommonCalendarError_sw.GetWrappedClass: TClass;
begin
  Result := ECommonCalendarError;
end;

class procedure ECommonCalendarError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ECommonCalendarError_sw.ToVar(
  const AValue: ECommonCalendarError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ECommonCalendarError_sw.FromVar(
  const AValue: OleVariant): ECommonCalendarError;
begin
  Result := ECommonCalendarError(ConvFromVar(AValue, ECommonCalendarError));
end;

class function ECommonCalendarError_sw.ClassToVar(
  AClass: ECommonCalendarError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ECommonCalendarError_sw.ClassFromVar(
  const AClass: OleVariant): ECommonCalendarError_sc;
begin
  Result := ECommonCalendarError_sc(ConvClsFromVar(AClass, 
    ECommonCalendarError));
end;

{ TMonthCalColors_sw }

function TMonthCalColors_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TCommonCalendar);

  Result := TMonthCalColors_sw.ToVar(TMonthCalColors_sc(AObj).Create(
    TCommonCalendar_sw.FromVar(AArgs[0])));
end;

function TMonthCalColors_BackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BackColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).BackColor)
  else
    TMonthCalColors(AObj).BackColor := TColor_sw.FromVar(AArgs[0]);
end;

function TMonthCalColors_TextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TextColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).TextColor)
  else
    TMonthCalColors(AObj).TextColor := TColor_sw.FromVar(AArgs[0]);
end;

function TMonthCalColors_TitleBackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TitleBackColor: TColor read <getter> write <sett...

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).TitleBackColor)
  else
    TMonthCalColors(AObj).TitleBackColor := TColor_sw.FromVar(AArgs[0]);
end;

function TMonthCalColors_TitleTextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TitleTextColor: TColor read <getter> write <sett...

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).TitleTextColor)
  else
    TMonthCalColors(AObj).TitleTextColor := TColor_sw.FromVar(AArgs[0]);
end;

function TMonthCalColors_MonthBackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MonthBackColor: TColor read <getter> write <sett...

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).MonthBackColor)
  else
    TMonthCalColors(AObj).MonthBackColor := TColor_sw.FromVar(AArgs[0]);
end;

function TMonthCalColors_TrailingTextColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TrailingTextColor: TColor read <getter> write <s...

  if IsGet then
    Result := TColor_sw.ToVar(TMonthCalColors(AObj).TrailingTextColor)
  else
    TMonthCalColors(AObj).TrailingTextColor := TColor_sw.FromVar(AArgs[0]);
end;

class function TMonthCalColors_sw.GetTypeName: WideString;
begin
  Result := 'TMonthCalColors';
end;

class function TMonthCalColors_sw.GetWrappedClass: TClass;
begin
  Result := TMonthCalColors;
end;

class procedure TMonthCalColors_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BackColor', TMonthCalColors_BackColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TextColor', TMonthCalColors_TextColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TitleBackColor', TMonthCalColors_TitleBackColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TitleTextColor', TMonthCalColors_TitleTextColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('MonthBackColor', TMonthCalColors_MonthBackColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('TrailingTextColor', TMonthCalColors_TrailingTextColor_si, TColor_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMonthCalColors_Create_si, 1, False);
end;

class function TMonthCalColors_sw.ToVar(
  const AValue: TMonthCalColors): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMonthCalColors_sw.FromVar(
  const AValue: OleVariant): TMonthCalColors;
begin
  Result := TMonthCalColors(ConvFromVar(AValue, TMonthCalColors));
end;

class function TMonthCalColors_sw.ClassToVar(
  AClass: TMonthCalColors_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMonthCalColors_sw.ClassFromVar(
  const AClass: OleVariant): TMonthCalColors_sc;
begin
  Result := TMonthCalColors_sc(ConvClsFromVar(AClass, TMonthCalColors));
end;

{ TOnGetMonthInfoEvent_sh }

function TOnGetMonthInfoEvent_sh.GetHandler: TMethod;
var
  hdr: TOnGetMonthInfoEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TOnGetMonthInfoEvent_sh.Handler(Sender: TObject; Month: LongWord;
  var MonthBoldInfo: LongWord);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Month: LongWord; var MonthBol...

  v_1 := MonthBoldInfo;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Month;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  MonthBoldInfo := LongWord(v_1);
end;

{ TOnGetMonthInfoEvent_sw }

class function TOnGetMonthInfoEvent_sw.GetTypeName: WideString;
begin
  Result := 'TOnGetMonthInfoEvent';
end;

class function TOnGetMonthInfoEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TOnGetMonthInfoEvent_sh;
end;

class function TOnGetMonthInfoEvent_sw.ToVar(
  const AValue: TOnGetMonthInfoEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TOnGetMonthInfoEvent_sw.FromVar(
  const AValue: OleVariant): TOnGetMonthInfoEvent;
begin
  Result := TOnGetMonthInfoEvent(ConvFromVar(AValue));
end;

class function TOnGetMonthInfoEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TOnGetMonthInfoEvent;
var
  hdlr: TOnGetMonthInfoEvent_sh;
begin
  hdlr   := TOnGetMonthInfoEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TOnGetMonthInfoEvent_sw));
  Result := hdlr.Handler;
end;

{ TOnGetMonthBoldInfoEvent_sh }

function TOnGetMonthBoldInfoEvent_sh.GetHandler: TMethod;
var
  hdr: TOnGetMonthBoldInfoEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TOnGetMonthBoldInfoEvent_sh.Handler(Sender: TObject; Month: LongWord;
  Year: LongWord; var MonthBoldInfo: LongWord);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Month: LongWord; Year: LongWo...

  v_1 := MonthBoldInfo;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Month;
  args[2] := Year;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  MonthBoldInfo := LongWord(v_1);
end;

{ TOnGetMonthBoldInfoEvent_sw }

class function TOnGetMonthBoldInfoEvent_sw.GetTypeName: WideString;
begin
  Result := 'TOnGetMonthBoldInfoEvent';
end;

class function TOnGetMonthBoldInfoEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TOnGetMonthBoldInfoEvent_sh;
end;

class function TOnGetMonthBoldInfoEvent_sw.ToVar(
  const AValue: TOnGetMonthBoldInfoEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TOnGetMonthBoldInfoEvent_sw.FromVar(
  const AValue: OleVariant): TOnGetMonthBoldInfoEvent;
begin
  Result := TOnGetMonthBoldInfoEvent(ConvFromVar(AValue));
end;

class function TOnGetMonthBoldInfoEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TOnGetMonthBoldInfoEvent;
var
  hdlr: TOnGetMonthBoldInfoEvent_sh;
begin
  hdlr   := TOnGetMonthBoldInfoEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TOnGetMonthBoldInfoEvent_sw));
  Result := hdlr.Handler;
end;

{ TCommonCalendar_sw }

function TCommonCalendar_CalExceptionClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CalExceptionClass: ECommonCalExceptCla...

  if IsGet then
    Result := ECommonCalExceptClass_sw.ToVar(TCommonCalendar_sacc(
      TCommonCalendar(AObj)).CalExceptionClass)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).CalExceptionClass := 
      ECommonCalExceptClass_sw.FromVar(AArgs[0]);
end;

function TCommonCalendar_CalColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CalColors: TMonthCalColors read <gette...

  if IsGet then
    Result := TMonthCalColors_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(
      AObj)).CalColors)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).CalColors := TMonthCalColors_sw.
      FromVar(AArgs[0]);
end;

function TCommonCalendar_CalendarHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CalendarHandle: HWND read <getter>;

  Result := HWND_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).
    CalendarHandle);
end;

function TCommonCalendar_Date_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Date: TDate read <getter> write <setter>;

  if IsGet then
    Result := TDate_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).Date)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).Date := TDate_sw.FromVar(
      AArgs[0]);
end;

function TCommonCalendar_DateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DateTime: TDateTime read <getter> writ...

  if IsGet then
    Result := TDateTime_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).
      DateTime)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).DateTime := TDateTime_sw.
      FromVar(AArgs[0]);
end;

function TCommonCalendar_EndDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property EndDate: TDate read <getter> write <se...

  if IsGet then
    Result := TDate_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).
      EndDate)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).EndDate := TDate_sw.FromVar(
      AArgs[0]);
end;

function TCommonCalendar_FirstDayOfWeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FirstDayOfWeek: TCalDayOfWeek read <ge...

  if IsGet then
    Result := TCalDayOfWeek_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(
      AObj)).FirstDayOfWeek)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).FirstDayOfWeek := 
      TCalDayOfWeek_sw.FromVar(AArgs[0]);
end;

function TCommonCalendar_MaxDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MaxDate: TDate read <getter> write <se...

  if IsGet then
    Result := TDate_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).
      MaxDate)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).MaxDate := TDate_sw.FromVar(
      AArgs[0]);
end;

function TCommonCalendar_MaxSelectRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MaxSelectRange: Integer read <getter> ...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).MaxSelectRange
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).MaxSelectRange := Integer(
      AArgs[0]);
end;

function TCommonCalendar_MinDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MinDate: TDate read <getter> write <se...

  if IsGet then
    Result := TDate_sw.ToVar(TCommonCalendar_sacc(TCommonCalendar(AObj)).
      MinDate)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).MinDate := TDate_sw.FromVar(
      AArgs[0]);
end;

function TCommonCalendar_MonthDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MonthDelta: Integer read <getter> writ...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).MonthDelta
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).MonthDelta := Integer(AArgs[0]);
end;

function TCommonCalendar_MultiSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MultiSelect: Boolean read <getter> wri...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).MultiSelect
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).MultiSelect := Boolean(
      AArgs[0]);
end;

function TCommonCalendar_ShowToday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowToday: Boolean read <getter> write...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).ShowToday
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).ShowToday := Boolean(AArgs[0]);
end;

function TCommonCalendar_ShowTodayCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ShowTodayCircle: Boolean read <getter>...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).ShowTodayCircle
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).ShowTodayCircle := Boolean(
      AArgs[0]);
end;

function TCommonCalendar_WeekNumbers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WeekNumbers: Boolean read <getter> wri...

  if IsGet then
    Result := TCommonCalendar_sacc(TCommonCalendar(AObj)).WeekNumbers
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).WeekNumbers := Boolean(
      AArgs[0]);
end;

function TCommonCalendar_OnGetMonthInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetMonthInfo: TOnGetMonthInfoEvent r...

  if IsGet then
    Result := TOnGetMonthInfoEvent_sw.ToVar(TCommonCalendar_sacc(
      TCommonCalendar(AObj)).OnGetMonthInfo)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).OnGetMonthInfo := 
      TOnGetMonthInfoEvent_sw.FromVar(AArgs[0]);
end;

function TCommonCalendar_OnGetMonthBoldInfo_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetMonthBoldInfo: TOnGetMonthBoldInf...

  if IsGet then
    Result := TOnGetMonthBoldInfoEvent_sw.ToVar(TCommonCalendar_sacc(
      TCommonCalendar(AObj)).OnGetMonthBoldInfo)
  else
    TCommonCalendar_sacc(TCommonCalendar(AObj)).OnGetMonthBoldInfo := 
      TOnGetMonthBoldInfoEvent_sw.FromVar(AArgs[0]);
end;

class function TCommonCalendar_sw.GetTypeName: WideString;
begin
  Result := 'TCommonCalendar';
end;

class function TCommonCalendar_sw.GetWrappedClass: TClass;
begin
  Result := TCommonCalendar;
end;

class procedure TCommonCalendar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('CalExceptionClass', TCommonCalendar_CalExceptionClass_si, ECommonCalExceptClass_sw, True, True, 0, True, False);
  AData.AddProperty('CalColors', TCommonCalendar_CalColors_si, TMonthCalColors_sw, True, True, 0, True, False);
  AData.AddProperty('CalendarHandle', TCommonCalendar_CalendarHandle_si, HWND_sw, True, False, 0, True, False);
  AData.AddProperty('Date', TCommonCalendar_Date_si, TDate_sw, True, True, 0, True, False);
  AData.AddProperty('DateTime', TCommonCalendar_DateTime_si, TDateTime_sw, True, True, 0, True, False);
  AData.AddProperty('EndDate', TCommonCalendar_EndDate_si, TDate_sw, True, True, 0, True, False);
  AData.AddProperty('FirstDayOfWeek', TCommonCalendar_FirstDayOfWeek_si, TCalDayOfWeek_sw, True, True, 0, True, False);
  AData.AddProperty('MaxDate', TCommonCalendar_MaxDate_si, TDate_sw, True, True, 0, True, False);
  AData.AddProperty('MaxSelectRange', TCommonCalendar_MaxSelectRange_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('MinDate', TCommonCalendar_MinDate_si, TDate_sw, True, True, 0, True, False);
  AData.AddProperty('MonthDelta', TCommonCalendar_MonthDelta_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('MultiSelect', TCommonCalendar_MultiSelect_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowToday', TCommonCalendar_ShowToday_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ShowTodayCircle', TCommonCalendar_ShowTodayCircle_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('WeekNumbers', TCommonCalendar_WeekNumbers_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetMonthInfo', TCommonCalendar_OnGetMonthInfo_si, TOnGetMonthInfoEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetMonthBoldInfo', TCommonCalendar_OnGetMonthBoldInfo_si, TOnGetMonthBoldInfoEvent_sw, True, True, 0, True, False);
end;

class function TCommonCalendar_sw.ToVar(
  const AValue: TCommonCalendar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCommonCalendar_sw.FromVar(
  const AValue: OleVariant): TCommonCalendar;
begin
  Result := TCommonCalendar(ConvFromVar(AValue, TCommonCalendar));
end;

class function TCommonCalendar_sw.ClassToVar(
  AClass: TCommonCalendar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCommonCalendar_sw.ClassFromVar(
  const AClass: OleVariant): TCommonCalendar_sc;
begin
  Result := TCommonCalendar_sc(ConvClsFromVar(AClass, TCommonCalendar));
end;

{ EMonthCalError_sw }

class function EMonthCalError_sw.GetTypeName: WideString;
begin
  Result := 'EMonthCalError';
end;

class function EMonthCalError_sw.GetWrappedClass: TClass;
begin
  Result := EMonthCalError;
end;

class procedure EMonthCalError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EMonthCalError_sw.ToVar(
  const AValue: EMonthCalError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EMonthCalError_sw.FromVar(
  const AValue: OleVariant): EMonthCalError;
begin
  Result := EMonthCalError(ConvFromVar(AValue, EMonthCalError));
end;

class function EMonthCalError_sw.ClassToVar(
  AClass: EMonthCalError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EMonthCalError_sw.ClassFromVar(
  const AClass: OleVariant): EMonthCalError_sc;
begin
  Result := EMonthCalError_sc(ConvClsFromVar(AClass, EMonthCalError));
end;

{ TMonthCalendar_sw }

class function TMonthCalendar_sw.GetTypeName: WideString;
begin
  Result := 'TMonthCalendar';
end;

class function TMonthCalendar_sw.GetWrappedClass: TClass;
begin
  Result := TMonthCalendar;
end;

class procedure TMonthCalendar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('CalColors', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('MultiSelect', False);
  AData.AddPropertyRedecl('Date', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('EndDate', False);
  AData.AddPropertyRedecl('FirstDayOfWeek', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxDate', False);
  AData.AddPropertyRedecl('MaxSelectRange', False);
  AData.AddPropertyRedecl('MinDate', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('ShowToday', False);
  AData.AddPropertyRedecl('ShowTodayCircle', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WeekNumbers', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetMonthInfo', False);
  AData.AddPropertyRedecl('OnGetMonthBoldInfo', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TMonthCalendar_sw.ToVar(
  const AValue: TMonthCalendar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMonthCalendar_sw.FromVar(
  const AValue: OleVariant): TMonthCalendar;
begin
  Result := TMonthCalendar(ConvFromVar(AValue, TMonthCalendar));
end;

class function TMonthCalendar_sw.ClassToVar(
  AClass: TMonthCalendar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMonthCalendar_sw.ClassFromVar(
  const AClass: OleVariant): TMonthCalendar_sc;
begin
  Result := TMonthCalendar_sc(ConvClsFromVar(AClass, TMonthCalendar));
end;

{ EDateTimeError_sw }

class function EDateTimeError_sw.GetTypeName: WideString;
begin
  Result := 'EDateTimeError';
end;

class function EDateTimeError_sw.GetWrappedClass: TClass;
begin
  Result := EDateTimeError;
end;

class procedure EDateTimeError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EDateTimeError_sw.ToVar(
  const AValue: EDateTimeError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDateTimeError_sw.FromVar(
  const AValue: OleVariant): EDateTimeError;
begin
  Result := EDateTimeError(ConvFromVar(AValue, EDateTimeError));
end;

class function EDateTimeError_sw.ClassToVar(
  AClass: EDateTimeError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDateTimeError_sw.ClassFromVar(
  const AClass: OleVariant): EDateTimeError_sc;
begin
  Result := EDateTimeError_sc(ConvClsFromVar(AClass, EDateTimeError));
end;

{ TDateTimeKind_sw }

class function TDateTimeKind_sw.GetTypeName: WideString;
begin
  Result := 'TDateTimeKind';
end;

class procedure TDateTimeKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dtkDate'; Value: Integer({$IFDEF LMDSCT_12}TDateTimeKind.{$ENDIF}dtkDate)),
    (Name: 'dtkTime'; Value: Integer({$IFDEF LMDSCT_12}TDateTimeKind.{$ENDIF}dtkTime))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDateTimeKind_sw.ToVar(const AValue: TDateTimeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDateTimeKind_sw.FromVar(
  const AValue: OleVariant): TDateTimeKind;
begin
  Result := TDateTimeKind(Integer(AValue));
end;

{ TDTDateMode_sw }

class function TDTDateMode_sw.GetTypeName: WideString;
begin
  Result := 'TDTDateMode';
end;

class procedure TDTDateMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dmComboBox'; Value: Integer({$IFDEF LMDSCT_12}TDTDateMode.{$ENDIF}dmComboBox)),
    (Name: 'dmUpDown'; Value: Integer({$IFDEF LMDSCT_12}TDTDateMode.{$ENDIF}dmUpDown))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDTDateMode_sw.ToVar(const AValue: TDTDateMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDTDateMode_sw.FromVar(const AValue: OleVariant): TDTDateMode;
begin
  Result := TDTDateMode(Integer(AValue));
end;

{ TDTDateFormat_sw }

class function TDTDateFormat_sw.GetTypeName: WideString;
begin
  Result := 'TDTDateFormat';
end;

class procedure TDTDateFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dfShort'; Value: Integer({$IFDEF LMDSCT_12}TDTDateFormat.{$ENDIF}dfShort)),
    (Name: 'dfLong'; Value: Integer({$IFDEF LMDSCT_12}TDTDateFormat.{$ENDIF}dfLong))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDTDateFormat_sw.ToVar(const AValue: TDTDateFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDTDateFormat_sw.FromVar(
  const AValue: OleVariant): TDTDateFormat;
begin
  Result := TDTDateFormat(Integer(AValue));
end;

{ TDTCalAlignment_sw }

class function TDTCalAlignment_sw.GetTypeName: WideString;
begin
  Result := 'TDTCalAlignment';
end;

class procedure TDTCalAlignment_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dtaLeft'; Value: Integer({$IFDEF LMDSCT_12}TDTCalAlignment.{$ENDIF}dtaLeft)),
    (Name: 'dtaRight'; Value: Integer({$IFDEF LMDSCT_12}TDTCalAlignment.{$ENDIF}dtaRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDTCalAlignment_sw.ToVar(
  const AValue: TDTCalAlignment): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDTCalAlignment_sw.FromVar(
  const AValue: OleVariant): TDTCalAlignment;
begin
  Result := TDTCalAlignment(Integer(AValue));
end;

{ TDTParseInputEvent_sh }

function TDTParseInputEvent_sh.GetHandler: TMethod;
var
  hdr: TDTParseInputEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDTParseInputEvent_sh.Handler(Sender: TObject;
  const UserString: string; var DateAndTime: TDateTime;
  var AllowChange: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Sender: TObject; const UserString: string; var...

  v_1 := TDateTime_sw.ToVar(DateAndTime);
  v_2 := AllowChange;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := UserString;
  args[2] := MakeVarRef(v_1);
  args[3] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  DateAndTime := TDateTime_sw.FromVar(v_1);
  AllowChange := Boolean(v_2);
end;

{ TDTParseInputEvent_sw }

class function TDTParseInputEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDTParseInputEvent';
end;

class function TDTParseInputEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDTParseInputEvent_sh;
end;

class function TDTParseInputEvent_sw.ToVar(
  const AValue: TDTParseInputEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDTParseInputEvent_sw.FromVar(
  const AValue: OleVariant): TDTParseInputEvent;
begin
  Result := TDTParseInputEvent(ConvFromVar(AValue));
end;

class function TDTParseInputEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TDTParseInputEvent;
var
  hdlr: TDTParseInputEvent_sh;
begin
  hdlr   := TDTParseInputEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDTParseInputEvent_sw));
  Result := hdlr.Handler;
end;

{ TDateTimePicker_sw }

function TDateTimePicker_DroppedDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DroppedDown: Boolean read <getter>;

  Result := TDateTimePicker(AObj).DroppedDown;
end;

function TDateTimePicker_CalAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CalAlignment: TDTCalAlignment read <getter> writ...

  if IsGet then
    Result := TDTCalAlignment_sw.ToVar(TDateTimePicker(AObj).CalAlignment)
  else
    TDateTimePicker(AObj).CalAlignment := TDTCalAlignment_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_Format_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Format: string read <getter> write <setter>;

  if IsGet then
    Result := TDateTimePicker(AObj).Format
  else
    TDateTimePicker(AObj).Format := string(AArgs[0]);
end;

function TDateTimePicker_Time_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Time: TTime read <getter> write <setter>;

  if IsGet then
    Result := TTime_sw.ToVar(TDateTimePicker(AObj).Time)
  else
    TDateTimePicker(AObj).Time := TTime_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_ShowCheckbox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowCheckbox: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDateTimePicker(AObj).ShowCheckbox
  else
    TDateTimePicker(AObj).ShowCheckbox := Boolean(AArgs[0]);
end;

function TDateTimePicker_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDateTimePicker(AObj).Checked
  else
    TDateTimePicker(AObj).Checked := Boolean(AArgs[0]);
end;

function TDateTimePicker_DateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DateFormat: TDTDateFormat read <getter> write <s...

  if IsGet then
    Result := TDTDateFormat_sw.ToVar(TDateTimePicker(AObj).DateFormat)
  else
    TDateTimePicker(AObj).DateFormat := TDTDateFormat_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_DateMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DateMode: TDTDateMode read <getter> write <setter>;

  if IsGet then
    Result := TDTDateMode_sw.ToVar(TDateTimePicker(AObj).DateMode)
  else
    TDateTimePicker(AObj).DateMode := TDTDateMode_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_Kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Kind: TDateTimeKind read <getter> write <setter>;

  if IsGet then
    Result := TDateTimeKind_sw.ToVar(TDateTimePicker(AObj).Kind)
  else
    TDateTimePicker(AObj).Kind := TDateTimeKind_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_ParseInput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParseInput: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDateTimePicker(AObj).ParseInput
  else
    TDateTimePicker(AObj).ParseInput := Boolean(AArgs[0]);
end;

function TDateTimePicker_OnCloseUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCloseUp: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDateTimePicker(AObj).OnCloseUp)
  else
    TDateTimePicker(AObj).OnCloseUp := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDateTimePicker(AObj).OnChange)
  else
    TDateTimePicker(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_OnDropDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDropDown: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDateTimePicker(AObj).OnDropDown)
  else
    TDateTimePicker(AObj).OnDropDown := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDateTimePicker_OnUserInput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUserInput: TDTParseInputEvent read <getter> wr...

  if IsGet then
    Result := TDTParseInputEvent_sw.ToVar(TDateTimePicker(AObj).OnUserInput)
  else
    TDateTimePicker(AObj).OnUserInput := TDTParseInputEvent_sw.FromVar(
      AArgs[0]);
end;

class function TDateTimePicker_sw.GetTypeName: WideString;
begin
  Result := 'TDateTimePicker';
end;

class function TDateTimePicker_sw.GetWrappedClass: TClass;
begin
  Result := TDateTimePicker;
end;

class procedure TDateTimePicker_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('DateTime', False);
  AData.AddProperty('DroppedDown', TDateTimePicker_DroppedDown_si, Boolean_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddProperty('CalAlignment', TDateTimePicker_CalAlignment_si, TDTCalAlignment_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('CalColors', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Date', False);
  AData.AddProperty('Format', TDateTimePicker_Format_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Time', TDateTimePicker_Time_si, TTime_sw, True, True, 0, False, False);
  AData.AddProperty('ShowCheckbox', TDateTimePicker_ShowCheckbox_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Checked', TDateTimePicker_Checked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddProperty('DateFormat', TDateTimePicker_DateFormat_si, TDTDateFormat_sw, True, True, 0, False, False);
  AData.AddProperty('DateMode', TDateTimePicker_DateMode_si, TDTDateMode_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddProperty('Kind', TDateTimePicker_Kind_si, TDateTimeKind_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('MaxDate', False);
  AData.AddPropertyRedecl('MinDate', False);
  AData.AddProperty('ParseInput', TDateTimePicker_ParseInput_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddProperty('OnCloseUp', TDateTimePicker_OnCloseUp_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TDateTimePicker_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddProperty('OnDropDown', TDateTimePicker_OnDropDown_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddProperty('OnUserInput', TDateTimePicker_OnUserInput_si, TDTParseInputEvent_sw, True, True, 0, False, False);
end;

class function TDateTimePicker_sw.ToVar(
  const AValue: TDateTimePicker): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDateTimePicker_sw.FromVar(
  const AValue: OleVariant): TDateTimePicker;
begin
  Result := TDateTimePicker(ConvFromVar(AValue, TDateTimePicker));
end;

class function TDateTimePicker_sw.ClassToVar(
  AClass: TDateTimePicker_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDateTimePicker_sw.ClassFromVar(
  const AClass: OleVariant): TDateTimePicker_sc;
begin
  Result := TDateTimePicker_sc(ConvClsFromVar(AClass, TDateTimePicker));
end;

{ TPageScrollerOrientation_sw }

class function TPageScrollerOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TPageScrollerOrientation';
end;

class procedure TPageScrollerOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'soHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerOrientation.{$ENDIF}soHorizontal)),
    (Name: 'soVertical'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerOrientation.{$ENDIF}soVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPageScrollerOrientation_sw.ToVar(
  const AValue: TPageScrollerOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageScrollerOrientation_sw.FromVar(
  const AValue: OleVariant): TPageScrollerOrientation;
begin
  Result := TPageScrollerOrientation(Integer(AValue));
end;

{ TPageScrollerButton_sw }

class function TPageScrollerButton_sw.GetTypeName: WideString;
begin
  Result := 'TPageScrollerButton';
end;

class procedure TPageScrollerButton_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'sbFirst'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButton.{$ENDIF}sbFirst)),
    (Name: 'sbLast'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButton.{$ENDIF}sbLast))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPageScrollerButton_sw.ToVar(
  const AValue: TPageScrollerButton): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageScrollerButton_sw.FromVar(
  const AValue: OleVariant): TPageScrollerButton;
begin
  Result := TPageScrollerButton(Integer(AValue));
end;

{ TPageScrollerButtonState_sw }

class function TPageScrollerButtonState_sw.GetTypeName: WideString;
begin
  Result := 'TPageScrollerButtonState';
end;

class procedure TPageScrollerButtonState_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'bsNormal'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButtonState.{$ENDIF}bsNormal)),
    (Name: 'bsInvisible'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButtonState.{$ENDIF}bsInvisible)),
    (Name: 'bsGrayed'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButtonState.{$ENDIF}bsGrayed)),
    (Name: 'bsDepressed'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButtonState.{$ENDIF}bsDepressed)),
    (Name: 'bsHot'; Value: Integer({$IFDEF LMDSCT_12}TPageScrollerButtonState.{$ENDIF}bsHot))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TPageScrollerButtonState_sw.ToVar(
  const AValue: TPageScrollerButtonState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageScrollerButtonState_sw.FromVar(
  const AValue: OleVariant): TPageScrollerButtonState;
begin
  Result := TPageScrollerButtonState(Integer(AValue));
end;

{ TPageScroller_sw }

function TPageScroller_GetButtonState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetButtonState(Button: TPageScrollerButton): TPa...

  Result := TPageScrollerButtonState_sw.ToVar(TPageScroller(AObj).
    GetButtonState(TPageScrollerButton_sw.FromVar(AArgs[0])));
end;

function TPageScroller_AutoScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoScroll: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPageScroller(AObj).AutoScroll
  else
    TPageScroller(AObj).AutoScroll := Boolean(AArgs[0]);
end;

function TPageScroller_ButtonSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageScroller(AObj).ButtonSize
  else
    TPageScroller(AObj).ButtonSize := Integer(AArgs[0]);
end;

function TPageScroller_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TWinControl read <getter> write <setter>;

  if IsGet then
    Result := TWinControl_sw.ToVar(TPageScroller(AObj).Control)
  else
    TPageScroller(AObj).Control := TWinControl_sw.FromVar(AArgs[0]);
end;

function TPageScroller_DragScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragScroll: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPageScroller(AObj).DragScroll
  else
    TPageScroller(AObj).DragScroll := Boolean(AArgs[0]);
end;

function TPageScroller_Margin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageScroller(AObj).Margin
  else
    TPageScroller(AObj).Margin := Integer(AArgs[0]);
end;

function TPageScroller_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TPageScrollerOrientation read <gett...

  if IsGet then
    Result := TPageScrollerOrientation_sw.ToVar(TPageScroller(AObj).Orientation)
  else
    TPageScroller(AObj).Orientation := TPageScrollerOrientation_sw.FromVar(
      AArgs[0]);
end;

function TPageScroller_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageScroller(AObj).Position
  else
    TPageScroller(AObj).Position := Integer(AArgs[0]);
end;

class function TPageScroller_sw.GetTypeName: WideString;
begin
  Result := 'TPageScroller';
end;

class function TPageScroller_sw.GetWrappedClass: TClass;
begin
  Result := TPageScroller;
end;

class procedure TPageScroller_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetButtonState', TPageScroller_GetButtonState_si, TPageScrollerButtonState_sw, 1, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('AutoScroll', TPageScroller_AutoScroll_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddProperty('ButtonSize', TPageScroller_ButtonSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('Control', TPageScroller_Control_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DragScroll', TPageScroller_DragScroll_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('Margin', TPageScroller_Margin_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Orientation', TPageScroller_Orientation_si, TPageScrollerOrientation_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Position', TPageScroller_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
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
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TPageScroller_sw.ToVar(const AValue: TPageScroller): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPageScroller_sw.FromVar(
  const AValue: OleVariant): TPageScroller;
begin
  Result := TPageScroller(ConvFromVar(AValue, TPageScroller));
end;

class function TPageScroller_sw.ClassToVar(
  AClass: TPageScroller_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPageScroller_sw.ClassFromVar(
  const AClass: OleVariant): TPageScroller_sc;
begin
  Result := TPageScroller_sc(ConvClsFromVar(AClass, TPageScroller));
end;

{ TComboExItem_sw }

function TComboExItem_Indent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Indent: Integer read <getter> write <setter>;

  if IsGet then
    Result := TComboExItem(AObj).Indent
  else
    TComboExItem(AObj).Indent := Integer(AArgs[0]);
end;

function TComboExItem_OverlayImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OverlayImageIndex: TImageIndex read <getter> wri...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TComboExItem(AObj).OverlayImageIndex)
  else
    TComboExItem(AObj).OverlayImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TComboExItem_SelectedImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedImageIndex: TImageIndex read <getter> wr...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TComboExItem(AObj).SelectedImageIndex)
  else
    TComboExItem(AObj).SelectedImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

class function TComboExItem_sw.GetTypeName: WideString;
begin
  Result := 'TComboExItem';
end;

class function TComboExItem_sw.GetWrappedClass: TClass;
begin
  Result := TComboExItem;
end;

class procedure TComboExItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Indent', TComboExItem_Indent_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('OverlayImageIndex', TComboExItem_OverlayImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('SelectedImageIndex', TComboExItem_SelectedImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
end;

class function TComboExItem_sw.ToVar(const AValue: TComboExItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboExItem_sw.FromVar(const AValue: OleVariant): TComboExItem;
begin
  Result := TComboExItem(ConvFromVar(AValue, TComboExItem));
end;

class function TComboExItem_sw.ClassToVar(AClass: TComboExItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboExItem_sw.ClassFromVar(
  const AClass: OleVariant): TComboExItem_sc;
begin
  Result := TComboExItem_sc(ConvClsFromVar(AClass, TComboExItem));
end;

{ TComboExItems_sw }

function TComboExItems_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TComboExItem;

  Result := TComboExItem_sw.ToVar(TComboExItems(AObj).Add());
end;

function TComboExItems_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): TComboExItem;

  Result := TComboExItem_sw.ToVar(TComboExItems(AObj).Insert(Integer(
    AArgs[0])));
end;

function TComboExItems_ComboItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ComboItems[const Index: Integer]: TComboExItem r...

  Result := TComboExItem_sw.ToVar(TComboExItems(AObj).ComboItems[Integer(
    AArgs[0])]);
end;

class function TComboExItems_sw.GetTypeName: WideString;
begin
  Result := 'TComboExItems';
end;

class function TComboExItems_sw.GetWrappedClass: TClass;
begin
  Result := TComboExItems;
end;

class procedure TComboExItems_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TComboExItems_Add_si, TComboExItem_sw, 0, False);
  AData.AddFunction('Insert', TComboExItems_Insert_si, TComboExItem_sw, 1, False);
  AData.AddProperty('ComboItems', TComboExItems_ComboItems_si, TComboExItem_sw, True, False, 1, False, False);
end;

class function TComboExItems_sw.ToVar(const AValue: TComboExItems): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboExItems_sw.FromVar(
  const AValue: OleVariant): TComboExItems;
begin
  Result := TComboExItems(ConvFromVar(AValue, TComboExItems));
end;

class function TComboExItems_sw.ClassToVar(
  AClass: TComboExItems_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboExItems_sw.ClassFromVar(
  const AClass: OleVariant): TComboExItems_sc;
begin
  Result := TComboExItems_sc(ConvClsFromVar(AClass, TComboExItems));
end;

{ TComboExItemsClass_sw }

class function TComboExItemsClass_sw.GetTypeName: WideString;
begin
  Result := 'TComboExItemsClass';
end;

class function TComboExItemsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TComboExItems;
end;

class function TComboExItemsClass_sw.ToVar(
  const AValue: TComboExItemsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboExItemsClass_sw.FromVar(
  const AValue: OleVariant): TComboExItemsClass;
begin
  Result := TComboExItemsClass(ConvFromVar(AValue, TComboExItems));
end;

{ TComboExItemClass_sw }

class function TComboExItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TComboExItemClass';
end;

class function TComboExItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TComboExItem;
end;

class function TComboExItemClass_sw.ToVar(
  const AValue: TComboExItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboExItemClass_sw.FromVar(
  const AValue: OleVariant): TComboExItemClass;
begin
  Result := TComboExItemClass(ConvFromVar(AValue, TComboExItem));
end;

{ TComboBoxExStrings_sw }

function TComboBoxExStrings_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Owner: TCustomComboBoxEx);

  Result := TComboBoxExStrings_sw.ToVar(TComboBoxExStrings_sc(AObj).Create(
    TCustomComboBoxEx_sw.FromVar(AArgs[0])));
end;

function TComboBoxExStrings_SortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SortType: TListItemsSortType read <getter> write...

  if IsGet then
    Result := TListItemsSortType_sw.ToVar(TComboBoxExStrings(AObj).SortType)
  else
    TComboBoxExStrings(AObj).SortType := TListItemsSortType_sw.FromVar(
      AArgs[0]);
end;

function TComboBoxExStrings_ItemsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemsEx: TComboExItems read <getter> write <sett...

  if IsGet then
    Result := TComboExItems_sw.ToVar(TComboBoxExStrings(AObj).ItemsEx)
  else
    TComboBoxExStrings(AObj).ItemsEx := TComboExItems_sw.FromVar(AArgs[0]);
end;

class function TComboBoxExStrings_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExStrings';
end;

class function TComboBoxExStrings_sw.GetWrappedClass: TClass;
begin
  Result := TComboBoxExStrings;
end;

class procedure TComboBoxExStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('SortType', TComboBoxExStrings_SortType_si, TListItemsSortType_sw, True, True, 0, False, False);
  AData.AddProperty('ItemsEx', TComboBoxExStrings_ItemsEx_si, TComboExItems_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TComboBoxExStrings_Create_si, 1, False);
end;

class function TComboBoxExStrings_sw.ToVar(
  const AValue: TComboBoxExStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboBoxExStrings_sw.FromVar(
  const AValue: OleVariant): TComboBoxExStrings;
begin
  Result := TComboBoxExStrings(ConvFromVar(AValue, TComboBoxExStrings));
end;

class function TComboBoxExStrings_sw.ClassToVar(
  AClass: TComboBoxExStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboBoxExStrings_sw.ClassFromVar(
  const AClass: OleVariant): TComboBoxExStrings_sc;
begin
  Result := TComboBoxExStrings_sc(ConvClsFromVar(AClass, TComboBoxExStrings));
end;

{ TComboBoxExStringsClass_sw }

class function TComboBoxExStringsClass_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExStringsClass';
end;

class function TComboBoxExStringsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TComboBoxExStrings;
end;

class function TComboBoxExStringsClass_sw.ToVar(
  const AValue: TComboBoxExStringsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboBoxExStringsClass_sw.FromVar(
  const AValue: OleVariant): TComboBoxExStringsClass;
begin
  Result := TComboBoxExStringsClass(ConvFromVar(AValue, TComboBoxExStrings));
end;

{ TComboBoxExStyle_sw }

class function TComboBoxExStyle_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExStyle';
end;

class procedure TComboBoxExStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'csExDropDown'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyle.{$ENDIF}csExDropDown)),
    (Name: 'csExSimple'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyle.{$ENDIF}csExSimple)),
    (Name: 'csExDropDownList'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyle.{$ENDIF}csExDropDownList))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TComboBoxExStyle_sw.ToVar(
  const AValue: TComboBoxExStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TComboBoxExStyle_sw.FromVar(
  const AValue: OleVariant): TComboBoxExStyle;
begin
  Result := TComboBoxExStyle(Integer(AValue));
end;

{ TComboBoxExStyleEx_sw }

class function TComboBoxExStyleEx_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExStyleEx';
end;

class procedure TComboBoxExStyleEx_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'csExCaseSensitive'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyleEx.{$ENDIF}csExCaseSensitive)),
    (Name: 'csExNoEditImage'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyleEx.{$ENDIF}csExNoEditImage)),
    (Name: 'csExNoEditImageIndent'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyleEx.{$ENDIF}csExNoEditImageIndent)),
    (Name: 'csExNoSizeLimit'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyleEx.{$ENDIF}csExNoSizeLimit)),
    (Name: 'csExPathWordBreak'; Value: Integer({$IFDEF LMDSCT_12}TComboBoxExStyleEx.{$ENDIF}csExPathWordBreak))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TComboBoxExStyleEx_sw.ToVar(
  const AValue: TComboBoxExStyleEx): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TComboBoxExStyleEx_sw.FromVar(
  const AValue: OleVariant): TComboBoxExStyleEx;
begin
  Result := TComboBoxExStyleEx(Integer(AValue));
end;

{ TComboBoxExStyles_sw }

class function TComboBoxExStyles_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExStyles';
end;

class function TComboBoxExStyles_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TComboBoxExStyles);
end;

class function TComboBoxExStyles_sw.ToVar(
  const AValue: TComboBoxExStyles): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TComboBoxExStyles_sw.FromVar(
  const AValue: OleVariant): TComboBoxExStyles;
begin
  ConvFromVar(AValue, @Result);
end;

{ TAutoCompleteOption_sw }

class function TAutoCompleteOption_sw.GetTypeName: WideString;
begin
  Result := 'TAutoCompleteOption';
end;

class procedure TAutoCompleteOption_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'acoAutoSuggest'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoAutoSuggest)),
    (Name: 'acoAutoAppend'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoAutoAppend)),
    (Name: 'acoSearch'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoSearch)),
    (Name: 'acoFilterPrefixes'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoFilterPrefixes)),
    (Name: 'acoUseTab'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoUseTab)),
    (Name: 'acoUpDownKeyDropsList'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoUpDownKeyDropsList)),
    (Name: 'acoRtlReading'; Value: Integer({$IFDEF LMDSCT_12}TAutoCompleteOption.{$ENDIF}acoRtlReading))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TAutoCompleteOption_sw.ToVar(
  const AValue: TAutoCompleteOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAutoCompleteOption_sw.FromVar(
  const AValue: OleVariant): TAutoCompleteOption;
begin
  Result := TAutoCompleteOption(Integer(AValue));
end;

{ TAutoCompleteOptions_sw }

class function TAutoCompleteOptions_sw.GetTypeName: WideString;
begin
  Result := 'TAutoCompleteOptions';
end;

class function TAutoCompleteOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TAutoCompleteOptions);
end;

class function TAutoCompleteOptions_sw.ToVar(
  const AValue: TAutoCompleteOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TAutoCompleteOptions_sw.FromVar(
  const AValue: OleVariant): TAutoCompleteOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCustomComboBoxEx_sw }

function TCustomComboBoxEx_AutoCompleteOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCompleteOptions: TAutoCompleteOptions read <...

  if IsGet then
    Result := TAutoCompleteOptions_sw.ToVar(TCustomComboBoxEx(AObj).
      AutoCompleteOptions)
  else
    TCustomComboBoxEx(AObj).AutoCompleteOptions := TAutoCompleteOptions_sw.
      FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_DropDownCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownCount: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomComboBoxEx(AObj).DropDownCount
  else
    TCustomComboBoxEx(AObj).DropDownCount := Integer(AArgs[0]);
end;

function TCustomComboBoxEx_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TCustomComboBoxEx(AObj).Images)
  else
    TCustomComboBoxEx(AObj).Images := TCustomImageList_sw.FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_ItemsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemsEx: TComboExItems read <getter> write <sett...

  if IsGet then
    Result := TComboExItems_sw.ToVar(TCustomComboBoxEx(AObj).ItemsEx)
  else
    TCustomComboBoxEx(AObj).ItemsEx := TComboExItems_sw.FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_SelText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomComboBoxEx(AObj).SelText
  else
    TCustomComboBoxEx(AObj).SelText := string(AArgs[0]);
end;

function TCustomComboBoxEx_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TComboBoxExStyle read <getter> write <set...

  if IsGet then
    Result := TComboBoxExStyle_sw.ToVar(TCustomComboBoxEx(AObj).Style)
  else
    TCustomComboBoxEx(AObj).Style := TComboBoxExStyle_sw.FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_StyleEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StyleEx: TComboBoxExStyles read <getter> write <...

  if IsGet then
    Result := TComboBoxExStyles_sw.ToVar(TCustomComboBoxEx(AObj).StyleEx)
  else
    TCustomComboBoxEx(AObj).StyleEx := TComboBoxExStyles_sw.FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_OnBeginEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnBeginEdit: TNotifyEvent read <getter> write <s...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomComboBoxEx(AObj).OnBeginEdit)
  else
    TCustomComboBoxEx(AObj).OnBeginEdit := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomComboBoxEx_OnEndEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEndEdit: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomComboBoxEx(AObj).OnEndEdit)
  else
    TCustomComboBoxEx(AObj).OnEndEdit := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomComboBoxEx_sw.GetTypeName: WideString;
begin
  Result := 'TCustomComboBoxEx';
end;

class function TCustomComboBoxEx_sw.GetWrappedClass: TClass;
begin
  Result := TCustomComboBoxEx;
end;

class procedure TCustomComboBoxEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoCompleteOptions', TCustomComboBoxEx_AutoCompleteOptions_si, TAutoCompleteOptions_sw, True, True, 0, False, False);
  AData.AddProperty('DropDownCount', TCustomComboBoxEx_DropDownCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Images', TCustomComboBoxEx_Images_si, TCustomImageList_sw, True, True, 0, False, False);
  AData.AddProperty('ItemsEx', TCustomComboBoxEx_ItemsEx_si, TComboExItems_sw, True, True, 0, False, False);
  AData.AddProperty('SelText', TCustomComboBoxEx_SelText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TCustomComboBoxEx_Style_si, TComboBoxExStyle_sw, True, True, 0, False, False);
  AData.AddProperty('StyleEx', TCustomComboBoxEx_StyleEx_si, TComboBoxExStyles_sw, True, True, 0, False, False);
  AData.AddProperty('OnBeginEdit', TCustomComboBoxEx_OnBeginEdit_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnEndEdit', TCustomComboBoxEx_OnEndEdit_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomComboBoxEx_sw.ToVar(
  const AValue: TCustomComboBoxEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomComboBoxEx_sw.FromVar(
  const AValue: OleVariant): TCustomComboBoxEx;
begin
  Result := TCustomComboBoxEx(ConvFromVar(AValue, TCustomComboBoxEx));
end;

class function TCustomComboBoxEx_sw.ClassToVar(
  AClass: TCustomComboBoxEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomComboBoxEx_sw.ClassFromVar(
  const AClass: OleVariant): TCustomComboBoxEx_sc;
begin
  Result := TCustomComboBoxEx_sc(ConvClsFromVar(AClass, TCustomComboBoxEx));
end;

{ TComboBoxEx_sw }

class function TComboBoxEx_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxEx';
end;

class function TComboBoxEx_sw.GetWrappedClass: TClass;
begin
  Result := TComboBoxEx;
end;

class procedure TComboBoxEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('AutoCompleteOptions', False);
  AData.AddPropertyRedecl('ItemsEx', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('StyleEx', False);
  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('ItemHeight', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnBeginEdit', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDropDown', False);
  AData.AddPropertyRedecl('OnEndEdit', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnSelect', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('Images', False);
  AData.AddPropertyRedecl('DropDownCount', False);
end;

class function TComboBoxEx_sw.ToVar(const AValue: TComboBoxEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboBoxEx_sw.FromVar(const AValue: OleVariant): TComboBoxEx;
begin
  Result := TComboBoxEx(ConvFromVar(AValue, TComboBoxEx));
end;

class function TComboBoxEx_sw.ClassToVar(AClass: TComboBoxEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboBoxEx_sw.ClassFromVar(
  const AClass: OleVariant): TComboBoxEx_sc;
begin
  Result := TComboBoxEx_sc(ConvClsFromVar(AClass, TComboBoxEx));
end;

{ TComboBoxExActionLink_sw }

class function TComboBoxExActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TComboBoxExActionLink';
end;

class function TComboBoxExActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TComboBoxExActionLink;
end;

class procedure TComboBoxExActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TComboBoxExActionLink_sw.ToVar(
  const AValue: TComboBoxExActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComboBoxExActionLink_sw.FromVar(
  const AValue: OleVariant): TComboBoxExActionLink;
begin
  Result := TComboBoxExActionLink(ConvFromVar(AValue, TComboBoxExActionLink));
end;

class function TComboBoxExActionLink_sw.ClassToVar(
  AClass: TComboBoxExActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComboBoxExActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TComboBoxExActionLink_sc;
begin
  Result := TComboBoxExActionLink_sc(ConvClsFromVar(AClass, 
    TComboBoxExActionLink));
end;

{ ComCtrls_sw }

function ComCtrls_dowMonday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowMonday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowMonday);
end;

function ComCtrls_dowTuesday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowTuesday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowTuesday);
end;

function ComCtrls_dowWednesday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowWednesday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowWednesday);
end;

function ComCtrls_dowThursday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowThursday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowThursday);
end;

function ComCtrls_dowFriday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowFriday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowFriday);
end;

function ComCtrls_dowSaturday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowSaturday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowSaturday);
end;

function ComCtrls_dowSunday_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowSunday = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowSunday);
end;

function ComCtrls_dowLocaleDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dowLocaleDefault = <value>;

  Result := TCalDayOfWeek_sw.ToVar(dowLocaleDefault);
end;

function ComCtrls_THitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THitTest = (htAbove, htBelow, htNowhere, htOnItem, h...

  Result := TLMDUnitWrapper.TypeToVar(THitTest_sw);
end;

function ComCtrls_THitTests_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THitTests = set of THitTest;

  Result := TLMDUnitWrapper.TypeToVar(THitTests_sw);
end;

function ComCtrls_TTabChangingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabChangingEvent = procedure (Sender: TObject; var ...

  Result := TLMDUnitWrapper.TypeToVar(TTabChangingEvent_sw);
end;

function ComCtrls_TTabPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabPosition = (tpTop, tpBottom, tpLeft, tpRight);

  Result := TLMDUnitWrapper.TypeToVar(TTabPosition_sw);
end;

function ComCtrls_TTabStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabStyle = (tsTabs, tsButtons, tsFlatButtons);

  Result := TLMDUnitWrapper.TypeToVar(TTabStyle_sw);
end;

function ComCtrls_TDrawTabEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDrawTabEvent = procedure (Control: TCustomTabContro...

  Result := TLMDUnitWrapper.TypeToVar(TDrawTabEvent_sw);
end;

function ComCtrls_TTabGetImageEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabGetImageEvent = procedure (Sender: TObject; TabI...

  Result := TLMDUnitWrapper.TypeToVar(TTabGetImageEvent_sw);
end;

function ComCtrls_TCustomTabControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomTabControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomTabControl_sw);
end;

function ComCtrls_TTabControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabControl = class(TCustomTabControl);

  Result := TLMDUnitWrapper.TypeToVar(TTabControl_sw);
end;

function ComCtrls_TTabSheet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabSheet = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TTabSheet_sw);
end;

function ComCtrls_TPageControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageControl = class(TCustomTabControl);

  Result := TLMDUnitWrapper.TypeToVar(TPageControl_sw);
end;

function ComCtrls_TStatusPanelStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusPanelStyle = (psText, psOwnerDraw);

  Result := TLMDUnitWrapper.TypeToVar(TStatusPanelStyle_sw);
end;

function ComCtrls_TStatusPanelBevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusPanelBevel = (pbNone, pbLowered, pbRaised);

  Result := TLMDUnitWrapper.TypeToVar(TStatusPanelBevel_sw);
end;

function ComCtrls_TStatusPanelClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusPanelClass = class of TStatusPanel;

  Result := TLMDUnitWrapper.TypeToVar(TStatusPanelClass_sw);
end;

function ComCtrls_TStatusPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusPanel = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TStatusPanel_sw);
end;

function ComCtrls_TStatusPanels_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusPanels = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TStatusPanels_sw);
end;

function ComCtrls_TCustomDrawPanelEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDrawPanelEvent = procedure (StatusBar: TCusto...

  Result := TLMDUnitWrapper.TypeToVar(TCustomDrawPanelEvent_sw);
end;

function ComCtrls_TSBCreatePanelClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSBCreatePanelClassEvent = procedure (Sender: TCusto...

  Result := TLMDUnitWrapper.TypeToVar(TSBCreatePanelClassEvent_sw);
end;

function ComCtrls_TCustomStatusBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomStatusBar = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomStatusBar_sw);
end;

function ComCtrls_TDrawPanelEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDrawPanelEvent = procedure (StatusBar: TStatusBar; ...

  Result := TLMDUnitWrapper.TypeToVar(TDrawPanelEvent_sw);
end;

function ComCtrls_TStatusBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStatusBar = class(TCustomStatusBar);

  Result := TLMDUnitWrapper.TypeToVar(TStatusBar_sw);
end;

function ComCtrls_TCustomDrawTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDrawTarget = (dtControl, dtItem, dtSubItem);

  Result := TLMDUnitWrapper.TypeToVar(TCustomDrawTarget_sw);
end;

function ComCtrls_TCustomDrawStage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDrawStage = (cdPrePaint, cdPostPaint, cdPreEr...

  Result := TLMDUnitWrapper.TypeToVar(TCustomDrawStage_sw);
end;

function ComCtrls_THeaderSectionStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderSectionStyle = (hsText, hsOwnerDraw);

  Result := TLMDUnitWrapper.TypeToVar(THeaderSectionStyle_sw);
end;

function ComCtrls_THeaderSectionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderSectionClass = class of THeaderSection;

  Result := TLMDUnitWrapper.TypeToVar(THeaderSectionClass_sw);
end;

function ComCtrls_THeaderSection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderSection = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(THeaderSection_sw);
end;

function ComCtrls_THeaderSections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderSections = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(THeaderSections_sw);
end;

function ComCtrls_TSectionTrackState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSectionTrackState = (tsTrackBegin, tsTrackMove, tsT...

  Result := TLMDUnitWrapper.TypeToVar(TSectionTrackState_sw);
end;

function ComCtrls_TCustomDrawSectionEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDrawSectionEvent = procedure (HeaderControl: ...

  Result := TLMDUnitWrapper.TypeToVar(TCustomDrawSectionEvent_sw);
end;

function ComCtrls_TCustomSectionNotifyEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomSectionNotifyEvent = procedure (HeaderControl...

  Result := TLMDUnitWrapper.TypeToVar(TCustomSectionNotifyEvent_sw);
end;

function ComCtrls_TCustomSectionTrackEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomSectionTrackEvent = procedure (HeaderControl:...

  Result := TLMDUnitWrapper.TypeToVar(TCustomSectionTrackEvent_sw);
end;

function ComCtrls_TSectionDragEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSectionDragEvent = procedure (Sender: TObject; From...

  Result := TLMDUnitWrapper.TypeToVar(TSectionDragEvent_sw);
end;

function ComCtrls_TCustomHCCreateSectionClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHCCreateSectionClassEvent = procedure (Sender...

  Result := TLMDUnitWrapper.TypeToVar(TCustomHCCreateSectionClassEvent_sw);
end;

function ComCtrls_THeaderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderStyle = (hsButtons, hsFlat);

  Result := TLMDUnitWrapper.TypeToVar(THeaderStyle_sw);
end;

function ComCtrls_TCustomHeaderControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHeaderControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomHeaderControl_sw);
end;

function ComCtrls_TDrawSectionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDrawSectionEvent = procedure (HeaderControl: THeade...

  Result := TLMDUnitWrapper.TypeToVar(TDrawSectionEvent_sw);
end;

function ComCtrls_TSectionNotifyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSectionNotifyEvent = procedure (HeaderControl: THea...

  Result := TLMDUnitWrapper.TypeToVar(TSectionNotifyEvent_sw);
end;

function ComCtrls_TSectionTrackEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSectionTrackEvent = procedure (HeaderControl: THead...

  Result := TLMDUnitWrapper.TypeToVar(TSectionTrackEvent_sw);
end;

function ComCtrls_THCCreateSectionClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THCCreateSectionClassEvent = procedure (Sender: THea...

  Result := TLMDUnitWrapper.TypeToVar(THCCreateSectionClassEvent_sw);
end;

function ComCtrls_THeaderControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeaderControl = class(TCustomHeaderControl);

  Result := TLMDUnitWrapper.TypeToVar(THeaderControl_sw);
end;

function ComCtrls_TNodeState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeState = (nsCut, nsDropHilited, nsFocused, nsSel...

  Result := TLMDUnitWrapper.TypeToVar(TNodeState_sw);
end;

function ComCtrls_TNodeAttachMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeAttachMode = (naAdd, naAddFirst, naAddChild, na...

  Result := TLMDUnitWrapper.TypeToVar(TNodeAttachMode_sw);
end;

function ComCtrls_TAddMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAddMode = (taAddFirst, taAdd, taInsert);

  Result := TLMDUnitWrapper.TypeToVar(TAddMode_sw);
end;

function ComCtrls_TNodeInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeInfo_sw);
end;

function ComCtrls_TNodeDataInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataInfo_sw);
end;

function ComCtrls_TNodeDataInfoX86_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataInfoX86 = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataInfoX86_sw);
end;

function ComCtrls_TNodeDataInfo2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataInfo2 = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataInfo2_sw);
end;

function ComCtrls_TNodeDataInfo2x86_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataInfo2x86 = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataInfo2x86_sw);
end;

function ComCtrls_TNodeDataInfo2x64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataInfo2x64 = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataInfo2x64_sw);
end;

function ComCtrls_TNodeDataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeDataType = (ndtDefault, ndtDefault2, ndt32bit, ...

  Result := TLMDUnitWrapper.TypeToVar(TNodeDataType_sw);
end;

function ComCtrls_TTVItemStateEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVItemStateEx = (tviDisabled, tviFlat);

  Result := TLMDUnitWrapper.TypeToVar(TTVItemStateEx_sw);
end;

function ComCtrls_TTVItemStateExSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVItemStateExSet = set of TTVItemStateEx;

  Result := TLMDUnitWrapper.TypeToVar(TTVItemStateExSet_sw);
end;

function ComCtrls_TTreeNodeClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTreeNodeClass = class of TTreeNode;

  Result := TLMDUnitWrapper.TypeToVar(TTreeNodeClass_sw);
end;

function ComCtrls_TTreeNode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTreeNode = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TTreeNode_sw);
end;

function ComCtrls_TTreeNodesEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTreeNodesEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TTreeNodesEnumerator_sw);
end;

function ComCtrls_TNodeCache_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNodeCache = record;

  Result := TLMDUnitWrapper.TypeToVar(TNodeCache_sw);
end;

function ComCtrls_TTreeNodes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTreeNodes = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TTreeNodes_sw);
end;

function ComCtrls_TSortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSortType = (stNone, stData, stText, stBoth);

  Result := TLMDUnitWrapper.TypeToVar(TSortType_sw);
end;

function ComCtrls_TMultiSelectStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMultiSelectStyles = (msControlSelect, msShiftSelect...

  Result := TLMDUnitWrapper.TypeToVar(TMultiSelectStyles_sw);
end;

function ComCtrls_TMultiSelectStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMultiSelectStyle = set of TMultiSelectStyles;

  Result := TLMDUnitWrapper.TypeToVar(TMultiSelectStyle_sw);
end;

function ComCtrls_ETreeViewError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ETreeViewError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(ETreeViewError_sw);
end;

function ComCtrls_TTVChangingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVChangingEvent = procedure (Sender: TObject; Node:...

  Result := TLMDUnitWrapper.TypeToVar(TTVChangingEvent_sw);
end;

function ComCtrls_TTVChangedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVChangedEvent = procedure (Sender: TObject; Node: ...

  Result := TLMDUnitWrapper.TypeToVar(TTVChangedEvent_sw);
end;

function ComCtrls_TTVEditingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVEditingEvent = procedure (Sender: TObject; Node: ...

  Result := TLMDUnitWrapper.TypeToVar(TTVEditingEvent_sw);
end;

function ComCtrls_TTVEditedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVEditedEvent = procedure (Sender: TObject; Node: T...

  Result := TLMDUnitWrapper.TypeToVar(TTVEditedEvent_sw);
end;

function ComCtrls_TTVExpandingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVExpandingEvent = procedure (Sender: TObject; Node...

  Result := TLMDUnitWrapper.TypeToVar(TTVExpandingEvent_sw);
end;

function ComCtrls_TTVCollapsingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVCollapsingEvent = procedure (Sender: TObject; Nod...

  Result := TLMDUnitWrapper.TypeToVar(TTVCollapsingEvent_sw);
end;

function ComCtrls_TTVExpandedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVExpandedEvent = procedure (Sender: TObject; Node:...

  Result := TLMDUnitWrapper.TypeToVar(TTVExpandedEvent_sw);
end;

function ComCtrls_TTVCompareEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVCompareEvent = procedure (Sender: TObject; Node1:...

  Result := TLMDUnitWrapper.TypeToVar(TTVCompareEvent_sw);
end;

function ComCtrls_TTVHintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVHintEvent = procedure (Sender: TObject; const Nod...

  Result := TLMDUnitWrapper.TypeToVar(TTVHintEvent_sw);
end;

function ComCtrls_TTVCustomDrawEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVCustomDrawEvent = procedure (Sender: TCustomTreeV...

  Result := TLMDUnitWrapper.TypeToVar(TTVCustomDrawEvent_sw);
end;

function ComCtrls_TTVAdvancedCustomDrawEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVAdvancedCustomDrawEvent = procedure (Sender: TCus...

  Result := TLMDUnitWrapper.TypeToVar(TTVAdvancedCustomDrawEvent_sw);
end;

function ComCtrls_TTVCreateNodeClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTVCreateNodeClassEvent = procedure (Sender: TCustom...

  Result := TLMDUnitWrapper.TypeToVar(TTVCreateNodeClassEvent_sw);
end;

function ComCtrls_TCustomTreeView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomTreeView = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomTreeView_sw);
end;

function ComCtrls_TTreeView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTreeView = class(TCustomTreeView);

  Result := TLMDUnitWrapper.TypeToVar(TTreeView_sw);
end;

function ComCtrls_TTrackBarOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTrackBarOrientation = (trHorizontal, trVertical);

  Result := TLMDUnitWrapper.TypeToVar(TTrackBarOrientation_sw);
end;

function ComCtrls_TTickMark_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTickMark = (tmBottomRight, tmTopLeft, tmBoth);

  Result := TLMDUnitWrapper.TypeToVar(TTickMark_sw);
end;

function ComCtrls_TTickStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTickStyle = (tsNone, tsAuto, tsManual);

  Result := TLMDUnitWrapper.TypeToVar(TTickStyle_sw);
end;

function ComCtrls_TPositionToolTip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPositionToolTip = (ptNone, ptTop, ptLeft, ptBottom,...

  Result := TLMDUnitWrapper.TypeToVar(TPositionToolTip_sw);
end;

function ComCtrls_TTrackBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTrackBar = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TTrackBar_sw);
end;

function ComCtrls_TProgressRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressRange = Integer;

  Result := TLMDUnitWrapper.TypeToVar(TProgressRange_sw);
end;

function ComCtrls_TProgressBarOrientation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressBarOrientation = (pbHorizontal, pbVertical);

  Result := TLMDUnitWrapper.TypeToVar(TProgressBarOrientation_sw);
end;

function ComCtrls_TProgressBarStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressBarStyle = (pbstNormal, pbstMarquee);

  Result := TLMDUnitWrapper.TypeToVar(TProgressBarStyle_sw);
end;

function ComCtrls_TProgressBarState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressBarState = (pbsNormal, pbsError, pbsPaused);

  Result := TLMDUnitWrapper.TypeToVar(TProgressBarState_sw);
end;

function ComCtrls_TProgressBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProgressBar = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TProgressBar_sw);
end;

function ComCtrls_TAttributeType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAttributeType = (atSelected, atDefaultText);

  Result := TLMDUnitWrapper.TypeToVar(TAttributeType_sw);
end;

function ComCtrls_TConsistentAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConsistentAttribute = (caBold, caColor, caFace, caI...

  Result := TLMDUnitWrapper.TypeToVar(TConsistentAttribute_sw);
end;

function ComCtrls_TConsistentAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConsistentAttributes = set of TConsistentAttribute;

  Result := TLMDUnitWrapper.TypeToVar(TConsistentAttributes_sw);
end;

function ComCtrls_TTextAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextAttributes = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TTextAttributes_sw);
end;

function ComCtrls_TNumberingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNumberingStyle = (nsNone, nsBullet);

  Result := TLMDUnitWrapper.TypeToVar(TNumberingStyle_sw);
end;

function ComCtrls_TParaAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParaAttributes = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TParaAttributes_sw);
end;

function ComCtrls_TRichEditResizeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRichEditResizeEvent = procedure (Sender: TObject; R...

  Result := TLMDUnitWrapper.TypeToVar(TRichEditResizeEvent_sw);
end;

function ComCtrls_TRichEditProtectChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRichEditProtectChange = procedure (Sender: TObject;...

  Result := TLMDUnitWrapper.TypeToVar(TRichEditProtectChange_sw);
end;

function ComCtrls_TRichEditSaveClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRichEditSaveClipboard = procedure (Sender: TObject;...

  Result := TLMDUnitWrapper.TypeToVar(TRichEditSaveClipboard_sw);
end;

function ComCtrls_TSearchType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchType = (stWholeWord, stMatchCase);

  Result := TLMDUnitWrapper.TypeToVar(TSearchType_sw);
end;

function ComCtrls_TSearchTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchTypes = set of TSearchType;

  Result := TLMDUnitWrapper.TypeToVar(TSearchTypes_sw);
end;

function ComCtrls_TConversion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConversion = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TConversion_sw);
end;

function ComCtrls_TConversionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConversionClass = class of TConversion;

  Result := TLMDUnitWrapper.TypeToVar(TConversionClass_sw);
end;

function ComCtrls_TConversionFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConversionFormat = record;

  Result := TLMDUnitWrapper.TypeToVar(TConversionFormat_sw);
end;

function ComCtrls_TRichEditStreamInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRichEditStreamInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TRichEditStreamInfo_sw);
end;

function ComCtrls_TCustomRichEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomRichEdit = class(TCustomMemo);

  Result := TLMDUnitWrapper.TypeToVar(TCustomRichEdit_sw);
end;

function ComCtrls_TRichEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRichEdit = class(TCustomRichEdit);

  Result := TLMDUnitWrapper.TypeToVar(TRichEdit_sw);
end;

function ComCtrls_TUDAlignButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDAlignButton = (udLeft, udRight);

  Result := TLMDUnitWrapper.TypeToVar(TUDAlignButton_sw);
end;

function ComCtrls_TUDOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDOrientation = (udHorizontal, udVertical);

  Result := TLMDUnitWrapper.TypeToVar(TUDOrientation_sw);
end;

function ComCtrls_TUDBtnType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDBtnType = (btNext, btPrev);

  Result := TLMDUnitWrapper.TypeToVar(TUDBtnType_sw);
end;

function ComCtrls_TUpDownDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpDownDirection = (updNone, updUp, updDown);

  Result := TLMDUnitWrapper.TypeToVar(TUpDownDirection_sw);
end;

function ComCtrls_TUDClickEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDClickEvent = procedure (Sender: TObject; Button: ...

  Result := TLMDUnitWrapper.TypeToVar(TUDClickEvent_sw);
end;

function ComCtrls_TUDChangingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDChangingEvent = procedure (Sender: TObject; var A...

  Result := TLMDUnitWrapper.TypeToVar(TUDChangingEvent_sw);
end;

function ComCtrls_TUDChangingEventEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUDChangingEventEx = procedure (Sender: TObject; var...

  Result := TLMDUnitWrapper.TypeToVar(TUDChangingEventEx_sw);
end;

function ComCtrls_TCustomUpDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomUpDown = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomUpDown_sw);
end;

function ComCtrls_TUpDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpDown = class(TCustomUpDown);

  Result := TLMDUnitWrapper.TypeToVar(TUpDown_sw);
end;

function ComCtrls_THKModifier_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THKModifier = (hkShift, hkCtrl, hkAlt, hkExt);

  Result := TLMDUnitWrapper.TypeToVar(THKModifier_sw);
end;

function ComCtrls_THKModifiers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THKModifiers = set of THKModifier;

  Result := TLMDUnitWrapper.TypeToVar(THKModifiers_sw);
end;

function ComCtrls_THKInvalidKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THKInvalidKey = (hcNone, hcShift, hcCtrl, hcAlt, hcS...

  Result := TLMDUnitWrapper.TypeToVar(THKInvalidKey_sw);
end;

function ComCtrls_THKInvalidKeys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THKInvalidKeys = set of THKInvalidKey;

  Result := TLMDUnitWrapper.TypeToVar(THKInvalidKeys_sw);
end;

function ComCtrls_TCustomHotKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHotKey = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomHotKey_sw);
end;

function ComCtrls_THotKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THotKey = class(TCustomHotKey);

  Result := TLMDUnitWrapper.TypeToVar(THotKey_sw);
end;

function ComCtrls_ColumnHeaderWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ColumnHeaderWidth = <value>;

  Result := ColumnHeaderWidth;
end;

function ComCtrls_ColumnTextWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ColumnTextWidth = <value>;

  Result := ColumnTextWidth;
end;

function ComCtrls_TWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWidth = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TWidth_sw);
end;

function ComCtrls_TListGroupState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListGroupState = (lgsNormal, lgsHidden, lgsCollapse...

  Result := TLMDUnitWrapper.TypeToVar(TListGroupState_sw);
end;

function ComCtrls_TListGroupStateSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListGroupStateSet = set of TListGroupState;

  Result := TLMDUnitWrapper.TypeToVar(TListGroupStateSet_sw);
end;

function ComCtrls_TListGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListGroup = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TListGroup_sw);
end;

function ComCtrls_TListGroups_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListGroups = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TListGroups_sw);
end;

function ComCtrls_TListColumn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListColumn = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TListColumn_sw);
end;

function ComCtrls_TListColumns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListColumns = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TListColumns_sw);
end;

function ComCtrls_TDisplayCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDisplayCode = (drBounds, drIcon, drLabel, drSelectB...

  Result := TLMDUnitWrapper.TypeToVar(TDisplayCode_sw);
end;

function ComCtrls_TListItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListItemClass = class of TListItem;

  Result := TLMDUnitWrapper.TypeToVar(TListItemClass_sw);
end;

function ComCtrls_TListItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListItem = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TListItem_sw);
end;

function ComCtrls_TListItemsEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListItemsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TListItemsEnumerator_sw);
end;

function ComCtrls_TListItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListItems = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TListItems_sw);
end;

function ComCtrls_TWorkArea_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWorkArea = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TWorkArea_sw);
end;

function ComCtrls_TWorkAreas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWorkAreas = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TWorkAreas_sw);
end;

function ComCtrls_TIconArrangement_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIconArrangement = (iaTop, iaLeft);

  Result := TLMDUnitWrapper.TypeToVar(TIconArrangement_sw);
end;

function ComCtrls_TIconOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIconOptions = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TIconOptions_sw);
end;

function ComCtrls_TListArrangement_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListArrangement = (arAlignBottom, arAlignLeft, arAl...

  Result := TLMDUnitWrapper.TypeToVar(TListArrangement_sw);
end;

function ComCtrls_TViewStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TViewStyle = (vsIcon, vsSmallIcon, vsList, vsReport);

  Result := TLMDUnitWrapper.TypeToVar(TViewStyle_sw);
end;

function ComCtrls_TItemState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemState = (isNone, isCut, isDropHilited, isFocuse...

  Result := TLMDUnitWrapper.TypeToVar(TItemState_sw);
end;

function ComCtrls_TItemStates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemStates = set of TItemState;

  Result := TLMDUnitWrapper.TypeToVar(TItemStates_sw);
end;

function ComCtrls_TItemChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemChange = (ctText, ctImage, ctState);

  Result := TLMDUnitWrapper.TypeToVar(TItemChange_sw);
end;

function ComCtrls_TItemFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemFind = (ifData, ifPartialString, ifExactString,...

  Result := TLMDUnitWrapper.TypeToVar(TItemFind_sw);
end;

function ComCtrls_TSearchDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchDirection = (sdLeft, sdRight, sdAbove, sdBelo...

  Result := TLMDUnitWrapper.TypeToVar(TSearchDirection_sw);
end;

function ComCtrls_TListHotTrackStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListHotTrackStyle = (htHandPoint, htUnderlineCold, ...

  Result := TLMDUnitWrapper.TypeToVar(TListHotTrackStyle_sw);
end;

function ComCtrls_TListHotTrackStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListHotTrackStyles = set of TListHotTrackStyle;

  Result := TLMDUnitWrapper.TypeToVar(TListHotTrackStyles_sw);
end;

function ComCtrls_TItemRequests_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemRequests = (irText, irImage, irParam, irState, ...

  Result := TLMDUnitWrapper.TypeToVar(TItemRequests_sw);
end;

function ComCtrls_TItemRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemRequest = set of TItemRequests;

  Result := TLMDUnitWrapper.TypeToVar(TItemRequest_sw);
end;

function ComCtrls_TLVDeletedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVDeletedEvent = procedure (Sender: TObject; Item: ...

  Result := TLMDUnitWrapper.TypeToVar(TLVDeletedEvent_sw);
end;

function ComCtrls_TLVEditingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVEditingEvent = procedure (Sender: TObject; Item: ...

  Result := TLMDUnitWrapper.TypeToVar(TLVEditingEvent_sw);
end;

function ComCtrls_TLVEditedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVEditedEvent = procedure (Sender: TObject; Item: T...

  Result := TLMDUnitWrapper.TypeToVar(TLVEditedEvent_sw);
end;

function ComCtrls_TLVChangeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVChangeEvent = procedure (Sender: TObject; Item: T...

  Result := TLMDUnitWrapper.TypeToVar(TLVChangeEvent_sw);
end;

function ComCtrls_TLVChangingEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVChangingEvent = procedure (Sender: TObject; Item:...

  Result := TLMDUnitWrapper.TypeToVar(TLVChangingEvent_sw);
end;

function ComCtrls_TLVColumnClickEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVColumnClickEvent = procedure (Sender: TObject; Co...

  Result := TLMDUnitWrapper.TypeToVar(TLVColumnClickEvent_sw);
end;

function ComCtrls_TLVColumnRClickEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVColumnRClickEvent = procedure (Sender: TObject; C...

  Result := TLMDUnitWrapper.TypeToVar(TLVColumnRClickEvent_sw);
end;

function ComCtrls_TLVCompareEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVCompareEvent = procedure (Sender: TObject; Item1:...

  Result := TLMDUnitWrapper.TypeToVar(TLVCompareEvent_sw);
end;

function ComCtrls_TLVNotifyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVNotifyEvent = procedure (Sender: TObject; Item: T...

  Result := TLMDUnitWrapper.TypeToVar(TLVNotifyEvent_sw);
end;

function ComCtrls_TLVSelectItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVSelectItemEvent = procedure (Sender: TObject; Ite...

  Result := TLMDUnitWrapper.TypeToVar(TLVSelectItemEvent_sw);
end;

function ComCtrls_TLVCheckedItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVCheckedItemEvent = procedure (Sender: TObject; It...

  Result := TLMDUnitWrapper.TypeToVar(TLVCheckedItemEvent_sw);
end;

function ComCtrls_TLVCustomDrawEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVCustomDrawEvent = procedure (Sender: TCustomListV...

  Result := TLMDUnitWrapper.TypeToVar(TLVCustomDrawEvent_sw);
end;

function ComCtrls_TLVAdvancedCustomDrawEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVAdvancedCustomDrawEvent = procedure (Sender: TCus...

  Result := TLMDUnitWrapper.TypeToVar(TLVAdvancedCustomDrawEvent_sw);
end;

function ComCtrls_TLVOwnerDataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVOwnerDataEvent = procedure (Sender: TObject; Item...

  Result := TLMDUnitWrapper.TypeToVar(TLVOwnerDataEvent_sw);
end;

function ComCtrls_TLVOwnerDataHintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVOwnerDataHintEvent = procedure (Sender: TObject; ...

  Result := TLMDUnitWrapper.TypeToVar(TLVOwnerDataHintEvent_sw);
end;

function ComCtrls_TLVOwnerDataStateChangeEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVOwnerDataStateChangeEvent = procedure (Sender: TO...

  Result := TLMDUnitWrapper.TypeToVar(TLVOwnerDataStateChangeEvent_sw);
end;

function ComCtrls_TLVSubItemImageEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVSubItemImageEvent = procedure (Sender: TObject; I...

  Result := TLMDUnitWrapper.TypeToVar(TLVSubItemImageEvent_sw);
end;

function ComCtrls_TLVInfoTipEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVInfoTipEvent = procedure (Sender: TObject; Item: ...

  Result := TLMDUnitWrapper.TypeToVar(TLVInfoTipEvent_sw);
end;

function ComCtrls_TLVCreateItemClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLVCreateItemClassEvent = procedure (Sender: TCustom...

  Result := TLMDUnitWrapper.TypeToVar(TLVCreateItemClassEvent_sw);
end;

function ComCtrls_TCustomListView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomListView = class(TCustomMultiSelectListControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomListView_sw);
end;

function ComCtrls_TListView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListView = class(TCustomListView);

  Result := TLMDUnitWrapper.TypeToVar(TListView_sw);
end;

function ComCtrls_TListViewActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListViewActionLink = class(TListActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TListViewActionLink_sw);
end;

function ComCtrls_TCommonAVI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonAVI = (aviNone, aviFindFolder, aviFindFile, a...

  Result := TLMDUnitWrapper.TypeToVar(TCommonAVI_sw);
end;

function ComCtrls_TAnimateParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnimateParams = record;

  Result := TLMDUnitWrapper.TypeToVar(TAnimateParams_sw);
end;

function ComCtrls_TAnimateResId_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnimateResId = NativeInt;

  Result := TLMDUnitWrapper.TypeToVar(TAnimateResId_sw);
end;

function ComCtrls_TAnimate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnimate = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TAnimate_sw);
end;

function ComCtrls_CN_DROPDOWNCLOSED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_DROPDOWNCLOSED = <value>;

  Result := CN_DROPDOWNCLOSED;
end;

function ComCtrls_TToolButtonStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolButtonStyle = (tbsButton, tbsCheck, tbsDropDown...

  Result := TLMDUnitWrapper.TypeToVar(TToolButtonStyle_sw);
end;

function ComCtrls_TToolButtonState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolButtonState = (tbsChecked, tbsPressed, tbsEnabl...

  Result := TLMDUnitWrapper.TypeToVar(TToolButtonState_sw);
end;

function ComCtrls_TToolButtonActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolButtonActionLink = class(TControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TToolButtonActionLink_sw);
end;

function ComCtrls_TToolButtonActionLinkClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolButtonActionLinkClass = class of TToolButtonAct...

  Result := TLMDUnitWrapper.TypeToVar(TToolButtonActionLinkClass_sw);
end;

function ComCtrls_TToolButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolButton = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TToolButton_sw);
end;

function ComCtrls_TTBDrawingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBDrawingStyle = (dsNormal, dsGradient);

  Result := TLMDUnitWrapper.TypeToVar(TTBDrawingStyle_sw);
end;

function ComCtrls_TTBCustomDrawEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBCustomDrawEvent = procedure (Sender: TToolBar; co...

  Result := TLMDUnitWrapper.TypeToVar(TTBCustomDrawEvent_sw);
end;

function ComCtrls_TTBAdvancedCustomDrawEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBAdvancedCustomDrawEvent = procedure (Sender: TToo...

  Result := TLMDUnitWrapper.TypeToVar(TTBAdvancedCustomDrawEvent_sw);
end;

function ComCtrls_TTBCustomizeQueryEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBCustomizeQueryEvent = procedure (Sender: TToolbar...

  Result := TLMDUnitWrapper.TypeToVar(TTBCustomizeQueryEvent_sw);
end;

function ComCtrls_TTBNewButtonEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBNewButtonEvent = procedure (Sender: TToolbar; Ind...

  Result := TLMDUnitWrapper.TypeToVar(TTBNewButtonEvent_sw);
end;

function ComCtrls_TTBButtonEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTBButtonEvent = procedure (Sender: TToolbar; Button...

  Result := TLMDUnitWrapper.TypeToVar(TTBButtonEvent_sw);
end;

function ComCtrls_TToolBarEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolBarEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TToolBarEnumerator_sw);
end;

function ComCtrls_TToolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolBar = class(TToolWindow);

  Result := TLMDUnitWrapper.TypeToVar(TToolBar_sw);
end;

function ComCtrls_TToolBarDockObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolBarDockObject = class(TDragDockObject);

  Result := TLMDUnitWrapper.TypeToVar(TToolBarDockObject_sw);
end;

function ComCtrls_CN_BANDCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_BANDCHANGE = <value>;

  Result := CN_BANDCHANGE;
end;

function ComCtrls_TCoolBand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCoolBand = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TCoolBand_sw);
end;

function ComCtrls_TCoolBands_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCoolBands = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TCoolBands_sw);
end;

function ComCtrls_TCoolBandMaximize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCoolBandMaximize = (bmNone, bmClick, bmDblClick);

  Result := TLMDUnitWrapper.TypeToVar(TCoolBandMaximize_sw);
end;

function ComCtrls_TCoolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCoolBar = class(TToolWindow);

  Result := TLMDUnitWrapper.TypeToVar(TCoolBar_sw);
end;

function ComCtrls_ECommonCalendarError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ECommonCalendarError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(ECommonCalendarError_sw);
end;

function ComCtrls_ECommonCalExceptClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ECommonCalExceptClass = ExceptClass;

  Result := TLMDUnitWrapper.TypeToVar(ECommonCalExceptClass_sw);
end;

function ComCtrls_TMonthCalColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonthCalColors = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TMonthCalColors_sw);
end;

function ComCtrls_TCalDayOfWeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCalDayOfWeek = System.UITypes.TCalDayOfWeek;

  Result := TLMDUnitWrapper.TypeToVar(TCalDayOfWeek_sw);
end;

function ComCtrls_TOnGetMonthInfoEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOnGetMonthInfoEvent = procedure (Sender: TObject; M...

  Result := TLMDUnitWrapper.TypeToVar(TOnGetMonthInfoEvent_sw);
end;

function ComCtrls_TOnGetMonthBoldInfoEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOnGetMonthBoldInfoEvent = procedure (Sender: TObjec...

  Result := TLMDUnitWrapper.TypeToVar(TOnGetMonthBoldInfoEvent_sw);
end;

function ComCtrls_TCommonCalendar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonCalendar = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCommonCalendar_sw);
end;

function ComCtrls_EMonthCalError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EMonthCalError = class(ECommonCalendarError);

  Result := TLMDUnitWrapper.TypeToVar(EMonthCalError_sw);
end;

function ComCtrls_TMonthCalendar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonthCalendar = class(TCommonCalendar);

  Result := TLMDUnitWrapper.TypeToVar(TMonthCalendar_sw);
end;

function ComCtrls_EDateTimeError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDateTimeError = class(ECommonCalendarError);

  Result := TLMDUnitWrapper.TypeToVar(EDateTimeError_sw);
end;

function ComCtrls_TDateTimeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimeKind = (dtkDate, dtkTime);

  Result := TLMDUnitWrapper.TypeToVar(TDateTimeKind_sw);
end;

function ComCtrls_TDTDateMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDTDateMode = (dmComboBox, dmUpDown);

  Result := TLMDUnitWrapper.TypeToVar(TDTDateMode_sw);
end;

function ComCtrls_TDTDateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDTDateFormat = (dfShort, dfLong);

  Result := TLMDUnitWrapper.TypeToVar(TDTDateFormat_sw);
end;

function ComCtrls_TDTCalAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDTCalAlignment = (dtaLeft, dtaRight);

  Result := TLMDUnitWrapper.TypeToVar(TDTCalAlignment_sw);
end;

function ComCtrls_TDTParseInputEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDTParseInputEvent = procedure (Sender: TObject; con...

  Result := TLMDUnitWrapper.TypeToVar(TDTParseInputEvent_sw);
end;

function ComCtrls_TDateTimeColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimeColors = TMonthCalColors;

  Result := TLMDUnitWrapper.TypeToVar(TDateTimeColors_sw);
end;

function ComCtrls_TDateTimePicker_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimePicker = class(TCommonCalendar);

  Result := TLMDUnitWrapper.TypeToVar(TDateTimePicker_sw);
end;

function ComCtrls_TPageScrollerOrientation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageScrollerOrientation = (soHorizontal, soVertical);

  Result := TLMDUnitWrapper.TypeToVar(TPageScrollerOrientation_sw);
end;

function ComCtrls_TPageScrollerButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageScrollerButton = (sbFirst, sbLast);

  Result := TLMDUnitWrapper.TypeToVar(TPageScrollerButton_sw);
end;

function ComCtrls_TPageScrollerButtonState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageScrollerButtonState = (bsNormal, bsInvisible, b...

  Result := TLMDUnitWrapper.TypeToVar(TPageScrollerButtonState_sw);
end;

function ComCtrls_TPageScroller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageScroller = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TPageScroller_sw);
end;

function ComCtrls_TComboExItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboExItem = class(TListControlItem);

  Result := TLMDUnitWrapper.TypeToVar(TComboExItem_sw);
end;

function ComCtrls_TComboExItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboExItems = class(TListControlItems);

  Result := TLMDUnitWrapper.TypeToVar(TComboExItems_sw);
end;

function ComCtrls_TComboExItemsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboExItemsClass = class of TComboExItems;

  Result := TLMDUnitWrapper.TypeToVar(TComboExItemsClass_sw);
end;

function ComCtrls_TComboExItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboExItemClass = class of TComboExItem;

  Result := TLMDUnitWrapper.TypeToVar(TComboExItemClass_sw);
end;

function ComCtrls_TComboBoxExStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExStrings = class(TCustomComboBoxStrings);

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExStrings_sw);
end;

function ComCtrls_TComboBoxExStringsClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExStringsClass = class of TComboBoxExStrings;

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExStringsClass_sw);
end;

function ComCtrls_TComboBoxExStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExStyle = (csExDropDown, csExSimple, csExDr...

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExStyle_sw);
end;

function ComCtrls_TComboBoxExStyleEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExStyleEx = (csExCaseSensitive, csExNoEditI...

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExStyleEx_sw);
end;

function ComCtrls_TComboBoxExStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExStyles = set of TComboBoxExStyleEx;

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExStyles_sw);
end;

function ComCtrls_TAutoCompleteOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAutoCompleteOption = (acoAutoSuggest, acoAutoAppend...

  Result := TLMDUnitWrapper.TypeToVar(TAutoCompleteOption_sw);
end;

function ComCtrls_TAutoCompleteOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAutoCompleteOptions = set of TAutoCompleteOption;

  Result := TLMDUnitWrapper.TypeToVar(TAutoCompleteOptions_sw);
end;

function ComCtrls_TCustomComboBoxEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomComboBoxEx = class(TCustomCombo);

  Result := TLMDUnitWrapper.TypeToVar(TCustomComboBoxEx_sw);
end;

function ComCtrls_TComboBoxEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxEx = class(TCustomComboBoxEx);

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxEx_sw);
end;

function ComCtrls_TComboBoxExActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComboBoxExActionLink = class(TListActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TComboBoxExActionLink_sw);
end;

function ComCtrls_InitCommonControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InitCommonControl(CC: Integer): Boolean;

  Result := Vcl.ComCtrls.InitCommonControl(Integer(AArgs[0]));
end;

function ComCtrls_CheckCommonControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckCommonControl(CC: Integer);

  Vcl.ComCtrls.CheckCommonControl(Integer(AArgs[0]));
end;

function ComCtrls_ComCtlVersionIE3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE3 = <value>;

  Result := ComCtlVersionIE3;
end;

function ComCtrls_ComCtlVersionIE4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE4 = <value>;

  Result := ComCtlVersionIE4;
end;

function ComCtrls_ComCtlVersionIE401_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE401 = <value>;

  Result := ComCtlVersionIE401;
end;

function ComCtrls_ComCtlVersionIE5_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE5 = <value>;

  Result := ComCtlVersionIE5;
end;

function ComCtrls_ComCtlVersionIE501_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE501 = <value>;

  Result := ComCtlVersionIE501;
end;

function ComCtrls_ComCtlVersionIE6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ComCtlVersionIE6 = <value>;

  Result := ComCtlVersionIE6;
end;

function ComCtrls_GetComCtlVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetComCtlVersion: Integer;

  Result := Vcl.ComCtrls.GetComCtlVersion();
end;

function ComCtrls_CheckToolMenuDropdown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckToolMenuDropdown(ToolButton: TToolButton);

  Vcl.ComCtrls.CheckToolMenuDropdown(TToolButton_sw.FromVar(AArgs[0]));
end;

class function ComCtrls_sw.GetUnitName: WideString;
begin
  Result := 'ComCtrls';
end;

class procedure ComCtrls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('dowMonday', ComCtrls_dowMonday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowTuesday', ComCtrls_dowTuesday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowWednesday', ComCtrls_dowWednesday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowThursday', ComCtrls_dowThursday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowFriday', ComCtrls_dowFriday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowSaturday', ComCtrls_dowSaturday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowSunday', ComCtrls_dowSunday_si, TCalDayOfWeek_sw);
  AData.AddConstant('dowLocaleDefault', ComCtrls_dowLocaleDefault_si, TCalDayOfWeek_sw);
  AData.AddType(THitTest_sw, ComCtrls_THitTest_si);
  AData.AddType(THitTests_sw, ComCtrls_THitTests_si);
  AData.AddType(TTabChangingEvent_sw, ComCtrls_TTabChangingEvent_si);
  AData.AddType(TTabPosition_sw, ComCtrls_TTabPosition_si);
  AData.AddType(TTabStyle_sw, ComCtrls_TTabStyle_si);
  AData.AddType(TDrawTabEvent_sw, ComCtrls_TDrawTabEvent_si);
  AData.AddType(TTabGetImageEvent_sw, ComCtrls_TTabGetImageEvent_si);
  AData.AddType(TCustomTabControl_sw, ComCtrls_TCustomTabControl_si);
  AData.AddType(TTabControl_sw, ComCtrls_TTabControl_si);
  AData.AddType(TTabSheet_sw, ComCtrls_TTabSheet_si);
  AData.AddType(TPageControl_sw, ComCtrls_TPageControl_si);
  AData.AddType(TStatusPanelStyle_sw, ComCtrls_TStatusPanelStyle_si);
  AData.AddType(TStatusPanelBevel_sw, ComCtrls_TStatusPanelBevel_si);
  AData.AddType(TStatusPanelClass_sw, ComCtrls_TStatusPanelClass_si);
  AData.AddType(TStatusPanel_sw, ComCtrls_TStatusPanel_si);
  AData.AddType(TStatusPanels_sw, ComCtrls_TStatusPanels_si);
  AData.AddType(TCustomDrawPanelEvent_sw, ComCtrls_TCustomDrawPanelEvent_si);
  AData.AddType(TSBCreatePanelClassEvent_sw, ComCtrls_TSBCreatePanelClassEvent_si);
  AData.AddType(TCustomStatusBar_sw, ComCtrls_TCustomStatusBar_si);
  AData.AddType(TDrawPanelEvent_sw, ComCtrls_TDrawPanelEvent_si);
  AData.AddType(TStatusBar_sw, ComCtrls_TStatusBar_si);
  AData.AddType(TCustomDrawTarget_sw, ComCtrls_TCustomDrawTarget_si);
  AData.AddType(TCustomDrawStage_sw, ComCtrls_TCustomDrawStage_si);
  AData.AddType(THeaderSectionStyle_sw, ComCtrls_THeaderSectionStyle_si);
  AData.AddType(THeaderSectionClass_sw, ComCtrls_THeaderSectionClass_si);
  AData.AddType(THeaderSection_sw, ComCtrls_THeaderSection_si);
  AData.AddType(THeaderSections_sw, ComCtrls_THeaderSections_si);
  AData.AddType(TSectionTrackState_sw, ComCtrls_TSectionTrackState_si);
  AData.AddType(TCustomDrawSectionEvent_sw, ComCtrls_TCustomDrawSectionEvent_si);
  AData.AddType(TCustomSectionNotifyEvent_sw, ComCtrls_TCustomSectionNotifyEvent_si);
  AData.AddType(TCustomSectionTrackEvent_sw, ComCtrls_TCustomSectionTrackEvent_si);
  AData.AddType(TSectionDragEvent_sw, ComCtrls_TSectionDragEvent_si);
  AData.AddType(TCustomHCCreateSectionClassEvent_sw, ComCtrls_TCustomHCCreateSectionClassEvent_si);
  AData.AddType(THeaderStyle_sw, ComCtrls_THeaderStyle_si);
  AData.AddType(TCustomHeaderControl_sw, ComCtrls_TCustomHeaderControl_si);
  AData.AddType(TDrawSectionEvent_sw, ComCtrls_TDrawSectionEvent_si);
  AData.AddType(TSectionNotifyEvent_sw, ComCtrls_TSectionNotifyEvent_si);
  AData.AddType(TSectionTrackEvent_sw, ComCtrls_TSectionTrackEvent_si);
  AData.AddType(THCCreateSectionClassEvent_sw, ComCtrls_THCCreateSectionClassEvent_si);
  AData.AddType(THeaderControl_sw, ComCtrls_THeaderControl_si);
  AData.AddType(TNodeState_sw, ComCtrls_TNodeState_si);
  AData.AddType(TNodeAttachMode_sw, ComCtrls_TNodeAttachMode_si);
  AData.AddType(TAddMode_sw, ComCtrls_TAddMode_si);
  AData.AddType(TNodeInfo_sw, ComCtrls_TNodeInfo_si);
  AData.AddType(TNodeDataInfo_sw, ComCtrls_TNodeDataInfo_si);
  AData.AddType(TNodeDataInfoX86_sw, ComCtrls_TNodeDataInfoX86_si);
  AData.AddType(TNodeDataInfo2_sw, ComCtrls_TNodeDataInfo2_si);
  AData.AddType(TNodeDataInfo2x86_sw, ComCtrls_TNodeDataInfo2x86_si);
  AData.AddType(TNodeDataInfo2x64_sw, ComCtrls_TNodeDataInfo2x64_si);
  AData.AddType(TNodeDataType_sw, ComCtrls_TNodeDataType_si);
  AData.AddType(TTVItemStateEx_sw, ComCtrls_TTVItemStateEx_si);
  AData.AddType(TTVItemStateExSet_sw, ComCtrls_TTVItemStateExSet_si);
  AData.AddType(TTreeNodeClass_sw, ComCtrls_TTreeNodeClass_si);
  AData.AddType(TTreeNode_sw, ComCtrls_TTreeNode_si);
  AData.AddType(TTreeNodesEnumerator_sw, ComCtrls_TTreeNodesEnumerator_si);
  AData.AddType(TNodeCache_sw, ComCtrls_TNodeCache_si);
  AData.AddType(TTreeNodes_sw, ComCtrls_TTreeNodes_si);
  AData.AddType(TSortType_sw, ComCtrls_TSortType_si);
  AData.AddType(TMultiSelectStyles_sw, ComCtrls_TMultiSelectStyles_si);
  AData.AddType(TMultiSelectStyle_sw, ComCtrls_TMultiSelectStyle_si);
  AData.AddType(ETreeViewError_sw, ComCtrls_ETreeViewError_si);
  AData.AddType(TTVChangingEvent_sw, ComCtrls_TTVChangingEvent_si);
  AData.AddType(TTVChangedEvent_sw, ComCtrls_TTVChangedEvent_si);
  AData.AddType(TTVEditingEvent_sw, ComCtrls_TTVEditingEvent_si);
  AData.AddType(TTVEditedEvent_sw, ComCtrls_TTVEditedEvent_si);
  AData.AddType(TTVExpandingEvent_sw, ComCtrls_TTVExpandingEvent_si);
  AData.AddType(TTVCollapsingEvent_sw, ComCtrls_TTVCollapsingEvent_si);
  AData.AddType(TTVExpandedEvent_sw, ComCtrls_TTVExpandedEvent_si);
  AData.AddType(TTVCompareEvent_sw, ComCtrls_TTVCompareEvent_si);
  AData.AddType(TTVHintEvent_sw, ComCtrls_TTVHintEvent_si);
  AData.AddType(TTVCustomDrawEvent_sw, ComCtrls_TTVCustomDrawEvent_si);
  AData.AddType(TTVAdvancedCustomDrawEvent_sw, ComCtrls_TTVAdvancedCustomDrawEvent_si);
  AData.AddType(TTVCreateNodeClassEvent_sw, ComCtrls_TTVCreateNodeClassEvent_si);
  AData.AddType(TCustomTreeView_sw, ComCtrls_TCustomTreeView_si);
  AData.AddType(TTreeView_sw, ComCtrls_TTreeView_si);
  AData.AddType(TTrackBarOrientation_sw, ComCtrls_TTrackBarOrientation_si);
  AData.AddType(TTickMark_sw, ComCtrls_TTickMark_si);
  AData.AddType(TTickStyle_sw, ComCtrls_TTickStyle_si);
  AData.AddType(TPositionToolTip_sw, ComCtrls_TPositionToolTip_si);
  AData.AddType(TTrackBar_sw, ComCtrls_TTrackBar_si);
  AData.AddType(TProgressRange_sw, ComCtrls_TProgressRange_si);
  AData.AddType(TProgressBarOrientation_sw, ComCtrls_TProgressBarOrientation_si);
  AData.AddType(TProgressBarStyle_sw, ComCtrls_TProgressBarStyle_si);
  AData.AddType(TProgressBarState_sw, ComCtrls_TProgressBarState_si);
  AData.AddType(TProgressBar_sw, ComCtrls_TProgressBar_si);
  AData.AddType(TAttributeType_sw, ComCtrls_TAttributeType_si);
  AData.AddType(TConsistentAttribute_sw, ComCtrls_TConsistentAttribute_si);
  AData.AddType(TConsistentAttributes_sw, ComCtrls_TConsistentAttributes_si);
  AData.AddType(TTextAttributes_sw, ComCtrls_TTextAttributes_si);
  AData.AddType(TNumberingStyle_sw, ComCtrls_TNumberingStyle_si);
  AData.AddType(TParaAttributes_sw, ComCtrls_TParaAttributes_si);
  AData.AddType(TRichEditResizeEvent_sw, ComCtrls_TRichEditResizeEvent_si);
  AData.AddType(TRichEditProtectChange_sw, ComCtrls_TRichEditProtectChange_si);
  AData.AddType(TRichEditSaveClipboard_sw, ComCtrls_TRichEditSaveClipboard_si);
  AData.AddType(TSearchType_sw, ComCtrls_TSearchType_si);
  AData.AddType(TSearchTypes_sw, ComCtrls_TSearchTypes_si);
  AData.AddType(TConversion_sw, ComCtrls_TConversion_si);
  AData.AddType(TConversionClass_sw, ComCtrls_TConversionClass_si);
  AData.AddType(TConversionFormat_sw, ComCtrls_TConversionFormat_si);
  AData.AddType(TRichEditStreamInfo_sw, ComCtrls_TRichEditStreamInfo_si);
  AData.AddType(TCustomRichEdit_sw, ComCtrls_TCustomRichEdit_si);
  AData.AddType(TRichEdit_sw, ComCtrls_TRichEdit_si);
  AData.AddType(TUDAlignButton_sw, ComCtrls_TUDAlignButton_si);
  AData.AddType(TUDOrientation_sw, ComCtrls_TUDOrientation_si);
  AData.AddType(TUDBtnType_sw, ComCtrls_TUDBtnType_si);
  AData.AddType(TUpDownDirection_sw, ComCtrls_TUpDownDirection_si);
  AData.AddType(TUDClickEvent_sw, ComCtrls_TUDClickEvent_si);
  AData.AddType(TUDChangingEvent_sw, ComCtrls_TUDChangingEvent_si);
  AData.AddType(TUDChangingEventEx_sw, ComCtrls_TUDChangingEventEx_si);
  AData.AddType(TCustomUpDown_sw, ComCtrls_TCustomUpDown_si);
  AData.AddType(TUpDown_sw, ComCtrls_TUpDown_si);
  AData.AddType(THKModifier_sw, ComCtrls_THKModifier_si);
  AData.AddType(THKModifiers_sw, ComCtrls_THKModifiers_si);
  AData.AddType(THKInvalidKey_sw, ComCtrls_THKInvalidKey_si);
  AData.AddType(THKInvalidKeys_sw, ComCtrls_THKInvalidKeys_si);
  AData.AddType(TCustomHotKey_sw, ComCtrls_TCustomHotKey_si);
  AData.AddType(THotKey_sw, ComCtrls_THotKey_si);
  AData.AddConstant('ColumnHeaderWidth', ComCtrls_ColumnHeaderWidth_si, Integer_sw);
  AData.AddConstant('ColumnTextWidth', ComCtrls_ColumnTextWidth_si, Integer_sw);
  AData.AddType(TWidth_sw, ComCtrls_TWidth_si);
  AData.AddType(TListGroupState_sw, ComCtrls_TListGroupState_si);
  AData.AddType(TListGroupStateSet_sw, ComCtrls_TListGroupStateSet_si);
  AData.AddType(TListGroup_sw, ComCtrls_TListGroup_si);
  AData.AddType(TListGroups_sw, ComCtrls_TListGroups_si);
  AData.AddType(TListColumn_sw, ComCtrls_TListColumn_si);
  AData.AddType(TListColumns_sw, ComCtrls_TListColumns_si);
  AData.AddType(TDisplayCode_sw, ComCtrls_TDisplayCode_si);
  AData.AddType(TListItemClass_sw, ComCtrls_TListItemClass_si);
  AData.AddType(TListItem_sw, ComCtrls_TListItem_si);
  AData.AddType(TListItemsEnumerator_sw, ComCtrls_TListItemsEnumerator_si);
  AData.AddType(TListItems_sw, ComCtrls_TListItems_si);
  AData.AddType(TWorkArea_sw, ComCtrls_TWorkArea_si);
  AData.AddType(TWorkAreas_sw, ComCtrls_TWorkAreas_si);
  AData.AddType(TIconArrangement_sw, ComCtrls_TIconArrangement_si);
  AData.AddType(TIconOptions_sw, ComCtrls_TIconOptions_si);
  AData.AddType(TListArrangement_sw, ComCtrls_TListArrangement_si);
  AData.AddType(TViewStyle_sw, ComCtrls_TViewStyle_si);
  AData.AddType(TItemState_sw, ComCtrls_TItemState_si);
  AData.AddType(TItemStates_sw, ComCtrls_TItemStates_si);
  AData.AddType(TItemChange_sw, ComCtrls_TItemChange_si);
  AData.AddType(TItemFind_sw, ComCtrls_TItemFind_si);
  AData.AddType(TSearchDirection_sw, ComCtrls_TSearchDirection_si);
  AData.AddType(TListHotTrackStyle_sw, ComCtrls_TListHotTrackStyle_si);
  AData.AddType(TListHotTrackStyles_sw, ComCtrls_TListHotTrackStyles_si);
  AData.AddType(TItemRequests_sw, ComCtrls_TItemRequests_si);
  AData.AddType(TItemRequest_sw, ComCtrls_TItemRequest_si);
  AData.AddType(TLVDeletedEvent_sw, ComCtrls_TLVDeletedEvent_si);
  AData.AddType(TLVEditingEvent_sw, ComCtrls_TLVEditingEvent_si);
  AData.AddType(TLVEditedEvent_sw, ComCtrls_TLVEditedEvent_si);
  AData.AddType(TLVChangeEvent_sw, ComCtrls_TLVChangeEvent_si);
  AData.AddType(TLVChangingEvent_sw, ComCtrls_TLVChangingEvent_si);
  AData.AddType(TLVColumnClickEvent_sw, ComCtrls_TLVColumnClickEvent_si);
  AData.AddType(TLVColumnRClickEvent_sw, ComCtrls_TLVColumnRClickEvent_si);
  AData.AddType(TLVCompareEvent_sw, ComCtrls_TLVCompareEvent_si);
  AData.AddType(TLVNotifyEvent_sw, ComCtrls_TLVNotifyEvent_si);
  AData.AddType(TLVSelectItemEvent_sw, ComCtrls_TLVSelectItemEvent_si);
  AData.AddType(TLVCheckedItemEvent_sw, ComCtrls_TLVCheckedItemEvent_si);
  AData.AddType(TLVCustomDrawEvent_sw, ComCtrls_TLVCustomDrawEvent_si);
  AData.AddType(TLVAdvancedCustomDrawEvent_sw, ComCtrls_TLVAdvancedCustomDrawEvent_si);
  AData.AddType(TLVOwnerDataEvent_sw, ComCtrls_TLVOwnerDataEvent_si);
  AData.AddType(TLVOwnerDataHintEvent_sw, ComCtrls_TLVOwnerDataHintEvent_si);
  AData.AddType(TLVOwnerDataStateChangeEvent_sw, ComCtrls_TLVOwnerDataStateChangeEvent_si);
  AData.AddType(TLVSubItemImageEvent_sw, ComCtrls_TLVSubItemImageEvent_si);
  AData.AddType(TLVInfoTipEvent_sw, ComCtrls_TLVInfoTipEvent_si);
  AData.AddType(TLVCreateItemClassEvent_sw, ComCtrls_TLVCreateItemClassEvent_si);
  AData.AddType(TCustomListView_sw, ComCtrls_TCustomListView_si);
  AData.AddType(TListView_sw, ComCtrls_TListView_si);
  AData.AddType(TListViewActionLink_sw, ComCtrls_TListViewActionLink_si);
  AData.AddType(TCommonAVI_sw, ComCtrls_TCommonAVI_si);
  AData.AddType(TAnimateParams_sw, ComCtrls_TAnimateParams_si);
  AData.AddType(TAnimateResId_sw, ComCtrls_TAnimateResId_si);
  AData.AddType(TAnimate_sw, ComCtrls_TAnimate_si);
  AData.AddConstant('CN_DROPDOWNCLOSED', ComCtrls_CN_DROPDOWNCLOSED_si, nil, VarType(Vcl.ComCtrls.CN_DROPDOWNCLOSED));
  AData.AddType(TToolButtonStyle_sw, ComCtrls_TToolButtonStyle_si);
  AData.AddType(TToolButtonState_sw, ComCtrls_TToolButtonState_si);
  AData.AddType(TToolButtonActionLink_sw, ComCtrls_TToolButtonActionLink_si);
  AData.AddType(TToolButtonActionLinkClass_sw, ComCtrls_TToolButtonActionLinkClass_si);
  AData.AddType(TToolButton_sw, ComCtrls_TToolButton_si);
  AData.AddType(TTBDrawingStyle_sw, ComCtrls_TTBDrawingStyle_si);
  AData.AddType(TTBCustomDrawEvent_sw, ComCtrls_TTBCustomDrawEvent_si);
  AData.AddType(TTBAdvancedCustomDrawEvent_sw, ComCtrls_TTBAdvancedCustomDrawEvent_si);
  AData.AddType(TTBCustomizeQueryEvent_sw, ComCtrls_TTBCustomizeQueryEvent_si);
  AData.AddType(TTBNewButtonEvent_sw, ComCtrls_TTBNewButtonEvent_si);
  AData.AddType(TTBButtonEvent_sw, ComCtrls_TTBButtonEvent_si);
  AData.AddType(TToolBarEnumerator_sw, ComCtrls_TToolBarEnumerator_si);
  AData.AddType(TToolBar_sw, ComCtrls_TToolBar_si);
  AData.AddType(TToolBarDockObject_sw, ComCtrls_TToolBarDockObject_si);
  AData.AddConstant('CN_BANDCHANGE', ComCtrls_CN_BANDCHANGE_si, nil, VarType(Vcl.ComCtrls.CN_BANDCHANGE));
  AData.AddType(TCoolBand_sw, ComCtrls_TCoolBand_si);
  AData.AddType(TCoolBands_sw, ComCtrls_TCoolBands_si);
  AData.AddType(TCoolBandMaximize_sw, ComCtrls_TCoolBandMaximize_si);
  AData.AddType(TCoolBar_sw, ComCtrls_TCoolBar_si);
  AData.AddType(ECommonCalendarError_sw, ComCtrls_ECommonCalendarError_si);
  AData.AddType(ECommonCalExceptClass_sw, ComCtrls_ECommonCalExceptClass_si);
  AData.AddType(TMonthCalColors_sw, ComCtrls_TMonthCalColors_si);
  AData.AddType(TCalDayOfWeek_sw, ComCtrls_TCalDayOfWeek_si);
  AData.AddType(TOnGetMonthInfoEvent_sw, ComCtrls_TOnGetMonthInfoEvent_si);
  AData.AddType(TOnGetMonthBoldInfoEvent_sw, ComCtrls_TOnGetMonthBoldInfoEvent_si);
  AData.AddType(TCommonCalendar_sw, ComCtrls_TCommonCalendar_si);
  AData.AddType(EMonthCalError_sw, ComCtrls_EMonthCalError_si);
  AData.AddType(TMonthCalendar_sw, ComCtrls_TMonthCalendar_si);
  AData.AddType(EDateTimeError_sw, ComCtrls_EDateTimeError_si);
  AData.AddType(TDateTimeKind_sw, ComCtrls_TDateTimeKind_si);
  AData.AddType(TDTDateMode_sw, ComCtrls_TDTDateMode_si);
  AData.AddType(TDTDateFormat_sw, ComCtrls_TDTDateFormat_si);
  AData.AddType(TDTCalAlignment_sw, ComCtrls_TDTCalAlignment_si);
  AData.AddType(TDTParseInputEvent_sw, ComCtrls_TDTParseInputEvent_si);
  AData.AddType(TDateTimeColors_sw, ComCtrls_TDateTimeColors_si);
  AData.AddType(TDateTimePicker_sw, ComCtrls_TDateTimePicker_si);
  AData.AddType(TPageScrollerOrientation_sw, ComCtrls_TPageScrollerOrientation_si);
  AData.AddType(TPageScrollerButton_sw, ComCtrls_TPageScrollerButton_si);
  AData.AddType(TPageScrollerButtonState_sw, ComCtrls_TPageScrollerButtonState_si);
  AData.AddType(TPageScroller_sw, ComCtrls_TPageScroller_si);
  AData.AddType(TComboExItem_sw, ComCtrls_TComboExItem_si);
  AData.AddType(TComboExItems_sw, ComCtrls_TComboExItems_si);
  AData.AddType(TComboExItemsClass_sw, ComCtrls_TComboExItemsClass_si);
  AData.AddType(TComboExItemClass_sw, ComCtrls_TComboExItemClass_si);
  AData.AddType(TComboBoxExStrings_sw, ComCtrls_TComboBoxExStrings_si);
  AData.AddType(TComboBoxExStringsClass_sw, ComCtrls_TComboBoxExStringsClass_si);
  AData.AddType(TComboBoxExStyle_sw, ComCtrls_TComboBoxExStyle_si);
  AData.AddType(TComboBoxExStyleEx_sw, ComCtrls_TComboBoxExStyleEx_si);
  AData.AddType(TComboBoxExStyles_sw, ComCtrls_TComboBoxExStyles_si);
  AData.AddType(TAutoCompleteOption_sw, ComCtrls_TAutoCompleteOption_si);
  AData.AddType(TAutoCompleteOptions_sw, ComCtrls_TAutoCompleteOptions_si);
  AData.AddType(TCustomComboBoxEx_sw, ComCtrls_TCustomComboBoxEx_si);
  AData.AddType(TComboBoxEx_sw, ComCtrls_TComboBoxEx_si);
  AData.AddType(TComboBoxExActionLink_sw, ComCtrls_TComboBoxExActionLink_si);
  AData.AddFunction('InitCommonControl', ComCtrls_InitCommonControl_si, Boolean_sw, 1, False);
  AData.AddProcedure('CheckCommonControl', ComCtrls_CheckCommonControl_si, 1, False);
  AData.AddConstant('ComCtlVersionIE3', ComCtrls_ComCtlVersionIE3_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE3));
  AData.AddConstant('ComCtlVersionIE4', ComCtrls_ComCtlVersionIE4_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE4));
  AData.AddConstant('ComCtlVersionIE401', ComCtrls_ComCtlVersionIE401_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE401));
  AData.AddConstant('ComCtlVersionIE5', ComCtrls_ComCtlVersionIE5_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE5));
  AData.AddConstant('ComCtlVersionIE501', ComCtrls_ComCtlVersionIE501_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE501));
  AData.AddConstant('ComCtlVersionIE6', ComCtrls_ComCtlVersionIE6_si, nil, VarType(Vcl.ComCtrls.ComCtlVersionIE6));
  AData.AddFunction('GetComCtlVersion', ComCtrls_GetComCtlVersion_si, Integer_sw, 0, False);
  AData.AddProcedure('CheckToolMenuDropdown', ComCtrls_CheckToolMenuDropdown_si, 1, False);
end;

class function ComCtrls_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ComCtrls_sw);
end;

initialization
  RegisterUnitWrapper(ComCtrls_sw);
  RegisterClassWrapper(TCustomTabControl_sw);
  RegisterClassWrapper(TTabControl_sw);
  RegisterClassWrapper(TTabSheet_sw);
  RegisterClassWrapper(TPageControl_sw);
  RegisterClassWrapper(TStatusPanel_sw);
  RegisterClassWrapper(TStatusPanels_sw);
  RegisterClassWrapper(TCustomStatusBar_sw);
  RegisterClassWrapper(TStatusBar_sw);
  RegisterClassWrapper(THeaderSection_sw);
  RegisterClassWrapper(THeaderSections_sw);
  RegisterClassWrapper(TCustomHeaderControl_sw);
  RegisterClassWrapper(THeaderControl_sw);
  RegisterClassWrapper(TTreeNode_sw);
  RegisterClassWrapper(TTreeNodesEnumerator_sw);
  RegisterClassWrapper(TTreeNodes_sw);
  RegisterClassWrapper(ETreeViewError_sw);
  RegisterClassWrapper(TCustomTreeView_sw);
  RegisterClassWrapper(TTreeView_sw);
  RegisterClassWrapper(TTrackBar_sw);
  RegisterClassWrapper(TProgressBar_sw);
  RegisterClassWrapper(TTextAttributes_sw);
  RegisterClassWrapper(TParaAttributes_sw);
  RegisterClassWrapper(TConversion_sw);
  RegisterClassWrapper(TCustomRichEdit_sw);
  RegisterClassWrapper(TRichEdit_sw);
  RegisterClassWrapper(TCustomUpDown_sw);
  RegisterClassWrapper(TUpDown_sw);
  RegisterClassWrapper(TCustomHotKey_sw);
  RegisterClassWrapper(THotKey_sw);
  RegisterClassWrapper(TListGroup_sw);
  RegisterClassWrapper(TListGroups_sw);
  RegisterClassWrapper(TListColumn_sw);
  RegisterClassWrapper(TListColumns_sw);
  RegisterClassWrapper(TListItem_sw);
  RegisterClassWrapper(TListItemsEnumerator_sw);
  RegisterClassWrapper(TListItems_sw);
  RegisterClassWrapper(TWorkArea_sw);
  RegisterClassWrapper(TWorkAreas_sw);
  RegisterClassWrapper(TIconOptions_sw);
  RegisterClassWrapper(TCustomListView_sw);
  RegisterClassWrapper(TListView_sw);
  RegisterClassWrapper(TListViewActionLink_sw);
  RegisterClassWrapper(TAnimate_sw);
  RegisterClassWrapper(TToolButtonActionLink_sw);
  RegisterClassWrapper(TToolButton_sw);
  RegisterClassWrapper(TToolBarEnumerator_sw);
  RegisterClassWrapper(TToolBar_sw);
  RegisterClassWrapper(TToolBarDockObject_sw);
  RegisterClassWrapper(TCoolBand_sw);
  RegisterClassWrapper(TCoolBands_sw);
  RegisterClassWrapper(TCoolBar_sw);
  RegisterClassWrapper(ECommonCalendarError_sw);
  RegisterClassWrapper(TMonthCalColors_sw);
  RegisterClassWrapper(TCommonCalendar_sw);
  RegisterClassWrapper(EMonthCalError_sw);
  RegisterClassWrapper(TMonthCalendar_sw);
  RegisterClassWrapper(EDateTimeError_sw);
  RegisterClassWrapper(TDateTimePicker_sw);
  RegisterClassWrapper(TPageScroller_sw);
  RegisterClassWrapper(TComboExItem_sw);
  RegisterClassWrapper(TComboExItems_sw);
  RegisterClassWrapper(TComboBoxExStrings_sw);
  RegisterClassWrapper(TCustomComboBoxEx_sw);
  RegisterClassWrapper(TComboBoxEx_sw);
  RegisterClassWrapper(TComboBoxExActionLink_sw);
  RegisterEventWrapper(TypeInfo(TTabChangingEvent), TTabChangingEvent_sw);
  RegisterEventWrapper(TypeInfo(TDrawTabEvent), TDrawTabEvent_sw);
  RegisterEventWrapper(TypeInfo(TTabGetImageEvent), TTabGetImageEvent_sw);
  RegisterEventWrapper(TypeInfo(TCustomDrawPanelEvent), TCustomDrawPanelEvent_sw);
  RegisterEventWrapper(TypeInfo(TSBCreatePanelClassEvent), TSBCreatePanelClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TDrawPanelEvent), TDrawPanelEvent_sw);
  RegisterEventWrapper(TypeInfo(TCustomDrawSectionEvent), TCustomDrawSectionEvent_sw);
  RegisterEventWrapper(TypeInfo(TCustomSectionNotifyEvent), TCustomSectionNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TCustomSectionTrackEvent), TCustomSectionTrackEvent_sw);
  RegisterEventWrapper(TypeInfo(TSectionDragEvent), TSectionDragEvent_sw);
  RegisterEventWrapper(TypeInfo(TCustomHCCreateSectionClassEvent), TCustomHCCreateSectionClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TDrawSectionEvent), TDrawSectionEvent_sw);
  RegisterEventWrapper(TypeInfo(TSectionNotifyEvent), TSectionNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TSectionTrackEvent), TSectionTrackEvent_sw);
  RegisterEventWrapper(TypeInfo(THCCreateSectionClassEvent), THCCreateSectionClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVChangingEvent), TTVChangingEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVChangedEvent), TTVChangedEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVEditingEvent), TTVEditingEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVEditedEvent), TTVEditedEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVExpandingEvent), TTVExpandingEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVCollapsingEvent), TTVCollapsingEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVExpandedEvent), TTVExpandedEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVCompareEvent), TTVCompareEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVHintEvent), TTVHintEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVCustomDrawEvent), TTVCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVAdvancedCustomDrawEvent), TTVAdvancedCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TTVCreateNodeClassEvent), TTVCreateNodeClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TRichEditResizeEvent), TRichEditResizeEvent_sw);
  RegisterEventWrapper(TypeInfo(TRichEditProtectChange), TRichEditProtectChange_sw);
  RegisterEventWrapper(TypeInfo(TRichEditSaveClipboard), TRichEditSaveClipboard_sw);
  RegisterEventWrapper(TypeInfo(TUDClickEvent), TUDClickEvent_sw);
  RegisterEventWrapper(TypeInfo(TUDChangingEvent), TUDChangingEvent_sw);
  RegisterEventWrapper(TypeInfo(TUDChangingEventEx), TUDChangingEventEx_sw);
  RegisterEventWrapper(TypeInfo(TLVDeletedEvent), TLVDeletedEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVEditingEvent), TLVEditingEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVEditedEvent), TLVEditedEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVChangeEvent), TLVChangeEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVChangingEvent), TLVChangingEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVColumnClickEvent), TLVColumnClickEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVColumnRClickEvent), TLVColumnRClickEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVCompareEvent), TLVCompareEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVNotifyEvent), TLVNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVSelectItemEvent), TLVSelectItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVCheckedItemEvent), TLVCheckedItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVCustomDrawEvent), TLVCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVAdvancedCustomDrawEvent), TLVAdvancedCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVOwnerDataEvent), TLVOwnerDataEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVOwnerDataHintEvent), TLVOwnerDataHintEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVOwnerDataStateChangeEvent), TLVOwnerDataStateChangeEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVSubItemImageEvent), TLVSubItemImageEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVInfoTipEvent), TLVInfoTipEvent_sw);
  RegisterEventWrapper(TypeInfo(TLVCreateItemClassEvent), TLVCreateItemClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TTBCustomDrawEvent), TTBCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TTBAdvancedCustomDrawEvent), TTBAdvancedCustomDrawEvent_sw);
  RegisterEventWrapper(TypeInfo(TTBCustomizeQueryEvent), TTBCustomizeQueryEvent_sw);
  RegisterEventWrapper(TypeInfo(TTBNewButtonEvent), TTBNewButtonEvent_sw);
  RegisterEventWrapper(TypeInfo(TTBButtonEvent), TTBButtonEvent_sw);
  RegisterEventWrapper(TypeInfo(TOnGetMonthInfoEvent), TOnGetMonthInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TOnGetMonthBoldInfoEvent), TOnGetMonthBoldInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TDTParseInputEvent), TDTParseInputEvent_sw);

end.
