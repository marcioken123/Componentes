// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBRadioButton.pas' rev: 31.00 (Windows)

#ifndef LmddbradiobuttonHPP
#define LmddbradiobuttonHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDRadioButton.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomControl.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbradiobutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRadioButton;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 2> Lmddbradiobutton__1;

class PASCALIMPLEMENTATION TLMDDBRadioButton : public Lmdradiobutton::TLMDRadioButton
{
	typedef Lmdradiobutton::TLMDRadioButton inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString FValue;
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall ValueMatch(const System::UnicodeString ValueList, const System::UnicodeString Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall SetChecked(bool aValue);
	virtual bool __fastcall isSibling(Vcl::Controls::TControl* aControl);
	virtual bool __fastcall CanModify(void);
	bool __fastcall GetFieldState(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRadioButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRadioButton(void);
	__property Checked;
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property About = {default=0};
	__property Alignment;
	__property AutoSize = {index=0, default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
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
	__property GlyphTransparent = {index=1, default=1};
	__property GlyphTransparentColor = {default=32896};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
	__property Visible = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBRadioButton(HWND ParentWindow) : Lmdradiobutton::TLMDRadioButton(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmddbradiobutton__1 tf;
}	/* namespace Lmddbradiobutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBRADIOBUTTON)
using namespace Lmddbradiobutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbradiobuttonHPP
