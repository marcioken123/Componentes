// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeElectric.pas' rev: 34.00 (Windows)

#ifndef TreeelectricHPP
#define TreeelectricHPP

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
#include <TreeFlow.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeelectric
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElectricShape;
class DELPHICLASS TSolidResistorShape;
class DELPHICLASS TFuseShape;
class DELPHICLASS TResistorShape;
class DELPHICLASS TCapacitorShape;
class DELPHICLASS TDiodeShape;
class DELPHICLASS TGroundShape;
class DELPHICLASS TSourceShape;
class DELPHICLASS TChasisShape;
class DELPHICLASS TOrGateShape;
class DELPHICLASS TAndGateShape;
class DELPHICLASS TLampShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElectricShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TElectricShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TElectricShape() { }
	
};


class PASCALIMPLEMENTATION TSolidResistorShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TSolidResistorShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TSolidResistorShape() { }
	
};


class PASCALIMPLEMENTATION TFuseShape : public TSolidResistorShape
{
	typedef TSolidResistorShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TFuseShape(System::Classes::TComponent* AOwner) : TSolidResistorShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TFuseShape() { }
	
};


class PASCALIMPLEMENTATION TResistorShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TResistorShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TResistorShape() { }
	
};


class PASCALIMPLEMENTATION TCapacitorShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TCapacitorShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TCapacitorShape() { }
	
};


class PASCALIMPLEMENTATION TDiodeShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TDiodeShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDiodeShape() { }
	
};


class PASCALIMPLEMENTATION TGroundShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TGroundShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TGroundShape() { }
	
};


class PASCALIMPLEMENTATION TSourceShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TSourceShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TSourceShape() { }
	
};


class PASCALIMPLEMENTATION TChasisShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TChasisShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TChasisShape() { }
	
};


class PASCALIMPLEMENTATION TOrGateShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TOrGateShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TOrGateShape() { }
	
};


class PASCALIMPLEMENTATION TAndGateShape : public TElectricShape
{
	typedef TElectricShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TAndGateShape(System::Classes::TComponent* AOwner) : TElectricShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TAndGateShape() { }
	
};


class PASCALIMPLEMENTATION TLampShape : public Treeflow::TOctagonShape
{
	typedef Treeflow::TOctagonShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TLampShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Color = {default=65535};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TLampShape() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treeelectric */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEELECTRIC)
using namespace Treeelectric;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeelectricHPP
