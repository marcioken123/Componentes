// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeVideoBlock.pas' rev: 34.00 (Windows)

#ifndef TeevideoblockHPP
#define TeevideoblockHPP

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
#include <Vcl.Buttons.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeVideo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teevideoblock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVideoAnimation;
class DELPHICLASS TVideoEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVideoAnimation : public Vcltee::Teeanimate::TPropertyAnimation
{
	typedef Vcltee::Teeanimate::TPropertyAnimation inherited;
	
private:
	System::UnicodeString FFileName;
	Vcltee::Tecanvas::TFilterItems* FFilters;
	int IEndFrame;
	Vcltee::Teevideo::IGetFrame* *IGetFrame;
	void *IStream;
	int IPrevFrame;
	void __fastcall Finish();
	int __fastcall GetEnd();
	int __fastcall GetStart();
	void __fastcall Open();
	
protected:
	void __fastcall GetFrame(int FrameNumber, Vcl::Graphics::TBitmap* &b)/* overload */;
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TVideoAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TVideoAnimation();
	DYNAMIC bool __fastcall IsEnabled();
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall Stop();
	Vcl::Graphics::TPicture* __fastcall Picture();
	Vcltee::Tecanvas::TFilterItems* __fastcall Filters();
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property PropertyName = {default=0};
};


class PASCALIMPLEMENTATION TVideoEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TEdit* EName;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	void __fastcall ENameChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	TVideoAnimation* Player;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVideoEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVideoEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVideoEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVideoEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teevideoblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEVIDEOBLOCK)
using namespace Teevideoblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeevideoblockHPP
