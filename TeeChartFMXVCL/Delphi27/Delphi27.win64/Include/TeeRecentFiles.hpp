// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeRecentFiles.pas' rev: 34.00 (Windows)

#ifndef TeerecentfilesHPP
#define TeerecentfilesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teerecentfiles
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRecentFiles;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TRecentFilesNotifyEvent)(const System::UnicodeString FileName);

class PASCALIMPLEMENTATION TRecentFiles : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void __fastcall ReopenFile(System::TObject* Sender);
	System::UnicodeString __fastcall GetFileName(Vcl::Menus::TMenuItem* Item);
	
public:
	Vcl::Menus::TMenuItem* MenuItem;
	Vcl::Menus::TMenuItem* MenuSep;
	TRecentFilesNotifyEvent ReOpenFileEvent;
	void __fastcall Add(const System::UnicodeString FileName);
	void __fastcall ReadRegistry(const System::UnicodeString Key);
	void __fastcall WriteRegistry(const System::UnicodeString Key);
public:
	/* TObject.Create */ inline __fastcall TRecentFiles() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TRecentFiles() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerecentfiles */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEERECENTFILES)
using namespace Teerecentfiles;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeerecentfilesHPP
