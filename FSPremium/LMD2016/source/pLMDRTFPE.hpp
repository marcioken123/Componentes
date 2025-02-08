// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFPE.pas' rev: 31.00 (Windows)

#ifndef PlmdrtfpeHPP
#define PlmdrtfpeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ActnMan.hpp>
#include <Vcl.ActnCtrls.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Vcl.ActnMenus.hpp>
#include <ToolsAPI.hpp>
#include <ColnEdit.hpp>
#include <LMDRTFStorage.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFHyperTextStorage.hpp>
#include <LMDRTFSyntaxEdit.hpp>
#include <LMDRTFLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtfpe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRTFLinesProperty;
class DELPHICLASS TRTFSyntaxDefsProperty;
class DELPHICLASS TRTFHyperTextLinesProperty;
class DELPHICLASS TRTFStorageItemProperty;
class DELPHICLASS TRTFStorageItemsProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TRTFLinesProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TRTFLinesProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRTFLinesProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRTFSyntaxDefsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TRTFSyntaxDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRTFSyntaxDefsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRTFHyperTextLinesProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TRTFHyperTextLinesProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRTFHyperTextLinesProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRTFStorageItemProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	virtual void __fastcall SetValue(const System::UnicodeString aValue)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TRTFStorageItemProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRTFStorageItemProperty(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRTFStorageItemsProperty : public Colnedit::TCollectionProperty
{
	typedef Colnedit::TCollectionProperty inherited;
	
public:
	virtual Colnedit::TCollectionEditorClass __fastcall GetEditorClass(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TRTFStorageItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Colnedit::TCollectionProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRTFStorageItemsProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdrtfpe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFPE)
using namespace Plmdrtfpe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtfpeHPP
