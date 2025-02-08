// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHideNonVC.pas' rev: 31.00 (Windows)

#ifndef LmdhidenonvcHPP
#define LmdhidenonvcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhidenonvc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHideNonVC;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnNewComponentEvent)(System::TObject* Sender, System::Classes::TComponent* aComponent);

class PASCALIMPLEMENTATION TLMDHideNonVC : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDOnNewComponentEvent FNewComponent;
	bool FUseTag;
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDHideNonVC(System::Classes::TComponent* aOwner);
	__property TLMDOnNewComponentEvent OnNewComponent = {read=FNewComponent, write=FNewComponent};
	
__published:
	__property About = {default=0};
	__property bool UseTagInfo = {read=FUseTag, write=FUseTag, default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDHideNonVC(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Word defHideX;
extern DELPHI_PACKAGE System::Byte defComWidth;
extern DELPHI_PACKAGE bool __fastcall LMDCheckValidComponent(System::Classes::TComponent* Comp, System::Classes::TComponent* Parent);
extern DELPHI_PACKAGE int __fastcall LMDGetNonVCIndex(Vcl::Forms::TScrollingWinControl* Target, System::Classes::TComponent* Comp);
extern DELPHI_PACKAGE void __fastcall LMDShowContainer(Vcl::Forms::TScrollingWinControl* Target, System::Classes::TComponent* Comp);
extern DELPHI_PACKAGE void __fastcall LMDRemoveContainer(Vcl::Forms::TScrollingWinControl* Target, System::Classes::TComponent* Comp);
}	/* namespace Lmdhidenonvc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHIDENONVC)
using namespace Lmdhidenonvc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhidenonvcHPP
