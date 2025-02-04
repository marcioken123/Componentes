// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acRootEdit.pas' rev: 27.00 (Windows)

#ifndef AcrooteditHPP
#define AcrooteditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <acShellCtrls.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <VCLEditors.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sDialogs.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <sRadioButton.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <sGroupBox.hpp>	// Pascal unit
#include <sButton.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <sMaskEdit.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <sToolEdit.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acrootedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TacRootPathEditDlg;
class PASCALIMPLEMENTATION TacRootPathEditDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sbitbtn::TsBitBtn* Button1;
	Sbitbtn::TsBitBtn* Button2;
	Sradiobutton::TsRadioButton* rbUseFolder;
	Sgroupbox::TsGroupBox* GroupBox1;
	Scombobox::TsComboBox* cbFolderType;
	Sgroupbox::TsGroupBox* GroupBox2;
	Sdialogs::TsOpenDialog* OpenDialog1;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sradiobutton::TsRadioButton* rbUsePath;
	Stooledit::TsDirectoryEdit* ePath;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall rbUseFolderClick(System::TObject* Sender);
	void __fastcall rbUsePathClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	void __fastcall UpdateState(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TacRootPathEditDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TacRootPathEditDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TacRootPathEditDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TacRootPathEditDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TacRootProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacRootProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TacRootProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TacRootProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacRootEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacRootEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TacRootEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TacRootEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acrootedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACROOTEDIT)
using namespace Acrootedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcrooteditHPP
