// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDriveCombo.pas' rev: 31.00 (Windows)

#ifndef EldrivecomboHPP
#define EldrivecomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDShUtils.hpp>
#include <LMDThemes.hpp>
#include <ElShellUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElCombos.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElImgFrm.hpp>
#include <ElInputProcessor.hpp>
#include <LMDGraph.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.Menus.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldrivecombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDriveComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElDriveComboOption : unsigned char { dcoDisplayFloppy, dcoDisplayNetwork, dcoDisplayHard, dcoDisplayCD, dcoDisplayRAM };

typedef System::Set<TElDriveComboOption, TElDriveComboOption::dcoDisplayFloppy, TElDriveComboOption::dcoDisplayRAM> TElDriveComboOptions;

class PASCALIMPLEMENTATION TElDriveComboBox : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
private:
	System::WideChar FDummyChar;
	
protected:
	System::WideChar FDrive;
	Elvclutils::TElTextCase FTextCase;
	TElDriveComboOptions FOptions;
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall FillItems(void);
	void __fastcall SetDrive(System::WideChar Value);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetTextCase(Elvclutils::TElTextCase Value);
	void __fastcall SetOptions(TElDriveComboOptions Value);
	virtual void __fastcall DoChange(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElDriveComboBox(System::Classes::TComponent* AOwner);
	__property System::WideChar Drive = {read=FDrive, write=SetDrive, nodefault};
	__property System::WideChar ItemIndex = {read=FDummyChar, nodefault};
	
__published:
	__property Elvclutils::TElTextCase TextCase = {read=FTextCase, write=SetTextCase, default=2};
	__property TElDriveComboOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property ButtonArrowColor = {default=-16777198};
	__property ShowGripper = {default=0};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property ListColor = {default=-16777211};
	__property ListImageForm;
	__property ListInvertSelection = {default=0};
	__property UseBackground = {default=0};
	__property OnDropDown;
	__property AdjustDropDownPos = {default=1};
	__property ShowLineHint = {default=0};
	__property HorizontalScroll = {default=0};
	__property OnDrawItem;
	__property OnMeasureItem;
	__property DropDownAlignment = {default=1};
	__property ReadOnly = {default=0};
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property MaxLength = {default=0};
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
	/* TCustomElComboBox.Destroy */ inline __fastcall virtual ~TElDriveComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDriveComboBox(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldrivecombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDRIVECOMBO)
using namespace Eldrivecombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldrivecomboHPP
