// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeUML.pas' rev: 34.00 (Windows)

#ifndef TreeumlHPP
#define TreeumlHPP

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
#include <System.Types.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeuml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActorShape;
class DELPHICLASS TUMLRectangle;
class DELPHICLASS TClassShape;
class DELPHICLASS TInterfaceShape;
class DELPHICLASS TPackageShape;
class DELPHICLASS TActionShape;
class DELPHICLASS TProcShape;
class DELPHICLASS TNoteShape;
class DELPHICLASS TStoreShape;
//-- type declarations -------------------------------------------------------
typedef Teetree::TCustomTreeShape TUMLShape;

class PASCALIMPLEMENTATION TActorShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TActorShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TActorShape() { }
	
};


class PASCALIMPLEMENTATION TUMLRectangle : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
public:
	__fastcall virtual TUMLRectangle(System::Classes::TComponent* AOwner);
	
__published:
	__property ImageIndex = {default=0};
	__property VertTextAlign = {default=1};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TUMLRectangle() { }
	
};


class PASCALIMPLEMENTATION TClassShape : public TUMLRectangle
{
	typedef TUMLRectangle inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TUMLRectangle.Create */ inline __fastcall virtual TClassShape(System::Classes::TComponent* AOwner) : TUMLRectangle(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TClassShape() { }
	
};


class PASCALIMPLEMENTATION TInterfaceShape : public TUMLRectangle
{
	typedef TUMLRectangle inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TUMLRectangle.Create */ inline __fastcall virtual TInterfaceShape(System::Classes::TComponent* AOwner) : TUMLRectangle(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TInterfaceShape() { }
	
};


class PASCALIMPLEMENTATION TPackageShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TPackageShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TPackageShape() { }
	
};


class PASCALIMPLEMENTATION TActionShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TActionShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TActionShape() { }
	
};


class PASCALIMPLEMENTATION TProcShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TProcShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TProcShape() { }
	
};


class PASCALIMPLEMENTATION TNoteShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TNoteShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TNoteShape() { }
	
};


class PASCALIMPLEMENTATION TStoreShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TStoreShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TStoreShape() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treeuml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEUML)
using namespace Treeuml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeumlHPP
