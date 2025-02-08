// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBGraphicLabel.pas' rev: 31.00 (Windows)

#ifndef LmddbgraphiclabelHPP
#define LmddbgraphiclabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Data.DB.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomGraphicLabel.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDTypes.hpp>
#include <LMDGrlf.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbgraphiclabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBGraphicLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBGraphicLabel : public Lmdcustomgraphiclabel::TLMDCustomGraphicLabel
{
	typedef Lmdcustomgraphiclabel::TLMDCustomGraphicLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	System::UnicodeString __fastcall GetFieldText(void);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBGraphicLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBGraphicLabel(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Attributes = {default=4};
	__property AutoSize = {index=1, default=0};
	__property Color = {default=-16777211};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Factor = {index=2, default=5};
	__property FillObject;
	__property Font;
	__property FontFX;
	__property InvertCaption = {index=2, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Perspective = {default=1};
	__property PerspectiveDepth = {index=4, default=5};
	__property PopupMenu;
	__property ShowHint;
	__property Toggle = {default=0};
	__property Transform = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbgraphiclabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBGRAPHICLABEL)
using namespace Lmddbgraphiclabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbgraphiclabelHPP
