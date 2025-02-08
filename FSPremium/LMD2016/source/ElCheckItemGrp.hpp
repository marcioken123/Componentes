// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCheckItemGrp.pas' rev: 31.00 (Windows)

#ifndef ElcheckitemgrpHPP
#define ElcheckitemgrpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDObjectList.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <ElImgFrm.hpp>
#include <ElCheckCtl.hpp>
#include <ElGroupBox.hpp>
#include <ElSndMap.hpp>
#include <ElPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcheckitemgrp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCheckItemGroup;
class DELPHICLASS TCustomElRadioGroup;
class DELPHICLASS TElRadioGroup;
class DELPHICLASS TCustomElCheckGroup;
class DELPHICLASS TElCheckGroup;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TElCheckItemClass;

class PASCALIMPLEMENTATION TElCheckItemGroup : public Elgroupbox::TCustomElGroupBox
{
	typedef Elgroupbox::TCustomElGroupBox inherited;
	
protected:
	System::Classes::TAlignment FCheckAlignment;
	Lmdobjectlist::TLMDObjectList* FButtons;
	int FColumns;
	System::Classes::TStrings* FHints;
	System::Classes::TStrings* FItems;
	bool FReading;
	bool FUpdating;
	int FHorzOffset;
	int FItemHeight;
	int FItemSpacing;
	int FVertOffset;
	bool FEndEllipsis;
	virtual void __fastcall NotifyChildsThatRepaint(bool AllChilds = false);
	void __fastcall ArrangeButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall HintsChange(System::TObject* Sender);
	virtual void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetCheckAlignment(System::Classes::TLeftRight newValue);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	virtual void __fastcall SetFlat(bool newValue);
	void __fastcall SetHints(System::Classes::TStrings* Value);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	virtual void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* Value);
	virtual void __fastcall SetIsHTML(bool Value);
	virtual void __fastcall SetTransparent(bool newValue);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall IntCreateItem(void) = 0 ;
	virtual void __fastcall ButtonClick(System::TObject* Sender);
	virtual void __fastcall SetCheckSound(Elsndmap::TElSoundName Value);
	virtual void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	virtual void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	virtual void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	virtual void __fastcall SetSoundMap(Elsndmap::TElSoundMap* Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetUseImageList(bool Value);
	virtual void __fastcall SetCheckBoxChecked(bool Value);
	HIDESBASE void __fastcall SetFlatAlways(bool Value);
	virtual void __fastcall SetMoneyFlatInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetMoneyFlatActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetMoneyFlatDownColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetMoneyFlat(bool Value);
	bool __fastcall GetItemEnabled(int Index);
	void __fastcall SetItemEnabled(int Index, bool Value);
	void __fastcall SetHorzOffset(int Value);
	void __fastcall SetItemHeight(int Value);
	void __fastcall SetItemSpacing(int Value);
	void __fastcall SetVertOffset(int Value);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadAlignment(System::Classes::TReader* Reader);
	void __fastcall SetEndEllipsis(bool Value);
	__property System::Classes::TLeftRight CheckAlignment = {read=FCheckAlignment, write=SetCheckAlignment, default=1};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property System::Classes::TStrings* Hints = {read=FHints, write=SetHints};
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property int HorzOffset = {read=FHorzOffset, write=SetHorzOffset, default=0};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=-1};
	__property int ItemSpacing = {read=FItemSpacing, write=SetItemSpacing, default=-1};
	__property int VertOffset = {read=FVertOffset, write=SetVertOffset, default=0};
	__property bool EndEllipsis = {read=FEndEllipsis, write=SetEndEllipsis, default=0};
	
public:
	__fastcall virtual TElCheckItemGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCheckItemGroup(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCheckItemGroup(HWND ParentWindow) : Elgroupbox::TCustomElGroupBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElRadioGroup : public TElCheckItemGroup
{
	typedef TElCheckItemGroup inherited;
	
private:
	int FItemIndex;
	void __fastcall SetItemIndex(int Value);
	
protected:
	virtual void __fastcall IntCreateItem(void);
	virtual void __fastcall UpdateButtons(void);
	virtual void __fastcall ButtonClick(System::TObject* Sender);
	virtual void __fastcall ItemsChange(System::TObject* Sender);
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	
public:
	__fastcall virtual TCustomElRadioGroup(System::Classes::TComponent* AOwner);
public:
	/* TElCheckItemGroup.Destroy */ inline __fastcall virtual ~TCustomElRadioGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElRadioGroup(HWND ParentWindow) : TElCheckItemGroup(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElRadioGroup : public TCustomElRadioGroup
{
	typedef TCustomElRadioGroup inherited;
	
public:
	__property ItemEnabled;
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderSides = {default=15};
	__property Caption;
	__property CaptionColor = {default=536870911};
	__property CheckBoxChecked = {default=1};
	__property Color = {default=-16777201};
	__property Columns = {default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property EndEllipsis = {default=0};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property Font;
	__property Hints;
	__property HorzOffset = {default=0};
	__property ImageForm;
	__property IsHTML = {default=0};
	__property ItemIndex = {default=-1};
	__property Items;
	__property ItemHeight = {default=-1};
	__property ItemSpacing = {default=-1};
	__property MoneyFlat = {default=0};
	__property MoneyFlatInactiveColor;
	__property MoneyFlatActiveColor;
	__property MoneyFlatDownColor;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowCheckBox = {default=0};
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property VertOffset = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TransparentXPThemes = {default=1};
	__property CheckSound = {default=0};
	__property SoundMap;
	__property Glyph;
	__property Images;
	__property AlphaForImages;
	__property UseCustomGlyphs = {default=0};
	__property UseImageList = {default=0};
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnResize;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnContextPopup;
public:
	/* TCustomElRadioGroup.Create */ inline __fastcall virtual TElRadioGroup(System::Classes::TComponent* AOwner) : TCustomElRadioGroup(AOwner) { }
	
public:
	/* TElCheckItemGroup.Destroy */ inline __fastcall virtual ~TElRadioGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElRadioGroup(HWND ParentWindow) : TCustomElRadioGroup(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElCheckGroup : public TElCheckItemGroup
{
	typedef TElCheckItemGroup inherited;
	
private:
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, bool Value);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	void __fastcall SetState(int Index, Vcl::Stdctrls::TCheckBoxState Value);
	
protected:
	bool FAllowGrayed;
	void __fastcall SetAllowGrayed(bool Value);
	virtual void __fastcall IntCreateItem(void);
	
public:
	__fastcall virtual TCustomElCheckGroup(System::Classes::TComponent* AOwner);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property Vcl::Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	
__published:
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, default=1};
public:
	/* TElCheckItemGroup.Destroy */ inline __fastcall virtual ~TCustomElCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElCheckGroup(HWND ParentWindow) : TElCheckItemGroup(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElCheckGroup : public TCustomElCheckGroup
{
	typedef TCustomElCheckGroup inherited;
	
public:
	__property ItemEnabled;
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderSides = {default=15};
	__property Caption;
	__property CaptionColor = {default=536870911};
	__property CheckBoxChecked = {default=1};
	__property Color = {default=-16777201};
	__property Columns = {default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property EndEllipsis = {default=0};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property Font;
	__property Hints;
	__property HorzOffset = {default=0};
	__property ImageForm;
	__property IsHTML = {default=0};
	__property Items;
	__property ItemHeight = {default=-1};
	__property ItemSpacing = {default=-1};
	__property MoneyFlat = {default=0};
	__property MoneyFlatInactiveColor;
	__property MoneyFlatActiveColor;
	__property MoneyFlatDownColor;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowCheckBox = {default=0};
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TransparentXPThemes = {default=1};
	__property VertOffset = {default=0};
	__property CheckSound = {default=0};
	__property SoundMap;
	__property Glyph;
	__property Images;
	__property AlphaForImages;
	__property UseCustomGlyphs = {default=0};
	__property UseImageList = {default=0};
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnResize;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnContextPopup;
public:
	/* TCustomElCheckGroup.Create */ inline __fastcall virtual TElCheckGroup(System::Classes::TComponent* AOwner) : TCustomElCheckGroup(AOwner) { }
	
public:
	/* TElCheckItemGroup.Destroy */ inline __fastcall virtual ~TElCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCheckGroup(HWND ParentWindow) : TCustomElCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcheckitemgrp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCHECKITEMGRP)
using namespace Elcheckitemgrp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcheckitemgrpHPP
