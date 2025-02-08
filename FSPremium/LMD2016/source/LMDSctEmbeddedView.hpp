// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctEmbeddedView.pas' rev: 31.00 (Windows)

#ifndef LmdsctembeddedviewHPP
#define LmdsctembeddedviewHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <DesignIntf.hpp>
#include <ToolsAPI.hpp>
#include <VCLEditors.hpp>
#include <LMDSctImporterTree.hpp>
#include <LMDSctImporterUnitDoc.hpp>
#include <LMDSctUnitFrame.hpp>
#include <LMDSctBatchFrame.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctembeddedview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImportMessageGroup;
class DELPHICLASS TLMDImportMessage;
class DELPHICLASS TLMDUnitViewTraits;
class DELPHICLASS TLMDUnitEmbeddedView;
class DELPHICLASS TLMDBatchTraits;
class DELPHICLASS TLMDBatchEmbeddedView;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDImportMessageGroup : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
protected:
	void __fastcall MessageGroupAdded(const Toolsapi::_di_IOTAMessageGroup Group);
	void __fastcall MessageGroupDeleted(const Toolsapi::_di_IOTAMessageGroup Group);
	
public:
	__classmethod Toolsapi::_di_IOTAMessageGroup __fastcall Get();
	__classmethod void __fastcall Remove();
public:
	/* TObject.Create */ inline __fastcall TLMDImportMessageGroup(void) : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDImportMessageGroup(void) { }
	
private:
	void *__IOTAMessageNotifier;	// Toolsapi::IOTAMessageNotifier 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FDCB2ED4-B89C-4D00-B0DB-19562951CDBB}
	operator Toolsapi::_di_IOTAMessageNotifier()
	{
		Toolsapi::_di_IOTAMessageNotifier intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAMessageNotifier*(void) { return (Toolsapi::IOTAMessageNotifier*)&__IOTAMessageNotifier; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F17A7BCF-E07D-11D1-AB0B-00C04FB16FB3}
	operator Toolsapi::_di_IOTANotifier()
	{
		Toolsapi::_di_IOTANotifier intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTANotifier*(void) { return (Toolsapi::IOTANotifier*)&__IOTAMessageNotifier; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDImportMessage : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FFilePath;
	System::UnicodeString FNodeFullName;
	System::UnicodeString FLineText;
	
protected:
	int __fastcall GetColumnNumber(void);
	System::UnicodeString __fastcall GetFileName(void);
	int __fastcall GetLineNumber(void);
	System::UnicodeString __fastcall GetLineText(void);
	void __fastcall ShowHelp(void);
	int __fastcall GetChildCount(void);
	Toolsapi::_di_IOTACustomMessage50 __fastcall GetChild(int Index);
	bool __fastcall CanGotoSource(bool &DefaultHandling);
	void __fastcall TrackSource(bool &DefaultHandling);
	void __fastcall GotoSource(bool &DefaultHandling);
	
public:
	__fastcall TLMDImportMessage(const System::UnicodeString AFilePath, const System::UnicodeString ANodeFullName, const System::UnicodeString S);
	__classmethod void __fastcall ClearMessages();
	__classmethod void __fastcall ShowMessageView();
	__classmethod void __fastcall AddTitle(const System::UnicodeString S);
	__classmethod void __fastcall AddText(const System::UnicodeString S);
	__classmethod void __fastcall AddDocsMsgs(Lmdsctimporterunitdoc::TLMDUnitDocument* const *ADocuments, const int ADocuments_High);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDImportMessage(void) { }
	
private:
	void *__IOTACustomMessage100;	// Toolsapi::IOTACustomMessage100 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {824153E3-6336-48BA-805E-1A35E429787E}
	operator Toolsapi::_di_IOTACustomMessage100()
	{
		Toolsapi::_di_IOTACustomMessage100 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTACustomMessage100*(void) { return (Toolsapi::IOTACustomMessage100*)&__IOTACustomMessage100; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B7523AB7-EB81-11D2-AC7B-00C04FB173DC}
	operator Toolsapi::_di_IOTACustomMessage50()
	{
		Toolsapi::_di_IOTACustomMessage50 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTACustomMessage50*(void) { return (Toolsapi::IOTACustomMessage50*)&__IOTACustomMessage100; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {589BBDA1-F995-11D1-AB27-00C04FB16FB3}
	operator Toolsapi::_di_IOTACustomMessage()
	{
		Toolsapi::_di_IOTACustomMessage intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTACustomMessage*(void) { return (Toolsapi::IOTACustomMessage*)&__IOTACustomMessage100; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDUnitViewTraits : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Forms::TCustomFrame* FViewObject;
	Lmdsctunitframe::TLMDUnitFrame* FContent;
	void __fastcall SetContent(Lmdsctunitframe::TLMDUnitFrame* const Value);
	void __fastcall SetStatus(const System::UnicodeString S, int AProgress = 0xffffffff);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall UpdateCaption(void);
	void __fastcall OpenUsedUnit(const System::UnicodeString AUnitName);
	bool __fastcall UseExternalMessageView(void);
	void __fastcall BeginImporting(void);
	void __fastcall ImportingProgress(int AProgress);
	void __fastcall EndImporting(bool ASucceded);
	
public:
	__fastcall TLMDUnitViewTraits(Vcl::Forms::TCustomFrame* AViewObject);
	__fastcall virtual ~TLMDUnitViewTraits(void);
	__property Lmdsctunitframe::TLMDUnitFrame* Content = {read=FContent, write=SetContent};
private:
	void *__ILMDUnitFrameTraits;	// Lmdsctunitframe::ILMDUnitFrameTraits 
	
public:
	operator Lmdsctunitframe::ILMDUnitFrameTraits*(void) { return (Lmdsctunitframe::ILMDUnitFrameTraits*)&__ILMDUnitFrameTraits; }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitEmbeddedView : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Toolsapi::_di_IOTASourceEditor __fastcall EditorFromContext(const System::_di_IInterface AContext);
	Vcl::Stdctrls::TCustomEdit* __fastcall GetFocusedEditor(System::TObject* AViewObject);
	TLMDUnitViewTraits* __fastcall GetTraits(Vcl::Forms::TFrame* AViewObject);
	
protected:
	void __fastcall Display(const System::_di_IInterface AContext, System::TObject* AViewObject);
	bool __fastcall EditAction(const System::_di_IInterface AContext, Designintf::TEditAction Action, System::TObject* AViewObject);
	Vcl::Forms::TCustomFrameClass __fastcall GetFrameClass(void);
	void __fastcall FrameCreated(Vcl::Forms::TCustomFrame* AFrame);
	bool __fastcall GetCanCloneView(void);
	System::UnicodeString __fastcall GetCaption(void);
	Designintf::TEditState __fastcall GetEditState(const System::_di_IInterface AContext, System::TObject* AViewObject);
	int __fastcall GetPriority(void);
	System::UnicodeString __fastcall GetViewIdentifier(void);
	bool __fastcall Handles(const System::_di_IInterface AContext);
	void __fastcall Hide(const System::_di_IInterface AContext, System::TObject* AViewObject);
	void __fastcall ViewClosed(const System::_di_IInterface AContext, System::TObject* AViewObject);
	
public:
	__classmethod void __fastcall Finalize();
public:
	/* TObject.Create */ inline __fastcall TLMDUnitEmbeddedView(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitEmbeddedView(void) { }
	
private:
	void *__INTACustomEditorSubView;	// Toolsapi::INTACustomEditorSubView 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {655AA26C-5898-4DB5-B21F-4F55E9B2B407}
	operator Toolsapi::_di_INTACustomEditorSubView()
	{
		Toolsapi::_di_INTACustomEditorSubView intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::INTACustomEditorSubView*(void) { return (Toolsapi::INTACustomEditorSubView*)&__INTACustomEditorSubView; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDBatchTraits : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdsctbatchframe::TLMDBatchFrame* FFrame;
	void __fastcall SetStatus(const System::UnicodeString S);
	
protected:
	bool __fastcall UseExternalMessageView(void);
	void __fastcall BeginImporting(void);
	void __fastcall UnitNotFound(const System::UnicodeString AUnitName);
	void __fastcall HintsSaved(const System::UnicodeString AFilePath);
	void __fastcall BeginUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	void __fastcall EndUnitImport(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument, bool ASucceded);
	void __fastcall EndImporting(Lmdsctimporterunitdoc::TLMDUnitDocument* const *ADocuments, const int ADocuments_High, bool ASucceded);
	
public:
	__fastcall TLMDBatchTraits(Lmdsctbatchframe::TLMDBatchFrame* AFrame);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDBatchTraits(void) { }
	
private:
	void *__ILMDBatchFrameTraits;	// Lmdsctbatchframe::ILMDBatchFrameTraits 
	
public:
	operator Lmdsctbatchframe::ILMDBatchFrameTraits*(void) { return (Lmdsctbatchframe::ILMDBatchFrameTraits*)&__ILMDBatchFrameTraits; }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBatchEmbeddedView : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Vcl::Stdctrls::TCustomEdit* __fastcall GetFocusedEditor(void);
	
protected:
	bool __fastcall GetCanCloneView(void);
	Toolsapi::_di_INTACustomEditorView __fastcall CloneEditorView(void);
	System::UnicodeString __fastcall GetCaption(void);
	System::UnicodeString __fastcall GetEditorWindowCaption(void);
	System::UnicodeString __fastcall GetViewIdentifier(void);
	Designintf::TEditState __fastcall GetEditState(void);
	bool __fastcall EditAction(Designintf::TEditAction Action);
	void __fastcall CloseAllCalled(bool &ShouldClose);
	void __fastcall SelectView(void);
	void __fastcall DeselectView(void);
	Vcl::Forms::TCustomFrameClass __fastcall GetFrameClass(void);
	void __fastcall FrameCreated(Vcl::Forms::TCustomFrame* AFrame);
	int __fastcall GetStatusPanelCount(void);
	void __fastcall ConfigurePanel(Vcl::Comctrls::TStatusBar* StatusBar, Vcl::Comctrls::TStatusPanel* Panel);
	void __fastcall DrawPanel(Vcl::Comctrls::TStatusBar* StatusBar, Vcl::Comctrls::TStatusPanel* Panel, const System::Types::TRect &Rect);
	
public:
	__classmethod void __fastcall Finalize();
public:
	/* TObject.Create */ inline __fastcall TLMDBatchEmbeddedView(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBatchEmbeddedView(void) { }
	
private:
	void *__INTACustomEditorViewStatusPanel;	// Toolsapi::INTACustomEditorViewStatusPanel 
	void *__INTACustomEditorView;	// Toolsapi::INTACustomEditorView 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {39B8ECEB-3048-4733-BF3D-C76540D87AE2}
	operator Toolsapi::_di_INTACustomEditorViewStatusPanel()
	{
		Toolsapi::_di_INTACustomEditorViewStatusPanel intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::INTACustomEditorViewStatusPanel*(void) { return (Toolsapi::INTACustomEditorViewStatusPanel*)&__INTACustomEditorViewStatusPanel; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E9465FAF-B671-4098-9ED9-AE4C05C5454A}
	operator Toolsapi::_di_INTACustomEditorView()
	{
		Toolsapi::_di_INTACustomEditorView intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::INTACustomEditorView*(void) { return (Toolsapi::INTACustomEditorView*)&__INTACustomEditorView; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define VIEW_NAME L"LMD-Script Import"
}	/* namespace Lmdsctembeddedview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTEMBEDDEDVIEW)
using namespace Lmdsctembeddedview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctembeddedviewHPP
