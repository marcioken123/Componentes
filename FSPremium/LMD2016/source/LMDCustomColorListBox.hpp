// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomColorListBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcolorlistboxHPP
#define LmdcustomcolorlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcolorlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomColorListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomColorListBox : public Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox inherited;
	
private:
	int FCounter;
	bool FCustomMode;
	System::Classes::TStringList* FCustomColors;
	Lmdcustomcolorcombobox::TLMDColorCBOptions FOptions;
	Lmdcustomcolorcombobox::TLMDColorCBStyle FDisplayStyle;
	Vcl::Dialogs::TColorDialogOptions FDlgOptions;
	Lmdcustomcolorcombobox::TLMDOnColorDialogEvent FOnEnterDialog;
	Lmdcustomcolorcombobox::TLMDOnColorDialogEvent FOnFinishedDialog;
	System::Classes::THelpContext FContext;
	HIDESBASE void __fastcall GetChange(System::TObject* Sender);
	void __fastcall FillColorList(const System::UnicodeString S);
	System::Classes::TStrings* __fastcall GetCustomColors(void);
	System::Uitypes::TColor __fastcall GetSelectedColor(void);
	System::UnicodeString __fastcall GetSelectedColorName(void);
	System::Uitypes::TColor __fastcall GetColor(int index);
	System::UnicodeString __fastcall GetColorName(int index);
	void __fastcall SetCustomMode(bool aValue);
	void __fastcall SetCustomColors(System::Classes::TStrings* aValue);
	void __fastcall SetDisplayStyle(Lmdcustomcolorcombobox::TLMDColorCBStyle aValue);
	void __fastcall SetOptions(Lmdcustomcolorcombobox::TLMDColorCBOptions aValue);
	HIDESBASE void __fastcall SetSelectedColor(System::Uitypes::TColor aValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateColorList(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState State);
	virtual System::Uitypes::TColor __fastcall GetColorValue(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoSelect(void);
	
public:
	__fastcall virtual TLMDCustomColorListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomColorListBox(void);
	bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(System::Classes::TStrings* aList);
	void __fastcall Init(void);
	void __fastcall LoadCustomColors(System::TObject* IniFile, const System::UnicodeString Section);
	void __fastcall SaveCustomColors(System::TObject* IniFile, const System::UnicodeString Section);
	__property System::Uitypes::TColor Colors[int index] = {read=GetColor};
	__property CtlXP;
	__property System::UnicodeString ColorName[int index] = {read=GetColorName};
	__property System::UnicodeString SelectedColorName = {read=GetSelectedColorName};
	__property System::Uitypes::TColor SelectedColor = {read=GetSelectedColor, write=SetSelectedColor, nodefault};
	__property Text = {default=0};
	
__published:
	__property About = {default=0};
	__property bool CustomMode = {read=FCustomMode, write=SetCustomMode, default=0};
	__property System::Classes::TStrings* CustomColors = {read=GetCustomColors, write=SetCustomColors};
	__property Vcl::Dialogs::TColorDialogOptions DlgOptions = {read=FDlgOptions, write=FDlgOptions, nodefault};
	__property System::Classes::THelpContext DlgHelpContext = {read=FContext, write=FContext, nodefault};
	__property Lmdcustomcolorcombobox::TLMDColorCBStyle DisplayStyle = {read=FDisplayStyle, write=SetDisplayStyle, default=2};
	__property Lmdcustomcolorcombobox::TLMDColorCBOptions Options = {read=FOptions, write=SetOptions, default=9};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
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
	__property Sorted = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
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
	__property OnStartDrag;
	__property Lmdcustomcolorcombobox::TLMDOnColorDialogEvent OnBeforeDialogShow = {read=FOnEnterDialog, write=FOnEnterDialog};
	__property Lmdcustomcolorcombobox::TLMDOnColorDialogEvent OnAfterDialogShow = {read=FOnFinishedDialog, write=FOnFinishedDialog};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomColorListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomcolorlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCOLORLISTBOX)
using namespace Lmdcustomcolorlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcolorlistboxHPP
