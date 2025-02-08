// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctExpertUnit.pas' rev: 31.00 (Windows)

#ifndef LmdsctexpertunitHPP
#define LmdsctexpertunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.StrUtils.hpp>
#include <DesignIntf.hpp>
#include <ToolsAPI.hpp>
#include <System.Win.Registry.hpp>
#include <LMDTypes.hpp>
#include <LMDSctUnitFrame.hpp>
#include <LMDSctEmbeddedView.hpp>
#include <LMDSctFloatingView.hpp>
#include <LMDSctBatchFrame.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctexpertunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImporterExpert;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDImporterExpert : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void *FView;
	Vcl::Menus::TMenuItem* FSeparatorItem;
	Vcl::Menus::TMenuItem* FWizardItem;
	Vcl::Menus::TMenuItem* FBatchItem;
	Vcl::Menus::TMenuItem* FMainItem;
	void __fastcall InitMenuItems(void);
	void __fastcall BatchMenuItemClick(System::TObject* Sender);
	
public:
	__fastcall TLMDImporterExpert(void);
	__fastcall virtual ~TLMDImporterExpert(void);
	__classmethod Toolsapi::_di_IOTASourceEditor __fastcall EditorFromModule(const Toolsapi::_di_IOTAModule AModule);
	__classmethod Toolsapi::_di_IOTASourceEditor __fastcall GetCurrentEditor();
	__classmethod void __fastcall Register();
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctexpertunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTEXPERTUNIT)
using namespace Lmdsctexpertunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctexpertunitHPP
