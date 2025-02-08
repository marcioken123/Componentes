// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxImage.pas' rev: 31.00 (Windows)

#ifndef LmdfximageHPP
#define LmdfximageHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDFxBase.hpp>
#include <LMDFxAnimation.hpp>
#include <LMDFxImageList.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfximage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxImage : public Lmdfxbase::TLMDFxGraphicControl
{
	typedef Lmdfxbase::TLMDFxGraphicControl inherited;
	
private:
	Lmdfxanimation::TLMDFxAnimation* FAnimation;
	bool FAnimating;
	Lmdfximagelist::TLMDFxChangeLink* FChangeLink;
	bool FCenter;
	bool FDrawing;
	int FImageIndex;
	Lmdfximagelist::TLMDFxImageList* FImageList;
	bool FIncrementalDisplay;
	Vcl::Graphics::TProgressEvent FOnProgress;
	Vcl::Graphics::TPicture* FPicture;
	bool FProportional;
	Vcl::Graphics::TPicture* FSavedPicture;
	bool FStretch;
	bool FTransparent;
	void __fastcall SetAnimation(Lmdfxanimation::TLMDFxAnimation* const Value);
	void __fastcall SetBoolean(int index, bool Value);
	void __fastcall SetImages(Lmdfximagelist::TLMDFxImageList* const Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* Value);
	void __fastcall GetChange(System::TObject* Sender);
	Vcl::Graphics::TPicture* __fastcall GetPicture(void);
	
protected:
	System::Types::TRect __fastcall CalcDestRect(Vcl::Graphics::TPicture* APicture);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	bool __fastcall DoPaletteChange(void);
	void __fastcall ExecuteAnimation(void);
	DYNAMIC void __fastcall DoProgress(System::TObject* Sender, Vcl::Graphics::TProgressStage Stage, System::Byte PercentDone, bool RedrawNow, const System::Types::TRect &R, const System::UnicodeString Msg);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDFxImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxImage(void);
	bool __fastcall IMLEmpty(void);
	__property Vcl::Graphics::TPicture* CurrentPicture = {read=GetPicture};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Lmdfxanimation::TLMDFxAnimation* Animation = {read=FAnimation, write=SetAnimation};
	__property AutoSize = {default=0};
	__property bool Center = {read=FCenter, write=SetBoolean, index=0, default=0};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property Lmdfximagelist::TLMDFxImageList* Images = {read=FImageList, write=SetImages};
	__property bool IncrementalDisplay = {read=FIncrementalDisplay, write=SetBoolean, index=1, default=0};
	__property ParentShowHint = {default=1};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property PopupMenu;
	__property bool Proportional = {read=FProportional, write=SetBoolean, index=2, default=0};
	__property ShowHint;
	__property bool Stretch = {read=FStretch, write=SetBoolean, index=3, default=0};
	__property bool Transparent = {read=FTransparent, write=SetBoolean, index=4, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Vcl::Graphics::TProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property OnStartDock;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfximage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXIMAGE)
using namespace Lmdfximage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfximageHPP
