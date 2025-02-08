// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwriched.pas' rev: 6.00

#ifndef wwrichedHPP
#define wwrichedHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CommCtrl.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <OleConst.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <OleDlg.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <OleCtnrs.hpp>	// Pascal unit
#include <wwrichole.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <wwTrackIcon.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Wwintl.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <RichEdit.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
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

namespace Wwriched
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwRichEditWidth { rewWindowSize, rewPrinterSize };
#pragma option pop

typedef void __fastcall (__closure *TwwOnRichEditDlgEvent)(Forms::TForm* Form);

class DELPHICLASS TwwCustomRichEdit;
typedef void __fastcall (__closure *TwwURLOpenEvent)(TwwCustomRichEdit* Sender, AnsiString URLLink, bool &UseDefault);

#pragma option push -b-
enum TwwMeasurementUnits { muInches, muCentimeters };
#pragma option pop

#pragma option push -b-
enum TwwRichEditParaOption { rpoAlignment, rpoBullet, rpoLeftIndent, rpoRightIndent, rpoFirstLineIndent, rpoTabs, rpoSpaceBefore, rpoSpaceAfter, rpoLineSpacing };
#pragma option pop

#pragma option push -b-
enum TwwRichEditOleOption { reoAdjustPopupMenu, reoDisableOLE };
#pragma option pop

typedef Set<TwwRichEditOleOption, reoAdjustPopupMenu, reoDisableOLE>  TwwRichEditOleOptions;

#pragma option push -b-
enum TwwRichEditCopyMethod { recmByMemory, recmByTempFile };
#pragma option pop

typedef Set<TwwRichEditParaOption, rpoAlignment, rpoLineSpacing>  TwwRichEditParaOptions;

#pragma option push -b-
enum TwwRichEditPopupOption { rpoPopupEdit, rpoPopupCut, rpoPopupCopy, rpoPopupPaste, rpoPopupBold, rpoPopupItalic, rpoPopupUnderline, rpoPopupFont, rpoPopupBullet, rpoPopupParagraph, rpoPopupTabs, rpoPopupFind, rpoPopupReplace, rpoPopupInsertObject, rpoPopupMSWordSpellCheck };
#pragma option pop

typedef Set<TwwRichEditPopupOption, rpoPopupEdit, rpoPopupMSWordSpellCheck>  TwwRichEditPopupOptions;

#pragma option push -b-
enum TwwRichEditOption { reoShowLoad, reoShowSaveAs, reoShowSaveExit, reoShowPrint, reoShowPageSetup, reoShowFormatBar, reoShowToolBar, reoShowStatusBar, reoShowHints, reoShowRuler, reoShowInsertObject, reoCloseOnEscape, reoFlatButtons, reoShowSpellCheck, reoShowMainMenuIcons, reoShowJustifyButton, reoUseBackColor, reoNoConfirmation };
#pragma option pop

typedef Set<TwwRichEditOption, reoShowLoad, reoNoConfirmation>  TwwRichEditOptions;

#pragma option push -b-
enum TwwRichSelection { wwstText, wwstObject, wwstMultiChar, wwstMultiObject };
#pragma option pop

typedef Set<TwwRichSelection, wwstText, wwstMultiObject>  TwwRichSelectionType;

class DELPHICLASS TwwPrintMargins;
class PASCALIMPLEMENTATION TwwPrintMargins : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	double FTop;
	double FBottom;
	double FLeft;
	double FRight;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual TwwPrintMargins(Classes::TComponent* AOwner);
	
__published:
	__property double Top = {read=FTop, write=FTop};
	__property double Bottom = {read=FBottom, write=FBottom};
	__property double Left = {read=FLeft, write=FLeft};
	__property double Right = {read=FRight, write=FRight};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwPrintMargins(void) { }
	#pragma option pop
	
};


#pragma pack(push, 4)
struct TwwParaFormat2
{
	unsigned cbSize;
	unsigned dwMask;
	Word wNumbering;
	Word wReserved;
	int dxStartIndent;
	int dxRightIndent;
	int dxOffset;
	Word wAlignment;
	short cTabCount;
	int rgxTabs[32];
	int dySpaceBefore;
	int dySpaceAfter;
	int dyLineSpacing;
	short sStyle;
	Byte bLineSpacingRule;
	Byte bCRC;
	Word wShadingWeight;
	Word wShadingStyle;
	Word wNumberingStart;
	Word wNumberingStyle;
	Word wNumberingTab;
	Word wBorderSpace;
	Word wBorderWidth;
	Word wBorders;
} ;
#pragma pack(pop)

typedef void __fastcall (__closure *TwwRTFNotifyEvent)(Forms::TForm* Form, TwwCustomRichEdit* RichEdit, bool &DoDefault);

class PASCALIMPLEMENTATION TwwCustomRichEdit : public Comctrls::TCustomRichEdit 
{
	typedef Comctrls::TCustomRichEdit inherited;
	
private:
	bool FAutoURLDetect;
	bool FAutoSelect;
	TwwURLOpenEvent FOnURLOpen;
	unsigned FLibHandle;
	bool FWordWrap;
	TwwPrintMargins* FPrintMargins;
	int FPrintPageSize;
	TwwRichEditWidth FEditWidth;
	int StartingFindPos;
	bool InResetToStart;
	Menus::TMenuItem* PopupEdit;
	Menus::TMenuItem* PopupCut;
	Menus::TMenuItem* PopupCopy;
	Menus::TMenuItem* PopupPaste;
	Menus::TMenuItem* PopupBold;
	Menus::TMenuItem* PopupItalic;
	Menus::TMenuItem* PopupUnderline;
	Menus::TMenuItem* PopupFont;
	Menus::TMenuItem* PopupBullet;
	Menus::TMenuItem* PopupParagraph;
	Menus::TMenuItem* PopupTabs;
	Menus::TMenuItem* PopupFind;
	Menus::TMenuItem* PopupReplace;
	Menus::TMenuItem* PopupInsertObject;
	Menus::TMenuItem* PopupSpellCheck;
	Menus::TMenuItem* PopupSep1;
	Menus::TMenuItem* PopupSep2;
	Menus::TMenuItem* PopupSep3;
	Menus::TMenuItem* PopupSep4;
	Menus::TMenuItem* PopupSep5;
	TwwRichEditPopupOptions FPopupOptions;
	TwwRichEditOptions FEditorOptions;
	AnsiString FEditorCaption;
	Wwtypes::TwwFormPosition* FEditorPosition;
	AnsiString LastSearchText;
	TwwMeasurementUnits FUnits;
	TwwOnRichEditDlgEvent FOnInitDialog;
	TwwOnRichEditDlgEvent FOnCloseDialog;
	TwwOnRichEditDlgEvent FOnCreateDialog;
	TwwRTFNotifyEvent FOnMenuLoadClick;
	TwwRTFNotifyEvent FOnMenuPrintClick;
	TwwRTFNotifyEvent FOnMenuSaveAsClick;
	TwwRTFNotifyEvent FOnMenuSaveAndExitClick;
	bool OrigHideSelection;
	TwwRichEditOleOptions FOLEOptions;
	_di_IOleObject FOleSelObject;
	TwwRichEditCopyMethod FRichEditCopyMethod;
	Buttons::TSpeedButton* FUserSpeedButton1;
	Buttons::TSpeedButton* FUserSpeedButton2;
	AnsiString FPrintJobName;
	Graphics::TColor FHighlightColor;
	Wwframe::TwwEditFrame* FFrame;
	bool FWantNavigationKeys;
	Controls::TControlCanvas* FCanvas;
	Controls::TWinControl* FPaintControl;
	Wwrichole::_di_IRichEditOle FRichEditOle;
	Wwrichole::_di_IRichEditOleCallback FRichEditOleCallback;
	Classes::TStringList* FObjectVerbs;
	Classes::TList* OleMenuItemList;
	bool InParentChanging;
	Classes::TStream* ReloadStream;
	bool UseReloadStream;
	bool NewDataFormat;
	bool URLDetectButtonPressed;
	Menus::TPopupMenu* FVerbMenu;
	bool InitEditRect;
	int FRichEditVersion;
	Classes::TStrings* FLines;
	AnsiString FTitle;
	bool InMouseUp;
	bool SkipChange;
	int FGutterWidth;
	int OldLineCount;
	int OldCharPos;
	int OrigWin32MajorVersion;
	void __fastcall FindDialog1Close(System::TObject* Sender);
	void __fastcall FindDialog1Find(System::TObject* Sender);
	void __fastcall FindReplaceDlg(Dialogs::TFindDialog* dialog, bool replace, AnsiString replaceStr);
	void __fastcall ReplaceDialog1Replace(System::TObject* Sender);
	void __fastcall PopupMenuPopup(System::TObject* Sender);
	void __fastcall PopupEditclick(System::TObject* Sender);
	void __fastcall PopupCutClick(System::TObject* Sender);
	void __fastcall PopupCopyClick(System::TObject* Sender);
	void __fastcall PopupPasteClick(System::TObject* Sender);
	void __fastcall PopupFontClick(System::TObject* Sender);
	void __fastcall PopupParagraphClick(System::TObject* Sender);
	void __fastcall PopupTabsClick(System::TObject* Sender);
	void __fastcall PopupBulletClick(System::TObject* Sender);
	void __fastcall PopupBoldClick(System::TObject* Sender);
	void __fastcall PopupItalicClick(System::TObject* Sender);
	void __fastcall PopupUnderlineClick(System::TObject* Sender);
	void __fastcall PopupFindClick(System::TObject* Sender);
	void __fastcall PopupReplaceClick(System::TObject* Sender);
	void __fastcall PopupInsertObjectClick(System::TObject* Sender);
	void __fastcall PopupSpellCheckClick(System::TObject* Sender);
	HIDESBASE void __fastcall SetWordWrap(bool val);
	void __fastcall SetPrintPageSize(int val);
	int __fastcall TwipsToPixels(int twips);
	HIDESBASE MESSAGE void __fastcall WMNCDestroy(Messages::TMessage &Msg);
	void __fastcall SetOleOptions(TwwRichEditOleOptions val);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	void __fastcall ReadVersion(Classes::TReader* Reader);
	void __fastcall WriteVersion(Classes::TWriter* Writer);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	void __fastcall URLLinkNotification(void * Link);
	void __fastcall SetAutoURLDetect(bool val);
	void __fastcall SetUserSpeedButton1(Buttons::TSpeedButton* val);
	void __fastcall SetUserSpeedButton2(Buttons::TSpeedButton* val);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE void __fastcall SetLines(Classes::TStrings* val);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Message);
	TwwRichSelectionType __fastcall GetSelectionType(void);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	void __fastcall SetTitle(const AnsiString Value);
	
protected:
	bool BoundMode;
	int ScreenPixelsPerInch;
	bool FFocused;
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall ClearSelectedBackgroundColor(void);
	virtual void __fastcall WriteState(Classes::TWriter* Writer);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	MESSAGE void __fastcall EMFormatRange(Messages::TMessage &msg);
	DYNAMIC void __fastcall SelectionChange(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &msg);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall BeginEditing(void);
	virtual void __fastcall UpdateField(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	void __fastcall DestroyVerbs(void);
	void __fastcall UpdateVerbs(void);
	void __fastcall PopupVerbMenuClick(System::TObject* Sender);
	void __fastcall ObjectPropertiesMenuClick(System::TObject* Sender);
	virtual bool __fastcall IsMemoLoaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual Db::TField* __fastcall GetField(void);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoURLOpen(AnsiString URLLink, bool &UseDefault);
	virtual void __fastcall LoadPacketsFromStream(Classes::TStream* Stream, bool AppendMode, int NumPackets = 0x0);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual bool __fastcall isTransparentEffective(void);
	virtual void __fastcall LoadMemo(void);
	virtual void __fastcall CreatePopup(void);
	virtual void __fastcall CreateRuntimeComponents(void);
	
public:
	TwwCustomRichEdit* DialogRichEdit;
	Forms::TForm* RichEditForm;
	Dialogs::TFindDialog* FindDialog1;
	Dialogs::TReplaceDialog* ReplaceDialog1;
	Dialogs::TFontDialog* FontDialog1;
	AnsiString FirstLineText;
	bool SkipPaint;
	bool SkipErase;
	Variant Patch;
	Menus::TPopupMenu* DefaultPopupMenu;
	bool BeforePopup;
	Graphics::TColor LastColor;
	int ClickTime;
	TwwRichEditWidth __fastcall EffectiveEditWidth(void);
	void __fastcall SetTextBackgroundColor(Graphics::TColor BackColor);
	Graphics::TColor __fastcall GetTextBackgroundColor(void);
	virtual int __fastcall FindTextBefore(const AnsiString SearchStr, int StartPos, int Length, Comctrls::TSearchTypes Options);
	virtual bool __fastcall InsertObjectDialog(void);
	virtual bool __fastcall ObjectPropertiesDialog(void);
	void __fastcall DoVerb(int Verb);
	__fastcall virtual TwwCustomRichEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwCustomRichEdit(void);
	virtual bool __fastcall Execute(void);
	virtual void __fastcall ExecuteFindDialog(void);
	virtual void __fastcall ExecuteReplaceDialog(void);
	virtual void __fastcall ExecuteFontDialog(void);
	virtual bool __fastcall ExecuteParagraphDialog(void);
	virtual void __fastcall ExecuteTabDialog(void);
	virtual void __fastcall FindNextMatch(void);
	virtual void __fastcall FindReplace(void);
	virtual bool __fastcall FindReplaceText(AnsiString SearchText, AnsiString ReplaceText, Comctrls::TSearchTypes SearchTypes);
	void __fastcall SetBullet(bool val);
	void __fastcall SetBold(bool val);
	void __fastcall SetItalic(bool val);
	void __fastcall SetUnderline(bool val);
	bool __fastcall CanPaste(void);
	HIDESBASE bool __fastcall CanUndo(void);
	bool __fastcall CanRedo(void);
	bool __fastcall CanCut(void);
	bool __fastcall CanFindNext(void);
	void __fastcall CopyRichEditFromBlob(Db::TField* Field);
	void __fastcall CopyRichEdittoBlob(Db::TField* Field);
	void __fastcall CopyRichEditTo(Comctrls::TCustomRichEdit* val);
	void __fastcall AppendRichEditFrom(Comctrls::TCustomRichEdit* val);
	void __fastcall SetRichEditFontAttributes(AnsiString FontName, int FontSize, Graphics::TFontStyles FontStyle, Graphics::TColor FontColor);
	void __fastcall SetStyleAttribute(Graphics::TFontStyle Attr, bool AttrOn);
	int __fastcall GetCharSetOfFontName(const AnsiString FaceName);
	void __fastcall GetParaIndent(int &LeftIndent, int &RightIndent, int &FirstIndent);
	void __fastcall SetParaFormat(TwwRichEditParaOptions Options, AnsiString alignment, bool bulletStyle, int leftindent, int rightindent, int firstlineindent, int tabCount, void * tabArray, int SpaceBefore, int SpaceAfter, int LineSpacing, int LineSpacingRule);
	AnsiString __fastcall GetRTFText();
	Types::TRect __fastcall GetPrinterRect();
	void __fastcall GetParaFormat(TwwParaFormat2 &Format);
	int __fastcall UnitStrToTwips(AnsiString str);
	int __fastcall UnitsToTwips(double val);
	AnsiString __fastcall FormatUnitStr(double val);
	AnsiString __fastcall RoundedFormatUnitStr(double units, int intervals);
	double __fastcall TwipsToUnits(int val);
	virtual void __fastcall DoInitDialog(Forms::TForm* Form);
	virtual void __fastcall DoCloseDialog(Forms::TForm* Form);
	virtual void __fastcall DoCreateDialog(Forms::TForm* Form);
	void __fastcall SetEditRect(void);
	virtual void __fastcall Print(const AnsiString Caption);
	void __fastcall UpdatePrinter(void);
	Classes::TStrings* __fastcall ILines(void);
	virtual bool __fastcall MSWordSpellChecker(void);
	virtual bool __fastcall MSWordPrintDocument(AnsiString TemplateFileName);
	void __fastcall GetRTFSelection(Classes::TStream* DestStream);
	void __fastcall PutRTFSelection(Classes::TStream* SourceStream);
	void __fastcall Import(AnsiString Format, AnsiString FileName);
	void __fastcall Export(AnsiString Format, AnsiString FileName);
	__property Db::TField* Field = {read=GetField};
	__property _di_IOleObject OleSelObject = {read=FOleSelObject};
	__property Wwrichole::_di_IRichEditOle RichEditOle = {read=FRichEditOle};
	__property Wwrichole::_di_IRichEditOleCallback RichEditOleCallback = {read=FRichEditOleCallback};
	__property TwwRichEditPopupOptions PopupOptions = {read=FPopupOptions, write=FPopupOptions, default=32655};
	__property TwwRichEditOptions EditorOptions = {read=FEditorOptions, write=FEditorOptions, default=32764};
	__property int RichEditVersion = {read=FRichEditVersion, write=FRichEditVersion, nodefault};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, default=65535};
	__property AnsiString EditorCaption = {read=FEditorCaption, write=FEditorCaption};
	__property TwwMeasurementUnits MeasurementUnits = {read=FUnits, write=FUnits, nodefault};
	__property TwwOnRichEditDlgEvent OnInitDialog = {read=FOnInitDialog, write=FOnInitDialog};
	__property TwwOnRichEditDlgEvent OnCloseDialog = {read=FOnCloseDialog, write=FOnCloseDialog};
	__property TwwOnRichEditDlgEvent OnCreateDialog = {read=FOnCreateDialog, write=FOnCreateDialog};
	__property TwwPrintMargins* PrintMargins = {read=FPrintMargins, write=FPrintMargins};
	__property TwwRichEditWidth EditWidth = {read=FEditWidth, write=FEditWidth, default=0};
	__property Wwtypes::TwwFormPosition* EditorPosition = {read=FEditorPosition, write=FEditorPosition};
	__property int PrintPageSize = {read=FPrintPageSize, write=SetPrintPageSize, default=1};
	__property TwwRichEditOleOptions OleOptions = {read=FOLEOptions, write=SetOleOptions, default=1};
	__property TwwRichEditCopyMethod RichEditCopyMethod = {read=FRichEditCopyMethod, write=FRichEditCopyMethod, default=0};
	__property bool AutoURLDetect = {read=FAutoURLDetect, write=SetAutoURLDetect, nodefault};
	__property bool AutoSelect = {read=FAutoSelect, write=FAutoSelect, default=0};
	__property TwwURLOpenEvent OnURLOpen = {read=FOnURLOpen, write=FOnURLOpen};
	__property Buttons::TSpeedButton* UserSpeedButton1 = {read=FUserSpeedButton1, write=SetUserSpeedButton1};
	__property Buttons::TSpeedButton* UserSpeedButton2 = {read=FUserSpeedButton2, write=SetUserSpeedButton2};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property PlainText  = {default=0};
	__property Wwframe::TwwEditFrame* Frame = {read=FFrame, write=FFrame};
	__property AnsiString PrintJobName = {read=FPrintJobName, write=FPrintJobName};
	__property int GutterWidth = {read=FGutterWidth, write=FGutterWidth, default=3};
	__property TwwRichSelectionType SelectionType = {read=GetSelectionType, nodefault};
	__property bool WantNavigationKeys = {read=FWantNavigationKeys, write=FWantNavigationKeys, default=0};
	__property AnsiString Title = {read=FTitle, write=SetTitle};
	__property TwwRTFNotifyEvent OnMenuLoadClick = {read=FOnMenuLoadClick, write=FOnMenuLoadClick};
	__property TwwRTFNotifyEvent OnMenuPrintClick = {read=FOnMenuPrintClick, write=FOnMenuPrintClick};
	__property TwwRTFNotifyEvent OnMenuSaveAsClick = {read=FOnMenuSaveAsClick, write=FOnMenuSaveAsClick};
	__property TwwRTFNotifyEvent OnMenuSaveAndExitClick = {read=FOnMenuSaveAndExitClick, write=FOnMenuSaveAndExitClick};
	
__published:
	__property ScrollBars  = {default=0};
	__property Classes::TStrings* Lines = {read=FLines, write=SetLines, stored=false};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomRichEdit(HWND ParentWindow) : Comctrls::TCustomRichEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwRulerPanel;
class PASCALIMPLEMENTATION TwwRulerPanel : public Extctrls::TPanel 
{
	typedef Extctrls::TPanel inherited;
	
private:
	int __fastcall TwipsToPixels(int Twips);
	int __fastcall PrinterPixelsToTwipsX(int pixels);
	int __fastcall PixelsToTwipsX(int pixels);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	#pragma pack(push, 1)
	Types::TRect RulerRect;
	#pragma pack(pop)
	
	Wwtrackicon::TwwTrackIcon* LeftDragButton;
	Wwtrackicon::TwwTrackIcon* RightDragButton;
	Wwtrackicon::TwwTrackIcon* FirstLineDragButton;
	void __fastcall UpdateDragIcons(void);
	void __fastcall UpdateSize(TwwCustomRichEdit* DialogRichEdit);
	void __fastcall UpdateRulerProp(System::TObject* Sender);
public:
	#pragma option push -w-inl
	/* TCustomPanel.Create */ inline __fastcall virtual TwwRulerPanel(Classes::TComponent* AOwner) : Extctrls::TPanel(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TwwRulerPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwRulerPanel(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBRichEdit;
class PASCALIMPLEMENTATION TwwDBRichEdit : public TwwCustomRichEdit 
{
	typedef TwwCustomRichEdit inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FAutoDisplay;
	bool FMemoLoaded;
	AnsiString FDataSave;
	bool __fastcall isBlob(void);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall SetAutoDisplay(bool Value);
	void __fastcall SetFocused(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	virtual void __fastcall BeginEditing(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall UpdateField(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall CreateWnd(void);
	virtual bool __fastcall IsMemoLoaded(void);
	virtual Db::TField* __fastcall GetField(void);
	
public:
	__fastcall virtual TwwDBRichEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBRichEdit(void);
	virtual void __fastcall LoadMemo(void);
	void __fastcall LoadBlobStart(Db::TField* Field, int NumPackets = 0x2);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	
__published:
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property AutoURLDetect ;
	__property AutoSelect  = {default=0};
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property Color  = {default=-16777211};
	__property Ctl3D ;
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Frame ;
	__property GutterWidth  = {default=3};
	__property HideSelection  = {default=1};
	__property HideScrollBars  = {default=1};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property MaxLength  = {default=0};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property OleOptions  = {default=1};
	__property PrintPageSize  = {default=1};
	__property UserSpeedButton1 ;
	__property UserSpeedButton2 ;
	__property HighlightColor  = {default=65535};
	__property Title ;
	__property PopupMenu ;
	__property PrintJobName ;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property WantReturns  = {default=1};
	__property WantTabs  = {default=0};
	__property WantNavigationKeys  = {default=0};
	__property WordWrap  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResizeRequest ;
	__property OnSelectionChange ;
	__property OnProtectChange ;
	__property OnSaveClipboard ;
	__property OnStartDrag ;
	__property PopupOptions  = {default=32655};
	__property EditorOptions  = {default=32764};
	__property EditorCaption ;
	__property EditorPosition ;
	__property MeasurementUnits ;
	__property PrintMargins ;
	__property EditWidth  = {default=0};
	__property OnInitDialog ;
	__property OnCloseDialog ;
	__property OnCreateDialog ;
	__property OnURLOpen ;
	__property OnMenuLoadClick ;
	__property OnMenuPrintClick ;
	__property OnMenuSaveAsClick ;
	__property OnMenuSaveAndExitClick ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBRichEdit(HWND ParentWindow) : TwwCustomRichEdit(ParentWindow) { }
	#pragma option pop
	
};


#pragma pack(push, 4)
struct TwwCharFormat2
{
	unsigned cbSize;
	int dwMask;
	int dwEffects;
	int yHeight;
	int yOffset;
	unsigned crTextColor;
	Byte bCharSet;
	Byte bPitchAndFamily;
	char szFaceName[32];
	Word wWeight;
	Shortint sSpacing;
	unsigned crBackColor;
	int lcid;
	int dwReserved;
	Shortint style;
	Word wKerning;
	Byte bUnderlineType;
	Byte bAnimation;
	Byte bRevAuthor;
	Byte bReserved1;
} ;
#pragma pack(pop)

class DELPHICLASS EwwRTFError;
class PASCALIMPLEMENTATION EwwRTFError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
private:
	int FErrorCode;
	
public:
	__fastcall EwwRTFError(AnsiString Message, int ErrCode);
	__property int ErrorCode = {read=FErrorCode, nodefault};
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EwwRTFError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EwwRTFError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EwwRTFError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EwwRTFError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EwwRTFError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EwwRTFError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EwwRTFError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EwwRTFError(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwriched)
static const Word wwTwipsPerInch = 0x5a0;
static const Shortint PFA_FULLJUSTIFY = 0x4;
extern PACKAGE bool __fastcall wwGetUniqueFileName(AnsiString &Filename);
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwriched */
using namespace Wwriched;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwriched
