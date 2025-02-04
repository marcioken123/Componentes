// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sPopupClndr.pas' rev: 27.00 (Windows)

#ifndef SpopupclndrHPP
#define SpopupclndrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <sMonthCalendar.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Spopupclndr
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsPopupCalendar;
class PASCALIMPLEMENTATION TsPopupCalendar : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Smonthcalendar::TsMonthCalendar* sMonthCalendar1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* OK1;
	Vcl::Menus::TMenuItem* Cancel1;
	void __fastcall sToolButton3Click(System::TObject* Sender);
	void __fastcall sToolButton1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CalendarClick(void);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TMessage &Message);
	
protected:
	System::Classes::TNotifyEvent FCloseUp;
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	System::Variant __fastcall GetValue(void);
	void __fastcall SetValue(const System::Variant &Value);
	void __fastcall FillArOR(void);
	HRGN __fastcall GetRgnFromArOR(void);
	
public:
	Scustomcomboedit::TsCustomComboEdit* FEditor;
	bool __fastcall IsValidDate(System::TDateTime Date);
	void __fastcall CloseUp(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property Smonthcalendar::TsMonthCalendar* FCalendar = {read=sMonthCalendar1, write=sMonthCalendar1};
	__property System::Classes::TNotifyEvent OnCloseUp = {read=FCloseUp, write=FCloseUp};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TsPopupCalendar(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TsPopupCalendar(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TsPopupCalendar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsPopupCalendar(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Byte FormHeight = System::Byte(0x90);
}	/* namespace Spopupclndr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SPOPUPCLNDR)
using namespace Spopupclndr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SpopupclndrHPP
