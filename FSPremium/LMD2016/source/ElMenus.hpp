// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMenus.pas' rev: 31.00 (Windows)

#ifndef ElmenusHPP
#define ElmenusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDDebugUnit.hpp>
#include <ElShadowWindow.hpp>
#include <ElImgFrm.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDElConst.hpp>
#include <LMDProcs.hpp>
#include <LMDFiles.hpp>
#include <LMDUnicode.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDPNGImageFilters.hpp>
#include <LMDGraph.hpp>
#include <LMDSysIn.hpp>
#include <ElHook.hpp>
#include <ElTimers.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmenus
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EMenuError;
class DELPHICLASS THackClass;
class DELPHICLASS TMenuActionLink;
class DELPHICLASS TElMenuTheme;
class DELPHICLASS TElMenuItem;
class DELPHICLASS TElMainMenu;
class DELPHICLASS TElPopupMenu;
class DELPHICLASS TElPopupWindow;
class DELPHICLASS TElPopupTracker;
class DELPHICLASS TElBarPopupMenu;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EMenuError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMenuError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMenuError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EMenuError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EMenuError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EMenuError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EMenuError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EMenuError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMenuError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMenuError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMenuError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMenuError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMenuError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMenuError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TMenuBreak : unsigned char { mbNone, mbBreak, mbBarBreak };

typedef void __fastcall (__closure *TElEndPopupEvent)(System::TObject* Sender, bool ManualCancel);

typedef void __fastcall (__closure *TElNavigateKeyEvent)(System::TObject* Sender, System::Word Button);

typedef void __fastcall (__closure *TMenuChangeEvent)(System::TObject* Sender, TElMenuItem* Source, bool Rebuild);

class PASCALIMPLEMENTATION THackClass : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TBiDiMode FBiDiMode;
	Vcl::Menus::TMenuItem* FItems;
public:
	/* TComponent.Create */ inline __fastcall virtual THackClass(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~THackClass(void) { }
	
};


class PASCALIMPLEMENTATION TMenuActionLink : public Vcl::Actnlist::TActionLink
{
	typedef Vcl::Actnlist::TActionLink inherited;
	
protected:
	TElMenuItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsAutoCheckLinked(void);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHelpContext(System::Classes::THelpContext Value);
	virtual void __fastcall SetHint(const System::UnicodeString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetShortCut(System::Classes::TShortCut Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(System::Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TMenuActionLink(System::TObject* AClient) : Vcl::Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TMenuActionLink(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElMenuTheme : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	virtual void __fastcall DrawItemText(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString AText, const System::Types::TRect &ARect, const int AFlags) = 0 ;
	virtual void __fastcall DrawItemBackground(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect) = 0 ;
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElMenuTheme(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElMenuTheme(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TMenuActionLinkClass;

enum DECLSPEC_DENUM TDrawStyle : unsigned char { tdsNormal, tdsOfficeXP, tdsWindowsXP, tdsOffice2003 };

class PASCALIMPLEMENTATION TElMenuItem : public Vcl::Menus::TMenuItem
{
	typedef Vcl::Menus::TMenuItem inherited;
	
public:
	TElMenuItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TNotifyEvent FOnSubMenuPopup;
	HIDESBASE bool __fastcall InternalRethinkLines(bool ForceRethink);
	void __fastcall DrawAlphaMaskedImage(Vcl::Graphics::TCanvas* Canvas, int X, int Y, int W, int H, Vcl::Imglist::TCustomImageList* Images, Vcl::Imglist::TCustomImageList* AlphaImages);
	
protected:
	Winapi::Windows::TOwnerDrawState FState;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	Vcl::Imglist::TCustomImageList* FSubMenuImages;
	Vcl::Imglist::TCustomImageList* FAlphaSubMenuImages;
	Lmdtypes::TLMDString FCaption;
	HMENU FHandle;
	bool FChecked;
	bool FEnabled;
	bool FDefault;
	bool FRadioItem;
	bool FVisible;
	System::Byte FGroupIndex;
	int FImageIndex;
	Vcl::Forms::TCustomForm* FCurrentForm;
	TMenuActionLink* FActionLink;
	bool FProcessShortCut;
	TMenuBreak FBreak;
	Vcl::Graphics::TBitmap* FBitmap;
	Vcl::Graphics::TBitmap* FDisBitmap;
	System::Word FCommand;
	Lmdtypes::TLMDString FHint;
	System::Classes::TList* FItems;
	System::Classes::TShortCut FShortCut;
	TElMenuItem* FParent;
	TElMenuItem* FMerged;
	TElMenuItem* FMergedWith;
	Vcl::Menus::TMenu* FMenu;
	bool FStreamedRebuild;
	TMenuChangeEvent FOnChange;
	TMenuChangeEvent FOnIntChange;
	System::Classes::TNotifyEvent FOnClick;
	bool FVertical;
	bool __fastcall IsVistaSelNeed(bool Selected);
	bool __fastcall ChildsHasImage(void);
	HIDESBASE void __fastcall AppendTo(HMENU Menu, bool ARightToLeft);
	HIDESBASE void __fastcall DoActionChange(System::TObject* Sender);
	HIDESBASE void __fastcall ReadShortCutText(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall MergeWith(TElMenuItem* Menu);
	HIDESBASE void __fastcall RebuildHandle(void);
	HIDESBASE void __fastcall PopulateMenu(void);
	HIDESBASE void __fastcall SubItemChanged(System::TObject* Sender, TElMenuItem* Source, bool Rebuild);
	HIDESBASE void __fastcall TurnSiblingsOff(void);
	void __fastcall WriteShortCutText(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall VerifyGroupIndex(int Position, System::Byte Value);
	HIDESBASE virtual System::Classes::TBasicAction* __fastcall GetAction(void);
	HIDESBASE virtual void __fastcall SetAction(System::Classes::TBasicAction* Value);
	HIDESBASE void __fastcall SetSubMenuImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaSubMenuImages(Vcl::Imglist::TCustomImageList* Value);
	HIDESBASE Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	HIDESBASE void __fastcall SetBitmap(Vcl::Graphics::TBitmap* Value);
	HIDESBASE void __fastcall InitiateActions(void);
	HIDESBASE bool __fastcall IsCaptionStored(void);
	HIDESBASE bool __fastcall IsCheckedStored(void);
	HIDESBASE bool __fastcall IsEnabledStored(void);
	HIDESBASE bool __fastcall IsHintStored(void);
	HIDESBASE bool __fastcall IsImageIndexStored(void);
	HIDESBASE bool __fastcall IsOnClickStored(void);
	HIDESBASE bool __fastcall IsShortCutStored(void);
	HIDESBASE bool __fastcall IsVisibleStored(void);
	TDrawStyle __fastcall GetDrawStyle(void);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages(bool Enabled, bool Selected);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaImages(bool Enabled, bool Selected);
	bool __fastcall IsRightToLeft(void);
	bool __fastcall IsTopLevel(void);
	HIDESBASE bool __fastcall IsLine(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall MeasureItem(Vcl::Graphics::TCanvas* ACanvas, int &Width, int &Height);
	DYNAMIC void __fastcall DoMeasureItem(Vcl::Graphics::TCanvas* Canvas, int &Width, int &Height);
	void __fastcall MeasureNormalItem(Vcl::Graphics::TCanvas* Canvas, int &Width, int &Height);
	void __fastcall MeasureOfficeXPItem(Vcl::Graphics::TCanvas* Canvas, int &Width, int &Height);
	void __fastcall MeasureWindowsXPItem(Vcl::Graphics::TCanvas* Canvas, int &Width, int &Height);
	virtual void __fastcall MeasureMenuItem(Vcl::Graphics::TCanvas* Canvas, int &Width, int &Height);
	void __fastcall DrawOfficeXPSeparator(Vcl::Graphics::TCanvas* ACanvas, int ImgW, const System::Types::TRect &TR, System::Types::TRect &R);
	HIDESBASE void __fastcall DoDrawText(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString ACaption, System::Types::TRect &Rect, bool Selected, int Flags);
	void __fastcall DrawNormalLeftToRight(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected);
	void __fastcall DrawOfficeXPLeftToRight(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected, bool Dropped);
	void __fastcall DrawWindowsXPLeftToRight(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected);
	void __fastcall DrawNormalRightToLeft(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected);
	void __fastcall DrawOfficeXPRightToLeft(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected, bool Dropped);
	void __fastcall DrawWindowsXPRightToLeft(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected);
	virtual void __fastcall DrawMenuItem(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool Selected, bool Dropped);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	HIDESBASE void __fastcall ImageListChange(System::TObject* Sender);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	HIDESBASE TMenuActionLinkClass __fastcall GetActionLinkClass(void);
	void __fastcall TriggerSubMenuPopup(void);
	HIDESBASE HMENU __fastcall GetHandle(void);
	HIDESBASE int __fastcall GetCount(void);
	virtual System::Uitypes::TColor __fastcall GetFontColor(Lmdclass::TLMDThemeMode aThemeMode, bool Selected);
	HIDESBASE TElMenuItem* __fastcall GetItem(int Index);
	HIDESBASE int __fastcall GetMenuIndex(void);
	virtual void __fastcall MenuChanged(bool Rebuild);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE void __fastcall SetBreak(TMenuBreak Value);
	HIDESBASE void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	HIDESBASE void __fastcall SetChecked(bool Value);
	DYNAMIC void __fastcall SetChildOrder(System::Classes::TComponent* Child, int Order);
	HIDESBASE void __fastcall SetDefault(bool Value);
	HIDESBASE void __fastcall SetEnabled(bool Value);
	HIDESBASE void __fastcall SetGroupIndex(System::Byte Value);
	HIDESBASE void __fastcall SetImageIndex(int Value);
	HIDESBASE void __fastcall SetMenuIndex(int Value);
	HIDESBASE void __fastcall SetRadioItem(bool Value);
	void __fastcall ReadCaption(System::Classes::TReader* Reader);
	void __fastcall ReadHint(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	HIDESBASE void __fastcall SetShortCut(System::Classes::TShortCut Value);
	HIDESBASE void __fastcall SetVisible(bool Value);
	__property TMenuActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	HIDESBASE void __fastcall UpdateItems(void);
	int __fastcall GetImageWidth(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	void __fastcall UpdateCommand(void);
	bool __fastcall DisabledImagePresent(void);
	virtual void __fastcall IntMenuChanged(bool Rebuild);
	__property TMenuChangeEvent OnIntChange = {read=FOnIntChange, write=FOnIntChange};
	__property bool Vertical = {read=FVertical, write=FVertical, default=0};
	
public:
	__fastcall virtual TElMenuItem(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElMenuItem(void);
	bool __fastcall IsThemed(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* Value);
	virtual void __fastcall InitiateAction(void);
	void __fastcall DesignRebuild(void);
	HIDESBASE void __fastcall Insert(int Index, TElMenuItem* Item);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TElMenuItem* __fastcall Find(Lmdtypes::TLMDString ACaption);
	HIDESBASE int __fastcall IndexOf(TElMenuItem* Item);
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent(void);
	HIDESBASE Vcl::Menus::TMenu* __fastcall GetParentMenu(void);
	DYNAMIC bool __fastcall HasParent(void);
	HIDESBASE void __fastcall Add(TElMenuItem* Item);
	HIDESBASE void __fastcall Remove(TElMenuItem* Item);
	HIDESBASE void __fastcall Clear(void);
	void __fastcall CopyItemsFrom(TElMenuItem* AItem);
	__property HMENU Handle = {read=GetHandle, nodefault};
	__property TElMenuItem* Merged = {read=FMerged};
	__property int Count = {read=GetCount, nodefault};
	__property TElMenuItem* Items[int Index] = {read=GetItem/*, default*/};
	__property int MenuIndex = {read=GetMenuIndex, write=SetMenuIndex, nodefault};
	__property TElMenuItem* Parent = {read=FParent};
	virtual void __fastcall Click(void);
	
__published:
	__property System::Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property bool ProcessShortCut = {read=FProcessShortCut, write=FProcessShortCut, default=1};
	__property Vcl::Imglist::TCustomImageList* SubMenuImages = {read=FSubMenuImages, write=SetSubMenuImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForSubMenuImages = {read=FAlphaSubMenuImages, write=SetAlphaSubMenuImages};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=GetBitmap, write=SetBitmap};
	__property TMenuBreak Break = {read=FBreak, write=SetBreak, default=0};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property bool Checked = {read=FChecked, write=SetChecked, stored=IsCheckedStored, default=0};
	__property bool Default = {read=FDefault, write=SetDefault, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property System::Byte GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint, stored=IsHintStored};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property bool RadioItem = {read=FRadioItem, write=SetRadioItem, default=0};
	__property System::Classes::TShortCut ShortCut = {read=FShortCut, write=SetShortCut, stored=IsShortCutStored, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, stored=IsVisibleStored, default=1};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
	__property TMenuChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnSubMenuPopup = {read=FOnSubMenuPopup, write=FOnSubMenuPopup};
};


typedef System::TMetaClass* TElMenuItemClass;

class PASCALIMPLEMENTATION TElMainMenu : public Vcl::Menus::TMainMenu
{
	typedef Vcl::Menus::TMainMenu inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	HMENU FOle2Menu;
	Lmdtypes::TLMDString FMenuImage;
	TElMenuItem* FUnicodeItems;
	TDrawStyle FDrawStyle;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FSelectedItemFont;
	Vcl::Forms::TForm* FForm;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Vcl::Imglist::TChangeLink* FDisabledImageChangeLink;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TChangeLink* FHotImageChangeLink;
	Vcl::Imglist::TCustomImageList* FHotImages;
	Vcl::Imglist::TChangeLink* FAHotImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaHotImages;
	Vcl::Imglist::TChangeLink* FADisabledImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaDisabledImages;
	int FItemSpace;
	int FImageMargin;
	bool FOwnerDraw;
	bool FRightToLeft;
	bool WindowActive;
	bool FIsHTML;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	void __fastcall SetIsHTML(bool Value);
	bool __fastcall GetIsHTML(void);
	HIDESBASE void __fastcall SetOwnerDraw(bool Value);
	HIDESBASE void __fastcall ImageListChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	HIDESBASE void __fastcall ItemChanged(void);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	void __fastcall OnAfterHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	void __fastcall SetDrawStyle(TDrawStyle Value);
	TDrawStyle __fastcall GetDrawStyle(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	HIDESBASE bool __fastcall UpdateImage(void);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetHotImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaDisabledImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaHotImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetItemSpace(int Value);
	void __fastcall SetImageMargin(int Value);
	void __fastcall SetUseFontColor(const bool Value);
	void __fastcall SetSelectedItemFont(Vcl::Graphics::TFont* const Value);
	
protected:
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	Elhook::TElHook* FHook;
	int FUpdateCount;
	bool FSystemFont;
	bool FUseFontColor;
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	HIDESBASE bool __fastcall IsOwnerDraw(void);
	HIDESBASE void __fastcall ProcessMenuChar(Winapi::Messages::TWMMenuChar &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE int __fastcall DoGetMenuString(HMENU Menu, unsigned ItemID, System::WideChar * Str, int MaxCount, unsigned Flag);
	virtual void __fastcall MenuChanged(System::TObject* Sender, Vcl::Menus::TMenuItem* Source, bool Rebuild);
	void __fastcall IntMenuChanged(System::TObject* Sender, TElMenuItem* Source, bool Rebuild);
	virtual HMENU __fastcall GetHandle(void);
	HIDESBASE bool __fastcall DispatchCommand(System::Word ACommand);
	virtual void __fastcall Loaded(void);
	void __fastcall SetRightToLeft(bool Value);
	void __fastcall SetSystemFont(bool Value);
	void __fastcall GetFont(void);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall UpdateCommands(void);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall virtual TElMainMenu(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElMainMenu(void);
	bool __fastcall IsThemed(void);
	HIDESBASE TElMenuItem* __fastcall FindItem(unsigned Value, Vcl::Menus::TFindItemKind Kind);
	DYNAMIC bool __fastcall IsShortCut(Winapi::Messages::TWMKey &Message);
	HIDESBASE void __fastcall UpdateItems(void);
	HIDESBASE bool __fastcall DispatchPopup(HMENU AHandle);
	HIDESBASE void __fastcall Merge(TElMainMenu* Menu);
	HIDESBASE void __fastcall Unmerge(TElMainMenu* Menu);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	bool __fastcall isUpdated(void);
	void __fastcall LoadItemsFromFiles(const Lmdtypes::TLMDString *ItemsFileName, const int ItemsFileName_High);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TElMenuItem* Items = {read=FUnicodeItems};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Vcl::Graphics::TFont* SelectedItemFont = {read=FSelectedItemFont, write=SetSelectedItemFont};
	__property TDrawStyle DrawStyle = {read=GetDrawStyle, write=SetDrawStyle, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDisabledImages = {read=FAlphaDisabledImages, write=SetAlphaDisabledImages};
	__property Vcl::Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHotImages = {read=FAlphaHotImages, write=SetAlphaHotImages};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetOwnerDraw, default=0};
	__property int ItemSpace = {read=FItemSpace, write=SetItemSpace, default=4};
	__property int ImageMargin = {read=FImageMargin, write=SetImageMargin, default=6};
	__property bool RightToLeft = {read=FRightToLeft, write=SetRightToLeft, default=0};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, default=0};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool UseFontColor = {read=FUseFontColor, write=SetUseFontColor, default=0};
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


class PASCALIMPLEMENTATION TElPopupMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Elhook::TElHook* FHook;
	TDrawStyle FDrawStyle;
	TElMenuItem* FUnicodeItems;
	System::Types::TPoint FPopupPoint;
	Vcl::Controls::TWinControl* FForm;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FSelectedItemFont;
	bool FSystemFont;
	System::Classes::TWndMethod FHookWindowProc;
	TElEndPopupEvent FOnEndPopup;
	TElNavigateKeyEvent FOnNavigateKey;
	bool FInitialSelect;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Vcl::Imglist::TChangeLink* FDisabledImageChangeLink;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TChangeLink* FHotImageChangeLink;
	Vcl::Imglist::TCustomImageList* FHotImages;
	Vcl::Imglist::TChangeLink* FAHotImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaHotImages;
	Vcl::Imglist::TChangeLink* FADisabledImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaDisabledImages;
	int FItemSpace;
	int FImageMargin;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FIsPopuped;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	HIDESBASE void __fastcall ImageListChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetDrawStyle(TDrawStyle Value);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetIsHTML(bool Value);
	bool __fastcall GetIsHTML(void);
	void __fastcall SetItemSpace(int Value);
	void __fastcall SetImageMargin(int Value);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetHotImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaDisabledImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaHotImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetUseFontColor(const bool Value);
	void __fastcall SetSelectedItemFont(Vcl::Graphics::TFont* const Value);
	
protected:
	bool FPopupRightToLeft;
	bool FMustBeInScreen;
	System::Types::TRect ExcludeRect;
	bool FUseFontColor;
	virtual void __fastcall DoPopup(System::TObject* Sender);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	HIDESBASE bool __fastcall IsOwnerDraw(void);
	HIDESBASE bool __fastcall DispatchCommand(System::Word ACommand);
	virtual HMENU __fastcall GetHandle(void);
	void __fastcall GetFont(void);
	void __fastcall SetPopupRightToLeft(bool Value);
	void __fastcall SetSystemFont(bool Value);
	void __fastcall FontChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall UpdateCommands(void);
	void __fastcall TriggerEndPopup(bool ManualCancel);
	virtual void __fastcall TriggerNavigateKey(System::Word Button);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	TDrawStyle __fastcall GetDrawStyle(void);
	__property TElNavigateKeyEvent OnNavigateKey = {read=FOnNavigateKey, write=FOnNavigateKey};
	
public:
	__fastcall virtual TElPopupMenu(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElPopupMenu(void);
	bool __fastcall IsThemed(void);
	virtual void __fastcall Popup(int X, int Y);
	HIDESBASE virtual TElMenuItem* __fastcall FindItem(unsigned Value, Vcl::Menus::TFindItemKind Kind);
	DYNAMIC bool __fastcall IsShortCut(Winapi::Messages::TWMKey &Message);
	__property System::Classes::TWndMethod HookWindowProc = {read=FHookWindowProc, write=FHookWindowProc};
	HIDESBASE void __fastcall ProcessMenuChar(Winapi::Messages::TWMMenuChar &Message);
	HIDESBASE void __fastcall UpdateItems(void);
	HIDESBASE bool __fastcall DispatchPopup(HMENU AHandle);
	__property System::Types::TPoint PopupPoint = {read=FPopupPoint};
	__property Handle = {read=GetHandle};
	void __fastcall LoadItemsFromFiles(const Lmdtypes::TLMDString *ItemsFileName, const int ItemsFileName_High);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool IsPopuped = {read=FIsPopuped, nodefault};
	__property bool InitialSelect = {read=FInitialSelect, write=FInitialSelect, nodefault};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TElMenuItem* Items = {read=FUnicodeItems};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Vcl::Graphics::TFont* SelectedItemFont = {read=FSelectedItemFont, write=SetSelectedItemFont};
	__property TDrawStyle DrawStyle = {read=GetDrawStyle, write=SetDrawStyle, default=0};
	__property bool RightToLeft = {read=FPopupRightToLeft, write=SetPopupRightToLeft, default=0};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, default=0};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property int ItemSpace = {read=FItemSpace, write=SetItemSpace, default=4};
	__property int ImageMargin = {read=FImageMargin, write=SetImageMargin, default=6};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDisabledImages = {read=FAlphaDisabledImages, write=SetAlphaDisabledImages};
	__property Vcl::Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHotImages = {read=FAlphaHotImages, write=SetAlphaHotImages};
	__property TElEndPopupEvent OnEndPopup = {read=FOnEndPopup, write=FOnEndPopup};
	__property bool UseFontColor = {read=FUseFontColor, write=SetUseFontColor, default=0};
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


typedef void * TLMDIterator;

enum DECLSPEC_DENUM TPassthroughMouse : unsigned char { pmNone, pmDblClk, pmMove };

enum DECLSPEC_DENUM TMenuScrollArrow : unsigned char { msNone, msTop, msBottom };

enum DECLSPEC_DENUM TMenuSelectedWith : unsigned char { swNone, swMouse, swKeyboard };

enum DECLSPEC_DENUM TMenuPopupAction : unsigned char { paShow, paClose };

class PASCALIMPLEMENTATION TElPopupWindow : public Vcl::Forms::TCustomForm
{
	typedef Vcl::Forms::TCustomForm inherited;
	
	
private:
	typedef System::DynamicArray<int> _TElPopupWindow__1;
	
	typedef System::DynamicArray<int> _TElPopupWindow__2;
	
	typedef System::DynamicArray<int> _TElPopupWindow__3;
	
	typedef System::DynamicArray<System::Types::TRect> _TElPopupWindow__4;
	
	
private:
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	TDrawStyle FDrawStyle;
	Vcl::Imglist::TCustomImageList* FImages;
	TElMenuItem* FMenuItem;
	Eltimers::TElTimerPoolItem* FPopupTimer;
	bool FRightToLeft;
	Eltimers::TElTimerPoolItem* FScrollTimer;
	TElPopupTracker* FTracker;
	_TElPopupWindow__1 FColumnItems;
	_TElPopupWindow__2 FColumnWidths;
	_TElPopupWindow__3 FItemHeights;
	_TElPopupWindow__4 FItemRects;
	int FTopItem;
	int FLastItem;
	bool FScrollable;
	bool FScrollActive;
	bool FScrollableTopToBottom;
	System::Types::TRect FBottomArrowRect;
	System::Types::TRect FTopArrowRect;
	TMenuScrollArrow FActiveScrollArrow;
	int FSelectedWithMouse;
	int FSelectedWithKeyboard;
	TMenuSelectedWith FLastSelectedWith;
	bool FScrolling;
	Vcl::Graphics::TBitmap* FPaintBuffer;
	bool FPainting;
	TMenuPopupAction FPopupAction;
	int FPopupItem;
	int FSubmenuItem;
	TElPopupWindow* FPrevPopupWindow;
	System::Types::TRect ExcludeRect;
	void __fastcall PopupTimerTick(System::TObject* Sender);
	void __fastcall ScrollTimerTick(System::TObject* Sender);
	void __fastcall StartClosePopup(void);
	void __fastcall StartShowPopup(int Item);
	void __fastcall StopPopup(void);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Msg);
	void __fastcall SetSubmenuItem(const int Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall CloseSubmenus(void);
	int __fastcall FindFirstVisibleItem(void);
	int __fastcall FindLastVisibleItem(void);
	int __fastcall FindNextItem(int Index);
	int __fastcall FindPrevItem(int Index);
	virtual TDrawStyle __fastcall GetDrawStyle(void);
	int __fastcall GetItemColumnIndex(int Item);
	virtual int __fastcall GetSelectedItem(void);
	bool __fastcall InBottomArrowArea(int X, int Y);
	bool __fastcall InTopArrowArea(int X, int Y);
	HIDESBASE bool __fastcall IsRightToLeft(void);
	int __fastcall ItemFromPoint(int X, int Y);
	virtual void __fastcall DrawColumnedWndLeftToRight(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DrawScrollableWndLeftToRight(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DrawColumnedWndRightToLeft(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DrawScrollableWndRightToLeft(Vcl::Graphics::TCanvas* Canvas);
	void __fastcall DrawOfficeXPBorder(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R);
	virtual void __fastcall MeasureBounds(void);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall RedrawItem(int Index);
	void __fastcall ScrollDown(void);
	void __fastcall ScrollUp(void);
	void __fastcall SelectFirstItem(void);
	void __fastcall SelectLastItem(void);
	void __fastcall SelectLeftItem(int Column);
	void __fastcall SelectNextItem(void);
	void __fastcall SelectPrevItem(void);
	void __fastcall SelectRightItem(int Column);
	void __fastcall ShowSubmenu(int Item);
	DYNAMIC bool __fastcall TrackRightButton(void);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	void __fastcall NotifyMenuSelect(int ItemIndex, TElMenuItem* Item);
	void __fastcall NotifyHelpRequest(void);
	
public:
	__fastcall virtual TElPopupWindow(TElPopupTracker* Tracker, TElMenuItem* Menu, TDrawStyle DrawStyle, Vcl::Graphics::TFont* Font, bool RightToLeft, Vcl::Imglist::TCustomImageList* Images, Vcl::Imglist::TCustomImageList* AlphaImages, bool SelectFirst);
	__fastcall virtual ~TElPopupWindow(void);
	bool __fastcall IsThemed(void);
	void __fastcall EndMenu(void);
	__property int SelectedItem = {read=GetSelectedItem, nodefault};
	__property int SubmenuItem = {read=FSubmenuItem, write=SetSubmenuItem, nodefault};
	__property TElMenuItem* MenuItem = {read=FMenuItem};
	__property int SelectedWidthMouse = {read=FSelectedWithMouse, nodefault};
	__property int SelectedWidthKeyboard = {read=FSelectedWithKeyboard, nodefault};
	__property TMenuSelectedWith LastSelectedWith = {read=FLastSelectedWith, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElPopupWindow(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TCustomForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPopupWindow(HWND ParentWindow) : Vcl::Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElPopupTracker : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	TDrawStyle FDrawStyle;
	int FFlags;
	Vcl::Graphics::TFont* FFont;
	Vcl::Imglist::TCustomImageList* FImages;
	NativeUInt FMessageWnd;
	bool FRightToLeft;
	TPassthroughMouse FPassthroughMouse;
	NativeUInt FTarget;
	bool FTerminated;
	bool FTermCancel;
	Eltimers::TElTimerPool* FTimers;
	NativeUInt FTrackerWnd;
	System::Classes::TList* FWindows;
	bool FSystemShadows;
	System::Classes::TList* FShadows;
	MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMSysKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall ELMenuSelect(Winapi::Messages::TMessage &Message);
	
protected:
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	Eltimers::TElTimerPoolItem* __fastcall AddPopupTimer(void);
	Eltimers::TElTimerPoolItem* __fastcall AddScrollTimer(void);
	virtual void __fastcall CloseLastPopupWindow(void);
	virtual void __fastcall CloseWindows(void);
	void __fastcall DeletePopupTimer(Eltimers::TElTimerPoolItem* Timer);
	void __fastcall DeleteScrollTimer(Eltimers::TElTimerPoolItem* Timer);
	int __fastcall FindPopupWindow(int X, int Y);
	virtual void __fastcall InternalTrack(TElPopupMenu* Menu, TElMenuItem* MenuItem, int X, int Y1, int Y2, int Flags, const System::Types::TRect &ExcludeRect, bool SelectFirstItem);
	bool __fastcall MouseInOtherWindow(TElPopupWindow* Window, int X, int Y);
	bool __fastcall SubmenuShown(TElPopupWindow* Window);
	virtual void __fastcall TrackerWndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall NotifyButton(System::Word Key);
	MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	
public:
	__fastcall virtual TElPopupTracker(void);
	__fastcall virtual ~TElPopupTracker(void);
	virtual void __fastcall EndMenu(bool ManualCancel);
	virtual void __fastcall Track(TElMenuItem* Menu, int X, int Y, int Flags, NativeUInt Target, TPassthroughMouse PassthroughMouse);
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
};


class PASCALIMPLEMENTATION TElBarPopupMenu : public TElPopupMenu
{
	typedef TElPopupMenu inherited;
	
public:
	/* TElPopupMenu.Create */ inline __fastcall virtual TElBarPopupMenu(System::Classes::TComponent* AOwner) : TElPopupMenu(AOwner) { }
	/* TElPopupMenu.Destroy */ inline __fastcall virtual ~TElBarPopupMenu(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word EL_NAVIGATEKEY = System::Word(0x547);
static const System::Word EL_MENUSELECT = System::Word(0x548);
static const System::Word EL_MENUCLICK = System::Word(0x549);
extern DELPHI_PACKAGE TElPopupWindow* ActivePopupWindow;
extern DELPHI_PACKAGE void __fastcall TrackElPopupMenu(TElMenuItem* Menu, int Flags, int X, int Y, NativeUInt Target);
extern DELPHI_PACKAGE void __fastcall CancelElMenu(bool ManualCancel);
extern DELPHI_PACKAGE HFONT __fastcall GetMenuFont(void);
extern DELPHI_PACKAGE void __fastcall IterateMenus(void * Func, TElMenuItem* Menu1, TElMenuItem* Menu2);
extern DELPHI_PACKAGE void __fastcall ElLoadItemsFromFiles(Vcl::Menus::TMenu* Menu, const Lmdtypes::TLMDString *ItemsFileName, const int ItemsFileName_High);
extern DELPHI_PACKAGE void __fastcall InsertItems(Vcl::Menus::TMenu* &AMenu, TElMenuItem* MainItem, int Index, TElMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE void __fastcall InsertMenuItems(Vcl::Menus::TMenu* &AMenu, int Index, TElMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE void __fastcall ElInitMenuItems(Vcl::Menus::TMenu* AMenu, TElMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE TElMainMenu* __fastcall ElNewMenu(System::Classes::TComponent* Owner, const Lmdtypes::TLMDString AName, TElMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE TElMenuItem* __fastcall ElNewSubMenu(const Lmdtypes::TLMDString ACaption, System::Word hCtx, const Lmdtypes::TLMDString AName, TElMenuItem* *Items, const int Items_High, bool AEnabled);
extern DELPHI_PACKAGE TElMenuItem* __fastcall ElNewItem(const Lmdtypes::TLMDString ACaption, System::Classes::TShortCut AShortCut, bool AChecked, bool AEnabled, System::Classes::TNotifyEvent AOnClick, System::Word hCtx, const Lmdtypes::TLMDString AName, TElMenuItemClass MenuItemClass, const int AImageIndex = 0xffffffff);
extern DELPHI_PACKAGE TElMenuItem* __fastcall ElNewLine(void);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall ElGetHotkey(const Lmdtypes::TLMDString Text);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall ElStripHotKey(const Lmdtypes::TLMDString Text);
}	/* namespace Elmenus */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMENUS)
using namespace Elmenus;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElmenusHPP
