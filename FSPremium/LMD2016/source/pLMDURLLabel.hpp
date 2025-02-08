// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDURLLabel.pas' rev: 31.00 (Windows)

#ifndef PlmdurllabelHPP
#define PlmdurllabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ActnList.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdurllabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDURLLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDURLLabel : public Vcl::Stdctrls::TCustomLabel
{
	typedef Vcl::Stdctrls::TCustomLabel inherited;
	
private:
	System::UnicodeString FJump;
	System::Uitypes::TColor FActiveColor;
	System::Uitypes::TColor FInActiveColor;
	bool FJumpUnderline;
	int FCounter;
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetJumpUnderLine(bool aValue);
	int __fastcall GetCounter(void);
	
protected:
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDURLLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDURLLabel(void);
	void __fastcall ResetCounter(void);
	void __fastcall Execute(void);
	__property int Counter = {read=GetCounter, nodefault};
	
__published:
	__property Action;
	__property Caption = {default=0};
	__property System::Uitypes::TColor ActiveColor = {read=FActiveColor, write=SetColor, index=0, default=8388736};
	__property System::UnicodeString Jump = {read=FJump, write=FJump};
	__property System::Uitypes::TColor InActiveColor = {read=FInActiveColor, write=SetColor, index=1, default=16711680};
	__property bool JumpUnderline = {read=FJumpUnderline, write=SetJumpUnderLine, default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {default=1};
	__property ShowHint;
	__property Transparent;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdurllabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDURLLABEL)
using namespace Plmdurllabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdurllabelHPP
