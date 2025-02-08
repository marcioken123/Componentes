// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwmemo.pas' rev: 6.00

#ifndef WwmemoHPP
#define WwmemoHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwmemo
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwMemoAttribute { mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog };
#pragma option pop

typedef Set<TwwMemoAttribute, mSizeable, mDisableDialog>  TwwMemoAttributes;

class DELPHICLASS TwwMemoDlg;
class PASCALIMPLEMENTATION TwwMemoDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TMemo* Memo;
	Extctrls::TPanel* UserButtonPanel;
	Stdctrls::TButton* UserButton1;
	Stdctrls::TButton* UserButton2;
	Menus::TPopupMenu* PopupMenu1;
	void __fastcall ResizeControls(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall UserButton1Click(System::TObject* Sender);
	void __fastcall UserButton2Click(System::TObject* Sender);
	void __fastcall MemoChange(System::TObject* Sender);
	
private:
	bool OKBtnpressed;
	#pragma pack(push, 1)
	Types::TRect posRect;
	#pragma pack(pop)
	
	void __fastcall ApplyIntl(void);
	
protected:
	bool changed;
	bool init;
	bool allowClose;
	DYNAMIC void __fastcall KeyPress(char &key);
	
public:
	Graphics::TFont* TempFont;
	AnsiString TempTitle;
	Classes::TComponent* CallingComponent;
	Stdctrls::TButton* OKBtn;
	Stdctrls::TButton* CancelBtn;
	__fastcall virtual TwwMemoDlg(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwMemoDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwMemoDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwMemoDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwmemo)
extern PACKAGE bool __fastcall wwEditMemoField(Forms::TForm* AParentForm, Classes::TComponent* ADialog, bool Editable);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwmemo */
using namespace Wwmemo;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwmemo
