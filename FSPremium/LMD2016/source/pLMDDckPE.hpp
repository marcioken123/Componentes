// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDckPE.pas' rev: 31.00 (Windows)

#ifndef PlmddckpeHPP
#define PlmddckpeHPP

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
#include <System.Types.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <ToolsAPI.hpp>
#include <DesignIntf.hpp>
#include <PaletteAPI.hpp>
#include <ComponentDesigner.hpp>
#include <DesignEditors.hpp>
#include <DesignMenus.hpp>
#include <TreeIntf.hpp>
#include <VCLSprigs.hpp>
#include <VCLEditors.hpp>
#include <LMDDckCst.hpp>
#include <LMDDckClass.hpp>
#include <LMDDckSite.hpp>
#include <LMDDckStyles.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddckpe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDockSiteCompEditor;
class DELPHICLASS TLMDDockStyleNameProperty;
class DELPHICLASS TLMDDockImageIndexProperty;
class DELPHICLASS TLMDHeaderButtonImageIndexProperty;
class DELPHICLASS TLMDDockPanelSprig;
class DELPHICLASS TLMDNewDockPanelItem;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockSiteCompEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
private:
	void __fastcall GetParams(/* out */ Lmddcksite::TLMDDockSite* &ASite, /* out */ Lmddcksite::TLMDDockZone* &AZone);
	Lmddcksite::TLMDDockZone* __fastcall FindEmptyChild(Lmddcksite::TLMDDockZone* AZone);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall PrepareItem(int Index, const Designmenus::_di_IMenuItem AItem);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDDockSiteCompEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDockSiteCompEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockStyleNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDDockStyleNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDDockStyleNameProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockImageIndexProperty : public Designeditors::TIntegerProperty
{
	typedef Designeditors::TIntegerProperty inherited;
	
protected:
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
	virtual System::UnicodeString __fastcall GetImagesPropertyName(void);
	void __fastcall ListMeasureWidth(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	void __fastcall ListMeasureHeight(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	void __fastcall ListDrawValue(const System::UnicodeString Value, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDDockImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TIntegerProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDDockImageIndexProperty(void) { }
	
private:
	void *__ICustomPropertyListDrawing;	// Vcleditors::ICustomPropertyListDrawing 
	
public:
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
class PASCALIMPLEMENTATION TLMDHeaderButtonImageIndexProperty : public TLMDDockImageIndexProperty
{
	typedef TLMDDockImageIndexProperty inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetImagesPropertyName(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDHeaderButtonImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TLMDDockImageIndexProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDHeaderButtonImageIndexProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockPanelSprig : public Vclsprigs::TWinControlSprig
{
	typedef Vclsprigs::TWinControlSprig inherited;
	
public:
	virtual bool __fastcall DragOverTo(Treeintf::TSprig* AParent);
	virtual bool __fastcall DragDropTo(Treeintf::TSprig* AParent);
public:
	/* TWinControlSprig.Create */ inline __fastcall virtual TLMDDockPanelSprig(System::Classes::TPersistent* AItem)/* overload */ : Vclsprigs::TWinControlSprig(AItem) { }
	
public:
	/* TComponentSprig.Create */ inline __fastcall TLMDDockPanelSprig(System::Classes::TPersistent* AItem, Treeintf::TSprig* AOwner)/* overload */ : Vclsprigs::TWinControlSprig(AItem, AOwner) { }
	
public:
	/* TSprig.Destroy */ inline __fastcall virtual ~TLMDDockPanelSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewDockPanelItem : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Paletteapi::_di_IOTAPaletteServices FPalette;
	System::UnicodeString FHelpName;
	System::UnicodeString FHintText;
	System::UnicodeString FName;
	bool FVisible;
	bool FEnabled;
	Lmddcksite::TLMDDockPanel* FNewPanel;
	System::UnicodeString FNewPanelName;
	Lmddcksite::TLMDDockSite* FCurSite;
	void __fastcall CancelDrag(void);
	bool __fastcall TryGetSite(int X, int Y, /* out */ Lmddcksite::TLMDDockSite* &ASite);
	
protected:
	bool __fastcall GetCanDelete(void);
	System::UnicodeString __fastcall GetHelpName(void);
	System::UnicodeString __fastcall GetHintText(void);
	System::UnicodeString __fastcall GetIDString(void);
	System::UnicodeString __fastcall GetName(void);
	bool __fastcall GetVisible(void);
	bool __fastcall GetEnabled(void);
	void __fastcall SetHelpName(const System::UnicodeString Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetHintText(const System::UnicodeString Value);
	void __fastcall Execute(void);
	void __fastcall Delete(void);
	void __fastcall DragOver(Paletteapi::_di_IOTAPaletteDragAcceptor Target, int X, int Y, Paletteapi::TPalDragState State, bool &Accept);
	void __fastcall DragDrop(Paletteapi::_di_IOTAPaletteDragAcceptor Target, int X, int Y);
	
public:
	__fastcall TLMDNewDockPanelItem(const Paletteapi::_di_IOTAPaletteServices APalette);
	__classmethod void __fastcall Register(const System::UnicodeString APage);
	__classmethod void __fastcall Unregister();
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewDockPanelItem(void) { }
	
private:
	void *__IOTAPaletteDragDropOp;	// Paletteapi::IOTAPaletteDragDropOp 
	void *__IOTABasePaletteItem;	// Paletteapi::IOTABasePaletteItem 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A6364D92-37AB-4C39-ACA3-4CB1F8BD0C94}
	operator Paletteapi::_di_IOTAPaletteDragDropOp()
	{
		Paletteapi::_di_IOTAPaletteDragDropOp intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Paletteapi::IOTAPaletteDragDropOp*(void) { return (Paletteapi::IOTAPaletteDragDropOp*)&__IOTAPaletteDragDropOp; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {9CAEBEBF-6BFB-4E9A-B5E7-C3146DEFA6E8}
	operator Paletteapi::_di_IOTABasePaletteItem()
	{
		Paletteapi::_di_IOTABasePaletteItem intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Paletteapi::IOTABasePaletteItem*(void) { return (Paletteapi::IOTABasePaletteItem*)&__IOTABasePaletteItem; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmddckpe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDCKPE)
using namespace Plmddckpe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddckpeHPP
