// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDriveComboBox.pas' rev: 31.00 (Windows)

#ifndef LmddrivecomboboxHPP
#define LmddrivecomboboxHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddrivecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDriveComboBox;
class DELPHICLASS TLMDLabeledDriveComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDriveType : unsigned char { dtUnknown, dtNoRoot, dtRemovable, dtFixed, dtNetwork, dtCDROM, dtRAM };

class PASCALIMPLEMENTATION TLMDDriveComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
private:
	System::WideChar FDrive;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetDrive(System::WideChar NewDrive);
	void __fastcall ResetItemHeight(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall BuildList(void);
	
public:
	__fastcall virtual TLMDDriveComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDriveComboBox(void);
	__property Text = {default=0};
	__property System::WideChar Drive = {read=FDrive, write=SetDrive, nodefault};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {index=0, default=0};
	__property Enabled = {default=1};
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property ItemHeight;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property UseGlobalTimer = {default=0};
	__property Visible = {default=1};
	__property OnSelect;
	__property OnChange;
	__property OnClick;
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
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnCloseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDriveComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledDriveComboBox : public TLMDDriveComboBox
{
	typedef TLMDDriveComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledDriveComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDDriveComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledDriveComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledDriveComboBox(HWND ParentWindow) : TLMDDriveComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddrivecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDRIVECOMBOBOX)
using namespace Lmddrivecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddrivecomboboxHPP
