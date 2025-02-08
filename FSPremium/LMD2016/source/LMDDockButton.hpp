// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDockButton.pas' rev: 31.00 (Windows)

#ifndef LmddockbuttonHPP
#define LmddockbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomButton.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddockbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDockButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDockButton : public Lmdcustombutton::TLMDCustomButton
{
	typedef Lmdcustombutton::TLMDCustomButton inherited;
	
private:
	bool FAdjustSize;
	bool FChanging;
	bool FDocked;
	bool FDestroying;
	bool FReflect;
	Vcl::Controls::TWinControl* FControl;
	Lmdclass::TLMDDockPosition FPosition;
	int FMargin;
	System::Classes::TWndMethod FWndProcOld;
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
	MESSAGE void __fastcall CMReDock(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DockControl(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OwnWndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDDockButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDockButton(void);
	__property CtlXP = {default=1};
	
__published:
	__property bool AdjustDockedSize = {read=FAdjustSize, write=SetBoolean, index=0, default=1};
	__property Vcl::Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property bool Docked = {read=FDocked, write=SetBoolean, index=1, default=1};
	__property GlyphKind = {default=1};
	__property int Margin = {read=FMargin, write=SetMargin, default=1};
	__property Lmdclass::TLMDDockPosition Position = {read=FPosition, write=SetPosition, default=2};
	__property bool ReflectOwnChanges = {read=FReflect, write=SetBoolean, index=2, default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDockButton(HWND ParentWindow) : Lmdcustombutton::TLMDCustomButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddockbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCKBUTTON)
using namespace Lmddockbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddockbuttonHPP
