// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sLabel.pas' rev: 27.00 (Windows)

#ifndef SlabelHPP
#define SlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sMessages.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Slabel
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsShadowMode : unsigned char { smNone, smCustom, smSkin1 };

enum DECLSPEC_DENUM TsKindType : unsigned char { ktStandard, ktCustom, ktSkin };

class DELPHICLASS TsCustomLabel;
class PASCALIMPLEMENTATION TsCustomLabel : public Vcl::Stdctrls::TCustomLabel
{
	typedef Vcl::Stdctrls::TCustomLabel inherited;
	
private:
	System::Classes::TNotifyEvent FOnMouseLeave;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::UnicodeString FSkinSection;
	Sskinmanager::TsSkinManager* FSkinManager;
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	void __fastcall SetSkinManager(Sskinmanager::TsSkinManager* const Value);
	Sskinmanager::TsSkinManager* __fastcall GetSkinManager(void);
	
protected:
	virtual Vcl::Graphics::TFont* __fastcall GetCurrentFont(void);
	virtual System::Uitypes::TColor __fastcall TextColor(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall ManagerStored(void);
	
public:
	int FSkinIndex;
	__fastcall virtual TsCustomLabel(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoDrawText(System::Types::TRect &Rect, int Flags);
	__property Font;
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property AutoSize = {default=1};
	__property BiDiMode;
	__property Sskinmanager::TsSkinManager* SkinManager = {read=GetSkinManager, write=SetSkinManager, stored=ManagerStored};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=SetSkinSection};
	__property Caption = {default=0};
	__property EllipsisPosition = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {default=1};
	__property ShowHint;
	__property Transparent = {default=1};
	__property Touch;
	__property Layout = {default=0};
	__property Visible = {default=1};
	__property WordWrap = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TsCustomLabel(void) { }
	
};


struct DECLSPEC_DRECORD TsClassSkinData
{
public:
	bool CustomColor;
	bool CustomFont;
};


class DELPHICLASS TsLabel;
class PASCALIMPLEMENTATION TsLabel : public TsCustomLabel
{
	typedef TsCustomLabel inherited;
	
private:
	bool FUseSkinColor;
	
protected:
	virtual System::Uitypes::TColor __fastcall TextColor(void);
	
public:
	__fastcall virtual TsLabel(System::Classes::TComponent* AOwner);
	
__published:
	__property Font;
	__property bool UseSkinColor = {read=FUseSkinColor, write=FUseSkinColor, default=1};
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TsLabel(void) { }
	
};


class DELPHICLASS TsHTMLLabel;
class PASCALIMPLEMENTATION TsHTMLLabel : public TsLabel
{
	typedef TsLabel inherited;
	
private:
	System::UnicodeString __fastcall GetPlainCaption(void);
	
public:
	DYNAMIC void __fastcall DoDrawText(System::Types::TRect &Rect, int Flags);
	
__published:
	__property System::UnicodeString PlainCaption = {read=GetPlainCaption};
public:
	/* TsLabel.Create */ inline __fastcall virtual TsHTMLLabel(System::Classes::TComponent* AOwner) : TsLabel(AOwner) { }
	
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TsHTMLLabel(void) { }
	
};


class DELPHICLASS TsEditLabel;
class PASCALIMPLEMENTATION TsEditLabel : public TsLabel
{
	typedef TsLabel inherited;
	
public:
	System::TObject* BoundLabel;
	__fastcall TsEditLabel(System::Classes::TComponent* AOwner, System::TObject* BoundStruct);
	__fastcall virtual ~TsEditLabel(void);
public:
	/* TsLabel.Create */ inline __fastcall virtual TsEditLabel(System::Classes::TComponent* AOwner) : TsLabel(AOwner) { }
	
};


class DELPHICLASS TsWebLabel;
class PASCALIMPLEMENTATION TsWebLabel : public TsLabel
{
	typedef TsLabel inherited;
	
private:
	Vcl::Graphics::TFont* FNormalFont;
	void __fastcall SetHoverFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetNormalFont(Vcl::Graphics::TFont* const Value);
	
protected:
	Vcl::Graphics::TFont* FHoverFont;
	System::UnicodeString FURL;
	Sconst::TsWindowShowMode FShowMode;
	virtual System::Uitypes::TColor __fastcall TextColor(void);
	virtual Vcl::Graphics::TFont* __fastcall GetCurrentFont(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Message);
	
public:
	bool MouseAbove;
	__fastcall virtual TsWebLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsWebLabel(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FNormalFont, write=SetNormalFont};
	__property Cursor = {default=-21};
	__property Vcl::Graphics::TFont* HoverFont = {read=FHoverFont, write=SetHoverFont};
	__property Sconst::TsWindowShowMode ShowMode = {read=FShowMode, write=FShowMode, default=10};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
};


class DELPHICLASS TsKind;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsKind : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Controls::TControl* FOwner;
	TsKindType FKindType;
	System::Uitypes::TColor FColor;
	void __fastcall SetKindType(const TsKindType Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall TsKind(Vcl::Controls::TControl* AOwner);
	__fastcall virtual ~TsKind(void);
	
__published:
	__property TsKindType KindType = {read=FKindType, write=SetKindType, default=2};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=16777215};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TShadowData
{
public:
	System::Uitypes::TColor Color;
	int Blur;
	int Offset;
	int Alpha;
};


class DELPHICLASS TacOffsetKeeper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacOffsetKeeper : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FRightBottom;
	int FLeftTop;
	
__published:
	__property int LeftTop = {read=FLeftTop, write=FLeftTop, stored=true, nodefault};
	__property int RightBottom = {read=FRightBottom, write=FRightBottom, stored=true, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacOffsetKeeper(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TacOffsetKeeper(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class DELPHICLASS TsShadow;
class DELPHICLASS TsLabelFX;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsShadow : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FBuffered;
	int FBlurCount;
	int FDistance;
	System::Uitypes::TColor FColor;
	TsLabelFX* ParentControl;
	TsShadowMode FMode;
	System::Byte FAlphaValue;
	TacOffsetKeeper* FOffsetKeeper;
	void __fastcall SetBlurCount(const int Value);
	void __fastcall SetDistance(const int Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetMode(const TsShadowMode Value);
	void __fastcall UpdateRGB(void);
	void __fastcall SetAlphaValue(const System::Byte Value);
	
public:
	int sr;
	int sg;
	int sb;
	__fastcall TsShadow(System::Classes::TComponent* AOwner, TsLabelFX* Control);
	__fastcall virtual ~TsShadow(void);
	__property bool ShadowBuffered = {read=FBuffered, write=FBuffered, default=0};
	
__published:
	__property System::Byte AlphaValue = {read=FAlphaValue, write=SetAlphaValue, default=255};
	__property int BlurCount = {read=FBlurCount, write=SetBlurCount, default=4};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property int Distance = {read=FDistance, write=SetDistance, default=1};
	__property TsShadowMode Mode = {read=FMode, write=SetMode, default=2};
	__property TacOffsetKeeper* OffsetKeeper = {read=FOffsetKeeper, write=FOffsetKeeper};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TsLabelFX : public TsCustomLabel
{
	typedef TsCustomLabel inherited;
	
private:
	Vcl::Graphics::TBitmap* FMask;
	void *FMaskBits;
	int FMaskBitsSize;
	TsShadow* FShadow;
	bool FNeedInvalidate;
	int OffsTopLeft;
	TsKind* FKind;
	bool IntPosChanging;
	int FAngle;
	void __fastcall SetAngle(const int Value);
	
public:
	DYNAMIC void __fastcall AdjustBounds(void);
	__fastcall virtual TsLabelFX(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsLabelFX(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall DoDrawText(System::Types::TRect &Rect, int Flags);
	TShadowData __fastcall CurrentShadowData(void);
	System::Uitypes::TColor __fastcall CurrentFontColor(void);
	void __fastcall UpdatePosition(void);
	
__published:
	__property Font;
	__property int Angle = {read=FAngle, write=SetAngle, nodefault};
	__property TsKind* Kind = {read=FKind, write=FKind};
	__property TsShadow* Shadow = {read=FShadow, write=FShadow};
};


enum DECLSPEC_DENUM TAlignTo : unsigned char { altLeft, altTop, altBottom, altRight };

class DELPHICLASS TsStickyLabel;
class PASCALIMPLEMENTATION TsStickyLabel : public TsLabel
{
	typedef TsLabel inherited;
	
private:
	Vcl::Controls::TControl* FAttachTo;
	TAlignTo FAlignTo;
	int FGap;
	System::Classes::TWndMethod FOldWinProc;
	bool FRealigning;
	void __fastcall SetGap(int Value);
	void __fastcall SetAttachTo(Vcl::Controls::TControl* Value);
	void __fastcall SetAlignTo(TAlignTo Value);
	void __fastcall NewWinProc(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TsStickyLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsStickyLabel(void);
	void __fastcall Adjust(bool MoveLabel);
	
__published:
	__property Font;
	__property TAlignTo AlignTo = {read=FAlignTo, write=SetAlignTo, default=0};
	__property Vcl::Controls::TControl* AttachTo = {read=FAttachTo, write=SetAttachTo};
	__property int Gap = {read=FGap, write=SetGap, default=2};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Slabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SLABEL)
using namespace Slabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SlabelHPP
