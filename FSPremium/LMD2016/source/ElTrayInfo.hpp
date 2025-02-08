// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTrayInfo.pas' rev: 31.00 (Windows)

#ifndef EltrayinfoHPP
#define EltrayinfoHPP

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
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDUtils.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDSysIn.hpp>
#include <ElVCLUtils.hpp>
#include <ElHTMLLbl.hpp>
#include <LMDObjectList.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDGlyphs.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElPopBtn.hpp>
#include <ElImgLst.hpp>
#include <ElTopmost.hpp>
#include <ElComponent.hpp>
#include <ElCLabel.hpp>
#include <ElMenus.hpp>
#include <ElLabel.hpp>
#include <ElPanel.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltrayinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTrayMessage;
class DELPHICLASS TElTrayMessageList;
class DELPHICLASS TElTrayVisualScheme;
class DELPHICLASS TElAdvButton;
class DELPHICLASS TTrayInfoForm;
class DELPHICLASS TElTrayInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElTrayInfoType : unsigned char { titInformation, titWarning, titError, titNone };

typedef void __fastcall (__closure *TElCanDeleteMessageEvent)(System::TObject* Sender, const int Index, bool &CanDelete);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTrayMessage : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Graphics::TBitmap* FGlyph;
	System::Uitypes::TColor FGradientEndColor;
	System::Uitypes::TColor FGradientStartColor;
	bool FIsHtml;
	Lmdtypes::TLMDString FText;
	void __fastcall SetGradientEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetGradientStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetIsHtml(const bool Value);
	void __fastcall SetText(const Lmdtypes::TLMDString Value);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	
public:
	__fastcall virtual TElTrayMessage(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElTrayMessage(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, nodefault};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, nodefault};
	__property bool IsHTML = {read=FIsHtml, write=SetIsHtml, nodefault};
	__property Lmdtypes::TLMDString Text = {read=FText, write=SetText};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTrayMessageList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	TElTrayInfo* FTrayInfo;
	TElTrayMessage* __fastcall Get(int Index);
	void __fastcall Put(int Index, TElTrayMessage* const Value);
	void __fastcall RebuildPopupMenu(void);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	void __fastcall AClick(System::TObject* Sender);
	
public:
	HIDESBASE TElTrayMessage* __fastcall Add(void);
	__property TElTrayMessage* Items[int Index] = {read=Get, write=Put};
public:
	/* TCollection.Create */ inline __fastcall TElTrayMessageList(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TElTrayMessageList(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElTrayVisualScheme : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Lmdtypes::TLMDString FName;
	System::Uitypes::TColor FBorderColor;
	System::Uitypes::TColor FWindowGradientEnd;
	System::Uitypes::TColor FBarGradientStart;
	System::Uitypes::TColor FWindowGradientStart;
	System::Uitypes::TColor FBarGradientEnd;
	System::Uitypes::TColor FButtonHoverGradientEnd;
	System::Uitypes::TColor FButtonDownGradientEnd;
	System::Uitypes::TColor FButtonHoverGradientStart;
	System::Uitypes::TColor FButtonDownGradientStart;
	int FBorderWidth;
	System::Classes::TNotifyEvent FOnChange;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	int FBarHeight;
	Elvclutils::TTaskbarEdge FBarPosition;
	void __fastcall SetBackgroundType(const Lmdgraph::TLMDBackgroundType Value);
	void __fastcall SetBorderColor(const System::Uitypes::TColor Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetButtonDownGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetButtonDownGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetButtonHoverGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetButtonHoverGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetBarGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetBarGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetWindowGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetWindowGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetBarHeight(const int Value);
	void __fastcall SetBarPosition(const Elvclutils::TTaskbarEdge Value);
	
protected:
	virtual void __fastcall TriggerChangeEvent(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdtypes::TLMDString Name = {read=FName, write=FName};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, nodefault};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property Elvclutils::TTaskbarEdge BarPosition = {read=FBarPosition, write=SetBarPosition, nodefault};
	__property int BarHeight = {read=FBarHeight, write=SetBarHeight, nodefault};
	__property System::Uitypes::TColor ButtonHoverGradientStart = {read=FButtonHoverGradientStart, write=SetButtonHoverGradientStart, nodefault};
	__property System::Uitypes::TColor ButtonHoverGradientEnd = {read=FButtonHoverGradientEnd, write=SetButtonHoverGradientEnd, nodefault};
	__property System::Uitypes::TColor ButtonDownGradientStart = {read=FButtonDownGradientStart, write=SetButtonDownGradientStart, nodefault};
	__property System::Uitypes::TColor ButtonDownGradientEnd = {read=FButtonDownGradientEnd, write=SetButtonDownGradientEnd, nodefault};
	__property System::Uitypes::TColor WindowGradientStart = {read=FWindowGradientStart, write=SetWindowGradientStart, nodefault};
	__property System::Uitypes::TColor WindowGradientEnd = {read=FWindowGradientEnd, write=SetWindowGradientEnd, nodefault};
	__property System::Uitypes::TColor BarGradientStart = {read=FBarGradientStart, write=SetBarGradientStart, nodefault};
	__property System::Uitypes::TColor BarGradientEnd = {read=FBarGradientEnd, write=SetBarGradientEnd, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElTrayVisualScheme(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElTrayVisualScheme(void) : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TElAdvButton : public Elpanel::TCustomElPanel
{
	typedef Elpanel::TCustomElPanel inherited;
	
private:
	bool FDown;
	bool FHover;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	System::Uitypes::TColor FDownGradientEndColor;
	System::Uitypes::TColor FHoverGradientStartColor;
	System::Uitypes::TColor FHoverGradientEndColor;
	System::Uitypes::TColor FBorderColor;
	System::Uitypes::TColor FDownGradientStartColor;
	Lmdtypes::TLMDString FCaption;
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetBorderColor(const System::Uitypes::TColor Value);
	void __fastcall SetDownGradientEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetDownGradientStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetHoverGradientEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetHoverGradientStartColor(const System::Uitypes::TColor Value);
	
protected:
	virtual void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	virtual void __fastcall TriggerPaintEvent(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseEnter(System::TObject* Sender);
	void __fastcall MouseLeave(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	
public:
	__fastcall virtual TElAdvButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElAdvButton(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property System::Uitypes::TColor HoverGradientStartColor = {read=FHoverGradientStartColor, write=SetHoverGradientStartColor, nodefault};
	__property System::Uitypes::TColor HoverGradientEndColor = {read=FHoverGradientEndColor, write=SetHoverGradientEndColor, nodefault};
	__property System::Uitypes::TColor DownGradientStartColor = {read=FDownGradientStartColor, write=SetDownGradientStartColor, nodefault};
	__property System::Uitypes::TColor DownGradientEndColor = {read=FDownGradientEndColor, write=SetDownGradientEndColor, nodefault};
	__property OnClick;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvButton(HWND ParentWindow) : Elpanel::TCustomElPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TTrayInfoForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TTimer* Timer;
	Elpanel::TElPanel* Panel1;
	Elhtmllbl::TElHTMLLabel* InfoLabel;
	Vcl::Extctrls::TPaintBox* Image1;
	void __fastcall TimerTimer(System::TObject* Sender);
	void __fastcall ClickHandler(System::TObject* Sender);
	void __fastcall DblClickHandler(System::TObject* Sender);
	void __fastcall ShowHandler(System::TObject* Sender);
	void __fastcall HideHandler(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Image1Paint(System::TObject* Sender);
	
private:
	bool FShadowXP;
	System::Uitypes::TColor FBorderColor;
	int FBarHeight;
	Elvclutils::TTaskbarEdge FBarPosition;
	int FBorderWidth;
	System::Uitypes::TColor FBarGradientStart;
	System::Uitypes::TColor FBarGradientEnd;
	bool FSaveState;
	
protected:
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	void __fastcall SetShadowXP(const bool Value);
	DYNAMIC void __fastcall Paint(void);
	virtual void __fastcall DoDestroy(void);
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	Ellabel::TElLabel* FPages;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	TElAdvButton* FCloseBtn;
	TElAdvButton* FNextBtn;
	TElAdvButton* FPrevBtn;
	TElAdvButton* FDeleteBtn;
	TElAdvButton* FMenuBtn;
	Eltopmost::TElTopmost* FTopmost;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	
public:
	__property bool ShadowXP = {read=FShadowXP, write=SetShadowXP, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTrayInfoForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTrayInfoForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTrayInfoForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTrayInfoForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTrayInfo : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	bool FIsHTML;
	TTrayInfoForm* FInfoForm;
	unsigned FShowTime;
	TElTrayInfoType FInfoType;
	Lmdtypes::TLMDString FMessage;
	System::Uitypes::TColor FColor;
	bool FShowCloseButton;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	bool FShadowXP;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	TElTrayMessageList* FMsgs;
	int FCurrentMsg;
	Elmenus::TElPopupMenu* FPopupMenu;
	System::Classes::TNotifyEvent FOnPrevMessage;
	System::Classes::TNotifyEvent FOnNextMessage;
	System::Classes::TNotifyEvent FOnPopupClick;
	TElCanDeleteMessageEvent FOnCanDeleteMessage;
	Lmdobjectlist::TLMDObjectList* FVisualSchemeList;
	TElTrayVisualScheme* FVisualScheme;
	bool FShowNavPanel;
	bool FShowMenuButton;
	bool FShowDeleteButton;
	Lmdtypes::TLMDString FFormatOfNavigation;
	int FFormWidth;
	int FFormHeight;
	void __fastcall PrepareInfoForm(void);
	virtual void __fastcall FixTopbarPos(void);
	void __fastcall SetVisualScheme(TElTrayVisualScheme* const Value);
	void __fastcall HandlerChangeVisualScheme(System::TObject* Sender);
	void __fastcall SetShowNavPanel(const bool Value);
	void __fastcall SetFormatOfNavigation(const Lmdtypes::TLMDString Value);
	void __fastcall CloseBtnClick(System::TObject* Sender);
	void __fastcall NextBtnClick(System::TObject* Sender);
	void __fastcall PrevBtnClick(System::TObject* Sender);
	void __fastcall MenuBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall SetShowDeleteButton(const bool Value);
	void __fastcall SetShowMenuButton(const bool Value);
	bool __fastcall GetVisible(void);
	
protected:
	Vcl::Graphics::TFont* FFont;
	bool FParentFont;
	virtual void __fastcall SetShowTime(unsigned newValue);
	virtual void __fastcall SetInfoType(TElTrayInfoType newValue);
	virtual void __fastcall SetMessage(Lmdtypes::TLMDString newValue);
	void __fastcall AdjustFormIcon(void);
	void __fastcall AdjustFormSize(int X, int Y);
	int __fastcall SuggestedHeight(void);
	int __fastcall SuggestedWidth(void);
	virtual void __fastcall SetIsHTML(bool newValue);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall ClickHandler(System::TObject* Sender);
	void __fastcall DblClickHandler(System::TObject* Sender);
	void __fastcall ShowHandler(System::TObject* Sender);
	void __fastcall HideHandler(System::TObject* Sender);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall SetParentFont(bool Value);
	void __fastcall FillVisualStyles(void);
	
public:
	void __fastcall SetMessageIndex(const int Index);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	__fastcall virtual TElTrayInfo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTrayInfo(void);
	void __fastcall ShowEx(int X, int Y, bool AdjustY);
	void __fastcall ChooseVisualScheme(System::UnicodeString AName);
	__property TTrayInfoForm* InfoForm = {read=FInfoForm};
	__property bool Visible = {read=GetVisible, nodefault};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777192};
	__property unsigned ShowTime = {read=FShowTime, write=SetShowTime, nodefault};
	__property TElTrayInfoType InfoType = {read=FInfoType, write=SetInfoType, nodefault};
	__property Lmdtypes::TLMDString Message = {read=FMessage, write=SetMessage};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
	__property bool ShowNavPanel = {read=FShowNavPanel, write=SetShowNavPanel, nodefault};
	__property bool ShowMenuButton = {read=FShowMenuButton, write=SetShowMenuButton, nodefault};
	__property bool ShowDeleteButton = {read=FShowDeleteButton, write=SetShowDeleteButton, nodefault};
	__property bool ShowCloseButton = {read=FShowCloseButton, write=FShowCloseButton, nodefault};
	__property TElTrayVisualScheme* VisualScheme = {read=FVisualScheme, write=SetVisualScheme};
	__property Lmdtypes::TLMDString FormatOfNavigation = {read=FFormatOfNavigation, write=SetFormatOfNavigation};
	__property TElTrayMessageList* Messages = {read=FMsgs, write=FMsgs};
	__property int Width = {read=SuggestedWidth, write=FFormWidth, nodefault};
	__property int Height = {read=SuggestedHeight, write=FFormHeight, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property System::Classes::TNotifyEvent OnNextMessage = {read=FOnNextMessage, write=FOnNextMessage};
	__property System::Classes::TNotifyEvent OnPrevMessage = {read=FOnPrevMessage, write=FOnPrevMessage};
	__property System::Classes::TNotifyEvent OnPopupClick = {read=FOnPopupClick, write=FOnPopupClick};
	__property TElCanDeleteMessageEvent OnCanDeleteMessage = {read=FOnCanDeleteMessage, write=FOnCanDeleteMessage};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
};


typedef System::TMetaClass* TTrayInfoFormClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TTrayInfoFormClass TrayInfoFormClass;
}	/* namespace Eltrayinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTRAYINFO)
using namespace Eltrayinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltrayinfoHPP
