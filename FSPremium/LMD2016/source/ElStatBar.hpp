// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElStatBar.pas' rev: 31.00 (Windows)

#ifndef ElstatbarHPP
#define ElstatbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElImgFrm.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDObjectList.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUnicode.hpp>
#include <ElXPThemedControl.hpp>
#include <ElIni.hpp>
#include <ElVCLUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elstatbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElStatusPanel;
class DELPHICLASS TElStatusPanels;
class DELPHICLASS TElStatusBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElStatusPanelBevel : unsigned char { epbLowered, epbNone, epbRaised };

enum DECLSPEC_DENUM TElStatusPanelStyle : unsigned char { epsText, epsControl, epsOwnerDraw };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStatusPanel : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Lmdtypes::TLMDString FHint;
	System::Classes::TAlignment FAlignment;
	TElStatusPanelBevel FBevel;
	TElStatusPanelStyle FStyle;
	Lmdtypes::TLMDString FText;
	int FWidth;
	Vcl::Controls::TControl* FControl;
	Vcl::Controls::TWinControl* FOldParent;
	System::Types::TRect FOldBounds;
	bool FCtlVisible;
	bool FOldVisible;
	bool FVisible;
	TElStatusBar* FOwner;
	int FSavedWidth;
	bool FResizable;
	bool FAutoSize;
	bool FIsHTML;
	void __fastcall SetImageIndex(int newValue);
	void __fastcall SetAutoSize(bool newValue);
	void __fastcall SetVisible(bool newValue);
	void __fastcall SetAlignment(System::Classes::TAlignment newValue);
	void __fastcall SetBevel(TElStatusPanelBevel newValue);
	void __fastcall SetStyle(TElStatusPanelStyle newValue);
	void __fastcall SetText(Lmdtypes::TLMDString newValue);
	void __fastcall SetWidth(int newValue);
	void __fastcall SetControl(Vcl::Controls::TControl* newValue);
	int __fastcall GetLeft(void);
	int __fastcall GetRight(void);
	System::Types::TRect __fastcall GetPanelRect(void);
	void __fastcall SetIsHTML(bool Value);
	
protected:
	void __fastcall SaveWidth(void);
	void __fastcall RestoreWidth(void);
	virtual void __fastcall UpdateControl(void);
	int __fastcall CurWidth(void);
	int __fastcall CalcAutoSize(void);
	
public:
	__fastcall virtual TElStatusPanel(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElStatusPanel(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall GetRealWidth(void);
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, nodefault};
	__property int Left = {read=GetLeft, nodefault};
	__property int Right = {read=GetRight, nodefault};
	__property System::Types::TRect PanelRect = {read=GetPanelRect};
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property bool Resizable = {read=FResizable, write=FResizable, default=1};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TElStatusPanelBevel Bevel = {read=FBevel, write=SetBevel, default=0};
	__property TElStatusPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Lmdtypes::TLMDString Text = {read=FText, write=SetText};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=FHint};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElPanelEvent)(System::TObject* Sender, TElStatusPanel* Panel);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStatusPanels : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElStatusPanel* operator[](int Index) { return this->Items[Index]; }
	
private:
	TElStatusBar* FStatusBar;
	TElStatusPanel* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElStatusPanel* newValue);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TElStatusPanels(TElStatusBar* StatusBar);
	HIDESBASE TElStatusPanel* __fastcall Add(void);
	TElStatusPanel* __fastcall LastVisiblePanel(void);
	__property TElStatusPanel* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElStatusPanels(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElStatusBar : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	Vcl::Imglist::TChangeLink* FHChLink;
	TElStatusPanelBevel FBevel;
	Elini::TElIniFile* FStorage;
	System::UnicodeString FStoragePath;
	bool FResizablePanels;
	bool FPressed;
	TElStatusPanel* FHintPanel;
	TElStatusPanel* FPressedPanel;
	TElStatusPanel* FResizePanel;
	Lmdtypes::TLMDString FSimpleText;
	bool FSimplePanel;
	bool FSizeGrip;
	TElPanelEvent FOnPanelResize;
	TElPanelEvent FOnPanelDraw;
	TElPanelEvent FOnPanelClick;
	TElPanelEvent FOnPanelDblClick;
	TElStatusPanels* FPanels;
	System::Uitypes::TCursor FOldCursor;
	int FDelta;
	int FLine;
	bool FLineVis;
	bool FIgnoreSize;
	bool FSimpleTextIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	Lmdtypes::TLMDString FHint;
	void __fastcall SetPanels(TElStatusPanels* Value);
	void __fastcall SetSimpleText(Lmdtypes::TLMDString newValue);
	void __fastcall SetSimplePanel(bool newValue);
	void __fastcall SetSizeGrip(bool newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Msg);
	void __fastcall IntHintShow(Vcl::Controls::THintInfo &HintInfo);
	void __fastcall DrawDragLine(bool Restore);
	void __fastcall SetBevel(TElStatusPanelBevel newValue);
	void __fastcall SetSimpleTextIsHTML(bool Value);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	
protected:
	virtual void __fastcall TriggerPanelResizeEvent(TElStatusPanel* Panel);
	virtual void __fastcall TriggerPanelDrawEvent(TElStatusPanel* Panel);
	virtual void __fastcall TriggerPanelDblClickEvent(TElStatusPanel* Panel);
	virtual void __fastcall TriggerPanelClickEvent(TElStatusPanel* Panel);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawPanel(TElStatusPanel* Panel);
	virtual void __fastcall UpdatePanels(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall IntLButtonDown(int X, int Y);
	void __fastcall IntLButtonUp(int X, int Y);
	void __fastcall IntMouseMove(int X, int Y);
	void __fastcall InitDragLine(void);
	void __fastcall DeinitDragLine(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ImagesChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TElStatusBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElStatusBar(void);
	virtual TElStatusPanel* __fastcall PanelAtPoint(const System::Types::TPoint &Pos);
	__property Canvas;
	void __fastcall Save(void);
	void __fastcall Restore(void);
	
__published:
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImageList, write=SetImageList};
	__property TElStatusPanels* Panels = {read=FPanels, write=SetPanels};
	__property Lmdtypes::TLMDString SimpleText = {read=FSimpleText, write=SetSimpleText};
	__property bool SimplePanel = {read=FSimplePanel, write=SetSimplePanel, default=1};
	__property bool SimpleTextIsHTML = {read=FSimpleTextIsHTML, write=SetSimpleTextIsHTML, default=0};
	__property bool SizeGrip = {read=FSizeGrip, write=SetSizeGrip, default=1};
	__property bool ResizablePanels = {read=FResizablePanels, write=FResizablePanels, default=0};
	__property Elini::TElIniFile* Storage = {read=FStorage, write=FStorage};
	__property System::UnicodeString StoragePath = {read=FStoragePath, write=FStoragePath};
	__property TElStatusPanelBevel Bevel = {read=FBevel, write=SetBevel, default=1};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Align;
	__property Color;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property TElPanelEvent OnPanelResize = {read=FOnPanelResize, write=FOnPanelResize};
	__property TElPanelEvent OnPanelDraw = {read=FOnPanelDraw, write=FOnPanelDraw};
	__property TElPanelEvent OnPanelClick = {read=FOnPanelClick, write=FOnPanelClick};
	__property TElPanelEvent OnPanelDblClick = {read=FOnPanelDblClick, write=FOnPanelDblClick};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnHTMLImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElStatusBar(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::WideString __fastcall ConvertHintTextW(System::UnicodeString Hint);
}	/* namespace Elstatbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSTATBAR)
using namespace Elstatbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElstatbarHPP
