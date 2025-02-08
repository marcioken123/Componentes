// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDVldRegExpEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdvldregexpeditorHPP
#define PlmdvldregexpeditorHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Grids.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdvldregexpeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRegExprForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRegExprForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* edRegExpr;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Grids::TStringGrid* sgExpressions;
	Vcl::Stdctrls::TButton* btAddExpr;
	Vcl::Stdctrls::TButton* btRemove;
	Vcl::Stdctrls::TButton* btLoadFile;
	Vcl::Stdctrls::TButton* btSaveFile;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* edExprName;
	Vcl::Stdctrls::TButton* btUpdateExpr;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btAddExprClick(System::TObject* Sender);
	void __fastcall btRemoveClick(System::TObject* Sender);
	void __fastcall sgExpressionsClick(System::TObject* Sender);
	void __fastcall btLoadFileClick(System::TObject* Sender);
	void __fastcall btSaveFileClick(System::TObject* Sender);
	void __fastcall sgExpressionsDblClick(System::TObject* Sender);
	void __fastcall sgExpressionsSetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall btUpdateExprClick(System::TObject* Sender);
	
protected:
	System::UnicodeString FSelectedExpr;
	void __fastcall LoadRegExprFile(System::UnicodeString FileName);
	void __fastcall SaveRegExprFile(System::UnicodeString FileName);
	
public:
	System::UnicodeString __fastcall EditExpression(System::UnicodeString CurExpr);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRegExprForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRegExprForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRegExprForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRegExprForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDRegExprForm* LMDRegExprForm;
}	/* namespace Plmdvldregexpeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDVLDREGEXPEDITOR)
using namespace Plmdvldregexpeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdvldregexpeditorHPP
