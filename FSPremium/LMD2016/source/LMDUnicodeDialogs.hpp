// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUnicodeDialogs.pas' rev: 31.00 (Windows)

#ifndef LmdunicodedialogsHPP
#define LmdunicodedialogsHPP

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
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.CommDlg.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Math.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdunicodedialogs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOpenDialog;
class DELPHICLASS TLMDSaveDialog;
class DELPHICLASS TLMDOpenPictureDialog;
class DELPHICLASS TLMDSavePictureDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDOpenDialog : public Vcl::Dialogs::TOpenDialog
{
	typedef Vcl::Dialogs::TOpenDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	
private:
	Lmdtypes::TLMDString FDefaultExt;
	Lmdtypes::TLMDString FFileName;
	Lmdtypes::TLMDString FFilter;
	Lmdtypes::TLMDString FInitialDir;
	Lmdtypes::TLMDString FTitle;
	System::Classes::TStringList* FFiles;
	void __fastcall SetDefaultExt(const Lmdtypes::TLMDString Value);
	HIDESBASE System::Classes::TStrings* __fastcall GetFiles(void);
	HIDESBASE void __fastcall SetFileName(const Lmdtypes::TLMDString Value);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetFileName(void);
	void __fastcall SetFilter(const Lmdtypes::TLMDString Value);
	HIDESBASE void __fastcall SetInitialDir(const Lmdtypes::TLMDString Value);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	
protected:
	tagOFNA FHackOpenFileName;
	bool __fastcall CanCloseUnicode(tagOFNW &OpenFileName);
	void __fastcall GetFileNamesUnicode(tagOFNW &OpenFileName);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall DoExecuteUnicode(void * AFunc, HWND AParentWnd)/* overload */;
	bool __fastcall DoExecuteUnicode(void * AFunc)/* overload */;
	
public:
	__fastcall virtual TLMDOpenDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDOpenDialog(void);
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall Execute(void)/* overload */;
	__property System::Classes::TStrings* Files = {read=GetFiles};
	
__published:
	__property Lmdtypes::TLMDString DefaultExt = {read=FDefaultExt, write=SetDefaultExt};
	__property Lmdtypes::TLMDString FileName = {read=GetFileName, write=SetFileName};
	__property Lmdtypes::TLMDString Filter = {read=FFilter, write=SetFilter};
	__property Lmdtypes::TLMDString InitialDir = {read=FInitialDir, write=SetInitialDir};
	__property Lmdtypes::TLMDString Title = {read=FTitle, write=SetTitle};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDSaveDialog : public TLMDOpenDialog
{
	typedef TLMDOpenDialog inherited;
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall Execute(void)/* overload */;
public:
	/* TLMDOpenDialog.Create */ inline __fastcall virtual TLMDSaveDialog(System::Classes::TComponent* AOwner) : TLMDOpenDialog(AOwner) { }
	/* TLMDOpenDialog.Destroy */ inline __fastcall virtual ~TLMDSaveDialog(void) { }
	
};


typedef void __fastcall (__closure *TLMDPictureLoadEvent)(System::TObject* Sender, Vcl::Graphics::TPicture* Picture, const System::UnicodeString FileName);

class PASCALIMPLEMENTATION TLMDOpenPictureDialog : public TLMDOpenDialog
{
	typedef TLMDOpenDialog inherited;
	
private:
	Vcl::Extctrls::TPanel* FPreviewPanel;
	Vcl::Extctrls::TPanel* FPaintPane;
	Vcl::Buttons::TSpeedButton* FPreviewButton;
	Vcl::Extctrls::TImage* FImage;
	Vcl::Stdctrls::TLabel* FSizeLabel;
	Vcl::Forms::TForm* FPreviewForm;
	Vcl::Extctrls::TImage* FPopupImage;
	Vcl::Extctrls::TPanel* FPopupPanel;
	TLMDPictureLoadEvent FOnPictureLoad;
	
protected:
	DYNAMIC void __fastcall DoSelectionChange(void);
	DYNAMIC void __fastcall DoShow(void);
	void __fastcall DoPreviewClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDOpenPictureDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall Execute(void)/* overload */;
	
__published:
	__property TLMDPictureLoadEvent OnCustomPictureLoad = {read=FOnPictureLoad, write=FOnPictureLoad};
public:
	/* TLMDOpenDialog.Destroy */ inline __fastcall virtual ~TLMDOpenPictureDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSavePictureDialog : public TLMDOpenPictureDialog
{
	typedef TLMDOpenPictureDialog inherited;
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall Execute(void)/* overload */;
public:
	/* TLMDOpenPictureDialog.Create */ inline __fastcall virtual TLMDSavePictureDialog(System::Classes::TComponent* AOwner) : TLMDOpenPictureDialog(AOwner) { }
	
public:
	/* TLMDOpenDialog.Destroy */ inline __fastcall virtual ~TLMDSavePictureDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdunicodedialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUNICODEDIALOGS)
using namespace Lmdunicodedialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdunicodedialogsHPP
