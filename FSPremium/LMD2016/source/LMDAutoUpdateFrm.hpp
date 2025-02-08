// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAutoUpdateFrm.pas' rev: 31.00 (Windows)

#ifndef LmdautoupdatefrmHPP
#define LmdautoupdatefrmHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWebBase.hpp>
#include <LMDWebConfig.hpp>
#include <System.SyncObjs.hpp>
#include <LMDUpdateInternetOptionsUnit.hpp>
#include <LMDUpdateMessage.hpp>
#include <Vcl.ImgList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdautoupdatefrm
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAutoUpdateForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAutoUpdateForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Actnlist::TAction* actShowLog;
	Vcl::Actnlist::TAction* actDone;
	Vcl::Stdctrls::TMemo* mmStatus;
	Vcl::Stdctrls::TLabel* lbStatus;
	Vcl::Buttons::TSpeedButton* btnDone;
	Vcl::Buttons::TSpeedButton* btnShowLog;
	Vcl::Comctrls::TProgressBar* pbStatus;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* btnInternetOptions;
	Vcl::Actnlist::TAction* actInternetOptions;
	Vcl::Actnlist::TAction* actStartUpdate;
	Lmdwebconfig::TLMDWebConfig* LMDWebConfig1;
	Vcl::Stdctrls::TButton* btnStartUpdate;
	Vcl::Extctrls::TImage* Image1;
	void __fastcall actShowLogExecute(System::TObject* Sender);
	void __fastcall actDoneExecute(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall actInternetOptionsExecute(System::TObject* Sender);
	void __fastcall actStartUpdateExecute(System::TObject* Sender);
	
private:
	System::Syncobjs::TCriticalSection* FCriticalSection;
	
public:
	void __fastcall SetStatus(const Lmdtypes::TLMDString AStatus);
	void __fastcall ProgressiveBarVisiable(bool AVisiable);
	void __fastcall SetProgressiveBarMaxValue(int AValue);
	void __fastcall SetProgressiveBarValue(int AValue);
	void __fastcall ShowAdditionalButtons(bool AValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDAutoUpdateForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAutoUpdateForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDAutoUpdateForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAutoUpdateForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDAutoUpdateForm* LMDAutoUpdateForm;
}	/* namespace Lmdautoupdatefrm */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDAUTOUPDATEFRM)
using namespace Lmdautoupdatefrm;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdautoupdatefrmHPP
