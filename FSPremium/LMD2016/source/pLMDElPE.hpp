// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElPE.pas' rev: 31.00 (Windows)

#ifndef PlmdelpeHPP
#define PlmdelpeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <ColnEdit.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <LMDTypes.hpp>
#include <ElPgCtl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelpe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElActivePageProperty;
class DELPHICLASS TElImageIndexProperty;
class DELPHICLASS TElCurrencyEditButtonImageIndexProperty;
class DELPHICLASS TElFormProperty;
class DELPHICLASS TElHTMLContainerItemsProperty;
class DELPHICLASS TElHTMLStringsProperty;
class DELPHICLASS TElHTMLStringProperty;
class DELPHICLASS TElMlCaptionProperty;
class DELPHICLASS TElSectionsProperty;
class DELPHICLASS TElXSectionsProperty;
class DELPHICLASS TElSideBarSectionImageIndexProperty;
class DELPHICLASS TElSideBarItemImageIndexProperty;
class DELPHICLASS TStrPoolItemsProperty;
class DELPHICLASS TElTabSheetImageIndexProperty;
class DELPHICLASS TElToolButtonImageIndexProperty;
class DELPHICLASS TLMDWideStringsProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElActivePageProperty : public Designeditors::TComponentProperty
{
	typedef Designeditors::TComponentProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElActivePageProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TComponentProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElActivePageProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElImageIndexProperty : public Designeditors::TIntegerProperty
{
	typedef Designeditors::TIntegerProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
	virtual System::UnicodeString __fastcall GetImagesPropertyName(void);
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages};
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	void __fastcall PropDrawName(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	void __fastcall PropDrawValue(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	void __fastcall ListMeasureWidth(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	void __fastcall ListMeasureHeight(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	void __fastcall ListDrawValue(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TIntegerProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElImageIndexProperty(void) { }
	
private:
	void *__ICustomPropertyDrawing;	// Vcleditors::ICustomPropertyDrawing 
	void *__ICustomPropertyListDrawing;	// Vcleditors::ICustomPropertyListDrawing 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E1A50419-1288-4B26-9EFA-6608A35F0824}
	operator Vcleditors::_di_ICustomPropertyDrawing()
	{
		Vcleditors::_di_ICustomPropertyDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyDrawing*(void) { return (Vcleditors::ICustomPropertyDrawing*)&__ICustomPropertyDrawing; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {BE2B8CF7-DDCA-4D4B-BE26-2396B969F8E0}
	operator Vcleditors::_di_ICustomPropertyListDrawing()
	{
		Vcleditors::_di_ICustomPropertyListDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyListDrawing*(void) { return (Vcleditors::ICustomPropertyListDrawing*)&__ICustomPropertyListDrawing; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCurrencyEditButtonImageIndexProperty : public TElImageIndexProperty
{
	typedef TElImageIndexProperty inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetImagesPropertyName(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElCurrencyEditButtonImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TElImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElCurrencyEditButtonImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFormProperty : public Designeditors::TEnumProperty
{
	typedef Designeditors::TEnumProperty inherited;
	
private:
	System::Classes::TStringList* List;
	System::UnicodeString FormName;
	System::UnicodeString FileName;
	void __fastcall EnumProc(const System::UnicodeString FileName, const System::UnicodeString UnitName, const System::UnicodeString FormName, const System::UnicodeString DesignClass, System::Classes::TStrings* CoClasses);
	void __fastcall FNProc(const System::UnicodeString FileName, const System::UnicodeString UnitName, const System::UnicodeString FormName, const System::UnicodeString DesignClass, System::Classes::TStrings* CoClasses);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElFormProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TEnumProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElFormProperty(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHTMLContainerItemsProperty : public Colnedit::TCollectionProperty
{
	typedef Colnedit::TCollectionProperty inherited;
	
public:
	virtual Colnedit::TCollectionEditorClass __fastcall GetEditorClass(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElHTMLContainerItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Colnedit::TCollectionProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElHTMLContainerItemsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHTMLStringsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElHTMLStringsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElHTMLStringsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHTMLStringProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElHTMLStringProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElHTMLStringProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElMlCaptionProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElMlCaptionProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElMlCaptionProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSectionsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElSectionsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElSectionsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXSectionsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElXSectionsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElXSectionsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSideBarSectionImageIndexProperty : public TElImageIndexProperty
{
	typedef TElImageIndexProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElSideBarSectionImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TElImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElSideBarSectionImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSideBarItemImageIndexProperty : public TElImageIndexProperty
{
	typedef TElImageIndexProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElSideBarItemImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TElImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElSideBarItemImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TStrPoolItemsProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TStrPoolItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TStrPoolItemsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTabSheetImageIndexProperty : public TElImageIndexProperty
{
	typedef TElImageIndexProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElTabSheetImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TElImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElTabSheetImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElToolButtonImageIndexProperty : public TElImageIndexProperty
{
	typedef TElImageIndexProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElToolButtonImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TElImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElToolButtonImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWideStringsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDWideStringsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDWideStringsProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdelpe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELPE)
using namespace Plmdelpe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelpeHPP
