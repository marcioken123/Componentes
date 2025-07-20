// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockClasses.pas' rev: 34.00 (Windows)

#ifndef TeeblockclassesHPP
#define TeeblockclassesHPP

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
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeMakerControl.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockclasses
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockChooser;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockChooser : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Stdctrls::TLabel* LabelSelected;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabBlocks;
	Vcl::Comctrls::TTabSheet* Preferences;
	Teemakercontrol::TMaker* Maker1;
	Vcl::Stdctrls::TCheckBox* RandomColors;
	Vcltee::Tecanvas::TButtonColor* BlockColor;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* ComboTextures;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TCheckBox* BlockBorders;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Maker1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Maker1DblClick(System::TObject* Sender);
	void __fastcall Maker1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Panel1DblClick(System::TObject* Sender);
	void __fastcall BOKClick(System::TObject* Sender);
	void __fastcall BCancelClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TNumberAnimation* Animation;
	void __fastcall AddBlocks(bool IsRandom, bool Borders, System::Uitypes::TColor AColor, const System::UnicodeString ATexture);
	void __fastcall ApplyConfig();
	Teeblocks::TCustomBlock* __fastcall SelectBlock(int X, int Y, bool DeselectBlock = false);
	
public:
	__classmethod Teeblocks::TBlockClass __fastcall Choose();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlockChooser(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlockChooser(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlockChooser() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlockChooser(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeblockclasses */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKCLASSES)
using namespace Teeblockclasses;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockclassesHPP
