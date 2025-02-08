// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctBatchFrame.pas' rev: 31.00 (Windows)

#ifndef LmdsctbatchframeHPP
#define LmdsctbatchframeHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDXML.hpp>
#include <LMDSctDialects.hpp>
#include <LMDSctImporterFileUtils.hpp>
#include <LMDSctImporterTree.hpp>
#include <LMDSctImporterUnitDoc.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctbatchframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUnitDocNotifier;
class DELPHICLASS TUnitItem;
__interface ILMDBatchFrameTraits;
typedef System::DelphiInterface<ILMDBatchFrameTraits> _di_ILMDBatchFrameTraits;
class DELPHICLASS TLMDBatchFrame;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitDocNotifier : public Lmdsctimporterunitdoc::ILMDUnitDocNotifier
{
	typedef Lmdsctimporterunitdoc::ILMDUnitDocNotifier inherited;
	
private:
	TLMDBatchFrame* FFrame;
	
public:
	__fastcall TLMDUnitDocNotifier(TLMDBatchFrame* AFrame);
	virtual void __fastcall Modified(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender);
	virtual void __fastcall AnalizeProgress(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, int ADeclsCount, int AAnalizedCount);
	virtual bool __fastcall PreprocessUsedUnit(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, /* out */ System::UnicodeString &AUSUPath);
	virtual void __fastcall UsedElemReferenced(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, const System::UnicodeString AElemFullName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitDocNotifier(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TUnitItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__fastcall virtual ~TUnitItem(void);
	System::UnicodeString UnitName;
	bool Supplemental;
	bool Handled;
	Lmdsctimporterunitdoc::TLMDUnitDocument* Doc;
public:
	/* TObject.Create */ inline __fastcall TUnitItem(void) : System::TObject() { }
	
};

#pragma pack(pop)

__interface ILMDBatchFrameTraits  : public System::IInterface 
{
	virtual bool __fastcall UseExternalMessageView(void) = 0 ;
	virtual void __fastcall UnitNotFound(const System::UnicodeString AUnitName) = 0 ;
	virtual void __fastcall HintsSaved(const System::UnicodeString AFilePath) = 0 ;
	virtual void __fastcall BeginImporting(void) = 0 ;
	virtual void __fastcall BeginUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument) = 0 ;
	virtual void __fastcall EndUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument, bool ASucceded) = 0 ;
	virtual void __fastcall EndImporting(Lmdsctimporterunitdoc::TLMDUnitDocument* const *ADocuments, const int ADocuments_High, bool ASucceded) = 0 ;
};

class PASCALIMPLEMENTATION TLMDBatchFrame : public Vcl::Forms::TFrame
{
	typedef Vcl::Forms::TFrame inherited;
	
__published:
	Vcl::Extctrls::TSplitter* ErrorsSplitter;
	Vcl::Extctrls::TPanel* ErrorsPanel;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TMemo* UnitsMemo;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TCheckBox* PsreOnly;
	Vcl::Stdctrls::TCheckBox* UncheckErrors;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Comctrls::TPageControl* ErrorsPageControls;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TMemo* ErrorList;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TMemo* InfoMemo;
	Vcl::Stdctrls::TCheckBox* SaveHint;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall InfoMemoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	_di_ILMDBatchFrameTraits FTraits;
	System::Classes::TList* FUnitList;
	System::Classes::TStrings* FLibPaths;
	Lmdsctdialects::TLMDIDEDialect* FDialect;
	Lmdsctimporterunitdoc::ILMDUnitDocNotifier* FNotifier;
	bool FSucceded;
	void __fastcall SetTraits(const _di_ILMDBatchFrameTraits Value);
	void __fastcall AddMessage(const System::UnicodeString AUnitName, const System::UnicodeString AMsg);
	void __fastcall ClearUnitList(void);
	TUnitItem* __fastcall FindUnitItem(const System::UnicodeString AUnitName)/* overload */;
	TUnitItem* __fastcall FindUnitItem(Lmdsctimporterunitdoc::TLMDUnitDocument* const ADocument)/* overload */;
	System::UnicodeString __fastcall FindUnitPath(const System::UnicodeString AUnitName);
	bool __fastcall ProcessUsedUnit(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, /* out */ System::UnicodeString &AUSUPath);
	void __fastcall UsedElemReferenced(Lmdsctimporterunitdoc::TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, const System::UnicodeString AElemFullName);
	bool __fastcall ImportUnit(TUnitItem* AItem, /* out */ System::UnicodeString &AUSUPath);
	void __fastcall ReportDocMessages(TUnitItem* AItem);
	void __fastcall ProcessSupplemental(TUnitItem* AItem);
	void __fastcall Run(void);
	
public:
	__fastcall virtual TLMDBatchFrame(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBatchFrame(void);
	__property _di_ILMDBatchFrameTraits Traits = {read=FTraits, write=SetTraits};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBatchFrame(HWND ParentWindow) : Vcl::Forms::TFrame(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctbatchframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTBATCHFRAME)
using namespace Lmdsctbatchframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctbatchframeHPP
