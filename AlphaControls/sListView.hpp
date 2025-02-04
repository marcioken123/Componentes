// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sListView.pas' rev: 27.00 (Windows)

#ifndef SlistviewHPP
#define SlistviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sMessages.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Slistview
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TColumnResizeEvent)(Vcl::Comctrls::TCustomListView* sender, int columnIndex, int columnWidth);

class DELPHICLASS TsCustomListView;
class PASCALIMPLEMENTATION TsCustomListView : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
private:
	bool Loading;
	HWND FhWndHeader;
	void *FhHeaderProc;
	void *FhDefHeaderProc;
	int FPressedColumn;
	Scommondata::TsScrollWndData* FCommonData;
	int HoverColIndex;
	Scommondata::TsBoundLabel* FBoundLabel;
	bool FHighlightHeaders;
	bool SkipAdvancedDraw;
	Vcl::Comctrls::TLVCustomDrawItemEvent FOldCustomDrawItem;
	Vcl::Comctrls::TLVAdvancedCustomDrawEvent FOldAdvancedCustomDraw;
	Vcl::Comctrls::TLVAdvancedCustomDrawItemEvent FOldAdvancedCustomDrawItem;
	bool FFlag;
	Vcl::Stdctrls::TMeasureItemEvent FOnMeasureItem;
	TColumnResizeEvent FColumnResizeEvent;
	TColumnResizeEvent FEndColumnResizeEvent;
	TColumnResizeEvent FBeginColumnResizeEvent;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMHitTest(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMParentNotify(Winapi::Messages::TWMParentNotify &Message);
	void __fastcall NewCustomDrawItem(Vcl::Comctrls::TCustomListView* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall NewAdvancedCustomDraw(Vcl::Comctrls::TCustomListView* Sender, const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall NewAdvancedCustomDrawItem(Vcl::Comctrls::TCustomListView* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall NewAdvancedCustomDrawSubItem(Vcl::Comctrls::TCustomListView* Sender, Vcl::Comctrls::TListItem* Item, int SubItem, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw, Vcl::Graphics::TBitmap* Bmp)/* overload */;
	void __fastcall PrepareCache(void);
	System::Types::TRect __fastcall GetHeaderColumnRect(const int Index);
	void __fastcall ColumnSkinPaint(const System::Types::TRect &ControlRect, const int cIndex);
	void __fastcall PaintHeader(void);
	
protected:
	bool NewStyleItems;
	int HotItem;
	Acsbutils::TacScrollWnd* ListSW;
	int iSelectIndex;
	bool StyleChanging;
	void __fastcall DoBeginColumnResize(const int ColumnIndex, const int ColumnWidth);
	void __fastcall DoEndColumnResize(const int ColumnIndex, const int ColumnWidth);
	void __fastcall DoColumnResize(const int ColumnIndex, const int ColumnWidth);
	HIDESBASE MESSAGE void __fastcall WMNotify(Winapi::Messages::TWMNotify &msg);
	int __fastcall FindColumnIndex(const Winapi::Windows::PNMHdr pHeader);
	int __fastcall FindColumnWidth(const Winapi::Windows::PNMHdr pHeader);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE void __fastcall HeaderWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall InitSkinParams(void);
	int __fastcall AllColWidth(void);
	bool __fastcall FullRepaint(void);
	bool __fastcall ItemIsHot(Vcl::Comctrls::TListItem* const Item, const System::Types::TRect &R);
	__property BorderStyle = {default=1};
	NativeUInt __fastcall MakeDragImage(const Winapi::Messages::TMessage &Message);
	void __fastcall InvalidateSmooth(const bool Always);
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	virtual void __fastcall SetViewStyle(Vcl::Comctrls::TViewStyle Value);
	
public:
	int __fastcall ColumnLeft(const int Index);
	__fastcall virtual TsCustomListView(System::Classes::TComponent* AOwner);
	virtual void __fastcall InitControl(const bool Skinned);
	__fastcall virtual ~TsCustomListView(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SelectItem(const int Index);
	
__published:
	__property Action;
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelEdges = {default=15};
	__property DoubleBuffered;
	__property Groups;
	__property GroupView = {default=0};
	__property GroupHeaderImages;
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property Scommondata::TsScrollWndData* SkinData = {read=FCommonData, write=FCommonData};
	__property bool HighlightHeaders = {read=FHighlightHeaders, write=FHighlightHeaders, default=1};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=FOnMeasureItem, write=FOnMeasureItem};
	__property OnItemChecked;
	__property TColumnResizeEvent OnBeginColumnResize = {read=FBeginColumnResizeEvent, write=FBeginColumnResizeEvent};
	__property TColumnResizeEvent OnEndColumnResize = {read=FEndColumnResizeEvent, write=FEndColumnResizeEvent};
	__property TColumnResizeEvent OnColumnResize = {read=FColumnResizeEvent, write=FColumnResizeEvent};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomListView(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
};


class DELPHICLASS TsListView;
class PASCALIMPLEMENTATION TsListView : public TsCustomListView
{
	typedef TsCustomListView inherited;
	
__published:
	__property Align = {default=0};
	__property AllocBy = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Checkboxes = {default=0};
	__property Color = {default=-16777211};
	__property Columns;
	__property ColumnClick = {default=1};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property FlatScrollBars = {default=0};
	__property FullDrag = {default=0};
	__property GridLines = {default=0};
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property HotTrackStyles = {default=0};
	__property HoverTime = {default=-1};
	__property IconOptions;
	__property Items;
	__property LargeImages;
	__property MultiSelect = {default=0};
	__property OwnerData = {default=0};
	__property OwnerDraw = {default=0};
	__property ReadOnly = {default=0};
	__property RowSelect = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowColumnHeaders = {default=1};
	__property ShowWorkAreas = {default=0};
	__property ShowHint;
	__property SmallImages;
	__property SortType = {default=0};
	__property StateImages;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ViewStyle = {default=0};
	__property Visible = {default=1};
	__property OnAdvancedCustomDraw;
	__property OnAdvancedCustomDrawItem;
	__property OnAdvancedCustomDrawSubItem;
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnColumnClick;
	__property OnColumnDragged;
	__property OnColumnRightClick;
	__property OnCompare;
	__property OnContextPopup;
	__property OnCustomDraw;
	__property OnCustomDrawItem;
	__property OnCustomDrawSubItem;
	__property OnData;
	__property OnDataFind;
	__property OnDataHint;
	__property OnDataStateChange;
	__property OnDblClick;
	__property OnDeletion;
	__property OnDrawItem;
	__property OnEdited;
	__property OnEditing;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetImageIndex;
	__property OnGetSubItemImage;
	__property OnDragDrop;
	__property OnDragOver;
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
	__property OnStartDock;
	__property OnStartDrag;
	__property BoundLabel;
	__property SkinData;
public:
	/* TsCustomListView.Create */ inline __fastcall virtual TsListView(System::Classes::TComponent* AOwner) : TsCustomListView(AOwner) { }
	/* TsCustomListView.Destroy */ inline __fastcall virtual ~TsListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsListView(HWND ParentWindow) : TsCustomListView(ParentWindow) { }
	
};


class DELPHICLASS TsHackedListItems;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsHackedListItems : public Vcl::Comctrls::TListItems
{
	typedef Vcl::Comctrls::TListItems inherited;
	
public:
	bool FNoRedraw;
public:
	/* TListItems.Create */ inline __fastcall TsHackedListItems(Vcl::Comctrls::TCustomListView* AOwner) : Vcl::Comctrls::TListItems(AOwner) { }
	/* TListItems.Destroy */ inline __fastcall virtual ~TsHackedListItems(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool acSmallCheckBoxes;
extern DELPHI_PACKAGE void __fastcall ListViewToCSV(TsListView* LV, const System::UnicodeString FileName);
}	/* namespace Slistview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SLISTVIEW)
using namespace Slistview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SlistviewHPP
