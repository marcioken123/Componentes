// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEditTools.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeedittoolsHPP
#define Vcltee_TeeedittoolsHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeedittools
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormTeeTools;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFormTeeTools : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TListBox* LBTools;
	Vcl::Extctrls::TPanel* PanelToolEditor;
	Vcl::Extctrls::TPanel* PTop;
	Vcl::Stdctrls::TButton* BAdd;
	Vcl::Stdctrls::TButton* BDelete;
	Vcl::Stdctrls::TCheckBox* CBActive;
	Vcl::Extctrls::TPanel* PBottom;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* BMoveUp;
	Vcl::Buttons::TSpeedButton* BMoveDown;
	Vcl::Stdctrls::TCheckBox* CBShowInEditor;
	Vcl::Buttons::TSpeedButton* BClone;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	void __fastcall LBToolsClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall CBActiveClick(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BMoveUpClick(System::TObject* Sender);
	void __fastcall BMoveDownClick(System::TObject* Sender);
	void __fastcall LBToolsDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall CBShowInEditorClick(System::TObject* Sender);
	void __fastcall BCloneClick(System::TObject* Sender);
	void __fastcall PBottomClick(System::TObject* Sender);
	
private:
	Vcltee::Teengine::TTeeCustomTool* __fastcall CurrentTool();
	void __fastcall DeleteForm();
	void __fastcall EnableButtons();
	void __fastcall FillAndSet();
	void __fastcall FillTools();
	void __fastcall SetPanelBottom();
	void __fastcall SwapTool(int A, int B);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	
protected:
	System::Classes::TNotifyEvent OnAdded;
	System::Classes::TNotifyEvent OnDeleted;
	virtual Vcltee::Teengine::TTeeCustomTool* __fastcall CloneTool(Vcltee::Teengine::TTeeCustomTool* const Tool);
	virtual Vcltee::Teengine::TTeeCustomTool* __fastcall GetNewTool();
	
public:
	Vcltee::Teengine::TChartTools* Tools;
	__classmethod Vcltee::Teengine::TTeeCustomTool* __fastcall AddNewTool(Vcltee::Teengine::TChartTools* const ATools, Vcltee::Teengine::TTeeCustomToolClass AClass, const System::UnicodeString ADefaultName);
	void __fastcall Reload();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormTeeTools(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormTeeTools(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormTeeTools() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormTeeTools(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeedittools */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEDITTOOLS)
using namespace Vcltee::Teeedittools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeedittoolsHPP
