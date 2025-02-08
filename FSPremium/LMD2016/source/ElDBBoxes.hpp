// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBBoxes.pas' rev: 31.00 (Windows)

#ifndef EldbboxesHPP
#define EldbboxesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <ElDBCtrls.hpp>
#include <HTMLLbx.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElListBox.hpp>
#include <ElXPThemedControl.hpp>
#include <ElCombos.hpp>
#include <ElBtnEdit.hpp>
#include <ElEdits.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <ElImgFrm.hpp>
#include <ElSBCtrl.hpp>
#include <ElInputProcessor.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <LMDHTMLUnit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbboxes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBListBox;
class DELPHICLASS TElDBComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBListBox : public Htmllbx::TCustomElHTMLListBox
{
	typedef Htmllbx::TCustomElHTMLListBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TShortCut FNullValueKey;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall DataChange(System::TObject* Sender);
	bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	
protected:
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElDBListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBListBox(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	__property UseXPThemes;
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Items = {write=SetItems};
	__property AllowGrayed = {default=1};
	__property BorderStyle = {default=1};
	__property Columns = {default=0};
	__property ExtendedSelect = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=0};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property IntegralHeight = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property ItemHeight;
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property TabWidth = {default=0};
	__property ItemIndex;
	__property SelCount;
	__property TopIndex;
	__property ShowCheckBox = {default=0};
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
	__property Images;
	__property AlphaForImages;
	__property ImageForm;
	__property InactiveBorderType = {default=3};
	__property InvertSelection = {default=0};
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property SelectedFont;
	__property ShowLineHint = {default=0};
	__property Transparent = {default=0};
	__property TransparentSelection = {default=0};
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
	__property Style = {default=2};
	__property OnDrawItem;
	__property OnMeasureItem;
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property RightAlignedView = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBListBox(HWND ParentWindow) : Htmllbx::TCustomElHTMLListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBComboBox : public Htmllbx::TCustomElHTMLComboBox
{
	typedef Htmllbx::TCustomElHTMLComboBox inherited;
	
private:
	System::Classes::TShortCut FNullValueKey;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TStrings* FValues;
	bool FUseValues;
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	bool __fastcall GetCReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetCReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall EditingChange(System::TObject* Sender);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	virtual void __fastcall CActiveChange(System::TObject* Sender);
	virtual void __fastcall UpdateData(System::TObject* Sender);
	virtual void __fastcall DataChange(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Change(void);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetValues(System::Classes::TStrings* Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElDBComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBComboBox(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	virtual void __fastcall CloseUp(bool AcceptValue);
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property bool UseValues = {read=FUseValues, write=FUseValues, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Items = {write=SetItems};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property DisplayReadOnlyOptions;
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property IsHTML = {default=0};
	__property Style = {default=0};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property ShowGripper = {default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property AutoCompletion = {default=0};
	__property ListColor = {default=-16777211};
	__property ListImageForm;
	__property ListInvertSelection = {default=0};
	__property UseBackground = {default=0};
	__property OnDropDown;
	__property AdjustDropDownPos = {default=1};
	__property ItemIndex = {default=-1};
	__property ShowLineHint = {default=0};
	__property HorizontalScroll = {default=0};
	__property ItemHeight;
	__property DropDownAlignment = {default=1};
	__property AutoHistory = {default=0};
	__property AutoHistoryDirection = {default=0};
	__property AutoHistoryLimit = {default=25};
	__property OnAutoHistoryItemAdd;
	__property OnAutoHistoryItemMove;
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property MaxLength = {default=0};
	__property BorderSides = {default=15};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property ImageForm;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property Text;
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property StressShortCut = {default=0};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonShowBorder = {default=1};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIsSwitch = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShowBorder = {default=1};
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property OnAltButtonClick;
	__property BorderStyle = {default=1};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnLinkClick;
	__property OnImageNeeded;
	__property OnDrawItem;
	__property OnMeasureItem;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBComboBox(HWND ParentWindow) : Htmllbx::TCustomElHTMLComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbboxes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBBOXES)
using namespace Eldbboxes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbboxesHPP
