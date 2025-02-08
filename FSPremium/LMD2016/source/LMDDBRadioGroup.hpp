// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBRadioGroup.pas' rev: 31.00 (Windows)

#ifndef LmddbradiogroupHPP
#define LmddbradiogroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbradiogroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRadioGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBRadioGroup : public Lmdcustomradiogroup::TLMDCustomRadioGroup
{
	typedef Lmdcustomradiogroup::TLMDCustomRadioGroup inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString FValue;
	System::Classes::TStrings* FValues;
	bool FInSetValue;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	System::UnicodeString __fastcall GetButtonValue(int Index);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetItems(System::Classes::TStringList* Value);
	void __fastcall SetValues(System::Classes::TStrings* Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Vcl::Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TLMDDBRadioGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRadioGroup(void);
	virtual bool __fastcall CanModify(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	__property ItemIndex = {default=-1};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property CaptionFont;
	__property CaptionFont3D;
	__property CaptionOffset = {default=8};
	__property CaptionParentFont = {default=1};
	__property Color = {default=-16777201};
	__property Columns = {default=1};
	__property Ctl3D;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusStyle = {default=1};
	__property FocusColor = {default=8421504};
	__property UseFocusColor = {default=0};
	__property Font;
	__property Font3D;
	__property GlyphImageIndex = {index=0, default=0};
	__property GlyphImageList;
	__property GlyphListIndex = {index=1, default=0};
	__property GlyphTransparent = {default=1};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Items = {write=SetItems};
	__property ItemHeight = {default=-1};
	__property ItemOffset = {default=4};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property ShowAccelChar = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property System::Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick;
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBRadioGroup(HWND ParentWindow) : Lmdcustomradiogroup::TLMDCustomRadioGroup(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbradiogroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBRADIOGROUP)
using namespace Lmddbradiogroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbradiogroupHPP
