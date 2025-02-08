// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMessageHint.pas' rev: 31.00 (Windows)

#ifndef LmdmessagehintHPP
#define LmdmessagehintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomShapeHint.hpp>
#include <LMDShapeHint.hpp>
#include <LMDCustomHint.hpp>
#include <LMDNativeHint.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <LMDButtonBase.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGradient.hpp>
#include <LMDShadow.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmessagehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMessageHint;
class DELPHICLASS TLMDMessageHintWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMessageHint : public Lmdcustomshapehint::TLMDCustomShapeHint
{
	typedef Lmdcustomshapehint::TLMDCustomShapeHint inherited;
	
private:
	bool FSetCapture;
	bool FAllowMultipleHints;
	bool __fastcall GetState(void);
	void __fastcall SetAllowMultipleHints(const bool Value);
	
protected:
	virtual bool __fastcall NeedHintHook(void);
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	virtual void __fastcall DoHide(Vcl::Controls::THintWindow* Sender);
	
public:
	__fastcall virtual TLMDMessageHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMessageHint(void);
	void __fastcall HideMessage(void)/* overload */;
	void __fastcall HideMessage(TLMDMessageHintWindow* AWindow)/* overload */;
	virtual void __fastcall HideMessages(int aDisplayOrder = 0xffffffff);
	void __fastcall ShowMessage(const System::UnicodeString Msg, int x, int y, Lmdtypes::TLMDString aTitle = Lmdtypes::TLMDString(), System::Uitypes::TColor aColor = (System::Uitypes::TColor)(0x1fffffff), Lmdcustomshapehint::TLMDHintIconType aIcon = (Lmdcustomshapehint::TLMDHintIconType)(0x2), int aDisplayOrder = 0xffffffff);
	void __fastcall ShowControlMessage(const System::UnicodeString Msg, Vcl::Controls::TControl* aControl, Lmdtypes::TLMDString aTitle = Lmdtypes::TLMDString(), System::Uitypes::TColor aColor = (System::Uitypes::TColor)(0x1fffffff), Lmdcustomshapehint::TLMDHintIconType aIcon = (Lmdcustomshapehint::TLMDHintIconType)(0x2), int aDisplayOrder = 0xffffffff);
	__property bool IsDisplaying = {read=GetState, nodefault};
	
__published:
	__property bool AllowMultipleHints = {read=FAllowMultipleHints, write=SetAllowMultipleHints, nodefault};
	__property CloseBtnType = {default=1};
	__property CloseBtnStyle = {default=1};
	__property DefaultTitle = {default=0};
	__property Distance = {default=1};
	__property Enabled = {default=1};
	__property Font3D;
	__property Gradient;
	__property HideAccelChar = {default=1};
	__property NoseLength = {default=25};
	__property NoseWidth = {default=25};
	__property NoseAngleWidth = {default=25};
	__property Options;
	__property Position = {default=1};
	__property RoundRectWidth = {default=18};
	__property bool SetCapture = {read=FSetCapture, write=FSetCapture, default=1};
	__property Shadow;
	__property Style = {default=4};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TitleFont;
	__property TitleFont3D;
	__property UseGradient = {default=0};
	__property UseSystemShadow = {default=0};
};


class PASCALIMPLEMENTATION TLMDMessageHintWindow : public Lmdcustomshapehint::TLMDShapeHintWindow
{
	typedef Lmdcustomshapehint::TLMDShapeHintWindow inherited;
	
protected:
	int FDisplayOrder;
	virtual void __fastcall PreCreateWnd(void);
	
public:
	__property int DisplayOrder = {read=FDisplayOrder, nodefault};
public:
	/* TLMDShapeHintWindow.Create */ inline __fastcall virtual TLMDMessageHintWindow(System::Classes::TComponent* AOwner) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner) { }
	/* TLMDShapeHintWindow.Destroy */ inline __fastcall virtual ~TLMDMessageHintWindow(void) { }
	
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDMessageHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner, AHintControl) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDMessageHintWindow(HWND ParentWindow) : Lmdcustomshapehint::TLMDShapeHintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmessagehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMESSAGEHINT)
using namespace Lmdmessagehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmessagehintHPP
