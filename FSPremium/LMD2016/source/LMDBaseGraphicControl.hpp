// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseGraphicControl.pas' rev: 31.00 (Windows)

#ifndef LmdbasegraphiccontrolHPP
#define LmdbasegraphiccontrolHPP

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
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <intfLMDBackGround.hpp>
#include <intfLMDBase.hpp>
#include <LMDCustomImageList.hpp>
#include <Vcl.Themes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBaseController.hpp>
#include <LMDCont.hpp>
#include <LMDBaseControl.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasegraphiccontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseGraphicControl;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnBoundsChangeEvent)(System::TObject* Sender, Lmdclass::TLMDBoundsChangeStates State);

class PASCALIMPLEMENTATION TLMDBaseGraphicControl : public Lmdbasecontrol::TLMDBaseControl
{
	typedef Lmdbasecontrol::TLMDBaseControl inherited;
	
private:
	TLMDOnBoundsChangeEvent FOnBoundsChange;
	int FUpdateCount;
	bool FTransparent;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	Lmdbitmapeffectobject::TLMDBitmapEffectObject* FBackFX;
	bool FThemeGlobalMode;
	bool FParentThemeMode;
	void __fastcall SetTransparent(bool aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall SetBackFX(Lmdbitmapeffectobject::TLMDBitmapEffectObject* aValue);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	MESSAGE void __fastcall CMTRANSPARENTCHANGED(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdclass::TLMDThemeMode FThemeMode;
	bool Painting;
	virtual bool __fastcall CheckOptimized(void);
	void __fastcall DisableTransMode(void);
	HIDESBASE void __fastcall InvalidateControl(void);
	void __fastcall set_CtlXP(bool aValue);
	bool __fastcall get_CtlXP(void);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	System::Types::TRect __fastcall GetScreenRect(const System::Types::TRect &aRect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetImageIndex(int aValue);
	__property TLMDOnBoundsChangeEvent OnBoundsChange = {read=FOnBoundsChange, write=FOnBoundsChange};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=0};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool CtlXP = {read=get_CtlXP, write=set_CtlXP, default=0};
	__property Lmdbitmapeffectobject::TLMDBitmapEffectObject* BackFX = {read=FBackFX, write=SetBackFX};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	
public:
	__fastcall virtual TLMDBaseGraphicControl(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBaseGraphicControl(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall BeginUpdate(void);
	bool __fastcall IsUpdating(void);
	void __fastcall EndUpdate(bool repaint);
	bool __fastcall IsThemed(void);
	DYNAMIC void __fastcall Click(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
	virtual bool __fastcall isTransparentSet(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual HPALETTE __fastcall BackBitmapPalette(void);
	virtual void __fastcall BackUpdate(void);
	virtual Vcl::Controls::TControl* __fastcall BackControl(int index);
	virtual int __fastcall BackControlCount(void);
	bool __fastcall IMLEmpty(void);
	
__published:
	__property OnGesture;
	__property Touch;
private:
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	
public:
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
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasegraphiccontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEGRAPHICCONTROL)
using namespace Lmdbasegraphiccontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasegraphiccontrolHPP
