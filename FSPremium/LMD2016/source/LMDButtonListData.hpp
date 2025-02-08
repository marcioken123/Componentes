// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonListData.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonlistdataHPP
#define LmdbuttonlistdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonlistdata
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonListData;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDButtonListMode : unsigned char { blCheckBox, blCheckBox3State, blRadioButton };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonListData : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::TObject* FData;
	Vcl::Stdctrls::TCheckBoxState FState;
	bool FDisabled;
	void __fastcall SetChecked(bool Check);
	bool __fastcall GetChecked(void);
	
public:
	__classmethod Vcl::Stdctrls::TCheckBoxState __fastcall GetDefaultState();
	__property System::TObject* Data = {read=FData, write=FData};
	__property bool Checked = {read=GetChecked, write=SetChecked, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=FState, nodefault};
	__property bool Disabled = {read=FDisabled, write=FDisabled, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDButtonListData(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDButtonListData(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TObject* __fastcall LMDBtnMakeSaveState(Vcl::Stdctrls::TCheckBoxState State, bool Disabled);
extern DELPHI_PACKAGE Vcl::Stdctrls::TCheckBoxState __fastcall LMDBtnGetSaveState(System::TObject* aObject);
extern DELPHI_PACKAGE bool __fastcall LMDBtnGetSaveDisabled(System::TObject* aObject);
extern DELPHI_PACKAGE void __fastcall LMDDrawButtonListItem(Vcl::Controls::TWinControl* Control, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &r, Vcl::Stdctrls::TCheckBoxState aState, TLMDButtonListMode BtnMode, bool aEnabled, bool BtnFlat = false, bool BtnDefault = true, Lmdclass::TLMDThemeMode BtnXPTheme = (Lmdclass::TLMDThemeMode)(0x1));
}	/* namespace Lmdbuttonlistdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONLISTDATA)
using namespace Lmdbuttonlistdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonlistdataHPP
