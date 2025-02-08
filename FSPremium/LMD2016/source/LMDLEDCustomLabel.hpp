// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLEDCustomLabel.pas' rev: 31.00 (Windows)

#ifndef LmdledcustomlabelHPP
#define LmdledcustomlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDLED.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdledcustomlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLEDCustomLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLEDCustomLabel : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	bool FAutosize;
	System::Byte FDigits;
	Lmdled::TLMDLED* FLED;
	int FValue;
	Lmdled::TLMDLEDStyle FStyle;
	HIDESBASE void __fastcall SetAutosize(bool aValue);
	void __fastcall SetByte(System::Byte aValue);
	void __fastcall SetLED(Lmdled::TLMDLED* aValue);
	void __fastcall SetStyle(Lmdled::TLMDLEDStyle aValue);
	void __fastcall SetValue(int aValue);
	void __fastcall CalcBoundsRect(void);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	System::UnicodeString __fastcall ValueString(int aValue);
	__property int Value = {read=FValue, write=SetValue, default=0};
	
public:
	__fastcall virtual TLMDLEDCustomLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDLEDCustomLabel(void);
	__property Caption = {default=0};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property bool AutoSize = {read=FAutosize, write=SetAutosize, default=0};
	__property Bevel;
	__property Color = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property System::Byte Digits = {read=FDigits, write=SetByte, default=2};
	__property Enabled = {default=1};
	__property Lmdled::TLMDLED* LED = {read=FLED, write=SetLED};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Lmdled::TLMDLEDStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdledcustomlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLEDCUSTOMLABEL)
using namespace Lmdledcustomlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdledcustomlabelHPP
