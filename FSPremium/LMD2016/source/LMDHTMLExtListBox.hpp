// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLExtListBox.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlextlistboxHPP
#define LmdhtmlextlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDHTMLUnit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlextlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLExtListBox;
class DELPHICLASS TLMDHTMLLabeledExtListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLExtListBox : public Lmdcustomlistbox::TLMDCustomListBox
{
	typedef Lmdcustomlistbox::TLMDCustomListBox inherited;
	
private:
	System::Uitypes::TCursor FCursor;
	bool FIsHTML;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	void __fastcall SetIsHTML(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	void __fastcall SetLinkColor(const System::Uitypes::TColor Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetLinkStyle(const System::Uitypes::TFontStyles Value);
	HIDESBASE void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	
protected:
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall ModifyItemRect(System::Types::TRect &ItemRect);
	virtual void __fastcall ModifyItemText(System::UnicodeString &ItemText);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TriggerLinkClickEvent(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	
public:
	__fastcall virtual TLMDHTMLExtListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDHTMLExtListBox(void);
	__property Count;
	__property CtlXP;
	__property Lmdhtmlunit::TLMDHTMLRender* HTMLRender = {read=FRender};
	
__published:
	__property AutoComplete = {default=1};
	__property VirtualMode = {default=0};
	__property Columns = {default=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property Items;
	__property ItemAutoHeight = {default=0};
	__property EditOptions = {default=0};
	__property LargeTextOptions = {default=0};
	__property VerticalScrollBar = {default=1};
	__property Margin = {default=1};
	__property MultiLine = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property HorzGridColor = {default=12632256};
	__property HorzGridStyle = {default=0};
	__property HorzGridLine = {default=0};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property OnEditShow;
	__property OnEditMeasure;
	__property OnEditChange;
	__property OnEditHide;
	__property OnData;
	__property OnDataObject;
	__property OnDataFind;
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLExtListBox(HWND ParentWindow) : Lmdcustomlistbox::TLMDCustomListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDHTMLLabeledExtListBox : public TLMDHTMLExtListBox
{
	typedef TLMDHTMLExtListBox inherited;
	
public:
	__fastcall virtual TLMDHTMLLabeledExtListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDHTMLExtListBox.Destroy */ inline __fastcall virtual ~TLMDHTMLLabeledExtListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLLabeledExtListBox(HWND ParentWindow) : TLMDHTMLExtListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlextlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLEXTLISTBOX)
using namespace Lmdhtmlextlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlextlistboxHPP
