// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElImgCombo.pas' rev: 31.00 (Windows)

#ifndef ElimgcomboHPP
#define ElimgcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <ElEdits.hpp>
#include <ElCombos.hpp>
#include <ElVCLUtils.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElImgFrm.hpp>
#include <LMDGraph.hpp>
#include <Vcl.Graphics.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.Menus.hpp>
#include <LMDPNGImage.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elimgcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElImageComboBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElImageNameEvent)(System::TObject* Sender, int Index, Lmdtypes::TLMDString &Text);

class PASCALIMPLEMENTATION TElImageComboBox : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
private:
	Vcl::Imglist::TChangeLink* FChLink;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FAChLink;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	bool FModified;
	System::Classes::TStrings* FImageNames;
	int IOffs;
	bool FUseImageNames;
	void __fastcall ImagesChanged(System::TObject* Sender);
	HIDESBASE void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall Remake(void);
	int __fastcall GetImageIndex(void);
	void __fastcall SetImageIndex(const int Value);
	HIDESBASE void __fastcall SetModified(const bool Value);
	void __fastcall SetImageNames(System::Classes::TStrings* Value);
	void __fastcall SetUseImageNames(bool Value);
	
protected:
	TElImageNameEvent FOnImageName;
	bool FManualEdit;
	System::UnicodeString FEmptyValueText;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoDropDown(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall DoChange(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall TriggerImageNameEvent(int Index, Lmdtypes::TLMDString &Text);
	void __fastcall SetManualEdit(bool Value);
	bool __fastcall GetShowEmptyValue(void);
	void __fastcall SetShowEmptyValue(bool Value);
	virtual void __fastcall Loaded(void);
	void __fastcall SetEmptyValueText(const System::UnicodeString Value);
	void __fastcall RebuildList(void);
	virtual int __fastcall GetItemWidth(int Index);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall DisplayOptionsChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElImageComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElImageComboBox(void);
	
__published:
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property bool ManualEdit = {read=FManualEdit, write=SetManualEdit, default=1};
	__property bool ShowEmptyValue = {read=GetShowEmptyValue, write=SetShowEmptyValue, default=1};
	__property System::UnicodeString EmptyValueText = {read=FEmptyValueText, write=SetEmptyValueText};
	__property TElImageNameEvent OnImageName = {read=FOnImageName, write=FOnImageName};
	__property System::Classes::TStrings* ImageNames = {read=FImageNames, write=SetImageNames};
	__property bool UseImageNames = {read=FUseImageNames, write=SetUseImageNames, default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property ReadOnly = {default=0};
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
	__property AlignBottom = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TElImageComboBox(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elimgcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELIMGCOMBO)
using namespace Elimgcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElimgcomboHPP
