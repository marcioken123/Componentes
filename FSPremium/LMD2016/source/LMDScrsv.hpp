// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDScrsv.pas' rev: 31.00 (Windows)

#ifndef LmdscrsvHPP
#define LmdscrsvHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Win.Registry.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdscrsv
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScreenSaver;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDScreenSaverMode : unsigned char { sscfgNoParent, sscfgParent, ssfullView, ssPreview, ssCheckPassword };

typedef void __fastcall (__closure *TLMDPWCheckEvent)(System::TObject* Sender, bool &CanClose);

class PASCALIMPLEMENTATION TLMDScreenSaver : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	System::Uitypes::TColor FColor;
	bool FNowClose;
	bool FSaveBack;
	System::Types::TPoint FPosition;
	System::UnicodeString FTitle;
	System::Win::Registry::TRegIniFile* FIniFile;
	System::UnicodeString FSection;
	System::Classes::TNotifyEvent FOnSetupDlg;
	System::Classes::TNotifyEvent FOnSaverStart;
	System::Classes::TNotifyEvent FOnSaverEnd;
	bool FEnabled;
	TLMDScreenSaverMode FMode;
	HWND FWndHandle;
	void __fastcall PrevInit(void);
	void __fastcall ChangePassWord(void);
	void __fastcall SaveBack(void);
	void __fastcall SaverInit(void);
	void __fastcall ParseArgs(void);
	void __fastcall Quit(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDScreenSaver(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDScreenSaver(void);
	bool __fastcall SaverClose(void);
	__property System::Win::Registry::TRegIniFile* Inifile = {read=FIniFile};
	__property System::UnicodeString Section = {read=FSection};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap};
	__property TLMDScreenSaverMode Mode = {read=FMode, nodefault};
	int __fastcall ShowDialog(Vcl::Forms::TForm* aForm);
	
__published:
	__property About = {default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=0};
	__property bool SaveBackground = {read=FSaveBack, write=FSaveBack, default=0};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::Classes::TNotifyEvent OnSetupDlg = {read=FOnSetupDlg, write=FOnSetupDlg};
	__property System::Classes::TNotifyEvent OnSaverStart = {read=FOnSaverStart, write=FOnSaverStart};
	__property System::Classes::TNotifyEvent OnSaverEnd = {read=FOnSaverEnd, write=FOnSaverEnd};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdscrsv */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCRSV)
using namespace Lmdscrsv;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdscrsvHPP
