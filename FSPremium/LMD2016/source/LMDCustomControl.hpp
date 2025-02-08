// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomControl.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcontrolHPP
#define LmdcustomcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBackGround.hpp>
#include <intfLMDControlPosSize.hpp>
#include <intfLMDFaceController.hpp>
#include <LMDFaceController.hpp>
#include <LMDFillObject.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDControl.hpp>
#include <LMDGraph.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomControl : public Lmdcontrol::TLMDBaseCustomControl
{
	typedef Lmdcontrol::TLMDBaseCustomControl inherited;
	
private:
	bool FAutoBring;
	bool FInternalMouseAbove;
	bool FFwdBackFX;
	bool FMouseAbove;
	bool FEntered;
	bool FFlat;
	bool FTransparent;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	System::Classes::TNotifyEvent FOnAfterEnter;
	System::Classes::TNotifyEvent FOnAfterExit;
	bool FAllowMove;
	bool FAllowSize;
	bool FShowGrip;
	bool FMoving;
	bool FWindowed;
	bool FLocked;
	System::Byte FBorderSense;
	System::Classes::TNotifyEvent FOnMove;
	Lmdfacecontroller::TLMDFaceController* FFaceController;
	Lmdbitmapeffectobject::TLMDBitmapEffectObject* FBackFX;
	bool FThemeGlobalMode;
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall SetTransparent(bool aValue);
	void __fastcall SetFlat(bool aValue);
	void __fastcall SetBoolean(bool aValue);
	void __fastcall SetPassBackFX(bool aValue);
	void __fastcall SetBackFXObject(Lmdbitmapeffectobject::TLMDBitmapEffectObject* aValue);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	MESSAGE void __fastcall CMLMDAfterEnter(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDAfterExit(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CMStyleChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	void __fastcall SetShowGrip(const bool aValue);
	bool __fastcall get_AllowMoving(void);
	void __fastcall set_AllowMoving(const bool aValue);
	bool __fastcall get_AllowSizing(void);
	void __fastcall set_AllowSizing(const bool aValue);
	bool __fastcall get_ControlLocked(void);
	void __fastcall set_ControlLocked(const bool aValue);
	void __fastcall set_OnMove(const System::Classes::TNotifyEvent aValue);
	System::Classes::TNotifyEvent __fastcall get_OnMove(void);
	void __fastcall set_CtlXP(bool aValue);
	bool __fastcall get_CtlXP(void);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetFaceController(Lmdfacecontroller::TLMDFaceController* aValue);
	MESSAGE void __fastcall CMTRANSPARENTCHANGED(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDSCROLLBOXSCROLLEVENT(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSYSCOLORCHANGE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMKILLFOCUS(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMMOVE(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMSETFOCUS(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Winapi::Messages::TWMMouse &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FParentThemeMode;
	virtual void __fastcall SetParentBackground(bool Value);
	bool __fastcall CheckOpaqueState(void);
	bool __fastcall IsNotOpaque(void);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	__property bool AutoBringToFront = {read=FAutoBring, write=FAutoBring, default=1};
	virtual void __fastcall DoMove(void);
	virtual System::Types::TRect __fastcall GetMoveRect(void);
	virtual System::Types::TRect __fastcall GetSizeRect(void);
	__property bool HandleNonWinControls = {read=FWindowed, write=FWindowed, default=0};
	__property bool AllowMoving = {read=get_AllowMoving, write=set_AllowMoving, default=0};
	__property bool AllowSizing = {read=get_AllowSizing, write=set_AllowSizing, default=0};
	__property bool ControlLocked = {read=get_ControlLocked, write=set_ControlLocked, default=0};
	__property bool SizeGrip = {read=FShowGrip, write=SetShowGrip, default=0};
	__property System::Classes::TNotifyEvent OnMove = {read=get_OnMove, write=set_OnMove};
	__property System::Byte BorderSensitivity = {read=FBorderSense, write=FBorderSense, default=4};
	virtual bool __fastcall fcGetFocused(void);
	virtual bool __fastcall fcGetMouseAbove(void);
	virtual bool __fastcall fcGetTransparent(void);
	virtual bool __fastcall fcGetCtlXP(void);
	virtual bool __fastcall fcGetBorderCtl3D(void);
	virtual bool __fastcall fcGetEnabled(void);
	virtual System::Uitypes::TColor __fastcall fcGetBackColor(void);
	void __fastcall fcSetFaceController(System::Classes::TComponent* aComponent);
	virtual Vcl::Graphics::TFont* __fastcall GetFont(void);
	virtual Lmd3dcaption::TLMD3DCaption* __fastcall GetFont3D(void);
	virtual bool __fastcall GetTransparent(void);
	virtual bool __fastcall GetCtlXP(void);
	virtual System::Uitypes::TColor __fastcall GetBackColor(void);
	virtual Lmdfillobject::TLMDFillObject* __fastcall GetFillObject(void);
	virtual Lmdbitmapeffectobject::TLMDBitmapEffectObject* __fastcall GetBackFX(void);
	virtual bool __fastcall GetBorderCtl3D(void);
	virtual Lmdbevel::TLMDBevel* __fastcall GetBevel(void);
	void __fastcall ForceMouseAbove(void);
	void __fastcall ForceMouseNotAbove(void);
	virtual void __fastcall DoForwardBackFX(void);
	virtual void __fastcall DoFlatChanged(void);
	void __fastcall SetMouseAbove(bool aValue);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual bool __fastcall CheckOptimized(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DrawDashedFrame(void);
	void __fastcall RepBack(const System::Types::TRect &aRect);
	virtual void __fastcall FillControl(void);
	virtual bool __fastcall GetEmpty(void);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	System::Types::TRect __fastcall GetScreenRect(const System::Types::TRect &aRect);
	virtual bool __fastcall IMLEmpty(void);
	HIDESBASE void __fastcall InvalidateFrame(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall RestoreBorderBack(void);
	DYNAMIC void __fastcall RestoreBorderFront(void);
	virtual void __fastcall DrawThemeBevel(Lmdclass::TLMDThemeMode aTheme, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	__property bool Entered = {read=FEntered, write=SetBoolean, nodefault};
	__property Lmdbitmapeffectobject::TLMDBitmapEffectObject* BackFX = {read=FBackFX, write=SetBackFXObject};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool CtlXP = {read=get_CtlXP, write=set_CtlXP, default=1};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool BackFXPass = {read=FFwdBackFX, write=SetPassBackFX, default=0};
	__property System::Classes::TNotifyEvent OnAfterEnter = {read=FOnAfterEnter, write=FOnAfterEnter};
	__property System::Classes::TNotifyEvent OnAfterExit = {read=FOnAfterExit, write=FOnAfterExit};
	__property TabStop = {default=0};
	__property ParentBackground = {default=1};
	
public:
	__fastcall virtual TLMDCustomControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomControl(void);
	bool __fastcall IsThemed(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
	virtual bool __fastcall isTransparentSet(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual HPALETTE __fastcall BackBitmapPalette(void);
	virtual void __fastcall BackUpdate(void);
	virtual Vcl::Controls::TControl* __fastcall BackControl(int index);
	virtual int __fastcall BackControlCount(void);
	__property bool MouseAbove = {read=FMouseAbove, nodefault};
	__property Lmdfacecontroller::TLMDFaceController* FaceController = {read=FFaceController, write=SetFaceController};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomControl(HWND ParentWindow) : Lmdcontrol::TLMDBaseCustomControl(ParentWindow) { }
	
private:
	void *__ILMDFaceController;	// Intflmdfacecontroller::ILMDFaceController 
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	void *__ILMDControlPosSize;	// Intflmdcontrolpossize::ILMDControlPosSize 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {32BE634B-1A6E-4975-9975-241836293C61}
	operator Intflmdfacecontroller::_di_ILMDFaceController()
	{
		Intflmdfacecontroller::_di_ILMDFaceController intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdfacecontroller::ILMDFaceController*(void) { return (Intflmdfacecontroller::ILMDFaceController*)&__ILMDFaceController; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0068598D-C5C6-488F-8E00-D813525C9163}
	operator Intflmdbackground::_di_ILMDBackground()
	{
		Intflmdbackground::_di_ILMDBackground intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbackground::ILMDBackground*(void) { return (Intflmdbackground::ILMDBackground*)&__ILMDBackground; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {EE3AFF62-E73A-41F2-B04D-D24710377EBD}
	operator Intflmdcontrolpossize::_di_ILMDControlPosSize()
	{
		Intflmdcontrolpossize::_di_ILMDControlPosSize intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdcontrolpossize::ILMDControlPosSize*(void) { return (Intflmdcontrolpossize::ILMDControlPosSize*)&__ILMDControlPosSize; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 def_BorderSense = System::Int8(0x4);
}	/* namespace Lmdcustomcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCONTROL)
using namespace Lmdcustomcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcontrolHPP
