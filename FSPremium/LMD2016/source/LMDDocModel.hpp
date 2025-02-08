// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDocModel.pas' rev: 31.00 (Windows)

#ifndef LmddocmodelHPP
#define LmddocmodelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDPrinter.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddocmodel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextAreaSettings;
class DELPHICLASS TLMDDocEntity;
class DELPHICLASS TLMDDocContainer;
class DELPHICLASS TLMDDocument;
class DELPHICLASS TLMDDocElement;
class DELPHICLASS TLMDVertPlaceholder;
class DELPHICLASS TLMDTextBlock;
class DELPHICLASS TLMDDocImage;
class DELPHICLASS TLMDTableCellFormat;
class DELPHICLASS TLMDTableColumn;
class DELPHICLASS TLMDTableCell;
class DELPHICLASS TLMDDocTable;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDVerticalAlignment : unsigned char { vaTop, vaBottom };

enum DECLSPEC_DENUM TLMDHorizontalAlignment : unsigned char { haLeft, haCenter, haRight };

enum DECLSPEC_DENUM TLMDTextAlignment : unsigned char { laLeft, laRight, laCenter, laWidth };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextAreaSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	TLMDTextAlignment FAlign;
	bool FReflowText;
	bool FIsRTF;
	int FTabSize;
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetIsRTF(const bool Value);
	void __fastcall SetTabSize(const int Value);
	
public:
	__fastcall TLMDTextAreaSettings(void);
	__fastcall virtual ~TLMDTextAreaSettings(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int TabSize = {read=FTabSize, write=SetTabSize, default=8};
	__property bool IsRTF = {read=FIsRTF, write=SetIsRTF, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TLMDTextAlignment Align = {read=FAlign, write=FAlign, default=0};
	__property bool ReflowText = {read=FReflowText, write=FReflowText, default=0};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocEntity : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::TObject* FTag;
	
public:
	__property System::TObject* Tag = {read=FTag, write=FTag};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDDocEntity(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDDocEntity(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocContainer : public TLMDDocEntity
{
	typedef TLMDDocEntity inherited;
	
protected:
	System::Classes::TList* FChildElements;
	
public:
	__fastcall TLMDDocContainer(void);
	__fastcall virtual ~TLMDDocContainer(void);
	
__published:
	__property System::Classes::TList* ChildElements = {read=FChildElements};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocument : public TLMDDocContainer
{
	typedef TLMDDocContainer inherited;
	
public:
	/* TLMDDocContainer.Create */ inline __fastcall TLMDDocument(void) : TLMDDocContainer() { }
	/* TLMDDocContainer.Destroy */ inline __fastcall virtual ~TLMDDocument(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocElement : public TLMDDocContainer
{
	typedef TLMDDocContainer inherited;
	
private:
	int FHeight;
	int FLeft;
	int FWidth;
	int FTop;
	bool FCanGrow;
	bool FAutoSize;
	int FPageNum;
	
public:
	__fastcall TLMDDocElement(void);
	virtual void __fastcall PrepareForPrinting(Vcl::Graphics::TCanvas* APageCanvas, Lmdtypes::TLMDMargins* AMargins);
	
__published:
	__property int Top = {read=FTop, write=FTop, default=0};
	__property int Left = {read=FLeft, write=FLeft, default=0};
	__property int Height = {read=FHeight, write=FHeight, default=0};
	__property int Width = {read=FWidth, write=FWidth, default=0};
	__property int PageNum = {read=FPageNum, write=FPageNum, default=0};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=1};
	__property bool CanGrow = {read=FCanGrow, write=FCanGrow, default=1};
public:
	/* TLMDDocContainer.Destroy */ inline __fastcall virtual ~TLMDDocElement(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVertPlaceholder : public TLMDDocElement
{
	typedef TLMDDocElement inherited;
	
public:
	/* TLMDDocElement.Create */ inline __fastcall TLMDVertPlaceholder(void) : TLMDDocElement() { }
	
public:
	/* TLMDDocContainer.Destroy */ inline __fastcall virtual ~TLMDVertPlaceholder(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextBlock : public TLMDDocElement
{
	typedef TLMDDocElement inherited;
	
private:
	System::Classes::TStrings* FStrings;
	TLMDTextAreaSettings* FTextFormat;
	bool FIsRTF;
	int FEndPos;
	int FStartPos;
	void __fastcall SetTextFormat(TLMDTextAreaSettings* const Value);
	void __fastcall SetIsRTF(const bool Value);
	void __fastcall SetStrings(System::Classes::TStrings* const Value);
	
public:
	__fastcall TLMDTextBlock(void);
	__fastcall virtual ~TLMDTextBlock(void);
	
__published:
	__property System::Classes::TStrings* Strings = {read=FStrings, write=SetStrings};
	__property TLMDTextAreaSettings* TextFormat = {read=FTextFormat, write=SetTextFormat};
	__property bool IsRTF = {read=FIsRTF, write=SetIsRTF, default=0};
	__property int StartPos = {read=FStartPos, write=FStartPos, default=-1};
	__property int EndPos = {read=FEndPos, write=FEndPos, default=0};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocImage : public TLMDDocElement
{
	typedef TLMDDocElement inherited;
	
private:
	Vcl::Graphics::TBitmap* FPicture;
	System::Types::TRect FRect;
	void __fastcall SetPicture(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetRect(const System::Types::TRect &Value);
	
public:
	__fastcall TLMDDocImage(void);
	__property Vcl::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture};
	__property System::Types::TRect PictureRect = {read=FRect, write=SetRect};
public:
	/* TLMDDocContainer.Destroy */ inline __fastcall virtual ~TLMDDocImage(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableCellFormat : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TPen* FTopBorderPen;
	Vcl::Graphics::TPen* FBottomBorderPen;
	Vcl::Graphics::TPen* FRightBorderPen;
	Vcl::Graphics::TPen* FLeftBorderPen;
	TLMDTextAreaSettings* FTextFormat;
	Lmdtypes::TLMDMargins* FMargins;
	bool FIsRTF;
	void __fastcall SetBottomBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetLeftBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetRightBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetTopBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetTextFormat(TLMDTextAreaSettings* const Value);
	void __fastcall SetMargins(Lmdtypes::TLMDMargins* const Value);
	void __fastcall SetIsRTF(const bool Value);
	
public:
	__fastcall TLMDTableCellFormat(void);
	__fastcall virtual ~TLMDTableCellFormat(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TPen* LeftBorderPen = {read=FLeftBorderPen, write=SetLeftBorderPen};
	__property Vcl::Graphics::TPen* RightBorderPen = {read=FRightBorderPen, write=SetRightBorderPen};
	__property Vcl::Graphics::TPen* TopBorderPen = {read=FTopBorderPen, write=SetTopBorderPen};
	__property Vcl::Graphics::TPen* BottomBorderPen = {read=FBottomBorderPen, write=SetBottomBorderPen};
	__property TLMDTextAreaSettings* TextFormat = {read=FTextFormat, write=SetTextFormat};
	__property bool IsRTF = {read=FIsRTF, write=SetIsRTF, default=0};
	__property Lmdtypes::TLMDMargins* Margins = {read=FMargins, write=SetMargins};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableColumn : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FWidth;
	
public:
	__fastcall TLMDTableColumn(void);
	
__published:
	__property int Width = {read=FWidth, write=FWidth, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTableColumn(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableCell : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDTableCellFormat* FCellFormat;
	System::Classes::TStrings* FStrings;
	bool FHasSpecialFormat;
	void __fastcall SetCellFormat(TLMDTableCellFormat* const Value);
	void __fastcall SetHasSpecialFormat(const bool Value);
	void __fastcall SetStrings(System::Classes::TStrings* const Value);
	
protected:
	TLMDDocTable* FTable;
	
public:
	__fastcall TLMDTableCell(void);
	__fastcall virtual ~TLMDTableCell(void);
	__property TLMDTableCellFormat* CellFormat = {read=FCellFormat, write=SetCellFormat};
	__property bool HasSpecialFormat = {read=FHasSpecialFormat, write=SetHasSpecialFormat, default=0};
	__property System::Classes::TStrings* Strings = {read=FStrings, write=SetStrings};
};

#pragma pack(pop)

typedef System::DynamicArray<TLMDTableCell*> Lmddocmodel__21;

typedef System::DynamicArray<System::DynamicArray<TLMDTableCell*> > TLMDCellsMatrix;

enum DECLSPEC_DENUM TLMDColumnsWidthMode : unsigned char { cwmEqual, cwmAutoSize, cwmManual };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocTable : public TLMDDocElement
{
	typedef TLMDDocElement inherited;
	
	
private:
	typedef System::DynamicArray<TLMDTableColumn*> _TLMDDocTable__1;
	
	
private:
	TLMDCellsMatrix FCells;
	TLMDTableCellFormat* FDefaultCellFormat;
	_TLMDDocTable__1 FColumns;
	int FRowCount;
	System::Types::TRect FArea;
	int FFirstYOffset;
	TLMDColumnsWidthMode FColumnsWidthMode;
	int FColCount;
	void __fastcall SetDefaultCellFormat(TLMDTableCellFormat* const Value);
	void __fastcall SetRowCount(const int Value);
	TLMDTableCell* __fastcall GetCell(int ARow, int ACol);
	void __fastcall SetColCount(const int Value);
	TLMDTableColumn* __fastcall GetColumn(int ACol);
	
protected:
	System::Classes::TList* FCellFormats;
	
public:
	__fastcall TLMDDocTable(void);
	__fastcall virtual ~TLMDDocTable(void);
	virtual void __fastcall PrepareForPrinting(Vcl::Graphics::TCanvas* APageCanvas, Lmdtypes::TLMDMargins* AMargins);
	int __fastcall GetHorizontalCellOffset(int ARow, int ACol);
	__property TLMDTableCell* Cell[int ARow][int ACol] = {read=GetCell};
	__property TLMDTableColumn* Columns[int ACol] = {read=GetColumn};
	__property TLMDTableCellFormat* DefaultCellFormat = {read=FDefaultCellFormat, write=SetDefaultCellFormat};
	__property TLMDColumnsWidthMode ColumnsWidthMode = {read=FColumnsWidthMode, write=FColumnsWidthMode, nodefault};
	__property int RowCount = {read=FRowCount, write=SetRowCount, default=0};
	__property int ColCount = {read=FColCount, write=SetColCount, default=0};
	__property System::Types::TRect Area = {read=FArea, write=FArea};
	__property int FirstYOffset = {read=FFirstYOffset, write=FFirstYOffset, default=0};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddocmodel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCMODEL)
using namespace Lmddocmodel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddocmodelHPP
