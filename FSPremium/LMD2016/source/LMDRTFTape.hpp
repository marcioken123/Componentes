// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFTape.pas' rev: 31.00 (Windows)

#ifndef LmdrtftapeHPP
#define LmdrtftapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtftape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFTapeCellDATA;
class DELPHICLASS TLMDRTFTapeCellIDATA;
class DELPHICLASS TLMDRTFTapeCellPDATA;
class DELPHICLASS TLMDRTFTapeCellSDATA;
class DELPHICLASS TLMDRTFTapeCellBDATA;
class DELPHICLASS TLMDRTFTapeCell;
class DELPHICLASS TLMDRTFTape;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCellDATA : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDRTFTapeCellDATA(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFTapeCellDATA(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCellIDATA : public TLMDRTFTapeCellDATA
{
	typedef TLMDRTFTapeCellDATA inherited;
	
private:
	int FData;
	
public:
	__fastcall TLMDRTFTapeCellIDATA(int aData);
	__property int Data = {read=FData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFTapeCellIDATA(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCellPDATA : public TLMDRTFTapeCellDATA
{
	typedef TLMDRTFTapeCellDATA inherited;
	
private:
	System::UnicodeString FData;
	
public:
	__fastcall TLMDRTFTapeCellPDATA(System::UnicodeString aData);
	__property System::UnicodeString Data = {read=FData};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFTapeCellPDATA(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCellSDATA : public TLMDRTFTapeCellDATA
{
	typedef TLMDRTFTapeCellDATA inherited;
	
private:
	System::UnicodeString FData;
	
public:
	__fastcall TLMDRTFTapeCellSDATA(System::UnicodeString aData);
	__property System::UnicodeString Data = {read=FData};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFTapeCellSDATA(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCellBDATA : public TLMDRTFTapeCellDATA
{
	typedef TLMDRTFTapeCellDATA inherited;
	
private:
	System::Classes::TMemoryStream* FData;
	
public:
	__fastcall TLMDRTFTapeCellBDATA(System::Classes::TStream* aData);
	__fastcall virtual ~TLMDRTFTapeCellBDATA(void);
	__property System::Classes::TMemoryStream* Data = {read=FData};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFCellType : unsigned char { ctDATA, ctIDATA, ctPDATA, ctSDATA, ctBDATA };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTapeCell : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDRTFCellType FCellType;
	int FCellCode;
	TLMDRTFTapeCellDATA* FData;
	bool FReady;
	
protected:
	void __fastcall SetReady(void);
	
public:
	__fastcall virtual TLMDRTFTapeCell(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFTapeCell(void);
	__property int CellCode = {read=FCellCode, nodefault};
	__property TLMDRTFCellType CellType = {read=FCellType, nodefault};
	__property TLMDRTFTapeCellDATA* Data = {read=FData};
	__property bool Ready = {read=FReady, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTape : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFTapeCell* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFTapeCell* __fastcall GetItem(int index);
	
protected:
	TLMDRTFTapeCell* __fastcall AddCell(void)/* overload */;
	
public:
	__fastcall TLMDRTFTape(void);
	void __fastcall AddCell(int aCode)/* overload */;
	void __fastcall AddICell(int aCode, int aData);
	void __fastcall AddPCell(int aCode, System::UnicodeString aData);
	void __fastcall AddSCell(int aCode, System::UnicodeString aData);
	void __fastcall AddBCell(int aCode, System::Classes::TStream* aData);
	__property TLMDRTFTapeCell* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFTape(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtftape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFTAPE)
using namespace Lmdrtftape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtftapeHPP
