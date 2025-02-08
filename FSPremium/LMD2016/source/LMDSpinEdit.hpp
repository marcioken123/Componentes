// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSpinEdit.pas' rev: 31.00 (Windows)

#ifndef LmdspineditHPP
#define LmdspineditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomSpinEdit;
class DELPHICLASS TLMDSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomSpinEdit : public Lmdcustomextspinedit::TLMDCustomExtSpinEdit
{
	typedef Lmdcustomextspinedit::TLMDCustomExtSpinEdit inherited;
	
private:
	HIDESBASE void __fastcall SetInteger(int Index, int aValue);
	int __fastcall GetInteger(int Index);
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDCustomSpinEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
	__property AutoSelect = {index=4, default=0};
	__property AutoSize = {default=1};
	__property Alignment = {default=0};
	__property Suffix = {default=0};
	__property EditorEnabled = {default=1};
	__property TabOnEnter = {default=0};
	__property int LineSize = {read=GetInteger, write=SetInteger, index=0, default=1};
	__property int PageSize = {read=GetInteger, write=SetInteger, index=1, default=10};
	__property int MinValue = {read=GetInteger, write=SetInteger, index=2, default=0};
	__property int MaxValue = {read=GetInteger, write=SetInteger, index=3, default=100};
	__property int Value = {read=GetInteger, write=SetInteger, index=4, default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxLength = {index=0, default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {index=1, default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
public:
	/* TLMDCustomExtSpinEdit.Destroy */ inline __fastcall virtual ~TLMDCustomSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomSpinEdit(HWND ParentWindow) : Lmdcustomextspinedit::TLMDCustomExtSpinEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDSpinEdit : public TLMDCustomSpinEdit
{
	typedef TLMDCustomSpinEdit inherited;
	
__published:
	__property Value = {index=4, default=0};
public:
	/* TLMDCustomSpinEdit.Create */ inline __fastcall virtual TLMDSpinEdit(System::Classes::TComponent* AOwner) : TLMDCustomSpinEdit(AOwner) { }
	
public:
	/* TLMDCustomExtSpinEdit.Destroy */ inline __fastcall virtual ~TLMDSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSpinEdit(HWND ParentWindow) : TLMDCustomSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSPINEDIT)
using namespace Lmdspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdspineditHPP
