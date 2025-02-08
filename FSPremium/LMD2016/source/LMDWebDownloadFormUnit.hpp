// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebDownloadFormUnit.pas' rev: 31.00 (Windows)

#ifndef LmdwebdownloadformunitHPP
#define LmdwebdownloadformunitHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDDownload.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDWebConst.hpp>
#include <LMDHTMLObjectUnit.hpp>
#include <LMDURLSupp.hpp>
#include <LMDStringsSupport.hpp>
#include <LMDFSSupport.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebdownloadformunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebDownload;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWebDownload : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* StopBtn;
	Vcl::Comctrls::TProgressBar* ProgressBar;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* DownloadLabel;
	Vcl::Stdctrls::TLabel* TransferLabel;
	Vcl::Stdctrls::TLabel* CPSLabel;
	Vcl::Stdctrls::TButton* CloseBtn;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* SizeLabel;
	Vcl::Comctrls::TAnimate* CopyAnimate;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall StopBtnClick(System::TObject* Sender);
	void __fastcall CloseBtnClick(System::TObject* Sender);
	
private:
	System::Classes::TNotifyEvent FOnProcessed;
	bool FAutoClose;
	Lmddownload::TLMDDownloadProgress FOldProgress;
	Lmddownload::TLMDDownloadProcessed FOldProcessed;
	void __fastcall DownloadProgress(Lmddownload::TLMDDownloadItem* Sender);
	void __fastcall DownloadProcessed(Lmddownload::TLMDDownloads* Sender);
	void __fastcall SetOnProcessed(const System::Classes::TNotifyEvent Value);
	MESSAGE void __fastcall SendProcessed(Winapi::Messages::TMessage &Message);
	void __fastcall SetAutoClose(const bool Value);
	
public:
	System::Uitypes::TModalResult FormResult;
	int ProgressStart;
	int ProgressLen;
	Lmddownload::TLMDDownloads* DL;
	void __fastcall UpdateBtn(void);
	void __fastcall Start(void);
	void __fastcall Stop(void);
	void __fastcall SetHandlers(void);
	__property System::Classes::TNotifyEvent OnProcessed = {read=FOnProcessed, write=SetOnProcessed};
	
__published:
	__property bool AutoClose = {read=FAutoClose, write=SetAutoClose, default=1};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDWebDownload(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDWebDownload(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDWebDownload(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWebDownload(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_SEND_PROCESSED = System::Word(0x416);
}	/* namespace Lmdwebdownloadformunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBDOWNLOADFORMUNIT)
using namespace Lmdwebdownloadformunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebdownloadformunitHPP
