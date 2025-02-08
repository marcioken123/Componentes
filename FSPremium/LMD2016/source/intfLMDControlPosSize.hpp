// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDControlPosSize.pas' rev: 31.00 (Windows)

#ifndef IntflmdcontrolpossizeHPP
#define IntflmdcontrolpossizeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Intflmdcontrolpossize
{
//-- forward type declarations -----------------------------------------------
__interface ILMDControlPosSize;
typedef System::DelphiInterface<ILMDControlPosSize> _di_ILMDControlPosSize;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{EE3AFF62-E73A-41F2-B04D-D24710377EBD}") ILMDControlPosSize  : public System::IInterface 
{
	virtual bool __fastcall get_AllowMoving(void) = 0 ;
	virtual void __fastcall set_AllowMoving(const bool aValue) = 0 ;
	virtual bool __fastcall get_AllowSizing(void) = 0 ;
	virtual void __fastcall set_AllowSizing(const bool aValue) = 0 ;
	virtual bool __fastcall get_ControlLocked(void) = 0 ;
	virtual void __fastcall set_ControlLocked(const bool aValue) = 0 ;
	virtual System::Types::TRect __fastcall GetMoveRect(void) = 0 ;
	virtual void __fastcall set_OnMove(const System::Classes::TNotifyEvent aValue) = 0 ;
	virtual System::Classes::TNotifyEvent __fastcall get_OnMove(void) = 0 ;
	__property bool AllowMoving = {read=get_AllowMoving, write=set_AllowMoving};
	__property bool AllowSizing = {read=get_AllowSizing, write=set_AllowSizing};
	__property bool ControlLocked = {read=get_ControlLocked, write=set_ControlLocked};
	__property System::Classes::TNotifyEvent OnMove = {read=get_OnMove, write=set_OnMove};
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDSetCtlLocked(Vcl::Forms::TCustomForm* aParent, bool Value)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSetCtlLocked(Vcl::Controls::TWinControl* aParent, bool Value)/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall LMDControlSizingHitTest(HWND Handle, const System::Types::TPoint &cPos, const System::Types::TRect &CRect, System::Byte bs);
}	/* namespace Intflmdcontrolpossize */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDCONTROLPOSSIZE)
using namespace Intflmdcontrolpossize;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdcontrolpossizeHPP
