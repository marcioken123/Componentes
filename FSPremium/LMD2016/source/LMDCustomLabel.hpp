// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomLabel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlabelHPP
#define LmdcustomlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <LMDFXCaption.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomLabel : public Lmdbaselabel::TLMDBaseLabel
{
	typedef Lmdbaselabel::TLMDBaseLabel inherited;
	
private:
	Lmdbevel::TLMDBevel* FBevel;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetFontFx(Lmdfxcaption::TLMDFxCaption* aValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall FontChange(System::TObject* Sender);
	int __fastcall GetBevelExtend(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual bool __fastcall GetStatusControl(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomLabel(void);
	virtual void __fastcall CorrectBounds(void);
	
__published:
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetFontFx};
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property MultiLine = {index=1, default=0};
	__property Options;
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {index=2, default=1};
	__property ShowHint;
	__property Transparent = {default=1};
	__property Visible = {default=1};
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
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLABEL)
using namespace Lmdcustomlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlabelHPP
