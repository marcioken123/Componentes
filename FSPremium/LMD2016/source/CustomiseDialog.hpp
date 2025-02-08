// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CustomiseDialog.pas' rev: 31.00 (Windows)

#ifndef CustomisedialogHPP
#define CustomisedialogHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <JSDialog.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ActnList.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Customisedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmCustomiseDialog;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TfrmCustomiseDialogClass;

class PASCALIMPLEMENTATION TfrmCustomiseDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* bOK;
	Vcl::Stdctrls::TButton* bPreview;
	Vcl::Stdctrls::TButton* bCancel;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* tsCustomBUttons;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TTabSheet* tsRadioBUttons;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* eInstruction;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TMemo* mContent;
	Vcl::Stdctrls::TGroupBox* gbOptions;
	Vcl::Stdctrls::TCheckBox* cbdoShowHelpLink;
	Vcl::Stdctrls::TCheckBox* cbdoRadioButtons;
	Vcl::Stdctrls::TCheckBox* cbdoCommandLinks;
	Vcl::Stdctrls::TCheckBox* cbdoCommandLinksNoIcon;
	Vcl::Stdctrls::TCheckBox* cbdoProgressBar;
	Vcl::Stdctrls::TCheckBox* cbdoProgressBarMarque;
	Vcl::Stdctrls::TCheckBox* cbdoTimer;
	Vcl::Stdctrls::TCheckBox* cbdoTopMost;
	Vcl::Stdctrls::TCheckBox* cbdoModal;
	Vcl::Stdctrls::TGroupBox* gbFonts;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* lInstructionFont;
	Vcl::Stdctrls::TLabel* lContentFont;
	Vcl::Stdctrls::TLabel* lMoreContentFont;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Stdctrls::TCheckBox* cbShowVerification;
	Vcl::Stdctrls::TEdit* eVerification;
	Jsdialog::TJSDialog* jsDialog1;
	Vcl::Comctrls::TTabSheet* TabSheet7;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* eTitle;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TCheckBox* cbShowMoreShowing;
	Vcl::Stdctrls::TEdit* eShowText;
	Vcl::Stdctrls::TEdit* eHideText;
	Vcl::Stdctrls::TCheckBox* cbShowMoreShowInFooter;
	Vcl::Extctrls::TRadioGroup* rgShowMoreFormat;
	Vcl::Extctrls::TRadioGroup* rgShowMoreSource;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* eShowMoreFooterHeight;
	Vcl::Stdctrls::TCheckBox* cbShowHeader;
	Vcl::Stdctrls::TCheckBox* cbShowFooter;
	Vcl::Extctrls::TRadioGroup* rgFooterIcon;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TMemo* mHeaderText;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TMemo* mFooterText;
	Vcl::Stdctrls::TListBox* lbCustomButtons;
	Vcl::Stdctrls::TListBox* lbRadioButtons;
	Vcl::Extctrls::TPanel* pCustomButtonAddEdit;
	Vcl::Stdctrls::TButton* bCustomButtonAdd;
	Vcl::Stdctrls::TButton* bCustomButtonDelete;
	Vcl::Stdctrls::TButton* bCustomButtonSave;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TEdit* eCustomButtonCaption;
	Vcl::Stdctrls::TCheckBox* cbCustomButtonCancel;
	Vcl::Stdctrls::TCheckBox* cbCustomButtonDefault;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* eCustomButtonHint;
	Vcl::Stdctrls::TEdit* eCustomButtonImageIndex;
	Vcl::Stdctrls::TEdit* eCustomButtonPictureIndex;
	Vcl::Extctrls::TImage* iCustomButtonGlyph;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog1;
	Jsdialog::TJSDialog* jsdConfirmDelete;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TEdit* eDialogWidth;
	Vcl::Extctrls::TPanel* pRadioButtonsAddEdit;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TButton* bRadioButtonsSave;
	Vcl::Stdctrls::TEdit* eRadioButtonCaption;
	Vcl::Stdctrls::TCheckBox* cbRadioButtonEnabled;
	Vcl::Stdctrls::TCheckBox* cbRadioButtonChecked;
	Vcl::Stdctrls::TEdit* Edit5;
	Vcl::Stdctrls::TButton* bRadioButtonsAdd;
	Vcl::Stdctrls::TButton* bRadioButtonsDelete;
	Vcl::Stdctrls::TButton* bCustomButtonEdit;
	Vcl::Stdctrls::TButton* bCustomButtonCancel;
	Vcl::Stdctrls::TButton* bRadioButtonsCancel;
	Vcl::Stdctrls::TButton* bRadioButtonsEdit;
	Vcl::Comctrls::TTabSheet* TabSheet8;
	Vcl::Stdctrls::TGroupBox* gbCommonButtons;
	Vcl::Stdctrls::TCheckBox* cbcbYes;
	Vcl::Stdctrls::TCheckBox* cbcbNo;
	Vcl::Stdctrls::TCheckBox* cbcbOK;
	Vcl::Stdctrls::TCheckBox* cbcbCancel;
	Vcl::Stdctrls::TCheckBox* cbcbAbort;
	Vcl::Stdctrls::TCheckBox* cbcbRetry;
	Vcl::Stdctrls::TCheckBox* cbcbIgnore;
	Vcl::Stdctrls::TCheckBox* cbcbAll;
	Vcl::Stdctrls::TCheckBox* cbcbNoToAll;
	Vcl::Stdctrls::TCheckBox* cbcbYesToAll;
	Vcl::Stdctrls::TCheckBox* cbcbHelp;
	Vcl::Stdctrls::TCheckBox* cbcbClose;
	Vcl::Stdctrls::TComboBox* cboxButtonsDefault;
	Vcl::Stdctrls::TComboBox* cboxButtonsCancel;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TCheckBox* cbShowCommonButtons;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TEdit* eButtonBarColor;
	Vcl::Dialogs::TColorDialog* ColorDialog1;
	Vcl::Buttons::TBitBtn* bbColorDialog;
	Vcl::Comctrls::TTabSheet* TabSheet9;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Stdctrls::TLabel* Label23;
	Vcl::Stdctrls::TLabel* Label24;
	Vcl::Stdctrls::TLabel* Label25;
	Vcl::Stdctrls::TEdit* eHelpLinkLabelText;
	Vcl::Stdctrls::TEdit* eHelpLinkContext;
	Vcl::Stdctrls::TComboBox* cboxHelpLinkType;
	Vcl::Stdctrls::TEdit* eHelpLinkKeyword;
	Vcl::Stdctrls::TLabel* Label26;
	Vcl::Buttons::TBitBtn* BitBtn1;
	Vcl::Stdctrls::TEdit* eHeaderColor;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* lHeaderFont;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* lFooterFont;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* eDialogColor;
	Vcl::Buttons::TBitBtn* bbDialogColor;
	Vcl::Extctrls::TRadioGroup* rgIconSize;
	Vcl::Stdctrls::TGroupBox* gbMainIcon;
	Vcl::Extctrls::TRadioGroup* rgMainIcon;
	Vcl::Extctrls::TImage* iMainIcon;
	Vcl::Stdctrls::TCheckBox* cbUseDefaultFonts;
	Vcl::Stdctrls::TComboBox* cboxBorderStyle;
	Vcl::Stdctrls::TLabel* lBorderStyle;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TCheckBox* cbSystemMenu;
	Vcl::Stdctrls::TCheckBox* cbMinimize;
	Vcl::Extctrls::TRadioGroup* rgPosition;
	Vcl::Stdctrls::TGroupBox* GroupBox4;
	Vcl::Extctrls::TImage* iHeaderIcon;
	Vcl::Extctrls::TRadioGroup* rgHeaderIcon;
	Vcl::Stdctrls::TLabel* Label27;
	Vcl::Stdctrls::TEdit* eMainInstructionColor;
	Vcl::Buttons::TBitBtn* bbMainInstructionColor;
	Vcl::Stdctrls::TCheckBox* cbMultiline;
	Vcl::Stdctrls::TCheckBox* cbShowGlyph;
	Vcl::Stdctrls::TCheckBox* cbShowAtTop;
	Vcl::Stdctrls::TLabel* Label28;
	Vcl::Stdctrls::TComboBox* cboxMainInstructionIcon;
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Actnlist::TAction* aDeleteCustomButton;
	Vcl::Actnlist::TAction* aDeleteRadioButton;
	Vcl::Stdctrls::TLabel* Label29;
	Vcl::Stdctrls::TMemo* mCommandLinkHint;
	Vcl::Stdctrls::TLabel* Label30;
	Vcl::Stdctrls::TCheckBox* cbElevelationRequired;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TComboBox* eCustomButtonModalResult;
	Vcl::Stdctrls::TLabel* Label33;
	Vcl::Stdctrls::TEdit* eFooterBackgroundColor;
	Vcl::Buttons::TBitBtn* BitBtn2;
	Vcl::Stdctrls::TLabel* Label31;
	Vcl::Stdctrls::TLabel* Label32;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TCheckBox* cbShowMore;
	Vcl::Stdctrls::TMemo* mMoreContent;
	Vcl::Stdctrls::TLabel* lHelpLinkInfo;
	Vcl::Stdctrls::TLabel* lHelpLinkInfo1;
	Vcl::Comctrls::TTabSheet* tsProgress;
	Vcl::Stdctrls::TLabel* Label34;
	Vcl::Stdctrls::TLabel* Label35;
	Vcl::Stdctrls::TLabel* Label36;
	Vcl::Stdctrls::TLabel* Label37;
	Vcl::Stdctrls::TLabel* Label38;
	Vcl::Stdctrls::TLabel* Label39;
	Vcl::Stdctrls::TEdit* eProgressInterval;
	Vcl::Stdctrls::TEdit* eProgressMin;
	Vcl::Stdctrls::TEdit* eProgressMax;
	Vcl::Stdctrls::TEdit* eProgressPosition;
	Vcl::Stdctrls::TEdit* eProgressStep;
	Vcl::Stdctrls::TComboBox* cboxProgressState;
	Vcl::Stdctrls::TGroupBox* gbBorder;
	Vcl::Stdctrls::TLabel* Label41;
	Vcl::Stdctrls::TLabel* lBorderWidth;
	Vcl::Stdctrls::TEdit* eBorderColor;
	Vcl::Buttons::TBitBtn* bbBorderColor;
	Vcl::Stdctrls::TCheckBox* cbBorderVisible;
	Vcl::Stdctrls::TEdit* eBorderWidth;
	Vcl::Stdctrls::TGroupBox* gbHeaderGradient;
	Vcl::Stdctrls::TCheckBox* cbHeaderGradientEnabled;
	Vcl::Stdctrls::TEdit* eHeaderGradientStartColor;
	Vcl::Buttons::TBitBtn* bbStartColor;
	Vcl::Stdctrls::TEdit* eHeaderGradientEndColor;
	Vcl::Buttons::TBitBtn* bbEndColor;
	Vcl::Extctrls::TRadioGroup* rgHeaderGradientDirection;
	Vcl::Stdctrls::TLabel* Label40;
	Vcl::Stdctrls::TLabel* Label42;
	Vcl::Extctrls::TPanel* pImageLists;
	Vcl::Stdctrls::TLabel* Label43;
	Vcl::Stdctrls::TLabel* Label44;
	Vcl::Stdctrls::TComboBox* cboxCustomButtonImages;
	Vcl::Stdctrls::TComboBox* cboxCustomButtonPictureImages;
	Vcl::Extctrls::TBevel* Bevel3;
	Vcl::Stdctrls::TLabel* Label45;
	Vcl::Stdctrls::TCheckBox* cbCustomButtonEnabled;
	Vcl::Stdctrls::TCheckBox* cbCustomButtonVisible;
	Vcl::Stdctrls::TCheckBox* cbProgressUseNativeProgressBar;
	void __fastcall lInstructionFontClick(System::TObject* Sender);
	void __fastcall bPreviewClick(System::TObject* Sender);
	void __fastcall lbCustomButtonsClick(System::TObject* Sender);
	void __fastcall iCustomButtonGlyphDblClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall bOKClick(System::TObject* Sender);
	void __fastcall bCustomButtonAddClick(System::TObject* Sender);
	void __fastcall bCustomButtonSaveClick(System::TObject* Sender);
	void __fastcall bRadioButtonsAddClick(System::TObject* Sender);
	void __fastcall bRadioButtonsSaveClick(System::TObject* Sender);
	void __fastcall lbRadioButtonsClick(System::TObject* Sender);
	void __fastcall bCustomButtonEditClick(System::TObject* Sender);
	void __fastcall bCustomButtonCancelClick(System::TObject* Sender);
	void __fastcall bRadioButtonsCancelClick(System::TObject* Sender);
	void __fastcall bRadioButtonsEditClick(System::TObject* Sender);
	void __fastcall bbColorDialogClick(System::TObject* Sender);
	void __fastcall eHelpLinkContextKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall BitBtn1Click(System::TObject* Sender);
	void __fastcall lHeaderFontClick(System::TObject* Sender);
	void __fastcall eButtonBarColorExit(System::TObject* Sender);
	void __fastcall eHeaderColorExit(System::TObject* Sender);
	void __fastcall bbDialogColorClick(System::TObject* Sender);
	void __fastcall eDialogColorExit(System::TObject* Sender);
	void __fastcall rgMainIconClick(System::TObject* Sender);
	void __fastcall rgHeaderIconClick(System::TObject* Sender);
	void __fastcall rgIconSizeClick(System::TObject* Sender);
	void __fastcall bbMainInstructionColorClick(System::TObject* Sender);
	void __fastcall aDeleteCustomButtonExecute(System::TObject* Sender);
	void __fastcall aDeleteRadioButtonExecute(System::TObject* Sender);
	void __fastcall aDeleteCustomButtonUpdate(System::TObject* Sender);
	void __fastcall aDeleteRadioButtonUpdate(System::TObject* Sender);
	void __fastcall BitBtn2Click(System::TObject* Sender);
	void __fastcall eFooterBackgroundColorExit(System::TObject* Sender);
	void __fastcall eProgressStepKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall bbStartColorClick(System::TObject* Sender);
	void __fastcall bbEndColorClick(System::TObject* Sender);
	void __fastcall bbBorderColorContextPopup(System::TObject* Sender, const System::Types::TPoint &MousePos, bool &Handled);
	
private:
	bool FCustomButtonEdit;
	bool FRadioButtonEdit;
	Jsdialog::TJSDialog* FTempDialog;
	void __fastcall SetTempDialog(Jsdialog::TJSDialog* const Value);
	int __fastcall AddCustomButton(void);
	int __fastcall AddRadioButton(void);
	void __fastcall CancelCustomButtonEdit(void);
	void __fastcall CancelRadioButtonEdit(void);
	void __fastcall ClearCustomButtonValues(void);
	void __fastcall ClearRadioButtonvalues(void);
	void __fastcall LoadCustomButtons(void);
	void __fastcall LoadRadioButtons(void);
	void __fastcall PreviewHelpLinkClick(System::TObject* Sender, bool &Handled);
	void __fastcall SetControlState(Vcl::Extctrls::TPanel* AControl, const bool AEnabled, const bool ACustomButton);
	
protected:
	Jsdialog::TJSDialogClass FPreviewClass;
	virtual void __fastcall CreateTempDialog(void);
	virtual void __fastcall DestroyTempDialog(void);
	virtual Jsdialog::TJSDialog* __fastcall GetTempDialog(void);
	virtual void __fastcall LoadDialogValues(void);
	virtual void __fastcall SaveDialogValues(Jsdialog::TJSDialog* ADialog);
	
public:
	__fastcall virtual TfrmCustomiseDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrmCustomiseDialog(void);
	void __fastcall UpdateIconHints(void);
	__classmethod virtual bool __fastcall Execute(Jsdialog::TJSDialog* ADialog, Jsdialog::TJSDialogClass APreviewClass, TfrmCustomiseDialogClass ACustomiseClass);
	__property Jsdialog::TJSDialog* TempDialog = {read=GetTempDialog, write=SetTempDialog};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmCustomiseDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmCustomiseDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmCustomiseDialog* frmCustomiseDialog;
}	/* namespace Customisedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_CUSTOMISEDIALOG)
using namespace Customisedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomisedialogHPP
