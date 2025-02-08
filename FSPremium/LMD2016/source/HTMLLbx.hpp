// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'HTMLLbx.pas' rev: 31.00 (Windows)

#ifndef HtmllbxHPP
#define HtmllbxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElCombos.hpp>
#include <ElListBox.hpp>
#include <LMDGraphUtils.hpp>
#include <ElVCLUtils.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElHintWnd.hpp>
#include <ElImgFrm.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <System.UITypes.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnEdit.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <ElSBCtrl.hpp>
#include <ElInputProcessor.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Htmllbx
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElHTMLListBox;
class DELPHICLASS TCustomElHTMLComboBox;
class DELPHICLASS TElHTMLListBox;
class DELPHICLASS TElHTMLComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElHTMLListBox : public Ellistbox::TCustomElListBox
{
	typedef Ellistbox::TCustomElListBox inherited;
	
private:
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	bool FIsHTML;
	System::Uitypes::TCursor FCursor;
	void __fastcall SetWordWrap(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	
protected:
	Vcl::Stdctrls::TListBoxStyle FStyle;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	bool FWordWrap;
	virtual int __fastcall GetItemWidth(int Index);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall TriggerLinkClickEvent(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE virtual void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	virtual Elhintwnd::TElHintWindow* __fastcall CreateHintWindow(void);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TListBoxStyle Value);
	virtual void __fastcall SetIsHTML(bool Value);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
public:
	__fastcall virtual TCustomElHTMLListBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	__fastcall virtual ~TCustomElHTMLListBox(void);
	
__published:
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property Vcl::Stdctrls::TListBoxStyle Style = {read=FStyle, write=SetStyle, default=2};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElHTMLListBox(HWND ParentWindow) : Ellistbox::TCustomElListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElHTMLComboBox : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
private:
	bool FWordWrap;
	Vcl::Stdctrls::TDrawItemEvent FDrawItem;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	bool FIsHTML;
	
protected:
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Vcl::Stdctrls::TComboBoxStyle FStyle;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TFontStyles FLinkStyle;
	virtual Vcl::Stdctrls::TComboBoxStyle __fastcall GetCurrentStyle(void);
	virtual int __fastcall GetDropDownHeight(void);
	HIDESBASE void __fastcall SetWordWrap(bool Value);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall TriggerLinkClickEvent(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TComboBoxStyle Value);
	virtual void __fastcall SetIsHTML(bool Value);
	virtual Lmdtypes::TLMDString __fastcall GetTextFromItem(int Index);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=FDrawItem, write=FDrawItem};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property Vcl::Stdctrls::TComboBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	__fastcall virtual TCustomElHTMLComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElHTMLComboBox(void);
	virtual void __fastcall Loaded(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElHTMLComboBox(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElHTMLListBox : public TCustomElHTMLListBox
{
	typedef TCustomElHTMLListBox inherited;
	
__published:
	__property OnMultiCheck;
	__property OnChange;
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
	__property OnClick;
	__property OnCheckStateChange;
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
	__property Style = {default=2};
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property RightAlignedView = {default=0};
public:
	/* TCustomElHTMLListBox.Create */ inline __fastcall virtual TElHTMLListBox(System::Classes::TComponent* AOwner) : TCustomElHTMLListBox(AOwner) { }
	/* TCustomElHTMLListBox.Destroy */ inline __fastcall virtual ~TElHTMLListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHTMLListBox(HWND ParentWindow) : TCustomElHTMLListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElHTMLComboBox : public TCustomElHTMLComboBox
{
	typedef TCustomElHTMLComboBox inherited;
	
__published:
	__property ShowGripper = {default=0};
	__property OnLinkClick;
	__property OnImageNeeded;
	__property OnVariableNeeded;
	__property OnDrawItem;
	__property OnMeasureItem;
	__property IsHTML = {default=1};
	__property Style = {default=0};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property ButtonArrowColor = {default=-16777198};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property AutoCompletion = {default=0};
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
	__property ItemHeight;
	__property DropDownAlignment = {default=1};
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
	__property ImageForm;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property Text;
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property StressShortCut = {default=0};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
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
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
	__property WordWrap = {default=0};
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
public:
	/* TCustomElHTMLComboBox.Create */ inline __fastcall virtual TElHTMLComboBox(System::Classes::TComponent* AOwner) : TCustomElHTMLComboBox(AOwner) { }
	/* TCustomElHTMLComboBox.Destroy */ inline __fastcall virtual ~TElHTMLComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHTMLComboBox(HWND ParentWindow) : TCustomElHTMLComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Htmllbx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_HTMLLBX)
using namespace Htmllbx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmllbxHPP
