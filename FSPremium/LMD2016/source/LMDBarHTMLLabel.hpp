// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBarHTMLLabel.pas' rev: 31.00 (Windows)

#ifndef LmdbarhtmllabelHPP
#define LmdbarhtmllabelHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDClass.hpp>
#include <LMDBarBase.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbarhtmllabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBarHTMLLabel;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TLMDBarHTMLString;

class PASCALIMPLEMENTATION TLMDBarHTMLLabel : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	bool FAlreadyInSetBounds;
	Lmdgraph::TLMDBorderStyle FBorder;
	System::Byte FBorderWidth;
	TLMDBarHTMLString FCaption;
	int FLineGap;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	void __fastcall SetBorder(const Lmdgraph::TLMDBorderStyle Value);
	void __fastcall SetBorderWidth(const System::Byte Value);
	void __fastcall SetCaption(const TLMDBarHTMLString Value);
	void __fastcall SetLineGap(const int Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall AdjustSize(void);
	virtual void __fastcall DoUpdate(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TLMDBarHTMLLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBarHTMLLabel(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
	__property AutoSize = {default=0};
	__property Align = {default=0};
	__property Lmdgraph::TLMDBorderStyle Border = {read=FBorder, write=SetBorder, default=0};
	__property System::Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property TLMDBarHTMLString Caption = {read=FCaption, write=SetCaption};
	__property int LineGap = {read=FLineGap, write=SetLineGap, default=0};
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
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbarhtmllabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBARHTMLLABEL)
using namespace Lmdbarhtmllabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbarhtmllabelHPP
