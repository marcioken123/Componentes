// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDlgEx.pas' rev: 31.00 (Windows)

#ifndef LmddlgexHPP
#define LmddlgexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ShlObj.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.ActiveX.hpp>
#include <LMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDShUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddlgex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormCommonDialog;
class DELPHICLASS TLMDFormOpenDialog;
class DELPHICLASS TLMDFormSaveDialog;
class DELPHICLASS TLMDFormColorDialog;
class DELPHICLASS TLMDFormFontDialog;
class DELPHICLASS TLMDFormPageSetupDialog;
class DELPHICLASS TLMDFormPrinterSetupDialog;
class DELPHICLASS TLMDFormPrintCommDialog;
class DELPHICLASS TLMDFormFolderDialog;
class DELPHICLASS TLMDFormOLEDialog;
class DELPHICLASS TLMDFormChangeIconDialog;
class DELPHICLASS TLMDFormInsertObjectDialog;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TLMDFilterString;

typedef System::UnicodeString TLMDFileName;

typedef System::LongBool __stdcall (*TDialogFunc)(void *DialogData);

class PASCALIMPLEMENTATION TLMDFormCommonDialog : public Vcl::Controls::TGraphicControl
{
	typedef Vcl::Controls::TGraphicControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FCtl3D;
	void *FDefWndProc;
	System::Classes::THelpContext FHelpContext;
	HWND FHandle;
	HWND FDialogHandle;
	void *FObjectInstance;
	NativeUInt FDialogTemplateHandle;
	int FFormClientWidth;
	int FFormClientHeight;
	int FFormWidth;
	int FFormHeight;
	bool FDialogShowing;
	Vcl::Forms::TForm* FForm;
	Vcl::Controls::TWinControl* FOldFormParent;
	HWND FOldFormParentHandle;
	Vcl::Forms::TFormBorderStyle FOldFormBorderStyle;
	System::Classes::TWndMethod FOldFormWndProc;
	bool FUpdateFFormRect;
	void *FOldDialogWndProc;
	bool FSkipMessages;
	System::UnicodeString FTitle;
	System::UnicodeString FDesignBMPName;
	System::UnicodeString FDesignCaption;
	System::UnicodeString FOkButtonCaption;
	System::UnicodeString FCancelButtonCaption;
	System::UnicodeString FHelpButtonCaption;
	System::Classes::TNotifyEvent FOnHelp;
	System::Classes::TNotifyEvent FOnClose;
	System::Classes::TNotifyEvent FOnShow;
	virtual NativeUInt __fastcall GetDialogTemplateHandle(void);
	MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMInitDialog(Winapi::Messages::TWMInitDialog &Message);
	MESSAGE void __fastcall WMNCDestroy(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMGETMINMAXINFO(Winapi::Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE virtual void __fastcall SetHeight(int Value);
	HIDESBASE virtual void __fastcall SetWidth(int Value);
	HIDESBASE virtual void __fastcall SetClientHeight(int Value);
	HIDESBASE virtual void __fastcall SetClientWidth(int Value);
	HIDESBASE virtual void __fastcall SetLeft(int Value);
	HIDESBASE virtual void __fastcall SetTop(int Value);
	void __fastcall SetForm(Vcl::Forms::TForm* Form);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	HIDESBASE int __fastcall GetClientWidth(void);
	HIDESBASE int __fastcall GetClientHeight(void);
	int __fastcall GetLeft(void);
	int __fastcall GetTop(void);
	void __fastcall SetOkButtonCaption(const System::UnicodeString Value);
	void __fastcall SetCancelButtonCaption(const System::UnicodeString Value);
	void __fastcall SetHelpButtonCaption(const System::UnicodeString Value);
	
protected:
	bool FParentWasRescaled;
	int FDlgBaseUnits;
	int __fastcall GetDlgBaseUnits(void);
	void __fastcall RescaleParent(void);
	virtual void __fastcall ValidateBounds(void) = 0 ;
	virtual void __fastcall Paint(void);
	virtual System::Types::TRect __fastcall GetStaticRect(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual bool __fastcall MessageHook(Winapi::Messages::TMessage &Msg);
	virtual int __fastcall TaskModalDialog(TDialogFunc DialogFunc, void *DialogData);
	void __fastcall NewFormProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoClose(void);
	virtual void __fastcall DoShow(void);
	virtual void __fastcall DoHelp(void);
	__property NativeUInt DialogTemplateHandle = {read=GetDialogTemplateHandle, nodefault};
	__property Vcl::Forms::TForm* Form = {read=FForm, write=SetForm};
	__property System::Classes::TWndMethod OldFormWndProc = {read=FOldFormWndProc};
	__property void * OldDialogWndProc = {read=FOldDialogWndProc};
	__property System::Classes::TNotifyEvent OnHelp = {read=FOnHelp, write=FOnHelp};
	
__published:
	__property int DlgBaseUnits = {read=GetDlgBaseUnits, write=FDlgBaseUnits, nodefault};
	
public:
	virtual bool __fastcall Execute(void) = 0 ;
	__property int FormHeight = {read=GetHeight, write=SetHeight, nodefault};
	__property int FormWidth = {read=GetWidth, write=SetWidth, nodefault};
	__property int FormClientHeight = {read=GetClientHeight, write=SetClientHeight, nodefault};
	__property int FormClientWidth = {read=GetClientWidth, write=SetClientWidth, nodefault};
	__property int FormLeft = {read=GetLeft, write=SetLeft, nodefault};
	__property int FormTop = {read=GetTop, write=SetTop, nodefault};
	virtual void __fastcall DefaultHandler(void *Message);
	__fastcall virtual TLMDFormCommonDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormCommonDialog(void);
	__property HWND Handle = {read=FHandle, nodefault};
	__property HWND DialogHandle = {read=FDialogHandle, nodefault};
	__property bool DialogShowing = {read=FDialogShowing, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property System::UnicodeString OkButtonCaption = {read=FOkButtonCaption, write=SetOkButtonCaption};
	__property System::UnicodeString CancelButtonCaption = {read=FCancelButtonCaption, write=SetCancelButtonCaption};
	__property System::UnicodeString HelpButtonCaption = {read=FHelpButtonCaption, write=SetHelpButtonCaption};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property bool Ctl3D = {read=FCtl3D, write=FCtl3D, default=1};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
};


enum DECLSPEC_DENUM TLMDFormOpenOption : unsigned char { ofReadOnly, ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofShareAware, ofNoReadOnlyReturn, ofNoTestFileCreate, ofNoNetworkButton, ofNoLongNames, ofNoDereferenceLinks };

typedef System::Set<TLMDFormOpenOption, TLMDFormOpenOption::ofReadOnly, TLMDFormOpenOption::ofNoDereferenceLinks> TLMDFormOpenOptions;

enum DECLSPEC_DENUM TLMDFileEditStyle : unsigned char { fsEdit, fsComboBox };

enum DECLSPEC_DENUM TLMDVisibleControls : unsigned char { ccOkButton, ccCancelButton, ccHelpButton, ccFolderCombo, ccFileNameEdit, ccFileTypeComboBox, ccReadOnlyCheckBox, ccLookInLabel, ccFileNameLabel, ccFileTypeLabel };

typedef System::Set<TLMDVisibleControls, TLMDVisibleControls::ccOkButton, TLMDVisibleControls::ccFileTypeLabel> TLMDVisibleControlsSet;

class PASCALIMPLEMENTATION TLMDFormOpenDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	System::Classes::TStrings* FHistoryList;
	TLMDFormOpenOptions FOptions;
	System::UnicodeString FFilter;
	int FFilterIndex;
	int FCurrentFilterIndex;
	System::UnicodeString FInitialDir;
	System::UnicodeString FDefaultExt;
	System::UnicodeString FFileName;
	System::Classes::TStrings* FFiles;
	TLMDFileEditStyle FFileEditStyle;
	TLMDVisibleControlsSet FVisibleControls;
	System::Classes::TNotifyEvent FOnSelectionChange;
	System::Classes::TNotifyEvent FOnFolderChange;
	System::Classes::TNotifyEvent FOnTypeChange;
	Vcl::Forms::TCloseQueryEvent FOnFileOk;
	System::Classes::TNotifyEvent FOnShareViolation;
	System::Uitypes::TOpenOptionsEx FOptionsEx;
	virtual NativeUInt __fastcall GetDialogTemplateHandle(void);
	System::UnicodeString __fastcall GetFileName(void);
	int __fastcall GetFilterIndex(void);
	System::Classes::TStrings* __fastcall GetFiles(void);
	void __fastcall ReadFileEditStyle(System::Classes::TReader* Reader);
	void __fastcall SetHistoryList(System::Classes::TStrings* Value);
	void __fastcall SetInitialDir(const System::UnicodeString Value);
	void __fastcall SetDefaultExt(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	System::LongBool __fastcall DoExecute(TDialogFunc Func);
	void __fastcall SetVisibleControls(TLMDVisibleControlsSet Controls);
	System::UnicodeString __fastcall GetDirectory(void);
	void __fastcall UpdateFiles(void);
	HWND __fastcall GetToolBarHandle(void);
	virtual void __fastcall DoShow(void);
	virtual void __fastcall DoSelectionChange(void);
	virtual void __fastcall DoFolderChange(void);
	virtual void __fastcall DoTypeChange(void);
	virtual bool __fastcall DoFileOk(void);
	void __fastcall DoShareViolation(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormOpenDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormOpenDialog(void);
	virtual bool __fastcall Execute(void);
	void __fastcall ToolBarButtonClick(int N);
	void __fastcall ShowToolBar(bool Value);
	__property TLMDFileEditStyle FileEditStyle = {read=FFileEditStyle, write=FFileEditStyle, nodefault};
	__property System::Classes::TStrings* Files = {read=GetFiles};
	__property System::UnicodeString Directory = {read=GetDirectory};
	__property System::Classes::TStrings* HistoryList = {read=FHistoryList, write=SetHistoryList};
	__property DialogHandle;
	__property DialogShowing;
	
__published:
	__property Ctl3D = {default=1};
	__property System::UnicodeString DefaultExt = {read=FDefaultExt, write=SetDefaultExt};
	__property System::UnicodeString FileName = {read=GetFileName, write=FFileName};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property int FilterIndex = {read=GetFilterIndex, write=FFilterIndex, default=1};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=SetInitialDir};
	__property TLMDFormOpenOptions Options = {read=FOptions, write=FOptions, default=4};
	__property TLMDVisibleControlsSet VisibleControls = {read=FVisibleControls, write=SetVisibleControls, default=1023};
	__property HelpContext = {default=0};
	__property System::Classes::TNotifyEvent OnFolderChange = {read=FOnFolderChange, write=FOnFolderChange};
	__property System::Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property System::Classes::TNotifyEvent OnTypeChange = {read=FOnTypeChange, write=FOnTypeChange};
	__property Vcl::Forms::TCloseQueryEvent OnFileOK = {read=FOnFileOk, write=FOnFileOk};
	__property OnHelp;
	__property System::Classes::TNotifyEvent OnShareViolation = {read=FOnShareViolation, write=FOnShareViolation};
	__property System::Uitypes::TOpenOptionsEx OptionsEx = {read=FOptionsEx, write=FOptionsEx, default=1};
};


class PASCALIMPLEMENTATION TLMDFormSaveDialog : public TLMDFormOpenDialog
{
	typedef TLMDFormOpenDialog inherited;
	
public:
	__fastcall virtual TLMDFormSaveDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void);
public:
	/* TLMDFormOpenDialog.Destroy */ inline __fastcall virtual ~TLMDFormSaveDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDFormColorDialogOption : unsigned char { cdShowHelp, cdSolidColor, cdAnyColor };

typedef System::Set<TLMDFormColorDialogOption, TLMDFormColorDialogOption::cdShowHelp, TLMDFormColorDialogOption::cdAnyColor> TLMDFormColorDialogOptions;

typedef System::StaticArray<int, 16> TLMDCustomColors;

class PASCALIMPLEMENTATION TLMDFormColorDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	System::Classes::TNotifyEvent FOnColorChange;
	System::Uitypes::TColor FColor;
	TLMDFormColorDialogOptions FOptions;
	System::Classes::TStrings* FCustomColors;
	void __fastcall SetCustomColors(System::Classes::TStrings* Value);
	System::Uitypes::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall UpdateColor(void);
	
protected:
	virtual void __fastcall DoShow(void);
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormColorDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormColorDialog(void);
	virtual bool __fastcall Execute(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=0};
	__property Ctl3D = {default=0};
	__property System::Classes::TStrings* CustomColors = {read=FCustomColors, write=SetCustomColors};
	__property TLMDFormColorDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property System::Classes::TNotifyEvent OnColorChange = {read=FOnColorChange, write=FOnColorChange};
};


enum DECLSPEC_DENUM TLMDFormFontDialogOption : unsigned char { fdAnsiOnly, fdTrueTypeOnly, fdEffects, fdFixedPitchOnly, fdForceFontExist, fdNoFaceSel, fdNoOEMFonts, fdNoSimulations, fdNoSizeSel, fdNoStyleSel, fdNoVectorFonts, fdShowHelp, fdWysiwyg, fdLimitSize, fdScalableOnly, fdApplyButton };

typedef System::Set<TLMDFormFontDialogOption, TLMDFormFontDialogOption::fdAnsiOnly, TLMDFormFontDialogOption::fdApplyButton> TLMDFormFontDialogOptions;

enum DECLSPEC_DENUM TLMDFormFontDialogDevice : unsigned char { fdScreen, fdPrinter, fdBoth };

typedef void __fastcall (__closure *TLMDFormDialogApplyEvent)(System::TObject* Sender);

class PASCALIMPLEMENTATION TLMDFormFontDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	System::UnicodeString FSampleCaption;
	TLMDFormFontDialogDevice FDevice;
	TLMDFormFontDialogOptions FOptions;
	TLMDFormDialogApplyEvent FOnApply;
	System::Classes::TNotifyEvent FOnFontChange;
	int FMinFontSize;
	int FMaxFontSize;
	void __fastcall DoApply(HWND Wnd);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall UpdateFromLogFont(const tagLOGFONTW &LogFont);
	
protected:
	virtual void __fastcall Apply(HWND Wnd);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall ValidateBounds(void);
	void __fastcall SetSampleCaption(System::UnicodeString Value);
	virtual void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDFormFontDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormFontDialog(void);
	virtual bool __fastcall Execute(void);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TLMDFormFontDialogDevice Device = {read=FDevice, write=FDevice, default=0};
	__property int MinFontSize = {read=FMinFontSize, write=FMinFontSize, nodefault};
	__property int MaxFontSize = {read=FMaxFontSize, write=FMaxFontSize, nodefault};
	__property System::UnicodeString SampleCaption = {read=FSampleCaption, write=SetSampleCaption};
	__property TLMDFormFontDialogOptions Options = {read=FOptions, write=FOptions, default=4};
	__property TLMDFormDialogApplyEvent OnApply = {read=FOnApply, write=FOnApply};
	__property System::Classes::TNotifyEvent OnFontChange = {read=FOnFontChange, write=FOnFontChange};
};


enum DECLSPEC_DENUM TLMDPageSetupOption : unsigned char { poDefaultMinMargins, poDisableMargins, poDisableOrientation, poDisablePagePainting, poDisablePaper, poDisablePrinter, poNoWarning, poShowHelp };

typedef System::Set<TLMDPageSetupOption, TLMDPageSetupOption::poDefaultMinMargins, TLMDPageSetupOption::poShowHelp> TLMDPageSetupOptions;

enum DECLSPEC_DENUM TLMDPaperType : unsigned char { ptPaper, ptEnvelope };

enum DECLSPEC_DENUM TLMDPaperOrientation : unsigned char { poPortrait, poLandscape };

enum DECLSPEC_DENUM TLMDPrinterType : unsigned char { ptDotMatrix, ptHPPCL };

enum DECLSPEC_DENUM TLMDPaintWhat : unsigned char { pwFullPage, pwMinimumMargins, pwMargins, pwGreekText, pwEnvStamp, pwYAFullPage };

enum DECLSPEC_DENUM TLMDMeasurements : unsigned char { pmMillimeters, pmInches };

typedef bool __fastcall (__closure *TLMDPaintPageEvent)(System::TObject* Sender, TLMDPaintWhat PaintWhat, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);

typedef void __fastcall (__closure *TLMDOnPrinterClickEvent)(System::TObject* Sender, bool &ShowPrinters);

class PASCALIMPLEMENTATION TLMDFormPageSetupDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	TLMDPageSetupOptions FOptions;
	System::Types::TPoint FPaperSize;
	System::Types::TRect FMinimumMargins;
	System::Types::TRect FMargins;
	TLMDMeasurements FMeasurements;
	TLMDOnPrinterClickEvent FOnPrinter;
	TLMDPaintPageEvent FOnPaintPage;
	bool __fastcall DoPrinter(void);
	bool __fastcall DoExecute(TDialogFunc Func);
	
protected:
	virtual bool __fastcall Printer(void);
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDFormPageSetupDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormPageSetupDialog(void);
	virtual bool __fastcall Execute(void);
	void __fastcall RedrawPage(void);
	__property System::Types::TPoint PaperSize = {read=FPaperSize, write=FPaperSize};
	__property System::Types::TRect MinimumMargins = {read=FMinimumMargins, write=FMinimumMargins};
	__property System::Types::TRect Margins = {read=FMargins, write=FMargins};
	
__published:
	__property TLMDPageSetupOptions Options = {read=FOptions, write=FOptions, default=129};
	__property TLMDMeasurements Measurements = {read=FMeasurements, write=FMeasurements, default=1};
	__property TLMDOnPrinterClickEvent OnPrinter = {read=FOnPrinter, write=FOnPrinter};
	__property TLMDPaintPageEvent OnPaintPage = {read=FOnPaintPage, write=FOnPaintPage};
};


class PASCALIMPLEMENTATION TLMDFormPrinterSetupDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
protected:
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDFormPrinterSetupDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void);
public:
	/* TLMDFormCommonDialog.Destroy */ inline __fastcall virtual ~TLMDFormPrinterSetupDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDPrintRange : unsigned char { prAllPages, prSelection, prPageNums };

enum DECLSPEC_DENUM TLMDPrintDialogOption : unsigned char { poPrintToFile, poPageNums, poSelection, poWarning, poHelp, poDisablePrintToFile };

typedef System::Set<TLMDPrintDialogOption, TLMDPrintDialogOption::poPrintToFile, TLMDPrintDialogOption::poDisablePrintToFile> TLMDPrintDialogOptions;

class PASCALIMPLEMENTATION TLMDFormPrintCommDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	int FFromPage;
	int FToPage;
	bool FCollate;
	TLMDPrintDialogOptions FOptions;
	bool FPrintToFile;
	TLMDPrintRange FPrintRange;
	int FMinPage;
	int FMaxPage;
	int FCopies;
	
protected:
	void __fastcall SetNumCopies(int Value);
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDFormPrintCommDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void);
	
__published:
	__property bool Collate = {read=FCollate, write=FCollate, default=0};
	__property int Copies = {read=FCopies, write=SetNumCopies, default=0};
	__property int FromPage = {read=FFromPage, write=FFromPage, default=0};
	__property int MinPage = {read=FMinPage, write=FMinPage, default=0};
	__property int MaxPage = {read=FMaxPage, write=FMaxPage, default=0};
	__property TLMDPrintDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property bool PrintToFile = {read=FPrintToFile, write=FPrintToFile, default=0};
	__property TLMDPrintRange PrintRange = {read=FPrintRange, write=FPrintRange, default=0};
	__property int ToPage = {read=FToPage, write=FToPage, default=0};
public:
	/* TLMDFormCommonDialog.Destroy */ inline __fastcall virtual ~TLMDFormPrintCommDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDFormFolderDialogOption : unsigned char { bfFileSysDirsOnly, bfDontGoBelowDomain, bfStatusText, bfFileSysAncestors, bfBrowseForComputer, bfBrowseForPrinter, bfShowPathInStatusArea };

typedef System::Set<TLMDFormFolderDialogOption, TLMDFormFolderDialogOption::bfFileSysDirsOnly, TLMDFormFolderDialogOption::bfShowPathInStatusArea> TLMDFormFolderDialogOptions;

enum DECLSPEC_DENUM TLMDFormShellFolder : unsigned char { sfoDesktopExpanded, sfoDesktop, sfoPrograms, sfoControlPanel, sfoPrinters, sfoPersonal, sfoFavorites, sfoStartup, sfoRecent, sfoSendto, sfoRecycleBin, sfoStartMenu, sfoDesktopDirectory, sfoMyComputer, sfoNetwork, sfoNetworkNeighborhood, sfoFonts, sfoTemplates, sfoCommonStartMenu, sfoCommonPrograms, sfoCommonStartup, sfoCommonDesktopDirectory, sfoAppData, sfoPrintHood };

class PASCALIMPLEMENTATION TLMDFormFolderDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	TLMDFormFolderDialogOptions FOptions;
	_ITEMIDLIST *FRootIDList;
	_ITEMIDLIST *FSelectionIDList;
	System::UnicodeString FDirectory;
	System::UnicodeString FSelectionPath;
	TLMDFormShellFolder FRootFolder;
	int FImageIndex;
	System::UnicodeString FDisplayName;
	System::UnicodeString FStatusText;
	System::UnicodeString FTitle;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetSelectionPath(System::UnicodeString Value);
	System::UnicodeString __fastcall GetDirectory(void);
	void __fastcall SetDirectory(System::UnicodeString Value);
	void __fastcall SetRootFolder(TLMDFormShellFolder Value);
	void __fastcall SetSelectionPIDL(Winapi::Shlobj::PItemIDList Value);
	void __fastcall SetOptions(TLMDFormFolderDialogOptions Value);
	void __fastcall SetStatusText(const System::UnicodeString Value);
	void __fastcall SetTitle(System::UnicodeString Value);
	
protected:
	virtual void __fastcall ValidateBounds(void);
	void __fastcall ReplaceSelection(Winapi::Shlobj::PItemIDList PIDL);
	virtual void __fastcall DoShow(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall BFFMInitialized(NativeUInt Param);
	void __fastcall BFFMSelChanged(NativeUInt Param);
	
public:
	__fastcall virtual TLMDFormFolderDialog(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void);
	void __fastcall EnableOK(const bool Value);
	__property System::UnicodeString DisplayName = {read=FDisplayName};
	__property System::UnicodeString SelectionPath = {read=FSelectionPath, write=SetSelectionPath};
	__property System::UnicodeString Directory = {read=GetDirectory, write=SetDirectory};
	__property Winapi::Shlobj::PItemIDList SelectionPIDL = {read=FSelectionIDList, write=SetSelectionPIDL};
	__property Winapi::Shlobj::PItemIDList RootPIDL = {read=FRootIDList};
	__property System::UnicodeString StatusText = {read=FStatusText, write=SetStatusText};
	
__published:
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property TLMDFormShellFolder RootFolder = {read=FRootFolder, write=SetRootFolder, default=0};
	__property TLMDFormFolderDialogOptions Options = {read=FOptions, write=SetOptions, default=69};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TLMDFormCommonDialog.Destroy */ inline __fastcall virtual ~TLMDFormFolderDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDFormOLEDialog : public TLMDFormCommonDialog
{
	typedef TLMDFormCommonDialog inherited;
	
private:
	int FErrorCode;
	
protected:
	virtual void __fastcall DoShow(void);
	
public:
	virtual System::UnicodeString __fastcall ErrorCodeAsStr(void);
	__property int ErrorCode = {read=FErrorCode, nodefault};
public:
	/* TLMDFormCommonDialog.Create */ inline __fastcall virtual TLMDFormOLEDialog(System::Classes::TComponent* AOwner) : TLMDFormCommonDialog(AOwner) { }
	/* TLMDFormCommonDialog.Destroy */ inline __fastcall virtual ~TLMDFormOLEDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDChangeIconSelect : unsigned char { cisDefault, cisCurrent, cisFromFile };

class PASCALIMPLEMENTATION TLMDFormChangeIconDialog : public TLMDFormOLEDialog
{
	typedef TLMDFormOLEDialog inherited;
	
private:
	TLMDChangeIconSelect FSelection;
	bool FShowHelp;
	bool FUseIconEXE;
	Vcl::Graphics::TMetafile* FMetafile;
	GUID FClsID;
	System::UnicodeString FEXEName;
	void __fastcall SetMetafile(Vcl::Graphics::TMetafile* const Value);
	
protected:
	virtual void __fastcall ValidateBounds(void);
	virtual void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDFormChangeIconDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormChangeIconDialog(void);
	virtual bool __fastcall Execute(void);
	virtual System::UnicodeString __fastcall ErrorCodeAsStr(void);
	__property Vcl::Graphics::TMetafile* Metafile = {read=FMetafile, write=SetMetafile};
	__property GUID ClsID = {read=FClsID, write=FClsID};
	
__published:
	__property TLMDChangeIconSelect Selection = {read=FSelection, write=FSelection, nodefault};
	__property bool ShowHelp = {read=FShowHelp, write=FShowHelp, nodefault};
	__property bool UseIconEXE = {read=FUseIconEXE, write=FUseIconEXE, nodefault};
	__property System::UnicodeString EXEName = {read=FEXEName, write=FEXEName};
};


enum DECLSPEC_DENUM TLMDInsertObjectOption : unsigned char { iofShowHelp, iofCheckLink, iofCheckDisplayAsIcon, iofCreateNewObject, iofCreateFileObject, iofCreateLinkObject, iofDisableLink, iofVerifyServerExists, iofDisableDisplayAsIcon, iofHideChangeIcon, iofShowInsertControl };

typedef System::Set<TLMDInsertObjectOption, TLMDInsertObjectOption::iofShowHelp, TLMDInsertObjectOption::iofShowInsertControl> TLMDInsertObjectOptions;

enum DECLSPEC_DENUM TLMDIOSelectedOption : unsigned char { iosCreateNew, iosCreateFromFile, iosCreateControl };

class PASCALIMPLEMENTATION TLMDFormInsertObjectDialog : public TLMDFormOLEDialog
{
	typedef TLMDFormOLEDialog inherited;
	
private:
	TLMDInsertObjectOptions FOptions;
	TLMDIOSelectedOption FSelected;
	GUID FClsId;
	System::UnicodeString FFileName;
	System::Classes::TList* FExcludeList;
	GUID FIID;
	int FOLERender;
	tagFORMATETC FFormatEtc;
	_di_IOleClientSite FIOLEClientSite;
	_di_IStorage FIStorage;
	void *FObject;
	int FSC;
	Vcl::Graphics::TMetafile* FMetafile;
	
protected:
	virtual void __fastcall ValidateBounds(void);
	
public:
	__fastcall virtual TLMDFormInsertObjectDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormInsertObjectDialog(void);
	virtual System::UnicodeString __fastcall ErrorCodeAsStr(void);
	virtual bool __fastcall Execute(void);
	__property GUID ClsID = {read=FClsId};
	__property System::UnicodeString FileName = {read=FFileName};
	__property System::Classes::TList* ExcludeList = {read=FExcludeList};
	__property GUID IID = {read=FIID, write=FIID};
	__property int OleRender = {read=FOLERender, write=FOLERender, nodefault};
	__property tagFORMATETC FormatEtc = {read=FFormatEtc, write=FFormatEtc};
	__property _di_IOleClientSite IOLECLientSite = {read=FIOLEClientSite, write=FIOLEClientSite};
	__property _di_IStorage IStorage = {read=FIStorage, write=FIStorage};
	__property void * PObject = {read=FObject};
	__property int SC = {read=FSC, nodefault};
	__property Vcl::Graphics::TMetafile* Metafile = {read=FMetafile};
	
__published:
	__property TLMDInsertObjectOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property TLMDIOSelectedOption Selected = {read=FSelected, write=FSelected, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxCustomColors = System::Int8(0x10);
#define DefaultVisibleControls (System::Set<TLMDVisibleControls, TLMDVisibleControls::ccOkButton, TLMDVisibleControls::ccFileTypeLabel>() << TLMDVisibleControls::ccOkButton << TLMDVisibleControls::ccCancelButton << TLMDVisibleControls::ccHelpButton << TLMDVisibleControls::ccFolderCombo << TLMDVisibleControls::ccFileNameEdit << TLMDVisibleControls::ccFileTypeComboBox << TLMDVisibleControls::ccReadOnlyCheckBox << TLMDVisibleControls::ccLookInLabel << TLMDVisibleControls::ccFileNameLabel << TLMDVisibleControls::ccFileTypeLabel )
static const System::Int8 OFNEXNOPLACESBAR = System::Int8(0x1);
}	/* namespace Lmddlgex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDLGEX)
using namespace Lmddlgex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddlgexHPP
