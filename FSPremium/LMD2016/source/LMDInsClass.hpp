// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsClass.pas' rev: 31.00 (Windows)

#ifndef LmdinsclassHPP
#define LmdinsclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDInsCst.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinsclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDObjectList;
class DELPHICLASS TLMDObjectList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDObjectList : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDObjectList(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDObjectList(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDObjectList(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDObjectList(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDObjectList(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDObjectList(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDObjectList(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDObjectList(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDObjectList(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDObjectList(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDObjectList(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDObjectList(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDObjectList(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDItemByProc)(System::TObject* AItem, void * AData, bool &AResult);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDObjectList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TObject* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	bool FChangingCount;
	System::TObject* __fastcall GetItems(int AIndex);
	int __fastcall GetCount(void);
	void __fastcall SetCount(const int Value);
	
protected:
	virtual System::TObject* __fastcall CreateItem(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall Added(void);
	virtual void __fastcall Deleted(void);
	
public:
	__fastcall TLMDObjectList(void);
	__fastcall virtual ~TLMDObjectList(void);
	System::TObject* __fastcall DoItemBy(void * AData, TLMDItemByProc AItemByProc);
	System::TObject* __fastcall DoFind(void * AData, TLMDItemByProc AItemByProc);
	System::TObject* __fastcall DoSearch(void * AData, TLMDItemByProc AItemByProc);
	int __fastcall Add(void);
	void __fastcall Remove(System::TObject* AItem);
	void __fastcall Delete(int AIndex);
	void __fastcall Clear(void);
	int __fastcall IndexOf(System::TObject* AItem);
	__property System::TObject* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int Count = {read=GetCount, write=SetCount, nodefault};
};

#pragma pack(pop)

typedef int __fastcall (*TLMDQSCompareProc)(int AItemIndex1, int AItemIndex2, void * AData);

typedef void __fastcall (*TLMDQSExchangeProc)(int AItemIndex1, int AItemIndex2, void * AData);

typedef void __fastcall (__closure *TLMDHintHookProc)(tagMSG &AMsg);

typedef Vcl::Grids::TEditStyle TLMDEditStyle;

typedef Vcl::Grids::TCustomGrid TLMDGridBase;

typedef Vcl::Grids::TInplaceEditList TLMDGridBaseInplaceEditList;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDQuickSort(int ALow, int AHigh, TLMDQSCompareProc ACompareProc, TLMDQSExchangeProc AExchangeProc, void * AData);
extern DELPHI_PACKAGE void __fastcall LMDHookHint(TLMDHintHookProc AHookProc);
extern DELPHI_PACKAGE void __fastcall LMDUnhookHint(TLMDHintHookProc AHookProc);
}	/* namespace Lmdinsclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSCLASS)
using namespace Lmdinsclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinsclassHPP
