// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDrawEdge.pas' rev: 31.00 (Windows)

#ifndef LmddrawedgeHPP
#define LmddrawedgeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddrawedge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDrawEdge;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDiagonalStyle : unsigned char { dsEndBottomLeft, dsEndBottomRight, dsEndTopLeft, dsEndTopRight };

enum DECLSPEC_DENUM TLMDDrawEdgeStyle : unsigned char { esEdge, esDiagonal, esStandard };

class PASCALIMPLEMENTATION TLMDDrawEdge : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	TLMDDiagonalStyle FDiagonal;
	Lmdgraph::TLMDEdgeStyle FEdgeStyle;
	bool FFilled;
	Lmdgraph::TLMDFrameSides FFrame;
	Lmdgraph::TLMDBorderStyle FShape;
	bool FSoft;
	TLMDDrawEdgeStyle FStyle;
	void __fastcall SetBoolean(int Index, bool aValue);
	void __fastcall SetDiagonal(TLMDDiagonalStyle aValue);
	void __fastcall SetEdgeStyle(Lmdgraph::TLMDEdgeStyle aValue);
	void __fastcall SetFrame(Lmdgraph::TLMDFrameSides aValue);
	void __fastcall SetStyle(TLMDDrawEdgeStyle aValue);
	void __fastcall SetShape(Lmdgraph::TLMDBorderStyle aValue);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDDrawEdge(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property TLMDDiagonalStyle DiagonalStyle = {read=FDiagonal, write=SetDiagonal, default=0};
	__property Lmdgraph::TLMDEdgeStyle EdgeStyle = {read=FEdgeStyle, write=SetEdgeStyle, default=5};
	__property Enabled = {default=1};
	__property bool Filled = {read=FFilled, write=SetBoolean, index=0, default=0};
	__property Lmdgraph::TLMDFrameSides FrameSides = {read=FFrame, write=SetFrame, default=15};
	__property ParentShowHint = {default=1};
	__property Lmdgraph::TLMDBorderStyle StandardStyle = {read=FShape, write=SetShape, default=12};
	__property ShowHint;
	__property bool Soft = {read=FSoft, write=SetBoolean, index=1, default=0};
	__property TLMDDrawEdgeStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
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
public:
	/* TLMDBaseGraphicControl.Destroy */ inline __fastcall virtual ~TLMDDrawEdge(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddrawedge */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDRAWEDGE)
using namespace Lmddrawedge;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddrawedgeHPP
