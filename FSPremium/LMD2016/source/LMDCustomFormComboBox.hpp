// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomFormComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomformcomboboxHPP
#define LmdcustomformcomboboxHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDDropdownForm.hpp>
#include <LMDButtonBase.hpp>
#include <LMDButton.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDBevel.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDSBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomformcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDControlForm;
class DELPHICLASS TLMDCustomFormComboBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnCloseUpEvent)(System::TObject* Sender, Lmdtypes::TLMDString &NewText, Lmdtypes::TLMDString OldText, Vcl::Controls::TWinControl* Control, bool &aAcceptValue);

class PASCALIMPLEMENTATION TLMDControlForm : public Lmddropdownform::TLMDDropDownForm
{
	typedef Lmddropdownform::TLMDDropDownForm inherited;
	
private:
	Lmdsimplepanel::TLMDSimplePanel* FMainPanel;
	Lmdsimplepanel::TLMDSimplePanel* FControlPanel;
	Lmdsimplepanel::TLMDSimplePanel* FButtonPanel;
	Lmdbutton::TLMDButton* FOkBtn;
	Lmdbutton::TLMDButton* FCancelBtn;
	Vcl::Controls::TWinControl* FOldControlParent;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMDeactivate(Winapi::Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	
public:
	__fastcall virtual TLMDControlForm(System::Classes::TComponent* AOwner, int Dummy);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall InitControl(void);
	virtual void __fastcall InitButtons(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDControlForm(System::Classes::TComponent* AOwner) : Lmddropdownform::TLMDDropDownForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDControlForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDControlForm(HWND ParentWindow) : Lmddropdownform::TLMDDropDownForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomFormComboBox : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	bool FDroppedDown;
	System::Classes::TAlignment FDropDownAlignment;
	TLMDControlForm* FForm;
	int FFormWidth;
	int FFormHeight;
	int FFormBorderWidth;
	bool FEditorEnabled;
	bool FAllowDropDown;
	System::Classes::TNotifyEvent FOnDropDown;
	TLMDOnCloseUpEvent FOnCloseUp;
	System::Uitypes::TColor FFormColor;
	System::Uitypes::TColor FControlPanelColor;
	System::Uitypes::TColor FButtonPanelColor;
	bool FKeepWithinForm;
	Lmdtypes::TLMDString FOkCaption;
	Lmdtypes::TLMDString FCancelCaption;
	bool FShowOkCancelButtons;
	Vcl::Controls::TWinControl* FControl;
	Lmdbevel::TLMDBevel* FMainPanelBevel;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKILLFOCUS(Winapi::Messages::TWMKillFocus &Message);
	void __fastcall FormChange(System::TObject* Sender);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall SetAllowDropDown(const bool Value);
	void __fastcall SetControl(Vcl::Controls::TWinControl* const Value);
	void __fastcall SetMainPanelBevel(Lmdbevel::TLMDBevel* const Value);
	Lmdsimplepanel::TLMDSimplePanel* __fastcall GetButtonPanel(void);
	Lmdsimplepanel::TLMDSimplePanel* __fastcall GetControlPanel(void);
	Lmdsimplepanel::TLMDSimplePanel* __fastcall GetMainPanel(void);
	
protected:
	virtual bool __fastcall AllowedOperation(Lmdtypes::TLMDString textToInsert);
	virtual void __fastcall DoAClick(System::TObject* Btn, int index);
	virtual void __fastcall DoDropDown(void);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall DoCloseUp(Lmdtypes::TLMDString &NewText, Lmdtypes::TLMDString OldText, Vcl::Controls::TWinControl* Control, bool &aAcceptValue);
	virtual void __fastcall CloseUp(bool AcceptValue);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall ModifyPaintRect(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCustomFormComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomFormComboBox(void);
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	__property Lmdsimplepanel::TLMDSimplePanel* MainPanel = {read=GetMainPanel};
	__property Lmdsimplepanel::TLMDSimplePanel* ControlPanel = {read=GetControlPanel};
	__property Lmdsimplepanel::TLMDSimplePanel* ButtonPanel = {read=GetButtonPanel};
	
__published:
	__property AutoSize = {default=0};
	__property Alignment = {default=0};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=10};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property Vcl::Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property System::Uitypes::TColor FormColor = {read=FFormColor, write=FFormColor, default=-16777201};
	__property int FormWidth = {read=FFormWidth, write=FFormWidth, default=-1};
	__property int FormHeight = {read=FFormHeight, write=FFormHeight, default=-1};
	__property int FormBorderWidth = {read=FFormBorderWidth, write=FFormBorderWidth, default=0};
	__property Lmdbevel::TLMDBevel* MainPanelBevel = {read=FMainPanelBevel, write=SetMainPanelBevel};
	__property System::Uitypes::TColor ControlPanelColor = {read=FControlPanelColor, write=FControlPanelColor, default=-16777201};
	__property System::Uitypes::TColor ButtonPanelColor = {read=FButtonPanelColor, write=FButtonPanelColor, default=-16777201};
	__property bool KeepWithinForm = {read=FKeepWithinForm, write=FKeepWithinForm, default=0};
	__property bool AllowDropDown = {read=FAllowDropDown, write=SetAllowDropDown, default=1};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property Lmdtypes::TLMDString OkCaption = {read=FOkCaption, write=FOkCaption};
	__property Lmdtypes::TLMDString CancelCaption = {read=FCancelCaption, write=FCancelCaption};
	__property bool ShowOkCancelButtons = {read=FShowOkCancelButtons, write=FShowOkCancelButtons, nodefault};
	__property ReadOnly = {index=1, default=0};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TLMDOnCloseUpEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Options = {default=56};
	__property MaskType = {default=8};
	__property Mask = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFormComboBox(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomformcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMFORMCOMBOBOX)
using namespace Lmdcustomformcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomformcomboboxHPP
