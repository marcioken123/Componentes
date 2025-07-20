// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVideoPlayer.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeevideoplayerHPP
#define Vcltee_TeevideoplayerHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeVideo.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevideoplayer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVideoPlayerTool;
class DELPHICLASS TVideoPlayerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVideoPlayerTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	System::UnicodeString FFileName;
	Vcltee::Tecanvas::TFilterItems* FFilters;
	bool FLoop;
	System::Classes::TNotifyEvent FOnFrame;
	Vcl::Graphics::TPicture* FPicture;
	Vcl::Graphics::TBitmap* IBitmap;
	int ICount;
	bool IPaused;
	bool IPlaying;
	Vcl::Extctrls::TTimer* ITimer;
	int IEndFrame;
	Vcltee::Teevideo::IGetFrame* *IGetFrame;
	void *IStream;
	void *IFile;
	void __fastcall Finish();
	int __fastcall GetEnd();
	int __fastcall GetStart();
	void __fastcall Open();
	void __fastcall TimerEvent(System::TObject* Sender);
	int __fastcall GetDelay();
	void __fastcall SetDelay(const int Value);
	void __fastcall SetFilters(Vcltee::Tecanvas::TFilterItems* const Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	Vcl::Graphics::TBitmap* __fastcall GetFrame(int FrameNumber)/* overload */;
	void __fastcall GetFrame(int FrameNumber, Vcl::Graphics::TBitmap* &b)/* overload */;
	virtual void __fastcall SetActive(bool Value);
	
public:
	__fastcall virtual TVideoPlayerTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TVideoPlayerTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Pause();
	void __fastcall Play();
	void __fastcall Stop();
	__property bool Paused = {read=IPaused, nodefault};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Playing = {read=IPlaying, nodefault};
	__property int Position = {read=ICount, write=ICount, nodefault};
	__property int StartFrame = {read=GetStart, nodefault};
	__property int EndFrame = {read=GetEnd, nodefault};
	
__published:
	__property int Delay = {read=GetDelay, write=SetDelay, default=1};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property Vcltee::Tecanvas::TFilterItems* Filters = {read=FFilters, write=SetFilters, stored=false};
	__property bool Loop = {read=FLoop, write=FLoop, default=0};
	__property System::Classes::TNotifyEvent OnFrame = {read=FOnFrame, write=FOnFrame};
};


class PASCALIMPLEMENTATION TVideoPlayerEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EName;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TButton* BPlay;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EDelay;
	Vcl::Comctrls::TUpDown* UDDelay;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TLabel* LFrame;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TRadioButton* RBBack;
	Vcl::Stdctrls::TRadioButton* RBOther;
	Vcltee::Tecanvas::TComboFlat* CBDisplay;
	Vcltee::Tecanvas::TComboFlat* CBItem;
	void __fastcall BPlayClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBLoopClick(System::TObject* Sender);
	void __fastcall EDelayChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ENameChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall RBOtherClick(System::TObject* Sender);
	void __fastcall RBBackClick(System::TObject* Sender);
	void __fastcall CBDisplayChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBItemChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	System::Classes::TNotifyEvent OldOnFrame;
	TVideoPlayerTool* Player;
	int VideoSize;
	void __fastcall PlayerFrame(System::TObject* Sender);
	void __fastcall SetupPlay();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVideoPlayerEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVideoPlayerEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVideoPlayerEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVideoPlayerEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teevideoplayer */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVIDEOPLAYER)
using namespace Vcltee::Teevideoplayer;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeevideoplayerHPP
