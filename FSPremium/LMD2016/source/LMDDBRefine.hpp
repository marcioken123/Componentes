// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBRefine.pas' rev: 31.00 (Windows)

#ifndef LmddbrefineHPP
#define LmddbrefineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <LMDSearchBase.hpp>
#include <LMDRefineUnit.hpp>
#include <LMDSearchConsts.hpp>
#include <LMDDBRefineDialog.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbrefine
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRefine;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSearchDirection : unsigned char { sdUp, sdDown };

enum DECLSPEC_DENUM Lmddbrefine__1 : unsigned char { fdoAutoSelect, fdoShowBuildButton, fdoCenterDialog, fdoCenterOwnerForm, fdoDefaultNotFoundMessage, fdoUseBookMark };

typedef System::Set<Lmddbrefine__1, Lmddbrefine__1::fdoAutoSelect, Lmddbrefine__1::fdoUseBookMark> TLMDSearchFindDialogOptions;

class PASCALIMPLEMENTATION TLMDDBRefine : public Lmdsearchbase::TLMDSearchBaseDlgComponent
{
	typedef Lmdsearchbase::TLMDSearchBaseDlgComponent inherited;
	
private:
	bool FOffset;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	TLMDSearchDirection FSearchDirection;
	Lmdrefineunit::TLMDRefine* FRefine;
	System::UnicodeString FSearchString;
	Lmddbrefinedialog::TLMDDBSearchFindForm* FFindDialog;
	TLMDSearchFindDialogOptions FFindOptions;
	System::Classes::TNotifyEvent FOnStartSearch;
	System::Classes::TNotifyEvent FOnNotFound;
	System::Classes::TNotifyEvent FOnFound;
	System::Classes::TNotifyEvent FOnFindDlgCustomize;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetSearchDirection(const TLMDSearchDirection Value);
	void __fastcall ShowBuildDialog(System::TObject* Sender);
	void __fastcall FindNextButtonClick(System::TObject* Sender);
	bool __fastcall InternalFind(TLMDSearchDirection Direction = (TLMDSearchDirection)(0x1), bool UpdateSettings = true);
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall SetTemplate(const Lmdsearchbase::TLMDSearchTemplate Value);
	virtual Lmdsearchbase::TLMDSearchTemplate __fastcall GetTemplate(void);
	
public:
	__fastcall virtual TLMDDBRefine(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBRefine(void);
	bool __fastcall FindNext(void);
	void __fastcall FreeFindDialogResources(void);
	void __fastcall ShowFindDialog(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	bool __fastcall ShowBuilderDialog(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TLMDSearchDirection SearchDirection = {read=FSearchDirection, write=SetSearchDirection, default=1};
	__property TLMDSearchFindDialogOptions DlgFindOptions = {read=FFindOptions, write=FFindOptions, default=50};
	__property System::Classes::TNotifyEvent OnDlgFindCustomize = {read=FOnFindDlgCustomize, write=FOnFindDlgCustomize};
	__property System::Classes::TNotifyEvent OnStartSearch = {read=FOnStartSearch, write=FOnStartSearch};
	__property System::Classes::TNotifyEvent OnFound = {read=FOnFound, write=FOnFound};
	__property System::Classes::TNotifyEvent OnNotFound = {read=FOnNotFound, write=FOnNotFound};
	__property DlgBuilderOptions = {default=339};
	__property SearchString = {default=0};
	__property SearchOptions;
	__property OnDlgCustomize;
	__property OnDlgHelpClick;
};


//-- var, const, procedure ---------------------------------------------------
#define def_LMDSPFindOptions (System::Set<Lmddbrefine__1, Lmddbrefine__1::fdoAutoSelect, Lmddbrefine__1::fdoUseBookMark>() << Lmddbrefine__1::fdoShowBuildButton << Lmddbrefine__1::fdoDefaultNotFoundMessage << Lmddbrefine__1::fdoUseBookMark )
}	/* namespace Lmddbrefine */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBREFINE)
using namespace Lmddbrefine;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbrefineHPP
