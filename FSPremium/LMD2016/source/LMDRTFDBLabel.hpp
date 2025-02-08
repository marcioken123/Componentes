// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFDBLabel.pas' rev: 31.00 (Windows)

#ifndef LmdrtfdblabelHPP
#define LmdrtfdblabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDRTFLabel.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDRTFBase.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfdblabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRichLabel;
class DELPHICLASS TLMDDBRichScrollText;
class DELPHICLASS TLMDDBRichScrollBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBRichLabel : public Lmdrtflabel::TLMDCustomRichLabel
{
	typedef Lmdrtflabel::TLMDCustomRichLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FMemoLoaded;
	System::UnicodeString FDataSave;
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRichLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRichLabel(void);
	virtual void __fastcall LoadMemo(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property AutoURLDetect = {default=1};
	__property AutoURLPopup = {default=1};
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
};


class PASCALIMPLEMENTATION TLMDDBRichScrollText : public Lmdrtflabel::TLMDCustomRichScrollText
{
	typedef Lmdrtflabel::TLMDCustomRichScrollText inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FMemoLoaded;
	System::UnicodeString FDataSave;
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRichScrollText(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRichScrollText(void);
	virtual void __fastcall LoadMemo(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	
__published:
	__property AutoURLPopup = {default=1};
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Direction = {default=0};
	__property ScrollStyle = {default=0};
	__property Scroll = {default=0};
	__property AutoURLDetect = {default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Transparent = {default=0};
	__property WordWrap = {default=1};
	__property MaxWidth = {default=3000};
	__property MaxHeight = {default=3000};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property Delay = {default=200};
	__property Step = {default=10};
};


class PASCALIMPLEMENTATION TLMDDBRichScrollBox : public Lmdrtflabel::TLMDCustomRichScrollBox
{
	typedef Lmdrtflabel::TLMDCustomRichScrollBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FMemoLoaded;
	System::UnicodeString FDataSave;
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRichScrollBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRichScrollBox(void);
	virtual void __fastcall LoadMemo(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	
__published:
	__property AutoURLPopup = {default=1};
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Transparent = {default=0};
	__property WordWrap = {default=1};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfdblabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFDBLABEL)
using namespace Lmdrtfdblabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfdblabelHPP
