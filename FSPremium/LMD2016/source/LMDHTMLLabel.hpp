// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLLabel.pas' rev: 31.00 (Windows)

#ifndef LmdhtmllabelHPP
#define LmdhtmllabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Themes.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.UITypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmllabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomHTMLLabel;
class DELPHICLASS TLMDHTMLLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomHTMLLabel : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	bool FAlreadyInSetBounds;
	Lmdclass::TLMDHTMLString FCaption;
	System::Uitypes::TCursor FCursor;
	int FLineGap;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Vcl::Stdctrls::TTextLayout FTextLayout;
	bool FWordWrap;
	bool FUpdating;
	Lmdhtmlunit::TLMDHTMLControlPositionNeededEvent FOnAdjustControlPosition;
	Lmdhtmlunit::TLMDHTMLControlCreatedEvent FOnControlCreated;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMThemeChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetCaption(const Lmdclass::TLMDHTMLString Value);
	void __fastcall SetLineGap(const int Value);
	void __fastcall SetWordWrap(bool AValue);
	void __fastcall SetTextLayout(const Vcl::Stdctrls::TTextLayout Value);
	
protected:
	void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall AdjustSize(void);
	System::Types::TRect __fastcall CalcTextRect(void);
	virtual void __fastcall DoUpdate(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall MouseEnter(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	void __fastcall TriggerAdjustControlPositionEvent(System::TObject* Sender, Vcl::Controls::TControl* aControl, void * aData, int &X, int &Y);
	void __fastcall TriggerControlCreatedEvent(System::TObject* Sender, Vcl::Controls::TControl* aControl);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Lmdclass::TLMDHTMLString Caption = {read=FCaption, write=SetCaption};
	__property Vcl::Stdctrls::TTextLayout Layout = {read=FTextLayout, write=SetTextLayout, nodefault};
	__property int LineGap = {read=FLineGap, write=SetLineGap, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	
public:
	__fastcall virtual TLMDCustomHTMLLabel(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual ~TLMDCustomHTMLLabel(void);
	
__published:
	__property About = {default=0};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLControlCreatedEvent OnControlCreated = {read=FOnControlCreated, write=FOnControlCreated};
	__property Lmdhtmlunit::TLMDHTMLControlPositionNeededEvent OnAdjustControlPosition = {read=FOnAdjustControlPosition, write=FOnAdjustControlPosition};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
};


class PASCALIMPLEMENTATION TLMDHTMLLabel : public TLMDCustomHTMLLabel
{
	typedef TLMDCustomHTMLLabel inherited;
	
__published:
	__property Align = {default=0};
	__property AutoSize = {default=0};
	__property Bevel;
	__property Alignment;
	__property Caption;
	__property Layout;
	__property LineGap = {default=0};
	__property WordWrap = {default=1};
	__property Transparent = {default=1};
	__property OnMouseEnter;
	__property OnMouseExit;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnMouseActivate;
public:
	/* TLMDCustomHTMLLabel.Create */ inline __fastcall virtual TLMDHTMLLabel(System::Classes::TComponent* AOwner) : TLMDCustomHTMLLabel(AOwner) { }
	/* TLMDCustomHTMLLabel.Destroy */ inline __fastcall virtual ~TLMDHTMLLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmllabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLLABEL)
using namespace Lmdhtmllabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmllabelHPP
