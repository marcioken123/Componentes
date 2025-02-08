// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBMemo.pas' rev: 31.00 (Windows)

#ifndef LmddbmemoHPP
#define LmddbmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDBevel.hpp>
#include <LMDCaret.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <LMDSBar.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbmemo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBMemo;
class DELPHICLASS TLMDDBLabeledMemo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBMemo : public Lmdcustommemo::TLMDCustomMemo
{
	typedef Lmdcustommemo::TLMDCustomMemo inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FFocused;
	bool FMemoLoaded;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetAutoDisplay(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall DrawEditText(int from);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall ChangedText(int At);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBMemo(void);
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	void __fastcall LoadMemo(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property AskForLoop = {default=1};
	__property Bevel;
	__property Caret;
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property FocusOnMouseAbove = {index=6, default=0};
	__property Font;
	__property Font3D;
	__property HideSelection = {index=0, default=1};
	__property HighlightBack = {default=-16777203};
	__property HighlightText = {default=-16777202};
	__property HorizScrollBar;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property Lined = {index=3, default=0};
	__property LineStyle;
	__property ListIndex = {index=1, default=0};
	__property Margin;
	__property MaxLength = {index=0, default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ScrollBars = {default=4};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property VertScrollBar;
	__property Visible = {default=1};
	__property WantTabs = {index=1, default=0};
	__property WordWrap = {index=0, default=1};
	__property OnChange;
	__property OnClick;
	__property OnCurrentRowChanged;
	__property OnCursorPosChanged;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMarginRowPaint;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnRowCountChanged;
	__property OnStartDrag;
	__property OnTextChangedAt;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBMemo(HWND ParentWindow) : Lmdcustommemo::TLMDCustomMemo(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


class PASCALIMPLEMENTATION TLMDDBLabeledMemo : public TLMDDBMemo
{
	typedef TLMDDBMemo inherited;
	
public:
	__fastcall virtual TLMDDBLabeledMemo(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDDBMemo.Destroy */ inline __fastcall virtual ~TLMDDBLabeledMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBLabeledMemo(HWND ParentWindow) : TLMDDBMemo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbmemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBMEMO)
using namespace Lmddbmemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbmemoHPP
