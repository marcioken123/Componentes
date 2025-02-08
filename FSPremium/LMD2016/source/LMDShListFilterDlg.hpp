// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShListFilterDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshlistfilterdlgHPP
#define LmdshlistfilterdlgHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDShBase.hpp>
#include <LMDShList.hpp>
#include <LMDShConsts.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshlistfilterdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmShellListFilterDialog;
class DELPHICLASS TLMDShellListFilterDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmShellListFilterDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TComboBox* hcb;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TRadioGroup* rg;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmShellListFilterDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmShellListFilterDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmShellListFilterDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmShellListFilterDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDShellListFilterDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	bool FAuto;
	bool Fon;
	bool FDirs;
	System::UnicodeString FFilter;
	System::UnicodeString FCaption;
	System::UnicodeString FInstructionText;
	Lmdshlist::TLMDShellList* FShellList;
	System::Classes::TStringList* FHistory;
	int FCount;
	void __fastcall SetShellList(Lmdshlist::TLMDShellList* aValue);
	void __fastcall SetHistoryList(System::Classes::TStringList* aValue);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDShellListFilterDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellListFilterDialog(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property bool FilterActive = {read=Fon, write=Fon, nodefault};
	__property bool FilterDirs = {read=FDirs, write=FDirs, nodefault};
	
__published:
	__property bool AutoEnabled = {read=FAuto, write=FAuto, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString InstructionText = {read=FInstructionText, write=FInstructionText};
	__property Lmdshlist::TLMDShellList* ShellList = {read=FShellList, write=SetShellList};
	__property System::Classes::TStringList* HistoryList = {read=FHistory, write=SetHistoryList};
	__property int HistoryCount = {read=FCount, write=FCount, default=10};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshlistfilterdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHLISTFILTERDLG)
using namespace Lmdshlistfilterdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshlistfilterdlgHPP
