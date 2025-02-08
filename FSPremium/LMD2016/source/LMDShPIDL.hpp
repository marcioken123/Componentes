// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShPIDL.pas' rev: 31.00 (Windows)

#ifndef LmdshpidlHPP
#define LmdshpidlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Forms.hpp>
#include <System.Win.ComObj.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDTypes.hpp>
#include <LMDShBase.hpp>
#include <LMDShMisc.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshpidl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellPIDLS;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Winapi::Shlobj::PItemIDList> PLMDShellPIDLArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellPIDLS : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Winapi::Shlobj::PItemIDList operator[](int index) { return this->Items[index]; }
	
private:
	PLMDShellPIDLArray FItems;
	int FCount;
	Winapi::Shlobj::PItemIDList __fastcall GetItem(int index);
	PLMDShellPIDLArray __fastcall GetItems(void);
	void __fastcall SetCount(int V);
	void __fastcall SetItem(int Ind, Winapi::Shlobj::PItemIDList aItem);
	
public:
	__fastcall TLMDShellPIDLS(void);
	__fastcall virtual ~TLMDShellPIDLS(void);
	void __fastcall Add(Winapi::Shlobj::PItemIDList aItem);
	__property Winapi::Shlobj::PItemIDList Items[int index] = {read=GetItem, write=SetItem/*, default*/};
	__property PLMDShellPIDLArray List = {read=GetItems};
	__property int Count = {read=FCount, write=SetCount, nodefault};
};

#pragma pack(pop)

typedef Winapi::Shlobj::PItemIDList __stdcall (*TLMDShPIDLClone)(Winapi::Shlobj::PItemIDList aPIDL);

typedef Winapi::Shlobj::PItemIDList __stdcall (*TLMDShPIDLCloneFirst)(Winapi::Shlobj::PItemIDList aPIDL);

typedef Winapi::Shlobj::PItemIDList __stdcall (*TLMDShPIDLCombine)(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);

typedef Winapi::Shlobj::PItemIDList __stdcall (*TLMDShPIDLGetNext)(Winapi::Shlobj::PItemIDList aPIDL);

typedef Winapi::Shlobj::PItemIDList __stdcall (*TLMDShPIDLFindLastID)(Winapi::Shlobj::PItemIDList aPIDL);

typedef System::LongBool __stdcall (*TLMDShPIDLIsEqual)(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);

typedef System::LongBool __stdcall (*TLMDShPIDLRemoveLastID)(Winapi::Shlobj::PItemIDList aPIDL);

typedef System::Word __stdcall (*TLMDShPIDLGetSize)(Winapi::Shlobj::PItemIDList aPIDL);

typedef void __stdcall (*TLMDShPIDLFree)(Winapi::Shlobj::PItemIDList aPIDL);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE NativeUInt hShell32;
extern DELPHI_PACKAGE TLMDShPIDLClone LMDShPIDLClone;
extern DELPHI_PACKAGE TLMDShPIDLCloneFirst LMDShPIDLCloneFirst;
extern DELPHI_PACKAGE TLMDShPIDLCombine LMDShPIDLCombine;
extern DELPHI_PACKAGE TLMDShPIDLGetNext LMDShPIDLGetNext;
extern DELPHI_PACKAGE TLMDShPIDLFindLastID LMDShPIDLFindLastID;
extern DELPHI_PACKAGE TLMDShPIDLRemoveLastID LMDShPIDLRemoveLastID;
extern DELPHI_PACKAGE TLMDShPIDLGetSize LMDShPIDLGetSize;
extern DELPHI_PACKAGE TLMDShPIDLFree LMDShPIDLFree;
extern DELPHI_PACKAGE bool __fastcall LMDPIDLIsEqual(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall LMDDesktopFolder(void);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall GetIShellFolder(Winapi::Shlobj::PItemIDList aPIDL);
extern DELPHI_PACKAGE _di_IShellDetails __fastcall GetIShellDetails(_di_IShellFolder IFolder, Winapi::Shlobj::PItemIDList PIDL, NativeUInt Handle = (NativeUInt)(0x0));
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDDesktopID(void);
extern DELPHI_PACKAGE bool __fastcall LMDPathToPIDL(const System::UnicodeString aPath, Winapi::Shlobj::PItemIDList &Res, _di_IShellFolder Folder = _di_IShellFolder())/* overload */;
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDPathToPIDL(const System::UnicodeString aPath, _di_IShellFolder Folder = _di_IShellFolder())/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDPIDLToPath(Winapi::Shlobj::PItemIDList aPIDL);
extern DELPHI_PACKAGE bool __fastcall IsElement(unsigned Element, unsigned Flag);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDGetDisplayFileName(_di_IShellFolder ParentFolder, Winapi::Shlobj::PItemIDList PIDL, unsigned Flags);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDCopyPIDL(Winapi::Shlobj::PItemIDList IDList);
extern DELPHI_PACKAGE bool __fastcall LMDPIDLToStream(Winapi::Shlobj::PItemIDList aPIDL, System::Classes::TStream* Dst);
extern DELPHI_PACKAGE int __fastcall LMDGetPIDLSize(Winapi::Shlobj::PItemIDList IDList);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDNextPIDL(Winapi::Shlobj::PItemIDList IDList);
extern DELPHI_PACKAGE void __fastcall LMDStripLastID(Winapi::Shlobj::PItemIDList IDList);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDConcatPIDLs(Winapi::Shlobj::PItemIDList IDList1, Winapi::Shlobj::PItemIDList IDList2);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDGetParentPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDGetIDFromPath(const System::UnicodeString aPath);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDPathFromPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall LMDCreatePIDLList(Winapi::Shlobj::PItemIDList ID);
extern DELPHI_PACKAGE int __fastcall LMDGetItemCount(Winapi::Shlobj::PItemIDList IDList);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDCreatePIDL(int Size);
extern DELPHI_PACKAGE void __fastcall LMDDisposePIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE void __fastcall LMDShPIDLsFree(Winapi::Shlobj::PItemIDList *PIDLs, const int PIDLs_High);
extern DELPHI_PACKAGE bool __fastcall LMDSamePIDL(Winapi::Shlobj::PItemIDList ID1, Winapi::Shlobj::PItemIDList ID2);
extern DELPHI_PACKAGE void __fastcall LMDDestroyPIDLList(System::Classes::TList* List);
extern DELPHI_PACKAGE unsigned __fastcall LMDSHGetFileInfo(const System::UnicodeString pszPath, unsigned uFlags, _SHFILEINFOW &psfi, unsigned dwFileAttributes = (unsigned)(0x0))/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall LMDSHGetFileInfo(Winapi::Shlobj::PItemIDList aPIDL, unsigned uFlags, _SHFILEINFOW &psfi, unsigned dwFileAttributes = (unsigned)(0x0))/* overload */;
}	/* namespace Lmdshpidl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHPIDL)
using namespace Lmdshpidl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshpidlHPP
