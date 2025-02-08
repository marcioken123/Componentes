// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBBtn.pas' rev: 31.00 (Windows)

#ifndef LmddbbtnHPP
#define LmddbbtnHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Data.DBConsts.hpp>
#include <Data.DB.hpp>
#include <Vcl.VDBConsts.hpp>
#include <LMDDBConst.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBookmarkCont.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbbtn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonDataLink;
class DELPHICLASS TLMDSpecialButton;
class DELPHICLASS TLMDSpecialButtons;
class DELPHICLASS TLMDDBNavigator;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDNavigateBtn : unsigned char { nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbSetBookmark, nbGotoBookmark, nbDeleteBookmark, nbSearch, nbSetFilter, nbRemoveFilter, nbClear, nbOpen, nbClose, nbFindFirst, nbFindPrior, nbFindNext, nbFindLast };

typedef void __fastcall (__closure *TLMDNavClick)(System::TObject* Sender, TLMDNavigateBtn Button);

enum DECLSPEC_DENUM TLMDNavGlyphSet : unsigned char { ngBlack, ngColored, ngNone };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	System::Classes::TComponent* FDBNavComp;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TLMDButtonDataLink(System::Classes::TComponent* ANavComponent);
	__fastcall virtual ~TLMDButtonDataLink(void);
};

#pragma pack(pop)

typedef System::Set<TLMDNavigateBtn, TLMDNavigateBtn::nbFirst, TLMDNavigateBtn::nbFindLast> TLMDNavButtons;

typedef void __fastcall (__closure *TLMDOnCustomBtnClick)(System::TObject* Sender, int index);

class PASCALIMPLEMENTATION TLMDSpecialButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TBitmap* FGlyph;
	Lmdspeedbutton::TLMDSpeedButton* FBtn;
	bool FEnabled;
	TLMDOnCustomBtnClick FOnClick;
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetBtn(Lmdspeedbutton::TLMDSpeedButton* aValue);
	void __fastcall DoOnClick(System::TObject* Sender);
	void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDSpecialButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSpecialButton(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Lmdspeedbutton::TLMDSpeedButton* Btn = {read=FBtn, write=SetBtn};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetString, index=0};
	__property System::UnicodeString Hint = {read=FHint, write=SetString, index=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Index;
	__property DisplayName = {default=0};
	__property TLMDOnCustomBtnClick OnClick = {read=FOnClick, write=FOnClick};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSpecialButtons : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDSpecialButton* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDDBNavigator* FNavigator;
	HIDESBASE TLMDSpecialButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSpecialButton* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDSpecialButtons(TLMDDBNavigator* Navigator);
	__fastcall virtual ~TLMDSpecialButtons(void);
	HIDESBASE TLMDSpecialButton* __fastcall Add(void);
	__property TLMDSpecialButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDBNavigator : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	TLMDNavButtons FButtons;
	TLMDButtonDataLink* FDataLink;
	Lmdbookmarkcont::TLMDBookmarkCont* FBookmark;
	bool FHideHint;
	bool FSingleLine;
	bool FShowBtnHints;
	bool FConfirmDelete;
	System::Types::TPoint FMinBtnSize;
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	System::Classes::TStrings* FBtnCaptions;
	System::Classes::TStrings* FBtnHints;
	System::StaticArray<Lmdspeedbutton::TLMDSpeedButton*, 23> FDisplayButtons;
	TLMDSpecialButtons* FCustomButtons;
	Lmdbuttonlayout::TLMDButtonLayout* FBtnLayout;
	System::Classes::TNotifyEvent FOnSearch;
	TLMDNavGlyphSet FSet;
	TLMDNavClick FOnNavClick;
	TLMDNavClick FBeforeAction;
	bool FRepeatedClick;
	System::Word FRepeatingInterval;
	void __fastcall SetCustomButtons(TLMDSpecialButtons* aValue);
	void __fastcall SetMinBtnSize(int index, int aValue);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetBtnHints(System::Classes::TStrings* aValue);
	void __fastcall SetBtnCaptions(System::Classes::TStrings* aValue);
	void __fastcall SetBtnLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetBtnStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetButtons(TLMDNavButtons aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall SetBookmark(Lmdbookmarkcont::TLMDBookmarkCont* aValue);
	void __fastcall SetBorders(int &aWidth, int &aHeight);
	void __fastcall SetRepeatedClick(bool aValue);
	void __fastcall SetRepeatingInterval(System::Word aValue);
	void __fastcall SetSet(TLMDNavGlyphSet aValue);
	Data::Db::TDataSource* __fastcall GetDatasource(void);
	int __fastcall GetMinBtnSize(int Index);
	void __fastcall DataChanged(void);
	void __fastcall EditingChanged(void);
	void __fastcall ActiveChanged(void);
	void __fastcall InitButtons(void);
	void __fastcall InitButtonHints(System::TObject* Sender);
	void __fastcall InitButtonCaptions(System::TObject* Sender);
	void __fastcall InitButtonLayouts(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
protected:
	DYNAMIC void __fastcall Click(void);
	void __fastcall DoClick(System::TObject* Sender);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall ClickButton(TLMDNavigateBtn btn);
	void __fastcall UpdateSize(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall MouseExit(void);
	
public:
	__fastcall virtual TLMDDBNavigator(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBNavigator(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall BtnClick(TLMDNavigateBtn Index);
	__property CtlXP = {default=1};
	__property DockManager;
	
__published:
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDatasource, write=SetDataSource};
	__property TLMDNavButtons Buttons = {read=FButtons, write=SetButtons, nodefault};
	__property Lmdbookmarkcont::TLMDBookmarkCont* Bookmark = {read=FBookmark, write=SetBookmark};
	__property bool ConfirmDelete = {read=FConfirmDelete, write=SetBoolean, index=1, default=1};
	__property bool HideHint = {read=FHideHint, write=FHideHint, default=0};
	__property bool ShowButtonHints = {read=FShowBtnHints, write=FShowBtnHints, default=1};
	__property System::Classes::TStrings* ButtonHints = {read=FBtnHints, write=SetBtnHints};
	__property System::Classes::TStrings* ButtonCaptions = {read=FBtnCaptions, write=SetBtnCaptions};
	__property Lmdbuttonlayout::TLMDButtonLayout* ButtonLayout = {read=FBtnLayout, write=SetBtnLayout};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FBtnStyle, write=SetBtnStyle, default=1};
	__property bool SingleLine = {read=FSingleLine, write=SetBoolean, index=0, default=0};
	__property int MinBtnWidth = {read=GetMinBtnSize, write=SetMinBtnSize, index=0, default=20};
	__property int MinBtnHeight = {read=GetMinBtnSize, write=SetMinBtnSize, index=1, default=18};
	__property TLMDSpecialButtons* CustomButtons = {read=FCustomButtons, write=SetCustomButtons};
	__property TLMDNavGlyphSet GlyphSet = {read=FSet, write=SetSet, default=0};
	__property bool RepeatedClick = {read=FRepeatedClick, write=SetRepeatedClick, default=0};
	__property System::Word RepeatingInterval = {read=FRepeatingInterval, write=SetRepeatingInterval, default=100};
	__property Color = {default=-16777201};
	__property Align = {default=0};
	__property Bevel;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property Visible = {default=1};
	__property PopupMenu;
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property Transparent = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property OnClick;
	__property TLMDNavClick OnBeforeNavBtnAction = {read=FBeforeAction, write=FBeforeAction};
	__property TLMDNavClick OnNavBtnClick = {read=FOnNavClick, write=FOnNavClick};
	__property System::Classes::TNotifyEvent OnSearch = {read=FOnSearch, write=FOnSearch};
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnMouseWheel;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBNavigator(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word IDB_NAVBMP = System::Word(0x40a4);
static const System::Int8 LMDNAVBTNS = System::Int8(0x17);
extern DELPHI_PACKAGE void __fastcall LMDDBNavAction(System::Classes::TComponent* Sender, Data::Db::TDataSet* DataSet, TLMDNavigateBtn Kind, Lmdbookmarkcont::TLMDBookmarkCont* FBookMark, bool FConfirmDelete);
}	/* namespace Lmddbbtn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBBTN)
using namespace Lmddbbtn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbbtnHPP
