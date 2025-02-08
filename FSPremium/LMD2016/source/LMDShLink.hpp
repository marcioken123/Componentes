// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShLink.pas' rev: 31.00 (Windows)

#ifndef LmdshlinkHPP
#define LmdshlinkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.ShlObj.hpp>
#include <System.Win.ComObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDShFolder.hpp>
#include <LMDShBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshlink
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellLink;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellLinkShowCmd : unsigned char { SW_SHOWNORMAL_, SW_SHOWMAXIMIZED_, SW_SHOWMINIMIZED_ };

class PASCALIMPLEMENTATION TLMDShellLink : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	unsigned dwPathFlags;
	_di_IShellLinkW ISL;
	int FIconIndex;
	System::UnicodeString FArguments;
	System::UnicodeString FIconLocation;
	System::UnicodeString FDescription;
	System::UnicodeString FWorkingDirectory;
	System::UnicodeString FPath;
	System::Classes::TShortCut FHotKey;
	TLMDShellLinkShowCmd FShowCmd;
	System::Sysutils::TFileName FFileName;
	_ITEMIDLIST *FIDList;
	void __fastcall SetArguments(const System::UnicodeString Value);
	void __fastcall SetHotKey(const System::Classes::TShortCut Value);
	void __fastcall SetIconIndex(const int Value);
	void __fastcall SetShowCmd(const TLMDShellLinkShowCmd Value);
	void __fastcall SetWorkingDirectory(const System::UnicodeString Value);
	void __fastcall SetFileName(const System::Sysutils::TFileName Value);
	void __fastcall SetPath(const System::UnicodeString Value);
	void __fastcall Changed(void);
	void __fastcall SetDescription(const System::UnicodeString Value);
	void __fastcall SetIconLocation(const System::UnicodeString Value);
	void __fastcall SetIDList(const Winapi::Shlobj::PItemIDList Value);
	
public:
	__fastcall virtual TLMDShellLink(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellLink(void);
	bool __fastcall Load(System::Sysutils::TFileName szFileName, unsigned dwMode = (unsigned)(0x0))/* overload */;
	bool __fastcall Save(System::Sysutils::TFileName szFileName)/* overload */;
	bool __fastcall Load(void)/* overload */;
	bool __fastcall Save(void)/* overload */;
	void __fastcall Resolve(HWND Wnd, unsigned fFlags);
	void __fastcall Reset(void);
	__property Winapi::Shlobj::PItemIDList IDList = {read=FIDList, write=SetIDList};
	
__published:
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=SetFileName};
	__property System::UnicodeString Path = {read=FPath, write=SetPath};
	__property System::UnicodeString Description = {read=FDescription, write=SetDescription};
	__property System::UnicodeString IconLocation = {read=FIconLocation, write=SetIconLocation};
	__property int IconIndex = {read=FIconIndex, write=SetIconIndex, default=0};
	__property System::UnicodeString Arguments = {read=FArguments, write=SetArguments};
	__property System::Classes::TShortCut HotKey = {read=FHotKey, write=SetHotKey, default=0};
	__property TLMDShellLinkShowCmd ShowCmd = {read=FShowCmd, write=SetShowCmd, default=0};
	__property System::UnicodeString WorkingDirectory = {read=FWorkingDirectory, write=SetWorkingDirectory};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall LMDShellOpenDOSWindow(const System::UnicodeString usePath = System::UnicodeString());
extern DELPHI_PACKAGE void __fastcall LMDCreateShortCut(const System::UnicodeString FilePath, const System::UnicodeString ShortCutPath, const System::UnicodeString Description, const System::UnicodeString IconLocation, const System::UnicodeString Arguments, const System::UnicodeString WorkingDirectory, int IconIndex, System::Classes::TShortCut HotKey, TLMDShellLinkShowCmd ShowCmd)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDCreateShortCut(Winapi::Shlobj::PItemIDList IDList, const System::UnicodeString ShortCutPath, const System::UnicodeString Description, const System::UnicodeString IconLocation, const System::UnicodeString Arguments, const System::UnicodeString WorkingDirectory, int IconIndex, System::Classes::TShortCut HotKey, TLMDShellLinkShowCmd ShowCmd)/* overload */;
}	/* namespace Lmdshlink */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHLINK)
using namespace Lmdshlink;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshlinkHPP
