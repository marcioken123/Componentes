// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeCombo.pas' rev: 31.00 (Windows)

#ifndef EltreecomboHPP
#define EltreecomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDObjectList.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDGlyphs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDStrings.hpp>
#include <LMDProcs.hpp>
#include <LMDUnicode.hpp>
#include <ElDragDrop.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElImgLst.hpp>
#include <ElPopBtn.hpp>
#include <ElVCLUtils.hpp>
#include <ElBtnEdit.hpp>
#include <ElSBCtrl.hpp>
#include <ElScrollBar.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElIni.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElSndMap.hpp>
#include <LMDPNGImage.hpp>
#include <ElImgFrm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreecombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeComboButton;
class DELPHICLASS TElTreeComboDropDownButton;
class DELPHICLASS TDropdownElTree;
class DELPHICLASS TCustomElTreeCombo;
class DELPHICLASS TElTreeCombo;
//-- type declarations -------------------------------------------------------
;

typedef void __fastcall (__closure *TElComboDropEvent)(System::TObject* Sender, bool Dropped);

typedef void __fastcall (__closure *TElGetDisplayTextEvent)(System::TObject* Sender, Eltree::TElTreeItem* Item, Lmdtypes::TLMDString &DisplayText);

class PASCALIMPLEMENTATION TElTreeComboButton : public Elpopbtn::TCustomElGraphicButton
{
	typedef Elpopbtn::TCustomElGraphicButton inherited;
	
protected:
	virtual bool __fastcall GetShowGlyph(void);
public:
	/* TCustomElGraphicButton.Create */ inline __fastcall virtual TElTreeComboButton(System::Classes::TComponent* AOwner) : Elpopbtn::TCustomElGraphicButton(AOwner) { }
	/* TCustomElGraphicButton.Destroy */ inline __fastcall virtual ~TElTreeComboButton(void) { }
	
};


class PASCALIMPLEMENTATION TElTreeComboDropDownButton : public TElTreeComboButton
{
	typedef TElTreeComboButton inherited;
	
protected:
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetDetails(void);
public:
	/* TCustomElGraphicButton.Create */ inline __fastcall virtual TElTreeComboDropDownButton(System::Classes::TComponent* AOwner) : TElTreeComboButton(AOwner) { }
	/* TCustomElGraphicButton.Destroy */ inline __fastcall virtual ~TElTreeComboDropDownButton(void) { }
	
};


class PASCALIMPLEMENTATION TDropdownElTree : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
private:
	TCustomElTreeCombo* FOwner;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMEnterSizeMove(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	virtual void __fastcall UpdateScrollBars(void);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMShowWindow(Winapi::Messages::TWMShowWindow &Message);
	HIDESBASE MESSAGE void __fastcall WMUpdateSBFrame(Winapi::Messages::TMessage &Message);
	
public:
	DYNAMIC bool __fastcall CanFocus(void);
	__fastcall virtual TDropdownElTree(System::Classes::TComponent* AOwner);
	void __fastcall ForceRecreateWnd(void);
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TDropdownElTree(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	/* TCustomElTree.Destroy */ inline __fastcall virtual ~TDropdownElTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropdownElTree(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TElComboBoxStyle : unsigned char { tcsDropDown, tcsDropDownList };

class PASCALIMPLEMENTATION TCustomElTreeCombo : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
private:
	bool FShowImagesInText;
	int FTextImageIndex;
	int FImageIndex;
	TElComboBoxStyle FStyle;
	Eltree::TEditRequestEvent FOnEditRequest;
	Vcl::Controls::TKeyEvent FOnTreeKeyDown;
	Vcl::Controls::TKeyPressEvent FOnTreeKeyPress;
	Vcl::Controls::TKeyEvent FOnTreeKeyUp;
	Vcl::Controls::TMouseEvent FOnTreeMouseDown;
	Vcl::Controls::TMouseMoveEvent FOnTreeMouseMove;
	Vcl::Controls::TMouseEvent FOnTreeMouseUp;
	bool FAutoProcessSelection;
	System::Classes::TNotifyEvent FOnNewTextSelection;
	int FDropWidth;
	int FDropHeight;
	Eltree::TValidateComboEvent FOnValidateCombo_FTree;
	Eltree::TElCellStyleSaveEvent FOnCellStyleLoad_FTree;
	Eltree::TElCellStyleSaveEvent FOnCellStyleSave_FTree;
	Eltree::TComboEditShowEvent FOnComboEditShow_FTree;
	Elheader::TElHeaderLookupEvent FOnHeaderLookup_FTree;
	Elheader::TElHeaderLookupDoneEvent FOnHeaderLookupDone_FTree;
	System::Classes::TNotifyEvent FOnHeaderResize_FTree;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnHeaderSectionAutoSize_FTree;
	Eltree::THeaderSectionEvent FOnHeaderSectionCollapse_FTree;
	Eltree::THeaderSectionEvent FOnHeaderSectionExpand_FTree;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnHeaderSectionFilterCall_FTree;
	Elsbctrl::TElScrollDrawPartEvent FOnHorzScrollDrawPart_FTree;
	Elsbctrl::TElScrollHintNeededEvent FOnHorzScrollHintNeeded_FTree;
	Eltree::THotTrackEvent FOnHotTrack_FTree;
	Eltree::TElItemSaveEvent FOnItemLoad_FTree;
	Eltree::TOnPicDrawEvent FOnItemPicDraw2_FTree;
	Eltree::TElItemSaveEvent FOnItemSave_FTree;
	Eltree::TItemSelChangeEvent FOnItemSelectedChange_FTree;
	Eltree::TOleDragFinishEvent FOnOleDragFinish_FTree;
	Eltree::TOleDragStartEvent FOnOleDragStart_FTree;
	Eldragdrop::TTargetDragEvent FOnOleTargetDrag_FTree;
	Eldragdrop::TTargetDropEvent FOnOleTargetDrop_FTree;
	System::Classes::TNotifyEvent FOnResize_FTree;
	Eltree::TElScrollEvent FOnScroll_FTree;
	Eltree::TTryEditEvent FOnTryEdit_FTree;
	Eltree::TOnValidateEvent FOnValidateInplaceEdit_FTree;
	Elsbctrl::TElScrollDrawPartEvent FOnVertScrollDrawPart_FTree;
	Elsbctrl::TElScrollHintNeededEvent FOnVertScrollHintNeeded_FTree;
	System::Uitypes::TCursor FSaveCursor;
	System::Uitypes::TCursor FSaveCursor1;
	bool FOwnReadOnly;
	bool FDropped;
	TElComboDropEvent FOnDrop;
	TDropdownElTree* FTree;
	Eltree::TElTreeItem* FTSelection;
	Lmdobjectlist::TLMDObjectList* FTSelectionList;
	bool IgnoreDrop;
	bool FMouseDown;
	HWND FSaveCapture;
	Eltree::TOnCompareItems FOnCompareItems;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnHeaderColumnClick;
	Elheader::TElSectionRedrawEvent FOnHeaderColumnDraw;
	Eltree::TElColumnMoveEvent FOnHeaderColumnMove;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnHeaderColumnResize;
	Eltree::TOnItemChangeEvent FOnItemChange;
	Eltree::TOnItemExpandEvent FOnItemCollapse;
	Eltree::TOnItemExpanding FOnItemCollapsing;
	Eltree::TOnItemExpandEvent FOnItemDeletion;
	Eltree::TOnItemDrawEvent FOnItemDraw;
	Eltree::TOnItemExpandEvent FOnItemExpand;
	Eltree::TOnItemExpanding FOnItemExpanding;
	System::Classes::TNotifyEvent FOnItemFocused;
	Eltree::TOnPicDrawEvent FOnItemPicDraw;
	Eltree::TOnShowHintEvent FOnShowLineHint;
	Vcl::Controls::TStartDragEvent FOnStartDrag_FTree;
	void __fastcall IntSelect(Eltree::TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, Eltree::TCustomElTree* Tree);
	Eltree::TElTreeItem* __fastcall GetSelection(void);
	HIDESBASE void __fastcall SetSelection(Eltree::TElTreeItem* Value);
	Lmdobjectlist::TLMDObjectList* __fastcall GetSelectionList(void);
	void __fastcall SetAutoLineHeight_FTree(bool Value);
	bool __fastcall GetAutoLineHeight_FTree(void);
	void __fastcall SetBkColor_FTree(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetBkColor_FTree(void);
	void __fastcall SetChangeStateImage_FTree(bool Value);
	bool __fastcall GetChangeStateImage_FTree(void);
	void __fastcall SetCtl3D_FTree(bool Value);
	bool __fastcall GetCtl3D_FTree(void);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor Value);
	System::Uitypes::TCursor __fastcall GetCursor(void);
	void __fastcall SetDraggableSections(bool Value);
	bool __fastcall GetDraggableSections(void);
	void __fastcall SetFont_FTree(Vcl::Graphics::TFont* Value);
	Vcl::Graphics::TFont* __fastcall GetFont_FTree(void);
	void __fastcall SetHeaderHotTrack_FTree(bool Value);
	bool __fastcall GetHeaderHotTrack_FTree(void);
	void __fastcall SetHeaderSections_FTree(Elheader::TElHeaderSections* Value);
	Elheader::TElHeaderSections* __fastcall GetHeaderSections_FTree(void);
	void __fastcall SetHideHintOnMove_FTree(bool Value);
	bool __fastcall GetHideHintOnMove_FTree(void);
	void __fastcall SetHideHintOnTimer_FTree(bool Value);
	bool __fastcall GetHideHintOnTimer_FTree(void);
	void __fastcall SetHideHorzScrollBar_FTree(bool Value);
	bool __fastcall GetHideHorzScrollBar_FTree(void);
	void __fastcall SetHideVertScrollBar_FTree(bool Value);
	bool __fastcall GetHideVertScrollBar_FTree(void);
	void __fastcall SetHorizontalLines_FTree(bool Value);
	bool __fastcall GetHorizontalLines_FTree(void);
	void __fastcall SetImages_FTree(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages_FTree(void);
	void __fastcall SetAlphaImages_FTree(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaImages_FTree(void);
	void __fastcall SetItems_FTree(Eltree::TElTreeItems* Value);
	Eltree::TElTreeItems* __fastcall GetItems_FTree(void);
	void __fastcall SetLineHintMode(Eltreeinplaceeditors::THintModes Value);
	Eltreeinplaceeditors::THintModes __fastcall GetLineHintMode(void);
	void __fastcall SetMainTreeColumn(int Value);
	int __fastcall GetMainTreeColumn(void);
	void __fastcall SetMultiSelect(bool Value);
	bool __fastcall GetMultiSelect(void);
	void __fastcall SetOwnerDrawByColumn(bool Value);
	bool __fastcall GetOwnerDrawByColumn(void);
	void __fastcall SetOwnerDrawMask(Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetOwnerDrawMask(void);
	HIDESBASE void __fastcall SetParentCtl3D(bool Value);
	bool __fastcall GetParentCtl3D(void);
	HIDESBASE void __fastcall SetParentFont(bool Value);
	bool __fastcall GetParentFont(void);
	HIDESBASE void __fastcall SetParentShowHint(bool Value);
	bool __fastcall GetParentShowHint(void);
	void __fastcall SetRowSelect(bool Value);
	bool __fastcall GetRowSelect(void);
	void __fastcall SetHorzScrollTracking(bool Value);
	bool __fastcall GetHorzScrollTracking(void);
	void __fastcall SetSelectionMode(Eltreeinplaceeditors::TSTSelModes Value);
	Eltreeinplaceeditors::TSTSelModes __fastcall GetSelectionMode(void);
	void __fastcall SetShowButtons(bool Value);
	bool __fastcall GetShowButtons(void);
	void __fastcall SetShowColumns(bool Value);
	bool __fastcall GetShowColumns(void);
	HIDESBASE void __fastcall SetShowHint(bool Value);
	bool __fastcall GetShowHint(void);
	void __fastcall SetShowImages(bool Value);
	bool __fastcall GetShowImages(void);
	void __fastcall SetShowLines(bool Value);
	bool __fastcall GetShowLines(void);
	void __fastcall SetShowRoot(bool Value);
	bool __fastcall GetShowRoot(void);
	void __fastcall SetSortDir(Eltreeinplaceeditors::TSortDirs Value);
	Eltreeinplaceeditors::TSortDirs __fastcall GetSortDir(void);
	void __fastcall SetSortMode(Eltreeinplaceeditors::TSortModes Value);
	Eltreeinplaceeditors::TSortModes __fastcall GetSortMode(void);
	void __fastcall SetSortSection(int Value);
	int __fastcall GetSortSection(void);
	void __fastcall SetSortType(Eltreeinplaceeditors::TSortTypes Value);
	Eltreeinplaceeditors::TSortTypes __fastcall GetSortType(void);
	void __fastcall Tree_SetTextColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall Tree_GetTextColor(void);
	void __fastcall SetTracking(bool Value);
	bool __fastcall GetTracking(void);
	void __fastcall SetVerticalLines(bool Value);
	bool __fastcall GetVerticalLines(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall CompareItemsTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item1, Eltree::TElTreeItem* Item2, int &res);
	void __fastcall ClickHandler(System::TObject* Sender);
	void __fastcall HeaderColumnClickTransfer(System::TObject* Sender, int SectionIndex);
	void __fastcall HeaderColumnDrawTransfer(Elheader::TCustomElHeader* Sender, Vcl::Graphics::TCanvas* Canvas, Elheader::TElHeaderSection* Section, const System::Types::TRect &R, bool Pressed);
	void __fastcall HeaderColumnMoveTransfer(Eltree::TCustomElTree* Sender, Elheader::TElHeaderSection* Section, int OldPos, int NewPos);
	void __fastcall HeaderColumnResizeTransfer(System::TObject* Sender, int SectionIndex);
	void __fastcall ItemChangeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);
	void __fastcall ItemCollapseTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall ItemCollapsingTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, bool &CanProcess);
	void __fastcall ItemDeletionTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall ItemDrawTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);
	void __fastcall ItemExpandTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall ItemExpandingTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, bool &CanProcess);
	void __fastcall ItemFocusedTransfer(System::TObject* Sender);
	void __fastcall ItemPicDrawTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, int &ImageIndex);
	void __fastcall KeyDownHandler(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ShowLineHintTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text, Vcl::Controls::THintWindow* HintWindow, const System::Types::TPoint &MousePos, bool &DoShowHint);
	void __fastcall TreeResizeTransfer(System::TObject* Sender);
	void __fastcall ScrollTransfer(System::TObject* Sender, Vcl::Forms::TScrollBarKind ScrollBarKind, int ScrollCode);
	void __fastcall SetLineHeight_FTree(int Value);
	int __fastcall GetLineHeight_FTree(void);
	bool __fastcall GetCReadOnly(void);
	void __fastcall SetCReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	void __fastcall SetAlwaysKeepSelection_FTree(bool Value);
	bool __fastcall GetAlwaysKeepSelection_FTree(void);
	void __fastcall SetAutoExpand_FTree(bool Value);
	bool __fastcall GetAutoExpand_FTree(void);
	void __fastcall SetAutoLookup_FTree(bool Value);
	bool __fastcall GetAutoLookup_FTree(void);
	void __fastcall SetBarStyle_FTree(bool Value);
	bool __fastcall GetBarStyle_FTree(void);
	void __fastcall SetCustomPlusMinus_FTree(bool Value);
	bool __fastcall GetCustomPlusMinus_FTree(void);
	void __fastcall SetDeselectChildrenOnCollapse_FTree(bool Value);
	bool __fastcall GetDeselectChildrenOnCollapse_FTree(void);
	void __fastcall SetTreeDragImageMode(Eltreeinplaceeditors::TDragImgMode Value);
	Eltreeinplaceeditors::TDragImgMode __fastcall GetTreeDragImageMode(void);
	void __fastcall SetTreeDrawFocusRect(bool Value);
	bool __fastcall GetTreeDrawFocusRect(void);
	void __fastcall SetTreeFullRowSelect(bool Value);
	bool __fastcall GetTreeFullRowSelect(void);
	void __fastcall SetTreeImages2(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetTreeImages2(void);
	void __fastcall SetAlphaTreeImages2(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaTreeImages2(void);
	void __fastcall SetMinusPicture_FTree(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetMinusPicture_FTree(void);
	void __fastcall SetPlusPicture_FTree(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetPlusPicture_FTree(void);
	void __fastcall SetShowCheckboxes_FTree(bool Value);
	bool __fastcall GetShowCheckboxes_FTree(void);
	void __fastcall SetStickyHeaderSections_FTree(bool Value);
	bool __fastcall GetStickyHeaderSections_FTree(void);
	void __fastcall SetStoragePath_FTree(System::UnicodeString Value);
	System::UnicodeString __fastcall GetStoragePath_FTree(void);
	void __fastcall CellStyleLoad_FTreeTransfer(System::TObject* Sender, System::Classes::TStream* Stream, Eltree::TElCellStyle* Style);
	void __fastcall CellStyleSave_FTreeTransfer(System::TObject* Sender, System::Classes::TStream* Stream, Eltree::TElCellStyle* Style);
	void __fastcall ComboEditShow_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combobox);
	void __fastcall HeaderLookup_FTreeTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text);
	void __fastcall HeaderLookupDone_FTreeTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	void __fastcall HeaderResize_FTreeTransfer(System::TObject* Sender);
	void __fastcall HeaderSectionAutoSize_FTreeTransfer(System::TObject* Sender, int SectionIndex);
	void __fastcall HeaderSectionCollapse_FTreeTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall HeaderSectionExpand_FTreeTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall HeaderSectionFilterCall_FTreeTransfer(System::TObject* Sender, int SectionIndex);
	void __fastcall HorzScrollDrawPart_FTreeTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall HorzScrollHintNeeded_FTreeTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall HotTrack_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* OldItem, Eltree::TElTreeItem* NewItem);
	void __fastcall ItemLoad_FTreeTransfer(System::TObject* Sender, System::Classes::TStream* Stream, Eltree::TElTreeItem* Item);
	void __fastcall ItemPicDraw2_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, int &ImageIndex);
	void __fastcall ItemSave_FTreeTransfer(System::TObject* Sender, System::Classes::TStream* Stream, Eltree::TElTreeItem* Item);
	void __fastcall ItemSelectedChange_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall OleDragFinish_FTreeTransfer(System::TObject* Sender, Eldragdrop::TDragType dwEffect, HRESULT Result);
	void __fastcall OleDragStart_FTreeTransfer(System::TObject* Sender, _di_IDataObject &dataObj, _di_IDropSource &dropSource, Eldragdrop::TDragTypes &dwOKEffects);
	void __fastcall OleTargetDrag_FTreeTransfer(System::TObject* Sender, System::Uitypes::TDragState State, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	void __fastcall OleTargetDrop_FTreeTransfer(System::TObject* Sender, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	void __fastcall TryEdit_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);
	void __fastcall ValidateCombo_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combo, bool &Accept);
	void __fastcall ValidateInplaceEdit_FTreeTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section, System::UnicodeString &Text, bool &Accept);
	void __fastcall VertScrollDrawPart_FTreeTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall VertScrollHintNeeded_FTreeTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall PrepareSelection(void);
	void __fastcall SetDropWidth(int Value);
	void __fastcall SetDropHeight(int Value);
	void __fastcall SetPathSeparator(System::WideChar Value);
	System::WideChar __fastcall GetPathSeparator(void);
	bool __fastcall GetDrawFocusRect_FTree(void);
	void __fastcall SetFilteredVisibility_FTree(bool Value);
	bool __fastcall GetFilteredVisibility_FTree(void);
	void __fastcall SetRightAlignedText_FTree(bool Value);
	bool __fastcall GetRightAlignedText_FTree(void);
	void __fastcall SetRightAlignedTree_FTree(bool Value);
	bool __fastcall GetRightAlignedTree_FTree(void);
	void __fastcall SetCheckBoxGlyph_FTree(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetCheckBoxGlyph_FTree(void);
	void __fastcall SetCustomCheckboxes_FTree(bool Value);
	bool __fastcall GetCustomCheckboxes_FTree(void);
	void __fastcall SetRadioButtonGlyph_FTree(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetRadioButtonGlyph_FTree(void);
	void __fastcall SetUnderlineTracked_FTree(bool Value);
	bool __fastcall GetUnderlineTracked_FTree(void);
	void __fastcall SetDoInplaceEdit(bool Value);
	bool __fastcall GetDoInplaceEdit(void);
	void __fastcall TreeKeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall TreeKeyPressTransfer(System::TObject* Sender, System::WideChar &Key);
	void __fastcall TreeKeyUpTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall TreeMouseDownTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TreeMouseMoveTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TreeMouseUpTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetShowRootButtons(bool Value);
	bool __fastcall GetShowRootButtons(void);
	void __fastcall EditRequestTransfer(System::TObject* Sender, Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section);
	void __fastcall SetTreeFlat(bool Value);
	bool __fastcall GetTreeFlat(void);
	void __fastcall SetTreeHeaderActiveFilterColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetTreeHeaderActiveFilterColor(void);
	void __fastcall SetTreeHeaderFilterColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetTreeHeaderFilterColor(void);
	void __fastcall SetTreeHeaderFlat(bool Value);
	bool __fastcall GetTreeHeaderFlat(void);
	void __fastcall SetAutoResizeColumns(bool Value);
	bool __fastcall GetAutoResizeColumns(void);
	void __fastcall SetTreeBackground(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetTreeBackground(void);
	void __fastcall SetTreeBackgroundType(Lmdgraph::TLMDBackgroundType Value);
	Lmdgraph::TLMDBackgroundType __fastcall GetTreeBackgroundType(void);
	HIDESBASE void __fastcall SetFlatFocusedScrollbars(bool Value);
	bool __fastcall GetFlatFocusedScrollbars(void);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetGradientEndColor(void);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetGradientStartColor(void);
	void __fastcall SetGradientSteps(int Value);
	int __fastcall GetGradientSteps(void);
	void __fastcall SetHorzScrollBarStyles(Elscrollbar::TElScrollBarStyles* Value);
	Elscrollbar::TElScrollBarStyles* __fastcall GetHorzScrollBarStyles(void);
	void __fastcall SetVertScrollBarStyles(Elscrollbar::TElScrollBarStyles* Value);
	Elscrollbar::TElScrollBarStyles* __fastcall GetVertScrollBarStyles(void);
	System::Uitypes::TScrollStyle __fastcall GetForcedScrollBars(void);
	void __fastcall SetForcedScrollBars(const System::Uitypes::TScrollStyle Value);
	int __fastcall GetTreeHeaderHeight(void);
	void __fastcall SetTreeHeaderHeight(const int Value);
	bool __fastcall GetHeaderInvertSortArrows_FTree(void);
	void __fastcall SetHeaderInvertSortArrows_FTree(const bool Value);
	int __fastcall GetLeftPosition_FTree(void);
	void __fastcall SetLeftPosition_FTree(const int Value);
	System::Uitypes::TColor __fastcall GetLinesColor_FTree(void);
	Vcl::Graphics::TPenStyle __fastcall GetLinesStyle_FTree(void);
	void __fastcall SetLinesColor_FTree(const System::Uitypes::TColor Value);
	void __fastcall SetLinesStyle_FTree(const Vcl::Graphics::TPenStyle Value);
	bool __fastcall GetLockHeaderHeight_FTree(void);
	void __fastcall SetLockHeaderHeight_FTree(const bool Value);
	bool __fastcall GetMoveColumnOnDrag_FTree(void);
	bool __fastcall GetMoveFocusOnCollapse_FTree(void);
	void __fastcall SetMoveColumnOnDrag_FTree(const bool Value);
	void __fastcall SetMoveFocusOnCollapse_FTree(const bool Value);
	int __fastcall GetSelectColumn(void);
	void __fastcall SetSelectColumn(const int Value);
	void __fastcall StartDrag_FTreeTransfer(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	Elvclutils::TElFlatBorderType __fastcall GetTreeActiveBorderType(void);
	Elvclutils::TElFlatBorderType __fastcall GetTreeInactiveBorderType(void);
	void __fastcall SetTreeActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetTreeInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetStorage_FTree(Elini::TElIniFile* Value);
	Elini::TElIniFile* __fastcall GetStorage_FTree(void);
	bool __fastcall GetAlwaysKeepFocus(void);
	void __fastcall SetAlwaysKeepFocus(bool Value);
	bool __fastcall GetAdjustMultilineHeight(void);
	void __fastcall SetAdjustMultilineHeight(bool Value);
	void __fastcall SetBarStyleVerticalLines(bool Value);
	bool __fastcall GetBarStyleVerticalLines(void);
	int __fastcall GetChangeDelay(void);
	void __fastcall SetChangeDelay(int Value);
	System::Uitypes::TColor __fastcall GetHorzDivLinesColor(void);
	void __fastcall SetHorzDivLinesColor(System::Uitypes::TColor Value);
	Eltreeinplaceeditors::TDragTargetDraw __fastcall GetDragTrgDrawMode(void);
	void __fastcall SetDragTrgDrawMode(Eltreeinplaceeditors::TDragTargetDraw Value);
	int __fastcall GetDragExpandDelay(void);
	void __fastcall SetDragExpandDelay(int Value);
	System::Uitypes::TColor __fastcall GetDragRectAcceptColor(void);
	void __fastcall SetDragRectAcceptColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetDragRectDenyColor(void);
	void __fastcall SetDragRectDenyColor(System::Uitypes::TColor Value);
	bool __fastcall GetExpandOnDragOver(void);
	void __fastcall SetExpandOnDragOver(bool Value);
	System::Uitypes::TColor __fastcall GetHeaderColor(void);
	void __fastcall SetHeaderColor(System::Uitypes::TColor Value);
	bool __fastcall GetHeaderWrapCaptions(void);
	void __fastcall SetHeaderWrapCaptions(bool Value);
	bool __fastcall GetHideFocusRect(void);
	void __fastcall SetHideFocusRect(bool Value);
	bool __fastcall GetIncrementalSearch(void);
	void __fastcall SetIncrementalSearch(bool Value);
	int __fastcall GetItemIndent(void);
	void __fastcall SetItemIndent(int Value);
	System::Uitypes::TColor __fastcall GetLineHintColor(void);
	void __fastcall SetLineHintColor(System::Uitypes::TColor Value);
	int __fastcall GetLineHintTimeout(void);
	void __fastcall SetLineHintTimeout(int Value);
	Eltreeinplaceeditors::TLineHintType __fastcall GetLineHintType(void);
	void __fastcall SetLineHintType(Eltreeinplaceeditors::TLineHintType Value);
	bool __fastcall GetPlusMinusTransparent(void);
	void __fastcall SetPlusMinusTransparent(bool Value);
	bool __fastcall GetRightClickSelect(void);
	void __fastcall SetRightClickSelect(bool Value);
	bool __fastcall GetRowHotTrack(void);
	void __fastcall SetRowHotTrack(bool Value);
	bool __fastcall GetScrollbarOpposite(void);
	void __fastcall SetScrollbarOpposite(bool Value);
	System::Uitypes::TColor __fastcall GetTrackColor(void);
	void __fastcall SetTrackColor(System::Uitypes::TColor Value);
	bool __fastcall GetUseCustomScrollBars(void);
	HIDESBASE void __fastcall SetUseCustomScrollBars(bool Value);
	bool __fastcall GetVerticalLinesLong(void);
	void __fastcall SetVerticalLinesLong(bool Value);
	bool __fastcall GetUseSystemHintColors(void);
	void __fastcall SetUseSystemHintColors(bool Value);
	Elheader::TMeasureSectionEvent __fastcall GetOnHeaderSectionMeasure(void);
	void __fastcall SetOnHeaderSectionMeasure(Elheader::TMeasureSectionEvent Value);
	Eltree::TApplyVisFilterEvent __fastcall GetOnApplyVisFilter(void);
	void __fastcall SetOnApplyVisFilter(Eltree::TApplyVisFilterEvent Value);
	System::Classes::TNotifyEvent __fastcall GetOnAfterSelectionChange(void);
	void __fastcall SetOnAfterSelectionChange(System::Classes::TNotifyEvent Value);
	Eltree::TOnItemCheckedEvent __fastcall GetOnItemChecked(void);
	void __fastcall SetOnItemChecked(Eltree::TOnItemCheckedEvent Value);
	System::Classes::TNotifyEvent __fastcall GetOnSortBegin(void);
	void __fastcall SetOnSortBegin(System::Classes::TNotifyEvent Value);
	System::Classes::TNotifyEvent __fastcall GetOnSortEnd(void);
	void __fastcall SetOnSortEnd(System::Classes::TNotifyEvent Value);
	Lmdhtmlunit::TElHTMLImageNeededEvent __fastcall GetOnHTMLImageNeeded(void);
	void __fastcall SetOnHTMLImageNeeded(Lmdhtmlunit::TElHTMLImageNeededEvent Value);
	System::Uitypes::TColor __fastcall GetStripedOddColor(void);
	void __fastcall SetStripedOddColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetStripedEvenColor(void);
	void __fastcall SetStripedEvenColor(System::Uitypes::TColor Value);
	bool __fastcall GetStripedItems(void);
	void __fastcall SetStripedItems(bool Value);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSysKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSysKeyUp(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	bool __fastcall GetVertScrollTracking(void);
	void __fastcall SetVertScrollTracking(bool Value);
	void __fastcall SetShowImagesInText(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall CheckTextImageIndex(void);
	
protected:
	bool FNoCompletion;
	bool FShowGripper;
	bool FCloseOnClick;
	bool FSizeableTree;
	bool FAdjustDropDownPos;
	bool FHandleEditWhenDropped;
	bool FAutoCompletion;
	TElGetDisplayTextEvent FOnGetDisplayText;
	bool IgnoreFocus;
	virtual void __fastcall DblClickHandler(System::TObject* Sender);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall PaintText(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	void __fastcall ChangeBtnGlyph(void);
	virtual void __fastcall SetDropped(bool Value);
	virtual void __fastcall ProcessSelect(void);
	virtual void __fastcall TriggerDropEvent(bool Dropped);
	virtual void __fastcall TriggerNewTextSelectionEvent(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	Eltreeinplaceeditors::TElHintType __fastcall GetHintType(void);
	void __fastcall SetHintType(Eltreeinplaceeditors::TElHintType Value);
	MESSAGE void __fastcall WMActivateApp(Winapi::Messages::TWMActivateApp &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMButtonDblClk(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall EMSetReadOnly(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	virtual void __fastcall SetFocusedSelectColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetHideSelectColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetHideSelectTextColor(System::Uitypes::TColor Value);
	void __fastcall SetInheritedReadOnly(bool Value);
	System::Uitypes::TColor __fastcall GetVertDivLinesColor(void);
	void __fastcall SetVertDivLinesColor(System::Uitypes::TColor Value);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	Elheader::TElHeaderSections* __fastcall GetHeaderSections(void);
	void __fastcall SetHeaderSections(Elheader::TElHeaderSections* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetHeaderImages(void);
	void __fastcall SetHeaderImages(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaHeaderImages(void);
	void __fastcall SetAlphaHeaderImages(Vcl::Imglist::TCustomImageList* Value);
	int __fastcall GetMultiSelectLevel(void);
	void __fastcall SetMultiSelectLevel(int Value);
	int __fastcall GetDragScrollInterval(void);
	void __fastcall SetDragScrollInterval(int Value);
	bool __fastcall GetMouseFrameSelect(void);
	void __fastcall SetMouseFrameSelect(bool Value);
	virtual Eltree::TCustomElTree* __fastcall CreateTree(void);
	bool __fastcall GetShowLeafButton(void);
	void __fastcall SetShowLeafButton(bool Value);
	Vcl::Graphics::TBitmap* __fastcall GetLeafPicture(void);
	void __fastcall SetLeafPicture(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TFont* __fastcall GetHeaderFont(void);
	void __fastcall SetHeaderFont(Vcl::Graphics::TFont* Value);
	bool __fastcall GetHeaderUseTreeFont(void);
	void __fastcall SetHeaderUseTreeFont(bool Value);
	void __fastcall SetShowGripper(bool Value);
	void __fastcall SetSizeableTree(bool Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall Loaded(void);
	bool __fastcall IsButtonWidthStored(void);
	void __fastcall ReselectByText(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadTreeFocusedSelectColor(System::Classes::TReader* Reader);
	void __fastcall ReadTreeHeaderImages(System::Classes::TReader* Reader);
	virtual void __fastcall DoChange(void);
	virtual Lmdtypes::TLMDString __fastcall GetDisplayText(Eltree::TElTreeItem* Item);
	Elstyleman::TElStyleManager* __fastcall GetTreeStyleManager(void);
	void __fastcall SetTreeStyleManager(Elstyleman::TElStyleManager* Value);
	System::UnicodeString __fastcall GetTreeStyleName(void);
	void __fastcall SetTreeStyleName(const System::UnicodeString Value);
	virtual void __fastcall SetStyle(TElComboBoxStyle Value);
	void __fastcall ReadScrollTracking(System::Classes::TReader* Reader);
	virtual void __fastcall DestroyWnd(void);
	virtual System::Uitypes::TColor __fastcall GetBkColor(void);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetButtonClass(void);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetAltButtonClass(void);
	__property Eltree::TApplyVisFilterEvent OnApplyVisFilter = {read=GetOnApplyVisFilter, write=SetOnApplyVisFilter};
	HIDESBASE MESSAGE void __fastcall CMEnabledchanged(Winapi::Messages::TMessage &Message);
	__property bool ShowImagesInText = {read=FShowImagesInText, write=SetShowImagesInText, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	
public:
	__fastcall virtual TCustomElTreeCombo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElTreeCombo(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Eltree::TElTree* __fastcall GetTree(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Lmdobjectlist::TLMDObjectList* SelectionList = {read=GetSelectionList};
	__property bool Dropped = {read=FDropped, write=SetDropped, nodefault};
	__property Eltree::TElTreeItem* Selection = {read=GetSelection, write=SetSelection};
	__property Eltree::TElTreeItems* Items = {read=GetItems_FTree, write=SetItems_FTree};
	__property bool DoInplaceEdit = {read=GetDoInplaceEdit, write=SetDoInplaceEdit, nodefault};
	__property bool DeselectChildrenOnCollapse = {read=GetDeselectChildrenOnCollapse_FTree, write=SetDeselectChildrenOnCollapse_FTree, nodefault};
	__property Vcl::Graphics::TBitmap* CheckBoxGlyph = {read=GetCheckBoxGlyph_FTree, write=SetCheckBoxGlyph_FTree};
	__property bool CustomCheckboxes = {read=GetCustomCheckboxes_FTree, write=SetCustomCheckboxes_FTree, nodefault};
	__property bool AutoExpand = {read=GetAutoExpand_FTree, write=SetAutoExpand_FTree, nodefault};
	__property bool CustomPlusMinus = {read=GetCustomPlusMinus_FTree, write=SetCustomPlusMinus_FTree, nodefault};
	__property bool AutoLookup = {read=GetAutoLookup_FTree, write=SetAutoLookup_FTree, nodefault};
	__property bool ShowCheckboxes = {read=GetShowCheckboxes_FTree, write=SetShowCheckboxes_FTree, nodefault};
	__property bool DraggableSections = {read=GetDraggableSections, write=SetDraggableSections, nodefault};
	__property Eltreeinplaceeditors::TDragTargetDraw DragTrgDrawMode = {read=GetDragTrgDrawMode, write=SetDragTrgDrawMode, nodefault};
	__property int DragExpandDelay = {read=GetDragExpandDelay, write=SetDragExpandDelay, nodefault};
	__property System::Uitypes::TColor DragRectAcceptColor = {read=GetDragRectAcceptColor, write=SetDragRectAcceptColor, nodefault};
	__property System::Uitypes::TColor DragRectDenyColor = {read=GetDragRectDenyColor, write=SetDragRectDenyColor, nodefault};
	__property int DragScrollInterval = {read=GetDragScrollInterval, write=SetDragScrollInterval, nodefault};
	__property bool ExpandOnDragOver = {read=GetExpandOnDragOver, write=SetExpandOnDragOver, nodefault};
	__property Eltree::TOleDragFinishEvent OnOleDragFinish = {read=FOnOleDragFinish_FTree, write=FOnOleDragFinish_FTree};
	__property Eltree::TOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart_FTree, write=FOnOleDragStart_FTree};
	__property Eldragdrop::TTargetDragEvent OnOleTargetDrag = {read=FOnOleTargetDrag_FTree, write=FOnOleTargetDrag_FTree};
	__property Eldragdrop::TTargetDropEvent OnOleTargetDrop = {read=FOnOleTargetDrop_FTree, write=FOnOleTargetDrop_FTree};
	__property Eltreeinplaceeditors::TDragImgMode DragImageMode = {read=GetTreeDragImageMode, write=SetTreeDragImageMode, nodefault};
	__property bool PlusMinusTransparent = {read=GetPlusMinusTransparent, write=SetPlusMinusTransparent, nodefault};
	__property Vcl::Graphics::TBitmap* MinusPicture = {read=GetMinusPicture_FTree, write=SetMinusPicture_FTree};
	__property Vcl::Graphics::TBitmap* PlusPicture = {read=GetPlusPicture_FTree, write=SetPlusPicture_FTree};
	__property bool MoveFocusOnCollapse = {read=GetMoveFocusOnCollapse_FTree, write=SetMoveFocusOnCollapse_FTree, nodefault};
	__property int MultiSelectLevel = {read=GetMultiSelectLevel, write=SetMultiSelectLevel, nodefault};
	__property bool MultiSelect = {read=GetMultiSelect, write=SetMultiSelect, nodefault};
	__property System::WideChar PathSeparator = {read=GetPathSeparator, write=SetPathSeparator, nodefault};
	__property Vcl::Graphics::TBitmap* RadioButtonGlyph = {read=GetRadioButtonGlyph_FTree, write=SetRadioButtonGlyph_FTree};
	__property bool ShowRootButtons = {read=GetShowRootButtons, write=SetShowRootButtons, nodefault};
	__property bool ShowRoot = {read=GetShowRoot, write=SetShowRoot, nodefault};
	__property Elini::TElIniFile* Storage = {read=GetStorage_FTree, write=SetStorage_FTree};
	__property System::UnicodeString StoragePath = {read=GetStoragePath_FTree, write=SetStoragePath_FTree};
	__property TElGetDisplayTextEvent OnGetDisplayText = {read=FOnGetDisplayText, write=FOnGetDisplayText};
	__property Eltree::TTryEditEvent OnTryEdit = {read=FOnTryEdit_FTree, write=FOnTryEdit_FTree};
	__property Eltree::TComboEditShowEvent OnComboEditShow = {read=FOnComboEditShow_FTree, write=FOnComboEditShow_FTree};
	__property Eltree::TOnItemCheckedEvent OnItemChecked = {read=GetOnItemChecked, write=SetOnItemChecked};
	__property Eltree::TOnItemExpandEvent OnItemCollapse = {read=FOnItemCollapse, write=FOnItemCollapse};
	__property Eltree::TOnItemExpanding OnItemCollapsing = {read=FOnItemCollapsing, write=FOnItemCollapsing};
	__property Eltree::TOnItemExpandEvent OnItemExpand = {read=FOnItemExpand, write=FOnItemExpand};
	__property Eltree::TOnItemExpanding OnItemExpanding = {read=FOnItemExpanding, write=FOnItemExpanding};
	__property Eltree::TOnItemExpandEvent OnItemDeletion = {read=FOnItemDeletion, write=FOnItemDeletion};
	__property Eltree::TOnValidateEvent OnValidateInplaceEdit = {read=FOnValidateInplaceEdit_FTree, write=FOnValidateInplaceEdit_FTree};
	__property Elheader::TElHeaderSections* HeaderSections = {read=GetHeaderSections, write=SetHeaderSections};
	__property bool ShowButtons = {read=GetShowButtons, write=SetShowButtons, nodefault};
	__property bool ShowColumns = {read=GetShowColumns, write=SetShowColumns, nodefault};
	__property TElComboBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	
__published:
	__property ButtonWidth = {stored=IsButtonWidthStored, default=16};
	__property ButtonFlat = {default=0};
	__property ButtonColor = {default=-16777201};
	__property bool AutoLineHeight = {read=GetAutoLineHeight_FTree, write=SetAutoLineHeight_FTree, nodefault};
	__property System::Uitypes::TColor TreeBkColor = {read=GetBkColor_FTree, write=SetBkColor_FTree, nodefault};
	__property bool TreeChangeStateImage = {read=GetChangeStateImage_FTree, write=SetChangeStateImage_FTree, nodefault};
	__property bool TreeCtl3D = {read=GetCtl3D_FTree, write=SetCtl3D_FTree, nodefault};
	__property System::Uitypes::TCursor TreeCursor = {read=GetCursor, write=SetCursor, nodefault};
	__property Vcl::Graphics::TFont* TreeFont = {read=GetFont_FTree, write=SetFont_FTree};
	__property bool TreeHeaderHotTrack = {read=GetHeaderHotTrack_FTree, write=SetHeaderHotTrack_FTree, nodefault};
	__property bool TreeHeaderInvertSortArrows = {read=GetHeaderInvertSortArrows_FTree, write=SetHeaderInvertSortArrows_FTree, nodefault};
	__property Elheader::TElHeaderSections* TreeHeaderSections = {read=GetHeaderSections_FTree, write=SetHeaderSections_FTree};
	__property bool TreeHideHintOnMove = {read=GetHideHintOnMove_FTree, write=SetHideHintOnMove_FTree, nodefault};
	__property bool TreeHideHintOnTimer = {read=GetHideHintOnTimer_FTree, write=SetHideHintOnTimer_FTree, nodefault};
	__property bool TreeHideHorzScrollBar = {read=GetHideHorzScrollBar_FTree, write=SetHideHorzScrollBar_FTree, nodefault};
	__property bool TreeHideVertScrollBar = {read=GetHideVertScrollBar_FTree, write=SetHideVertScrollBar_FTree, nodefault};
	__property bool TreeHorizontalLines = {read=GetHorizontalLines_FTree, write=SetHorizontalLines_FTree, nodefault};
	__property int TreeLeftPosition = {read=GetLeftPosition_FTree, write=SetLeftPosition_FTree, nodefault};
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages_FTree, write=SetImages_FTree};
	__property Vcl::Imglist::TCustomImageList* Images2 = {read=GetTreeImages2, write=SetTreeImages2};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=GetAlphaImages_FTree, write=SetAlphaImages_FTree};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages2 = {read=GetAlphaTreeImages2, write=SetAlphaTreeImages2};
	__property Eltreeinplaceeditors::THintModes LineHintMode = {read=GetLineHintMode, write=SetLineHintMode, nodefault};
	__property int MainTreeColumn = {read=GetMainTreeColumn, write=SetMainTreeColumn, nodefault};
	__property bool OwnerDrawByColumn = {read=GetOwnerDrawByColumn, write=SetOwnerDrawByColumn, nodefault};
	__property Lmdtypes::TLMDString OwnerDrawMask = {read=GetOwnerDrawMask, write=SetOwnerDrawMask};
	__property bool TreeParentCtl3D = {read=GetParentCtl3D, write=SetParentCtl3D, nodefault};
	__property bool TreeParentFont = {read=GetParentFont, write=SetParentFont, nodefault};
	__property bool TreeParentShowHint = {read=GetParentShowHint, write=SetParentShowHint, nodefault};
	__property bool RowSelect = {read=GetRowSelect, write=SetRowSelect, nodefault};
	__property bool HorzScrollTracking = {read=GetHorzScrollTracking, write=SetHorzScrollTracking, nodefault};
	__property int SelectColumn = {read=GetSelectColumn, write=SetSelectColumn, nodefault};
	__property Eltreeinplaceeditors::TSTSelModes SelectionMode = {read=GetSelectionMode, write=SetSelectionMode, nodefault};
	__property bool TreeShowHint = {read=GetShowHint, write=SetShowHint, nodefault};
	__property bool ShowImages = {read=GetShowImages, write=SetShowImages, nodefault};
	__property bool ShowLines = {read=GetShowLines, write=SetShowLines, nodefault};
	__property Eltreeinplaceeditors::TSortDirs SortDir = {read=GetSortDir, write=SetSortDir, nodefault};
	__property Eltreeinplaceeditors::TSortModes SortMode = {read=GetSortMode, write=SetSortMode, nodefault};
	__property int SortSection = {read=GetSortSection, write=SetSortSection, nodefault};
	__property Eltreeinplaceeditors::TSortTypes SortType = {read=GetSortType, write=SetSortType, nodefault};
	__property System::Uitypes::TColor TextColor = {read=Tree_GetTextColor, write=Tree_SetTextColor, nodefault};
	__property bool Tracking = {read=GetTracking, write=SetTracking, nodefault};
	__property bool VerticalLines = {read=GetVerticalLines, write=SetVerticalLines, nodefault};
	__property bool AlwaysKeepSelection = {read=GetAlwaysKeepSelection_FTree, write=SetAlwaysKeepSelection_FTree, nodefault};
	__property bool BarStyle = {read=GetBarStyle_FTree, write=SetBarStyle_FTree, nodefault};
	__property bool DrawFocusRect = {read=GetTreeDrawFocusRect, write=SetTreeDrawFocusRect, nodefault};
	__property System::Uitypes::TScrollStyle ForcedScrollBars = {read=GetForcedScrollBars, write=SetForcedScrollBars, nodefault};
	__property bool FullRowSelect = {read=GetTreeFullRowSelect, write=SetTreeFullRowSelect, nodefault};
	__property bool MoveColumnOnDrag = {read=GetMoveColumnOnDrag_FTree, write=SetMoveColumnOnDrag_FTree, nodefault};
	__property bool StickyHeaderSections = {read=GetStickyHeaderSections_FTree, write=SetStickyHeaderSections_FTree, nodefault};
	__property int DropWidth = {read=FDropWidth, write=SetDropWidth, nodefault};
	__property int DropHeight = {read=FDropHeight, write=SetDropHeight, default=80};
	__property int LineHeight = {read=GetLineHeight_FTree, write=SetLineHeight_FTree, nodefault};
	__property System::Uitypes::TColor LinesColor = {read=GetLinesColor_FTree, write=SetLinesColor_FTree, nodefault};
	__property Vcl::Graphics::TPenStyle LinesStyle = {read=GetLinesStyle_FTree, write=SetLinesStyle_FTree, nodefault};
	__property bool LockHeaderHeight = {read=GetLockHeaderHeight_FTree, write=SetLockHeaderHeight_FTree, nodefault};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property bool FilteredVisibility = {read=GetFilteredVisibility_FTree, write=SetFilteredVisibility_FTree, nodefault};
	__property bool RightAlignedText = {read=GetRightAlignedText_FTree, write=SetRightAlignedText_FTree, nodefault};
	__property bool RightAlignedTree = {read=GetRightAlignedTree_FTree, write=SetRightAlignedTree_FTree, nodefault};
	__property Eltree::TOnCompareItems OnCompareItems = {read=FOnCompareItems, write=FOnCompareItems};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnClick = {read=FOnHeaderColumnClick, write=FOnHeaderColumnClick};
	__property Elheader::TElSectionRedrawEvent OnHeaderColumnDraw = {read=FOnHeaderColumnDraw, write=FOnHeaderColumnDraw};
	__property Eltree::TElColumnMoveEvent OnHeaderColumnMove = {read=FOnHeaderColumnMove, write=FOnHeaderColumnMove};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnResize = {read=FOnHeaderColumnResize, write=FOnHeaderColumnResize};
	__property Eltree::TOnItemChangeEvent OnItemChange = {read=FOnItemChange, write=FOnItemChange};
	__property Eltree::TOnItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property System::Classes::TNotifyEvent OnItemFocused = {read=FOnItemFocused, write=FOnItemFocused};
	__property Eltree::TOnPicDrawEvent OnItemPicDraw = {read=FOnItemPicDraw, write=FOnItemPicDraw};
	__property Eltree::TElScrollEvent OnScroll = {read=FOnScroll_FTree, write=FOnScroll_FTree};
	__property Eltree::TOnShowHintEvent OnShowLineHint = {read=FOnShowLineHint, write=FOnShowLineHint};
	__property System::Classes::TNotifyEvent OnTreeResize = {read=FOnResize_FTree, write=FOnResize_FTree};
	__property Eltree::TElCellStyleSaveEvent OnCellStyleLoad = {read=FOnCellStyleLoad_FTree, write=FOnCellStyleLoad_FTree};
	__property Eltree::TElCellStyleSaveEvent OnCellStyleSave = {read=FOnCellStyleSave_FTree, write=FOnCellStyleSave_FTree};
	__property Elheader::TElHeaderLookupEvent OnHeaderLookup = {read=FOnHeaderLookup_FTree, write=FOnHeaderLookup_FTree};
	__property Elheader::TElHeaderLookupDoneEvent OnHeaderLookupDone = {read=FOnHeaderLookupDone_FTree, write=FOnHeaderLookupDone_FTree};
	__property System::Classes::TNotifyEvent OnHeaderResize = {read=FOnHeaderResize_FTree, write=FOnHeaderResize_FTree};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionAutoSize = {read=FOnHeaderSectionAutoSize_FTree, write=FOnHeaderSectionAutoSize_FTree};
	__property Eltree::THeaderSectionEvent OnHeaderSectionCollapse = {read=FOnHeaderSectionCollapse_FTree, write=FOnHeaderSectionCollapse_FTree};
	__property Eltree::THeaderSectionEvent OnHeaderSectionExpand = {read=FOnHeaderSectionExpand_FTree, write=FOnHeaderSectionExpand_FTree};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionFilterCall = {read=FOnHeaderSectionFilterCall_FTree, write=FOnHeaderSectionFilterCall_FTree};
	__property Elsbctrl::TElScrollDrawPartEvent OnHorzScrollDrawPart = {read=FOnHorzScrollDrawPart_FTree, write=FOnHorzScrollDrawPart_FTree};
	__property Elsbctrl::TElScrollHintNeededEvent OnHorzScrollHintNeeded = {read=FOnHorzScrollHintNeeded_FTree, write=FOnHorzScrollHintNeeded_FTree};
	__property Eltree::THotTrackEvent OnHotTrack = {read=FOnHotTrack_FTree, write=FOnHotTrack_FTree};
	__property Eltree::TElItemSaveEvent OnItemLoad = {read=FOnItemLoad_FTree, write=FOnItemLoad_FTree};
	__property Eltree::TOnPicDrawEvent OnItemPicDraw2 = {read=FOnItemPicDraw2_FTree, write=FOnItemPicDraw2_FTree};
	__property Eltree::TElItemSaveEvent OnItemSave = {read=FOnItemSave_FTree, write=FOnItemSave_FTree};
	__property Eltree::TItemSelChangeEvent OnItemSelectedChange = {read=FOnItemSelectedChange_FTree, write=FOnItemSelectedChange_FTree};
	__property Eltree::TValidateComboEvent OnValidateCombo = {read=FOnValidateCombo_FTree, write=FOnValidateCombo_FTree};
	__property Elsbctrl::TElScrollDrawPartEvent OnVertScrollDrawPart = {read=FOnVertScrollDrawPart_FTree, write=FOnVertScrollDrawPart_FTree};
	__property Elsbctrl::TElScrollHintNeededEvent OnVertScrollHintNeeded = {read=FOnVertScrollHintNeeded_FTree, write=FOnVertScrollHintNeeded_FTree};
	__property System::Classes::TNotifyEvent OnNewTextSelection = {read=FOnNewTextSelection, write=FOnNewTextSelection};
	__property Vcl::Controls::TKeyEvent OnTreeKeyDown = {read=FOnTreeKeyDown, write=FOnTreeKeyDown};
	__property Vcl::Controls::TKeyPressEvent OnTreeKeyPress = {read=FOnTreeKeyPress, write=FOnTreeKeyPress};
	__property Vcl::Controls::TKeyEvent OnTreeKeyUp = {read=FOnTreeKeyUp, write=FOnTreeKeyUp};
	__property Vcl::Controls::TMouseEvent OnTreeMouseDown = {read=FOnTreeMouseDown, write=FOnTreeMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnTreeMouseMove = {read=FOnTreeMouseMove, write=FOnTreeMouseMove};
	__property Vcl::Controls::TMouseEvent OnTreeMouseUp = {read=FOnTreeMouseUp, write=FOnTreeMouseUp};
	__property TElComboDropEvent OnDrop = {read=FOnDrop, write=FOnDrop};
	__property bool UnderlineTracked = {read=GetUnderlineTracked_FTree, write=SetUnderlineTracked_FTree, nodefault};
	__property bool AutoProcessSelection = {read=FAutoProcessSelection, write=FAutoProcessSelection, default=1};
	__property Eltree::TEditRequestEvent OnEditRequest = {read=FOnEditRequest, write=FOnEditRequest};
	__property Elvclutils::TElFlatBorderType TreeActiveBorderType = {read=GetTreeActiveBorderType, write=SetTreeActiveBorderType, nodefault};
	__property bool TreeFlat = {read=GetTreeFlat, write=SetTreeFlat, nodefault};
	__property System::Uitypes::TColor TreeHeaderActiveFilterColor = {read=GetTreeHeaderActiveFilterColor, write=SetTreeHeaderActiveFilterColor, nodefault};
	__property System::Uitypes::TColor TreeHeaderFilterColor = {read=GetTreeHeaderFilterColor, write=SetTreeHeaderFilterColor, nodefault};
	__property bool TreeHeaderFlat = {read=GetTreeHeaderFlat, write=SetTreeHeaderFlat, nodefault};
	__property int TreeHeaderHeight = {read=GetTreeHeaderHeight, write=SetTreeHeaderHeight, nodefault};
	__property Elvclutils::TElFlatBorderType TreeInactiveBorderType = {read=GetTreeInactiveBorderType, write=SetTreeInactiveBorderType, nodefault};
	__property bool AutoResizeColumns = {read=GetAutoResizeColumns, write=SetAutoResizeColumns, nodefault};
	__property Vcl::Graphics::TBitmap* TreeBackground = {read=GetTreeBackground, write=SetTreeBackground};
	__property Lmdgraph::TLMDBackgroundType TreeBackgroundType = {read=GetTreeBackgroundType, write=SetTreeBackgroundType, nodefault};
	__property bool FlatFocusedScrollbars = {read=GetFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, nodefault};
	__property System::Uitypes::TColor GradientEndColor = {read=GetGradientEndColor, write=SetGradientEndColor, nodefault};
	__property System::Uitypes::TColor GradientStartColor = {read=GetGradientStartColor, write=SetGradientStartColor, nodefault};
	__property int GradientSteps = {read=GetGradientSteps, write=SetGradientSteps, nodefault};
	__property Elscrollbar::TElScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBarStyles, write=SetHorzScrollBarStyles};
	__property Elscrollbar::TElScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBarStyles, write=SetVertScrollBarStyles};
	__property bool AlwaysKeepFocus = {read=GetAlwaysKeepFocus, write=SetAlwaysKeepFocus, nodefault};
	__property bool AdjustMultilineHeight = {read=GetAdjustMultilineHeight, write=SetAdjustMultilineHeight, nodefault};
	__property bool BarStyleVerticalLines = {read=GetBarStyleVerticalLines, write=SetBarStyleVerticalLines, nodefault};
	__property int ChangeDelay = {read=GetChangeDelay, write=SetChangeDelay, nodefault};
	__property System::Uitypes::TColor HorzDivLinesColor = {read=GetHorzDivLinesColor, write=SetHorzDivLinesColor, nodefault};
	__property System::Uitypes::TColor HeaderColor = {read=GetHeaderColor, write=SetHeaderColor, nodefault};
	__property bool HeaderWrapCaptions = {read=GetHeaderWrapCaptions, write=SetHeaderWrapCaptions, nodefault};
	__property bool HideFocusRect = {read=GetHideFocusRect, write=SetHideFocusRect, nodefault};
	__property bool IncrementalSearch = {read=GetIncrementalSearch, write=SetIncrementalSearch, nodefault};
	__property int ItemIndent = {read=GetItemIndent, write=SetItemIndent, nodefault};
	__property System::Uitypes::TColor LineHintColor = {read=GetLineHintColor, write=SetLineHintColor, nodefault};
	__property int LineHintTimeout = {read=GetLineHintTimeout, write=SetLineHintTimeout, nodefault};
	__property Eltreeinplaceeditors::TLineHintType LineHintType = {read=GetLineHintType, write=SetLineHintType, nodefault};
	__property bool RightClickSelect = {read=GetRightClickSelect, write=SetRightClickSelect, nodefault};
	__property bool RowHotTrack = {read=GetRowHotTrack, write=SetRowHotTrack, nodefault};
	__property bool ScrollbarOpposite = {read=GetScrollbarOpposite, write=SetScrollbarOpposite, nodefault};
	__property System::Uitypes::TColor TrackColor = {read=GetTrackColor, write=SetTrackColor, nodefault};
	__property bool UseCustomScrollBars = {read=GetUseCustomScrollBars, write=SetUseCustomScrollBars, nodefault};
	__property bool VerticalLinesLong = {read=GetVerticalLinesLong, write=SetVerticalLinesLong, nodefault};
	__property bool UseSystemHintColors = {read=GetUseSystemHintColors, write=SetUseSystemHintColors, nodefault};
	__property Elheader::TMeasureSectionEvent OnHeaderSectionMeasure = {read=GetOnHeaderSectionMeasure, write=SetOnHeaderSectionMeasure};
	__property System::Classes::TNotifyEvent OnAfterSelectionChange = {read=GetOnAfterSelectionChange, write=SetOnAfterSelectionChange};
	__property System::Classes::TNotifyEvent OnSortBegin = {read=GetOnSortBegin, write=SetOnSortBegin};
	__property System::Classes::TNotifyEvent OnSortEnd = {read=GetOnSortEnd, write=SetOnSortEnd};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnHTMLImageNeeded = {read=GetOnHTMLImageNeeded, write=SetOnHTMLImageNeeded};
	__property System::Uitypes::TColor StripedOddColor = {read=GetStripedOddColor, write=SetStripedOddColor, nodefault};
	__property System::Uitypes::TColor StripedEvenColor = {read=GetStripedEvenColor, write=SetStripedEvenColor, nodefault};
	__property bool StripedItems = {read=GetStripedItems, write=SetStripedItems, nodefault};
	__property Eltreeinplaceeditors::TElHintType HintType = {read=GetHintType, write=SetHintType, nodefault};
	__property System::Uitypes::TColor VertDivLinesColor = {read=GetVertDivLinesColor, write=SetVertDivLinesColor, nodefault};
	__property bool CloseOnClick = {read=FCloseOnClick, write=FCloseOnClick, default=0};
	__property bool SizeableTree = {read=FSizeableTree, write=SetSizeableTree, default=1};
	__property Vcl::Imglist::TCustomImageList* HeaderImages = {read=GetHeaderImages, write=SetHeaderImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHeaderImages = {read=GetAlphaHeaderImages, write=SetAlphaHeaderImages};
	__property bool MouseFrameSelect = {read=GetMouseFrameSelect, write=SetMouseFrameSelect, nodefault};
	__property bool ShowLeafButton = {read=GetShowLeafButton, write=SetShowLeafButton, nodefault};
	__property Vcl::Graphics::TBitmap* LeafPicture = {read=GetLeafPicture, write=SetLeafPicture};
	__property Vcl::Graphics::TFont* HeaderFont = {read=GetHeaderFont, write=SetHeaderFont};
	__property bool ShowGripper = {read=FShowGripper, write=SetShowGripper, nodefault};
	__property bool HeaderUseTreeFont = {read=GetHeaderUseTreeFont, write=SetHeaderUseTreeFont, nodefault};
	__property bool AdjustDropDownPos = {read=FAdjustDropDownPos, write=FAdjustDropDownPos, default=1};
	__property bool HandleEditWhenDropped = {read=FHandleEditWhenDropped, write=FHandleEditWhenDropped, default=0};
	__property bool AutoCompletion = {read=FAutoCompletion, write=FAutoCompletion, default=0};
	__property Elstyleman::TElStyleManager* TreeStyleManager = {read=GetTreeStyleManager, write=SetTreeStyleManager};
	__property System::UnicodeString TreeStyleName = {read=GetTreeStyleName, write=SetTreeStyleName};
	__property bool VertScrollTracking = {read=GetVertScrollTracking, write=SetVertScrollTracking, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElTreeCombo(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeCombo : public TCustomElTreeCombo
{
	typedef TCustomElTreeCombo inherited;
	
__published:
	__property ShowImagesInText = {default=0};
	__property ImageIndex = {default=-1};
	__property Style = {default=0};
	__property StressShortCut = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Items;
	__property DoInplaceEdit;
	__property DeselectChildrenOnCollapse;
	__property CheckBoxGlyph;
	__property CustomCheckboxes;
	__property AutoExpand;
	__property CustomPlusMinus;
	__property AutoLookup;
	__property ShowCheckboxes;
	__property DraggableSections;
	__property DragTrgDrawMode;
	__property DragExpandDelay;
	__property DragRectAcceptColor;
	__property DragRectDenyColor;
	__property DragScrollInterval;
	__property ExpandOnDragOver;
	__property OnOleDragFinish;
	__property OnOleDragStart;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property DragImageMode;
	__property PlusMinusTransparent;
	__property MinusPicture;
	__property PlusPicture;
	__property MoveFocusOnCollapse;
	__property MultiSelectLevel;
	__property MultiSelect;
	__property PathSeparator;
	__property RadioButtonGlyph;
	__property ShowRootButtons;
	__property ShowRoot;
	__property Storage;
	__property StoragePath = {default=0};
	__property OnGetDisplayText;
	__property OnTryEdit;
	__property OnComboEditShow;
	__property OnItemChecked;
	__property OnItemCollapse;
	__property OnItemCollapsing;
	__property OnItemExpand;
	__property OnItemExpanding;
	__property OnItemDeletion;
	__property OnValidateInplaceEdit;
	__property HeaderSections;
	__property ShowButtons;
	__property ShowColumns;
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonEnabled = {default=1};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property OnButtonClick;
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIsSwitch = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonPngGlyph;
	__property AltButtonUsePng;
	__property OnAltButtonClick;
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AlignBottom = {default=1};
	__property AutoSelect = {default=0};
	__property AutoSize = {default=1};
	__property RightAlignedView = {default=0};
	__property BorderSides = {default=15};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property WantTabs = {default=0};
	__property HandleDialogKeys = {default=0};
	__property HideSelection = {default=1};
	__property TabSpaces = {default=4};
	__property ImageForm;
	__property WordWrap = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Text;
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property UseSystemMenu = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TCustomElTreeCombo.Create */ inline __fastcall virtual TElTreeCombo(System::Classes::TComponent* AOwner) : TCustomElTreeCombo(AOwner) { }
	/* TCustomElTreeCombo.Destroy */ inline __fastcall virtual ~TElTreeCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeCombo(HWND ParentWindow) : TCustomElTreeCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreecombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREECOMBO)
using namespace Eltreecombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreecomboHPP
