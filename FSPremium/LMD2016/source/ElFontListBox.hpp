// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFontListBox.pas' rev: 31.00 (Windows)

#ifndef ElfontlistboxHPP
#define ElfontlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <ElVCLUtils.hpp>
#include <ElListBox.hpp>
#include <ElCombos.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.Menus.hpp>
#include <ElSBCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elfontlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFontListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElFontListBox : public Ellistbox::TCustomElListBox
{
	typedef Ellistbox::TCustomElListBox inherited;
	
protected:
	Elcombos::TElFontComboOptions FOptions;
	Lmdtypes::TLMDString FSampleText;
	System::Uitypes::TFontPitch FFontPitch;
	Elcombos::TElFontSampleMode FSampleMode;
	Elcombos::TElFontDevice FFontDevice;
	System::UnicodeString FFontName;
	bool ListFilled;
	bool FManualEdit;
	int FItemIndex;
	void __fastcall SetFontName(System::Uitypes::TFontName Value);
	void __fastcall SetOptions(Elcombos::TElFontComboOptions Value);
	void __fastcall SetSampleText(Lmdtypes::TLMDString Value);
	void __fastcall SetFontPitch(System::Uitypes::TFontPitch Value);
	void __fastcall SetSampleMode(Elcombos::TElFontSampleMode Value);
	virtual void __fastcall CreateWnd(void);
	Lmdtypes::TLMDString __fastcall GetItemText(int index);
	virtual int __fastcall GetItemWidth(int Index);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SetFontDevice(Elcombos::TElFontDevice Value);
	void __fastcall AddFont(System::Uitypes::TFontName Font, int FontType);
	System::Uitypes::TFontName __fastcall GetFontName(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetManualEdit(bool Value);
	HIDESBASE int __fastcall GetItemIndex(void);
	
public:
	void __fastcall RebuildFontList(void);
	__fastcall virtual TElFontListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFontListBox(void);
	__property UseXPThemes;
	
__published:
	__property System::Uitypes::TFontName FontName = {read=GetFontName, write=SetFontName};
	__property Elcombos::TElFontComboOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Lmdtypes::TLMDString SampleText = {read=FSampleText, write=SetSampleText};
	__property System::Uitypes::TFontPitch FontPitch = {read=FFontPitch, write=SetFontPitch, nodefault};
	__property Elcombos::TElFontSampleMode SampleMode = {read=FSampleMode, write=SetSampleMode, nodefault};
	__property Elcombos::TElFontDevice FontDevice = {read=FFontDevice, write=SetFontDevice, nodefault};
	__property bool ManualEdit = {read=FManualEdit, write=SetManualEdit, default=0};
	__property int ItemIndex = {read=GetItemIndex, write=FItemIndex, nodefault};
	__property AllowGrayed = {default=1};
	__property BorderStyle = {default=1};
	__property Columns = {default=0};
	__property ExtendedSelect = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property IntegralHeight = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property ItemHeight;
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property Sorted = {default=0};
	__property TabWidth = {default=0};
	__property Items;
	__property SelCount;
	__property TopIndex;
	__property ShowCheckBox = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property ActiveBorderType = {default=1};
	__property Background;
	__property BorderSides = {default=15};
	__property Flat = {default=0};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property Font;
	__property FlatFocusedScrollBars = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalScroll = {default=0};
	__property ImageForm;
	__property InactiveBorderType = {default=3};
	__property InvertSelection = {default=0};
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property SelectedFont;
	__property ShowLineHint = {default=0};
	__property Transparent = {default=0};
	__property UseBackground = {default=0};
	__property UseSelectedFont = {default=0};
	__property TabStop = {default=1};
	__property ParentFont = {default=1};
	__property OnClick;
	__property OnCheckStateChange;
	__property OnCheckBoxChange;
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
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Style = {default=0};
	__property OnDrawItem;
	__property OnMeasureItem;
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property RightAlignedView = {default=0};
	__property AutoSize = {default=0};
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFontListBox(HWND ParentWindow) : Ellistbox::TCustomElListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elfontlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFONTLISTBOX)
using namespace Elfontlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElfontlistboxHPP
