// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeTransit.pas' rev: 34.00 (Windows)

#ifndef TreetransitHPP
#define TreetransitHPP

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
#include <Vcl.Controls.hpp>
#include <TeeTree.hpp>
#include <TreeFlow.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treetransit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransitShape;
class DELPHICLASS TStopShape;
class DELPHICLASS TYieldShape;
class DELPHICLASS TSlowShape;
class DELPHICLASS TDangerShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransitShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TTransitShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTransitShape() { }
	
};


class PASCALIMPLEMENTATION TStopShape : public Treeflow::TOctagonShape
{
	typedef Treeflow::TOctagonShape inherited;
	
public:
	__fastcall virtual TStopShape(System::Classes::TComponent* AOwner);
	virtual void __fastcall RecalcSize(Vcltee::Tecanvas::TCanvas3D* const ACanvas);
	
__published:
	__property Color = {default=255};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TStopShape() { }
	
};


class PASCALIMPLEMENTATION TYieldShape : public TTransitShape
{
	typedef TTransitShape inherited;
	
public:
	__fastcall virtual TYieldShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Color = {default=65535};
	__property Style = {default=8};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TYieldShape() { }
	
};


class PASCALIMPLEMENTATION TSlowShape : public TTransitShape
{
	typedef TTransitShape inherited;
	
public:
	__fastcall virtual TSlowShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Color = {default=65535};
	__property Style = {default=6};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TSlowShape() { }
	
};


class PASCALIMPLEMENTATION TDangerShape : public TTransitShape
{
	typedef TTransitShape inherited;
	
public:
	__fastcall virtual TDangerShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Color = {default=255};
	__property Style = {default=6};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDangerShape() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treetransit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREETRANSIT)
using namespace Treetransit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreetransitHPP
