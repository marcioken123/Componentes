// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBWideLookupControls.pas' rev: 31.00 (Windows)

#ifndef EldbwidelookupcontrolsHPP
#define EldbwidelookupcontrolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Variants.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <LMDTypes.hpp>
#include <ElDBCtrls.hpp>
#include <ElListBox.hpp>
#include <ElCombos.hpp>
#include <LMDElDBConst.hpp>
#include <ElTreeCombo.hpp>
#include <ElHeader.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDStrings.hpp>
#include <HTMLLbx.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <ElImgFrm.hpp>
#include <ElSBCtrl.hpp>
#include <System.Types.hpp>
#include <ElInputProcessor.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbwidelookupcontrols
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElWideDBLookupListControl;
class DELPHICLASS TElWideDBLookUpComboControl;
class DELPHICLASS TElWideDBLookupListBox;
class DELPHICLASS TElWideDBLookupComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElWideDBLookupListControl : public Vcl::Dbctrls::TDBLookupControl
{
	typedef Vcl::Dbctrls::TDBLookupControl inherited;
	
private:
	TElWideDBLookupListBox* FElDBWideLookupListBox;
	bool FUpdate;
	System::Classes::TNotifyEvent FSavedOnUpdateDataEvent;
	Data::Db::TDataSetState fOLDListState;
	int FOldItemIndex;
	System::Variant FOldValue;
	
protected:
	virtual void __fastcall KeyValueChanged(void);
	virtual void __fastcall UpdateListFields(void);
	void __fastcall UpdateBuffer(void);
	void __fastcall SelectCurrent(void);
	void __fastcall Select(int Value);
	void __fastcall UpdateData(System::TObject* Sender);
	virtual void __fastcall ListLinkDataChanged(void);
	
public:
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	
__published:
	__property NullValueKey = {default=0};
public:
	/* TDBLookupControl.Create */ inline __fastcall virtual TElWideDBLookupListControl(System::Classes::TComponent* AOwner) : Vcl::Dbctrls::TDBLookupControl(AOwner) { }
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TElWideDBLookupListControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookupListControl(HWND ParentWindow) : Vcl::Dbctrls::TDBLookupControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElWideDBLookUpComboControl : public Vcl::Dbctrls::TDBLookupControl
{
	typedef Vcl::Dbctrls::TDBLookupControl inherited;
	
private:
	TElWideDBLookupComboBox* FElDBWideLookupComboBox;
	System::Classes::TNotifyEvent FSavedOnUpdateDataEvent;
	bool FUpdate;
	int FOldItemIndex;
	System::Variant FOldValue;
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall KeyValueChanged(void);
	virtual void __fastcall ListLinkDataChanged(void);
	virtual void __fastcall UpdateListFields(void);
	void __fastcall SelectCurrent(void);
	bool __fastcall Select(int Value);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	
public:
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=SetUnicodeMode, default=0};
	
__published:
	__property NullValueKey = {default=0};
public:
	/* TDBLookupControl.Create */ inline __fastcall virtual TElWideDBLookUpComboControl(System::Classes::TComponent* AOwner) : Vcl::Dbctrls::TDBLookupControl(AOwner) { }
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TElWideDBLookUpComboControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookUpComboControl(HWND ParentWindow) : Vcl::Dbctrls::TDBLookupControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElWideDBLookupListBox : public Ellistbox::TCustomElListBox
{
	typedef Ellistbox::TCustomElListBox inherited;
	
	
private:
	typedef System::DynamicArray<int> _TElWideDBLookupListBox__1;
	
	
private:
	System::Classes::TNotifyEvent FOnChange;
	TElWideDBLookupListControl* FElDBWideLookupControl;
	bool FReadOnly;
	int FFieldCount;
	_TElWideDBLookupListBox__1 FFieldWidth;
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetListSource(Data::Db::TDataSource* Value);
	void __fastcall SetDataFieldName(const System::UnicodeString Value);
	void __fastcall SetListFieldName(const System::UnicodeString Value);
	void __fastcall SetKeyFieldName(const System::UnicodeString Value);
	void __fastcall SetKeyValue(const System::Variant &Value);
	void __fastcall SetListFieldIndex(int Value);
	Data::Db::TField* __fastcall GetField(void);
	int __fastcall GetListFieldIndex(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TDataSource* __fastcall GetListSource(void);
	System::UnicodeString __fastcall GetListFieldName(void);
	System::UnicodeString __fastcall GetDataFieldName(void);
	System::UnicodeString __fastcall GetKeyFieldName(void);
	System::Variant __fastcall GetKeyValue(void);
	System::WideString __fastcall GetSelectedString(void);
	void __fastcall SetNullValueKey(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetNullValueKey(void);
	HIDESBASE bool __fastcall GetSelected(int Index);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall SetHorizontalExtent(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall DoDrawText(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString ACaption, System::Types::TRect &Rect, int Flags);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetFieldCount(int Value);
	void __fastcall ClearFields(void);
	Vcl::Stdctrls::TListBoxStyle __fastcall GetStyle(void);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TListBoxStyle Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	__property bool Selected[int Index] = {read=GetSelected};
	
public:
	__fastcall virtual TElWideDBLookupListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElWideDBLookupListBox(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	__property System::Variant KeyValue = {read=GetKeyValue, write=SetKeyValue};
	__property System::WideString SelectedItem = {read=GetSelectedString};
	__property int ListFieldIndex = {read=GetListFieldIndex, write=SetListFieldIndex, nodefault};
	__property Data::Db::TField* Field = {read=GetField};
	__property Items;
	__property ItemIndex;
	__property MultiSelect = {default=0};
	__property UseXPThemes;
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=GetNullValueKey, write=SetNullValueKey, default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Data::Db::TDataSource* ListSource = {read=GetListSource, write=SetListSource};
	__property System::UnicodeString DataField = {read=GetDataFieldName, write=SetDataFieldName};
	__property System::UnicodeString ListField = {read=GetListFieldName, write=SetListFieldName};
	__property System::UnicodeString KeyField = {read=GetKeyFieldName, write=SetKeyFieldName};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property Vcl::Stdctrls::TListBoxStyle Style = {read=GetStyle, write=SetStyle, stored=false, nodefault};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property HideSelection = {default=0};
	__property AllowGrayed = {default=1};
	__property BorderStyle = {default=1};
	__property Columns = {default=0};
	__property ExtendedSelect = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property IntegralHeight = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property ItemHeight;
	__property ParentColor = {default=0};
	__property TabWidth = {default=0};
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
	__property OnDrawItem;
	__property OnMeasureItem;
	__property UseCustomScrollBars = {default=1};
	__property HorzScrollBarStyles;
	__property VertScrollBarStyles;
	__property RightAlignedView = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookupListBox(HWND ParentWindow) : Ellistbox::TCustomElListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElWideDBLookupComboBox : public Htmllbx::TCustomElHTMLComboBox
{
	typedef Htmllbx::TCustomElHTMLComboBox inherited;
	
	
private:
	typedef System::DynamicArray<System::Classes::TStrings*> _TElWideDBLookupComboBox__1;
	
	typedef System::DynamicArray<int> _TElWideDBLookupComboBox__2;
	
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FMyOnChange;
	TElWideDBLookUpComboControl* FElDBWideLookupControl;
	int FFieldCount;
	_TElWideDBLookupComboBox__1 FFields;
	int FKeyIndex;
	_TElWideDBLookupComboBox__2 FFieldWidth;
	bool fNeedUpdate;
	int fSaveItemIndex;
	System::UnicodeString fListFieldNames;
	bool FWReadOnly;
	Lmdtypes::TLMDString FAutoCompletionBuf;
	System::TDateTime fLastAutoComletion;
	Elcombos::TElAutoHistoryItemMoveEvent FOldAutoHistoryItemMoveEvent;
	void __fastcall SetNullValueKey(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetNullValueKey(void);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetListSource(Data::Db::TDataSource* Value);
	void __fastcall SetDataFieldName(const System::UnicodeString Value);
	void __fastcall SetListFieldName(const System::UnicodeString Value);
	void __fastcall SetKeyFieldName(const System::UnicodeString Value);
	void __fastcall SetKeyValue(const System::Variant &Value);
	void __fastcall SetListFieldIndex(int Value);
	void __fastcall SetSelected(int index, bool Value);
	void __fastcall SetHScrollBarWidth(void);
	bool __fastcall GetSelected(int index);
	Data::Db::TField* __fastcall GetField(void);
	int __fastcall GetListFieldIndex(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TDataSource* __fastcall GetListSource(void);
	System::UnicodeString __fastcall GetListFieldName(void);
	System::UnicodeString __fastcall GetDataFieldName(void);
	System::UnicodeString __fastcall GetKeyFieldName(void);
	System::Variant __fastcall GetKeyValue(void);
	System::WideString __fastcall GetSelectedString(void);
	System::Classes::TStrings* __fastcall GetFields(int Index);
	Vcl::Stdctrls::TComboBoxStyle __fastcall GetStyle(void);
	bool __fastcall GetMultiSelectLookup(void);
	void __fastcall SetMultiSelectLookup(const bool Value);
	void __fastcall SetWReadOnly(const bool Value);
	void __fastcall SelfAutoHistoryItemMoveEvent(System::TObject* Sender, const Lmdtypes::TLMDString aString, const int aIdx);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	void __fastcall ComboKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ComboMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall ClearAutoCompletionData(void);
	virtual void __fastcall DoAutoComplete(void);
	void __fastcall SetFieldCount(int Value);
	void __fastcall ClearFields(void);
	void __fastcall AddItem(const Lmdtypes::TLMDString Value, int Field);
	virtual void __fastcall DoDropDown(void);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TComboBoxStyle Value);
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	virtual void __fastcall PaintText(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	__property System::Classes::TStrings* Fields[int Index] = {read=GetFields};
	
public:
	__fastcall virtual TElWideDBLookupComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElWideDBLookupComboBox(void);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall CloseUp(bool AcceptValue);
	void __fastcall UpdateData(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	void __fastcall DoDrawText(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, int Index, System::Types::TRect &Rect, int Flags);
	__property System::Variant KeyValue = {read=GetKeyValue, write=SetKeyValue};
	__property System::WideString SelectedItem = {read=GetSelectedString};
	__property int ListFieldIndex = {read=GetListFieldIndex, write=SetListFieldIndex, nodefault};
	__property Data::Db::TField* Field = {read=GetField};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	__property bool MultiSelect = {read=GetMultiSelectLookup, write=SetMultiSelectLookup, default=0};
	__property Items;
	__property ItemIndex = {default=-1};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=GetNullValueKey, write=SetNullValueKey, default=0};
	__property Vcl::Stdctrls::TComboBoxStyle Style = {read=GetStyle, write=SetStyle, default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Data::Db::TDataSource* ListSource = {read=GetListSource, write=SetListSource};
	__property System::UnicodeString DataField = {read=GetDataFieldName, write=SetDataFieldName};
	__property System::UnicodeString ListField = {read=GetListFieldName, write=SetListFieldName};
	__property System::UnicodeString KeyField = {read=GetKeyFieldName, write=SetKeyFieldName};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=SetUnicodeMode, default=0};
	__property bool ReadOnly = {read=FWReadOnly, write=SetWReadOnly, default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property OnChange = {read=FMyOnChange, write=FMyOnChange};
	__property IsHTML = {default=0};
	__property DisplayReadOnlyOptions;
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
	__property ShowLineHint = {default=0};
	__property HorizontalScroll = {default=0};
	__property ItemHeight;
	__property OnDrawItem;
	__property OnMeasureItem;
	__property DropDownAlignment = {default=1};
	__property ShowGripper = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property RightAlignedView = {default=0};
	__property OnSelect;
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
	__property IncrementalSearchTimeout = {default=500};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnSelectionChange;
	__property OnKeyPressEx;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
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
	__property AutoSelect = {default=1};
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
	__property ButtonOldStyled = {default=0};
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
	__property AltButtonOldStyled = {default=0};
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
	__property OnCloseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookupComboBox(HWND ParentWindow) : Htmllbx::TCustomElHTMLComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TDateTime cAutoCompletionTimeOut;
}	/* namespace Eldbwidelookupcontrols */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBWIDELOOKUPCONTROLS)
using namespace Eldbwidelookupcontrols;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbwidelookupcontrolsHPP
