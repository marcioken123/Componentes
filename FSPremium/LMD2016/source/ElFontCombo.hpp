// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFontCombo.pas' rev: 31.00 (Windows)

#ifndef ElfontcomboHPP
#define ElfontcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDGraphUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElFontListBox.hpp>
#include <ElCombos.hpp>
#include <ElEdits.hpp>
#include <Vcl.Controls.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElImgFrm.hpp>
#include <LMDGraph.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.Menus.hpp>
#include <LMDPNGImage.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elfontcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFontComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElFontComboBox : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
protected:
	Elcombos::TElFontComboOptions FOptions;
	Lmdtypes::TLMDString FSampleText;
	System::Uitypes::TFontPitch FFontPitch;
	Elcombos::TElFontSampleMode FSampleMode;
	Elcombos::TElFontDevice FFontDevice;
	System::UnicodeString FFontName;
	bool ListFilled;
	bool FManualEdit;
	int FItemIndex;
	void __fastcall SetFontName(System::Uitypes::TFontName Value);
	void __fastcall SetOptions(Elcombos::TElFontComboOptions Value);
	void __fastcall SetSampleText(Lmdtypes::TLMDString Value);
	void __fastcall SetFontPitch(System::Uitypes::TFontPitch Value);
	void __fastcall SetSampleMode(Elcombos::TElFontSampleMode Value);
	virtual void __fastcall CreateWnd(void);
	Lmdtypes::TLMDString __fastcall GetItemText(int index);
	virtual int __fastcall GetItemWidth(int Index);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SetFontDevice(Elcombos::TElFontDevice Value);
	void __fastcall AddFont(System::Uitypes::TFontName Font, int FontType);
	System::Uitypes::TFontName __fastcall GetFontName(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetManualEdit(bool Value);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	int __fastcall GetItemIndex(void);
	
public:
	void __fastcall RebuildFontList(void);
	__fastcall virtual TElFontComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFontComboBox(void);
	virtual void __fastcall DoChange(void);
	int __fastcall FontIndex(System::Uitypes::TFontName AFontName);
	System::Uitypes::TFontName __fastcall FontNameByIndex(int AFontIndex);
	
__published:
	__property System::Uitypes::TFontName FontName = {read=GetFontName, write=SetFontName};
	__property Elcombos::TElFontComboOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Lmdtypes::TLMDString SampleText = {read=FSampleText, write=SetSampleText};
	__property System::Uitypes::TFontPitch FontPitch = {read=FFontPitch, write=SetFontPitch, nodefault};
	__property Elcombos::TElFontSampleMode SampleMode = {read=FSampleMode, write=SetSampleMode, nodefault};
	__property Elcombos::TElFontDevice FontDevice = {read=FFontDevice, write=SetFontDevice, nodefault};
	__property bool ManualEdit = {read=FManualEdit, write=SetManualEdit, default=0};
	__property int ItemIndex = {read=GetItemIndex, write=FItemIndex, nodefault};
	__property ReadOnly = {default=0};
	__property ShowGripper = {default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property ListColor = {default=-16777211};
	__property ListImageForm;
	__property ListInvertSelection = {default=0};
	__property Sorted = {default=0};
	__property UseBackground = {default=0};
	__property OnDropDown;
	__property AdjustDropDownPos = {default=1};
	__property ShowLineHint = {default=0};
	__property HorizontalScroll = {default=0};
	__property DropDownAlignment = {default=1};
	__property AlignBottom = {default=1};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property BorderSides = {default=15};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property ImageForm;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonOldStyled = {default=0};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonShowBorder = {default=1};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIsSwitch = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonOldStyled = {default=0};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShowBorder = {default=1};
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonPngGlyph;
	__property AltButtonUsePng;
	__property OnAltButtonClick;
	__property BorderStyle = {default=1};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFontComboBox(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elfontcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFONTCOMBO)
using namespace Elfontcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElfontcomboHPP
