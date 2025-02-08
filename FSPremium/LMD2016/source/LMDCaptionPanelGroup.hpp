// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCaptionPanelGroup.pas' rev: 31.00 (Windows)

#ifndef LmdcaptionpanelgroupHPP
#define LmdcaptionpanelgroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDBase.hpp>
#include <LMDGraph.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCaptionPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcaptionpanelgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaptionPanelGroup;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDCPGIniSaveOption : unsigned char { cpgIndex, cpgState, cpgVisible, cpgDimensions, cpgScrollPos };

typedef System::Set<TLMDCPGIniSaveOption, TLMDCPGIniSaveOption::cpgIndex, TLMDCPGIniSaveOption::cpgScrollPos> TLMDCPGIniSaveOptions;

class PASCALIMPLEMENTATION TLMDCaptionPanelGroup : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	bool FAutoExpand;
	Lmdgraph::TLMDOrientation FOrientation;
	System::Classes::TList* FPanels;
	System::Byte FPanelGap;
	System::Byte FMargin;
	Vcl::Stdctrls::TScrollBar* FScrollBar;
	int FHeight;
	System::Classes::TNotifyEvent FOnScroll;
	System::UnicodeString FIniSection;
	System::UnicodeString FIniKey;
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	TLMDCPGIniSaveOptions FIniSaveOptions;
	Lmdinictrl::TLMDIniUse FIniUse;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniReadData;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniWriteData;
	void __fastcall SetAutoExpand(bool aValue);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	bool __fastcall SaveIniKey(void);
	bool __fastcall SaveIniSection(void);
	Lmdcaptionpanel::TLMDCaptionPanel* __fastcall GetPanelByCaption(System::UnicodeString PanelCaption);
	Lmdcaptionpanel::TLMDCaptionPanel* __fastcall GetPanelByIndex(int PanelIndex);
	Lmdcaptionpanel::TLMDCaptionPanel* __fastcall GetPanelByName(System::UnicodeString PanelName);
	Lmdcaptionpanel::TLMDCaptionPanel* __fastcall GetPanelByData(System::UnicodeString PanelData);
	void __fastcall SetOrientation(const Lmdgraph::TLMDOrientation Value);
	void __fastcall SetPanelGap(const System::Byte Value);
	void __fastcall SetMargin(const System::Byte Value);
	MESSAGE void __fastcall CMTabStopChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	MESSAGE void __fastcall CMLMDUpdatePanel(Winapi::Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC bool __fastcall DoReadData(void);
	DYNAMIC void __fastcall DoWriteData(void);
	void __fastcall DoScroll(System::TObject* Sender);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall GetChange(System::TObject* Sender);
	void __fastcall InitScrollBar(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall FixPanelIndex(void);
	virtual void __fastcall UpdatePanelIndex(int Value, int old);
	
public:
	__fastcall virtual TLMDCaptionPanelGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCaptionPanelGroup(void);
	void __fastcall Change(void);
	void __fastcall CollapseAll(void);
	void __fastcall ExpandAll(void);
	void __fastcall ScrollInView(Vcl::Controls::TControl* AControl);
	void __fastcall AllowSizingAll(bool Value = true);
	void __fastcall AllowMovingAll(bool Value = true);
	int __fastcall PanelMaxIndex(void);
	int __fastcall PanelIndexAtPos(int X, int Y);
	void __fastcall PanelExchange(int OldIndex, int NewIndex);
	void __fastcall PanelList(System::Classes::TStrings* Value, bool CustomData = false)/* overload */;
	void __fastcall PanelList(System::Classes::TList* Value)/* overload */;
	__property Lmdcaptionpanel::TLMDCaptionPanel* PanelByName[System::UnicodeString PanelName] = {read=GetPanelByName};
	__property Lmdcaptionpanel::TLMDCaptionPanel* Panels[int PanelIndex] = {read=GetPanelByIndex};
	__property Lmdcaptionpanel::TLMDCaptionPanel* PanelByData[System::UnicodeString PanelData] = {read=GetPanelByData};
	__property Lmdcaptionpanel::TLMDCaptionPanel* PanelByCaption[System::UnicodeString PanelCaption] = {read=GetPanelByCaption};
	__property Vcl::Stdctrls::TScrollBar* ScrollBar = {read=FScrollBar};
	
__published:
	__property bool AutoExpand = {read=FAutoExpand, write=SetAutoExpand, default=0};
	__property System::Byte PanelGap = {read=FPanelGap, write=SetPanelGap, default=1};
	__property Lmdgraph::TLMDOrientation Orientation = {read=FOrientation, write=SetOrientation, default=1};
	__property System::Byte Margin = {read=FMargin, write=SetMargin, default=3};
	__property System::Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property System::UnicodeString IniKey = {read=FIniKey, write=FIniKey, stored=SaveIniKey};
	__property System::UnicodeString IniSection = {read=FIniSection, write=FIniSection, stored=SaveIniSection};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property TLMDCPGIniSaveOptions IniSaveOptions = {read=FIniSaveOptions, write=FIniSaveOptions, default=31};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniReadData = {read=FOnIniReadData, write=FOnIniReadData};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniWriteData = {read=FOnIniWriteData, write=FOnIniWriteData};
	__property AllowSizing = {default=0};
	__property AllowMoving = {default=0};
	__property ControlLocked = {default=0};
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
	__property Bevel;
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
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
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCaptionPanelGroup(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString IDS_CAPTIONPANELGROUPSAVE;
static const System::Word CM_LMDUpdatePanel = System::Word(0x283c);
#define def_LMDCPGOptions (System::Set<TLMDCPGIniSaveOption, TLMDCPGIniSaveOption::cpgIndex, TLMDCPGIniSaveOption::cpgScrollPos>() << TLMDCPGIniSaveOption::cpgIndex << TLMDCPGIniSaveOption::cpgState << TLMDCPGIniSaveOption::cpgVisible << TLMDCPGIniSaveOption::cpgDimensions << TLMDCPGIniSaveOption::cpgScrollPos )
}	/* namespace Lmdcaptionpanelgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCAPTIONPANELGROUP)
using namespace Lmdcaptionpanelgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcaptionpanelgroupHPP
