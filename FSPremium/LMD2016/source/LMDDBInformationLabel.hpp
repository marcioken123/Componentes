// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBInformationLabel.pas' rev: 31.00 (Windows)

#ifndef LmddbinformationlabelHPP
#define LmddbinformationlabelHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbinformationlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBInformationLabel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDBInfoTypes : unsigned char { itDBRecords, itDBCurrentRecord, itDBCurrent_All, itDBState, itDBRecordSize, itDBFieldCount, itDBModified, itDBReadOnly };

class PASCALIMPLEMENTATION TLMDDBInformationLabel : public Lmdbaselabel::TLMDBaseLabel
{
	typedef Lmdbaselabel::TLMDBaseLabel inherited;
	
private:
	TLMDDBInfoTypes FInfo;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	bool FStandartCaption;
	Lmdbevel::TLMDBevel* FBevel;
	System::UnicodeString FUnits;
	System::Int8 FDB;
	System::Int8 FTabs;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetInfo(TLMDDBInfoTypes aValue);
	void __fastcall SetTabs(System::Int8 aValue);
	void __fastcall SetDB(System::Int8 aValue);
	void __fastcall SetUnits(System::UnicodeString aValue);
	void __fastcall SetStandartCaption(bool aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	bool __fastcall ReturnCaption(System::UnicodeString &s);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDDBInformationLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBInformationLabel(void);
	virtual void __fastcall CorrectBounds(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	virtual void __fastcall Paint(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property TLMDDBInfoTypes Info = {read=FInfo, write=SetInfo, nodefault};
	__property AutoSize = {index=0, default=1};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Font;
	__property System::Int8 InsertTabs = {read=FTabs, write=SetTabs, default=1};
	__property bool UseStandardCaption = {read=FStandartCaption, write=SetStandartCaption, default=1};
	__property System::UnicodeString Units = {read=FUnits, write=SetUnits};
	__property System::Int8 InsertDB = {read=FDB, write=SetDB, default=-1};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Alignment = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property Transparent = {default=0};
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property Hint = {default=0};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property ShowAccelChar = {index=2, default=1};
	__property Visible = {default=1};
	__property Cursor = {default=0};
	__property OnClick;
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
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbinformationlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBINFORMATIONLABEL)
using namespace Lmddbinformationlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbinformationlabelHPP
