// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextScrollPanel.pas' rev: 31.00 (Windows)

#ifndef LmdtextscrollpanelHPP
#define LmdtextscrollpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDGraph.hpp>
#include <LMDTextCustomPanel.hpp>
#include <LMDSBar.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>
#include <LMDTextObject.hpp>
#include <System.UITypes.hpp>
#include <LMDTextContainer.hpp>
#include <LMDTypes.hpp>
#include <LMDFaceController.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextscrollpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextScrollPanel;
//-- type declarations -------------------------------------------------------
typedef Lmdcustommemo::TLMDMemoScrollBarKind TLMDTextScrollBarKind;

class PASCALIMPLEMENTATION TLMDTextScrollPanel : public Lmdtextcustompanel::TLMDTextCustomPanel
{
	typedef Lmdtextcustompanel::TLMDTextCustomPanel inherited;
	
private:
	System::Types::TPoint FScrollStep;
	System::Types::TPoint FPos;
	Lmdsbar::TLMDScrollBar* FVScroll;
	Lmdsbar::TLMDScrollBar* FHScroll;
	System::Types::TRect FTextSize;
	Lmdsbar::TLMDScrollBarObject* FVSet;
	Lmdsbar::TLMDScrollBarObject* FHSet;
	Lmdcustommemo::TLMDMemoScrollBarKind FScrollBars;
	void __fastcall SetTextSize(const System::Types::TRect &aValue);
	void __fastcall SetInteger(int Index, int aValue);
	int __fastcall GetInteger(int Index);
	void __fastcall SetScrollBarObject(int index, Lmdsbar::TLMDScrollBarObject* aValue);
	void __fastcall SetScrollBars(Lmdcustommemo::TLMDMemoScrollBarKind aValue);
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DoVScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall DoHScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	virtual void __fastcall DoTxtChange(System::TObject* Sender);
	void __fastcall UpdateAndRefresh(void);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &ARect);
	virtual System::Types::TRect __fastcall GetClientRect(void);
	void __fastcall SetupScrollBars(void);
	__property System::Types::TRect TextSize = {read=FTextSize, write=SetTextSize};
	
public:
	__fastcall virtual TLMDTextScrollPanel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextScrollPanel(void);
	
__published:
	__property Lmdsbar::TLMDScrollBarObject* VertScrollBar = {read=FVSet, write=SetScrollBarObject, index=0};
	__property Lmdsbar::TLMDScrollBarObject* HorizScrollBar = {read=FHSet, write=SetScrollBarObject, index=1};
	__property Lines;
	__property Anchors = {default=3};
	__property TabStop = {default=0};
	__property WordWrap = {default=1};
	__property OnLinkClick;
	__property Lmdcustommemo::TLMDMemoScrollBarKind ScrollBars = {read=FScrollBars, write=SetScrollBars, default=2};
	__property int ScrollX = {read=GetInteger, write=SetInteger, index=0, default=-1};
	__property int ScrollY = {read=GetInteger, write=SetInteger, index=1, default=-1};
	__property TextContainer;
	__property TextIndex = {default=0};
	__property CheckContainerLinks = {default=0};
	__property NoHandleUpdate = {default=0};
	__property FDSupport = {default=0};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=4};
	__property FaceController;
	__property BackFX;
	__property BackFXPass = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FillObject;
	__property Font;
	__property FontFX;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Transparent = {default=0};
	__property TransparentBorder = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextScrollPanel(HWND ParentWindow) : Lmdtextcustompanel::TLMDTextCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextscrollpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTSCROLLPANEL)
using namespace Lmdtextscrollpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextscrollpanelHPP
