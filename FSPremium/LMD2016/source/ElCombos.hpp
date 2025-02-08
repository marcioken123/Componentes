// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCombos.pas' rev: 31.00 (Windows)

#ifndef ElcombosHPP
#define ElcombosHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Menus.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.Imm.hpp>
#include <LMDThemes.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicode.hpp>
#include <ElVCLUtils.hpp>
#include <ElImgFrm.hpp>
#include <ElPopBtn.hpp>
#include <ElSBCtrl.hpp>
#include <ElInputProcessor.hpp>
#include <ElEdits.hpp>
#include <ElListBox.hpp>
#include <ElBtnEdit.hpp>
#include <ElFrmPers.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElSndMap.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcombos
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElComboListBox;
class DELPHICLASS TCustomElComboBox;
class DELPHICLASS TElComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElFontSampleMode : unsigned char { fsmFontName, fsmFontSample, fsmBoth, fsmNoSample };

enum DECLSPEC_DENUM TElFontDevice : unsigned char { efdScreen, efdPrinter, efdBoth };

enum DECLSPEC_DENUM TElFontComboOption : unsigned char { foAnsiOnly, foTrueTypeOnly, foIncludeOEMFonts, foIncludeSymbolFonts, foOEMFontsOnly, foScalableOnly, foExcludeAtPrefixedFonts };

typedef System::Set<TElFontComboOption, TElFontComboOption::foAnsiOnly, TElFontComboOption::foExcludeAtPrefixedFonts> TElFontComboOptions;

typedef void __fastcall (__closure *TElAutoHistoryItemAddEvent)(System::TObject* Sender, const Lmdtypes::TLMDString aString, const int aIdx);

typedef void __fastcall (__closure *TElAutoHistoryItemMoveEvent)(System::TObject* Sender, const Lmdtypes::TLMDString aString, const int aIdx);

enum DECLSPEC_DENUM TElAutoHistoryDirection : unsigned char { ahdFirst, ahdLast };

typedef void __fastcall (__closure *TElComboBoxBeforeSelectValueEvent)(System::TObject* Sender, int AnIndex, bool &AnAllow);

class PASCALIMPLEMENTATION TElComboListBox : public Ellistbox::TElListBox
{
	typedef Ellistbox::TElListBox inherited;
	
private:
	TCustomElComboBox* FCombo;
	bool FIsContextMenuUp;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Msg);
	
protected:
	DYNAMIC void __fastcall ResetContent(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual Vcl::Graphics::TBitmap* __fastcall GetBackground(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	virtual void __fastcall UpdateItemHeight(void);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	
public:
	__fastcall virtual TElComboListBox(System::Classes::TComponent* AOwner);
public:
	/* TCustomElListBox.Destroy */ inline __fastcall virtual ~TElComboListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElComboListBox(HWND ParentWindow) : Ellistbox::TElListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElComboBox : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
protected:
	bool FAutoCompletionProcessByAnyChange;
	bool FForceItemHeight;
	System::Types::TSize FSaveSize;
	bool FUseSaveSize;
	bool FIgnoreFocus;
	bool FChangeAllowed;
	int FDropDownWidth;
	bool FAutoCompletion;
	Lmdtypes::TLMDString FTextBefoCompletation;
	bool FAutoHistory;
	TElAutoHistoryDirection FAutoHistoryDirection;
	int FAutoHistoryLimit;
	TElAutoHistoryItemAddEvent FOnAutoHistoryItemAdd;
	TElAutoHistoryItemMoveEvent FOnAutoHistoryItemMove;
	Elinputprocessor::TElKeyboardInput* Input;
	System::Classes::TThread* SearchTextTimeoutThread;
	System::Classes::TAlignment FAltBtnAlign;
	int FDropDownCount;
	Vcl::Forms::TForm* FForm;
	int FItemIndex;
	TElComboListBox* FListBox;
	System::Classes::TNotifyEvent FOnAltBtnClick;
	System::Classes::TNotifyEvent FOnDropDown;
	System::Classes::TNotifyEvent FOnCloseUp;
	System::Uitypes::TColor FArrowColor;
	System::Uitypes::TColor FSaveColor;
	bool FSaveFlat;
	bool FForcedText;
	bool FIgnoreItemIdx;
	bool FOldActive;
	bool FCanDrop;
	bool FDroppedDown;
	bool FForcedTextClear;
	bool FAdjustDropDownPos;
	bool FHorizontalScroll;
	Vcl::Stdctrls::TComboBoxStyle FStyle;
	Vcl::Stdctrls::TDrawItemEvent FOnDrawItem;
	Vcl::Stdctrls::TMeasureItemEvent FOnMeasureItem;
	Vcl::Graphics::TCanvas* FEditCanvas;
	Vcl::Graphics::TCanvas* FCanvas;
	System::Classes::TAlignment FDropDownAlignment;
	int FIncrementalSearchTimeout;
	bool FShowGripper;
	System::Classes::TNotifyEvent FOnSelect;
	bool FAutoCompleteUseCase;
	bool FWMKeyDown;
	bool FOwnReadOnly;
	TElComboBoxBeforeSelectValueEvent FOnBeforeSelectValue;
	DYNAMIC void __fastcall Select(void);
	int __fastcall GetItemHeight(void);
	void __fastcall ChangeBtnGlyph(void);
	void __fastcall SetItemHeight(int Value);
	void __fastcall SetForceItemHeight(const bool Value);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, NativeUInt ComboWnd, void * ComboProc);
	bool __fastcall GetListTransparentSelection(void);
	void __fastcall SetListTransparentSelection(bool Value);
	void __fastcall SetDropDownWidth(const int Value);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	virtual void __fastcall DoChange(void);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMMButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	MESSAGE void __fastcall EMSetReadOnly(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall GetThemedElementDetails(Vcl::Themes::TThemedElementDetails &ADetails);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall GetDropDownValue(void);
	bool __fastcall GetDroppedDown(void);
	Vcl::Menus::TPopupMenu* __fastcall GetListBoxPopup(void);
	void __fastcall SetListBoxPopup(Vcl::Menus::TPopupMenu* Value);
	System::Classes::TStrings* __fastcall GetItems(void);
	System::Uitypes::TColor __fastcall GetListColor(void);
	bool __fastcall GetListInvertSelection(void);
	bool __fastcall GetSorted(void);
	bool __fastcall GetUseBackground(void);
	void __fastcall ListBoxClick(System::TObject* Sender);
	void __fastcall SetDropDownCount(const int Value);
	void __fastcall SetDroppedDown(const bool Value);
	void __fastcall SetCanDrop(const bool Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	void __fastcall SetListColor(const System::Uitypes::TColor Value);
	void __fastcall SetListInvertSelection(const bool Value);
	void __fastcall SetSorted(const bool Value);
	HIDESBASE void __fastcall SetUseBackground(const bool Value);
	int __fastcall GetDroppedIndex(void);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	void __fastcall SetHorizontalScroll(const bool Value);
	virtual int __fastcall GetRightOffsetForBackground(void);
	virtual void __fastcall AdjustFocusedRect(System::Types::TRect &aRect);
	virtual void __fastcall AdjustRegion(void);
	virtual Vcl::Stdctrls::TComboBoxStyle __fastcall GetCurrentStyle(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	Elimgfrm::TElImageForm* __fastcall GetListImageForm(void);
	void __fastcall SetListImageForm(Elimgfrm::TElImageForm* newValue);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	virtual int __fastcall GetDropDownHeight(void);
	virtual void __fastcall DoDropDown(void);
	virtual void __fastcall DoCloseUp(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	virtual System::Uitypes::TColor __fastcall GetBtnArrowColor(void);
	virtual void __fastcall SetBtnArrowColor(System::Uitypes::TColor newValue);
	HIDESBASE void __fastcall SetAltBtnAlign(System::Classes::TLeftRight Value);
	virtual void __fastcall DoAutoComplete(void);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetFlat(const bool Value);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetButtonClass(void);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetAltButtonClass(void);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall DestroyWnd(void);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	bool __fastcall GetShowLineHint(void);
	void __fastcall SetShowLineHint(bool Value);
	virtual void __fastcall SetStyle(Vcl::Stdctrls::TComboBoxStyle Value);
	HWND __fastcall GetEditHandle(void);
	void __fastcall SetDropDownAlignment(System::Classes::TAlignment Value);
	bool __fastcall GetRightAlignedView(void);
	virtual void __fastcall SetRightAlignedView(bool Value);
	virtual void __fastcall SetRightAlignedText(bool Value);
	virtual void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetHighlightAlphaLevel(int Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadBtnColor(System::Classes::TReader* Reader);
	virtual Lmdtypes::TLMDString __fastcall GetTextFromItem(int Index);
	void __fastcall ReadBtnArrowColor(System::Classes::TReader* Reader);
	void __fastcall ReadBtnFlat(System::Classes::TReader* Reader);
	void __fastcall ReadBtnTransparent(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnColor(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnFlat(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnTransparent(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnVisible(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnWidth(System::Classes::TReader* Reader);
	void __fastcall ReadAltBtnPosition(System::Classes::TReader* Reader);
	Vcl::Graphics::TBitmap* __fastcall GetAltBtnGlyph(void);
	void __fastcall SetAltBtnGlyph(Vcl::Graphics::TBitmap* Value);
	void __fastcall ReadReadOnly(System::Classes::TReader* Reader);
	virtual int __fastcall GetItemWidth(int Index);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall PaintText(Vcl::Graphics::TCanvas* Canvas);
	HIDESBASE MESSAGE void __fastcall WMDeadChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEComposition(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEStartComposition(Winapi::Messages::TMessage &Message);
	void __fastcall StartClearSearchTimeoutThread(void);
	void __fastcall StopClearSearchTimeoutThread(void);
	virtual bool __fastcall DoPerformSearch(Lmdtypes::TLMDString SearchText, int AFromIndex = 0x0);
	void __fastcall SearchTextTimeout(System::TObject* Sender);
	virtual bool __fastcall DoCompareItems(Lmdtypes::TLMDString SearchText, int ItemIndex);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaForImages(void);
	void __fastcall SetAlphaForImages(Vcl::Imglist::TCustomImageList* Value);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	HIDESBASE Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetHorzScrollBar(void);
	HIDESBASE Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetVertScrollBar(void);
	bool __fastcall GetUseCustomScrollBars(void);
	HIDESBASE void __fastcall SetHorzScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	HIDESBASE void __fastcall SetVertScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	HIDESBASE void __fastcall SetUseCustomScrollBars(const bool Value);
	void __fastcall SetShowGripper(bool Value);
	__property HWND EditHandle = {read=GetEditHandle, nodefault};
	__property System::Uitypes::TColor ButtonArrowColor = {read=GetBtnArrowColor, write=SetBtnArrowColor, default=-16777198};
	__property Vcl::Graphics::TBitmap* AltBtnGlyph = {read=GetAltBtnGlyph, stored=false};
	__property bool CanDrop = {read=FCanDrop, write=SetCanDrop, default=1};
	__property int DropDownCount = {read=FDropDownCount, write=SetDropDownCount, default=8};
	__property int DropDownWidth = {read=FDropDownWidth, write=SetDropDownWidth, default=-1};
	__property bool ListTransparentSelection = {read=GetListTransparentSelection, write=SetListTransparentSelection, default=0};
	__property bool AutoCompletion = {read=FAutoCompletion, write=FAutoCompletion, default=0};
	__property bool AutoCompletionProcessByAnyChange = {read=FAutoCompletionProcessByAnyChange, write=FAutoCompletionProcessByAnyChange, default=1};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property System::Uitypes::TColor ListColor = {read=GetListColor, write=SetListColor, default=-16777211};
	__property Elimgfrm::TElImageForm* ListImageForm = {read=GetListImageForm, write=SetListImageForm};
	__property bool ListInvertSelection = {read=GetListInvertSelection, write=SetListInvertSelection, default=0};
	__property bool Sorted = {read=GetSorted, write=SetSorted, default=0};
	__property bool UseBackground = {read=GetUseBackground, write=SetUseBackground, default=0};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property System::Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property bool AdjustDropDownPos = {read=FAdjustDropDownPos, write=FAdjustDropDownPos, default=1};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property bool ShowLineHint = {read=GetShowLineHint, write=SetShowLineHint, default=0};
	__property bool HorizontalScroll = {read=FHorizontalScroll, write=SetHorizontalScroll, default=0};
	__property Vcl::Stdctrls::TComboBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=FOnMeasureItem, write=FOnMeasureItem};
	__property System::Classes::TAlignment DropDownAlignment = {read=FDropDownAlignment, write=SetDropDownAlignment, default=1};
	__property bool ForcedTextClear = {read=FForcedTextClear, write=FForcedTextClear, default=0};
	__property bool AutoHistory = {read=FAutoHistory, write=FAutoHistory, default=0};
	__property TElAutoHistoryDirection AutoHistoryDirection = {read=FAutoHistoryDirection, write=FAutoHistoryDirection, default=0};
	__property int AutoHistoryLimit = {read=FAutoHistoryLimit, write=FAutoHistoryLimit, default=25};
	__property TElAutoHistoryItemAddEvent OnAutoHistoryItemAdd = {read=FOnAutoHistoryItemAdd, write=FOnAutoHistoryItemAdd};
	__property TElAutoHistoryItemMoveEvent OnAutoHistoryItemMove = {read=FOnAutoHistoryItemMove, write=FOnAutoHistoryItemMove};
	__property int IncrementalSearchTimeout = {read=FIncrementalSearchTimeout, write=FIncrementalSearchTimeout, default=500};
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=GetAlphaForImages, write=SetAlphaForImages};
	__property bool ShowGripper = {read=FShowGripper, write=SetShowGripper, default=0};
	__property Elsbctrl::TElCtrlScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBar, write=SetHorzScrollBar};
	__property Elsbctrl::TElCtrlScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBar, write=SetVertScrollBar};
	__property bool UseCustomScrollBars = {read=GetUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property bool RightAlignedView = {read=GetRightAlignedView, write=SetRightAlignedView, default=0};
	int __fastcall GetSelectedItemIndex(void);
	void __fastcall SelectItem(bool Previous);
	virtual System::Uitypes::TColor __fastcall GetBkColor(void);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property bool AutoCompleteUseCase = {read=FAutoCompleteUseCase, write=FAutoCompleteUseCase, default=0};
	bool __fastcall GetHideFocusRect(void);
	void __fastcall SetHideFocusRect(bool AValue);
	void __fastcall SetSaveUnicode(const bool AValue);
	bool __fastcall GetSaveUnicode(void);
	__property TElComboBoxBeforeSelectValueEvent OnBeforeSelectValue = {read=FOnBeforeSelectValue, write=FOnBeforeSelectValue};
	
public:
	__fastcall virtual TCustomElComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElComboBox(void);
	__property TElComboListBox* ListBox = {read=FListBox};
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall CloseUp(bool AcceptValue);
	virtual void __fastcall DropDown(void);
	void __fastcall AutoHistoryUpdate(void);
	__property Vcl::Menus::TPopupMenu* ListBoxPopupMenu = {read=GetListBoxPopup, write=SetListBoxPopup};
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property bool DroppedDown = {read=GetDroppedDown, write=SetDroppedDown, nodefault};
	__property int DroppedIndex = {read=GetDroppedIndex, nodefault};
	__property Ctl3D;
	__property bool ForceItemHeight = {read=FForceItemHeight, write=SetForceItemHeight, default=0};
	__property ParentCtl3D = {default=1};
	__property int SelectedItemIndex = {read=GetSelectedItemIndex, nodefault};
	__property bool HideFocusRect = {read=GetHideFocusRect, write=SetHideFocusRect, nodefault};
	__property bool SaveUnicode = {read=GetSaveUnicode, write=SetSaveUnicode, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElComboBox(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElComboBox : public TCustomElComboBox
{
	typedef TCustomElComboBox inherited;
	
__published:
	__property SaveUnicode;
	__property StressShortCut = {default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property AutoCompletion = {default=0};
	__property AutoCompleteUseCase = {default=0};
	__property AutoCompletionProcessByAnyChange = {default=1};
	__property Items;
	__property ListColor = {default=-16777211};
	__property ListImageForm;
	__property ListInvertSelection = {default=0};
	__property Sorted = {default=0};
	__property UseBackground = {default=0};
	__property OnDropDown;
	__property OnCloseUp;
	__property AdjustDropDownPos = {default=1};
	__property ItemIndex = {default=-1};
	__property ShowLineHint = {default=0};
	__property HorizontalScroll = {default=0};
	__property Style = {default=0};
	__property ItemHeight;
	__property OnDrawItem;
	__property OnMeasureItem;
	__property DropDownAlignment = {default=1};
	__property ShowGripper = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property RightAlignedView = {default=0};
	__property ForceItemHeight = {default=0};
	__property OnSelect;
	__property AutoHistory = {default=0};
	__property AutoHistoryDirection = {default=0};
	__property AutoHistoryLimit = {default=25};
	__property OnAutoHistoryItemAdd;
	__property OnAutoHistoryItemMove;
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property ReadOnly = {default=0};
	__property MaxLength = {default=0};
	__property BorderSides = {default=15};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property ListBoxPopupMenu;
	__property ImageForm;
	__property IncrementalSearchTimeout = {default=500};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property OnKeyPressEx;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Text;
	__property ForcedTextClear = {default=0};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=1};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonOldStyled = {default=0};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonShowBorder = {default=1};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
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
	__property AltButtonOldStyled = {default=0};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShowBorder = {default=1};
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonPngGlyph;
	__property AltButtonUsePng;
	__property OnAltButtonClick;
	__property BorderStyle = {default=1};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
	__property OnBeforeSelectValue;
	__property HideFocusRect;
public:
	/* TCustomElComboBox.Create */ inline __fastcall virtual TElComboBox(System::Classes::TComponent* AOwner) : TCustomElComboBox(AOwner) { }
	/* TCustomElComboBox.Destroy */ inline __fastcall virtual ~TElComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElComboBox(HWND ParentWindow) : TCustomElComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcombos */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCOMBOS)
using namespace Elcombos;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcombosHPP
