// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBLookupCtrls.pas' rev: 31.00 (Windows)

#ifndef LmddblookupctrlsHPP
#define LmddblookupctrlsHPP

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
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Variants.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDTypes.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDComboBoxExt.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddblookupctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBLookUpComboControl;
class DELPHICLASS TLMDDBLookupComboBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDNotInListEvent)(System::TObject* Sender, System::UnicodeString Text, bool &Accept);

class PASCALIMPLEMENTATION TLMDDBLookUpComboControl : public Vcl::Dbctrls::TDBLookupControl
{
	typedef Vcl::Dbctrls::TDBLookupControl inherited;
	
private:
	TLMDDBLookupComboBox* FElDBLookupComboBox;
	int FSelected;
	System::Classes::TNotifyEvent FSavedOnUpdateDataEvent;
	bool FUpdate;
	
protected:
	virtual void __fastcall KeyValueChanged(void);
	virtual void __fastcall UpdateListFields(void);
	void __fastcall SelectCurrent(void);
	void __fastcall Select(int Value);
	__property int Selected = {read=FSelected, nodefault};
	void __fastcall UpdateData(System::TObject* Sender);
	
public:
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
public:
	/* TDBLookupControl.Create */ inline __fastcall virtual TLMDDBLookUpComboControl(System::Classes::TComponent* AOwner) : Vcl::Dbctrls::TDBLookupControl(AOwner) { }
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TLMDDBLookUpComboControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLookUpComboControl(HWND ParentWindow) : Vcl::Dbctrls::TDBLookupControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDDBLookupComboBox : public Lmdcomboboxext::TLMDComboBoxExt
{
	typedef Lmdcomboboxext::TLMDComboBoxExt inherited;
	
	
private:
	typedef System::DynamicArray<bool> _TLMDDBLookupComboBox__1;
	
	typedef System::DynamicArray<System::Classes::TStrings*> _TLMDDBLookupComboBox__2;
	
	typedef System::DynamicArray<int> _TLMDDBLookupComboBox__3;
	
	
private:
	TLMDDBLookUpComboControl* FLMDDBLookupControl;
	_TLMDDBLookupComboBox__1 FSelected;
	int FMaxItems;
	int FFieldCount;
	_TLMDDBLookupComboBox__2 FFields;
	_TLMDDBLookupComboBox__3 FFieldWidth;
	bool FReadOnly;
	bool FCompleting;
	TLMDNotInListEvent FOnNotInList;
	bool fNeedUpdate;
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
	System::UnicodeString __fastcall GetSelectedString(void);
	System::Classes::TStrings* __fastcall GetFields(int Index);
	void __fastcall DoComplete(bool Accept);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	
protected:
	void __fastcall SetFieldCount(int Value);
	void __fastcall ClearFields(void);
	void __fastcall AddFieldItem(const System::UnicodeString Value, int Field);
	__property System::Classes::TStrings* Fields[int Index] = {read=GetFields};
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Change(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DropDown(void);
	
public:
	__fastcall virtual TLMDDBLookupComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBLookupComboBox(void);
	void __fastcall UpdateData(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	__property System::Variant KeyValue = {read=GetKeyValue, write=SetKeyValue};
	__property System::UnicodeString SelectedItem = {read=GetSelectedString};
	__property int ListFieldIndex = {read=GetListFieldIndex, write=SetListFieldIndex, nodefault};
	__property Data::Db::TField* Field = {read=GetField};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Data::Db::TDataSource* ListSource = {read=GetListSource, write=SetListSource};
	__property System::UnicodeString DataField = {read=GetDataFieldName, write=SetDataFieldName};
	__property System::UnicodeString ListField = {read=GetListFieldName, write=SetListFieldName};
	__property System::UnicodeString KeyField = {read=GetKeyFieldName, write=SetKeyFieldName};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property TLMDNotInListEvent OnNotInList = {read=FOnNotInList, write=FOnNotInList};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Flat = {default=0};
	__property Hint;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemIndex = {stored=false};
	__property MaxLength = {index=0, default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {stored=false};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property Items = {stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLookupComboBox(HWND ParentWindow) : Lmdcomboboxext::TLMDComboBoxExt(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddblookupctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBLOOKUPCTRLS)
using namespace Lmddblookupctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddblookupctrlsHPP
