// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolCtrlsReg.pas' rev: 6.00

#ifndef CoolCtrlsRegHPP
#define CoolCtrlsRegHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <VCLEditors.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolctrlsreg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCoolButtonPanelCompEditor;
class PASCALIMPLEMENTATION TCoolButtonPanelCompEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolButtonPanelCompEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolButtonPanelCompEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolTrayIconEditor;
class PASCALIMPLEMENTATION TCoolTrayIconEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
private:
	unsigned FTimeToPreview;
	
public:
	__fastcall virtual TCoolTrayIconEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolTrayIconEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCopyModeProperty;
class PASCALIMPLEMENTATION TCopyModeProperty : public Designeditors::TIntegerProperty 
{
	typedef Designeditors::TIntegerProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
	virtual void __fastcall SetValue(const AnsiString Value);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TCopyModeProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TIntegerProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCopyModeProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolImagesEditor;
class PASCALIMPLEMENTATION TCoolImagesEditor : public Designeditors::TDefaultEditor 
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolImagesEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolImagesEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCCAboutProperty;
class PASCALIMPLEMENTATION TCCAboutProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TCCAboutProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCCAboutProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCaptionPropertyEx;
class PASCALIMPLEMENTATION TCaptionPropertyEx : public Vcleditors::TCaptionProperty 
{
	typedef Vcleditors::TCaptionProperty inherited;
	
public:
	virtual void __fastcall SetValue(const AnsiString Value);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TCaptionPropertyEx(const Designintf::_di_IDesigner ADesigner, int APropCount) : Vcleditors::TCaptionProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCaptionPropertyEx(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDBCoolListBoxEditor;
class PASCALIMPLEMENTATION TDBCoolListBoxEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TDBCoolListBoxEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBCoolListBoxEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPointListProperty;
class PASCALIMPLEMENTATION TPointListProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TPointListProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPointListProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TColorListProperty;
class PASCALIMPLEMENTATION TColorListProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TColorListProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TColorListProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPolygonesProperty;
class PASCALIMPLEMENTATION TPolygonesProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TPolygonesProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPolygonesProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolImageShapeEditor;
class PASCALIMPLEMENTATION TCoolImageShapeEditor : public Designeditors::TDefaultEditor 
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolImageShapeEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolImageShapeEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolPageControlEditor;
class PASCALIMPLEMENTATION TCoolPageControlEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolPageControlEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolPageControlEditor(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Coolctrlsreg */
using namespace Coolctrlsreg;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolCtrlsReg
