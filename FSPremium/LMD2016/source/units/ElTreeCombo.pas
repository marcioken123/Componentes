unit ElTreeCombo;
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

ElTreeCombo unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

July 2007 (EV):

[+] ShowImagesInText: Defines whether to show the images in main text. Images
    from tree's Images will be used.
[+] ImageIndex: ImageIndex for text's image. Leave '-1' if you want to use
    ImageIndex from selected item.
###############################################################################}

interface

uses
  Windows,
  StdCtrls,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ExtCtrls,
  ImgList,
  CommCtrl,
  UxTheme, Themes,
  ActiveX,
  Types,

  LMDTypes,
  LMDHTMLUnit,
  LMDObjectList,
  LMDClass,
  LMDThemes,
  LMDGlyphs,
  LMDGraphUtils,
  LMDGraph,
  LMDStrings,
  LMDProcs,
  {$ifdef LMD_UNICODE}
  LMDUnicode,
  {$endif}

  ElDragDrop,
  ElStyleMan,
  ElTree,
  ElHeader,
  ElImgLst,
  ElPopBtn,
  ElVCLUtils,
  ElBtnEdit,
  ElSBCtrl,
  ElScrollBar,
  ElTreeInplaceEditors,
  ElIni;

type
  {$EXTERNALSYM TElHeaderSection}
  TElHeaderSection = ElHeader.TElHeaderSection;
  {$EXTERNALSYM TCustomElHeader}
  TCustomElHeader = ElHeader.TCustomElHeader;
  {$EXTERNALSYM TElFieldType}
  TElFieldType = ElHeader.TElFieldType;
  {$EXTERNALSYM TElScrollBarPart}
  TElScrollBarPart = ElSBCtrl.TElScrollBarPart;
  {$EXTERNALSYM TElCellStyle}
  TElCellStyle = ElTree.TElCellStyle;
  {$EXTERNALSYM TElTreeItem}
  TElTreeItem = ElTree.TElTreeItem;
  {$EXTERNALSYM TCustomElTree}
  TCustomElTree = ElTree.TCustomElTree;

  {$EXTERNALSYM TDragType}
  TDragType = ElDragDrop.TDragType;
  {$EXTERNALSYM IDataObject}
  IDataObject = ActiveX.IDataObject;
  {$EXTERNALSYM IDataObject}
  IDropSource = ActiveX.IDropSource;
  {$EXTERNALSYM TDragTypes}
  TDragTypes = ElDragDrop.TDragTypes;
  {$EXTERNALSYM TOleDragObject}
  TOleDragObject = ElDragDrop.TOleDragObject;

type
  TElComboDropEvent = procedure(Sender : TObject; Dropped : boolean) of object;
  TElGetDisplayTextEvent = procedure(Sender : TObject; Item : TElTreeItem; var DisplayText : TElFString) of object;

  TCustomElTreeCombo = class;

  TElTreeComboButton = class(TCustomElGraphicButton)
  protected
    function GetShowGlyph: Boolean; override;
  end;

  TElTreeComboDropDownButton = class(TElTreeComboButton)
  protected
    function GetDetails: TThemedElementDetails; override;
  end;

  TDropdownElTree = class(TCustomElTree)
  private
    FOwner : TCustomElTreeCombo;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure UpdateScrollBars; override;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMGetMinMaxInfo(var Message: TMessage); message WM_GETMINMAXINFO;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
    procedure WMUpdateSBFrame(var Message: TMessage); message WM_UPDATESBFRAME;
  public
    function CanFocus: Boolean;override;
    constructor Create(AOwner : TComponent); override;
    procedure ForceRecreateWnd;
    property Ctl3D;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
  end;

  TElComboBoxStyle = (tcsDropDown, tcsDropDownList);

  TCustomElTreeCombo = class(TCustomElButtonEdit)
  private
    FShowImagesInText: Boolean;
    FTextImageIndex,
    FImageIndex: Integer;
    FStyle: TElComboBoxStyle;
    FOnEditRequest : TEditRequestEvent;
    FOnTreeKeyDown : TKeyEvent;
    FOnTreeKeyPress : TKeyPressEvent;
    FOnTreeKeyUp : TKeyEvent;
    FOnTreeMouseDown : TMouseEvent;
    FOnTreeMouseMove : TMouseMoveEvent;
    FOnTreeMouseUp : TMouseEvent;
    FAutoProcessSelection : Boolean;
    FOnNewTextSelection : TNotifyEvent;
    FDropWidth : Integer;
    FDropHeight : Integer;
    FOnValidateCombo_FTree : TValidateComboEvent;
    FOnCellStyleLoad_FTree : TElCellStyleSaveEvent;
    FOnCellStyleSave_FTree : TElCellStyleSaveEvent;
    FOnComboEditShow_FTree : TComboEditShowEvent;
    FOnHeaderLookup_FTree : TElHeaderLookupEvent;
    FOnHeaderLookupDone_FTree : TElHeaderLookupDoneEvent;
    FOnHeaderResize_FTree : TNotifyEvent;
    FOnHeaderSectionAutoSize_FTree: TColumnNotifyEvent;
    FOnHeaderSectionCollapse_FTree : THeaderSectionEvent;
    FOnHeaderSectionExpand_FTree : THeaderSectionEvent;
    FOnHeaderSectionFilterCall_FTree: TColumnNotifyEvent;
    FOnHorzScrollDrawPart_FTree: TElScrollDrawPartEvent;
    FOnHorzScrollHintNeeded_FTree: TElScrollHintNeededEvent;
    FOnHotTrack_FTree : THotTrackEvent;
    FOnItemLoad_FTree : TElItemSaveEvent;
    FOnItemPicDraw2_FTree : TOnPicDrawEvent;
    FOnItemSave_FTree : TElItemSaveEvent;
    FOnItemSelectedChange_FTree : TItemSelChangeEvent;

{.$IFNDEF B _3}
{.$IFNDEF V ER90}
    FOnOleDragFinish_FTree : TOleDragFinishEvent;
    FOnOleDragStart_FTree : TOleDragStartEvent;
    FOnOleTargetDrag_FTree : TTargetDragEvent;
    FOnOleTargetDrop_FTree : TTargetDropEvent;
{.$ENDIF}
{.$ENDIF}

    FOnResize_FTree: TNotifyEvent;
    FOnScroll_FTree: ElTree.TElScrollEvent;
    FOnTryEdit_FTree : TTryEditEvent;
    FOnValidateInplaceEdit_FTree : TOnValidateEvent;
    FOnVertScrollDrawPart_FTree: TElScrollDrawPartEvent;
    FOnVertScrollHintNeeded_FTree: TElScrollHintNeededEvent;
    //FEdit : TEdit;
    FSaveCursor,
    FSaveCursor1 : TCursor;
    FOwnReadOnly : Boolean;
    FDropped : Boolean;
    FOnDrop : TElComboDropEvent;
    FTree : TDropdownElTree;
    FTSelection : TElTreeItem;
    FTSelectionList : TLMDObjectList;
    IgnoreDrop  : boolean;
    FMouseDown  : boolean;
    FSaveCapture: HWND;
    { Exposed Events: }
    FOnCompareItems : TOnCompareItems;
    FOnHeaderColumnClick : TColumnNotifyEvent;
    FOnHeaderColumnDraw : TElSectionRedrawEvent;
    FOnHeaderColumnMove : TElColumnMoveEvent;
    FOnHeaderColumnResize : TColumnNotifyEvent;
    FOnItemChange : TOnItemChangeEvent;
    FOnItemCollapse : TOnItemExpandEvent;
    FOnItemCollapsing : TOnItemExpanding;
    FOnItemDeletion : TOnItemExpandEvent;
    FOnItemDraw : TOnItemDrawEvent;
    FOnItemExpand : TOnItemExpandEvent;
    FOnItemExpanding : TOnItemExpanding;
    FOnItemFocused : TNotifyEvent;
    FOnItemPicDraw : TOnPicDrawEvent;
    FOnShowLineHint : TOnShowHintEvent;
    FOnStartDrag_FTree : TStartDragEvent;
    // Iterator
    procedure IntSelect(Item : TElTreeItem; Index : integer; var ContinueIterate : boolean;
      IterateData : TLMDDataTag; Tree : TCustomElTree);

    function GetSelection : TElTreeItem;
    procedure SetSelection(Value : TElTreeItem);
    function GetSelectionList : TLMDObjectList;
    { Inherited properties' Read/Write methods: }
    procedure SetAutoLineHeight_FTree(Value : Boolean);
    function GetAutoLineHeight_FTree : Boolean;
    procedure SetBkColor_FTree(Value : TColor);
    function GetBkColor_FTree : TColor;
    procedure SetChangeStateImage_FTree(Value : Boolean);
    function GetChangeStateImage_FTree : Boolean;
    procedure SetCtl3D_FTree(Value : Boolean);
    function GetCtl3D_FTree : Boolean;
    procedure SetCursor(Value : TCursor);
    function GetCursor : TCursor;
    procedure SetDraggableSections(Value : Boolean);
    function GetDraggableSections : Boolean;
    procedure SetFont_FTree(Value : TFont);
    function GetFont_FTree : TFont;
    procedure SetHeaderHotTrack_FTree(Value : Boolean);
    function GetHeaderHotTrack_FTree : Boolean;
//    procedure SetHeaderImages_FTree(Value : TCustomImageList);
//    function GetHeaderImages_FTree : TCustomImageList;
    procedure SetHeaderSections_FTree(Value : TElHeaderSections);
    function GetHeaderSections_FTree : TElHeaderSections;
    procedure SetHideHintOnMove_FTree(Value : Boolean);
    function GetHideHintOnMove_FTree : Boolean;
    procedure SetHideHintOnTimer_FTree(Value : Boolean);
    function GetHideHintOnTimer_FTree : Boolean;
    procedure SetHideHorzScrollBar_FTree(Value : Boolean);
    function GetHideHorzScrollBar_FTree : Boolean;
    procedure SetHideVertScrollBar_FTree(Value : Boolean);
    function GetHideVertScrollBar_FTree : Boolean;
    procedure SetHorizontalLines_FTree(Value : Boolean);
    function GetHorizontalLines_FTree : Boolean;
    procedure SetImages_FTree(Value : TCustomImageList);
    function GetImages_FTree : TCustomImageList;
    procedure SetAlphaImages_FTree(Value : TCustomImageList);
    function GetAlphaImages_FTree : TCustomImageList;
    procedure SetItems_FTree(Value : TElTreeItems);
    function GetItems_FTree : TElTreeItems;
    procedure SetLineHintMode(Value : THintModes);
    function GetLineHintMode : THintModes;
    procedure SetMainTreeColumn(Value : Integer);
    function GetMainTreeColumn : Integer;
    procedure SetMultiSelect(Value : Boolean);
    function GetMultiSelect : Boolean;
    procedure SetOwnerDrawByColumn(Value : Boolean);
    function GetOwnerDrawByColumn : Boolean;
    procedure SetOwnerDrawMask(Value: TLMDString);
    function GetOwnerDrawMask: TLMDString;
    procedure SetParentCtl3D(Value : Boolean);
    function GetParentCtl3D : Boolean;
    procedure SetParentFont(Value : Boolean);
    function GetParentFont : Boolean;
    procedure SetParentShowHint(Value : Boolean);
    function GetParentShowHint : Boolean;
    procedure SetRowSelect(Value : Boolean);
    function GetRowSelect : Boolean;
    procedure SetHorzScrollTracking(Value : Boolean);
    function GetHorzScrollTracking: Boolean;
    procedure SetSelectionMode(Value : TSTSelModes);
    function GetSelectionMode : TSTSelModes;
    procedure SetShowButtons(Value : Boolean);
    function GetShowButtons : Boolean;
    procedure SetShowColumns(Value : Boolean);
    function GetShowColumns : Boolean;
    procedure SetShowHint(Value : Boolean);
    function GetShowHint : Boolean;
    procedure SetShowImages(Value : Boolean);
    function GetShowImages : Boolean;
    procedure SetShowLines(Value : Boolean);
    function GetShowLines : Boolean;
    procedure SetShowRoot(Value : Boolean);
    function GetShowRoot : Boolean;
    procedure SetSortDir(Value : TSortDirs);
    function GetSortDir : TSortDirs;
    procedure SetSortMode(Value : TSortModes);
    function GetSortMode : TSortModes;
    procedure SetSortSection(Value : Integer);
    function GetSortSection : Integer;
    procedure SetSortType(Value : TSortTypes);
    function GetSortType : TSortTypes;
    procedure Tree_SetTextColor(Value : TColor);
    function Tree_GetTextColor : TColor;
    procedure SetTracking(Value : Boolean);
    function GetTracking : Boolean;
    procedure SetVerticalLines(Value : Boolean);
    function GetVerticalLines : Boolean;
    procedure ButtonClick(Sender : TObject);
    procedure CompareItemsTransfer(Sender : TObject; Item1 : TElTreeItem; Item2 : TElTreeItem; var res : Integer); { TOnCompareItems }
    procedure ClickHandler(Sender : TObject); { TNotifyEvent }
    procedure HeaderColumnClickTransfer(Sender : TObject; SectionIndex : Integer); { TColumnNotifyEvent }
    procedure HeaderColumnDrawTransfer(Sender : TCustomElHeader; Canvas : TCanvas; Section : TElHeaderSection; R : TRect; Pressed : Boolean); { TElSectionRedrawEvent }
    procedure HeaderColumnMoveTransfer(Sender : TCustomElTree; Section : TElHeaderSection; OldPos : Integer; NewPos : Integer); { TElColumnMoveEvent }
    procedure HeaderColumnResizeTransfer(Sender : TObject; SectionIndex : Integer); { TColumnNotifyEvent }
    procedure ItemChangeTransfer(Sender : TObject; Item : TElTreeItem; ItemChangeMode : TItemChangeMode); { TOnItemChangeEvent }
    procedure ItemCollapseTransfer(Sender : TObject; Item : TElTreeItem); { TOnItemExpandEvent }
    procedure ItemCollapsingTransfer(Sender : TObject; Item : TElTreeItem; var CanProcess : Boolean); { TOnItemExpanding }
    procedure ItemDeletionTransfer(Sender : TObject; Item : TElTreeItem); { TOnItemExpandEvent }
    procedure ItemDrawTransfer(Sender : TObject; Item : TElTreeItem; Surface : TCanvas; R : TRect; SectionIndex : Integer); { TOnItemDrawEvent }
    procedure ItemExpandTransfer(Sender : TObject; Item : TElTreeItem); { TOnItemExpandEvent }
    procedure ItemExpandingTransfer(Sender : TObject; Item : TElTreeItem; var CanProcess : Boolean); { TOnItemExpanding }
    procedure ItemFocusedTransfer(Sender : TObject); { TNotifyEvent }
    procedure ItemPicDrawTransfer(Sender : TObject; Item : TElTreeItem; var ImageIndex : Integer); { TOnPicDrawEvent }
    procedure KeyDownHandler(Sender : TObject; var Key : Word; Shift : TShiftState); { TKeyEvent }
    procedure ShowLineHintTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; var Text : TLMDString; HintWindow : THintWindow; MousePos : TPoint; var DoShowHint : Boolean); { TOnShowHintEvent }
    procedure TreeResizeTransfer(Sender: TObject);
    procedure ScrollTransfer(Sender: TObject; ScrollBarKind: TScrollBarKind; ScrollCode: integer);
    procedure SetLineHeight_FTree(Value : Integer);
    function GetLineHeight_FTree : Integer;
    //function GetTextHeight: Integer;
    function GetCReadOnly : Boolean;
    procedure SetCReadOnly(Value : Boolean);
    procedure CMEnter(var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
    procedure SetAlwaysKeepSelection_FTree(Value : Boolean);
    function GetAlwaysKeepSelection_FTree : Boolean;
    procedure SetAutoExpand_FTree(Value : Boolean);
    function GetAutoExpand_FTree : Boolean;
    procedure SetAutoLookup_FTree(Value : Boolean);
    function GetAutoLookup_FTree : Boolean;
    procedure SetBarStyle_FTree(Value : Boolean);
    function GetBarStyle_FTree : Boolean;
    procedure SetCustomPlusMinus_FTree(Value : Boolean);
    function GetCustomPlusMinus_FTree : Boolean;
    procedure SetDeselectChildrenOnCollapse_FTree(Value : Boolean);
    function GetDeselectChildrenOnCollapse_FTree : Boolean;
    procedure SetTreeDragImageMode(Value : TDragImgMode);
    function GetTreeDragImageMode : TDragImgMode;
    procedure SetTreeDrawFocusRect(Value : Boolean);
    function GetTreeDrawFocusRect : Boolean;
    procedure SetTreeFullRowSelect(Value : Boolean);
    function GetTreeFullRowSelect : Boolean;
    procedure SetTreeImages2(Value : TCustomImageList);
    function GetTreeImages2 : TCustomImageList;
    procedure SetAlphaTreeImages2(Value : TCustomImageList);
    function GetAlphaTreeImages2 : TCustomImageList;
    procedure SetMinusPicture_FTree(Value : TBitmap);
    function GetMinusPicture_FTree : TBitmap;
    procedure SetPlusPicture_FTree(Value : TBitmap);
    function GetPlusPicture_FTree : TBitmap;
    procedure SetShowCheckboxes_FTree(Value : Boolean);
    function GetShowCheckboxes_FTree : Boolean;
    procedure SetStickyHeaderSections_FTree(Value : Boolean);
    function GetStickyHeaderSections_FTree : Boolean;
    procedure SetStoragePath_FTree(Value : string);
    function GetStoragePath_FTree : string;
    procedure CellStyleLoad_FTreeTransfer(Sender : TObject; Stream : TStream; Style : TElCellStyle); { TCellStyleSaveEvent }
    procedure CellStyleSave_FTreeTransfer(Sender : TObject; Stream : TStream; Style : TElCellStyle); { TCellStyleSaveEvent }
    procedure ComboEditShow_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; Combobox : TComboBox); { TComboEditShowEvent }
    procedure HeaderLookup_FTreeTransfer(Sender : TObject; Section : TElHeaderSection; var Text : TLMDString); { TElHeaderLookupEvent }
    procedure HeaderLookupDone_FTreeTransfer(Sender : TObject; Section : TElHeaderSection; Text : TLMDString; Accepted : Boolean); { TElHeaderLookupDoneEvent }
    procedure HeaderResize_FTreeTransfer(Sender : TObject); { TNotifyEvent }
    procedure HeaderSectionAutoSize_FTreeTransfer(Sender: TObject; SectionIndex: integer);
    procedure HeaderSectionCollapse_FTreeTransfer(Sender : TObject; Section : TElHeaderSection); { THeaderSectionEvent }
    procedure HeaderSectionExpand_FTreeTransfer(Sender : TObject; Section : TElHeaderSection); { THeaderSectionEvent }
    procedure HeaderSectionFilterCall_FTreeTransfer(Sender: TObject; SectionIndex: integer);
    procedure HorzScrollDrawPart_FTreeTransfer(Sender : TObject; Canvas : TCanvas;
      R : TRect; Part : TElScrollBarPart; Enabled, Focused, Pressed : boolean;
      var DefaultDraw : boolean);
    procedure HorzScrollHintNeeded_FTreeTransfer(Sender : TObject; TrackPosition : integer; var Hint : TLMDString);
    procedure HotTrack_FTreeTransfer(Sender : TObject; OldItem : TElTreeItem; NewItem : TElTreeItem); { THotTrackEvent }
    procedure ItemLoad_FTreeTransfer(Sender : TObject; Stream : TStream; Item : TElTreeItem); { TItemSaveEvent }
    procedure ItemPicDraw2_FTreeTransfer(Sender : TObject; Item : TElTreeItem; var ImageIndex : Integer); { TOnPicDrawEvent }
    procedure ItemSave_FTreeTransfer(Sender : TObject; Stream : TStream; Item : TElTreeItem); { TItemSaveEvent }
    procedure ItemSelectedChange_FTreeTransfer(Sender : TObject; Item : TElTreeItem); { TItemSelChangeEvent }

{.$IFNDEF B _3}
{.$IFNDEF V ER90}
    procedure OleDragFinish_FTreeTransfer(Sender : TObject; dwEffect : TDragType; Result : HRESULT); { TOleDragFinishEvent }
    procedure OleDragStart_FTreeTransfer(Sender : TObject; var dataObj : IDataObject; var dropSource : IDropSource; var dwOKEffects : TDragTypes); { TOleDragStartEvent }
    procedure OleTargetDrag_FTreeTransfer(Sender : TObject; State : TDragState; Source : TOleDragObject; Shift : TShiftState; X : Integer; Y : Integer; var DragType : TDragType); { TTargetDragEvent }
    procedure OleTargetDrop_FTreeTransfer(Sender : TObject; Source : TOleDragObject; Shift : TShiftState; X : Integer; Y : Integer; var DragType : TDragType); { TTargetDropEvent }
{.$ENDIF}
{.$ENDIF}

    procedure TryEdit_FTreeTransfer(Sender : TObject; Item : TElTreeItem; SectionIndex : integer; var CellType : TElFieldType; var CanEdit : Boolean);

    procedure ValidateCombo_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; Combo : TComboBox; var Accept : Boolean); { TValidateComboEvent }
    procedure ValidateInplaceEdit_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; var Text : string; var Accept : Boolean); { TOnValidateEvent }
    procedure VertScrollDrawPart_FTreeTransfer(Sender : TObject; Canvas : TCanvas;
      R : TRect; Part : TElScrollBarPart; Enabled, Focused, Pressed : boolean;
      var DefaultDraw : boolean);
    procedure VertScrollHintNeeded_FTreeTransfer(Sender : TObject; TrackPosition : integer; var Hint : TLMDString);
    procedure PrepareSelection;
    procedure SetDropWidth(Value : Integer);
    procedure SetDropHeight(Value : Integer);
    procedure SetPathSeparator(Value : Char);
    function GetPathSeparator : Char;
    function GetDrawFocusRect_FTree : Boolean;
    procedure SetFilteredVisibility_FTree(Value : Boolean);
    function GetFilteredVisibility_FTree : Boolean;
    procedure SetRightAlignedText_FTree(Value : Boolean);
    function GetRightAlignedText_FTree : Boolean;
    procedure SetRightAlignedTree_FTree(Value : Boolean);
    function GetRightAlignedTree_FTree : Boolean;
    procedure SetCheckBoxGlyph_FTree(Value : TBitmap);
    function GetCheckBoxGlyph_FTree : TBitmap;
    procedure SetCustomCheckboxes_FTree(Value : Boolean);
    function GetCustomCheckboxes_FTree : Boolean;
    procedure SetRadioButtonGlyph_FTree(Value : TBitmap);
    function GetRadioButtonGlyph_FTree : TBitmap;
    procedure SetUnderlineTracked_FTree(Value : Boolean);
    function GetUnderlineTracked_FTree : Boolean;
    procedure SetDoInplaceEdit(Value : Boolean);
    function GetDoInplaceEdit : Boolean;
    procedure TreeKeyDownTransfer(Sender : TObject; var Key : Word; Shift : TShiftState); { TKeyEvent }
    procedure TreeKeyPressTransfer(Sender : TObject; var Key : Char); { TKeyPressEvent }
    procedure TreeKeyUpTransfer(Sender : TObject; var Key : Word; Shift : TShiftState); { TKeyEvent }
    procedure TreeMouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer); { TMouseEvent }
    procedure TreeMouseMoveTransfer(Sender : TObject; Shift : TShiftState; X : Integer; Y : Integer); { TMouseMoveEvent }
    procedure TreeMouseUpTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer); { TMouseEvent }
    procedure SetShowRootButtons(Value : Boolean);
    function GetShowRootButtons : Boolean;
    procedure EditRequestTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection); { TEditRequestEvent }
    procedure SetTreeFlat(Value : Boolean);
    function GetTreeFlat : Boolean;
    procedure SetTreeHeaderActiveFilterColor(Value : TColor);
    function GetTreeHeaderActiveFilterColor : TColor;
    procedure SetTreeHeaderFilterColor(Value : TColor);
    function GetTreeHeaderFilterColor : TColor;
    procedure SetTreeHeaderFlat(Value : Boolean);
    function GetTreeHeaderFlat : Boolean;
    procedure SetAutoResizeColumns(Value : Boolean);
    function GetAutoResizeColumns : Boolean;
    procedure SetTreeBackground(Value : TBitmap);
    function GetTreeBackground : TBitmap;
    procedure SetTreeBackgroundType(Value : TLMDBackgroundType);
    function GetTreeBackgroundType : TLMDBackgroundType;
    procedure SetFlatFocusedScrollbars(Value : Boolean);
    function GetFlatFocusedScrollbars : Boolean;
    procedure SetGradientEndColor(Value : TColor);
    function GetGradientEndColor : TColor;
    procedure SetGradientStartColor(Value : TColor);
    function GetGradientStartColor : TColor;
    procedure SetGradientSteps(Value : Integer);
    function GetGradientSteps : Integer;
    procedure SetHorzScrollBarStyles(Value : TElScrollBarStyles);
    function GetHorzScrollBarStyles : TElScrollBarStyles;
    procedure SetVertScrollBarStyles(Value : TElScrollBarStyles);
    function GetVertScrollBarStyles : TElScrollBarStyles;
    function GetForcedScrollBars: TScrollStyle;
    procedure SetForcedScrollBars(const Value: TScrollStyle);
    function GetTreeHeaderHeight: integer;
    procedure SetTreeHeaderHeight(const Value: integer);
    function GetHeaderInvertSortArrows_FTree: boolean;
    procedure SetHeaderInvertSortArrows_FTree(const Value: boolean);
    function GetLeftPosition_FTree: integer;
    procedure SetLeftPosition_FTree(const Value: integer);
    function GetLinesColor_FTree: TColor;
    function GetLinesStyle_FTree: TPenStyle;
    procedure SetLinesColor_FTree(const Value: TColor);
    procedure SetLinesStyle_FTree(const Value: TPenStyle);
    function GetLockHeaderHeight_FTree: boolean;
    procedure SetLockHeaderHeight_FTree(const Value: boolean);
    function GetMoveColumnOnDrag_FTree: boolean;
    function GetMoveFocusOnCollapse_FTree: boolean;
    procedure SetMoveColumnOnDrag_FTree(const Value: boolean);
    procedure SetMoveFocusOnCollapse_FTree(const Value: boolean);
    function GetSelectColumn: integer;
    procedure SetSelectColumn(const Value: integer);
    procedure StartDrag_FTreeTransfer(Sender: TObject;
      var DragObject: TDragObject);
    function GetTreeActiveBorderType: TElFlatBorderType;
    function GetTreeInactiveBorderType: TElFlatBorderType;
    procedure SetTreeActiveBorderType(const Value: TElFlatBorderType);
    procedure SetTreeInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetStorage_FTree(Value : TElIniFile);
    function  GetStorage_FTree : TElIniFile;
    function GetAlwaysKeepFocus: Boolean;
    procedure SetAlwaysKeepFocus(Value: Boolean);
    function GetAdjustMultilineHeight: Boolean;
    procedure SetAdjustMultilineHeight(Value: Boolean);
    procedure SetBarStyleVerticalLines(Value: Boolean);
    function GetBarStyleVerticalLines: Boolean;
    function GetChangeDelay: Integer;
    procedure SetChangeDelay(Value: Integer);
    function GetHorzDivLinesColor: TColor;
    procedure SetHorzDivLinesColor(Value: TColor);
    function GetDragTrgDrawMode: TDragTargetDraw;
    procedure SetDragTrgDrawMode(Value: TDragTargetDraw);
    function GetDragExpandDelay: Integer;
    procedure SetDragExpandDelay(Value: Integer);
    function GetDragRectAcceptColor: TColor;
    procedure SetDragRectAcceptColor(Value: TColor);
    function GetDragRectDenyColor: TColor;
    procedure SetDragRectDenyColor(Value: TColor);
    function GetExpandOnDragOver: Boolean;
    procedure SetExpandOnDragOver(Value: Boolean);
    function GetHeaderColor: TColor;
    procedure SetHeaderColor(Value: TColor);
    function GetHeaderWrapCaptions: Boolean;
    procedure SetHeaderWrapCaptions(Value: Boolean);
    function GetHideFocusRect: Boolean;
    procedure SetHideFocusRect(Value: Boolean);
    function GetIncrementalSearch: Boolean;
    procedure SetIncrementalSearch(Value: Boolean);
    function GetItemIndent: Integer;
    procedure SetItemIndent(Value: Integer);
    function GetLineHintColor: TColor;
    procedure SetLineHintColor(Value: TColor);
    function GetLineHintTimeout: Integer;
    procedure SetLineHintTimeout(Value: Integer);
    function GetLineHintType: TLineHintType;
    procedure SetLineHintType(Value: TLineHintType);
    function GetPlusMinusTransparent: Boolean;
    procedure SetPlusMinusTransparent(Value: Boolean);
    function GetRightClickSelect: Boolean;
    procedure SetRightClickSelect(Value: Boolean);
    function GetRowHotTrack: Boolean;
    procedure SetRowHotTrack(Value: Boolean);
    function GetScrollbarOpposite: Boolean;
    procedure SetScrollbarOpposite(Value: Boolean);
    function GetTrackColor: TColor;
    procedure SetTrackColor(Value: TColor);
    function GetUseCustomScrollBars: Boolean;
    procedure SetUseCustomScrollBars(Value: Boolean);
    function GetVerticalLinesLong: Boolean;
    procedure SetVerticalLinesLong(Value: Boolean);
    function GetUseSystemHintColors: Boolean;
    procedure SetUseSystemHintColors(Value: Boolean);
    function GetOnHeaderSectionMeasure: TMeasureSectionEVent;
    procedure SetOnHeaderSectionMeasure(Value: TMeasureSectionEVent);
    function GetOnApplyVisFilter: TApplyVisFilterEvent;
    procedure SetOnApplyVisFilter(Value: TApplyVisFilterEvent);
    function GetOnAfterSelectionChange: TNotifyEvent;
    procedure SetOnAfterSelectionChange(Value: TNotifyEvent);
    function GetOnItemChecked: TOnItemCheckedEvent;
    procedure SetOnItemChecked(Value: TOnItemCheckedEvent);
    function GetOnSortBegin: TNotifyEvent;
    procedure SetOnSortBegin(Value: TNotifyEvent);
    function GetOnSortEnd: TNotifyEvent;
    procedure SetOnSortEnd(Value: TNotifyEvent);
    function GetOnHTMLImageNeeded: TElHTMLImageNeededEvent;
    procedure SetOnHTMLImageNeeded(Value: TElHTMLImageNeededEvent);
    function GetStripedOddColor: TColor;
    procedure SetStripedOddColor(Value: TColor);
    function GetStripedEvenColor: TColor;
    procedure SetStripedEvenColor(Value: TColor);
    function GetStripedItems: Boolean;
    procedure SetStripedItems(Value: Boolean);

//    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMSysKeyUp(var Message: TWMSysKeyUp); message WM_SYSKEYUP;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    function GetVertScrollTracking: Boolean;
    procedure SetVertScrollTracking(Value : Boolean);
    procedure SetShowImagesInText(const Value: Boolean);
    procedure SetImageIndex(const Value: Integer);
    procedure CheckTextImageIndex;
  protected
    FNoCompletion: Boolean;
    FShowGripper: Boolean;
    { Protected declarations }
    FCloseOnClick: Boolean;
    FSizeableTree: Boolean;
    FAdjustDropDownPos: Boolean;
    FHandleEditWhenDropped: Boolean;
    FAutoCompletion: Boolean;
    FOnGetDisplayText: TElGetDisplayTextEvent;
    IgnoreFocus : boolean;
    procedure DblClickHandler(Sender : TObject);virtual;
    // function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;
//    function GetPartIDForBackground: integer; override;
    procedure PaintText(Canvas : TCanvas); override;
    procedure Paint; override;
    procedure SetEditRect(Value : TRect); override;
    procedure ChangeBtnGlyph;
    procedure SetDropped(Value : Boolean); virtual;
    procedure ProcessSelect; virtual;
    procedure TriggerDropEvent(Dropped : boolean); virtual;
    procedure TriggerNewTextSelectionEvent; virtual;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    function GetHintType: TElHintType;
    procedure SetHintType(Value: TElHintType);
    procedure WMActivateApp(var Msg : TWMActivateApp); message WM_ACTIVATEAPP;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMButtonDblClk(var Message: TWMMButtonDblClk); message
        WM_LBUTTONDBLCLK;
    procedure EMSetReadOnly(var Msg : TMessage); message EM_SETREADONLY;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure SetFocusedSelectColor(Value: TColor); override;
    procedure SetFocusedSelectTextColor(Value: TColor); override;
    procedure SetHideSelectColor(Value: TColor); override;
    procedure SetHideSelectTextColor(Value: TColor); override;
    procedure SetInheritedReadOnly(Value: Boolean);

    function GetVertDivLinesColor: TColor;
    procedure SetVertDivLinesColor(Value: TColor);
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    function GetHeaderSections: TElHeaderSections;
    procedure SetHeaderSections(Value: TElHeaderSections);
    function GetHeaderImages: TCustomImageList;
    procedure SetHeaderImages(Value: TCustomImageList);
    function GetAlphaHeaderImages: TCustomImageList;
    procedure SetAlphaHeaderImages(Value: TCustomImageList);
    function GetMultiSelectLevel: Integer;
    procedure SetMultiSelectLevel(Value: Integer);
    function GetDragScrollInterval: Integer;
    procedure SetDragScrollInterval(Value: Integer);
    function GetMouseFrameSelect: Boolean;
    procedure SetMouseFrameSelect(Value: Boolean);
    function CreateTree: TCustomElTree; virtual;
    function GetShowLeafButton: Boolean;
    procedure SetShowLeafButton(Value: Boolean);
    function GetLeafPicture: TBitmap;
    procedure SetLeafPicture(Value: TBitmap);
    //function GetExplorerEditMode: Boolean;
    // procedure SetExplorerEditMode(Value: Boolean);
    function GetHeaderFont: TFont;
    procedure SetHeaderFont(Value: TFont);
    function GetHeaderUseTreeFont: Boolean;
    procedure SetHeaderUseTreeFont(Value: Boolean);
    procedure SetShowGripper(Value: Boolean);
    procedure SetSizeableTree(Value: Boolean);
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure Loaded; override;
    function IsButtonWidthStored: Boolean;
    procedure ReselectByText;
    procedure DefineProperties(Filer : TFiler); override;
    procedure ReadTreeFocusedSelectColor(Reader : TReader);
    procedure ReadTreeHeaderImages(Reader : TReader);
    procedure DoChange; override;
    function GetDisplayText(Item : TElTreeItem): TLMDString; virtual;
    function GetTreeStyleManager: TElStyleManager;
    procedure SetTreeStyleManager(Value: TElStyleManager);
    function GetTreeStyleName: string;
    procedure SetTreeStyleName(const Value: string);
    procedure SetStyle(Value: TElComboBoxStyle); virtual;
    procedure ReadScrollTracking(Reader : TReader);
    procedure DestroyWnd; override;
    function GetBkColor: TColor; override;
    function GetTextColor : TColor; override;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    function GetButtonClass: TCustomElGraphicButtonClass; override;
    function GetAltButtonClass: TCustomElGraphicButtonClass; override;

    property OnApplyVisFilter: TApplyVisFilterEvent read GetOnApplyVisFilter write
        SetOnApplyVisFilter;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    property ShowImagesInText: Boolean read FShowImagesInText write SetShowImagesInText default False;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
    function GetTree : TElTree;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property SelectionList : TLMDObjectList read GetSelectionList; { Public }
    property Dropped : Boolean read FDropped write SetDropped; { Public }
    property Selection : TElTreeItem read GetSelection write SetSelection; { Published }
    property Items : TElTreeItems read GetItems_FTree write SetItems_FTree;
    property DoInplaceEdit : Boolean read GetDoInplaceEdit write SetDoInplaceEdit;
    property DeselectChildrenOnCollapse : Boolean read GetDeselectChildrenOnCollapse_FTree write SetDeselectChildrenOnCollapse_FTree;
    property CheckBoxGlyph : TBitmap read GetCheckBoxGlyph_FTree write SetCheckBoxGlyph_FTree;
    property CustomCheckboxes : Boolean read GetCustomCheckboxes_FTree write SetCustomCheckboxes_FTree;
    property AutoExpand : Boolean read GetAutoExpand_FTree write SetAutoExpand_FTree;
    property CustomPlusMinus : Boolean read GetCustomPlusMinus_FTree write SetCustomPlusMinus_FTree;
    property AutoLookup : Boolean read GetAutoLookup_FTree write SetAutoLookup_FTree;
    property ShowCheckboxes : Boolean read GetShowCheckboxes_FTree write SetShowCheckboxes_FTree;
    property DraggableSections : Boolean read GetDraggableSections write SetDraggableSections;
    property DragTrgDrawMode: TDragTargetDraw read GetDragTrgDrawMode write
        SetDragTrgDrawMode;
    property DragExpandDelay: Integer read GetDragExpandDelay write
        SetDragExpandDelay;
    property DragRectAcceptColor: TColor read GetDragRectAcceptColor write
        SetDragRectAcceptColor;
    property DragRectDenyColor: TColor read GetDragRectDenyColor write
        SetDragRectDenyColor;
    property DragScrollInterval: Integer read GetDragScrollInterval write
        SetDragScrollInterval;
    property ExpandOnDragOver: Boolean read GetExpandOnDragOver write
        SetExpandOnDragOver;
{.$IFNDEF B _3}
{.$IFNDEF V ER90}
    property OnOleDragFinish : TOleDragFinishEvent read FOnOleDragFinish_FTree write FOnOleDragFinish_FTree;
    property OnOleDragStart : TOleDragStartEvent read FOnOleDragStart_FTree write FOnOleDragStart_FTree;
    property OnOleTargetDrag : TTargetDragEvent read FOnOleTargetDrag_FTree write FOnOleTargetDrag_FTree;
    property OnOleTargetDrop : TTargetDropEvent read FOnOleTargetDrop_FTree write FOnOleTargetDrop_FTree;
{.$ENDIF}
{.$ENDIF}
    property DragImageMode : TDragImgMode read GetTreeDragImageMode write SetTreeDragImageMode;
    property PlusMinusTransparent: Boolean read GetPlusMinusTransparent write
        SetPlusMinusTransparent;
    property MinusPicture : TBitmap read GetMinusPicture_FTree write SetMinusPicture_FTree;
    property PlusPicture : TBitmap read GetPlusPicture_FTree write SetPlusPicture_FTree;
    property MoveFocusOnCollapse: boolean read GetMoveFocusOnCollapse_FTree write SetMoveFocusOnCollapse_FTree;
    property MultiSelectLevel: Integer read GetMultiSelectLevel write
        SetMultiSelectLevel;
    property MultiSelect : Boolean read GetMultiSelect write SetMultiSelect;
    property PathSeparator : Char read GetPathSeparator write SetPathSeparator;
    property RadioButtonGlyph : TBitmap read GetRadioButtonGlyph_FTree write SetRadioButtonGlyph_FTree;
    property ShowRootButtons : Boolean read GetShowRootButtons write SetShowRootButtons;
    property ShowRoot : Boolean read GetShowRoot write SetShowRoot;
    property Storage : TElIniFile read GetStorage_FTree write SetStorage_FTree;
    property StoragePath : string read GetStoragePath_FTree write SetStoragePath_FTree;
    property OnGetDisplayText: TElGetDisplayTextEvent read FOnGetDisplayText write
        FOnGetDisplayText;
    property OnTryEdit : TTryEditEvent read FOnTryEdit_FTree write FOnTryEdit_FTree;
    property OnComboEditShow : TComboEditShowEvent read FOnComboEditShow_FTree write FOnComboEditShow_FTree;
    property OnItemChecked: TOnItemCheckedEvent read GetOnItemChecked write
        SetOnItemChecked;
    property OnItemCollapse : TOnItemExpandEvent read FOnItemCollapse write FOnItemCollapse;
    property OnItemCollapsing : TOnItemExpanding read FOnItemCollapsing write FOnItemCollapsing;
    property OnItemExpand : TOnItemExpandEvent read FOnItemExpand write FOnItemExpand;
    property OnItemExpanding : TOnItemExpanding read FOnItemExpanding write FOnItemExpanding;
    property OnItemDeletion : TOnItemExpandEvent read FOnItemDeletion write FOnItemDeletion;
    property OnValidateInplaceEdit : TOnValidateEvent read FOnValidateInplaceEdit_FTree write FOnValidateInplaceEdit_FTree;
    property HeaderSections: TElHeaderSections read GetHeaderSections write
        SetHeaderSections;
    property ShowButtons : Boolean read GetShowButtons write SetShowButtons;
    property ShowColumns : Boolean read GetShowColumns write SetShowColumns;
    property Style: TElComboBoxStyle read FStyle write SetStyle default tcsDropDown;
 published
    property ButtonWidth stored IsButtonWidthStored default 16;
    property ButtonFlat default false;
    property ButtonColor default clBtnFace;
    { Exposed subcomponent properties: }
    property AutoLineHeight : Boolean read GetAutoLineHeight_FTree write SetAutoLineHeight_FTree;
    property TreeBkColor : TColor read GetBkColor_FTree write SetBkColor_FTree;
    property TreeChangeStateImage : Boolean read GetChangeStateImage_FTree write SetChangeStateImage_FTree;
    property TreeCtl3D : Boolean read GetCtl3D_FTree write SetCtl3D_FTree;
    property TreeCursor : TCursor read GetCursor write SetCursor;
    property TreeFont : TFont read GetFont_FTree write SetFont_FTree;
    property TreeHeaderHotTrack : Boolean read GetHeaderHotTrack_FTree write SetHeaderHotTrack_FTree;
//    property TreeHeaderImages : TCustomImageList read GetHeaderImages_FTree write SetHeaderImages_FTree;
    property TreeHeaderInvertSortArrows: boolean read GetHeaderInvertSortArrows_FTree write SetHeaderInvertSortArrows_FTree;
    property TreeHeaderSections : TElHeaderSections read GetHeaderSections_FTree write SetHeaderSections_FTree;
    property TreeHideHintOnMove : Boolean read GetHideHintOnMove_FTree write SetHideHintOnMove_FTree;
    property TreeHideHintOnTimer : Boolean read GetHideHintOnTimer_FTree write SetHideHintOnTimer_FTree;
    property TreeHideHorzScrollBar : Boolean read GetHideHorzScrollBar_FTree write SetHideHorzScrollBar_FTree;
    property TreeHideVertScrollBar : Boolean read GetHideVertScrollBar_FTree write SetHideVertScrollBar_FTree;
    property TreeHorizontalLines : Boolean read GetHorizontalLines_FTree write SetHorizontalLines_FTree;
    property TreeLeftPosition: integer read GetLeftPosition_FTree write SetLeftPosition_FTree;
    property Images : TCustomImageList read GetImages_FTree write SetImages_FTree;
    property Images2 : TCustomImageList read GetTreeImages2 write SetTreeImages2;
    property AlphaForImages : TCustomImageList read GetAlphaImages_FTree write SetAlphaImages_FTree;
    property AlphaForImages2 : TCustomImageList read GetAlphaTreeImages2 write SetAlphaTreeImages2;
    property LineHintMode : THintModes read GetLineHintMode write SetLineHintMode;
    property MainTreeColumn : Integer read GetMainTreeColumn write SetMainTreeColumn;
    property OwnerDrawByColumn : Boolean read GetOwnerDrawByColumn write SetOwnerDrawByColumn;
    property OwnerDrawMask: TLMDString read GetOwnerDrawMask write SetOwnerDrawMask;
    property TreeParentCtl3D : Boolean read GetParentCtl3D write SetParentCtl3D;
    property TreeParentFont : Boolean read GetParentFont write SetParentFont;
    property TreeParentShowHint : Boolean read GetParentShowHint write SetParentShowHint;
    property RowSelect : Boolean read GetRowSelect write SetRowSelect;
    property HorzScrollTracking: Boolean read GetHorzScrollTracking write
        SetHorzScrollTracking;
    property SelectColumn: integer read GetSelectColumn write SetSelectColumn;
    property SelectionMode : TSTSelModes read GetSelectionMode write SetSelectionMode;
    property TreeShowHint : Boolean read GetShowHint write SetShowHint;
    property ShowImages : Boolean read GetShowImages write SetShowImages;
    property ShowLines : Boolean read GetShowLines write SetShowLines;
    property SortDir : TSortDirs read GetSortDir write SetSortDir;
    property SortMode : TSortModes read GetSortMode write SetSortMode;
    property SortSection : Integer read GetSortSection write SetSortSection;
    property SortType : TSortTypes read GetSortType write SetSortType;
    property TextColor : TColor read Tree_GetTextColor write Tree_SetTextColor;
    property Tracking : Boolean read GetTracking write SetTracking;
    property VerticalLines : Boolean read GetVerticalLines write SetVerticalLines;
    property AlwaysKeepSelection : Boolean read GetAlwaysKeepSelection_FTree write SetAlwaysKeepSelection_FTree;

    property BarStyle : Boolean read GetBarStyle_FTree write SetBarStyle_FTree;
    property DrawFocusRect : Boolean read GetTreeDrawFocusRect write SetTreeDrawFocusRect;
    property ForcedScrollBars: TScrollStyle read GetForcedScrollBars write SetForcedScrollBars;
    property FullRowSelect : Boolean read GetTreeFullRowSelect write SetTreeFullRowSelect;
    property MoveColumnOnDrag: boolean read GetMoveColumnOnDrag_FTree write SetMoveColumnOnDrag_FTree;
    property StickyHeaderSections : Boolean read GetStickyHeaderSections_FTree write SetStickyHeaderSections_FTree;
    property DropWidth : Integer read FDropWidth write SetDropWidth;
    property DropHeight : Integer read FDropHeight write SetDropHeight default 80;

    property LineHeight : Integer read GetLineHeight_FTree write SetLineHeight_FTree;
    property LinesColor: TColor read GetLinesColor_FTree write SetLinesColor_FTree;
    property LinesStyle: TPenStyle read GetLinesStyle_FTree write SetLinesStyle_FTree;
    property LockHeaderHeight: boolean read GetLockHeaderHeight_FTree write SetLockHeaderHeight_FTree;
    property ReadOnly : Boolean read GetCReadOnly write SetCReadOnly default False; { Published }
    property FilteredVisibility : Boolean read GetFilteredVisibility_FTree write SetFilteredVisibility_FTree;
    property RightAlignedText : Boolean read GetRightAlignedText_FTree write SetRightAlignedText_FTree;
    property RightAlignedTree : Boolean read GetRightAlignedTree_FTree write SetRightAlignedTree_FTree;

    { Exposed subcomponent events: }
    property OnCompareItems : TOnCompareItems read FOnCompareItems write FOnCompareItems;
    property OnHeaderColumnClick : TColumnNotifyEvent read FOnHeaderColumnClick write FOnHeaderColumnClick;
    property OnHeaderColumnDraw : TElSectionRedrawEvent read FOnHeaderColumnDraw write FOnHeaderColumnDraw;
    property OnHeaderColumnMove : TElColumnMoveEvent read FOnHeaderColumnMove write FOnHeaderColumnMove;
    property OnHeaderColumnResize : TColumnNotifyEvent read FOnHeaderColumnResize write FOnHeaderColumnResize;
    property OnItemChange : TOnItemChangeEvent read FOnItemChange write FOnItemChange;
    property OnItemDraw : TOnItemDrawEvent read FOnItemDraw write FOnItemDraw;
    property OnItemFocused : TNotifyEvent read FOnItemFocused write FOnItemFocused;
    property OnItemPicDraw : TOnPicDrawEvent read FOnItemPicDraw write FOnItemPicDraw;
    property OnScroll: ElTree.TElScrollEvent read FOnScroll_FTree write FOnScroll_FTree;
    property OnShowLineHint : TOnShowHintEvent read FOnShowLineHint write FOnShowLineHint;
    property OnTreeResize: TNotifyEvent read FOnResize_FTree write FOnResize_FTree;

    property OnCellStyleLoad : TElCellStyleSaveEvent read FOnCellStyleLoad_FTree write FOnCellStyleLoad_FTree;
    property OnCellStyleSave : TElCellStyleSaveEvent read FOnCellStyleSave_FTree write FOnCellStyleSave_FTree;
    property OnHeaderLookup : TElHeaderLookupEvent read FOnHeaderLookup_FTree write FOnHeaderLookup_FTree;
    property OnHeaderLookupDone : TElHeaderLookupDoneEvent read FOnHeaderLookupDone_FTree write FOnHeaderLookupDone_FTree;
    property OnHeaderResize : TNotifyEvent read FOnHeaderResize_FTree write FOnHeaderResize_FTree;
    property OnHeaderSectionAutoSize: TColumnNotifyEvent read FOnHeaderSectionAutoSize_FTree write FOnHeaderSectionAutoSize_FTree;
    property OnHeaderSectionCollapse : THeaderSectionEvent read FOnHeaderSectionCollapse_FTree write FOnHeaderSectionCollapse_FTree;
    property OnHeaderSectionExpand : THeaderSectionEvent read FOnHeaderSectionExpand_FTree write FOnHeaderSectionExpand_FTree;
    property OnHeaderSectionFilterCall: TColumnNotifyEvent read FOnHeaderSectionFilterCall_FTree write FOnHeaderSectionFilterCall_FTree;
    property OnHorzScrollDrawPart: TElScrollDrawPartEvent read FOnHorzScrollDrawPart_FTree write FOnHorzScrollDrawPart_FTree;
    property OnHorzScrollHintNeeded: TElScrollHintNeededEvent read FOnHorzScrollHintNeeded_FTree write FOnHorzScrollHintNeeded_FTree;
    property OnHotTrack : THotTrackEvent read FOnHotTrack_FTree write FOnHotTrack_FTree;
    property OnItemLoad : TElItemSaveEvent read FOnItemLoad_FTree write FOnItemLoad_FTree;
    property OnItemPicDraw2 : TOnPicDrawEvent read FOnItemPicDraw2_FTree write FOnItemPicDraw2_FTree;
    property OnItemSave : TElItemSaveEvent read FOnItemSave_FTree write FOnItemSave_FTree;
    property OnItemSelectedChange : TItemSelChangeEvent read FOnItemSelectedChange_FTree write FOnItemSelectedChange_FTree;

    property OnValidateCombo : TValidateComboEvent read FOnValidateCombo_FTree write FOnValidateCombo_FTree;
    property OnVertScrollDrawPart: TElScrollDrawPartEvent read FOnVertScrollDrawPart_FTree write FOnVertScrollDrawPart_FTree;
    property OnVertScrollHintNeeded: TElScrollHintNeededEvent read FOnVertScrollHintNeeded_FTree write FOnVertScrollHintNeeded_FTree;
    property OnNewTextSelection : TNotifyEvent read FOnNewTextSelection write FOnNewTextSelection;
    property OnTreeKeyDown : TKeyEvent read FOnTreeKeyDown write FOnTreeKeyDown;
    property OnTreeKeyPress : TKeyPressEvent read FOnTreeKeyPress write FOnTreeKeyPress;
    property OnTreeKeyUp : TKeyEvent read FOnTreeKeyUp write FOnTreeKeyUp;
    property OnTreeMouseDown : TMouseEvent read FOnTreeMouseDown write FOnTreeMouseDown;
    property OnTreeMouseMove : TMouseMoveEvent read FOnTreeMouseMove write FOnTreeMouseMove;
    property OnTreeMouseUp : TMouseEvent read FOnTreeMouseUp write FOnTreeMouseUp;

    property OnDrop : TElComboDropEvent read FOnDrop write FOnDrop;

    property UnderlineTracked : Boolean read GetUnderlineTracked_FTree write SetUnderlineTracked_FTree;
    property AutoProcessSelection : Boolean read FAutoProcessSelection write FAutoProcessSelection default true; { Published }
    property OnEditRequest : TEditRequestEvent read FOnEditRequest write FOnEditRequest;
    property TreeActiveBorderType: TElFlatBorderType read GetTreeActiveBorderType write SetTreeActiveBorderType;
    property TreeFlat : Boolean read GetTreeFlat write SetTreeFlat;
    property TreeHeaderActiveFilterColor : TColor read GetTreeHeaderActiveFilterColor write SetTreeHeaderActiveFilterColor;
    property TreeHeaderFilterColor : TColor read GetTreeHeaderFilterColor write SetTreeHeaderFilterColor;
    property TreeHeaderFlat : Boolean read GetTreeHeaderFlat write SetTreeHeaderFlat;
    property TreeHeaderHeight: integer read GetTreeHeaderHeight write SetTreeHeaderHeight;
    property TreeInactiveBorderType: TElFlatBorderType read GetTreeInactiveBorderType write SetTreeInactiveBorderType;
    property AutoResizeColumns : Boolean read GetAutoResizeColumns write SetAutoResizeColumns;
    property TreeBackground : TBitmap read GetTreeBackground write SetTreeBackground;
    property TreeBackgroundType : TLMDBackgroundType read GetTreeBackgroundType write SetTreeBackgroundType;
    property FlatFocusedScrollbars : Boolean read GetFlatFocusedScrollbars write SetFlatFocusedScrollbars;
    property GradientEndColor : TColor read GetGradientEndColor write SetGradientEndColor;
    property GradientStartColor : TColor read GetGradientStartColor write SetGradientStartColor;
    property GradientSteps : Integer read GetGradientSteps write SetGradientSteps;
    property HorzScrollBarStyles : TElScrollBarStyles read GetHorzScrollBarStyles write SetHorzScrollBarStyles;
    property VertScrollBarStyles : TElScrollBarStyles read GetVertScrollBarStyles write SetVertScrollBarStyles;
    property AlwaysKeepFocus: Boolean read GetAlwaysKeepFocus write
        SetAlwaysKeepFocus;
    property AdjustMultilineHeight: Boolean read GetAdjustMultilineHeight write
        SetAdjustMultilineHeight;
    property BarStyleVerticalLines: Boolean read GetBarStyleVerticalLines write
        SetBarStyleVerticalLines;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay;
    property HorzDivLinesColor: TColor read GetHorzDivLinesColor write
        SetHorzDivLinesColor;
    property HeaderColor: TColor read GetHeaderColor write SetHeaderColor;
    property HeaderWrapCaptions: Boolean read GetHeaderWrapCaptions write
        SetHeaderWrapCaptions;
    property HideFocusRect: Boolean read GetHideFocusRect write SetHideFocusRect;
    property IncrementalSearch: Boolean read GetIncrementalSearch write
        SetIncrementalSearch;
    property ItemIndent: Integer read GetItemIndent write SetItemIndent;
    property LineHintColor: TColor read GetLineHintColor write SetLineHintColor;
    property LineHintTimeout: Integer read GetLineHintTimeout write
        SetLineHintTimeout;
    property LineHintType: TLineHintType read GetLineHintType write SetLineHintType;
    property RightClickSelect: Boolean read GetRightClickSelect write
        SetRightClickSelect;
    property RowHotTrack: Boolean read GetRowHotTrack write SetRowHotTrack;
    property ScrollbarOpposite: Boolean read GetScrollbarOpposite write
        SetScrollbarOpposite;
    property TrackColor: TColor read GetTrackColor write SetTrackColor;
    property UseCustomScrollBars: Boolean read GetUseCustomScrollBars write
        SetUseCustomScrollBars;
    property VerticalLinesLong: Boolean read GetVerticalLinesLong write
        SetVerticalLinesLong;
    property UseSystemHintColors: Boolean read GetUseSystemHintColors write
        SetUseSystemHintColors;
    property OnHeaderSectionMeasure: TMeasureSectionEVent read
        GetOnHeaderSectionMeasure write SetOnHeaderSectionMeasure;
    property OnAfterSelectionChange: TNotifyEvent read GetOnAfterSelectionChange
        write SetOnAfterSelectionChange;
    property OnSortBegin: TNotifyEvent read GetOnSortBegin write SetOnSortBegin;
    property OnSortEnd: TNotifyEvent read GetOnSortEnd write SetOnSortEnd;
    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read GetOnHTMLImageNeeded write SetOnHTMLImageNeeded;
    property StripedOddColor: TColor read GetStripedOddColor write SetStripedOddColor;
    property StripedEvenColor: TColor read GetStripedEvenColor write
        SetStripedEvenColor;
    property StripedItems: Boolean read GetStripedItems write SetStripedItems;
    property HintType: TElHintType read GetHintType write SetHintType;
    property VertDivLinesColor: TColor read GetVertDivLinesColor write
        SetVertDivLinesColor;
    property CloseOnClick: Boolean read FCloseOnClick write FCloseOnClick default
        false;
    property SizeableTree: Boolean read FSizeableTree write SetSizeableTree default
        true;
    property HeaderImages: TCustomImageList read GetHeaderImages write SetHeaderImages;
    property AlphaForHeaderImages: TCustomImageList read GetAlphaHeaderImages write SetAlphaHeaderImages;
    property MouseFrameSelect: Boolean read GetMouseFrameSelect write
        SetMouseFrameSelect;
    property ShowLeafButton: Boolean read GetShowLeafButton write SetShowLeafButton;
    property LeafPicture: TBitmap read GetLeafPicture write SetLeafPicture;
    //property ExplorerEditMode: Boolean read GetExplorerEditMode write
    //     SetExplorerEditMode;
    property HeaderFont: TFont read GetHeaderFont write SetHeaderFont;
    property ShowGripper: Boolean read FShowGripper write SetShowGripper;
    property HeaderUseTreeFont: Boolean read GetHeaderUseTreeFont write
        SetHeaderUseTreeFont;
    property AdjustDropDownPos: Boolean read FAdjustDropDownPos write
        FAdjustDropDownPos default true;
    property HandleEditWhenDropped: Boolean read FHandleEditWhenDropped write
        FHandleEditWhenDropped default false;
    property AutoCompletion: Boolean read FAutoCompletion write FAutoCompletion
        default false;
    property TreeStyleManager: TElStyleManager read GetTreeStyleManager write
        SetTreeStyleManager;
    property TreeStyleName: string read GetTreeStyleName write SetTreeStyleName;
    property VertScrollTracking: Boolean read GetVertScrollTracking write
        SetVertScrollTracking;
  end; { TCustomElTreeCombo }

  TElTreeCombo = class(TCustomElTreeCombo)
  published
    property ShowImagesInText;
    property ImageIndex;
    property Style;
    property StressShortCut;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Items;
    property DoInplaceEdit;
    property DeselectChildrenOnCollapse;
    property CheckBoxGlyph;
    property CustomCheckboxes;
    property AutoExpand;
    property CustomPlusMinus;
    property AutoLookup;
    property ShowCheckboxes;
    property DraggableSections;
    property DragTrgDrawMode;
    property DragExpandDelay;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property ExpandOnDragOver;
{.$IFNDEF B _3}
{.$IFNDEF V ER90}
    property OnOleDragFinish;
    property OnOleDragStart;
    property OnOleTargetDrag;
    property OnOleTargetDrop;
{.$ENDIF}
{.$ENDIF}
    property DragImageMode;
    property PlusMinusTransparent;
    property MinusPicture;
    property PlusPicture;
    property MoveFocusOnCollapse;
    property MultiSelectLevel;
    property MultiSelect;
    property PathSeparator;
    property RadioButtonGlyph;
    property ShowRootButtons;
    property ShowRoot;
    property Storage;
    property StoragePath;
    property OnGetDisplayText;
    property OnTryEdit;
    property OnComboEditShow;
    property OnItemChecked;
    property OnItemCollapse;
    property OnItemCollapsing;
    property OnItemExpand ;
    property OnItemExpanding;
    property OnItemDeletion;
    property OnValidateInplaceEdit;
    property HeaderSections;
    property ShowButtons;
    property ShowColumns;

// inherited properties
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonEnabled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;

    property OnButtonClick;

    property AltButtonCaption;

    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;

    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property AltButtonPngGlyph;
    property AltButtonUsePng;
    property OnAltButtonClick;

    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AlignBottom;
    property AutoSelect;
    property AutoSize;
    property RightAlignedView;
    property BorderSides;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property WantTabs;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property ImageForm;
    property WordWrap;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;

    property Align;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Text;
    property TabStop;
    property TabOrder;
    property Visible;

    property UseSystemMenu;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
  end;

implementation

uses ElEdits, ElXPThemedControl;

procedure TDropdownElTree.WMNCHitTest(var Msg : TWMNCHitTest);
var R : TRect;
begin
  R := BoundsRect;
  OffsetRect(R, -Left, -Top);
  if TCustomElTreeCombo(FOwner).FSizeableTree then
  begin
    Msg.Result := HitTest(R, ScreenToClient(SmallPointToPoint(Msg.Pos)), (R.Bottom - R.Top) div 4, GetSystemMetrics(SM_CYEDGE));
    if ((Msg.Result = HTBOTTOMLEFT) or
       (Msg.Result = HTLEFT) or
       (Msg.Result = HTTOPLEFT) or
       (Msg.Result = HTTOPRIGHT) or
       (Msg.Result = HTTOP)) then
    begin
      Msg.Result := HTNOWHERE;
    end
    else
    begin
      if TCustomElTreeCombo(FOwner).FShowGripper then
        inherited;
    end;
    if TCustomElTreeCombo(FOwner).FShowGripper then
    begin
      InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
      Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
      R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
        Msg.Result := HTBOTTOMRIGHT;
    end;
  end
  else
    inherited;
end;

procedure TDropdownElTree.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := {(Params.Style and not WS_CHILD) or} WS_POPUP or WS_BORDER;
  Params.ExStyle := WS_EX_TOOLWINDOW;
  if TCustomElTreeCombo(FOwner).FSizeableTree then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := WS_EX_TOOLWINDOW or WS_EX_CLIENTEDGE;
  end
  else
  begin
    Params.ExStyle := WS_EX_TOOLWINDOW;
  end;
  Params.WndParent := GetDesktopWindow;
end;

function TDropdownElTree.CanFocus: Boolean;
begin
  result := false;
end;

procedure TDropdownElTree.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TDropdownElTree.WMExitSizeMove(var Message: TMessage);
var AForm : TCustomForm;
begin
  AForm := GetParentForm(FOwner);
  if (AForm <> nil) and (AForm.CanFocus) then
    AForm.SetFocus;

  Windows.SetFocus(FOwner.Handle);
  FOwner.IgnoreFocus := false;
  inherited;
end;

procedure TDropdownElTree.WMEnterSizeMove(var Message: TMessage);
begin
  inherited;
  FOwner.IgnoreFocus := true;
end;

procedure TDropdownElTree.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if TCustomElTreeCombo(FOwner).FSizeableTree and TCustomElTreeCombo(FOwner).ShowGripper then
  Dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;

procedure TDropdownElTree.WMNCPaint(var Message: TWMNCPaint);
var DC : HDC;
    R: TRect;
    LUseThemeMode: TLMDThemeMode;
    LDetails: TThemedElementDetails;
begin
  inherited;
  LUseThemeMode := UseThemeMode;
  if TCustomElTreeCombo(FOwner).FSizeableTree and TCustomElTreeCombo(FOwner).ShowGripper then
  begin
    R := BoundsRect;
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
    Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    DC := GetWindowDC(Handle);
    if LUseThemeMode <> ttmNone then
    begin
      FillRect(DC, R, HBRUSH(LMDThemeServices.GetThemeSysColor(LUseThemeMode, teComboBox, clBtnFace) + 1));
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      LDetails.Element := teStatus;
      LDetails.Part := SP_GRIPPER;
      LDetails.State := CBS_SCROLLSIZEGRIPRIGHT;
      LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, R, nil);


    end
    else
      DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);

    ReleaseDC(Handle, DC);
  end;
end;

procedure TDropdownElTree.UpdateScrollBars;
begin
  inherited;
  if Visible then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TDropdownElTree.WMSetFocus(var Message: TWMSetFocus);
begin
  Windows.SetFocus(Message.FocusedWnd);
end;

procedure TDropdownElTree.CMParentFontChanged(var Message: TMessage);
begin
  // intentionally left blank
end;

constructor TDropdownElTree.Create(AOwner : TComponent);
begin
  inherited;
  //Flat := false;
  Ctl3D := true;
end;

procedure TDropdownElTree.ForceRecreateWnd;
begin
  RecreateWnd;
end;

procedure TDropdownElTree.WMGetMinMaxInfo(var Message: TMessage);
//var
//  tp : PMinMaxInfo;
begin
  inherited;
  (*
  tp := PMinMaxInfo(Message.LParam);
  tp.ptMinTrackSize.y := FCombo.ItemHeight;
  if FCombo.HorizontalScroll then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  if FCombo.ShowGripper then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYBORDER) * 2);
  Message.Result := 1;
  *)
end;

procedure TDropdownElTree.WMShowWindow(var Message: TWMShowWindow);
begin
  inherited;
end;

procedure TDropdownElTree.WMUpdateSBFrame(var Message: TMessage);
begin
  if Visible then inherited;
end;

function TCustomElTreeCombo.GetSelection : TElTreeItem;
begin
  result := FTSelection;
  // result := FTree.ItemFocused;
end; { GetSelection }

procedure TCustomElTreeCombo.SetSelection(Value : TElTreeItem);
{ Sets data member FSelection to Value. }
begin
  if (Selection <> Value) then
  begin
    FTSelection := Value;
    FTree.ItemFocused := FTSelection;
    if (Selection <> nil) and AutoProcessSelection then
    begin
      Text := GetDisplayText(Selection);
      CheckTextImageIndex;
    end;
  end; { if }
end; { SetSelection }

function TCustomElTreeCombo.GetSelectionList : TLMDObjectList;
begin
  result := FTSelectionList;
end; { GetSelectionList }

{ Inherited properties' Read/Write methods: }

procedure TCustomElTreeCombo.SetAutoLineHeight_FTree(Value : Boolean);
{ Sets the FTree subcomponent's AutoLineHeight property to Value. }
begin
  FTree.AutoLineHeight := Value;
end; { SetAutoLineHeight_FTree }

function TCustomElTreeCombo.GetAutoLineHeight_FTree : Boolean;
begin
  GetAutoLineHeight_FTree := FTree.AutoLineHeight;
end; { GetAutoLineHeight_FTree }

procedure TCustomElTreeCombo.SetBkColor_FTree(Value : TColor);
{ Sets the FTree subcomponent's BkColor property to Value. }
begin
  FTree.BkColor := Value;
end; { SetBkColor_FTree }

function TCustomElTreeCombo.GetBkColor_FTree : TColor;
begin
  GetBkColor_FTree := FTree.BkColor;
end; { GetBkColor_FTree }

procedure TCustomElTreeCombo.SetChangeStateImage_FTree(Value : Boolean);
{ Sets the FTree subcomponent's ChangeStateImage property to Value. }
begin
  FTree.ChangeStateImage := Value;
end; { SetChangeStateImage_FTree }

function TCustomElTreeCombo.GetChangeStateImage_FTree : Boolean;
begin
  GetChangeStateImage_FTree := FTree.ChangeStateImage;
end; { GetChangeStateImage_FTree }

procedure TCustomElTreeCombo.SetCtl3D_FTree(Value : Boolean);
{ Sets the FTree subcomponent's Ctl3D property to Value. }
begin
  FTree.Ctl3D := Value;
end; { SetCtl3D_FTree }

function TCustomElTreeCombo.GetCtl3D_FTree : Boolean;
begin
  GetCtl3D_FTree := FTree.Ctl3D;
end; { GetCtl3D_FTree }

procedure TCustomElTreeCombo.SetCursor(Value : TCursor);
{ Sets the FTree subcomponent's Cursor property to Value. }
begin
  FTree.Cursor := Value;
end; { SetCursor }

function TCustomElTreeCombo.GetCursor : TCursor;
begin
  GetCursor := FTree.Cursor;
end; { GetCursor }

procedure TCustomElTreeCombo.SetDraggableSections(Value : Boolean);
{ Sets the FTree subcomponent's DraggableSections property to Value. }
begin
  FTree.DraggableSections := Value;
end; { SetDraggableSections }

function TCustomElTreeCombo.GetDraggableSections : Boolean;
begin
  GetDraggableSections := FTree.DraggableSections;
end; { GetDraggableSections }

procedure TCustomElTreeCombo.SetFont_FTree(Value : TFont);
{ Sets the FTree subcomponent's Font property to Value. }
begin
  FTree.Font := Value;
end; { SetFont_FTree }

function TCustomElTreeCombo.GetFont_FTree : TFont;
begin
  GetFont_FTree := FTree.Font;
end; { GetFont_FTree }

procedure TCustomElTreeCombo.SetHeaderHotTrack_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HeaderHotTrack property to Value. }
begin
  FTree.HeaderHotTrack := Value;
end; { SetHeaderHotTrack_FTree }

function TCustomElTreeCombo.GetHeaderHotTrack_FTree : Boolean;
begin
  GetHeaderHotTrack_FTree := FTree.HeaderHotTrack;
end; { GetHeaderHotTrack_FTree }
(*
procedure TCustomElTreeCombo.SetHeaderImages_FTree(Value : TCustomImageList);
{ Sets the FTree subcomponent's HeaderImages property to Value. }
begin
  FTree.HeaderImages := Value;
end; { SetHeaderImages_FTree }

function TCustomElTreeCombo.GetHeaderImages_FTree : TCustomImageList;
begin
  GetHeaderImages_FTree := FTree.HeaderImages;
end; { GetHeaderImages_FTree }
*)
procedure TCustomElTreeCombo.SetHeaderSections_FTree(Value : TElHeaderSections);
{ Sets the FTree subcomponent's HeaderSections property to Value. }
begin
  FTree.HeaderSections := Value;
end; { SetHeaderSections_FTree }

function TCustomElTreeCombo.GetHeaderSections_FTree : TElHeaderSections;
begin
  GetHeaderSections_FTree := FTree.HeaderSections;
end; { GetHeaderSections_FTree }

procedure TCustomElTreeCombo.SetHideHintOnMove_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HideHintOnMove property to Value. }
begin
  FTree.HideHintOnMove := Value;
end; { SetHideHintOnMove_FTree }

function TCustomElTreeCombo.GetHideHintOnMove_FTree : Boolean;
begin
  GetHideHintOnMove_FTree := FTree.HideHintOnMove;
end; { GetHideHintOnMove_FTree }

procedure TCustomElTreeCombo.SetHideHintOnTimer_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HideHintOnTimer property to Value. }
begin
  FTree.HideHintOnTimer := Value;
end; { SetHideHintOnTimer_FTree }

function TCustomElTreeCombo.GetHideHintOnTimer_FTree : Boolean;
begin
  GetHideHintOnTimer_FTree := FTree.HideHintOnTimer;
end; { GetHideHintOnTimer_FTree }

procedure TCustomElTreeCombo.SetHideHorzScrollBar_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HideHorzScrollBar property to Value. }
begin
  FTree.HideHorzScrollBar := Value;
end; { SetHideHorzScrollBar_FTree }

function TCustomElTreeCombo.GetHideHorzScrollBar_FTree : Boolean;
begin
  GetHideHorzScrollBar_FTree := FTree.HideHorzScrollBar;
end; { GetHideHorzScrollBar_FTree }

procedure TCustomElTreeCombo.SetHideVertScrollBar_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HideVertScrollBar property to Value. }
begin
  FTree.HideVertScrollBar := Value;
end; { SetHideVertScrollBar_FTree }

function TCustomElTreeCombo.GetHideVertScrollBar_FTree : Boolean;
begin
  GetHideVertScrollBar_FTree := FTree.HideVertScrollBar;
end; { GetHideVertScrollBar_FTree }

procedure TCustomElTreeCombo.SetHorizontalLines_FTree(Value : Boolean);
{ Sets the FTree subcomponent's HorizontalLines property to Value. }
begin
  FTree.HorizontalLines := Value;
end; { SetHorizontalLines_FTree }

function TCustomElTreeCombo.GetHorizontalLines_FTree : Boolean;
begin
  GetHorizontalLines_FTree := FTree.HorizontalLines;
end; { GetHorizontalLines_FTree }

procedure TCustomElTreeCombo.SetImages_FTree(Value : TCustomImageList);
{ Sets the FTree subcomponent's Images property to Value. }
begin
  FTree.Images := Value;
end; { SetImages_FTree }

function TCustomElTreeCombo.GetImages_FTree : TCustomImageList;
begin
  GetImages_FTree := FTree.Images;
end; { GetImages_FTree }

procedure TCustomElTreeCombo.SetAlphaImages_FTree(Value : TCustomImageList);
{ Sets the FTree subcomponent's AlphaForImages property to Value. }
begin
  FTree.AlphaForImages := Value;
end; { SetAlphaImages_FTree }

function TCustomElTreeCombo.GetAlphaImages_FTree : TCustomImageList;
begin
  GetAlphaImages_FTree := FTree.AlphaForImages;
end; { GetAlphaImages_FTree }

procedure TCustomElTreeCombo.SetItems_FTree(Value : TElTreeItems);
{ Sets the FTree subcomponent's Items property to Value. }
begin
  FTree.Items := Value;
end; { SetItems_FTree }

function TCustomElTreeCombo.GetItems_FTree : TElTreeItems;
begin
  GetItems_FTree := FTree.Items;
end; { GetItems_FTree }

procedure TCustomElTreeCombo.SetLineHintMode(Value : THintModes);
{ Sets the FTree subcomponent's LineHintMode property to Value. }
begin
  FTree.LineHintMode := Value;
end; { SetLineHintMode }

function TCustomElTreeCombo.GetLineHintMode : THintModes;
begin
  GetLineHintMode := FTree.LineHintMode;
end; { GetLineHintMode }

procedure TCustomElTreeCombo.SetMainTreeColumn(Value : Integer);
{ Sets the FTree subcomponent's MainTreeColumn property to Value. }
begin
  FTree.MainTreeColumn := Value;
end; { SetMainTreeColumn }

function TCustomElTreeCombo.GetMainTreeColumn : Integer;
begin
  GetMainTreeColumn := FTree.MainTreeColumn;
end; { GetMainTreeColumn }

procedure TCustomElTreeCombo.SetMultiSelect(Value : Boolean);
{ Sets the FTree subcomponent's MultiSelect property to Value. }
begin
  FTree.MultiSelect := Value;
end; { SetMultiSelect }

function TCustomElTreeCombo.GetMultiSelect : Boolean;
begin
  GetMultiSelect := FTree.MultiSelect;
end; { GetMultiSelect }

procedure TCustomElTreeCombo.SetOwnerDrawByColumn(Value : Boolean);
{ Sets the FTree subcomponent's OwnerDrawByColumn property to Value. }
begin
  FTree.OwnerDrawByColumn := Value;
end; { SetOwnerDrawByColumn }

function TCustomElTreeCombo.GetOwnerDrawByColumn : Boolean;
begin
  GetOwnerDrawByColumn := FTree.OwnerDrawByColumn;
end; { GetOwnerDrawByColumn }

procedure TCustomElTreeCombo.SetOwnerDrawMask(Value: TLMDString);
{ Sets the FTree subcomponent's OwnerDrawMask property to Value. }
begin
  FTree.OwnerDrawMask := Value;
end; { SetOwnerDrawMask }

function TCustomElTreeCombo.GetOwnerDrawMask: TLMDString;
begin
  GetOwnerDrawMask := FTree.OwnerDrawMask;
end; { GetOwnerDrawMask }

procedure TCustomElTreeCombo.SetParentCtl3D(Value : Boolean);
{ Sets the FTree subcomponent's ParentCtl3D property to Value. }
begin
  FTree.ParentCtl3D := Value;
end; { SetParentCtl3D }

function TCustomElTreeCombo.GetParentCtl3D : Boolean;
begin
  GetParentCtl3D := FTree.ParentCtl3D;
end; { GetParentCtl3D }

procedure TCustomElTreeCombo.SetParentFont(Value : Boolean);
{ Sets the FTree subcomponent's ParentFont property to Value. }
begin
  FTree.ParentFont := Value;
end; { SetParentFont }

function TCustomElTreeCombo.GetParentFont : Boolean;
begin
  GetParentFont := FTree.ParentFont;
end; { GetParentFont }

procedure TCustomElTreeCombo.SetParentShowHint(Value : Boolean);
{ Sets the FTree subcomponent's ParentShowHint property to Value. }
begin
  FTree.ParentShowHint := Value;
end; { SetParentShowHint }

function TCustomElTreeCombo.GetParentShowHint : Boolean;
begin
  GetParentShowHint := FTree.ParentShowHint;
end; { GetParentShowHint }

procedure TCustomElTreeCombo.SetRowSelect(Value : Boolean);
{ Sets the FTree subcomponent's RowSelect property to Value. }
begin
  FTree.RowSelect := Value;
end; { SetRowSelect }

function TCustomElTreeCombo.GetRowSelect : Boolean;
begin
  GetRowSelect := FTree.RowSelect;
end; { GetRowSelect }

procedure TCustomElTreeCombo.SetHorzScrollTracking(Value : Boolean);
{ Sets the FTree subcomponent's ScrollTracking property to Value. }
begin
  FTree.HorzScrollTracking := Value;
end; { SetScrollTracking }

function TCustomElTreeCombo.GetHorzScrollTracking: Boolean;
begin
  result := FTree.HorzScrollTracking;
end; { GetScrollTracking }

procedure TCustomElTreeCombo.SetSelectionMode(Value : TSTSelModes);
{ Sets the FTree subcomponent's SelectionMode property to Value. }
begin
  FTree.SelectionMode := Value;
end; { SetSelectionMode }

function TCustomElTreeCombo.GetSelectionMode : TSTSelModes;
begin
  GetSelectionMode := FTree.SelectionMode;
end; { GetSelectionMode }

procedure TCustomElTreeCombo.SetShowButtons(Value : Boolean);
{ Sets the FTree subcomponent's ShowButtons property to Value. }
begin
  FTree.ShowButtons := Value;
end; { SetShowButtons }

function TCustomElTreeCombo.GetShowButtons : Boolean;
begin
  GetShowButtons := FTree.ShowButtons;
end; { GetShowButtons }

procedure TCustomElTreeCombo.SetShowColumns(Value : Boolean);
{ Sets the FTree subcomponent's ShowColumns property to Value. }
begin
  FTree.ShowColumns := Value;
end; { SetShowColumns }

function TCustomElTreeCombo.GetShowColumns : Boolean;
begin
  GetShowColumns := FTree.ShowColumns;
end; { GetShowColumns }

procedure TCustomElTreeCombo.SetShowHint(Value : Boolean);
{ Sets the FTree subcomponent's ShowHint property to Value. }
begin
  FTree.ShowHint := Value;
end; { SetShowHint }

function TCustomElTreeCombo.GetShowHint : Boolean;
begin
  GetShowHint := FTree.ShowHint;
end; { GetShowHint }

procedure TCustomElTreeCombo.SetShowImages(Value : Boolean);
{ Sets the FTree subcomponent's ShowImages property to Value. }
begin
  FTree.ShowImages := Value;
end; { SetShowImages }

function TCustomElTreeCombo.GetShowImages : Boolean;
begin
  GetShowImages := FTree.ShowImages;
end; { GetShowImages }

procedure TCustomElTreeCombo.SetShowLines(Value : Boolean);
{ Sets the FTree subcomponent's ShowLines property to Value. }
begin
  FTree.ShowLines := Value;
end; { SetShowLines }

function TCustomElTreeCombo.GetShowLines : Boolean;
begin
  GetShowLines := FTree.ShowLines;
end; { GetShowLines }

procedure TCustomElTreeCombo.SetShowRoot(Value : Boolean);
{ Sets the FTree subcomponent's ShowRoot property to Value. }
begin
  FTree.ShowRoot := Value;
end; { SetShowRoot }

function TCustomElTreeCombo.GetShowRoot : Boolean;
begin
  GetShowRoot := FTree.ShowRoot;
end; { GetShowRoot }

procedure TCustomElTreeCombo.SetSortDir(Value : TSortDirs);
{ Sets the FTree subcomponent's SortDir property to Value. }
begin
  FTree.SortDir := Value;
end; { SetSortDir }

function TCustomElTreeCombo.GetSortDir : TSortDirs;
begin
  GetSortDir := FTree.SortDir;
end; { GetSortDir }

procedure TCustomElTreeCombo.SetSortMode(Value : TSortModes);
{ Sets the FTree subcomponent's SortMode property to Value. }
begin
  FTree.SortMode := Value;
end; { SetSortMode }

function TCustomElTreeCombo.GetSortMode : TSortModes;
begin
  GetSortMode := FTree.SortMode;
end; { GetSortMode }

procedure TCustomElTreeCombo.SetSortSection(Value : Integer);
{ Sets the FTree subcomponent's SortSection property to Value. }
begin
  FTree.SortSection := Value;
end; { SetSortSection }

function TCustomElTreeCombo.GetSortSection : Integer;
begin
  GetSortSection := FTree.SortSection;
end; { GetSortSection }

procedure TCustomElTreeCombo.SetSortType(Value : TSortTypes);
{ Sets the FTree subcomponent's SortType property to Value. }
begin
  FTree.SortType := Value;
end; { SetSortType }

function TCustomElTreeCombo.GetSortType : TSortTypes;
begin
  GetSortType := FTree.SortType;
end; { GetSortType }

procedure TCustomElTreeCombo.Tree_SetTextColor(Value : TColor);
{ Sets the FTree subcomponent's TextColor property to Value. }
begin
  FTree.TextColor := Value;
end; { SetTextColor }

function TCustomElTreeCombo.Tree_GetTextColor : TColor;
begin
  Result := FTree.TextColor;
end; { GetTextColor }

procedure TCustomElTreeCombo.SetTracking(Value : Boolean);
{ Sets the FTree subcomponent's Tracking property to Value. }
begin
  FTree.Tracking := Value;
end; { SetTracking }

function TCustomElTreeCombo.GetTracking : Boolean;
begin
  GetTracking := FTree.Tracking;
end; { GetTracking }

procedure TCustomElTreeCombo.SetVerticalLines(Value : Boolean);
{ Sets the FTree subcomponent's VerticalLines property to Value. }
begin
  FTree.VerticalLines := Value;
end; { SetVerticalLines }

function TCustomElTreeCombo.GetVerticalLines : Boolean;
begin
  GetVerticalLines := FTree.VerticalLines;
end; { GetVerticalLines }

procedure TCustomElTreeCombo.CompareItemsTransfer(Sender : TObject; Item1 : TElTreeItem; Item2 : TElTreeItem; var res : Integer);
begin
  if (assigned(FOnCompareItems)) then
    FOnCompareItems(Self, Item1, Item2, res);
end; { CompareItemsTransfer }

procedure TCustomElTreeCombo.ClickHandler(Sender : TObject);
var P : TPoint;
    IP: TSTItemPart;
    HC: integer;
    it: TElTreeItem;
begin
  GetCursorPos(P);
  P := FTree.ScreenToClient(p);
  it := FTree.GetItemAt(P.X, P.Y, IP, HC);
//  if FCloseOnClick and (ip in [ipMainText, ipColumn, ipInside, ipPicture, ipPicture2, ipCheckBox]) then
  if FCloseOnClick and Assigned(it) and not (ip in [ipButton, ipCheckBox]) then
  begin
    Dropped := false;
    ProcessSelect;
    TriggerNewTextSelectionEvent;
    SetFocus;
  end;
end;

procedure TCustomElTreeCombo.DblClickHandler(Sender : TObject);
begin
  Dropped := false;
  if not FOwnReadOnly then
  begin
    ProcessSelect;
    TriggerNewTextSelectionEvent;
  end;
  SetFocus;
end; { DblClickHandler }

procedure TCustomElTreeCombo.HeaderColumnClickTransfer(Sender : TObject; SectionIndex : Integer);
begin
  if (assigned(FOnHeaderColumnClick)) then
    FOnHeaderColumnClick(Self, SectionIndex);
end; { HeaderColumnClickTransfer }

procedure TCustomElTreeCombo.HeaderColumnDrawTransfer(Sender : TCustomElHeader; Canvas : TCanvas; Section : TElHeaderSection; R : TRect; Pressed : Boolean);
begin
  if (assigned(FOnHeaderColumnDraw)) then
    FOnHeaderColumnDraw(FTree.HeaderSections.Owner, Canvas, Section, R, Pressed);
end; { HeaderColumnDrawTransfer }

procedure TCustomElTreeCombo.HeaderColumnMoveTransfer(Sender : TCustomElTree; Section : TElHeaderSection; OldPos : Integer; NewPos : Integer);
begin
  if (assigned(FOnHeaderColumnMove)) then
    FOnHeaderColumnMove(FTree, Section, OldPos, NewPos);
end; { HeaderColumnMoveTransfer }

procedure TCustomElTreeCombo.HeaderColumnResizeTransfer(Sender : TObject; SectionIndex : Integer);
begin
  if (assigned(FOnHeaderColumnResize)) then
    FOnHeaderColumnResize(FTree, SectionIndex);
end; { HeaderColumnResizeTransfer }

procedure TCustomElTreeCombo.ItemChangeTransfer(Sender : TObject; Item : TElTreeItem; ItemChangeMode : TItemChangeMode);
begin
  if (assigned(FOnItemChange)) then
    FOnItemChange(Self, Item, ItemChangeMode);
end; { ItemChangeTransfer }

procedure TCustomElTreeCombo.ItemCollapseTransfer(Sender : TObject; Item : TElTreeItem);
begin
  if (assigned(FOnItemCollapse)) then
    FOnItemCollapse(Self, Item);
end; { ItemCollapseTransfer }

procedure TCustomElTreeCombo.ItemCollapsingTransfer(Sender : TObject; Item : TElTreeItem; var CanProcess : Boolean);
begin
  if (assigned(FOnItemCollapsing)) then
    FOnItemCollapsing(Self, Item, CanProcess);
end; { ItemCollapsingTransfer }

procedure TCustomElTreeCombo.ItemDeletionTransfer(Sender : TObject; Item : TElTreeItem);
begin
  if SelectionList = nil then exit;
  SelectionList.Remove(Item);
  if FTSelection = Item then
    FTSelection := nil;
  if (assigned(FOnItemDeletion)) then
    FOnItemDeletion(Self, Item);
end; { ItemDeletionTransfer }

procedure TCustomElTreeCombo.ItemDrawTransfer(Sender : TObject; Item : TElTreeItem; Surface : TCanvas; R : TRect; SectionIndex : Integer);
begin
  if (assigned(FOnItemDraw)) then
    FOnItemDraw(Self, Item, Surface, R, SectionIndex);
end; { ItemDrawTransfer }

procedure TCustomElTreeCombo.ItemExpandTransfer(Sender : TObject; Item : TElTreeItem);
begin
  if (assigned(FOnItemExpand)) then
    FOnItemExpand(Self, Item);
end; { ItemExpandTransfer }

procedure TCustomElTreeCombo.ItemExpandingTransfer(Sender : TObject; Item : TElTreeItem; var CanProcess : Boolean);
begin
  if (assigned(FOnItemExpanding)) then
    FOnItemExpanding(Self, Item, CanProcess);
end; { ItemExpandingTransfer }

procedure TCustomElTreeCombo.ItemFocusedTransfer(Sender : TObject);
begin
  if (assigned(FOnItemFocused)) then
    FOnItemFocused(Self);
end; { ItemFocusedTransfer }

procedure TCustomElTreeCombo.ItemPicDrawTransfer(Sender : TObject; Item : TElTreeItem; var ImageIndex : Integer);
begin
  if (assigned(FOnItemPicDraw)) then
    FOnItemPicDraw(Self, Item, ImageIndex);
end; { ItemPicDrawTransfer }

procedure TCustomElTreeCombo.KeyDownHandler(Sender : TObject; var Key : Word; Shift : TShiftState);
{ Handles the FTree OnKeyDown event. }
begin
  if Dropped and ((Key = VK_DOWN) or (Key = VK_UP)) and (ssAlt in Shift) then
  begin
    Dropped := false;
    exit;
  end;
  if (Key = VK_RETURN) and (Shift = []) then
  begin
    Key := 0;
    Dropped := false;
    ProcessSelect;
    exit;
  end;
  if (Key = VK_ESCAPE) and (Shift = []) then
  begin
    Key := 0;
    Dropped := false;
    exit;
  end;
  TreeKeyDownTransfer(Self, Key, Shift);
end; { KeyDownHandler }

procedure TCustomElTreeCombo.ShowLineHintTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; var Text : TLMDString; HintWindow : THintWindow; MousePos : TPoint; var DoShowHint : Boolean);
begin
  if (assigned(FOnShowLineHint)) then
    FOnShowLineHint(Self, Item, Section, Text, HintWindow, MousePos, DoShowHint);
end; { ShowLineHintTransfer }

procedure TCustomElTreeCombo.StartDrag_FTreeTransfer(Sender : TObject; var DragObject : TDragObject);
begin
  if (assigned(FOnStartDrag_FTree)) then
    FOnStartDrag_FTree(Self, DragObject);
end; { StartDrag_FTreeTransfer }

procedure TCustomElTreeCombo.SetDropped(Value : Boolean);
{ Sets data member FDropped to Value. }
var
  P, P1: TPoint;
  PF   : TCustomForm;
begin
  if (FDropped <> Value) then
  begin
    FDropped := Value;
    TElGraphicButton(FButton).Down := FDropped;
    TriggerDropEvent(FDropped);
    if FDropped then
    begin
      //FTree.Parent := Self;
      if ReadOnly then
      begin
        SendMessage(Handle, EM_SETSEL, -1, -1);
        HideCaret(Handle);
      end;

      FSaveCursor := Cursor;
      Cursor := crArrow;
      PrepareSelection;
      //FTree.ParentWindow := GetDesktopWindow;
      if TreeParentFont then
        TreeFont.Assign(Font);

      FTree.Height := FDropHeight;

      if FDropWidth > 0 then
        FTree.Width := FDropWidth
      else
        FTree.Width := Width;

      P := Point(Left, Top + Height);
      P := Parent.ClientToScreen(P);
      IgnoreFocus := true;
      if P.Y + FTree.Height > GetDesktopBottom then
        P.Y := P.Y - FTree.Height - Height;
      if P.X + FTree.Width > GetDesktopRight then
        P.X := P.X - FTree.Width + Width;
      if AdjustDropDownPos then
      begin
        PF := GetParentForm(Self);
        P1 := Point(0, PF.ClientHeight);
        P1 := PF.ClientToScreen(P1);
        if P.Y + FTree.Height > P1.y then
        begin
          P1 := Point(0, 0);
          P1 := PF.ClientToScreen(P1);
          if P.Y - Height - FTree.Height >= P1.y then
          P.Y := P.Y - Height - FTree.Height;
        end;
      end;

      IgnoreDrop := true;
      SetWindowPos(FTree.Handle, HWND_TOPMOST, P.x, P.y, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW );
      SetFocus;

      if not HandleEditWhenDropped then
      begin
        FReadOnly := True;
        FIgnoreReadOnlyState := not FOwnReadOnly or not DisplayReadOnlyOptions.Enabled;
        HideCaret(Handle);
      end;
      IgnoreFocus := false;
      IgnoreDrop := false;
    end
    else
    begin
      Cursor := FSaveCursor;
      IgnoreDrop := true;
      FDropHeight := FTree.Height;
      FDropWidth := FTree.Width;
      FReadOnly := (Style <> tcsDropDown) or FOwnReadOnly;
      IgnoreFocus := true;
      if HandleAllocated and not FReadOnly then
        ShowCaret(Handle);
      //FTree.Visible := false;

      if FTree.HandleAllocated then
        SetWindowPos(FTree.Handle, HWND_NOTOPMOST, 0,0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);

      IgnoreFocus := false;
      IgnoreDrop := false;
    end;
  end; { if }
  invalidate;
end; { SetDropped }

procedure TCustomElTreeCombo.TriggerDropEvent(Dropped : boolean);
begin
  if (assigned(FOnDrop)) then FOnDrop(Self, Dropped);
end; { TriggerDropEvent }

procedure TCustomElTreeCombo.ButtonClick(Sender : TObject);
begin
  if not (csDesigning in ComponentState) then
    Dropped := not Dropped;
end;

{ Exposed properties' Read/Write methods: }

procedure TCustomElTreeCombo.SetLineHeight_FTree(Value : Integer);
{ Sets the FTree subcomponent's LineHeight property to Value. }
begin
  FTree.LineHeight := Value;
end; { SetLineHeight_FTree }

function TCustomElTreeCombo.GetLineHeight_FTree : Integer;
begin
  GetLineHeight_FTree := FTree.LineHeight;
end; { GetLineHeight_FTree }

function TCustomElTreeCombo.GetCReadOnly : Boolean;
begin
  result := FOwnReadOnly;
end; { GetReadOnly }

procedure TCustomElTreeCombo.SetCReadOnly(Value : Boolean);
{ Sets data member FReadOnly to Value. }
begin
  if (FOwnReadOnly <> Value) or (FReadOnly <> Value) then
  begin
    if Value then
    begin
      FSaveCursor1 := Cursor;
      if Dropped then
        FSaveCursor := crArrow
      else
        Cursor := crArrow;
    end
    else
    begin
      if Dropped then
        FSaveCursor := FSaveCursor1
      else
        Cursor := FSaveCursor1;
    end;
    if not Value then
    begin
      if FMouseDown then
      begin
        if FSaveCapture <> 0 then
          SetCapture(FSaveCapture)
        else
          ReleaseCapture;
      end;
      FMouseDown := false;
    end;
    FOwnReadOnly := Value;
    FReadOnly := (Style <> tcsDropDown) or FOwnReadOnly;
  end; { if }
  FIgnoreReadOnlyState := Value and not DisplayReadOnlyOptions.Enabled;
  invalidate;
end; { SetReadOnly }

procedure TCustomElTreeCombo.CMEnter(var Msg : TCMEnter); { private }
begin
  inherited;
  if not IgnoreFocus then
    Dropped := false;
end; { CMEnter }

procedure TCustomElTreeCombo.CMExit(var Msg : TCMExit); { private }
begin
  inherited;
  if not IgnoreFocus then
    Dropped := false;
end; { CMExit }

procedure TCustomElTreeCombo.ProcessSelect;
begin
  if not ReadOnly then
  begin
    if (not MultiSelect) then
      Selection := FTree.ItemFocused
    else
      FTree.AllSelected(FTSelectionList);
    Change;
  end;
end;

{ Exposed properties' Read/Write methods: }

procedure TCustomElTreeCombo.SetAlwaysKeepSelection_FTree(Value : Boolean);
{ Sets the FTree subcomponent's AlwaysKeepSelection property to Value. }
begin
  FTree.AlwaysKeepSelection := Value;
end; { SetAlwaysKeepSelection_FTree }

function TCustomElTreeCombo.GetAlwaysKeepSelection_FTree : Boolean;
begin
  GetAlwaysKeepSelection_FTree := FTree.AlwaysKeepSelection;
end; { GetAlwaysKeepSelection_FTree }

procedure TCustomElTreeCombo.SetAutoExpand_FTree(Value : Boolean);
{ Sets the FTree subcomponent's AutoExpand property to Value. }
begin
  FTree.AutoExpand := Value;
end; { SetAutoExpand_FTree }

function TCustomElTreeCombo.GetAutoExpand_FTree : Boolean;
begin
  GetAutoExpand_FTree := FTree.AutoExpand;
end; { GetAutoExpand_FTree }

procedure TCustomElTreeCombo.SetAutoLookup_FTree(Value : Boolean);
{ Sets the FTree subcomponent's AutoLookup property to Value. }
begin
  FTree.AutoLookup := Value;
end; { SetAutoLookup_FTree }

function TCustomElTreeCombo.GetAutoLookup_FTree : Boolean;
begin
  GetAutoLookup_FTree := FTree.AutoLookup;
end; { GetAutoLookup_FTree }

procedure TCustomElTreeCombo.SetBarStyle_FTree(Value : Boolean);
{ Sets the FTree subcomponent's BarStyle property to Value. }
begin
  FTree.BarStyle := Value;
end; { SetBarStyle_FTree }

function TCustomElTreeCombo.GetBarStyle_FTree : Boolean;
begin
  GetBarStyle_FTree := FTree.BarStyle;
end; { GetBarStyle_FTree }

procedure TCustomElTreeCombo.SetCustomPlusMinus_FTree(Value : Boolean);
{ Sets the FTree subcomponent's CustomPlusMinus property to Value. }
begin
  FTree.CustomPlusMinus := Value;
end; { SetCustomPlusMinus_FTree }

function TCustomElTreeCombo.GetCustomPlusMinus_FTree : Boolean;
begin
  GetCustomPlusMinus_FTree := FTree.CustomPlusMinus;
end; { GetCustomPlusMinus_FTree }

procedure TCustomElTreeCombo.SetDeselectChildrenOnCollapse_FTree(Value : Boolean);
{ Sets the FTree subcomponent's DeselectChildrenOnCollapse property to Value. }
begin
  FTree.DeselectChildrenOnCollapse := Value;
end; { SetDeselectChildrenOnCollapse_FTree }

function TCustomElTreeCombo.GetDeselectChildrenOnCollapse_FTree : Boolean;
begin
  GetDeselectChildrenOnCollapse_FTree := FTree.DeselectChildrenOnCollapse;
end; { GetDeselectChildrenOnCollapse_FTree }

procedure TCustomElTreeCombo.SetTreeDragImageMode(Value : TDragImgMode);
{ Sets the FTree subcomponent's DragImageMode property to Value. }
begin
  FTree.DragImageMode := Value;
end; { SetTreeDragImageMode }

function TCustomElTreeCombo.GetTreeDragImageMode : TDragImgMode;
begin
  GetTreeDragImageMode := FTree.DragImageMode;
end; { GetTreeDragImageMode }

procedure TCustomElTreeCombo.SetTreeDrawFocusRect(Value : Boolean);
{ Sets the FTree subcomponent's DrawFocusRect property to Value. }
begin
  FTree.DrawFocusRect := Value;
end; { SetTreeDrawFocusRect }

function TCustomElTreeCombo.GetTreeDrawFocusRect : Boolean;
begin
  GetTreeDrawFocusRect := FTree.DrawFocusRect;
end; { GetTreeDrawFocusRect }

procedure TCustomElTreeCombo.SetTreeFullRowSelect(Value : Boolean);
{ Sets the FTree subcomponent's FullRowSelect property to Value. }
begin
  FTree.FullRowSelect := Value;
end; { SetTreeFullRowSelect }

function TCustomElTreeCombo.GetTreeFullRowSelect : Boolean;
begin
  GetTreeFullRowSelect := FTree.FullRowSelect;
end; { GetTreeFullRowSelect }

procedure TCustomElTreeCombo.SetTreeImages2(Value : TCustomImageList);
{ Sets the FTree subcomponent's Images2 property to Value. }
begin
  FTree.Images2 := Value;
end; { SetTreeImages2 }

function TCustomElTreeCombo.GetTreeImages2 : TCustomImageList;
begin
  GetTreeImages2 := FTree.Images2;
end; { GetTreeImages2 }

procedure TCustomElTreeCombo.SetAlphaTreeImages2(Value : TCustomImageList);
{ Sets the FTree subcomponent's AlphaForImages2 property to Value. }
begin
  FTree.AlphaForImages2 := Value;
end; { SetAlphaTreeImages2 }

function TCustomElTreeCombo.GetAlphaTreeImages2 : TCustomImageList;
begin
  GetAlphaTreeImages2 := FTree.AlphaForImages2;
end; { GetAlphaTreeImages2 }

procedure TCustomElTreeCombo.SetMinusPicture_FTree(Value : TBitmap);
{ Sets the FTree subcomponent's MinusPicture property to Value. }
begin
  FTree.MinusPicture := Value;
end; { SetMinusPicture_FTree }

function TCustomElTreeCombo.GetMinusPicture_FTree : TBitmap;
begin
  GetMinusPicture_FTree := FTree.MinusPicture;
end; { GetMinusPicture_FTree }

procedure TCustomElTreeCombo.SetPlusPicture_FTree(Value : TBitmap);
{ Sets the FTree subcomponent's PlusPicture property to Value. }
begin
  FTree.PlusPicture := Value;
end; { SetPlusPicture_FTree }

function TCustomElTreeCombo.GetPlusPicture_FTree : TBitmap;
begin
  GetPlusPicture_FTree := FTree.PlusPicture;
end; { GetPlusPicture_FTree }

procedure TCustomElTreeCombo.SetShowCheckboxes_FTree(Value : Boolean);
{ Sets the FTree subcomponent's ShowCheckboxes property to Value. }
begin
  FTree.ShowCheckboxes := Value;
end; { SetShowCheckboxes_FTree }

function TCustomElTreeCombo.GetShowCheckboxes_FTree : Boolean;
begin
  GetShowCheckboxes_FTree := FTree.ShowCheckboxes;
end; { GetShowCheckboxes_FTree }

procedure TCustomElTreeCombo.SetStickyHeaderSections_FTree(Value : Boolean);
{ Sets the FTree subcomponent's StickyHeaderSections property to Value. }
begin
  FTree.StickyHeaderSections := Value;
end; { SetStickyHeaderSections_FTree }

function TCustomElTreeCombo.GetStickyHeaderSections_FTree : Boolean;
begin
  GetStickyHeaderSections_FTree := FTree.StickyHeaderSections;
end; { GetStickyHeaderSections_FTree }

procedure TCustomElTreeCombo.SetStoragePath_FTree(Value : string);
{ Sets the FTree subcomponent's StoragePath property to Value. }
begin
  FTree.StoragePath := Value;
end; { SetStoragePath_FTree }

function TCustomElTreeCombo.GetStoragePath_FTree : string;
begin
  GetStoragePath_FTree := FTree.StoragePath;
end; { GetStoragePath_FTree }

procedure TCustomElTreeCombo.CellStyleLoad_FTreeTransfer(Sender : TObject; Stream : TStream; Style : TElCellStyle);
begin
  if (assigned(FOnCellStyleLoad_FTree)) then
    FOnCellStyleLoad_FTree(Self, Stream, Style);
end; { CellStyleLoad_FTreeTransfer }

procedure TCustomElTreeCombo.CellStyleSave_FTreeTransfer(Sender : TObject; Stream : TStream; Style : TElCellStyle);
begin
  if (assigned(FOnCellStyleSave_FTree)) then
    FOnCellStyleSave_FTree(Self, Stream, Style);
end; { CellStyleSave_FTreeTransfer }

procedure TCustomElTreeCombo.ComboEditShow_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; Combobox : TComboBox);
begin
  if (assigned(FOnComboEditShow_FTree)) then
    FOnComboEditShow_FTree(Self, Item, Section, Combobox);
end; { ComboEditShow_FTreeTransfer }

procedure TCustomElTreeCombo.HeaderLookup_FTreeTransfer(Sender : TObject; Section : TElHeaderSection; var Text : TLMDString);
begin
  if (assigned(FOnHeaderLookup_FTree)) then
    FOnHeaderLookup_FTree(Self, Section, Text);
end; { HeaderLookup_FTreeTransfer }

procedure TCustomElTreeCombo.HeaderLookupDone_FTreeTransfer(Sender : TObject; Section : TElHeaderSection; Text : TLMDString; Accepted : Boolean);
begin
  if (assigned(FOnHeaderLookupDone_FTree)) then
    FOnHeaderLookupDone_FTree(Self, Section, Text, Accepted);
end; { HeaderLookupDone_FTreeTransfer }

procedure TCustomElTreeCombo.HeaderResize_FTreeTransfer(Sender : TObject);
begin
  if (assigned(FOnHeaderResize_FTree)) then
    FOnHeaderResize_FTree(Self);
end; { HeaderResize_FTreeTransfer }

procedure TCustomElTreeCombo.HeaderSectionCollapse_FTreeTransfer(Sender : TObject; Section : TElHeaderSection);
begin
  if (assigned(FOnHeaderSectionCollapse_FTree)) then
    FOnHeaderSectionCollapse_FTree(Self, Section);
end; { HeaderSectionCollapse_FTreeTransfer }

procedure TCustomElTreeCombo.HeaderSectionExpand_FTreeTransfer(Sender : TObject; Section : TElHeaderSection);
begin
  if (assigned(FOnHeaderSectionExpand_FTree)) then
    FOnHeaderSectionExpand_FTree(Self, Section);
end; { HeaderSectionExpand_FTreeTransfer }

procedure TCustomElTreeCombo.HotTrack_FTreeTransfer(Sender : TObject; OldItem : TElTreeItem; NewItem : TElTreeItem);
begin
  if (assigned(FOnHotTrack_FTree)) then
    FOnHotTrack_FTree(Self, OldItem, NewItem);
end; { HotTrack_FTreeTransfer }

procedure TCustomElTreeCombo.ItemLoad_FTreeTransfer(Sender : TObject; Stream : TStream; Item : TElTreeItem);
begin
  if (assigned(FOnItemLoad_FTree)) then
    FOnItemLoad_FTree(Self, Stream, Item);
end; { ItemLoad_FTreeTransfer }

procedure TCustomElTreeCombo.ItemPicDraw2_FTreeTransfer(Sender : TObject; Item : TElTreeItem; var ImageIndex : Integer);
begin
  if (assigned(FOnItemPicDraw2_FTree)) then
    FOnItemPicDraw2_FTree(Self, Item, ImageIndex);
end; { ItemPicDraw2_FTreeTransfer }

procedure TCustomElTreeCombo.ItemSave_FTreeTransfer(Sender : TObject; Stream : TStream; Item : TElTreeItem);
begin
  if (assigned(FOnItemSave_FTree)) then
    FOnItemSave_FTree(Self, Stream, Item);
end; { ItemSave_FTreeTransfer }

procedure TCustomElTreeCombo.ItemSelectedChange_FTreeTransfer(Sender : TObject; Item : TElTreeItem);
begin
  if (assigned(FOnItemSelectedChange_FTree)) then
    FOnItemSelectedChange_FTree(Self, Item);
end; { ItemSelectedChange_FTreeTransfer }

{.$IFNDEF B _3}
{.$IFNDEF V ER90}
procedure TCustomElTreeCombo.OleDragFinish_FTreeTransfer(Sender : TObject; dwEffect : TDragType; Result : HResult);
begin
  if (assigned(FOnOleDragFinish_FTree)) then
    FOnOleDragFinish_FTree(Self, dwEffect, Result);
end; { OleDragFinish_FTreeTransfer }

procedure TCustomElTreeCombo.OleDragStart_FTreeTransfer(Sender : TObject; var dataObj : IDataObject; var dropSource : IDropSource; var dwOKEffects : TDragTypes);
begin
  if (assigned(FOnOleDragStart_FTree)) then
    FOnOleDragStart_FTree(Self, dataObj, dropSource, dwOKEffects);
end; { OleDragStart_FTreeTransfer }

procedure TCustomElTreeCombo.OleTargetDrag_FTreeTransfer(Sender : TObject; State : TDragState; Source : TOleDragObject; Shift : TShiftState; X : Integer; Y : Integer; var DragType : TDragType);
begin
  if (assigned(FOnOleTargetDrag_FTree)) then
    FOnOleTargetDrag_FTree(Self, State, Source, Shift, X, Y, DragType);
end; { OleTargetDrag_FTreeTransfer }

procedure TCustomElTreeCombo.OleTargetDrop_FTreeTransfer(Sender : TObject; Source : TOleDragObject; Shift : TShiftState; X : Integer; Y : Integer; var DragType : TDragType);
begin
  if (assigned(FOnOleTargetDrop_FTree)) then
    FOnOleTargetDrop_FTree(Self, Source, Shift, X, Y, DragType);
end; { OleTargetDrop_FTreeTransfer }
{.$ENDIF}
{.$ENDIF}

procedure TCustomElTreeCombo.TryEdit_FTreeTransfer(Sender : TObject; Item : TElTreeItem; SectionIndex : integer; var CellType : TElFieldType; var CanEdit : Boolean);

begin
  if (assigned(FOnTryEdit_FTree)) then

    FOnTryEdit_FTree(Self, Item, SectionIndex, CellType, CanEdit);

end; { TryEdit_FTreeTransfer }

procedure TCustomElTreeCombo.ValidateCombo_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; Combo : TComboBox; var Accept : Boolean);
begin
  if (assigned(FOnValidateCombo_FTree)) then
    FOnValidateCombo_FTree(Self, Item, Section, Combo, Accept);
end; { ValidateCombo_FTreeTransfer }

procedure TCustomElTreeCombo.ValidateInplaceEdit_FTreeTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection; var Text : string; var Accept : Boolean);
begin
  if (assigned(FOnValidateInplaceEdit_FTree)) then
    FOnValidateInplaceEdit_FTree(Self, Item, Section, Text, Accept);
end; { ValidateInplaceEdit_FTreeTransfer }

destructor TCustomElTreeCombo.Destroy;
begin
  inherited Destroy;
  //FTree.Free;
  FTSelectionList.Free;
end; { Destroy }

constructor TCustomElTreeCombo.Create(AOwner : TComponent);
var
  FGlyph: TBitmap;
begin

  BeginCreate;
  inherited Create(AOwner);

  FDropHeight := 80;
  FTSelectionList := TLMDObjectList.Create;
  FTSelection := nil;
  FAdjustDropDownPos := true;

  OnButtonClick := ButtonClick;

  FGlyph := TBitmap.Create;
  FGlyph.PixelFormat := pf32bit;
  FGlyph.Width := 9;
  FGlyph.Height := 5;
  FGlyph.TransparentMode := tmFixed;
  FGlyph.TransparentColor := clWhite;
  FGlyph.Canvas.Brush.Color := clWhite;
  FGlyph.Canvas.FillRect(Rect(0, 0, 9, 5));
  LMDDrawArrow(FGlyph.Canvas, eadDown, Rect(0, 1, 9, 5), clBlack, Enabled);
  TElTreeComboDropDownButton(FButton).Glyph := FGlyph;
  FGlyph.Free;
  TElTreeComboDropDownButton(FButton).ShowText := false;
  TElTreeComboDropDownButton(FButton).ShowGlyph := not IsThemed;// (UseXPThemes and IsThemeApplied);
  FAutoProcessSelection := true;

  AltButtonVisible := false;
  ButtonFlat := false;
  ButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  ButtonColor := clBtnFace;
  FDropWidth := Width;
  FSizeableTree := true;
  TElGraphicButton(FButton).Cursor := crArrow;
  TElGraphicButton(FButton).IsSwitch := true;
  FTree := TDropDownElTree(CreateTree);
  with FTree do
  begin
    StyleManager := nil;
    FOwner := Self;
    ControlStyle := ControlStyle - [csCaptureMouse];
    //ParentWindow := GetDesktopWindow;
    //
    // Parent := Self;
    ParentWindow := 0;
    Visible := false;

    DblClickMode := dcmNone;
    BorderStyle := bsSingle;
    Align := alNone;
    Tracking := false;
    FTree.DoInplaceEdit := false;
    MultiSelect := false;
    Flat := false;

    OnCompareItems := CompareItemsTransfer;
    OnDblClick := DblClickHandler;
    OnClick    := ClickHandler;
    OnHeaderColumnClick := HeaderColumnClickTransfer;
    OnHeaderColumnDraw := HeaderColumnDrawTransfer;
    OnHeaderColumnMove := HeaderColumnMoveTransfer;
    OnHeaderColumnResize := HeaderColumnResizeTransfer;
    OnItemChange := ItemChangeTransfer;
    OnItemCollapse := ItemCollapseTransfer;
    OnItemCollapsing := ItemCollapsingTransfer;
    OnItemDeletion := ItemDeletionTransfer;
    OnItemDraw := ItemDrawTransfer;
    OnItemExpand := ItemExpandTransfer;
    OnItemExpanding := ItemExpandingTransfer;
    OnItemFocused := ItemFocusedTransfer;
    OnItemPicDraw := ItemPicDrawTransfer;

    OnKeyDown := KeyDownHandler;
    OnKeyPress := TreeKeyPressTransfer;
    OnKeyUp := TreeKeyUpTransfer;
    OnMouseDown := TreeMouseDownTransfer;
    OnMouseMove := TreeMouseMoveTransfer;
    OnMouseUp := TreeMouseUpTransfer;
    OnEditRequest := EditRequestTransfer;

    OnShowLineHint := ShowLineHintTransfer;
    OnStartDrag := StartDrag_FTreeTransfer;
    OnCellStyleLoad := CellStyleLoad_FTreeTransfer;
    OnCellStyleSave := CellStyleSave_FTreeTransfer;
    OnComboEditShow := ComboEditShow_FTreeTransfer;
    OnHeaderLookup := HeaderLookup_FTreeTransfer;
    OnHeaderLookupDone := HeaderLookupDone_FTreeTransfer;
    OnHeaderResize := HeaderResize_FTreeTransfer;
    OnHeaderSectionAutoSize := HeaderSectionAutoSize_FTreeTransfer;
    OnHeaderSectionCollapse := HeaderSectionCollapse_FTreeTransfer;
    OnHeaderSectionExpand := HeaderSectionExpand_FTreeTransfer;
    OnHeaderSectionFilterCall := HeaderSectionFilterCall_FTreeTransfer;
    OnHorzScrollDrawPart := HorzScrollDrawPart_FTreeTransfer;
    OnHorzScrollHintNeeded := HorzScrollHintNeeded_FTreeTransfer;
    OnHotTrack := HotTrack_FTreeTransfer;
    OnItemLoad := ItemLoad_FTreeTransfer;
    OnItemPicDraw2 := ItemPicDraw2_FTreeTransfer;
    OnItemSave := ItemSave_FTreeTransfer;
    OnItemSelectedChange := ItemSelectedChange_FTreeTransfer;

{.$IFNDEF B _3}
{.$IFNDEF V ER90}
    OnOleDragFinish := OleDragFinish_FTreeTransfer;
    OnOleDragStart := OleDragStart_FTreeTransfer;
    OnOleTargetDrag := OleTargetDrag_FTreeTransfer;
    OnOleTargetDrop := OleTargetDrop_FTreeTransfer;
{.$ENDIF}
{.$ENDIF}

    OnResize := TreeResizeTransfer;
    OnScroll := ScrollTransfer;
    OnTryEdit := TryEdit_FTreeTransfer;
    OnValidateCombo := ValidateCombo_FTreeTransfer;
    OnValidateInplaceEdit := ValidateInplaceEdit_FTreeTransfer;
    OnVertScrollDrawPart := VertScrollDrawPart_FTreeTransfer;
    OnVertScrollHintNeeded := VertScrollHintNeeded_FTreeTransfer;
    HideSelectColor := Self.FFocusedSelectColor;
    HideSelectTextColor := Self.FFocusedSelectTextColor;
    FocusedSelectColor := Self.FFocusedSelectColor;
    FocusedSelectTextColor := Self.FFocusedSelectTextColor;
  end; { FTree }
  FReadOnly := False;
  FShowImagesInText := false;
  FTextImageIndex := -1;
  FImageIndex := -1;
  EndCreate;
end; { Create }

procedure TCustomElTreeCombo.Assign(Source : TPersistent); { public }
begin
  if Source is TCustomElTree then
    FTree.Assign(Source as TCustomElTree)
  else
    inherited Assign(Source);
end; { Assign }

procedure TCustomElTreeCombo.PrepareSelection; { private }
var i : integer;
begin
  if MultiSelect then
  begin
    FTree.Items.BeginUpdate;
    FTree.DeselectAll;
    for i := 0 to FTSelectionList.Count - 1 do // Iterate
      TElTreeItem(FTSelectionList[i]).Selected := true;
    FTree.Items.EndUpdate;
  end
  else
  begin
    if Length(Text) > 0 then
      ReSelectByText;
  end;
end; { PrepareSelection }

procedure TCustomElTreeCombo.SetDropWidth(Value : Integer);
begin
  if (FDropWidth <> Value) then
  begin
    FDropWidth := Value;
    if FTree.Visible then
      FTree.Width := Value;
  end; {if}
end;

procedure TCustomElTreeCombo.SetDropHeight(Value : Integer);
begin
  if (FDropHeight <> Value) then
  begin
    FDropHeight := Value;
    if FTree.Visible then
      FTree.Height := Value;
  end; {if}
end;

procedure TCustomElTreeCombo.SetPathSeparator(Value : Char);
begin
  FTree.PathSeparator := Value;
end;

function TCustomElTreeCombo.GetPathSeparator : Char;
begin
  GetPathSeparator := FTree.PathSeparator;
end;

procedure TCustomElTreeCombo.TriggerNewTextSelectionEvent;
{ Triggers the OnNewTextSelection event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnNewTextSelection)) then
    FOnNewTextSelection(Self);
end; { TriggerNewTextSelectionEvent }

procedure TCustomElTreeCombo.KeyDown(var Key : Word; Shift : TShiftState); { protected }
begin
  if (Key = VK_DOWN) and (ssAlt in Shift) then
    Dropped := not Dropped
  else
  if (Key = VK_F4) and (Shift = []) then
  begin
    Dropped := not Dropped;
  end
  else
    inherited;
end; { KeyDown }

function TCustomElTreeCombo.GetDrawFocusRect_FTree : Boolean;
begin
  GetDrawFocusRect_FTree := FTree.DrawFocusRect;
end; { GetDrawFocusRect_FTree }

procedure TCustomElTreeCombo.SetFilteredVisibility_FTree(Value : Boolean);
{ Sets the FTree subcomponent's FilteredVisibility property to Value. }
begin
  FTree.FilteredVisibility := Value;
end; { SetFilteredVisibility_FTree }

function TCustomElTreeCombo.GetFilteredVisibility_FTree : Boolean;
begin
  GetFilteredVisibility_FTree := FTree.FilteredVisibility;
end; { GetFilteredVisibility_FTree }

procedure TCustomElTreeCombo.SetRightAlignedText_FTree(Value : Boolean);
{ Sets the FTree subcomponent's RightAlignedText property to Value. }
begin
  FTree.RightAlignedText := Value;
end; { SetRightAlignedText_FTree }

function TCustomElTreeCombo.GetRightAlignedText_FTree : Boolean;
begin
  GetRightAlignedText_FTree := FTree.RightAlignedText;
end; { GetRightAlignedText_FTree }

procedure TCustomElTreeCombo.SetRightAlignedTree_FTree(Value : Boolean);
{ Sets the FTree subcomponent's RightAlignedTree property to Value. }
begin
  FTree.RightAlignedView := Value;
end; { SetRightAlignedTree_FTree }

function TCustomElTreeCombo.GetRightAlignedTree_FTree : Boolean;
begin
  GetRightAlignedTree_FTree := FTree.RightAlignedView;
end; { GetRightAlignedTree_FTree }

{ Exposed properties' Read/Write methods: }

procedure TCustomElTreeCombo.SetCheckBoxGlyph_FTree(Value : TBitmap);
{ Sets the FTree subcomponent's CheckBoxGlyph property to Value. }
begin
  FTree.CheckBoxGlyph := Value;
end; { SetCheckBoxGlyph_FTree }

function TCustomElTreeCombo.GetCheckBoxGlyph_FTree : TBitmap;
begin
  GetCheckBoxGlyph_FTree := FTree.CheckBoxGlyph;
end; { GetCheckBoxGlyph_FTree }

procedure TCustomElTreeCombo.SetCustomCheckboxes_FTree(Value : Boolean);
{ Sets the FTree subcomponent's CustomCheckboxes property to Value. }
begin
  FTree.CustomCheckboxes := Value;
end; { SetCustomCheckboxes_FTree }

function TCustomElTreeCombo.GetCustomCheckboxes_FTree : Boolean;
begin
  GetCustomCheckboxes_FTree := FTree.CustomCheckboxes;
end; { GetCustomCheckboxes_FTree }

procedure TCustomElTreeCombo.SetRadioButtonGlyph_FTree(Value : TBitmap);
{ Sets the FTree subcomponent's RadioButtonGlyph property to Value. }
begin
  FTree.RadioButtonGlyph := Value;
end; { SetRadioButtonGlyph_FTree }

function TCustomElTreeCombo.GetRadioButtonGlyph_FTree : TBitmap;
begin
  GetRadioButtonGlyph_FTree := FTree.RadioButtonGlyph;
end; { GetRadioButtonGlyph_FTree }

procedure TCustomElTreeCombo.SetUnderlineTracked_FTree(Value : Boolean);
{ Sets the FTree subcomponent's UnderlineTracked property to Value. }
begin
  FTree.UnderlineTracked := Value;
end; { SetUnderlineTracked_FTree }

function TCustomElTreeCombo.GetUnderlineTracked_FTree : Boolean;
begin
  GetUnderlineTracked_FTree := FTree.UnderlineTracked;
end; { GetUnderlineTracked_FTree }

procedure TCustomElTreeCombo.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  inherited;
  if (Button = mbLeft) and (ReadOnly) then
    Dropped := not Dropped;
end; { MouseDown }

{ Exposed properties' Read/Write methods: }

procedure TCustomElTreeCombo.SetDoInplaceEdit(Value : Boolean);
{ Sets the FTree subcomponent's DoInplaceEdit property to Value. }
begin
  FTree.DoInplaceEdit := Value;
end; { SetDoInplaceEdit }

function TCustomElTreeCombo.GetDoInplaceEdit : Boolean;
begin
  GetDoInplaceEdit := FTree.DoInplaceEdit;
end; { GetDoInplaceEdit }

procedure TCustomElTreeCombo.TreeKeyDownTransfer(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if (assigned(FOnTreeKeyDown)) then
    FOnTreeKeyDown(Self, Key, Shift);
end; { TreeKeyDownTransfer }

procedure TCustomElTreeCombo.TreeKeyPressTransfer(Sender : TObject; var Key : Char);
begin
  if (assigned(FOnTreeKeyPress)) then
    FOnTreeKeyPress(Self, Key);
end; { TreeKeyPressTransfer }

procedure TCustomElTreeCombo.TreeKeyUpTransfer(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if (assigned(FOnTreeKeyUp)) then
    FOnTreeKeyUp(Self, Key, Shift);
end; { TreeKeyUpTransfer }

procedure TCustomElTreeCombo.TreeMouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
begin
  if (assigned(FOnTreeMouseDown)) then
    FOnTreeMouseDown(Self, Button, Shift, X, Y);
end; { TreeMouseDownTransfer }

procedure TCustomElTreeCombo.TreeMouseMoveTransfer(Sender : TObject; Shift : TShiftState; X : Integer; Y : Integer);
begin
  if (assigned(FOnTreeMouseMove)) then
    FOnTreeMouseMove(Self, Shift, X, Y);
end; { TreeMouseMoveTransfer }

procedure TCustomElTreeCombo.TreeMouseUpTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
begin
  if (assigned(FOnTreeMouseUp)) then
    FOnTreeMouseUp(Self, Button, Shift, X, Y);
end; { TreeMouseUpTransfer }

procedure TCustomElTreeCombo.SetShowRootButtons(Value : Boolean);
begin
  FTree.ShowRootButtons := Value;
end; { SetShowRootButtons }

function TCustomElTreeCombo.GetShowRootButtons : Boolean;
begin
  GetShowRootButtons := FTree.ShowRootButtons;
end; { GetShowRootButtons }

function TCustomElTreeCombo.GetTree : TElTree; { public }
begin
  Result := TElTree(FTree);
end; { GetTree }

procedure TCustomElTreeCombo.EditRequestTransfer(Sender : TObject; Item : TElTreeItem; Section : TElHeaderSection);
begin
  if (assigned(FOnEditRequest)) then
    FOnEditRequest(Self, Item, Section);
end; { EditRequestTransfer }

procedure TCustomElTreeCombo.SetTreeFlat(Value : Boolean);
begin
  FTree.Flat := Value;
end; { SetTreeFlat }

function TCustomElTreeCombo.GetTreeFlat : Boolean;
begin
  GetTreeFlat := FTree.Flat;
end; { GetTreeFlat }

procedure TCustomElTreeCombo.SetTreeHeaderActiveFilterColor(Value : TColor);
begin
  FTree.HeaderActiveFilterColor := Value;
end; { SetTreeHeaderActiveFilterColor }

function TCustomElTreeCombo.GetTreeHeaderActiveFilterColor : TColor;
begin
  GetTreeHeaderActiveFilterColor := FTree.HeaderActiveFilterColor;
end; { GetTreeHeaderActiveFilterColor }

procedure TCustomElTreeCombo.SetTreeHeaderFilterColor(Value : TColor);
begin
  FTree.HeaderFilterColor := Value;
end; { SetTreeHeaderFilterColor }

function TCustomElTreeCombo.GetTreeHeaderFilterColor : TColor;
begin
  GetTreeHeaderFilterColor := FTree.HeaderFilterColor;
end; { GetTreeHeaderFilterColor }

procedure TCustomElTreeCombo.SetTreeHeaderFlat(Value : Boolean);
begin
  FTree.HeaderFlat := Value;
end; { SetTreeHeaderFlat }

function TCustomElTreeCombo.GetTreeHeaderFlat : Boolean;
begin
  GetTreeHeaderFlat := FTree.HeaderFlat;
end; { GetTreeHeaderFlat }

procedure TCustomElTreeCombo.SetAutoResizeColumns(Value : Boolean);
begin
  FTree.AutoResizeColumns := Value;
end;  { SetAutoResizeColumns }

function TCustomElTreeCombo.GetAutoResizeColumns : Boolean;
begin
  GetAutoResizeColumns := FTree.AutoResizeColumns;
end;  { GetAutoResizeColumns }

procedure TCustomElTreeCombo.SetTreeBackground(Value : TBitmap);
begin
  FTree.Background := Value;
end;  { SetTreeBackground }

function TCustomElTreeCombo.GetTreeBackground : TBitmap;
begin
  GetTreeBackground := FTree.Background;
end;  { GetTreeBackground }

procedure TCustomElTreeCombo.SetTreeBackgroundType(Value : TLMDBackgroundType);
begin
  FTree.BackgroundType := Value;
end;  { SetTreeBackgroundType }

function TCustomElTreeCombo.GetTreeBackgroundType : TLMDBackgroundType;
begin
  GetTreeBackgroundType := FTree.BackgroundType;
end;  { GetTreeBackgroundType }

procedure TCustomElTreeCombo.SetFlatFocusedScrollbars(Value : Boolean);
begin
  FTree.FlatFocusedScrollbars := Value;
end;  { SetFlatFocusedScrollbars }

function TCustomElTreeCombo.GetFlatFocusedScrollbars : Boolean;
begin
  GetFlatFocusedScrollbars := FTree.FlatFocusedScrollbars;
end;  { GetFlatFocusedScrollbars }

procedure TCustomElTreeCombo.SetGradientEndColor(Value : TColor);
begin
  FTree.GradientEndColor := Value;
end;  { SetGradientEndColor }

function TCustomElTreeCombo.GetGradientEndColor : TColor;
begin
  GetGradientEndColor := FTree.GradientEndColor;
end;  { GetGradientEndColor }

procedure TCustomElTreeCombo.SetGradientStartColor(Value : TColor);
begin
  FTree.GradientStartColor := Value;
end;  { SetGradientStartColor }

function TCustomElTreeCombo.GetGradientStartColor : TColor;
begin
  GetGradientStartColor := FTree.GradientStartColor;
end;  { GetGradientStartColor }

procedure TCustomElTreeCombo.SetGradientSteps(Value : Integer);
begin
  FTree.GradientSteps := Value;
end;  { SetGradientSteps }

function TCustomElTreeCombo.GetGradientSteps : Integer;
begin
  GetGradientSteps := FTree.GradientSteps;
end;  { GetGradientSteps }

procedure TCustomElTreeCombo.SetHorzScrollBarStyles(Value : TElScrollBarStyles);
begin
  FTree.HorzScrollBarStyles := Value;
end;  { SetHorzScrollBarStyles }

function TCustomElTreeCombo.GetHorzScrollBarStyles : TElScrollBarStyles;
begin
  GetHorzScrollBarStyles := FTree.HorzScrollBarStyles;
end;  { GetHorzScrollBarStyles }

procedure TCustomElTreeCombo.SetVertScrollBarStyles(Value : TElScrollBarStyles);
begin
  FTree.VertScrollBarStyles := Value;
end;  { SetVertScrollBarStyles }

function TCustomElTreeCombo.GetVertScrollBarStyles : TElScrollBarStyles;
begin
  GetVertScrollBarStyles := FTree.VertScrollBarStyles;
end;  { GetVertScrollBarStyles }

function TCustomElTreeCombo.GetForcedScrollBars: TScrollStyle;
begin
  Result := FTree.ForcedScrollBars;
end;

procedure TCustomElTreeCombo.SetForcedScrollBars(const Value: TScrollStyle);
begin
  FTree.ForcedScrollBars := Value;
end;

function TCustomElTreeCombo.GetTreeHeaderHeight: integer;
begin
  Result := FTree.HeaderHeight;
end;

procedure TCustomElTreeCombo.SetTreeHeaderHeight(const Value: integer);
begin
  FTree.HeaderHeight := Value;
  FTree.FHeaderHeight := Value;
end;

function TCustomElTreeCombo.GetHeaderInvertSortArrows_FTree: boolean;
begin
  Result := FTree.HeaderInvertSortArrows;
end;

procedure TCustomElTreeCombo.SetHeaderInvertSortArrows_FTree(
  const Value: boolean);
begin
  FTree.HeaderInvertSortArrows := Value;
end;

function TCustomElTreeCombo.GetLeftPosition_FTree: integer;
begin
  Result := FTree.LeftPosition;
end;

procedure TCustomElTreeCombo.SetLeftPosition_FTree(const Value: integer);
begin
  if FTree.HandleAllocated then
    FTree.LeftPosition := Value;
end;

function TCustomElTreeCombo.GetLinesColor_FTree: TColor;
begin
  Result := FTree.LinesColor;
end;

function TCustomElTreeCombo.GetLinesStyle_FTree: TPenStyle;
begin
  Result := FTree.LinesStyle;
end;

procedure TCustomElTreeCombo.SetLinesColor_FTree(const Value: TColor);
begin
  FTree.LinesColor := Value;
end;

procedure TCustomElTreeCombo.SetLinesStyle_FTree(const Value: TPenStyle);
begin
  FTree.LinesStyle := Value;
end;

function TCustomElTreeCombo.GetLockHeaderHeight_FTree: boolean;
begin
  Result := FTree.LockHeaderHeight;
end;

procedure TCustomElTreeCombo.SetLockHeaderHeight_FTree(const Value: boolean);
begin
  FTree.LockHeaderHeight := Value;
end;

function TCustomElTreeCombo.GetMoveColumnOnDrag_FTree: boolean;
begin
  Result := FTree.MoveColumnOnDrag;
end;

function TCustomElTreeCombo.GetMoveFocusOnCollapse_FTree: boolean;
begin
  Result := FTree.MoveFocusOnCollapse;
end;

procedure TCustomElTreeCombo.SetMoveColumnOnDrag_FTree(const Value: boolean);
begin
  FTree.MoveColumnOnDrag := Value;
end;

procedure TCustomElTreeCombo.SetMoveFocusOnCollapse_FTree(const Value: boolean);
begin
  FTree.MoveFocusOnCollapse := Value;
end;

function TCustomElTreeCombo.GetSelectColumn: integer;
begin
  Result := FTree.SelectColumn;
end;

procedure TCustomElTreeCombo.SetSelectColumn(const Value: integer);
begin
  FTree.SelectColumn := Value;
end;

procedure TCustomElTreeCombo.HeaderSectionAutoSize_FTreeTransfer(Sender: TObject;
  SectionIndex: integer);
begin
  if Assigned(FOnHeaderSectionAutoSize_FTree) then
    FOnHeaderSectionAutoSize_FTree(Sender, SectionIndex);
end;

procedure TCustomElTreeCombo.HeaderSectionFilterCall_FTreeTransfer(
  Sender: TObject; SectionIndex: integer);
begin
  if Assigned(FOnHeaderSectionFilterCall_FTree) then
    FOnHeaderSectionFilterCall_FTree(Sender, SectionIndex);
end;

procedure TCustomElTreeCombo.HorzScrollDrawPart_FTreeTransfer(Sender: TObject;
  Canvas: TCanvas; R: TRect; Part: TElScrollBarPart; Enabled, Focused,
  Pressed: boolean; var DefaultDraw: boolean);
begin
  if Assigned(FOnHorzScrollDrawPart_FTree) then
    FOnHorzScrollDrawPart_FTree(Sender, Canvas, R, Part, Enabled, Focused, Pressed, DefaultDraw);
end;

procedure TCustomElTreeCombo.HorzScrollHintNeeded_FTreeTransfer(Sender: TObject;
  TrackPosition: integer; var Hint: TLMDString);
begin
  if Assigned(FOnHorzScrollHintNeeded_FTree) then
    FOnHorzScrollHintNeeded_FTree(Sender, TrackPosition, Hint);
end;

procedure TCustomElTreeCombo.VertScrollDrawPart_FTreeTransfer(Sender: TObject;
  Canvas: TCanvas; R: TRect; Part: TElScrollBarPart; Enabled, Focused,
  Pressed: boolean; var DefaultDraw: boolean);
begin
  if Assigned(FOnHorzScrollDrawPart_FTree) then
    FOnHorzScrollDrawPart_FTree(Sender, Canvas, R, Part, Enabled, Focused, Pressed, DefaultDraw);
end;

procedure TCustomElTreeCombo.VertScrollHintNeeded_FTreeTransfer(Sender: TObject;
  TrackPosition: integer; var Hint: TLMDString);
begin
  if Assigned(FOnHorzScrollHintNeeded_FTree) then
    FOnHorzScrollHintNeeded_FTree(Sender, TrackPosition, Hint);
end;

procedure TCustomElTreeCombo.TreeResizeTransfer(Sender: TObject);
begin
  if Assigned(FOnResize_FTree) then FOnResize_FTree(Sender);
end;

procedure TCustomElTreeCombo.ScrollTransfer(Sender: TObject;
  ScrollBarKind: TScrollBarKind; ScrollCode: integer);
begin
  if Assigned(FOnScroll_FTree) then FOnScroll_FTree(Sender, ScrollBarKind, ScrollCode);
end;

function TCustomElTreeCombo.GetTreeActiveBorderType: TElFlatBorderType;
begin
  Result := FTree.ActiveBorderType;
end;

function TCustomElTreeCombo.GetTreeInactiveBorderType: TElFlatBorderType;
begin
  Result := FTree.InactiveBorderType;
end;

procedure TCustomElTreeCombo.SetTreeActiveBorderType(
  const Value: TElFlatBorderType);
begin
  FTree.ActiveBorderType := Value;
end;

procedure TCustomElTreeCombo.SetTreeInactiveBorderType(
  const Value: TElFlatBorderType);
begin
  FTree.InactiveBorderType := Value;
end;

procedure TCustomElTreeCombo.SetStorage_FTree(Value : TElIniFile);
begin

  FTree.Storage := Value;

end;

function  TCustomElTreeCombo.GetStorage_FTree : TElIniFile;
begin

  result := FTree.Storage;

end;

function TCustomElTreeCombo.GetAlwaysKeepFocus: Boolean;
begin
  Result := FTree.AlwaysKeepFocus;
end;

procedure TCustomElTreeCombo.SetAlwaysKeepFocus(Value: Boolean);
begin
  FTree.AlwaysKeepFocus := Value;
end;

function TCustomElTreeCombo.GetAdjustMultilineHeight: Boolean;
begin
  Result := FTree.AdjustMultilineHeight;
end;

procedure TCustomElTreeCombo.SetAdjustMultilineHeight(Value: Boolean);
begin
  FTree.AdjustMultilineHeight := Value;
end;

procedure TCustomElTreeCombo.SetBarStyleVerticalLines(Value: Boolean);
begin
  FTree.BarStyleVerticalLines := Value;
end;

function TCustomElTreeCombo.GetBarStyleVerticalLines: Boolean;
begin
  Result := FTree.BarStyleVerticalLines;
end;

function TCustomElTreeCombo.GetChangeDelay: Integer;
begin
  Result := FTree.ChangeDelay;
end;

procedure TCustomElTreeCombo.SetChangeDelay(Value: Integer);
begin
  FTree.ChangeDelay := Value;
end;

function TCustomElTreeCombo.GetHorzDivLinesColor: TColor;
begin
  Result := FTree.HorzDivLinesColor;
end;

procedure TCustomElTreeCombo.SetHorzDivLinesColor(Value: TColor);
begin
  FTree.HorzDivLinesColor := Value;
end;

function TCustomElTreeCombo.GetDragTrgDrawMode: TDragTargetDraw;
begin
  Result := FTree.DragTrgDrawMode;
end;

procedure TCustomElTreeCombo.SetDragTrgDrawMode(Value: TDragTargetDraw);
begin
  FTree.DragTrgDrawMode := Value;
end;

function TCustomElTreeCombo.GetDragExpandDelay: Integer;
begin
  Result := FTree.DragExpandDelay;
end;

procedure TCustomElTreeCombo.SetDragExpandDelay(Value: Integer);
begin
  FTree.DragExpandDelay := Value;
end;

function TCustomElTreeCombo.GetDragRectAcceptColor: TColor;
begin
  Result := FTree.DragRectAcceptColor;
end;

procedure TCustomElTreeCombo.SetDragRectAcceptColor(Value: TColor);
begin
  FTree.DragRectAcceptColor := Value;
end;

function TCustomElTreeCombo.GetDragRectDenyColor: TColor;
begin
  Result := FTree.DragRectDenyColor;
end;

procedure TCustomElTreeCombo.SetDragRectDenyColor(Value: TColor);
begin
  FTree.DragRectDenyColor := Value;
end;

function TCustomElTreeCombo.GetExpandOnDragOver: Boolean;
begin
  Result := FTree.ExpandOnDragOver;
end;

procedure TCustomElTreeCombo.SetExpandOnDragOver(Value: Boolean);
begin
  FTree.ExpandOnDragOver := Value;
end;

procedure TCustomElTreeCombo.SetFocusedSelectColor(Value: TColor);
begin
  inherited;
  FTree.FocusedSelectColor := Value;
  FTree.HideSelectColor := Value;
end;

procedure TCustomElTreeCombo.SetFocusedSelectTextColor(Value: TColor);
begin
  inherited;
  FTree.FocusedSelectTextColor := Value;
  FTree.HideSelectTextColor := Value;
end;

function TCustomElTreeCombo.GetHeaderColor: TColor;
begin
  Result := FTree.HeaderColor;
end;

procedure TCustomElTreeCombo.SetHeaderColor(Value: TColor);
begin
  FTree.HeaderColor := Value;
end;

function TCustomElTreeCombo.GetHeaderWrapCaptions: Boolean;
begin
  Result := FTree.HeaderWrapCaptions;
end;

procedure TCustomElTreeCombo.SetHeaderWrapCaptions(Value: Boolean);
begin
  FTree.HeaderWrapCaptions := Value;
end;

function TCustomElTreeCombo.GetHideFocusRect: Boolean;
begin
  Result := FTree.HideFocusRect;
end;

procedure TCustomElTreeCombo.SetHideFocusRect(Value: Boolean);
begin
  FTree.HideFocusRect := Value;
end;

procedure TCustomElTreeCombo.SetHideSelectColor(Value: TColor);
begin
  inherited;
  //FTree.HideSelectColor := Value;
end;

procedure TCustomElTreeCombo.SetHideSelectTextColor(Value: TColor);
begin
  inherited;
  //FTree.HideSelectTextColor := Value;
end;

procedure TCustomElTreeCombo.SetInheritedReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
end;

function TCustomElTreeCombo.GetIncrementalSearch: Boolean;
begin
  Result := FTree.IncrementalSearch;
end;

procedure TCustomElTreeCombo.SetIncrementalSearch(Value: Boolean);
begin
  FTree.IncrementalSearch := Value;
end;

function TCustomElTreeCombo.GetItemIndent: Integer;
begin
  Result := FTree.ItemIndent;
end;

procedure TCustomElTreeCombo.SetItemIndent(Value: Integer);
begin
  FTree.ItemIndent := Value;
end;

function TCustomElTreeCombo.GetLineHintColor: TColor;
begin
  Result := FTree.LineHintColor;
end;

procedure TCustomElTreeCombo.SetLineHintColor(Value: TColor);
begin
  FTree.LineHintColor := Value;
end;

function TCustomElTreeCombo.GetLineHintTimeout: Integer;
begin
  Result := FTree.LineHintTimeout;
end;

procedure TCustomElTreeCombo.SetLineHintTimeout(Value: Integer);
begin
  FTree.LineHintTimeout := Value;
end;

function TCustomElTreeCombo.GetLineHintType: TLineHintType;
begin
  Result := FTree.LineHintType;
end;

procedure TCustomElTreeCombo.SetLineHintType(Value: TLineHintType);
begin
  FTree.LineHintType := Value;
end;

function TCustomElTreeCombo.GetPlusMinusTransparent: Boolean;
begin
  Result := FTree.PlusMinusTransparent;
end;

procedure TCustomElTreeCombo.SetPlusMinusTransparent(Value: Boolean);
begin
  FTree.PlusMinusTransparent := Value;
end;

function TCustomElTreeCombo.GetRightClickSelect: Boolean;
begin
  Result := FTree.RightClickSelect;
end;

procedure TCustomElTreeCombo.SetRightClickSelect(Value: Boolean);
begin
  FTree.RightClickSelect := Value;
end;

function TCustomElTreeCombo.GetRowHotTrack: Boolean;
begin
  Result := FTree.RowHotTrack;
end;

procedure TCustomElTreeCombo.SetRowHotTrack(Value: Boolean);
begin
  FTree.RowHotTrack := Value;
end;

function TCustomElTreeCombo.GetScrollbarOpposite: Boolean;
begin
  Result := FTree.ScrollbarOpposite;
end;

procedure TCustomElTreeCombo.SetScrollbarOpposite(Value: Boolean);
begin
  FTree.ScrollbarOpposite := Value;
end;

function TCustomElTreeCombo.GetTrackColor: TColor;
begin
  Result := FTree.TrackColor;
end;

procedure TCustomElTreeCombo.SetTrackColor(Value: TColor);
begin
  FTree.TrackColor := Value;
end;

function TCustomElTreeCombo.GetUseCustomScrollBars: Boolean;
begin
  Result := FTree.UseCustomScrollBars;
end;

procedure TCustomElTreeCombo.SetUseCustomScrollBars(Value: Boolean);
begin
  FTree.UseCustomScrollBars := Value;
end;

function TCustomElTreeCombo.GetVerticalLinesLong: Boolean;
begin
  Result := FTree.VerticalLinesLong;
end;

procedure TCustomElTreeCombo.SetVerticalLinesLong(Value: Boolean);
begin
  FTree.VerticalLinesLong := Value;
end;

function TCustomElTreeCombo.GetUseSystemHintColors: Boolean;
begin
  Result := FTree.UseSystemHintColors;
end;

procedure TCustomElTreeCombo.SetUseSystemHintColors(Value: Boolean);
begin
  FTree.UseSystemHintColors := Value;
end;

function TCustomElTreeCombo.GetOnHeaderSectionMeasure: TMeasureSectionEVent;
begin
  Result := FTree.OnHeaderSectionMeasure;
end;

procedure TCustomElTreeCombo.SetOnHeaderSectionMeasure(Value: TMeasureSectionEVent);
begin
  FTree.OnHeaderSectionMeasure := Value;
end;

function TCustomElTreeCombo.GetOnApplyVisFilter: TApplyVisFilterEvent;
begin
  Result := FTree.OnApplyVisFilter;
end;

procedure TCustomElTreeCombo.SetOnApplyVisFilter(Value: TApplyVisFilterEvent);
begin
  FTree.OnApplyVisFilter := Value;
end;

function TCustomElTreeCombo.GetOnAfterSelectionChange: TNotifyEvent;
begin
  Result := FTree.OnAfterSelectionChange;
end;

procedure TCustomElTreeCombo.SetOnAfterSelectionChange(Value: TNotifyEvent);
begin
  FTree.OnAfterSelectionChange := Value;
end;

function TCustomElTreeCombo.GetOnItemChecked: TOnItemCheckedEvent;
begin
  Result := FTree.OnItemChecked;
end;

procedure TCustomElTreeCombo.SetOnItemChecked(Value: TOnItemCheckedEvent);
begin
  FTree.OnItemChecked := Value;
end;

function TCustomElTreeCombo.GetOnSortBegin: TNotifyEvent;
begin
  Result := FTree.OnSortBegin;
end;

procedure TCustomElTreeCombo.SetOnSortBegin(Value: TNotifyEvent);
begin
  FTree.OnSortBegin := Value;
end;

function TCustomElTreeCombo.GetOnSortEnd: TNotifyEvent;
begin
  Result := FTree.OnSortEnd;
end;

procedure TCustomElTreeCombo.SetOnSortEnd(Value: TNotifyEvent);
begin
  FTree.OnSortEnd := Value;
end;

function TCustomElTreeCombo.GetOnHTMLImageNeeded: TElHTMLImageNeededEvent;
begin
  Result := FTree.OnHTMLImageNeeded;
end;

procedure TCustomElTreeCombo.SetOnHTMLImageNeeded(Value: TElHTMLImageNeededEvent);
begin
  FTree.OnHTMLImageNeeded := Value;
end;

function TCustomElTreeCombo.GetStripedOddColor: TColor;
begin
  Result := FTree.StripedOddColor;
end;

procedure TCustomElTreeCombo.SetStripedOddColor(Value: TColor);
begin
  FTree.StripedOddColor := Value;
end;

function TCustomElTreeCombo.GetStripedEvenColor: TColor;
begin
  Result := FTree.StripedEvenColor;
end;

procedure TCustomElTreeCombo.SetStripedEvenColor(Value: TColor);
begin
  FTree.StripedEvenColor := Value;
end;

function TCustomElTreeCombo.GetStripedItems: Boolean;
begin
  Result := FTree.StripedItems;
end;

procedure TCustomElTreeCombo.SetStripedItems(Value: Boolean);
begin
  FTree.StripedItems := Value;
end;

function TCustomElTreeCombo.GetHintType: TElHintType;
begin
  Result := FTree.HintType;
end;

procedure TCustomElTreeCombo.SetHintType(Value: TElHintType);
begin
  FTree.HintType := Value;
end;

//procedure TCustomElTreeCombo.WMSize(var Message: TMessage);
//begin
//  inherited;
//  DropWidth := Width;
//end;

procedure TCustomElTreeCombo.WMSetCursor(var Msg: TWMSetCursor);
begin
  if FOwnReadOnly or FReadOnly then
    Windows.SetCursor(Screen.Cursors[crArrow])
  else
    inherited;
end;

procedure TCustomElTreeCombo.WMChar;
var
  LMsg: TMessage;
begin
  if not FDropped then
    inherited
  else
  begin
    if (not HandleEditWhenDropped) or ReadOnly then
    begin
      LMsg := TMessage(Message);
      FTree.FView.WindowProc(LMsg);
      Message := TWMChar(LMsg);
      end
    else
    begin
      inherited;
      if not MultiSelect then
        ReSelectByText;
    end;
  end;
end;

procedure TCustomElTreeCombo.WMKeyDown;
var
  LMsg: TMessage;
begin
  if not FDropped then
  begin
    if ReadOnly then
    begin
      with TWMKeyDown(Message) do
      if ((CharCode = VK_DOWN) or (CharCode = VK_UP) or (CharCode = VK_PRIOR) or (CharCode = VK_NEXT)) and
         (KeyDataToShiftState(KeyData) = []) then
      begin
        LMsg := TMessage(Message);
        FTree.FView.WindowProc(LMsg);
        Message := TWMKeyDown(LMsg);
        ProcessSelect;
        CharCode := 0;
      end
      else
        inherited;
        HideCaret(Handle);
      SendMessage(Handle, EM_SETSEL, -1, -1);
    end
    else
    begin
      if (TWMKeyDown(Message).CharCode = VK_DOWN) and (KeyDataToShiftState(TWMKeyDown(Message).KeyData) = []) then
      ReselectByText
      else
        inherited;
    end;
  end
  else
  begin
    with TWMKeyDown(Message) do
    if (not HandleEditWhenDropped) or ReadOnly or (CharCode = VK_UP) or (CharCode = VK_DOWN) or
         (CharCode = VK_NEXT) or (CharCode = VK_PRIOR) then
      begin
        LMsg := TMessage(Message);
        FTree.FView.WindowProc(LMsg);
        Message := TWMKeyDown(LMsg);
        end
      else
      if CharCode = VK_RETURN Then
      begin
        CharCode := 0;
      end
      else
      begin
        inherited;
        if not MultiSelect then
          ReSelectByText;
      end;
  end;
end;

procedure TCustomElTreeCombo.WMKeyUp;
var
  LMsg: TMessage;
begin
  if not FDropped then
    inherited
  else
  with TWMKeyUp(Message) do
  if (not HandleEditWhenDropped) or ReadOnly or (CharCode = VK_UP) or (CharCode = VK_DOWN) or
       (CharCode = VK_NEXT) or (CharCode = VK_PRIOR) then
    begin
      LMsg := TMessage(Message);
      FTree.FView.WindowProc(LMsg);
      Message := TWMKeyUp(LMsg);
      end
    else
      inherited;
end;

procedure TCustomElTreeCombo.WMSysKeyDown;
var
  LMsg: TMessage;
begin
  if not FDropped then
    inherited
  else
  begin
    LMsg := TMessage(Message);
    FTree.FView.WindowProc(LMsg);
    Message := TWMSysKeyDown(LMsg);
    end;
end;

procedure TCustomElTreeCombo.WMSysKeyUp;
var
  LMsg: TMessage;
begin
  if not FDropped then
    inherited
  else
  begin
    LMsg := TMessage(Message);
    FTree.FView.WindowProc(LMsg);
    Message := TWMSysKeyUp(LMsg);
    end;
end;

procedure TCustomElTreeCombo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if (not FDropped) or (ReadOnly) or HandleEditWhenDropped then
  begin
    inherited;
    if Dropped then
      Message.Result := Message.Result or DLGC_WANTALLKEYS;
  end
  else
    Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTALLKEYS;
end;

procedure TCustomElTreeCombo.WMActivateApp(var Msg : TWMActivateApp);
begin
  inherited;
  if (Msg.Active = false) then
    Self.Dropped := false;
(*
  if (Msg.Active = WA_ACTIVE) or (Msg.Active = WA_CLICKACTIVE) then
  begin
    if TCustomElTreeCombo(Owner).CanFocus then
      TCustomElTreeCombo(Owner).SetFocus;
  end;
*)
end;

procedure TCustomElTreeCombo.WMKillFocus(var Msg: TWMKillFocus);
begin
  if (not IgnoreDrop) and (not IgnoreFocus) then
    Dropped := false;
  inherited;
end;

procedure TCustomElTreeCombo.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_UPDATE) and ReadOnly then
  begin
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElTreeCombo.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if ReadOnly then
  begin
    if FMouseDown then
    begin
      if (FSaveCapture <> 0) then
        SetCapture(FSaveCapture)
      else
        ReleaseCapture;
    end;

    FMouseDown := false;
    inherited;
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElTreeCombo.WMMButtonDblClk(var Message: TWMMButtonDblClk);
begin
  if ReadOnly then
  begin
    Message.Result := 0;
    with Message do
      MouseDown(mbMiddle, KeysToShiftState(Keys) + [ssDouble], XPos, YPos);
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end else
    inherited;
end;

procedure TCustomElTreeCombo.EMSetReadOnly(var Msg : TMessage);
begin
  inherited;
  FIgnoreReadOnlyState := not FOwnReadOnly or not DisplayReadOnlyOptions.Enabled;
  (*
  if Boolean(Msg.wParam) then
  begin
    if GetFocus = Handle then
       HideCaret(Handle);
  end;
  *)
end;

procedure TCustomElTreeCombo.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if (Style <> tcsDropDown) or ReadOnly then
  begin
    inherited;
    if (Style <> tcsDropDown) then
    begin
      if csClickEvents in ControlStyle then
        ControlState := ControlState + [csClicked];
      if not (csNoStdEvents in ControlStyle) then
        with Message do
          MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
      Dropped := not Dropped;
    end
    else
    begin
      if GetCapture <> Handle then
      begin
        FSaveCapture := GetCapture;
        SetCapture(Handle);
      end;
    end;
    FMouseDown := true;
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElTreeCombo.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  PopupMenu: TPopupMenu;
begin
  if ReadOnly then
  begin
    Pt.x := Message.XPos; //LOWORD(Message.lParam);
    Pt.y := Message.YPos;  //HIWORD(Message.lParam);
    if Pt.X < 0 then
      Temp := Pt
    else
    begin
      Temp := ScreenToClient(Pt);
      if not PtInRect(ClientRect, Temp) then
      begin
        inherited;
        Exit;
      end;
    end;

    Handled := False;
    DoContextPopup(Temp, Handled);
    Message.Result := Ord(Handled);
    if Handled then Exit;
    PopupMenu := GetPopupMenu;
    if (PopupMenu <> nil) and PopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
        Pt := ClientToScreen(Point(0,0));
      PopupMenu.Popup(Pt.X, Pt.Y);
    end;
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomElTreeCombo.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if ReadOnly then
     HideCaret(Handle);
end;

procedure TCustomElTreeCombo.WMMouseMove(var Message: TWMMouseMove);

begin
  if ReadOnly and FMouseDown then
  begin
    if WindowFromPoint(SmallPointToPoint(TWMMouse(Message).Pos)) <> Handle then
      WMLButtonUp(TWMMouse(Message));
    end
  else
    inherited;
end;

procedure TCustomElTreeCombo.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if FMouseDown then
  begin
    if FSaveCapture <> 0 then
      SetCapture(FSaveCapture)
    else
      ReleaseCapture;
  end;
end;

function TCustomElTreeCombo.GetVertDivLinesColor: TColor;
begin
  Result := FTree.VertDivLinesColor;
end;

procedure TCustomElTreeCombo.SetVertDivLinesColor(Value: TColor);
begin
  FTree.VertDivLinesColor := Value;
end;

procedure TCustomElTreeCombo.CMCancelMode(var Msg: TCMCancelMode);
begin
  if (Msg.Sender <> Self) and (Msg.Sender <> FButton) and (Msg.Sender <> FTree)
     and (Msg.Sender <> FTree.View) and (Msg.Sender <> FTree.HScrollBar)
     and (Msg.Sender <> FTree.VScrollBar) and (Msg.Sender <> FTree.FHeader) then Dropped := false;
end;

function TCustomElTreeCombo.GetHeaderSections: TElHeaderSections;
begin
  Result := FTree.HeaderSections;
end;

procedure TCustomElTreeCombo.SetHeaderSections(Value: TElHeaderSections);
begin
  FTree.HeaderSections := Value;
end;

function TCustomElTreeCombo.GetHeaderImages: TCustomImageList;
begin
  Result := FTree.HeaderImages;
end;

procedure TCustomElTreeCombo.SetHeaderImages(Value: TCustomImageList);
begin
  FTree.HeaderImages := Value;
end;

function TCustomElTreeCombo.GetAlphaHeaderImages: TCustomImageList;
begin
  Result := FTree.AlphaForHeaderImages;
end;

procedure TCustomElTreeCombo.SetAlphaHeaderImages(Value: TCustomImageList);
begin
  FTree.AlphaForHeaderImages := Value;
end;

function TCustomElTreeCombo.GetMultiSelectLevel: Integer;
begin
  Result := FTree.MultiSelectLevel;
end;

procedure TCustomElTreeCombo.SetMultiSelectLevel(Value: Integer);
begin
  FTree.MultiSelectLevel := Value;
end;

function TCustomElTreeCombo.GetDragScrollInterval: Integer;
begin
  Result := FTree.DragScrollInterval;
end;

procedure TCustomElTreeCombo.SetDragScrollInterval(Value: Integer);
begin
  FTree.DragScrollInterval := Value;
end;

function TCustomElTreeCombo.GetMouseFrameSelect: Boolean;
begin
  Result := FTree.MouseFrameSelect;
end;

procedure TCustomElTreeCombo.SetMouseFrameSelect(Value: Boolean);
begin
  FTree.MouseFrameSelect := Value;
end;

function TCustomElTreeCombo.CreateTree: TCustomElTree;
begin
  Result := TDropDownElTree.Create(Self);
end;

function TCustomElTreeCombo.GetShowLeafButton: Boolean;
begin
  Result := FTree.ShowLeafButton;
end;

procedure TCustomElTreeCombo.SetShowLeafButton(Value: Boolean);
begin
  FTree.ShowLeafButton := Value;
end;

function TCustomElTreeCombo.GetLeafPicture: TBitmap;
begin
  Result := FTree.LeafPicture;
end;

procedure TCustomElTreeCombo.SetLeafPicture(Value: TBitmap);
begin
  FTree.LeafPicture := Value;
end;

{
function TCustomElTreeCombo.GetExplorerEditMode: Boolean;
begin
  Result := FTree.ExplorerEditMode;
end;

procedure TCustomElTreeCombo.SetExplorerEditMode(Value: Boolean);
begin
  FTree.ExplorerEditMode := Value;
end;
}
function TCustomElTreeCombo.GetHeaderFont: TFont;
begin
  Result := FTree.HeaderFont;
end;

procedure TCustomElTreeCombo.SetHeaderFont(Value: TFont);
begin
  FTree.HeaderFont := Value;
end;

function TCustomElTreeCombo.GetHeaderUseTreeFont: Boolean;
begin
  Result := FTree.HeaderUseTreeFont;
end;

procedure TCustomElTreeCombo.SetHeaderUseTreeFont(Value: Boolean);
begin
  FTree.HeaderUseTreeFont := Value;
end;

procedure TCustomElTreeCombo.SetSizeableTree(Value: Boolean);
begin
  if FSizeableTree <> Value then
  begin
    FSizeableTree := Value;
    FTree.ForceRecreateWnd;
  end;
end;

procedure TCustomElTreeCombo.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  TDropDownElTree(FTree).UseXPThemes := Value;
  TElTreeComboDropDownButton(FButton).ShowGlyph := not IsThemed;
  end;

procedure TCustomElTreeCombo.Loaded;
begin
  inherited;
  FTree.Loaded;
  if TreeParentFont then
    TreeFont.Assign(Font);
  FReadOnly := (Style <> tcsDropDown) or FOwnReadOnly;
  TElTreeComboDropDownButton(FButton).ShowGlyph := not UseXPThemes;
  //  FTree.Parent := Self;
end;

function TCustomElTreeCombo.IsButtonWidthStored: Boolean;
begin
  Result := ButtonWidth <> GetSystemMetrics(SM_CXHSCROLL);
end;

procedure TCustomElTreeCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if TreeParentFont then
    TreeFont.Assign(Font);
end;

procedure TCustomElTreeCombo.SetShowGripper(Value: Boolean);
begin
  if FShowGripper <> Value then
  begin
    FShowGripper := Value;
    FTree.ForceRecreateWnd;
  end;
end;

type
  TSearchRec = record
     Combo : TCustomElTreeCombo;
     Text : String;
     Separator : string;
  end;
  PSearchRec = ^TSearchRec;
  procedure TCustomElTreeCombo.IntSelect(Item : TElTreeItem; Index : integer; var ContinueIterate : boolean;
  IterateData : TLMDDataTag; Tree : TCustomElTree);
begin
  if PSearchRec(IterateData).Combo.GetDisplayText(Item) = PSearchRec(IterateData).Text then
  begin
    ContinueIterate := false;
    Tree.ItemFocused := Item;
    Item.Selected := true;
  end;
end;

procedure TCustomElTreeCombo.ReselectByText;
var
  SRec : TSearchRec;

begin
  SRec.Combo := Self;
  SRec.Separator := PathSeparator;
  SRec.Text := Text;
  FTree.ItemFocused := FTSelection;
  if FTree.ItemFocused = nil then
    FTree.Items.Iterate(false, false, IntSelect, @SRec);
end;

procedure TCustomElTreeCombo.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('TreeHideSelection', FakeBoolean, nil, false);
    Filer.DefineProperty('NoBlendSelected', FakeBoolean, nil, false);
    Filer.DefineProperty('TreeScrollBackground', FakeBoolean, nil, false);
  end;
  Filer.DefineProperty('TreeFocusedSelectColor', ReadTreeFocusedSelectColor, nil, false);
  Filer.DefineProperty('TreeHeaderImages', ReadTreeHeaderImages, nil, false);
  Filer.DefineProperty('ScrollTracking', ReadScrollTracking, nil, false);
end;

procedure TCustomElTreeCombo.ReadTreeFocusedSelectColor(Reader : TReader);
begin
  FocusedSelectTextColor := StringToColor(Reader.ReadIdent);
end;

procedure TCustomElTreeCombo.ReadTreeHeaderImages(Reader : TReader);
begin
  Reader.ReadIdent;
end;

procedure TCustomElTreeCombo.DoChange;
var SearchText : TLMDString;
    DisplayText: TLMDString;
    liSearchTextLength,
    liIndex : Integer ;
    AnItem  : TElTreeItem;
begin
  inherited;
  if (AutoCompletion and not ReadOnly and (not Dropped)) and not (FNoCompletion) then
  begin
    SearchText := Text;
    if (SearchText > '') then
    begin
      liSearchTextLength := Length (SearchText) ;

      for liIndex := 0 to (FTree.Items.Count - 1) do
      begin
        AnItem := FTree.Items[liIndex];
        DisplayText := GetDisplayText(AnItem);
        {$ifdef LMD_UNICODE}
        if LMDWideSameText(SearchText, Copy(DisplayText, 1, liSearchTextLength)) then
        {$else}
        if LMDAnsiSameText(SearchText, Copy (DisplayText, 1, liSearchTextLength)) then
        {$endif}
        begin
          FNoCompletion := true;
          FTree.ItemFocused := AnItem;
          Text := DisplayText;
          SelStart := liSearchTextLength;
          SelLength := Length(DisplayText) - SelStart;
          FNoCompletion := false;
          break;
        end;
      end;
    end;
  end;
end;

function TCustomElTreeCombo.GetDisplayText(Item : TElTreeItem): TLMDString;
begin
  if Assigned(FOnGetDisplayText) then
    FOnGetDisplayText(Self, Item, Result)
  else
    Result := Item.GetFullName(PathSeparator);
end;

function TCustomElTreeCombo.GetTreeStyleManager: TElStyleManager;
begin
  Result := FTree.StyleManager;
end;

procedure TCustomElTreeCombo.SetTreeStyleManager(Value: TElStyleManager);
begin
  FTree.StyleManager := Value;
end;

function TCustomElTreeCombo.GetTreeStyleName: string;
begin
  Result := FTree.StyleName;
end;

procedure TCustomElTreeCombo.SetTreeStyleName(const Value: string);
begin
  FTree.StyleName := Value;
end;

function TCustomElTreeCombo.GetVertScrollTracking: Boolean;
begin
  Result := FTree.VertScrollTracking;
end; { GetScrollTracking }

procedure TCustomElTreeCombo.SetVertScrollTracking(Value : Boolean);
{ Sets the FTree subcomponent's ScrollTracking property to Value. }
begin
  FTree.VertScrollTracking := Value;
end; { SetScrollTracking }

procedure TCustomElTreeCombo.ReadScrollTracking(Reader : TReader);
begin
  VertScrollTracking := Reader.ReadBoolean;
  HorzScrollTracking := VertScrollTracking;
end;

procedure TCustomElTreeCombo.DestroyWnd;
begin
  if Dropped then
    SetDropped(false);
  inherited;
end;

function TCustomElTreeCombo.GetBkColor: TColor;
begin
  if {Dropped and} FIgnoreReadOnlyState then
  begin
    if UseDisabledColors and (not Enabled) then
      result := DisabledColor
    else
      if Focused and (Style = tcsDropDownList) and (not Dropped) then
        Result := FocusedSelectColor
      else
        Result := Color;
  end
  else
    Result := inherited GetBkColor;
end;

function TCustomElTreeCombo.GetTextColor: TColor;
begin
  if FIgnoreReadOnlyState {and Dropped} then
  begin
    if UseDisabledColors and (not Enabled) then
      result := DisabledFontColor
    else
      if Focused and (Style = tcsDropDownList) and (not Dropped) then
        Result := FocusedSelectTextColor
      else
        Result := Font.Color;
  end
  else
    Result := inherited GetTextColor;
end;

procedure TCustomElTreeCombo.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode = VK_RETURN) and Dropped then
  begin
    Dropped := false;
    ProcessSelect;
    Message.result := 1;
  end
  else
  if (Message.CharCode = VK_ESCAPE) and Dropped then
  begin
    Dropped := false;
    Message.result := 1;
  end
  else
    inherited;
end;

function TCustomElTreeCombo.GetButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElTreeComboDropDownButton;
end;

function TCustomElTreeCombo.GetAltButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElTreeComboButton;
end;

procedure TCustomElTreeCombo.ChangeBtnGlyph;
var
  FGlyph: TBitmap;
begin
  FGlyph := TBitmap.Create;
  FGlyph.PixelFormat := pf32bit;
  FGlyph.Width := 9;
  FGlyph.Height := 5;
  FGlyph.TransparentMode := tmFixed;
  FGlyph.TransparentColor := clWhite;
  FGlyph.Canvas.Brush.Color := clWhite;
  FGlyph.Canvas.FillRect(Rect(0, 0, 9, 5));
  LMDDrawArrow(FGlyph.Canvas, eadDown, Rect(0, 1, 9, 5), clBlack, Enabled);
  TElTreeComboDropDownButton(FButton).Glyph := FGlyph;
  FGlyph.Free;
  TElTreeComboDropDownButton(FButton).ShowGlyph := not isThemed; //(UseXPThemes and IsThemeApplied);
  end;

procedure TCustomElTreeCombo.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
  ChangeBtnGlyph;
end;

procedure TCustomElTreeCombo.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
  w: integer;
begin
  w := Width;
  inherited;
  if (AWidth <> w) and (FDropWidth = w) then
    FDropWidth := AWidth;
end;

{ TElTreeComboButton }

function TElTreeComboButton.GetShowGlyph: Boolean;
begin
  if Assigned(Parent) then
  begin
    Result := (not TCustomElTreeCombo(Parent).IsThemed) or (TCustomElTreeCombo(Parent).FAltButton = Self);
  end
  else
    result := true;
end;

function TElTreeComboDropDownButton.GetDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
  else
    if FState in [ebsDown, ebsExclusive] then
    result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
  else
    if FMouseInControl or FMouseInArrow or Focused then
    result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
  else
    result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
end;

procedure TCustomElTreeCombo.SetStyle(Value: TElComboBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TElComboBoxStyle)..High(TElComboBoxStyle)]) then
  begin
    FStyle := Value;
    FReadOnly := (Style <> tcsDropDown) or FOwnReadOnly;
    FIgnoreReadOnlyState := not FOwnReadOnly;
  end;
end;

procedure TCustomElTreeCombo.SetShowImagesInText(const Value: Boolean);
begin
  if FShowImagesInText <> Value then
  begin
    FShowImagesInText := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElTreeCombo.SetEditRect(Value: TRect);
begin
  if Assigned(Images) and (FShowImagesInText) and (FTextImageIndex > -1) then
    LeftMargin := Images.Width + 4
  else
    LeftMargin := 1;
  inherited SetEditRect(Value);
end;

procedure TCustomElTreeCombo.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    CheckTextImageIndex;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElTreeCombo.CheckTextImageIndex;
begin
  FTextImageIndex := -1;
  if Assigned(Images) and (FShowImagesInText) then
  begin
    if FImageIndex > -1 then
      FTextImageIndex := FImageIndex
    else
      if Assigned(Selection) then
        FTextImageIndex := Selection.ImageIndex;
  end;
  SetEditRect(ClientRect);
end;
{
function TCustomElTreeCombo.GetPartIDForBackground: integer;
begin
  Result := 0;
end;
}
{
function TCustomElTreeCombo.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiComboBox;
end;
}

function TCustomElTreeCombo.GetThemedElement: TThemedElement;
begin
  Result := teComboBox;
end;

procedure TCustomElTreeCombo.PaintText(Canvas : TCanvas);
var
  R: TRect;
  LOldBkColor: TColor;
begin
  if (Style = tcsDropDownList) then
  begin
    if self.Text <> EmptyStr then SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
    if Focused then
    begin
      R := ClientRect;
      if ButtonVisible then
        R.Right := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
      if not Dropped then
      begin
        LOldBkColor := Canvas.Brush.Color;
        Canvas.Brush.Color := GetBkColor;
        Canvas.FillRect(R);
        Canvas.DrawFocusRect(R);
        Canvas.Brush.Color := LOldBkColor;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomElTreeCombo.Paint;
var
  LHelperBitmap, LHelperBitmap1 : TBitmap;
  LCanvas: TCanvas;
  i: integer;
  R, R1: TRect;
begin
  inherited;
  if Assigned(Images) and (FShowImagesInText) and (FTextImageIndex > -1) then
  begin
    LCanvas := TCanvas.Create;
    LCanvas.Handle := GetDC(Handle);

    R := Classes.Rect(0, 0, Images.Width, ClientHeight);
    LMDCenterRects(Images.Width, R.Right - R.Left, Images.Height, R.Bottom - R.Top, R1);
    OffsetRect(R1, R.Left + 1, R.Top);
    i := FTextImageIndex;
    if (AlphaForImages <> nil) and (i < AlphaForImages.Count) then
    begin
      LHelperBitmap := TBitmap.Create;
      LHelperBitmap.Width := Images.Width;
      LHelperBitmap.Height := Images.Height;
      ImageList_DrawEx(Images.Handle, I, LHelperBitmap.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      LHelperBitmap1 := TBitmap.Create;
      LHelperBitmap1.Width := AlphaForImages.Width;
      LHelperBitmap1.Height := AlphaForImages.Height;
      ImageList_DrawEx(AlphaForImages.Handle, I, LHelperBitmap1.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);
      AlphaCopyRect2(LCanvas.Handle, R1, LHelperBitmap.Canvas.Handle, rect(0, 0, LHelperBitmap.Width, LHelperBitmap.Height), LHelperBitmap1, 255);

      LHelperBitmap.Free;
      LHelperBitmap1.Free;
    end
    else
      ImageList_Draw(Images.Handle, i, LCanvas.Handle, R1.Left, R1.Top, ILD_NORMAL);
    ReleaseDC(Handle, LCanvas.Handle);
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

end.
