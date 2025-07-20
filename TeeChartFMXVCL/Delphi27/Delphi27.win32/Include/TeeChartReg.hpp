// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeChartReg.pas' rev: 34.00 (Windows)

#ifndef TeechartregHPP
#define TeechartregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <PropertyCategories.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeGDIPlusEditor.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teechartreg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeClassProperty;
class DELPHICLASS TChartClassProperty;
class DELPHICLASS TChartCompEditor;
class DELPHICLASS TTeeGDIPlusCompEditor;
class DELPHICLASS TTeePanelSelectionEditor;
class DELPHICLASS TChartSeriesEditor;
class DELPHICLASS TChartPenProperty;
class DELPHICLASS TChartBrushProperty;
class DELPHICLASS TPreviewPanelCompEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeClassProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
protected:
	int __fastcall GetObject();
	
public:
	virtual System::UnicodeString __fastcall GetValue();
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TTeeClassProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TTeeClassProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartClassProperty : public TTeeClassProperty
{
	typedef TTeeClassProperty inherited;
	
protected:
	void __fastcall InternalEditPage(Vcltee::Chart::TCustomChart* AChart, int APage);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes();
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TChartClassProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TTeeClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TChartClassProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartCompEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
protected:
	virtual Vcltee::Chart::TCustomChart* __fastcall Chart();
	
public:
	virtual void __fastcall Edit();
	virtual void __fastcall ExecuteVerb(int Index);
	virtual int __fastcall GetVerbCount();
	virtual System::UnicodeString __fastcall GetVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TChartCompEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TChartCompEditor() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeGDIPlusCompEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
protected:
	virtual Vcltee::Teegdiplus::TTeeGDIPlus* __fastcall GDIPlus();
	
public:
	virtual void __fastcall Edit();
	virtual void __fastcall ExecuteVerb(int Index);
	virtual int __fastcall GetVerbCount();
	virtual System::UnicodeString __fastcall GetVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TTeeGDIPlusCompEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTeeGDIPlusCompEditor() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeePanelSelectionEditor : public Designeditors::TSelectionEditor
{
	typedef Designeditors::TSelectionEditor inherited;
	
public:
	virtual void __fastcall RequiresUnits(System::Classes::TGetStrProc Proc);
public:
	/* TSelectionEditor.Create */ inline __fastcall virtual TTeePanelSelectionEditor(const Designintf::_di_IDesigner ADesigner) : Designeditors::TSelectionEditor(ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTeePanelSelectionEditor() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartSeriesEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit();
	virtual void __fastcall ExecuteVerb(int Index);
	virtual int __fastcall GetVerbCount();
	virtual System::UnicodeString __fastcall GetVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TChartSeriesEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TChartSeriesEditor() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartPenProperty : public TChartClassProperty
{
	typedef TChartClassProperty inherited;
	
public:
	virtual void __fastcall Edit();
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TChartPenProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TChartClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TChartPenProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartBrushProperty : public TChartClassProperty
{
	typedef TChartClassProperty inherited;
	
public:
	virtual void __fastcall Edit();
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TChartBrushProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TChartClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TChartBrushProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPreviewPanelCompEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual int __fastcall GetVerbCount();
	virtual System::UnicodeString __fastcall GetVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TPreviewPanelCompEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPreviewPanelCompEditor() { }
	
};

#pragma pack(pop)

typedef Designintf::_di_IDesigner TTeeDesigner;

typedef void __fastcall (*TTeeEditSeriesProc)(Vcltee::Teengine::TChartSeries* ASeries, Designintf::_di_IDesigner ADesigner);

typedef void __fastcall (*TTeeChartEditorHook)(Designintf::_di_IDesigner ADesigner, Vcltee::Teengine::TCustomSeriesList* AList, TTeeEditSeriesProc EditSeriesProc, Vcltee::Teengine::TSeriesGroup* AGroup/* = (Vcltee::Teengine::TSeriesGroup*)(0x0)*/);

typedef void __fastcall (*TTeeDesignOptionsHook)(void);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TTeeChartEditorHook TeeChartEditorHook;
extern DELPHI_PACKAGE TTeeDesignOptionsHook TeeDesignOptionsHook;
extern DELPHI_PACKAGE void __fastcall EditChartDesign(Vcltee::Chart::TCustomChart* AChart);
extern DELPHI_PACKAGE void __fastcall EditSeriesProc(Vcltee::Teengine::TChartSeries* ASeries, Designintf::_di_IDesigner ADesigner);
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Teechartreg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECHARTREG)
using namespace Teechartreg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeechartregHPP
