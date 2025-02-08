// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFCharmapDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtfcharmapdialogHPP
#define LmdrtfcharmapdialogHPP

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
#include <Vcl.ToolWin.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFFontComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfcharmapdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDRTFCharmapDialog;
class DELPHICLASS TLMDRichCharmapDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDRTFCharmapDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lblFont;
	Vcl::Stdctrls::TLabel* lblCharSet;
	Vcl::Stdctrls::TComboBox* cbCharSet;
	Vcl::Extctrls::TPaintBox* CharTable;
	Vcl::Stdctrls::TScrollBar* ScrollBar;
	Vcl::Extctrls::TPaintBox* CharZoom;
	Vcl::Stdctrls::TEdit* edSelChar;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnHelp;
	Lmdrtffontcombobox::TLMDRichFontComboBox* cbFont;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CharTablePaint(System::TObject* Sender);
	void __fastcall cbFontChange(System::TObject* Sender);
	void __fastcall CharZoomPaint(System::TObject* Sender);
	void __fastcall CharTableMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CharTableDblClick(System::TObject* Sender);
	
private:
	int FColPerPage;
	int FRowPerPage;
	int FCellSize;
	int FSmallSize;
	int FLargeSize;
	int FSelOffset;
	bool FDblCLick;
	System::UnicodeString __fastcall GetSelChar(void);
	System::Uitypes::TFontName __fastcall GetFontName(void);
	System::Uitypes::TFontCharset __fastcall GetCharSet(void);
	void __fastcall FillCharSet(const System::UnicodeString s);
	
public:
	__property System::UnicodeString InsertText = {read=GetSelChar};
	__property System::Uitypes::TFontName FontName = {read=GetFontName};
	__property System::Uitypes::TFontCharset CharSet = {read=GetCharSet, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDRTFCharmapDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDRTFCharmapDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDRTFCharmapDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDRTFCharmapDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichCharmapDialog : public Lmdrtfbase::TLMDRichBaseDialog
{
	typedef Lmdrtfbase::TLMDRichBaseDialog inherited;
	
private:
	System::Uitypes::TFontName FFontName;
	System::Uitypes::TFontCharset FFontCharSet;
	Lmdrtfrichedit::TLMDCustomRichEdit* FControl;
	System::UnicodeString FInsertText;
	bool FRestoreFont;
	bool __fastcall IsNotDefaultFont(void);
	void __fastcall SetControl(Lmdrtfrichedit::TLMDCustomRichEdit* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDRichCharmapDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	__property System::Uitypes::TFontCharset FontCharSet = {read=FFontCharSet, write=FFontCharSet, default=1};
	__property System::UnicodeString InsertText = {read=FInsertText};
	
__published:
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=FFontName, stored=IsNotDefaultFont};
	__property Lmdrtfrichedit::TLMDCustomRichEdit* RichEditControl = {read=FControl, write=SetControl};
	__property bool RestoreFont = {read=FRestoreFont, write=FRestoreFont, default=1};
	__property OnHelpClick;
	__property OnCustomize;
	__property Options = {default=6};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDRichCharmapDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_CharMapFont L"WingDings"
}	/* namespace Lmdrtfcharmapdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFCHARMAPDIALOG)
using namespace Lmdrtfcharmapdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfcharmapdialogHPP
