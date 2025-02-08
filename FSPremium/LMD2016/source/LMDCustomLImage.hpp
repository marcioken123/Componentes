// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomLImage.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlimageHPP
#define LmdcustomlimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomLImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomLImage : public Lmdbaseimage::TLMDBaseImage
{
	typedef Lmdbaseimage::TLMDBaseImage inherited;
	
private:
	bool FSilentMove;
	void __fastcall SetBool(int index, bool aValue);
	
protected:
	bool FForceTransparent;
	virtual bool __fastcall CheckOptimized(void);
	virtual bool __fastcall CorrectBounds(void);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	__property bool ForceTransparent = {read=FForceTransparent, write=SetBool, index=0, default=0};
	
public:
	__fastcall virtual TLMDCustomLImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomLImage(void);
	virtual bool __fastcall isTransparentSet(void);
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property bool SilentMove = {read=FSilentMove, write=SetBool, index=1, default=0};
	__property Transparent = {default=1};
	
__published:
	__property Align = {default=0};
	__property Bevel;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property QuickDraw = {default=1};
	__property ShowHint;
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
}	/* namespace Lmdcustomlimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLIMAGE)
using namespace Lmdcustomlimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlimageHPP
