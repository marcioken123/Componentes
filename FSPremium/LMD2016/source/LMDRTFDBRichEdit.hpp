// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFDBRichEdit.pas' rev: 31.00 (Windows)

#ifndef LmdrtfdbricheditHPP
#define LmdrtfdbricheditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDRTFRichEdit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFRuler.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfdbrichedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRichEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBRichEdit : public Lmdrtfrichedit::TLMDCustomRichEdit
{
	typedef Lmdrtfrichedit::TLMDCustomRichEdit inherited;
	
private:
	bool FKeepCaret;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FFocused;
	bool FMemoLoaded;
	System::UnicodeString FDataSave;
	void __fastcall BeginEditing(void);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall SetAutoDisplay(bool Value);
	void __fastcall SetFocused(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	System::Types::TPoint FCaretPos;
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRichEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRichEdit(void);
	virtual void __fastcall LoadMemo(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	
__published:
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool KeepCaret = {read=FKeepCaret, write=FKeepCaret, default=0};
	__property AcceptDropFiles = {default=1};
	__property AllowObjects = {default=1};
	__property AllowInPlace = {default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property AutoURLDetect = {default=0};
	__property AutoVerbMenu = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property HideScrollBars = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property Constraints;
	__property LanguageOptions = {default=2};
	__property MaxLength = {default=0};
	__property Mode = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PlainText = {default=0};
	__property PopupMenu;
	__property ShowRuler = {default=0};
	__property ScrollBars = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Title = {default=0};
	__property UndoLimit = {default=100};
	__property Visible = {default=1};
	__property Version;
	__property WantTabs = {default=0};
	__property WantReturns = {default=1};
	__property WordWrap = {default=1};
	__property Zoom = {default=0};
	__property OnChange;
	__property ShowDefaultPopup = {default=1};
	__property OnAfterSave;
	__property OnBeforeSave;
	__property OnContextPopup;
	__property OnDlgCustomize;
	__property OnDlgInit;
	__property OnDlgAfterShow;
	__property OnDropFile;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnProtectChange;
	__property OnResizeRequest;
	__property OnSaveClipboard;
	__property OnSelectionChange;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnURLClick;
	__property OnLinkClick;
	__property OnRulerTabCreate;
	__property OnRulerTabChange;
	__property OnRulerTabDestroy;
	__property OnRulerFirstIdentChange;
	__property OnRulerLeftIdentChange;
	__property OnRulerRightIdentChange;
	__property OnVScroll;
	__property OnHScroll;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBRichEdit(HWND ParentWindow) : Lmdrtfrichedit::TLMDCustomRichEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfdbrichedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFDBRICHEDIT)
using namespace Lmdrtfdbrichedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfdbricheditHPP
