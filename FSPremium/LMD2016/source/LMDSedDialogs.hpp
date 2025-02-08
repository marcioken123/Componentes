// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedDialogs.pas' rev: 31.00 (Windows)

#ifndef LmdseddialogsHPP
#define LmdseddialogsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.CommDlg.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSedDocument.hpp>
#include <LMDSedSchemeEditDialog.hpp>
#include <LMDSedFindDialog.hpp>
#include <LMDSedView.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdseddialogs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditBaseDialog;
class DELPHICLASS TLMDEditFindDialog;
class DELPHICLASS TLMDEditReplaceDialog;
class DELPHICLASS TLMDEditKeybindingsDialog;
class DELPHICLASS TLMDEditGotoLineDialog;
class DELPHICLASS TLMDEditBaseSchemeDialog;
class DELPHICLASS TLMDEditColorSchemeDialog;
class DELPHICLASS TLMDEditSyntaxSchemeDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEditBaseDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsedview::TLMDCustomEditView* FView;
	void __fastcall SetView(Lmdsedview::TLMDCustomEditView* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall CheckViewSet(void);
	
public:
	__fastcall virtual TLMDEditBaseDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditBaseDialog(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdsedview::TLMDCustomEditView* View = {read=FView, write=SetView};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDEditFindDialog : public TLMDEditBaseDialog
{
	typedef TLMDEditBaseDialog inherited;
	
protected:
	Lmdsedfinddialog::TLMDEditSearchResult FLastResult;
	Lmdsedfinddialog::TLMDEditSearchDlgOptions FOptions;
	System::Classes::TStringList* FSearch;
	Lmdseddocument::TLMDEditSearchDirection __fastcall GetDirection(void);
	Lmdseddocument::TLMDEditSearchOptions __fastcall GetOptions(void);
	System::Classes::TStrings* __fastcall GetSearches(void);
	Lmdsedview::TLMDEditViewSearchStart __fastcall GetStart(void);
	void __fastcall SetDirection(Lmdseddocument::TLMDEditSearchDirection AValue);
	void __fastcall SetOptions(Lmdseddocument::TLMDEditSearchOptions AValue);
	void __fastcall SetSearches(System::Classes::TStrings* AValue);
	void __fastcall SetStart(Lmdsedview::TLMDEditViewSearchStart AValue);
	
public:
	__fastcall virtual TLMDEditFindDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditFindDialog(void);
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall ExecuteNext(HWND ParentWnd);
	__property Lmdsedfinddialog::TLMDEditSearchResult LastResult = {read=FLastResult, nodefault};
	
__published:
	__property Lmdseddocument::TLMDEditSearchOptions Options = {read=GetOptions, write=SetOptions, default=0};
	__property Lmdseddocument::TLMDEditSearchDirection Direction = {read=GetDirection, write=SetDirection, default=0};
	__property Lmdsedview::TLMDEditViewSearchStart Start = {read=GetStart, write=SetStart, default=0};
	__property System::Classes::TStrings* Searches = {read=GetSearches, write=SetSearches};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TLMDEditReplaceDialog : public TLMDEditFindDialog
{
	typedef TLMDEditFindDialog inherited;
	
protected:
	System::Classes::TStringList* FReplaces;
	System::Classes::TStrings* __fastcall GetReplaces(void);
	void __fastcall SetReplaces(System::Classes::TStrings* AValue);
	Lmdsedview::TLMDEditViewReplaceAllBounds __fastcall GetReplaceAllBounds(void);
	void __fastcall SetReplaceAllBounds(Lmdsedview::TLMDEditViewReplaceAllBounds AValue);
	int __fastcall GetLastReplaces(void);
	
public:
	__fastcall virtual TLMDEditReplaceDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditReplaceDialog(void);
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	virtual bool __fastcall ExecuteNext(HWND ParentWnd);
	__property int LastReplacesNumber = {read=GetLastReplaces, nodefault};
	
__published:
	__property System::Classes::TStrings* Replaces = {read=GetReplaces, write=SetReplaces};
	__property Lmdsedview::TLMDEditViewReplaceAllBounds ReplaceAllBounds = {read=GetReplaceAllBounds, write=SetReplaceAllBounds, default=0};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TLMDEditKeybindingsDialog : public TLMDEditBaseDialog
{
	typedef TLMDEditBaseDialog inherited;
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
public:
	/* TLMDEditBaseDialog.Create */ inline __fastcall virtual TLMDEditKeybindingsDialog(System::Classes::TComponent* AOwner) : TLMDEditBaseDialog(AOwner) { }
	/* TLMDEditBaseDialog.Destroy */ inline __fastcall virtual ~TLMDEditKeybindingsDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TLMDEditGotoLineDialog : public TLMDEditBaseDialog
{
	typedef TLMDEditBaseDialog inherited;
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
public:
	/* TLMDEditBaseDialog.Create */ inline __fastcall virtual TLMDEditGotoLineDialog(System::Classes::TComponent* AOwner) : TLMDEditBaseDialog(AOwner) { }
	/* TLMDEditBaseDialog.Destroy */ inline __fastcall virtual ~TLMDEditGotoLineDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TLMDEditBaseSchemeDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
protected:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdseddocument::TLMDEditDocument* FDoc;
	void __fastcall CheckScheme(Lmdtypes::TLMDString AName, Lmdsedschemeeditdialog::TLMDEditSchemeEditKind AKind, bool ForSetScheme);
	void __fastcall SetDoc(Lmdseddocument::TLMDEditDocument* ADoc);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall CheckDocSet(void);
	
public:
	__fastcall virtual TLMDEditBaseSchemeDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditBaseSchemeDialog(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdseddocument::TLMDEditDocument* Document = {read=FDoc, write=SetDoc};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDEditColorSchemeDialog : public TLMDEditBaseSchemeDialog
{
	typedef TLMDEditBaseSchemeDialog inherited;
	
protected:
	Lmdseddocument::TLMDColorSchemeRef FScheme;
	void __fastcall SetScheme(Lmdseddocument::TLMDColorSchemeRef AValue);
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	
__published:
	__property Lmdseddocument::TLMDColorSchemeRef ColorScheme = {read=FScheme, write=SetScheme};
public:
	/* TLMDEditBaseSchemeDialog.Create */ inline __fastcall virtual TLMDEditColorSchemeDialog(System::Classes::TComponent* AOwner) : TLMDEditBaseSchemeDialog(AOwner) { }
	/* TLMDEditBaseSchemeDialog.Destroy */ inline __fastcall virtual ~TLMDEditColorSchemeDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TLMDEditSyntaxSchemeDialog : public TLMDEditBaseSchemeDialog
{
	typedef TLMDEditBaseSchemeDialog inherited;
	
protected:
	Lmdseddocument::TLMDSyntaxSchemeRef FScheme;
	void __fastcall SetScheme(Lmdseddocument::TLMDSyntaxSchemeRef AValue);
	
public:
	virtual bool __fastcall Execute(HWND ParentWnd)/* overload */;
	
__published:
	__property Lmdseddocument::TLMDSyntaxSchemeRef SyntaxScheme = {read=FScheme, write=SetScheme};
public:
	/* TLMDEditBaseSchemeDialog.Create */ inline __fastcall virtual TLMDEditSyntaxSchemeDialog(System::Classes::TComponent* AOwner) : TLMDEditBaseSchemeDialog(AOwner) { }
	/* TLMDEditBaseSchemeDialog.Destroy */ inline __fastcall virtual ~TLMDEditSyntaxSchemeDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(void){ return Vcl::Dialogs::TCommonDialog::Execute(); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdseddialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDDIALOGS)
using namespace Lmdseddialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdseddialogsHPP
