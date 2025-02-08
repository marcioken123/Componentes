// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImagePrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdimageprinttaskHPP
#define LmdimageprinttaskHPP

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
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDPageLayout.hpp>
#include <LMDSimpleRectPageLayout.hpp>
#include <LMDLayoutRenderPrintTask.hpp>
#include <LMDDocElementRenderer.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimageprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomImagePrintTask;
class DELPHICLASS TLMDImagePrintTask;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDImagePrintMode : unsigned char { ipmAsIs, ipmFitToPage, ipmFixedSize, ipmFixedPageCount };

class PASCALIMPLEMENTATION TLMDCustomImagePrintTask : public Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask
{
	typedef Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask inherited;
	
private:
	double FFixedSizeX;
	double FFixedSizeY;
	int FMaxPagesCountY;
	int FMaxPagesCountX;
	TLMDImagePrintMode FDrawingMode;
	bool FStretch;
	bool FKeepRatio;
	Vcl::Graphics::TPixelFormat FPixelFormat;
	void __fastcall SetPixelFormat(const Vcl::Graphics::TPixelFormat Value);
	
protected:
	Vcl::Graphics::TBitmap* FPicture;
	virtual void __fastcall CreateLayoutManager(void);
	virtual void __fastcall ConstructDocument(void);
	void __fastcall SetImageSize(Lmddocmodel::TLMDDocImage* ADocImage, int APagesX, int APagesY);
	virtual void __fastcall SetExpectedPictureSize(void);
	virtual void __fastcall RenderTargetPicture(void);
	
__published:
	__property About = {default=0};
	__property TLMDImagePrintMode DrawingMode = {read=FDrawingMode, write=FDrawingMode, default=0};
	__property Vcl::Graphics::TPixelFormat PixelFormat = {read=FPixelFormat, write=SetPixelFormat, default=0};
	__property bool Stretch = {read=FStretch, write=FStretch, default=0};
	__property bool KeepRatio = {read=FKeepRatio, write=FKeepRatio, default=0};
	__property double FixedSizeX = {read=FFixedSizeX, write=FFixedSizeX};
	__property double FixedSizeY = {read=FFixedSizeY, write=FFixedSizeY};
	__property int MaxPagesCountX = {read=FMaxPagesCountX, write=FMaxPagesCountX, default=0};
	__property int MaxPagesCountY = {read=FMaxPagesCountY, write=FMaxPagesCountY, default=0};
public:
	/* TLMDCustomPrintTask.Create */ inline __fastcall virtual TLMDCustomImagePrintTask(System::Classes::TComponent* AOwner) : Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask(AOwner) { }
	/* TLMDCustomPrintTask.Destroy */ inline __fastcall virtual ~TLMDCustomImagePrintTask(void) { }
	
};


class PASCALIMPLEMENTATION TLMDImagePrintTask : public TLMDCustomImagePrintTask
{
	typedef TLMDCustomImagePrintTask inherited;
	
__published:
	void __fastcall SetPicture(Vcl::Graphics::TBitmap* const Value);
	
public:
	__fastcall virtual TLMDImagePrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDImagePrintTask(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Picture = {read=FPicture, write=SetPicture};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimageprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGEPRINTTASK)
using namespace Lmdimageprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimageprinttaskHPP
