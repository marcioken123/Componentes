// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acImage.pas' rev: 27.00 (Windows)

#ifndef AcimageHPP
#define AcimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acimage
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCustomImage;
class PASCALIMPLEMENTATION TsCustomImage : public Vcl::Extctrls::TImage
{
	typedef Vcl::Extctrls::TImage inherited;
	
private:
	bool FGrayed;
	bool FReflected;
	Sconst::TPercent FBlend;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	int FImageIndex;
	Vcl::Imglist::TCustomImageList* FImages;
	Scommondata::TsCtrlSkinData* FCommonData;
	bool FUseFullSize;
	void __fastcall SetBlend(const Sconst::TPercent Value);
	void __fastcall SetGrayed(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetReflected(const bool Value);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall SetUseFullSize(const bool Value);
	
protected:
	bool ImageChanged;
	Vcl::Graphics::TBitmap* FImage;
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	bool __fastcall OwnDrawing(void);
	bool __fastcall PrepareCache(HDC DC);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	__fastcall virtual TsCustomImage(System::Classes::TComponent* AOwner);
	void __fastcall UpdateImage(void);
	bool __fastcall Empty(void);
	__fastcall virtual ~TsCustomImage(void);
	MESSAGE void __fastcall acWM_PAINT(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property Sconst::TPercent Blend = {read=FBlend, write=SetBlend, default=0};
	__property bool UseFullSize = {read=FUseFullSize, write=SetUseFullSize, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property bool Grayed = {read=FGrayed, write=SetGrayed, default=0};
	__property bool Reflected = {read=FReflected, write=SetReflected, default=0};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
};


class DELPHICLASS TsImage;
class PASCALIMPLEMENTATION TsImage : public TsCustomImage
{
	typedef TsCustomImage inherited;
	
__published:
	__property Picture;
	__property Blend = {default=0};
	__property ImageIndex = {default=-1};
	__property Images;
	__property Grayed = {default=0};
	__property Reflected = {default=0};
	__property SkinData;
	__property UseFullSize = {default=0};
public:
	/* TsCustomImage.Create */ inline __fastcall virtual TsImage(System::Classes::TComponent* AOwner) : TsCustomImage(AOwner) { }
	/* TsCustomImage.Destroy */ inline __fastcall virtual ~TsImage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACIMAGE)
using namespace Acimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcimageHPP
