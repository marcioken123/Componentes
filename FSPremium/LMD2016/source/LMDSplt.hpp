// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSplt.pas' rev: 31.00 (Windows)

#ifndef LmdspltHPP
#define LmdspltHPP

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
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <LMDUtils.hpp>
#include <LMDBase.hpp>
#include <LMDScrollBox.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsplt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSplitterBarItem;
class DELPHICLASS TLMDSplitterBarItems;
class DELPHICLASS TLMDSplitterPane;
class DELPHICLASS TLMDSplitterPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDResizeButtonStyle : unsigned char { rbsNoButton, rbsGripOnly, rbsGripWithArrows, rbsFlatGripOnly, rbsFlatGripWithArrows };

enum DECLSPEC_DENUM TLMDSplitterOrientation : unsigned char { spHorzDown, spHorzUp, spVertRight, spVertLeft, spCross };

typedef void __fastcall (__closure *TLMDSplitterPanelEvent)(System::TObject* Sender, int BarIndex);

enum DECLSPEC_DENUM TLMDSplitterIniSaveOption : unsigned char { ssOrderVisible, ssPosition, soColor, soFont };

typedef System::Set<TLMDSplitterIniSaveOption, TLMDSplitterIniSaveOption::ssOrderVisible, TLMDSplitterIniSaveOption::soFont> TLMDSplitterIniSaveOptions;

enum DECLSPEC_DENUM TLMDSplitterJump : unsigned char { sjUpLeft, sjDnRight };

class PASCALIMPLEMENTATION TLMDSplitterBarItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdgraph::TLMDBorderStyle FBorderStyle;
	int FMaxAbs;
	bool FMoved;
	bool FClosed;
	TLMDResizeButtonStyle FResizeBtn;
	bool FInvResizeBtn;
	bool FTransparent;
	bool FHorizontal;
	bool FLocked;
	bool FMoving;
	int FPosition;
	int FGhostPosition;
	Lmdtypes::TLMDPercent FPosPercent;
	TLMDSplitterJump FSplitterJmp;
	int FOldPos;
	int FMin;
	int FMax;
	System::Uitypes::TColor FBtnColor;
	System::Uitypes::TColor FColor;
	int FWidth;
	TLMDSplitterPanel* FSplitControl;
	bool FMouseBtn;
	bool FSelect;
	System::Classes::TNotifyEvent FOnChange;
	System::Types::TRect FBtnRect;
	void __fastcall SetBorderStyle(Lmdgraph::TLMDBorderStyle aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetLocked(bool aValue);
	void __fastcall SetPercent(Lmdtypes::TLMDPercent aValue);
	void __fastcall SetColor(int index, System::Uitypes::TColor aValue);
	void __fastcall SetJumpDir(TLMDSplitterJump aValue);
	void __fastcall SetResizeBtn(TLMDResizeButtonStyle aValue);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall ReadBoolean(System::Classes::TReader* Reader);
	bool __fastcall GetResizeBtn(void);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDSplitterBarItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSplitterBarItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall TrimValues(bool aValue);
	void __fastcall Minimize(void);
	void __fastcall Restore(void);
	__property bool Selected = {read=FSelect, write=FSelect, nodefault};
	__property bool Horizontal = {read=FHorizontal, nodefault};
	__property bool MouseAboveBtn = {read=FMouseBtn, write=SetBoolean, index=5, default=0};
	__property bool ResizeButton = {read=GetResizeBtn, nodefault};
	
__published:
	__property int OldPosition = {read=FOldPos, write=FOldPos, nodefault};
	__property Lmdgraph::TLMDBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property int Position = {read=FPosition, write=SetInteger, index=0, nodefault};
	__property Lmdtypes::TLMDPercent PosPercent = {read=FPosPercent, write=SetPercent, default=50};
	__property int Min = {read=FMin, write=SetInteger, index=1, default=0};
	__property int Max = {read=FMax, write=SetInteger, index=2, default=0};
	__property bool Locked = {read=FLocked, write=SetLocked, default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, index=0, default=-16777201};
	__property TLMDResizeButtonStyle ResizeButtonStyle = {read=FResizeBtn, write=SetResizeBtn, default=0};
	__property TLMDSplitterJump ResizeDirection = {read=FSplitterJmp, write=SetJumpDir, default=0};
	__property System::Uitypes::TColor ResizeColor = {read=FBtnColor, write=SetColor, index=1, default=-16777201};
	__property bool Transparent = {read=FTransparent, write=SetBoolean, index=1, default=0};
	__property int Width = {read=FWidth, write=SetInteger, index=3, default=3};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSplitterBarItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDSplitterBarItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDSplitterPanel* FSplitControl;
	HIDESBASE TLMDSplitterBarItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSplitterBarItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDSplitterBarItems(TLMDSplitterPanel* SplitControl);
	HIDESBASE TLMDSplitterBarItem* __fastcall Add(void);
	__property TLMDSplitterBarItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDSplitterBarItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSplitterPane : public Lmdscrollbox::TLMDScrollBox
{
	typedef Lmdscrollbox::TLMDScrollBox inherited;
	
private:
	int FPaneIndex;
	TLMDSplitterPanel* FParentControl;
	bool FParentCtlXP;
	void __fastcall SetParentControl(TLMDSplitterPanel* aValue);
	void __fastcall SetParentCtlXP(bool aValue);
	Vcl::Controls::TAlign __fastcall GetAlign(void);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDParentCtlXPChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TLMDSplitterPane(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSplitterPane(void);
	__property TLMDSplitterPanel* ParentControl = {read=FParentControl, write=SetParentControl};
	__property int PaneIndex = {read=FPaneIndex, write=FPaneIndex, nodefault};
	__property CtlXP = {default=0};
	
__published:
	__property bool ParentCtlXP = {read=FParentCtlXP, write=SetParentCtlXP, default=1};
	__property Vcl::Controls::TAlign Align = {read=GetAlign, nodefault};
	__property Height = {stored=false};
	__property Left = {stored=false};
	__property ParentColor = {default=1};
	__property TabOrder = {stored=false, default=-1};
	__property Top = {stored=false};
	__property Width = {stored=false};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSplitterPane(HWND ParentWindow) : Lmdscrollbox::TLMDScrollBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDSplitterPanel : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	int FSplitterCount;
	System::Classes::TList* FPanes;
	TLMDSplitterBarItems* FBars;
	int FBevelExtend;
	TLMDSplitterOrientation FOrientation;
	System::Types::TPoint FHitTest;
	System::Types::TPoint FActPt;
	System::Types::TPoint FMouseDownPt;
	bool FInstantUpdate;
	bool FInternal;
	bool FMoving;
	int FMovingBar;
	bool FMovable;
	TLMDSplitterPanelEvent FOnSplitChange;
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	Lmdinictrl::TLMDIniUse FIniUse;
	System::UnicodeString FSection;
	System::UnicodeString FKey;
	TLMDSplitterIniSaveOptions FIniOptions;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniReadData;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniWriteData;
	bool FAutoResize;
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	void __fastcall SetAutoResize(const bool Value);
	bool __fastcall SaveKey(void);
	bool __fastcall SaveSection(void);
	bool __fastcall HasBars(void);
	void __fastcall SetBars(TLMDSplitterBarItems* aValue);
	void __fastcall SetOrientation(TLMDSplitterOrientation aValue);
	System::Types::TRect __fastcall GetBarRect(int index);
	TLMDSplitterPane* __fastcall GetPane(int index);
	int __fastcall GetPaneCount(void);
	int __fastcall GetVisibleBarCount(void);
	int __fastcall GetVisiblePaneCount(void);
	TLMDSplitterPane* __fastcall GetVisiblePanes(int index);
	void __fastcall ChangeSplitterBounds(bool aResize = true);
	void __fastcall ChangeSplitterOrientation(void);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* aControl, System::Types::TRect &aRect);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoReadData(void);
	DYNAMIC void __fastcall DoWriteData(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	void __fastcall PaintSplitter(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateBar(int Index);
	void __fastcall UpdateBars(void);
	void __fastcall ValidatePoint(System::Types::TPoint &aPt, const System::Types::TPoint &OldPt);
	virtual void __fastcall DoThemeChanged(void);
	
public:
	__fastcall virtual TLMDSplitterPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSplitterPanel(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	virtual void __fastcall EndUpdate(bool aValue);
	int __fastcall AddPane(TLMDSplitterPane* aPane);
	void __fastcall ClearPanes(void);
	void __fastcall ExChangePanes(int first, int second);
	void __fastcall MovePane(int oldindex, int newindex);
	void __fastcall RemovePane(TLMDSplitterPane* aPane);
	void __fastcall RotatePanes(void);
	void __fastcall WriteData(void);
	void __fastcall ReadData(void);
	__property bool Movable = {read=FMovable, write=FMovable, nodefault};
	__property System::Types::TRect BarRect[int index] = {read=GetBarRect};
	__property TLMDSplitterPane* Panes[int index] = {read=GetPane};
	__property int PaneCount = {read=GetPaneCount, nodefault};
	__property int VisibleBarCount = {read=GetVisibleBarCount, nodefault};
	__property int VisiblePaneCount = {read=GetVisiblePaneCount, nodefault};
	__property TLMDSplitterPane* VisiblePanes[int index] = {read=GetVisiblePanes};
	__property CtlXP = {default=0};
	
__published:
	__property About = {default=0};
	__property BackFX;
	__property bool InstantUpdate = {read=FInstantUpdate, write=FInstantUpdate, default=0};
	__property Bevel;
	__property TLMDSplitterBarItems* Bars = {read=FBars, write=SetBars, stored=HasBars};
	__property TLMDSplitterOrientation Orientation = {read=FOrientation, write=SetOrientation, default=2};
	__property Transparent = {default=0};
	__property bool AutoResizePanes = {read=FAutoResize, write=SetAutoResize, default=1};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property TLMDSplitterIniSaveOptions IniSaveOptions = {read=FIniOptions, write=FIniOptions, default=3};
	__property System::UnicodeString Section = {read=FSection, write=FSection, stored=SaveSection};
	__property System::UnicodeString IniKey = {read=FKey, write=FKey, stored=SaveKey};
	__property Align = {default=0};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TLMDSplitterPanelEvent OnSplitChange = {read=FOnSplitChange, write=FOnSplitChange};
	__property OnResize;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniReadData = {read=FOnIniReadData, write=FOnIniReadData};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniWriteData = {read=FOnIniWriteData, write=FOnIniWriteData};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSplitterPanel(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Byte LMDMAXSPLITPANE;
extern DELPHI_PACKAGE System::UnicodeString IDS_SPLITTERSAVE;
}	/* namespace Lmdsplt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSPLT)
using namespace Lmdsplt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdspltHPP
