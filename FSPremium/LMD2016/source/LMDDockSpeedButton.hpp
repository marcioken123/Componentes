// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDockSpeedButton.pas' rev: 31.00 (Windows)

#ifndef LmddockspeedbuttonHPP
#define LmddockspeedbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddockspeedbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDockSpeedButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDockSpeedButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
private:
	bool FAdjustSize;
	bool FChanging;
	bool FDocked;
	bool FDestroying;
	bool FReflect;
	Vcl::Controls::TWinControl* FControl;
	Lmdclass::TLMDDockPosition FPosition;
	int FMargin;
	void *FWndProc;
	void *FWndProcOld;
	void __fastcall SetBoolean(int Index, bool aValue);
	void __fastcall SetControl(Vcl::Controls::TWinControl* aValue);
	void __fastcall SetMargin(int aValue);
	void __fastcall SetPosition(Lmdclass::TLMDDockPosition aValue);
	void __fastcall AdjustToControl(void);
	void __fastcall AdjustToButton(void);
	void __fastcall InitWndProc(void);
	void __fastcall RestoreWndProc(void);
	HIDESBASE bool __fastcall HasControl(void);
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Paint(void);
	void __fastcall DockControl(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OwnWndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDDockSpeedButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDockSpeedButton(void);
	__property Style;
	
__published:
	__property bool AdjustDockedSize = {read=FAdjustSize, write=SetBoolean, index=0, default=1};
	__property ButtonStyle = {default=1};
	__property Vcl::Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property bool Docked = {read=FDocked, write=SetBoolean, index=1, default=1};
	__property GlyphKind = {default=1};
	__property int Margin = {read=FMargin, write=SetMargin, default=1};
	__property Lmdclass::TLMDDockPosition Position = {read=FPosition, write=SetPosition, default=2};
	__property bool ReflectOwnChanges = {read=FReflect, write=SetBoolean, index=2, default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddockspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCKSPEEDBUTTON)
using namespace Lmddockspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddockspeedbuttonHPP
