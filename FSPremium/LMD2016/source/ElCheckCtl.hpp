// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCheckCtl.pas' rev: 31.00 (Windows)

#ifndef ElcheckctlHPP
#define ElcheckctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Math.hpp>
#include <Vcl.ImgList.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDProcs.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDClass.hpp>
#include <LMDUnicode.hpp>
#include <LMDGraph.hpp>
#include <ElXPThemedControl.hpp>
#include <ElSndMap.hpp>
#include <ElVCLUtils.hpp>
#include <ElBtnCtl.hpp>
#include <ElImgFrm.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcheckctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCheckItem;
class DELPHICLASS TElCheckBox;
class DELPHICLASS TElRadioButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCheckItem : public Elbtnctl::TElButtonControl
{
	typedef Elbtnctl::TElButtonControl inherited;
	
private:
	bool FFlat;
	Elsndmap::TElSoundMap* FSoundMap;
	Elsndmap::TElSoundName FCheckSound;
	bool FJustLooseFocus;
	bool FWordWrap;
	bool FUseCustomGlyphs;
	Vcl::Graphics::TBitmap* FGlyph;
	System::Classes::TAlignment FAlignment;
	bool FMouseInControl;
	bool FPressed;
	HWND FOldCapture;
	Vcl::Imglist::TChangeLink* FChLink;
	Vcl::Imglist::TChangeLink* FAChLink;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FAutoSize;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	bool FModified;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	bool FUseImageList;
	System::Uitypes::TCursor FCursor;
	System::Types::TPoint FTextPos;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	void __fastcall AdjustAutoSize(void);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall ImagesChanged(System::TObject* Sender);
	void __fastcall setImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall setUseCustomGlyphs(bool newValue);
	void __fastcall setGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall setAlignment(System::Classes::TLeftRight newValue);
	void __fastcall setSoundMap(Elsndmap::TElSoundMap* newValue);
	void __fastcall SetIsHTML(bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Vcl::Controls::TCMFocusChanged &Msg);
	MESSAGE void __fastcall CMKillFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetUseImageList(bool Value);
	void __fastcall SetWordWrap(const bool Value);
	
protected:
	bool FFlatAlways;
	bool FHandleDialogKeys;
	bool FEndEllipsis;
	bool FReadOnly;
	int FCheckMargin;
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	void __fastcall TranslateClick(void);
	System::Types::TSize __fastcall GetCheckBoxSize(void);
	virtual void __fastcall SetAutoSize(bool newValue);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall GlyphChange(System::TObject* Sender);
	virtual void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R) = 0 ;
	virtual void __fastcall DrawGlyph(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DestRect, const System::Types::TRect &SrcRect);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	void __fastcall SetFlatAlways(bool Value);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	virtual void __fastcall CreateWnd(void);
	virtual int __fastcall CalcAutoHeight(bool Multiline);
	HIDESBASE virtual void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	System::Types::TRect __fastcall CalcTextRect(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadAlignment(System::Classes::TReader* Reader);
	void __fastcall SetEndEllipsis(bool Value);
	bool __fastcall CalcAutoSize(int &ax, int &ay);
	void __fastcall SetCheckMargin(int Value);
	
public:
	__fastcall virtual TElCheckItem(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCheckItem(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Click(void);
	__property Elsndmap::TElSoundName CheckSound = {read=FCheckSound, write=FCheckSound};
	__property Elsndmap::TElSoundMap* SoundMap = {read=FSoundMap, write=setSoundMap};
	__property System::Classes::TLeftRight CheckAlignment = {read=FAlignment, write=setAlignment, default=1};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=setUseCustomGlyphs, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=setGlyph};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=setImageForm};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
	__property bool FlatAlways = {read=FFlatAlways, write=SetFlatAlways, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property bool UseImageList = {read=FUseImageList, write=SetUseImageList, default=0};
	__property bool EndEllipsis = {read=FEndEllipsis, write=SetEndEllipsis, default=0};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	
__published:
	__property int CheckMargin = {read=FCheckMargin, write=SetCheckMargin, default=5};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCheckItem(HWND ParentWindow) : Elbtnctl::TElButtonControl(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


class PASCALIMPLEMENTATION TElCheckBox : public TElCheckItem
{
	typedef TElCheckItem inherited;
	
private:
	Vcl::Stdctrls::TCheckBoxState FState;
	bool FAllowGrayed;
	void __fastcall SetState(Vcl::Stdctrls::TCheckBoxState newValue);
	void __fastcall SetAllowGrayed(bool newValue);
	
protected:
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool newValue);
	virtual void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual void __fastcall Toggle(void);
	
__published:
	__property CheckAlignment = {default=1};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, default=0};
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	__property EndEllipsis = {default=0};
	__property AutoSize = {default=1};
	__property UseCustomGlyphs = {default=0};
	__property Checked = {default=0};
	__property CheckSound = {default=0};
	__property SoundMap;
	__property Glyph;
	__property ImageForm;
	__property TextDrawType = {default=0};
	__property Transparent = {default=0};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property IsHTML = {default=0};
	__property Images;
	__property AlphaForImages;
	__property Cursor = {default=0};
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property OnImageNeeded;
	__property OnLinkClick;
	__property MoneyFlat = {default=0};
	__property MoneyFlatActiveColor;
	__property MoneyFlatInactiveColor;
	__property MoneyFlatDownColor;
	__property UseImageList = {default=0};
	__property Caption;
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color;
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property ShowHint;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TElCheckItem.Create */ inline __fastcall virtual TElCheckBox(System::Classes::TComponent* AOwner) : TElCheckItem(AOwner) { }
	/* TElCheckItem.Destroy */ inline __fastcall virtual ~TElCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCheckBox(HWND ParentWindow) : TElCheckItem(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElRadioButton : public TElCheckItem
{
	typedef TElCheckItem inherited;
	
private:
	bool FChecked;
	
protected:
	bool FClicked;
	virtual void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool newValue);
	
public:
	__fastcall virtual TElRadioButton(System::Classes::TComponent* AOwner);
	
__published:
	__property AutoSize = {default=1};
	__property Checked = {default=0};
	__property EndEllipsis = {default=0};
	__property Cursor = {default=0};
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property OnImageNeeded;
	__property OnLinkClick;
	__property UseCustomGlyphs = {default=0};
	__property CheckSound = {default=0};
	__property SoundMap;
	__property CheckAlignment = {default=1};
	__property Glyph;
	__property ImageForm;
	__property MoneyFlat = {default=0};
	__property MoneyFlatActiveColor;
	__property MoneyFlatInactiveColor;
	__property MoneyFlatDownColor;
	__property Transparent = {default=0};
	__property TextDrawType = {default=0};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property IsHTML = {default=0};
	__property Images;
	__property AlphaForImages;
	__property UseImageList = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color;
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TElCheckItem.Destroy */ inline __fastcall virtual ~TElRadioButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElRadioButton(HWND ParentWindow) : TElCheckItem(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int DefCheckMargin;
extern DELPHI_PACKAGE int CheckBoxSize;
extern DELPHI_PACKAGE int InitCheckBoxSize;
}	/* namespace Elcheckctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCHECKCTL)
using namespace Elcheckctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcheckctlHPP
