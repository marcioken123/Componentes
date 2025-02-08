// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'MsgTracer.pas' rev: 5.00

#ifndef MsgTracerHPP
#define MsgTracerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolCtrls.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <VclTracer.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Msgtracer
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTracerForm;
class PASCALIMPLEMENTATION TTracerForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Coolctrls::TCoolStringGrid* MsgGrid;
	Stdctrls::TLabel* SrcLabel;
	Stdctrls::TLabel* DstLabel;
	Buttons::TSpeedButton* IncludeBtn;
	Buttons::TSpeedButton* IncAllBtn;
	Buttons::TSpeedButton* ExcludeBtn;
	Buttons::TSpeedButton* ExAllBtn;
	Coolctrls::TCoolListBox* SrcList;
	Coolctrls::TCoolListBox* DstList;
	Stdctrls::TButton* btnStart;
	Stdctrls::TButton* btnStop;
	Stdctrls::TButton* btnClear;
	Stdctrls::TButton* btnClose;
	Menus::TPopupMenu* mPopup;
	Menus::TMenuItem* Copymessage1;
	Menus::TMenuItem* CopywParam1;
	Menus::TMenuItem* CopylParam1;
	Menus::TMenuItem* CopyResult1;
	Extctrls::TImage* ImageRest;
	Extctrls::TImage* ImageMsg;
	Buttons::TSpeedButton* btnUp;
	Buttons::TSpeedButton* btnDown;
	Stdctrls::TButton* btnOpen;
	Stdctrls::TButton* btnSave;
	Dialogs::TOpenDialog* OpenDialog;
	Dialogs::TSaveDialog* SaveDialog;
	void __fastcall MsgGridDrawCell(System::TObject* Sender, int Col, int Row, const Windows::TRect &Recty
		, Grids::TGridDrawState State);
	void __fastcall IncludeBtnClick(System::TObject* Sender);
	void __fastcall ExcludeBtnClick(System::TObject* Sender);
	void __fastcall IncAllBtnClick(System::TObject* Sender);
	void __fastcall ExAllBtnClick(System::TObject* Sender);
	void __fastcall btnStartClick(System::TObject* Sender);
	void __fastcall btnStopClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnCloseClick(System::TObject* Sender);
	void __fastcall Copymessage1Click(System::TObject* Sender);
	void __fastcall CopywParam1Click(System::TObject* Sender);
	void __fastcall CopylParam1Click(System::TObject* Sender);
	void __fastcall CopyResult1Click(System::TObject* Sender);
	void __fastcall btnDownClick(System::TObject* Sender);
	void __fastcall btnUpClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnOpenClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Coolutils::TWndHook* FWndHook;
	bool FOnce;
	bool FTopMost;
	bool FStoped;
	HIDESBASE MESSAGE void __fastcall WMSysCommand(Messages::TWMSysCommand &Msg);
	void __fastcall SetTopMost(bool Value);
	void __fastcall BeforeMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall AfterMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall HookedControlChange(System::TObject* Sender);
	void __fastcall MoveSelected(Stdctrls::TCustomListBox* List, Classes::TStrings* Items);
	void __fastcall SetItem(Stdctrls::TCustomListBox* List, int Index);
	int __fastcall GetFirstSelection(Stdctrls::TCustomListBox* List);
	void __fastcall SetButtons(void);
	
public:
	__fastcall virtual TTracerForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TTracerForm(void);
	
__published:
	__property bool TopMost = {read=FTopMost, write=SetTopMost, nodefault};
	__property Coolutils::TWndHook* WndHook = {read=FWndHook, write=FWndHook};
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTracerForm(Classes::TComponent* AOwner, int 
		Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TTracerForm(HWND ParentWindow) : Forms::TForm(ParentWindow
		) { }
	#pragma option pop
	
};


typedef Classes::TIdentMapEntry MsgTracer__2[437];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Classes::TIdentMapEntry WindowsMessages[437];
extern PACKAGE TTracerForm* TracerForm;

}	/* namespace Msgtracer */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Msgtracer;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MsgTracer
