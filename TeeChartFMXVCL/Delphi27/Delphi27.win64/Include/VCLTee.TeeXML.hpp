// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeXML.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeexmlHPP
#define Vcltee_TeexmlHPP

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
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeURL.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeSourceEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teexml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeXMLSource;
class DELPHICLASS TXMLSourceEditor;
//-- type declarations -------------------------------------------------------
typedef System::OleVariant XmlDocument;

typedef System::OleVariant XmlNode;

typedef System::OleVariant XmlNodeList;

typedef System::OleVariant XmlAttributeCollection;

class PASCALIMPLEMENTATION TTeeXMLSource : public Vcltee::Teeurl::TTeeSeriesSourceFile
{
	typedef Vcltee::Teeurl::TTeeSeriesSourceFile inherited;
	
private:
	System::UnicodeString FSeriesNode;
	System::UnicodeString FValueSource;
	System::Classes::TStrings* FXML;
	System::OleVariant FXMLDocument;
	System::OleVariant __fastcall CreateAndLoadXML();
	void __fastcall CloseXML();
	void __fastcall FillSeries(System::Classes::TStrings* AItems);
	void __fastcall LoadSeriesNode(const System::OleVariant &ANode);
	void __fastcall SetSeriesNode(const System::UnicodeString Value);
	void __fastcall SetValueSource(const System::UnicodeString Value);
	void __fastcall SetXML(System::Classes::TStrings* const Value);
	void __fastcall XMLError(const System::UnicodeString Reason);
	
protected:
	virtual void __fastcall SetActive(const bool Value);
	
public:
	__fastcall virtual TTeeXMLSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeXMLSource();
	virtual void __fastcall Close();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::Classes::TComponentClass __fastcall Editor();
	virtual void __fastcall Load();
	__property System::OleVariant XMLDoc = {read=FXMLDocument};
	
__published:
	__property Active = {default=0};
	__property Chart;
	__property FileName = {default=0};
	__property LoadMode = {default=0};
	__property Series;
	__property System::UnicodeString SeriesNode = {read=FSeriesNode, write=SetSeriesNode};
	__property System::UnicodeString ValueSource = {read=FValueSource, write=SetValueSource};
	__property System::Classes::TStrings* XML = {read=FXML, write=SetXML};
};


class PASCALIMPLEMENTATION TXMLSourceEditor : public Vcltee::Teesourceedit::TBaseSourceEditor
{
	typedef Vcltee::Teesourceedit::TBaseSourceEditor inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBSeries;
	Vcl::Stdctrls::TEdit* ESource;
	Vcl::Stdctrls::TCheckBox* CBActive;
	Vcltee::Tecanvas::TComboFlat* CBLoadMode;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TEdit* EFile;
	Vcl::Stdctrls::TRadioButton* RBFile;
	Vcl::Stdctrls::TRadioButton* RBManual;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall EFileChange(System::TObject* Sender);
	void __fastcall CBSeriesDropDown(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ESourceChange(System::TObject* Sender);
	void __fastcall CBActiveClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBLoadModeChange(System::TObject* Sender);
	void __fastcall RBManualClick(System::TObject* Sender);
	void __fastcall RBFileClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Memo1Change(System::TObject* Sender);
	void __fastcall Memo1Enter(System::TObject* Sender);
	void __fastcall EFileEnter(System::TObject* Sender);
	
private:
	void __fastcall EnableApply();
	void __fastcall FillXMLSeries();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TXMLSourceEditor(System::Classes::TComponent* AOwner) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TXMLSourceEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TXMLSourceEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TXMLSourceEditor(HWND ParentWindow) : Vcltee::Teesourceedit::TBaseSourceEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teexml */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEXML)
using namespace Vcltee::Teexml;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeexmlHPP
