// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPanelShape.pas' rev: 31.00 (Windows)

#ifndef LmdpanelshapeHPP
#define LmdpanelshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <LMDRegion.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpanelshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPanelShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPanelShape : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdregion::TLMDBorderRegion* FRegion;
	bool FUseRgnBitmap;
	Lmdregion::TLMDBorderDrawEvent FOnDrawBorder;
	void __fastcall SetUseBitmap(bool aValue);
	void __fastcall SetRegion(Lmdregion::TLMDBorderRegion* aValue);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	
protected:
	virtual void __fastcall CreateBack(bool aValue);
	
public:
	__fastcall virtual TLMDPanelShape(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDPanelShape(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property FillObject;
	__property Font;
	__property FontFX;
	__property Hint;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property QuickDraw = {default=0};
	__property ShowHint;
	__property Lmdregion::TLMDBorderRegion* Region = {read=FRegion, write=SetRegion};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property bool UseRgnBitmap = {read=FUseRgnBitmap, write=SetUseBitmap, default=1};
	__property Visible = {default=1};
	__property Lmdregion::TLMDBorderDrawEvent OnDrawBorder = {read=FOnDrawBorder, write=FOnDrawBorder};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseExit;
	__property OnMouseEnter;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnDragOver;
	__property OnClick;
	__property OnDblClick;
	__property OnResize;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPanelShape(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpanelshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPANELSHAPE)
using namespace Lmdpanelshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpanelshapeHPP
