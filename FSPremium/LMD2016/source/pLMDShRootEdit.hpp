// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDShRootEdit.pas' rev: 31.00 (Windows)

#ifndef PlmdshrooteditHPP
#define PlmdshrooteditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDShDlg.hpp>
#include <LMDShBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdshrootedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRootPathEditDlg;
class DELPHICLASS TLMDRootProperty;
class DELPHICLASS TLMDRootEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRootPathEditDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TRadioButton* rbUseFolder;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TComboBox* cbFolderType;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TEdit* ePath;
	Vcl::Stdctrls::TRadioButton* rbUsePath;
	Vcl::Stdctrls::TButton* btnBrowse;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall rbUseFolderClick(System::TObject* Sender);
	void __fastcall rbUsePathClick(System::TObject* Sender);
	void __fastcall btnBrowseClick(System::TObject* Sender);
	
private:
	void __fastcall UpdateState(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRootPathEditDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRootPathEditDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRootPathEditDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRootPathEditDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRootProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDRootProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDRootProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRootEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDRootEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRootEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdshrootedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSHROOTEDIT)
using namespace Plmdshrootedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdshrooteditHPP
