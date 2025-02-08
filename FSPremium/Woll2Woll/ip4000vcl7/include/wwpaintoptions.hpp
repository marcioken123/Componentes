// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwpaintoptions.pas' rev: 6.00

#ifndef wwpaintoptionsHPP
#define wwpaintoptionsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <TypInfo.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <wwbitmap.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwpaintoptions
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwBackgroundOption { coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord, coBlendAlternatingRow };
#pragma option pop

typedef Set<TwwBackgroundOption, coFillDataCells, coBlendAlternatingRow>  TwwBackgroundOptions;

#pragma option push -b-
enum TwwBackgroundDrawStyle { bdsTile, bdsStretch, bdsTopLeft, bdsCenter };
#pragma option pop

#pragma option push -b-
enum TwwAlternatingRowRegion { arrFixedColumns, arrDataColumns, arrActiveDataColumn };
#pragma option pop

typedef Set<TwwAlternatingRowRegion, arrFixedColumns, arrActiveDataColumn>  TwwAlternatingRowRegions;

class DELPHICLASS TwwGridPaintOptions;
class PASCALIMPLEMENTATION TwwGridPaintOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FAlternatingRowColor;
	Graphics::TColor FActiveRecordColor;
	TwwBackgroundOptions FBackgroundOptions;
	Graphics::TPicture* FBackgroundBitmap;
	TwwBackgroundDrawStyle FBackgroundDrawStyle;
	TwwAlternatingRowRegions FAlternatingRowRegions;
	bool FFastRecordScrolling;
	void __fastcall PictureChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetAlternatingRowRegions(TwwAlternatingRowRegions val);
	virtual void __fastcall SetAlternatingRowColor(Graphics::TColor Value);
	virtual void __fastcall SetActiveRecordColor(Graphics::TColor Value);
	virtual void __fastcall SetBackgroundOptions(TwwBackgroundOptions Value);
	virtual void __fastcall SetBackgroundDrawStyle(TwwBackgroundDrawStyle Value);
	virtual void __fastcall SetBackgroundBitmap(Graphics::TPicture* Value);
	virtual Graphics::TCanvas* __fastcall GetCanvas(void);
	
public:
	Grids::TCustomGrid* Grid;
	bool InitBlendBitmapsFlag;
	Graphics::TColor Column1Color;
	Graphics::TColor Row1Color;
	Graphics::TBitmap* FPaintBitmap;
	Graphics::TBitmap* OrigBitmap;
	Wwbitmap::TwwBitmap* AlternatingColorBitmap;
	Wwbitmap::TwwBitmap* ActiveRecordBitmap;
	Wwbitmap::TwwBitmap* Column1Bitmap;
	Wwbitmap::TwwBitmap* Row1Bitmap;
	__fastcall TwwGridPaintOptions(Classes::TComponent* Owner, Graphics::TBitmap* APaintBitmap);
	__fastcall virtual ~TwwGridPaintOptions(void);
	void __fastcall InitBlendBitmaps(bool ForceInit = false);
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	virtual bool __fastcall HaveBackgroundForDataCells(void);
	
__published:
	__property Graphics::TPicture* BackgroundBitmap = {read=FBackgroundBitmap, write=SetBackgroundBitmap};
	__property TwwBackgroundDrawStyle BackgroundDrawStyle = {read=FBackgroundDrawStyle, write=SetBackgroundDrawStyle, default=0};
	__property TwwAlternatingRowRegions AlternatingRowRegions = {read=FAlternatingRowRegions, write=SetAlternatingRowRegions, default=7};
	__property bool FastRecordScrolling = {read=FFastRecordScrolling, write=FFastRecordScrolling, default=1};
	__property Graphics::TColor AlternatingRowColor = {read=FAlternatingRowColor, write=SetAlternatingRowColor, default=536870911};
	__property Graphics::TColor ActiveRecordColor = {read=FActiveRecordColor, write=SetActiveRecordColor, default=536870911};
	__property TwwBackgroundOptions BackgroundOptions = {read=FBackgroundOptions, write=SetBackgroundOptions, default=0};
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwpaintoptions)

}	/* namespace Wwpaintoptions */
using namespace Wwpaintoptions;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwpaintoptions
