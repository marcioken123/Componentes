// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormVista.pas' rev: 31.00 (Windows)

#ifndef LmdformvistaHPP
#define LmdformvistaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDSysIn.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformvista
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormVistaExtension;
class DELPHICLASS TLMDFormGlass;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormVistaExtension : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int FAppStyle;
	int FMainFrmStyle;
	System::UnicodeString FOldTitle;
	bool FEnabled;
	System::Classes::TNotifyEvent FOwnerFormShow;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall OwnerFormShow(System::TObject* Sender);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	void __fastcall Install(void);
	void __fastcall UnInstall(void);
	
public:
	__fastcall virtual TLMDFormVistaExtension(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormVistaExtension(void);
	void __fastcall ShowModalChildForm(Vcl::Forms::TCustomForm* const AForm);
	void __fastcall FixFonts(Vcl::Forms::TCustomForm* const AForm);
	
__published:
	__property About = {default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
};


class PASCALIMPLEMENTATION TLMDFormGlass : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	int FRight;
	int FBottom;
	int FTop;
	int FLeft;
	void __fastcall SetBottom(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetRight(const int Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall GlassRectChanged(void);
	void __fastcall GlassPaint(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetEnabled(bool aValue);
	
public:
	__fastcall virtual TLMDFormGlass(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property int TopMargin = {read=FTop, write=SetTop, nodefault};
	__property int LeftMargin = {read=FLeft, write=SetLeft, nodefault};
	__property int BottomMargin = {read=FBottom, write=SetBottom, nodefault};
	__property int RightMargin = {read=FRight, write=SetRight, nodefault};
public:
	/* TLMDWndProcComponent.Destroy */ inline __fastcall virtual ~TLMDFormGlass(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool LMDVistaSupportEnable;
}	/* namespace Lmdformvista */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMVISTA)
using namespace Lmdformvista;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformvistaHPP
