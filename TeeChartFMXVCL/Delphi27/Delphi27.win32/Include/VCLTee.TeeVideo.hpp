// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVideo.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeevideoHPP
#define Vcltee_TeevideoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeProCo.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevideo
{
//-- forward type declarations -----------------------------------------------
struct TAviStreamInfoA;
struct TAVICompressOptions;
class DELPHICLASS TVideoTool;
class DELPHICLASS TVideoToolEditor;
struct TAVIFILEINFOA;
class DELPHICLASS IGetFrame;
//-- type declarations -------------------------------------------------------
typedef void * PAVIFile;

typedef void * PAVIStream;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TAviStreamInfoA
{
public:
	unsigned fccType;
	unsigned fccHandler;
	unsigned dwFlags;
	unsigned dwCaps;
	System::Word wPriority;
	System::Word wLanguage;
	unsigned dwScale;
	unsigned dwRate;
	unsigned dwStart;
	unsigned dwLength;
	unsigned dwInitialFrames;
	unsigned dwSuggestedBufferSize;
	unsigned dwQuality;
	unsigned dwSampleSize;
	System::Types::TRect rcFrame;
	unsigned dwEditCount;
	unsigned dwFormatChangeCount;
	System::StaticArray<char, 64> szName;
};
#pragma pack(pop)


typedef TAVICompressOptions *PAVICompressOptions;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TAVICompressOptions
{
public:
	unsigned fccType;
	unsigned fccHandler;
	unsigned dwKeyFrameEvery;
	unsigned dwQuality;
	unsigned dwBytesPerSecond;
	unsigned dwFlags;
	void *lpFormat;
	unsigned cbFormat;
	void *lpParms;
	unsigned cbParms;
	unsigned dwInterleaveEvery;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TVideoTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	int FCount;
	int FDuration;
	System::UnicodeString FFileName;
	System::UnicodeString FFourCC;
	System::Classes::TNotifyEvent FOnNewFrame;
	System::Classes::TNotifyEvent FOnStart;
	System::Classes::TNotifyEvent FOnStop;
	int FQuality;
	bool FRecording;
	void *IFile;
	TAviStreamInfoA IStream;
	void *IPStream;
	void *ICompStream;
	tagBITMAPINFO *IPInInfo;
	TAVICompressOptions AviCompressoptions;
	void __fastcall AddFrame(Vcl::Graphics::TBitmap* Bitmap);
	void __fastcall Clean();
	void __fastcall CreateStream();
	void __fastcall InitStreamFormat(Vcl::Graphics::TBitmap* Bitmap);
	void __fastcall PrepareBitmapHeader(tagBITMAPINFOHEADER &Header);
	void __fastcall SetCompression(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TVideoTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TVideoTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall GetCompressors(System::Classes::TStrings* const List);
	void __fastcall ShowCompressorOptions(Vcl::Controls::TWinControl* Parent);
	void __fastcall StartRecording(const System::UnicodeString FileName);
	void __fastcall StopRecording();
	__property int FrameCount = {read=FCount, nodefault};
	__property bool IsRecording = {read=FRecording, nodefault};
	
__published:
	__property System::UnicodeString Compression = {read=FFourCC, write=SetCompression};
	__property int CompressionQuality = {read=FQuality, write=FQuality, default=8000};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property int FrameDuration = {read=FDuration, write=FDuration, default=50};
	__property System::Classes::TNotifyEvent OnNewFrame = {read=FOnNewFrame, write=FOnNewFrame};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnStart, write=FOnStart};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
};


class PASCALIMPLEMENTATION TVideoToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TScrollBar* SBMsec;
	Vcltee::Tecanvas::TComboFlat* CBCompress;
	Vcltee::Tecanvas::TComboFlat* CBQuality;
	Vcl::Stdctrls::TButton* BEdit;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* BStart;
	Vcl::Stdctrls::TButton* BStop;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* EFile;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TLabel* LFrameCap;
	Vcl::Stdctrls::TLabel* LFrame;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBMsecChange(System::TObject* Sender);
	void __fastcall BStartClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall EFileChange(System::TObject* Sender);
	void __fastcall BStopClick(System::TObject* Sender);
	void __fastcall CBQualityChange(System::TObject* Sender);
	void __fastcall CBCompressChange(System::TObject* Sender);
	void __fastcall BEditClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	bool CompressFilled;
	TVideoTool* Video;
	System::Classes::TNotifyEvent OldNewFrame;
	void __fastcall SetLabelFrame();
	void __fastcall SetupProgress();
	void __fastcall VideoNewFrame(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVideoToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVideoToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVideoToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVideoToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef TAVIFILEINFOA *PAVIFILEINFOA;

struct DECLSPEC_DRECORD TAVIFILEINFOA
{
public:
	unsigned dwMaxBytesPerSec;
	unsigned dwFlags;
	unsigned dwCaps;
	unsigned dwStreams;
	unsigned dwSuggestedBufferSize;
	unsigned dwWidth;
	unsigned dwHeight;
	unsigned dwScale;
	unsigned dwRate;
	unsigned dwLength;
	unsigned dwEditCount;
	System::StaticArray<char, 64> szFileType;
};


typedef void * PVOID;

typedef IGetFrame* *PGetFrame;

#pragma pack(push,1)
class PASCALIMPLEMENTATION IGetFrame : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void * __stdcall GetFrame(unsigned lPos) = 0 ;
	virtual HRESULT __stdcall _Begin(unsigned lStart, unsigned lEnd, unsigned lRate) = 0 ;
	virtual HRESULT __stdcall _End() = 0 ;
	virtual HRESULT __stdcall SetFormat(Winapi::Windows::PBitmapInfoHeader lpbi, void * lpBits, int x, int y, int dx, int dy) = 0 ;
public:
	/* TObject.Create */ inline __fastcall IGetFrame() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~IGetFrame() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 AVIERR_OK = System::Int8(0x0);
static const unsigned AVIERR_UNSUPPORTED = unsigned(0x80044065);
static const unsigned AVIERR_BADFORMAT = unsigned(0x80044066);
static const unsigned AVIERR_MEMORY = unsigned(0x80044067);
static const unsigned AVIERR_INTERNAL = unsigned(0x80044068);
static const unsigned AVIERR_BADFLAGS = unsigned(0x80044069);
static const unsigned AVIERR_BADPARAM = unsigned(0x8004406a);
static const unsigned AVIERR_BADSIZE = unsigned(0x8004406b);
static const unsigned AVIERR_BADHANDLE = unsigned(0x8004406c);
static const unsigned AVIERR_FILEREAD = unsigned(0x8004406d);
static const unsigned AVIERR_FILEWRITE = unsigned(0x8004406e);
static const unsigned AVIERR_FILEOPEN = unsigned(0x8004406f);
static const unsigned AVIERR_COMPRESSOR = unsigned(0x80044070);
static const unsigned AVIERR_NOCOMPRESSOR = unsigned(0x80044071);
static const unsigned AVIERR_READONLY = unsigned(0x80044072);
static const unsigned AVIERR_NODATA = unsigned(0x80044073);
static const unsigned AVIERR_BUFFERTOOSMALL = unsigned(0x80044074);
static const unsigned AVIERR_CANTCOMPRESS = unsigned(0x80044075);
static const unsigned AVIERR_USERABORT = unsigned(0x800440c6);
static const unsigned AVIERR_ERROR = unsigned(0x800440c7);
static const int StreamTypeVIDEO = int(0x73646976);
static const int StreamTypeAUDIO = int(0x73647561);
static const int StreamTypeIAVS = int(0x73766169);
extern DELPHI_PACKAGE void __stdcall (*AVIFileExit)(void);
extern DELPHI_PACKAGE HRESULT __stdcall (*AVIFileGetStream)(void * pfile, void * &ppavi, unsigned fccType, unsigned lParam);
extern DELPHI_PACKAGE void __stdcall (*AVIFileInit)(void);
extern DELPHI_PACKAGE HRESULT __stdcall (*AVIFileOpen)(void * &ppfile, System::WideChar * szFile, unsigned uMode, void * lpHandler);
extern DELPHI_PACKAGE unsigned __stdcall (*AVIFileRelease)(void * pfile);
extern DELPHI_PACKAGE HRESULT __stdcall (*AVIFileInfo)(void * pfile, PAVIFILEINFOA pfi, unsigned lSize);
extern DELPHI_PACKAGE HRESULT __stdcall (*AVIStreamOpenFromFile)(void * &ppavi, System::WideChar * szFile, unsigned fccType, unsigned lParam, unsigned mode, System::PGUID pclsidHandler);
extern DELPHI_PACKAGE void * __stdcall (*AVIStreamGetFrame)(PGetFrame pg, unsigned lPos);
extern DELPHI_PACKAGE HRESULT __stdcall (*AVIStreamGetFrameClose)(PGetFrame pg);
extern DELPHI_PACKAGE PGetFrame __stdcall (*AVIStreamGetFrameOpen)(void * pavi, Winapi::Windows::PBitmapInfoHeader lpbiWanted);
extern DELPHI_PACKAGE unsigned __stdcall (*AVIStreamLength)(void * pavi);
extern DELPHI_PACKAGE unsigned __stdcall (*AVIStreamRelease)(void * pavi);
extern DELPHI_PACKAGE unsigned __stdcall (*AVIStreamStart)(void * pavi);
extern DELPHI_PACKAGE unsigned __stdcall (*AVIStreamInfo)(void * pavi, TAviStreamInfoA &psi, unsigned lSize);
extern DELPHI_PACKAGE void __fastcall AviCheck(const HRESULT ErrorCode);
extern DELPHI_PACKAGE bool __fastcall InitVideoForWindows(void);
}	/* namespace Teevideo */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVIDEO)
using namespace Vcltee::Teevideo;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeevideoHPP
