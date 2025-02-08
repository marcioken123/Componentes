// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUtils.pas' rev: 34.00 (Windows)

#ifndef LmdutilsHPP
#define LmdutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::LongBool __stdcall LMDAlphaBlend(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, _BLENDFUNCTION p11);
extern DELPHI_PACKAGE System::LongBool __stdcall LMDTransparentBlt(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, unsigned p11);
extern DELPHI_PACKAGE void __fastcall LMDDrawTriangle(Vcl::Graphics::TCanvas* aCanvas, int x, int y, int size, System::Uitypes::TColor Col, bool Down, bool Enabled);
extern DELPHI_PACKAGE bool __fastcall LMDIsTrueTypeFont(Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE bool __fastcall LMDIsTrueTypeFontCheck(Vcl::Graphics::TCanvas* aCanvas);
extern DELPHI_PACKAGE int __fastcall LMDGetFontHeight(Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE bool __fastcall LMDIsChild(Vcl::Controls::TControl* Parent, Vcl::Controls::TControl* Child);
extern DELPHI_PACKAGE void __fastcall LMDSetEnabledState(Vcl::Controls::TWinControl* Container, bool aValue);
extern DELPHI_PACKAGE System::LongBool __fastcall LMDInvalidateRect(HWND hWnd, const System::Types::TRect &lpRect, System::LongBool bErase);
extern DELPHI_PACKAGE void __fastcall LMDLoadCustomColorFromIniFile(const System::UnicodeString filename, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDLoadCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDSaveCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDSaveCustomColorToIniFile(const System::UnicodeString Filename, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE HWND __fastcall LMDAllocateHWND(System::TObject* Obj, Lmdtypes::TLMDWndMethod WndMethod)/* overload */;
extern DELPHI_PACKAGE HWND __fastcall LMDAllocateHWND(System::TObject* Obj, Lmdtypes::TLMDWndMethod WndMethod, System::UnicodeString AWindowClass, System::UnicodeString AWindowName)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDeallocateHWND(HWND Wnd);
extern DELPHI_PACKAGE void __fastcall LMDActivatePrevInstance(void);
extern DELPHI_PACKAGE bool __fastcall LMDSetForegroundWindow(NativeUInt HWnd);
extern DELPHI_PACKAGE void __fastcall LMDWait(unsigned ms);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall LMDCenterChild(Vcl::Forms::TCustomForm* frmParent, Vcl::Forms::TCustomForm* frmchild, bool flag = true);
extern DELPHI_PACKAGE void __fastcall LMDCenterForm(Vcl::Forms::TCustomForm* frm);
extern DELPHI_PACKAGE void __fastcall LMDCenterChildWindow(HWND Parent, HWND Child, bool AtTop);
extern DELPHI_PACKAGE void __fastcall LMDCenterWindow(HWND Wnd, bool AtTop = false);
extern DELPHI_PACKAGE void __fastcall LMDPositionWindow(HWND Wnd, const System::Types::TRect &aRect, Lmdclass::TLMDDlgPosition APos, bool AtTop);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDDlgGetTargetRect(Lmdclass::TLMDDlgPosRel aRel);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall LMDShowModal(Vcl::Forms::TFormClass aClass, System::Classes::TComponent* owner);
extern DELPHI_PACKAGE void __fastcall LMDExplodeForm(Vcl::Forms::TCustomForm* aForm);
extern DELPHI_PACKAGE void __fastcall LMDExplodeFormExt(Vcl::Forms::TCustomForm* aForm, int X, int Y, int Steps, int Delay);
extern DELPHI_PACKAGE Vcl::Forms::TForm* __fastcall LMDGetOwnerForm(System::Classes::TComponent* Component);
extern DELPHI_PACKAGE Vcl::Controls::TWinControl* __fastcall LMDGetOwnerFrameForm(System::Classes::TComponent* Component);
extern DELPHI_PACKAGE void __fastcall LMDExplodeForm2(Vcl::Forms::TCustomForm* aForm);
extern DELPHI_PACKAGE void __fastcall LMDExplodeFormExt2(Vcl::Forms::TCustomForm* aForm, int X, int Y, int Steps, int smWidth, int smHeight, int Delay, bool flag);
extern DELPHI_PACKAGE bool __fastcall LMDHasClipboardFormat(NativeUInt Handle, int Index);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDGetClipboardFormatName(int AFormat);
extern DELPHI_PACKAGE int __fastcall LMDGetClipboardFormatIndex(const System::UnicodeString FormatName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDConvertVCLHint(const Lmdtypes::TLMDString Hint);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDConvertUnicodeHint(const System::UnicodeString AHint);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetShortHint(System::WideString Hint);
extern DELPHI_PACKAGE void __fastcall LMDConvertVCLHintShow(const System::UnicodeString InHint, const Lmdtypes::TLMDString FHint, Vcl::Controls::TCMHintShow &Message);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDConvertBreaksFormat(Lmdtypes::TLMDString Text);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetTextFromClipBoard(void);
extern DELPHI_PACKAGE void __fastcall LMDCopyTextToClipboard(Lmdtypes::TLMDString aText, bool aConvertBreaksFmt = false);
}	/* namespace Lmdutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUTILS)
using namespace Lmdutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdutilsHPP
