// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeDebugCtrls.pas' rev: 31.00 (Windows)

#ifndef LmdidedebugctrlsHPP
#define LmdidedebugctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Grids.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDHashTable.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDSctScripter.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidedebugctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ILMDDbgSourceNotifier;
class DELPHICLASS TLMDDebuggerSource;
class DELPHICLASS TLMDCallStackView;
class DELPHICLASS TLMDCallStackComboBox;
struct TLMDNodeDescr;
struct TLMDNodeData;
class DELPHICLASS TLMDExpandedNode;
class DELPHICLASS TLMDRootExpandedNode;
class DELPHICLASS TLMDVarsTreeBase;
class DELPHICLASS TLMDVariablesView;
class DELPHICLASS TLMDWatchItem;
class DELPHICLASS TLMDWatchItems;
class DELPHICLASS TLMDWatchView;
class DELPHICLASS TLMDEventLogView;
class DELPHICLASS TLMDBreakpointsView;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdidedebugctrls__1 : unsigned char { scFrameIndex, scDebuggerState, scDebugNameChanged };

typedef System::Set<Lmdidedebugctrls__1, Lmdidedebugctrls__1::scFrameIndex, Lmdidedebugctrls__1::scDebugNameChanged> TLMDDbgSourceChange;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDDbgSourceNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall StateChanged(TLMDDbgSourceChange AChange) = 0 ;
	virtual void __fastcall LogMessage(const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind) = 0 ;
	virtual void __fastcall BreakpointsChanged(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDDbgSourceNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDDbgSourceNotifier(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDDebuggerSourceOnLogMessage)(System::TObject* Sender, const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind);

class PASCALIMPLEMENTATION TLMDDebuggerSource : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	Lmdsctscripter::TLMDScriptDebugger* FDebugger;
	int FStackFrameIndex;
	Lmdsctscripter::ILMDScriptDebuggerNotifier* FDbgNotifier;
	System::Classes::TList* FNotifiers;
	System::Classes::TNotifyEvent FOnStateChanged;
	TLMDDebuggerSourceOnLogMessage FOnLogMessage;
	System::Classes::TNotifyEvent FOnBreakpointsChanged;
	void __fastcall AdjustFrameIndex(void);
	void __fastcall DebuggerBreaked(Lmdsctscripter::TLMDScriptDebugger* ADebugger);
	void __fastcall DebuggerResumed(Lmdsctscripter::TLMDScriptDebugger* ADebugger);
	void __fastcall DebugNameChanged(Lmdsctscripter::TLMDScriptDebugger* ADebugger, Lmdsctscripter::TLMDScriptControl* AScript);
	void __fastcall DebugLogMessage(Lmdsctscripter::TLMDScriptDebugger* ADebugger, const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind);
	void __fastcall BreakpointsChanged(Lmdsctscripter::TLMDScriptDebugger* ADebugger);
	void __fastcall SetDebugger(Lmdsctscripter::TLMDScriptDebugger* const Value);
	void __fastcall SetStackFrameIndex(const int Value);
	Lmdsctscripter::TLMDStackFrame* __fastcall GetStackFrame(void);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoStateChanged(TLMDDbgSourceChange AChange);
	virtual void __fastcall DoLogMessage(const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind);
	virtual void __fastcall DoBreakpointsChanged(void);
	
public:
	__fastcall virtual TLMDDebuggerSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDebuggerSource(void);
	void __fastcall AddNotifier(ILMDDbgSourceNotifier* ANotifier);
	void __fastcall RemoveNotifier(ILMDDbgSourceNotifier* ANotifier);
	__property int StackFrameIndex = {read=FStackFrameIndex, write=SetStackFrameIndex, nodefault};
	__property Lmdsctscripter::TLMDStackFrame* StackFrame = {read=GetStackFrame};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property Lmdsctscripter::TLMDScriptDebugger* Debugger = {read=FDebugger, write=SetDebugger};
	__property System::Classes::TNotifyEvent OnStateChanged = {read=FOnStateChanged, write=FOnStateChanged};
	__property TLMDDebuggerSourceOnLogMessage OnLogMessage = {read=FOnLogMessage, write=FOnLogMessage};
	__property System::Classes::TNotifyEvent OnBreakpointsChanged = {read=FOnBreakpointsChanged, write=FOnBreakpointsChanged};
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


typedef void __fastcall (__closure *TLMDCallStackViewOnGetCaption)(System::TObject* Sender, Lmdsctscripter::TLMDStackFrame* AFrame, Lmdtypes::TLMDString &S);

typedef void __fastcall (__closure *TLMDCallStackViewOnGetImageIndex)(System::TObject* Sender, Lmdsctscripter::TLMDStackFrame* AFrame, System::Uitypes::TImageIndex &AImageIndex);

enum DECLSPEC_DENUM TLMDCallStackFrameIndexUpdate : unsigned char { iuOnClick, iuOnDblClick };

class PASCALIMPLEMENTATION TLMDCallStackView : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FAdjusting;
	Vcl::Graphics::TBitmap* FItemBuffer;
	ILMDDbgSourceNotifier* FSourceNotifier;
	TLMDDebuggerSource* FSource;
	TLMDCallStackFrameIndexUpdate FSourceIndexUpdate;
	int FPrevSelected;
	System::Uitypes::TImageIndex FItemImageIndex;
	System::Uitypes::TImageIndex FTopImageIndex;
	TLMDCallStackViewOnGetCaption FOnGetCaption;
	TLMDCallStackViewOnGetImageIndex FOnGetImageIndex;
	void __fastcall SourceStateChanged(void);
	void __fastcall AdjustColumns(int AWholeWidth);
	Vcl::Graphics::TBitmap* __fastcall GetBufferBitmap(int AWidth, int AHeight);
	void __fastcall DoDrawItem(int AIndex, Vcl::Comctrls::TCustomDrawState State, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetItemImageIndex(const System::Uitypes::TImageIndex Value);
	void __fastcall SetTopImageIndex(const System::Uitypes::TImageIndex Value);
	HIDESBASE Lmdsctscripter::TLMDStackFrame* __fastcall GetSelected(void);
	HIDESBASE void __fastcall SetSelected(Lmdsctscripter::TLMDStackFrame* const Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TListItem* Item, int Change);
	DYNAMIC void __fastcall Delete(Vcl::Comctrls::TListItem* Item);
	virtual bool __fastcall IsCustomDrawn(Vcl::Comctrls::TCustomDrawTarget Target, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDraw(const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual Lmdtypes::TLMDString __fastcall DoGetCaption(Lmdsctscripter::TLMDStackFrame* AFrame);
	virtual System::Uitypes::TImageIndex __fastcall DoGetImageIndex(Lmdsctscripter::TLMDStackFrame* AFrame);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(bool AEnabled);
	void __fastcall UpdateView(void);
	
public:
	__fastcall virtual TLMDCallStackView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCallStackView(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property ItemIndex;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property TLMDCallStackFrameIndexUpdate SourceIndexUpdate = {read=FSourceIndexUpdate, write=FSourceIndexUpdate, default=1};
	__property Lmdsctscripter::TLMDStackFrame* Selected = {read=GetSelected, write=SetSelected};
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property System::Uitypes::TImageIndex ItemImageIndex = {read=FItemImageIndex, write=SetItemImageIndex, default=-1};
	__property System::Uitypes::TImageIndex TopImageIndex = {read=FTopImageIndex, write=SetTopImageIndex, default=-1};
	__property TLMDCallStackViewOnGetCaption OnGetCaption = {read=FOnGetCaption, write=FOnGetCaption};
	__property TLMDCallStackViewOnGetImageIndex OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
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
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCallStackView(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TLMDCallStackComboOnGetCaption)(System::TObject* Sender, Lmdsctscripter::TLMDStackFrame* AFrame, Lmdtypes::TLMDString &S);

class PASCALIMPLEMENTATION TLMDCallStackComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDDebuggerSource* FSource;
	ILMDDbgSourceNotifier* FSourceNotifier;
	bool FIsEmpty;
	TLMDCallStackComboOnGetCaption FOnGetCaption;
	void __fastcall SourceStateChanged(void);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	HIDESBASE int __fastcall GetItemIndex(void);
	HIDESBASE void __fastcall SetItemIndex(const int Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall CloseUp(void);
	virtual Lmdtypes::TLMDString __fastcall DoGetCaption(Lmdsctscripter::TLMDStackFrame* AFrame);
	void __fastcall UpdateView(void);
	
public:
	__fastcall virtual TLMDCallStackComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCallStackComboBox(void);
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property TLMDCallStackComboOnGetCaption OnGetCaption = {read=FOnGetCaption, write=FOnGetCaption};
	__property Align = {default=0};
	__property AutoDropDown = {default=0};
	__property AutoCloseUp = {default=0};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemHeight;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentDoubleBuffered = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnCloseUp;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnSelect;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCallStackComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
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


typedef System::StaticArray<int, 1025> TLMDNodePath;

typedef TLMDNodePath *PLMDNodePath;

struct DECLSPEC_DRECORD TLMDNodeDescr
{
public:
	TLMDExpandedNode* Parent;
	int Index;
};


struct DECLSPEC_DRECORD TLMDNodeData
{
public:
	Lmdtypes::TLMDString Name;
	Lmdtypes::TLMDString Value;
	void *Key;
	bool ShowCheckbox;
	bool Checked;
	bool Enabled;
};


enum DECLSPEC_DENUM TLMDExpNodeProcRes : unsigned char { enrProcessChildren, cnrDeleteItem };

typedef TLMDExpNodeProcRes __fastcall (__closure *TLMDExpNodeProc)(TLMDExpandedNode* AItem, void * AUserData);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExpandedNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDExpandedNode* FParent;
	void *FKey;
	int FIndex;
	System::Classes::TList* FItems;
	TLMDVarsTreeBase* __fastcall GetTree(void);
	TLMDRootExpandedNode* __fastcall GetRoot(void);
	int __fastcall GetLevel(void);
	void __fastcall InsertItem(TLMDExpandedNode* AItem);
	void __fastcall RemoveItem(TLMDExpandedNode* AItem);
	
public:
	__fastcall TLMDExpandedNode(TLMDExpandedNode* AParent, void * AKey, int AIndex);
	__fastcall virtual ~TLMDExpandedNode(void);
	void __fastcall Clear(void);
	void __fastcall Delete(void);
	TLMDExpandedNode* __fastcall Add(void * AKey, int AIndex);
	void __fastcall ForAllItems(TLMDExpNodeProc AProc, void * AUserData);
	__property TLMDVarsTreeBase* Tree = {read=GetTree};
	__property TLMDRootExpandedNode* Root = {read=GetRoot};
	__property TLMDExpandedNode* Parent = {read=FParent};
	__property void * Key = {read=FKey};
	__property int Index = {read=FIndex, nodefault};
	__property int Level = {read=GetLevel, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRootExpandedNode : public TLMDExpandedNode
{
	typedef TLMDExpandedNode inherited;
	
private:
	TLMDVarsTreeBase* FTree;
	Lmdhashtable::TLMDHashTable* FIndex;
	void __fastcall InsertInIndex(TLMDExpandedNode* AItem);
	void __fastcall RemoveFromIndex(TLMDExpandedNode* AItem);
	
public:
	__fastcall TLMDRootExpandedNode(TLMDVarsTreeBase* ATree);
	__fastcall virtual ~TLMDRootExpandedNode(void);
	TLMDExpandedNode* __fastcall FindItem(const TLMDNodeDescr &ANode);
	void __fastcall UpdateHashIndex(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDVarsTreeBase : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TLMDVarsTreeBase__1;
	
	typedef System::DynamicArray<System::Types::TRect> _TLMDVarsTreeBase__2;
	
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDRootExpandedNode* FRoot;
	int FListSize;
	TLMDNodeDescr FCachedNode;
	int FCachedListIdx;
	Vcl::Graphics::TBitmap* FItemBuffer;
	_TLMDVarsTreeBase__1 FExpBtns;
	_TLMDVarsTreeBase__2 FCheckBtns;
	bool FAdjusting;
	Vcl::Controls::TImageList* FImageLst;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNotify(Winapi::Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	void __fastcall NotifyDesigner(void);
	TLMDExpNodeProcRes __fastcall CountVisibleChildrenProc(TLMDExpandedNode* AItem, void * AUserData);
	TLMDExpNodeProcRes __fastcall ValidateExpNodeProc(TLMDExpandedNode* AItem, void * AUserData);
	TLMDNodeDescr __fastcall NodeByListIdx(int AListIdx);
	int __fastcall GetLevel(const TLMDNodeDescr &ANode);
	int __fastcall GetChildCount(const TLMDNodeDescr &ANode)/* overload */;
	int __fastcall GetChildCount(TLMDExpandedNode* const ANode)/* overload */;
	void __fastcall GetData(const TLMDNodeDescr &ANode, /* out */ TLMDNodeData &AData);
	void __fastcall CheckboxClicked(const TLMDNodeDescr &ANode);
	bool __fastcall GetExpanded(const TLMDNodeDescr &ANode);
	void __fastcall SetExpanded(int AListIdx, bool AValue, bool AInvalidate = true);
	void __fastcall InitColumns(void);
	void __fastcall AdjustColumns(int ANameWidth, int AWholeWidth);
	Vcl::Graphics::TBitmap* __fastcall GetBufferBitmap(int AWidth, int AHeight);
	bool __fastcall IsOnExpBtn(const System::Types::TPoint &P);
	void __fastcall SetExpBtn(int AListIdx, const System::Types::TRect &ABounds);
	bool __fastcall IsOnCheckBtn(const System::Types::TPoint &P);
	void __fastcall SetCheckBtn(int AListIdx, const System::Types::TRect &ABounds);
	void __fastcall DoDrawItem(const TLMDNodeDescr &ANode, int AListIdx, Vcl::Comctrls::TCustomDrawState State, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, int AValClnOffset, /* out */ System::Types::TRect &AExpBtn, /* out */ System::Types::TRect &ACheckBtn);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DblClick(void);
	virtual bool __fastcall OwnerDataFetch(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemRequest Request);
	virtual bool __fastcall IsCustomDrawn(Vcl::Comctrls::TCustomDrawTarget Target, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDraw(const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual int __fastcall DoGetChildCount(PLMDNodePath APath, int APathSize) = 0 ;
	virtual void __fastcall DoGetNodeData(PLMDNodePath APath, int APathSize, TLMDNodeData &AData) = 0 ;
	virtual int __fastcall DoKeyIndexOf(PLMDNodePath AParentPath, int AParentPathSize, void * AKey);
	virtual void __fastcall DoCheckboxClicked(PLMDNodePath APath, int APathSize);
	virtual void __fastcall DoGetColumnNames(Lmdtypes::TLMDString &ANameCln, Lmdtypes::TLMDString &AValueCln);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(bool AEnabled);
	void __fastcall UpdateView(bool AInvalidate = true);
	int __fastcall GetSelectedPath(PLMDNodePath APathBuf, int ABufSize);
	
public:
	__fastcall virtual TLMDVarsTreeBase(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDVarsTreeBase(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDVarsTreeBase(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
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


enum DECLSPEC_DENUM TLMDVarsViewDataKind : unsigned char { dkLocalVars, dkExpression };

class PASCALIMPLEMENTATION TLMDVariablesView : public TLMDVarsTreeBase
{
	typedef TLMDVarsTreeBase inherited;
	
private:
	Lmdsctscripter::TLMDVariables* FVars;
	bool FShowRoot;
	ILMDDbgSourceNotifier* FSourceNotifier;
	TLMDDebuggerSource* FSource;
	TLMDVarsViewDataKind FKind;
	Lmdtypes::TLMDString FExpression;
	bool FAutoShowRoot;
	void __fastcall VarsChanged(void);
	bool __fastcall TryVarByPath(PLMDNodePath APath, int APathSize, /* out */ Lmdsctscripter::TLMDVariable* &AVar);
	void __fastcall SourceStateChanged(void);
	Lmdsctscripter::TLMDVariable* __fastcall GetRoot(void);
	void __fastcall SetShowRoot(const bool Value);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	bool __fastcall IsShowRootStored(void);
	void __fastcall SetAutoShowRoot(const bool Value);
	void __fastcall SetExpression(const Lmdtypes::TLMDString Value);
	void __fastcall SetKind(const TLMDVarsViewDataKind Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall DoGetChildCount(PLMDNodePath APath, int APathSize);
	virtual void __fastcall DoGetNodeData(PLMDNodePath APath, int APathSize, TLMDNodeData &AData);
	HIDESBASE void __fastcall UpdateView(void);
	
public:
	__fastcall virtual TLMDVariablesView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDVariablesView(void);
	__property Lmdsctscripter::TLMDVariables* Vars = {read=FVars};
	__property Lmdsctscripter::TLMDVariable* Root = {read=GetRoot};
	
__published:
	__property bool ShowRoot = {read=FShowRoot, write=SetShowRoot, stored=IsShowRootStored, nodefault};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property TLMDVarsViewDataKind Kind = {read=FKind, write=SetKind, default=0};
	__property Lmdtypes::TLMDString Expression = {read=FExpression, write=SetExpression};
	__property bool AutoShowRoot = {read=FAutoShowRoot, write=SetAutoShowRoot, default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowColumnHeaders = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDVariablesView(HWND ParentWindow) : TLMDVarsTreeBase(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWatchItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FExpression;
	bool FEnabled;
	bool FNeedUpdate;
	Lmdsctscripter::TLMDVariables* FVars;
	void __fastcall VarsChanged(void);
	void __fastcall InternalInvalidate(void);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetExpression(const Lmdtypes::TLMDString Value);
	Lmdsctscripter::TLMDVariable* __fastcall GetRoot(void);
	
public:
	__fastcall virtual TLMDWatchItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDWatchItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Delete(void);
	__property Lmdsctscripter::TLMDVariables* Vars = {read=FVars};
	__property Lmdsctscripter::TLMDVariable* Root = {read=GetRoot};
	
__published:
	__property Lmdtypes::TLMDString Expression = {read=FExpression, write=SetExpression};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWatchItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDWatchItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDWatchItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDWatchItem* const Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TLMDWatchItem* __fastcall Add(const Lmdtypes::TLMDString AExpression)/* overload */;
	HIDESBASE TLMDWatchItem* __fastcall Add(void)/* overload */;
	HIDESBASE TLMDWatchItem* __fastcall FindItemID(int ID);
	HIDESBASE TLMDWatchItem* __fastcall Insert(int Index);
	__property TLMDWatchItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDWatchItems(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDWatchItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWatchView : public TLMDVarsTreeBase
{
	typedef TLMDVarsTreeBase inherited;
	
private:
	TLMDWatchItems* FItems;
	ILMDDbgSourceNotifier* FSourceNotifier;
	TLMDDebuggerSource* FSource;
	void __fastcall SourceStateChanged(void);
	void __fastcall ItemsChanged(void);
	bool __fastcall TryVarByPath(PLMDNodePath APath, int APathSize, /* out */ Lmdsctscripter::TLMDVariable* &AVar);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	HIDESBASE void __fastcall SetItems(TLMDWatchItems* const Value);
	HIDESBASE TLMDWatchItem* __fastcall GetSelected(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual int __fastcall DoGetChildCount(PLMDNodePath APath, int APathSize);
	virtual void __fastcall DoGetNodeData(PLMDNodePath APath, int APathSize, TLMDNodeData &AData);
	virtual int __fastcall DoKeyIndexOf(PLMDNodePath AParentPath, int AParentPathSize, void * AKey);
	virtual void __fastcall DoCheckboxClicked(PLMDNodePath APath, int APathSize);
	virtual void __fastcall DoGetColumnNames(Lmdtypes::TLMDString &ANameCln, Lmdtypes::TLMDString &AValueCln);
	HIDESBASE void __fastcall UpdateView(void);
	
public:
	__fastcall virtual TLMDWatchView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWatchView(void);
	
__published:
	__property TLMDWatchItems* Items = {read=FItems, write=SetItems};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property TLMDWatchItem* Selected = {read=GetSelected};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowColumnHeaders = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWatchView(HWND ParentWindow) : TLMDVarsTreeBase(ParentWindow) { }
	
};


enum DECLSPEC_DENUM Lmdidedebugctrls__31 : unsigned char { lvsAsyncUpdateSent };

typedef System::Set<Lmdidedebugctrls__31, Lmdidedebugctrls__31::lvsAsyncUpdateSent, Lmdidedebugctrls__31::lvsAsyncUpdateSent> TLMDEventLogViewState;

class PASCALIMPLEMENTATION TLMDEventLogView : public Vcl::Grids::TCustomGrid
{
	typedef Vcl::Grids::TCustomGrid inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDEventLogViewState FState;
	ILMDDbgSourceNotifier* FSourceNotifier;
	TLMDDebuggerSource* FSource;
	Lmdsctscripter::TLMDDebugMsgKinds FSourceMessageKinds;
	bool FAsyncUpdate;
	int FMaxMessageCount;
	bool FShowNewMessage;
	System::Classes::TStringList* FMessages;
	int FMsgStart;
	int FMsgMaxWidth;
	int FMsgMaxWidthIndex;
	System::StaticArray<System::Uitypes::TColor, 6> FMsgColors;
	System::StaticArray<System::Uitypes::TColor, 6> FMsgBkColors;
	bool FUseMsgColors;
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall DMAsyncUpdate(Winapi::Messages::TMessage &Message);
	void __fastcall AdjustColWidth(void);
	void __fastcall AdjustRowHeight(void);
	void __fastcall NormalizeMessages(void);
	void __fastcall GetMsg(int AIndex, /* out */ Lmdtypes::TLMDString &AMsg, /* out */ Lmdsctscripter::TLMDDebugMsgKind &AKind);
	void __fastcall InitColors(void);
	void __fastcall SourceLogMsg(const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind);
	void __fastcall SetMaxMessageCount(const int Value);
	System::Uitypes::TColor __fastcall GetMsgColor(const int Index);
	void __fastcall SetMsgColor(const int Index, const System::Uitypes::TColor Value);
	bool __fastcall IsMsgColorStred(const int Index);
	System::Uitypes::TColor __fastcall GetMsgBkColor(const int Index);
	void __fastcall SetMsgBkColor(const int Index, const System::Uitypes::TColor Value);
	bool __fastcall IsMsgBkColorStred(const int Index);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	void __fastcall SetUseMsgColors(const bool Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState AState);
	void __fastcall UpdateView(bool AForceSync = false, bool ASelectLastMsg = false);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	
public:
	__fastcall virtual TLMDEventLogView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEventLogView(void);
	void __fastcall Clear(void);
	void __fastcall LogMessage(const Lmdtypes::TLMDString AMsg)/* overload */;
	void __fastcall LogMessage(const Lmdtypes::TLMDString AMsg, Lmdsctscripter::TLMDDebugMsgKind AKind)/* overload */;
	__property Col;
	__property ColWidths;
	__property GridHeight;
	__property GridWidth;
	__property LeftCol;
	__property Selection;
	__property Row;
	__property RowHeights;
	__property TabStops;
	__property TopRow;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool AsyncUpdate = {read=FAsyncUpdate, write=FAsyncUpdate, default=1};
	__property bool ShowNewMessage = {read=FShowNewMessage, write=FShowNewMessage, default=1};
	__property int MaxMessageCount = {read=FMaxMessageCount, write=SetMaxMessageCount, default=-1};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property Lmdsctscripter::TLMDDebugMsgKinds SourceMessageKinds = {read=FSourceMessageKinds, write=FSourceMessageKinds, default=63};
	__property bool UseMsgColors = {read=FUseMsgColors, write=SetUseMsgColors, default=1};
	__property System::Uitypes::TColor DebuggerOutputColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=0, nodefault};
	__property System::Uitypes::TColor DebuggerOutputBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=0, nodefault};
	__property System::Uitypes::TColor BreakpointReachedColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=1, nodefault};
	__property System::Uitypes::TColor BreakpointReachedBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=1, nodefault};
	__property System::Uitypes::TColor LogMessageColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=2, nodefault};
	__property System::Uitypes::TColor LogMessageBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=2, nodefault};
	__property System::Uitypes::TColor EvalExprColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=3, nodefault};
	__property System::Uitypes::TColor EvalExprBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=3, nodefault};
	__property System::Uitypes::TColor LogStackHeaderColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=4, nodefault};
	__property System::Uitypes::TColor LogStackHeaderBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=4, nodefault};
	__property System::Uitypes::TColor LogStackFrameColor = {read=GetMsgColor, write=SetMsgColor, stored=IsMsgColorStred, index=5, nodefault};
	__property System::Uitypes::TColor LogStackFrameBkColor = {read=GetMsgBkColor, write=SetMsgBkColor, stored=IsMsgBkColorStred, index=5, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property ColCount = {default=5};
	__property Constraints;
	__property Ctl3D;
	__property DefaultRowHeight = {default=24};
	__property DefaultDrawing = {default=1};
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property GridLineWidth = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentDoubleBuffered = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ScrollBars = {default=3};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property VisibleColCount;
	__property VisibleRowCount;
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
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDEventLogView(HWND ParentWindow) : Vcl::Grids::TCustomGrid(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TLMDBPViewOnGetImageIndex)(System::TObject* Sender, Lmdsctscripter::TLMDBreakpoint* BP, System::Uitypes::TImageIndex &AIndex);

class PASCALIMPLEMENTATION TLMDBreakpointsView : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TLMDBreakpointsView__1;
	
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	_TLMDBreakpointsView__1 FCheckBtns;
	ILMDDbgSourceNotifier* FSourceNotifier;
	TLMDDebuggerSource* FSource;
	System::Uitypes::TImageIndex FNormalImageIndex;
	System::Uitypes::TImageIndex FDisabledImageIndex;
	System::Uitypes::TImageIndex FInvalidImageIndex;
	TLMDBPViewOnGetImageIndex FOnGetImageIndex;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Message);
	void __fastcall InitColumns(void);
	void __fastcall SourceStateChanged(void);
	bool __fastcall IsOnCheckBtn(const System::Types::TPoint &P);
	void __fastcall SetCheckBtn(int AListIdx, const System::Types::TRect &ABounds);
	Lmdsctscripter::TLMDBreakpoint* __fastcall BpByItem(Vcl::Comctrls::TListItem* AItem);
	void __fastcall SetSource(TLMDDebuggerSource* const Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages(void);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetDisabledImageIndex(const System::Uitypes::TImageIndex Value);
	void __fastcall SetInvalidImageIndex(const System::Uitypes::TImageIndex Value);
	void __fastcall SetNormalImageIndex(const System::Uitypes::TImageIndex Value);
	HIDESBASE Lmdsctscripter::TLMDBreakpoint* __fastcall GetSelected(void);
	HIDESBASE void __fastcall SetSelected(Lmdsctscripter::TLMDBreakpoint* const Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateHandle(void);
	virtual bool __fastcall IsCustomDrawn(Vcl::Comctrls::TCustomDrawTarget Target, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDraw(const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall DoGetBreakpointParams(Lmdsctscripter::TLMDBreakpoint* BP, /* out */ Lmdtypes::TLMDString &ASource, /* out */ Lmdtypes::TLMDString &ALine, /* out */ Lmdtypes::TLMDString &ACondition, /* out */ Lmdtypes::TLMDString &AAction, /* out */ Lmdtypes::TLMDString &APassCount, /* out */ Lmdtypes::TLMDString &AGroup);
	virtual System::Uitypes::TImageIndex __fastcall DoGetImageIndex(Lmdsctscripter::TLMDBreakpoint* BP);
	void __fastcall UpdateView(void);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(bool ABreakpointEnabled);
	
public:
	__fastcall virtual TLMDBreakpointsView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBreakpointsView(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDebuggerSource* Source = {read=FSource, write=SetSource};
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property Lmdsctscripter::TLMDBreakpoint* Selected = {read=GetSelected, write=SetSelected};
	__property System::Uitypes::TImageIndex NormalImageIndex = {read=FNormalImageIndex, write=SetNormalImageIndex, default=-1};
	__property System::Uitypes::TImageIndex DisabledImageIndex = {read=FDisabledImageIndex, write=SetDisabledImageIndex, default=-1};
	__property System::Uitypes::TImageIndex InvalidImageIndex = {read=FInvalidImageIndex, write=SetInvalidImageIndex, default=-1};
	__property TLMDBPViewOnGetImageIndex OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowColumnHeaders = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBreakpointsView(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
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
static const System::Word DM_ASYNCUPDATE = System::Word(0x401);
}	/* namespace Lmdidedebugctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEDEBUGCTRLS)
using namespace Lmdidedebugctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidedebugctrlsHPP
