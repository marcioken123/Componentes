// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSysViewDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsysviewdlgHPP
#define PlmdsysviewdlgHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysNetworkEnumerator.hpp>
#include <LMDSysTreeView.hpp>
#include <LMDSysNetTreeView.hpp>
#include <LMDSysInfoListView.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDSysInfoTreeView.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsysviewdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDSysViewDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDSysViewDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdsysinfolistview::TLMDSysInfoListView* lv;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnClose;
	void __fastcall FormDestroy(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDSysViewDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDSysViewDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDSysViewDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDSysViewDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsysviewdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSYSVIEWDLG)
using namespace Plmdsysviewdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsysviewdlgHPP
