// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSGraphics.pas' rev: 31.00 (Windows)

#ifndef JsgraphicsHPP
#define JsgraphicsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <JSTypes.hpp>
#include <Vcl.GraphUtil.hpp>
#include <JSGraphUtil.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsgraphics
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSLinkRects;
class DELPHICLASS TJSLinkRect;
class DELPHICLASS TJSLinkInfo;
class DELPHICLASS TJSCaption;
class DELPHICLASS TJSPoint;
class DELPHICLASS TJSCustomCaptionControl;
class DELPHICLASS TJSCaptionControl;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSLinkRects : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Types::TRect operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Contnrs::TObjectList* FLinkRects;
	System::Types::TRect __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const System::Types::TRect &Value);
	bool __fastcall IsUnique(const System::Types::TRect &aRect);
	
public:
	__fastcall TJSLinkRects(void);
	__fastcall virtual ~TJSLinkRects(void);
	void __fastcall Add(const System::Types::TRect &aRect);
	void __fastcall Clear(void);
	bool __fastcall InLink(const int X, const int Y);
	int __fastcall Count(void);
	__property System::Types::TRect Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSLinkRect : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Types::TRect FRect;
	
public:
	__fastcall TJSLinkRect(const System::Types::TRect &aRect);
	__property System::Types::TRect Rect = {read=FRect, write=FRect};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TJSLinkRect(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSLinkInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString Text;
	System::UnicodeString Link;
	__fastcall TJSLinkInfo(const System::UnicodeString aText, const System::UnicodeString aLink);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TJSLinkInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSCaption : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TJSLinkRects* FLinkRects;
	TJSLinkInfo* FLinkInfo;
	Jstypes::TJSBackground* FBackground;
	System::UnicodeString FCaption;
	Vcl::Graphics::TCanvas* FCanvas;
	System::UnicodeString FRawCaption;
	System::Classes::TStringList* FCaptionSegments;
	int FWidth;
	int FHeight;
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FLinkFont;
	int FLeft;
	int FTop;
	System::Types::TPoint FOffSet;
	bool FTreatAsLink;
	System::Classes::TBiDiMode FBidiMode;
	Vcl::Controls::TControl* FControl;
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall GetFormatingForSegment(int &AUPos, int &APosEnd, /* out */ bool &AIsUnderline, /* out */ bool &AIsBold, System::UnicodeString ACaption, int &APos, int &AIPos, /* out */ bool &AIsItalic, int &ALPos, /* out */ bool &AIsLink);
	void __fastcall SetBackground(Jstypes::TJSBackground* const Value);
	void __fastcall SetLinkFont(Vcl::Graphics::TFont* const Value);
	
protected:
	int FRequiredHeight;
	virtual void __fastcall ParseCaption(void);
	void __fastcall PaintCaption(const bool ADoPaint)/* overload */;
	
public:
	__fastcall virtual TJSCaption(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Jstypes::TJSBackground* const ABackground, Vcl::Graphics::TFont* const AFont, const int AHeight, const int AWidth, const System::Types::TPoint &AOffSet, Vcl::Controls::TControl* AControl, const System::Classes::TBiDiMode ABiDiMode);
	__fastcall virtual ~TJSCaption(void);
	System::Types::TRect __fastcall GetLinkRect(const int AIndex);
	int __fastcall LinkRectCount(void);
	bool __fastcall MouseInLink(const int AX, const int AY);
	__classmethod void __fastcall PaintCaption(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Jstypes::TJSBackground* ABackground, Vcl::Graphics::TFont* const AFont, const int ALeft, const int ATop, const int AWidth, const int AHeight, const System::Types::TPoint &AOffSet, Vcl::Controls::TControl* AControl, const System::Classes::TBiDiMode BiDiMode)/* overload */;
	__classmethod void __fastcall PaintCaption(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Jstypes::TJSBackground* ABackground, Vcl::Graphics::TFont* const AFont, const System::Types::TRect &ARect, const System::Types::TPoint &AOffSet)/* overload */;
	__classmethod void __fastcall PaintCaption(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Jstypes::TJSBackground* ABackground, Vcl::Graphics::TFont* const AFont, const System::Types::TRect &ARect)/* overload */;
	__classmethod void __fastcall PaintCaption(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Jstypes::TJSBackground* ABackground, Vcl::Graphics::TFont* const AFont, const System::Types::TRect &ARect, Vcl::Controls::TControl* AControl, const System::Classes::TBiDiMode BiDiMode)/* overload */;
	__classmethod int __fastcall MinimumHeight(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Vcl::Graphics::TFont* const AFont, const int AWidth);
	__classmethod int __fastcall MinimumWidth(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Vcl::Graphics::TFont* const AFont, const int AWidth);
	__classmethod System::Types::TRect __fastcall TranslateRect(const System::Types::TRect &ARect);
	virtual void __fastcall Paint(void);
	__property Jstypes::TJSBackground* Background = {read=FBackground, write=SetBackground};
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Vcl::Graphics::TFont* LinkFont = {read=FLinkFont, write=SetLinkFont};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property bool TreatAsLink = {read=FTreatAsLink, write=FTreatAsLink, nodefault};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TJSLinkClickEvent)(System::TObject* Sender, const System::UnicodeString Link, bool &Handled);

class PASCALIMPLEMENTATION TJSPoint : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FX;
	int FY;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	
protected:
	virtual void __fastcall DoChange(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall TJSPoint(void);
	System::Types::TPoint __fastcall AsPoint(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property int X = {read=FX, write=SetX, default=0};
	__property int Y = {read=FY, write=SetY, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSPoint(void) { }
	
};


class PASCALIMPLEMENTATION TJSCustomCaptionControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	TJSCaption* FCaption;
	System::Classes::TStringList* FText;
	Vcl::Graphics::TFont* FLinkFont;
	TJSLinkClickEvent FOnLinkClick;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Jstypes::TJSBackground* FBackground;
	TJSPoint* FOffSet;
	bool FAutoSize;
	bool FTreatAsLink;
	void __fastcall LinkFontChanged(System::TObject* Sender);
	void __fastcall OffSetChanged(System::TObject* Sender);
	HIDESBASE void __fastcall SetText(System::Classes::TStringList* const Value);
	void __fastcall SetLinkFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetBorderStyle(const Vcl::Forms::TBorderStyle Value);
	void __fastcall SetOffSet(TJSPoint* const Value);
	void __fastcall TextChangedHandler(System::TObject* Sender);
	void __fastcall SetTreatAsLink(const bool Value);
	void __fastcall SetBackground(Jstypes::TJSBackground* const Value);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	bool __fastcall CanUseLink(void);
	DYNAMIC void __fastcall Click(void);
	HIDESBASE MESSAGE void __fastcall CMColorchanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontchanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DoLinkClick(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=1};
	__property Jstypes::TJSBackground* Background = {read=FBackground, write=SetBackground};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Vcl::Graphics::TFont* LinkFont = {read=FLinkFont, write=SetLinkFont};
	__property System::Classes::TStringList* Text = {read=FText, write=SetText};
	__property TJSLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property TJSPoint* OffSet = {read=FOffSet, write=SetOffSet};
	__property bool TreatAsLink = {read=FTreatAsLink, write=SetTreatAsLink, nodefault};
	
public:
	__fastcall virtual TJSCustomCaptionControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomCaptionControl(void);
	bool __fastcall HasLinks(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomCaptionControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSCaptionControl : public TJSCustomCaptionControl
{
	typedef TJSCustomCaptionControl inherited;
	
public:
	__property OnClick;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoSize = {default=1};
	__property Background;
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Font;
	__property Height;
	__property LinkFont;
	__property OffSet;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property TabStop = {default=1};
	__property Text;
	__property TreatAsLink = {default=0};
	__property Visible = {default=1};
	__property Width;
public:
	/* TJSCustomCaptionControl.Create */ inline __fastcall virtual TJSCaptionControl(System::Classes::TComponent* AOwner) : TJSCustomCaptionControl(AOwner) { }
	/* TJSCustomCaptionControl.Destroy */ inline __fastcall virtual ~TJSCaptionControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCaptionControl(HWND ParentWindow) : TJSCustomCaptionControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Types::TRect EmptyRect;
extern DELPHI_PACKAGE System::Types::TPoint EmptyPoint;
static const System::Word crJSHand = System::Word(0xc34);
}	/* namespace Jsgraphics */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSGRAPHICS)
using namespace Jsgraphics;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsgraphicsHPP
