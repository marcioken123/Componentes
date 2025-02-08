// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSEditEvents.pas' rev: 31.00 (Windows)

#ifndef JsediteventsHPP
#define JsediteventsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <JSEditDialog.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <JSTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jseditevents
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSEditEvents;
class DELPHICLASS TJSMemoEvents;
class DELPHICLASS TJSComboEvents;
class DELPHICLASS TJSListEvents;
class DELPHICLASS TJSDateEvents;
class DELPHICLASS TJSTimeEvents;
class DELPHICLASS TJSCalendarEvents;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSEditEvents : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall GetEditControlClass(System::TObject* Sender, const int Index, Vcl::Controls::TControlClass &ControlClass);
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall InitialiseEditHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
	virtual void __fastcall GetControlHeightHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, int &Height);
public:
	/* TObject.Create */ inline __fastcall TJSEditEvents(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TJSEditEvents(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TJSEditEventClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSMemoEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
public:
	virtual void __fastcall GetControlHeightHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, int &Height);
public:
	/* TObject.Create */ inline __fastcall TJSMemoEvents(void) : TJSEditEvents() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TJSMemoEvents(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSComboEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
protected:
	bool FFixedList;
	int FSelectedIndex;
	
public:
	__fastcall virtual TJSComboEvents(const bool AFixedList, const int ASelectedIndex);
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall InitialiseEditHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
	__property int SelectedIndex = {read=FSelectedIndex, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TJSComboEvents(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TJSComboEventClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSListEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
protected:
	int FSelectedIndex;
	bool FIgnoreIndex;
	
public:
	__fastcall virtual TJSListEvents(const int ASelectedIndex);
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall InitialiseEditHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
	virtual void __fastcall GetControlHeightHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, int &Height);
	__property int SelectedIndex = {read=FSelectedIndex, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TJSListEvents(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TJSListEventClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSDateEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
public:
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
public:
	/* TObject.Create */ inline __fastcall TJSDateEvents(void) : TJSEditEvents() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TJSDateEvents(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSTimeEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
public:
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
public:
	/* TObject.Create */ inline __fastcall TJSTimeEvents(void) : TJSEditEvents() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TJSTimeEvents(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSCalendarEvents : public TJSEditEvents
{
	typedef TJSEditEvents inherited;
	
public:
	virtual void __fastcall GetEditValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);
	virtual void __fastcall SetDefaultValueHandler(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);
public:
	/* TObject.Create */ inline __fastcall TJSCalendarEvents(void) : TJSEditEvents() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TJSCalendarEvents(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 JSED_IGNORE_INDEX = System::Int8(-2);
extern DELPHI_PACKAGE void __fastcall RegisterEventClass(const Jseditdialog::TJSEditType AEditType, TJSEditEventClass AEventClass);
extern DELPHI_PACKAGE TJSEditEventClass __fastcall GetEventClass(const Jseditdialog::TJSEditType AEditType);
}	/* namespace Jseditevents */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSEDITEVENTS)
using namespace Jseditevents;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsediteventsHPP
