// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPeAcp.pas' rev: 31.00 (Windows)

#ifndef PlmdpeacpHPP
#define PlmdpeacpHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Tabs.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <LMDConst.hpp>
#include <LMDClass.hpp>
#include <pLMDPeClp.hpp>
#include <LMDObj.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpeacp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAniClipEditorDlg;
class DELPHICLASS TLMDAniClipProperty;
class DELPHICLASS TLMDAniClipEditor;
class DELPHICLASS TLMDAniEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAniClipEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* Cancel;
	Vcl::Buttons::TBitBtn* OK;
	Vcl::Extctrls::TNotebook* book;
	Vcl::Tabs::TTabSet* tab;
	Vcl::Stdctrls::TButton* bt2;
	Vcl::Forms::TScrollBox* ScrollBox1;
	Vcl::Extctrls::TImage* img;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* name;
	Vcl::Stdctrls::TEdit* index;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* start;
	Vcl::Stdctrls::TLabel* ende;
	Vcl::Stdctrls::TButton* bt;
	Vcl::Stdctrls::TButton* bt1;
	Vcl::Extctrls::THeader* header;
	Vcl::Stdctrls::TListBox* lb;
	Vcl::Stdctrls::TButton* bt3;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Dialogs::TOpenDialog* FileDialog;
	Vcl::Stdctrls::TButton* Load;
	Vcl::Stdctrls::TButton* Save;
	Vcl::Stdctrls::TButton* loadclip;
	Vcl::Stdctrls::TButton* clear;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* breite;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* hoehe;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* row;
	Vcl::Stdctrls::TLabel* cols;
	Vcl::Stdctrls::TLabel* info;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall tabChange(System::TObject* Sender, int NewTab, bool &AllowChange);
	void __fastcall imgMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall btClick(System::TObject* Sender);
	void __fastcall headerSized(System::TObject* Sender, int ASection, int AWidth);
	void __fastcall lbDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall OKClick(System::TObject* Sender);
	void __fastcall loadclipClick(System::TObject* Sender);
	void __fastcall clearClick(System::TObject* Sender);
	void __fastcall imgMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall bookMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	
private:
	Lmdobj::TLMDAniClip* FAniClip;
	System::Classes::TStringList* FS;
	bool FShow;
	System::Word Cell;
	void __fastcall SetAniClip(Lmdobj::TLMDAniClip* aValue);
	void __fastcall FillLB(void);
	void __fastcall FillList(void);
	
public:
	void __fastcall SetLabels(void);
	__property Lmdobj::TLMDAniClip* AniClip = {read=FAniClip, write=SetAniClip};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDAniClipEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAniClipEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDAniClipEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAniClipEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAniClipProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDAniClipProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDAniClipProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAniClipEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDAniClipEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDAniClipEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAniEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDAniEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDAniEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdpeacp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPEACP)
using namespace Plmdpeacp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpeacpHPP
