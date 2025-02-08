// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomProgressFill.pas' rev: 31.00 (Windows)

#ifndef LmdcustomprogressfillHPP
#define LmdcustomprogressfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDGraphicControl.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomprogressfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomProgressFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomProgressFill : public Lmdbasemeter::TLMDBaseMeter
{
	typedef Lmdbasemeter::TLMDBaseMeter inherited;
	
private:
	Lmdgraph::TLMDBorderStyle FBar3D;
	System::Uitypes::TColor FBack;
	Lmdfillobject::TLMDFillObject* FFillObject;
	void __fastcall SetBar3D(Lmdgraph::TLMDBorderStyle aValue);
	void __fastcall SetBack(System::Uitypes::TColor aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	
protected:
	virtual void __fastcall DrawBar(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &dest, const System::Types::TRect &notDest, const System::Types::TRect &aRect);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCustomProgressFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomProgressFill(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Lmdgraph::TLMDBorderStyle Bar3D = {read=FBar3D, write=SetBar3D, default=0};
	__property Bevel;
	__property System::Uitypes::TColor BrushBackColor = {read=FBack, write=SetBack, default=-16777201};
	__property Color = {default=-16777211};
	__property Caption = {default=0};
	__property Direction = {default=0};
	__property Delta = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property Font;
	__property Font3D;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property MaxValue = {default=100};
	__property MinValue = {default=0};
	__property OptionsText = {default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property UseFontColor = {default=0};
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
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomprogressfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPROGRESSFILL)
using namespace Lmdcustomprogressfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomprogressfillHPP
