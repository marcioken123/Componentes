// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTree.pas' rev: 31.00 (Windows)

#ifndef EltreeHPP
#define EltreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <System.Math.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.Imm.hpp>
#include <System.Variants.hpp>
#include <Winapi.ActiveX.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDUtils.hpp>
#include <LMDStrings.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDFiles.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDObjectList.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDGlyphs.hpp>
#include <LMDArray.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDGraph.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElHook.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHeader.hpp>
#include <ElSBCtrl.hpp>
#include <ElScrollBar.hpp>
#include <ElHintWnd.hpp>
#include <ElInputProcessor.hpp>
#include <ElIni.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElImgFrm.hpp>
#include <ElDragDrop.hpp>
#include <ElVCLUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCellControl;
class DELPHICLASS TElCellCheckBox;
class DELPHICLASS TElCellButtonGlyph;
class DELPHICLASS TElCellButton;
class DELPHICLASS TElCellProgressBar;
class DELPHICLASS TElCellStyle;
struct TElTreeItemStaticData;
class DELPHICLASS TElTreeItemStaticDataEx;
class DELPHICLASS TElTreeItem;
class DELPHICLASS TElTreeItems;
class DELPHICLASS TElTreeView;
class DELPHICLASS TCustomElTree;
class DELPHICLASS TElTree;
class DELPHICLASS TElTreeDragObject;
//-- type declarations -------------------------------------------------------
typedef System::Set<System::Int8, 1, 8> TSTIStates;

typedef void __fastcall (__closure *TInplaceEditorNeededEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);

class PASCALIMPLEMENTATION TElCellControl : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Vcl::Menus::TPopupMenu* FPopupMenu;
	TElCellStyle* FOwner;
	Lmdtypes::TLMDString FCaption;
	bool FVisible;
	bool FEnabled;
	System::Classes::TNotifyEvent FOnClick;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	System::Classes::TNotifyEvent FOnDblClick;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	Vcl::Graphics::TFont* FFont;
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	
protected:
	int FBorderWidth;
	virtual void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	virtual void __fastcall SetVisible(bool newValue);
	virtual void __fastcall SetEnabled(bool newValue);
	virtual void __fastcall TriggerClickEvent(void);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerDblClickEvent(void);
	virtual void __fastcall TriggerMouseMoveEvent(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetBorderWidth(int Value);
	virtual bool __fastcall PassClicks(void);
	
public:
	virtual void __fastcall Update(void);
	HIDESBASE virtual void __fastcall Assign(TElCellControl* Source);
	virtual void __fastcall Paint(TCustomElTree* Tree, TElTreeItem* Item, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect) = 0 ;
	__fastcall virtual TElCellControl(void);
	__fastcall virtual ~TElCellControl(void);
	
__published:
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property TElCellStyle* Owner = {read=FOwner};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class PASCALIMPLEMENTATION TElCellCheckBox : public TElCellControl
{
	typedef TElCellControl inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	Vcl::Stdctrls::TCheckBoxState FState;
	bool FAllowGrayed;
	void __fastcall SetState(Vcl::Stdctrls::TCheckBoxState newValue);
	void __fastcall SetAllowGrayed(bool newValue);
	bool __fastcall GetChecked(void);
	void __fastcall SetChecked(bool newValue);
	void __fastcall SetAlignment(System::Classes::TAlignment newValue);
	
protected:
	virtual void __fastcall TriggerClickEvent(void);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall Assign(TElCellControl* Source);
	__fastcall virtual TElCellCheckBox(void);
	__fastcall virtual ~TElCellCheckBox(void);
	virtual void __fastcall Paint(TCustomElTree* Tree, TElTreeItem* Item, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=SetState, nodefault};
	__property bool Checked = {read=GetChecked, write=SetChecked, nodefault};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, nodefault};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=1};
};


class PASCALIMPLEMENTATION TElCellButtonGlyph : public Lmdglyphs::TLMDButtonGlyph
{
	typedef Lmdglyphs::TLMDButtonGlyph inherited;
	
public:
	__property ImageList;
	__property ImageIndex = {default=-1};
	__property UseImageList;
public:
	/* TLMDButtonGlyph.Create */ inline __fastcall TElCellButtonGlyph(void) : Lmdglyphs::TLMDButtonGlyph() { }
	/* TLMDButtonGlyph.Destroy */ inline __fastcall virtual ~TElCellButtonGlyph(void) { }
	
};


class PASCALIMPLEMENTATION TElCellButton : public TElCellControl
{
	typedef TElCellControl inherited;
	
private:
	TElCellButtonGlyph* FGlyph;
	Vcl::Buttons::TButtonLayout FLayout;
	bool FFixClick;
	bool FDown;
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall SetDown(bool newValue);
	void __fastcall SetLayout(Vcl::Buttons::TButtonLayout newValue);
	bool __fastcall GetUseImageList(void);
	void __fastcall SetUseImageList(bool newValue);
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	int __fastcall GetImageIndex(void);
	void __fastcall SetImageIndex(int newValue);
	
protected:
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall Assign(TElCellControl* Source);
	__fastcall virtual TElCellButton(void);
	__fastcall virtual ~TElCellButton(void);
	virtual void __fastcall Paint(TCustomElTree* Tree, TElTreeItem* Item, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property bool UseImageList = {read=GetUseImageList, write=SetUseImageList, nodefault};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool FixClick = {read=FFixClick, write=FFixClick, nodefault};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
};


class PASCALIMPLEMENTATION TElCellProgressBar : public TElCellControl
{
	typedef TElCellControl inherited;
	
protected:
	int FMinValue;
	int FMaxValue;
	int FValue;
	System::Uitypes::TColor FBarColor;
	bool FShowProgressText;
	System::Classes::TAlignment FTextAlignment;
	System::Uitypes::TColor FFrameColor;
	System::Uitypes::TColor FColor;
	void __fastcall SetMinValue(int Value);
	void __fastcall SetMaxValue(int Value);
	void __fastcall SetValue(int Value);
	void __fastcall SetBarColor(System::Uitypes::TColor Value);
	void __fastcall SetShowProgressText(bool Value);
	void __fastcall SetTextAlignment(System::Classes::TAlignment Value);
	void __fastcall SetFrameColor(System::Uitypes::TColor Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	virtual bool __fastcall PassClicks(void);
	
public:
	__fastcall virtual TElCellProgressBar(void);
	__fastcall virtual ~TElCellProgressBar(void);
	virtual void __fastcall Assign(TElCellControl* Source);
	virtual void __fastcall Paint(TCustomElTree* Tree, TElTreeItem* Item, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property int MinValue = {read=FMinValue, write=SetMinValue, nodefault};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=100};
	__property int Value = {read=FValue, write=SetValue, nodefault};
	__property System::Uitypes::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777203};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=2};
	__property bool ShowProgressText = {read=FShowProgressText, write=SetShowProgressText, default=1};
	__property System::Uitypes::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777208};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777211};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCellStyle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FTag;
	TElTreeItem* FOwner;
	System::Uitypes::TColor FCellBkColor;
	System::Uitypes::TColor FTextBkColor;
	System::Uitypes::TColor FTextColor;
	unsigned FTextFlags;
	Vcl::Graphics::TBitmap* FPicture;
	Elheader::TElFieldType FCellType;
	Elheader::TElSectionStyle FStyle;
	bool FOwnerProps;
	int FFontSize;
	System::Uitypes::TFontStyles FFontStyles;
	System::Uitypes::TFontName FFontName;
	TElCellControl* FControl;
	bool FUseBkColor;
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
	void __fastcall SetControl(TElCellControl* newValue);
	void __fastcall SetFontSize(int newValue);
	void __fastcall SetFontStyles(System::Uitypes::TFontStyles newValue);
	void __fastcall SetFontName(System::Uitypes::TFontName newValue);
	void __fastcall SetOwnerColors(bool newValue);
	void __fastcall SetStyle(Elheader::TElSectionStyle newValue);
	void __fastcall SetCellBkColor(System::Uitypes::TColor newValue);
	void __fastcall SetTextBkColor(System::Uitypes::TColor newValue);
	void __fastcall SetTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetTextFlags(unsigned newValue);
	void __fastcall SetPicture(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetUseBkColor(bool Value);
	void __fastcall SetBorderStyle(Eltreeinplaceeditors::TElItemBorderStyle Value);
	
public:
	__fastcall TElCellStyle(TElTreeItem* Owner);
	__fastcall virtual ~TElCellStyle(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Update(void);
	__property TElTreeItem* Owner = {read=FOwner};
	
__published:
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property TElCellControl* Control = {read=FControl, write=SetControl};
	__property System::Uitypes::TColor CellBkColor = {read=FCellBkColor, write=SetCellBkColor, default=536870911};
	__property System::Uitypes::TColor TextBkColor = {read=FTextBkColor, write=SetTextBkColor, default=536870911};
	__property System::Uitypes::TColor TextColor = {read=FTextColor, write=SetTextColor, default=-16777208};
	__property unsigned TextFlags = {read=FTextFlags, write=SetTextFlags, default=34852};
	__property Vcl::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture};
	__property Elheader::TElFieldType CellType = {read=FCellType, write=FCellType, default=1};
	__property Elheader::TElSectionStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool OwnerProps = {read=FOwnerProps, write=SetOwnerColors, default=0};
	__property int FontSize = {read=FFontSize, write=SetFontSize, nodefault};
	__property System::Uitypes::TFontStyles FontStyles = {read=FFontStyles, write=SetFontStyles, nodefault};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFontName};
	__property bool UseBkColor = {read=FUseBkColor, write=SetUseBkColor, default=0};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TElTreeItemStaticData
{
public:
	Lmdtypes::TLMDString FText;
	System::Classes::TStringList* FColText;
	Lmdtypes::TLMDString FHint;
	TElCellStyle* FMainStyle;
	Lmdobjectlist::TLMDObjectList* FStyles;
};


typedef TElTreeItemStaticData *PElTreeItemStaticData;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeItemStaticDataEx : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElTreeItem* ItemRef;
	TSTIStates FState;
	
protected:
	int FBoolData1;
	System::Uitypes::TColor FBkColor;
	System::Uitypes::TColor FStrikedLineColor;
	System::Uitypes::TColor FBorderSpaceColor;
	int FIndentAdjust;
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
	System::Uitypes::TColor FColor;
	Eltreeinplaceeditors::TElCheckBoxType FCheckBoxType;
	Vcl::Stdctrls::TCheckBoxState FCheckBoxState;
	System::Uitypes::TColor FRowBkColor;
	int FImageIndex;
	int FStImageIndex;
	int FImageIndex2;
	int FStImageIndex2;
	int FOverlayIndex;
	int FOverlayIndex2;
	int __fastcall GetImage(int Index);
	void __fastcall SetImage(int Index, int Value);
	bool __fastcall GetBoolFlag(int Index);
	bool __fastcall GetState(int Index);
	void __fastcall SetBoolFlag(int Index, bool Value);
	void __fastcall SetState(int Index, bool Value);
	void __fastcall Assign(TElTreeItemStaticDataEx* Source);
	
public:
	__property System::Uitypes::TColor StrikedLineColor = {read=FStrikedLineColor, write=FStrikedLineColor, nodefault};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property System::Uitypes::TColor BorderSpaceColor = {read=FBorderSpaceColor, write=FBorderSpaceColor, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState CheckBoxState = {read=FCheckBoxState, write=FCheckBoxState, nodefault};
	__property Eltreeinplaceeditors::TElCheckBoxType CheckBoxType = {read=FCheckBoxType, write=FCheckBoxType, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, nodefault};
	__property int ImageIndex = {read=GetImage, write=SetImage, index=0, nodefault};
	__property int ImageIndex2 = {read=GetImage, write=SetImage, index=1, nodefault};
	__property int IndentAdjust = {read=FIndentAdjust, write=FIndentAdjust, nodefault};
	__property int OverlayIndex = {read=GetImage, write=SetImage, index=4, nodefault};
	__property int OverlayIndex2 = {read=GetImage, write=SetImage, index=5, nodefault};
	__property System::Uitypes::TColor RowBkColor = {read=FRowBkColor, write=FRowBkColor, nodefault};
	__property int StImageIndex = {read=GetImage, write=SetImage, index=2, nodefault};
	__property int StImageIndex2 = {read=GetImage, write=SetImage, index=3, nodefault};
	__property bool Cut = {read=GetState, write=SetState, index=3, nodefault};
	__property bool Bold = {read=GetState, write=SetState, index=5, nodefault};
	__property bool Underlined = {read=GetState, write=SetState, index=4, nodefault};
	__property bool Italic = {read=GetState, write=SetState, index=6, nodefault};
	__property bool Strikeout = {read=GetState, write=SetState, index=8, nodefault};
	__property bool ParentColors = {read=GetBoolFlag, write=SetBoolFlag, index=1, nodefault};
	__property bool ParentFontStyle = {read=GetBoolFlag, write=SetBoolFlag, index=2, nodefault};
	__property bool SuppressLines = {read=GetBoolFlag, write=SetBoolFlag, index=3, nodefault};
	__property bool ForceButtons = {read=GetBoolFlag, write=SetBoolFlag, index=6, nodefault};
	__property bool StrikedOutLine = {read=GetBoolFlag, write=SetBoolFlag, index=7, nodefault};
	__property bool DrawHLine = {read=GetBoolFlag, write=SetBoolFlag, index=8, nodefault};
	__property bool AllowEdit = {read=GetBoolFlag, write=SetBoolFlag, index=10, nodefault};
	__property bool UseBkColor = {read=GetBoolFlag, write=SetBoolFlag, index=11, nodefault};
	__property bool UseStyles = {read=GetBoolFlag, write=SetBoolFlag, index=13, nodefault};
	__property bool Enabled = {read=GetBoolFlag, write=SetBoolFlag, index=16, nodefault};
	__property bool SuppressButtons = {read=GetBoolFlag, write=SetBoolFlag, index=17, nodefault};
	__property bool CheckBoxEnabled = {read=GetBoolFlag, write=SetBoolFlag, index=18, nodefault};
	__property bool ShowCheckBox = {read=GetBoolFlag, write=SetBoolFlag, index=19, nodefault};
	__property bool HintIsHTML = {read=GetBoolFlag, write=SetBoolFlag, index=23, nodefault};
public:
	/* TObject.Create */ inline __fastcall TElTreeItemStaticDataEx(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TElTreeItemStaticDataEx(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeItem : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	void __fastcall IterateProc(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall InvalidateItemPart(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	
protected:
	Lmdhtmlunit::TLMDHTMLData* FHTMLData;
	Lmdarray::TLMDArray* FHTMLDataArray;
	void *FData;
	int FTag;
	System::TObject* FObject;
	System::_di_IInterface FDataInterface;
	void *FSortData;
	int FSortType;
	int FSortRef;
	TElTreeItemStaticData *FStaticData;
	TElTreeItemStaticDataEx* FStaticDataEx;
	unsigned FComplexHeight;
	System::Types::TRect FTextRect;
	Lmdobjectlist::TLMDObjectList* FChildren;
	TCustomElTree* FOwner;
	TElTreeItems* FList;
	int FBoolData;
	TElTreeItem* FParent;
	TElTreeItem* FRoot;
	Lmdtypes::TLMDString __fastcall GetText(void);
	virtual Lmdtypes::TLMDString __fastcall GetHint(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	void __fastcall SetBorderStyle(Eltreeinplaceeditors::TElItemBorderStyle Value);
	TElTreeItem* __fastcall GetParent(void);
	int __fastcall GetLevel(void);
	void __fastcall SetColor(int Index, System::Uitypes::TColor value);
	void __fastcall SetUseBkColor(bool newValue);
	bool __fastcall GetHasChildren(void);
	bool __fastcall GetHasVisibleChildren(void);
	void __fastcall SetExpanded(bool value);
	void __fastcall SetParentColors(bool value);
	void __fastcall SetParentStyle(bool value);
	int __fastcall GetIndex(void);
	int __fastcall GetAbsIndex(void);
	int __fastcall GetVisIndex(void);
	int __fastcall GetChildIndex(TElTreeItem* Child);
	bool __fastcall IsExpanded(void);
	bool __fastcall GetFullExpand(void);
	void __fastcall MakeFullyExpanded(bool value);
	void __fastcall OnColTextChange(System::TObject* Sender);
	void __fastcall SetImageIndex(int Index, int value);
	void __fastcall SetForceButtons(bool newValue);
	int __fastcall GetChildrenCount(void);
	int __fastcall GetCount(void);
	TElTreeItem* __fastcall GetItems(int Index);
	void __fastcall SetUseStyles(bool newValue);
	void __fastcall OnStyleDelete(System::TObject* Sender, void * &Item);
	TElCellStyle* __fastcall GetStyles(int index);
	void __fastcall SetStyles(int index, TElCellStyle* newValue);
	int __fastcall GetStylesCount(void);
	void __fastcall SetCheckBoxState(Vcl::Stdctrls::TCheckBoxState newValue);
	void __fastcall SetChecked(bool newValue);
	bool __fastcall GetChecked(void);
	void __fastcall SetShowCheckBox(bool newValue);
	void __fastcall SetCheckBoxType(Eltreeinplaceeditors::TElCheckBoxType newValue);
	void __fastcall SetCheckBoxEnabled(bool newValue);
	void __fastcall SetSuppressButtons(bool newValue);
	void __fastcall SetEnabled(bool newValue);
	void __fastcall SetHidden(bool newValue);
	bool __fastcall GetFullyVisible(void);
	void __fastcall SetFullyVisible(bool newValue);
	bool __fastcall GetSelected(void);
	void __fastcall SetSelected(bool newValue);
	void __fastcall CreateStyles(void);
	void __fastcall SetOwnerHeight(bool newValue);
	void __fastcall SetHeight(int newValue);
	int __fastcall GetHeight(void);
	void __fastcall SetSuppressLines(bool newValue);
	void __fastcall UpdateItem(void);
	virtual void __fastcall SetText(Lmdtypes::TLMDString Value);
	bool __fastcall GetState(int index);
	void __fastcall SetState(int index, bool value);
	void __fastcall RemoveChild(TElTreeItem* Child);
	void __fastcall RemoveSubChild(TElTreeItem* Child);
	void __fastcall DeleteChild(TElTreeItem* Child);
	int __fastcall AddChild(TElTreeItem* Child);
	void __fastcall AddExistingChild(TElTreeItem* Child);
	int __fastcall AddLastChild(TElTreeItem* Child);
	int __fastcall InsertChild(int index, TElTreeItem* Child);
	void __fastcall ExchangeItems(int I, int J);
	void __fastcall QuickSort(bool recursive, int L, int R, Elheader::TElSSortMode SM, Eltreeinplaceeditors::TSortTypes SortType, int FSortSection);
	void __fastcall AddSortData(Eltreeinplaceeditors::TSortTypes SortType, int FSortSection);
	void __fastcall ReleaseSortData(void);
	void __fastcall NormalizeSorts(int StartIdx);
	bool __fastcall GetOwnerHeight(void);
	virtual void __fastcall SetMultiline(bool newValue);
	void __fastcall SetIsHTML(bool newValue);
	void __fastcall OnHTMLDataDestroy(System::TObject* Sender, void * Item);
	TElTreeItem* __fastcall GetAncestor(void);
	void __fastcall SetStrikedOutLine(const bool Value);
	bool __fastcall GetStrikedOutLine(void);
	void __fastcall SetDrawHLine(const bool Value);
	void __fastcall SetAllowEdit(const bool Value);
	int __fastcall CalcSubItemsHeight(void);
	void __fastcall NewStaticData(void);
	void __fastcall DisposeStaticData(void);
	void __fastcall FillStaticData(void);
	System::Classes::TStrings* __fastcall GetColText(void);
	bool __fastcall GetParentStyle(void);
	TElCellStyle* __fastcall GetMainStyle(void);
	bool __fastcall GetUseStyles(void);
	bool __fastcall GetUseBkColor(void);
	bool __fastcall GetParentColors(void);
	bool __fastcall GetDrawHLine(void);
	bool __fastcall GetAllowEdit(void);
	bool __fastcall GetForceButtons(void);
	bool __fastcall GetSuppressButtons(void);
	bool __fastcall GetSuppressLines(void);
	bool __fastcall GetIsHTML(void);
	bool __fastcall GetMultiline(void);
	bool __fastcall GetShowCheckBox(void);
	bool __fastcall GetCheckBoxEnabled(void);
	bool __fastcall GetEnabled(void);
	bool __fastcall GetHidden(void);
	void __fastcall SetIndentAdjust(int Value);
	bool __fastcall GetDropTarget(void);
	bool __fastcall GetHintIsHTML(void);
	void __fastcall SetHintIsHTML(bool Value);
	void __fastcall ClearSubChild(void);
	int __fastcall GetTextDim(int Index);
	void __fastcall SetIndex(int Value);
	void __fastcall NewStaticDataEx(void);
	void __fastcall DisposeStaticDataEx(void);
	System::Uitypes::TColor __fastcall GetColor(int Index);
	int __fastcall GetImageIndex(int Index);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetCheckBoxState(void);
	Eltreeinplaceeditors::TElCheckBoxType __fastcall GetCheckBoxType(void);
	int __fastcall GetIndentAdjust(void);
	Eltreeinplaceeditors::TElItemBorderStyle __fastcall GetBorderStyle(void);
	bool __fastcall GetFocused(void);
	void __fastcall SetFocused(bool Value);
	void __fastcall UpdateChangedMainText(void);
	void __fastcall UpdateChangedCellText(void);
	void __fastcall NewVirtualSort(void);
	void __fastcall SetWordWrap(bool Value);
	bool __fastcall GetWordWrap(void);
	bool __fastcall GetWholeLine(void);
	void __fastcall SetWholeLine(bool Value);
	
public:
	__fastcall virtual TElTreeItem(TCustomElTree* AOwner);
	__fastcall virtual ~TElTreeItem(void);
	virtual void __fastcall ReRenderMainText(void);
	virtual void __fastcall ReRenderAllTexts(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	bool __fastcall IsUnder(TElTreeItem* Item);
	Lmdtypes::TLMDString __fastcall GetFullName(Lmdtypes::TLMDString separator);
	Lmdtypes::TLMDString __fastcall GetFullNameEx(Lmdtypes::TLMDString separator, bool AddRoot);
	void __fastcall Expand(bool recursive);
	void __fastcall Collapse(bool recursive);
	void __fastcall Sort(bool recursive);
	void __fastcall MoveTo(TElTreeItem* NewParent);
	void __fastcall MoveToIns(TElTreeItem* NewParent, int AnIndex);
	void __fastcall Clear(void);
	TElTreeItem* __fastcall GetFirstVisibleChild(void);
	TElTreeItem* __fastcall GetFirstChild(void);
	TElTreeItem* __fastcall GetLastChild(void);
	TElTreeItem* __fastcall GetNextChild(TElTreeItem* Child);
	TElTreeItem* __fastcall GetPrevChild(TElTreeItem* Child);
	TElTreeItem* __fastcall GetFirstSibling(void);
	TElTreeItem* __fastcall GetLastSibling(void);
	TElTreeItem* __fastcall GetNextSibling(void);
	TElTreeItem* __fastcall GetPrevSibling(void);
	TElTreeItem* __fastcall GetLastSubItem(void);
	TElTreeItem* __fastcall GetChildByIndex(int index);
	void __fastcall EditText(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Delete(void);
	__property TCustomElTree* TreeView = {read=FOwner};
	bool __fastcall IsVisible(void);
	TElTreeItem* __fastcall GetNextVisible(void);
	TElTreeItem* __fastcall GetPrevVisible(void);
	virtual TElTreeItem* __fastcall GetPrev(void);
	virtual TElTreeItem* __fastcall GetNext(void);
	virtual void __fastcall MoveToItem(TElTreeItem* Item, Eltreeinplaceeditors::TNodeAttachMode Mode);
	virtual TElCellStyle* __fastcall AddStyle(void);
	virtual void __fastcall RemoveStyle(TElCellStyle* Style);
	void __fastcall RedrawItem(bool DoCheck);
	void __fastcall RedrawItemPart(bool DoCheck, int Left, int Right);
	System::Types::TRect __fastcall DisplayRect(bool TextOnly);
	void __fastcall EndEdit(bool ByCancel);
	void __fastcall RecalcHeight(void);
	bool __fastcall HasAsParent(TElTreeItem* Item);
	int __fastcall IndexOf(TElTreeItem* Item);
	void __fastcall MakeVisible(void);
	void __fastcall UpdateInfo(Eltreeinplaceeditors::TElVirtPropTypes PropTypes);
	virtual void __fastcall AllocateStorage(int MaxItems);
	bool __fastcall IsFirstChild(void);
	bool __fastcall IsLastChild(void);
	__property int TextLeft = {read=GetTextDim, index=0, nodefault};
	__property int TextRight = {read=GetTextDim, index=2, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property System::_di_IInterface DataInterface = {read=FDataInterface, write=FDataInterface};
	__property TCustomElTree* Owner = {read=FOwner};
	__property TElTreeItem* Parent = {read=GetParent, write=MoveTo};
	__property bool HasVisibleChildren = {read=GetHasVisibleChildren, nodefault};
	__property bool HasChildren = {read=GetHasChildren, nodefault};
	__property int Index = {read=GetIndex, write=SetIndex, nodefault};
	__property int AbsoluteIndex = {read=GetAbsIndex, nodefault};
	__property int VisIndex = {read=GetVisIndex, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property int ChildrenCount = {read=GetChildrenCount, nodefault};
	__property TElTreeItem* Children[int Index] = {read=GetItems};
	__property TElTreeItem* Item[int Index] = {read=GetItems};
	__property int Level = {read=GetLevel, nodefault};
	__property TElCellStyle* Styles[int index] = {read=GetStyles, write=SetStyles};
	__property TElTreeItem* Ancestor = {read=GetAncestor};
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	__property System::Classes::TStrings* SubItems = {read=GetColText};
	__property bool DropTarget = {read=GetDropTarget, nodefault};
	__property System::Types::TRect TextRect = {read=FTextRect, write=FTextRect};
	
__published:
	__property System::TObject* AnObject = {read=FObject, write=FObject, stored=false};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool Focused = {read=GetFocused, write=SetFocused, stored=false, nodefault};
	__property bool Expanded = {read=IsExpanded, write=SetExpanded, nodefault};
	__property bool FullyExpanded = {read=GetFullExpand, write=MakeFullyExpanded, nodefault};
	__property bool WholeLine = {read=GetWholeLine, write=SetWholeLine, default=0};
	__property bool StrikedOutLine = {read=GetStrikedOutLine, write=SetStrikedOutLine, nodefault};
	__property System::Uitypes::TColor StrikedLineColor = {read=GetColor, write=SetColor, index=5, nodefault};
	__property bool DrawHLine = {read=GetDrawHLine, write=SetDrawHLine, nodefault};
	__property bool AllowEdit = {read=GetAllowEdit, write=SetAllowEdit, nodefault};
	__property bool Cut = {read=GetState, write=SetState, index=3, nodefault};
	__property bool Underlined = {read=GetState, write=SetState, index=4, nodefault};
	__property bool Bold = {read=GetState, write=SetState, index=5, nodefault};
	__property bool Italic = {read=GetState, write=SetState, index=6, nodefault};
	__property bool StrikeOut = {read=GetState, write=SetState, index=8, nodefault};
	__property bool ParentFontStyle = {read=GetParentStyle, write=SetParentStyle, nodefault};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property Lmdtypes::TLMDString Caption = {read=GetText, write=SetText, stored=false};
	__property System::Classes::TStrings* ColumnText = {read=GetColText};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, index=1, nodefault};
	__property System::Uitypes::TColor BkColor = {read=GetColor, write=SetColor, index=2, nodefault};
	__property bool UseBkColor = {read=GetUseBkColor, write=SetUseBkColor, nodefault};
	__property bool ParentColors = {read=GetParentColors, write=SetParentColors, nodefault};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, index=0, default=-1};
	__property int StateImageIndex = {read=GetImageIndex, write=SetImageIndex, index=2, default=-1};
	__property int ImageIndex2 = {read=GetImageIndex, write=SetImageIndex, index=1, default=-1};
	__property int StateImageIndex2 = {read=GetImageIndex, write=SetImageIndex, index=3, default=-1};
	__property int OverlayIndex = {read=GetImageIndex, write=SetImageIndex, index=4, default=-1};
	__property int OverlayIndex2 = {read=GetImageIndex, write=SetImageIndex, index=5, default=-1};
	__property bool ForceButtons = {read=GetForceButtons, write=SetForceButtons, default=0};
	__property bool SuppressButtons = {read=GetSuppressButtons, write=SetSuppressButtons, default=0};
	__property bool SuppressLines = {read=GetSuppressLines, write=SetSuppressLines, nodefault};
	__property Lmdtypes::TLMDString Hint = {read=GetHint, write=SetHint};
	__property bool UseStyles = {read=GetUseStyles, write=SetUseStyles, nodefault};
	__property TElCellStyle* MainStyle = {read=GetMainStyle};
	__property int StylesCount = {read=GetStylesCount, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState CheckBoxState = {read=GetCheckBoxState, write=SetCheckBoxState, default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property bool ShowCheckBox = {read=GetShowCheckBox, write=SetShowCheckBox, default=1};
	__property Eltreeinplaceeditors::TElCheckBoxType CheckBoxType = {read=GetCheckBoxType, write=SetCheckBoxType, default=0};
	__property bool CheckBoxEnabled = {read=GetCheckBoxEnabled, write=SetCheckBoxEnabled, nodefault};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, default=1};
	__property bool Hidden = {read=GetHidden, write=SetHidden, nodefault};
	__property bool FullyVisible = {read=GetFullyVisible, write=SetFullyVisible, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property bool OwnerHeight = {read=GetOwnerHeight, write=SetOwnerHeight, nodefault};
	__property bool Multiline = {read=GetMultiline, write=SetMultiline, nodefault};
	__property System::Uitypes::TColor RowBkColor = {read=GetColor, write=SetColor, index=3, nodefault};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, nodefault};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=GetBorderStyle, write=SetBorderStyle, nodefault};
	__property int IndentAdjust = {read=GetIndentAdjust, write=SetIndentAdjust, nodefault};
	__property bool HintIsHTML = {read=GetHintIsHTML, write=SetHintIsHTML, nodefault};
	__property System::Uitypes::TColor BorderSpaceColor = {read=GetColor, write=SetColor, index=4, default=-16777211};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
};

#pragma pack(pop)

typedef System::TMetaClass* TElTreeItemClass;

typedef bool __fastcall (*TElLookupCompareProc)(TElTreeItem* Item, void * SearchDetails);

typedef bool __fastcall (__closure *TElLookupCompareMethod)(TElTreeItem* Item, void * SearchDetails);

typedef void __fastcall (*TElIterateProc)(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);

typedef void __fastcall (__closure *TElIterateMethod)(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeItems : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TElTreeItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	void __fastcall IntFind(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntFind1(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntFind3(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntFind4(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	
protected:
	TCustomElTree* FOwner;
	TElTreeItem* FRoot;
	TElTreeItemClass FItemClass;
	int __fastcall GetVisCount(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual TElTreeItem* __fastcall CreateItem(TCustomElTree* FOwner);
	int __fastcall GetCount(void);
	int __fastcall GetRootCount(void);
	TElTreeItem* __fastcall GetRootItem(int Index);
	TElTreeItem* __fastcall GetItem(int index);
	TElTreeItem* __fastcall GetVisItem(int index);
	virtual void __fastcall Init(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TElTreeItems(TCustomElTree* AOwner);
	__fastcall TElTreeItems(TCustomElTree* AOwner, TElTreeItemClass ItemClass);
	__fastcall virtual ~TElTreeItems(void);
	void __fastcall AddExistingItem(TElTreeItem* Item, TElTreeItem* Parent);
	void __fastcall InsertExistingItem(TElTreeItem* Item, TElTreeItem* Parent, int Index);
	void __fastcall RemoveItem(TElTreeItem* Child);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(Lmdtypes::TLMDString FileName);
	void __fastcall LoadFromFile(Lmdtypes::TLMDString FileName);
	void __fastcall SaveToStringList(System::Classes::TStrings* AStrings);
	void __fastcall LoadFromStringList(System::Classes::TStrings* Strings);
	void __fastcall LoadFromWideStringList(System::Classes::TStrings* Strings);
	void __fastcall SaveToWideStringList(System::Classes::TStrings* AStrings);
	void __fastcall DeleteItem(TElTreeItem* Child);
	int __fastcall GetAbsIndex(TElTreeItem* Child);
	int __fastcall GetVisIndex(TElTreeItem* Child);
	TElTreeItem* __fastcall AddItem(TElTreeItem* Parent);
	TElTreeItem* __fastcall AddLastItem(TElTreeItem* Parent);
	void __fastcall SetItem(int Index, TElTreeItem* Value);
	TElTreeItem* __fastcall InsertItem(int Index, TElTreeItem* Parent);
	void __fastcall AllocateStorage(int MaxItems);
	void __fastcall AllocateStorageInRoot(int MaxItems);
	virtual TElTreeItem* __fastcall Add(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall AddChild(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall AddChildFirst(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall AddChildObject(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElTreeItem* __fastcall AddChildObjectFirst(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElTreeItem* __fastcall AddFirst(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall AddObject(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElTreeItem* __fastcall AddObjectFirst(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElTreeItem* __fastcall Insert(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall InsertObject(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual TElTreeItem* __fastcall InsertAfter(TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual TElTreeItem* __fastcall InsertAfterObject(TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	TElTreeItem* __fastcall InsertItemFromString(int Index, Lmdtypes::TLMDString AString);
	virtual void __fastcall Delete(TElTreeItem* Item);
	TElTreeItem* __fastcall GetFirstNode(void);
	void __fastcall Clear(void);
	void __fastcall IterateBranch(bool VisibleOnly, TElIterateProc IterateProc, void * IterateData, TElTreeItem* BranchParent)/* overload */;
	void __fastcall IterateFrom(bool VisibleOnly, bool CheckCollapsed, TElIterateProc IterateProc, void * IterateData, TElTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBackFrom(bool VisibleOnly, bool CheckCollapsed, TElIterateProc IterateProc, void * IterateData, TElTreeItem* StartFrom)/* overload */;
	void __fastcall Iterate(bool VisibleOnly, bool CheckCollapsed, TElIterateProc IterateProc, void * IterateData)/* overload */;
	void __fastcall IterateBack(bool VisibleOnly, bool CheckCollapsed, TElIterateProc IterateProc, void * IterateData)/* overload */;
	void __fastcall Iterate(bool VisibleOnly, bool CheckCollapsed, TElIterateMethod IterateMethod, void * IterateData)/* overload */;
	void __fastcall IterateBack(bool VisibleOnly, bool CheckCollapsed, TElIterateMethod IterateMethod, void * IterateData)/* overload */;
	void __fastcall IterateFrom(bool VisibleOnly, bool CheckCollapsed, TElIterateMethod IterateMethod, void * IterateData, TElTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBackFrom(bool VisibleOnly, bool CheckCollapsed, TElIterateMethod IterateMethod, void * IterateData, TElTreeItem* StartFrom)/* overload */;
	void __fastcall IterateBranch(bool VisibleOnly, TElIterateMethod IterateMethod, void * IterateData, TElTreeItem* BranchParent)/* overload */;
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	TElTreeItem* __fastcall LookForItem(TElTreeItem* StartItem, Lmdtypes::TLMDString TextToFind, void * DataToFind, int ColumnNum, bool LookForData, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool NoCase);
	TElTreeItem* __fastcall LookForItem2(TElTreeItem* StartItem, Lmdtypes::TLMDString TextToFind, bool WholeTextOnly, void * DataToFind, int ColumnNum, bool LookForData, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, bool NoCase);
	TElTreeItem* __fastcall LookForItemEx(TElTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, void * SearchDetails, TElLookupCompareProc CompareProc);
	TElTreeItem* __fastcall LookBackForItemEx2(TElTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElLookupCompareProc CompareProc);
	TElTreeItem* __fastcall LookForItemEx2(TElTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElLookupCompareProc CompareProc)/* overload */;
	TElTreeItem* __fastcall LookForItemEx2(TElTreeItem* StartItem, int ColumnNum, bool CheckStartItem, bool SubItemsOnly, bool VisibleOnly, bool CheckCollapsed, void * SearchDetails, TElLookupCompareMethod CompareMethod)/* overload */;
	__property TElTreeItemClass ItemClass = {read=FItemClass, write=FItemClass};
	__property TCustomElTree* Owner = {read=FOwner};
	__property TElTreeItem* Item[int Index] = {read=GetItem/*, default*/};
	__property TElTreeItem* ItemAsVis[int Index] = {read=GetVisItem};
	__property int Count = {read=GetCount, nodefault};
	__property int VisCount = {read=GetVisCount, nodefault};
	__property int RootCount = {read=GetRootCount, nodefault};
	__property TElTreeItem* RootItem[int Index] = {read=GetRootItem};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TOleDragStartEvent)(System::TObject* Sender, _di_IDataObject &dataObj, _di_IDropSource &dropSource, Eldragdrop::TDragTypes &dwOKEffects);

typedef void __fastcall (__closure *TOleDragFinishEvent)(System::TObject* Sender, Eldragdrop::TDragType dwEffect, HRESULT Result);

typedef void __fastcall (__closure *TMeasureItemPartEvent)(System::TObject* Sender, TElTreeItem* Item, int PartIndex, System::Types::TPoint &Size);

typedef void __fastcall (__closure *THeaderSectionEvent)(System::TObject* Sender, Elheader::TElHeaderSection* Section);

typedef void __fastcall (__closure *TOnItemDrawEvent)(System::TObject* Sender, TElTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);

typedef void __fastcall (__closure *TOnShowHintEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text, Vcl::Controls::THintWindow* HintWindow, const System::Types::TPoint &MousePos, bool &DoShowHint);

typedef void __fastcall (__closure *TApplyVisFilterEvent)(System::TObject* Sender, TElTreeItem* Item, bool &Hidden);

typedef void __fastcall (__closure *TTuneUpInplaceEditEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, Vcl::Stdctrls::TCustomEdit* Editor);

typedef void __fastcall (__closure *TOnItemExpandEvent)(System::TObject* Sender, TElTreeItem* Item);

typedef void __fastcall (__closure *TOnItemCheckedEvent)(System::TObject* Sender, TElTreeItem* Item);

typedef void __fastcall (__closure *TItemSelChangeEvent)(System::TObject* Sender, TElTreeItem* Item);

typedef void __fastcall (__closure *TOnItemChangeEvent)(System::TObject* Sender, TElTreeItem* Item, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);

typedef void __fastcall (__closure *TOnCompareItems)(System::TObject* Sender, TElTreeItem* Item1, TElTreeItem* Item2, int &res);

typedef void __fastcall (__closure *TOnItemExpanding)(System::TObject* Sender, TElTreeItem* Item, bool &CanProcess);

typedef void __fastcall (__closure *TOnPicDrawEvent)(System::TObject* Sender, TElTreeItem* Item, int &ImageIndex);

typedef void __fastcall (__closure *THotTrackEvent)(System::TObject* Sender, TElTreeItem* OldItem, TElTreeItem* NewItem);

typedef void __fastcall (__closure *TOnValidateEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section, System::UnicodeString &Text, bool &Accept);

typedef void __fastcall (__closure *TOnEndEditEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section, bool Canceled);

typedef void __fastcall (__closure *TTryEditEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);

typedef void __fastcall (__closure *TEditRequestEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section);

typedef void __fastcall (__closure *TComboEditShowEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combobox);

typedef void __fastcall (__closure *TValidateComboEvent)(System::TObject* Sender, TElTreeItem* Item, Elheader::TElHeaderSection* Section, Vcl::Stdctrls::TComboBox* Combo, bool &Accept);

typedef void __fastcall (__closure *TElScrollEvent)(System::TObject* Sender, Vcl::Forms::TScrollBarKind ScrollBarKind, int ScrollCode);

typedef void __fastcall (__closure *TElColumnMoveEvent)(TCustomElTree* Sender, Elheader::TElHeaderSection* Section, int OldPos, int NewPos);

typedef void __fastcall (__closure *TElItemSaveEvent)(System::TObject* Sender, System::Classes::TStream* Stream, TElTreeItem* Item);

typedef void __fastcall (__closure *TElCellStyleSaveEvent)(System::TObject* Sender, System::Classes::TStream* Stream, TElCellStyle* Style);

typedef void __fastcall (__closure *TElTreeChangingEvent)(System::TObject* Sender, TElTreeItem* Item, bool &AllowChange);

typedef void __fastcall (__closure *TElTreeItemPostDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, TElTreeItem* Item, const System::Types::TRect &ItemRect, bool &DrawFocusRect);

typedef void __fastcall (__closure *TElTreeItemDragTargetEvent)(System::TObject* Sender, TElTreeItem* Item, const System::Types::TRect &ItemRect, int X, int Y);

typedef void __fastcall (__closure *TElCanDragEvent)(System::TObject* Sender, TElTreeItem* Item, bool &CanDrag);

typedef void __fastcall (__closure *TVirtualTextNeededEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);

typedef void __fastcall (__closure *TVirtualHintNeededEvent)(System::TObject* Sender, TElTreeItem* Item, Lmdtypes::TLMDString &Hint);

typedef void __fastcall (__closure *TVirtualValueNeededEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);

typedef void __fastcall (__closure *TVirtualPropsNeededEvent)(System::TObject* Sender, TElTreeItem* Item, Eltreeinplaceeditors::TElVirtPropTypes PropTypes, TElTreeItemStaticDataEx* Value);

typedef void __fastcall (__closure *TVirtualStyleNeededEvent)(System::TObject* Sender, TElTreeItem* Item, int SectionIndex, TElCellStyle* Style);

class PASCALIMPLEMENTATION TElTreeView : public Eltreeinplaceeditors::TElTreeViewAncestor
{
	typedef Eltreeinplaceeditors::TElTreeViewAncestor inherited;
	
private:
	void __fastcall IntVis0(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntNextVis(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntPgVis(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	void __fastcall IntPrevVis(TElTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData, TCustomElTree* Tree);
	
protected:
	Elheader::TElHeader* FHeader;
	TCustomElTree* FOwner;
	TElTreeItems* FItems;
	TElCellStyle* VirtStyle;
	Vcl::Extctrls::TTimer* FHintTimer;
	Elhintwnd::TElHintWindow* FHintWnd;
	System::Types::TPoint FHintCoord;
	TElTreeItem* FHintItem;
	TElTreeItem* FHintItemEx;
	int FHintHCol;
	TElCanDragEvent FOnCanDrag;
	bool FPainting;
	bool FClearVis;
	bool FClearAll;
	bool FVisUpdated;
	bool FRangeUpdate;
	int FHRange;
	System::Types::TPoint FPressCoord;
	bool FPressed;
	bool FMouseSel;
	System::Types::TPoint FClickCoord;
	bool FClicked;
	TElCellControl* FClickControl;
	bool FIgnoreClick;
	bool FIgnoreClick2;
	bool FClickPassed;
	TElTreeItem* FPassedItem;
	System::Classes::TShiftState FPassedShift;
	int FClickSection;
	TElTreeItem* FClickItem;
	TElTreeItem* FTrackItem;
	TElTreeItem* FEditingItem;
	TElTreeItem* FFocused;
	TElTreeItem* FSelected;
	TElTreeItem* FDropTrg;
	TElTreeItem* FMFSStartItem;
	System::Types::TPoint FMFSStartCoord;
	TElTreeItem* FMFSEndItem;
	System::Types::TPoint FMFSendCoord;
	Lmdobjectlist::TLMDObjectList* FMFSList;
	TElTreeItem* FClickedItem;
	Lmdobjectlist::TLMDObjectList* FVisible;
	bool FOverColors;
	bool FRowOvColors;
	Vcl::Extctrls::TTimer* FDragScrollTimer;
	Vcl::Extctrls::TTimer* FDragExpandTimer;
	bool FDropAcc;
	bool FInDragging;
	int FDDY;
	Vcl::Controls::TImageList* FDragImages;
	Eltreeinplaceeditors::TElTreeInplaceEditor* FInpEdit;
	Elheader::TElFieldType FEditType;
	int FEditSect;
	Vcl::Extctrls::TTimer* FEditTimer;
	TElTreeItem* FItemToEdit;
	bool FEndEditWhenDestroy;
	bool FOldHide;
	Vcl::Menus::TPopupMenu* FFakePopup;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Vcl::Graphics::TBitmap* FTmpBmp;
	Elinputprocessor::TElKeyboardInput* Input;
	System::Classes::TThread* SearchTextTimeoutThread;
	bool FScrollFirstClick;
	bool FHasFocus;
	void __fastcall StartClearSearchTimeoutThread(void);
	void __fastcall StopClearSearchTimeoutThread(void);
	void __fastcall SearchTextTimeout(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	void __fastcall RedoTmpBmp(void);
	virtual void __fastcall RedrawTree(Vcl::Graphics::TCanvas* ACanvas, int RealLeftPos, Lmdobjectlist::TLMDObjectList* ItemsList);
	void __fastcall DrawImages(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R, System::Types::TRect &ItemRect);
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, System::Types::TRect &R);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, System::Types::TRect &R);
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, System::Types::TRect &R);
	void __fastcall DrawButtons(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, bool IsNode, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R, System::Types::TRect &ItemRect);
	void __fastcall DrawCheckBoxes(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R, System::Types::TRect &ItemRect);
	void __fastcall DrawItemLines(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, System::Types::TRect &R, System::Types::TRect &ItemRect);
	void __fastcall DoRedrawItem(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, const System::Types::TRect &ItemRect, const System::Types::TRect &SurfRect);
	void __fastcall DoRedrawItemTree(Vcl::Graphics::TCanvas* ACanvas, Vcl::Graphics::TBitmap* HelperBitmap, TElTreeItem* Item, const System::Types::TRect &ItemRect, const System::Types::TRect &SurfRect);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	void __fastcall DoPaintBkgnd(HDC DC, const System::Types::TRect &ClipRect);
	void __fastcall UpdateView(void);
	void __fastcall TryStartHint(int XPos, int YPos);
	void __fastcall OnHintTimer(System::TObject* Sender);
	void __fastcall DoHideLineHint(void);
	void __fastcall DoShowLineHint(TElTreeItem* Item, Elheader::TElHeaderSection* Section);
	Lmdtypes::TLMDString __fastcall GetHintText(TElTreeItem* Item, Elheader::TElHeaderSection* &Section);
	int __fastcall CalcPageUpPos(int CurIdx);
	int __fastcall CalcPageDownPos(int CurIdx);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDblClk(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMIMEComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMIMEStartComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMDeadChar(Winapi::Messages::TWMKey &Message);
	bool __fastcall IntLButtonDown(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntLButtonUp(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall IntRButtonDown(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntRButtonUp(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntLButtonDblClick(int X, int Y, System::Classes::TShiftState Shift);
	bool __fastcall IntRButtonDblClick(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall IntMouseMove(int X, int Y, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Vcl::Controls::TCMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Msg);
	void __fastcall SetHPosition(int value);
	void __fastcall SetVPosition(int value);
	void __fastcall DoSetTopIndex(int Value);
	void __fastcall OnHScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall OnVScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall FillVisFwd(int StartIndex);
	void __fastcall DefineHRange(void);
	virtual int __fastcall GetVisCount(void);
	int __fastcall GetVisiblesHeight(void);
	void __fastcall OnEditTimer(System::TObject* Sender);
	virtual void __fastcall DoEditItem(TElTreeItem* Item, int SectionNum);
	virtual void __fastcall DoEndEdit(bool ByCancel);
	virtual void __fastcall EditOperationCancelled(void);
	virtual void __fastcall EditOperationAccepted(void);
	void __fastcall FillDragImage(void);
	virtual void __fastcall DoCanDrag(TElTreeItem* Item, bool &CanDrag);
	DYNAMIC void __fastcall DoStartDrag(Vcl::Controls::TDragObject* &DragObject);
	virtual void __fastcall DoDragOver(Vcl::Controls::TDragObject* Source, int X, int Y, bool CanDrop);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMDrag(Vcl::Controls::TCMDrag &Message);
	virtual bool __fastcall DragScroll(Vcl::Controls::TDragObject* Source, int X, int Y);
	void __fastcall OnScrollTimer(System::TObject* Sender);
	void __fastcall OnDragExpandTimer(System::TObject* Sender);
	void __fastcall OnDropTargetDrag(System::TObject* Sender, System::Uitypes::TDragState State, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	void __fastcall OnDropTargetDrop(System::TObject* Sender, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual System::Types::TRect __fastcall GetItemRect(int ItemIndex);
	virtual TElTreeItem* __fastcall GetItemAtY(int Y);
	virtual TElTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall NeedToFoxusItemInMouseDown(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall ProcessPassedClick(void);
	void __fastcall FitMostChildren(TElTreeItem* Item);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWindowHandle(void);
	void __fastcall DoSetSelected(TElTreeItem* value);
	virtual int __fastcall GetVisCount2(void);
	void __fastcall DrawMouseSelectFrame(void);
	void __fastcall AllocateMouseSelectFrame(void);
	void __fastcall DeallocateMouseSelectFrame(void);
	void __fastcall SelectMouseSelectItems(void);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	void __fastcall CancelMouseSel(void);
	MESSAGE void __fastcall CMDeactivate(Winapi::Messages::TWMNoParams &Message);
	virtual TElTreeItem* __fastcall FindNewFocused(System::Word Key, System::PInteger PVal1, bool &Sel)/* overload */;
	virtual TElTreeItem* __fastcall FindNewFocused(System::Word Key, bool &Sel)/* overload */;
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall InitiateEditOp(TElTreeItem* Item, int HCol, bool Immediate);
	bool __fastcall IsControlCell(TElTreeItem* Item, int SectionIndex);
	void __fastcall DrawCellImage(Vcl::Graphics::TCanvas* ACanvas, TElTreeItem* Item, int ImageIndex, int SectionIndex, Vcl::Graphics::TBitmap* HelperBitmap, System::Types::TRect &R);
	virtual void __fastcall DoPerformSearch(Lmdtypes::TLMDString SearchText);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	
public:
	__fastcall virtual TElTreeView(System::Classes::TComponent* Owner);
	__fastcall virtual ~TElTreeView(void);
	virtual void __fastcall SetFocus(void);
	virtual Vcl::Controls::TDragImageList* __fastcall GetDragImages(void);
	__property DragCursor = {default=-12};
	__property TCustomElTree* Owner = {read=FOwner};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeView(HWND ParentWindow) : Eltreeinplaceeditors::TElTreeViewAncestor(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElTree : public Eltreeinplaceeditors::TElTreeAncestor
{
	typedef Eltreeinplaceeditors::TElTreeAncestor inherited;
	
private:
	bool __fastcall IntCompare(TElTreeItem* Item, void * SearchDetails);
	void __fastcall SetMultilineEllipsis(const bool Value);
	void __fastcall SetSinglelineEllipsis(const bool Value);
	
protected:
	bool FUseThemeForSelection;
	System::Uitypes::TColor FStripedOddColor;
	System::Uitypes::TColor FStripedEvenColor;
	bool FStripedItems;
	TVirtualStyleNeededEvent FOnVirtualStyleNeeded;
	System::Classes::TNotifyEvent FOnBeginUpdate;
	System::Classes::TNotifyEvent FOnEndUpdate;
	Lmdobjectlist::TLMDObjectList* FSortSections;
	TVirtualTextNeededEvent FOnVirtualTextNeeded;
	Eltreeinplaceeditors::TVirtualityLevel FVirtualityLevel;
	TVirtualHintNeededEvent FOnVirtualHintNeeded;
	TVirtualValueNeededEvent FOnVirtualValueNeeded;
	TVirtualPropsNeededEvent FOnVirtualPropsNeeded;
	Eltreeinplaceeditors::TLineHintType FLineHintType;
	int FLineHintTimeout;
	int FFireFocusEvents;
	bool FTransButtons;
	bool FTransCheckBoxes;
	System::Uitypes::TColor FTrackColor;
	bool FExpandOnDragOver;
	System::Uitypes::TScrollStyle FForcedScrollBars;
	bool FMoveFocusOnCollapse;
	int FHeaderHeight;
	Elsbctrl::TElScrollHintNeededEvent FOnVertScrollHintNeeded;
	Elsbctrl::TElScrollDrawPartEvent FOnHorzScrollDrawPart;
	Elsbctrl::TElScrollHintNeededEvent FOnHorzScrollHintNeeded;
	Elsbctrl::TElScrollDrawPartEvent FOnVertScrollDrawPart;
	Elsbctrl::TElScrollHitTestEvent FOnVertScrollHitTest;
	TElTreeChangingEvent FOnChanging;
	Vcl::Controls::TBevelKind FBevelKindDummy;
	Eltreeinplaceeditors::TElHintType FHintType;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	Vcl::Controls::TDragDropEvent FOnDrop;
	Vcl::Controls::TDragOverEvent FOnOver;
	Vcl::Controls::TEndDragEvent FOnDrag;
	System::Classes::TNotifyEvent FOnEnter;
	System::Classes::TNotifyEvent FOnExit;
	Vcl::Controls::TKeyEvent FOnKeyDown;
	Vcl::Controls::TKeyPressEvent FOnKeyPress;
	Vcl::Controls::TKeyEvent FOnKeyUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TStartDragEvent FOnStartDrag;
	TOnItemExpandEvent FOnItemPreDraw;
	TElTreeItemDragTargetEvent FOnDragTargetChange;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	int FGradientSteps;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FRowHotTrack;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectTextColor;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	bool FAdjustMultilineHeight;
	bool FFlatFocusedScrollbars;
	bool FAutoResizeColumns;
	bool FHideFocusRect;
	bool FShowEmptyImages;
	bool FShowEmptyImages2;
	bool FShowRootButtons;
	bool FUnderlineTracked;
	bool FCustomCheckboxes;
	Vcl::Graphics::TBitmap* FCheckBoxGlyph;
	Vcl::Graphics::TBitmap* FRadioButtonGlyph;
	bool FFilteredVisibility;
	TApplyVisFilterEvent FOnApplyVisFilter;
	bool FRightAlignedText;
	bool FFlat;
	bool FRightAlignedView;
	System::WideChar FPathSeparator;
	Vcl::Graphics::TPenStyle FLinesStyle;
	System::Uitypes::TColor FLinesColor;
	bool FDeselectChildrenOnCollapse;
	bool FDrawFocusRect;
	bool FBarStyle;
	bool FNotRaiseForBarStyle;
	bool FAlwaysKeepFocus;
	bool FAlwaysKeepSelection;
	bool FFullRowSelect;
	Eltreeinplaceeditors::TElDragType FDragType;
	bool FMouseOver;
	Eldragdrop::TElDropTarget* FDropTarget;
	Vcl::Controls::TDragObject* FDragObject;
	bool FAutoLookup;
	int FSelectColumn;
	bool FAutoExpand;
	Vcl::Graphics::TBitmap* FLeafPicture;
	Vcl::Graphics::TBitmap* FPlusPicture;
	Vcl::Graphics::TBitmap* FMinusPicture;
	bool FCustomPlusMinus;
	bool FShowHeader;
	bool FShowCheckboxes;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elini::TElIniFile* FStorage;
	System::UnicodeString FStoragePath;
	Eltreeinplaceeditors::TDragImgMode FDragImageMode;
	bool FHideHorzScrollBar;
	bool FHideVertScrollBar;
	bool FHideHintOnMove;
	int FSortSection;
	Eltreeinplaceeditors::TSortModes FSortMode;
	Eltreeinplaceeditors::TSortTypes FSortType;
	bool FDragAllowed;
	System::Uitypes::TColor FBkColor;
	System::Uitypes::TColor FTextColor;
	bool FShowButtons;
	bool FShowLines;
	bool FShowImages;
	bool FShowRoot;
	System::Uitypes::TColor FLineHintColor;
	Eltreeinplaceeditors::THintModes FShowHintMode;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	bool FCanEdit;
	bool FIgnoreSBChange;
	bool FScrollbarsInitialized;
	bool FSortRequired;
	bool FProcUpdate;
	bool FUpdated;
	int FInSorting;
	bool FBSVLines;
	Lmdobjectlist::TLMDObjectList* FAllList;
	Lmdobjectlist::TLMDObjectList* FSelectedList;
	bool FVertScrollTracking;
	bool FHorzScrollTracking;
	bool FTracking;
	bool FHeaderHotTrack;
	bool FODFollowCol;
	Lmdtypes::TLMDString FODMask;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FImages2;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Vcl::Imglist::TCustomImageList* FAlphaImages2;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	int FTopIndex;
	int FBottomIndex;
	bool FChStateImage;
	Lmdtypes::TLMDString FRealHint;
	Lmdtypes::TLMDString FHint;
	int FMainTreeCol;
	bool FMultiSelect;
	int FMultiSelectLevel;
	bool FRowSelect;
	bool FHideSelect;
	int FLineHeight;
	bool FAutoLineHeight;
	int ItemExt;
	bool FUseCustomBars;
	int FHPos;
	bool FVScrollVisible;
	bool FHScrollVisible;
	Eltreeinplaceeditors::TSTSelModes FSelMode;
	Eltreeinplaceeditors::TSortDirs FSortDir;
	bool FSelChange;
	bool FColSizeUpdate;
	bool FUpdating;
	int FUpdateCount;
	bool FHintHide;
	bool FUseSystemHintColors;
	bool IgnoreResize;
	System::Uitypes::TColor FCurBkColor;
	System::Uitypes::TColor FCurTextColor;
	bool FDelOnEdit;
	bool FAutoSizingColumns;
	TElTreeItems* FItems;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnColumnResize;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnColumnClick;
	Elheader::TElSectionRedrawEvent FOnColumnDraw;
	TOnItemChangeEvent FOnItemChange;
	TOnItemDrawEvent FOnItemDraw;
	TOnItemCheckedEvent FOnItemChecked;
	TOnItemExpandEvent FOnItemExpand;
	TOnItemExpandEvent FOnItemCollapse;
	TOnItemExpanding FOnItemExpanding;
	TOnItemExpanding FOnItemCollapsing;
	TOnItemExpandEvent FOnItemDelete;
	System::Classes::TNotifyEvent FOnItemFocused;
	TElTreeItemPostDrawEvent FOnItemPostDraw;
	TOnShowHintEvent FOnShowHint;
	TOnCompareItems FOnCompareItems;
	TOnPicDrawEvent FOnItemPicDraw;
	TOnPicDrawEvent FOnItemPicDraw2;
	THotTrackEvent FOnHotTrack;
	TElScrollEvent FOnScroll;
	TElItemSaveEvent FOnItemSave;
	TElItemSaveEvent FOnItemLoad;
	TTryEditEvent FOnTryEdit;
	TOnEndEditEvent FOnEndEdit;
	TElColumnMoveEvent FOnHeaderColumnMove;
	TElCellStyleSaveEvent FOnSave;
	TElCellStyleSaveEvent FOnLoad;
	TItemSelChangeEvent FOnItemSelectedChange;
	Elheader::TElHeaderLookupEvent FOnHeaderLookup;
	Elheader::TElHeaderLookupDoneEvent FOnHeaderLookupDone;
	System::Classes::TNotifyEvent FOnHeaderResize;
	THeaderSectionEvent FOnHeaderSectionExpand;
	THeaderSectionEvent FOnHeaderSectionCollapse;
	Elheader::TMeasureSectionEvent FOnHeaderSectionMeasure;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnSectionAutoSize;
	Eltreeinplaceeditors::TColumnNotifyEvent FOnSectionFilterCall;
	TMeasureItemPartEvent FOnMeasureItemPart;
	System::Classes::TNotifyEvent FOnSortBegin;
	System::Classes::TNotifyEvent FOnSortEnd;
	Vcl::Controls::TKeyEvent FOnEditKeyDown;
	TOleDragFinishEvent FOnOleDragFinish;
	TOleDragStartEvent FOnOleDragStart;
	Eldragdrop::TTargetDragEvent FOnOleTargetDrag;
	Eldragdrop::TTargetDropEvent FOnOleTargetDrop;
	int TotalHiddenCount;
	int TotalVisCount;
	int TotalVarHeightCount;
	TElTreeView* FView;
	Elheader::TElHeader* FHeader;
	Elscrollbar::TElScrollBar* FHScrollBar;
	Elscrollbar::TElScrollBar* FVScrollBar;
	Elscrollbar::TElScrollBarStyles* FHorzScrollBarStyle;
	Elscrollbar::TElScrollBarStyles* FVertScrollBarStyle;
	int SavedHH;
	Vcl::Extctrls::TTimer* FDelayTimer;
	TElTreeItem* FDelayedItem;
	int FDragExpandDelay;
	int FChangeDelay;
	Eltreeinplaceeditors::TDragTargetDraw FDragTrgDrawMode;
	Vcl::Controls::TMouseEvent FOnHeaderMouseDown;
	System::Classes::TNotifyEvent FOnAfterSelectionChange;
	System::Uitypes::TColor FDragRectAcceptColor;
	System::Uitypes::TColor FDragRectDenyColor;
	int FIncrementalSearchTimeout;
	bool FIncrementalSearch;
	bool FRightClickSelect;
	bool FScrollbarOpposite;
	bool FVerticalLinesLong;
	Lmdgraph::TLMDBorderSides FBorderSides;
	TInplaceEditorNeededEvent FOnInplaceEditorNeeded;
	System::Uitypes::TCursor FCursor;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeededEx;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLLinkOverEvent FOnLinkOver;
	System::Uitypes::TCursor FLinkCursor;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TFontStyles FLinkStyle;
	bool FQuickEditMode;
	Elheader::TElFieldType FMainTextType;
	Elsbctrl::TElScrollHitTestEvent FOnHorzScrollHitTest;
	bool FMouseFrameVisible;
	bool FMouseFrameSelect;
	System::Uitypes::TColor FVertDivLinesColor;
	System::Uitypes::TColor FHorzDivLinesColor;
	int FDragScrollInterval;
	bool FShowLeafButton;
	int FCheckBoxSize;
	bool FIgnoreEnabled;
	int FInplaceEditorDelay;
	Vcl::Graphics::TFont* FHeaderFont;
	bool FHeaderUseTreeFont;
	bool FKeepSelectionWithinLevel;
	bool FAutoCollapse;
	bool FIgnoreResizes;
	bool FSortUseCase;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Eltreeinplaceeditors::TElDblClickMode FDblClickMode;
	bool FDoubleBuffered;
	bool FDoubleBufferedOnResize;
	bool InSizeMove;
	Elhook::TElHook* FHook;
	int FHighlightAlphaLevel;
	Lmdobjectlist::TLMDObjectList* FDataCache;
	int FDataCacheSize;
	bool FLastWasDown;
	int FSortSectionToCompare;
	Eltreeinplaceeditors::TElIncSearchScope FIncrementalSearchScope;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	Eltreeinplaceeditors::TElIncSearchColumn FIncrementalSearchColumn;
	bool FCheckBoxFlat;
	bool FHorzArrowsScroll;
	System::Uitypes::TColor FSortColumnColor;
	bool FSinglelineEllipsis;
	bool FMultilineEllipsis;
	void __fastcall SetUseThemeForSelection(const bool Value);
	bool __fastcall IsVistaSelNeed(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	void __fastcall SetStripedOddColor(System::Uitypes::TColor Value);
	void __fastcall SetStripedEvenColor(System::Uitypes::TColor Value);
	void __fastcall SetStripedItems(bool Value);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerImageNeededExEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef, int X, int Y);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetVirtualityLevel(Eltreeinplaceeditors::TVirtualityLevel Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	int __fastcall GetDefaultSectionWidth(void);
	void __fastcall SetDefaultSectionWidth(int Value);
	void __fastcall OnHeaderSectionResize(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	void __fastcall OnHeaderSectionClick(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	virtual void __fastcall OnHeaderSectionDelete(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	void __fastcall DoHeaderMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnHeaderSectionLookup(System::TObject* Sender, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text);
	void __fastcall OnHeaderSectionLookupDone(System::TObject* Sender, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	void __fastcall OnHeaderExpand(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall OnHeaderCollapse(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall OnHeaderSectionVisChange(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall HeaderSectionAutoSizeHandler(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall SectionAutoSizeTransfer(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall SectionFilterCallTransfer(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section);
	void __fastcall DoHeaderResize(System::TObject* Sender);
	virtual void __fastcall OnFontChange(System::TObject* Sender);
	bool __fastcall IsHeaderFontStored(void);
	HIDESBASE bool __fastcall IsFontStored(void);
	void __fastcall OnSignChange(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	TElCanDragEvent __fastcall GetCanDrag(void);
	void __fastcall SetCanDrag(const TElCanDragEvent Value);
	TElTreeItem* __fastcall GetDropTarget(void);
	virtual Eltreeinplaceeditors::TElTreeViewAncestor* __fastcall GetTreeViewAncestor(void);
	virtual System::UnicodeString __fastcall GetAlignmentOnSection(int SectionIndex);
	void __fastcall SetTextColor(System::Uitypes::TColor value);
	void __fastcall SetBkColor(System::Uitypes::TColor value);
	bool __fastcall GetHeaderWrapCaptions(void);
	void __fastcall SetHeaderWrapCaptions(bool Value);
	void __fastcall SetHeaderHotTrack(bool value);
	void __fastcall SetHeaderHeight(int value);
	void __fastcall SetShowEmptyImages(bool newValue);
	void __fastcall SetShowEmptyImages2(bool newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetImages2(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetAlphaImages2(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetLineHintTimeout(int Value);
	void __fastcall SetLineStyle(bool Value);
	void __fastcall SetRootStyle(bool Value);
	void __fastcall SetImagesStyle(bool Value);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetButtonStyle(bool Value);
	void __fastcall SetUpdating(bool value);
	bool __fastcall GetUpdating(void);
	void __fastcall SetHLines(bool value);
	void __fastcall SetVLines(bool value);
	void __fastcall SetBSVLines(bool value);
	void __fastcall SetRowSelect(bool value);
	void __fastcall SetMultiSelectLevel(int Value);
	void __fastcall SetMultiSelect(bool value);
	void __fastcall SetFocused(TElTreeItem* value);
	void __fastcall SetHideSelect(bool value);
	void __fastcall SetAutoExpand(bool value);
	void __fastcall SetMoveFocusOnCollapse(bool value);
	Elheader::TElHeaderSections* __fastcall GetHeaderSections(void);
	void __fastcall SetHeaderSections(Elheader::TElHeaderSections* value);
	void __fastcall SetChStateImage(bool value);
	void __fastcall SetUseStdBars(bool value);
	void __fastcall SetItemIndent(int value);
	void __fastcall SetLineHeight(int value);
	void __fastcall SetAutoLineHeight(bool value);
	int __fastcall GetHeaderHeight(void);
	void __fastcall SetMainTreeCol(int value);
	void __fastcall SetItems(TElTreeItems* value);
	int __fastcall GetTotalVisCount(void);
	bool __fastcall GetDraggableSections(void);
	void __fastcall SetDraggableSections(bool newValue);
	void __fastcall SetSortMode(Eltreeinplaceeditors::TSortModes newValue);
	void __fastcall SetSortSection(int newValue);
	bool __fastcall GetMoveColumnOnDrag(void);
	void __fastcall SetMoveColumnOnDrag(bool newValue);
	void __fastcall SetHideHorzScrollBar(bool newValue);
	void __fastcall SetHideVertScrollBar(bool newValue);
	Vcl::Imglist::TCustomImageList* __fastcall GetHeaderImages(void);
	void __fastcall SetHeaderImages(Vcl::Imglist::TCustomImageList* newValue);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaHeaderImages(void);
	void __fastcall SetAlphaHeaderImages(Vcl::Imglist::TCustomImageList* newValue);
	bool __fastcall GetFireFocusEvents(void);
	void __fastcall SetFireFocusEvents(bool Value);
	void __fastcall SetScrollbarOpposite(bool Value);
	void __fastcall SetVerticalLinesLong(bool Value);
	int __fastcall GetSelCount(void);
	TElTreeItem* __fastcall GetSelected(void);
	TElTreeItem* __fastcall GetFocused(void);
	void __fastcall SetSelected(TElTreeItem* newValue);
	void __fastcall SetStorage(Elini::TElIniFile* newValue);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetHeaderImageForm(Elimgfrm::TElImageForm* newValue);
	Elimgfrm::TElImageForm* __fastcall GetHeaderImageForm(void);
	void __fastcall SetShowCheckboxes(bool newValue);
	void __fastcall SetPlusPicture(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetMinusPicture(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetCustomPlusMinus(bool newValue);
	void __fastcall SetSelectColumn(int newValue);
	void __fastcall SetDragType(Eltreeinplaceeditors::TElDragType newValue);
	void __fastcall HeaderResizeTransfer(System::TObject* Sender);
	void __fastcall HeaderResizeHandler(System::TObject* Sender);
	bool __fastcall GetStickyHeaderSections(void);
	void __fastcall SetStickyHeaderSections(bool newValue);
	void __fastcall SetBarStyle(bool newValue);
	void __fastcall SetDrawFocusRect(bool newValue);
	void __fastcall SetLinesColor(System::Uitypes::TColor newValue);
	void __fastcall SetHorzDivLinesColor(System::Uitypes::TColor newValue);
	void __fastcall SetLinesStyle(Vcl::Graphics::TPenStyle newValue);
	void __fastcall SetRightAlignedView(bool newValue);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetRightAlignedText(bool newValue);
	void __fastcall SetFilteredVisibility(bool newValue);
	void __fastcall SetUnderlineTracked(bool newValue);
	void __fastcall SetCustomCheckboxes(bool newValue);
	void __fastcall SetCheckBoxGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetRadioButtonGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetShowRootButtons(bool newValue);
	void __fastcall SetHideFocusRect(bool newValue);
	bool __fastcall GetLockHeaderHeight(void);
	void __fastcall SetLockHeaderHeight(bool newValue);
	void __fastcall SetTransButtons(bool newValue);
	void __fastcall UpdateFrame(void);
	void __fastcall SetHeaderActiveFilterColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetHeaderActiveFilterColor(void);
	void __fastcall SetHeaderFilterColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetHeaderFilterColor(void);
	void __fastcall SetHeaderFlat(bool newValue);
	bool __fastcall GetHeaderFlat(void);
	void __fastcall DrawFlatBorder(bool HorzTracking, bool VertTracking);
	void __fastcall DrawFlatBorderEx(HDC DC, bool HorzTracking, bool VertTracking);
	void __fastcall ReRenderAllHTMLItems(void);
	void __fastcall SetFlatFocusedScrollbars(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall BackgroundChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMNCHITTEST(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	MESSAGE void __fastcall WMEnable(Winapi::Messages::TWMEnable &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSysColorChange(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall IFMCanPaintBkgnd(Winapi::Messages::TMessage &Message);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetRowHotTrack(bool newValue);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall SetHPosition(int value);
	void __fastcall SetVPosition(int value);
	virtual void __fastcall ClickTransfer(System::TObject* Sender);
	virtual void __fastcall DblClickTransfer(System::TObject* Sender);
	virtual void __fastcall DropTransfer(System::TObject* Sender, System::TObject* Source, int X, int Y);
	virtual void __fastcall OverTransfer(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	virtual void __fastcall DragTransfer(System::TObject* Sender, System::TObject* Target, int X, int Y);
	virtual void __fastcall EnterTransfer(System::TObject* Sender);
	virtual void __fastcall ExitTransfer(System::TObject* Sender);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyPressTransfer(System::TObject* Sender, System::WideChar &Key);
	virtual void __fastcall KeyUpTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall MouseDownTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseMoveTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseUpTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall StartDragTransfer(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	virtual void __fastcall MeasureSectionTransfer(System::TObject* Sender, Elheader::TElHeaderSection* Section, System::Types::TPoint &Size);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	System::Uitypes::TCursor __fastcall GetCursor(void);
	int __fastcall SetScrollInfo(HWND hWnd, int BarFlag, const tagSCROLLINFO &ScrollInfo, System::LongBool Redraw);
	System::LongBool __fastcall GetScrollInfo(HWND hWnd, int BarFlag, tagSCROLLINFO &ScrollInfo);
	void __fastcall SetHorzScrollBarStyle(Elscrollbar::TElScrollBarStyles* newValue);
	void __fastcall SetVertScrollBarStyle(Elscrollbar::TElScrollBarStyles* newValue);
	void __fastcall HorzScrollDrawPartTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall HorzScrollHintNeededTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall VertScrollDrawPartTransfer(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, Elsbctrl::TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall VertScrollHintNeededHandler(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall VertScrollHintNeededTransfer(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);
	bool __fastcall GetHeaderInvertSortArrows(void);
	void __fastcall SetHeaderInvertSortArrows(bool newValue);
	void __fastcall SBChanged(System::TObject* Sender);
	void __fastcall ScrollBarMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetForcedScrollBars(System::Uitypes::TScrollStyle newValue);
	System::Uitypes::TCursor __fastcall GetDragCursor(void);
	void __fastcall SetDragCursor(System::Uitypes::TCursor Value);
	void __fastcall SetTrackColor(System::Uitypes::TColor value);
	Elheader::TElHeaderSection* __fastcall GetLockedHeaderSection(void);
	void __fastcall SetLockedHeaderSection(Elheader::TElHeaderSection* newValue);
	virtual void __fastcall SetAdjustMultilineHeight(bool newValue);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall AlignPieces(void);
	virtual TElTreeItem* __fastcall GetRoot(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall CompareItems(TElTreeItem* Item1, TElTreeItem* Item2, Elheader::TElSSortMode SM, Eltreeinplaceeditors::TSortTypes ST, int FSortSection);
	virtual void __fastcall SetCanEdit(bool value);
	virtual void __fastcall SetShowHeader(bool value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall Resize(void);
	virtual int __fastcall DoGetPicture(TElTreeItem* Item);
	virtual int __fastcall DoGetPicture2(TElTreeItem* Item);
	virtual int __fastcall DefineLineHeight(void);
	virtual void __fastcall UpdateScrollBars(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual TElTreeItems* __fastcall CreateItems(void);
	virtual TElTreeItems* __fastcall CreateItemsExt(TElTreeItemClass ItemClass);
	virtual Elheader::TElHeader* __fastcall CreateHeader(void);
	bool __fastcall DoSetFocused(TElTreeItem* value, bool Forced);
	bool __fastcall DoSetFocusedEx(TElTreeItem* value, bool Forced, bool Delayed);
	virtual void __fastcall SetHeaderColor(System::Uitypes::TColor newValue);
	virtual System::Uitypes::TColor __fastcall GetHeaderColor(void);
	Lmdtypes::TLMDString __fastcall GetHint(void);
	void __fastcall SetHint(Lmdtypes::TLMDString newValue);
	virtual void __fastcall DoChanging(TElTreeItem* Item, bool &AllowChange);
	virtual void __fastcall DoOnColumnResize(int SectionIndex);
	virtual void __fastcall DoColumnClick(int SectionIndex);
	virtual void __fastcall DoItemFocused(void);
	virtual void __fastcall DoBeginUpdate(void);
	virtual void __fastcall DoEndUpdate(void);
	virtual void __fastcall DoItemDraw(TElTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);
	virtual void __fastcall DoItemChange(TElTreeItem* Item, Eltreeinplaceeditors::TItemChangeMode ItemChangeMode);
	virtual void __fastcall DoItemExpanding(TElTreeItem* Item, bool &CanProcess);
	virtual void __fastcall DoItemCollapsing(TElTreeItem* Item, bool &CanProcess);
	virtual void __fastcall DoItemChecked(TElTreeItem* Item);
	virtual void __fastcall DoItemExpand(TElTreeItem* Item);
	virtual void __fastcall DoItemCollapse(TElTreeItem* Item);
	virtual void __fastcall DoItemDelete(TElTreeItem* Item);
	virtual void __fastcall DoCompareItems(TElTreeItem* Item1, TElTreeItem* Item2, int &res);
	virtual void __fastcall DoHeaderDraw(Elheader::TCustomElHeader* Header, Vcl::Graphics::TCanvas* Canvas, Elheader::TElHeaderSection* Section, const System::Types::TRect &Rect, bool Pressed);
	virtual void __fastcall OnHeaderSectionChange(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section, Elheader::TSectionChangeMode Change);
	virtual void __fastcall OnHeaderSectionMove(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section, int OldPos, int NewPos);
	virtual void __fastcall TriggerHotTrackEvent(TElTreeItem* OldItem, TElTreeItem* NewItem);
	virtual void __fastcall TriggerScrollEvent(Vcl::Forms::TScrollBarKind ScrollBarKind, int ScrollCode);
	virtual void __fastcall TriggerHeaderColumnMoveEvent(Elheader::TElHeaderSection* Section, int OldPos, int NewPos);
	virtual void __fastcall TriggerItemSaveEvent(System::Classes::TStream* Stream, TElTreeItem* Item);
	virtual void __fastcall TriggerItemLoadEvent(System::Classes::TStream* Stream, TElTreeItem* Item);
	virtual void __fastcall TriggerItemSelectedChangeEvent(TElTreeItem* Item);
	virtual void __fastcall DoShowHint(TElTreeItem* Item, Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text, Vcl::Controls::THintWindow* HintWindow, const System::Types::TPoint &MousePos, bool &DoShowHint);
	virtual void __fastcall Paint(void);
	virtual void __fastcall OnHeaderSectionCreate(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	virtual void __fastcall TriggerHeaderLookupEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerHeaderLookupDoneEvent(Elheader::TElHeaderSection* Section, Lmdtypes::TLMDString Text, bool Accepted);
	virtual void __fastcall TriggerHeaderSectionExpandEvent(Elheader::TElHeaderSection* Section);
	virtual void __fastcall TriggerHeaderSectionCollapseEvent(Elheader::TElHeaderSection* Section);
	virtual void __fastcall TriggerMeasureItemPartEvent(TElTreeItem* Item, int PartIndex, System::Types::TPoint &Size);
	virtual void __fastcall TriggerApplyVisFilterEvent(TElTreeItem* Item, bool &Hidden);
	virtual void __fastcall TriggerItemPostDrawEvent(Vcl::Graphics::TCanvas* Canvas, TElTreeItem* Item, const System::Types::TRect &ItemRect, bool &DrawFocusRect);
	virtual void __fastcall TriggerItemPreDrawEvent(TElTreeItem* Item);
	virtual void __fastcall TriggerOleTargetDragEvent(System::Uitypes::TDragState State, Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual void __fastcall TriggerOleTargetDropEvent(Eldragdrop::TOleDragObject* Source, System::Classes::TShiftState Shift, int X, int Y, Eldragdrop::TDragType &DragType);
	virtual void __fastcall TriggerOleDragStartEvent(_di_IDataObject &dataObj, _di_IDropSource &dropSource, Eldragdrop::TDragTypes &dwOKEffects);
	virtual void __fastcall TriggerOleDragFinishEvent(Eldragdrop::TDragType dwEffect, HRESULT Result);
	virtual TElTreeItem* __fastcall GetTopItem(void);
	virtual void __fastcall SetTopItem(TElTreeItem* Item);
	virtual void __fastcall Loaded(void);
	Eltreeinplaceeditors::TSortTypes __fastcall SectionTypeToSortType(Elheader::TElFieldType SectionType);
	virtual void __fastcall TriggerSortBegin(void);
	virtual void __fastcall TriggerSortEnd(void);
	virtual TElTreeView* __fastcall CreateView(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall StartDelayedFocus(TElTreeItem* FocusItemToReport);
	void __fastcall StopDelayedFocus(void);
	void __fastcall OnDelayTimer(System::TObject* Sender);
	virtual void __fastcall DoAfterSelectionChange(void);
	void __fastcall SetDragRectAcceptColor(const System::Uitypes::TColor Value);
	void __fastcall SetDragRectDenyColor(System::Uitypes::TColor Value);
	void __fastcall SetDragTrgDrawMode(Eltreeinplaceeditors::TDragTargetDraw Value);
	int __fastcall GetVisibleRowCount(void);
	void __fastcall DoSetDragTrgDrawMode(Eltreeinplaceeditors::TDragTargetDraw Value, bool RedrawItem);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	void __fastcall UpdateDiffItems(void);
	void __fastcall SlowCompareItems(TElTreeItem* Item1, TElTreeItem* Item2, Elheader::TElHeaderSection* Section, int &Result);
	void __fastcall TriggerVirtualPropsNeeded(TElTreeItem* Item, Eltreeinplaceeditors::TElVirtPropTypes PropTypes, TElTreeItemStaticDataEx* Value);
	virtual void __fastcall TriggerVirtualTextNeeded(TElTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerVirtualHintNeeded(TElTreeItem* Item, Lmdtypes::TLMDString &Hint);
	virtual void __fastcall TriggerVirtualValueNeeded(TElTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);
	virtual void __fastcall TriggerVirtualStyleNeeded(TElTreeItem* Item, int SectionIndex, TElCellStyle* Style);
	virtual void __fastcall TriggerTryEditEvent(TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);
	virtual void __fastcall TriggerInplaceEditorNeeded(TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	virtual Eltreeinplaceeditors::TElTreeInplaceManager* __fastcall CreateInplaceManager(void);
	virtual void __fastcall DoEndEditItem(TElTreeItem* Item, Elheader::TElHeaderSection* Section, bool Canceled);
	virtual void __fastcall VertScrollHitTestTransfer(System::TObject* Sender, int X, int Y, Elsbctrl::TElScrollBarPart &Part, bool &DefaultTest);
	virtual void __fastcall HorzScrollHitTestTransfer(System::TObject* Sender, int X, int Y, Elsbctrl::TElScrollBarPart &Part, bool &DefaultTest);
	void __fastcall SetVertDivLinesColor(System::Uitypes::TColor Value);
	void __fastcall SetCheckBoxSize(int Value);
	TElTreeItem* __fastcall GetTrackItem(void);
	bool __fastcall GetDragging(void);
	void __fastcall SetShowLeafButton(bool Value);
	void __fastcall SetLeafPicture(Vcl::Graphics::TBitmap* Value);
	void __fastcall MouseWheelTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelDownTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelUpTransfer(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall FitMostChildren(TElTreeItem* Item);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	int __fastcall GetCheckBoxSize(void);
	Vcl::Menus::TPopupMenu* __fastcall GetHeaderPopupMenu(void);
	void __fastcall SetHeaderPopupMenu(Vcl::Menus::TPopupMenu* Value);
	void __fastcall SetHeaderFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetHeaderUseTreeFont(bool Value);
	void __fastcall HeaderFontChanged(System::TObject* Sender);
	bool __fastcall IsStripedColorStored(void);
	bool __fastcall IsOwnerDrawMaskStored(void);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELSettingChange(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall SetSortUseCase(bool Value);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetDblClickMode(Eltreeinplaceeditors::TElDblClickMode Value);
	Vcl::Graphics::TBitmap* __fastcall GetPlusPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetLeafPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetMinusPicture(void);
	Vcl::Graphics::TBitmap* __fastcall GetCheckBoxGlyph(void);
	Vcl::Graphics::TBitmap* __fastcall GetRadioButtonGlyph(void);
	void __fastcall OnCheckSignChange(System::TObject* Sender);
	MESSAGE void __fastcall WMUpdateSBFrame(Winapi::Messages::TMessage &Message);
	HIDESBASE void __fastcall SetDoubleBuffered(bool Value);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall ReadRightAlignedTree(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DataCacheAllocate(void);
	void __fastcall DataCacheDeallocate(void);
	void __fastcall DataCacheClear(void);
	void __fastcall SetDataCacheSize(int Value);
	TElTreeItemStaticDataEx* __fastcall CreateDataCacheItem(void);
	void __fastcall CacheItem(TElTreeItem* Item, int MinInCache);
	virtual Lmdtypes::TLMDString __fastcall GetIncSearchColumnText(TElTreeItem* Item);
	void __fastcall ResetAllItemsHeight(void);
	void __fastcall ReadScrollTracking(System::Classes::TReader* Reader);
	void __fastcall ReadExpandOnDblClick(System::Classes::TReader* Reader);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	void __fastcall SetCheckBoxFlat(bool Value);
	void __fastcall SetSortColumnColor(System::Uitypes::TColor Value);
	__property bool SinglelineEllipsis = {read=FSinglelineEllipsis, write=SetSinglelineEllipsis, default=1};
	__property bool MultilineEllipsis = {read=FMultilineEllipsis, write=SetMultilineEllipsis, default=0};
	__property System::Uitypes::TColor TextColor = {read=FTextColor, write=SetTextColor, default=-16777208};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=SetBkColor, default=-16777211};
	__property bool ShowButtons = {read=FShowButtons, write=SetButtonStyle, default=1};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool ShowLines = {read=FShowLines, write=SetLineStyle, default=1};
	__property bool ShowImages = {read=FShowImages, write=SetImagesStyle, default=1};
	__property bool ShowRoot = {read=FShowRoot, write=SetRootStyle, default=0};
	__property Eltreeinplaceeditors::THintModes LineHintMode = {read=FShowHintMode, write=FShowHintMode, default=1};
	__property System::Uitypes::TColor LineHintColor = {read=FLineHintColor, write=FLineHintColor, default=-16777211};
	__property bool HideSelection = {read=FHideSelect, write=SetHideSelect, default=0};
	__property bool HideHintOnTimer = {read=FHintHide, write=FHintHide, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* Images2 = {read=FImages2, write=SetImages2};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages2 = {read=FAlphaImages2, write=SetAlphaImages2};
	__property bool ChangeStateImage = {read=FChStateImage, write=SetChStateImage, default=0};
	__property bool ShowColumns = {read=FShowHeader, write=SetShowHeader, default=0};
	__property Eltreeinplaceeditors::TDragTargetDraw DragTrgDrawMode = {read=FDragTrgDrawMode, write=SetDragTrgDrawMode, default=2};
	__property bool DraggableSections = {read=GetDraggableSections, write=SetDraggableSections, default=0};
	__property Eltreeinplaceeditors::TSTSelModes SelectionMode = {read=FSelMode, write=FSelMode, default=1};
	__property bool DoInplaceEdit = {read=FCanEdit, write=SetCanEdit, default=1};
	__property bool VerticalLines = {read=FVerticalLines, write=SetVLines, default=0};
	__property bool BarStyleVerticalLines = {read=FBSVLines, write=SetBSVLines, default=0};
	__property bool HorizontalLines = {read=FHorizontalLines, write=SetHLines, default=0};
	__property bool HorzScrollTracking = {read=FHorzScrollTracking, write=FHorzScrollTracking, default=0};
	__property bool VertScrollTracking = {read=FVertScrollTracking, write=FVertScrollTracking, default=0};
	__property bool HotTrack = {read=FTracking, write=FTracking, default=1};
	__property bool Tracking = {read=FTracking, write=FTracking, default=1};
	__property bool RowSelect = {read=FRowSelect, write=SetRowSelect, default=1};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=1};
	__property int MultiSelectLevel = {read=FMultiSelectLevel, write=SetMultiSelectLevel, default=-1};
	__property int LineHeight = {read=FLineHeight, write=SetLineHeight, nodefault};
	__property bool AutoLineHeight = {read=FAutoLineHeight, write=SetAutoLineHeight, default=1};
	__property bool HeaderHotTrack = {read=FHeaderHotTrack, write=SetHeaderHotTrack, default=1};
	__property Elheader::TElHeaderSections* HeaderSections = {read=GetHeaderSections, write=SetHeaderSections};
	__property int HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight, nodefault};
	__property int MainTreeColumn = {read=FMainTreeCol, write=SetMainTreeCol, default=0};
	__property bool OwnerDrawByColumn = {read=FODFollowCol, write=FODFollowCol, default=1};
	__property Lmdtypes::TLMDString OwnerDrawMask = {read=FODMask, write=FODMask, stored=IsOwnerDrawMaskStored};
	__property bool DragAllowed = {read=FDragAllowed, write=FDragAllowed, default=0};
	__property Eltreeinplaceeditors::TSortDirs SortDir = {read=FSortDir, write=FSortDir, default=0};
	__property Eltreeinplaceeditors::TSortModes SortMode = {read=FSortMode, write=SetSortMode, default=0};
	__property int SortSection = {read=FSortSection, write=SetSortSection, default=0};
	__property Eltreeinplaceeditors::TSortTypes SortType = {read=FSortType, write=FSortType, default=1};
	__property bool HideHintOnMove = {read=FHideHintOnMove, write=FHideHintOnMove, default=1};
	__property bool MoveColumnOnDrag = {read=GetMoveColumnOnDrag, write=SetMoveColumnOnDrag, default=0};
	__property bool HideHorzScrollBar = {read=FHideHorzScrollBar, write=SetHideHorzScrollBar, default=0};
	__property bool HideVertScrollBar = {read=FHideVertScrollBar, write=SetHideVertScrollBar, default=0};
	__property Elscrollbar::TElScrollBarStyles* HorzScrollBarStyles = {read=FHorzScrollBarStyle, write=SetHorzScrollBarStyle, stored=true};
	__property Elscrollbar::TElScrollBarStyles* VertScrollBarStyles = {read=FVertScrollBarStyle, write=SetVertScrollBarStyle, stored=true};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property Vcl::Imglist::TCustomImageList* HeaderImages = {read=GetHeaderImages, write=SetHeaderImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHeaderImages = {read=GetAlphaHeaderImages, write=SetAlphaHeaderImages};
	__property Eltreeinplaceeditors::TDragImgMode DragImageMode = {read=FDragImageMode, write=FDragImageMode, default=0};
	__property System::UnicodeString StoragePath = {read=FStoragePath, write=FStoragePath};
	__property Elini::TElIniFile* Storage = {read=FStorage, write=SetStorage};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Elimgfrm::TElImageForm* HeaderImageForm = {read=GetHeaderImageForm, write=SetHeaderImageForm};
	__property bool ShowCheckBoxes = {read=FShowCheckboxes, write=SetShowCheckboxes, default=0};
	__property Vcl::Graphics::TBitmap* PlusPicture = {read=GetPlusPicture, write=SetPlusPicture};
	__property Vcl::Graphics::TBitmap* MinusPicture = {read=GetMinusPicture, write=SetMinusPicture};
	__property bool CustomPlusMinus = {read=FCustomPlusMinus, write=SetCustomPlusMinus, default=0};
	__property int SelectColumn = {read=FSelectColumn, write=SetSelectColumn, default=-1};
	__property bool AutoExpand = {read=FAutoExpand, write=SetAutoExpand, default=0};
	__property bool AutoLookup = {read=FAutoLookup, write=FAutoLookup, default=0};
	__property Eltreeinplaceeditors::TElDragType DragType = {read=FDragType, write=SetDragType, default=1};
	__property bool FullRowSelect = {read=FFullRowSelect, write=FFullRowSelect, default=1};
	__property bool AlwaysKeepSelection = {read=FAlwaysKeepSelection, write=FAlwaysKeepSelection, default=1};
	__property bool AlwaysKeepFocus = {read=FAlwaysKeepFocus, write=FAlwaysKeepFocus, default=0};
	__property bool StickyHeaderSections = {read=GetStickyHeaderSections, write=SetStickyHeaderSections, default=0};
	__property bool BarStyle = {read=FBarStyle, write=SetBarStyle, default=0};
	__property bool DrawFocusRect = {read=FDrawFocusRect, write=SetDrawFocusRect, default=1};
	__property bool DeselectChildrenOnCollapse = {read=FDeselectChildrenOnCollapse, write=FDeselectChildrenOnCollapse, default=0};
	__property System::Uitypes::TColor HorzDivLinesColor = {read=FHorzDivLinesColor, write=SetHorzDivLinesColor, default=-16777201};
	__property System::Uitypes::TColor LinesColor = {read=FLinesColor, write=SetLinesColor, default=-16777201};
	__property Vcl::Graphics::TPenStyle LinesStyle = {read=FLinesStyle, write=SetLinesStyle, default=2};
	__property System::WideChar PathSeparator = {read=FPathSeparator, write=FPathSeparator, default=92};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool RightAlignedText = {read=FRightAlignedText, write=SetRightAlignedText, default=0};
	__property bool FilteredVisibility = {read=FFilteredVisibility, write=SetFilteredVisibility, default=0};
	__property bool UnderlineTracked = {read=FUnderlineTracked, write=SetUnderlineTracked, default=1};
	__property bool CustomCheckboxes = {read=FCustomCheckboxes, write=SetCustomCheckboxes, default=0};
	__property Vcl::Graphics::TBitmap* CheckBoxGlyph = {read=GetCheckBoxGlyph, write=SetCheckBoxGlyph};
	__property Vcl::Graphics::TBitmap* RadioButtonGlyph = {read=GetRadioButtonGlyph, write=SetRadioButtonGlyph};
	__property bool ScrollbarOpposite = {read=FScrollbarOpposite, write=SetScrollbarOpposite, default=0};
	__property bool ShowRootButtons = {read=FShowRootButtons, write=SetShowRootButtons, default=1};
	__property bool ShowEmptyImages = {read=FShowEmptyImages, write=SetShowEmptyImages, default=0};
	__property bool ShowEmptyImages2 = {read=FShowEmptyImages2, write=SetShowEmptyImages2, default=0};
	__property bool HideFocusRect = {read=FHideFocusRect, write=SetHideFocusRect, default=0};
	__property bool LockHeaderHeight = {read=GetLockHeaderHeight, write=SetLockHeaderHeight, default=0};
	__property bool AutoResizeColumns = {read=FAutoResizeColumns, write=FAutoResizeColumns, default=1};
	__property System::Uitypes::TColor HeaderActiveFilterColor = {read=GetHeaderActiveFilterColor, write=SetHeaderActiveFilterColor, default=0};
	__property System::Uitypes::TColor HeaderFilterColor = {read=GetHeaderFilterColor, write=SetHeaderFilterColor, default=-16777198};
	__property bool HeaderFlat = {read=GetHeaderFlat, write=SetHeaderFlat, default=0};
	__property bool HeaderWrapCaptions = {read=GetHeaderWrapCaptions, write=SetHeaderWrapCaptions, default=0};
	__property bool FlatFocusedScrollbars = {read=FFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, default=1};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property bool UseCustomScrollBars = {read=FUseCustomBars, write=SetUseStdBars, default=1};
	__property bool RowHotTrack = {read=FRowHotTrack, write=SetRowHotTrack, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property int ItemIndent = {read=ItemExt, write=SetItemIndent, default=17};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=0};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=0};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=64};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, default=0};
	__property bool HeaderInvertSortArrows = {read=GetHeaderInvertSortArrows, write=SetHeaderInvertSortArrows, default=0};
	__property bool MoveFocusOnCollapse = {read=FMoveFocusOnCollapse, write=SetMoveFocusOnCollapse, default=0};
	__property System::Uitypes::TScrollStyle ForcedScrollBars = {read=FForcedScrollBars, write=SetForcedScrollBars, default=0};
	__property bool PlusMinusTransparent = {read=FTransButtons, write=SetTransButtons, default=0};
	__property Lmdtypes::TLMDString Hint = {read=GetHint, write=SetHint};
	__property System::Uitypes::TColor DragRectAcceptColor = {read=FDragRectAcceptColor, write=SetDragRectAcceptColor, default=32768};
	__property System::Uitypes::TColor DragRectDenyColor = {read=FDragRectDenyColor, write=SetDragRectDenyColor, default=255};
	__property int DragExpandDelay = {read=FDragExpandDelay, write=FDragExpandDelay, default=500};
	__property int IncrementalSearchTimeout = {read=FIncrementalSearchTimeout, write=FIncrementalSearchTimeout, default=500};
	__property bool IncrementalSearch = {read=FIncrementalSearch, write=FIncrementalSearch, default=0};
	__property bool AdjustMultilineHeight = {read=FAdjustMultilineHeight, write=SetAdjustMultilineHeight, default=1};
	__property bool ExpandOnDragOver = {read=FExpandOnDragOver, write=FExpandOnDragOver, default=0};
	__property System::Uitypes::TCursor DragCursor = {read=GetDragCursor, write=SetDragCursor, default=-12};
	__property System::Uitypes::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=-16777203};
	__property bool UseSystemHintColors = {read=FUseSystemHintColors, write=FUseSystemHintColors, default=0};
	__property System::Uitypes::TColor HeaderColor = {read=GetHeaderColor, write=SetHeaderColor, default=-16777201};
	__property int ChangeDelay = {read=FChangeDelay, write=FChangeDelay, default=500};
	__property bool RightClickSelect = {read=FRightClickSelect, write=FRightClickSelect, default=1};
	__property System::Uitypes::TColor StripedOddColor = {read=FStripedOddColor, write=SetStripedOddColor, stored=IsStripedColorStored, nodefault};
	__property System::Uitypes::TColor StripedEvenColor = {read=FStripedEvenColor, write=SetStripedEvenColor, stored=IsStripedColorStored, nodefault};
	__property bool StripedItems = {read=FStripedItems, write=SetStripedItems, default=0};
	__property TInplaceEditorNeededEvent OnInplaceEditorNeeded = {read=FOnInplaceEditorNeeded, write=FOnInplaceEditorNeeded};
	__property bool QuickEditMode = {read=FQuickEditMode, write=FQuickEditMode, default=0};
	__property Elheader::TElFieldType MainTextType = {read=FMainTextType, write=FMainTextType, default=1};
	__property Eltreeinplaceeditors::TElHintType HintType = {read=FHintType, write=FHintType, default=2};
	__property Elsbctrl::TElScrollHitTestEvent OnVertScrollHitTest = {read=FOnVertScrollHitTest, write=FOnVertScrollHitTest};
	__property Elsbctrl::TElScrollHitTestEvent OnHorzScrollHitTest = {read=FOnHorzScrollHitTest, write=FOnHorzScrollHitTest};
	__property bool MouseFrameVisible = {read=FMouseFrameVisible, write=FMouseFrameVisible, default=1};
	__property bool MouseFrameSelect = {read=FMouseFrameSelect, write=FMouseFrameSelect, default=1};
	__property System::Uitypes::TColor VertDivLinesColor = {read=FVertDivLinesColor, write=SetVertDivLinesColor, default=-16777201};
	__property TOnItemChangeEvent OnItemChange = {read=FOnItemChange, write=FOnItemChange};
	__property TOnItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TOnItemCheckedEvent OnItemChecked = {read=FOnItemChecked, write=FOnItemChecked};
	__property TOnItemExpandEvent OnItemExpand = {read=FOnItemExpand, write=FOnItemExpand};
	__property TOnItemExpandEvent OnItemCollapse = {read=FOnItemCollapse, write=FOnItemCollapse};
	__property TOnItemExpanding OnItemExpanding = {read=FOnItemExpanding, write=FOnItemExpanding};
	__property TOnItemExpanding OnItemCollapsing = {read=FOnItemCollapsing, write=FOnItemCollapsing};
	__property TElScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TOnItemExpandEvent OnItemDeletion = {read=FOnItemDelete, write=FOnItemDelete};
	__property TElTreeChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property System::Classes::TNotifyEvent OnItemFocused = {read=FOnItemFocused, write=FOnItemFocused};
	__property System::Classes::TNotifyEvent OnBeginUpdate = {read=FOnBeginUpdate, write=FOnBeginUpdate};
	__property System::Classes::TNotifyEvent OnEndUpdate = {read=FOnEndUpdate, write=FOnEndUpdate};
	__property TOnShowHintEvent OnShowLineHint = {read=FOnShowHint, write=FOnShowHint};
	__property TOnCompareItems OnCompareItems = {read=FOnCompareItems, write=FOnCompareItems};
	__property TOnPicDrawEvent OnItemPicDraw = {read=FOnItemPicDraw, write=FOnItemPicDraw};
	__property TOnPicDrawEvent OnItemPicDraw2 = {read=FOnItemPicDraw2, write=FOnItemPicDraw2};
	__property THotTrackEvent OnHotTrack = {read=FOnHotTrack, write=FOnHotTrack};
	__property TElCanDragEvent OnCanDrag = {read=GetCanDrag, write=SetCanDrag};
	__property TTryEditEvent OnTryEdit = {read=FOnTryEdit, write=FOnTryEdit};
	__property TOnEndEditEvent OnEndEditItem = {read=FOnEndEdit, write=FOnEndEdit};
	__property TElItemSaveEvent OnItemSave = {read=FOnItemSave, write=FOnItemSave};
	__property TElItemSaveEvent OnItemLoad = {read=FOnItemLoad, write=FOnItemLoad};
	__property TItemSelChangeEvent OnItemSelectedChange = {read=FOnItemSelectedChange, write=FOnItemSelectedChange};
	__property TElCellStyleSaveEvent OnCellStyleSave = {read=FOnSave, write=FOnSave};
	__property TElCellStyleSaveEvent OnCellStyleLoad = {read=FOnLoad, write=FOnLoad};
	__property System::Classes::TNotifyEvent OnSortBegin = {read=FOnSortBegin, write=FOnSortBegin};
	__property System::Classes::TNotifyEvent OnSortEnd = {read=FOnSortEnd, write=FOnSortEnd};
	__property System::Classes::TNotifyEvent OnHeaderResize = {read=FOnHeaderResize, write=FOnHeaderResize};
	__property Elheader::TElHeaderLookupEvent OnHeaderLookup = {read=FOnHeaderLookup, write=FOnHeaderLookup};
	__property Elheader::TElHeaderLookupDoneEvent OnHeaderLookupDone = {read=FOnHeaderLookupDone, write=FOnHeaderLookupDone};
	__property THeaderSectionEvent OnHeaderSectionExpand = {read=FOnHeaderSectionExpand, write=FOnHeaderSectionExpand};
	__property THeaderSectionEvent OnHeaderSectionCollapse = {read=FOnHeaderSectionCollapse, write=FOnHeaderSectionCollapse};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionAutoSize = {read=FOnSectionAutoSize, write=FOnSectionAutoSize};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnResize = {read=FOnColumnResize, write=FOnColumnResize};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderColumnClick = {read=FOnColumnClick, write=FOnColumnClick};
	__property TElColumnMoveEvent OnHeaderColumnMove = {read=FOnHeaderColumnMove, write=FOnHeaderColumnMove};
	__property Elheader::TElSectionRedrawEvent OnHeaderColumnDraw = {read=FOnColumnDraw, write=FOnColumnDraw};
	__property Eltreeinplaceeditors::TColumnNotifyEvent OnHeaderSectionFilterCall = {read=FOnSectionFilterCall, write=FOnSectionFilterCall};
	__property Elheader::TMeasureSectionEvent OnHeaderSectionMeasure = {read=FOnHeaderSectionMeasure, write=FOnHeaderSectionMeasure};
	__property TApplyVisFilterEvent OnApplyVisFilter = {read=FOnApplyVisFilter, write=FOnApplyVisFilter};
	__property TElTreeItemPostDrawEvent OnItemPostDraw = {read=FOnItemPostDraw, write=FOnItemPostDraw};
	__property TMeasureItemPartEvent OnMeasureItemPart = {read=FOnMeasureItemPart, write=FOnMeasureItemPart};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnHTMLImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnHTMLImageNeededEx = {read=FOnImageNeededEx, write=FOnImageNeededEx};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLLinkOverEvent OnLinkOver = {read=FOnLinkOver, write=FOnLinkOver};
	__property System::Uitypes::TCursor LinkCursor = {read=FLinkCursor, write=FLinkCursor, default=-21};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TDragDropEvent OnDragDrop = {read=FOnDrop, write=FOnDrop};
	__property Vcl::Controls::TDragOverEvent OnDragOver = {read=FOnOver, write=FOnOver};
	__property System::Classes::TNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property System::Classes::TNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property Vcl::Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Vcl::Controls::TKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property Vcl::Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property Vcl::Controls::TStartDragEvent OnStartDrag = {read=FOnStartDrag, write=FOnStartDrag};
	__property Eldragdrop::TTargetDragEvent OnOleTargetDrag = {read=FOnOleTargetDrag, write=FOnOleTargetDrag};
	__property Eldragdrop::TTargetDropEvent OnOleTargetDrop = {read=FOnOleTargetDrop, write=FOnOleTargetDrop};
	__property TOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart, write=FOnOleDragStart};
	__property TOleDragFinishEvent OnOleDragFinish = {read=FOnOleDragFinish, write=FOnOleDragFinish};
	__property Elsbctrl::TElScrollDrawPartEvent OnHorzScrollDrawPart = {read=FOnHorzScrollDrawPart, write=FOnHorzScrollDrawPart};
	__property Elsbctrl::TElScrollHintNeededEvent OnHorzScrollHintNeeded = {read=FOnHorzScrollHintNeeded, write=FOnHorzScrollHintNeeded};
	__property Elsbctrl::TElScrollDrawPartEvent OnVertScrollDrawPart = {read=FOnVertScrollDrawPart, write=FOnVertScrollDrawPart};
	__property Elsbctrl::TElScrollHintNeededEvent OnVertScrollHintNeeded = {read=FOnVertScrollHintNeeded, write=FOnVertScrollHintNeeded};
	__property Vcl::Controls::TMouseEvent OnHeaderMouseDown = {read=FOnHeaderMouseDown, write=FOnHeaderMouseDown};
	__property System::Classes::TNotifyEvent OnAfterSelectionChange = {read=FOnAfterSelectionChange, write=FOnAfterSelectionChange};
	__property TOnItemExpandEvent OnItemPreDraw = {read=FOnItemPreDraw, write=FOnItemPreDraw};
	__property TElTreeItemDragTargetEvent OnDragTargetChange = {read=FOnDragTargetChange, write=FOnDragTargetChange};
	__property int LineHintTimeout = {read=FLineHintTimeout, write=SetLineHintTimeout, default=3000};
	__property bool VerticalLinesLong = {read=FVerticalLinesLong, write=SetVerticalLinesLong, default=1};
	__property int DefaultSectionWidth = {read=GetDefaultSectionWidth, write=SetDefaultSectionWidth, default=120};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Eltreeinplaceeditors::TLineHintType LineHintType = {read=FLineHintType, write=FLineHintType, default=2};
	__property TVirtualPropsNeededEvent OnVirtualPropsNeeded = {read=FOnVirtualPropsNeeded, write=FOnVirtualPropsNeeded};
	__property TVirtualTextNeededEvent OnVirtualTextNeeded = {read=FOnVirtualTextNeeded, write=FOnVirtualTextNeeded};
	__property Eltreeinplaceeditors::TVirtualityLevel VirtualityLevel = {read=FVirtualityLevel, write=SetVirtualityLevel, default=0};
	__property TVirtualHintNeededEvent OnVirtualHintNeeded = {read=FOnVirtualHintNeeded, write=FOnVirtualHintNeeded};
	__property TVirtualValueNeededEvent OnVirtualValueNeeded = {read=FOnVirtualValueNeeded, write=FOnVirtualValueNeeded};
	__property TVirtualStyleNeededEvent OnVirtualStyleNeeded = {read=FOnVirtualStyleNeeded, write=FOnVirtualStyleNeeded};
	__property int CheckBoxSize = {read=GetCheckBoxSize, write=SetCheckBoxSize, default=15};
	__property int DragScrollInterval = {read=FDragScrollInterval, write=FDragScrollInterval, default=100};
	__property bool ShowLeafButton = {read=FShowLeafButton, write=SetShowLeafButton, default=0};
	__property Vcl::Graphics::TBitmap* LeafPicture = {read=GetLeafPicture, write=SetLeafPicture};
	__property bool ExplorerEditMode = {read=FExplorerEditMode, write=FExplorerEditMode, default=0};
	__property bool IgnoreEnabled = {read=FIgnoreEnabled, write=FIgnoreEnabled, default=0};
	__property int InplaceEditorDelay = {read=FInplaceEditorDelay, write=FInplaceEditorDelay, default=500};
	__property Vcl::Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont, stored=IsHeaderFontStored};
	__property bool HeaderUseTreeFont = {read=FHeaderUseTreeFont, write=SetHeaderUseTreeFont, default=1};
	__property bool KeepSelectionWithinLevel = {read=FKeepSelectionWithinLevel, write=FKeepSelectionWithinLevel, default=0};
	__property bool AutoCollapse = {read=FAutoCollapse, write=FAutoCollapse, default=0};
	__property bool SortUseCase = {read=FSortUseCase, write=SetSortUseCase, default=1};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Eltreeinplaceeditors::TElDblClickMode DblClickMode = {read=FDblClickMode, write=SetDblClickMode, default=1};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property int DataCacheSize = {read=FDataCacheSize, write=SetDataCacheSize, default=200};
	__property Eltreeinplaceeditors::TElIncSearchScope IncrementalSearchScope = {read=FIncrementalSearchScope, write=FIncrementalSearchScope, default=0};
	__property Eltreeinplaceeditors::TElIncSearchColumn IncrementalSearchColumn = {read=FIncrementalSearchColumn, write=FIncrementalSearchColumn, default=0};
	__property bool CheckBoxFlat = {read=FCheckBoxFlat, write=SetCheckBoxFlat, default=0};
	__property bool HorzArrowsScroll = {read=FHorzArrowsScroll, write=FHorzArrowsScroll, default=0};
	__property System::Uitypes::TColor SortColumnColor = {read=FSortColumnColor, write=SetSortColumnColor, default=536870911};
	void __fastcall EnsureVisibleEx(TElTreeItem* Item, bool Expande);
	void __fastcall EnsureVisibleBottomEx(TElTreeItem* Item, bool Expande);
	void __fastcall Init(void);
	
public:
	__fastcall virtual TCustomElTree(System::Classes::TComponent* AOwner);
	__fastcall TCustomElTree(System::Classes::TComponent* AOwner, TElTreeItemClass ItemClass);
	__fastcall virtual ~TCustomElTree(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FullCollapse(void);
	virtual void __fastcall FullExpand(void);
	DYNAMIC bool __fastcall CanFocus(void);
	virtual Vcl::Controls::TDragImageList* __fastcall GetDragImages(void);
	DYNAMIC bool __fastcall Focused(void);
	virtual System::Types::TRect __fastcall GetItemRect(int ItemIndex);
	virtual TElTreeItem* __fastcall GetItemAtY(int Y);
	virtual TElTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	virtual void __fastcall MeasureCell(TElTreeItem* Item, int ColumnNum, int MaxWidth, System::Types::TPoint &Size);
	virtual TElTreeItem* __fastcall GetNextSelected(TElTreeItem* Prev);
	virtual void __fastcall AllSelected(Lmdobjectlist::TLMDObjectList* SelectedItems);
	virtual void __fastcall SelectAll(void);
	virtual void __fastcall InvertSelection(void);
	virtual void __fastcall SelectAllEx(bool IncludeHidden);
	virtual void __fastcall InvertSelectionEx(bool IncludeHidden);
	virtual void __fastcall DeselectAll(void);
	virtual void __fastcall DeselectAllEx(bool IncludeHidden);
	virtual void __fastcall SelectRange(TElTreeItem* FromItem, TElTreeItem* ToItem);
	virtual void __fastcall SelectRange2(TElTreeItem* FromItem, TElTreeItem* ToItem, bool SelectDisabled, bool SelectCollapsedChildren);
	virtual void __fastcall SelectRangeEx(TElTreeItem* FromItem, TElTreeItem* ToItem, bool IncludeHidden);
	virtual void __fastcall SelectRangeEx2(TElTreeItem* FromItem, TElTreeItem* ToItem, bool IncludeHidden, bool SelectDisabled, bool SelectCollapsedChildren);
	virtual void __fastcall Sort(bool recursive);
	virtual void __fastcall Save(void);
	virtual void __fastcall Restore(void);
	void __fastcall EnsureVisible(TElTreeItem* Item);
	void __fastcall EnsureVisibleBottom(TElTreeItem* Item);
	bool __fastcall IsEditing(void);
	virtual void __fastcall EditItem(TElTreeItem* Item, int SectionNum);
	void __fastcall EndEdit(bool ByCancel);
	virtual void __fastcall SaveStringsToStream(System::Classes::TStream* Stream);
	TElTreeItem* __fastcall GetNodeAt(int X, int Y);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual bool __fastcall IsInView(TElTreeItem* Item);
	int __fastcall MeasureColumnWidth(int ColumnNum, bool VisibleOnly);
	int __fastcall IndexInView(TElTreeItem* Item);
	void __fastcall AllSelectedEx(Lmdobjectlist::TLMDObjectList* SelectedItems, bool Order);
	void __fastcall AddSortSection(int Index, bool ReSort);
	void __fastcall RemoveSortSection(int Index, bool ReSort);
	void __fastcall ClearSortList(bool ReSort);
	void __fastcall AutoSizeAllColumns(void);
	void __fastcall AutoSizeColumn(int SectionIndex);
	void __fastcall AutoSizeAllColumnsEx(bool VisibleOnly);
	void __fastcall AutoSizeColumnEx(int SectionIndex, bool VisibleOnly);
	virtual bool __fastcall MeasureCellText(TElTreeItem* Item, int ColumnNum, int MaxWidth, System::Types::TPoint &Size);
	void __fastcall ResetUpdateCounter(void);
	__property int TopIndex = {read=FTopIndex, write=SetVPosition, nodefault};
	__property int BottomIndex = {read=FBottomIndex, nodefault};
	__property bool IsUpdating = {read=GetUpdating, write=SetUpdating, nodefault};
	__property TElTreeItems* Items = {read=FItems, write=SetItems};
	__property TElTreeItem* ItemFocused = {read=GetFocused, write=SetFocused};
	__property int SelectedCount = {read=GetSelCount, nodefault};
	__property bool FireFocusEvents = {read=GetFireFocusEvents, write=SetFireFocusEvents, default=1};
	__property TElTreeItem* Selected = {read=GetSelected, write=SetSelected};
	__property TElTreeItem* TopItem = {read=GetTopItem, write=SetTopItem};
	__property Vcl::Controls::TDragObject* DragObject = {read=FDragObject};
	__property TElTreeView* View = {read=FView};
	__property bool HorzScrollBarVisible = {read=FHScrollVisible, nodefault};
	__property bool VertScrollBarVisible = {read=FVScrollVisible, nodefault};
	__property Elheader::TElHeaderSection* LockedHeaderSection = {read=GetLockedHeaderSection, write=SetLockedHeaderSection};
	__property int VisibleRowCount = {read=GetVisibleRowCount, nodefault};
	__property TElTreeItem* DropTarget = {read=GetDropTarget};
	__property Elscrollbar::TElScrollBar* HScrollBar = {read=FHScrollBar};
	__property Elscrollbar::TElScrollBar* VScrollBar = {read=FVScrollBar};
	__property TElTreeItem* TrackItem = {read=GetTrackItem};
	__property int SortSectionToCompare = {read=FSortSectionToCompare, nodefault};
	__property bool UseThemeForSelection = {read=FUseThemeForSelection, write=SetUseThemeForSelection, default=0};
	
__published:
	__property int LeftPosition = {read=FHPos, write=SetHPosition, default=0};
	__property Vcl::Controls::TBevelKind BevelKind = {read=FBevelKindDummy, write=FBevelKindDummy, stored=false, default=0};
	__property Vcl::Menus::TPopupMenu* HeaderPopupMenu = {read=GetHeaderPopupMenu, write=SetHeaderPopupMenu};
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=SetDoubleBuffered, default=1};
	__property bool DoubleBufferedOnResize = {read=FDoubleBufferedOnResize, write=FDoubleBufferedOnResize, default=1};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElTree(HWND ParentWindow) : Eltreeinplaceeditors::TElTreeAncestor(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTree : public TCustomElTree
{
	typedef TCustomElTree inherited;
	
__published:
	__property UseThemeForSelection = {default=0};
	__property ActiveBorderType = {default=1};
	__property DragCursor = {default=-12};
	__property Align = {default=0};
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property AutoCollapse = {default=0};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=1};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=1};
	__property DragKind = {default=0};
	__property DefaultSectionWidth = {default=120};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BorderStyle = {default=1};
	__property BorderSides = {default=15};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxFlat = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property Ctl3D;
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DblClickMode = {default=1};
	__property DoInplaceEdit = {default=1};
	__property DragAllowed = {default=0};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragImageMode = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property Enabled = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=0};
	__property FilteredVisibility = {default=0};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=IsFontStored};
	__property FullRowSelect = {default=1};
	__property GradientStartColor = {default=0};
	__property GradientEndColor = {default=0};
	__property GradientSteps = {default=64};
	__property HeaderActiveFilterColor = {default=0};
	__property HeaderColor = {default=-16777201};
	__property HeaderHeight;
	__property HeaderHotTrack = {default=1};
	__property HeaderInvertSortArrows = {default=0};
	__property HeaderSections;
	__property HeaderFilterColor = {default=-16777198};
	__property HeaderFlat = {default=0};
	__property HeaderFont;
	__property HeaderUseTreeFont = {default=1};
	__property HeaderImages;
	__property AlphaForHeaderImages;
	__property HeaderWrapCaptions = {default=0};
	__property HideFocusRect = {default=0};
	__property HideHintOnTimer = {default=0};
	__property HideHintOnMove = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HideSelection = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalLines = {default=0};
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property Hint;
	__property HintType = {default=2};
	__property HorzArrowsScroll = {default=0};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property IgnoreEnabled = {default=0};
	__property HeaderImageForm;
	__property ImageForm;
	__property Images;
	__property Images2;
	__property AlphaForImages;
	__property AlphaForImages2;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property IncrementalSearchColumn = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
	__property Items;
	__property KeepSelectionWithinLevel = {default=0};
	__property LeafPicture;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property LineHeight;
	__property LinesColor = {default=-16777201};
	__property LinesStyle = {default=2};
	__property LineHintColor = {default=-16777211};
	__property LineHintMode = {default=1};
	__property LineHintTimeout = {default=3000};
	__property LineHintType = {default=2};
	__property LockHeaderHeight = {default=0};
	__property MainTextType = {default=1};
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MouseFrameSelect = {default=1};
	__property MouseFrameVisible = {default=1};
	__property MultilineEllipsis = {default=0};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
	__property PopupMenu;
	__property QuickEditMode = {default=0};
	__property RadioButtonGlyph;
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property RightClickSelect = {default=1};
	__property RowHotTrack = {default=0};
	__property RowSelect = {default=1};
	__property ScrollbarOpposite = {default=0};
	__property HorzScrollTracking = {default=0};
	__property VertScrollTracking = {default=0};
	__property SelectColumn = {default=-1};
	__property ShowButtons = {default=1};
	__property ShowColumns = {default=0};
	__property ShowCheckBoxes = {default=0};
	__property ShowEmptyImages = {default=0};
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=1};
	__property ShowLeafButton = {default=0};
	__property ShowLines = {default=1};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=1};
	__property SinglelineEllipsis = {default=1};
	__property SelectionMode = {default=1};
	__property SortColumnColor = {default=536870911};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property SortSection = {default=0};
	__property SortType = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property SortUseCase = {default=1};
	__property StickyHeaderSections = {default=0};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Tracking = {default=1};
	__property TrackColor = {default=-16777203};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property VertDivLinesColor = {default=-16777201};
	__property VerticalLines = {default=0};
	__property VerticalLinesLong = {default=1};
	__property VertScrollBarStyles;
	__property VirtualityLevel = {default=0};
	__property Visible = {default=1};
	__property UseSystemHintColors = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TextColor = {default=-16777208};
	__property BkColor = {default=-16777211};
	__property OnScroll;
	__property OnHeaderColumnClick;
	__property OnHeaderColumnDraw;
	__property OnHeaderColumnResize;
	__property OnHeaderColumnMove;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnHeaderResize;
	__property OnHeaderSectionExpand;
	__property OnHeaderSectionCollapse;
	__property OnHeaderSectionFilterCall;
	__property OnHeaderSectionAutoSize;
	__property OnHeaderSectionMeasure;
	__property OnHorzScrollDrawPart;
	__property OnHorzScrollHintNeeded;
	__property OnAfterSelectionChange;
	__property OnApplyVisFilter;
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnResize;
	__property OnTryEdit;
	__property OnInplaceEditorNeeded;
	__property OnEndEditItem;
	__property OnItemChecked;
	__property OnItemExpand;
	__property OnItemCollapse;
	__property OnItemExpanding;
	__property OnItemCollapsing;
	__property OnItemDeletion;
	__property OnItemFocused;
	__property OnBeginUpdate;
	__property OnEndUpdate;
	__property OnShowLineHint;
	__property OnCompareItems;
	__property OnItemPicDraw;
	__property OnItemPicDraw2;
	__property OnItemPostDraw;
	__property OnHotTrack;
	__property OnMeasureItemPart;
	__property OnSortBegin;
	__property OnSortEnd;
	__property OnItemSave;
	__property OnItemLoad;
	__property OnItemSelectedChange;
	__property OnCellStyleSave;
	__property OnCellStyleLoad;
	__property OnVertScrollDrawPart;
	__property OnVertScrollHintNeeded;
	__property OnCanDrag;
	__property OnHTMLImageNeeded;
	__property OnHTMLImageNeededEx;
	__property OnLinkClick;
	__property OnLinkOver;
	__property LinkCursor = {default=-21};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property OnVirtualPropsNeeded;
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnHeaderMouseDown;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
public:
	/* TCustomElTree.Create */ inline __fastcall virtual TElTree(System::Classes::TComponent* AOwner) : TCustomElTree(AOwner) { }
	/* TCustomElTree.CreateClass */ inline __fastcall TElTree(System::Classes::TComponent* AOwner, TElTreeItemClass ItemClass) : TCustomElTree(AOwner, ItemClass) { }
	/* TCustomElTree.Destroy */ inline __fastcall virtual ~TElTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTree(HWND ParentWindow) : TCustomElTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeDragObject : public Vcl::Controls::TDragControlObject
{
	typedef Vcl::Controls::TDragControlObject inherited;
	
public:
	virtual void __fastcall Finished(System::TObject* Target, int X, int Y, bool Accepted);
	virtual System::Uitypes::TCursor __fastcall GetDragCursor(bool Accepted, int X, int Y);
	__fastcall virtual ~TElTreeDragObject(void);
public:
	/* TBaseDragControlObject.Create */ inline __fastcall virtual TElTreeDragObject(Vcl::Controls::TControl* AControl) : Vcl::Controls::TDragControlObject(AControl) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word DefaultTextFlags = System::Word(0x8824);
static const System::Word TM_CLOSEINPLACEEDITOR = System::Word(0xf13);
static const System::Int8 stsExpanded = System::Int8(0x7);
static const System::Int8 stsCut = System::Int8(0x3);
static const System::Int8 stsUnderlined = System::Int8(0x4);
static const System::Int8 stsBold = System::Int8(0x5);
static const System::Int8 stsItalic = System::Int8(0x6);
static const System::Int8 stsStrikeOut = System::Int8(0x8);
static const System::Int8 stiMaxState = System::Int8(0x8);
static const System::Int8 tisExpanded = System::Int8(0x8);
static const System::Int8 tisCut = System::Int8(0x4);
static const System::Int8 tisBold = System::Int8(0x10);
static const System::Int8 tisItalic = System::Int8(0x20);
static const System::Int8 tisUnderlined = System::Int8(0x40);
static const System::Byte tisStrikeout = System::Byte(0x80);
static const System::Int8 ibfParentColors = System::Int8(0x1);
static const System::Int8 ibfParentStyle = System::Int8(0x2);
static const System::Int8 ibfSuppressLines = System::Int8(0x4);
static const System::Int8 ibfForceButtons = System::Int8(0x20);
static const System::Int8 ibfStrikedOutLine = System::Int8(0x40);
static const System::Byte ibfDrawHLine = System::Byte(0x80);
static const System::Word ibfWholeLine = System::Word(0x100);
static const System::Word ibfAllowEdit = System::Word(0x200);
static const System::Word ibfUseBkColor = System::Word(0x400);
static const System::Word ibfUseStyles = System::Word(0x1000);
static const int ibfSuppressButtons = int(0x10000);
static const int ibfCheckBoxEnabled = int(0x20000);
static const int ibfShowCheckBox = int(0x40000);
static const int ibfHintIsHTML = int(0x400000);
static const int ibfWordWrap = int(0x4000000);
static const System::Int8 ibfImageDrawn = System::Int8(0x8);
static const System::Int8 ibfImageDrawn2 = System::Int8(0x10);
static const System::Word ibfDeleting = System::Word(0x800);
static const System::Word ibfMultiline = System::Word(0x2000);
static const System::Word ibfHidden = System::Word(0x4000);
static const System::Word ibfEnabled = System::Word(0x8000);
static const int ibfIsHTML = int(0x80000);
static const int ibfOwnerHeight = int(0x100000);
static const int ibfRec = int(0x200000);
static const int ibfSelected = int(0x800000);
static const int ibfFocused = int(0x1000000);
static const int ibfExpanded = int(0x2000000);
static const System::Int8 FDivLineWidth = System::Int8(0x1);
static const System::Int8 CheckMargin = System::Int8(0x2);
static const System::Int8 CheckBoxSize = System::Int8(0xf);
static const System::Word crDragSingleNo = System::Word(0x4e21);
static const System::Word crDragSingleMove = System::Word(0x4e22);
static const System::Word crDragSingleCopy = System::Word(0x4e23);
extern DELPHI_PACKAGE System::StaticArray<int, 2> MultiLineFlags;
extern DELPHI_PACKAGE System::StaticArray<System::StaticArray<int, 2>, 2> WordWrapFlags;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* LeafBmp;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* PlusBmp;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* MinusBmp;
}	/* namespace Eltree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREE)
using namespace Eltree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreeHPP
