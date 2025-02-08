// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBookmarkCont.pas' rev: 31.00 (Windows)

#ifndef LmdbookmarkcontHPP
#define LmdbookmarkcontHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Classes.hpp>
#include <LMDBookmarkList.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbookmarkcont
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBookmarkCont;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBookmarkCont : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdbookmarklist::TLMDBookmarkList* FBookList;
	int FGotoBook;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FUniqueBookmarks;
	System::Classes::TNotifyEvent FOnAfterAdd;
	System::Classes::TNotifyEvent FOnAfterGoto;
	System::Classes::TNotifyEvent FOnAfterDelete;
	void __fastcall SetUniqueBookmarks(bool aValue);
	int __fastcall GetCount(void);
	void __fastcall SetGotoBook(int aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDatasource(void);
	
protected:
	__property Lmdbookmarklist::TLMDBookmarkList* Bookmarks = {read=FBookList};
	
public:
	__fastcall virtual TLMDBookmarkCont(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBookmarkCont(void);
	void __fastcall GotoBookmark(void);
	void __fastcall AddBookmark(void);
	void __fastcall DeleteBookmark(void);
	bool __fastcall IsBookmarked(void);
	
__published:
	__property About = {default=0};
	__property int Count = {read=GetCount, nodefault};
	__property int Bookmark = {read=FGotoBook, write=SetGotoBook, default=-1};
	__property Data::Db::TDataSource* DataSource = {read=GetDatasource, write=SetDataSource};
	__property bool UniqueBookmarks = {read=FUniqueBookmarks, write=SetUniqueBookmarks, default=1};
	__property System::Classes::TNotifyEvent OnAfterGoto = {read=FOnAfterGoto, write=FOnAfterGoto};
	__property System::Classes::TNotifyEvent OnAfterAdd = {read=FOnAfterAdd, write=FOnAfterAdd};
	__property System::Classes::TNotifyEvent OnAfterDelete = {read=FOnAfterDelete, write=FOnAfterDelete};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbookmarkcont */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBOOKMARKCONT)
using namespace Lmdbookmarkcont;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbookmarkcontHPP
