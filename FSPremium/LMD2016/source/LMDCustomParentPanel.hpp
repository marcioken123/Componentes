// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomParentPanel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomparentpanelHPP
#define LmdcustomparentpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomparentpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomParentPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomParentPanel : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	bool FQuickDraw;
	bool FFDSupport;
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	MESSAGE void __fastcall CMLMDBackChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetFDSupport(const bool Value);
	
protected:
	Vcl::Graphics::TBitmap* FBack;
	virtual bool __fastcall CheckOptimized(void);
	virtual void __fastcall CreateBack(bool aValue);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoForwardBackFX(void);
	void __fastcall DrawBack(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &aRect);
	virtual void __fastcall FillControl(void);
	bool __fastcall FormDispSupport(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomParentPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomParentPanel(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
	virtual void __fastcall BackUpdate(void);
	__property bool Empty = {read=GetEmpty, nodefault};
	__property bool QuickDraw = {read=FQuickDraw, write=FQuickDraw, default=0};
	__property bool FDSupport = {read=FFDSupport, write=SetFDSupport, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomParentPanel(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomparentpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPARENTPANEL)
using namespace Lmdcustomparentpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomparentpanelHPP
