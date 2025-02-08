// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBCheckGroup.pas' rev: 31.00 (Windows)

#ifndef LmddbcheckgroupHPP
#define LmddbcheckgroupHPP

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
#include <LMDCustomCheckGroup.hpp>
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
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbcheckgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBCheckGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBCheckGroup : public Lmdcustomcheckgroup::TLMDCustomCheckGroup
{
	typedef Lmdcustomcheckgroup::TLMDCustomCheckGroup inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	DYNAMIC void __fastcall Click(void);
	virtual int __fastcall GetFieldValue(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBCheckGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBCheckGroup(void);
	virtual bool __fastcall CanModify(void);
	__property Value = {default=0};
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property About = {default=0};
	__property Alignment = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property CaptionFont;
	__property CaptionFont3D;
	__property CaptionOffset = {default=8};
	__property CaptionParentFont = {default=1};
	__property Columns = {default=1};
	__property FocusStyle = {default=1};
	__property FocusColor = {default=8421504};
	__property UseFocusColor = {default=0};
	__property Font;
	__property Font3D;
	__property GlyphImageIndex = {index=0, default=0};
	__property GlyphImageList;
	__property GlyphListIndex = {index=1, default=0};
	__property GlyphNumber = {default=3};
	__property GlyphTransparent = {default=0};
	__property GlyphTransparentColor = {default=32896};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ItemHeight = {default=-1};
	__property ItemOffset = {default=4};
	__property Items;
	__property ListIndex = {index=1, default=0};
	__property ShowAccelChar = {default=1};
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
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
	__property OnResize;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBCheckGroup(HWND ParentWindow) : Lmdcustomcheckgroup::TLMDCustomCheckGroup(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbcheckgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBCHECKGROUP)
using namespace Lmddbcheckgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbcheckgroupHPP
