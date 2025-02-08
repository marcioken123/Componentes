// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFRichEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdrtfricheditorHPP
#define PlmdrtfricheditorHPP

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
#include <Vcl.ActnList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDRTFActions.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFFontComboBox.hpp>
#include <LMDRTFBase.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtfricheditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDRichEditorForm;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 2> Plmdrtfricheditor__1;

class PASCALIMPLEMENTATION TfrmLMDRichEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TMainMenu* MainMenu;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* New1;
	Vcl::Controls::TImageList* ImageList;
	Vcl::Actnlist::TActionList* alToolbar;
	Vcl::Comctrls::TToolBar* Toolbar;
	Vcl::Comctrls::TToolButton* btnNew1;
	Lmdrtfactions::TLMDRichEditNew* actNew;
	Vcl::Comctrls::TToolButton* btnLoad1;
	Lmdrtfactions::TLMDRichEditLoad* actLoad;
	Vcl::Comctrls::TToolButton* btnSave1;
	Lmdrtfactions::TLMDRichEditSave* actSave;
	Vcl::Comctrls::TToolButton* Separator1;
	Vcl::Comctrls::TToolButton* btnPrint1;
	Lmdrtfactions::TLMDRichEditPrint* actPrint;
	Vcl::Comctrls::TToolButton* btnPreview1;
	Lmdrtfactions::TLMDRichEditPreview* actPreview;
	Vcl::Comctrls::TToolButton* Separator2;
	Vcl::Comctrls::TToolButton* btnFind1;
	Lmdrtfactions::TLMDRichEditFind* actFind;
	Vcl::Comctrls::TToolButton* Separator3;
	Vcl::Comctrls::TToolButton* btnCut1;
	Lmdrtfactions::TLMDRichEditCut* actCut;
	Vcl::Comctrls::TToolButton* btnCopy1;
	Lmdrtfactions::TLMDRichEditCopy* actCopy;
	Vcl::Comctrls::TToolButton* btnPaste1;
	Lmdrtfactions::TLMDRichEditPaste* actPaste;
	Vcl::Comctrls::TToolButton* Separator4;
	Vcl::Comctrls::TToolButton* btnUndo1;
	Lmdrtfactions::TLMDRichEditUndo* actUndo;
	Vcl::Comctrls::TToolButton* btnRedo1;
	Lmdrtfactions::TLMDRichEditRedo* actRedo;
	Vcl::Comctrls::TToolButton* btnTextAttributes1;
	Lmdrtfactions::TLMDRichEditTextAttributes* actTextAttributes;
	Vcl::Comctrls::TToolButton* Separator6;
	Vcl::Comctrls::TToolButton* btnTextBold1;
	Lmdrtfactions::TLMDRichEditTextBold* actTextBold;
	Vcl::Comctrls::TToolButton* btnTextItalic1;
	Lmdrtfactions::TLMDRichEditTextItalic* actTextItalic;
	Vcl::Comctrls::TToolButton* btnTextUnderline1;
	Lmdrtfactions::TLMDRichEditTextUnderline* actTextUnderline;
	Lmdrtfactions::TLMDRichEditTextSubscript* actTextSubscript;
	Lmdrtfactions::TLMDRichEditTextSuperscript* actTextSuperscript;
	Vcl::Comctrls::TToolButton* Separator8;
	Vcl::Comctrls::TToolButton* btnParaAlign1;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign1;
	Vcl::Comctrls::TToolButton* btnParaAlign2;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign2;
	Vcl::Comctrls::TToolButton* btnParaAlign3;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign3;
	Vcl::Comctrls::TToolButton* Separator9;
	Vcl::Comctrls::TToolButton* btnNumbering1;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering1;
	Vcl::Comctrls::TToolButton* btnNumbering2;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering2;
	Vcl::Comctrls::TToolButton* btnIndent1;
	Lmdrtfactions::TLMDRichEditIndent* actIndent;
	Vcl::Comctrls::TToolButton* btnUnindent1;
	Lmdrtfactions::TLMDRichEditUnindent* actUnindent;
	Vcl::Menus::TMenuItem* Openafile1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* Preview1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Find1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* Undo1;
	Vcl::Menus::TMenuItem* Redo1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* Format1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* Numbering1;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Comctrls::TToolBar* FormatBar;
	Lmdrtffontcombobox::TLMDRichFontComboBox* LMDRichFontComboBox1;
	Lmdrtffontcombobox::TLMDRichFontSizeComboBox* fsc;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Menus::TMenuItem* N4;
	Vcl::Menus::TMenuItem* Exit1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* DateandTime1;
	Vcl::Menus::TMenuItem* Object1;
	Vcl::Menus::TMenuItem* SelectAll1;
	Lmdrtfactions::TLMDRichEditSelectAll* actSelectAll;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* Symbol1;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* vwToolbar;
	Vcl::Menus::TMenuItem* vwFormatBar;
	Vcl::Menus::TMenuItem* Paragraph1;
	Vcl::Menus::TMenuItem* Tabstops1;
	Vcl::Menus::TMenuItem* Replace1;
	Vcl::Menus::TMenuItem* vwStatusBar;
	Vcl::Menus::TMenuItem* vwRuler;
	Vcl::Menus::TMenuItem* PageSettings1;
	Lmdrtfactions::TLMDRichEditDelete* actDelete;
	Lmdrtfactions::TLMDRichEditParagraph* actParagraph;
	Lmdrtfactions::TLMDRichEditInsertDateTime* actInsertDateTime;
	Lmdrtfactions::TLMDRichEditInsertChar* actInsertChar;
	Lmdrtfactions::TLMDRichEditInsertObject* actInsertObject;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TToolButton* btnColors;
	Vcl::Menus::TPopupMenu* mnuColors;
	Vcl::Menus::TMenuItem* mnuBlack;
	Vcl::Menus::TMenuItem* mnuMaroon;
	Vcl::Menus::TMenuItem* mnuGreen;
	Vcl::Menus::TMenuItem* mnuOlive;
	Vcl::Menus::TMenuItem* mnuNavy;
	Vcl::Menus::TMenuItem* mnuPurple;
	Vcl::Menus::TMenuItem* mnuTeal;
	Vcl::Menus::TMenuItem* mnuGray;
	Vcl::Menus::TMenuItem* mnuSilver;
	Vcl::Menus::TMenuItem* mnuRed;
	Vcl::Menus::TMenuItem* mnuLime;
	Vcl::Menus::TMenuItem* mnuYellow;
	Vcl::Menus::TMenuItem* mnuBlue;
	Vcl::Menus::TMenuItem* mnuFuchsia;
	Vcl::Menus::TMenuItem* mnuAqua;
	Vcl::Menus::TMenuItem* mnuWhite;
	Vcl::Menus::TMenuItem* mnuAutomatic;
	Vcl::Menus::TMenuItem* Custom1;
	Vcl::Dialogs::TColorDialog* ColorDialog;
	Vcl::Menus::TMenuItem* N7;
	Vcl::Menus::TMenuItem* vwMeasurement;
	Vcl::Menus::TMenuItem* vwmPoints;
	Vcl::Menus::TMenuItem* vwmInches;
	Vcl::Menus::TMenuItem* vwmMillimeters;
	Vcl::Menus::TMenuItem* N8;
	Vcl::Menus::TMenuItem* vwWordWrap;
	Vcl::Menus::TMenuItem* vwMode;
	Vcl::Menus::TMenuItem* vwoPrinterSupport;
	Vcl::Menus::TMenuItem* vwoAppOnly;
	Lmdrtfactions::TLMDRichEditReplace* actReplace;
	Vcl::Menus::TMenuItem* N9;
	Vcl::Menus::TMenuItem* vwStatistics;
	Lmdrtfactions::TLMDRichEditSaveAs* actSaveAs;
	Vcl::Menus::TMenuItem* Savefileas1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Lmdrtfactions::TLMDRichEditBaseEditAction* actMenuColors;
	Lmdrtfactions::TLMDRichEditPrint* actPrintDialog;
	Lmdrtfactions::TLMDRichEditBaseEditAction* actTabs;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnOK;
	Lmdrtfactions::TLMDRichEditStatistics* actStatistics;
	Lmdrtfrichedit::TLMDRichEdit* LMDRichEdit;
	Lmdrtfactions::TLMDRichEditPageSetting* actPageSetting;
	Lmdrtfactions::TLMDRichEditBaseEditAction* actInsertBitmap;
	Vcl::Menus::TMenuItem* InsertBitmap1;
	Vcl::Menus::TMenuItem* N10;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* ToolButton5;
	void __fastcall OnViewClick(System::TObject* Sender);
	void __fastcall OnactionClick(System::TObject* Sender);
	void __fastcall LMDRichEditSelectionChange(System::TObject* Sender);
	void __fastcall mnuColorClick(System::TObject* Sender);
	void __fastcall mnuColorDrawItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall LMDRichEditChange(System::TObject* Sender);
	void __fastcall Measurement1Click(System::TObject* Sender);
	void __fastcall vwWordWrapClick(System::TObject* Sender);
	void __fastcall ModeClick(System::TObject* Sender);
	void __fastcall actSaveUnknownFilename(System::TObject* Sender, System::TObject* Target, bool &Saved);
	void __fastcall actTabsExecute(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall actInsertBitmapUpdate(System::TObject* Sender);
	
private:
	System::Classes::TComponent* fComponent;
	System::UnicodeString FPicPath;
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
	void __fastcall SetBComponent(System::Classes::TComponent* C);
	void __fastcall AdjustControlItems(void);
	bool __fastcall ExecuteStrings(const System::UnicodeString ACaption, System::Classes::TStrings* C);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__classmethod bool __fastcall ExecuteEx(const System::UnicodeString ACaption, System::Classes::TPersistent* C);
	__classmethod bool __fastcall ExecuteRTFStrings(const System::UnicodeString ACaption, System::Classes::TStrings* C, bool WordWrap, bool AllowObjects);
	bool __fastcall Execute(const System::UnicodeString ACaption, System::Classes::TComponent* C);
	__property System::Classes::TComponent* BaseComponent = {read=fComponent, write=SetBComponent};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDRichEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDRichEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDRichEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDRichEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Plmdrtfricheditor__1 ModifiedStates;
extern DELPHI_PACKAGE bool __fastcall LMDRTFEditComponent(const System::UnicodeString ACaption, System::Classes::TPersistent* C);
}	/* namespace Plmdrtfricheditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFRICHEDITOR)
using namespace Plmdrtfricheditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtfricheditorHPP
