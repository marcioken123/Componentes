// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBWideLookupComboGrid.pas' rev: 31.00 (Windows)

#ifndef EldbwidelookupcombogridHPP
#define EldbwidelookupcombogridHPP

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
#include <ElDBCtrls.hpp>
#include <LMDTypes.hpp>
#include <ElTree.hpp>
#include <LMDElDBConst.hpp>
#include <ElTreeCombo.hpp>
#include <ElHeader.hpp>
#include <LMDProcs.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <ElEditCmds.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDSysIn.hpp>
#include <LMDStrings.hpp>
#include <ElVCLUtils.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <ElSndMap.hpp>
#include <System.UITypes.hpp>
#include <ElPopBtn.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbwidelookupcombogrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElWideDBLookUpComboGridControl;
class DELPHICLASS TElWideDBLookupComboGrid;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElWideDBLookUpComboGridControl : public Vcl::Dbctrls::TDBLookupControl
{
	typedef Vcl::Dbctrls::TDBLookupControl inherited;
	
private:
	TElWideDBLookupComboGrid* FElDBWideLookupComboGrid;
	System::Classes::TNotifyEvent FSavedOnUpdateDataEvent;
	bool FUpdate;
	int FOldItemIndex;
	System::Variant FOldValue;
	System::Classes::TNotifyEvent FOldStateChange;
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall KeyValueChanged(void);
	virtual void __fastcall UpdateListFields(void);
	virtual void __fastcall ListLinkDataChanged(void);
	void __fastcall StateChange(System::TObject* Sender);
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
	/* TDBLookupControl.Create */ inline __fastcall virtual TElWideDBLookUpComboGridControl(System::Classes::TComponent* AOwner) : Vcl::Dbctrls::TDBLookupControl(AOwner) { }
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TElWideDBLookUpComboGridControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookUpComboGridControl(HWND ParentWindow) : Vcl::Dbctrls::TDBLookupControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElWideDBLookupComboGrid : public Eltreecombo::TCustomElTreeCombo
{
	typedef Eltreecombo::TCustomElTreeCombo inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	TElWideDBLookUpComboGridControl* FElDBWideLookupControl;
	int FKeyIndex;
	bool fNeedUpdate;
	int fSaveItemIndex;
	System::UnicodeString fListFieldNames;
	Lmdtypes::TLMDString FAutoCompletionBuf;
	bool FWReadOnly;
	System::TDateTime fLastAutoComletion;
	System::WideString FPressedKey;
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
	bool __fastcall GetSelected(int index);
	Data::Db::TField* __fastcall GetField(void);
	int __fastcall GetListFieldIndex(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TDataSource* __fastcall GetListSource(void);
	System::UnicodeString __fastcall GetListFieldName(void);
	System::UnicodeString __fastcall GetDataFieldName(void);
	System::UnicodeString __fastcall GetKeyFieldName(void);
	System::Variant __fastcall GetKeyValue(void);
	bool __fastcall GetWReadOnly(void);
	void __fastcall SetWReadOnly(const bool Value);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DblClickHandler(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	virtual void __fastcall SetDropped(bool Value);
	virtual void __fastcall ProcessSelect(void);
	virtual Lmdtypes::TLMDString __fastcall GetDisplayText(Eltree::TElTreeItem* Item);
	void __fastcall ClearAutoCompletionData(void);
	void __fastcall SetFieldCount(int Value);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	virtual void __fastcall TriggerBeforeCommand(void * AData, System::WideChar AChar, Eleditcmds::TElCommand ACommand);
	HIDESBASE MESSAGE void __fastcall WMImeStartComposition(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMImeComposition(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	virtual void __fastcall PaintText(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall TreeItemDelete(System::TObject* Sender, Eltree::TElTreeItem* Item);
	virtual void __fastcall DoAutoComplete(void);
	
public:
	__fastcall virtual TElWideDBLookupComboGrid(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElWideDBLookupComboGrid(void);
	void __fastcall UpdateData(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	__property System::Variant KeyValue = {read=GetKeyValue, write=SetKeyValue};
	__property int ListFieldIndex = {read=GetListFieldIndex, write=SetListFieldIndex, nodefault};
	__property Data::Db::TField* Field = {read=GetField};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	__property AutoCompletion = {default=0};
	__property ShowLines = {default=1};
	__property ShowColumns = {default=1};
	__property TreeHorizontalLines = {default=1};
	__property VerticalLines = {default=1};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=GetNullValueKey, write=SetNullValueKey, default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Data::Db::TDataSource* ListSource = {read=GetListSource, write=SetListSource};
	__property System::UnicodeString DataField = {read=GetDataFieldName, write=SetDataFieldName};
	__property System::UnicodeString ListField = {read=GetListFieldName, write=SetListFieldName};
	__property System::UnicodeString KeyField = {read=GetKeyFieldName, write=SetKeyFieldName};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=SetUnicodeMode, default=0};
	__property bool ReadOnly = {read=GetWReadOnly, write=SetWReadOnly, default=0};
	__property DisplayReadOnlyOptions;
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonEnabled = {default=1};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property OnButtonClick;
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
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property OnAltButtonClick;
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AlignBottom = {default=1};
	__property AutoSelect = {default=0};
	__property AutoSize = {default=1};
	__property RightAlignedView = {default=0};
	__property BorderSides = {default=15};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property WantTabs = {default=0};
	__property HandleDialogKeys = {default=0};
	__property HideSelection = {default=1};
	__property TabSpaces = {default=4};
	__property ImageForm;
	__property WordWrap = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property StressShortCut = {default=0};
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property UseSystemMenu = {default=1};
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
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBLookupComboGrid(HWND ParentWindow) : Eltreecombo::TCustomElTreeCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TDateTime cAutoCompletionTimeOut;
}	/* namespace Eldbwidelookupcombogrid */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBWIDELOOKUPCOMBOGRID)
using namespace Eldbwidelookupcombogrid;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbwidelookupcombogridHPP
