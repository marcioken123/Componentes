// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMD_RegV3.pas' rev: 31.00 (Windows)

#ifndef Lmd_regv3HPP
#define Lmd_regv3HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <System.TypInfo.hpp>
#include <pLMDCECore.hpp>
#include <LMDSpltA.hpp>
#include <LMDShapeLabel.hpp>
#include <LMDTeethShape.hpp>
#include <LMDTeethShapeLabel.hpp>
#include <LMD3DShapeButton.hpp>
#include <LMD3DShapeLabelButton.hpp>
#include <LMDShapeLabelButton.hpp>
#include <LMD3DCaptionButton.hpp>
#include <LMDOfficeButton.hpp>
#include <LMDDockOfficeButton.hpp>
#include <LMDExplorerButton.hpp>
#include <Data.DB.hpp>
#include <LMDDBFilter.hpp>
#include <LMDDBShapeLabel.hpp>
#include <LMDDBAliasNamesComboBox.hpp>
#include <LMDDBDriverComboBox.hpp>
#include <LMDDBTablesComboBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmd_regv3
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSplitterComponentEditor;
class DELPHICLASS TLMDDBStringProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSplitterComponentEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDSplitterComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSplitterComponentEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBStringProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValueList(System::Classes::TStrings* List);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDDBStringProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDDBStringProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Lmd_regv3 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMD_REGV3)
using namespace Lmd_regv3;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmd_regv3HPP
