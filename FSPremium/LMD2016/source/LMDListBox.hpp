// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDListBox.pas' rev: 31.00 (Windows)

#ifndef LmdlistboxHPP
#define LmdlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <LMDBase.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDClass.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDHeaderControl.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDExtListBox.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDVldBase.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLBGridLines : unsigned char { glNone, glHorizontal, glVertical, glBoth };

typedef void __fastcall (__closure *TLMDLBCompareItemEvent)(System::TObject* Sender, const System::UnicodeString s1, const System::UnicodeString s2, System::Int8 &result);

typedef void __fastcall (__closure *TLMDLBGetLineSettingsEvent)(System::TObject* Sender, int Index, Winapi::Windows::TOwnerDrawState State, System::Uitypes::TColor &bColor, Vcl::Graphics::TFont* aFont);

class PASCALIMPLEMENTATION TLMDListBox : public Lmdcustomscrollbox::TLMDCustomScrollBox
{
	typedef Lmdcustomscrollbox::TLMDCustomScrollBox inherited;
	
private:
	bool __fastcall GetBool(int Index);
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	System::Uitypes::TColor __fastcall GetColor(int Index);
	System::Uitypes::TCursor __fastcall GetCursor(int Index);
	Vcl::Graphics::TFont* __fastcall GetFont(int Index);
	System::UnicodeString __fastcall GetHint(void);
	Vcl::Controls::TImeMode __fastcall GetImeMode(void);
	Vcl::Controls::TImeName __fastcall GetImeName(void);
	int __fastcall GetInteger(int Index);
	System::Classes::TStrings* __fastcall GetItems(void);
	HIDESBASE System::Uitypes::TDragMode __fastcall GetDragMode(void);
	Vcl::Stdctrls::TMeasureItemEvent __fastcall GetMeasureItemEvent(void);
	Vcl::Comctrls::TSectionNotifyEvent __fastcall GetSectionEvent(void);
	Vcl::Comctrls::TSectionTrackEvent __fastcall GetSectionTrackEvent(void);
	bool __fastcall GetSelected(int index);
	Vcl::Comctrls::TDrawSectionEvent __fastcall GetDrawSectionEvent(void);
	Vcl::Forms::TControlScrollBar* __fastcall GetControlBar(void);
	Vcl::Stdctrls::TLBGetDataEvent __fastcall GetOnData(void);
	Vcl::Stdctrls::TLBFindDataEvent __fastcall GetOnDataFind(void);
	int __fastcall GetCount(void);
	void __fastcall SetOnData(Vcl::Stdctrls::TLBGetDataEvent aValue);
	void __fastcall SetOnDataFind(Vcl::Stdctrls::TLBFindDataEvent aValue);
	void __fastcall SetCount(int aValue);
	void __fastcall SetBool(int Index, bool aValue);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	HIDESBASE void __fastcall SetCursor(int Index, System::Uitypes::TCursor aValue);
	void __fastcall SetGridLines(TLMDLBGridLines aValue);
	void __fastcall SetDelimiter(System::WideChar aValue);
	void __fastcall SetDragMod(System::Uitypes::TDragMode aValue);
	HIDESBASE void __fastcall SetFont(int Index, Vcl::Graphics::TFont* aValue);
	void __fastcall SetHint(System::UnicodeString aValue);
	void __fastcall SetImeMode(Vcl::Controls::TImeMode aValue);
	void __fastcall SetImeName(Vcl::Controls::TImeName aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetListBoxStyle(Vcl::Stdctrls::TListBoxStyle aValue);
	void __fastcall SetMeasureItemEvent(Vcl::Stdctrls::TMeasureItemEvent aValue);
	void __fastcall SetSelectedFontStyle(const System::Uitypes::TFontStyles aValue);
	void __fastcall SetPenStyle(const int Index, const Vcl::Graphics::TPenStyle Value);
	void __fastcall SetSectionEvent(Vcl::Comctrls::TSectionNotifyEvent aValue);
	void __fastcall SetSectionTrackEvent(Vcl::Comctrls::TSectionTrackEvent aValue);
	void __fastcall SetDrawSectionEvent(Vcl::Comctrls::TDrawSectionEvent aValue);
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	void __fastcall SetVirtualWidth(int aValue);
	void __fastcall SetSelected(int index, bool flag);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	bool __fastcall SaveKey(void);
	bool __fastcall SaveSection(void);
	void __fastcall SetOptions(Lmdbaselabel::TLMDLabelOptions aValue);
	void __fastcall SetHeaderSections(Vcl::Comctrls::THeaderSections* aValue);
	Vcl::Comctrls::THeaderSections* __fastcall GetHeaderSections(void);
	MESSAGE void __fastcall CMTRANSPARENTCHANGED(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	System::Classes::TNotifyEvent __fastcall GetOnSelect(void);
	void __fastcall SetOnSelect(const System::Classes::TNotifyEvent Value);
	Lmdextlistbox::TLMDExtListBox* __fastcall GetListBox(void);
	
protected:
	Lmdheadercontrol::TLMDHeaderControl* FHeader;
	System::WideChar FDelimiter;
	bool FDesc;
	bool FHScroll;
	TLMDLBGridLines FGridLines;
	Lmdcustomlistbox::TLMDCustomListBox* FListBox;
	Vcl::Stdctrls::TListBoxStyle FListBoxStyle;
	System::Uitypes::TColor FSelectedFontColor;
	System::Uitypes::TColor FGridHorzColor;
	System::Uitypes::TColor FGridVertColor;
	System::Uitypes::TColor FSelColor;
	System::Uitypes::TFontStyles FSelectedFontStyle;
	Vcl::Extctrls::TSectionEvent FOnHeaderSized;
	Vcl::Comctrls::TSectionNotifyEvent FOnHeaderResize;
	Vcl::Stdctrls::TDrawItemEvent FOnDrawItem;
	TLMDLBCompareItemEvent FOnCompare;
	int FVirtualWidth;
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	Lmdinictrl::TLMDIniUse FIniUse;
	System::UnicodeString FSection;
	System::UnicodeString FKey;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniReadData;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniWriteData;
	Lmdbaselabel::TLMDLabelOptions FOptions;
	Vcl::Stdctrls::TDrawItemEvent FOnPrepareDrawItem;
	Vcl::Graphics::TPenStyle FGridHorzStyle;
	Vcl::Graphics::TPenStyle FGridVertStyle;
	bool FVirtualAutoWidth;
	bool FAlternateLineColors;
	System::Uitypes::TColor FAltColor;
	System::Uitypes::TColor FAltFontColor;
	TLMDLBGetLineSettingsEvent FOnGetLineSettings;
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall InternalMouseMove(System::Classes::TShiftState Shift, int X, int Y);
	int __fastcall CalcColumnsWidth(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHeader(void);
	virtual void __fastcall CreateLB(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall DoReadData(void);
	DYNAMIC void __fastcall DoWriteData(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall DrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	System::Word __fastcall GetOptionsFlag(void);
	void __fastcall HeaderSized(Vcl::Comctrls::THeaderControl* Sender, Vcl::Comctrls::THeaderSection* Section);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateVirtualWidth(void);
	System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	
public:
	__fastcall virtual TLMDListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDListBox(void);
	void __fastcall SpecialSort(int *sortOrder, const int sortOrder_High)/* overload */;
	void __fastcall SpecialSort(void)/* overload */;
	int __fastcall AddLine(const System::UnicodeString *X, const int X_High);
	void __fastcall Clear(void);
	void __fastcall PrepareDrawItem(const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State, int Index = 0xffffffff);
	virtual void __fastcall SetFocus(void);
	System::UnicodeString __fastcall GetIniString(void);
	void __fastcall SetIniString(System::UnicodeString w);
	System::UnicodeString __fastcall GetPartString(const System::UnicodeString w, int col);
	int __fastcall ItemAtPos(const System::Types::TPoint &Pos, bool Existing);
	System::UnicodeString __fastcall ItemPart(int Index, int Col);
	void __fastcall SetItemPart(int Index, int Col, System::UnicodeString partStr);
	DYNAMIC bool __fastcall Focused(void);
	void __fastcall ReadData(void);
	void __fastcall WriteData(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property Lmdheadercontrol::TLMDHeaderControl* Header = {read=FHeader};
	__property int ItemIndex = {read=GetInteger, write=SetInteger, index=1, nodefault};
	__property Lmdextlistbox::TLMDExtListBox* LB = {read=GetListBox};
	__property int SectionCount = {read=GetInteger, index=5, nodefault};
	__property int SelCount = {read=GetInteger, index=3, nodefault};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	__property Showing;
	__property int TopIndex = {read=GetInteger, write=SetInteger, index=2, nodefault};
	__property bool SortDescending = {read=FDesc, write=FDesc, default=0};
	__property int ColumnsWidth = {read=CalcColumnsWidth, nodefault};
	__property int Count = {read=GetCount, write=SetCount, nodefault};
	void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int errorLevel);
	Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void);
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property bool AllowResize = {read=GetBool, write=SetBool, index=5, default=1};
	__property bool AutoScroll = {read=GetBool, index=21, nodefault};
	__property Bevel;
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, index=0, default=16777215};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, index=0, default=0};
	__property System::WideChar Delimiter = {read=FDelimiter, write=SetDelimiter, default=59};
	__property System::Uitypes::TCursor DragCursor = {read=GetCursor, write=SetCursor, index=1, default=-12};
	__property System::Uitypes::TDragMode DragMode = {read=GetDragMode, write=SetDragMod, default=0};
	__property bool Enabled = {read=GetBool, write=SetBool, index=0, default=1};
	__property bool ExtendedSelect = {read=GetBool, write=SetBool, index=1, default=1};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont, index=1};
	__property System::Uitypes::TColor GridHorzColor = {read=FGridHorzColor, write=SetColor, index=2, default=12632256};
	__property TLMDLBGridLines GridLines = {read=FGridLines, write=SetGridLines, default=0};
	__property System::Uitypes::TColor GridVertColor = {read=FGridVertColor, write=SetColor, index=3, default=12632256};
	__property Vcl::Graphics::TFont* HeaderFont = {read=GetFont, write=SetFont, index=0};
	__property int HeaderHeight = {read=GetInteger, write=SetInteger, index=0, default=17};
	__property Vcl::Comctrls::THeaderSections* HeaderSections = {read=GetHeaderSections, write=SetHeaderSections};
	__property bool HeaderVisible = {read=GetBool, write=SetBool, index=2, default=1};
	__property bool HeaderHotTrack = {read=GetBool, write=SetBool, index=12, default=0};
	__property bool HeaderFlat = {read=GetBool, write=SetBool, index=13, default=0};
	__property System::UnicodeString Hint = {read=GetHint, write=SetHint};
	__property Vcl::Controls::TImeMode ImeMode = {read=GetImeMode, write=SetImeMode, default=3};
	__property Vcl::Controls::TImeName ImeName = {read=GetImeName, write=SetImeName};
	__property int ItemHeight = {read=GetInteger, write=SetInteger, index=4, nodefault};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property bool MultiSelect = {read=GetBool, write=SetBool, index=3, default=0};
	__property bool ParentShowHint = {read=GetBool, write=SetBool, index=7, default=1};
	__property PopupMenu;
	__property System::Uitypes::TColor SelectedColor = {read=GetColor, write=SetColor, index=1, default=-16777203};
	__property bool ShowHint = {read=GetBool, write=SetBool, index=6, default=0};
	__property bool Sorted = {read=GetBool, write=SetBool, index=4, default=0};
	__property Vcl::Stdctrls::TListBoxStyle Style = {read=FListBoxStyle, write=SetListBoxStyle, default=0};
	__property TabOrder = {default=-1};
	__property bool TabStop = {read=GetBool, write=SetBool, index=8, default=1};
	__property Visible = {default=1};
	__property Vcl::Forms::TControlScrollBar* VertScrollBar = {read=GetControlBar, stored=false};
	__property int VirtualWidth = {read=FVirtualWidth, write=SetVirtualWidth, default=0};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property System::UnicodeString Section = {read=FSection, write=FSection, stored=SaveSection};
	__property System::UnicodeString IniKey = {read=FKey, write=FKey, stored=SaveKey};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniReadData = {read=FOnIniReadData, write=FOnIniReadData};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniWriteData = {read=FOnIniWriteData, write=FOnIniWriteData};
	__property Lmdbaselabel::TLMDLabelOptions ColumnOptions = {read=FOptions, write=SetOptions, default=0};
	__property bool AlternateColors = {read=FAlternateLineColors, write=SetBool, index=14, default=0};
	__property System::Uitypes::TColor AltLineColor = {read=FAltColor, write=SetColor, index=5, default=12632256};
	__property System::Uitypes::TColor AltFontColor = {read=FAltFontColor, write=SetColor, index=6, default=-16777208};
	__property bool BeveledFocus = {read=GetBool, write=SetBool, index=15, default=0};
	__property System::Uitypes::TColor BevelFocusShadowColor = {read=GetColor, write=SetColor, index=7, default=8421504};
	__property System::Uitypes::TColor BevelFocusLightColor = {read=GetColor, write=SetColor, index=8, default=16777215};
	__property bool VirtualAutoWidth = {read=FVirtualAutoWidth, write=SetBool, index=16, default=0};
	__property TLMDLBGetLineSettingsEvent OnGetLineSettings = {read=FOnGetLineSettings, write=FOnGetLineSettings};
	__property Vcl::Graphics::TPenStyle GridHorzStyle = {read=FGridHorzStyle, write=SetPenStyle, index=0, default=0};
	__property Vcl::Graphics::TPenStyle GridVertStyle = {read=FGridVertStyle, write=SetPenStyle, index=1, default=0};
	__property bool ItemAutoHeight = {read=GetBool, write=SetBool, index=9, default=0};
	__property System::Uitypes::TColor SelectedFontColor = {read=FSelectedFontColor, write=SetColor, index=4, default=-16777202};
	__property System::Uitypes::TFontStyles SelectedFontStyle = {read=FSelectedFontStyle, write=SetSelectedFontStyle, default=0};
	__property Transparent = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=GetMeasureItemEvent, write=SetMeasureItemEvent};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property Vcl::Stdctrls::TDrawItemEvent OnPrepareDrawItem = {read=FOnPrepareDrawItem, write=FOnPrepareDrawItem};
	__property Vcl::Extctrls::TSectionEvent OnHeaderSized = {read=FOnHeaderSized, write=FOnHeaderSized};
	__property Vcl::Comctrls::TDrawSectionEvent OnHeaderDrawSection = {read=GetDrawSectionEvent, write=SetDrawSectionEvent};
	__property Vcl::Comctrls::TSectionNotifyEvent OnHeaderSectionClick = {read=GetSectionEvent, write=SetSectionEvent};
	__property Vcl::Comctrls::TSectionNotifyEvent OnHeaderSectionResize = {read=FOnHeaderResize, write=FOnHeaderResize};
	__property Vcl::Comctrls::TSectionTrackEvent OnHeaderSectionTrack = {read=GetSectionTrackEvent, write=SetSectionTrackEvent};
	__property System::Classes::TNotifyEvent OnSelect = {read=GetOnSelect, write=SetOnSelect};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property TLMDLBCompareItemEvent OnSSCompareItem = {read=FOnCompare, write=FOnCompare};
	__property Vcl::Stdctrls::TLBGetDataEvent OnData = {read=GetOnData, write=SetOnData};
	__property Vcl::Stdctrls::TLBFindDataEvent OnDataFind = {read=GetOnDataFind, write=SetOnDataFind};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDListBox(HWND ParentWindow) : Lmdcustomscrollbox::TLMDCustomScrollBox(ParentWindow) { }
	
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


//-- var, const, procedure ---------------------------------------------------
#define IDS_LISTBOXSAVE L"ListBoxData"
}	/* namespace Lmdlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLISTBOX)
using namespace Lmdlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistboxHPP
