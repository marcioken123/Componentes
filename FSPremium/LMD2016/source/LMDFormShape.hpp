// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormShape.pas' rev: 31.00 (Windows)

#ifndef LmdformshapeHPP
#define LmdformshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ImgList.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDFillObject.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDRegion.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormShape : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	Lmdregion::TLMDBorderRegion* FRegion;
	HRGN FRegionHandle;
	bool FRegioning;
	bool FUseRgnBitmap;
	bool FRightMouseBtn;
	bool FFormDragable;
	bool FFormCaption;
	Lmdfillobject::TLMDFillObject* FFillObject;
	Vcl::Graphics::TBitmap* FBack;
	System::Types::TRect RegionRect;
	int FListIndex;
	int FImageIndex;
	int FCaptionH;
	Vcl::Imglist::TChangeLink* FChangeLink;
	Vcl::Imglist::TCustomImageList* FImageList;
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetRegion(Lmdregion::TLMDBorderRegion* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	void __fastcall GetIMLChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDFormShape(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDFormShape(void);
	Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	HPALETTE __fastcall BackBitmapPalette(void);
	bool __fastcall BackBitmapCheck(void);
	System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags);
	bool __fastcall isTransparentSet(void);
	void __fastcall BackUpdate(void);
	Vcl::Controls::TControl* __fastcall BackControl(int index);
	int __fastcall BackControlCount(void);
	void __fastcall SetPolygonShape(const System::Types::TPoint *points, const int points_High);
	void __fastcall SetRegionShape(HRGN region);
	void __fastcall SetBitmapShape(Vcl::Graphics::TBitmap* aBitmap, System::Uitypes::TColor aTransparentColor);
	void __fastcall PaintBorder(HDC DC);
	void __fastcall ReRegion(void);
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property Lmdregion::TLMDBorderRegion* Region = {read=FRegion, write=SetRegion};
	__property bool ShowFormCaption = {read=FFormCaption, write=SetBoolean, index=0, default=1};
	__property bool FormDragable = {read=FFormDragable, write=SetBoolean, index=1, default=1};
	__property bool UseRgnBitmap = {read=FUseRgnBitmap, write=SetBoolean, index=2, default=1};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ListIndex = {read=FListIndex, write=SetInteger, index=0, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetInteger, index=1, default=0};
private:
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0068598D-C5C6-488F-8E00-D813525C9163}
	operator Intflmdbackground::_di_ILMDBackground()
	{
		Intflmdbackground::_di_ILMDBackground intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbackground::ILMDBackground*(void) { return (Intflmdbackground::ILMDBackground*)&__ILMDBackground; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMSHAPE)
using namespace Lmdformshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformshapeHPP
