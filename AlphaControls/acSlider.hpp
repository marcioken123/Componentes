// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acSlider.pas' rev: 27.00 (Windows)

#ifndef AcsliderHPP
#define AcsliderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acslider
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TacSliderChangeEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TacOnChangingEvent)(System::TObject* Sender, bool &CanChange);

enum DECLSPEC_DENUM TControlOrientation : unsigned char { coHorizontal, coVertical };

class DELPHICLASS TsSlider;
class PASCALIMPLEMENTATION TsSlider : public Spanel::TsPanel
{
	typedef Spanel::TsPanel inherited;
	
private:
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Spanel::TsPanel* FButton;
	System::Types::TPoint MouseDownSpot;
	bool Capturing;
	bool Dragged;
	bool FSliderOn;
	TacSliderChangeEvent FOnSliderChange;
	System::UnicodeString FSliderCaptionOn;
	System::UnicodeString FSliderCaptionOff;
	TControlOrientation FOrientation;
	System::Uitypes::TImageIndex FImageIndexOff;
	System::Uitypes::TImageIndex FImageIndexOn;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Graphics::TFont* FFontOn;
	Scommondata::TsBoundLabel* FBoundLabel;
	bool FShowCaption;
	TacOnChangingEvent FOnChanging;
	void __fastcall SetSliderOn(const bool Value);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall FontOnChange(System::TObject* Sender);
	void __fastcall UpdateButton(void);
	void __fastcall SetSliderCaptionOff(const System::UnicodeString Value);
	void __fastcall SetSliderCaptionOn(const System::UnicodeString Value);
	void __fastcall SetSliderCursor(const System::Uitypes::TCursor Value);
	System::Uitypes::TCursor __fastcall GetSliderCursor(void);
	void __fastcall SetOrientation(const TControlOrientation Value);
	void __fastcall SetImageIndexOff(const System::Uitypes::TImageIndex Value);
	void __fastcall SetImageIndexOn(const System::Uitypes::TImageIndex Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetFontOn(Vcl::Graphics::TFont* const Value);
	HIDESBASE void __fastcall SetShowCaption(const bool Value);
	
protected:
	bool __fastcall CanChange(void);
	void __fastcall UpdateSize(void);
	void __fastcall UpdateBtnFont(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	void __fastcall ChangeValueAnim(void);
	void __fastcall ButtonMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ButtonMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ButtonMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ButtonPaint(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas);
	void __fastcall UpdateThumbSkin(void);
	
public:
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TsSlider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSlider(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall PrepareCache(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property BevelOuter = {default=1};
	__property Height = {default=21};
	__property Width = {default=57};
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property TControlOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property System::Uitypes::TImageIndex ImageIndexOff = {read=FImageIndexOff, write=SetImageIndexOff, default=-1};
	__property System::Uitypes::TImageIndex ImageIndexOn = {read=FImageIndexOn, write=SetImageIndexOn, default=-1};
	__property Vcl::Graphics::TFont* FontOn = {read=FFontOn, write=SetFontOn};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property System::Uitypes::TCursor SliderCursor = {read=GetSliderCursor, write=SetSliderCursor, default=0};
	__property bool SliderOn = {read=FSliderOn, write=SetSliderOn, default=1};
	__property System::UnicodeString SliderCaptionOn = {read=FSliderCaptionOn, write=SetSliderCaptionOn};
	__property System::UnicodeString SliderCaptionOff = {read=FSliderCaptionOff, write=SetSliderCaptionOff};
	__property TacOnChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TacSliderChangeEvent OnSliderChange = {read=FOnSliderChange, write=FOnSliderChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsSlider(HWND ParentWindow) : Spanel::TsPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acslider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACSLIDER)
using namespace Acslider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcsliderHPP
