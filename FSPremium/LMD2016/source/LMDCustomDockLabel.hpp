// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomDockLabel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomdocklabelHPP
#define LmdcustomdocklabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomdocklabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomDockLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomDockLabel : public Lmdcustomsimplelabel::TLMDCustomSimpleLabel
{
	typedef Lmdcustomsimplelabel::TLMDCustomSimpleLabel inherited;
	
private:
	bool FAdjustSize;
	bool FChanging;
	bool FDocked;
	bool FDestroying;
	bool FReflect;
	Lmdclass::TLMDDockPosition FPosition;
	int FMargin;
	void *FWndProc;
	void *FWndProcOld;
	void __fastcall SetBoolean(int Index, bool aValue);
	HIDESBASE void __fastcall SetControl(Vcl::Controls::TWinControl* aValue);
	void __fastcall SetMargin(int aValue);
	void __fastcall SetPosition(Lmdclass::TLMDDockPosition aValue);
	void __fastcall AdjustToControl(void);
	void __fastcall AdjustToLabel(void);
	void __fastcall InitWndProc(void);
	void __fastcall RestoreWndProc(void);
	HIDESBASE bool __fastcall HasControl(void);
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DockControl(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OwnWndProc(Winapi::Messages::TMessage &Message);
	__property bool AdjustDockedSize = {read=FAdjustSize, write=SetBoolean, index=0, default=0};
	__property bool Docked = {read=FDocked, write=SetBoolean, index=1, default=1};
	__property Vcl::Controls::TWinControl* FocusControl = {read=GetControl, write=SetControl};
	__property int Margin = {read=FMargin, write=SetMargin, default=1};
	__property Lmdclass::TLMDDockPosition Position = {read=FPosition, write=SetPosition, default=1};
	__property bool ReflectOwnChanges = {read=FReflect, write=SetBoolean, index=2, default=0};
	
public:
	__fastcall virtual TLMDCustomDockLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomDockLabel(void);
	virtual void __fastcall CorrectBounds(void);
	
__published:
	__property About = {default=0};
	__property Action;
	__property Align = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomdocklabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMDOCKLABEL)
using namespace Lmdcustomdocklabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomdocklabelHPP
