// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeDTPickEdit.pas' rev: 31.00 (Windows)

#ifndef EltreedtpickeditHPP
#define EltreedtpickeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDProcs.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElDTPick.hpp>
#include <ElTreeInplaceEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreedtpickedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceDateTimePicker;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceDateTimePicker : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetShowPopupCalendar(bool Value);
	bool __fastcall GetShowPopupCalendar(void);
	void __fastcall SetShowCalendarClock(bool Value);
	bool __fastcall GetShowCalendarClock(void);
	void __fastcall SetFormat(Eldtpick::TElDatePickerFormat Value);
	Eldtpick::TElDatePickerFormat __fastcall GetFormat(void);
	
protected:
	bool FIgnoreKillFocus;
	virtual void __fastcall AdjustBounds(void);
	Eldtpick::TElDateTimePicker* __fastcall GetEditor(void);
	void __fastcall CalDropDown(System::TObject* Sender);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElTreeInplaceDateTimePicker(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceDateTimePicker(void);
	__property Eldtpick::TElDateTimePicker* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Font;
	__property bool ShowPopupCalendar = {read=GetShowPopupCalendar, write=SetShowPopupCalendar, stored=true, nodefault};
	__property Eldtpick::TElDatePickerFormat Format = {read=GetFormat, write=SetFormat, stored=true, nodefault};
	__property bool CalendarShowClock = {read=GetShowCalendarClock, write=SetShowCalendarClock, stored=true, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreedtpickedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEDTPICKEDIT)
using namespace Eltreedtpickedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreedtpickeditHPP
