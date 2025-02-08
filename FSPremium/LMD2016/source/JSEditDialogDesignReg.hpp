// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSEditDialogDesignReg.pas' rev: 31.00 (Windows)

#ifndef JseditdialogdesignregHPP
#define JseditdialogdesignregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignEditors.hpp>
#include <JSDialogDesignReg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jseditdialogdesignreg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPreviewEditDialogEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPreviewEditDialogEditor : public Jsdialogdesignreg::TPreviewDialogEditor
{
	typedef Jsdialogdesignreg::TPreviewDialogEditor inherited;
	
private:
	HIDESBASE void __fastcall PreviewHelpLinkClick(System::TObject* Sender, bool &Handled);
	
protected:
	virtual System::UnicodeString __fastcall GetComponentVersion(void);
	virtual void __fastcall ShowCustomise(void);
	virtual void __fastcall ShowPreview(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TPreviewEditDialogEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Jsdialogdesignreg::TPreviewDialogEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPreviewEditDialogEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Jseditdialogdesignreg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSEDITDIALOGDESIGNREG)
using namespace Jseditdialogdesignreg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JseditdialogdesignregHPP
