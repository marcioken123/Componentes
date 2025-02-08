// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXTreeCell.pas' rev: 31.00 (Windows)

#ifndef ElxtreecellHPP
#define ElxtreecellHPP

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
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <System.Variants.hpp>
#include <Winapi.ActiveX.hpp>
#include <ElStyleMan.hpp>
#include <ElHook.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHeader.hpp>
#include <ElSBCtrl.hpp>
#include <ElScrollBar.hpp>
#include <ElHintWnd.hpp>
#include <ElInputProcessor.hpp>
#include <ElIni.hpp>
#include <ElImgFrm.hpp>
#include <ElDragDrop.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElVCLUtils.hpp>
#include <LMDClass.hpp>
#include <LMDObjectList.hpp>
#include <LMDStrings.hpp>
#include <LMDThemes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGlyphs.hpp>
#include <LMDSysIn.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDElConst.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------
class DELPHICLASS TElXTreeCustomCellRange;

namespace Elxtreecell
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EStyleNotAssigned;
struct TStyleInfo;
class DELPHICLASS TElXTreeViewColorHelper;
class DELPHICLASS TElXCellFont;
class DELPHICLASS TElXCellStyleAncestor;
class DELPHICLASS TElXCellStyleRead;
class DELPHICLASS TElXCellStyle;
class DELPHICLASS TElXCellControl;
class DELPHICLASS TElXCellCheckBox;
class DELPHICLASS TElXCellButtonGlyph;
class DELPHICLASS TElXCellButton;
class DELPHICLASS TElXCellProgressBar;
class DELPHICLASS TElXBaseCell;
class DELPHICLASS TElXCustomTreeCell;
class DELPHICLASS TElXBaseCellRow;
class DELPHICLASS TElXTreeCustomCellRow;
class DELPHICLASS TElXTreeCustomCellRange;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EStyleNotAssigned : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EStyleNotAssigned(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EStyleNotAssigned(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EStyleNotAssigned(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EStyleNotAssigned(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EStyleNotAssigned(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EStyleNotAssigned(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EStyleNotAssigned(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EStyleNotAssigned(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EStyleNotAssigned(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EStyleNotAssigned(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EStyleNotAssigned(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EStyleNotAssigned(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EStyleNotAssigned(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElXTreeCellColorType : unsigned char { cctTextColor, cctTextBackGroundColor, cctCellBackGroundColor, cctBorderSpaceColor, cctStrikedLineColor };

enum DECLSPEC_DENUM TElSTIState : unsigned char { stsCut, stsUnderlined, stsBold, stsItalic, stsExpanded, stsStrikeOut };

typedef System::Set<TElSTIState, TElSTIState::stsCut, TElSTIState::stsStrikeOut> TElSTIStates;

typedef TStyleInfo *PStyleInfo;

struct DECLSPEC_DRECORD TStyleInfo
{
public:
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
	System::Uitypes::TColor FCellBackGroundColor;
	System::Uitypes::TColor FTextBackGroundColor;
	System::Uitypes::TColor FTextColor;
	unsigned FTextFlags;
	Vcl::Graphics::TBitmap* FPicture;
	Elheader::TElFieldType FCellType;
	Elheader::TElSectionStyle FDrawStyle;
	bool FOwnerProps;
	bool FUseBackGroundColor;
	int FFontSize;
	System::Uitypes::TFontStyles FFontStyles;
	System::Classes::TAlignment FTextAlignment;
	System::Uitypes::TColor FBorderSpaceColor;
	Lmdgraph::TLMDBorderSides FBorderSides;
	System::Uitypes::TColor FStrikedLineColor;
	bool FStrikedOutLine;
	int FTag;
	bool FParentColors;
	TElSTIStates FState;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeViewColorHelper : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FRowOvColors;
	Lmdobjectlist::TLMDObjectList* FVisible;
	
public:
	__fastcall TElXTreeViewColorHelper(void);
	__fastcall virtual ~TElXTreeViewColorHelper(void);
	__property bool RowOvColors = {read=FRowOvColors, write=FRowOvColors, nodefault};
	__property Lmdobjectlist::TLMDObjectList* Visible = {read=FVisible};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXCellFont : public Vcl::Graphics::TFont
{
	typedef Vcl::Graphics::TFont inherited;
	
protected:
	TElXCellStyleAncestor* FOwner;
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TElXCellFont(TElXCellStyleAncestor* AOwner);
public:
	/* TFont.Destroy */ inline __fastcall virtual ~TElXCellFont(void) { }
	
};


class PASCALIMPLEMENTATION TElXCellStyleAncestor : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	bool FParentColors;
	TElSTIStates FState;
	bool FIsUpdating;
	int FTag;
	System::Classes::TPersistent* FItem;
	TElXCustomTreeCell* FCell;
	System::Uitypes::TColor FCellBackGroundColor;
	System::Uitypes::TColor FTextBackGroundColor;
	unsigned FTextFlags;
	Elheader::TElFieldType FCellType;
	Elheader::TElSectionStyle FDrawStyle;
	TElXCellControl* FControl;
	bool FUseBackGroundColor;
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
	TElXCellFont* FFont;
	System::Classes::TAlignment FTextAlignment;
	System::Uitypes::TColor FBorderSpaceColor;
	System::Uitypes::TColor FStrikedLineColor;
	bool FStrikedOutLine;
	Lmdgraph::TLMDBorderSides FBorderSides;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall DoChangeEvent(void);
	void __fastcall SetParentColors(const bool Value);
	void __fastcall SetBorderSpaceColor(const System::Uitypes::TColor Value);
	void __fastcall SetStrikedLineColor(const System::Uitypes::TColor Value);
	void __fastcall SetControl(TElXCellControl* newValue);
	int __fastcall GetFontSize(void);
	void __fastcall SetFontSize(int newValue);
	System::Uitypes::TFontStyles __fastcall GetFontStyles(void);
	void __fastcall SetFontStyles(System::Uitypes::TFontStyles newValue);
	System::Uitypes::TFontName __fastcall GetFontName(void);
	void __fastcall SetFontName(System::Uitypes::TFontName newValue);
	void __fastcall SetDrawStyle(Elheader::TElSectionStyle newValue);
	System::Uitypes::TColor __fastcall GetCellBackGroundColor(void);
	void __fastcall SetCellBackGroundColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetTextBackGroundColor(void);
	void __fastcall SetTextBackGroundColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetTextColor(void);
	void __fastcall SetTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetTextFlags(unsigned newValue);
	void __fastcall SetUseBackGroundColor(bool Value);
	void __fastcall SetBorderStyle(Eltreeinplaceeditors::TElItemBorderStyle Value);
	void __fastcall ColumnSizeUpdate(void);
	void __fastcall SetTextAlignment(System::Classes::TAlignment Value);
	System::Classes::TAlignment __fastcall GetTextAlignment(void);
	void __fastcall SetStrikedOutLine(bool Value);
	bool __fastcall GetState(int AIndex);
	void __fastcall SetState(int AIndex, bool AValue);
	
public:
	__fastcall TElXCellStyleAncestor(System::Classes::TPersistent* AItem, TElXCustomTreeCell* ACell);
	__fastcall virtual ~TElXCellStyleAncestor(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Update(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
};


class PASCALIMPLEMENTATION TElXCellStyleRead : public TElXCellStyleAncestor
{
	typedef TElXCellStyleAncestor inherited;
	
public:
	__property bool IsUpdating = {read=FIsUpdating, nodefault};
	__property System::Classes::TPersistent* Item = {read=FItem};
	__property TElXCustomTreeCell* Cell = {read=FCell};
	
__published:
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, nodefault};
	__property bool ParentColors = {read=FParentColors, nodefault};
	__property int Tag = {read=FTag, nodefault};
	__property TElXCellControl* Control = {read=FControl};
	__property System::Uitypes::TColor CellBackGroundColor = {read=GetCellBackGroundColor, nodefault};
	__property System::Uitypes::TColor TextBackGroundColor = {read=GetTextBackGroundColor, nodefault};
	__property System::Uitypes::TColor TextColor = {read=GetTextColor, nodefault};
	__property unsigned TextFlags = {read=FTextFlags, nodefault};
	__property Elheader::TElFieldType CellType = {read=FCellType, default=1};
	__property Elheader::TElSectionStyle DrawStyle = {read=FDrawStyle, nodefault};
	__property int FontSize = {read=GetFontSize, nodefault};
	__property System::Uitypes::TFontStyles FontStyles = {read=GetFontStyles, nodefault};
	__property System::Uitypes::TFontName FontName = {read=GetFontName};
	__property bool UseBackGroundColor = {read=FUseBackGroundColor, nodefault};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, nodefault};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, nodefault};
	__property System::Uitypes::TColor BorderSpaceColor = {read=FBorderSpaceColor, nodefault};
	__property System::Uitypes::TColor StrikedLineColor = {read=FStrikedLineColor, nodefault};
	__property bool StrikedOutLine = {read=FStrikedOutLine, nodefault};
	__property bool Bold = {read=GetState, index=2, nodefault};
	__property bool Underlined = {read=GetState, index=1, nodefault};
	__property bool Italic = {read=GetState, index=3, nodefault};
	__property bool StrikeOut = {read=GetState, index=5, nodefault};
public:
	/* TElXCellStyleAncestor.Create */ inline __fastcall TElXCellStyleRead(System::Classes::TPersistent* AItem, TElXCustomTreeCell* ACell) : TElXCellStyleAncestor(AItem, ACell) { }
	/* TElXCellStyleAncestor.Destroy */ inline __fastcall virtual ~TElXCellStyleRead(void) { }
	
};


class PASCALIMPLEMENTATION TElXCellStyle : public TElXCellStyleRead
{
	typedef TElXCellStyleRead inherited;
	
public:
	__property bool IsUpdating = {read=FIsUpdating, write=FIsUpdating, nodefault};
	__property System::Classes::TPersistent* Owner = {read=FItem};
	__property System::Classes::TPersistent* Item = {read=FItem};
	__property TElXCustomTreeCell* Cell = {read=FCell};
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=FBorderSides, default=15};
	__property bool ParentColors = {read=FParentColors, write=SetParentColors, default=1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property TElXCellControl* Control = {read=FControl, write=SetControl};
	__property System::Uitypes::TColor CellBackGroundColor = {read=GetCellBackGroundColor, write=SetCellBackGroundColor, default=536870911};
	__property System::Uitypes::TColor TextBackGroundColor = {read=GetTextBackGroundColor, write=SetTextBackGroundColor, default=536870911};
	__property System::Uitypes::TColor TextColor = {read=GetTextColor, write=SetTextColor, default=-16777208};
	__property unsigned TextFlags = {read=FTextFlags, write=SetTextFlags, default=34852};
	__property Elheader::TElFieldType CellType = {read=FCellType, write=FCellType, default=1};
	__property Elheader::TElSectionStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property int FontSize = {read=GetFontSize, write=SetFontSize, nodefault};
	__property System::Uitypes::TFontStyles FontStyles = {read=GetFontStyles, write=SetFontStyles, nodefault};
	__property System::Uitypes::TFontName FontName = {read=GetFontName, write=SetFontName};
	__property bool UseBackGroundColor = {read=FUseBackGroundColor, write=SetUseBackGroundColor, default=1};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=0};
	__property System::Uitypes::TColor BorderSpaceColor = {read=FBorderSpaceColor, write=SetBorderSpaceColor, default=-16777211};
	__property System::Uitypes::TColor StrikedLineColor = {read=FStrikedLineColor, write=SetStrikedLineColor, default=536870911};
	__property bool StrikedOutLine = {read=FStrikedOutLine, write=SetStrikedOutLine, default=0};
	__property bool Bold = {read=GetState, write=SetState, index=2, default=0};
	__property bool Underlined = {read=GetState, write=SetState, index=1, default=0};
	__property bool Italic = {read=GetState, write=SetState, index=3, default=0};
	__property bool StrikeOut = {read=GetState, write=SetState, index=5, default=0};
public:
	/* TElXCellStyleAncestor.Create */ inline __fastcall TElXCellStyle(System::Classes::TPersistent* AItem, TElXCustomTreeCell* ACell) : TElXCellStyleRead(AItem, ACell) { }
	/* TElXCellStyleAncestor.Destroy */ inline __fastcall virtual ~TElXCellStyle(void) { }
	
};


class PASCALIMPLEMENTATION TElXCellControl : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Menus::TPopupMenu* FPopupMenu;
	TElXCellStyleAncestor* FOwner;
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
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetBorderWidth(int Value);
	
public:
	virtual void __fastcall TriggerClickEvent(void);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerDblClickEvent(void);
	virtual void __fastcall TriggerMouseMoveEvent(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall PassClicks(void);
	virtual void __fastcall SetControlActive(void);
	virtual void __fastcall Update(void);
	HIDESBASE virtual void __fastcall Assign(TElXCellControl* Source);
	virtual void __fastcall Paint(TElXCustomTreeCell* ACell, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);
	__fastcall virtual TElXCellControl(void);
	__fastcall virtual ~TElXCellControl(void);
	
__published:
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property TElXCellStyleAncestor* Owner = {read=FOwner, write=FOwner};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
};


typedef System::TMetaClass* TElXCellControlClass;

class PASCALIMPLEMENTATION TElXCellCheckBox : public TElXCellControl
{
	typedef TElXCellControl inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	Vcl::Stdctrls::TCheckBoxState FState;
	bool FAllowGrayed;
	Eltreeinplaceeditors::TElCheckBoxType FCheckBoxType;
	void __fastcall SetState(Vcl::Stdctrls::TCheckBoxState newValue);
	void __fastcall SetAllowGrayed(bool newValue);
	bool __fastcall GetChecked(void);
	void __fastcall SetChecked(bool newValue);
	void __fastcall SetAlignment(System::Classes::TAlignment newValue);
	void __fastcall SetCheckBoxType(Eltreeinplaceeditors::TElCheckBoxType newValue);
	
public:
	virtual void __fastcall TriggerClickEvent(void);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Assign(TElXCellControl* Source);
	__fastcall virtual TElXCellCheckBox(void);
	__fastcall virtual ~TElXCellCheckBox(void);
	virtual void __fastcall Paint(TElXCustomTreeCell* ACell, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=SetState, nodefault};
	__property bool Checked = {read=GetChecked, write=SetChecked, nodefault};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, nodefault};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=1};
	__property Eltreeinplaceeditors::TElCheckBoxType CheckBoxType = {read=FCheckBoxType, write=SetCheckBoxType, nodefault};
};


class PASCALIMPLEMENTATION TElXCellButtonGlyph : public Lmdglyphs::TLMDButtonGlyph
{
	typedef Lmdglyphs::TLMDButtonGlyph inherited;
	
public:
	__property ImageList;
	__property ImageIndex = {default=-1};
	__property UseImageList;
public:
	/* TLMDButtonGlyph.Create */ inline __fastcall TElXCellButtonGlyph(void) : Lmdglyphs::TLMDButtonGlyph() { }
	/* TLMDButtonGlyph.Destroy */ inline __fastcall virtual ~TElXCellButtonGlyph(void) { }
	
};


class PASCALIMPLEMENTATION TElXCellButton : public TElXCellControl
{
	typedef TElXCellControl inherited;
	
private:
	TElXCellButtonGlyph* FGlyph;
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
	
public:
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Assign(TElXCellControl* Source);
	__fastcall virtual TElXCellButton(void);
	__fastcall virtual ~TElXCellButton(void);
	virtual void __fastcall Paint(TElXCustomTreeCell* ACell, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property bool UseImageList = {read=GetUseImageList, write=SetUseImageList, nodefault};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool FixClick = {read=FFixClick, write=FFixClick, nodefault};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
};


class PASCALIMPLEMENTATION TElXCellProgressBar : public TElXCellControl
{
	typedef TElXCellControl inherited;
	
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
	
public:
	__fastcall virtual TElXCellProgressBar(void);
	virtual void __fastcall Assign(TElXCellControl* Source);
	virtual void __fastcall Paint(TElXCustomTreeCell* ACell, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual bool __fastcall PassClicks(void);
	
__published:
	__property int MinValue = {read=FMinValue, write=SetMinValue, nodefault};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=100};
	__property int Value = {read=FValue, write=SetValue, nodefault};
	__property System::Uitypes::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777203};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=2};
	__property bool ShowProgressText = {read=FShowProgressText, write=SetShowProgressText, default=1};
	__property System::Uitypes::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777208};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777211};
public:
	/* TElXCellControl.Destroy */ inline __fastcall virtual ~TElXCellProgressBar(void) { }
	
};


enum DECLSPEC_DENUM TJointCellRole : unsigned char { jcrSingle, jcrMaster, jcrSlave };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXBaseCell : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::Classes::TPersistent* FOwner;
	Lmdtypes::TLMDString FText;
	TJointCellRole FJointCellRole;
	TElXBaseCell* FJointCellMaster;
	int FJointRowCount;
	int FJointColumnCount;
	virtual Lmdtypes::TLMDString __fastcall GetText(void);
	virtual void __fastcall SetText(const Lmdtypes::TLMDString AValue);
	virtual TElXBaseCell* __fastcall GetJointRangeMasterCell(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
	virtual int __fastcall GetIndex(void) = 0 ;
	virtual int __fastcall GetRowIndex(void) = 0 ;
	__property System::Classes::TPersistent* Owner = {read=FOwner, write=FOwner};
	
public:
	__fastcall virtual TElXBaseCell(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TElXBaseCell(void);
	virtual System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Join(int ARowCount, int AColumnCount) = 0 ;
	virtual void __fastcall Split(void) = 0 ;
	__property int Index = {read=GetIndex, nodefault};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property TElXBaseCell* JointCellMaster = {read=FJointCellMaster};
	__property TJointCellRole JointCellRole = {read=FJointCellRole, nodefault};
	__property int JointRowCount = {read=FJointRowCount, nodefault};
	__property int JointColumnCount = {read=FJointColumnCount, nodefault};
	__property int RowIndex = {read=GetRowIndex, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXCustomTreeCell : public TElXBaseCell
{
	typedef TElXBaseCell inherited;
	
private:
	Vcl::Graphics::TBitmap* FPicture;
	void __fastcall SetUseOwnStyle(const bool Value);
	bool __fastcall GetUseOwnStyle(void);
	void __fastcall SetHTMLControlsVisible(const bool Value);
	
protected:
	System::Types::TRect FCellRect;
	int FTag;
	bool FUserText;
	bool FSelected;
	System::TObject* FObject;
	int FWidth;
	TElXCellStyle* FOwnStyle;
	TElXCellStyle* FVirtStyle;
	bool FShowCheckBox;
	void *FData;
	bool FUseOwnStyle;
	bool FTextTooLarge;
	bool FHTMLControlsVisible;
	bool __fastcall IsSelected(void);
	void __fastcall SetPicture(Vcl::Graphics::TBitmap* newValue);
	HIDESBASE TElXCustomTreeCell* __fastcall GetJointRangeMasterCell(void);
	virtual int __fastcall GetIndex(void);
	TElXCellControl* __fastcall GetControl(void);
	virtual Lmdtypes::TLMDString __fastcall GetText(void);
	virtual void __fastcall SetText(const Lmdtypes::TLMDString AValue);
	TElXCellStyle* __fastcall GetOwnStyle(void);
	TElXCellStyleRead* __fastcall GetCurrentStyle(void);
	virtual System::Classes::TPersistent* __fastcall GetHeaderSection(void);
	virtual int __fastcall GetAbsoluteRowIndex(void);
	virtual int __fastcall GetRowIndex(void);
	virtual bool __fastcall GetVisible(void);
	virtual int __fastcall GetLeft(void);
	virtual int __fastcall GetTop(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetLeft(const int Value);
	virtual void __fastcall SetTop(const int Value);
	virtual void __fastcall SetHeight(const int Value);
	virtual void __fastcall SetWidth(const int Value);
	virtual void __fastcall SetVisible(const bool Value);
	void __fastcall SetSelected(const bool ASelected);
	void __fastcall SetStyleProps(Vcl::Graphics::TCanvas* const ACanvas, TElXCellStyleRead* const AStyle);
	void __fastcall SetSelDropColors(Vcl::Graphics::TCanvas* const ACanvas);
	void __fastcall SetRowDragColors(Vcl::Graphics::TCanvas* const ACanvas);
	void __fastcall NoStylesItemDraw(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ARect, TElXCellStyleRead* AStyle, bool AUsePartialCheck = true);
	void __fastcall CalcTextRect(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ATextRect, System::Types::TRect &AR, const Lmdtypes::TLMDString AText, bool AUsePartialCheck = true);
	void __fastcall SetHtmlProps(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ATextRect, const Lmdtypes::TLMDString AText, const System::Types::TRect &ARect, bool AUsePartialCheck = true);
	void __fastcall HtmlOutput(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ATextRect, const System::Types::TRect &AR, const System::Types::TRect &AR1, const int AVAlign, bool AUsePartialCheck = true);
	void __fastcall NonHtmlOutput(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ATextRect, const System::Types::TRect &AR, const System::Types::TRect &AR1, const int AVAlign, const int AHAlign, const Lmdtypes::TLMDString AText);
	void __fastcall SetStyledFontProps(Vcl::Graphics::TCanvas* const ACanvas, TElXCellStyleRead* const ACurStyle);
	void __fastcall SetSelItemColors(Vcl::Graphics::TCanvas* const ACanvas);
	void __fastcall SetDropTrgItemColors(Vcl::Graphics::TCanvas* const ACanvas);
	void __fastcall AdjustTextRect(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ATextRect, System::Types::TRect &AR, const System::Types::TRect &AItemWholeRect, const int AHAlign, int &AVAlign);
	void __fastcall PictureOutput(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect);
	void __fastcall TreeLinesOffsetRect(System::Types::TRect &R);
	void __fastcall DrawNodeButtons(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ARect);
	void __fastcall DrawItemCheckBox(Vcl::Graphics::TCanvas* const ACanvas, Vcl::Graphics::TBitmap* ABitmap, System::Types::TRect &ARect);
	void __fastcall DrawItemImages(Vcl::Graphics::TCanvas* const ACanvas, Vcl::Graphics::TBitmap* ABitmap, System::Types::TRect &ARect);
	void __fastcall DrawBox(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, TElXCellStyleRead* const AStyle);
	void __fastcall DrawCellBk(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, int AAbsIndex = 0xffffffff, int AVisIndex = 0xffffffff);
	void __fastcall DrawFocusedCellBk(Vcl::Graphics::TCanvas* const ACanvas, const int APosition, System::Types::TRect &ARect);
	void __fastcall DrawCellBorders(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect);
	void __fastcall DrawCellTextLocal(Vcl::Graphics::TCanvas* const ACanvas, System::Types::TRect &ARect, bool AUsePartialCheck = true);
	void __fastcall DrawVerticalLines(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, TElXCellStyleRead* ACurStyle);
	void __fastcall DrawHorizontalLines(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, TElXCellStyleRead* ACurStyle);
	void __fastcall PaintStrikedOutLine(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect);
	__property bool Selected = {read=FSelected, write=SetSelected, nodefault};
	__property TElXCellControl* Control = {read=GetControl};
	__property TElXCellStyle* Style = {read=GetOwnStyle};
	__property System::Classes::TPersistent* HeaderSection = {read=GetHeaderSection};
	__property bool UserText = {read=FUserText, write=FUserText, nodefault};
	__property bool UseOwnStyle = {read=GetUseOwnStyle, write=SetUseOwnStyle, nodefault};
	HIDESBASE void __fastcall LoadFromStream(System::Classes::TStream* Stream, int ver);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
	TElXCustomTreeCell* __fastcall GetJointCellMaster(void);
	__property TElXCellStyleRead* CurrentStyle = {read=GetCurrentStyle};
	
public:
	__fastcall virtual TElXCustomTreeCell(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TElXCustomTreeCell(void);
	virtual void __fastcall Assign(TElXCustomTreeCell* Source);
	virtual void __fastcall Join(int ARowCount, int AColumnCount);
	virtual void __fastcall Split(void);
	virtual void __fastcall Paint(Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, bool AUsePartialCheck = true, int AAbsIndex = 0xffffffff, int AVisIndex = 0xffffffff);
	TElXCellControl* __fastcall CreateControl(TElXCellControlClass AControlClass);
	__property TElXCustomTreeCell* JointCellMaster = {read=GetJointCellMaster};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
	__property System::TObject* CellObject = {read=FObject, write=FObject};
	__property int AbsoluteRowIndex = {read=GetAbsoluteRowIndex, nodefault};
	__property int Top = {read=GetTop, write=SetTop, nodefault};
	__property int Left = {read=GetLeft, write=SetLeft, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property Vcl::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property System::Types::TRect CellRect = {read=FCellRect, write=FCellRect};
	__property bool HTMLControlsVisible = {read=FHTMLControlsVisible, write=SetHTMLControlsVisible, default=1};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXBaseCellRow : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	TElXBaseCell* operator[](int AIndex) { return this->Cell[AIndex]; }
	
protected:
	virtual TElXBaseCell* __fastcall GetCell(int AIndex);
	virtual int __fastcall IntGetCount(void);
	int __fastcall GetCount(void);
	__fastcall TElXBaseCellRow(void);
	__property TElXBaseCell* Cell[int AIndex] = {read=GetCell/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	
public:
	virtual void __fastcall Delete(int AIndex);
	HIDESBASE virtual int __fastcall IndexOf(TElXBaseCell* ACell);
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElXBaseCellRow(void) { }
	
};


class PASCALIMPLEMENTATION TElXTreeCustomCellRow : public TElXBaseCellRow
{
	typedef TElXBaseCellRow inherited;
	
public:
	TElXCustomTreeCell* operator[](int AIndex) { return this->Cell[AIndex]; }
	
protected:
	HIDESBASE TElXCustomTreeCell* __fastcall GetCell(int AIndex);
	__property TElXCustomTreeCell* Cell[int AIndex] = {read=GetCell/*, default*/};
	
public:
	HIDESBASE int __fastcall IndexOf(TElXCustomTreeCell* ACell);
protected:
	/* TElXBaseCellRow.Create */ inline __fastcall TElXTreeCustomCellRow(void) : TElXBaseCellRow() { }
	
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElXTreeCustomCellRow(void) { }
	
};


class PASCALIMPLEMENTATION TElXTreeCustomCellRange : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
protected:
	int FRowStart;
	int FRowEnd;
	int FColStart;
	int FColEnd;
	
public:
	void __fastcall Split(void);
	bool __fastcall CanSplit(void);
	bool __fastcall CanMerge(void);
	void __fastcall CheckBorderValues(void);
	__property int RowStart = {read=FRowStart, nodefault};
	__property int RowEnd = {read=FRowEnd, nodefault};
	__property int ColStart = {read=FColStart, nodefault};
	__property int ColEnd = {read=FColEnd, nodefault};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElXTreeCustomCellRange(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElXTreeCustomCellRange(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word CDefaultTextFlags = System::Word(0x8824);
extern DELPHI_PACKAGE void __fastcall DrawFlatCheckboxFrame(Vcl::Controls::TCustomControl* ATree, HDC DC, const System::Types::TRect &R, bool Enabled);
extern DELPHI_PACKAGE void __fastcall DrawFlatRadioButtonFrame(Vcl::Controls::TCustomControl* ATree, HDC DC, const System::Types::TRect &R, bool Enabled);
extern DELPHI_PACKAGE void __fastcall DrawCellFrame(TElXCustomTreeCell* Cell, Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect, unsigned grfFlags, bool IsDot = false, bool CheckMaster = false);
}	/* namespace Elxtreecell */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXTREECELL)
using namespace Elxtreecell;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxtreecellHPP
