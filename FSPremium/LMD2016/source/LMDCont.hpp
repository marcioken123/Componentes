// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCont.pas' rev: 31.00 (Windows)

#ifndef LmdcontHPP
#define LmdcontHPP

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
#include <Vcl.Consts.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraphicList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBitmapList.hpp>
#include <LMDImageList.hpp>
#include <LMDWaveList.hpp>
#include <LMDStringList.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseController.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcont
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDContainer;
class DELPHICLASS TLMDContainerCtrl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDContainer : public Lmdbasecontroller::TLMDBaseController
{
	typedef Lmdbasecontroller::TLMDBaseController inherited;
	
private:
	Lmdbitmaplist::TLMDBitmapList* FBitmapList;
	Lmdimagelist::TLMDImageList* FImageList;
	Lmdwavelist::TLMDWaveList* FWaveList;
	Lmdstringlist::TLMDStringList* FStringList;
	void __fastcall SetBitmapList(Lmdbitmaplist::TLMDBitmapList* aValue);
	void __fastcall SetImageList(Lmdimagelist::TLMDImageList* aValue);
	void __fastcall SetStringList(Lmdstringlist::TLMDStringList* aValue);
	void __fastcall SetWaveList(Lmdwavelist::TLMDWaveList* aValue);
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDContainer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDContainer(void);
	__property Lmdbitmaplist::TLMDBitmapList* BitmapList = {read=FBitmapList, write=SetBitmapList};
	__property Lmdimagelist::TLMDImageList* ImageList = {read=FImageList, write=SetImageList};
	__property Lmdstringlist::TLMDStringList* StringList = {read=FStringList, write=SetStringList};
	__property Lmdwavelist::TLMDWaveList* WaveList = {read=FWaveList, write=SetWaveList};
};


class PASCALIMPLEMENTATION TLMDContainerCtrl : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDContainer* FContainer;
	System::Byte FInternal;
	void __fastcall ReadStream(System::Classes::TStream* Stream);
	void __fastcall WriteStream(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDContainerCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDContainerCtrl(void);
	__property TLMDContainer* Container = {read=FContainer};
	
__published:
	__property About = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString LMD_ICGLOBALBML;
extern DELPHI_PACKAGE System::UnicodeString LMD_ICGLOBALIML;
extern DELPHI_PACKAGE TLMDContainer* LMDContainer;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDIMLGetColorAtPoint(Vcl::Imglist::TCustomImageList* aList, const System::Types::TPoint &aPoint, int ListIndex, int ItemIndex);
extern DELPHI_PACKAGE void __fastcall LMDIMLClipDraw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int pos, System::Uitypes::TColor transColor, Vcl::Imglist::TCustomImageList* aList, int ListIndex, int index);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDIMLDrawExt(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, Vcl::Imglist::TCustomImageList* aList, int ListIndex, int Index);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDIMLTransparentColor(Vcl::Imglist::TCustomImageList* aList, int ListIndex, int ImageIndex = 0x0);
extern DELPHI_PACKAGE HPALETTE __fastcall LMDIMLPalette(Vcl::Imglist::TCustomImageList* aList, int ListIndex);
extern DELPHI_PACKAGE bool __fastcall LMDIMLIsValidItem(Vcl::Imglist::TCustomImageList* aList, int ListIndex, int ImageIndex);
extern DELPHI_PACKAGE void __fastcall LMDIMLItemBitmap(Vcl::Imglist::TCustomImageList* aList, int ListIndex, int ImageIndex, Vcl::Graphics::TBitmap* tmp);
extern DELPHI_PACKAGE void __fastcall LMDIMLItemIcon(Vcl::Imglist::TCustomImageList* aList, int ListIndex, int ImageIndex, Vcl::Graphics::TIcon* tmp);
extern DELPHI_PACKAGE int __fastcall LMDIMLItemWidth(Vcl::Imglist::TCustomImageList* aList, int ListIndex);
extern DELPHI_PACKAGE int __fastcall LMDIMLItemHeight(Vcl::Imglist::TCustomImageList* aList, int ListIndex);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDIMLItemRect(Vcl::Imglist::TCustomImageList* aList, int ListIndex, int ImageIndex);
extern DELPHI_PACKAGE int __fastcall LMDIMLCount(Vcl::Imglist::TCustomImageList* aList, int ListIndex = 0xffffffff);
extern DELPHI_PACKAGE bool __fastcall LMDIMLMasked(Vcl::Imglist::TCustomImageList* aList, int ListIndex);
extern DELPHI_PACKAGE void __fastcall LMDWriteGlobalIdent(System::Classes::TWriter* Writer, Vcl::Imglist::TCustomImageList* aList);
extern DELPHI_PACKAGE Lmdcustomimagelist::TLMDCustomImageList* __fastcall LMDReadGlobalIdent(System::Classes::TReader* Reader);
extern DELPHI_PACKAGE bool __fastcall LMDIsGlobalIdent(Vcl::Imglist::TCustomImageList* aList);
extern DELPHI_PACKAGE bool __fastcall LMDIsSingleItemImageList(Vcl::Imglist::TCustomImageList* aList);
extern DELPHI_PACKAGE bool __fastcall LMDIsCollectionImageList(Vcl::Imglist::TCustomImageList* aList);
}	/* namespace Lmdcont */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONT)
using namespace Lmdcont;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcontHPP
