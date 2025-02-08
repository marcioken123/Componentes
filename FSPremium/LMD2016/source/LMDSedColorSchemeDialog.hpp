// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedColorSchemeDialog.pas' rev: 31.00 (Windows)

#ifndef LmdsedcolorschemedialogHPP
#define LmdsedcolorschemedialogHPP

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
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDSedView.hpp>
#include <LMDSedDocument.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDSedUtils.hpp>
#include <LMDXML.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedcolorschemedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDEditBadColorSchemeXml;
class DELPHICLASS TLMDSedColorSchemeDlg;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDEditBadColorSchemeXml : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDEditBadColorSchemeXml(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDEditBadColorSchemeXml(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditBadColorSchemeXml(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditBadColorSchemeXml(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditBadColorSchemeXml(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditBadColorSchemeXml(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDEditBadColorSchemeXml(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDEditBadColorSchemeXml(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditBadColorSchemeXml(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditBadColorSchemeXml(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditBadColorSchemeXml(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditBadColorSchemeXml(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDEditBadColorSchemeXml(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSedColorSchemeDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<Lmdseddocument::TLMDEditDocument*> _TLMDSedColorSchemeDlg__1;
	
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Lmdseddocument::TLMDEditDocument* DocHtml;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Dialogs::TColorDialog* dlgColor;
	Lmdseddocument::TLMDEditDocument* DocPascal;
	Vcl::Extctrls::TPanel* Panel10;
	Vcl::Extctrls::TPanel* Panel11;
	Vcl::Extctrls::TPanel* Panel13;
	Vcl::Extctrls::TPanel* Panel14;
	Vcl::Stdctrls::TGroupBox* gbTokens;
	Vcl::Extctrls::TPanel* Panel15;
	Vcl::Extctrls::TPanel* Panel16;
	Vcl::Extctrls::TPanel* Panel18;
	Vcl::Extctrls::TPanel* Panel19;
	Vcl::Buttons::TSpeedButton* btnMinus;
	Vcl::Buttons::TSpeedButton* btnPlus;
	Vcl::Stdctrls::TListBox* lsTokens;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Extctrls::TPanel* Panel8;
	Vcl::Stdctrls::TGroupBox* gbExample;
	Vcl::Extctrls::TPanel* Panel9;
	Vcl::Extctrls::TPanel* Panel17;
	Vcl::Extctrls::TPanel* Panel20;
	Vcl::Extctrls::TPanel* Panel22;
	Vcl::Stdctrls::TComboBox* cbExample;
	Lmdsedview::TLMDEditView* ViewExample;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* tsMainAttrs;
	Vcl::Stdctrls::TGroupBox* gbAttributes;
	Vcl::Stdctrls::TCheckBox* cbItalic;
	Vcl::Stdctrls::TCheckBox* cbBold;
	Vcl::Stdctrls::TCheckBox* cbUnderline;
	Vcl::Stdctrls::TCheckBox* cbStrikeout;
	Vcl::Stdctrls::TCheckBox* cbFontAttrsDefined;
	Vcl::Stdctrls::TGroupBox* gbColors;
	Vcl::Stdctrls::TLabel* lbBgColor;
	Vcl::Stdctrls::TLabel* lbColor;
	Vcl::Stdctrls::TComboBox* cbBgColor;
	Vcl::Stdctrls::TComboBox* cbColor;
	Vcl::Comctrls::TTabSheet* tsCustomAttrs;
	Vcl::Stdctrls::TLabel* lbCustomName;
	Vcl::Buttons::TSpeedButton* btnCustomPlus;
	Vcl::Buttons::TSpeedButton* btnCustomMinus;
	Vcl::Stdctrls::TLabel* lbCustomValue;
	Vcl::Stdctrls::TListBox* lsCustomAttrs;
	Vcl::Stdctrls::TEdit* edCustomAttrValue;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall lsTokensClick(System::TObject* Sender);
	void __fastcall cbBgColorDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall onAttrsClick(System::TObject* Sender);
	void __fastcall cbFontAttrsDefinedClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cbBgColorClick(System::TObject* Sender);
	void __fastcall cbExampleChange(System::TObject* Sender);
	void __fastcall btnMinusClick(System::TObject* Sender);
	void __fastcall btnPlusClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall btnCustomMinusClick(System::TObject* Sender);
	void __fastcall btnCustomPlusClick(System::TObject* Sender);
	void __fastcall lsCustomAttrsClick(System::TObject* Sender);
	void __fastcall edCustomAttrValueChange(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall lsTokensKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall lsCustomAttrsKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	bool FInEvent;
	bool FDocWasEmpty;
	Lmdseddocument::TLMDEditDocument* FDoc;
	Lmdxml::_di_ILMDXmlDocument FCurrentScheme;
	Lmdxml::_di_ILMDXmlNode FSchemeRoot;
	_TLMDSedColorSchemeDlg__1 FExamples;
	Lmdtypes::TLMDString FSchemeName;
	Lmdstrings::TLMDStringHashTable* FCustomAttrs;
	Lmdtypes::TLMDString __fastcall CurrentToken(void);
	void __fastcall LoadCurrentToken(void);
	void __fastcall LoadCurrentCustomAttr(void);
	void __fastcall SaveCurrentToken(void);
	void __fastcall RefreshExamples(void);
	void __fastcall UpdateStatus(void);
	Lmdtypes::TLMDString __fastcall ColorToStr(System::Uitypes::TColor AColor, bool &ACustom);
	void __fastcall FillColors(Vcl::Stdctrls::TComboBox* ACombo);
	void __fastcall CheckAndSelectColor(Vcl::Stdctrls::TComboBox* ACombo, bool ATransparent, System::Uitypes::TColor AColor);
	Lmdxml::_di_ILMDXmlNode __fastcall FindTokenNode(const Lmdtypes::TLMDString AName);
	void __fastcall RefreshTokens(void);
	void __fastcall LoadCurrentScheme(System::Classes::TStrings* ALines);
	void __fastcall SaveCurrentScheme(void);
	void __fastcall LMDSaveTokenXMLAttrs(const Lmdxml::_di_ILMDXmlNode ANode, const Lmdseddocument::TLMDEditAttributes &Attrs);
	bool __fastcall ShowDoc(Lmdseddocument::TLMDEditDocument* ADoc, const Lmdtypes::TLMDString ASchemeName);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSedColorSchemeDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSedColorSchemeDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSedColorSchemeDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSedColorSchemeDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDSedColorSchemeDlg* LMDSedColorSchemeDlg;
extern DELPHI_PACKAGE bool __fastcall LMDEditExecColorSchemesDialog(Lmdseddocument::TLMDEditDocument* ADoc, const Lmdtypes::TLMDString ASchemeName);
}	/* namespace Lmdsedcolorschemedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDCOLORSCHEMEDIALOG)
using namespace Lmdsedcolorschemedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedcolorschemedialogHPP
