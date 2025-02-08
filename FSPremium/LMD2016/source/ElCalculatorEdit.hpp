// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCalculatorEdit.pas' rev: 31.00 (Windows)

#ifndef ElcalculatoreditHPP
#define ElcalculatoreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <ElBtnEdit.hpp>
#include <ElVCLUtils.hpp>
#include <ElCalc.hpp>
#include <ElEdits.hpp>
#include <LMDTypes.hpp>
#include <ElXPThemedControl.hpp>
#include <ElInputProcessor.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <ElImgFrm.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.Menus.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcalculatoredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCalculatorDialogPos;
class DELPHICLASS TCustomElCalculatorEdit;
class DELPHICLASS TElCalculatorEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCalculatorDialogPos : public Elcalc::TElCalculatorDialog
{
	typedef Elcalc::TElCalculatorDialog inherited;
	
protected:
	Lmdtypes::TLMDString FSaveValue;
	int FModalResult;
	Elcalc::TElCalcDeactivateEvent FOnDeactivate;
	virtual void __fastcall InitCalculatorForm(Elcalc::TElCalculatorForm* ElCalculatorForm);
	void __fastcall CalcDlg_OnFormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall CalcDlg_OnFormDestroy(System::TObject* Sender);
	void __fastcall CalcDlg_bCancelClick(System::TObject* Sender);
	void __fastcall CalcDlg_bOKClick(System::TObject* Sender);
	void __fastcall SetEditor(Eledits::TCustomElEdit* Value);
	
public:
	virtual void __fastcall ExecuteNoModal(void);
	
__published:
	__property Editor = {write=SetEditor, stored=false};
	__property Elcalc::TElCalcDeactivateEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
public:
	/* TElCalculatorDialog.Create */ inline __fastcall virtual TElCalculatorDialogPos(System::Classes::TComponent* AOwner) : Elcalc::TElCalculatorDialog(AOwner) { }
	/* TElCalculatorDialog.Destroy */ inline __fastcall virtual ~TElCalculatorDialogPos(void) { }
	
};


class PASCALIMPLEMENTATION TCustomElCalculatorEdit : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
private:
	System::Classes::TNotifyEvent FOnButtonClick;
	bool FButtonGlyphDefault;
	System::Classes::TNotifyEvent FButtonGlyphOnChange;
	Elcalc::TElCalculatorDialog* FCalcDlg;
	bool FCalcDlgDefZeroValue;
	bool FCalcDlgResetValue;
	double FValue;
	int FPrecision;
	void __fastcall CalcDlg_OnDeactivate(System::TObject* Sender, int &ModalResult);
	void __fastcall ButtonGlyph_OnChanged(System::TObject* Sender);
	void __fastcall SetButtonGlyphDefault(bool Value);
	Vcl::Graphics::TFont* __fastcall GetCalcDlgMemoryButtonFont(void);
	void __fastcall SetCalcDlgMemoryButtonFont(Vcl::Graphics::TFont* const Value);
	Vcl::Controls::TCaption __fastcall GetCalcDlgCaption(void);
	Vcl::Graphics::TFont* __fastcall GetCalcDlgDigitButtonFont(void);
	Vcl::Graphics::TFont* __fastcall GetCalcDlgOperatorButtonFont(void);
	Vcl::Graphics::TFont* __fastcall GetCalcDlgServiceButtonFont(void);
	bool __fastcall GetCalcDlgShowControlButtons(void);
	void __fastcall SetCalcDlgCaption(const Vcl::Controls::TCaption Value);
	void __fastcall SetCalcDlgDigitButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgOperatorButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgServiceButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgShowControlButtons(const bool Value);
	System::Classes::TNotifyEvent __fastcall GetOnCalcDlgClose(void);
	Elcalc::TElCalcDeactivateEvent __fastcall GetOnCalcDlgDeactivate(void);
	Elcalc::TElMathErrorEvent __fastcall GetOnCalcDlgError(void);
	System::Classes::TNotifyEvent __fastcall GetOnCalcDlgShow(void);
	void __fastcall SetOnCalcDlgClose(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnCalcDlgDeactivate(const Elcalc::TElCalcDeactivateEvent Value);
	void __fastcall SetOnCalcDlgError(const Elcalc::TElMathErrorEvent Value);
	void __fastcall SetOnCalcDlgShow(const System::Classes::TNotifyEvent Value);
	void __fastcall SetPrecision(const int Value);
	void __fastcall SetValue(const double Value);
	
protected:
	Elcalc::TElCalculatorForm* FElCalculatorForm;
	bool FCalcDlgModal;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadText(System::Classes::TReader* Reader);
	virtual void __fastcall CalcButtonClick(System::TObject* Sender);
	void __fastcall LoadButtonGlyphDefault(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	bool __fastcall NeedStroredButtonGlyph(void);
	__property System::Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property ButtonGlyph = {stored=NeedStroredButtonGlyph};
	__property bool ButtonGlyphDefault = {read=FButtonGlyphDefault, write=SetButtonGlyphDefault, default=1};
	__property bool CalcDlgModal = {read=FCalcDlgModal, write=FCalcDlgModal, default=0};
	__property Vcl::Graphics::TFont* CalcDlgMemoryButtonFont = {read=GetCalcDlgMemoryButtonFont, write=SetCalcDlgMemoryButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgDigitButtonFont = {read=GetCalcDlgDigitButtonFont, write=SetCalcDlgDigitButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgOperatorButtonFont = {read=GetCalcDlgOperatorButtonFont, write=SetCalcDlgOperatorButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgServiceButtonFont = {read=GetCalcDlgServiceButtonFont, write=SetCalcDlgServiceButtonFont};
	__property Vcl::Controls::TCaption CalcDlgCaption = {read=GetCalcDlgCaption, write=SetCalcDlgCaption};
	__property bool CalcDlgShowControlButtons = {read=GetCalcDlgShowControlButtons, write=SetCalcDlgShowControlButtons, nodefault};
	__property bool CalcDlgDefZeroValue = {read=FCalcDlgDefZeroValue, write=FCalcDlgDefZeroValue, default=1};
	__property bool CalcDlgResetValue = {read=FCalcDlgResetValue, write=FCalcDlgResetValue, default=0};
	__property double Value = {read=FValue, write=SetValue};
	__property int Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property Elcalc::TElMathErrorEvent OnCalcDlgError = {read=GetOnCalcDlgError, write=SetOnCalcDlgError};
	__property System::Classes::TNotifyEvent OnCalcDlgShow = {read=GetOnCalcDlgShow, write=SetOnCalcDlgShow};
	__property System::Classes::TNotifyEvent OnCalcDlgClose = {read=GetOnCalcDlgClose, write=SetOnCalcDlgClose};
	__property Elcalc::TElCalcDeactivateEvent OnCalcDlgDeactivate = {read=GetOnCalcDlgDeactivate, write=SetOnCalcDlgDeactivate};
	virtual void __fastcall SetReadOnly(bool newValue);
	
public:
	__fastcall virtual TCustomElCalculatorEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElCalculatorEdit(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElCalculatorEdit(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElCalculatorEdit : public TCustomElCalculatorEdit
{
	typedef TCustomElCalculatorEdit inherited;
	
__published:
	__property CalcDlgModal = {default=0};
	__property ButtonGlyphDefault = {default=1};
	__property CalcDlgMemoryButtonFont;
	__property CalcDlgDigitButtonFont;
	__property CalcDlgOperatorButtonFont;
	__property CalcDlgServiceButtonFont;
	__property CalcDlgCaption = {default=0};
	__property CalcDlgShowControlButtons;
	__property CalcDlgDefZeroValue = {default=1};
	__property CalcDlgResetValue = {default=0};
	__property OnCalcDlgError;
	__property OnCalcDlgShow;
	__property OnCalcDlgClose;
	__property OnCalcDlgDeactivate;
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
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
	__property Value = {default=0};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseBackground = {default=0};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonDown = {default=0};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonGlyph;
	__property ButtonHint = {default=0};
	__property ButtonIcon;
	__property ButtonIsSwitch = {default=0};
	__property ButtonNumGlyphs = {default=1};
	__property ButtonPopupPlace = {default=0};
	__property ButtonPullDownMenu;
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonUseIcon = {default=0};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property OnButtonClick;
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
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
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
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
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
	__property ReadOnly = {default=0};
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
	/* TCustomElCalculatorEdit.Create */ inline __fastcall virtual TElCalculatorEdit(System::Classes::TComponent* AOwner) : TCustomElCalculatorEdit(AOwner) { }
	/* TCustomElCalculatorEdit.Destroy */ inline __fastcall virtual ~TElCalculatorEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCalculatorEdit(HWND ParentWindow) : TCustomElCalculatorEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcalculatoredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCALCULATOREDIT)
using namespace Elcalculatoredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcalculatoreditHPP
