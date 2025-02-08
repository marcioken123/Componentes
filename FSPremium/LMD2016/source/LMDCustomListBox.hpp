// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomListBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlistboxHPP
#define LmdcustomlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBoundLabel.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDVldBase.hpp>
#include <LMD3DCaption.hpp>
#include <LMDTypes.hpp>
#include <LMDBase.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomListBoxEdit;
class DELPHICLASS TLMDCustomListBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdcustomlistbox__1 : unsigned char { lboAllowDelete, lboAllowEdit, lboAllowInsert, lboNo3DFrame, lboSelectText };

typedef System::Set<Lmdcustomlistbox__1, Lmdcustomlistbox__1::lboAllowDelete, Lmdcustomlistbox__1::lboSelectText> TLMDListBoxEditOptions;

enum DECLSPEC_DENUM TLMDListBoxLargeTextOptions : unsigned char { lbltNone, lbltEndEllipsis, lbltPathEllipsis, lbltHorzScrollBar, lbltShowHint };

typedef void __fastcall (__closure *TLMDListBoxEditShowEvent)(System::TObject* Sender, int Index, bool &Cancel);

typedef void __fastcall (__closure *TLMDListBoxEditMeasureEvent)(System::TObject* Sender, int Index, int &Height);

typedef void __fastcall (__closure *TLMDListBoxEditChangeEvent)(System::TObject* Sender, int Index);

class PASCALIMPLEMENTATION TLMDCustomListBoxEdit : public Vcl::Stdctrls::TMemo
{
	typedef Vcl::Stdctrls::TMemo inherited;
	
public:
	/* TCustomMemo.Create */ inline __fastcall virtual TLMDCustomListBoxEdit(System::Classes::TComponent* AOwner) : Vcl::Stdctrls::TMemo(AOwner) { }
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TLMDCustomListBoxEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomListBoxEdit(HWND ParentWindow) : Vcl::Stdctrls::TMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomListBox : public Vcl::Stdctrls::TCustomListBox
{
	typedef Vcl::Stdctrls::TCustomListBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FMultiLine;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	int FLast;
	bool FTransparent;
	System::Classes::TNotifyEvent FOnSelect;
	TLMDListBoxEditOptions FEditOptions;
	int FEditIndex;
	TLMDListBoxEditShowEvent FOnEditShow;
	TLMDListBoxEditMeasureEvent FOnEditMeasure;
	TLMDListBoxEditChangeEvent FOnEditChange;
	System::Classes::TNotifyEvent FOnEditHide;
	bool FVertical;
	bool FMouseOver;
	bool FFlat;
	bool FHideFocus;
	bool FHorzGridline;
	System::Uitypes::TColor FDisabledColor;
	System::Uitypes::TColor FSelectedColor;
	System::Uitypes::TColor FSelectedFontColor;
	System::Uitypes::TColor FHorzGridColor;
	Vcl::Graphics::TPenStyle FHorzGridStyle;
	int FHorzWidth;
	bool FHideSelection;
	TLMDCustomListBoxEdit* FEdit;
	TLMDListBoxLargeTextOptions FLargeTextOptions;
	System::Byte FMargin;
	System::Uitypes::TFontStyles FSelectedFontStyle;
	Vcl::Controls::THintWindow* FHintWindow;
	bool FVirtual;
	bool FAutoHeight;
	bool FBeveledFocus;
	System::Uitypes::TColor FBevelFocusLightColor;
	System::Uitypes::TColor FBevelFocusDarkColor;
	Lmdboundlabel::TLMDBoundLabel* FEditLabel;
	bool FHasBoundLabel;
	Vcl::Extctrls::TLabelPosition FLabelPosition;
	bool FLabelSync;
	int FLabelSpacing;
	bool FMeasureItem;
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	void __fastcall SetLabelPosition(const Vcl::Extctrls::TLabelPosition Value);
	void __fastcall SetLabelSpacing(const int Value);
	void __fastcall SetHasLabel(bool aValue);
	void __fastcall SetLabelSync(const bool Value);
	void __fastcall ReadEditLabel(System::Classes::TStream* Stream);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	Vcl::Controls::THintWindow* __fastcall GetHintWindow(void);
	void __fastcall CancelHint(void);
	void __fastcall FreeHintWindow(void);
	void __fastcall SetListBoxEditOptions(const TLMDListBoxEditOptions aValue);
	void __fastcall SetListBoxLargeTextOptions(const TLMDListBoxLargeTextOptions aValue);
	void __fastcall SetMargin(const System::Byte aValue);
	void __fastcall SetMultiline(bool aValue);
	void __fastcall SetAutoHeight(bool aValue);
	void __fastcall SetHideSelection(const bool aValue);
	void __fastcall SetFlat(const bool aValue);
	void __fastcall SetVerticalScrollBar(const bool aValue);
	void __fastcall SetVirtualMode(const bool aValue);
	void __fastcall SetHorzGridline(const bool aValue);
	void __fastcall SetHorzGridColor(const System::Uitypes::TColor aValue);
	void __fastcall SetSelectedFontColor(const System::Uitypes::TColor aValue);
	void __fastcall SetSelectedColor(const System::Uitypes::TColor aValue);
	void __fastcall SetDisabledColor(const System::Uitypes::TColor aValue);
	void __fastcall SetHideFocus(const bool aValue);
	void __fastcall SetHorzGridStyle(const Vcl::Graphics::TPenStyle aValue);
	void __fastcall SetSelectedFontStyle(const System::Uitypes::TFontStyles aValue);
	void __fastcall SetTransparent(bool aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall DrawBorder(void);
	void __fastcall SetHorzExtent(void);
	void __fastcall DoOnEditExit(System::TObject* Sender);
	void __fastcall DoOnEditKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall MeasureListBoxItems(void);
	void __fastcall SetBeveledFocus(const bool Value);
	void __fastcall SetBevelFocusDarkColor(const System::Uitypes::TColor Value);
	void __fastcall SetBevelFocusLightColor(const System::Uitypes::TColor Value);
	MESSAGE void __fastcall CMLMDThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall SetMeasureItem(const bool Value);
	void __fastcall SetListBoxStyle(void);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	bool __fastcall get_CtlXP(void);
	void __fastcall set_CtlXP(bool aValue);
	MESSAGE void __fastcall CMLMDBOUNDLABELCHANGE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDSCROLLBOXSCROLLEVENT(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	MESSAGE void __fastcall LBGetTopIndex(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool __fastcall CheckOptimized(void);
	void __fastcall RestoreBack(const System::Types::TRect &tmp);
	virtual void __fastcall GetChange(System::TObject* Sender);
	void __fastcall InitHorzExtent(void);
	virtual int __fastcall GetHorzExtent(int index);
	bool __fastcall ItemVisible(int index);
	bool __fastcall IsHintWindowActive(void);
	virtual int __fastcall MeasureItemHeights(bool aVisibleOnly, bool aSetHeight = true);
	virtual bool __fastcall CanEdit(void);
	virtual System::Types::TRect __fastcall GetEditRect(int index);
	virtual System::UnicodeString __fastcall GetStringValue(int index);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall DoThemeChanged(void);
	System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall DoSelect(void);
	virtual int __fastcall GetFieldValue(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall EnterEditMode(const bool NewItem = false, int Index = 0xffffffff);
	virtual void __fastcall CancelEditMode(void);
	void __fastcall SetupEditLabel(void);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	__property Lmdboundlabel::TLMDBoundLabel* EditLabel = {read=FEditLabel};
	__property int LabelSpacing = {read=FLabelSpacing, write=SetLabelSpacing, default=3};
	__property bool HasBoundLabel = {read=FHasBoundLabel, write=SetHasLabel, nodefault};
	__property Count;
	__property bool VirtualMode = {read=FVirtual, write=SetVirtualMode, default=0};
	
public:
	__fastcall virtual TLMDCustomListBox(System::Classes::TComponent* AOwner);
	bool __fastcall IsThemed(void);
	virtual void __fastcall ClearSelection(void);
	__fastcall virtual ~TLMDCustomListBox(void);
	void __fastcall MoveHorz(System::Word flag);
	virtual void __fastcall DeleteSelected(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
	bool __fastcall isTransparentSet(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual HPALETTE __fastcall BackBitmapPalette(void);
	void __fastcall BackUpdate(void);
	virtual Vcl::Controls::TControl* __fastcall BackControl(int index);
	virtual int __fastcall BackControlCount(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall AddItemByEditor(void);
	void __fastcall DisplayEditor(const int Index);
	void __fastcall HideEditor(void);
	__property int ScrollWidth = {read=FHorzWidth, nodefault};
	__property System::UnicodeString StringValue[int Index] = {read=GetStringValue};
	__property bool ItemAutoHeight = {read=FAutoHeight, write=SetAutoHeight, default=0};
	__property TLMDListBoxEditOptions EditOptions = {read=FEditOptions, write=SetListBoxEditOptions, default=0};
	__property TLMDListBoxLargeTextOptions LargeTextOptions = {read=FLargeTextOptions, write=SetListBoxLargeTextOptions, default=0};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiline, default=0};
	__property TLMDCustomListBoxEdit* EditControl = {read=FEdit};
	__property TLMDListBoxEditShowEvent OnEditShow = {read=FOnEditShow, write=FOnEditShow};
	__property TLMDListBoxEditMeasureEvent OnEditMeasure = {read=FOnEditMeasure, write=FOnEditMeasure};
	__property TLMDListBoxEditChangeEvent OnEditChange = {read=FOnEditChange, write=FOnEditChange};
	__property System::Classes::TNotifyEvent OnEditHide = {read=FOnEditHide, write=FOnEditHide};
	__property Canvas;
	__property Text = {default=0};
	__property bool CtlXP = {read=get_CtlXP, write=set_CtlXP, nodefault};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Vcl::Extctrls::TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, default=0};
	__property bool LabelSync = {read=FLabelSync, write=SetLabelSync, default=0};
	void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int errorLevel);
	Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void);
	
__published:
	__property MultiSelect = {default=0};
	__property bool BeveledFocus = {read=FBeveledFocus, write=SetBeveledFocus, default=0};
	__property System::Uitypes::TColor BevelFocusShadowColor = {read=FBevelFocusDarkColor, write=SetBevelFocusDarkColor, default=8421504};
	__property System::Uitypes::TColor BevelFocusLightColor = {read=FBevelFocusLightColor, write=SetBevelFocusLightColor, default=16777215};
	__property bool MeasureItemEvent = {read=FMeasureItem, write=SetMeasureItem, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=0};
	__property System::Byte Margin = {read=FMargin, write=SetMargin, default=1};
	__property System::Uitypes::TColor HorzGridColor = {read=FHorzGridColor, write=SetHorzGridColor, default=12632256};
	__property Vcl::Graphics::TPenStyle HorzGridStyle = {read=FHorzGridStyle, write=SetHorzGridStyle, default=0};
	__property bool HorzGridLine = {read=FHorzGridline, write=SetHorzGridline, default=0};
	__property bool VerticalScrollBar = {read=FVertical, write=SetVerticalScrollBar, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property System::Uitypes::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, default=-16777203};
	__property System::Uitypes::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777211};
	__property System::Uitypes::TColor SelectedFontColor = {read=FSelectedFontColor, write=SetSelectedFontColor, default=-16777202};
	__property System::Uitypes::TFontStyles SelectedFontStyle = {read=FSelectedFontStyle, write=SetSelectedFontStyle, default=0};
	__property bool HideFocus = {read=FHideFocus, write=SetHideFocus, default=0};
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomListBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomListBox(ParentWindow) { }
	
private:
	void *__ILMDValidatingMsgControl;	// Lmdvldbase::ILMDValidatingMsgControl 
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	
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
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0068598D-C5C6-488F-8E00-D813525C9163}
	operator Intflmdbackground::_di_ILMDBackground()
	{
		Intflmdbackground::_di_ILMDBackground intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbackground::ILMDBackground*(void) { return (Intflmdbackground::ILMDBackground*)&__ILMDBackground; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_ListBoxEditOptions System::Set<System::Byte>()
}	/* namespace Lmdcustomlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLISTBOX)
using namespace Lmdcustomlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlistboxHPP
