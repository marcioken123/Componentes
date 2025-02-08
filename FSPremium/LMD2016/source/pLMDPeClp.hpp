// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPeClp.pas' rev: 31.00 (Windows)

#ifndef PlmdpeclpHPP
#define PlmdpeclpHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDObj.hpp>
#include <LMDUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpeclp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TlmdClipEditorDlg;
class DELPHICLASS Ttester;
class DELPHICLASS TLMDClipProperty;
class DELPHICLASS TLMDClipEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TlmdClipEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Load;
	Vcl::Stdctrls::TButton* Save;
	Vcl::Dialogs::TOpenDialog* FileDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Stdctrls::TButton* Clear;
	Vcl::Buttons::TBitBtn* Cancel;
	Vcl::Buttons::TBitBtn* OK;
	Vcl::Extctrls::TShape* Shape1;
	Vcl::Extctrls::TShape* Shape2;
	Vcl::Stdctrls::TButton* test;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* breite;
	Vcl::Stdctrls::TLabel* hoehe;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TComboBox* rows;
	Vcl::Stdctrls::TComboBox* cols;
	Vcl::Stdctrls::TButton* lbitmap;
	Vcl::Stdctrls::TButton* sbitmap;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall ClearClick(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall testClick(System::TObject* Sender);
	void __fastcall SavePClick(System::TObject* Sender);
	void __fastcall LoadPClick(System::TObject* Sender);
	
private:
	Lmdobj::TLMDClip* FClip;
	void __fastcall SetClip(Lmdobj::TLMDClip* aValue);
	
public:
	void __fastcall SetLabels(void);
	__property Lmdobj::TLMDClip* Clip = {read=FClip, write=SetClip};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TlmdClipEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TlmdClipEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TlmdClipEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TlmdClipEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION Ttester : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OK;
	Vcl::Extctrls::TImage* pic;
	Vcl::Stdctrls::TButton* spul;
	Vcl::Stdctrls::TButton* spul1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* pos;
	Vcl::Extctrls::TBevel* Bevel1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall spulClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Lmdobj::TLMDClip* FClip;
	bool FShow;
	System::Word FPos;
	System::Word FAll;
	void __fastcall CheckPos(void);
	void __fastcall SetClip(Lmdobj::TLMDClip* aValue);
	
public:
	__property Lmdobj::TLMDClip* TestClip = {read=FClip, write=SetClip};
public:
	/* TCustomForm.Create */ inline __fastcall virtual Ttester(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual Ttester(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~Ttester(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall Ttester(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDClipProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDClipProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDClipProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDClipEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDClipEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDClipEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdpeclp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPECLP)
using namespace Plmdpeclp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpeclpHPP
