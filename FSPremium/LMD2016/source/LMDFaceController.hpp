// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFaceController.pas' rev: 31.00 (Windows)

#ifndef LmdfacecontrollerHPP
#define LmdfacecontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFillObject.hpp>
#include <LMDBevel.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDCFCStateObject.hpp>
#include <LMDCFCSettingObject.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDStyleMan.hpp>
#include <LMDBaseController.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfacecontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFaceController;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSetFaceControllerEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, bool &ACanSetController);

class PASCALIMPLEMENTATION TLMDFaceController : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDSetFaceControllerEvent FOnSetFaceController;
	Lmdbasecontroller::TLMDChangeLink* FStyleMgrLink;
	Lmdstyleman::TLMDStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FUpdatingStyle;
	Lmdcfcsettingobject::TLMDCFCSettingObjects* FSettingObjects;
	System::Classes::TList* FControls;
	Lmdcfcstateobject::TLMDCFCStateObjects* FDefinedStates;
	void __fastcall SetStateObjects(Lmdcfcstateobject::TLMDCFCStateObjects* anObject);
	void __fastcall SetSettingObjects(Lmdcfcsettingobject::TLMDCFCSettingObjects* aValue);
	void __fastcall LoadSettingsFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveSettingsToStream(System::Classes::TStream* Stream);
	void __fastcall SetStyleManager(Lmdstyleman::TLMDStyleManager* AValue);
	
protected:
	void __fastcall ApplyStateStyle(Vcl::Controls::TControl* aControl, const Lmdcfcstateobject::TLMDStateList &AState);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall controlFocused(Vcl::Controls::TControl* aControl);
	bool __fastcall controlMouseAbove(Vcl::Controls::TControl* aControl);
	bool __fastcall controlTransparent(Vcl::Controls::TControl* aControl);
	bool __fastcall controlBackCtlXP(Vcl::Controls::TControl* aControl);
	System::Uitypes::TColor __fastcall controlBackColor(Vcl::Controls::TControl* aControl);
	bool __fastcall controlBorderCtlXP(Vcl::Controls::TControl* aControl);
	bool __fastcall controlBorderCtl3D(Vcl::Controls::TControl* aControl);
	bool __fastcall controlPressed(Vcl::Controls::TControl* aControl);
	bool __fastcall controlModified(Vcl::Controls::TControl* aControl);
	bool __fastcall controlReadOnly(Vcl::Controls::TControl* aControl);
	bool __fastcall controlWrongData(Vcl::Controls::TControl* aControl);
	bool __fastcall controlDisabled(Vcl::Controls::TControl* aControl);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall SetStyleName(const System::UnicodeString AValue);
	System::Classes::TPersistent* __fastcall GetStateObject(Vcl::Controls::TControl* aControl, System::Classes::TPersistentClass objectClass);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDFaceController(System::Classes::TComponent* aComponent);
	__fastcall virtual ~TLMDFaceController(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall AddSettingObject(System::Classes::TPersistent* aSettingObject)/* overload */;
	int __fastcall AddSettingObject(Lmdcfcsettingobject::TLMDCFCSettingObjectKind aKind)/* overload */;
	void __fastcall FillControlList(void);
	void __fastcall StateChanged(Vcl::Controls::TControl* aControl)/* overload */;
	void __fastcall RemoveSettingObject(System::Classes::TPersistent* aSettingObject);
	Vcl::Graphics::TFont* __fastcall GetFont(Vcl::Controls::TControl* aControl);
	Lmd3dcaption::TLMD3DCaption* __fastcall GetFont3D(Vcl::Controls::TControl* aControl);
	bool __fastcall GetTransparent(Vcl::Controls::TControl* aControl);
	bool __fastcall GetBackCtlXP(Vcl::Controls::TControl* aControl);
	System::Uitypes::TColor __fastcall GetBackColor(Vcl::Controls::TControl* aControl);
	Lmdfillobject::TLMDFillObject* __fastcall GetFillObject(Vcl::Controls::TControl* aControl);
	Lmdbitmapeffectobject::TLMDBitmapEffectObject* __fastcall GetBackFX(Vcl::Controls::TControl* aControl);
	bool __fastcall GetBorderCtlXP(Vcl::Controls::TControl* aControl);
	bool __fastcall GetBorderCtl3D(Vcl::Controls::TControl* aControl);
	Lmdbevel::TLMDBevel* __fastcall GetBevel(Vcl::Controls::TControl* aControl);
	Lmdcfcstateobject::TLMDCFCStateObject* __fastcall findState(Vcl::Controls::TControl* aControl);
	bool __fastcall Paint(Vcl::Controls::TControl* aControl);
	void __fastcall RegisterControl(Vcl::Controls::TControl* aControl);
	void __fastcall UnregisterControl(Vcl::Controls::TControl* aControl);
	void __fastcall LoadFromFile(const System::UnicodeString aFilename);
	void __fastcall SaveToFile(const System::UnicodeString aFilename);
	void __fastcall UpdateControls(void);
	void __fastcall UpdateStyle(void);
	__property Lmdcfcsettingobject::TLMDCFCSettingObjects* Settings = {read=FSettingObjects, write=SetSettingObjects};
	
__published:
	__property About = {default=0};
	__property Lmdcfcstateobject::TLMDCFCStateObjects* States = {read=FDefinedStates, write=SetStateObjects};
	__property Lmdstyleman::TLMDStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property TLMDSetFaceControllerEvent OnSetFaceController = {read=FOnSetFaceController, write=FOnSetFaceController};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfacecontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFACECONTROLLER)
using namespace Lmdfacecontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfacecontrollerHPP
