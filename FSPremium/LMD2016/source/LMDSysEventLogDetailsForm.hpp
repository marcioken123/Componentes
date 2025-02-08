// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysEventLogDetailsForm.pas' rev: 31.00 (Windows)

#ifndef LmdsyseventlogdetailsformHPP
#define LmdsyseventlogdetailsformHPP

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
#include <Vcl.Buttons.hpp>
#include <LMDSysEventLog.hpp>
#include <Vcl.ComCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyseventlogdetailsform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDSysLogDetails;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDSysLogDetails : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TTabControl* TabControl1;
	Vcl::Stdctrls::TLabel* lblDate;
	Vcl::Stdctrls::TLabel* lblTime;
	Vcl::Stdctrls::TLabel* lblType;
	Vcl::Stdctrls::TLabel* lblSource;
	Vcl::Stdctrls::TLabel* lblCategory;
	Vcl::Stdctrls::TLabel* lblEventID;
	Vcl::Stdctrls::TLabel* lblUser;
	Vcl::Stdctrls::TLabel* lblComputer;
	Vcl::Stdctrls::TMemo* edShowDescription;
	Vcl::Stdctrls::TLabel* lblDescription;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TLabel* lblDisplayDate;
	Vcl::Stdctrls::TLabel* lblDisplaySource;
	Vcl::Stdctrls::TLabel* lblDisplayTime;
	Vcl::Stdctrls::TLabel* lblDisplayType;
	Vcl::Stdctrls::TLabel* lblDisplayUser;
	Vcl::Stdctrls::TLabel* lblDisplayCategory;
	Vcl::Stdctrls::TLabel* lblDisplayEventID;
	Vcl::Stdctrls::TLabel* lblDisplayComputer;
	Vcl::Stdctrls::TLabel* lblShowPosition;
	Vcl::Buttons::TBitBtn* btnDown;
	Vcl::Buttons::TBitBtn* btnUp;
	Vcl::Buttons::TBitBtn* btnCopy;
	Vcl::Buttons::TBitBtn* btnFirst;
	Vcl::Buttons::TBitBtn* btnLast;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	
private:
	Lmdsyseventlog::TLMDSysEventDlgChange FOnChange;
	System::Classes::TNotifyEvent FOnBtnClick;
	
public:
	int FPosition;
	int FCount;
	Lmdsyseventlog::TLMDSysEventLog* FOwner;
	void __fastcall DisplayEvent(Lmdsyseventlog::PLMDSysEventInfo tmp);
	__property Lmdsyseventlog::TLMDSysEventDlgChange OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnBtnClick = {read=FOnBtnClick, write=FOnBtnClick};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDSysLogDetails(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDSysLogDetails(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDSysLogDetails(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDSysLogDetails(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyseventlogdetailsform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSEVENTLOGDETAILSFORM)
using namespace Lmdsyseventlogdetailsform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyseventlogdetailsformHPP
