// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwtypes.pas' rev: 6.00

#ifndef WwtypesHPP
#define WwtypesHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Controls.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwtypes
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TwwInvalidValueEvent)(Db::TDataSet* DataSet, Db::TField* Field);

typedef Db::TParam* __fastcall (__closure *TwwFilterFieldMethod)(AnsiString AFieldName);

typedef void __fastcall (__closure *TwwDataSetFilterEvent)(Db::TDataSet* table, bool &Accept);

typedef void __fastcall (__closure *TwwPerformSearchEvent)(System::TObject* Sender, Db::TDataSet* LookupTable, AnsiString SearchField, AnsiString SearchValue, bool PerformLookup, bool &Found);

#pragma option push -b-
enum TwwGetWordOption { wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes, wwgwSpacesInWords };
#pragma option pop

#pragma option push -b-
enum TwwWriteTextOption { wtoAmpersandToUnderline, wtoEllipsis, wtoWordWrap, wtoMergeCanvas, wtoTransparent, wtoCenterVert };
#pragma option pop

typedef Set<TwwWriteTextOption, wtoAmpersandToUnderline, wtoCenterVert>  TwwWriteTextOptions;

typedef Set<TwwGetWordOption, wwgwSkipLeadingBlanks, wwgwSpacesInWords>  TwwGetWordOptions;

#pragma option push -b-
enum TwwEditAlignment { eaLeftAlignEditing, eaRightAlignEditing };
#pragma option pop

class DELPHICLASS TwwFormPosition;
class PASCALIMPLEMENTATION TwwFormPosition : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FLeft;
	int FTop;
	int FWidth;
	int FHeight;
	
__published:
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwFormPosition(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwFormPosition(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwCheatCastNotify;
class PASCALIMPLEMENTATION TwwCheatCastNotify : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TwwCheatCastNotify(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TwwCheatCastNotify(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwCheatCastKeyDown;
class PASCALIMPLEMENTATION TwwCheatCastKeyDown : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
public:
	DYNAMIC void __fastcall KeyDown(Word &key, Classes::TShiftState shift);
public:
	#pragma option push -w-inl
	/* TCustomEdit.Create */ inline __fastcall virtual TwwCheatCastKeyDown(Classes::TComponent* AOwner) : Stdctrls::TCustomEdit(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCheatCastKeyDown(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TwwCheatCastKeyDown(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwOnFilterOption { ofoEnabled, ofoShowHourGlass, ofoCancelOnEscape };
#pragma option pop

typedef Set<TwwOnFilterOption, ofoEnabled, ofoCancelOnEscape>  TwwOnFilterOptions;

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwtypes)
#define wwNewLineString "<New Line>"
extern PACKAGE int __fastcall wwFilterMemoSize(void);

}	/* namespace Wwtypes */
using namespace Wwtypes;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwtypes
