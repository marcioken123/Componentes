// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElIPEdit.pas' rev: 31.00 (Windows)

#ifndef ElipeditHPP
#define ElipeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <System.Math.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.WinSock.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.UxTheme.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <ElVCLUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDClass.hpp>
#include <LMDElConst.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elipedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElIPPartEdit;
class DELPHICLASS TElIPEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElIPPartEdit : public Eledits::TElEdit
{
	typedef Eledits::TElEdit inherited;
	
private:
	System::Classes::TNotifyEvent OnPoint;
	System::Classes::TNotifyEvent OnLeftPoint;
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TElIPPartEdit(System::Classes::TComponent* AOwner);
public:
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElIPPartEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElIPPartEdit(HWND ParentWindow) : Eledits::TElEdit(ParentWindow) { }
	
};


typedef TElIPPartEdit IntEditClass;

class PASCALIMPLEMENTATION TElIPEdit : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	bool FFlat;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FMouseOver;
	bool FModified;
	bool FHideSelection;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	System::StaticArray<bool, 4> FPartCanEdit;
	System::StaticArray<TElIPPartEdit*, 4> FPartEditors;
	System::StaticArray<System::Byte, 4> FParts;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Lmdtypes::TLMDString FHint;
	Vcl::Themes::TThemedElementDetails __fastcall GetThemedElementDetails(void);
	int __fastcall FindPart(TElIPPartEdit* Editor);
	System::Byte __fastcall GetPart(int Index);
	bool __fastcall GetPartCanEdit(int Index);
	void __fastcall SetPart(int Index, System::Byte Value);
	void __fastcall SetPartCanEdit(int Index, bool Value);
	unsigned __fastcall GetIPAddress(void);
	void __fastcall SetIPAddress(unsigned Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall UpdateFrame(void);
	void __fastcall SetModified(bool Value);
	void __fastcall SetIPString(System::UnicodeString value);
	System::UnicodeString __fastcall GetIPString(void);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall ClickHandler(System::TObject* Sender);
	void __fastcall ContextPopupHandler(System::TObject* Sender, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall DblClickHandler(System::TObject* Sender);
	void __fastcall DragDropHandler(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DragOverHandler(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall EndDragHandler(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall KeyDownHandler(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall KeyPressHandler(System::TObject* Sender, System::WideChar &Key);
	void __fastcall KeyUpHandler(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall MouseDownHandler(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseEnterHandler(System::TObject* Sender);
	void __fastcall MouseLeaveHandler(System::TObject* Sender);
	void __fastcall MouseMoveHandler(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUpHandler(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall StartDragHandler(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	
protected:
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	int FHighlightAlphaLevel;
	Elvclutils::TElLinkCtlPos FLinkedControlPosition;
	Vcl::Controls::TControl* FLinkedControl;
	int FLinkedControlSpacing;
	System::Uitypes::TColor FDisabledColor;
	System::Uitypes::TColor FDisabledFontColor;
	bool FUseDisabledColors;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	void __fastcall DrawFlatBorder(HDC DC);
	virtual void __fastcall AdjustEditorPositions(void);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	void __fastcall OnEditorChange(System::TObject* Sender);
	void __fastcall OnEditorEnter(System::TObject* Sender);
	void __fastcall OnEditorExit(System::TObject* Sender);
	void __fastcall OnEditorPoint(System::TObject* Sender);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall OnEditorLeftPoint(System::TObject* Sender);
	virtual void __fastcall TriggerChangeEvent(void);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	bool __fastcall GetHideSelection(void);
	void __fastcall SetHideSelection(bool Value);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor Value);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor Value);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor Value);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor Value);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall SetLinkedControlPosition(Elvclutils::TElLinkCtlPos Value);
	void __fastcall SetLinkedControl(Vcl::Controls::TControl* Value);
	void __fastcall SetLinkedControlSpacing(int Value);
	void __fastcall UpdateLinkedControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDisabledColor(System::Uitypes::TColor Value);
	void __fastcall SetDisabledFontColor(System::Uitypes::TColor Value);
	void __fastcall SetUseDisabledColors(bool Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TElIPEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElIPEdit(void);
	virtual void __fastcall Paint(void);
	__property unsigned IPAddress = {read=GetIPAddress, write=SetIPAddress, nodefault};
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	
__published:
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property System::Byte Part1 = {read=GetPart, write=SetPart, index=1, default=0};
	__property System::Byte Part2 = {read=GetPart, write=SetPart, index=2, default=0};
	__property System::Byte Part3 = {read=GetPart, write=SetPart, index=3, default=0};
	__property System::Byte Part4 = {read=GetPart, write=SetPart, index=4, default=0};
	__property bool Part1CanEdit = {read=GetPartCanEdit, write=SetPartCanEdit, index=1, default=1};
	__property bool Part2CanEdit = {read=GetPartCanEdit, write=SetPartCanEdit, index=2, default=1};
	__property bool Part3CanEdit = {read=GetPartCanEdit, write=SetPartCanEdit, index=3, default=1};
	__property bool Part4CanEdit = {read=GetPartCanEdit, write=SetPartCanEdit, index=4, default=1};
	__property System::UnicodeString IPString = {read=GetIPString, write=SetIPString};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, nodefault};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, nodefault};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, nodefault};
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
	__property bool UseDisabledColors = {read=FUseDisabledColors, write=SetUseDisabledColors, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D = {default=1};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TElIPEdit(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 IPPARTMIN = System::Int8(0x1);
static const System::Int8 IPPARTMAX = System::Int8(0x4);
}	/* namespace Elipedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELIPEDIT)
using namespace Elipedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElipeditHPP
