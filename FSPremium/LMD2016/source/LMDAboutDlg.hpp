// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAboutDlg.pas' rev: 31.00 (Windows)

#ifndef LmdaboutdlgHPP
#define LmdaboutdlgHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdaboutdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAboutDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAboutStyle : unsigned char { bsStandard, bsLMD };

enum DECLSPEC_DENUM TLMDAboutIconStyle : unsigned char { isNone, isStandard, isExtended };

enum DECLSPEC_DENUM TLMDAboutVersionStyle : unsigned char { vsProg, vsFileShort, vsFileFull, vsFileBuild };

class PASCALIMPLEMENTATION TLMDAboutDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::UnicodeString FAppname;
	System::UnicodeString FCopyright;
	System::UnicodeString FJump;
	System::UnicodeString FEmail;
	System::UnicodeString FDescription;
	bool FDefault;
	Vcl::Graphics::TIcon* FIcon;
	TLMDAboutIconStyle FIconStyle;
	int FSize;
	TLMDAboutStyle FStyle;
	System::UnicodeString FVersion;
	bool FUseResInfo;
	TLMDAboutVersionStyle FUseResVersionInfo;
	void __fastcall SetIcon(Vcl::Graphics::TIcon* aIcon);
	
public:
	__fastcall virtual TLMDAboutDlg(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAboutDlg(void);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* aForm);
	__property CtlXP = {default=1};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon, write=SetIcon};
	
__published:
	__property About = {default=0};
	__property System::UnicodeString Appname = {read=FAppname, write=FAppname};
	__property int AppNameSize = {read=FSize, write=FSize, default=22};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property System::UnicodeString Copyright = {read=FCopyright, write=FCopyright};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property Effect = {default=0};
	__property System::UnicodeString EMail = {read=FEmail, write=FEmail};
	__property Hints;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property TLMDAboutIconStyle IconStyle = {read=FIconStyle, write=FIconStyle, default=2};
	__property System::UnicodeString Jump = {read=FJump, write=FJump};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property TLMDAboutStyle Style = {read=FStyle, write=FStyle, default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property bool UseDefault = {read=FDefault, write=FDefault, default=0};
	__property bool UseResInfo = {read=FUseResInfo, write=FUseResInfo, default=0};
	__property TLMDAboutVersionStyle UseResVersionInfoStyle = {read=FUseResVersionInfo, write=FUseResVersionInfo, default=0};
	__property System::UnicodeString Version = {read=FVersion, write=FVersion};
	__property OnCustomize;
	__property OnCustomClick;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdaboutdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDABOUTDLG)
using namespace Lmdaboutdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdaboutdlgHPP
