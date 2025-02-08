// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgDiagram.pas' rev: 31.00 (Windows)

#ifndef LmddsgdiagramHPP
#define LmddsgdiagramHPP

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
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDUnicode.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgdiagram
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDDiagram;
class DELPHICLASS TLMDDiagramLink;
class DELPHICLASS TLMDDiagramLinks;
class DELPHICLASS TLMDDiagramItemPanel;
class DELPHICLASS TLMDDiagramItem;
class DELPHICLASS TLMDDiagramItems;
class DELPHICLASS TLMDLinkDrawInfo;
class DELPHICLASS TLMDStdLinkDrawInfo;
struct TLMDLinkDrawInfoRec;
class DELPHICLASS TLMDCustomDiagram;
class DELPHICLASS TLMDDiagram;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDDiagram : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDDiagram(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDDiagram(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDiagram(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDiagram(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDiagram(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDiagram(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDDiagram(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDDiagram(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDiagram(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDiagram(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDiagram(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDiagram(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDDiagram(void) { }
	
};

#pragma pack(pop)

typedef System::UnicodeString TLMDDiagramItemName;

typedef System::UnicodeString TLMDDiagramItemRef;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDiagramLink : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FDInfIndex;
	TLMDDiagramItemRef FEndItemName;
	TLMDDiagramItemRef FBeginItemName;
	TLMDDiagramItem* FBeginItem;
	TLMDDiagramItem* FEndItem;
	System::Uitypes::TColor FColor;
	bool FVisible;
	void *FData;
	void __fastcall DoConnectItems(void);
	void __fastcall SetBeginItemName(const TLMDDiagramItemRef Value);
	void __fastcall SetEndItemName(const TLMDDiagramItemRef Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetVisible(const bool Value);
	bool __fastcall GetSelected(void);
	void __fastcall SetSelected(const bool Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual bool __fastcall CanBeShown(void);
	virtual void __fastcall DoAssign(System::Classes::TPersistent* ASource);
	void __fastcall ConnectItems(void);
	
public:
	__fastcall virtual TLMDDiagramLink(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDDiagramLink(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TLMDDiagramItem* BeginItem = {read=FBeginItem};
	__property TLMDDiagramItem* EndItem = {read=FEndItem};
	__property void * Data = {read=FData, write=FData};
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	
__published:
	__property TLMDDiagramItemRef BeginItemName = {read=FBeginItemName, write=SetBeginItemName};
	__property TLMDDiagramItemRef EndItemName = {read=FEndItemName, write=SetEndItemName};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777208};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDDiagramLinkClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDiagramLinks : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDDiagramLink* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomDiagram* FDiagram;
	HIDESBASE TLMDDiagramLink* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDiagramLink* const Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall virtual TLMDDiagramLinks(TLMDCustomDiagram* ADiagram);
	__property TLMDCustomDiagram* Diagram = {read=FDiagram};
	__property TLMDDiagramLink* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDiagramLinks(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDiagramItemPanel : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	TLMDDiagramItem* FItem;
	Lmdtypes::TLMDString __fastcall GetCaption(void);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Winapi::Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDrag(Vcl::Controls::TCMDrag &Message);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TLMDDiagramItemPanel(System::Classes::TComponent* AOwner, TLMDDiagramItem* AItem);
	__property TLMDDiagramItem* Item = {read=FItem};
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption};
	__property Canvas;
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TLMDDiagramItemPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDiagramItemPanel(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


typedef System::TMetaClass* TLMDDiagramItemPanelClass;

enum DECLSPEC_DENUM Lmddsgdiagram__5 : unsigned char { isBoundsChanged, isCaptionChanged, isColorChanged, isVisibleChanged, isChangingBounds, isCreatingPanel };

typedef System::Set<Lmddsgdiagram__5, Lmddsgdiagram__5::isBoundsChanged, Lmddsgdiagram__5::isCreatingPanel> TLMDDiagramItemState;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDiagramItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDDiagramItemState FState;
	TLMDDiagramItemName FName;
	int FLeft;
	int FTop;
	int FWidth;
	int FHeight;
	Lmdtypes::TLMDString FCaption;
	TLMDDiagramItemPanel* FPanel;
	bool FVisible;
	System::Uitypes::TColor FColor;
	void *FData;
	void __fastcall CreatePanel(void);
	void __fastcall FreePanel(void);
	void __fastcall UpdateBounds(void);
	void __fastcall UpdateDesigner(void);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	void __fastcall SetName(const TLMDDiagramItemName Value);
	void __fastcall SetVisible(const bool Value);
	bool __fastcall GetSelected(void);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual TLMDDiagramItemPanelClass __fastcall GetPanelClass(void);
	virtual void __fastcall Update(bool &ARefreshLinks);
	virtual void __fastcall ForceUpdate(void);
	virtual void __fastcall MakeUpdated(void);
	virtual void __fastcall DoAssign(System::Classes::TPersistent* ASource);
	virtual void __fastcall Select(bool ASelect);
	virtual void __fastcall SetFocus(void);
	__property TLMDDiagramItemState State = {read=FState, nodefault};
	
public:
	__fastcall virtual TLMDDiagramItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDDiagramItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall MakeVisible(void);
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TLMDDiagramItemPanel* Panel = {read=FPanel};
	
__published:
	__property int Left = {read=FLeft, write=SetLeft, nodefault};
	__property int Top = {read=FTop, write=SetTop, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property TLMDDiagramItemName Name = {read=FName, write=SetName};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDDiagramItemClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDiagramItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDDiagramItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomDiagram* FDiagram;
	HIDESBASE TLMDDiagramItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDiagramItem* const Value);
	void __fastcall ReconnectItems(void);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall SetItemName(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall virtual TLMDDiagramItems(TLMDCustomDiagram* ADiagram);
	int __fastcall IndexOf(TLMDDiagramItem* AItem);
	TLMDDiagramItem* __fastcall Find(const TLMDDiagramItemName AName);
	__property TLMDCustomDiagram* Diagram = {read=FDiagram};
	__property TLMDDiagramItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDiagramItems(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLinkDrawInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDLinkDrawInfo(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLinkDrawInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStdLinkDrawInfo : public TLMDLinkDrawInfo
{
	typedef TLMDLinkDrawInfo inherited;
	
public:
	System::Types::TPoint BeginP;
	System::Types::TPoint EndP;
	System::Types::TPoint LineBegin;
	System::Types::TPoint LineEnd;
	bool LeftToRight;
	System::Uitypes::TColor Color;
	bool Selected;
public:
	/* TObject.Create */ inline __fastcall TLMDStdLinkDrawInfo(void) : TLMDLinkDrawInfo() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStdLinkDrawInfo(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDLinkDrawInfoClass;

struct DECLSPEC_DRECORD TLMDLinkDrawInfoRec
{
public:
	TLMDDiagramLink* Link;
	TLMDLinkDrawInfo* DrawInfo;
	TLMDLinkDrawInfo* OldDrawInfo;
};


typedef TLMDLinkDrawInfoRec *PLMDLinkDrawInfoRec;

typedef void __fastcall (__closure *TLMDDiagramItemEvent)(System::TObject* Sender, TLMDDiagramItem* AItem);

typedef void __fastcall (__closure *TLMDDiagramLinkEvent)(System::TObject* Sender, TLMDDiagramLink* ALink);

enum DECLSPEC_DENUM Lmddsgdiagram__01 : unsigned char { dsRefreshingLinks, dsChangingSelection, dsErasingLinks, dsLinksChanged, dsRepainted };

typedef System::Set<Lmddsgdiagram__01, Lmddsgdiagram__01::dsRefreshingLinks, Lmddsgdiagram__01::dsRepainted> TLMDDiagramState;

class PASCALIMPLEMENTATION TLMDCustomDiagram : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDDiagramState FState;
	System::Classes::TList* FLinkDInfs;
	int FHScrollPos;
	int FVScrollPos;
	int FDiagramWidth;
	int FDiagramHeight;
	bool FReadOnly;
	TLMDDiagramLinks* FLinks;
	TLMDDiagramItems* FItems;
	TLMDDiagramItem* FSelectedItem;
	TLMDDiagramLink* FSelectedLink;
	System::Classes::TNotifyEvent FOnChangeSelection;
	System::Classes::TNotifyEvent FOnChange;
	System::Uitypes::TScrollStyle FScrollBars;
	bool FThumbTrack;
	bool FItemAutoPos;
	TLMDDiagramItemEvent FOnInsertItem;
	TLMDDiagramItemEvent FOnDeleteItem;
	TLMDDiagramLinkEvent FOnInsertLink;
	TLMDDiagramLinkEvent FOnDeleteLink;
	System::Types::TPoint __fastcall CalcItemPos(int AWidth, int AHeight);
	void __fastcall UpdateScrollBars(void);
	bool __fastcall IsActiveControl(void);
	void __fastcall FreeLinkDInfs(System::Classes::TList* AInfs);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	void __fastcall SetDiagramHeight(const int Value);
	void __fastcall SetDiagramWidth(const int Value);
	void __fastcall SetLinks(TLMDDiagramLinks* const Value);
	void __fastcall SetItems(TLMDDiagramItems* const Value);
	void __fastcall SetSelectedItem(TLMDDiagramItem* const Value);
	void __fastcall SetSelectedLink(TLMDDiagramLink* const Value);
	void __fastcall SetHScrollPos(const int Value);
	void __fastcall SetVScrollPos(const int Value);
	void __fastcall SetScrollBars(const System::Uitypes::TScrollStyle Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall EraseLinks(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall Resize(void);
	virtual TLMDDiagramLinkClass __fastcall GetLinkClass(void);
	virtual TLMDDiagramLinks* __fastcall CreateLinks(void);
	virtual TLMDDiagramItemClass __fastcall GetItemClass(void);
	virtual TLMDDiagramItems* __fastcall CreateItems(void);
	virtual TLMDLinkDrawInfoClass __fastcall GetLinkDrawInfoClass(void);
	virtual TLMDLinkDrawInfo* __fastcall CreateLinkDrawInfo(TLMDDiagramLink* ALink);
	virtual bool __fastcall IsEqualDrawInfos(TLMDLinkDrawInfo* ADrawInfo1, TLMDLinkDrawInfo* ADrawInfo2);
	virtual bool __fastcall IsOnLink(TLMDLinkDrawInfo* ADrawInfo, int AX, int AY);
	virtual void __fastcall PaintLink(TLMDLinkDrawInfo* ADrawInfo, bool AClear);
	virtual void __fastcall PaintItem(TLMDDiagramItemPanel* APanel);
	virtual void __fastcall ChangeSelection(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall ItemInsert(TLMDDiagramItem* AItem);
	virtual void __fastcall ItemDelete(TLMDDiagramItem* AItem);
	virtual void __fastcall LinkInsert(TLMDDiagramLink* ALink);
	virtual void __fastcall LinkDelete(TLMDDiagramLink* ALink);
	__property TLMDDiagramState State = {read=FState, nodefault};
	__property bool ItemAutoPos = {read=FItemAutoPos, write=FItemAutoPos, default=1};
	__property TLMDDiagramItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property TLMDDiagramLink* SelectedLink = {read=FSelectedLink, write=SetSelectedLink};
	__property System::Uitypes::TScrollStyle ScrollBars = {read=FScrollBars, write=SetScrollBars, default=3};
	__property int HScrollPos = {read=FHScrollPos, write=SetHScrollPos, nodefault};
	__property int VScrollPos = {read=FVScrollPos, write=SetVScrollPos, nodefault};
	__property bool ThumbTrack = {read=FThumbTrack, write=FThumbTrack, default=0};
	__property int DiagramWidth = {read=FDiagramWidth, write=SetDiagramWidth, nodefault};
	__property int DiagramHeight = {read=FDiagramHeight, write=SetDiagramHeight, nodefault};
	__property TLMDDiagramLinks* Links = {read=FLinks, write=SetLinks};
	__property TLMDDiagramItems* Items = {read=FItems, write=SetItems};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnChangeSelection = {read=FOnChangeSelection, write=FOnChangeSelection};
	__property TLMDDiagramItemEvent OnInsertItem = {read=FOnInsertItem, write=FOnInsertItem};
	__property TLMDDiagramItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property TLMDDiagramLinkEvent OnInsertLink = {read=FOnInsertLink, write=FOnInsertLink};
	__property TLMDDiagramLinkEvent OnDeleteLink = {read=FOnDeleteLink, write=FOnDeleteLink};
	__property BorderStyle = {default=1};
	
public:
	__fastcall virtual TLMDCustomDiagram(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomDiagram(void);
	HIDESBASE void __fastcall ScrollBy(int ADeltaX, int ADeltaY);
	void __fastcall RefreshLinks(void);
	TLMDDiagramLink* __fastcall LinkAtPos(int AX, int AY);
	System::Types::TRect __fastcall ItemRect(int AIndex);
	TLMDDiagramItem* __fastcall ItemAtPos(int AX, int AY);
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomDiagram(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TLMDDiagramOnPaintItem)(System::TObject* Sender, TLMDDiagramItemPanel* APanel);

typedef void __fastcall (__closure *TLMDDiagramOnCreateLinkDrawInfo)(System::TObject* Sender, TLMDDiagramLink* ALink, TLMDLinkDrawInfo* &ADrawInfo);

typedef void __fastcall (__closure *TLMDDiagramOnIsEqualDrawInfos)(System::TObject* Sender, TLMDLinkDrawInfo* ADrawInfo1, TLMDLinkDrawInfo* ADrawInfo2, bool &AIsEqual);

typedef void __fastcall (__closure *TLMDDiagramOnIsOnLink)(System::TObject* Sender, TLMDLinkDrawInfo* ADrawInfo, int AX, int AY, bool &AIsOnLink);

typedef void __fastcall (__closure *TLMDDiagramOnPaintLink)(System::TObject* Sender, TLMDLinkDrawInfo* ADrawInfo, bool AClear);

class PASCALIMPLEMENTATION TLMDDiagram : public TLMDCustomDiagram
{
	typedef TLMDCustomDiagram inherited;
	
private:
	TLMDDiagramOnPaintItem FOnPaintItem;
	bool FCustomDrawItems;
	bool FCustomDrawLinks;
	TLMDDiagramOnCreateLinkDrawInfo FOnCreateLinkDrawInfo;
	TLMDDiagramOnIsEqualDrawInfos FOnIsEqualDrawInfos;
	TLMDDiagramOnIsOnLink FOnIsOnLink;
	TLMDDiagramOnPaintLink FOnPaintLink;
	void __fastcall SetCustomDrawItems(const bool Value);
	void __fastcall SetCustomDrawLinks(const bool Value);
	
protected:
	virtual TLMDLinkDrawInfo* __fastcall CreateLinkDrawInfo(TLMDDiagramLink* ALink);
	virtual bool __fastcall IsEqualDrawInfos(TLMDLinkDrawInfo* ADrawInfo1, TLMDLinkDrawInfo* ADrawInfo2);
	virtual bool __fastcall IsOnLink(TLMDLinkDrawInfo* ADrawInfo, int AX, int AY);
	virtual void __fastcall PaintLink(TLMDLinkDrawInfo* ADrawInfo, bool AClear);
	virtual void __fastcall PaintItem(TLMDDiagramItemPanel* APanel);
	
public:
	__property Canvas;
	__property SelectedItem;
	__property SelectedLink;
	__property HScrollPos;
	__property VScrollPos;
	
__published:
	__property bool CustomDrawItems = {read=FCustomDrawItems, write=SetCustomDrawItems, default=0};
	__property bool CustomDrawLinks = {read=FCustomDrawLinks, write=SetCustomDrawLinks, default=0};
	__property TLMDDiagramOnPaintItem OnPaintItem = {read=FOnPaintItem, write=FOnPaintItem};
	__property TLMDDiagramOnCreateLinkDrawInfo OnCreateLinkDrawInfo = {read=FOnCreateLinkDrawInfo, write=FOnCreateLinkDrawInfo};
	__property TLMDDiagramOnIsEqualDrawInfos OnIsEqualDrawInfos = {read=FOnIsEqualDrawInfos, write=FOnIsEqualDrawInfos};
	__property TLMDDiagramOnIsOnLink OnIsOnLink = {read=FOnIsOnLink, write=FOnIsOnLink};
	__property TLMDDiagramOnPaintLink OnPaintLink = {read=FOnPaintLink, write=FOnPaintLink};
	__property ItemAutoPos = {default=1};
	__property ScrollBars = {default=3};
	__property DiagramWidth;
	__property DiagramHeight;
	__property Links;
	__property Items;
	__property ReadOnly = {default=0};
	__property ThumbTrack = {default=0};
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
	/* TLMDCustomDiagram.Create */ inline __fastcall virtual TLMDDiagram(System::Classes::TComponent* AOwner) : TLMDCustomDiagram(AOwner) { }
	/* TLMDCustomDiagram.Destroy */ inline __fastcall virtual ~TLMDDiagram(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDiagram(HWND ParentWindow) : TLMDCustomDiagram(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgdiagram */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGDIAGRAM)
using namespace Lmddsgdiagram;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgdiagramHPP
