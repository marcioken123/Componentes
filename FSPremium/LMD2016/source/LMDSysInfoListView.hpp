// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysInfoListView.pas' rev: 31.00 (Windows)

#ifndef LmdsysinfolistviewHPP
#define LmdsysinfolistviewHPP

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
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysInfoTreeView.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysinfolistview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysInfoListView;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSysInfoListViewGetPropertyImageIndexEvent)(System::TObject* Sender, Lmdsysbase::TLMDSysPropertyType aPropertyType, const System::Variant &aPropertyValue, bool aPropertyAvailable, int &aImageIndex);

typedef void __fastcall (__closure *TLMDSysInfoListViewGetObjectImageIndexEvent)(System::TObject* Sender, System::TObject* aSysInfoObject, Lmdsysbase::TLMDSysInfoType aSysInfoType, int &aImageIndex);

class PASCALIMPLEMENTATION TLMDSysInfoListView : public Lmdcontrol::TLMDBaseListView
{
	typedef Lmdcontrol::TLMDBaseListView inherited;
	
private:
	bool FShow;
	System::TObject* FSysInfoObject;
	Lmdsysbasecomponent::TLMDSysBaseComponent* FSysControl;
	Lmdsysinfotreeview::TLMDSysInfoTreeView* FSysInfoTreeView;
	TLMDSysInfoListViewGetPropertyImageIndexEvent FOnGetPropertyImageIndex;
	TLMDSysInfoListViewGetObjectImageIndexEvent FOnGetObjectImageIndex;
	System::Classes::TCollection* FList;
	Vcl::Controls::TImageList* FImageList;
	System::Classes::TNotifyEvent FOnShow;
	bool FShowDescriptionColumn;
	void __fastcall SetSysControl(Lmdsysbasecomponent::TLMDSysBaseComponent* const Value);
	void __fastcall SetSysInfoObject(System::TObject* const value);
	void __fastcall SetSysInfoTreeView(Lmdsysinfotreeview::TLMDSysInfoTreeView* const value);
	bool __fastcall CheckFlags(void);
	HIDESBASE void __fastcall AddItem(System::UnicodeString aName, System::UnicodeString aValue, System::UnicodeString aDesc, int aImageIndex = 0xffffffff);
	void __fastcall AddProperties(System::TObject* aObject);
	void __fastcall AddSubItems(System::TObject* aObject);
	void __fastcall AddColumn(System::UnicodeString aCaption, int aWidth);
	void __fastcall Populate(System::TObject* aSystemInfo);
	void __fastcall LoadImageList(void);
	void __fastcall SetShowDescriptionColumn(const bool Value);
	
protected:
	virtual int __fastcall GetPropertyImageIndex(System::TObject* aSysInfoObject, int index);
	virtual int __fastcall GetObjectImageIndex(System::TObject* aSysInfoObject);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall OwnerDataFetch(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemRequest Request);
	
public:
	__fastcall virtual TLMDSysInfoListView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysInfoListView(void);
	virtual void __fastcall Update(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall Loaded(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Columns;
	__property System::TObject* SysInfoObject = {read=FSysInfoObject, write=SetSysInfoObject};
	
__published:
	__property Lmdsysbasecomponent::TLMDSysBaseComponent* SysInfoControl = {read=FSysControl, write=SetSysControl};
	__property Lmdsysinfotreeview::TLMDSysInfoTreeView* SysInfoTreeView = {read=FSysInfoTreeView, write=SetSysInfoTreeView};
	__property bool ShowStrDlg = {read=FShow, write=FShow, default=1};
	__property System::Classes::TNotifyEvent OnShowStrDlg = {read=FOnShow, write=FOnShow};
	__property About = {default=0};
	__property bool ShowDescriptionColumn = {read=FShowDescriptionColumn, write=SetShowDescriptionColumn, default=1};
	__property Align = {default=0};
	__property AllocBy = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property Font;
	__property FlatScrollBars = {default=0};
	__property GridLines = {default=0};
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property HotTrackStyles = {default=0};
	__property HoverTime = {default=-1};
	__property IconOptions;
	__property Items;
	__property LargeImages;
	__property RowSelect = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property SmallImages;
	__property SortType = {default=0};
	__property StateImages;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnCompare;
	__property OnContextPopup;
	__property OnData;
	__property OnDataFind;
	__property OnDataHint;
	__property OnDataStateChange;
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
	__property TLMDSysInfoListViewGetPropertyImageIndexEvent OnGetPropertyImageIndex = {read=FOnGetPropertyImageIndex, write=FOnGetPropertyImageIndex};
	__property TLMDSysInfoListViewGetObjectImageIndexEvent OnGetObjectImageIndex = {read=FOnGetObjectImageIndex, write=FOnGetObjectImageIndex};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysInfoListView(HWND ParentWindow) : Lmdcontrol::TLMDBaseListView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysinfolistview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSINFOLISTVIEW)
using namespace Lmdsysinfolistview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinfolistviewHPP
