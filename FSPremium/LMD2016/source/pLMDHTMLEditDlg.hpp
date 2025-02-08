// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDHTMLEditDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdhtmleditdlgHPP
#define PlmdhtmleditdlgHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.StdActns.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.TypInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdhtmleditdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDMiniHTMLEditor;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDGraphicControlClass;

class PASCALIMPLEMENTATION TfrmLMDMiniHTMLEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Dialogs::TColorDialog* colordlg;
	Vcl::Actnlist::TActionList* MainAct;
	Vcl::Stdactns::TEditCut* EditCut1;
	Vcl::Stdactns::TEditCopy* EditCopy1;
	Vcl::Stdactns::TEditPaste* EditPaste1;
	Vcl::Stdactns::TEditSelectAll* EditSelectAll1;
	Vcl::Stdactns::TEditDelete* EditDelete1;
	Vcl::Stdactns::TEditUndo* EditUndo1;
	Vcl::Actnlist::TAction* BoldTag;
	Vcl::Actnlist::TAction* ItalicTag;
	Vcl::Actnlist::TAction* UnderlineTag;
	Vcl::Actnlist::TAction* ParaTag;
	Vcl::Actnlist::TAction* BRTag;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Menus::TMainMenu* MainMenu1;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* FileExitItem;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Undo1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* CutItem;
	Vcl::Menus::TMenuItem* CopyItem;
	Vcl::Menus::TMenuItem* PasteItem;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* SelectAll1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* BoldTag1;
	Vcl::Menus::TMenuItem* ItalicTag1;
	Vcl::Menus::TMenuItem* UnderlineTag1;
	Vcl::Menus::TMenuItem* ParaTag1;
	Vcl::Menus::TMenuItem* LineBreak1;
	Vcl::Extctrls::TPanel* LMDSimplePanel1;
	Vcl::Stdctrls::TButton* LMDButton1;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Extctrls::TPanel* LMDSimplePanel2;
	Vcl::Buttons::TSpeedButton* btnCut;
	Vcl::Buttons::TSpeedButton* btnCopy;
	Vcl::Buttons::TSpeedButton* btnPaste;
	Vcl::Buttons::TSpeedButton* LMDSpeedButton1;
	Vcl::Menus::TMenuItem* Strikr1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* FontColor1;
	Vcl::Stdctrls::TMemo* htmledit;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	void __fastcall MainAction(System::TObject* Sender);
	void __fastcall HTMLEditChange(System::TObject* Sender);
	void __fastcall SetPreviewText(void);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcl::Controls::TGraphicControl* FView;
	System::Typinfo::TPropInfo *FCaptionPropInfo;
	
public:
	void __fastcall SetViewControlClass(TLMDGraphicControlClass aControlClass);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDMiniHTMLEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDMiniHTMLEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDMiniHTMLEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDMiniHTMLEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmLMDMiniHTMLEditor* frmLMDMiniHTMLEditor;
}	/* namespace Plmdhtmleditdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDHTMLEDITDLG)
using namespace Plmdhtmleditdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdhtmleditdlgHPP
