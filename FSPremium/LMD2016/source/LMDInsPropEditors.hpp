// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsPropEditors.pas' rev: 31.00 (Windows)

#ifndef LmdinspropeditorsHPP
#define LmdinspropeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Menus.hpp>
#include <System.Masks.hpp>
#include <System.RTLConsts.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsCst.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsPropInsp.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinspropeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOrdinalPropEditor;
class DELPHICLASS TLMDIntegerPropEditor;
class DELPHICLASS TLMDCharPropEditor;
class DELPHICLASS TLMDEnumPropEditor;
class DELPHICLASS TLMDFloatPropEditor;
class DELPHICLASS TLMDStringPropEditor;
class DELPHICLASS TLMDWideStringPropEditor;
class DELPHICLASS TLMDSetElemPropEditor;
class DELPHICLASS TLMDSetPropEditor;
class DELPHICLASS TLMDClassPropEditor;
class DELPHICLASS TLMDComponentPropEditor;
class DELPHICLASS TLMDVariantTypePropEditor;
class DELPHICLASS TLMDVariantPropEditor;
class DELPHICLASS TLMDInt64PropEditor;
class DELPHICLASS TLMDComponentNamePropEditor;
class DELPHICLASS TLMDDatePropEditor;
class DELPHICLASS TLMDTimePropEditor;
class DELPHICLASS TLMDDateTimePropEditor;
class DELPHICLASS TLMDEventPropEditor;
class DELPHICLASS TLMDCaptionPropEditor;
class DELPHICLASS TLMDColorPropEditor;
class DELPHICLASS TLMDCursorPropEditor;
class DELPHICLASS TLMDFontCharsetPropEditor;
class DELPHICLASS TLMDFontNamePropEditor;
class DELPHICLASS TLMDImeNamePropEditor;
class DELPHICLASS TLMDFontPropEditor;
class DELPHICLASS TLMDModalResultPropEditor;
class DELPHICLASS TLMDPenStylePropEditor;
class DELPHICLASS TLMDBrushStylePropEditor;
class DELPHICLASS TLMDTabOrderPropEditor;
class DELPHICLASS TLMDShortCutPropEditor;
class DELPHICLASS TLMDStringsPropEditor;
class DELPHICLASS TLMDWideStringsPropEditor;
class DELPHICLASS TLMDCollectionPropEditor;
class DELPHICLASS TLMDMenuItemPropEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDOrdinalPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDOrdinalPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDOrdinalPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIntegerPropEditor : public TLMDOrdinalPropEditor
{
	typedef TLMDOrdinalPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDIntegerPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDOrdinalPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDIntegerPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCharPropEditor : public TLMDOrdinalPropEditor
{
	typedef TLMDOrdinalPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDCharPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDOrdinalPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDCharPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEnumPropEditor : public TLMDOrdinalPropEditor
{
	typedef TLMDOrdinalPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDEnumPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDOrdinalPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDEnumPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFloatPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDFloatPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDFloatPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDStringPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDStringPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWideStringPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDWideStringPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDWideStringPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetElemPropEditor : public Lmdinspropinsp::TLMDNestedPropEditor
{
	typedef Lmdinspropinsp::TLMDNestedPropEditor inherited;
	
private:
	int FElement;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual Lmdtypes::TLMDString __fastcall GetPropName(void);
	virtual bool __fastcall AllEqual(void);
	
public:
	__fastcall TLMDSetElemPropEditor(Lmdinspropinsp::TLMDPropEditor* AParent, int AElement);
	__property int Element = {read=FElement, nodefault};
public:
	/* TLMDNestedPropEditor.Destroy */ inline __fastcall virtual ~TLMDSetElemPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetPropEditor : public TLMDOrdinalPropEditor
{
	typedef TLMDOrdinalPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetSubProps(System::Classes::TList* AResult);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDSetPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDOrdinalPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDSetPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDClassPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
private:
	bool __fastcall GetObjects(System::Classes::TList* AResult);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetSubProps(System::Classes::TList* AResult);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDClassPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDClassPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDComponentPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetSubProps(System::Classes::TList* AResult);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDComponentPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDComponentPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVariantTypePropEditor : public Lmdinspropinsp::TLMDNestedPropEditor
{
	typedef Lmdinspropinsp::TLMDNestedPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual Lmdtypes::TLMDString __fastcall GetPropName(void);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual bool __fastcall AllEqual(void);
public:
	/* TLMDNestedPropEditor.Create */ inline __fastcall TLMDVariantTypePropEditor(Lmdinspropinsp::TLMDPropEditor* ANestedIn) : Lmdinspropinsp::TLMDNestedPropEditor(ANestedIn) { }
	/* TLMDNestedPropEditor.Destroy */ inline __fastcall virtual ~TLMDVariantTypePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVariantPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetSubProps(System::Classes::TList* AResult);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDVariantPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDVariantPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDInt64PropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual bool __fastcall AllEqual(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDInt64PropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDInt64PropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDComponentNamePropEditor : public TLMDStringPropEditor
{
	typedef TLMDStringPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDComponentNamePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDStringPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDComponentNamePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDatePropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDDatePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDDatePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTimePropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDTimePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDTimePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDateTimePropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDDateTimePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDDateTimePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEventPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual bool __fastcall AllEqual(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDEventPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDEventPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCaptionPropEditor : public TLMDStringPropEditor
{
	typedef TLMDStringPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDCaptionPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDStringPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDCaptionPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDColorPropEditor : public TLMDIntegerPropEditor
{
	typedef TLMDIntegerPropEditor inherited;
	
private:
	System::Classes::TStrings* FValues;
	void __fastcall AddValue(const System::UnicodeString LS);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall Edit(void);
	virtual void __fastcall ValuesMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall ValuesMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall ValuesDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDColorPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDIntegerPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDColorPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCursorPropEditor : public TLMDIntegerPropEditor
{
	typedef TLMDIntegerPropEditor inherited;
	
private:
	System::Classes::TStrings* FValues;
	void __fastcall AddValue(const System::UnicodeString LS);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall ValuesMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall ValuesMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall ValuesDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDCursorPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDIntegerPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDCursorPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontCharsetPropEditor : public TLMDIntegerPropEditor
{
	typedef TLMDIntegerPropEditor inherited;
	
private:
	System::Classes::TStrings* FValues;
	void __fastcall AddValue(const System::UnicodeString LS);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDFontCharsetPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDIntegerPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDFontCharsetPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontNamePropEditor : public TLMDStringPropEditor
{
	typedef TLMDStringPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDFontNamePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDStringPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDFontNamePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDImeNamePropEditor : public TLMDStringPropEditor
{
	typedef TLMDStringPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDImeNamePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDStringPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDImeNamePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontPropEditor : public TLMDClassPropEditor
{
	typedef TLMDClassPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDFontPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDClassPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDFontPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDModalResultPropEditor : public TLMDIntegerPropEditor
{
	typedef TLMDIntegerPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDModalResultPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDIntegerPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDModalResultPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPenStylePropEditor : public TLMDEnumPropEditor
{
	typedef TLMDEnumPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall ValuesMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall ValuesMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall ValuesDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDPenStylePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDEnumPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDPenStylePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBrushStylePropEditor : public TLMDEnumPropEditor
{
	typedef TLMDEnumPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall ValuesMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall ValuesMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall ValuesDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDBrushStylePropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDEnumPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDBrushStylePropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTabOrderPropEditor : public TLMDIntegerPropEditor
{
	typedef TLMDIntegerPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDTabOrderPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDIntegerPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDTabOrderPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShortCutPropEditor : public TLMDOrdinalPropEditor
{
	typedef TLMDOrdinalPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDShortCutPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDOrdinalPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDShortCutPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringsPropEditor : public TLMDClassPropEditor
{
	typedef TLMDClassPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDStringsPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDClassPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDStringsPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWideStringsPropEditor : public TLMDClassPropEditor
{
	typedef TLMDClassPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDWideStringsPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : TLMDClassPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDWideStringsPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCollectionPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDCollectionPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDCollectionPropEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMenuItemPropEditor : public Lmdinspropinsp::TLMDPropEditor
{
	typedef Lmdinspropinsp::TLMDPropEditor inherited;
	
protected:
	virtual Lmdinspropinsp::TLMDPropAttrs __fastcall GetAttrs(void);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall Edit(void);
public:
	/* TLMDPropEditor.Create */ inline __fastcall virtual TLMDMenuItemPropEditor(Lmdinspropinsp::TLMDCustomPropertyInspector* APropInsp, Lmdinspropinsp::TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList) : Lmdinspropinsp::TLMDPropEditor(APropInsp, AParentObjEditor, APropCount, APropList) { }
	/* TLMDPropEditor.Destroy */ inline __fastcall virtual ~TLMDMenuItemPropEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinspropeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSPROPEDITORS)
using namespace Lmdinspropeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinspropeditorsHPP
