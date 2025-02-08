// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolCtrlsReg.pas' rev: 4.00

#ifndef CoolCtrlsRegHPP
#define CoolCtrlsRegHPP

#pragma delphiheader begin
#pragma option push -w-
#include <DsgnIntf.hpp>	// Pascal unit
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
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolButtonPanelCompEditor : public Dsgnintf::TComponentEditor 
{
	typedef Dsgnintf::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolButtonPanelCompEditor(Classes::TComponent* 
		AComponent, Dsgnintf::_di_IFormDesigner ADesigner) : Dsgnintf::TComponentEditor(AComponent, ADesigner
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolButtonPanelCompEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolTrayIconEditor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolTrayIconEditor : public Dsgnintf::TComponentEditor 
{
	typedef Dsgnintf::TComponentEditor inherited;
	
private:
	unsigned FTimeToPreview;
	
public:
	__fastcall virtual TCoolTrayIconEditor(Classes::TComponent* AComponent, Dsgnintf::_di_IFormDesigner 
		ADesigner);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolTrayIconEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCopyModeProperty;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCopyModeProperty : public Dsgnintf::TIntegerProperty 
{
	typedef Dsgnintf::TIntegerProperty inherited;
	
public:
	virtual Dsgnintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
	virtual void __fastcall SetValue(const AnsiString Value);
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TCopyModeProperty(const Dsgnintf::_di_IFormDesigner 
		ADesigner, int APropCount) : Dsgnintf::TIntegerProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCopyModeProperty(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolImagesEditor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolImagesEditor : public Dsgnintf::TDefaultEditor 
{
	typedef Dsgnintf::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(Dsgnintf::TPropertyEditor* PropertyEditor, bool &Continue, bool 
		&FreeEditor);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolImagesEditor(Classes::TComponent* AComponent
		, Dsgnintf::_di_IFormDesigner ADesigner) : Dsgnintf::TDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolImagesEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCCAboutProperty;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCCAboutProperty : public Dsgnintf::TClassProperty 
{
	typedef Dsgnintf::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Dsgnintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TCCAboutProperty(const Dsgnintf::_di_IFormDesigner ADesigner
		, int APropCount) : Dsgnintf::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCCAboutProperty(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCaptionPropertyEx;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCaptionPropertyEx : public Dsgnintf::TCaptionProperty 
{
	typedef Dsgnintf::TCaptionProperty inherited;
	
public:
	virtual void __fastcall SetValue(const AnsiString Value);
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TCaptionPropertyEx(const Dsgnintf::_di_IFormDesigner 
		ADesigner, int APropCount) : Dsgnintf::TCaptionProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCaptionPropertyEx(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolListBoxEditor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolListBoxEditor : public Dsgnintf::TComponentEditor 
{
	typedef Dsgnintf::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TDBCoolListBoxEditor(Classes::TComponent* AComponent
		, Dsgnintf::_di_IFormDesigner ADesigner) : Dsgnintf::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBCoolListBoxEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TPointListProperty;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TPointListProperty : public Dsgnintf::TClassProperty 
{
	typedef Dsgnintf::TClassProperty inherited;
	
public:
	virtual Dsgnintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TPointListProperty(const Dsgnintf::_di_IFormDesigner 
		ADesigner, int APropCount) : Dsgnintf::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPointListProperty(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TColorListProperty;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TColorListProperty : public Dsgnintf::TClassProperty 
{
	typedef Dsgnintf::TClassProperty inherited;
	
public:
	virtual Dsgnintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TColorListProperty(const Dsgnintf::_di_IFormDesigner 
		ADesigner, int APropCount) : Dsgnintf::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TColorListProperty(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TPolygonesProperty;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TPolygonesProperty : public Dsgnintf::TClassProperty 
{
	typedef Dsgnintf::TClassProperty inherited;
	
public:
	virtual Dsgnintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
protected:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall TPolygonesProperty(const Dsgnintf::_di_IFormDesigner 
		ADesigner, int APropCount) : Dsgnintf::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPolygonesProperty(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolImageShapeEditor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolImageShapeEditor : public Dsgnintf::TDefaultEditor 
{
	typedef Dsgnintf::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(Dsgnintf::TPropertyEditor* PropertyEditor, bool &Continue, bool 
		&FreeEditor);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolImageShapeEditor(Classes::TComponent* 
		AComponent, Dsgnintf::_di_IFormDesigner ADesigner) : Dsgnintf::TDefaultEditor(AComponent, ADesigner
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolImageShapeEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolPageControlEditor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPageControlEditor : public Dsgnintf::TComponentEditor 
{
	typedef Dsgnintf::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TCoolPageControlEditor(Classes::TComponent* 
		AComponent, Dsgnintf::_di_IFormDesigner ADesigner) : Dsgnintf::TComponentEditor(AComponent, ADesigner
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCoolPageControlEditor(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Coolctrlsreg */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolctrlsreg;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolCtrlsReg
