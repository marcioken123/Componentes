// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysEventListView.pas' rev: 31.00 (Windows)

#ifndef LmdsyseventlistviewHPP
#define LmdsyseventlistviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <LMDSysBase.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyseventlistview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysEventListView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysEventListView : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Vcl::Controls::TImageList* FImageList;
	Lmdsysbase::TLMDSysComponent* FController;
	HWND FHeaderHandle;
	int FHeaderID;
	int FClickedColumn;
	Lmdsysbase::TLMDSysDirection FSortDirection;
	void __fastcall AddColumn(const System::UnicodeString aCaption, int aWidth, System::Classes::TAlignment Alignment = (System::Classes::TAlignment)(0x0));
	bool __fastcall CheckFlags(void);
	void __fastcall DrawHeaderItem(Winapi::Windows::PDrawItemStruct PDIS);
	void __fastcall LoadImageList(void);
	void __fastcall SetController(Lmdsysbase::TLMDSysComponent* const Value);
	void __fastcall SetSortDirection(const Lmdsysbase::TLMDSysDirection Value);
	void __fastcall SetSortedColumn(const int Value);
	HIDESBASE MESSAGE void __fastcall WMNotify(Winapi::Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMParentNotify(Winapi::Messages::TWMParentNotify &Message);
	
protected:
	DYNAMIC void __fastcall ColClick(Vcl::Comctrls::TListColumn* Column);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDSysEventListView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysEventListView(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Lmdsysbase::TLMDSysComponent* LogControl = {read=FController, write=SetController};
	__property Items;
	void __fastcall Sort(void);
	__property int SortedColumn = {read=FClickedColumn, write=SetSortedColumn, default=-1};
	__property Lmdsysbase::TLMDSysDirection SortDirection = {read=FSortDirection, write=SetSortDirection, default=1};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Align = {default=0};
	__property AllocBy = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property FlatScrollBars = {default=0};
	__property GridLines = {default=0};
	__property HideSelection = {default=0};
	__property HotTrack = {default=0};
	__property HotTrackStyles = {default=0};
	__property HoverTime = {default=-1};
	__property RowSelect = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnInfoTip;
	__property OnInsert;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnSelectItem;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysEventListView(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyseventlistview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSEVENTLISTVIEW)
using namespace Lmdsyseventlistview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyseventlistviewHPP
