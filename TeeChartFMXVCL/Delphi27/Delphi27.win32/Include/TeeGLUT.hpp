// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeGLUT.pas' rev: 34.00 (Windows)

#ifndef TeeglutHPP
#define TeeglutHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeglut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDodecahedron;
class DELPHICLASS TTeaPotBlock;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDodecahedron : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	bool ICreated;
	System::StaticArray<System::Math::Vectors::TPoint3D, 20> IData;
	System::StaticArray<System::Math::Vectors::TPoint3D, 12> INormals;
	void __fastcall Dodecahedron(const int AType);
	
public:
	virtual void __fastcall Draw();
public:
	/* TCustomBlock.Create */ inline __fastcall virtual TDodecahedron(System::Classes::TComponent* AOwner) : Teeblocks::TCustomBlock(AOwner) { }
	/* TCustomBlock.Destroy */ inline __fastcall virtual ~TDodecahedron() { }
	
};


class PASCALIMPLEMENTATION TTeaPotBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	int IList;
	void __fastcall BorderChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall DeleteLists();
	
public:
	__fastcall virtual TTeaPotBlock(System::Classes::TComponent* AOwner);
	virtual void __fastcall Draw();
public:
	/* TCustomBlock.Destroy */ inline __fastcall virtual ~TTeaPotBlock() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeglut */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEGLUT)
using namespace Teeglut;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeglutHPP
