﻿// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sFileCtrl.pas' rev: 27.00 (Windows)

#ifndef SfilectrlHPP
#define SfilectrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sfilectrl
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsFilterComboBox;
class PASCALIMPLEMENTATION TsFilterComboBox : public Scombobox::TsCustomComboBox
{
	typedef Scombobox::TsCustomComboBox inherited;
	
private:
	System::UnicodeString FFilter;
	bool __fastcall IsFilterStored(void);
	System::UnicodeString __fastcall GetMask(void);
	void __fastcall SetFilter(const System::UnicodeString NewFilter);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall BuildList(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	System::Classes::TStringList* MaskList;
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual TsFilterComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsFilterComboBox(void);
	__property System::UnicodeString Mask = {read=GetMask};
	__property Text = {default=0};
	
__published:
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property Font;
	__property ImeName = {default=0};
	__property ImeMode = {default=3};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter, stored=IsFilterStored};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFilterComboBox(HWND ParentWindow) : Scombobox::TsCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sfilectrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SFILECTRL)
using namespace Sfilectrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SfilectrlHPP
