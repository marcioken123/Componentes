// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sFontCtrls.pas' rev: 27.00 (Windows)

#ifndef SfontctrlsHPP
#define SfontctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sListBox.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sfontctrls
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM FontTypes : unsigned char { PS, TTF, RASTER, UNKNOWN };

class DELPHICLASS TFontClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFontClass : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString FntName;
	FontTypes FntType;
public:
	/* TObject.Create */ inline __fastcall TFontClass(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TFontClass(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TFilterOption : unsigned char { ShowTrueType, ShowPostScript, ShowRaster };

typedef System::Set<TFilterOption, TFilterOption::ShowTrueType, TFilterOption::ShowRaster> TFilterOptions;

typedef void __fastcall (__closure *EValidateFont)(System::TObject* Sender, TFontClass* Font, bool &accept);

class DELPHICLASS TsFontListBox;
class PASCALIMPLEMENTATION TsFontListBox : public Slistbox::TsCustomListBox
{
	typedef Slistbox::TsCustomListBox inherited;
	
private:
	TFilterOptions FFilterOptions;
	EValidateFont FOnValidateFont;
	bool FDrawFont;
	bool FPropsChanging;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetDrawFont(const bool Value);
	
protected:
	void __fastcall SetFilterOptions(TFilterOptions Value);
	
public:
	__fastcall virtual TsFontListBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	
__published:
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property Items = {stored=false};
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Style = {default=2};
	__property TabOrder = {default=-1};
	__property TabWidth = {default=0};
	__property Visible = {default=1};
	__property EValidateFont OnValidateFont = {read=FOnValidateFont, write=FOnValidateFont};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property bool DrawFont = {read=FDrawFont, write=SetDrawFont, default=1};
	__property TFilterOptions FilterOptions = {read=FFilterOptions, write=SetFilterOptions, default=7};
public:
	/* TsCustomListBox.Destroy */ inline __fastcall virtual ~TsFontListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFontListBox(HWND ParentWindow) : Slistbox::TsCustomListBox(ParentWindow) { }
	
};


class DELPHICLASS TsFontComboBox;
class PASCALIMPLEMENTATION TsFontComboBox : public Scombobox::TsCustomComboBox
{
	typedef Scombobox::TsCustomComboBox inherited;
	
private:
	TFilterOptions FFilterOptions;
	EValidateFont FOnValidateFont;
	bool FDrawFont;
	void __fastcall SetDrawFont(const bool Value);
	
protected:
	void __fastcall SetFilterOptions(TFilterOptions Value);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	
public:
	__fastcall virtual TsFontComboBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property Style = {default=4};
	
__published:
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=16};
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property Items = {stored=false};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property EValidateFont OnValidateFont = {read=FOnValidateFont, write=FOnValidateFont};
	__property OnChange;
	__property OnClick;
	__property OnCloseUp;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property bool DrawFont = {read=FDrawFont, write=SetDrawFont, default=1};
	__property TFilterOptions FilterOptions = {read=FFilterOptions, write=SetFilterOptions, default=7};
public:
	/* TsCustomComboBox.Destroy */ inline __fastcall virtual ~TsFontComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFontComboBox(HWND ParentWindow) : Scombobox::TsCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sfontctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SFONTCTRLS)
using namespace Sfontctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SfontctrlsHPP
