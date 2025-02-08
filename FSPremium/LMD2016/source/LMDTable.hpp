// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTable.pas' rev: 31.00 (Windows)

#ifndef LmdtableHPP
#define LmdtableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDWriter.hpp>
#include <LMDHiddenText.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtable
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCell;
class DELPHICLASS TLMDColumnParam;
class DELPHICLASS TLMDRowParam;
class DELPHICLASS TLMDTableRow;
class DELPHICLASS TLMDTable;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDVAlign : unsigned char { vaTop, vaMiddle, vaBottom, vaNone };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCell : public Lmdtext::TLMDParsedTextList
{
	typedef Lmdtext::TLMDParsedTextList inherited;
	
private:
	bool FChanged;
	int FRow;
	int FColumn;
	System::Classes::TList* FDependents;
	TLMDCell* FPrecedents;
	int FRowspan;
	int FColspan;
	Lmdtext::TLMDParaAlign FAlign;
	TLMDVAlign FVAlign;
	System::Uitypes::TColor FBgColor;
	int FWidth;
	int FHeight;
	int FMinCellWidth;
	int FMaxCellWidth;
	int FMinCellHeight;
	int FAdvCellWidth;
	int FCellWidth;
	int FCellHeight;
	TLMDTable* __fastcall Table(void);
	int __fastcall GetMinWidth(void);
	int __fastcall GetMaxWidth(void);
	void __fastcall UpdateCellSize(void);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDCell(Lmdtext::TLMDParsedTextList* AParent)/* overload */;
	__fastcall TLMDCell(Lmdtext::TLMDParsedTextList* AParent, int aWidth, int aHeight, int aRowspan, int aColspan, Lmdtext::TLMDParaAlign aAlign, TLMDVAlign aVAlign, System::Uitypes::TColor aBgColor)/* overload */;
	__fastcall virtual ~TLMDCell(void);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual Lmdtext::TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	bool __fastcall InGroup(void);
	void __fastcall UnGroup(void);
	void __fastcall GroupCell(TLMDCell* ACell);
	void __fastcall CalcMinHeight(Vcl::Graphics::TCanvas* aCanvas, Vcl::Graphics::TFont* aDefFont);
	void __fastcall CalcMinWidth(Vcl::Graphics::TCanvas* aCanvas, Vcl::Graphics::TFont* aDefFont);
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Rowspan = {read=FRowspan, write=FRowspan, nodefault};
	__property int Colspan = {read=FColspan, write=FColspan, nodefault};
	__property Lmdtext::TLMDParaAlign Align = {read=FAlign, write=FAlign, nodefault};
	__property TLMDVAlign VAlign = {read=FVAlign, write=FVAlign, nodefault};
	__property System::Uitypes::TColor BgColor = {read=FBgColor, write=FBgColor, nodefault};
	__property TLMDCell* Precedent = {read=FPrecedents, write=FPrecedents};
	__property int MinWidth = {read=GetMinWidth, nodefault};
	__property int MaxWidth = {read=GetMaxWidth, nodefault};
	__property int AdvWidth = {read=FAdvCellWidth, write=FAdvCellWidth, nodefault};
	__property int MinHeight = {read=FMinCellHeight, nodefault};
	__property int RowIndex = {read=FRow, write=FRow, nodefault};
	__property int ColumnIndex = {read=FColumn, write=FColumn, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDColumnParam : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FWidth;
	int FMinWidth;
	int FAdvWidth;
	
public:
	__fastcall TLMDColumnParam(void)/* overload */;
	__fastcall TLMDColumnParam(int aWidth, int aMinWidth, int aAdvWidth)/* overload */;
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int MinWidth = {read=FMinWidth, write=FMinWidth, nodefault};
	__property int MaxWidth = {read=FMinWidth, write=FMinWidth, nodefault};
	__property int AdvWidth = {read=FAdvWidth, write=FAdvWidth, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDColumnParam(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRowParam : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FHeight;
	
public:
	__fastcall TLMDRowParam(void)/* overload */;
	__fastcall TLMDRowParam(int aHeight)/* overload */;
	__property int Height = {read=FHeight, write=FHeight, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRowParam(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableRow : public Lmdtext::TLMDParsedTextList
{
	typedef Lmdtext::TLMDParsedTextList inherited;
	
public:
	TLMDCell* operator[](int index) { return this->Cell[index]; }
	
private:
	int FHeight;
	TLMDVAlign FVAlign;
	int __fastcall GetCellCount(void);
	TLMDCell* __fastcall GetCell(int index);
	
public:
	__fastcall TLMDTableRow(Lmdtext::TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDTableRow(Lmdtext::TLMDParsedTextList* aParent, int aHeight)/* overload */;
	virtual Lmdtext::TLMDBaseText* __fastcall Clone(void);
	void __fastcall InsertCell(int aPos);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property TLMDVAlign VAlign = {read=FVAlign, write=FVAlign, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int CellCount = {read=GetCellCount, nodefault};
	__property TLMDCell* Cell[int index] = {read=GetCell/*, default*/};
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDTableRow(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTable : public Lmdtext::TLMDParsedTextList
{
	typedef Lmdtext::TLMDParsedTextList inherited;
	
private:
	System::Classes::TList* FColumnParam;
	System::Classes::TList* FRowParam;
	bool FPrepared;
	int FMinTableWidth;
	int FAdvTableWidth;
	int FTableWidth;
	int FTableHeight;
	int FWidth;
	Lmdtext::TLMDParaAlign FAlign;
	TLMDVAlign FVAlign;
	int FCellspacing;
	int FCellpadding;
	int FBorder;
	System::Uitypes::TColor FBgColor;
	int FDefaultCellPadding;
	TLMDColumnParam* __fastcall GetColumnParam(int Index);
	TLMDRowParam* __fastcall GetRowParam(int Index);
	int __fastcall GetColumnCount(void);
	int __fastcall GetRowCount(void);
	void __fastcall SetMinColumnWidth(int Index);
	void __fastcall SetMaxColumnWidth(int Index);
	void __fastcall CalcMinColumnWidth(Vcl::Graphics::TCanvas* aCanvas, Vcl::Graphics::TFont* aDefFont);
	void __fastcall CalcAdvCellWidth(void);
	void __fastcall CalcAdvColumnsWidth(void);
	bool __fastcall CheckLowWidth(int AColumn, int AWidth);
	void __fastcall RecalcColumnsWidth(void);
	void __fastcall SetRowMinHeight(int ARow, Vcl::Graphics::TCanvas* aCanvas, Vcl::Graphics::TFont* aDefFont);
	void __fastcall CalcRowsHeight(Vcl::Graphics::TCanvas* aCanvas, Vcl::Graphics::TFont* aDefFont);
	void __fastcall UpdateTableSize(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	TLMDTableRow* __fastcall GetRow(int index);
	void __fastcall Group(int AFromRow, int AFromColumn, int AToRow, int AToColumn);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDTable(Lmdtext::TLMDParsedTextList* aParent)/* overload */;
	__fastcall virtual ~TLMDTable(void);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual Lmdtext::TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	void __fastcall Prepare(void);
	TLMDCell* __fastcall Cell(int ARow, int ACol);
	__property int ColumnCount = {read=GetColumnCount, nodefault};
	__property int RowCount = {read=GetRowCount, nodefault};
	__property TLMDColumnParam* ColumnParam[int Index] = {read=GetColumnParam};
	__property TLMDRowParam* RowParam[int Index] = {read=GetRowParam};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property Lmdtext::TLMDParaAlign Align = {read=FAlign, write=FAlign, nodefault};
	__property TLMDVAlign VAlign = {read=FVAlign, write=FVAlign, nodefault};
	__property int Cellspacing = {read=FCellspacing, write=FCellspacing, nodefault};
	__property int Cellpadding = {read=FCellpadding, write=FCellpadding, nodefault};
	__property int Border = {read=FBorder, write=FBorder, nodefault};
	__property System::Uitypes::TColor BgColor = {read=FBgColor, write=FBgColor, nodefault};
	__property TLMDTableRow* Row[int index] = {read=GetRow};
	__property int DefaultCellPadding = {read=FDefaultCellPadding, write=FDefaultCellPadding, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdtext::TLMDParaAlign __fastcall StrToLMDParaAlign(const System::UnicodeString value);
extern DELPHI_PACKAGE TLMDVAlign __fastcall StrToLMDVAlign(const System::UnicodeString value);
}	/* namespace Lmdtable */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTABLE)
using namespace Lmdtable;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtableHPP
