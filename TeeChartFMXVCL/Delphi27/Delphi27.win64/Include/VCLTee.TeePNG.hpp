// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePNG.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepngHPP
#define Vcltee_TeepngHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepng
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeePNGOptions;
class DELPHICLASS TPNGExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeePNGOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UpDown1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	
private:
	TPNGExportFormat* IFormat;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeePNGOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeePNGOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeePNGOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeePNGOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TPNGExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	int FCompression;
	Vcl::Graphics::TPixelFormat FPixel;
	void __fastcall CheckProperties();
	void __fastcall SetCompression(const int Value);
	
protected:
	TTeePNGOptions* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	__fastcall virtual TPNGExportFormat();
	Vcl::Graphics::TBitmap* __fastcall Bitmap();
	__property int Compression = {read=FCompression, write=SetCompression, nodefault};
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	static Vcl::Graphics::TGraphic* __fastcall LoadFromFile(const System::UnicodeString AFileName);
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	__property Vcl::Graphics::TPixelFormat PixelFormat = {read=FPixel, write=FPixel, nodefault};
	virtual void __fastcall SaveToStream(System::Classes::TStream* AStream)/* overload */;
	void __fastcall SaveToStreamCompression(System::Classes::TStream* AStream, int CompressionLevel);
public:
	/* TTeeExportFormat.Destroy */ inline __fastcall virtual ~TPNGExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToPNG(Vcltee::Teeprocs::TCustomTeePanel* APanel, const System::WideString AFileName, int AWidth = 0x0, int AHeight = 0x0);
}	/* namespace Teepng */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPNG)
using namespace Vcltee::Teepng;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepngHPP
