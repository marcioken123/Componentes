// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCurrEdit.pas' rev: 31.00 (Windows)

#ifndef ElcurreditHPP
#define ElcurreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDElConst.hpp>
#include <LMDVldBase.hpp>
#include <ElXPThemedControl.hpp>
#include <ElPopBtn.hpp>
#include <ElEdits.hpp>
#include <ElCalc.hpp>
#include <ElVCLUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcurredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCurrPartEdit;
class DELPHICLASS TElCalculatorFormCurrEdit;
class DELPHICLASS TElCurrencyEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCurrPartEdit : public Eledits::TElEdit
{
	typedef Eledits::TElEdit inherited;
	
private:
	bool FIsIntegerPart;
	System::Classes::TNotifyEvent OnPoint;
	System::Classes::TNotifyEvent OnLeftPoint;
	bool FSaveAlpha;
	System::Word FSKey;
	
protected:
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	
public:
	virtual void __fastcall CopyToClipboard(void);
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	__property System::Word SKey = {read=FSKey, write=FSKey, nodefault};
	__property bool SaveAlpha = {read=FSaveAlpha, write=FSaveAlpha, nodefault};
public:
	/* TCustomElEdit.Create */ inline __fastcall virtual TElCurrPartEdit(System::Classes::TComponent* AOwner) : Eledits::TElEdit(AOwner) { }
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElCurrPartEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCurrPartEdit(HWND ParentWindow) : Eledits::TElEdit(ParentWindow) { }
	
};


typedef TElCurrPartEdit IntEditClass;

enum DECLSPEC_DENUM TElCurrencySymbolPosition : unsigned char { ecsPosLeft, ecsPosRight };

typedef System::StaticArray<Elpopbtn::TElGraphicButton*, 2> TElGraphicButtons;

typedef System::StaticArray<System::Classes::TNotifyEvent, 2> TElGraphBtnsNotifyEvent;

class PASCALIMPLEMENTATION TElCalculatorFormCurrEdit : public Elcalc::TElCalculatorForm
{
	typedef Elcalc::TElCalculatorForm inherited;
	
private:
	int fModalResult;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElCalculatorFormCurrEdit(System::Classes::TComponent* AOwner) : Elcalc::TElCalculatorForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElCalculatorFormCurrEdit(System::Classes::TComponent* AOwner, int Dummy) : Elcalc::TElCalculatorForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElCalculatorFormCurrEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCalculatorFormCurrEdit(HWND ParentWindow) : Elcalc::TElCalculatorForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElCurrencyEdit : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	Lmdvldbase::TLMDValidationEntity* FValidator;
	Lmdtypes::TLMDString FValidationMsgString;
	bool FErrorIndication;
	Lmdvldbase::TLMDValidationErrorEvent FOnValidationError;
	bool FIgnoreReadOnlyState;
	bool FValueUndefined;
	bool FUseThousandSeparator;
	System::Currency FAbsValue;
	System::Byte FDecimalPlaces;
	bool FUseSystemDecimalPlaces;
	Lmdtypes::TLMDString FCurrencySymbol;
	TElCurrencySymbolPosition FCurrencySymbolPosition;
	bool FUseSystemCurrencySymbol;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	bool FFlat;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FMouseOver;
	bool FModified;
	int FDWidth;
	int FSWidth;
	int FBWidth;
	int FSignWidth;
	int FDSWidth;
	bool FHideSelection;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Lmdgraph::TLMDBorderSides FBorderSides;
	System::StaticArray<TElCurrPartEdit*, 2> FPartEditors;
	TElGraphicButtons FButtons;
	TElGraphBtnsNotifyEvent FButtonClicks;
	bool FEnableSign;
	bool FSign;
	System::Uitypes::TColor FNegativeValueTextColor;
	System::Uitypes::TColor FNegativeSignColor;
	bool FHandleDialogKeys;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Lmdtypes::TLMDString FHint;
	bool FUseDisabledColors;
	bool FCalcDlgResetValue;
	TElCalculatorFormCurrEdit* fCalcDlgElCalculatorForm;
	bool fCalcDlgModal;
	bool fCalcDlgButtonGlyphDefault;
	Vcl::Controls::TCaption fCalcDlgCaption;
	bool fCalcDlgShowControlButtons;
	Vcl::Graphics::TFont* fCalcDlgDigitButtonFont;
	Vcl::Graphics::TFont* fCalcDlgMemoryButtonFont;
	Vcl::Graphics::TFont* fCalcDlgOperatorButtonFont;
	Vcl::Graphics::TFont* fCalcDlgServiceButtonFont;
	Elcalc::TElMathErrorEvent fCalcDlgOnError;
	System::Classes::TNotifyEvent fCalcDlgOnShow;
	System::Classes::TNotifyEvent fCalcDlgOnClose;
	System::Classes::TNotifyEvent fCalcDlgButtonGlyphOnChange;
	System::Classes::TNotifyEvent fCalcDlgOnButtonClick;
	Elcalc::TElCalcDeactivateEvent fCalcDlgOnDeactivate;
	System::Classes::TNotifyEvent fCalcDlgOnFormShow;
	bool fCalcDlgDefZeroValue;
	int FHighlightAlphaLevel;
	Elvclutils::TElLinkCtlPos FLinkedControlPosition;
	Vcl::Controls::TControl* FLinkedControl;
	int FLinkedControlSpacing;
	System::Uitypes::TColor FDisabledColor;
	System::Uitypes::TColor FDisabledFontColor;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	System::Classes::TShortCut FCalcDlgButtonShortcut;
	System::Classes::TShortCut FButtonShortCut;
	Elvclutils::TElDisplayOptions* FDisplayReadOnlyOptions;
	bool __fastcall GetButtonIsSwitch(void);
	void __fastcall SetButtonIsSwitch(const bool Value);
	void __fastcall SetCalcDlgDigitButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgMemoryButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgOperatorButtonFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCalcDlgServiceButtonFont(Vcl::Graphics::TFont* const Value);
	virtual System::Uitypes::TColor __fastcall GetBkColor(void);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	void __fastcall SetDisplayReadOnlyOptions(Elvclutils::TElDisplayOptions* const Value);
	void __fastcall DisplayOptionsChange(System::TObject* Sender);
	virtual void __fastcall SetValueUndefined(bool Value);
	void __fastcall SetUseThousandSeparator(bool Value);
	System::UnicodeString __fastcall FracValue(System::Currency AValue);
	void __fastcall SetDecimalPlaces(const System::Byte Value);
	void __fastcall SetUseSystemDecimalPlaces(const bool Value);
	int __fastcall FindPart(TElCurrPartEdit* Editor);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall UpdateFrame(void);
	void __fastcall SetModified(bool Value);
	void __fastcall UpdateParts(void);
	void __fastcall UpdatePartsWidth(void);
	void __fastcall SetCurrencySymbol(const Lmdtypes::TLMDString Value);
	void __fastcall SetUseSystemCurrencySymbol(const bool Value);
	void __fastcall SetCurrencySymbolPosition(const TElCurrencySymbolPosition Value);
	Elpopbtn::TElGraphicButton* __fastcall GetButton(int Index);
	Lmdtypes::TLMDString __fastcall GetButtonCaption(int Index);
	System::Uitypes::TColor __fastcall GetButtonColor(int Index);
	bool __fastcall GetButtonDown(int Index);
	bool __fastcall GetButtonEnabled(int Index);
	bool __fastcall GetButtonFlat(int Index);
	bool __fastcall GetButtonVisible(int Index);
	int __fastcall GetButtonWidth(int Index);
	bool __fastcall GetButtonUseIcon(int Index);
	Vcl::Graphics::TBitmap* __fastcall GetButtonGlyph(int Index);
	Lmdtypes::TLMDString __fastcall GetButtonHint(int Index);
	Vcl::Graphics::TIcon* __fastcall GetButtonIcon(int Index);
	int __fastcall GetButtonNumGlyphs(int Index);
	Elpopbtn::TPopupPlace __fastcall GetButtonPopupPlace(int Index);
	Vcl::Menus::TPopupMenu* __fastcall GetButtonPullDownMenu(int Index);
	bool __fastcall GetButtonUseImageList(int Index);
	System::Classes::TNotifyEvent __fastcall GetOnButtonClick(int Index);
	void __fastcall SetButtonCaption(int Index, Lmdtypes::TLMDString Value);
	void __fastcall SetButtonColor(const int Index, const System::Uitypes::TColor Value);
	void __fastcall SetButtonDown(const int Index, const bool Value);
	void __fastcall SetButtonEnabled(const int Index, const bool Value);
	void __fastcall SetButtonFlat(const int Index, const bool Value);
	void __fastcall SetButtonVisible(const int Index, const bool Value);
	void __fastcall SetButtonWidth(const int Index, const int Value);
	void __fastcall SetButtonUseIcon(const int Index, const bool Value);
	void __fastcall SetButtonGlyph(const int Index, Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetButtonHint(const int Index, const Lmdtypes::TLMDString Value);
	void __fastcall SetButtonIcon(const int Index, Vcl::Graphics::TIcon* const Value);
	void __fastcall SetButtonNumGlyphs(const int Index, const int Value);
	void __fastcall SetButtonPopupPlace(const int Index, const Elpopbtn::TPopupPlace Value);
	void __fastcall SetButtonPullDownMenu(const int Index, Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetButtonUseImageList(const int Index, const bool Value);
	void __fastcall SetOnButtonClick(const int Index, const System::Classes::TNotifyEvent Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetButtonDisabledImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetButtonDownImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetButtonHotImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetButtonImageList(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaButtonDisabledImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaButtonDownImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaButtonHotImages(int Index);
	Vcl::Imglist::TCustomImageList* __fastcall GetAlphaButtonImageList(int Index);
	System::Uitypes::TImageIndex __fastcall GetButtonImageIndex(int Index);
	void __fastcall SetButtonDisabledImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetButtonDownImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetButtonHotImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetButtonImageList(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetAlphaButtonDisabledImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetAlphaButtonDownImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetAlphaButtonHotImages(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetAlphaButtonImageList(const int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetButtonImageIndex(const int Index, const System::Uitypes::TImageIndex Value);
	void __fastcall SetCalcDlgModal(bool Value);
	void __fastcall SetCalcDlgButtonGlyphDefault(bool Value);
	void __fastcall CalcDlgButtonClick(System::TObject* Sender);
	void __fastcall CalcDlgButtonGlyph_OnChanged(System::TObject* Sender);
	void __fastcall CalcDlg_OnFormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall CalcDlg_OnFormDestroy(System::TObject* Sender);
	void __fastcall CalcDlg_OnDeactivate(System::TObject* Sender, int &ModalResult);
	void __fastcall CalcDlg_bCancelClick(System::TObject* Sender);
	void __fastcall CalcDlg_bOKClick(System::TObject* Sender);
	bool __fastcall NeedStroredButtonGlyph(const int Index);
	void __fastcall LoadCalcDlgButtonGlyphDefault(void);
	void __fastcall CalcDlgFormShow(System::TObject* Sender);
	void __fastcall ButtonClickTransfer(System::TObject* Sender);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall SetEnableSign(const bool Value);
	System::Currency __fastcall GetSignValue(void);
	void __fastcall SetSign(const bool Value);
	void __fastcall SetSignValue(const System::Currency Value);
	void __fastcall SetAutoSelect(const bool Value);
	bool __fastcall GetAutoSelect(void);
	void __fastcall SetNegativeSignColor(const System::Uitypes::TColor Value);
	void __fastcall SetNegativeValueTextColor(const System::Uitypes::TColor Value);
	void __fastcall SetupPartsFont(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall OnEditorClick(System::TObject* Sender);
	void __fastcall OnEditorDblClick(System::TObject* Sender);
	void __fastcall OnEditorEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall OnEditorKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall OnEditorMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnEditorMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnEditorMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnEditorStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall OnEditorKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnEditorDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall OnEditorDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	bool __fastcall StoreCurrencySymbol(void);
	bool __fastcall StoreDecimalPlaces(void);
	void __fastcall SetAbsValue(const System::Currency Value);
	void __fastcall DrawFlatBorder(HDC DC);
	virtual void __fastcall AdjustEditorPositions(void);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	void __fastcall PaintBorder(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMWinIniChange(Winapi::Messages::TWMWinIniChange &Msg);
	DYNAMIC void __fastcall DoOnChange(void);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	void __fastcall OnEditorChange(System::TObject* Sender);
	void __fastcall OnEditorEnter(System::TObject* Sender);
	void __fastcall OnEditorExit(System::TObject* Sender);
	void __fastcall OnEditorPoint(System::TObject* Sender);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall OnEditorLeftPoint(System::TObject* Sender);
	void __fastcall OnEditorKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall SetUseDisabledColors(bool Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	bool __fastcall GetHideSelection(void);
	void __fastcall SetHideSelection(bool Value);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall UpdateLinkedControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetLinkedControlPosition(Elvclutils::TElLinkCtlPos Value);
	void __fastcall SetLinkedControl(Vcl::Controls::TControl* Value);
	void __fastcall SetLinkedControlSpacing(int Value);
	void __fastcall SetDisabledColor(System::Uitypes::TColor Value);
	void __fastcall SetDisabledFontColor(System::Uitypes::TColor Value);
	bool __fastcall GetButtonThinFrame(int Index);
	void __fastcall SetButtonThinFrame(int Index, bool Value);
	bool __fastcall GetButtonOldStyled(int Index);
	void __fastcall SetButtonOldStyled(int Index, bool Value);
	bool __fastcall GetButtonShowBorder(int Index);
	void __fastcall SetButtonShowBorder(int Index, bool Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val);
	Lmdtypes::TLMDString __fastcall GetValidationMsgString(void);
	HIDESBASE Vcl::Controls::TControl* __fastcall GetControl(void);
	Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void);
	Vcl::Graphics::TFont* __fastcall GetControlFont(void);
	Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	
public:
	__fastcall virtual TElCurrencyEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCurrencyEdit(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall SupportsDefaultIndication(void);
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	void __fastcall RespondToError(int ErrorLevel);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* Validator);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property System::Currency AbsoluteValue = {read=FAbsValue, write=SetAbsValue};
	__property Elpopbtn::TElGraphicButton* Buttons[int Index] = {read=GetButton};
	
__published:
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=FOnValidationError, write=FOnValidationError};
	__property Elvclutils::TElDisplayOptions* DisplayReadOnlyOptions = {read=FDisplayReadOnlyOptions, write=SetDisplayReadOnlyOptions};
	__property bool ValueUndefined = {read=FValueUndefined, write=SetValueUndefined, default=0};
	__property bool UseThousandSeparator = {read=FUseThousandSeparator, write=SetUseThousandSeparator, default=0};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool AutoSelect = {read=GetAutoSelect, write=SetAutoSelect, default=1};
	__property bool ButtonIsSwitch = {read=GetButtonIsSwitch, write=SetButtonIsSwitch, nodefault};
	__property System::Currency Value = {read=GetSignValue, write=SetSignValue};
	__property bool Sign = {read=FSign, write=SetSign, stored=false, nodefault};
	__property bool EnableSign = {read=FEnableSign, write=SetEnableSign, default=0};
	__property System::Uitypes::TColor NegativeSignColor = {read=FNegativeSignColor, write=SetNegativeSignColor, default=536870911};
	__property System::Uitypes::TColor NegativeValueTextColor = {read=FNegativeValueTextColor, write=SetNegativeValueTextColor, default=536870911};
	__property System::Byte DecimalPlaces = {read=FDecimalPlaces, write=SetDecimalPlaces, stored=StoreDecimalPlaces, nodefault};
	__property bool UseSystemDecimalPlaces = {read=FUseSystemDecimalPlaces, write=SetUseSystemDecimalPlaces, default=1};
	__property Lmdtypes::TLMDString CurrencySymbol = {read=FCurrencySymbol, write=SetCurrencySymbol, stored=StoreCurrencySymbol};
	__property TElCurrencySymbolPosition CurrencySymbolPosition = {read=FCurrencySymbolPosition, write=SetCurrencySymbolPosition, stored=StoreCurrencySymbol, default=1};
	__property bool UseSystemCurrencySymbol = {read=FUseSystemCurrencySymbol, write=SetUseSystemCurrencySymbol, default=0};
	__property Lmdtypes::TLMDString ButtonCaption = {read=GetButtonCaption, write=SetButtonCaption, index=0};
	__property System::Uitypes::TColor ButtonColor = {read=GetButtonColor, write=SetButtonColor, index=0, default=-16777201};
	__property bool ButtonDown = {read=GetButtonDown, write=SetButtonDown, index=0, default=0};
	__property bool ButtonEnabled = {read=GetButtonEnabled, write=SetButtonEnabled, index=0, default=1};
	__property bool ButtonFlat = {read=GetButtonFlat, write=SetButtonFlat, index=0, default=0};
	__property bool ButtonUseIcon = {read=GetButtonUseIcon, write=SetButtonUseIcon, index=0, default=0};
	__property bool ButtonVisible = {read=GetButtonVisible, write=SetButtonVisible, index=0, default=0};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, index=0, default=15};
	__property Vcl::Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, index=0};
	__property Lmdtypes::TLMDString ButtonHint = {read=GetButtonHint, write=SetButtonHint, index=0};
	__property Vcl::Graphics::TIcon* ButtonIcon = {read=GetButtonIcon, write=SetButtonIcon, index=0};
	__property int ButtonNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=0, default=1};
	__property Lmdtypes::TLMDString CalcDlgButtonCaption = {read=GetButtonCaption, write=SetButtonCaption, index=1};
	__property System::Uitypes::TColor CalcDlgButtonColor = {read=GetButtonColor, write=SetButtonColor, index=1, default=-16777201};
	__property bool CalcDlgButtonEnabled = {read=GetButtonEnabled, write=SetButtonEnabled, index=1, default=1};
	__property bool CalcDlgButtonUseIcon = {read=GetButtonUseIcon, write=SetButtonUseIcon, index=1, default=0};
	__property bool CalcDlgButtonVisible = {read=GetButtonVisible, write=SetButtonVisible, index=1, default=0};
	__property int CalcDlgButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, index=1, default=15};
	__property Vcl::Graphics::TBitmap* CalcDlgButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=NeedStroredButtonGlyph, index=1};
	__property Lmdtypes::TLMDString CalcDlgButtonHint = {read=GetButtonHint, write=SetButtonHint, index=1};
	__property Vcl::Graphics::TIcon* CalcDlgButtonIcon = {read=GetButtonIcon, write=SetButtonIcon, index=1};
	__property int CalcDlgButtonNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=1, default=1};
	__property bool CalcDlgButtonUseImageList = {read=GetButtonUseImageList, write=SetButtonUseImageList, index=1, default=0};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonImages = {read=GetButtonImageList, write=SetButtonImageList, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonDownImages = {read=GetButtonDownImages, write=SetButtonDownImages, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonHotImages = {read=GetButtonHotImages, write=SetButtonHotImages, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonDisabledImages = {read=GetButtonDisabledImages, write=SetButtonDisabledImages, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonAlphaForImages = {read=GetAlphaButtonImageList, write=SetAlphaButtonImageList, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonAlphaForDownImages = {read=GetAlphaButtonDownImages, write=SetAlphaButtonDownImages, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonAlphaForHotImages = {read=GetAlphaButtonHotImages, write=SetAlphaButtonHotImages, index=1};
	__property Vcl::Imglist::TCustomImageList* CalcDlgButtonAlphaForDisabledImages = {read=GetAlphaButtonDisabledImages, write=SetAlphaButtonDisabledImages, index=1};
	__property System::Uitypes::TImageIndex CalcDlgButtonImageIndex = {read=GetButtonImageIndex, write=SetButtonImageIndex, index=1, nodefault};
	__property System::Classes::TNotifyEvent CalcDlgOnButtonClick = {read=fCalcDlgOnButtonClick, write=fCalcDlgOnButtonClick};
	__property bool CalcDlgButtonGlyphDefault = {read=fCalcDlgButtonGlyphDefault, write=SetCalcDlgButtonGlyphDefault, default=1};
	__property bool CalcDlgModal = {read=fCalcDlgModal, write=SetCalcDlgModal, default=0};
	__property Vcl::Graphics::TFont* CalcDlgMemoryButtonFont = {read=fCalcDlgMemoryButtonFont, write=SetCalcDlgMemoryButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgDigitButtonFont = {read=fCalcDlgDigitButtonFont, write=SetCalcDlgDigitButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgOperatorButtonFont = {read=fCalcDlgOperatorButtonFont, write=SetCalcDlgOperatorButtonFont};
	__property Vcl::Graphics::TFont* CalcDlgServiceButtonFont = {read=fCalcDlgServiceButtonFont, write=SetCalcDlgServiceButtonFont};
	__property Vcl::Controls::TCaption CalcDlgCaption = {read=fCalcDlgCaption, write=fCalcDlgCaption};
	__property Elcalc::TElMathErrorEvent CalcDlgOnError = {read=fCalcDlgOnError, write=fCalcDlgOnError};
	__property System::Classes::TNotifyEvent CalcDlgOnShow = {read=fCalcDlgOnShow, write=fCalcDlgOnShow};
	__property System::Classes::TNotifyEvent CalcDlgOnClose = {read=fCalcDlgOnClose, write=fCalcDlgOnClose};
	__property Elcalc::TElCalcDeactivateEvent CalcDlgOnDeactivate = {read=fCalcDlgOnDeactivate, write=fCalcDlgOnDeactivate};
	__property bool CalcDlgShowControlButtons = {read=fCalcDlgShowControlButtons, write=fCalcDlgShowControlButtons, default=1};
	__property bool CalcDlgDefZeroValue = {read=fCalcDlgDefZeroValue, write=fCalcDlgDefZeroValue, default=1};
	__property bool CalcDlgResetValue = {read=FCalcDlgResetValue, write=FCalcDlgResetValue, default=0};
	__property Elpopbtn::TPopupPlace ButtonPopupPlace = {read=GetButtonPopupPlace, write=SetButtonPopupPlace, index=0, default=0};
	__property Vcl::Menus::TPopupMenu* ButtonPullDownMenu = {read=GetButtonPullDownMenu, write=SetButtonPullDownMenu, index=0};
	__property bool ButtonUseImageList = {read=GetButtonUseImageList, write=SetButtonUseImageList, index=0, default=0};
	__property Vcl::Imglist::TCustomImageList* ButtonImages = {read=GetButtonImageList, write=SetButtonImageList, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonDownImages = {read=GetButtonDownImages, write=SetButtonDownImages, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonHotImages = {read=GetButtonHotImages, write=SetButtonHotImages, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonDisabledImages = {read=GetButtonDisabledImages, write=SetButtonDisabledImages, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonAlphaForImages = {read=GetAlphaButtonImageList, write=SetAlphaButtonImageList, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonAlphaForDownImages = {read=GetAlphaButtonDownImages, write=SetAlphaButtonDownImages, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonAlphaForHotImages = {read=GetAlphaButtonHotImages, write=SetAlphaButtonHotImages, index=0};
	__property Vcl::Imglist::TCustomImageList* ButtonAlphaForDisabledImages = {read=GetAlphaButtonDisabledImages, write=SetAlphaButtonDisabledImages, index=0};
	__property System::Uitypes::TImageIndex ButtonImageIndex = {read=GetButtonImageIndex, write=SetButtonImageIndex, index=0, default=-1};
	__property System::Classes::TNotifyEvent OnButtonClick = {read=GetOnButtonClick, write=SetOnButtonClick, index=0};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, nodefault};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, nodefault};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, nodefault};
	__property bool UseDisabledColors = {read=FUseDisabledColors, write=SetUseDisabledColors, default=0};
	__property bool HideSelection = {read=GetHideSelection, write=SetHideSelection, default=1};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property Elvclutils::TElLinkCtlPos LinkedControlPosition = {read=FLinkedControlPosition, write=SetLinkedControlPosition, default=3};
	__property Vcl::Controls::TControl* LinkedControl = {read=FLinkedControl, write=SetLinkedControl};
	__property int LinkedControlSpacing = {read=FLinkedControlSpacing, write=SetLinkedControlSpacing, default=0};
	__property System::Uitypes::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777201};
	__property System::Uitypes::TColor DisabledFontColor = {read=FDisabledFontColor, write=SetDisabledFontColor, default=-16777199};
	__property bool ButtonThinFrame = {read=GetButtonThinFrame, write=SetButtonThinFrame, index=0, default=0};
	__property bool CalcDlgButtonFlat = {read=GetButtonFlat, write=SetButtonFlat, index=1, default=0};
	__property bool CalcDlgButtonThinFrame = {read=GetButtonThinFrame, write=SetButtonThinFrame, index=1, default=0};
	__property bool ButtonOldStyled = {read=GetButtonOldStyled, write=SetButtonOldStyled, index=0, default=0};
	__property bool CalcDlgButtonOldStyled = {read=GetButtonOldStyled, write=SetButtonOldStyled, index=1, default=0};
	__property bool ButtonShowBorder = {read=GetButtonShowBorder, write=SetButtonShowBorder, index=0, default=0};
	__property bool CalcDlgButtonShowBorder = {read=GetButtonShowBorder, write=SetButtonShowBorder, index=1, default=0};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property System::Classes::TShortCut CalcDlgButtonShortcut = {read=FCalcDlgButtonShortcut, write=FCalcDlgButtonShortcut, default=32808};
	__property System::Classes::TShortCut ButtonShortCut = {read=FButtonShortCut, write=FButtonShortCut, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCurrencyEdit(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
private:
	void *__ILMDValidatedControl;	// Lmdvldbase::ILMDValidatedControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {ED0CAB4C-DBF2-4078-8C06-000841566690}
	operator Lmdvldbase::_di_ILMDValidatedControl()
	{
		Lmdvldbase::_di_ILMDValidatedControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatedControl*(void) { return (Lmdvldbase::ILMDValidatedControl*)&__ILMDValidatedControl; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 CURRBTNCOUNT = System::Int8(0x2);
static const System::Int8 CURRBTNMIN = System::Int8(0x0);
static const System::Int8 CURRBTNMAX = System::Int8(0x1);
static const System::Int8 CURRPARTMIN = System::Int8(0x1);
static const System::Int8 CURRPARTMAX = System::Int8(0x2);
}	/* namespace Elcurredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCURREDIT)
using namespace Elcurredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcurreditHPP
