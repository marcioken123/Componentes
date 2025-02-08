// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTaskDialogTemplate.pas' rev: 31.00 (Windows)

#ifndef LmdtaskdialogtemplateHPP
#define LmdtaskdialogtemplateHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <LMDTaskDialog.hpp>
#include <LMDUnicodeCtrls.hpp>
#include <LMDStrings.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtaskdialogtemplate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCommandLinkButton;
class DELPHICLASS TLMDProgressBar;
class DELPHICLASS TLMDCollapseButton;
class DELPHICLASS TLMDCustomTaskDialog;
//-- type declarations -------------------------------------------------------
typedef Vcl::Stdctrls::TCheckBox TLMDTaskCheckBox;

typedef Vcl::Stdctrls::TRadioButton TLMDTaskRadioButton;

typedef Vcl::Stdctrls::TButton TLMDTaskButton;

typedef Lmdunicodectrls::TLMDWideLabel TLMDTaskLabel;

class PASCALIMPLEMENTATION TLMDCommandLinkButton : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FIsDefault;
	bool FIsElevationButton;
	System::Uitypes::TModalResult FModalResult;
	int FDefaultHeight;
	Lmdtypes::TLMDString FNote;
	bool FShowIcon;
	Lmdtypes::TLMDString FCaption;
	int FMarginVertical;
	int FMarginHorizontal;
	System::Types::TRect FTextRect;
	void __fastcall SetIsDefault(const bool Value);
	void __fastcall SetIsElevationButton(const bool Value);
	void __fastcall DrawDefaultBorder(void);
	void __fastcall DrawHotBorder(void);
	void __fastcall DrawCaption(void);
	void __fastcall DrawNote(void);
	void __fastcall SetNote(const Lmdtypes::TLMDString Value);
	void __fastcall SetShowIcon(const bool Value);
	void __fastcall SetMarginHorizontal(const int Value);
	void __fastcall SetMarginVertical(const int Value);
	
protected:
	Vcl::Graphics::TCanvas* FCanvas;
	bool FMouseInControl;
	bool FButtonDown;
	Vcl::Controls::TImageList* FImages;
	void __fastcall ReCalcHeight(void);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	virtual void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMMouseenter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseleave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Click(void);
	
public:
	__fastcall virtual TLMDCommandLinkButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCommandLinkButton(void);
	__property Lmdtypes::TLMDString Note = {read=FNote, write=SetNote};
	__property bool IsDefault = {read=FIsDefault, write=SetIsDefault, nodefault};
	__property bool IsElevationButton = {read=FIsElevationButton, write=SetIsElevationButton, nodefault};
	__property int MarginVertical = {read=FMarginVertical, write=SetMarginVertical, nodefault};
	__property int MarginHorizontal = {read=FMarginHorizontal, write=SetMarginHorizontal, nodefault};
	__property bool ShowIcon = {read=FShowIcon, write=SetShowIcon, nodefault};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property OnClick;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCommandLinkButton(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDProgressBar : public Vcl::Comctrls::TProgressBar
{
	typedef Vcl::Comctrls::TProgressBar inherited;
	
private:
	bool FMarquee;
	unsigned FMarqueeDelay;
	unsigned FMarqueeSpeed;
	void __fastcall SetMarquee(const bool Value);
	void __fastcall SetMarqueeSpeed(const unsigned Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TLMDProgressBar(System::Classes::TComponent* AOwner);
	void __fastcall UpdateProgressBar(void);
	
__published:
	__property bool Marquee = {read=FMarquee, write=SetMarquee, default=0};
	__property unsigned MarqueeSpeed = {read=FMarqueeSpeed, write=SetMarqueeSpeed, default=60};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDProgressBar(HWND ParentWindow) : Vcl::Comctrls::TProgressBar(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDProgressBar(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCollapseButton : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FChecked;
	int FCaptionPadding;
	Lmdtypes::TLMDString FCollapsedText;
	Lmdtypes::TLMDString FExpandedText;
	bool FMouseAbove;
	bool FDown;
	Vcl::Controls::TImageList* FImages;
	Lmdtypes::TLMDString FCaption;
	int FTextWidth;
	int FTextHeight;
	void __fastcall SetCollapsedText(const Lmdtypes::TLMDString Value);
	void __fastcall SetExpandedText(const Lmdtypes::TLMDString Value);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintWindow(HDC DC);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	void __fastcall Toggle(void);
	virtual void __fastcall SetChecked(bool Value);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Click(void);
	HIDESBASE MESSAGE void __fastcall CMTextchanged(Winapi::Messages::TMessage &Message);
	__property bool MouseAbove = {read=FMouseAbove, nodefault};
	__property bool Down = {read=FDown, nodefault};
	
public:
	__fastcall virtual TLMDCollapseButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCollapseButton(void);
	void __fastcall CalcNewSize(void);
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Lmdtypes::TLMDString CollapsedText = {read=FCollapsedText, write=SetCollapsedText};
	__property Lmdtypes::TLMDString ExpandedText = {read=FExpandedText, write=SetExpandedText};
	__property bool Checked = {read=FChecked, write=SetChecked, nodefault};
	__property OnClick;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCollapseButton(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomTaskDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	int FVericalControlPadding;
	int FHorzPadding;
	int FCalculatedWidth;
	int FLeftMargin;
	Vcl::Graphics::TBitmap* FShieldBmp;
	Vcl::Graphics::TBitmap* FSmallShield;
	bool __fastcall IsSetFlag(unsigned AValue);
	bool __fastcall IsCommonButtonExists(int ACommonButton);
	bool __fastcall IsButtonsExists(void);
	bool __fastcall IsRadioButtonsExists(void);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FreeListObjects(System::Classes::TList* ATempList);
	void __fastcall SetupVerificationCheckBox(void);
	void __fastcall SetupCommonButtons(int &ALeftPos);
	void __fastcall SetupButtons(int &ALeftPos);
	bool __fastcall ClickButton(System::Classes::TList* AList, int AButtonId);
	bool __fastcall EnableButton(System::Classes::TList* AList, int AButtonId, bool AEnabled);
	Vcl::Controls::TControl* __fastcall GetButtonById(System::Classes::TList* AList, int AButtonId);
	void __fastcall SetupCollapse(void);
	void __fastcall SetupFooterContent(void);
	void __fastcall SetupMainIcon(void);
	void __fastcall SetupFooterIcon(void);
	void __fastcall SetupExpandInfo(void);
	void __fastcall SetupCommandLinks(void);
	void __fastcall ClearList(System::Classes::TList* LList);
	void __fastcall SetupWindow(void);
	void __fastcall CorrectButtonsPosition(int LOldClientWidth);
	
protected:
	Lmdunicodectrls::TLMDWideLabel* FMainInstruction;
	Lmdunicodectrls::TLMDWideLabel* FContent;
	Lmdunicodectrls::TLMDWideLabel* FExpandText;
	TLMDProgressBar* FProgressBar;
	Vcl::Extctrls::TPanel* FButtonPanel;
	Vcl::Extctrls::TPanel* FFooterPanel;
	Vcl::Extctrls::TPanel* FExpandedInfo;
	Lmdunicodectrls::TLMDWideLabel* FFooterText;
	System::Classes::TList* FCommonButtons;
	System::Classes::TList* FButtons;
	System::Classes::TList* FRadioButtons;
	System::Classes::TList* FGarbageList;
	Vcl::Extctrls::TTimer* FCallbackTimer;
	unsigned FTimerCount;
	Lmdtaskdialog::TASKDIALOGCONFIG FConfig;
	Vcl::Stdctrls::TCheckBox* FVerification;
	TLMDCollapseButton* FCollapse;
	Vcl::Extctrls::TImage* FFooterIcon;
	Vcl::Extctrls::TImage* FMainIcon;
	int FResultButton;
	int __fastcall GetResultRadioButtonId(void);
	void __fastcall TriggerShow(System::TObject* Sender);
	virtual void __fastcall TriggerCreated(void);
	virtual void __fastcall TriggerNavigated(void);
	virtual void __fastcall TriggerDialogConstructed(void);
	virtual void __fastcall TriggerRadionButtonClick(System::TObject* Sender);
	virtual void __fastcall TriggerButtonClick(System::TObject* Sender);
	virtual void __fastcall TriggerTimer(System::TObject* Sender);
	virtual void __fastcall TriggerLinkClick(System::TObject* Sender, Lmdtypes::TLMDString AHref);
	virtual void __fastcall TriggerExpandArea(System::TObject* Sender);
	virtual void __fastcall SetupRadioButtons(void);
	virtual void __fastcall SetupProgressBar(void);
	virtual void __fastcall SetupContent(void);
	virtual void __fastcall SetupMainInstruction(void);
	void __fastcall VerticalRealignControls(void);
	void __fastcall HorizontalRealignControls(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall PrepareTaskDialog(void);
	DYNAMIC void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomTaskDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomTaskDialog(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDCustomTaskDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomTaskDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE HRESULT __stdcall TaskDialogIndirect(const Lmdtaskdialog::TASKDIALOGCONFIG &ptc, int &pnButton, int &pnRadioButton, bool &pfVerificationFlagChecked);
extern DELPHI_PACKAGE HRESULT __stdcall TaskDialog(HWND hwndParent, unsigned hInstance, System::WideChar * pszWindowTitle, System::WideChar * pszMainInstruction, System::WideChar * pszContent, unsigned dwCommonButtons, System::WideChar * pszIcon, int &pnButton);
}	/* namespace Lmdtaskdialogtemplate */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTASKDIALOGTEMPLATE)
using namespace Lmdtaskdialogtemplate;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtaskdialogtemplateHPP
