// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSpltA.pas' rev: 31.00 (Windows)

#ifndef LmdspltaHPP
#define LmdspltaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Consts.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDCustomControl.hpp>
#include <LMDObject.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsplta
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSplitPane;
class DELPHICLASS TLMDPaneInfo;
class DELPHICLASS TLMDCustomSplitter;
class DELPHICLASS TLMDMainSplitter;
class DELPHICLASS TLMDCustomSplitControl;
class DELPHICLASS TLMD2PaneSplitCtrl;
class DELPHICLASS TLMD4PaneSplitCtrl;
class DELPHICLASS TLMD3PaneSplitCtrl;
class DELPHICLASS TLMD4Pane3SplitCtrl;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMDSplitWidth;

enum DECLSPEC_DENUM TLMDSplitDirection : unsigned char { sdHorizontal, sdVertical };

enum DECLSPEC_DENUM TLMDSplitterPlace : unsigned char { ossEven, ossOdd };

class PASCALIMPLEMENTATION TLMDSplitPane : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TLMDSplitPane(System::Classes::TComponent* AOwner);
	
__published:
	__property BorderStyle = {stored=false, default=1};
	__property Height = {stored=false};
	__property Left = {stored=false};
	__property ParentColor = {stored=false, default=1};
	__property TabOrder = {stored=false, default=-1};
	__property Top = {stored=false};
	__property Width = {stored=false};
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TLMDSplitPane(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSplitPane(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDPaneInfo : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	bool FAutoScroll;
	System::Uitypes::TColor FColor;
	int FIndex;
	System::Types::TRect Bounds;
	void __fastcall SetAutoScroll(bool aValue);
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	
public:
	__fastcall TLMDPaneInfo(TLMDCustomSplitControl* aOwner, int index, System::Classes::TNotifyEvent foc);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int Index = {read=FIndex, write=FIndex, nodefault};
	
__published:
	__property bool AutoScroll = {read=FAutoScroll, write=SetAutoScroll, default=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
protected:
	/* TLMDObject.Create */ inline __fastcall virtual TLMDPaneInfo(System::Classes::TPersistent* Owner) : Lmdobject::TLMDObject(Owner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDPaneInfo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomSplitter : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FColor;
	TLMDSplitDirection FDirection;
	int FMin;
	int FMax;
	int FPosition;
	TLMDSplitWidth FWidth;
	System::Types::TRect Bounds;
	System::Types::TRect Within;
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	void __fastcall SetDirection(TLMDSplitDirection aValue);
	void __fastcall SetIntegers(int index, int aValue);
	void __fastcall SetWidth(TLMDSplitWidth aValue);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	bool NoUpdate;
	__fastcall virtual TLMDCustomSplitter(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TLMDSplitDirection Direction = {read=FDirection, write=SetDirection, default=1};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property int Min = {read=FMin, write=SetIntegers, index=0, default=0};
	__property int Max = {read=FMax, write=SetIntegers, index=1, default=0};
	__property int Position = {read=FPosition, write=SetIntegers, index=2, default=50};
	__property TLMDSplitWidth Width = {read=FWidth, write=SetWidth, default=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCustomSplitter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDMainSplitter : public TLMDCustomSplitter
{
	typedef TLMDCustomSplitter inherited;
	
__published:
	__property Direction = {default=1};
public:
	/* TLMDCustomSplitter.Create */ inline __fastcall virtual TLMDMainSplitter(System::Classes::TPersistent* Owner) : TLMDCustomSplitter(Owner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDMainSplitter(void) { }
	
};


typedef void __fastcall (__closure *TLMDSplitChangeEvent)(System::TObject* Sender, TLMDCustomSplitter* Splitter);

class PASCALIMPLEMENTATION TLMDCustomSplitControl : public Lmdcustomcontrol::TLMDCustomControl
{
	typedef Lmdcustomcontrol::TLMDCustomControl inherited;
	
private:
	Lmdgraph::TLMDBorderStyle FBorderStyle;
	System::Byte FBorderWidth;
	TLMDMainSplitter* FSplitterMain;
	TLMDCustomSplitter* FSplitter2;
	TLMDCustomSplitter* FSplitter3;
	System::Classes::TList* FPaneList;
	System::Classes::TList* FPaneInfoList;
	TLMDSplitterPlace FSplitterPlace;
	TLMDSplitChangeEvent FOnSplitChange;
	System::Classes::TNotifyEvent FOnResize;
	System::Classes::TNotifyEvent FOnSplitChanging;
	int ActiveSplitter;
	System::Types::TPoint PtMouseDown;
	System::Uitypes::TCursor OldCursor;
	int SplitterCount;
	int WindowCount;
	void __fastcall SetBorderStyle(Lmdgraph::TLMDBorderStyle aValue);
	void __fastcall SetSplitterPlace(TLMDSplitterPlace aValue);
	void __fastcall SetMainSplitter(TLMDMainSplitter* aValue);
	void __fastcall ClearPanes(void);
	void __fastcall UpdatePane(int index);
	void __fastcall UpdatePaneInfos(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMParentNotify(Winapi::Messages::TWMParentNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	
protected:
	void __fastcall SetPaneInfo(int index, TLMDPaneInfo* aValue);
	void __fastcall SetSplitter(int index, TLMDCustomSplitter* aValue);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	TLMDSplitPane* __fastcall GetPane(int index);
	TLMDPaneInfo* __fastcall GetPaneInfo(int index);
	virtual void __fastcall AdjustSplitters(void);
	virtual void __fastcall AdjustWindowBounds(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall DrawWindowEdge(int index);
	void __fastcall DrawSplitterInverse(int index);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdatePanes(void);
	int __fastcall MouseOverSlider(int x, int y);
	TLMDCustomSplitter* __fastcall GetSplitter(int index);
	__property TLMDSplitterPlace SplitterPlace = {read=FSplitterPlace, write=SetSplitterPlace, nodefault};
	
public:
	__fastcall virtual TLMDCustomSplitControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSplitControl(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	void __fastcall SwapPanes(int first, int second);
	void __fastcall RotatePanes(void);
	__property TLMDSplitPane* Pane[int index] = {read=GetPane};
	__property TLMDPaneInfo* PaneInfo[int index] = {read=GetPaneInfo};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Lmdgraph::TLMDBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=5};
	__property Cursor = {stored=false, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property TLMDPaneInfo* Pane1 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=0};
	__property TLMDPaneInfo* Pane2 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TLMDMainSplitter* SplitterMain = {read=FSplitterMain, write=SetMainSplitter};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnResize = {read=FOnResize, write=FOnResize};
	__property TLMDSplitChangeEvent OnSplitChange = {read=FOnSplitChange, write=FOnSplitChange};
	__property System::Classes::TNotifyEvent OnSplitChanging = {read=FOnSplitChanging, write=FOnSplitChanging};
	__property Anchors = {default=3};
	__property Constraints;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomSplitControl(HWND ParentWindow) : Lmdcustomcontrol::TLMDCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMD2PaneSplitCtrl : public TLMDCustomSplitControl
{
	typedef TLMDCustomSplitControl inherited;
	
public:
	/* TLMDCustomSplitControl.Create */ inline __fastcall virtual TLMD2PaneSplitCtrl(System::Classes::TComponent* AOwner) : TLMDCustomSplitControl(AOwner) { }
	/* TLMDCustomSplitControl.Destroy */ inline __fastcall virtual ~TLMD2PaneSplitCtrl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMD2PaneSplitCtrl(HWND ParentWindow) : TLMDCustomSplitControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMD4PaneSplitCtrl : public TLMDCustomSplitControl
{
	typedef TLMDCustomSplitControl inherited;
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall AdjustWindowBounds(void);
	virtual void __fastcall AdjustSplitters(void);
	
public:
	__fastcall virtual TLMD4PaneSplitCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMD4PaneSplitCtrl(void);
	
__published:
	__property TLMDPaneInfo* Pane3 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=2};
	__property TLMDPaneInfo* Pane4 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=3};
	__property TLMDCustomSplitter* Splitter2 = {read=GetSplitter, write=SetSplitter, index=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMD4PaneSplitCtrl(HWND ParentWindow) : TLMDCustomSplitControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMD3PaneSplitCtrl : public TLMDCustomSplitControl
{
	typedef TLMDCustomSplitControl inherited;
	
protected:
	virtual void __fastcall AdjustWindowBounds(void);
	virtual void __fastcall AdjustSplitters(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMD3PaneSplitCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMD3PaneSplitCtrl(void);
	
__published:
	__property TLMDPaneInfo* Pane3 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=2};
	__property TLMDCustomSplitter* Splitter2 = {read=GetSplitter, write=SetSplitter, index=1};
	__property SplitterPlace;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMD3PaneSplitCtrl(HWND ParentWindow) : TLMDCustomSplitControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMD4Pane3SplitCtrl : public TLMDCustomSplitControl
{
	typedef TLMDCustomSplitControl inherited;
	
protected:
	virtual void __fastcall AdjustWindowBounds(void);
	virtual void __fastcall AdjustSplitters(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMD4Pane3SplitCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMD4Pane3SplitCtrl(void);
	
__published:
	__property TLMDPaneInfo* Pane3 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=2};
	__property TLMDPaneInfo* Pane4 = {read=GetPaneInfo, write=SetPaneInfo, stored=false, index=3};
	__property TLMDCustomSplitter* Splitter2 = {read=GetSplitter, write=SetSplitter, index=1};
	__property TLMDCustomSplitter* Splitter3 = {read=GetSplitter, write=SetSplitter, index=2};
	__property SplitterPlace;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMD4Pane3SplitCtrl(HWND ParentWindow) : TLMDCustomSplitControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsplta */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSPLTA)
using namespace Lmdsplta;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdspltaHPP
