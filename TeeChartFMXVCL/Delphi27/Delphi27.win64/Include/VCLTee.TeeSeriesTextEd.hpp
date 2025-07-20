// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesTextEd.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriestextedHPP
#define Vcltee_TeeseriestextedHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeURL.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeSourceEdit.hpp>
#include <VCLTee.TeeStringsEditor.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriestexted
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesTextField;
class DELPHICLASS TSeriesTextFields;
class DELPHICLASS TSeriesTextSource;
class DELPHICLASS TSeriesTextEditor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSeriesTextGetValue)(TSeriesTextField* Field, const System::UnicodeString Text, double &Value);

class PASCALIMPLEMENTATION TSeriesTextField : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FFieldIndex;
	System::UnicodeString FFieldName;
	Vcltee::Teengine::TTeeFieldType FFieldType;
	TSeriesTextGetValue FOnGetValue;
	Vcltee::Teengine::TChartSeries* ISeries;
	void __fastcall SetFieldIndex(const int Value);
	
protected:
	System::TObject* Data;
	
public:
	__property Vcltee::Teengine::TTeeFieldType FieldType = {read=FFieldType, write=FFieldType, nodefault};
	
__published:
	__property int FieldIndex = {read=FFieldIndex, write=SetFieldIndex, nodefault};
	__property System::UnicodeString FieldName = {read=FFieldName, write=FFieldName};
	__property TSeriesTextGetValue OnGetValue = {read=FOnGetValue, write=FOnGetValue};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TSeriesTextField(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TSeriesTextField() { }
	
};


class PASCALIMPLEMENTATION TSeriesTextFields : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TSeriesTextField* operator[](int Index) { return this->Items[Index]; }
	
private:
	TSeriesTextField* __fastcall Get(int Index);
	void __fastcall Put(int Index, TSeriesTextField* const Value);
	
protected:
	TSeriesTextField* __fastcall AddField(int ANum, const System::UnicodeString AName, Vcltee::Teengine::TChartSeries* ASeries = (Vcltee::Teengine::TChartSeries*)(0x0));
	
public:
	__property TSeriesTextField* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TSeriesTextFields(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSeriesTextFields() { }
	
};


class PASCALIMPLEMENTATION TSeriesTextSource : public Vcltee::Teeurl::TTeeSeriesSourceFile
{
	typedef Vcltee::Teeurl::TTeeSeriesSourceFile inherited;
	
private:
	bool FAutomatic;
	System::Classes::TComponent* FDataSource;
	TSeriesTextFields* FFields;
	int FHeader;
	System::UnicodeString FSeparator;
	System::Classes::TStrings* FText;
	bool FTrim;
	void __fastcall SetAutomatic(const bool Value);
	void __fastcall SetDataSource(System::Classes::TComponent* const Value);
	void __fastcall SetFields(TSeriesTextFields* const Value);
	void __fastcall SetText(System::Classes::TStrings* const Value);
	
protected:
	bool CanCreateSeries;
	void __fastcall GuessFields(TSeriesTextFields* const AFields, System::Classes::TStrings* const AStrings, /* out */ System::UnicodeString &ASeparator);
	__classmethod int __fastcall GuessNumFields(System::UnicodeString S, /* out */ System::UnicodeString &ASeparator);
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TSeriesTextSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSeriesTextSource();
	TSeriesTextField* __fastcall AddField(const System::UnicodeString AName, int AIndex);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::Classes::TComponentClass __fastcall Editor();
	static System::TObject* __fastcall FindProperty(System::TObject* const S, const System::TClass AClass);
	virtual void __fastcall Load();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromStrings(System::Classes::TStrings* const AStrings);
	__classmethod bool __fastcall TryLocalStrToFloat(const System::UnicodeString S, /* out */ System::Extended &Value);
	
__published:
	__property Active = {default=0};
	__property bool Automatic = {read=FAutomatic, write=SetAutomatic, default=1};
	__property Chart;
	__property System::Classes::TComponent* DataSource = {read=FDataSource, write=SetDataSource};
	__property int HeaderLines = {read=FHeader, write=FHeader, default=0};
	__property TSeriesTextFields* Fields = {read=FFields, write=SetFields};
	__property System::UnicodeString FieldSeparator = {read=FSeparator, write=FSeparator};
	__property FileName = {default=0};
	__property Series;
	__property System::Classes::TStrings* Text = {read=FText, write=SetText};
	__property bool TrimSpaces = {read=FTrim, write=FTrim, default=1};
};


class PASCALIMPLEMENTATION TSeriesTextEditor : public Vcltee::Teesourceedit::TBaseSourceEditor
{
	typedef Vcltee::Teesourceedit::TBaseSourceEditor inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabFields;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Grids::TStringGrid* StringGrid1;
	Vcltee::Tecanvas::TComboFlat* CBSeries;
	Vcltee::Tecanvas::TComboFlat* CBSep;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Buttons::TSpeedButton* BBrowse;
	Vcl::Stdctrls::TRadioButton* RBFile;
	Vcl::Stdctrls::TEdit* EFile;
	Vcl::Stdctrls::TRadioButton* RBWeb;
	Vcl::Stdctrls::TEdit* EWeb;
	Vcl::Stdctrls::TButton* ButtonLoad;
	Vcl::Extctrls::TPanel* PanBot;
	Vcl::Comctrls::TTabSheet* TabText;
	Vcl::Stdctrls::TMemo* MemoText;
	Vcl::Stdctrls::TRadioButton* RBManual;
	Vcl::Stdctrls::TButton* BEditText;
	Vcl::Stdctrls::TCheckBox* CBAutoFields;
	Vcl::Stdctrls::TRadioButton* RBComponent;
	Vcltee::Tecanvas::TComboFlat* CBComponent;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ButtonLoadClick(System::TObject* Sender);
	void __fastcall RBFileClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	void __fastcall EFileChange(System::TObject* Sender);
	void __fastcall EWebChange(System::TObject* Sender);
	void __fastcall CBSepChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall StringGrid1SetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall MemoTextChange(System::TObject* Sender);
	void __fastcall RBManualClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall BEditTextClick(System::TObject* Sender);
	void __fastcall CBAutoFieldsClick(System::TObject* Sender);
	
private:
	void __fastcall FillComponents();
	void __fastcall HideSeriesCombo();
	Vcltee::Teengine::TChartSeries* __fastcall SelectedSeries();
	void __fastcall SetOptions();
	
public:
	void __fastcall RefreshSource(TSeriesTextSource* const ASource);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesTextEditor(System::Classes::TComponent* AOwner) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesTextEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesTextEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesTextEditor(HWND ParentWindow) : Vcltee::Teesourceedit::TBaseSourceEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar TeeDefaultFieldSeparator = (System::WideChar)(0x2c);
extern DELPHI_PACKAGE bool __fastcall TeeEditSeriesTextSource(TSeriesTextSource* const ASource);
}	/* namespace Teeseriestexted */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESTEXTED)
using namespace Vcltee::Teeseriestexted;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriestextedHPP
