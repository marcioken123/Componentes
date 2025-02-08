// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsEditorWnds.pas' rev: 31.00 (Windows)

#ifndef LmdinseditorwndsHPP
#define LmdinseditorwndsHPP

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
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDInsCst.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsEditorUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinseditorwnds
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditorWindowCallbacks;
class DELPHICLASS TLMDEditorWindowManager;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdinseditorwnds__1 : unsigned char { ewsMarkingModified, ewsUpdatingView, ewsDestroying };

typedef System::Set<Lmdinseditorwnds__1, Lmdinseditorwnds__1::ewsMarkingModified, Lmdinseditorwnds__1::ewsDestroying> TLMDEditorWndState;

enum DECLSPEC_DENUM TLMDEditorWndCommand : unsigned char { ewcUpdateView, ewcHideWindow, ewcShowWindow, ewcDestroyWindow, ewcUpdateStayOnTop };

typedef void __fastcall (__closure *TLMDEditorWndOnCommand)(System::TObject* Sender, TLMDEditorWndCommand ACommand);

typedef System::TMetaClass* TLMDEditorWindowCallbacksClass;

class PASCALIMPLEMENTATION TLMDEditorWindowCallbacks : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDEditorWindowManager* FManager;
	TLMDEditorWndOnCommand FOnCommand;
	TLMDEditorWndState FState;
	void __fastcall DoCommand(TLMDEditorWndCommand ACommand);
	bool __fastcall GetStayOnTop(void);
	Lmdinseditorutils::TLMDEditorUtils* __fastcall GetEditorUtils(void);
	
protected:
	void __fastcall UpdateView(void);
	void __fastcall HideWindow(void);
	void __fastcall ShowWindow(void);
	void __fastcall DestroyWindow(void);
	void __fastcall UpdateStayOnTop(void);
	
public:
	__fastcall virtual TLMDEditorWindowCallbacks(TLMDEditorWindowManager* AManager);
	__fastcall virtual ~TLMDEditorWindowCallbacks(void);
	__property TLMDEditorWindowManager* Manager = {read=FManager};
	__property Lmdinseditorutils::TLMDEditorUtils* EditorUtils = {read=GetEditorUtils};
	__property TLMDEditorWndState State = {read=FState, nodefault};
	__property bool StayOnTop = {read=GetStayOnTop, nodefault};
	__property TLMDEditorWndOnCommand OnCommand = {read=FOnCommand, write=FOnCommand};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditorWindowManager : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FEditorWndCbs;
	System::Classes::TComponent* FParentComp;
	Lmdinseditorutils::TLMDEditorUtils* FEditorUtils;
	bool FStayOnTop;
	void __fastcall DisassociateAllCallbacks(void);
	void __fastcall SetStayOnTop(const bool Value);
	
public:
	__fastcall TLMDEditorWindowManager(System::Classes::TComponent* AParentComp, Lmdinseditorutils::TLMDEditorUtils* AEditorUtils);
	__fastcall virtual ~TLMDEditorWindowManager(void);
	TLMDEditorWindowCallbacks* __fastcall CreateCallbacks(void);
	void __fastcall UpdateAll(void);
	void __fastcall ShowAll(void);
	void __fastcall HideAll(void);
	void __fastcall DestroyAll(void);
	__property System::Classes::TComponent* ParentComp = {read=FParentComp};
	__property bool StayOnTop = {read=FStayOnTop, write=SetStayOnTop, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinseditorwnds */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSEDITORWNDS)
using namespace Lmdinseditorwnds;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinseditorwndsHPP
