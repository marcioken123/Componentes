// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomFormFill.pas' rev: 31.00 (Windows)

#ifndef LmdcustomformfillHPP
#define LmdcustomformfillHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBaseController.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCont.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomformfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomFormFill;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPaintMode : unsigned char { pcNone, pcControl, pcOwnerDraw };

typedef void __fastcall (__closure *TLMDPaintEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &Dest);

class PASCALIMPLEMENTATION TLMDCustomFormFill : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	bool FDefaultFill;
	TLMDPaintMode FPaintMode;
	TLMDPaintEvent FOnPaint;
	bool FBuffered;
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	void __fastcall SetPaintMode(TLMDPaintMode aValue);
	
protected:
	bool FFlag;
	bool EraseBack;
	Vcl::Graphics::TBitmap* FBack;
	bool __fastcall IMLEmpty(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Init(void);
	void __fastcall DestroyBuffer(void);
	void __fastcall Invalidate(bool flag);
	virtual bool __fastcall PaintClientArea(HDC DC);
	virtual void __fastcall RestoreState(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property bool Buffered = {read=FBuffered, write=FBuffered, default=0};
	
public:
	__fastcall virtual TLMDCustomFormFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomFormFill(void);
	Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	bool __fastcall BackBitmapCheck(void);
	bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags);
	bool __fastcall isTransparentSet(void);
	System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	HPALETTE __fastcall BackBitmapPalette(void);
	void __fastcall BackUpdate(void);
	Vcl::Controls::TControl* __fastcall BackControl(int index);
	int __fastcall BackControlCount(void);
	
__published:
	__property About = {default=0};
	__property bool DefaultFill = {read=FDefaultFill, write=FDefaultFill, default=1};
	__property Enabled = {default=1};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	__property TLMDPaintMode PaintMode = {read=FPaintMode, write=SetPaintMode, default=1};
	__property TLMDPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
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
}	/* namespace Lmdcustomformfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMFORMFILL)
using namespace Lmdcustomformfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomformfillHPP
