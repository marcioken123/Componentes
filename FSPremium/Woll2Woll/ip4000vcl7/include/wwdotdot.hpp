// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwdotdot.pas' rev: 6.00

#ifndef WwdotdotHPP
#define WwdotdotHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <wwcombobutton.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Wwdatsrc.hpp>	// Pascal unit
#include <wwdblook.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdotdot
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDBCustomCombo;
class PASCALIMPLEMENTATION TwwDBCustomCombo : public Wwdbedit::TwwDBCustomEdit 
{
	typedef Wwdbedit::TwwDBCustomEdit inherited;
	
private:
	Controls::TWinControl* FBtnControl;
	Wwcombobutton::TwwComboButton* FButton;
	Classes::TNotifyEvent FOnCustomDlg;
	Wwdblook::TwwDBLookupComboStyle FStyle;
	Wwframe::TwwComboButtonStyle FButtonStyle;
	bool FDroppedDown;
	bool FMouseInButtonControl;
	bool FLimitEditRect;
	Wwframe::TwwButtonEffects* FButtonEffects;
	int FButtonWidth;
	bool SkipUpdate;
	bool FAutoEnableEdit;
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	void __fastcall SetButtonGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	void __fastcall NonEditMouseDown(Messages::TWMMouse &Message);
	void __fastcall SetButtonStyle(Wwframe::TwwComboButtonStyle val);
	void __fastcall UpdateButtonPosition(void);
	void __fastcall SetButtonWidth(int val);
	int __fastcall GetButtonWidth(void);
	
protected:
	virtual bool __fastcall IsCustom(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall UpdateButtonGlyph(void);
	virtual void __fastcall DrawButton(Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, Controls::TControlState ControlState, bool &DefaultPaint);
	virtual void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &msg);
	void __fastcall BtnClick(System::TObject* sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall GetShowButton(void);
	virtual void __fastcall SetShowButton(bool sel);
	DYNAMIC int __fastcall GetIconIndent(void);
	DYNAMIC int __fastcall GetIconLeft(void);
	virtual bool __fastcall Editable(void);
	virtual bool __fastcall MouseEditable(void);
	virtual bool __fastcall IsDroppedDown(void);
	virtual void __fastcall CloseUp(bool Accept);
	void __fastcall HandleDropDownKeys(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	void __fastcall InvalidateTransparentButton(void);
	
public:
	__fastcall virtual TwwDBCustomCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomCombo(void);
	virtual void __fastcall DropDown(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	__property bool AutoEnableEdit = {read=FAutoEnableEdit, write=FAutoEnableEdit, default=1};
	__property Wwcombobutton::TwwComboButton* Button = {read=FButton};
	__property Classes::TNotifyEvent OnCustomDlg = {read=FOnCustomDlg, write=FOnCustomDlg};
	__property Wwdblook::TwwDBLookupComboStyle Style = {read=FStyle, write=FStyle, nodefault};
	__property Wwframe::TwwComboButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property Wwframe::TwwButtonEffects* ButtonEffects = {read=FButtonEffects, write=FButtonEffects};
	__property bool LimitEditRect = {read=FLimitEditRect, write=FLimitEditRect, default=0};
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=IsCustom};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomCombo(HWND ParentWindow) : Wwdbedit::TwwDBCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBComboDlg;
class PASCALIMPLEMENTATION TwwDBComboDlg : public TwwDBCustomCombo 
{
	typedef TwwDBCustomCombo inherited;
	
__published:
	__property DisableThemes  = {default=0};
	__property OnCustomDlg ;
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property ParentBiDiMode  = {default=1};
	__property AutoEnableEdit  = {default=1};
	__property ShowButton ;
	__property Style ;
	__property ButtonStyle  = {default=0};
	__property AutoFillDate  = {default=1};
	__property AutoSelect  = {default=1};
	__property AutoSize  = {default=1};
	__property BorderStyle  = {default=1};
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Ctl3D ;
	__property DataField ;
	__property DataSource ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ButtonEffects ;
	__property Frame ;
	__property ButtonWidth  = {default=0};
	__property ButtonGlyph ;
	__property Font ;
	__property EditAlignment  = {default=0};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property LimitEditRect  = {default=0};
	__property MaxLength  = {default=0};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PasswordChar  = {default=0};
	__property Picture ;
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property WordWrap ;
	__property UnboundDataType ;
	__property UsePictureMask  = {default=1};
	__property Visible  = {default=1};
	__property UnboundAlignment  = {default=0};
	__property OnChange ;
	__property OnCheckValue ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TwwDBCustomCombo.Create */ inline __fastcall virtual TwwDBComboDlg(Classes::TComponent* AOwner) : TwwDBCustomCombo(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomCombo.Destroy */ inline __fastcall virtual ~TwwDBComboDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBComboDlg(HWND ParentWindow) : TwwDBCustomCombo(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwComboDlgButton;
class PASCALIMPLEMENTATION TwwComboDlgButton : public Wwcombobutton::TwwComboButton 
{
	typedef Wwcombobutton::TwwComboButton inherited;
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
public:
	#pragma option push -w-inl
	/* TwwComboButton.Create */ inline __fastcall virtual TwwComboDlgButton(Classes::TComponent* AOwner) : Wwcombobutton::TwwComboButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwComboButton.Destroy */ inline __fastcall virtual ~TwwComboDlgButton(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwdotdot)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwdotdot */
using namespace Wwdotdot;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwdotdot
