// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.ImagePoint.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_ImagepointHPP
#define Fmxtee_Series_ImagepointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Canvas.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Imagepoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomImagePointSeries;
class DELPHICLASS TImagePointSeries;
class DELPHICLASS TDeltaPointSeries;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TGetImageEvent)(TCustomImagePointSeries* Sender, int ValueIndex, Fmxtee::Canvas::TPicture* Picture);

class PASCALIMPLEMENTATION TCustomImagePointSeries : public Fmxtee::Series::TPointSeries
{
	typedef Fmxtee::Series::TPointSeries inherited;
	
private:
	bool FImageTransp;
	TGetImageEvent FOnGetImage;
	Fmxtee::Canvas::TTeePicture* IImage;
	Fmxtee::Canvas::TTeePicture* __fastcall GetImagePoint();
	void __fastcall SetImagePoint(Fmxtee::Canvas::TTeePicture* const Value);
	void __fastcall SetImageTransp(const bool Value);
	
protected:
	virtual void __fastcall DrawValue(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	virtual void __fastcall DrawLegend(int ValueIndex, const System::Types::TRectF &Rect);
	__property Fmxtee::Canvas::TTeePicture* ImagePoint = {read=GetImagePoint, write=SetImagePoint};
	__property bool ImageTransparent = {read=FImageTransp, write=SetImageTransp, default=0};
	__property TGetImageEvent OnGetImage = {read=FOnGetImage, write=FOnGetImage};
public:
	/* TPointSeries.Create */ inline __fastcall virtual TCustomImagePointSeries(System::Classes::TComponent* AOwner) : Fmxtee::Series::TPointSeries(AOwner) { }
	
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TCustomImagePointSeries() { }
	
};


class PASCALIMPLEMENTATION TImagePointSeries : public TCustomImagePointSeries
{
	typedef TCustomImagePointSeries inherited;
	
private:
	void __fastcall SetupFields();
	
public:
	__fastcall virtual TImagePointSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual TImagePointSeries(System::Classes::TComponent* AOwner, Fmxtee::Canvas::TTeePicture* Picture);
	
__published:
	__property ImagePoint;
	__property ImageTransparent = {default=1};
	__property OnGetImage;
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TImagePointSeries() { }
	
};


enum DECLSPEC_DENUM TDeltaImageStyle : unsigned char { disSmiles, disHands };

class PASCALIMPLEMENTATION TDeltaPointSeries : public TCustomImagePointSeries
{
	typedef TCustomImagePointSeries inherited;
	
private:
	Fmxtee::Canvas::TTeePicture* FEqualImage;
	Fmxtee::Canvas::TTeePicture* FGreaterImage;
	TDeltaImageStyle FImageStyle;
	Fmxtee::Canvas::TTeePicture* FLowerImage;
	void __fastcall CalculateImage(int ValueIndex);
	void __fastcall LoadImages();
	void __fastcall SetEqualImage(Fmxtee::Canvas::TTeePicture* const Value);
	void __fastcall SetGreaterImage(Fmxtee::Canvas::TTeePicture* const Value);
	void __fastcall SetImageStyle(const TDeltaImageStyle Value);
	void __fastcall SetLowerImage(Fmxtee::Canvas::TTeePicture* const Value);
	
protected:
	virtual void __fastcall DrawValue(int ValueIndex);
	
public:
	__fastcall virtual TDeltaPointSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDeltaPointSeries();
	virtual void __fastcall DrawLegend(int ValueIndex, const System::Types::TRectF &Rect);
	
__published:
	__property Fmxtee::Canvas::TTeePicture* EqualImage = {read=FEqualImage, write=SetEqualImage};
	__property Fmxtee::Canvas::TTeePicture* GreaterImage = {read=FGreaterImage, write=SetGreaterImage};
	__property TDeltaImageStyle ImageStyle = {read=FImageStyle, write=SetImageStyle, default=0};
	__property ImageTransparent = {default=0};
	__property Fmxtee::Canvas::TTeePicture* LowerImage = {read=FLowerImage, write=SetLowerImage};
	__property OnGetImage;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Imagepoint */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_IMAGEPOINT)
using namespace Fmxtee::Series::Imagepoint;
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
#endif	// Fmxtee_Series_ImagepointHPP
