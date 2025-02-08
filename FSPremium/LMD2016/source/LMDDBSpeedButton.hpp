// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBSpeedButton.pas' rev: 31.00 (Windows)

#ifndef LmddbspeedbuttonHPP
#define LmddbspeedbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBookmarkCont.hpp>
#include <LMDDBBtn.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDTypes.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbspeedbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBSpeedButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBSpeedButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
private:
	Lmddbbtn::TLMDButtonDataLink* FDataLink;
	Lmddbbtn::TLMDNavigateBtn FKind;
	Lmdbookmarkcont::TLMDBookmarkCont* FBookmark;
	bool FConfirmDelete;
	System::Classes::TNotifyEvent FOnSearch;
	Lmddbbtn::TLMDNavGlyphSet FSet;
	Lmddbbtn::TLMDNavClick FOnNavClick;
	Lmddbbtn::TLMDNavClick FBeforeAction;
	void __fastcall SetKind(Lmddbbtn::TLMDNavigateBtn aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDatasource(void);
	void __fastcall SetBookmark(Lmdbookmarkcont::TLMDBookmarkCont* aValue);
	void __fastcall SetSet(Lmddbbtn::TLMDNavGlyphSet aValue);
	void __fastcall LoadGlyph(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	void __fastcall EditingChanged(void);
	void __fastcall DataChanged(void);
	void __fastcall ActiveChanged(void);
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TLMDDBSpeedButton(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBSpeedButton(void);
	__property Style;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property ButtonStyle = {default=1};
	__property Data::Db::TDataSource* DataSource = {read=GetDatasource, write=SetDataSource};
	__property Lmddbbtn::TLMDNavigateBtn Kind = {read=FKind, write=SetKind, nodefault};
	__property Lmdbookmarkcont::TLMDBookmarkCont* Bookmark = {read=FBookmark, write=SetBookmark};
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property Lmddbbtn::TLMDNavGlyphSet GlyphSet = {read=FSet, write=SetSet, default=0};
	__property MultiLine = {default=0};
	__property System::Classes::TNotifyEvent OnSearch = {read=FOnSearch, write=FOnSearch};
	__property Lmddbbtn::TLMDNavClick OnBeforeNavBtnAction = {read=FBeforeAction, write=FBeforeAction};
	__property Lmddbbtn::TLMDNavClick OnNavBtnClick = {read=FOnNavClick, write=FOnNavClick};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBSPEEDBUTTON)
using namespace Lmddbspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbspeedbuttonHPP
