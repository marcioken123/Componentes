// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSkinManager.pas' rev: 27.00 (Windows)

#ifndef SskinmanagerHPP
#define SskinmanagerHPP

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
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <acTinyJPG.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sMaskData.hpp>	// Pascal unit
#include <sSkinMenus.hpp>	// Pascal unit
#include <sStyleSimply.hpp>	// Pascal unit
#include <acSkinPack.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sskinmanager
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TacSkinData
{
public:
	int Magic;
	System::StaticArray<char, 128> SkinName;
	System::StaticArray<char, 513> SkinDir;
	System::StaticArray<char, 30001> Data;
};
#pragma pack(pop)


typedef TacSkinData *PacSkinData;

enum DECLSPEC_DENUM TacSkinTypes : unsigned char { stUnpacked, stPacked, stAllSkins };

enum DECLSPEC_DENUM TacSkinPlaces : unsigned char { spInternal, spExternal, spAllPlaces };

typedef void __fastcall (__closure *TacGetExtraLineData)(Vcl::Menus::TMenuItem* FirstItem, System::UnicodeString &SkinSection, System::UnicodeString &Caption, Vcl::Graphics::TBitmap* &Glyph, bool &LineVisible);

struct DECLSPEC_DRECORD TacMenuItemData
{
public:
	Vcl::Graphics::TFont* Font;
};


struct DECLSPEC_DRECORD TacSysDlgData
{
public:
	NativeUInt WindowHandle;
};


typedef void __fastcall (__closure *TacSysDlgInit)(TacSysDlgData DlgData, bool &AllowSkinning);

typedef void __fastcall (__closure *TacGetPopupItemData)(Vcl::Menus::TMenuItem* Item, Winapi::Windows::TOwnerDrawState State, TacMenuItemData ItemData);

;

typedef System::UnicodeString TacSkinInfo;

class DELPHICLASS TacSkinEffects;
class DELPHICLASS TsSkinManager;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacSkinEffects : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAllowGlowing;
	bool FAllowAeroBluring;
	bool FDiscoloredGlyphs;
	bool FAllowOuterEffects;
	void __fastcall SetDiscoloredGlyphs(const bool Value);
	void __fastcall SetAllowOuterEffects(const bool Value);
	
public:
	TsSkinManager* Manager;
	__fastcall TacSkinEffects(void);
	
__published:
	__property bool AllowAeroBluring = {read=FAllowAeroBluring, write=FAllowAeroBluring, default=1};
	__property bool AllowGlowing = {read=FAllowGlowing, write=FAllowGlowing, default=1};
	__property bool AllowOuterEffects = {read=FAllowOuterEffects, write=SetAllowOuterEffects, default=0};
	__property bool DiscoloredGlyphs = {read=FDiscoloredGlyphs, write=SetDiscoloredGlyphs, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacSkinEffects(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacBtnEffects;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacBtnEffects : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Sconst::TacBtnEvents FEvents;
	
public:
	__fastcall TacBtnEffects(void);
	
__published:
	__property Sconst::TacBtnEvents Events = {read=FEvents, write=FEvents, default=15};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacBtnEffects(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacFormAnimation;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacFormAnimation : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Word FTime;
	bool FActive;
	Sconst::TacAnimType FMode;
	
public:
	__fastcall virtual TacFormAnimation(void);
	__property Sconst::TacAnimType Mode = {read=FMode, write=FMode, default=1};
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property System::Word Time = {read=FTime, write=FTime, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacFormAnimation(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacBlendOnMoving;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacBlendOnMoving : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
private:
	System::Byte FBlendValue;
	
public:
	__fastcall virtual TacBlendOnMoving(void);
	
__published:
	__property Active = {default=0};
	__property System::Byte BlendValue = {read=FBlendValue, write=FBlendValue, default=170};
	__property Time = {default=1000};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacBlendOnMoving(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacMinimizing;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacMinimizing : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
public:
	__fastcall virtual TacMinimizing(void);
	
__published:
	__property Time = {default=120};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacMinimizing(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacFormShow;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacFormShow : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
__published:
	__property Mode = {default=1};
public:
	/* TacFormAnimation.Create */ inline __fastcall virtual TacFormShow(void) : TacFormAnimation() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacFormShow(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacFormHide;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacFormHide : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
__published:
	__property Mode = {default=1};
public:
	/* TacFormAnimation.Create */ inline __fastcall virtual TacFormHide(void) : TacFormAnimation() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacFormHide(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacPageChange;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacPageChange : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
public:
	/* TacFormAnimation.Create */ inline __fastcall virtual TacPageChange(void) : TacFormAnimation() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacPageChange(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacDialogShow;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacDialogShow : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
public:
	__fastcall virtual TacDialogShow(void);
	
__published:
	__property Time = {default=0};
	__property Mode = {default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacDialogShow(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacSkinChanging;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacSkinChanging : public TacFormAnimation
{
	typedef TacFormAnimation inherited;
	
public:
	__fastcall virtual TacSkinChanging(void);
	
__published:
	__property Time = {default=100};
	__property Mode = {default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacSkinChanging(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacAnimEffects;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacAnimEffects : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TacBtnEffects* FButtons;
	TacDialogShow* FDialogShow;
	TacFormShow* FFormShow;
	TacFormHide* FFormHide;
	TacSkinChanging* FSkinChanging;
	TacPageChange* FPageChange;
	TacFormHide* FDialogHide;
	TacMinimizing* FMinimizing;
	TacBlendOnMoving* FBlendOnMoving;
	
public:
	TsSkinManager* Manager;
	__fastcall TacAnimEffects(void);
	__fastcall virtual ~TacAnimEffects(void);
	
__published:
	__property TacBlendOnMoving* BlendOnMoving = {read=FBlendOnMoving, write=FBlendOnMoving};
	__property TacBtnEffects* Buttons = {read=FButtons, write=FButtons};
	__property TacDialogShow* DialogShow = {read=FDialogShow, write=FDialogShow};
	__property TacFormShow* FormShow = {read=FFormShow, write=FFormShow};
	__property TacFormHide* FormHide = {read=FFormHide, write=FFormHide};
	__property TacFormHide* DialogHide = {read=FDialogHide, write=FDialogHide};
	__property TacMinimizing* Minimizing = {read=FMinimizing, write=FMinimizing};
	__property TacPageChange* PageChange = {read=FPageChange, write=FPageChange};
	__property TacSkinChanging* SkinChanging = {read=FSkinChanging, write=FSkinChanging};
};

#pragma pack(pop)

class DELPHICLASS TsStoredSkin;
class PASCALIMPLEMENTATION TsStoredSkin : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	Vcl::Graphics::TBitmap* FMasterBitmap;
	double FVersion;
	System::UnicodeString FDescription;
	System::UnicodeString FAuthor;
	int FShadow1Offset;
	System::Uitypes::TColor FShadow1Color;
	int FShadow1Blur;
	int FShadow1Transparency;
	System::Uitypes::TColor FBorderColor;
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadData(System::Classes::TStream* Reader);
	void __fastcall WriteData(System::Classes::TStream* Writer);
	
public:
	System::Classes::TMemoryStream* PackedData;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TsStoredSkin(System::Classes::TCollection* Collection);
	__fastcall virtual ~TsStoredSkin(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property Vcl::Graphics::TBitmap* MasterBitmap = {read=FMasterBitmap, write=FMasterBitmap};
	__property System::Uitypes::TColor Shadow1Color = {read=FShadow1Color, write=FShadow1Color, nodefault};
	__property int Shadow1Offset = {read=FShadow1Offset, write=FShadow1Offset, nodefault};
	__property int Shadow1Blur = {read=FShadow1Blur, write=FShadow1Blur, default=-1};
	__property int Shadow1Transparency = {read=FShadow1Transparency, write=FShadow1Transparency, nodefault};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=16711935};
	__property double Version = {read=FVersion, write=FVersion};
	__property System::UnicodeString Author = {read=FAuthor, write=FAuthor};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
};


class DELPHICLASS TsStoredSkins;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsStoredSkins : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TsStoredSkin* operator[](int Index) { return Items[Index]; }
	
private:
	TsSkinManager* FOwner;
	HIDESBASE TsStoredSkin* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TsStoredSkin* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall TsStoredSkins(TsSkinManager* AOwner);
	__fastcall virtual ~TsStoredSkins(void);
	__property TsStoredSkin* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	int __fastcall IndexOf(const System::UnicodeString SkinName);
};

#pragma pack(pop)

class DELPHICLASS ThirdPartyList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ThirdPartyList : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FThirdEdits;
	System::UnicodeString FThirdButtons;
	System::UnicodeString FThirdBitBtns;
	System::UnicodeString FThirdCheckBoxes;
	System::UnicodeString FThirdGroupBoxes;
	System::UnicodeString FThirdListViews;
	System::UnicodeString FThirdPanels;
	System::UnicodeString FThirdGrids;
	System::UnicodeString FThirdTreeViews;
	System::UnicodeString FThirdComboBoxes;
	System::UnicodeString FThirdWWEdits;
	System::UnicodeString FThirdVirtualTrees;
	System::UnicodeString FThirdGridEh;
	System::UnicodeString FThirdPageControl;
	System::UnicodeString FThirdTabControl;
	System::UnicodeString FThirdToolBar;
	System::UnicodeString FThirdStatusBar;
	System::UnicodeString FThirdSpeedButton;
	System::UnicodeString FThirdScrollControl;
	System::UnicodeString FThirdUpDownBtn;
	System::UnicodeString FThirdScrollBar;
	System::UnicodeString FThirdStaticText;
	System::UnicodeString FThirdNativePaint;
	System::UnicodeString __fastcall GetString(const int Index);
	void __fastcall SetString(const int Index, const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString ThirdEdits = {read=GetString, write=SetString, stored=true, index=0};
	__property System::UnicodeString ThirdButtons = {read=GetString, write=SetString, stored=true, index=1};
	__property System::UnicodeString ThirdBitBtns = {read=GetString, write=SetString, stored=true, index=2};
	__property System::UnicodeString ThirdCheckBoxes = {read=GetString, write=SetString, stored=true, index=3};
	__property System::UnicodeString ThirdGroupBoxes = {read=GetString, write=SetString, stored=true, index=6};
	__property System::UnicodeString ThirdListViews = {read=GetString, write=SetString, stored=true, index=7};
	__property System::UnicodeString ThirdPanels = {read=GetString, write=SetString, stored=true, index=8};
	__property System::UnicodeString ThirdGrids = {read=GetString, write=SetString, stored=true, index=5};
	__property System::UnicodeString ThirdTreeViews = {read=GetString, write=SetString, stored=true, index=9};
	__property System::UnicodeString ThirdComboBoxes = {read=GetString, write=SetString, stored=true, index=4};
	__property System::UnicodeString ThirdWWEdits = {read=GetString, write=SetString, stored=true, index=10};
	__property System::UnicodeString ThirdVirtualTrees = {read=GetString, write=SetString, stored=true, index=12};
	__property System::UnicodeString ThirdGridEh = {read=GetString, write=SetString, stored=true, index=11};
	__property System::UnicodeString ThirdPageControl = {read=GetString, write=SetString, stored=true, index=13};
	__property System::UnicodeString ThirdTabControl = {read=GetString, write=SetString, stored=true, index=14};
	__property System::UnicodeString ThirdToolBar = {read=GetString, write=SetString, stored=true, index=15};
	__property System::UnicodeString ThirdStatusBar = {read=GetString, write=SetString, stored=true, index=16};
	__property System::UnicodeString ThirdSpeedButton = {read=GetString, write=SetString, stored=true, index=17};
	__property System::UnicodeString ThirdScrollControl = {read=GetString, write=SetString, stored=true, index=18};
	__property System::UnicodeString ThirdUpDown = {read=GetString, write=SetString, stored=true, index=19};
	__property System::UnicodeString ThirdScrollBar = {read=GetString, write=SetString, stored=true, index=20};
	__property System::UnicodeString ThirdStaticText = {read=GetString, write=SetString, stored=true, index=21};
	__property System::UnicodeString ThirdNativePaint = {read=GetString, write=SetString, stored=true, index=22};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~ThirdPartyList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall ThirdPartyList(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TacSkinningRule : unsigned char { srStdForms, srStdDialogs, srThirdParty };

typedef System::Set<TacSkinningRule, TacSkinningRule::srStdForms, TacSkinningRule::srThirdParty> TacSkinningRules;

enum DECLSPEC_DENUM TacPaletteColors : unsigned char { pcMainColor, pcLabelText, pcWebText, pcWebTextHot, pcEditText, pcEditBG, pcSelectionBG, pcSelectionText, pcSelectionBG_Focused, pcSelectionText_Focused, pcEditBG_Inverted, pcEditText_Inverted, pcEditBG_OddRow, pcEditBG_EvenRow, pcEditText_Ok, pcEditText_Warning, pcEditText_Alert, pcEditText_Caution, pcEditText_Bypassed, pcEditBG_Ok, pcEditBG_Warning, pcEditBG_Alert, pcEditBG_Caution, pcEditBG_Bypassed, pcEditText_Highlight1, pcEditText_Highlight2, pcEditText_Highlight3, pcBorder };

typedef System::StaticArray<System::Uitypes::TColor, 28> TacPaletteArray;

class DELPHICLASS TacScrollBarsSupport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacScrollBarsSupport : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FScrollSize;
	TsSkinManager* FOwner;
	int FButtonsSize;
	void __fastcall SetScrollSize(const int Value);
	void __fastcall SetButtonsSize(const int Value);
	
public:
	__fastcall TacScrollBarsSupport(TsSkinManager* AOwner);
	
__published:
	__property int ScrollSize = {read=FScrollSize, write=SetScrollSize, default=-1};
	__property int ButtonsSize = {read=FButtonsSize, write=SetButtonsSize, default=-1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacScrollBarsSupport(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacButtonsSupport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacButtonsSupport : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FShowFocusRect;
	bool FShiftContentOnClick;
	
public:
	__fastcall TacButtonsSupport(TsSkinManager* AOwner);
	
__published:
	__property bool ShowFocusRect = {read=FShowFocusRect, write=FShowFocusRect, default=1};
	__property bool ShiftContentOnClick = {read=FShiftContentOnClick, write=FShiftContentOnClick, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacButtonsSupport(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacLabelsSupport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacLabelsSupport : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FTransparentAlways;
	
public:
	__fastcall TacLabelsSupport(TsSkinManager* AOwner);
	
__published:
	__property bool TransparentAlways = {read=FTransparentAlways, write=FTransparentAlways, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacLabelsSupport(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacOptions;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FCheckEmptyAlpha;
	bool FNoMouseHover;
	bool FNativeBordersMaximized;
	bool FStdGlyphsOrder;
	Sconst::TacOptimizingPriority FOptimizingPriority;
	bool __fastcall GetBool(const int Index);
	void __fastcall SetBool(const int Index, const bool Value);
	Sconst::TacOptimizingPriority __fastcall GetOptimizingPriority(void);
	void __fastcall SetOptimizingPriority(const Sconst::TacOptimizingPriority Value);
	
public:
	__fastcall TacOptions(void);
	
__published:
	__property bool CheckEmptyAlpha = {read=GetBool, write=SetBool, index=0, default=0};
	__property bool NoMouseHover = {read=GetBool, write=SetBool, index=1, default=0};
	__property bool NativeBordersMaximized = {read=GetBool, write=SetBool, index=2, default=0};
	__property bool StdGlyphsOrder = {read=GetBool, write=SetBool, index=3, default=0};
	__property Sconst::TacOptimizingPriority OptimizingPriority = {read=GetOptimizingPriority, write=SetOptimizingPriority, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacOptions(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TsSkinManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	typedef System::DynamicArray<System::Classes::TStringList*> _TsSkinManager__1;
	
	
private:
	int FGroupIndex;
	System::UnicodeString FSkinName;
	System::UnicodeString FSkinDirectory;
	bool FActive;
	TsStoredSkins* FBuiltInSkins;
	Sskinmenus::TsSkinableMenus* FSkinableMenus;
	System::Classes::TNotifyEvent FOnAfterChange;
	System::Classes::TNotifyEvent FOnBeforeChange;
	bool FSkinnedPopups;
	System::Classes::TStringList* FCommonSections;
	TacGetExtraLineData FOnGetPopupLineData;
	Sskinmenus::TacMenuSupport* FMenuSupport;
	TacAnimEffects* FAnimEffects;
	HWND FActiveControl;
	bool GlobalHookInstalled;
	TacSkinningRules FSkinningRules;
	ThirdPartyList* FThirdParty;
	bool FExtendedBorders;
	TacSkinEffects* FEffects;
	System::Classes::TNotifyEvent FOnSkinListChanged;
	System::Classes::TNotifyEvent FOnActivate;
	System::Classes::TNotifyEvent FOnDeactivate;
	TacGetPopupItemData FOnGetPopupItemData;
	TacSysDlgInit FOnSysDlgInit;
	System::Classes::TNotifyEvent FOnSkinLoading;
	TacScrollBarsSupport* FScrollsOptions;
	TacButtonsSupport* FButtonsSupport;
	TacLabelsSupport* FLabelsSupport;
	TacOptions* FOptions;
	void __fastcall SetSkinName(const System::UnicodeString Value);
	void __fastcall SetSkinDirectory(const System::UnicodeString Value);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetBuiltInSkins(TsStoredSkins* const Value);
	void __fastcall SetSkinnedPopups(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	TacSkinInfo __fastcall GetSkinInfo(void);
	void __fastcall SetSkinInfo(const TacSkinInfo Value);
	void __fastcall UpdateCurrentSkin(void);
	void __fastcall SetHueOffset(const int Value);
	void __fastcall SetBrightness(const int Value);
	void __fastcall SetSaturation(const int Value);
	void __fastcall SetIsDefault(const bool Value);
	bool __fastcall GetIsDefault(void);
	bool __fastcall MainWindowHook(Winapi::Messages::TMessage &Message);
	void __fastcall SetActiveControl(const HWND Value);
	void __fastcall SetActiveGraphControl(Vcl::Controls::TGraphicControl* const Value);
	void __fastcall SetFSkinningRules(const TacSkinningRules Value);
	void __fastcall SetExtendedBorders(const bool Value);
	bool __fastcall GetExtendedBorders(void);
	
protected:
	bool NoAutoUpdate;
	Vcl::Controls::TGraphicControl* FActiveGraphControl;
	void __fastcall SendNewSkin(bool Repaint = true);
	void __fastcall SendRemoveSkin(void);
	void __fastcall FreeBitmaps(void);
	void __fastcall FreeJpegs(void);
	
public:
	TacSkinData PreviewBuffer;
	Vcl::Forms::TShowAction ShowState;
	Sstylesimply::TsSkinData* CommonSkinData;
	Smaskdata::TsMaskArray ma;
	Smaskdata::TsPatternArray pa;
	Smaskdata::TsGeneralDataArray gd;
	Smaskdata::TacOutEffArray oe;
	Sstylesimply::TConstantSkinData ConstData;
	Vcl::Graphics::TBitmap* MasterBitmap;
	bool SkinIsPacked;
	Vcl::Graphics::TBitmap* ShdaTemplate;
	Vcl::Graphics::TBitmap* ShdiTemplate;
	System::Types::TRect FormShadowSize;
	int FHueOffset;
	int FSaturation;
	int FBrightness;
	_TsSkinManager__1 ThirdLists;
	bool SkinRemoving;
	TacPaletteArray Palette;
	void __fastcall InitConstantIndexes(void);
	void __fastcall CheckShadows(void);
	void __fastcall LoadAllGeneralData(void);
	void __fastcall LoadAllMasks(void);
	void __fastcall LoadAllPatterns(void);
	void __fastcall InitMaskIndexes(void);
	void __fastcall SetCommonSections(System::Classes::TStringList* const Value);
	__fastcall virtual TsSkinManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSkinManager(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	void __fastcall ReloadSkin(void);
	void __fastcall ReloadPackedSkin(void);
	void __fastcall InstallHook(void);
	void __fastcall UnInstallHook(void);
	void __fastcall CheckVersion(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall UpdateSkinSection(const System::UnicodeString SectionName);
	__property int GroupIndex = {read=FGroupIndex, write=FGroupIndex, nodefault};
	__property Sskinmenus::TsSkinableMenus* SkinableMenus = {read=FSkinableMenus, write=FSkinableMenus};
	__property HWND ActiveControl = {read=FActiveControl, write=SetActiveControl, nodefault};
	__property Vcl::Controls::TGraphicControl* ActiveGraphControl = {read=FActiveGraphControl, write=SetActiveGraphControl};
	void __fastcall RepaintForms(bool DoLockForms = true);
	int __fastcall GetSkinIndex(const System::UnicodeString SkinSection);
	int __fastcall GetMaskIndex(int SkinIndex, const System::UnicodeString SkinSection, const System::UnicodeString mask)/* overload */;
	int __fastcall GetMaskIndex(const System::UnicodeString SkinSection, const System::UnicodeString mask)/* overload */;
	int __fastcall GetTextureIndex(int SkinIndex, const System::UnicodeString SkinSection, const System::UnicodeString PropName);
	int __fastcall GetPatternIndex(int SkinIndex, const System::UnicodeString SkinSection, const System::UnicodeString pattern);
	System::UnicodeString __fastcall GetFullSkinDirectory(void);
	System::UnicodeString __fastcall GetSkinNames(System::Classes::TStrings* sl, TacSkinTypes SkinType = (TacSkinTypes)(0x2));
	System::UnicodeString __fastcall GetExternalSkinNames(System::Classes::TStrings* sl, TacSkinTypes SkinType = (TacSkinTypes)(0x2));
	void __fastcall GetSkinSections(System::Classes::TStrings* sl);
	void __fastcall ExtractInternalSkin(const System::UnicodeString NameOfSkin, const System::UnicodeString DestDir);
	void __fastcall ExtractByIndex(int Index, const System::UnicodeString DestDir);
	void __fastcall UpdateSkin(bool Repaint = true);
	System::UnicodeString __fastcall GetRandomSkin(void);
	System::Uitypes::TColor __fastcall GetGlobalColor(void);
	System::Uitypes::TColor __fastcall GetGlobalFontColor(void);
	System::Uitypes::TColor __fastcall GetActiveEditColor(void);
	System::Uitypes::TColor __fastcall GetActiveEditFontColor(void);
	System::Uitypes::TColor __fastcall GetHighLightColor(bool Focused = true);
	System::Uitypes::TColor __fastcall GetHighLightFontColor(bool Focused = true);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool Repaint = false, bool AllowAnimation = true);
	int __fastcall MaskWidthTop(int MaskIndex);
	int __fastcall MaskWidthLeft(int MaskIndex);
	int __fastcall MaskWidthBottom(int MaskIndex);
	int __fastcall MaskWidthRight(int MaskIndex);
	bool __fastcall IsValidImgIndex(int ImageIndex);
	bool __fastcall IsValidSkinIndex(int SkinIndex);
	
__published:
	__property TacSkinEffects* Effects = {read=FEffects, write=FEffects};
	__property bool ExtendedBorders = {read=GetExtendedBorders, write=SetExtendedBorders, default=0};
	__property bool SkinnedPopups = {read=FSkinnedPopups, write=SetSkinnedPopups, default=1};
	__property TacAnimEffects* AnimEffects = {read=FAnimEffects, write=FAnimEffects};
	__property TacButtonsSupport* ButtonsOptions = {read=FButtonsSupport, write=FButtonsSupport};
	__property bool IsDefault = {read=GetIsDefault, write=SetIsDefault, default=1};
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property System::Classes::TStringList* CommonSections = {read=FCommonSections, write=SetCommonSections};
	__property int Brightness = {read=FBrightness, write=SetBrightness, default=0};
	__property int Saturation = {read=FSaturation, write=SetSaturation, default=0};
	__property int HueOffset = {read=FHueOffset, write=SetHueOffset, default=0};
	__property TsStoredSkins* InternalSkins = {read=FBuiltInSkins, write=SetBuiltInSkins};
	__property TacLabelsSupport* LabelsOptions = {read=FLabelsSupport, write=FLabelsSupport};
	__property Sskinmenus::TacMenuSupport* MenuSupport = {read=FMenuSupport, write=FMenuSupport};
	__property TacOptions* Options = {read=FOptions, write=FOptions};
	__property TacScrollBarsSupport* ScrollsOptions = {read=FScrollsOptions, write=FScrollsOptions};
	__property System::UnicodeString SkinDirectory = {read=FSkinDirectory, write=SetSkinDirectory};
	__property System::UnicodeString SkinName = {read=FSkinName, write=SetSkinName};
	__property TacSkinInfo SkinInfo = {read=GetSkinInfo, write=SetSkinInfo};
	__property TacSkinningRules SkinningRules = {read=FSkinningRules, write=SetFSkinningRules, default=7};
	__property ThirdPartyList* ThirdParty = {read=FThirdParty, write=FThirdParty};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property System::Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	__property System::Classes::TNotifyEvent OnAfterChange = {read=FOnAfterChange, write=FOnAfterChange};
	__property System::Classes::TNotifyEvent OnBeforeChange = {read=FOnBeforeChange, write=FOnBeforeChange};
	__property System::Classes::TNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property TacGetExtraLineData OnGetMenuExtraLineData = {read=FOnGetPopupLineData, write=FOnGetPopupLineData};
	__property TacGetPopupItemData OnGetPopupItemData = {read=FOnGetPopupItemData, write=FOnGetPopupItemData};
	__property TacSysDlgInit OnSysDlgInit = {read=FOnSysDlgInit, write=FOnSysDlgInit};
	__property System::Classes::TNotifyEvent OnSkinListChanged = {read=FOnSkinListChanged, write=FOnSkinListChanged};
	__property System::Classes::TNotifyEvent OnSkinLoading = {read=FOnSkinLoading, write=FOnSkinLoading};
};


//-- var, const, procedure ---------------------------------------------------
#define acCurrentVersion L"9.10"
static const System::Word iMaxFileSize = System::Word(0x7530);
extern DELPHI_PACKAGE TsSkinManager* DefaultManager;
extern DELPHI_PACKAGE System::Inifiles::TMemIniFile* SkinFile;
extern DELPHI_PACKAGE bool IsNT;
extern DELPHI_PACKAGE bool UnPackedFirst;
extern DELPHI_PACKAGE System::Classes::TStringList* acMemSkinFile;
extern DELPHI_PACKAGE void __fastcall ReceiveData(TsSkinManager* SkinReceiver);
extern DELPHI_PACKAGE void __fastcall UpdatePreview(HWND Handle, bool Enabled);
extern DELPHI_PACKAGE void __fastcall UpdateCommonDlgs(TsSkinManager* sManager);
extern DELPHI_PACKAGE bool __fastcall ChangeImageInSkin(const System::UnicodeString SkinSection, const System::UnicodeString PropName, const System::UnicodeString FileName, TsSkinManager* sm);
extern DELPHI_PACKAGE void __fastcall ChangeSkinBrightness(TsSkinManager* sManager, int Value);
extern DELPHI_PACKAGE void __fastcall LoadThirdNames(TsSkinManager* sm, bool Overwrite = false);
extern DELPHI_PACKAGE void __fastcall UpdateThirdNames(TsSkinManager* sm);
extern DELPHI_PACKAGE int __fastcall GetScrollSize(TsSkinManager* sm);
extern DELPHI_PACKAGE int __fastcall GetComboBtnSize(TsSkinManager* sm);
}	/* namespace Sskinmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSKINMANAGER)
using namespace Sskinmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SskinmanagerHPP
