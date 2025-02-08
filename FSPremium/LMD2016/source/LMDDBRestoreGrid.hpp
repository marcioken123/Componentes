// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBRestoreGrid.pas' rev: 31.00 (Windows)

#ifndef LmddbrestoregridHPP
#define LmddbrestoregridHPP

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
#include <LMDCustomIniComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDIniCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbrestoregrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBRestoreGrid;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDBRestoreGridOption : unsigned char { rgIndex, rgVisible, rgWidth };

typedef System::Set<TLMDDBRestoreGridOption, TLMDDBRestoreGridOption::rgIndex, TLMDDBRestoreGridOption::rgWidth> TLMDDBRestoreGridOptions;

class PASCALIMPLEMENTATION TLMDDBRestoreGrid : public Lmdcustominicomponent::TLMDCustomIniComponent
{
	typedef Lmdcustominicomponent::TLMDCustomIniComponent inherited;
	
private:
	Data::Db::TDataSource* FDataSource;
	TLMDDBRestoreGridOptions FOptions;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	
protected:
	virtual void __fastcall CreateSectionDefault(System::UnicodeString &aValue);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBRestoreGrid(System::Classes::TComponent* aOwner);
	DYNAMIC void __fastcall RestoreState(void);
	DYNAMIC void __fastcall SaveState(void);
	void __fastcall ReadData(void);
	void __fastcall WriteData(void);
	
__published:
	__property About = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource};
	__property IniLink;
	__property IniUse = {default=1};
	__property TLMDDBRestoreGridOptions Options = {read=FOptions, write=FOptions, default=7};
	__property Section = {default=0};
public:
	/* TLMDCustomIniComponent.Destroy */ inline __fastcall virtual ~TLMDDBRestoreGrid(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbrestoregrid */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBRESTOREGRID)
using namespace Lmddbrestoregrid;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbrestoregridHPP
