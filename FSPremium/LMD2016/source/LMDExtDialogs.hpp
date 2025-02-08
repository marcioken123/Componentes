// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExtDialogs.pas' rev: 31.00 (Windows)

#ifndef LmdextdialogsHPP
#define LmdextdialogsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDWave.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdextdialogs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseOpenDialog;
class DELPHICLASS TLMDOpenWaveDialog;
class DELPHICLASS TLMDSaveWaveDialog;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 2> Lmdextdialogs__1;

typedef System::StaticArray<System::UnicodeString, 3> Lmdextdialogs__2;

class PASCALIMPLEMENTATION TLMDBaseOpenDialog : public Vcl::Dialogs::TOpenDialog
{
	typedef Vcl::Dialogs::TOpenDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TOpenDialog.Create */ inline __fastcall virtual TLMDBaseOpenDialog(System::Classes::TComponent* AOwner) : Vcl::Dialogs::TOpenDialog(AOwner) { }
	/* TOpenDialog.Destroy */ inline __fastcall virtual ~TLMDBaseOpenDialog(void) { }
	
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


class PASCALIMPLEMENTATION TLMDOpenWaveDialog : public TLMDBaseOpenDialog
{
	typedef TLMDBaseOpenDialog inherited;
	
private:
	Lmdwave::TLMDWave* FWave;
	Vcl::Extctrls::TPanel* FWavePanel;
	Vcl::Stdctrls::TLabel* FHeaderLabel;
	Vcl::Stdctrls::TLabel* FInfoLabel;
	Vcl::Buttons::TSpeedButton* FPlayButton;
	Vcl::Extctrls::TPanel* FInfoPanel;
	void __fastcall SetWave(Lmdwave::TLMDWave* aValue);
	bool __fastcall IsFilterStored(void);
	void __fastcall PlayClick(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall DoSelectionChange(void);
	DYNAMIC void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDOpenWaveDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDOpenWaveDialog(void);
	virtual bool __fastcall Execute(void)/* overload */;
	__property Lmdwave::TLMDWave* Wave = {read=FWave, write=SetWave};
	
__published:
	__property Filter = {stored=IsFilterStored, default=0};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TOpenDialog::Execute(ParentWnd); }
	
};


class PASCALIMPLEMENTATION TLMDSaveWaveDialog : public TLMDOpenWaveDialog
{
	typedef TLMDOpenWaveDialog inherited;
	
public:
	virtual bool __fastcall Execute(void)/* overload */;
public:
	/* TLMDOpenWaveDialog.Create */ inline __fastcall virtual TLMDSaveWaveDialog(System::Classes::TComponent* AOwner) : TLMDOpenWaveDialog(AOwner) { }
	/* TLMDOpenWaveDialog.Destroy */ inline __fastcall virtual ~TLMDSaveWaveDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TOpenDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdextdialogs__1 WaveFormats;
extern DELPHI_PACKAGE Lmdextdialogs__2 ChannelModes;
}	/* namespace Lmdextdialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXTDIALOGS)
using namespace Lmdextdialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdextdialogsHPP
