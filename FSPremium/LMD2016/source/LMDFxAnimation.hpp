// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxAnimation.pas' rev: 31.00 (Windows)

#ifndef LmdfxanimationHPP
#define LmdfxanimationHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxUtils.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDFxEffect.hpp>
#include <LMDFxBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxanimation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxAnimation;
class DELPHICLASS TLMDFxAnimationList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFxAnimationState : unsigned char { asNormal, asExecuting };

class PASCALIMPLEMENTATION TLMDFxAnimation : public Lmdfxeffect::TLMDFxAnimationRec
{
	typedef Lmdfxeffect::TLMDFxAnimationRec inherited;
	
private:
	Lmdfxbitmap::TLMDFxBitmap* FDestImage;
	Vcl::Graphics::TCanvas* FFreezeCanvas;
	System::Types::TRect FFreezeRect;
	Vcl::Controls::TControl* FFreezedControl;
	System::Classes::TNotifyEvent FOnFinish;
	System::Classes::TNotifyEvent FOnInternalChange;
	System::Classes::TNotifyEvent FOnStart;
	TLMDFxAnimationList* FParent;
	Lmdfxbitmap::TLMDFxBitmap* FSourceImage;
	TLMDFxAnimationState FState;
	void __fastcall SetDestImage(Lmdfxbitmap::TLMDFxBitmap* const Value);
	void __fastcall SetSourceImage(Lmdfxbitmap::TLMDFxBitmap* const Value);
	void __fastcall SetState(const TLMDFxAnimationState Value);
	
protected:
	void __fastcall DoProgress(int Percent);
	virtual void __fastcall SetName(const System::Classes::TComponentName NewName);
	
public:
	__fastcall virtual TLMDFxAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxAnimation(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Execute(void);
	void __fastcall ExecuteImage(Vcl::Graphics::TCanvas* const aCanvas, int X, int Y);
	void __fastcall FreezeControl(Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect, Lmdfxbitmap::TLMDFxBitmap* ASourceImage = (Lmdfxbitmap::TLMDFxBitmap*)(0x0));
	void __fastcall FreezeControlClient(Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect, Lmdfxbitmap::TLMDFxBitmap* ASourceImage = (Lmdfxbitmap::TLMDFxBitmap*)(0x0));
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent(void);
	DYNAMIC bool __fastcall HasParent(void);
	bool __fastcall IsControlFrozen(Vcl::Controls::TControl* AControl);
	void __fastcall Restore(void);
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* Value);
	System::Uitypes::TModalResult __fastcall ShowDesigner(void)/* overload */;
	System::Uitypes::TModalResult __fastcall ShowDesigner(const System::UnicodeString aCaption, bool OkCancelButtons, System::Classes::TNotifyEvent NotifyProc = 0x0)/* overload */;
	__property Lmdfxbitmap::TLMDFxBitmap* DestImage = {read=FDestImage, write=SetDestImage};
	__property System::Classes::TNotifyEvent OnInternalChange = {read=FOnInternalChange, write=FOnInternalChange};
	__property TLMDFxAnimationList* Parent = {read=FParent};
	__property Lmdfxbitmap::TLMDFxBitmap* SourceImage = {read=FSourceImage, write=SetSourceImage};
	__property TLMDFxAnimationState State = {read=FState, write=SetState, nodefault};
	
__published:
	__property System::Classes::TNotifyEvent OnFinish = {read=FOnFinish, write=FOnFinish};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnStart, write=FOnStart};
};


class PASCALIMPLEMENTATION TLMDFxAnimationList : public Lmdfxbase::TLMDFxComponent
{
	typedef Lmdfxbase::TLMDFxComponent inherited;
	
public:
	TLMDFxAnimation* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TList* FAnimationList;
	TLMDFxAnimation* __fastcall GetItem(int Index);
	int __fastcall GetCount(void);
	
protected:
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	
public:
	__fastcall virtual TLMDFxAnimationList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxAnimationList(void);
	void __fastcall Add(TLMDFxAnimation* Item);
	HIDESBASE void __fastcall Remove(TLMDFxAnimation* Item);
	__property int Count = {read=GetCount, nodefault};
	__property TLMDFxAnimation* Items[int Index] = {read=GetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfxanimation */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXANIMATION)
using namespace Lmdfxanimation;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxanimationHPP
