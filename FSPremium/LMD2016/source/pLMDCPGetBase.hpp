// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCPGetBase.pas' rev: 31.00 (Windows)

#ifndef PlmdcpgetbaseHPP
#define PlmdcpgetbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDDateTime.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcpgetbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStrEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStrEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* sh;
	Vcl::Stdctrls::TMemo* str;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TEdit* lh;
	Vcl::Stdctrls::TLabel* lbh;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* cancel;
	Vcl::Stdctrls::TButton* beditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDStrEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStrEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDStrEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStrEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::StaticArray<System::UnicodeString, 2> Plmdcpgetbase__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Plmdcpgetbase__2 BoolStr;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCPGetCaption(const System::UnicodeString aValue, int aMaxLength);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetBrush(Vcl::Graphics::TBrush* aBrush);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetDateTime(Lmddatetime::TLMDDateTime* aDateTime);
extern DELPHI_PACKAGE void __fastcall LMDComLoadCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDComSaveCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetShortCut(System::Classes::TShortCut &Value);
}	/* namespace Plmdcpgetbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCPGETBASE)
using namespace Plmdcpgetbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcpgetbaseHPP
