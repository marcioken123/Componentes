// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctFloatingView.pas' rev: 31.00 (Windows)

#ifndef LmdsctfloatingviewHPP
#define LmdsctfloatingviewHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <ToolsAPI.hpp>
#include <LMDSctImporterUnitDoc.hpp>
#include <LMDSctUnitFrame.hpp>
#include <LMDSctBatchFrame.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctfloatingview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUnitViewTraits;
class DELPHICLASS TLMDUnitFloatingView;
class DELPHICLASS TLMDBatchTraits;
class DELPHICLASS TLMDBatchFloatingView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDUnitViewTraits : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Forms::TForm* FForm;
	Lmdsctunitframe::TLMDUnitFrame* FContent;
	void __fastcall SetContent(Lmdsctunitframe::TLMDUnitFrame* const Value);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall UpdateCaption(void);
	void __fastcall OpenUsedUnit(const System::UnicodeString AUnitName);
	bool __fastcall UseExternalMessageView(void);
	void __fastcall BeginImporting(void);
	void __fastcall ImportingProgress(int AProgress);
	void __fastcall EndImporting(bool ASucceded);
	
public:
	__fastcall TLMDUnitViewTraits(Vcl::Forms::TForm* AForm);
	__fastcall virtual ~TLMDUnitViewTraits(void);
	__property Lmdsctunitframe::TLMDUnitFrame* Content = {read=FContent, write=SetContent};
private:
	void *__ILMDUnitFrameTraits;	// Lmdsctunitframe::ILMDUnitFrameTraits 
	
public:
	operator Lmdsctunitframe::ILMDUnitFrameTraits*(void) { return (Lmdsctunitframe::ILMDUnitFrameTraits*)&__ILMDUnitFrameTraits; }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitFloatingView : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod Vcl::Forms::TForm* __fastcall GetView(Lmdsctunitframe::TLMDUnitFrame* AContent);
	__classmethod void __fastcall Finalize();
public:
	/* TObject.Create */ inline __fastcall TLMDUnitFloatingView(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitFloatingView(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDBatchTraits : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Forms::TForm* FForm;
	Lmdsctbatchframe::TLMDBatchFrame* FContent;
	void __fastcall SetContent(Lmdsctbatchframe::TLMDBatchFrame* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall UseExternalMessageView(void);
	void __fastcall BeginImporting(void);
	void __fastcall UnitNotFound(const System::UnicodeString AUnitName);
	void __fastcall HintsSaved(const System::UnicodeString AFilePath);
	void __fastcall BeginUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	void __fastcall EndUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument, bool ASucceded);
	void __fastcall EndImporting(Lmdsctimporterunitdoc::TLMDUnitDocument* const *ADocuments, const int ADocuments_High, bool ASucceded);
	
public:
	__fastcall TLMDBatchTraits(Vcl::Forms::TForm* AForm);
	__fastcall virtual ~TLMDBatchTraits(void);
	__property Lmdsctbatchframe::TLMDBatchFrame* Content = {read=FContent, write=SetContent};
private:
	void *__ILMDBatchFrameTraits;	// Lmdsctbatchframe::ILMDBatchFrameTraits 
	
public:
	operator Lmdsctbatchframe::ILMDBatchFrameTraits*(void) { return (Lmdsctbatchframe::ILMDBatchFrameTraits*)&__ILMDBatchFrameTraits; }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBatchFloatingView : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall Execute();
	__classmethod void __fastcall Finalize();
public:
	/* TObject.Create */ inline __fastcall TLMDBatchFloatingView(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBatchFloatingView(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctfloatingview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTFLOATINGVIEW)
using namespace Lmdsctfloatingview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctfloatingviewHPP
