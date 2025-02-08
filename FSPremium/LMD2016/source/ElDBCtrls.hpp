// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBCtrls.pas' rev: 31.00 (Windows)

#ifndef EldbctrlsHPP
#define EldbctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <LMDThemes.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUtils.hpp>
#include <LMDGlyphs.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDElDBConst.hpp>
#include <ElPanel.hpp>
#include <ElToolBar.hpp>
#include <ElPopBtn.hpp>
#include <ElACtrls.hpp>
#include <ElMaskEdit.hpp>
#include <ElVCLUtils.hpp>
#include <ElCheckCtl.hpp>
#include <ElCheckItemGrp.hpp>
#include <ElPromptDlg.hpp>
#include <ElEdits.hpp>
#include <Vcl.Mask.hpp>
#include <ElGroupBox.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDVldBase.hpp>
#include <ElImgFrm.hpp>
#include <LMDClass.hpp>
#include <System.UITypes.hpp>
#include <ElBtnCtl.hpp>
#include <ElXPThemedControl.hpp>
#include <ElSndMap.hpp>
#include <Vcl.Buttons.hpp>
#include <ElInputProcessor.hpp>
#include <ElSBCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBEdit;
class DELPHICLASS TElDBMemo;
class DELPHICLASS TElDBCheckBox;
class DELPHICLASS TElDBRadioGroup;
class DELPHICLASS TElDBNavButton;
class DELPHICLASS TElDBNavigator;
class DELPHICLASS TElNavDataLink;
class DELPHICLASS TElWideDBEdit;
class DELPHICLASS TElWideDBMemo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBEdit : public Elmaskedit::TCustomElMaskEdit
{
	typedef Elmaskedit::TCustomElMaskEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	System::Classes::TShortCut FNullValueKey;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall ResetMaxLength(void);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall SetFocused(bool Value);
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMUndo(Winapi::Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual bool __fastcall EditCanModify(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Reset(void);
	
public:
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__fastcall virtual TElDBEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBEdit(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ValidationMsgString = {default=0};
	__property Validator;
	__property OnValidationError;
	__property ActiveBorderType = {default=1};
	__property Alignment = {default=0};
	__property Background;
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Transparent = {default=0};
	__property UseBackground = {default=0};
	__property BorderSides;
	__property HandleDialogKeys = {default=1};
	__property ImageForm;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property LineBorderActiveColor;
	__property LineBorderInactiveColor;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property CharCase = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxLength = {default=0};
	__property OEMConvert = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PasswordChar = {default=0};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property OnChange;
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
	/* TWinControl.CreateParented */ inline __fastcall TElDBEdit(HWND ParentWindow) : Elmaskedit::TCustomElMaskEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBMemo : public Elactrls::TElAdvancedMemo
{
	typedef Elactrls::TElAdvancedMemo inherited;
	
private:
	bool FAutoDisplay;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	bool FMemoLoaded;
	System::Classes::TShortCut FNullValueKey;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetAutoDisplay(bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMUndo(Winapi::Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual void __fastcall LoadMemo(void);
	__fastcall virtual TElDBMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBMemo(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBMemo(HWND ParentWindow) : Elactrls::TElAdvancedMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBCheckBox : public Elcheckctl::TElCheckBox
{
	typedef Elcheckctl::TElCheckBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	Lmdtypes::TLMDString FValueCheck;
	Lmdtypes::TLMDString FValueUncheck;
	System::Classes::TShortCut FNullValueKey;
	bool __fastcall IsValueCheckedStored(void);
	bool __fastcall IsValueUnCheckedStored(void);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall DataChange(System::TObject* Sender);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	void __fastcall SetValueCheck(const Lmdtypes::TLMDString Value);
	void __fastcall SetValueUncheck(const Lmdtypes::TLMDString Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall ValueMatch(const System::UnicodeString ValueList, const System::UnicodeString Value);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Toggle(void);
	
public:
	__fastcall virtual TElDBCheckBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBCheckBox(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	DYNAMIC void __fastcall Click(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Lmdtypes::TLMDString ValueChecked = {read=FValueCheck, write=SetValueCheck, stored=IsValueCheckedStored};
	__property Lmdtypes::TLMDString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck, stored=IsValueUnCheckedStored};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBCheckBox(HWND ParentWindow) : Elcheckctl::TElCheckBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBRadioGroup : public Elcheckitemgrp::TCustomElRadioGroup
{
	typedef Elcheckitemgrp::TCustomElRadioGroup inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnChange;
	Lmdtypes::TLMDString FValue;
	System::Classes::TStrings* FValues;
	bool FInSetValue;
	System::Classes::TShortCut FNullValueKey;
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall DataChange(System::TObject* Sender);
	Lmdtypes::TLMDString __fastcall GetButtonValue(int Index);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(Lmdtypes::TLMDString Value);
	void __fastcall SetValues(System::Classes::TStrings* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual bool __fastcall CanModify(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Vcl::Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TElDBRadioGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBRadioGroup(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	__property Lmdtypes::TLMDString Value = {read=FValue, write=SetValue};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property Items = {write=SetItems};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderSides = {default=15};
	__property Caption;
	__property CaptionColor = {default=536870911};
	__property CheckBoxChecked = {default=1};
	__property Color = {default=-16777201};
	__property Columns = {default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property Font;
	__property Hints;
	__property ImageForm;
	__property IsHTML = {default=0};
	__property MoneyFlat = {default=0};
	__property MoneyFlatInactiveColor;
	__property MoneyFlatActiveColor;
	__property MoneyFlatDownColor;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowCheckBox = {default=0};
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property CheckSound = {default=0};
	__property SoundMap;
	__property Glyph;
	__property Images;
	__property AlphaForImages;
	__property UseCustomGlyphs = {default=0};
	__property UseImageList = {default=0};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBRadioGroup(HWND ParentWindow) : Elcheckitemgrp::TCustomElRadioGroup(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TElNavButtonRole : unsigned char { nbrFirst, nbrPrior, nbrNext, nbrLast, nbrInsert, nbrDelete, nbrEdit, nbrPost, nbrCancel, nbrRefresh, nbrSearch, nbrSetFilter, nbrRemoveFilter, nbrClear, nbrOpen, nbrClose, nbrFindFirst, nbrFindPrior, nbrFindNext, nbrFindLast, nbrCustom };

class PASCALIMPLEMENTATION TElDBNavButton : public Eltoolbar::TCustomElToolButton
{
	typedef Eltoolbar::TCustomElToolButton inherited;
	
protected:
	TElNavButtonRole FRole;
	bool FCustomAction;
	bool FUseCustomImages;
	void __fastcall SetRole(TElNavButtonRole Value);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetDetails(void);
	void __fastcall FillStateForDetails(Vcl::Themes::TThemedElementDetails &ADetails);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetArrowDetails(void);
	virtual void __fastcall SetUseImageList(bool newValue);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall SetImageIndex(int newValue);
	void __fastcall SetUseCustomImage(bool Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	virtual void __fastcall AClick(bool Arrow);
	__fastcall virtual TElDBNavButton(System::Classes::TComponent* AOwner);
	
__published:
	__property TElNavButtonRole Role = {read=FRole, write=SetRole, default=20};
	__property bool UseCustomImage = {read=FUseCustomImages, write=SetUseCustomImage, default=0};
	__property UseImageList = {default=0};
	__property Wrap = {default=0};
	__property LargeGlyph;
	__property NumLargeGlyphs = {default=1};
	__property Glyph;
	__property NumGlyphs = {default=1};
	__property OwnerSettings = {default=1};
	__property PullDownMenu;
	__property PopupPlace = {default=0};
	__property DisableAutoPopup = {default=0};
	__property Flat = {default=0};
	__property Layout = {default=0};
	__property Margin = {default=-1};
	__property Spacing = {default=4};
	__property UseArrow = {default=0};
	__property ShadowFollowsColor = {default=1};
	__property ShowGlyph = {default=1};
	__property ShowText = {default=1};
	__property OnArrowClick;
	__property Icon;
	__property TextDrawType = {default=0};
	__property ThinFrame = {default=0};
	__property DownSound = {default=0};
	__property UpSound = {default=0};
	__property ClickSound = {default=0};
	__property ArrowClickSound = {default=0};
	__property SoundMap;
	__property UseIcon = {default=0};
	__property ImageIndex = {default=-1};
	__property OldStyled = {default=0};
	__property Background;
	__property DownBackground;
	__property BackgroundDrawBorder = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
	__property Enabled = {default=1};
	__property PopupMenu;
	__property Color;
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property Action;
	__property Constraints;
	__property OnContextPopup;
	__property bool CustomAction = {read=FCustomAction, write=FCustomAction, default=0};
public:
	/* TCustomElToolButton.Destroy */ inline __fastcall virtual ~TElDBNavButton(void) { }
	
};


class PASCALIMPLEMENTATION TElDBNavigator : public Eltoolbar::TElToolBar
{
	typedef Eltoolbar::TElToolBar inherited;
	
private:
	System::UnicodeString FDeleteRecordQuestion;
	TElNavDataLink* FDataLink;
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	
protected:
	bool FConfirmDelete;
	System::Classes::TNotifyEvent FOnSearch;
	bool FIsToolbar;
	Vcl::Imglist::TCustomImageList* FIntImageList;
	void __fastcall ActiveChanged(void);
	void __fastcall DataChanged(void);
	void __fastcall EditingChanged(void);
	virtual void __fastcall DoSearch(void);
	virtual Eltoolbar::TElToolButtonClass __fastcall GetButtonClass(void);
	void __fastcall SetIsToolbar(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	HIDESBASE MESSAGE void __fastcall CMControlChange(Vcl::Controls::TCMControlChange &Msg);
	
public:
	__fastcall virtual TElDBNavigator(System::Classes::TComponent* AOwner);
	TElDBNavButton* __fastcall FindButtonByRole(TElNavButtonRole Role);
	HIDESBASE TElDBNavButton* __fastcall AddButton(TElNavButtonRole Role);
	void __fastcall AddButtons(const TElNavButtonRole *Roles, const int Roles_High);
	__fastcall virtual ~TElDBNavigator(void);
	
__published:
	__property System::UnicodeString DeleteRecordQuestion = {read=FDeleteRecordQuestion, write=FDeleteRecordQuestion};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property System::Classes::TNotifyEvent OnSearch = {read=FOnSearch, write=FOnSearch};
	__property bool IsToolbar = {read=FIsToolbar, write=SetIsToolbar, default=0};
	__property BtnOffsHorz = {default=0};
	__property BtnOffsVert = {default=0};
	__property BevelOuter = {default=0};
	__property UseImageList = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBNavigator(HWND ParentWindow) : Eltoolbar::TElToolBar(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElNavDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TElDBNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TElNavDataLink(TElDBNavigator* ANav);
	__fastcall virtual ~TElNavDataLink(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElWideDBEdit : public Eledits::TCustomElEdit
{
	typedef Eledits::TCustomElEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	System::Classes::TShortCut FNullValueKey;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall ResetMaxLength(void);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall SetFocused(bool Value);
	bool __fastcall GetCReadOnly(void);
	void __fastcall SetCReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMUndo(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMImeStartComposition(Winapi::Messages::TMessage &Message);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall DataChange(System::TObject* Sender);
	void __fastcall DataChangeText(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Change(void);
	bool __fastcall EditCanModify(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Reset(void);
	HIDESBASE MESSAGE void __fastcall WMCommand(Winapi::Messages::TWMCommand &Msg);
	
public:
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__fastcall virtual TElWideDBEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElWideDBEdit(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property DisplayReadOnlyOptions;
	__property AlignBottom = {default=1};
	__property Multiline = {default=0};
	__property AutoSize = {default=1};
	__property Alignment = {default=0};
	__property Background;
	__property BorderSides = {default=15};
	__property CharCase = {default=0};
	__property UseBackground = {default=0};
	__property RightAlignedView = {default=0};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property WantTabs = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property TopMargin = {default=0};
	__property BorderStyle = {default=1};
	__property AutoSelect = {default=0};
	__property HandleDialogKeys = {default=0};
	__property HideSelection = {default=1};
	__property TabSpaces = {default=4};
	__property Lines = {stored=false};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property StressShortCut = {default=0};
	__property Text = {stored=false};
	__property ImageForm;
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property WordWrap = {default=0};
	__property ScrollBars = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property BiDiMode;
	__property Cursor = {default=0};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
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
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBEdit(HWND ParentWindow) : Eledits::TCustomElEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElWideDBMemo : public Eledits::TCustomElEdit
{
	typedef Eledits::TCustomElEdit inherited;
	
private:
	System::Classes::TShortCut FNullValueKey;
	bool FAutoDisplay;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	bool FMemoLoaded;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetAutoDisplay(bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	bool __fastcall GetCReadOnly(void);
	void __fastcall SetFocused(bool Value);
	void __fastcall SetCReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMUndo(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMImeStartComposition(Winapi::Messages::TMessage &Message);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE MESSAGE void __fastcall WMCommand(Winapi::Messages::TWMCommand &Msg);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	virtual void __fastcall LoadMemo(void);
	__fastcall virtual TElWideDBMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElWideDBMemo(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property DisplayReadOnlyOptions;
	__property AutoSize = {default=1};
	__property Alignment = {default=0};
	__property Background;
	__property BorderSides = {default=15};
	__property CharCase = {default=0};
	__property UseBackground = {default=0};
	__property RightAlignedView = {default=0};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property WantTabs = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property TopMargin = {default=0};
	__property BorderStyle = {default=1};
	__property AutoSelect = {default=0};
	__property HandleDialogKeys = {default=0};
	__property HideSelection = {default=1};
	__property TabSpaces = {default=4};
	__property Lines = {stored=false};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property StressShortCut = {default=0};
	__property Text = {stored=false};
	__property ImageForm;
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property WordWrap = {default=0};
	__property ScrollBars = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property BiDiMode;
	__property Cursor = {default=0};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
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
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBMemo(HWND ParentWindow) : Eledits::TCustomElEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::PResStringRec, 20> ElDBNavButtonsHint;
extern DELPHI_PACKAGE System::Classes::TAlignment __fastcall ChangeBiDiModeAlignment(System::Classes::TAlignment Alignment);
extern DELPHI_PACKAGE bool __fastcall DBCheckReadOnlyState(Vcl::Dbctrls::TFieldDataLink* FDataLink);
}	/* namespace Eldbctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBCTRLS)
using namespace Eldbctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbctrlsHPP
