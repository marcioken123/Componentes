// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBarBase.pas' rev: 31.00 (Windows)

#ifndef LmdbarbaseHPP
#define LmdbarbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDObject.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbarbase
{
//-- forward type declarations -----------------------------------------------
__interface TLMDBarParentControlInterface;
typedef System::DelphiInterface<TLMDBarParentControlInterface> _di_TLMDBarParentControlInterface;
class DELPHICLASS TLMDBarController;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{13432433-0000-4523-3456-454870235266}") TLMDBarParentControlInterface  : public System::IInterface 
{
	virtual bool __fastcall GetUseXP(void) = 0 ;
	virtual Lmdobject::TLMDObject* __fastcall GetTheme(void) = 0 ;
};

class PASCALIMPLEMENTATION TLMDBarController : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
protected:
	System::Classes::TList* FUpdateObjects;
	void __fastcall UpdateParentControls(int Internal = 0x0);
	
public:
	__fastcall virtual TLMDBarController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBarController(void);
	void __fastcall AddUpdateObject(System::TObject* aObject);
	void __fastcall RemoveUpdateObject(System::TObject* aObject);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word CM_UPDATELINKCONTROLMSG = System::Word(0x401);
static const System::Word WM_UPDATESCROLL = System::Word(0x402);
static const System::Int8 LEB_VSPACE = System::Int8(0xa);
static const System::Int8 LEB_HSPACE = System::Int8(0xa);
static const System::Int8 LEB_VSECTIONS_SPACE = System::Int8(0xf);
static const System::Int8 LEB_VITEMS_SPACE = System::Int8(0x14);
static const System::Int8 LEB_HEADER_BTN_SIZE = System::Int8(0x14);
static const System::Int8 LEB_HEADER_VSPACE = System::Int8(0xa);
static const int LEB_BACK_COLOR = int(0xde8e6c);
static const int LEB_HEADER_START = int(0xffffff);
static const int LEB_HEADER_END = int(0xf7d6d0);
static const int LEB_HEADER_COLOR = int(0xc65252);
static const int LEB_HEADER_HIGHLIGHT = int(0xde8e6c);
static const int LEB_ITEM_DISABLE = int(0xfeaeac);
static const int LEB_SECTION_BACK = int(0xf7dfd6);
#define LEB_HEADER_FONT_NAME L"Tahoma"
#define LEB_ITEM_FONT_NAME L"Tahoma"
static const int LEB_TRANS_COLOR = int(0x109311);
static const System::Int8 LEB_SMOOTH_STEP = System::Int8(0xa);
static const System::Int8 LEB_GLYPH_SIZE = System::Int8(0x13);
static const System::Word LEB_HINTPAUSE = System::Word(0x320);
static const int LSB_TEXTCOLOR = int(0);
static const int LSB_HIGHLIGHTEXT = int(8388608);
static const int LSB_DISABLETEXT = int(12632256);
static const int LSB_IBORDERLIGHT = int(16777215);
static const int LSB_IBORDERBLACK = int(12632256);
static const int LSB_ITEMSELECTEDBACKGROUND = int(0xf0f0f0);
static const int LSB_ITEMDOWNBACKGROUND = int(-16777201);
static const int LSB_ITEMDRAGBACKGROUND = int(0xb0b0b0);
static const int LSB_ITEMDRAGBORDER = int(0);
static const int LSB_LISTVIEW_BACK = int(-16777201);
static const int LSB_BUTTON_BACK = int(-16777201);
extern DELPHI_PACKAGE GUID IID_ILMDBarParentControlInterface;
}	/* namespace Lmdbarbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBARBASE)
using namespace Lmdbarbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbarbaseHPP
