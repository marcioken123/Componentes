// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolLists.pas' rev: 4.00

#ifndef CoolListsHPP
#define CoolListsHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coollists
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TIntegerList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIntegerList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TList* FList;
	bool FSorted;
	Classes::TNotifyEvent FOnChange;
	void __fastcall WriteIntegers(Classes::TWriter* Writer);
	void __fastcall ReadIntegers(Classes::TReader* Reader);
	void __fastcall SetSorted(bool Value);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	int __fastcall GetCount(void);
	int __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, int Value);
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TIntegerList(void);
	__fastcall virtual ~TIntegerList(void);
	virtual void __fastcall Add(int Value);
	virtual void __fastcall AddIntegers(TIntegerList* Value);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(int Value);
	virtual void __fastcall Insert(int Index, int Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	virtual void __fastcall Sort(Classes::TListSortCompare Compare);
	__property int Count = {read=GetCount, nodefault};
	__property int Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};

#pragma pack(pop)

class DELPHICLASS TPointList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TPointList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TList* FList;
	Classes::TNotifyEvent FOnChange;
	void __fastcall WritePoints(Classes::TWriter* Writer);
	void __fastcall ReadPoints(Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	int __fastcall GetCount(void);
	Windows::TPoint __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const Windows::TPoint &Value);
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TPointList(void);
	__fastcall virtual ~TPointList(void);
	virtual void __fastcall Add(const Windows::TPoint &Value);
	virtual void __fastcall AddPoints(TPointList* Value);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(const Windows::TPoint &Value);
	virtual void __fastcall Insert(int Index, const Windows::TPoint &Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	__property int Count = {read=GetCount, nodefault};
	__property Windows::TPoint Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};

#pragma pack(pop)

class DELPHICLASS TRectList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TRectList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TList* FList;
	Classes::TNotifyEvent FOnChange;
	void __fastcall WriteRects(Classes::TWriter* Writer);
	void __fastcall ReadRects(Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	int __fastcall GetCount(void);
	Windows::TRect __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const Windows::TRect &Value);
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TRectList(void);
	__fastcall virtual ~TRectList(void);
	virtual void __fastcall Add(const Windows::TRect &Value);
	virtual void __fastcall AddRects(TRectList* Value);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(const Windows::TRect &Value);
	virtual void __fastcall Insert(int Index, const Windows::TRect &Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	__property int Count = {read=GetCount, nodefault};
	__property Windows::TRect Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};

#pragma pack(pop)

typedef Graphics::TColor *PColor;

class DELPHICLASS TColorList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TColorList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TList* FList;
	Classes::TNotifyEvent FOnChange;
	void __fastcall WriteColors(Classes::TWriter* Writer);
	void __fastcall ReadColors(Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	int __fastcall GetCount(void);
	Graphics::TColor __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, Graphics::TColor Value);
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TColorList(void);
	__fastcall virtual ~TColorList(void);
	virtual void __fastcall Add(Graphics::TColor Value);
	virtual void __fastcall AddColors(TColorList* Value);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(Graphics::TColor Value);
	virtual void __fastcall Insert(int Index, Graphics::TColor Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	__property int Count = {read=GetCount, nodefault};
	__property Graphics::TColor Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};

#pragma pack(pop)

struct TPixelData;
typedef TPixelData *PPixelData;

#pragma pack(push, 1)
struct TPixelData
{
	Graphics::TColor Color;
	int X;
	int Y;
} ;
#pragma pack(pop)

class DELPHICLASS TPixelDataList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TPixelDataList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TList* FList;
	Classes::TNotifyEvent FOnChange;
	void __fastcall WritePixelDatas(Classes::TWriter* Writer);
	void __fastcall ReadPixelDatas(Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	int __fastcall GetCount(void);
	TPixelData __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const TPixelData &Value);
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TPixelDataList(void);
	__fastcall virtual ~TPixelDataList(void);
	virtual void __fastcall Add(const TPixelData &Value);
	virtual void __fastcall AddPixelDatas(TPixelDataList* Value);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(const TPixelData &Value);
	virtual void __fastcall Insert(int Index, const TPixelData &Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	__property int Count = {read=GetCount, nodefault};
	__property TPixelData Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coollists */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coollists;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolLists
