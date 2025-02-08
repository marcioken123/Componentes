// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomMemo.pas' rev: 31.00 (Windows)

#ifndef LmdcustommemoHPP
#define LmdcustommemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Themes.hpp>
#include <LMDObject.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDFillObject.hpp>
#include <LMDSBar.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <System.Types.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustommemo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMemoStrings;
class DELPHICLASS TLMDMarginObject;
class DELPHICLASS TLMDCustomMemo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDMemoScrollBarKind : unsigned char { skHorizontal, skVertical, skBoth, skAuto, skNone };

class PASCALIMPLEMENTATION TLMDMemoStrings : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
public:
	Lmdtypes::TLMDString operator[](int Index) { return this->Strings[Index]; }
	
private:
	TLMDCustomMemo* FOwnerMemo;
	bool FAdditiveLoadFrom;
	Lmdtypes::TLMDString __fastcall GetLine(int index);
	void __fastcall SetLine(int index, Lmdtypes::TLMDString aValue);
	Lmdtypes::TLMDString __fastcall GetText(void);
	int __fastcall GetRows(void);
	void __fastcall SetText(const Lmdtypes::TLMDString aValue);
	
public:
	__property TLMDCustomMemo* Owner = {read=FOwnerMemo};
	__fastcall TLMDMemoStrings(TLMDCustomMemo* aOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const Lmdtypes::TLMDString Filename);
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString Filename);
	void __fastcall SaveToStreamW(System::Classes::TStream* Stream);
	void __fastcall LoadFromStreamW(System::Classes::TStream* Stream);
	void __fastcall SaveToFileW(const Lmdtypes::TLMDString Filename);
	void __fastcall LoadFromFileW(const Lmdtypes::TLMDString Filename);
	HIDESBASE void __fastcall BeginUpdate(void);
	HIDESBASE void __fastcall EndUpdate(void);
	void __fastcall Insert(int Index, const Lmdtypes::TLMDString S);
	void __fastcall Append(const Lmdtypes::TLMDString S);
	int __fastcall Add(const Lmdtypes::TLMDString S);
	void __fastcall AddStrings(System::Classes::TStrings* aValue);
	void __fastcall GetAsStrings(System::Classes::TStrings* aValue);
	void __fastcall Move(int CurIndex, int NewIndex);
	void __fastcall Delete(int Index);
	void __fastcall Exchange(int FirstIndex, int SecondIndex);
	void __fastcall Clear(void);
	void __fastcall SetTextStr(const Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetTextStr(void);
	__property int Count = {read=GetRows, nodefault};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property Lmdtypes::TLMDString Strings[int Index] = {read=GetLine, write=SetLine/*, default*/};
	__property bool AdditiveLoadFrom = {read=FAdditiveLoadFrom, write=FAdditiveLoadFrom, default=0};
protected:
	/* TLMDObject.Create */ inline __fastcall virtual TLMDMemoStrings(System::Classes::TPersistent* Owner) : Lmdobject::TLMDObject(Owner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDMemoStrings(void) { }
	
};


enum DECLSPEC_DENUM TLMDMarginAlignment : unsigned char { maLeft, maRight };

class PASCALIMPLEMENTATION TLMDMarginObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	int FWidth;
	Lmdfillobject::TLMDFillObject* FFillObject;
	TLMDMarginAlignment FAlignment;
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetInteger(int aValue);
	void __fastcall SetAlignment(TLMDMarginAlignment aValue);
	
public:
	__fastcall virtual TLMDMarginObject(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDMarginObject(void);
	
__published:
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property int Width = {read=FWidth, write=SetInteger, default=0};
	__property TLMDMarginAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
};


typedef void __fastcall (__closure *TLMDOnMarginRowPaint)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &aRect, int firstChar, int length);

class PASCALIMPLEMENTATION TLMDCustomMemo : public Lmdbaseedit::TLMDBaseEdit
{
	typedef Lmdbaseedit::TLMDBaseEdit inherited;
	
private:
	Lmdsbar::TLMDScrollBar* FHScroll;
	Lmdsbar::TLMDScrollBar* FVScroll;
	Lmdsbar::TLMDScrollBarObject* FHScrollObj;
	Lmdsbar::TLMDScrollBarObject* FVScrollObj;
	TLMDMemoScrollBarKind FScrollBars;
	TLMDMemoStrings* FStrings;
	float FVScrollFactor;
	bool FCanScrollDown;
	int FOldHiddenLeft;
	int FOldFirstRow;
	int FOldCurrentRow;
	int FRowHeight;
	int FFirstRowOut;
	int FRows;
	int FWorkRowCount;
	int FCurrentRow;
	int FCursorRowStart;
	int FCursorRowFirst;
	int FCursorFirst;
	int FHideLeftRight;
	int FLongRow;
	int FRowsDrawnCount;
	int FFirstCharOut;
	bool FSoftLineBreak;
	bool FScrolled;
	bool FLined;
	bool FTextEnd;
	bool FWantTabs;
	bool FWantReturns;
	bool FWordWrap;
	TLMDMarginObject* FMargin;
	System::Types::TRect FMarginRect;
	Vcl::Graphics::TPen* FLineStyle;
	int FTabChars;
	System::StaticArray<int, 256> CharWidth;
	System::StaticArray<int, 150> LA;
	TLMDOnMarginRowPaint FOnMarginRowPaint;
	System::Classes::TNotifyEvent FOnRowChange;
	System::Classes::TNotifyEvent FOnRowCountChange;
	bool FIgnoreLastEmptyLine;
	int FLineGap;
	int FHiddenLeft;
	void __fastcall UpdateVScrollBar(void);
	void __fastcall SetRows(int index, int aValue);
	void __fastcall SetScrollBars(TLMDMemoScrollBarKind aValue);
	void __fastcall SetStrings(TLMDMemoStrings* aValue);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	int __fastcall GetRowCount(void);
	void __fastcall SetIgnoreLastEmptyLine(bool aValue);
	void __fastcall SetLineStyle(Vcl::Graphics::TPen* aValue);
	void __fastcall SetScrollObj(int index, Lmdsbar::TLMDScrollBarObject* aValue);
	void __fastcall SetMargin(TLMDMarginObject* aValue);
	void __fastcall SetTabChars(int aValue);
	void __fastcall SetLineGap(int aValue);
	TLMDMemoStrings* __fastcall GetStrings(void);
	int __fastcall GetRowNr(void);
	int __fastcall GetColumn(void);
	int __fastcall GetColumns(void);
	void __fastcall ScrollUp(int Rows);
	void __fastcall ScrollDown(int Rows);
	void __fastcall DoOnVScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall DoOnHScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall DoFontChanged(void);
	void __fastcall MakeCursorVisible(void);
	int __fastcall CalcRowNr(int pos);
	int __fastcall CalcRowFromChar(int pos);
	int __fastcall CalcCharRowStart(int pos, int &crow);
	int __fastcall CalcRowStart(int row);
	void __fastcall GetNextLine(int &LineStart, int TextEnd);
	void __fastcall GetPrevLine(int &LineStart, int TextStart);
	void __fastcall PaintMargin(Vcl::Graphics::TCanvas* toCanvas);
	HIDESBASE MESSAGE void __fastcall EMFMTLINES(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETFIRSTVISIBLELINE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETHANDLE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETLINE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETLINECOUNT(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETMARGINS(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMGETTHUMB(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMLINEFROMCHAR(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMLINEINDEX(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMLINELENGTH(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMLINESCROLL(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMPOSFROMCHAR(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMSCROLL(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMSCROLLCARET(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMSETMARGINS(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMSETTABSTOPS(Winapi::Messages::TMessage &Message);
	
protected:
	int __fastcall GetCharWidth(System::WideChar wc)/* overload */;
	int __fastcall GetCharWidth(int oc)/* overload */;
	virtual void __fastcall CreateBack(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall RepaintBack(const System::Types::TRect &aRect);
	void __fastcall ClearBack(void);
	virtual void __fastcall DoAlignmentChange(void);
	void __fastcall InitScrollBars(void);
	HIDESBASE int __fastcall RowWidth(const Lmdtypes::TLMDString s);
	virtual int __fastcall RowHeight(Lmdtypes::TLMDString s);
	virtual void __fastcall CursorPosChanged(void);
	int __fastcall getRow(int ch);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual System::Types::TRect __fastcall GetClientRect(void);
	int __fastcall CountRows(Lmdtypes::TLMDString &ctext);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	virtual void __fastcall SetCaret(void);
	virtual void __fastcall SetNewText(void);
	virtual void __fastcall GetNewText(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawEditText(int from);
	virtual int __fastcall CalcMousePos(System::Types::TSmallPoint Pos);
	virtual int __fastcall CalcMouseCol(int XPos);
	virtual int __fastcall CalcMouseRow(int YPos);
	virtual void __fastcall ChangedText(int At);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall HandleInsertText(int at, Lmdtypes::TLMDString &aValue);
	virtual void __fastcall HandleReplaceText(int at, Lmdtypes::TLMDString aValue);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ModifyTextRect(void);
	virtual void __fastcall ModifyPaintRect(void);
	__property bool IgnoreLastEmptyLine = {read=FIgnoreLastEmptyLine, write=SetIgnoreLastEmptyLine, default=0};
	__property int RowCounter = {read=FRows, write=SetRows, index=0, nodefault};
	__property int RowFirst = {read=FFirstRowOut, write=SetRows, index=1, nodefault};
	__property int RowLength = {read=FLongRow, write=SetRows, index=2, nodefault};
	__property int RowHide = {read=FHiddenLeft, write=SetRows, index=3, nodefault};
	__property int RowCurrent = {read=FCurrentRow, write=SetRows, index=4, nodefault};
	
public:
	__fastcall virtual TLMDCustomMemo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomMemo(void);
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString Filename)/* overload */;
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString Filename, System::Sysutils::TEncoding* aEncoding)/* overload */;
	void __fastcall SaveToFile(const Lmdtypes::TLMDString Filename)/* overload */;
	void __fastcall SaveToFile(const Lmdtypes::TLMDString Filename, System::Sysutils::TEncoding* aEncoding)/* overload */;
	void __fastcall AddLine(const Lmdtypes::TLMDString s);
	void __fastcall InsertAtLine(int Index, Lmdtypes::TLMDString S);
	void __fastcall DeleteLine(int Index);
	Lmdtypes::TLMDString __fastcall GetLineParas(int Index, int &Start, int &Count);
	Lmdtypes::TLMDString __fastcall GetLine(int Index);
	Lmdtypes::TLMDString __fastcall GetRowText(int Index);
	void __fastcall MoveLine(int CurIndex, int NewIndex);
	void __fastcall ExchangeLines(int FirstIndex, int SecondIndex);
	void __fastcall SetLine(int Index, Lmdtypes::TLMDString S);
	__property int Column = {read=GetColumn, nodefault};
	__property int Row = {read=GetRowNr, nodefault};
	__property int Rows = {read=GetRowCount, nodefault};
	__property int Columns = {read=GetColumns, nodefault};
	__property int FirstRow = {read=FFirstRowOut, nodefault};
	__property TLMDMarginObject* Margin = {read=FMargin, write=SetMargin};
	__property TLMDMemoScrollBarKind ScrollBars = {read=FScrollBars, write=SetScrollBars, default=4};
	__property bool WordWrap = {read=FWordWrap, write=SetBoolean, index=0, default=1};
	__property bool WantTabs = {read=FWantTabs, write=SetBoolean, index=1, default=0};
	__property bool WantReturns = {read=FWantReturns, write=SetBoolean, index=2, default=1};
	__property TLMDMemoStrings* Lines = {read=GetStrings, write=SetStrings, stored=false};
	__property int LineGap = {read=FLineGap, write=SetLineGap, default=2};
	__property int TabChars = {read=FTabChars, write=SetTabChars, default=8};
	__property bool Lined = {read=FLined, write=SetBoolean, index=3, default=0};
	__property Vcl::Graphics::TPen* LineStyle = {read=FLineStyle, write=SetLineStyle};
	__property Lmdsbar::TLMDScrollBarObject* HorizScrollBar = {read=FHScrollObj, write=SetScrollObj, index=0};
	__property Lmdsbar::TLMDScrollBarObject* VertScrollBar = {read=FVScrollObj, write=SetScrollObj, index=1};
	__property TLMDOnMarginRowPaint OnMarginRowPaint = {read=FOnMarginRowPaint, write=FOnMarginRowPaint};
	__property System::Classes::TNotifyEvent OnCurrentRowChanged = {read=FOnRowChange, write=FOnRowChange};
	__property System::Classes::TNotifyEvent OnRowCountChanged = {read=FOnRowCountChange, write=FOnRowCountChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomMemo(HWND ParentWindow) : Lmdbaseedit::TLMDBaseEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Byte LMDMaxVisibleLines = System::Byte(0x96);
}	/* namespace Lmdcustommemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMMEMO)
using namespace Lmdcustommemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustommemoHPP
