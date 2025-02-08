// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAlphaObject.pas' rev: 31.00 (Windows)

#ifndef LmdalphaobjectHPP
#define LmdalphaobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDBaseController.hpp>
#include <LMDBmp.hpp>
#include <LMDCont.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDObject.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdalphaobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAlphaObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAlphaObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	float FStrength;
	int FImageIndex;
	int FListIndex;
	bool FTransparent;
	Lmdfillobject::TLMDFillObject* FFillObject;
	Vcl::Imglist::TChangeLink* FChangeLink;
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetSingle(float aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall GetIMLChange(System::TObject* Sender);
	bool __fastcall IMLEmpty(void);
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	bool __fastcall HasNonDefaultStrength(void);
	__property bool Transparent = {read=FTransparent, write=SetBoolean, index=0, default=0};
	
public:
	__fastcall virtual TLMDAlphaObject(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDAlphaObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	bool __fastcall Enabled(void);
	HPALETTE __fastcall GetPalette(void);
	void __fastcall AlphaBlend(Vcl::Graphics::TBitmap* Target);
	void __fastcall ControlBlend(Vcl::Graphics::TBitmap* OriginalBack, const System::Types::TRect &ControlsRect, const System::Types::TRect &DestinationRect, Vcl::Graphics::TCanvas* Target, const System::Types::TRect &Src);
	
__published:
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FImageIndex, write=SetInteger, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetInteger, index=1, default=0};
	__property float Strength = {read=FStrength, write=SetSingle, stored=HasNonDefaultStrength};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdalphaobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDALPHAOBJECT)
using namespace Lmdalphaobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdalphaobjectHPP
