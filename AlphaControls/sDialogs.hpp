// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sDialogs.pas' rev: 27.00 (Windows)

#ifndef SdialogsHPP
#define SdialogsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.ExtDlgs.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdialogs
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsZipShowing : unsigned char { zsAsFolder, zsAsFile };

class DELPHICLASS TsOpenDialog;
class PASCALIMPLEMENTATION TsOpenDialog : public Vcl::Dialogs::TOpenDialog
{
	typedef Vcl::Dialogs::TOpenDialog inherited;
	
private:
	TsZipShowing FZipShowing;
	
public:
	__fastcall virtual TsOpenDialog(System::Classes::TComponent* AOwner);
	
__published:
	__property TsZipShowing ZipShowing = {read=FZipShowing, write=FZipShowing, default=0};
public:
	/* TOpenDialog.Destroy */ inline __fastcall virtual ~TsOpenDialog(void) { }
	
};


class DELPHICLASS TsOpenPictureDialog;
class PASCALIMPLEMENTATION TsOpenPictureDialog : public Vcl::Extdlgs::TOpenPictureDialog
{
	typedef Vcl::Extdlgs::TOpenPictureDialog inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	HIDESBASE bool __fastcall IsFilterStored(void);
	
public:
	__fastcall virtual TsOpenPictureDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsOpenPictureDialog(void);
	DYNAMIC void __fastcall DoSelectionChange(void);
	DYNAMIC void __fastcall DoShow(void);
	
__published:
	__property Filter = {stored=IsFilterStored, default=0};
};


class DELPHICLASS TsSaveDialog;
class PASCALIMPLEMENTATION TsSaveDialog : public Vcl::Dialogs::TSaveDialog
{
	typedef Vcl::Dialogs::TSaveDialog inherited;
	
public:
	/* TOpenDialog.Create */ inline __fastcall virtual TsSaveDialog(System::Classes::TComponent* AOwner) : Vcl::Dialogs::TSaveDialog(AOwner) { }
	/* TOpenDialog.Destroy */ inline __fastcall virtual ~TsSaveDialog(void) { }
	
};


class DELPHICLASS TsSavePictureDialog;
class PASCALIMPLEMENTATION TsSavePictureDialog : public Vcl::Extdlgs::TSavePictureDialog
{
	typedef Vcl::Extdlgs::TSavePictureDialog inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	HIDESBASE bool __fastcall IsFilterStored(void);
	
public:
	__fastcall virtual TsSavePictureDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSavePictureDialog(void);
	
__published:
	__property Filter = {stored=IsFilterStored, default=0};
};


class DELPHICLASS TsColorDialog;
class PASCALIMPLEMENTATION TsColorDialog : public Vcl::Dialogs::TColorDialog
{
	typedef Vcl::Dialogs::TColorDialog inherited;
	
private:
	System::Classes::TStrings* FMainColors;
	bool FStandardDlg;
	void __fastcall SetMainColors(System::Classes::TStrings* const Value);
	
public:
	virtual bool __fastcall Execute(void)/* overload */;
	__fastcall virtual TsColorDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsColorDialog(void);
	DYNAMIC void __fastcall DoShow(void);
	DYNAMIC void __fastcall DoClose(void);
	
__published:
	__property Options = {default=1};
	__property System::Classes::TStrings* MainColors = {read=FMainColors, write=SetMainColors};
	__property bool StandardDlg = {read=FStandardDlg, write=FStandardDlg, default=0};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TColorDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Forms::TForm* __fastcall sCreateMessageDialog(const System::UnicodeString Title, const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons);
extern DELPHI_PACKAGE int __fastcall sMessageDlg(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx)/* overload */;
extern DELPHI_PACKAGE int __fastcall sMessageDlg(const System::UnicodeString Title, const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx)/* overload */;
extern DELPHI_PACKAGE int __fastcall sMessageDlgPos(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y)/* overload */;
extern DELPHI_PACKAGE int __fastcall sMessageDlgPos(const System::UnicodeString Title, const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y)/* overload */;
extern DELPHI_PACKAGE int __fastcall sMessageDlgPosHelp(const System::UnicodeString Title, const System::UnicodeString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y, const System::UnicodeString HelpFileName);
extern DELPHI_PACKAGE void __fastcall sShowMessage(const System::UnicodeString Msg)/* overload */;
extern DELPHI_PACKAGE void __fastcall sShowMessage(const System::UnicodeString Title, const System::UnicodeString Msg)/* overload */;
extern DELPHI_PACKAGE void __fastcall sShowMessageFmt(const System::UnicodeString Msg, System::TVarRec const *Params, const int Params_High)/* overload */;
extern DELPHI_PACKAGE void __fastcall sShowMessageFmt(const System::UnicodeString Title, const System::UnicodeString Msg, System::TVarRec const *Params, const int Params_High)/* overload */;
extern DELPHI_PACKAGE void __fastcall sShowMessagePos(const System::UnicodeString Msg, int X, int Y)/* overload */;
extern DELPHI_PACKAGE void __fastcall sShowMessagePos(const System::UnicodeString Title, const System::UnicodeString Msg, int X, int Y)/* overload */;
extern DELPHI_PACKAGE bool __fastcall sInputQuery(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall sInputBox(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString ADefault);
}	/* namespace Sdialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SDIALOGS)
using namespace Sdialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SdialogsHPP
