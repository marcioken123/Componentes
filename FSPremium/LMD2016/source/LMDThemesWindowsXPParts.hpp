// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesWindowsXPParts.pas' rev: 31.00 (Windows)

#ifndef LmdthemeswindowsxppartsHPP
#define LmdthemeswindowsxppartsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>
#include <LMDThemesGeneral.hpp>
#include <LMDThemesWindowsXP.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemeswindowsxpparts
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWindowsXPThemeButton;
class DELPHICLASS TWindowsXPThemeCheckBoxState;
class DELPHICLASS TWindowsXPThemeCheckBox;
class DELPHICLASS TWindowsXPThemeComboBoxDropDown;
class DELPHICLASS TWindowsXPThemeComboBox;
class DELPHICLASS TWindowsXPThemeGroupBox;
class DELPHICLASS TWindowsXPThemeEditText;
class DELPHICLASS TWindowsXPThemeEdit;
class DELPHICLASS TWindowsXPThemeExplorerBarButton;
class DELPHICLASS TWindowsXPThemeExplorerBar;
class DELPHICLASS TWindowsXPThemeHeaderItem;
class DELPHICLASS TWindowsXPThemeHeader;
class DELPHICLASS TWindowsXPThemeListView;
class DELPHICLASS TWindowsXPThemePushButtonDisabled;
class DELPHICLASS TWindowsXPThemePushButton;
class DELPHICLASS TWindowsXPThemeProgress;
class DELPHICLASS TWindowsXPThemeScrollBarPart;
class DELPHICLASS TWindowsXPThemeScrollBarButton;
class DELPHICLASS TWindowsXPThemeScrollBarSizeBox;
class DELPHICLASS TWindowsXPThemeScrollBar;
class DELPHICLASS TWindowsXPThemeSpinButton;
class DELPHICLASS TWindowsXPThemeSpin;
class DELPHICLASS TWindowsXPThemeRadioButtonDisabled;
class DELPHICLASS TWindowsXPThemeRadioButton;
class DELPHICLASS TWindowsXPThemeStatusPane;
class DELPHICLASS TWindowsXPThemeStatusGripper;
class DELPHICLASS TWindowsXPThemeStatus;
class DELPHICLASS TWindowsXPThemeTabPart;
class DELPHICLASS TWindowsXPThemeTab;
class DELPHICLASS TWindowsXPThemeToolbarPart;
class DELPHICLASS TWindowsXPThemeToolbar;
class DELPHICLASS TWindowsXPThemeTrackBarThumb;
class DELPHICLASS TWindowsXPThemeTrackBarTics;
class DELPHICLASS TWindowsXPThemeTrackBar;
class DELPHICLASS TWindowsXPThemeTreeViewGlyph;
class DELPHICLASS TWindowsXPThemeTreeView;
class DELPHICLASS TWindowsXPThemeWindowFrame;
class DELPHICLASS TWindowsXPThemeWindowCaption;
class DELPHICLASS TWindowsXPThemeWindowCaptionState;
class DELPHICLASS TWindowsXPThemeWindowButton;
class DELPHICLASS TWindowsXPThemeWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TWindowsXPThemeButton : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeButton(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeButton(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeCheckBoxState : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeCheckBoxState(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeCheckBoxState(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeCheckBox : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
private:
	TWindowsXPThemeCheckBoxState* FUncheckedDisabled;
	TWindowsXPThemeCheckBoxState* FCheckedDisabled;
	TWindowsXPThemeCheckBoxState* FMixedDisabled;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
	
public:
	__fastcall virtual TWindowsXPThemeCheckBox(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	__fastcall virtual ~TWindowsXPThemeCheckBox(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeComboBoxDropDown : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeComboBoxDropDown(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeComboBoxDropDown(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeComboBox : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeComboBox(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeComboBox(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeGroupBox : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeGroupBox(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeGroupBox(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeEditText : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
private:
	Lmdthemeswindowsxp::TWindowsXPThemePart* FDisabled;
	Lmdthemeswindowsxp::TWindowsXPThemePart* FReadOnly;
	
public:
	__fastcall virtual TWindowsXPThemeEditText(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	__fastcall virtual ~TWindowsXPThemeEditText(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeEdit : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeEdit(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeEdit(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeExplorerBarButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeExplorerBarButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeExplorerBarButton(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeExplorerBar : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeExplorerBar(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeExplorerBar(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeHeaderItem : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeHeaderItem(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeHeaderItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeHeader : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeHeader(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeHeader(void) { }
	
};


class PASCALIMPLEMENTATION TWindowsXPThemeListView : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeListView(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeListView(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemePushButtonDisabled : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemePushButtonDisabled(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemePushButtonDisabled(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemePushButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
private:
	TWindowsXPThemePushButtonDisabled* FDisabled;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
	
public:
	__fastcall virtual TWindowsXPThemePushButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	__fastcall virtual ~TWindowsXPThemePushButton(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeProgress : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeProgress(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeProgress(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeScrollBarPart : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeScrollBarPart(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeScrollBarPart(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeScrollBarButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeScrollBarButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeScrollBarButton(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeScrollBarSizeBox : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeScrollBarSizeBox(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeScrollBarSizeBox(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeScrollBar : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeScrollBar(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeScrollBar(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeSpinButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeSpinButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeSpinButton(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeSpin : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeSpin(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeSpin(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeRadioButtonDisabled : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeRadioButtonDisabled(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeRadioButtonDisabled(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeRadioButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
private:
	TWindowsXPThemeRadioButtonDisabled* FUncheckedDisabled;
	TWindowsXPThemeRadioButtonDisabled* FCheckedDisabled;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
	
public:
	__fastcall virtual TWindowsXPThemeRadioButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	__fastcall virtual ~TWindowsXPThemeRadioButton(void);
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeStatusPane : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
public:
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
	virtual void __fastcall GetThemeBackgroundExtent(HDC DC, int StateID, const System::Types::TRect &ContentRect, /* out */ System::Types::TRect &ExtentRect);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeStatusPane(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeStatusPane(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeStatusGripper : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeStatusGripper(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeStatusGripper(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeStatus : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeStatus(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeStatus(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeTabPart : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
	
public:
	virtual void __fastcall GetThemeBackgroundContentRect(HDC DC, int StateID, const System::Types::TRect &BoundingRect, /* out */ System::Types::TRect &ContentRect);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeTabPart(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTabPart(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeTab : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeTab(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTab(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeToolbarPart : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeToolbarPart(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeToolbarPart(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeToolbar : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeToolbar(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeToolbar(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeTrackBarThumb : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeTrackBarThumb(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTrackBarThumb(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeTrackBarTics : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
public:
	virtual void __fastcall DrawThemeBackground(HDC DC, int StateID, const System::Types::TRect &Rect, System::Types::PRect ClipRect);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeTrackBarTics(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTrackBarTics(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeTrackBar : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeTrackBar(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTrackBar(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeTreeViewGlyph : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeTreeViewGlyph(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTreeViewGlyph(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeTreeView : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeTreeView(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeTreeView(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeWindowFrame : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeWindowFrame(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeWindowFrame(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeWindowCaption : public TWindowsXPThemeWindowFrame
{
	typedef TWindowsXPThemeWindowFrame inherited;
	
private:
	TWindowsXPThemeWindowCaptionState* FActive;
	TWindowsXPThemeWindowCaptionState* FInActive;
	
public:
	__fastcall virtual TWindowsXPThemeWindowCaption(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	__fastcall virtual ~TWindowsXPThemeWindowCaption(void);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &Rect);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeWindowCaptionState : public TWindowsXPThemeWindowFrame
{
	typedef TWindowsXPThemeWindowFrame inherited;
	
public:
	__fastcall virtual TWindowsXPThemeWindowCaptionState(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString Section);
	virtual void __fastcall DrawThemeText(HDC DC, int StateID, System::WideChar * Text, int CharCount, unsigned TextFlags, unsigned TextFlags2, const System::Types::TRect &ARect);
public:
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeWindowCaptionState(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPThemeWindowButton : public Lmdthemeswindowsxp::TWindowsXPThemePart
{
	typedef Lmdthemeswindowsxp::TWindowsXPThemePart inherited;
	
protected:
	virtual int __fastcall GetStateRectIndex(int StateID);
public:
	/* TWindowsXPThemePart.Create */ inline __fastcall virtual TWindowsXPThemeWindowButton(Lmdthemeswindowsxp::TWindowsXPTheme* Theme, Lmdthemeswindowsxp::TWindowsXPThemePart* Parent, System::UnicodeString ASection) : Lmdthemeswindowsxp::TWindowsXPThemePart(Theme, Parent, ASection) { }
	/* TWindowsXPThemePart.Destroy */ inline __fastcall virtual ~TWindowsXPThemeWindowButton(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TWindowsXPThemeWindow : public Lmdthemeswindowsxp::TWindowsXPTheme
{
	typedef Lmdthemeswindowsxp::TWindowsXPTheme inherited;
	
public:
	__fastcall virtual TWindowsXPThemeWindow(Lmdthemesgeneral::TThemeManager* Manager);
public:
	/* TTheme.Destroy */ inline __fastcall virtual ~TWindowsXPThemeWindow(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdthemeswindowsxpparts */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESWINDOWSXPPARTS)
using namespace Lmdthemeswindowsxpparts;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemeswindowsxppartsHPP
