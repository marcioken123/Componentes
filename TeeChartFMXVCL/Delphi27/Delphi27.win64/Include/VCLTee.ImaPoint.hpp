// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.ImaPoint.pas' rev: 34.00 (Windows)

#ifndef Vcltee_ImapointHPP
#define Vcltee_ImapointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Imapoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomImagePointSeries;
class DELPHICLASS TImagePointSeries;
class DELPHICLASS TDeltaPointSeries;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TGetImageEvent)(TCustomImagePointSeries* Sender, int ValueIndex, Vcl::Graphics::TPicture* Picture);

class PASCALIMPLEMENTATION TCustomImagePointSeries : public Vcltee::Series::TPointSeries
{
	typedef Vcltee::Series::TPointSeries inherited;
	
private:
	bool FImageTransp;
	TGetImageEvent FOnGetImage;
	Vcltee::Tecanvas::TTeePicture* IImage;
	Vcltee::Tecanvas::TTeePicture* __fastcall GetImagePoint();
	void __fastcall SetImagePoint(Vcltee::Tecanvas::TTeePicture* const Value);
	void __fastcall SetImageTransp(const bool Value);
	
protected:
	virtual void __fastcall DrawValue(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	virtual void __fastcall DrawLegend(int ValueIndex, const System::Types::TRect &Rect);
	__property Vcltee::Tecanvas::TTeePicture* ImagePoint = {read=GetImagePoint, write=SetImagePoint};
	__property bool ImageTransparent = {read=FImageTransp, write=SetImageTransp, default=0};
	__property TGetImageEvent OnGetImage = {read=FOnGetImage, write=FOnGetImage};
public:
	/* TPointSeries.Create */ inline __fastcall virtual TCustomImagePointSeries(System::Classes::TComponent* AOwner) : Vcltee::Series::TPointSeries(AOwner) { }
	
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
	__fastcall virtual TImagePointSeries(System::Classes::TComponent* AOwner, Vcltee::Tecanvas::TTeePicture* Picture);
	
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
	Vcltee::Tecanvas::TTeePicture* FEqualImage;
	Vcltee::Tecanvas::TTeePicture* FGreaterImage;
	TDeltaImageStyle FImageStyle;
	Vcltee::Tecanvas::TTeePicture* FLowerImage;
	void __fastcall CalculateImage(int ValueIndex);
	void __fastcall LoadImages();
	void __fastcall SetEqualImage(Vcltee::Tecanvas::TTeePicture* const Value);
	void __fastcall SetGreaterImage(Vcltee::Tecanvas::TTeePicture* const Value);
	void __fastcall SetImageStyle(const TDeltaImageStyle Value);
	void __fastcall SetLowerImage(Vcltee::Tecanvas::TTeePicture* const Value);
	
protected:
	virtual void __fastcall DrawValue(int ValueIndex);
	
public:
	__fastcall virtual TDeltaPointSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDeltaPointSeries();
	virtual void __fastcall DrawLegend(int ValueIndex, const System::Types::TRect &Rect);
	
__published:
	__property Vcltee::Tecanvas::TTeePicture* EqualImage = {read=FEqualImage, write=SetEqualImage};
	__property Vcltee::Tecanvas::TTeePicture* GreaterImage = {read=FGreaterImage, write=SetGreaterImage};
	__property TDeltaImageStyle ImageStyle = {read=FImageStyle, write=SetImageStyle, default=0};
	__property ImageTransparent = {default=0};
	__property Vcltee::Tecanvas::TTeePicture* LowerImage = {read=FLowerImage, write=SetLowerImage};
	__property OnGetImage;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Imapoint */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_IMAPOINT)
using namespace Vcltee::Imapoint;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_ImapointHPP
