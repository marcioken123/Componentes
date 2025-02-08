// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElImgFrm.pas' rev: 31.00 (Windows)

#ifndef ElimgfrmHPP
#define ElimgfrmHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.TypInfo.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <ElComponent.hpp>
#include <ElHook.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <LMDProcs.hpp>
#include <ElVCLUtils.hpp>
#include <LMDObjectList.hpp>
#include <LMDGraph.hpp>
#include <LMDBmp.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elimgfrm
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TImgFormChangeLink;
class DELPHICLASS TCustomElImageForm;
class DELPHICLASS TElImageForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TImgFormChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TCustomElImageForm* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TImgFormChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TCustomElImageForm* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TImgFormChangeLink(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TCustomElImageForm : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Controls::TGraphicControl* FCaptionControl;
	bool FChangeRegion;
	Vcl::Graphics::TBitmap* FBkImage;
	Vcl::Extctrls::TImage* FImage;
	Vcl::Graphics::TBitmap* FBmp;
	bool FMoveForm;
	Elhook::TElHook* FMoveHook;
	System::Classes::TNotifyEvent FOldImageEvent;
	HRGN FRegion;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	int FGradientSteps;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	bool FNoBk;
	Lmdobjectlist::TLMDObjectList* FCLients;
	Vcl::Graphics::TBitmap* CacheBackground;
	bool FStretchRegion;
	void __fastcall AfterMessage(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall HandleWMEraseBkgnd(Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall BeforeMessage(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall BkImageChange(System::TObject* Sender);
	void __fastcall SetCaptionControl(Vcl::Controls::TGraphicControl* const Value);
	void __fastcall SetChangeRegion(const bool Value);
	void __fastcall SetImage(Vcl::Extctrls::TImage* const Value);
	void __fastcall SetBkImage(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetMoveForm(const bool Value);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall SetStretchRegion(const bool Value);
	
protected:
	Vcl::Controls::TWinControl* FControl;
	System::Uitypes::TColor FTransparentColor;
	DYNAMIC void __fastcall Change(void);
	void __fastcall CreateHook(void);
	void __fastcall CreateRegion(void);
	void __fastcall DestroyHook(void);
	void __fastcall DestroyRegion(void);
	System::Uitypes::TColor __fastcall GetTransparentColor(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetControl(Vcl::Controls::TWinControl* Value);
	void __fastcall SetTransparentColor(System::Uitypes::TColor Value);
	void __fastcall CreateCacheBackground(void);
	void __fastcall DisposeCacheBackground(void);
	__property Vcl::Controls::TGraphicControl* CaptionControl = {read=FCaptionControl, write=SetCaptionControl};
	__property bool ChangeFormRegion = {read=FChangeRegion, write=SetChangeRegion, default=0};
	__property bool StretchFormRegion = {read=FStretchRegion, write=SetStretchRegion, default=0};
	__property bool MoveForm = {read=FMoveForm, write=SetMoveForm, default=0};
	__property Vcl::Extctrls::TImage* FormImage = {read=FImage, write=SetImage};
	__property Vcl::Graphics::TBitmap* Background = {read=FBkImage, write=SetBkImage};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, nodefault};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, nodefault};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=16};
	
public:
	__fastcall virtual TCustomElImageForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElImageForm(void);
	void __fastcall RegisterChanges(TImgFormChangeLink* Value);
	void __fastcall UnregisterChanges(TImgFormChangeLink* Value);
	void __fastcall PaintBkgnd(HDC DC, const System::Types::TRect &R, const System::Types::TPoint &Origin, bool Direct);
	Vcl::Controls::TWinControl* __fastcall GetRealControl(void);
	
__published:
	__property Vcl::Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property System::Uitypes::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, nodefault};
};


class PASCALIMPLEMENTATION TElImageForm : public TCustomElImageForm
{
	typedef TCustomElImageForm inherited;
	
__published:
	__property StretchFormRegion = {default=0};
	__property CaptionControl;
	__property ChangeFormRegion = {default=0};
	__property FormImage;
	__property MoveForm = {default=0};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientStartColor;
	__property GradientEndColor;
	__property GradientSteps = {default=16};
public:
	/* TCustomElImageForm.Create */ inline __fastcall virtual TElImageForm(System::Classes::TComponent* AOwner) : TCustomElImageForm(AOwner) { }
	/* TCustomElImageForm.Destroy */ inline __fastcall virtual ~TElImageForm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word IFM_EFFECTIVESIZE = System::Word(0x92e);
static const System::Word IFM_REPAINTCHILDREN = System::Word(0x1cf5);
static const System::Word IFM_CANPAINTBKGND = System::Word(0x1cf7);
}	/* namespace Elimgfrm */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELIMGFRM)
using namespace Elimgfrm;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElimgfrmHPP
