// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgDiagramDB.pas' rev: 31.00 (Windows)

#ifndef LmddsgdiagramdbHPP
#define LmddsgdiagramdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <LMDUnicode.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgDiagram.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgdiagramdb
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBDiagramLink;
class DELPHICLASS TLMDDBDiagramLinks;
class DELPHICLASS TLMDDBDiagramItemListBox;
class DELPHICLASS TLMDDBDiagramItemPanel;
class DELPHICLASS TLMDDBDiagramItem;
class DELPHICLASS TLMDDBDiagramItems;
class DELPHICLASS TLMDDBLinkDrawInfo;
class DELPHICLASS TLMDDBDiagram;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDBLinkPointType : unsigned char { lptNone, lptOne, lptInfinity };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBDiagramLink : public Lmddsgdiagram::TLMDDiagramLink
{
	typedef Lmddsgdiagram::TLMDDiagramLink inherited;
	
private:
	int FBeginLineIndex;
	int FEndLineIndex;
	TLMDDBLinkPointType FBeginPointType;
	TLMDDBLinkPointType FEndPointType;
	void __fastcall SetBeginLineIndex(const int Value);
	void __fastcall SetEndLineIndex(const int Value);
	void __fastcall SetBeginPointType(const TLMDDBLinkPointType Value);
	void __fastcall SetEndPointType(const TLMDDBLinkPointType Value);
	TLMDDBDiagramItem* __fastcall GetBeginItem(void);
	TLMDDBDiagramItem* __fastcall GetEndItem(void);
	
protected:
	virtual bool __fastcall CanBeShown(void);
	virtual void __fastcall DoAssign(System::Classes::TPersistent* ASource);
	
public:
	__fastcall virtual TLMDDBDiagramLink(System::Classes::TCollection* Collection);
	__property TLMDDBDiagramItem* BeginItem = {read=GetBeginItem};
	__property TLMDDBDiagramItem* EndItem = {read=GetEndItem};
	
__published:
	__property int BeginLineIndex = {read=FBeginLineIndex, write=SetBeginLineIndex, default=-1};
	__property TLMDDBLinkPointType BeginPointType = {read=FBeginPointType, write=SetBeginPointType, default=0};
	__property int EndLineIndex = {read=FEndLineIndex, write=SetEndLineIndex, default=-1};
	__property TLMDDBLinkPointType EndPointType = {read=FEndPointType, write=SetEndPointType, default=0};
public:
	/* TLMDDiagramLink.Destroy */ inline __fastcall virtual ~TLMDDBDiagramLink(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBDiagramLinks : public Lmddsgdiagram::TLMDDiagramLinks
{
	typedef Lmddsgdiagram::TLMDDiagramLinks inherited;
	
public:
	TLMDDBDiagramLink* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDDBDiagramLink* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDBDiagramLink* const Value);
	TLMDDBDiagram* __fastcall GetDiagram(void);
	
public:
	__property TLMDDBDiagram* Diagram = {read=GetDiagram};
	__property TLMDDBDiagramLink* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDDiagramLinks.Create */ inline __fastcall virtual TLMDDBDiagramLinks(Lmddsgdiagram::TLMDCustomDiagram* ADiagram) : Lmddsgdiagram::TLMDDiagramLinks(ADiagram) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDBDiagramLinks(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDBDiagramItemListBox : public Vcl::Stdctrls::TCustomListBox
{
	typedef Vcl::Stdctrls::TCustomListBox inherited;
	
private:
	System::Classes::TStrings* FItems;
	TLMDDBDiagramItemPanel* __fastcall GetPanel(void);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* const Value);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDrag(Vcl::Controls::TCMDrag &Message);
	
protected:
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	__property TLMDDBDiagramItemPanel* Panel = {read=GetPanel};
	
public:
	__fastcall virtual TLMDDBDiagramItemListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBDiagramItemListBox(void);
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBDiagramItemListBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDDBDiagramItemPanel : public Lmddsgdiagram::TLMDDiagramItemPanel
{
	typedef Lmddsgdiagram::TLMDDiagramItemPanel inherited;
	
private:
	TLMDDBDiagramItemListBox* FListBox;
	void __fastcall UpdateListBoxStyle(void);
	TLMDDBDiagramItem* __fastcall GetItem(void);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	__property TLMDDBDiagramItemListBox* ListBox = {read=FListBox};
	
public:
	__fastcall virtual TLMDDBDiagramItemPanel(System::Classes::TComponent* AOwner, Lmddsgdiagram::TLMDDiagramItem* AItem);
	__fastcall virtual ~TLMDDBDiagramItemPanel(void);
	__property TLMDDBDiagramItem* Item = {read=GetItem};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBDiagramItemPanel(HWND ParentWindow) : Lmddsgdiagram::TLMDDiagramItemPanel(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBDiagramItem : public Lmddsgdiagram::TLMDDiagramItem
{
	typedef Lmddsgdiagram::TLMDDiagramItem inherited;
	
private:
	bool FItemsChanged;
	int FOldItemIndex;
	int FLineIndex;
	System::Classes::TStrings* FLines;
	void __fastcall UpdateListBoxStyle(void);
	bool __fastcall ListBoxAvailable(void);
	void __fastcall LinesChange(System::TObject* Sender);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	int __fastcall GetLineIndex(void);
	void __fastcall SetLineIndex(int Value);
	TLMDDBDiagramItemPanel* __fastcall GetPanel(void);
	
protected:
	virtual void __fastcall DoAssign(System::Classes::TPersistent* ASource);
	virtual void __fastcall Update(bool &ARefreshLinks);
	virtual void __fastcall ForceUpdate(void);
	virtual void __fastcall MakeUpdated(void);
	virtual Lmddsgdiagram::TLMDDiagramItemPanelClass __fastcall GetPanelClass(void);
	virtual void __fastcall Select(bool ASelect);
	virtual void __fastcall SetFocus(void);
	__property TLMDDBDiagramItemPanel* Panel = {read=GetPanel};
	
public:
	__fastcall virtual TLMDDBDiagramItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDDBDiagramItem(void);
	int __fastcall LineAtPos(const System::Types::TPoint &APos, bool AExisting);
	
__published:
	__property Color = {default=-16777211};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBDiagramItems : public Lmddsgdiagram::TLMDDiagramItems
{
	typedef Lmddsgdiagram::TLMDDiagramItems inherited;
	
public:
	TLMDDBDiagramItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDDBDiagramItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDBDiagramItem* const Value);
	TLMDDBDiagram* __fastcall GetDiagram(void);
	
public:
	HIDESBASE TLMDDBDiagramItem* __fastcall Find(const Lmdtypes::TLMDString AName);
	__property TLMDDBDiagram* Diagram = {read=GetDiagram};
	__property TLMDDBDiagramItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDDiagramItems.Create */ inline __fastcall virtual TLMDDBDiagramItems(Lmddsgdiagram::TLMDCustomDiagram* ADiagram) : Lmddsgdiagram::TLMDDiagramItems(ADiagram) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDBDiagramItems(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBLinkDrawInfo : public Lmddsgdiagram::TLMDStdLinkDrawInfo
{
	typedef Lmddsgdiagram::TLMDStdLinkDrawInfo inherited;
	
public:
	TLMDDBLinkPointType BeginType;
	TLMDDBLinkPointType EndType;
public:
	/* TObject.Create */ inline __fastcall TLMDDBLinkDrawInfo(void) : Lmddsgdiagram::TLMDStdLinkDrawInfo() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDBLinkDrawInfo(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDDBDiagramMeasureItemLine)(System::TObject* Sender, TLMDDBDiagramItem* AItem, int ALineIndex, int &AHeight);

typedef void __fastcall (__closure *TLMDDBDiagramDrawItemLine)(System::TObject* Sender, TLMDDBDiagramItem* AItem, int ALineIndex, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState AState);

typedef void __fastcall (__closure *TLMDDBDiagramItemClick)(System::TObject* Sender, TLMDDBDiagramItem* AItem);

class PASCALIMPLEMENTATION TLMDDBDiagram : public Lmddsgdiagram::TLMDCustomDiagram
{
	typedef Lmddsgdiagram::TLMDCustomDiagram inherited;
	
private:
	Vcl::Graphics::TBitmap* FOneBitmap;
	Vcl::Graphics::TBitmap* FInfinityBitmap;
	Vcl::Stdctrls::TListBoxStyle FItemStyle;
	TLMDDBDiagramDrawItemLine FOnDrawItemLine;
	TLMDDBDiagramMeasureItemLine FOnMeasureItemLine;
	TLMDDBDiagramItemClick FOnItemClick;
	TLMDDBDiagramItems* __fastcall GetItems(void);
	HIDESBASE void __fastcall SetItems(TLMDDBDiagramItems* const Value);
	TLMDDBDiagramLinks* __fastcall GetLinks(void);
	HIDESBASE void __fastcall SetLinks(TLMDDBDiagramLinks* const Value);
	void __fastcall SetItemStyle(const Vcl::Stdctrls::TListBoxStyle Value);
	int __fastcall GetSelectedItemLine(void);
	void __fastcall SetSelectedItemLine(const int Value);
	TLMDDBDiagramItem* __fastcall GetSelectedItem(void);
	TLMDDBDiagramLink* __fastcall GetSelectedLink(void);
	HIDESBASE void __fastcall SetSelectedItem(TLMDDBDiagramItem* const Value);
	HIDESBASE void __fastcall SetSelectedLink(TLMDDBDiagramLink* const Value);
	
protected:
	virtual Lmddsgdiagram::TLMDDiagramItemClass __fastcall GetItemClass(void);
	virtual Lmddsgdiagram::TLMDDiagramLinkClass __fastcall GetLinkClass(void);
	virtual Lmddsgdiagram::TLMDLinkDrawInfo* __fastcall CreateLinkDrawInfo(Lmddsgdiagram::TLMDDiagramLink* ALink);
	virtual bool __fastcall IsEqualDrawInfos(Lmddsgdiagram::TLMDLinkDrawInfo* ADrawInfo1, Lmddsgdiagram::TLMDLinkDrawInfo* ADrawInfo2);
	virtual Lmddsgdiagram::TLMDLinkDrawInfoClass __fastcall GetLinkDrawInfoClass(void);
	virtual void __fastcall PaintLink(Lmddsgdiagram::TLMDLinkDrawInfo* ADrawInfo, bool AClear);
	virtual Lmddsgdiagram::TLMDDiagramItems* __fastcall CreateItems(void);
	virtual Lmddsgdiagram::TLMDDiagramLinks* __fastcall CreateLinks(void);
	virtual void __fastcall ItemInsert(Lmddsgdiagram::TLMDDiagramItem* AItem);
	virtual void __fastcall DBItemInsert(Lmddsgdiagram::TLMDDiagramItem* AItem);
	virtual void __fastcall ItemDelete(Lmddsgdiagram::TLMDDiagramItem* AItem);
	virtual void __fastcall DBItemDelete(Lmddsgdiagram::TLMDDiagramItem* AItem);
	virtual bool __fastcall MeasureItemLine(TLMDDBDiagramItem* AItem, int ALineIndex, int &AHeight);
	virtual bool __fastcall DrawItemLine(TLMDDBDiagramItem* AItem, int ALineIndex, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState AState);
	virtual void __fastcall ItemClick(TLMDDBDiagramItem* AItem);
	
public:
	__fastcall virtual TLMDDBDiagram(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBDiagram(void);
	HIDESBASE TLMDDBDiagramLink* __fastcall LinkAtPos(int AX, int AY);
	HIDESBASE TLMDDBDiagramItem* __fastcall ItemAtPos(int AX, int AY);
	__property int SelectedItemLine = {read=GetSelectedItemLine, write=SetSelectedItemLine, nodefault};
	__property TLMDDBDiagramItem* SelectedItem = {read=GetSelectedItem, write=SetSelectedItem};
	__property TLMDDBDiagramLink* SelectedLink = {read=GetSelectedLink, write=SetSelectedLink};
	__property HScrollPos;
	__property VScrollPos;
	
__published:
	__property ItemAutoPos = {default=1};
	__property ScrollBars = {default=3};
	__property DiagramWidth;
	__property DiagramHeight;
	__property ReadOnly = {default=0};
	__property TLMDDBDiagramLinks* Links = {read=GetLinks, write=SetLinks};
	__property TLMDDBDiagramItems* Items = {read=GetItems, write=SetItems};
	__property Vcl::Stdctrls::TListBoxStyle ItemStyle = {read=FItemStyle, write=SetItemStyle, default=0};
	__property ThumbTrack = {default=0};
	__property TLMDDBDiagramMeasureItemLine OnMeasureItemLine = {read=FOnMeasureItemLine, write=FOnMeasureItemLine};
	__property TLMDDBDiagramDrawItemLine OnDrawItemLine = {read=FOnDrawItemLine, write=FOnDrawItemLine};
	__property TLMDDBDiagramItemClick OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property OnChange;
	__property OnChangeSelection;
	__property OnInsertItem;
	__property OnDeleteItem;
	__property OnInsertLink;
	__property OnDeleteLink;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBDiagram(HWND ParentWindow) : Lmddsgdiagram::TLMDCustomDiagram(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgdiagramdb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGDIAGRAMDB)
using namespace Lmddsgdiagramdb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgdiagramdbHPP
