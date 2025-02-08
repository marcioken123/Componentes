// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialogDesignReg.pas' rev: 31.00 (Windows)

#ifndef JsdialogdesignregHPP
#define JsdialogdesignregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialogdesignreg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPreviewDialogEditor;
class DELPHICLASS TCheckPreviewDialogEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPreviewDialogEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
private:
	void __fastcall PreviewHelpLinkClick(System::TObject* Sender, bool &Handled);
	
protected:
	virtual System::UnicodeString __fastcall GetComponentVersion(void);
	virtual void __fastcall ShowCustomise(void);
	virtual void __fastcall ShowPreview(void);
	virtual void __fastcall LoadCommandLinkColors(void);
	virtual void __fastcall SaveCommandLinkColors(void);
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TPreviewDialogEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPreviewDialogEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCheckPreviewDialogEditor : public TPreviewDialogEditor
{
	typedef TPreviewDialogEditor inherited;
	
protected:
	virtual void __fastcall ShowPreview(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TCheckPreviewDialogEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TPreviewDialogEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCheckPreviewDialogEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define DIALOGPACK_VERSION L"2014.0"
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Jsdialogdesignreg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOGDESIGNREG)
using namespace Jsdialogdesignreg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogdesignregHPP
