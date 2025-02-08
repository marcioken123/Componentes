// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolCtrlsEx.pas' rev: 4.00

#ifndef CoolCtrlsExHPP
#define CoolCtrlsExHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Menus.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <CoolLists.hpp>	// Pascal unit
#include <CoolTools.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolctrlsex
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCoolCustomListView;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolCustomListView : public Comctrls::TCustomListView 
{
	typedef Comctrls::TCustomListView inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Graphics::TBitmap* FCaptionWallpaper;
	Graphics::TColor FSelColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Coolctrls::TCoolOptions FOptions;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	int FidCaptionWallpaper;
	Byte FTransparencyLevel;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall WallpaperChange(System::TObject* Sender);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall CTLDrawSelWallpaper(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	
protected:
	Windows::TPoint OldViewOrigin;
	void __fastcall MyCustomDrawItem(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, Comctrls::TCustomDrawState 
		State, bool &DefaultDraw);
	virtual void __fastcall NCCtlChanged(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Change(Comctrls::TListItem* Item, int Change);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall virtual TCoolCustomListView(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolCustomListView(void);
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=4096};
	__property Graphics::TColor SelColor = {read=FSelColor, write=FSelColor, default=-2147483635};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolCustomListView(HWND ParentWindow) : Comctrls::TCustomListView(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolListView;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolListView : public TCoolCustomListView 
{
	typedef TCoolCustomListView inherited;
	
__published:
	__property BorderPen ;
	__property BordersTrColor ;
	__property CaptionColor ;
	__property CaptionTextColor ;
	__property CaptionWallpaper ;
	__property CoolImages ;
	__property EdgeBorders ;
	__property idCaptionWallpaper ;
	__property idSelWallpaper ;
	__property idWallpaper ;
	__property Options ;
	__property SelColor ;
	__property SelWallpaper ;
	__property TransparencyLevel ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property Wallpaper ;
	__property Align ;
	__property AllocBy ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property BorderWidth ;
	__property Checkboxes ;
	__property Caption ;
	__property Color ;
	__property ColumnClick ;
	__property Columns ;
	__property Constraints ;
	__property Cursor ;
	__property Font ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property FlatScrollBars ;
	__property FullDrag ;
	__property GridLines ;
	__property HideSelection ;
	__property Hint ;
	__property HotTrack ;
	__property HotTrackStyles ;
	__property IconOptions ;
	__property Items ;
	__property LargeImages ;
	__property MultiSelect ;
	__property OwnerData ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property SmallImages ;
	__property ShowColumnHeaders ;
	__property ShowHint ;
	__property SortType ;
	__property TabOrder ;
	__property ViewStyle ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnColumnClick ;
	__property OnCompare ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnCustomDrawSubItem ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataHint ;
	__property OnDataStateChange ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDrawItem ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetImageIndex ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnInsert ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnSelectItem ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
public:
	#pragma option push -w-inl
	/* TCoolCustomListView.Create */ inline __fastcall virtual TCoolListView(Classes::TComponent* AOwner
		) : TCoolCustomListView(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCoolCustomListView.Destroy */ inline __fastcall virtual ~TCoolListView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolListView(HWND ParentWindow) : TCoolCustomListView(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TIconDblClickEvent)(System::TObject* Sender, AnsiString ItemCaption
	);

class DELPHICLASS TCoolExplorerListView;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolExplorerListView : public TCoolCustomListView 
{
	typedef TCoolCustomListView inherited;
	
private:
	AnsiString FDirectory;
	AnsiString FFileMask;
	Filectrl::TFileType FFileType;
	Classes::TMemoryStream* FMemStream;
	TIconDblClickEvent FOnIconDblClick;
	void __fastcall SetDirectory(AnsiString Value);
	void __fastcall SetFileMask(AnsiString Value);
	void __fastcall SetFileType(Filectrl::TFileType Value);
	MESSAGE void __fastcall WMDropFiles(Messages::TWMDropFiles &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall Delete(Comctrls::TListItem* Item);
	DYNAMIC void __fastcall Edit(const tagLVITEMA &Item);
	
public:
	__fastcall virtual TCoolExplorerListView(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolExplorerListView(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, 
		bool &Accept);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToFile(AnsiString FileName);
	void __fastcall LoadFromfile(AnsiString FileName);
	
__published:
	__property AnsiString Directory = {read=FDirectory, write=SetDirectory};
	__property AnsiString FileMask = {read=FFileMask, write=SetFileMask};
	__property Filectrl::TFileType FileType = {read=FFileType, write=SetFileType, default=48};
	__property TIconDblClickEvent OnIconDblClick = {read=FOnIconDblClick, write=FOnIconDblClick};
	__property BorderPen ;
	__property BordersTrColor ;
	__property CaptionColor ;
	__property CaptionTextColor ;
	__property CaptionWallpaper ;
	__property CoolImages ;
	__property EdgeBorders ;
	__property idCaptionWallpaper ;
	__property idSelWallpaper ;
	__property idWallpaper ;
	__property Options ;
	__property SelColor ;
	__property SelWallpaper ;
	__property TransparencyLevel ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property Wallpaper ;
	__property Align ;
	__property AllocBy ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property BorderWidth ;
	__property Checkboxes ;
	__property Caption ;
	__property Color ;
	__property ColumnClick ;
	__property Columns ;
	__property Constraints ;
	__property Cursor ;
	__property Font ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property FlatScrollBars ;
	__property FullDrag ;
	__property GridLines ;
	__property HideSelection ;
	__property Hint ;
	__property HotTrack ;
	__property HotTrackStyles ;
	__property IconOptions ;
	__property MultiSelect ;
	__property OwnerData ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowColumnHeaders ;
	__property ShowHint ;
	__property SortType ;
	__property TabOrder ;
	__property ViewStyle ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnColumnClick ;
	__property OnCompare ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnCustomDrawSubItem ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataHint ;
	__property OnDataStateChange ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDrawItem ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetImageIndex ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnInsert ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnSelectItem ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolExplorerListView(HWND ParentWindow) : TCoolCustomListView(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolScrollBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolScrollBox : public Forms::TScrollBox 
{
	typedef Forms::TScrollBox inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Coolctrls::TCoolOptions FOptions;
	Byte FTransparencyLevel;
	Graphics::TBitmap* FWallpaper;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolScrollBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolScrollBox(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolScrollBox(HWND ParentWindow) : Forms::TScrollBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolTabSheet;
class DELPHICLASS TCoolPageControl;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPageControl : public Comctrls::TCustomTabControl 
{
	typedef Comctrls::TCustomTabControl inherited;
	
private:
	Classes::TList* FPages;
	TCoolTabSheet* FActivePage;
	TCoolTabSheet* FNewDockSheet;
	TCoolTabSheet* FUndockingPage;
	Coolctrls::TCCAboutBox* FAboutBox;
	Graphics::TBitmap* FWallpaper;
	int FidWallpaper;
	Byte FTransparencyLevel;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Coolctrls::TCoolImages* FCoolImages;
	Coolctrls::TCoolOptions FOptions;
	bool FWallpaperWholeControl;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall SetWallpaperWholeControl(bool Value);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Controls::TCMDockClient &Message);
	MESSAGE void __fastcall CMDockNotification(Controls::TCMDockNotification &Message);
	HIDESBASE MESSAGE void __fastcall CMUnDockClient(Controls::TCMUnDockClient &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual bool __fastcall CanShowTab(int TabIndex);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoAddDockClient(Controls::TControl* Client, const Windows::TRect &ARect);
	DYNAMIC void __fastcall DockOver(Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState 
		State, bool &Accept);
	DYNAMIC void __fastcall DoRemoveDockClient(Controls::TControl* Client);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual int __fastcall GetImageIndex(int TabIndex);
	TCoolTabSheet* __fastcall GetPageFromDockClient(Controls::TControl* Client);
	DYNAMIC void __fastcall GetSiteInfo(Controls::TControl* Client, Windows::TRect &InfluenceRect, const 
		Windows::TPoint &MousePos, bool &CanDock);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	virtual void __fastcall ShowControl(Controls::TControl* AControl);
	virtual void __fastcall UpdateActivePage(void);
	virtual void __fastcall DrawTab(int TabIndex, const Windows::TRect &Rect, bool Active);
	
public:
	void __fastcall ChangeActivePage(TCoolTabSheet* Page);
	void __fastcall DeleteTab(TCoolTabSheet* Page, int Index);
	int __fastcall GetActivePageIndex(void);
	Controls::TControl* __fastcall GetDockClientFromMousePos(const Windows::TPoint &MousePos);
	TCoolTabSheet* __fastcall NewPage(void);
	TCoolTabSheet* __fastcall GetPage(int Index);
	int __fastcall GetPageCount(void);
	void __fastcall InsertPage(TCoolTabSheet* Page);
	void __fastcall InsertTab(TCoolTabSheet* Page);
	void __fastcall MoveTab(int CurIndex, int NewIndex);
	void __fastcall RemovePage(TCoolTabSheet* Page);
	void __fastcall SetActivePage(TCoolTabSheet* Page);
	void __fastcall SetActivePageIndex(const int Value);
	void __fastcall UpdateTab(TCoolTabSheet* Page);
	void __fastcall UpdateTabHighlights(void);
	__fastcall virtual TCoolPageControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolPageControl(void);
	TCoolTabSheet* __fastcall FindNextPage(TCoolTabSheet* CurPage, bool GoForward, bool CheckTabVisible
		);
	void __fastcall SelectNextPage(bool GoForward);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TCoolTabSheet* Pages[int Index] = {read=GetPage};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property bool WallpaperWholeControl = {read=FWallpaperWholeControl, write=SetWallpaperWholeControl
		, default=1};
	__property TCoolTabSheet* ActivePage = {read=FActivePage, write=SetActivePage};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property DockSite ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HotTrack ;
	__property Images ;
	__property MultiLine ;
	__property OwnerDraw ;
	__property ParentBiDiMode ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property RaggedRight ;
	__property ScrollOpposite ;
	__property ShowHint ;
	__property Style ;
	__property TabHeight ;
	__property TabOrder ;
	__property TabPosition ;
	__property TabStop ;
	__property TabWidth ;
	__property Visible ;
	__property OnChange ;
	__property OnChanging ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawTab ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetImageIndex ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolPageControl(HWND ParentWindow) : Comctrls::TCustomTabControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolTabSheet : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
private:
	int FImageIndex;
	TCoolPageControl* FPageControl;
	bool FTabVisible;
	bool FTabShowing;
	bool FHighlighted;
	Classes::TNotifyEvent FOnHide;
	Classes::TNotifyEvent FOnShow;
	Coolctrls::TCCAboutBox* FAboutBox;
	Graphics::TBitmap* FWallpaper;
	int FidWallpaper;
	Byte FTransparencyLevel;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Coolctrls::TCoolImages* FCoolImages;
	Coolctrls::TCoolOptions FOptions;
	bool FParentWallpaper;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall SetParentWallpaper(bool Value);
	int __fastcall GetPageIndex(void);
	int __fastcall GetTabIndex(void);
	void __fastcall SetHighlighted(bool Value);
	void __fastcall SetImageIndex(int Value);
	void __fastcall SeTCoolPageControl(TCoolPageControl* APageControl);
	void __fastcall SetPageIndex(int Value);
	void __fastcall SetTabShowing(bool Value);
	void __fastcall SetTabVisible(bool Value);
	void __fastcall UpdateTabShowing(void);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoShow(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	
public:
	__fastcall virtual TCoolTabSheet(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolTabSheet(void);
	__property TCoolPageControl* PageControl = {read=FPageControl, write=SeTCoolPageControl};
	__property int TabIndex = {read=GetTabIndex, nodefault};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property bool ParentWallpaper = {read=FParentWallpaper, write=SetParentWallpaper, default=1};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property BorderWidth ;
	__property Caption ;
	__property Color ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property Height  = {stored=false};
	__property bool Highlighted = {read=FHighlighted, write=SetHighlighted, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=0};
	__property Left  = {stored=false};
	__property Constraints ;
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property Top  = {stored=false};
	__property Visible  = {stored=false, default=1};
	__property Width  = {stored=false};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolTabSheet(HWND ParentWindow) : Controls::TWinControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolThermomitor;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolThermomitor : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	int FImageWidth;
	int FImageHeight;
	int FMin;
	int FMax;
	int FPositionPercent;
	int FPosition;
	AnsiString FLabelTitle;
	AnsiString FLabelCurrent;
	AnsiString FLabelGoal;
	Graphics::TColor FColorTitle;
	Graphics::TColor FColorCurrent;
	Graphics::TColor FColorGoal;
	Graphics::TFont* FFontTitle;
	Graphics::TFont* FFontCurrent;
	Graphics::TFont* FFontGoal;
	bool FTransparent;
	void __fastcall SetMax(int Value);
	void __fastcall SetMin(int Value);
	void __fastcall SetPosition(int Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetLabelTitle(AnsiString Value);
	void __fastcall SetLabelGoal(AnsiString Value);
	void __fastcall SetLabelCurrent(AnsiString Value);
	void __fastcall SetColorTitle(Graphics::TColor Value);
	void __fastcall SetColorGoal(Graphics::TColor Value);
	void __fastcall SetColorCurrent(Graphics::TColor Value);
	void __fastcall SetFontTitle(Graphics::TFont* Value);
	void __fastcall SetFontGoal(Graphics::TFont* Value);
	void __fastcall SetFontCurrent(Graphics::TFont* Value);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	
protected:
	int ltHeight;
	int ltWidth;
	int lcHeight;
	int lcWidth;
	int lgHeight;
	int lgWidth;
	virtual int __fastcall CalculatePositionPercent(void);
	void __fastcall PaintCoolThermomitor(Graphics::TCanvas* ACanvas, const Windows::TRect &R);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TCoolThermomitor(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolThermomitor(void);
	void __fastcall PaintTo(Graphics::TCanvas* ACanvas, int X, int Y)/* overload */;
	void __fastcall PaintTo(HDC DC, int X, int Y)/* overload */;
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TColor ColorTitle = {read=FColorTitle, write=SetColorTitle, default=16777215};
		
	__property Graphics::TColor ColorCurrent = {read=FColorCurrent, write=SetColorCurrent, default=16777215
		};
	__property Graphics::TColor ColorGoal = {read=FColorGoal, write=SetColorGoal, default=16777215};
	__property Graphics::TFont* FontTitle = {read=FFontTitle, write=SetFontTitle};
	__property Graphics::TFont* FontCurrent = {read=FFontCurrent, write=SetFontCurrent};
	__property Graphics::TFont* FontGoal = {read=FFontGoal, write=SetFontGoal};
	__property AnsiString LabelTitle = {read=FLabelTitle, write=SetLabelTitle};
	__property AnsiString LabelCurrent = {read=FLabelCurrent, write=SetLabelCurrent};
	__property AnsiString LabelGoal = {read=FLabelGoal, write=SetLabelGoal};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property Align ;
	__property Anchors ;
	__property Color ;
	__property Font ;
};

#pragma pack(pop)

#pragma option push -b-
enum TMouseStates { msMouseInside, msMouseDown };
#pragma option pop

typedef Set<TMouseStates, msMouseInside, msMouseDown>  TMouseState;

class DELPHICLASS TCustomBitmapButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCustomBitmapButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Coollists::TColorList* FColors;
	TMouseState FMouseState;
	bool FShadowEffect;
	bool FPositionEffect;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetColors(Coollists::TColorList* Value);
	HRGN __fastcall GetColorsRegion(Graphics::TBitmap* ABitmap);
	void __fastcall SetColorsRegion(Graphics::TBitmap* ABitmap);
	void __fastcall DeleteRegion(void);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	
protected:
	HRGN Rgn;
	virtual void __fastcall ColorListChanged(System::TObject* Sender) = 0 ;
	virtual void __fastcall FadeOut(Graphics::TBitmap* ABitmap);
	virtual void __fastcall FadeIn(Graphics::TBitmap* ABitmap);
	virtual void __fastcall PositionIn(void);
	virtual void __fastcall PositionOut(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	
public:
	__property Coollists::TColorList* Colors = {read=FColors, write=SetColors};
	__property bool PositionEffect = {read=FPositionEffect, write=FPositionEffect, default=1};
	__property bool ShadowEffect = {read=FShadowEffect, write=FShadowEffect, default=1};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property Classes::TNotifyEvent OnMoseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__fastcall virtual TCustomBitmapButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomBitmapButton(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCustomBitmapButton(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolBitmapButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolBitmapButton : public TCustomBitmapButton 
{
	typedef TCustomBitmapButton inherited;
	
private:
	Graphics::TBitmap* FBitmap;
	void __fastcall SetBitmap(Graphics::TBitmap* Value);
	void __fastcall BitmapChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	virtual void __fastcall ColorListChanged(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TCoolBitmapButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolBitmapButton(void);
	
__published:
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property AutoSize ;
	__property Caption ;
	__property Constraints ;
	__property Colors ;
	__property Cursor ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HelpContext ;
	__property Hint ;
	__property ParentShowHint ;
	__property PositionEffect ;
	__property ShadowEffect ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnClick ;
	__property OnDragOver ;
	__property OnDragDrop ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnMoseEnter ;
	__property OnMouseLeave ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolBitmapButton(HWND ParentWindow) : TCustomBitmapButton(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolManyBitmapsButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolManyBitmapsButton : public TCustomBitmapButton 
{
	typedef TCustomBitmapButton inherited;
	
private:
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	void __fastcall SetImages(Imglist::TCustomImageList* Value);
	void __fastcall ImagesChange(System::TObject* Sender);
	void __fastcall CurrentImageChanged(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ColorListChanged(System::TObject* Sender);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TCoolManyBitmapsButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolManyBitmapsButton(void);
	
__published:
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property AutoSize ;
	__property Caption ;
	__property Constraints ;
	__property Colors ;
	__property Cursor ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HelpContext ;
	__property Hint ;
	__property ParentShowHint ;
	__property PositionEffect ;
	__property ShowHint ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnClick ;
	__property OnDragOver ;
	__property OnDragDrop ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnMoseEnter ;
	__property OnMouseLeave ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolManyBitmapsButton(HWND ParentWindow) : TCustomBitmapButton(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coolctrlsex */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolctrlsex;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolCtrlsEx
