// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFill.pas' rev: 31.00 (Windows)

#ifndef LmdfillHPP
#define LmdfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDCont.hpp>
#include <LMDFillObject.hpp>
#include <LMDCaption.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFill : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	Lmdcaption::TLMDCaption* FCaption;
	Lmdfillobject::TLMDFillObject* FFillObject;
	void __fastcall SetCaption(Lmdcaption::TLMDCaption* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	
public:
	__fastcall virtual TLMDFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFill(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property Lmdcaption::TLMDCaption* Caption = {read=FCaption, write=SetCaption};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
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
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILL)
using namespace Lmdfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfillHPP
