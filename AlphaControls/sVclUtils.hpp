// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sVclUtils.pas' rev: 27.00 (Windows)

#ifndef SvclutilsHPP
#define SvclutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <Vcl.Themes.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acDials.hpp>	// Pascal unit
#include <acThdTimer.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Svclutils
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (*TacIterProc)(Vcl::Controls::TControl* Ctrl, int Data);

class DELPHICLASS TOutputWindow;
class PASCALIMPLEMENTATION TOutputWindow : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TOutputWindow(System::Classes::TComponent* AOwner);
	__property Canvas;
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TOutputWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TOutputWindow(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TacHideTimer;
class PASCALIMPLEMENTATION TacHideTimer : public Acthdtimer::TacThreadedTimer
{
	typedef Acthdtimer::TacThreadedTimer inherited;
	
public:
	Acdials::TacDialogWnd* Dlg;
	NativeUInt ParentWnd;
	HDC DC;
	Vcl::Forms::TForm* Form;
	System::Types::TSize FBmpSize;
	System::Types::TPoint FBmpTopLeft;
	_BLENDFUNCTION FBlend;
	double dx;
	double dy;
	double l;
	double t;
	double r;
	double b;
	int StartBlendValue;
	int i;
	int StepCount;
	Sconst::TacAnimType AnimType;
	bool EventCalled;
	double Trans;
	double p;
	Vcl::Graphics::TBitmap* SrcBmp;
	Vcl::Graphics::TBitmap* DstBmp;
	void __fastcall Anim_Init(void);
	void __fastcall CallEvent(void);
	void __fastcall Anim_DoNext(void);
	void __fastcall Anim_GoToNext(void);
	void __fastcall OnTimerProc(System::TObject* Sender);
	__fastcall virtual TacHideTimer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacHideTimer(void);
public:
	/* TacThreadedTimer.CreateOwned */ inline __fastcall virtual TacHideTimer(System::Classes::TComponent* AOwner, bool ChangeEvent) : Acthdtimer::TacThreadedTimer(AOwner, ChangeEvent) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<int, 3> AlignToInt;
extern DELPHI_PACKAGE TOutputWindow* ow;
extern DELPHI_PACKAGE bool InAnimationProcess;
extern DELPHI_PACKAGE bool acGraphPainting;
extern DELPHI_PACKAGE NativeUInt uxthemeLib;
extern DELPHI_PACKAGE HRESULT __stdcall (*Ac_SetWindowTheme)(HWND hwnd, System::WideChar * pszSubAppName, System::WideChar * pszSubIdList);
extern DELPHI_PACKAGE TacHideTimer* acHideTimer;
extern DELPHI_PACKAGE Vcl::Themes::TCustomStyleServices* acThemeServices;
extern DELPHI_PACKAGE System::Types::TPoint __fastcall acMousePos(void);
extern DELPHI_PACKAGE bool __fastcall LeftToRight(Vcl::Controls::TControl* const Control, const bool NormalAlignment = true);
extern DELPHI_PACKAGE void __fastcall AddToAdapter(Vcl::Controls::TWinControl* const Frame);
extern DELPHI_PACKAGE void __fastcall BroadCastMsg(const HWND Ctrl, const Winapi::Messages::TMessage &Message);
extern DELPHI_PACKAGE void __fastcall IterateControls(Vcl::Controls::TWinControl* Owner, int Data, TacIterProc CallBack);
extern DELPHI_PACKAGE void __fastcall PaintChildCtrls(Vcl::Controls::TWinControl* Ctrl, Vcl::Graphics::TBitmap* Bmp);
extern DELPHI_PACKAGE void __fastcall SkinPaintTo(Vcl::Graphics::TBitmap* const Bmp, Vcl::Controls::TControl* const Ctrl, const int Left = 0x0, const int Top = 0x0, System::Classes::TComponent* const SkinProvider = (System::Classes::TComponent*)(0x0));
extern DELPHI_PACKAGE void __fastcall AnimShowForm(Sskinprovider::TsSkinProvider* sp, System::Word wTime = (System::Word)(0x0), int MaxTransparency = 0xff, Sconst::TacAnimType AnimType = (Sconst::TacAnimType)(0x1));
extern DELPHI_PACKAGE void __fastcall AnimHideForm(System::TObject* SkinProvider);
extern DELPHI_PACKAGE void __fastcall PrintDlgClient(Acdials::TacDialogWnd* ListSW, Vcl::Graphics::TBitmap* acDstBmp, bool CopyScreen = false);
extern DELPHI_PACKAGE void __fastcall AnimHideDlg(Acdials::TacDialogWnd* ListSW);
extern DELPHI_PACKAGE Vcl::Controls::THintWindow* __fastcall acShowHintWnd(System::UnicodeString HintText, const System::Types::TPoint &Pos);
extern DELPHI_PACKAGE System::Types::TRect __fastcall acWorkRect(Vcl::Forms::TForm* Form)/* overload */;
extern DELPHI_PACKAGE System::Types::TRect __fastcall acWorkRect(const System::Types::TPoint &Coord)/* overload */;
extern DELPHI_PACKAGE void __fastcall AnimShowDlg(Acdials::TacDialogWnd* ListSW, System::Word wTime = (System::Word)(0x0), int MaxTransparency = 0xff, Sconst::TacAnimType AnimType = (Sconst::TacAnimType)(0x1));
extern DELPHI_PACKAGE void __fastcall PrepareForAnimation(Vcl::Controls::TWinControl* const Ctrl, Sconst::TacAnimTypeCtrl AnimType = (Sconst::TacAnimTypeCtrl)(0x0));
extern DELPHI_PACKAGE void __fastcall AnimShowControl(Vcl::Controls::TWinControl* Ctrl, System::Word wTime = (System::Word)(0x0), int MaxTransparency = 0xff, Sconst::TacAnimTypeCtrl AnimType = (Sconst::TacAnimTypeCtrl)(0x0));
extern DELPHI_PACKAGE void __fastcall SetParentUpdated(Vcl::Controls::TWinControl* const wc)/* overload */;
extern DELPHI_PACKAGE void __fastcall SetParentUpdated(const HWND pHwnd)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall GetControlColor(Vcl::Controls::TControl* const Control)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall GetControlColor(const NativeUInt Handle)/* overload */;
extern DELPHI_PACKAGE bool __fastcall AllEditSelected(Vcl::Stdctrls::TCustomEdit* Ctrl);
extern DELPHI_PACKAGE void __fastcall PaintControls(HDC DC, Vcl::Controls::TWinControl* OwnerControl, bool ChangeCache, const System::Types::TPoint &Offset, NativeUInt AHandle = (NativeUInt)(0x0), bool CheckVisible = true);
extern DELPHI_PACKAGE void __fastcall PaintParentBG(Vcl::Controls::TControl* AControl, Vcl::Graphics::TBitmap* ABitmap);
extern DELPHI_PACKAGE NativeInt __fastcall SendAMessage(const HWND Handle, const int Cmd, NativeInt LParam = (NativeInt)(0x0))/* overload */;
extern DELPHI_PACKAGE NativeInt __fastcall SendAMessage(Vcl::Controls::TControl* const Control, const int Cmd, NativeInt LParam = (NativeInt)(0x0))/* overload */;
extern DELPHI_PACKAGE bool __fastcall GetBoolMsg(Vcl::Controls::TWinControl* const Control, const unsigned Cmd)/* overload */;
extern DELPHI_PACKAGE bool __fastcall GetBoolMsg(const HWND CtrlHandle, const unsigned Cmd)/* overload */;
extern DELPHI_PACKAGE bool __fastcall ControlIsReady(Vcl::Controls::TControl* const Control);
extern DELPHI_PACKAGE Vcl::Forms::TCustomForm* __fastcall GetOwnerForm(System::Classes::TComponent* const Component);
extern DELPHI_PACKAGE Vcl::Forms::TCustomFrame* __fastcall GetOwnerFrame(System::Classes::TComponent* const Component);
extern DELPHI_PACKAGE void __fastcall SetControlsEnabled(Vcl::Controls::TWinControl* Parent, bool Value, bool Recursion = false);
extern DELPHI_PACKAGE int __fastcall GetStringFlags(Vcl::Controls::TControl* const Control, const System::Classes::TAlignment al);
extern DELPHI_PACKAGE void __fastcall RepaintsControls(Vcl::Controls::TWinControl* const Owner, const bool BGChanged);
extern DELPHI_PACKAGE void __fastcall AlphaBroadCast(Vcl::Controls::TWinControl* const Control, void *Message)/* overload */;
extern DELPHI_PACKAGE void __fastcall AlphaBroadCast(const HWND Handle, void *Message)/* overload */;
extern DELPHI_PACKAGE System::Types::TRect __fastcall acClientRect(const HWND Handle);
extern DELPHI_PACKAGE bool __fastcall TrySetSkinSection(Vcl::Controls::TControl* const Control, const System::UnicodeString SectionName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetWndClassName(const NativeUInt Hwnd);
extern DELPHI_PACKAGE int __fastcall GetAlignShift(Vcl::Controls::TWinControl* const Ctrl, const Vcl::Controls::TAlign Align, const bool GraphCtrlsToo = false);
extern DELPHI_PACKAGE HWND __fastcall GetParentFormHandle(const HWND CtrlHandle);
extern DELPHI_PACKAGE bool __fastcall acThemesEnabled(void);
}	/* namespace Svclutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SVCLUTILS)
using namespace Svclutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SvclutilsHPP
