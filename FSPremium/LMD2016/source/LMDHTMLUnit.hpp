// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLUnit.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlunitHPP
#define LmdhtmlunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <LMDList.hpp>
#include <LMDStack.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDHookComponent.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLItem;
class DELPHICLASS TLMDHTMLBreakItem;
class DELPHICLASS TLMDHTMLControlPainter;
class DELPHICLASS TLMDHTMLCheckBoxPainter;
class DELPHICLASS TLMDHTMLInputItem;
class DELPHICLASS TLMDHTMLControlItem;
class DELPHICLASS TLMDHTMLData;
class DELPHICLASS TLMDHTMLRender;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDHTMLVariableNeededEvent)(System::TObject* Sender, const Lmdtypes::TLMDString aVarName, Lmdtypes::TLMDString &aVarValue);

typedef void __fastcall (__closure *TLMDHTMLImageNeededEvent)(System::TObject* Sender, Lmdtypes::TLMDString SourceName, Vcl::Graphics::TPicture* Image);

typedef void __fastcall (__closure *TLMDHTMLLinkClickEvent)(System::TObject* Sender, Lmdtypes::TLMDString HRef);

typedef void __fastcall (__closure *TLMDHTMLControlCreatedEvent)(System::TObject* Sender, Vcl::Controls::TControl* aControl);

typedef void __fastcall (__closure *TLMDHTMLControlPositionNeededEvent)(System::TObject* Sender, Vcl::Controls::TControl* aControl, void * aData, int &X, int &Y);

typedef void __fastcall (__closure *TLMDHTMLControlVisibilityNeededEvent)(System::TObject* Sender, Vcl::Controls::TControl* aControl, void * aData, bool &aVisible);

typedef void __fastcall (__closure *TLMDHTMLTagFoundEvent)(System::TObject* Sender, Lmdtypes::TLMDString &Tag, TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);

typedef void __fastcall (__closure *TElHTMLImageNeededEvent)(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);

typedef void __fastcall (__closure *TElHTMLLinkClickEvent)(System::TObject* Sender, Lmdtypes::TLMDString HRef);

typedef void __fastcall (__closure *TElHTMLLinkOverEvent)(System::TObject* Sender, Lmdtypes::TLMDString HRef, int X, int Y);

enum DECLSPEC_DENUM TLMDHTMLItemType : unsigned char { hitChar, hitSoftBreak, hitBreak, hitPara, hitBitmap, hitHR, hitLI, hitUL, hitOL, hitIndent, hitInput, hitControl, hitVar };

enum DECLSPEC_DENUM TLMDHTMLInputType : unsigned char { itCheckBox, itRadioButton };

typedef void __fastcall (__closure *TLMDHTMLInputItemChangedEvent)(System::TObject* Sender, TLMDHTMLInputItem* InputItem);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDHTMLData* FOwner;
	TLMDHTMLItemType FItemType;
	Lmdtypes::TLMDString FText;
	System::Uitypes::TFontStyles FontStyle;
	int FontHeight;
	System::Uitypes::TColor FontBgColor;
	System::Uitypes::TColor FontColor;
	Lmdtypes::TLMDString FLinkRef;
	Lmdtypes::TLMDString FFontRef;
	int FFntCnt;
	System::Word FTWidth;
	System::Word FWidth;
	System::Word FHeight;
	int FIndent;
	int FBoolState;
	bool FTransparent;
	int FTag;
	bool __fastcall GetIsLink(void);
	void __fastcall SetIsLink(bool Value);
	bool __fastcall GetIsSub(void);
	void __fastcall SetIsSub(bool Value);
	bool __fastcall GetIsSuper(void);
	void __fastcall SetIsSuper(bool Value);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GenerateHTML(void);
	
public:
	void __fastcall Assign(TLMDHTMLItem* Source);
	__fastcall virtual TLMDHTMLItem(TLMDHTMLData* Owner);
	__fastcall virtual ~TLMDHTMLItem(void);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(int &BaseLine);
	__property bool IsLink = {read=GetIsLink, write=SetIsLink, nodefault};
	__property bool IsSub = {read=GetIsSub, write=SetIsSub, nodefault};
	__property bool IsSuper = {read=GetIsSuper, write=SetIsSuper, nodefault};
	__property Lmdtypes::TLMDString LinkRef = {read=FLinkRef, write=FLinkRef};
	__property Lmdtypes::TLMDString Text = {read=FText, write=FText};
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property TLMDHTMLItemType ItemType = {read=FItemType, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLBreakItem : public TLMDHTMLItem
{
	typedef TLMDHTMLItem inherited;
	
private:
	int FParams;
	int FListLevel;
	int FListItemN;
	
public:
	virtual int __fastcall GetHeight(int &BaseLine);
	virtual int __fastcall GetWidth(void);
	HIDESBASE void __fastcall Assign(TLMDHTMLItem* Source);
	void __fastcall AssignBreakProps(TLMDHTMLBreakItem* Source);
	__fastcall virtual TLMDHTMLBreakItem(TLMDHTMLData* Owner);
public:
	/* TLMDHTMLItem.Destroy */ inline __fastcall virtual ~TLMDHTMLBreakItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLControlPainter : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDHTMLInputItem* FInputItem;
	
public:
	__fastcall TLMDHTMLControlPainter(TLMDHTMLInputItem* AInputItem);
	virtual void __fastcall PaintTo(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHTMLControlPainter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLCheckBoxPainter : public TLMDHTMLControlPainter
{
	typedef TLMDHTMLControlPainter inherited;
	
public:
	virtual void __fastcall PaintTo(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect);
public:
	/* TLMDHTMLControlPainter.Create */ inline __fastcall TLMDHTMLCheckBoxPainter(TLMDHTMLInputItem* AInputItem) : TLMDHTMLControlPainter(AInputItem) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHTMLCheckBoxPainter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLInputItem : public TLMDHTMLItem
{
	typedef TLMDHTMLItem inherited;
	
protected:
	bool FChecked;
	TLMDHTMLInputType FInputType;
	Lmdtypes::TLMDString FName;
	Lmdtypes::TLMDString FValue;
	TLMDHTMLControlPainter* FControlPainter;
	void __fastcall ReCreateControlPainter(void);
	void __fastcall SetInputType(TLMDHTMLInputType Value);
	void __fastcall ProcessAtributes(System::Classes::TStringList* AList);
	void __fastcall SetChecked(bool AValue);
	void __fastcall SetValue(Lmdtypes::TLMDString AValue);
	virtual Lmdtypes::TLMDString __fastcall GenerateHTML(void);
	
public:
	__fastcall virtual TLMDHTMLInputItem(TLMDHTMLData* Owner);
	void __fastcall Click(void);
	__fastcall virtual ~TLMDHTMLInputItem(void);
	void __fastcall KeyDownTransfer(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE void __fastcall Assign(TLMDHTMLItem* Source);
	__property bool Checked = {read=FChecked, write=SetChecked, nodefault};
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property Lmdtypes::TLMDString Value = {read=FValue, write=SetValue};
	__property TLMDHTMLInputType InputType = {read=FInputType, write=SetInputType, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLControlItem : public TLMDHTMLItem
{
	typedef TLMDHTMLItem inherited;
	
private:
	Vcl::Controls::TControl* __fastcall GetControl(void);
	
protected:
	Lmdhookcomponent::TLMDHookComponent* FControlHook;
	Lmdtypes::TLMDString FControlClass;
	System::Classes::TStringList* FControlPropList;
	Vcl::Controls::TControl* FControl;
	void __fastcall ProcessAtributes(System::Classes::TStringList* AList);
	void __fastcall BeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	virtual Lmdtypes::TLMDString __fastcall GenerateHTML(void);
	
public:
	__fastcall virtual TLMDHTMLControlItem(TLMDHTMLData* Owner);
	__fastcall virtual ~TLMDHTMLControlItem(void);
	HIDESBASE void __fastcall Assign(TLMDHTMLItem* Source);
	__property Vcl::Controls::TControl* Control = {read=GetControl};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLData : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	Lmdlist::TLMDList* FArray;
	Lmdlist::TLMDList* FControlsArray;
	System::Classes::TStringList* FRadioList;
	TLMDHTMLRender* FRender;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TColor FDefaultColor;
	System::Uitypes::TFontStyles FLinkStyle;
	System::Uitypes::TFontStyles FDefaultStyle;
	int FDefaultHeight;
	System::Uitypes::TFontCharset FCharset;
	System::UnicodeString FDefaultFont;
	int FLineSpacing;
	int FLineGap;
	int FMaxWidth;
	System::Uitypes::TColor FDefaultBgColor;
	System::Uitypes::TColor FHighlightBgColor;
	System::Uitypes::TColor FHighlightColor;
	TLMDHTMLItem* FSelectedItem;
	System::Types::TRect FRect;
	System::Types::TSize FTextSize;
	TLMDHTMLInputItem* FActiveItem;
	int FHOffset;
	int FVOffset;
	void *FAuxData;
	int FHTMLTabWidth;
	void __fastcall SetSelectedItem(TLMDHTMLItem* const Value);
	void __fastcall SetActiveItem(TLMDHTMLInputItem* const Value);
	int __fastcall GetItemCount(void);
	TLMDHTMLItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TLMDHTMLData(void);
	__fastcall virtual ~TLMDHTMLData(void);
	void __fastcall ClearArray(void);
	__property Lmdlist::TLMDList* ControlsArray = {read=FControlsArray};
	int __fastcall LineCount(void);
	__property int ItemCount = {read=GetItemCount, nodefault};
	__property TLMDHTMLItem* Item[int Index] = {read=GetItem};
	Lmdtypes::TLMDString __fastcall GenerateHTML(void);
	__property System::Types::TSize TextSize = {read=FTextSize};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=FLinkColor, nodefault};
	__property System::Uitypes::TColor DefaultBgColor = {read=FDefaultBgColor, write=FDefaultBgColor, nodefault};
	__property System::Uitypes::TColor DefaultColor = {read=FDefaultColor, write=FDefaultColor, nodefault};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=FLinkStyle, nodefault};
	__property int LineSpacing = {read=FLineSpacing, write=FLineSpacing, nodefault};
	__property int LineGap = {read=FLineGap, write=FLineGap, nodefault};
	__property System::Uitypes::TFontStyles DefaultStyle = {read=FDefaultStyle, write=FDefaultStyle, nodefault};
	__property int DefaultHeight = {read=FDefaultHeight, write=FDefaultHeight, nodefault};
	__property System::UnicodeString DefaultFont = {read=FDefaultFont, write=FDefaultFont};
	__property System::Uitypes::TFontCharset Charset = {read=FCharset, write=FCharset, nodefault};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, nodefault};
	__property System::Uitypes::TColor HighlightBgColor = {read=FHighlightBgColor, write=FHighlightBgColor, nodefault};
	__property System::Uitypes::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, nodefault};
	__property TLMDHTMLItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property System::Types::TRect Rect = {read=FRect, write=FRect};
	__property TLMDHTMLInputItem* ActiveItem = {read=FActiveItem, write=SetActiveItem};
	__property int HOffset = {read=FHOffset, write=FHOffset, nodefault};
	__property int VOffset = {read=FVOffset, write=FVOffset, nodefault};
	__property void * AuxData = {read=FAuxData, write=FAuxData};
	__property int HTMLTabWidth = {read=FHTMLTabWidth, write=FHTMLTabWidth, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDHTMLRender : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FLinkSelect;
	Lmdhookcomponent::TLMDHookComponent* FHook;
	TLMDHTMLImageNeededEvent FOnImageNeededEx;
	TElHTMLImageNeededEvent FOnImageNeeded;
	int FCurListItem;
	TLMDHTMLData* FIntData;
	TLMDHTMLData* FData;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Graphics::TBitmap* FBitmap;
	HGDIOBJ FSaveObj;
	System::Classes::TNotifyEvent FOnChange;
	TLMDHTMLInputItemChangedEvent FOnInputItemChecked;
	TLMDHTMLInputItemChangedEvent FOnInputItemTextChanged;
	TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	TLMDHTMLControlPositionNeededEvent FOnAdjustControlPosition;
	TLMDHTMLControlVisibilityNeededEvent FOnSetControlVisibility;
	TLMDHTMLControlCreatedEvent FOnControlCreated;
	TLMDHTMLTagFoundEvent FOnTagFound;
	Vcl::Controls::TControl* __fastcall GetControl(void);
	void __fastcall SetControl(Vcl::Controls::TControl* const Value);
	
protected:
	bool FDoubleBuffered;
	void __fastcall CalcTokenSizes(TLMDHTMLData* FCurData);
	TLMDHTMLItem* __fastcall FindItemAt(const System::Types::TPoint &Point, const System::Types::TPoint &SrcPoint, const System::Types::TRect &R);
	System::Types::TSize __fastcall GetTextSize(void);
	virtual void __fastcall TriggerImageNeededEvent(Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image)/* overload */;
	virtual void __fastcall TriggerImageNeededEvent(Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image)/* overload */;
	void __fastcall TriggerInputItemChecked(TLMDHTMLInputItem* InputItem);
	void __fastcall TriggerInputItemTextChanged(TLMDHTMLInputItem* InputItem);
	void __fastcall TriggerVariableNeededEvent(Lmdtypes::TLMDString aName, Lmdtypes::TLMDString &aValue);
	void __fastcall TriggerAdjustControlPositionEvent(Vcl::Controls::TControl* aControl, void * aData, int &X, int &Y);
	void __fastcall TriggerControlVisibilityNeededEvent(Vcl::Controls::TControl* aControl, void * aData, bool &aVisible);
	void __fastcall TriggerControlCreated(Vcl::Controls::TControl* aControl);
	virtual void __fastcall TriggerTagFound(Lmdtypes::TLMDString &Tag, TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	void __fastcall BeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	
public:
	Lmdtypes::TLMDString __fastcall AsText(void);
	__fastcall TLMDHTMLRender(void);
	TLMDHTMLData* __fastcall CreateData(void);
	__fastcall virtual ~TLMDHTMLRender(void);
	void __fastcall DestroyData(TLMDHTMLData* Data);
	void __fastcall Change(void);
	void __fastcall DrawText(Vcl::Graphics::TCanvas* Canvas, const System::Types::TPoint &SrcPoint, const System::Types::TRect &R, System::Uitypes::TColor AdjustFromColor);
	void __fastcall DrawTextEx(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &ASrcPoint, const System::Types::TRect &AR, bool UseOverColors, System::Uitypes::TColor AColor, System::Uitypes::TColor ABkColor, System::Uitypes::TColor ASelColor, System::Uitypes::TColor ASelBkColor, System::Uitypes::TColor AAdjustFromColor);
	bool __fastcall IsCursorOverLink(const System::Types::TPoint &Point, const System::Types::TPoint &SrcPoint, const System::Types::TRect &R, Lmdtypes::TLMDString &href);
	void __fastcall PrepareText(const Lmdtypes::TLMDString Text, int MaxWidth, bool AutoWrap);
	void __fastcall PrepareToData(const Lmdtypes::TLMDString Text, int MaxWidth, bool AutoWrap, TLMDHTMLData* &CurData);
	void __fastcall SetDC(HDC DC);
	void __fastcall SetData(TLMDHTMLData* NewData);
	void __fastcall SelectLinkAt(const System::Types::TPoint &Point, const System::Types::TPoint &SrcPoint, const System::Types::TRect &R);
	void __fastcall SelectNextLink(void);
	void __fastcall SelectPrevLink(void);
	void __fastcall SelectNextSuitableItem(void);
	void __fastcall SelectPrevSuitableItem(void);
	TLMDHTMLInputItem* __fastcall FindInputItemByName(Lmdtypes::TLMDString AName, TLMDHTMLItem* const FindFrom = (TLMDHTMLItem*)(0x0));
	void __fastcall MouseMoveTransfer(System::Classes::TShiftState Shift, int X, int Y, const System::Types::TRect &R);
	void __fastcall ClickTransfer(int X, int Y, const System::Types::TRect &R);
	void __fastcall KeyDownTransfer(System::Word &Key, System::Classes::TShiftState Shift);
	__property TLMDHTMLData* Data = {read=FData};
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=FDoubleBuffered, default=1};
	__property TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property TLMDHTMLImageNeededEvent OnImageNeededEx = {read=FOnImageNeededEx, write=FOnImageNeededEx};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDHTMLInputItemChangedEvent OnInputItemChecked = {read=FOnInputItemChecked, write=FOnInputItemChecked};
	__property TLMDHTMLInputItemChangedEvent OnInputItemTextChanged = {read=FOnInputItemTextChanged, write=FOnInputItemTextChanged};
	__property TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property TLMDHTMLControlPositionNeededEvent OnAdjustControlPosition = {read=FOnAdjustControlPosition, write=FOnAdjustControlPosition};
	__property TLMDHTMLControlVisibilityNeededEvent OnSetControlVisibility = {read=FOnSetControlVisibility, write=FOnSetControlVisibility};
	__property TLMDHTMLControlCreatedEvent OnControlCreated = {read=FOnControlCreated, write=FOnControlCreated};
	__property TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property Vcl::Controls::TControl* Control = {read=GetControl, write=SetControl};
	__property bool LinkSelect = {read=FLinkSelect, write=FLinkSelect, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 flIsLink = System::Int8(0x1);
static const System::Int8 flSub = System::Int8(0x2);
static const System::Int8 flSuper = System::Int8(0x4);
static const System::Int8 flAbsInd = System::Int8(0x8);
static const unsigned flIsParE = unsigned(0x80000000);
#define def_LMDLinkStyle (System::Set<System::Uitypes::TFontStyle, _DELPHI_SET_ENUMERATOR(System::Uitypes::TFontStyle::fsBold), _DELPHI_SET_ENUMERATOR(System::Uitypes::TFontStyle::fsStrikeOut)>() << System::Uitypes::TFontStyle::fsUnderline )
static const int def_LMDLinkColor = int(16711680);
extern DELPHI_PACKAGE void __fastcall InitHTMLRender(void);
extern DELPHI_PACKAGE int __fastcall LMDHTMLDrawText(Vcl::Graphics::TCanvas* Canvas, System::UnicodeString szStr, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState uFlags, int LineGap, bool bCalcOnly = false)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDHTMLDrawText(Vcl::Graphics::TCanvas* Canvas, System::UnicodeString szStr, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState uFlags, bool bCalcOnly = false)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDColorToRGB(System::Uitypes::TColor aValue);
extern DELPHI_PACKAGE System::WideChar __fastcall SpecialCharsFunc(System::UnicodeString aText);
}	/* namespace Lmdhtmlunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLUNIT)
using namespace Lmdhtmlunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlunitHPP
