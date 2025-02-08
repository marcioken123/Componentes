// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomNImage.pas' rev: 31.00 (Windows)

#ifndef LmdcustomnimageHPP
#define LmdcustomnimageHPP

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
#include <LMDGraph.hpp>
#include <LMDTransparent.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomnimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomNImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomNImage : public Lmdbaseimage::TLMDBaseImage
{
	typedef Lmdbaseimage::TLMDBaseImage inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	TLMDCustomNImage* FControl;
	Lmdtransparent::TLMDTransparent* FTransparentStyle;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetControl(TLMDCustomNImage* aControl);
	void __fastcall SetTransparentStyle(Lmdtransparent::TLMDTransparent* aValue);
	
protected:
	virtual bool __fastcall CorrectBounds(void);
	virtual Vcl::Graphics::TBitmap* __fastcall GetBitmap(Vcl::Graphics::TBitmap* tmp);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	HIDESBASE bool __fastcall HasControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property TLMDCustomNImage* Control = {read=FControl, write=SetControl};
	
public:
	__fastcall virtual TLMDCustomNImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomNImage(void);
	
__published:
	__property Align = {default=0};
	__property BackFX;
	__property Bevel;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property QuickDraw = {default=1};
	__property ShowHint;
	__property Style = {default=0};
	__property Lmdtransparent::TLMDTransparent* TransparentStyle = {read=FTransparentStyle, write=SetTransparentStyle};
	__property Transparent = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomnimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMNIMAGE)
using namespace Lmdcustomnimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomnimageHPP
