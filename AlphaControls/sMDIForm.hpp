// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sMDIForm.pas' rev: 27.00 (Windows)

#ifndef SmdiformHPP
#define SmdiformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smdiform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsMDIForm;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsMDIForm : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	Vcl::Forms::TCustomForm* FForm;
	Acsbutils::TacScrollWnd* ListSW;
	Sskinprovider::TsSkinProvider* SkinProvider;
	void __fastcall ConnectToClient(void);
	__fastcall TsMDIForm(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TsMDIForm(void);
	Vcl::Menus::TMenuItem* __fastcall MakeChildIconItem(void);
	void __fastcall UpdateMDIIconItem(void);
	void __fastcall RefreshMDIScrolls(void);
	void __fastcall DestroyScrolls(void);
	void __fastcall RestoreClick(System::TObject* Sender);
	void __fastcall MinClick(System::TObject* Sender);
	void __fastcall CloseClick(System::TObject* Sender);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Smdiform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SMDIFORM)
using namespace Smdiform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SmdiformHPP
