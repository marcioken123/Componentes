// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeJPEG.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeejpegHPP
#define Vcltee_TeejpegHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teejpeg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeJPEGOptions;
class DELPHICLASS TJPEGExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeJPEGOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBGray;
	Vcl::Extctrls::TRadioGroup* RGPerf;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EQuality;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EDpi;
	Vcl::Comctrls::TUpDown* UDDpi;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeJPEGOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeJPEGOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeJPEGOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeJPEGOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TJPEGExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	void __fastcall CheckProperties();
	int __fastcall GetQuality();
	void __fastcall SetQuality(const int Value);
	
protected:
	TTeeJPEGOptions* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual ~TJPEGExportFormat();
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	virtual Vcl::Graphics::TGraphicClass __fastcall GraphicClass();
	Vcl::Imaging::Jpeg::TJPEGImage* __fastcall Jpeg(TTeeJPEGOptions* const AOptions);
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions)/* overload */;
	void __fastcall SetDpiJPEG(System::Classes::TStream* const Stream, System::Word Rx, System::Word Ry);
	__property int Quality = {read=GetQuality, write=SetQuality, default=95};
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TJPEGExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Imaging::Jpeg::TJPEGImage* __fastcall TeeGetJPEGImageParams(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const Vcl::Imaging::Jpeg::TJPEGDefaults &Params, int Left, int Top, int Width, int Height);
extern DELPHI_PACKAGE void __fastcall TeeSaveToJPEGFile(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const System::WideString FileName, System::WordBool Gray, Vcl::Imaging::Jpeg::TJPEGPerformance Performance, int Quality, int AWidth, int AHeight, int Dpi = 0x0);
extern DELPHI_PACKAGE void __fastcall TeeSaveToJPEG(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const System::WideString FileName, int AWidth, int AHeight, int Dpi = 0x0);
}	/* namespace Teejpeg */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEJPEG)
using namespace Vcltee::Teejpeg;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeejpegHPP
