// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolComparer.pas' rev: 5.00

#ifndef CoolComparerHPP
#define CoolComparerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CompareRoutines.hpp>	// Pascal unit
#include <CoolDBUtils.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolcomparer
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPriority { ptyHighest, ptyHigher, ptyHigh, ptyLow, ptyLower, ptyLowest, ptyNone };
#pragma option pop

#pragma option push -b-
enum TComparePosition { compByCons, compByVow, compByDig, compByPart, compByConsByPart, compByVowByPart, 
	compByDigByPart };
#pragma option pop

typedef Set<TComparePosition, compByCons, compByDigByPart>  TComparePositions;

typedef void __fastcall (__closure *TProgressEvent)(System::TObject* Sender, int Total, int Current)
	;

class DELPHICLASS TCoolDBComparer;
class PASCALIMPLEMENTATION TCoolDBComparer : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStrings* FFieldList;
	Classes::TStringList* FDataList;
	Classes::TStringList* FPriorityList;
	Classes::TStringList* FTargetList;
	TComparePositions FComparePositions;
	int FMatchesEnough;
	int FPointsEnough;
	Compareroutines::TStrComparer* FStrComparer;
	Cooldbutils::TDBCUAboutBox* FAbout;
	TProgressEvent FOnProgress;
	void __fastcall SetFieldList(Classes::TStrings* Value);
	AnsiString __fastcall GetFieldValue(AnsiString FieldName);
	void __fastcall SetFieldValue(AnsiString FieldName, AnsiString FieldVal);
	TPriority __fastcall GetFieldPriority(AnsiString FieldName);
	void __fastcall SetFieldPriority(AnsiString FieldName, TPriority FieldPrior);
	
protected:
	virtual bool __fastcall ValidFieldName(AnsiString FieldName);
	virtual bool __fastcall CompareFieldValue(AnsiString FieldName, AnsiString ValueToCheck);
	
public:
	__fastcall virtual TCoolDBComparer(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDBComparer(void);
	void __fastcall AssignData(Classes::TStrings* AFieldList, Classes::TStrings* ADataList, Classes::TStrings* 
		APriorityList);
	void __fastcall InitializeFields(const AnsiString * FieldNames, const int FieldNames_Size);
	bool __fastcall Compare(Db::TDataSet* Table, int &RecPoints, int &RecIndex);
	__property AnsiString FieldValue[AnsiString FieldName] = {read=GetFieldValue, write=SetFieldValue};
		
	__property TPriority FieldPriority[AnsiString FieldName] = {read=GetFieldPriority, write=SetFieldPriority
		};
	__property Classes::TStringList* DataList = {read=FDataList};
	__property Classes::TStringList* PriorityList = {read=FPriorityList};
	__property Classes::TStringList* TargetList = {read=FTargetList};
	
__published:
	__property Cooldbutils::TDBCUAboutBox* About = {read=FAbout, write=FAbout};
	__property TComparePositions ComparePositions = {read=FComparePositions, write=FComparePositions, default=127
		};
	__property int MatchesEnough = {read=FMatchesEnough, write=FMatchesEnough, default=3};
	__property int PointsEnough = {read=FPointsEnough, write=FPointsEnough, default=0};
	__property Classes::TStrings* FieldList = {read=FFieldList, write=SetFieldList};
	__property TProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint POINTS_HIGHEST = 0x3c;
static const Shortint POINTS_HIGHER = 0x32;
static const Shortint POINTS_HIGH = 0x28;
static const Shortint POINTS_LOW = 0x1e;
static const Shortint POINTS_LOWER = 0x14;
static const Shortint POINTS_LOWEST = 0xa;
static const Shortint POINTS_NONE = 0x0;
extern PACKAGE System::ResourceString _SErrorFieldName;
#define Coolcomparer_SErrorFieldName System::LoadResourceString(&Coolcomparer::_SErrorFieldName)
extern PACKAGE int __fastcall PriorityToPoints(TPriority Value);

}	/* namespace Coolcomparer */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolcomparer;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolComparer
