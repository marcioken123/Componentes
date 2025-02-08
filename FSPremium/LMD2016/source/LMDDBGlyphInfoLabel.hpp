// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBGlyphInfoLabel.pas' rev: 31.00 (Windows)

#ifndef LmddbglyphinfolabelHPP
#define LmddbglyphinfolabelHPP

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
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBevel.hpp>
#include <LMDCustomGlyphLabel.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyphTextLayout.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbglyphinfolabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBGlyphInfoLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBGlyphInfoLabel : public Lmdcustomglyphlabel::TLMDCustomGlyphLabel
{
	typedef Lmdcustomglyphlabel::TLMDCustomGlyphLabel inherited;
	
private:
	bool FGlyphTransparent;
	bool FStandartCaption;
	System::UnicodeString FUnits;
	System::Int8 FDB;
	System::Int8 FTabs;
	Lmdbevel::TLMDBevel* FBevel;
	System::Uitypes::TColor FTransparentColor;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	Vcl::Graphics::TBitmap* FGlyph;
	int FInternal;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetTabs(System::Int8 aValue);
	void __fastcall SetDB(System::Int8 aValue);
	void __fastcall SetUnits(System::UnicodeString aValue);
	HIDESBASE void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetTransparentColor(System::Uitypes::TColor aValue);
	void __fastcall SetStandartCaption(bool aValue);
	void __fastcall SetGlyphTransparent(bool aValue);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	bool __fastcall ReturnCaption(System::UnicodeString &s);
	virtual void __fastcall GetChange(System::TObject* Sender);
	System::Types::TRect __fastcall DrawItem(const System::Types::TRect &aRect, bool draw);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDDBGlyphInfoLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBGlyphInfoLabel(void);
	virtual void __fastcall CorrectBounds(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Font3D;
	__property Font;
	__property System::Int8 InsertTabs = {read=FTabs, write=SetTabs, default=1};
	__property bool UseStandardCaption = {read=FStandartCaption, write=SetStandartCaption, default=1};
	__property System::UnicodeString Units = {read=FUnits, write=SetUnits};
	__property System::Int8 InsertDB = {read=FDB, write=SetDB, default=-1};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Alignment;
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property Transparent = {default=0};
	__property System::Uitypes::TColor GlyphTransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=16711935};
	__property bool GlyphTransparent = {read=FGlyphTransparent, write=SetGlyphTransparent, default=1};
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
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word IDB_DBINFO = System::Word(0x418a);
}	/* namespace Lmddbglyphinfolabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBGLYPHINFOLABEL)
using namespace Lmddbglyphinfolabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbglyphinfolabelHPP
