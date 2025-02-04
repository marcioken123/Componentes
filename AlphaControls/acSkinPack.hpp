// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acSkinPack.pas' rev: 27.00 (Windows)

#ifndef AcskinpackHPP
#define AcskinpackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acskinpack
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TacImageItem
{
public:
	System::UnicodeString FileName;
	bool IsBitmap;
	System::Classes::TMemoryStream* FileStream;
};


typedef System::DynamicArray<TacImageItem> TacImageItems;

class DELPHICLASS TacSkinConvertor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacSkinConvertor : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	int ImageCount;
	TacImageItems Files;
	System::Classes::TMemoryStream* Options;
	System::Classes::TMemoryStream* PackedData;
	void __fastcall Clear(void);
	__fastcall virtual ~TacSkinConvertor(void);
public:
	/* TObject.Create */ inline __fastcall TacSkinConvertor(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall PackDir(const System::UnicodeString SrcPath, const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall UnpackSkinFile(const System::UnicodeString Filename, const System::UnicodeString DestDirectory);
extern DELPHI_PACKAGE void __fastcall LoadSkinFromFile(const System::UnicodeString FileName, TacSkinConvertor* &Convertor, bool FreePackedData = true);
extern DELPHI_PACKAGE void __fastcall ExtractPackedData(TacSkinConvertor* &Convertor);
}	/* namespace Acskinpack */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACSKINPACK)
using namespace Acskinpack;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcskinpackHPP
