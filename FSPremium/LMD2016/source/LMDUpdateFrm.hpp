// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUpdateFrm.pas' rev: 31.00 (Windows)

#ifndef LmdupdatefrmHPP
#define LmdupdatefrmHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDAutoUpdateFrm.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <System.SyncObjs.hpp>
#include <Vcl.Controls.hpp>
#include <LMDWebConfig.hpp>
#include <LMDUpdateMessage.hpp>
#include <LMDWebBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdupdatefrm
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomUpdateForm;
class DELPHICLASS TLMDUpdateForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomUpdateForm : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	Lmdautoupdatefrm::TLMDAutoUpdateForm* FFormInstance;
	Lmdwebconfig::TLMDWebConfig* __fastcall GetWebConfig(void);
	
public:
	System::Uitypes::TModalResult __fastcall ShowForm(bool AModal = false);
	void __fastcall OnMessageReceive(System::TObject* Sender, Lmdupdatemessage::TLMDUpdateMessage* AMessage);
	void __fastcall HideForm(void);
	__fastcall virtual TLMDCustomUpdateForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomUpdateForm(void);
	void __fastcall SetStatus(const Lmdtypes::TLMDString AStatus);
	void __fastcall ProgressiveBarVisiable(bool AVisiable);
	void __fastcall SetProgressiveBarMaxValue(int AValue);
	void __fastcall SetProgressiveBarValue(int AValue);
	void __fastcall BtnLogVisiable(bool AValue);
	void __fastcall BtnDoneVisiable(bool AValue);
	void __fastcall ShowAdditionalButtons(bool AValue);
	Lmdautoupdatefrm::TLMDAutoUpdateForm* __fastcall GetInstance(void);
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=GetWebConfig};
};


class PASCALIMPLEMENTATION TLMDUpdateForm : public TLMDCustomUpdateForm
{
	typedef TLMDCustomUpdateForm inherited;
	
public:
	/* TLMDCustomUpdateForm.Create */ inline __fastcall virtual TLMDUpdateForm(System::Classes::TComponent* AOwner) : TLMDCustomUpdateForm(AOwner) { }
	/* TLMDCustomUpdateForm.Destroy */ inline __fastcall virtual ~TLMDUpdateForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdupdatefrm */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUPDATEFRM)
using namespace Lmdupdatefrm;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdupdatefrmHPP
