// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElListBox.pas' rev: 31.00 (Windows)

#ifndef EllistboxHPP
#define EllistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.RTLConsts.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.Imm.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDElConst.hpp>
#include <LMDTypes.hpp>
#include <LMDVldBase.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElHintWnd.hpp>
#include <ElXPThemedControl.hpp>
#include <ElInputProcessor.hpp>
#include <LMDStrings.hpp>
#include <ElSBCtrl.hpp>
#include <ElVCLUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Ellistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElListBoxStrings;
class DELPHICLASS TCustomElListBox;
class DELPHICLASS TElListBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElCheckBoxChangeEvent)(System::TObject* aSender, int aItemIndex, Vcl::Stdctrls::TCheckBoxState aItemState);

typedef void __fastcall (__closure *TDrawTextEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, int Index, System::Types::TRect &Rect, int Flags);

typedef void __fastcall (__closure *TElCheckStateChangeEvent)(System::TObject* Sender, int Index);

typedef System::StaticArray<int, 536870911> TIntArray;

typedef TIntArray *PIntArray;

class PASCALIMPLEMENTATION TElListBoxStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	TCustomElListBox* ListBox;
	
protected:
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual int __fastcall GetCount(void);
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	virtual void __fastcall SetUpdateState(bool Updating);
	void __fastcall ResetBox(void);
	
public:
	__fastcall TElListBoxStrings(void);
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual int __fastcall AddObject(const System::UnicodeString S, System::TObject* AnObject);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(const System::UnicodeString S);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	virtual void __fastcall InsertObject(int Index, const System::UnicodeString S, System::TObject* AObject);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
public:
	/* TStringList.Destroy */ inline __fastcall virtual ~TElListBoxStrings(void) { }
	
};


typedef void __fastcall (__closure *TElListBoxMultiCheckEvent)(System::TObject* Sender, int FromItemNo, int ToItemNo);

class PASCALIMPLEMENTATION TCustomElListBox : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
	
private:
	typedef System::DynamicArray<System::Byte> _TCustomElListBox__1;
	
	
private:
	bool fUseCustomScrollBars;
	Elsbctrl::TElSBController* fSBCtrl;
	int FItemIndex;
	int FSavedItemIndex;
	int FCheckIndex;
	System::Classes::TNotifyEvent FOnChange;
	int FSavedIndex;
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetHorzScrollBar(void);
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetVertScrollBar(void);
	void __fastcall SetHorzScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	void __fastcall SetVertScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	void __fastcall SetUseCustomScrollBars(const bool Value);
	Elsbctrl::TElScrollHintNeededEvent __fastcall GetHorzScrollHintNeeded(void);
	void __fastcall SetHorzScrollHintNeeded(Elsbctrl::TElScrollHintNeededEvent Value);
	Elsbctrl::TElScrollHintNeededEvent __fastcall GetVertScrollHintNeeded(void);
	void __fastcall SetVertScrollHintNeeded(Elsbctrl::TElScrollHintNeededEvent Value);
	bool __fastcall IsTopIndexStored(void);
	
protected:
	_TCustomElListBox__1 FStates;
	TIntArray *FImageIndex;
	int FImagesSize;
	int FStatesSize;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Vcl::Graphics::TCanvas* FCanvas;
	int FColumns;
	bool FExtendedSelect;
	bool FIntegralHeight;
	int FItemHeight;
	bool FMultiSelect;
	bool FSorted;
	int FTabWidth;
	int FCurHintItem;
	int FLastTopIndex;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	System::Classes::TStrings* FListBoxStrings;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBorderSides FBorderSides;
	bool FFlat;
	bool FFlatFocusedScrollBars;
	bool FHorizontalScroll;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FInvertSelection;
	Vcl::Graphics::TFont* FSelectedFont;
	bool FShowLineHint;
	bool FTransparent;
	bool FTransparentSelection;
	bool FUseBackground;
	Elimgfrm::TElImageForm* FImgForm;
	bool FMouseOver;
	Vcl::Extctrls::TTimer* FHintTimer;
	Elhintwnd::TElHintWindow* FHintWnd;
	System::Classes::TWndMethod FHintWndProc;
	int FMaxWidth;
	bool FInVScroll;
	bool FInHScroll;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	bool FMoving;
	bool FShowCheckBox;
	bool FAllowGrayed;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	int FSaveTopIndex;
	int FSaveItemIndex;
	Lmdtypes::TLMDString FHint;
	TDrawTextEvent FOnDrawText;
	Vcl::Stdctrls::TListBoxStyle FStyle;
	Vcl::Stdctrls::TDrawItemEvent FOnDrawItem;
	TElCheckBoxChangeEvent FOnCheckBoxChange;
	Vcl::Stdctrls::TMeasureItemEvent FOnMeasureItem;
	bool FUseSelectedFont;
	bool FRightAlignedView;
	bool FRightAlignedText;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	bool FHideSelection;
	int FHighlightAlphaLevel;
	Elinputprocessor::TElKeyboardInput* Input;
	System::Classes::TThread* SearchTextTimeoutThread;
	TElListBoxMultiCheckEvent FOnMultiCheck;
	TElCheckStateChangeEvent FOnCheckStateChange;
	int FIncrementalSearchTimeout;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorWindow;
	bool FForceSetItemIndex;
	bool FHideFocusRect;
	void __fastcall SetStyle(Vcl::Stdctrls::TListBoxStyle Value);
	virtual void __fastcall SetHideFocusRect(bool Value);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFlatFocusedScrollBars(const bool Value);
	void __fastcall SetHorizontalScroll(bool Value);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetInvertSelection(const bool Value);
	void __fastcall SetSelectedFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetTransparentSelection(bool Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	void __fastcall CancelLineHint(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawBackgroundEx(HDC DC, const System::Types::TRect &R, const System::Types::TRect &SubR);
	void __fastcall DrawFlatBorder(HDC DC, bool HDragging, bool VDragging);
	void __fastcall DrawParentControl(HDC DC);
	void __fastcall DrawParentControlEx(HDC DC, const System::Types::TRect &R);
	void __fastcall HintWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall IntMouseMove(short XPos, short YPos);
	MESSAGE void __fastcall LBGetTopIndex(Winapi::Messages::TMessage &Msg);
	void __fastcall OnLineHintTimer(System::TObject* Sender);
	virtual void __fastcall ResetHorizontalExtent(void);
	void __fastcall SelectedFontChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	MESSAGE void __fastcall WMNCMouseMove(Winapi::Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall WMDeadChar(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMIMEComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMIMEStartComposition(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetHorizontalExtent(void);
	void __fastcall SetColumnWidth(void);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	MESSAGE void __fastcall CNMeasureItem(Winapi::Messages::TWMMeasureItem &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	int __fastcall GetItemHeight(void);
	int __fastcall GetItemIndex(void);
	int __fastcall GetSelCount(void);
	bool __fastcall GetSelected(int Index);
	int __fastcall GetTopIndex(void);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetExtendedSelect(bool Value);
	void __fastcall SetIntegralHeight(bool Value);
	void __fastcall SetItemHeight(int Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetMultiSelect(bool Value);
	void __fastcall SetSelected(int Index, bool Value);
	void __fastcall SetSorted(bool Value);
	void __fastcall SetTabWidth(int Value);
	void __fastcall SetTopIndex(int Value);
	virtual Vcl::Graphics::TBitmap* __fastcall GetBackground(void);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual Elhintwnd::TElHintWindow* __fastcall CreateHintWindow(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	virtual int __fastcall GetItemWidth(int Index);
	virtual int __fastcall GetParentCtlHeight(void);
	virtual int __fastcall GetParentCtlWidth(void);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual System::Types::TPoint __fastcall RealScreenToClient(const System::Types::TPoint &APoint);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC int __fastcall InternalGetItemData(int Index);
	DYNAMIC void __fastcall InternalSetItemData(int Index, int AData);
	DYNAMIC int __fastcall GetItemData(int Index);
	DYNAMIC void __fastcall SetItemData(int Index, int AData);
	DYNAMIC void __fastcall ResetContent(void);
	DYNAMIC void __fastcall DeleteString(int Index);
	void __fastcall SetShowCheckBox(bool Value);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	void __fastcall SetState(int Index, Vcl::Stdctrls::TCheckBoxState Value);
	System::Types::TSize __fastcall GetCheckBoxSize(void);
	void __fastcall SetAllowGrayed(bool Value);
	void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	void __fastcall OnImageListChange(System::TObject* Sender);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall AdjustItemHeight(void);
	int __fastcall GetImageIndex(int Index);
	void __fastcall SetImageIndex(int Index, int Value);
	void __fastcall SetStatesSize(int aSize);
	void __fastcall SetImagesSize(int aSize);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall StartClearSearchTimeoutThread(void);
	void __fastcall StopClearSearchTimeoutThread(void);
	virtual bool __fastcall DoPerformSearch(Lmdtypes::TLMDString SearchText, int AFromIndex = 0x0);
	void __fastcall SearchTextTimeout(System::TObject* Sender);
	virtual bool __fastcall DoCompareItems(System::UnicodeString SearchText, int ItemIndex);
	virtual void __fastcall DoDrawText(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString ACaption, System::Types::TRect &Rect, int Flags);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	void __fastcall SetUseSelectedFont(bool Value);
	void __fastcall SetRightAlignedView(bool Value);
	void __fastcall SetRightAlignedText(bool Value);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelection(bool Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadSelectedColor(System::Classes::TReader* Reader);
	void __fastcall ReadSelectedFontColor(System::Classes::TReader* Reader);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall TriggerChange(void);
	virtual void __fastcall TriggerCheckStateChange(int ItemNo);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall TriggerCheckBoxChange(int ItemNo, Vcl::Stdctrls::TCheckBoxState ItemState);
	virtual void __fastcall TriggerMultiCheckEvent(int FromItemNo, int ToItemNo);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall PaintWindow(HDC DC);
	int __fastcall GetCount(void);
	virtual void __fastcall UpdateItemHeight(void);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	__property int Count = {read=GetCount, nodefault};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property int Columns = {read=FColumns, write=SetColumns, default=0};
	__property bool ExtendedSelect = {read=FExtendedSelect, write=SetExtendedSelect, default=1};
	__property bool IntegralHeight = {read=FIntegralHeight, write=SetIntegralHeight, default=0};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property ParentColor = {default=0};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property int TabWidth = {read=FTabWidth, write=SetTabWidth, default=0};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property System::Classes::TStrings* Items = {read=FListBoxStrings, write=SetItems};
	__property int SelCount = {read=GetSelCount, nodefault};
	__property int TopIndex = {read=GetTopIndex, write=SetTopIndex, stored=IsTopIndexStored, nodefault};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Vcl::Graphics::TBitmap* Background = {read=GetBackground, write=SetBackground};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property bool HorizontalScroll = {read=FHorizontalScroll, write=SetHorizontalScroll, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool InvertSelection = {read=FInvertSelection, write=SetInvertSelection, default=0};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Vcl::Graphics::TFont* SelectedFont = {read=FSelectedFont, write=SetSelectedFont};
	__property bool ShowLineHint = {read=FShowLineHint, write=FShowLineHint, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool TransparentSelection = {read=FTransparentSelection, write=SetTransparentSelection, default=0};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property TabStop = {default=1};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, default=1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Vcl::Stdctrls::TListBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool UseSelectedFont = {read=FUseSelectedFont, write=SetUseSelectedFont, default=0};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property bool RightAlignedText = {read=FRightAlignedText, write=SetRightAlignedText, default=0};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElCheckStateChangeEvent OnCheckStateChange = {read=FOnCheckStateChange, write=FOnCheckStateChange};
	__property TElListBoxMultiCheckEvent OnMultiCheck = {read=FOnMultiCheck, write=FOnMultiCheck};
	__property int IncrementalSearchTimeout = {read=FIncrementalSearchTimeout, write=FIncrementalSearchTimeout, default=500};
	
public:
	__fastcall virtual TCustomElListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElListBox(void);
	int __fastcall ItemAtPos(const System::Types::TPoint &Pos, bool Existing);
	System::Types::TRect __fastcall ItemRect(int Index);
	void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int errorLevel);
	Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void);
	void __fastcall CheckAll(void);
	void __fastcall CheckSelected(void);
	void __fastcall GrayAll(void);
	void __fastcall GraySelected(void);
	void __fastcall UncheckAll(void);
	void __fastcall UncheckSelected(void);
	__property bool ForceSetItemIndex = {read=FForceSetItemIndex, write=FForceSetItemIndex, default=0};
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	__property Vcl::Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__property int ImageIndex[int Index] = {read=GetImageIndex, write=SetImageIndex};
	__property TElCheckBoxChangeEvent OnCheckBoxChange = {read=FOnCheckBoxChange, write=FOnCheckBoxChange};
	__property TDrawTextEvent OnDrawText = {read=FOnDrawText, write=FOnDrawText};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=FOnMeasureItem, write=FOnMeasureItem};
	__property bool UseCustomScrollBars = {read=fUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property Elsbctrl::TElCtrlScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBar, write=SetHorzScrollBar};
	__property Elsbctrl::TElCtrlScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBar, write=SetVertScrollBar};
	__property Elsbctrl::TElScrollHintNeededEvent OnHorzScrollHintNeeded = {read=GetHorzScrollHintNeeded, write=SetHorzScrollHintNeeded};
	__property Elsbctrl::TElScrollHintNeededEvent OnVertScrollHintNeeded = {read=GetVertScrollHintNeeded, write=SetVertScrollHintNeeded};
	
__published:
	__property DoubleBuffered;
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property bool HideFocusRect = {read=FHideFocusRect, write=SetHideFocusRect, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElListBox(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
private:
	void *__ILMDValidatingMsgControl;	// Lmdvldbase::ILMDValidatingMsgControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F85159D2-2952-4FAB-B795-D772368DEBC4}
	operator Lmdvldbase::_di_ILMDValidatingMsgControl()
	{
		Lmdvldbase::_di_ILMDValidatingMsgControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatingMsgControl*(void) { return (Lmdvldbase::ILMDValidatingMsgControl*)&__ILMDValidatingMsgControl; }
	#endif
	
};


class PASCALIMPLEMENTATION TElListBox : public TCustomElListBox
{
	typedef TCustomElListBox inherited;
	
__published:
	__property AllowGrayed = {default=1};
	__property BorderStyle = {default=1};
	__property Columns = {default=0};
	__property ExtendedSelect = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property IntegralHeight = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property ItemHeight;
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property Sorted = {default=0};
	__property TabWidth = {default=0};
	__property ItemIndex;
	__property Items;
	__property SelCount;
	__property TopIndex;
	__property ShowCheckBox = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property ActiveBorderType = {default=1};
	__property Background;
	__property BorderSides = {default=15};
	__property Flat = {default=0};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property Font;
	__property FlatFocusedScrollBars = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalScroll = {default=0};
	__property Images;
	__property AlphaForImages;
	__property ImageForm;
	__property InactiveBorderType = {default=3};
	__property InvertSelection = {default=0};
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property SelectedFont;
	__property ShowLineHint = {default=0};
	__property Transparent = {default=0};
	__property TransparentSelection = {default=0};
	__property UseBackground = {default=0};
	__property UseSelectedFont = {default=0};
	__property TabStop = {default=1};
	__property ParentFont = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnCheckStateChange;
	__property OnMultiCheck;
	__property OnCheckBoxChange;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Style = {default=0};
	__property OnDrawItem;
	__property OnMeasureItem;
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property RightAlignedView = {default=0};
public:
	/* TCustomElListBox.Create */ inline __fastcall virtual TElListBox(System::Classes::TComponent* AOwner) : TCustomElListBox(AOwner) { }
	/* TCustomElListBox.Destroy */ inline __fastcall virtual ~TElListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElListBox(HWND ParentWindow) : TCustomElListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ellistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELLISTBOX)
using namespace Ellistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EllistboxHPP
