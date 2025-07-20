// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAxisBreaksEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeaxisbreakseditorHPP
#define Vcltee_TeeaxisbreakseditorHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeAxisBreaks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeaxisbreakseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisBreaksEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisBreaksEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Checklst::TCheckListBox* LBreaks;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SBDelete;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TrackBar1;
	Vcltee::Teependlg::TButtonPen* BBrush;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* LStart;
	Vcl::Stdctrls::TLabel* LEnd;
	Vcl::Stdctrls::TEdit* EStart;
	Vcl::Stdctrls::TEdit* EEnd;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TGroupBox* GBreaks;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LBreaksClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall LBreaksClickCheck(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	
private:
	Vcltee::Teeaxisbreaks::TAxisBreaksTool* __fastcall BreakTool();
	Vcltee::Teeaxisbreaks::TAxisBreak* __fastcall CurrentBreak();
	void __fastcall FillBreaks();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisBreaksEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisBreaksEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisBreaksEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAxisBreaksEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeaxisbreakseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEAXISBREAKSEDITOR)
using namespace Vcltee::Teeaxisbreakseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeaxisbreakseditorHPP
