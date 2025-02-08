// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHeader.pas' rev: 31.00 (Windows)

#ifndef LmdheaderHPP
#define LmdheaderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDGraph.hpp>
#include <LMDCont.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomHeaderPanel.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBitmapList.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>
#include <LMDBevel.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdheader
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHeader;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHeader : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdcustomheaderpanel::TLMDCustomHeaderPanel* FHeaderPanel;
	System::Types::TRect FTextRect;
	bool FOverText;
	Vcl::Graphics::TBitmap* FGlyph;
	void __fastcall SetHeaderPanel(Lmdcustomheaderpanel::TLMDCustomHeaderPanel* aValue);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Winapi::Messages::TWMMouse &Message);
	
protected:
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	void __fastcall DoModeChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall TextEnter(void);
	void __fastcall TextExit(void);
	
public:
	__fastcall virtual TLMDHeader(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDHeader(void);
	void __fastcall SetCaption(System::UnicodeString aCaption)/* overload */;
	void __fastcall SetCaption(System::UnicodeString aCaption, Vcl::Graphics::TBitmap* aGlyph)/* overload */;
	void __fastcall SetCaption(System::UnicodeString aCaption, Vcl::Controls::TImageList* anImageList, int anImageIndex)/* overload */;
	void __fastcall SetCaption(System::UnicodeString aCaption, Lmdcustomimagelist::TLMDCustomImageList* anImageList, int anImageIndex, int aListIndex)/* overload */;
	void __fastcall SetCaption(System::UnicodeString aCaption, Lmdbitmaplist::TLMDBitmapList* aBitmapList, int anImageIndex)/* overload */;
	
__published:
	__property Lmdcustomheaderpanel::TLMDCustomHeaderPanel* HeaderPanel = {read=FHeaderPanel, write=SetHeaderPanel};
	__property Caption = {default=0};
	__property Flat = {default=0};
	__property BackFX;
	__property Color = {default=-16777201};
	__property FillObject;
	__property Bevel;
	__property Transparent = {default=0};
	__property Font;
	__property Anchors = {default=3};
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
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
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
	__property OnContextPopup;
	__property OnMouseActivate;
	__property ThemeGlobalMode = {default=0};
	__property ThemeMode = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHeader(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdheader */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHEADER)
using namespace Lmdheader;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdheaderHPP
