// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateTimePicker.pas' rev: 31.00 (Windows)

#ifndef LmddatetimepickerHPP
#define LmddatetimepickerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCalendar.hpp>
#include <LMDCustomDateTimePicker.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddatetimepicker
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDateTimePicker;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDateTimePicker : public Lmdcustomdatetimepicker::TLMDCustomDateTimePicker
{
	typedef Lmdcustomdatetimepicker::TLMDCustomDateTimePicker inherited;
	
public:
	/* TLMDCustomDateTimePicker.Create */ inline __fastcall virtual TLMDDateTimePicker(System::Classes::TComponent* aOwner) : Lmdcustomdatetimepicker::TLMDCustomDateTimePicker(aOwner) { }
	/* TLMDCustomDateTimePicker.Destroy */ inline __fastcall virtual ~TLMDDateTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDateTimePicker(HWND ParentWindow) : Lmdcustomdatetimepicker::TLMDCustomDateTimePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddatetimepicker */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATETIMEPICKER)
using namespace Lmddatetimepicker;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddatetimepickerHPP
