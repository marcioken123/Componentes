// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMessageHintController.pas' rev: 31.00 (Windows)

#ifndef LmdmessagehintcontrollerHPP
#define LmdmessagehintcontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomShapeHint.hpp>
#include <LMDMessageHint.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmessagehintcontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMessageSetItem;
class DELPHICLASS TLMDMessageSet;
class DELPHICLASS TLMDMessageHintController;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMessageSetItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FTitle;
	Lmdtypes::TLMDString FMsgString;
	Vcl::Controls::TControl* FControl;
	System::Uitypes::TColor FColor;
	int FDisplayOrder;
	Lmdcustomshapehint::TLMDHintIconType FIcon;
	void __fastcall SetMsgString(const Lmdtypes::TLMDString Value);
	void __fastcall SetControl(Vcl::Controls::TControl* const Value);
	void __fastcall SetDisplayOrder(const int Value);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetIcon(const Lmdcustomshapehint::TLMDHintIconType Value);
	
public:
	__fastcall virtual TLMDMessageSetItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDMessageSetItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property int DisplayOrder = {read=FDisplayOrder, write=SetDisplayOrder, nodefault};
	__property Lmdcustomshapehint::TLMDHintIconType Icon = {read=FIcon, write=SetIcon, nodefault};
	__property Lmdtypes::TLMDString MessageString = {read=FMsgString, write=SetMsgString};
	__property Lmdtypes::TLMDString Title = {read=FTitle, write=SetTitle};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMessageSet : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDMessageSetItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDMessageHintController* FOwner;
	HIDESBASE TLMDMessageSetItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDMessageSetItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDMessageSet(TLMDMessageHintController* Owner);
	__fastcall virtual ~TLMDMessageSet(void);
	HIDESBASE TLMDMessageSetItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	__property TLMDMessageSetItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDMessageHintController : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdmessagehint::TLMDMessageHint* FMessageHintControl;
	TLMDMessageSet* FMessages;
	void __fastcall SetItems(TLMDMessageSet* const Value);
	void __fastcall SetMessageHintControl(Lmdmessagehint::TLMDMessageHint* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDMessageHintController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMessageHintController(void);
	void __fastcall HideMessages(int DisplayOrder = 0xffffffff);
	void __fastcall ShowMessages(int DisplayOrder = 0xffffffff);
	
__published:
	__property About = {default=0};
	__property TLMDMessageSet* Items = {read=FMessages, write=SetItems};
	__property Lmdmessagehint::TLMDMessageHint* MessageHintControl = {read=FMessageHintControl, write=SetMessageHintControl};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmessagehintcontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMESSAGEHINTCONTROLLER)
using namespace Lmdmessagehintcontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmessagehintcontrollerHPP
