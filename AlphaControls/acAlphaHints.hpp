// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acAlphaHints.pas' rev: 27.00 (Windows)

#ifndef AcalphahintsHPP
#define AcalphahintsHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sHtmlParse.hpp>	// Pascal unit
#include <acPNG.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acalphahints
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TacShowHintEvent)(System::UnicodeString &HintStr, bool &CanShow, Vcl::Controls::THintInfo &HintInfo, Vcl::Forms::TFrame* &Frame);

enum DECLSPEC_DENUM TacMousePosition : unsigned char { mpLeftTop, mpLeftBottom, mpRightTop, mpRightBottom };

enum DECLSPEC_DENUM TacBorderDrawMode : unsigned char { dmRepeat, dmStretch };

typedef Vcl::Controls::THintInfo THintInfo;

class DELPHICLASS TacBorderDrawModes;
class DELPHICLASS TacHintImage;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacBorderDrawModes : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TacBorderDrawMode FBottom;
	TacBorderDrawMode FLeft;
	TacBorderDrawMode FTop;
	TacBorderDrawMode FRight;
	TacBorderDrawMode FCenter;
	TacHintImage* FOwner;
	void __fastcall SetDrawMode(const int Index, const TacBorderDrawMode Value);
	
protected:
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall TacBorderDrawModes(TacHintImage* AOwner);
	
__published:
	__property TacBorderDrawMode Top = {read=FTop, write=SetDrawMode, index=0, default=1};
	__property TacBorderDrawMode Left = {read=FLeft, write=SetDrawMode, index=1, default=1};
	__property TacBorderDrawMode Bottom = {read=FBottom, write=SetDrawMode, index=2, default=1};
	__property TacBorderDrawMode Right = {read=FRight, write=SetDrawMode, index=3, default=1};
	__property TacBorderDrawMode Center = {read=FCenter, write=SetDrawMode, index=4, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacBorderDrawModes(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacBordersSizes;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacBordersSizes : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int __fastcall GetInteger(const int Index);
	
protected:
	int FTop;
	int FLeft;
	int FBottom;
	int FRight;
	TacHintImage* FOwner;
	void __fastcall SetInteger(int Index, int Value);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	bool CheckSize;
	__fastcall TacBordersSizes(TacHintImage* AOwner);
	
__published:
	__property int Top = {read=GetInteger, write=SetInteger, index=0, default=0};
	__property int Left = {read=GetInteger, write=SetInteger, index=1, default=0};
	__property int Bottom = {read=GetInteger, write=SetInteger, index=2, default=0};
	__property int Right = {read=GetInteger, write=SetInteger, index=3, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacBordersSizes(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacHintTemplate;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacHintImage : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TacHintTemplate* FOwner;
	TacBordersSizes* FBordersWidths;
	TacBordersSizes* FClientMargins;
	TacBorderDrawModes* FBorderDrawModes;
	TacBordersSizes* FShadowSizes;
	int __fastcall GetImgHeight(void);
	int __fastcall GetImgWidth(void);
	void __fastcall SetImage(Acpng::TPNGGraphic* const Value);
	void __fastcall SetImgHeight(const int Value);
	void __fastcall SetImgWidth(const int Value);
	void __fastcall SetClientMargins(TacBordersSizes* const Value);
	void __fastcall SetBordersWidths(TacBordersSizes* const Value);
	void __fastcall SetShadowSizes(TacBordersSizes* const Value);
	
protected:
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	Acpng::TPNGGraphic* FImage;
	__fastcall TacHintImage(TacHintTemplate* AOwner);
	__fastcall virtual ~TacHintImage(void);
	void __fastcall ImageChanged(void);
	
__published:
	__property int ImageHeight = {read=GetImgHeight, write=SetImgHeight, nodefault};
	__property int ImageWidth = {read=GetImgWidth, write=SetImgWidth, nodefault};
	__property Acpng::TPNGGraphic* Image = {read=FImage, write=SetImage};
	__property TacBorderDrawModes* BorderDrawModes = {read=FBorderDrawModes, write=FBorderDrawModes};
	__property TacBordersSizes* BordersWidths = {read=FBordersWidths, write=SetBordersWidths};
	__property TacBordersSizes* ClientMargins = {read=FClientMargins, write=SetClientMargins};
	__property TacBordersSizes* ShadowSizes = {read=FShadowSizes, write=SetShadowSizes};
};

#pragma pack(pop)

class DELPHICLASS TacHintTemplates;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacHintTemplate : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TacHintImage* FImageDefault;
	TacHintImage* FImageLeftBottom;
	TacHintImage* FImageRightBottom;
	TacHintImage* FImageRightTop;
	System::UnicodeString FName;
	Vcl::Graphics::TFont* FFont;
	void __fastcall SetHintImage(const int Index, TacHintImage* const Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	
protected:
	TacHintTemplates* FOwner;
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall virtual ~TacHintTemplate(void);
	__fastcall virtual TacHintTemplate(System::Classes::TCollection* Collection);
	
__published:
	__property TacHintImage* ImageDefault = {read=FImageDefault, write=SetHintImage, index=0};
	__property TacHintImage* Img_LeftBottom = {read=FImageLeftBottom, write=SetHintImage, index=1};
	__property TacHintImage* Img_RightBottom = {read=FImageRightBottom, write=SetHintImage, index=2};
	__property TacHintImage* Img_RightTop = {read=FImageRightTop, write=SetHintImage, index=3};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Name = {read=FName, write=FName};
};

#pragma pack(pop)

class DELPHICLASS TsAlphaHints;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacHintTemplates : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TacHintTemplate* operator[](int Index) { return Items[Index]; }
	
protected:
	TsAlphaHints* FOwner;
	HIDESBASE TacHintTemplate* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TacHintTemplate* Value);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall TacHintTemplates(TsAlphaHints* AOwner);
	__fastcall virtual ~TacHintTemplates(void);
	__property TacHintTemplate* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TsAlphaHints : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	int FPauseHide;
	bool FHTMLMode;
	TacShowHintEvent FOnShowHint;
	TacMousePosition FDefaultMousePos;
	bool FAnimated;
	System::Types::TPoint FHintPos;
	int FMaxWidth;
	System::UnicodeString FSkinSection;
	bool FUseSkinData;
	bool FActive;
	TacHintTemplates* FTemplates;
	int FTemplateIndex;
	System::UnicodeString FTemplateName;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnHideHint;
	bool __fastcall GetAnimated(void);
	void __fastcall SetSkinData(const bool Value);
	void __fastcall SetPauseHide(const int Value);
	void __fastcall SetActive(const bool Value);
	void __fastcall UpdateHWClass(void);
	void __fastcall SetTemplates(TacHintTemplates* const Value);
	void __fastcall SetTemplateName(const System::UnicodeString Value);
	
protected:
	Vcl::Controls::THintInfo CurrentHintInfo;
	Vcl::Graphics::TBitmap* FCacheBmp;
	bool HintShowing;
	Vcl::Extctrls::TTimer* HideTimer;
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	void __fastcall ResetHintInfo(void);
	void __fastcall OnHideTimer(System::TObject* Sender);
	
public:
	Vcl::Forms::TFrame* HintFrame;
	Vcl::Controls::THintWindow* HintWindow;
	void __fastcall OnShowHintApp(System::UnicodeString &HintStr, bool &CanShow, Vcl::Controls::THintInfo &HintInfo);
	__fastcall virtual TsAlphaHints(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsAlphaHints(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Changed(void);
	virtual void __fastcall AfterConstruction(void);
	void __fastcall ShowHint(Vcl::Controls::TControl* TheControl, const System::UnicodeString HintText, System::Word HideTime = (System::Word)(0x0))/* overload */;
	void __fastcall ShowHint(const System::Types::TPoint &Position, const System::UnicodeString HintText, System::Word HideTime = (System::Word)(0x0))/* overload */;
	void __fastcall HideHint(void);
	void __fastcall RepaintHint(void);
	bool __fastcall Skinned(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TacMousePosition DefaultMousePos = {read=FDefaultMousePos, write=FDefaultMousePos, default=0};
	__property bool IsHintShowing = {read=HintShowing, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property TacShowHintEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
	__property System::Classes::TNotifyEvent OnHideHint = {read=FOnHideHint, write=FOnHideHint};
	__property bool Animated = {read=GetAnimated, write=FAnimated, default=1};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=120};
	__property TacHintTemplates* Templates = {read=FTemplates, write=SetTemplates};
	__property System::UnicodeString TemplateName = {read=FTemplateName, write=SetTemplateName};
	__property bool HTMLMode = {read=FHTMLMode, write=FHTMLMode, default=0};
	__property int PauseHide = {read=FPauseHide, write=SetPauseHide, default=5000};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=FSkinSection};
	__property bool UseSkinData = {read=FUseSkinData, write=SetSkinData, default=0};
};


class DELPHICLASS TacCustomHintWindow;
class PASCALIMPLEMENTATION TacCustomHintWindow : public Vcl::Controls::THintWindow
{
	typedef Vcl::Controls::THintWindow inherited;
	
private:
	System::UnicodeString Text;
	System::Types::TPoint FHintLocation;
	void __fastcall PrepareMask(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGND(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMPaint &Message);
	
protected:
	Vcl::Graphics::TBitmap* AlphaBmp;
	Vcl::Graphics::TBitmap* BodyBmp;
	TacMousePosition FMousePos;
	Vcl::Graphics::TBitmap* MaskBmp;
	HRGN rgn;
	int SkinIndex;
	int BorderIndex;
	int BGIndex;
	virtual void __fastcall CreateAlphaBmp(const int Width, const int Height);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	System::Types::TPoint __fastcall GetMousePosition(void);
	System::Types::TRect __fastcall MainRect(void);
	int __fastcall SkinMargin(System::Byte Border);
	void __fastcall TextOut(Vcl::Graphics::TBitmap* Bmp);
	bool __fastcall FullLayer(void);
	System::Types::TRect __fastcall ShadowSizes(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	__fastcall virtual TacCustomHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacCustomHintWindow(void);
	TacMousePosition __fastcall GetArrowPos(System::Types::TRect &Rect, const System::Types::TPoint &mPos);
	__property System::Types::TPoint HintLocation = {read=FHintLocation, write=FHintLocation};
	void __fastcall UpdateWnd(int w, int h);
public:
	/* TWinControl.CreateParented */ inline __fastcall TacCustomHintWindow(HWND ParentWindow) : Vcl::Controls::THintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Byte DefAnimationTime = System::Byte(0x96);
extern DELPHI_PACKAGE TsAlphaHints* Manager;
}	/* namespace Acalphahints */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACALPHAHINTS)
using namespace Acalphahints;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcalphahintsHPP
