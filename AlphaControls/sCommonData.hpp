// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCommonData.pas' rev: 27.00 (Windows)

#ifndef ScommondataHPP
#define ScommondataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scommondata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TacOuterEffects;
class DELPHICLASS TsCommonData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacOuterEffects : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TsCommonData* FOwner;
	Sconst::TacOuterVisibility FVisibility;
	void __fastcall SetVisibility(const Sconst::TacOuterVisibility Value);
	
public:
	void __fastcall Invalidate(void);
	__fastcall TacOuterEffects(TsCommonData* AOwner);
	
__published:
	__property Sconst::TacOuterVisibility Visibility = {read=FVisibility, write=SetVisibility, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacOuterEffects(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TsCommonData : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TBitmap* FOuterCache;
	System::UnicodeString FSkinSection;
	bool FCustomFont;
	bool FCustomColor;
	int FUpdateCount;
	TacOuterEffects* FOuterEffects;
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	bool __fastcall GetUpdating(void);
	void __fastcall SetCustomColor(const bool Value);
	void __fastcall SetCustomFont(const bool Value);
	Sskinmanager::TsSkinManager* __fastcall GetSkinManager(void);
	void __fastcall SetSkinManager(Sskinmanager::TsSkinManager* const Value);
	void __fastcall SetHUEOffset(const int Value);
	void __fastcall SetSaturation(const int Value);
	void __fastcall PaintOuter(Sconst::PacBGInfo PBGInfo, System::Word Data);
	void __fastcall SetColorTone(const System::Uitypes::TColor Value);
	
public:
	System::Uitypes::TColor FColorTone;
	int FHUEOffset;
	int FSaturation;
	int GlowID;
	bool FUpdating;
	bool Loading;
	Sskinmanager::TsSkinManager* FSkinManager;
	int BorderIndex;
	int SkinIndex;
	int Texture;
	int HotTexture;
	bool HalfVisible;
	Vcl::Controls::TControl* FOwnerControl;
	System::TObject* FOwnerObject;
	Vcl::Graphics::TBitmap* FCacheBmp;
	int COC;
	bool FFocused;
	bool FMouseAbove;
	System::Word CtrlSkinState;
	System::Word BGType;
	HDC PrintDC;
	System::Types::TRect InvalidRectH;
	System::Types::TRect InvalidRectV;
	bool BGChanged;
	__property bool Updating = {read=GetUpdating, write=FUpdating, default=0};
	__fastcall virtual TsCommonData(System::TObject* AOwner, const bool CreateCacheBmp);
	__fastcall virtual ~TsCommonData(void);
	void __fastcall UpdateIndexes(bool UpdateMain = true);
	void __fastcall Loaded(void);
	void __fastcall PaintOuterEffects(Vcl::Controls::TWinControl* OwnerCtrl, const System::Types::TPoint &Offset);
	bool __fastcall RepaintIfMoved(void);
	bool __fastcall ManagerStored(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(const bool Repaint = false);
	void __fastcall Invalidate(const bool UpdateNow = false);
	bool __fastcall Skinned(const bool CheckSkinActive = false);
	__property int HUEOffset = {read=FHUEOffset, write=SetHUEOffset, default=0};
	__property int Saturation = {read=FSaturation, write=SetSaturation, default=0};
	__property System::Uitypes::TColor ColorTone = {read=FColorTone, write=SetColorTone, default=536870911};
	
__published:
	__property bool CustomColor = {read=FCustomColor, write=SetCustomColor, default=0};
	__property bool CustomFont = {read=FCustomFont, write=SetCustomFont, default=0};
	__property TacOuterEffects* OuterEffects = {read=FOuterEffects, write=FOuterEffects};
	__property Sskinmanager::TsSkinManager* SkinManager = {read=GetSkinManager, write=SetSkinManager, stored=ManagerStored};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=SetSkinSection};
};

#pragma pack(pop)

class DELPHICLASS TsCtrlSkinData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsCtrlSkinData : public TsCommonData
{
	typedef TsCommonData inherited;
	
__published:
	__property HUEOffset = {default=0};
	__property Saturation = {default=0};
	__property ColorTone = {default=536870911};
public:
	/* TsCommonData.Create */ inline __fastcall virtual TsCtrlSkinData(System::TObject* AOwner, const bool CreateCacheBmp) : TsCommonData(AOwner, CreateCacheBmp) { }
	/* TsCommonData.Destroy */ inline __fastcall virtual ~TsCtrlSkinData(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacScrollData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacScrollData : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FScrollWidth;
	int FButtonsSize;
	void __fastcall SetScrollWidth(const int Value);
	void __fastcall SetButtonsSize(const int Value);
	
protected:
	TsCommonData* FOwner;
	
public:
	__fastcall TacScrollData(TsCommonData* AOwner);
	void __fastcall Invalidate(void);
	
__published:
	__property int ScrollWidth = {read=FScrollWidth, write=SetScrollWidth, default=-1};
	__property int ButtonsSize = {read=FButtonsSize, write=SetButtonsSize, default=-1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacScrollData(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TsScrollWndData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsScrollWndData : public TsCommonData
{
	typedef TsCommonData inherited;
	
private:
	TacScrollData* FHorzScrollData;
	TacScrollData* FVertScrollData;
	
public:
	__fastcall virtual TsScrollWndData(System::TObject* AOwner, const bool CreateCacheBmp);
	__fastcall virtual ~TsScrollWndData(void);
	
__published:
	__property TacScrollData* VertScrollData = {read=FVertScrollData, write=FVertScrollData};
	__property TacScrollData* HorzScrollData = {read=FHorzScrollData, write=FHorzScrollData};
};

#pragma pack(pop)

class DELPHICLASS TsBoundLabel;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsBoundLabel : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FMaxWidth;
	System::UnicodeString FText;
	Sconst::TsCaptionLayout FLayout;
	Vcl::Graphics::TFont* FFont;
	int FIndent;
	bool FEnabledAlways;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetLayout(const Sconst::TsCaptionLayout Value);
	void __fastcall SetMaxWidth(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetIndent(const int Value);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	void __fastcall UpdateAlignment(void);
	bool __fastcall GetUseSkin(void);
	void __fastcall SetUseSkin(const bool Value);
	void __fastcall SetEnabledAlways(const bool Value);
	
public:
	bool FActive;
	Slabel::TsEditLabel* FTheLabel;
	TsCommonData* FCommonData;
	void __fastcall AlignLabel(void);
	__fastcall TsBoundLabel(System::TObject* AOwner, TsCommonData* const CommonData);
	__fastcall virtual ~TsBoundLabel(void);
	void __fastcall HandleOwnerMsg(const Winapi::Messages::TMessage &Message, Vcl::Controls::TControl* const OwnerControl);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property System::UnicodeString Caption = {read=FText, write=SetText};
	__property bool EnabledAlways = {read=FEnabledAlways, write=SetEnabledAlways, default=0};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Sconst::TsCaptionLayout Layout = {read=FLayout, write=SetLayout, nodefault};
	__property int MaxWidth = {read=FMaxWidth, write=SetMaxWidth, nodefault};
	__property bool UseSkinColor = {read=GetUseSkin, write=SetUseSkin, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Sconst::TsColor C1;
extern DELPHI_PACKAGE Sconst::TsColor C2;
extern DELPHI_PACKAGE bool RestrictDrawing;
extern DELPHI_PACKAGE bool __fastcall IsCached(TsCommonData* const SkinData);
extern DELPHI_PACKAGE bool __fastcall HaveOuterEffects(TsCommonData* SkinData);
extern DELPHI_PACKAGE bool __fastcall InUpdating(TsCommonData* const SkinData, const bool Reset = false);
extern DELPHI_PACKAGE void __fastcall InitBGInfo(TsCommonData* const SkinData, const Sconst::PacBGInfo PBGInfo, const int State, NativeUInt Handle = (NativeUInt)(0x0));
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall GetBGColor(TsCommonData* const SkinData, const int State, const NativeUInt Handle = (NativeUInt)(0x0));
extern DELPHI_PACKAGE int __fastcall GetFontIndex(Vcl::Controls::TControl* const Ctrl, const int DefSkinIndex, Sskinmanager::TsSkinManager* const SkinManager, const int State = 0x0);
extern DELPHI_PACKAGE void __fastcall ShowGlowingIfNeeded(TsCommonData* const SkinData, const bool Clicked = false, const HWND CtrlHandle = (HWND)(0x0));
extern DELPHI_PACKAGE void __fastcall UpdateBmpColors(Vcl::Graphics::TBitmap* Bmp, TsCommonData* SkinData, bool CheckCorners, int State);
extern DELPHI_PACKAGE void __fastcall InitCacheBmp(TsCommonData* const SkinData);
extern DELPHI_PACKAGE int __fastcall SkinBorderMaxWidth(TsCommonData* const SkinData);
extern DELPHI_PACKAGE Sconst::TCacheInfo __fastcall GetParentCache(TsCommonData* const SkinData);
extern DELPHI_PACKAGE Sconst::TCacheInfo __fastcall GetParentCacheHwnd(const HWND cHwnd);
extern DELPHI_PACKAGE void __fastcall InvalidateParentCache(TsCommonData* SkinData);
extern DELPHI_PACKAGE void __fastcall InitIndexes(TsCommonData* const SkinData, System::UnicodeString const *Sections, const int Sections_High);
extern DELPHI_PACKAGE void __fastcall UpdateData(TsCommonData* const SkinData);
extern DELPHI_PACKAGE void __fastcall UpdateSkinState(TsCommonData* const SkinData, const bool UpdateChildren = true);
extern DELPHI_PACKAGE bool __fastcall ControlIsActive(TsCommonData* const SkinData);
extern DELPHI_PACKAGE bool __fastcall ChildBgIsChanged(TsCommonData* SkinData);
extern DELPHI_PACKAGE bool __fastcall CommonMessage(Winapi::Messages::TMessage &Message, TsCommonData* SkinData);
extern DELPHI_PACKAGE bool __fastcall CommonWndProc(Winapi::Messages::TMessage &Message, TsCommonData* SkinData);
extern DELPHI_PACKAGE void __fastcall CopyWinControlCache(Vcl::Controls::TWinControl* const Control, TsCommonData* const SkinData, const System::Types::TRect &SrcRect, const System::Types::TRect &DstRect, const HDC DstDC, const bool UpdateCorners, const int OffsetX = 0x0, const int OffsetY = 0x0)/* overload */;
extern DELPHI_PACKAGE void __fastcall CopyHwndCache(const NativeUInt hwnd, TsCommonData* const SkinData, const System::Types::TRect &SrcRect, const System::Types::TRect &DstRect, const HDC DstDC, const bool UpdateCorners, const int OffsetX = 0x0, const int OffsetY = 0x0)/* overload */;
}	/* namespace Scommondata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOMMONDATA)
using namespace Scommondata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScommondataHPP
