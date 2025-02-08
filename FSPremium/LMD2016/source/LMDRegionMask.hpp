// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRegionMask.pas' rev: 31.00 (Windows)

#ifndef LmdregionmaskHPP
#define LmdregionmaskHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDClass.hpp>
#include <LMDObject.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdregionmask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRegionMask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRegionMask : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	_RGNDATA *FRegionData;
	int FDataSize;
	Vcl::Graphics::TBitmap* FBmpUp;
	Vcl::Graphics::TBitmap* FBmpDn;
	Vcl::Graphics::TBitmap* FBmp;
	Lmdgraph::TLMDSavePixelFormat FPixelFormat;
	bool FCompressed;
	void __fastcall SetRegionData(Winapi::Windows::PRgnData aValue);
	void __fastcall SetDataSize(int aValue);
	void __fastcall SetBorderBmp(int index, Vcl::Graphics::TBitmap* aValue);
	void __fastcall ReadRegionData(System::Classes::TStream* Reader);
	void __fastcall ReadBitmap(System::Classes::TStream* Stream);
	void __fastcall ReadUpBitmap(System::Classes::TStream* Stream);
	void __fastcall ReadDnBitmap(System::Classes::TStream* Stream);
	void __fastcall WriteRegionData(System::Classes::TStream* Writer);
	void __fastcall WriteBitmap(System::Classes::TStream* Stream);
	void __fastcall WriteUpBitmap(System::Classes::TStream* Stream);
	void __fastcall WriteDnBitmap(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDRegionMask(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDRegionMask(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall CreateBorderUpBmp(void);
	void __fastcall CreateBorderDnBmp(void);
	void __fastcall GetMem(void);
	void __fastcall FreeMem(void);
	void __fastcall GetRegionData(HRGN frh);
	__property Winapi::Windows::PRgnData RegionData = {read=FRegionData, write=SetRegionData};
	__property Vcl::Graphics::TBitmap* BorderBmp = {read=FBmp, write=SetBorderBmp, index=0};
	__property Vcl::Graphics::TBitmap* BorderUpBmp = {read=FBmpUp, write=SetBorderBmp, index=1};
	__property Vcl::Graphics::TBitmap* BorderDnBmp = {read=FBmpDn, write=SetBorderBmp, index=2};
	
__published:
	__property int RegionDataSize = {read=FDataSize, write=SetDataSize, default=0};
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=0};
	__property Lmdgraph::TLMDSavePixelFormat PixelFormat = {read=FPixelFormat, write=FPixelFormat, default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Winapi::Windows::PRgnData __fastcall AllocRegionData(int Size);
extern DELPHI_PACKAGE void __fastcall FreeRegionData(Winapi::Windows::PRgnData Data);
}	/* namespace Lmdregionmask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREGIONMASK)
using namespace Lmdregionmask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdregionmaskHPP
