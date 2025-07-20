// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Organizational.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_OrganizationalHPP
#define Fmxtee_Series_OrganizationalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Constants.hpp>
#include <FMXTee.Procs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Organizational
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOrgShape;
class DELPHICLASS TOrgItem;
class DELPHICLASS TOrgItemCollection;
class DELPHICLASS TSpacing;
class DELPHICLASS TCustomOrgSeries;
class DELPHICLASS TOrgSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOrgShape : public Fmxtee::Chart::TTextShape
{
	typedef Fmxtee::Chart::TTextShape inherited;
	
private:
	Fmxtee::Engine::TChartSeries* IOwner;
	
public:
	virtual void __fastcall Repaint();
	
__published:
	__property CustomPosition = {default=1};
	__property Left = {stored=false};
	__property Top = {stored=false};
	__property Text = {stored=false, default=0};
	__property TextAlignment = {default=2};
public:
	/* TCustomTextShape.Create */ inline __fastcall virtual TOrgShape(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */ : Fmxtee::Chart::TTextShape(AOwner) { }
	/* TCustomTextShape.Destroy */ inline __fastcall virtual ~TOrgShape() { }
	
};


class PASCALIMPLEMENTATION TOrgItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TOrgShape* __fastcall GetFormat();
	int __fastcall GetHeight();
	int __fastcall GetSuperior();
	System::UnicodeString __fastcall GetText();
	int __fastcall GetWidth();
	void __fastcall SetFormat(TOrgShape* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetSuperior(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	TOrgShape* FFormat;
	int NumTextLines;
	TOrgShape* __fastcall ActiveFormat();
	bool __fastcall HasFormat();
	
public:
	System::Types::TRectF ShapeBounds;
	__fastcall virtual ~TOrgItem();
	TOrgItem* __fastcall AddChild(const System::UnicodeString Text);
	TOrgItem* __fastcall AddBrother(const System::UnicodeString Text);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall Level();
	TOrgItem* __fastcall Parent();
	void __fastcall RemoveFormat();
	TCustomOrgSeries* __fastcall Series();
	
__published:
	__property TOrgShape* Format = {read=GetFormat, write=SetFormat, stored=HasFormat};
	__property int Height = {read=GetHeight, write=SetHeight, stored=false, nodefault};
	__property int Superior = {read=GetSuperior, write=SetSuperior, stored=false, nodefault};
	__property System::UnicodeString Text = {read=GetText, write=SetText, stored=false};
	__property int Width = {read=GetWidth, write=SetWidth, stored=false, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TOrgItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};


class PASCALIMPLEMENTATION TOrgItemCollection : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TOrgItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TOrgItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TOrgItem* const Value);
	
public:
	__property TOrgItem* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TOrgItemCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TOrgItemCollection() { }
	
};


class PASCALIMPLEMENTATION TSpacing : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FVert;
	int FHoriz;
	Fmxtee::Engine::TChartSeries* ISeries;
	void __fastcall SetHoriz(const int Value);
	void __fastcall SetVert(const int Value);
	
public:
	__fastcall TSpacing();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Horizontal = {read=FHoriz, write=SetHoriz, default=8};
	__property int Vertical = {read=FVert, write=SetVert, default=16};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSpacing() { }
	
};


enum DECLSPEC_DENUM TOrgLineStyle : unsigned char { lsSquared, lsDiagonal };

class PASCALIMPLEMENTATION TCustomOrgSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
public:
	TOrgItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TOrgShape* FDefault;
	TOrgItemCollection* FNodes;
	TSpacing* FSpacing;
	TOrgItem* __fastcall GetItem(int Index);
	void __fastcall SetDefault(TOrgShape* const Value);
	void __fastcall SetItem(int Index, TOrgItem* const Value);
	void __fastcall SetNodes(TOrgItemCollection* const Value);
	void __fastcall SetSpacing(TSpacing* const Value);
	
protected:
	System::Types::TRectF IBounds;
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	void __fastcall AutoSizeNodes();
	virtual bool __fastcall CheckMouse(int x, int y);
	virtual void __fastcall ClearLists();
	virtual Fmxtee::Engine::TIntArray __fastcall GetChilds(int Superior, bool VisibleOnly);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TCustomOrgSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomOrgSeries();
	HIDESBASE int __fastcall Add(const System::UnicodeString Text, int Superior = 0xffffffff)/* overload */;
	virtual int __fastcall AddXY(const double AXValue, const double AYValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual void __fastcall Delete(int ValueIndex)/* overload */;
	int __fastcall FirstChild(int ValueIndex);
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	int __fastcall MaxLevels();
	DYNAMIC void __fastcall SwapValueIndex(int a, int b);
	virtual bool __fastcall UseAxis();
	__property System::Types::TRectF Bounds = {read=IBounds};
	__property TOrgItem* Item[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TOrgShape* Format = {read=FDefault, write=SetDefault};
	__property TOrgItemCollection* Items = {read=FNodes, write=SetNodes, stored=IsDataStored};
	__property TSpacing* Spacing = {read=FSpacing, write=SetSpacing};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	inline void __fastcall  Delete(int Start, int Quantity, bool RemoveGap = false){ Fmxtee::Engine::TChartSeries::Delete(Start, Quantity, RemoveGap); }
	
};


class PASCALIMPLEMENTATION TOrgSeries : public TCustomOrgSeries
{
	typedef TCustomOrgSeries inherited;
	
private:
	TOrgLineStyle FLineStyle;
	void __fastcall SetLineStyle(const TOrgLineStyle Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
__published:
	__property TOrgLineStyle LineStyle = {read=FLineStyle, write=SetLineStyle, default=0};
	__property ShowInLegend = {default=0};
	__property Format;
	__property Items;
	__property Spacing;
	__property XValues;
	__property YValues;
	__property Active = {default=1};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property Title = {default=0};
	__property Transparency = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property Brush;
	__property Pen;
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnGetMarkText;
	__property OnMouseEnter;
	__property OnMouseLeave;
public:
	/* TCustomOrgSeries.Create */ inline __fastcall virtual TOrgSeries(System::Classes::TComponent* AOwner) : TCustomOrgSeries(AOwner) { }
	/* TCustomOrgSeries.Destroy */ inline __fastcall virtual ~TOrgSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Organizational */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ORGANIZATIONAL)
using namespace Fmxtee::Series::Organizational;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_OrganizationalHPP
