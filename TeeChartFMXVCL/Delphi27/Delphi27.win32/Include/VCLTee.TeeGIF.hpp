// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGIF.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegifHPP
#define Vcltee_TeegifHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.Imaging.GIFImg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <Vcl.ComCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegif
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeGIFOptions;
class DELPHICLASS TGIFExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeGIFOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TRadioGroup* RGCompression;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBDither;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBReduction;
	Vcltee::Tecanvas::TComboFlat* CBAnim;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TCheckBox* CBOptimize;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Comctrls::TProgressBar* ProgressBar1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teeexport::TTeeExportFormat* IFormat;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeGIFOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeGIFOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeGIFOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeGIFOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TGIFExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	Vcltee::Teengine::TTeeCustomAnimation* FAnim;
	Vcltee::Teeanimate::TTeeAnimate* FAnimate;
	bool FOptimize;
	Vcl::Imaging::Gifimg::TGIFImage* IGIF;
	System::Classes::TNotifyEvent IOnFrame;
	System::Classes::TNotifyEvent IOnStop;
	void __fastcall AnimateFrame(System::TObject* Sender);
	void __fastcall AnimateStop(System::TObject* Sender);
	void __fastcall CheckProperties();
	
protected:
	TTeeGIFOptions* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	void __fastcall CreateAnimatedGIF(Vcl::Imaging::Gifimg::TGIFImage* const AGIF);
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	virtual Vcl::Graphics::TGraphicClass __fastcall GraphicClass();
	Vcl::Imaging::Gifimg::TGIFImage* __fastcall GIF();
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	__property Vcltee::Teeanimate::TTeeAnimate* Animate = {read=FAnimate, write=FAnimate};
	__property Vcltee::Teengine::TTeeCustomAnimation* Animation = {read=FAnim, write=FAnim};
	__property bool OptimizeColors = {read=FOptimize, write=FOptimize, nodefault};
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TGIFExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	/* TTeeExportFormat.Destroy */ inline __fastcall virtual ~TGIFExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teegif */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGIF)
using namespace Vcltee::Teegif;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegifHPP
