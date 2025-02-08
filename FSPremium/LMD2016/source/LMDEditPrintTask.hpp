// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEditPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdeditprinttaskHPP
#define LmdeditprinttaskHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDPrinter.hpp>
#include <LMDControlPrintTasks.hpp>
#include <LMDLayoutRenderPrintTask.hpp>
#include <LMDCustomPrintTask.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdeditprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditControlPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEditControlPrintTask : public Lmdcontrolprinttasks::TLMDCustomEditPrintTask
{
	typedef Lmdcontrolprinttasks::TLMDCustomEditPrintTask inherited;
	
private:
	Lmdbaseedit::TLMDBaseEdit* FEditor;
	void __fastcall SetEditor(Lmdbaseedit::TLMDBaseEdit* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall GetControlText(System::Classes::TStrings* ATargetStrings);
	
__published:
	__property Lmdbaseedit::TLMDBaseEdit* Editor = {read=FEditor, write=SetEditor};
	
public:
	__fastcall virtual ~TLMDEditControlPrintTask(void);
public:
	/* TLMDCustomEditPrintTask.Create */ inline __fastcall virtual TLMDEditControlPrintTask(System::Classes::TComponent* AOwner) : Lmdcontrolprinttasks::TLMDCustomEditPrintTask(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdeditprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEDITPRINTTASK)
using namespace Lmdeditprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeditprinttaskHPP
