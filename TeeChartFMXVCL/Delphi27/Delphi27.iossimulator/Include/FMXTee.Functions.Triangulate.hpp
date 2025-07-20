// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Triangulate.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Functions_TriangulateHPP
#define Fmxtee_Functions_TriangulateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Triangulate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTriangulator;
//-- type declarations -------------------------------------------------------
typedef double TTriValue;

typedef double __fastcall (__closure *TGetValueProc)(int Index);

typedef void __fastcall (__closure *TSetValueProc)(int Dest, int Source);

class PASCALIMPLEMENTATION TTriangulator : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<int> _TTriangulator__1;
	
	typedef System::DynamicArray<int> _TTriangulator__2;
	
	
private:
	int __fastcall IDxchg(const int I1, const int I2, const int I3, const int I4);
	
public:
	_TTriangulator__1 IPL;
	_TTriangulator__2 IPT;
	TGetValueProc GetX;
	TGetValueProc GetZ;
	TSetValueProc SetXYZ;
	int NumLines;
	int NumTriangles;
	bool ImprovedTriangles;
	__fastcall virtual ~TTriangulator();
	bool __fastcall CreateTriangles(int NumPoints);
public:
	/* TObject.Create */ inline __fastcall TTriangulator() : System::TObject() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Triangulate */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_TRIANGULATE)
using namespace Fmxtee::Functions::Triangulate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS)
using namespace Fmxtee::Functions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Functions_TriangulateHPP
