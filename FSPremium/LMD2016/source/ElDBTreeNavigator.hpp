// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBTreeNavigator.pas' rev: 31.00 (Windows)

#ifndef EldbtreenavigatorHPP
#define EldbtreenavigatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDDebugUnit.hpp>
#include <ElPanel.hpp>
#include <ElDBXTree.hpp>
#include <Vcl.ImgList.hpp>
#include <ElToolBar.hpp>
#include <ElPopBtn.hpp>
#include <ElACtrls.hpp>
#include <ElMaskEdit.hpp>
#include <ElCheckCtl.hpp>
#include <ElCheckItemGrp.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUtils.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <ElPromptDlg.hpp>
#include <ElEdits.hpp>
#include <System.Types.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDGlyphs.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDElDBConst.hpp>
#include <ElVCLUtils.hpp>
#include <LMDGraph.hpp>
#include <ElXTree.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <ElSndMap.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbtreenavigator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THElXDBTree;
class DELPHICLASS THElXDBTreeItem;
class DELPHICLASS TElDBTreeNavButton;
class DELPHICLASS TElDBTreeNavigator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THElXDBTree : public Eldbxtree::TCustomElDBXTree
{
	typedef Eldbxtree::TCustomElDBXTree inherited;
	
public:
	/* TCustomElDBXTree.Create */ inline __fastcall virtual THElXDBTree(System::Classes::TComponent* AOwner) : Eldbxtree::TCustomElDBXTree(AOwner) { }
	/* TCustomElDBXTree.Destroy */ inline __fastcall virtual ~THElXDBTree(void) { }
	
public:
	/* TCustomElXTree.CreateClass */ inline __fastcall THElXDBTree(System::Classes::TComponent* AOwner, Elxtree::TElXTreeItemClass ItemClass) : Eldbxtree::TCustomElDBXTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THElXDBTree(HWND ParentWindow) : Eldbxtree::TCustomElDBXTree(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION THElXDBTreeItem : public Eldbxtree::TElDBXTreeItem
{
	typedef Eldbxtree::TElDBXTreeItem inherited;
	
public:
	/* TElDBXTreeItem.Create */ inline __fastcall virtual THElXDBTreeItem(Elxtree::TCustomElXTree* AOwner) : Eldbxtree::TElDBXTreeItem(AOwner) { }
	/* TElDBXTreeItem.Destroy */ inline __fastcall virtual ~THElXDBTreeItem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElDBTreeNavButtonRole : unsigned char { tnbrFirstRootItem, tnbrFirst, tnbrPrior, tnbrNext, tnbrLast, tnbrLastRootItem, tnbrInsert, tnbrInsertChild, tnbrDelete, tnbrEdit, tnbrRefresh, tnbrCustom };

class PASCALIMPLEMENTATION TElDBTreeNavButton : public Eltoolbar::TCustomElToolButton
{
	typedef Eltoolbar::TCustomElToolButton inherited;
	
protected:
	TElDBTreeNavButtonRole FRole;
	bool FCustomAction;
	bool FUseCustomImages;
	void __fastcall SetRole(TElDBTreeNavButtonRole Value);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetDetails(void);
	void __fastcall FillStateForDetails(Vcl::Themes::TThemedElementDetails &ADetails);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetArrowDetails(void);
	virtual void __fastcall SetUseImageList(bool newValue);
	void __fastcall SetUseCustomImage(bool Value);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall SetImageIndex(int newValue);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	virtual void __fastcall AClick(bool Arrow);
	__fastcall virtual TElDBTreeNavButton(System::Classes::TComponent* AOwner);
	
__published:
	__property TElDBTreeNavButtonRole Role = {read=FRole, write=SetRole, default=11};
	__property bool UseCustomImage = {read=FUseCustomImages, write=SetUseCustomImage, default=0};
	__property Wrap = {default=0};
	__property LargeGlyph;
	__property NumLargeGlyphs = {default=1};
	__property Glyph;
	__property NumGlyphs = {default=1};
	__property OwnerSettings = {default=1};
	__property PullDownMenu;
	__property PopupPlace = {default=0};
	__property DisableAutoPopup = {default=0};
	__property Flat = {default=0};
	__property Layout = {default=0};
	__property Margin = {default=-1};
	__property Spacing = {default=4};
	__property UseArrow = {default=0};
	__property ShadowFollowsColor = {default=1};
	__property ShowGlyph = {default=1};
	__property ShowText = {default=1};
	__property OnArrowClick;
	__property Icon;
	__property TextDrawType = {default=0};
	__property ThinFrame = {default=0};
	__property DownSound = {default=0};
	__property UpSound = {default=0};
	__property ClickSound = {default=0};
	__property ArrowClickSound = {default=0};
	__property SoundMap;
	__property UseIcon = {default=0};
	__property ImageIndex = {default=-1};
	__property UseImageList = {default=0};
	__property OldStyled = {default=0};
	__property Background;
	__property DownBackground;
	__property BackgroundDrawBorder = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
	__property Enabled = {default=1};
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
	__property OnStartDrag;
	__property Action;
	__property Constraints;
	__property OnContextPopup;
	__property bool CustomAction = {read=FCustomAction, write=FCustomAction, default=0};
public:
	/* TCustomElToolButton.Destroy */ inline __fastcall virtual ~TElDBTreeNavButton(void) { }
	
};


class PASCALIMPLEMENTATION TElDBTreeNavigator : public Eltoolbar::TElToolBar
{
	typedef Eltoolbar::TElToolBar inherited;
	
private:
	System::UnicodeString FDeleteRecordQuestion;
	Eldbxtree::TCustomElDBXTree* FTree;
	Eldbxtree::TCustomElDBXTree* __fastcall GetTree(void);
	void __fastcall SetTree(Eldbxtree::TCustomElDBXTree* Value);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	
protected:
	bool FConfirmDelete;
	bool FIsToolbar;
	Vcl::Imglist::TCustomImageList* FIntImageList;
	virtual Eltoolbar::TElToolButtonClass __fastcall GetButtonClass(void);
	void __fastcall SetIsToolbar(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	void __fastcall CheckButtonsState(void);
	HIDESBASE MESSAGE void __fastcall CMControlChange(Vcl::Controls::TCMControlChange &Msg);
	void __fastcall ScrollTree(void);
	
public:
	__fastcall virtual TElDBTreeNavigator(System::Classes::TComponent* AOwner);
	TElDBTreeNavButton* __fastcall FindButtonByRole(TElDBTreeNavButtonRole Role);
	HIDESBASE TElDBTreeNavButton* __fastcall AddButton(TElDBTreeNavButtonRole Role);
	void __fastcall AddButtons(const TElDBTreeNavButtonRole *Roles, const int Roles_High);
	__fastcall virtual ~TElDBTreeNavigator(void);
	
__published:
	__property System::UnicodeString DeleteRecordQuestion = {read=FDeleteRecordQuestion, write=FDeleteRecordQuestion};
	__property Eldbxtree::TCustomElDBXTree* ElDBXTree = {read=GetTree, write=SetTree};
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property bool IsToolbar = {read=FIsToolbar, write=SetIsToolbar, default=0};
	__property BtnOffsHorz = {default=0};
	__property BtnOffsVert = {default=0};
	__property BevelOuter = {default=0};
	__property UseImageList = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBTreeNavigator(HWND ParentWindow) : Eltoolbar::TElToolBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::PResStringRec, 11> ElDBTreeNavButtonsHint;
}	/* namespace Eldbtreenavigator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBTREENAVIGATOR)
using namespace Eldbtreenavigator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbtreenavigatorHPP
