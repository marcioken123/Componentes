// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRichEditPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdricheditprinttaskHPP
#define LmdricheditprinttaskHPP

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
#include <LMDRTFRichEdit.hpp>
#include <LMDDocElementRenderer.hpp>
#include <LMDPrinter.hpp>
#include <LMDControlPrintTasks.hpp>
#include <LMDLayoutRenderPrintTask.hpp>
#include <LMDCustomPrintTask.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdricheditprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichEditPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichEditPrintTask : public Lmdcontrolprinttasks::TLMDCustomEditPrintTask
{
	typedef Lmdcontrolprinttasks::TLMDCustomEditPrintTask inherited;
	
private:
	Lmdrtfrichedit::TLMDCustomRichEdit* FEditor;
	void __fastcall SetEditor(Lmdrtfrichedit::TLMDCustomRichEdit* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall GetControlText(System::Classes::TStrings* ATargetStrings);
	
public:
	__fastcall virtual ~TLMDRichEditPrintTask(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdrtfrichedit::TLMDCustomRichEdit* Editor = {read=FEditor, write=SetEditor};
public:
	/* TLMDCustomEditPrintTask.Create */ inline __fastcall virtual TLMDRichEditPrintTask(System::Classes::TComponent* AOwner) : Lmdcontrolprinttasks::TLMDCustomEditPrintTask(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdricheditprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRICHEDITPRINTTASK)
using namespace Lmdricheditprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdricheditprinttaskHPP
