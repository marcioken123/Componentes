// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUnicodeControl.pas' rev: 34.00 (Windows)

#ifndef LmdunicodecontrolHPP
#define LmdunicodecontrolHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdunicodecontrol
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef Vcl::Controls::THintWindow TLMDHintWindow;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDCreateControlHandle(Vcl::Controls::TWinControl* AControl, const Vcl::Controls::TCreateParams &AParams, const Lmdtypes::TLMDString AStdClassName);
extern DELPHI_PACKAGE void __fastcall LMDCreateMDIWindowHandle(Vcl::Controls::TWinControl* AControl, const Vcl::Controls::TCreateParams &AParams, const Lmdtypes::TLMDString AStdClassName);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetControlText(Vcl::Controls::TControl* AControl);
extern DELPHI_PACKAGE void __fastcall LMDSetControlText(Vcl::Controls::TControl* AControl, const Lmdtypes::TLMDString AValue);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDGetCharFromMsg(const Winapi::Messages::TWMKey &AMessage);
extern DELPHI_PACKAGE void __fastcall LMDDefineUnicodeProperties(System::Classes::TFiler* const AFiler, System::Classes::TPersistent* const AInstance);
extern DELPHI_PACKAGE NativeInt __fastcall LMDSendMessage(HWND hWnd, unsigned Msg, NativeUInt wParam, NativeInt lParam);
extern DELPHI_PACKAGE void __fastcall LMDTextRect(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect, int X, int Y, const Lmdtypes::TLMDString Text);
}	/* namespace Lmdunicodecontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUNICODECONTROL)
using namespace Lmdunicodecontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdunicodecontrolHPP
