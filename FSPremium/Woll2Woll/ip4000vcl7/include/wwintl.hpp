// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwintl.pas' rev: 6.00

#ifndef WwintlHPP
#define WwintlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Buttons.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwintl
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TwwPictureValidationError)(System::TObject* Sender, Db::TField* Field, AnsiString &Msg, bool &DoDefault);

class DELPHICLASS TwwUserMessagesIntl;
class PASCALIMPLEMENTATION TwwUserMessagesIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FwwDBGridDiscardChanges;
	AnsiString FPictureValidateError;
	AnsiString FLocateNoMatches;
	AnsiString FLocateNoMoreMatches;
	AnsiString FMemoChangesWarning;
	AnsiString FRichEditExitWarning;
	AnsiString FRichEditClearWarning;
	AnsiString FRichEditSpellCheckComplete;
	AnsiString FRichEditMSWordNotFound;
	AnsiString FFilterDlgNoCriteria;
	AnsiString FRecordViewExitWarning;
	
__published:
	__property AnsiString wwDBGridDiscardChanges = {read=FwwDBGridDiscardChanges, write=FwwDBGridDiscardChanges};
	__property AnsiString PictureValidateError = {read=FPictureValidateError, write=FPictureValidateError};
	__property AnsiString LocateNoMatches = {read=FLocateNoMatches, write=FLocateNoMatches};
	__property AnsiString LocateNoMoreMatches = {read=FLocateNoMoreMatches, write=FLocateNoMoreMatches};
	__property AnsiString MemoChangesWarning = {read=FMemoChangesWarning, write=FMemoChangesWarning};
	__property AnsiString RichEditExitWarning = {read=FRichEditExitWarning, write=FRichEditExitWarning};
	__property AnsiString RichEditClearWarning = {read=FRichEditClearWarning, write=FRichEditClearWarning};
	__property AnsiString RichEditSpellCheckComplete = {read=FRichEditSpellCheckComplete, write=FRichEditSpellCheckComplete};
	__property AnsiString RichEditMSWordNotFound = {read=FRichEditMSWordNotFound, write=FRichEditMSWordNotFound};
	__property AnsiString FilterDlgNoCriteria = {read=FFilterDlgNoCriteria, write=FFilterDlgNoCriteria};
	__property AnsiString RecordViewExitWarning = {read=FRecordViewExitWarning, write=FRecordViewExitWarning};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwUserMessagesIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwUserMessagesIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwFilterDialogIntl;
class PASCALIMPLEMENTATION TwwFilterDialogIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FBtnViewSummary;
	AnsiString FBtnViewSummaryHint;
	AnsiString FViewSummaryNotText;
	AnsiString FBtnNewSearch;
	AnsiString FBtnNewSearchHint;
	AnsiString FFieldOrderLabel;
	AnsiString FFieldOrderHint;
	AnsiString FAlphabeticLabel;
	AnsiString FLogicalLabel;
	AnsiString FAllFieldsLabel;
	AnsiString FSearchedFieldsLabel;
	AnsiString FStartingRangeLabel;
	AnsiString FEndingRangeLabel;
	AnsiString FStartingRangeHint;
	AnsiString FEndingRangeHint;
	AnsiString FBtnClearMin;
	AnsiString FBtnClearMax;
	AnsiString FBtnClearFiltervalue;
	AnsiString FBtnClearMinHint;
	AnsiString FBtnClearMaxHint;
	AnsiString FBtnClearFilterValueHint;
	AnsiString FByValueLabel;
	AnsiString FByRangeLabel;
	AnsiString FFieldValueLabel;
	AnsiString FFieldValueHint;
	AnsiString FSearchTypeLabel;
	AnsiString FSearchTypeHint;
	AnsiString FMatchExactLabel;
	AnsiString FMatchStartLabel;
	AnsiString FMatchAnyLabel;
	AnsiString FCaseSensitiveLabel;
	AnsiString FCaseSensitiveHint;
	AnsiString FNonMatchingLabel;
	AnsiString FNonMatchingHint;
	AnsiString FSummaryFieldLabel;
	AnsiString FSummarySearchLabel;
	AnsiString FSummaryValueLabel;
	AnsiString FSummaryCaption;
	AnsiString FFieldsLabel;
	AnsiString FValueRangeTabHint;
	AnsiString FAllSearchedTabHint;
	
__published:
	__property AnsiString BtnViewSummary = {read=FBtnViewSummary, write=FBtnViewSummary};
	__property AnsiString BtnViewSummaryHint = {read=FBtnViewSummaryHint, write=FBtnViewSummaryHint};
	__property AnsiString BtnNewSearch = {read=FBtnNewSearch, write=FBtnNewSearch};
	__property AnsiString BtnNewSearchHint = {read=FBtnNewSearchHint, write=FBtnNewSearchHint};
	__property AnsiString FieldOrderLabel = {read=FFieldOrderLabel, write=FFieldOrderLabel};
	__property AnsiString FieldOrderHint = {read=FFieldOrderHint, write=FFieldOrderHint};
	__property AnsiString AlphabeticLabel = {read=FAlphabeticLabel, write=FAlphabeticLabel};
	__property AnsiString LogicalLabel = {read=FLogicalLabel, write=FLogicalLabel};
	__property AnsiString AllFieldsLabel = {read=FAllFieldsLabel, write=FAllFieldsLabel};
	__property AnsiString SearchedFieldsLabel = {read=FSearchedFieldsLabel, write=FSearchedFieldsLabel};
	__property AnsiString StartingRangeLabel = {read=FStartingRangeLabel, write=FStartingRangeLabel};
	__property AnsiString EndingRangeLabel = {read=FEndingRangeLabel, write=FEndingRangeLabel};
	__property AnsiString StartingRangeHint = {read=FStartingRangeHint, write=FStartingRangeHint};
	__property AnsiString EndingRangeHint = {read=FEndingRangeHint, write=FEndingRangeHint};
	__property AnsiString BtnClearMin = {read=FBtnClearMin, write=FBtnClearMin};
	__property AnsiString BtnClearMax = {read=FBtnClearMax, write=FBtnClearMax};
	__property AnsiString BtnClearFilterValue = {read=FBtnClearFiltervalue, write=FBtnClearFiltervalue};
	__property AnsiString BtnClearMinHint = {read=FBtnClearMinHint, write=FBtnClearMinHint};
	__property AnsiString BtnClearMaxHint = {read=FBtnClearMaxHint, write=FBtnClearMaxHint};
	__property AnsiString BtnClearFilterValueHint = {read=FBtnClearFilterValueHint, write=FBtnClearFilterValueHint};
	__property AnsiString ByValueLabel = {read=FByValueLabel, write=FByValueLabel};
	__property AnsiString ByRangeLabel = {read=FByRangeLabel, write=FByRangeLabel};
	__property AnsiString FieldValueLabel = {read=FFieldValueLabel, write=FFieldValueLabel};
	__property AnsiString FieldValueHint = {read=FFieldValueHint, write=FFieldValueHint};
	__property AnsiString SearchTypeLabel = {read=FSearchTypeLabel, write=FSearchTypeLabel};
	__property AnsiString SearchTypeHint = {read=FSearchTypeHint, write=FSearchTypeHint};
	__property AnsiString MatchExactLabel = {read=FMatchExactLabel, write=FMatchExactLabel};
	__property AnsiString MatchStartLabel = {read=FMatchStartLabel, write=FMatchStartLabel};
	__property AnsiString MatchAnyLabel = {read=FMatchAnyLabel, write=FMatchAnyLabel};
	__property AnsiString CaseSensitiveLabel = {read=FCaseSensitiveLabel, write=FCaseSensitiveLabel};
	__property AnsiString CaseSensitiveHint = {read=FCaseSensitiveHint, write=FCaseSensitiveHint};
	__property AnsiString NonMatchingLabel = {read=FNonMatchingLabel, write=FNonMatchingLabel};
	__property AnsiString NonMatchingHint = {read=FNonMatchingHint, write=FNonMatchingHint};
	__property AnsiString SummaryFieldLabel = {read=FSummaryFieldLabel, write=FSummaryFieldLabel};
	__property AnsiString SummarySearchLabel = {read=FSummarySearchLabel, write=FSummarySearchLabel};
	__property AnsiString SummaryValueLabel = {read=FSummaryValueLabel, write=FSummaryValueLabel};
	__property AnsiString SummaryCaption = {read=FSummaryCaption, write=FSummaryCaption};
	__property AnsiString FieldsLabel = {read=FFieldsLabel, write=FFieldsLabel};
	__property AnsiString ValueRangeTabHint = {read=FValueRangeTabHint, write=FValueRangeTabHint};
	__property AnsiString AllSearchedTabHint = {read=FAllSearchedTabHint, write=FAllSearchedTabHint};
	__property AnsiString ViewSummaryNotText = {read=FViewSummaryNotText, write=FViewSummaryNotText};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwFilterDialogIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwFilterDialogIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwRichEditMenuLabels;
class PASCALIMPLEMENTATION TwwRichEditMenuLabels : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FFileCaption;
	AnsiString FLoadCaption;
	AnsiString FSaveAsCaption;
	AnsiString FSaveExitCaption;
	AnsiString FPrintCaption;
	AnsiString FPageSetupCaption;
	AnsiString FExitCaption;
	AnsiString FEditCaption;
	AnsiString FUndoCaption;
	AnsiString FCutCaption;
	AnsiString FCopyCaption;
	AnsiString FPasteCaption;
	AnsiString FClearCaption;
	AnsiString FSelectallCaption;
	AnsiString FFindCaption;
	AnsiString FFindNextCaption;
	AnsiString FReplaceCaption;
	AnsiString FInsertObjectCaption;
	AnsiString FSpellCheckCaption;
	AnsiString FInsertCaption;
	AnsiString FRulerCaption;
	AnsiString FRedoCaption;
	AnsiString FViewCaption;
	AnsiString FToolbarCaption;
	AnsiString FFormatBarCaption;
	AnsiString FViewStatusBarCaption;
	AnsiString FOptionsCaption;
	AnsiString FFormatCaption;
	AnsiString FToolCaption;
	AnsiString FFontCaption;
	AnsiString FBulletStyleCaption;
	AnsiString FParagraphCaption;
	AnsiString FTabsCaption;
	AnsiString FHelpCaption;
	
__published:
	__property AnsiString FileCaption = {read=FFileCaption, write=FFileCaption};
	__property AnsiString LoadCaption = {read=FLoadCaption, write=FLoadCaption};
	__property AnsiString SaveAsCaption = {read=FSaveAsCaption, write=FSaveAsCaption};
	__property AnsiString SaveExitCaption = {read=FSaveExitCaption, write=FSaveExitCaption};
	__property AnsiString PrintCaption = {read=FPrintCaption, write=FPrintCaption};
	__property AnsiString PageSetupCaption = {read=FPageSetupCaption, write=FPageSetupCaption};
	__property AnsiString ExitCaption = {read=FExitCaption, write=FExitCaption};
	__property AnsiString EditCaption = {read=FEditCaption, write=FEditCaption};
	__property AnsiString UndoCaption = {read=FUndoCaption, write=FUndoCaption};
	__property AnsiString CutCaption = {read=FCutCaption, write=FCutCaption};
	__property AnsiString CopyCaption = {read=FCopyCaption, write=FCopyCaption};
	__property AnsiString PasteCaption = {read=FPasteCaption, write=FPasteCaption};
	__property AnsiString ClearCaption = {read=FClearCaption, write=FClearCaption};
	__property AnsiString SelectallCaption = {read=FSelectallCaption, write=FSelectallCaption};
	__property AnsiString FindCaption = {read=FFindCaption, write=FFindCaption};
	__property AnsiString FindNextCaption = {read=FFindNextCaption, write=FFindNextCaption};
	__property AnsiString ReplaceCaption = {read=FReplaceCaption, write=FReplaceCaption};
	__property AnsiString InsertObjectCaption = {read=FInsertObjectCaption, write=FInsertObjectCaption};
	__property AnsiString ToolCaption = {read=FToolCaption, write=FToolCaption};
	__property AnsiString SpellCheckCaption = {read=FSpellCheckCaption, write=FSpellCheckCaption};
	__property AnsiString InsertCaption = {read=FInsertCaption, write=FInsertCaption};
	__property AnsiString RulerCaption = {read=FRulerCaption, write=FRulerCaption};
	__property AnsiString RedoCaption = {read=FRedoCaption, write=FRedoCaption};
	__property AnsiString ViewCaption = {read=FViewCaption, write=FViewCaption};
	__property AnsiString ToolbarCaption = {read=FToolbarCaption, write=FToolbarCaption};
	__property AnsiString FormatBarCaption = {read=FFormatBarCaption, write=FFormatBarCaption};
	__property AnsiString ViewStatusBarCaption = {read=FViewStatusBarCaption, write=FViewStatusBarCaption};
	__property AnsiString OptionsCaption = {read=FOptionsCaption, write=FOptionsCaption};
	__property AnsiString FormatCaption = {read=FFormatCaption, write=FFormatCaption};
	__property AnsiString FontCaption = {read=FFontCaption, write=FFontCaption};
	__property AnsiString BulletStyleCaption = {read=FBulletStyleCaption, write=FBulletStyleCaption};
	__property AnsiString ParagraphCaption = {read=FParagraphCaption, write=FParagraphCaption};
	__property AnsiString TabsCaption = {read=FTabsCaption, write=FTabsCaption};
	__property AnsiString HelpCaption = {read=FHelpCaption, write=FHelpCaption};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwRichEditMenuLabels(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwRichEditMenuLabels(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwRichEditPopupMenuLabels;
class PASCALIMPLEMENTATION TwwRichEditPopupMenuLabels : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FEditCaption;
	AnsiString FViewCaption;
	AnsiString FCutCaption;
	AnsiString FCopyCaption;
	AnsiString FPasteCaption;
	AnsiString FFontCaption;
	AnsiString FBulletStyleCaption;
	AnsiString FBoldCaption;
	AnsiString FItalicCaption;
	AnsiString FUnderlineCaption;
	AnsiString FParagraphCaption;
	AnsiString FTabsCaption;
	AnsiString FFindCaption;
	AnsiString FReplaceCaption;
	AnsiString FInsertObjectCaption;
	AnsiString FSpellCheckCaption;
	AnsiString FObjectPropertiesCaption;
	
__published:
	__property AnsiString EditCaption = {read=FEditCaption, write=FEditCaption};
	__property AnsiString ViewCaption = {read=FViewCaption, write=FViewCaption};
	__property AnsiString CutCaption = {read=FCutCaption, write=FCutCaption};
	__property AnsiString CopyCaption = {read=FCopyCaption, write=FCopyCaption};
	__property AnsiString PasteCaption = {read=FPasteCaption, write=FPasteCaption};
	__property AnsiString FontCaption = {read=FFontCaption, write=FFontCaption};
	__property AnsiString BulletStyleCaption = {read=FBulletStyleCaption, write=FBulletStyleCaption};
	__property AnsiString BoldCaption = {read=FBoldCaption, write=FBoldCaption};
	__property AnsiString ItalicCaption = {read=FItalicCaption, write=FItalicCaption};
	__property AnsiString UnderlineCaption = {read=FUnderlineCaption, write=FUnderlineCaption};
	__property AnsiString ParagraphCaption = {read=FParagraphCaption, write=FParagraphCaption};
	__property AnsiString TabsCaption = {read=FTabsCaption, write=FTabsCaption};
	__property AnsiString FindCaption = {read=FFindCaption, write=FFindCaption};
	__property AnsiString ReplaceCaption = {read=FReplaceCaption, write=FReplaceCaption};
	__property AnsiString InsertObjectCaption = {read=FInsertObjectCaption, write=FInsertObjectCaption};
	__property AnsiString ObjectPropertiesCaption = {read=FObjectPropertiesCaption, write=FObjectPropertiesCaption};
	__property AnsiString SpellCheckCaption = {read=FSpellCheckCaption, write=FSpellCheckCaption};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwRichEditPopupMenuLabels(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwRichEditPopupMenuLabels(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwRichEditParagraphDlg;
class PASCALIMPLEMENTATION TwwRichEditParagraphDlg : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FParagraphDlgCaption;
	AnsiString FIndentationGroupBoxCaption;
	AnsiString FLeftEditCaption;
	AnsiString FRightEditCaption;
	AnsiString FFirstLineEditCaption;
	AnsiString FAlignmentCaption;
	AnsiString FLeftEditHint;
	AnsiString FRightEditHint;
	AnsiString FFirstLineEditHint;
	AnsiString FSpacingGroupCaption;
	AnsiString FBeforeParagraphCaption;
	AnsiString FAfterParagraphCaption;
	AnsiString FWithinParagraphCaption;
	AnsiString FWithinParagraphAtCaption;
	AnsiString FAlignmentHint;
	AnsiString FAlignLeft;
	AnsiString FAlignRight;
	AnsiString FAlignCenter;
	AnsiString FAlignJustify;
	AnsiString FSpacingSingle;
	AnsiString FSpacing1_5;
	AnsiString FSpacingDouble;
	AnsiString FSpacingAtLeast;
	AnsiString FSpacingExactly;
	AnsiString FSpacingMultiple;
	int FHelpContext;
	
__published:
	__property AnsiString ParagraphDlgCaption = {read=FParagraphDlgCaption, write=FParagraphDlgCaption};
	__property AnsiString IndentationGroupBoxCaption = {read=FIndentationGroupBoxCaption, write=FIndentationGroupBoxCaption};
	__property AnsiString LeftEditHint = {read=FLeftEditHint, write=FLeftEditHint};
	__property AnsiString RightEditHint = {read=FRightEditHint, write=FRightEditHint};
	__property AnsiString FirstLineEditHint = {read=FFirstLineEditHint, write=FFirstLineEditHint};
	__property AnsiString AlignmentHint = {read=FAlignmentHint, write=FAlignmentHint};
	__property AnsiString LeftEditCaption = {read=FLeftEditCaption, write=FLeftEditCaption};
	__property AnsiString RightEditCaption = {read=FRightEditCaption, write=FRightEditCaption};
	__property AnsiString FirstLineEditCaption = {read=FFirstLineEditCaption, write=FFirstLineEditCaption};
	__property AnsiString SpacingGroupCaption = {read=FSpacingGroupCaption, write=FSpacingGroupCaption};
	__property AnsiString BeforeParagraphCaption = {read=FBeforeParagraphCaption, write=FBeforeParagraphCaption};
	__property AnsiString AfterParagraphCaption = {read=FAfterParagraphCaption, write=FAfterParagraphCaption};
	__property AnsiString WithinParagraphCaption = {read=FWithinParagraphCaption, write=FWithinParagraphCaption};
	__property AnsiString WithinParagraphAtCaption = {read=FWithinParagraphAtCaption, write=FWithinParagraphAtCaption};
	__property AnsiString AlignmentCaption = {read=FAlignmentCaption, write=FAlignmentCaption};
	__property AnsiString AlignLeft = {read=FAlignLeft, write=FAlignLeft};
	__property AnsiString AlignRight = {read=FAlignRight, write=FAlignRight};
	__property AnsiString AlignCenter = {read=FAlignCenter, write=FAlignCenter};
	__property AnsiString AlignJustify = {read=FAlignJustify, write=FAlignJustify};
	__property AnsiString SpacingSingle = {read=FSpacingSingle, write=FSpacingSingle};
	__property AnsiString Spacing1_5 = {read=FSpacing1_5, write=FSpacing1_5};
	__property AnsiString SpacingDouble = {read=FSpacingDouble, write=FSpacingDouble};
	__property AnsiString SpacingAtLeast = {read=FSpacingAtLeast, write=FSpacingAtLeast};
	__property AnsiString SpacingExactly = {read=FSpacingExactly, write=FSpacingExactly};
	__property AnsiString SpacingMultiple = {read=FSpacingMultiple, write=FSpacingMultiple};
	__property int HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwRichEditParagraphDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwRichEditParagraphDlg(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwRichEditTabDlg;
class PASCALIMPLEMENTATION TwwRichEditTabDlg : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FTabDlgCaption;
	AnsiString FTabGroupBoxCaption;
	AnsiString FSetTabButtonCaption;
	AnsiString FClearTabButtonCaption;
	AnsiString FClearAllButtonCaption;
	AnsiString FTabPositionEditHint;
	AnsiString FListBoxHint;
	AnsiString FSetButtonHint;
	AnsiString FClearButtonHint;
	AnsiString FClearAllButtonHint;
	int FHelpContext;
	
__published:
	__property AnsiString TabDlgCaption = {read=FTabDlgCaption, write=FTabDlgCaption};
	__property int HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property AnsiString TabGroupBoxCaption = {read=FTabGroupBoxCaption, write=FTabGroupBoxCaption};
	__property AnsiString SetTabButtonCaption = {read=FSetTabButtonCaption, write=FSetTabButtonCaption};
	__property AnsiString ClearTabButtonCaption = {read=FClearTabButtonCaption, write=FClearTabButtonCaption};
	__property AnsiString ClearAllButtonCaption = {read=FClearAllButtonCaption, write=FClearAllButtonCaption};
	__property AnsiString TabPositionEditHint = {read=FTabPositionEditHint, write=FTabPositionEditHint};
	__property AnsiString ListBoxHint = {read=FListBoxHint, write=FListBoxHint};
	__property AnsiString SetButtonHint = {read=FSetButtonHint, write=FSetButtonHint};
	__property AnsiString ClearButtonHint = {read=FClearButtonHint, write=FClearButtonHint};
	__property AnsiString ClearAllButtonHint = {read=FClearAllButtonHint, write=FClearAllButtonHint};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwRichEditTabDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwRichEditTabDlg(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBRichEditIntl;
class PASCALIMPLEMENTATION TwwDBRichEditIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FFontNameComboHint;
	AnsiString FFontSizeComboHint;
	AnsiString FNewButtonHint;
	AnsiString FLoadButtonHint;
	AnsiString FSaveAsButtonHint;
	AnsiString FPrintButtonHint;
	AnsiString FFindButtonHint;
	AnsiString FCutButtonHint;
	AnsiString FCopyButtonHint;
	AnsiString FUndoButtonHint;
	AnsiString FRedoButtonHint;
	AnsiString FPasteButtonHint;
	AnsiString FBoldButtonHint;
	AnsiString FColorButtonHint;
	AnsiString FUnderlineButtonHint;
	AnsiString FItalicButtonHint;
	AnsiString FLeftButtonHint;
	AnsiString FCenterButtonHint;
	AnsiString FRightButtonHint;
	AnsiString FJustifyButtonHint;
	AnsiString FBulletButtonHint;
	AnsiString FHighlightButtonHint;
	AnsiString FSaveExitHint;
	AnsiString FPageSetupHint;
	AnsiString FExitHint;
	AnsiString FClearHint;
	AnsiString FSelectAllHint;
	AnsiString FFindNextHint;
	AnsiString FReplaceHint;
	AnsiString FInsertObjectHint;
	AnsiString FSpellCheckHint;
	AnsiString FToolbarHint;
	AnsiString FFormatBarHint;
	AnsiString FViewStatusBarHint;
	AnsiString FOptionsHint;
	AnsiString FFontHint;
	AnsiString FParagraphHint;
	AnsiString FTabsHint;
	TwwRichEditMenuLabels* FMenuLabels;
	TwwRichEditPopupMenuLabels* FPopupMenuLabels;
	TwwRichEditParagraphDlg* FParagraphDialog;
	TwwRichEditTabDlg* FTabDialog;
	AnsiString FCAPLockCaption;
	AnsiString FNUMLockCaption;
	
public:
	__fastcall virtual ~TwwDBRichEditIntl(void);
	
__published:
	__property AnsiString FontNameComboHint = {read=FFontNameComboHint, write=FFontNameComboHint};
	__property AnsiString FontSizeComboHint = {read=FFontSizeComboHint, write=FFontSizeComboHint};
	__property AnsiString NewButtonHint = {read=FNewButtonHint, write=FNewButtonHint};
	__property AnsiString LoadButtonHint = {read=FLoadButtonHint, write=FLoadButtonHint};
	__property AnsiString SaveAsButtonHint = {read=FSaveAsButtonHint, write=FSaveAsButtonHint};
	__property AnsiString PrintButtonHint = {read=FPrintButtonHint, write=FPrintButtonHint};
	__property AnsiString FindButtonHint = {read=FFindButtonHint, write=FFindButtonHint};
	__property AnsiString CutButtonHint = {read=FCutButtonHint, write=FCutButtonHint};
	__property AnsiString CopyButtonHint = {read=FCopyButtonHint, write=FCopyButtonHint};
	__property AnsiString UndoButtonHint = {read=FUndoButtonHint, write=FUndoButtonHint};
	__property AnsiString RedoButtonHint = {read=FRedoButtonHint, write=FRedoButtonHint};
	__property AnsiString PasteButtonHint = {read=FPasteButtonHint, write=FPasteButtonHint};
	__property AnsiString BoldButtonHint = {read=FBoldButtonHint, write=FBoldButtonHint};
	__property AnsiString ColorButtonHint = {read=FColorButtonHint, write=FColorButtonHint};
	__property AnsiString UnderlineButtonHint = {read=FUnderlineButtonHint, write=FUnderlineButtonHint};
	__property AnsiString ItalicButtonHint = {read=FItalicButtonHint, write=FItalicButtonHint};
	__property AnsiString LeftButtonHint = {read=FLeftButtonHint, write=FLeftButtonHint};
	__property AnsiString CenterButtonHint = {read=FCenterButtonHint, write=FCenterButtonHint};
	__property AnsiString RightButtonHint = {read=FRightButtonHint, write=FRightButtonHint};
	__property AnsiString JustifyButtonHint = {read=FJustifyButtonHint, write=FJustifyButtonHint};
	__property AnsiString BulletButtonHint = {read=FBulletButtonHint, write=FBulletButtonHint};
	__property AnsiString HighlightButtonHint = {read=FHighlightButtonHint, write=FHighlightButtonHint};
	__property AnsiString SaveExitHint = {read=FSaveExitHint, write=FSaveExitHint};
	__property AnsiString PageSetupHint = {read=FPageSetupHint, write=FPageSetupHint};
	__property AnsiString ExitHint = {read=FExitHint, write=FExitHint};
	__property AnsiString ClearHint = {read=FClearHint, write=FClearHint};
	__property AnsiString SelectAllHint = {read=FSelectAllHint, write=FSelectAllHint};
	__property AnsiString FindNextHint = {read=FFindNextHint, write=FFindNextHint};
	__property AnsiString ReplaceHint = {read=FReplaceHint, write=FReplaceHint};
	__property AnsiString InsertObjectHint = {read=FInsertObjectHint, write=FInsertObjectHint};
	__property AnsiString SpellCheckHint = {read=FSpellCheckHint, write=FSpellCheckHint};
	__property AnsiString ToolbarHint = {read=FToolbarHint, write=FToolbarHint};
	__property AnsiString FormatBarHint = {read=FFormatBarHint, write=FFormatBarHint};
	__property AnsiString ViewStatusBarHint = {read=FViewStatusBarHint, write=FViewStatusBarHint};
	__property AnsiString OptionsHint = {read=FOptionsHint, write=FOptionsHint};
	__property AnsiString FontHint = {read=FFontHint, write=FFontHint};
	__property AnsiString ParagraphHint = {read=FParagraphHint, write=FParagraphHint};
	__property AnsiString TabsHint = {read=FTabsHint, write=FTabsHint};
	__property AnsiString CAPLockCaption = {read=FCAPLockCaption, write=FCAPLockCaption};
	__property AnsiString NUMLockCaption = {read=FNUMLockCaption, write=FNUMLockCaption};
	__property TwwRichEditMenuLabels* MenuLabels = {read=FMenuLabels, write=FMenuLabels};
	__property TwwRichEditPopupMenuLabels* PopupMenuLabels = {read=FPopupMenuLabels, write=FPopupMenuLabels};
	__property TwwRichEditParagraphDlg* ParagraphDialog = {read=FParagraphDialog, write=FParagraphDialog};
	__property TwwRichEditTabDlg* TabDialog = {read=FTabDialog, write=FTabDialog};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwDBRichEditIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwSearchDialogIntl;
class PASCALIMPLEMENTATION TwwSearchDialogIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FSearchCharLabel;
	AnsiString FSearchCharShortLabel;
	AnsiString FSearchByLabel;
	AnsiString FStatusRecLabel;
	AnsiString FStatusOfLabel;
	AnsiString FSearchCharHint;
	AnsiString FSearchByHint;
	
__published:
	__property AnsiString SearchCharLabel = {read=FSearchCharLabel, write=FSearchCharLabel};
	__property AnsiString SearchCharShortLabel = {read=FSearchCharShortLabel, write=FSearchCharShortLabel};
	__property AnsiString SearchByLabel = {read=FSearchByLabel, write=FSearchByLabel};
	__property AnsiString StatusRecLabel = {read=FStatusRecLabel, write=FStatusRecLabel};
	__property AnsiString StatusOfLabel = {read=FStatusOfLabel, write=FStatusOfLabel};
	__property AnsiString SearchCharHint = {read=FSearchCharHint, write=FSearchCharHint};
	__property AnsiString SearchByHint = {read=FSearchByHint, write=FSearchByHint};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwSearchDialogIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwSearchDialogIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwMonthCalendarIntl;
class PASCALIMPLEMENTATION TwwMonthCalendarIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FPopupYearLabel;
	AnsiString FEnterYearPrompt;
	
__published:
	__property AnsiString PopupYearLabel = {read=FPopupYearLabel, write=FPopupYearLabel};
	__property AnsiString EnterYearPrompt = {read=FEnterYearPrompt, write=FEnterYearPrompt};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwMonthCalendarIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwMonthCalendarIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwLocateDialogIntl;
class PASCALIMPLEMENTATION TwwLocateDialogIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FFieldValueLabel;
	AnsiString FSearchTypeLabel;
	AnsiString FCaseSensitiveLabel;
	AnsiString FMatchExactLabel;
	AnsiString FMatchStartLabel;
	AnsiString FMatchAnyLabel;
	AnsiString FFieldsLabel;
	AnsiString FButtonFirst;
	AnsiString FButtonNext;
	AnsiString FButtonCancel;
	AnsiString FButtonClose;
	AnsiString FFieldValueHint;
	AnsiString FCaseSensitiveHint;
	AnsiString FMatchExactHint;
	AnsiString FMatchStartHint;
	AnsiString FMatchAnyHint;
	AnsiString FButtonFirstHint;
	AnsiString FButtonNextHint;
	AnsiString FFieldNameHint;
	
__published:
	__property AnsiString FieldValueLabel = {read=FFieldValueLabel, write=FFieldValueLabel};
	__property AnsiString SearchTypeLabel = {read=FSearchTypeLabel, write=FSearchTypeLabel};
	__property AnsiString CaseSensitiveLabel = {read=FCaseSensitiveLabel, write=FCaseSensitiveLabel};
	__property AnsiString MatchExactLabel = {read=FMatchExactLabel, write=FMatchExactLabel};
	__property AnsiString MatchStartLabel = {read=FMatchStartLabel, write=FMatchStartLabel};
	__property AnsiString MatchAnyLabel = {read=FMatchAnyLabel, write=FMatchAnyLabel};
	__property AnsiString FieldsLabel = {read=FFieldsLabel, write=FFieldsLabel};
	__property AnsiString BtnFirst = {read=FButtonFirst, write=FButtonFirst};
	__property AnsiString BtnNext = {read=FButtonNext, write=FButtonNext};
	__property AnsiString BtnCancel = {read=FButtonCancel, write=FButtonCancel};
	__property AnsiString BtnClose = {read=FButtonClose, write=FButtonClose};
	__property AnsiString FieldValueHint = {read=FFieldValueHint, write=FFieldValueHint};
	__property AnsiString CaseSensitiveHint = {read=FCaseSensitiveHint, write=FCaseSensitiveHint};
	__property AnsiString MatchExactHint = {read=FMatchExactHint, write=FMatchExactHint};
	__property AnsiString MatchStartHint = {read=FMatchStartHint, write=FMatchStartHint};
	__property AnsiString MatchAnyHint = {read=FMatchAnyHint, write=FMatchAnyHint};
	__property AnsiString BtnFirstHint = {read=FButtonFirstHint, write=FButtonFirstHint};
	__property AnsiString BtnNextHint = {read=FButtonNextHint, write=FButtonNextHint};
	__property AnsiString FieldNameHint = {read=FFieldNameHint, write=FFieldNameHint};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwLocateDialogIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwLocateDialogIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBNavigatorIntlHints;
class PASCALIMPLEMENTATION TwwDBNavigatorIntlHints : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FFirstHint;
	AnsiString FPriorHint;
	AnsiString FNextHint;
	AnsiString FLastHint;
	AnsiString FInsertHint;
	AnsiString FDeleteHint;
	AnsiString FEditHint;
	AnsiString FPostHint;
	AnsiString FCancelHint;
	AnsiString FRefreshHint;
	AnsiString FPriorPageHint;
	AnsiString FNextPageHint;
	AnsiString FSaveBookmarkHint;
	AnsiString FRestoreBookmarkHint;
	AnsiString FRecordViewDialogHint;
	AnsiString FLocateDialogHint;
	AnsiString FFilterDialogHint;
	AnsiString FSearchDialogHint;
	
public:
	__fastcall TwwDBNavigatorIntlHints(void);
	
__published:
	__property AnsiString FirstHint = {read=FFirstHint, write=FFirstHint};
	__property AnsiString PriorHint = {read=FPriorHint, write=FPriorHint};
	__property AnsiString NextHint = {read=FNextHint, write=FNextHint};
	__property AnsiString LastHint = {read=FLastHint, write=FLastHint};
	__property AnsiString InsertHint = {read=FInsertHint, write=FInsertHint};
	__property AnsiString DeleteHint = {read=FDeleteHint, write=FDeleteHint};
	__property AnsiString EditHint = {read=FEditHint, write=FEditHint};
	__property AnsiString PostHint = {read=FPostHint, write=FPostHint};
	__property AnsiString CancelHint = {read=FCancelHint, write=FCancelHint};
	__property AnsiString RefreshHint = {read=FRefreshHint, write=FRefreshHint};
	__property AnsiString PriorPageHint = {read=FPriorPageHint, write=FPriorPageHint};
	__property AnsiString NextPageHint = {read=FNextPageHint, write=FNextPageHint};
	__property AnsiString SaveBookmarkHint = {read=FSaveBookmarkHint, write=FSaveBookmarkHint};
	__property AnsiString RestoreBookmarkHint = {read=FRestoreBookmarkHint, write=FRestoreBookmarkHint};
	__property AnsiString RecordViewDialogHint = {read=FRecordViewDialogHint, write=FRecordViewDialogHint};
	__property AnsiString LocateDialogHint = {read=FLocateDialogHint, write=FLocateDialogHint};
	__property AnsiString FilterDialogHint = {read=FFilterDialogHint, write=FFilterDialogHint};
	__property AnsiString SearchDialogHint = {read=FSearchDialogHint, write=FSearchDialogHint};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwDBNavigatorIntlHints(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwADOIntl;
class PASCALIMPLEMENTATION TwwADOIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FUseLocateWhenFindingValue;
	
__published:
	__property bool UseLocateWhenFindingValue = {read=FUseLocateWhenFindingValue, write=FUseLocateWhenFindingValue, default=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwADOIntl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwADOIntl(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBNavigatorIntl;
class PASCALIMPLEMENTATION TwwDBNavigatorIntl : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FConfirmDeleteMessage;
	TwwDBNavigatorIntlHints* FHints;
	
public:
	__fastcall TwwDBNavigatorIntl(void);
	__fastcall virtual ~TwwDBNavigatorIntl(void);
	
__published:
	__property AnsiString ConfirmDeleteMessage = {read=FConfirmDeleteMessage, write=FConfirmDeleteMessage};
	__property TwwDBNavigatorIntlHints* Hints = {read=FHints, write=FHints};
};


#pragma option push -b-
enum TwwCheckBoxInGridStyle { cbStyleAuto, cbStyleCheckmark, cbStyleXmark, cbStyleCheckmarkFlat };
#pragma option pop

#pragma option push -b-
enum TwwGridPaintStyle { gpsBitmapCanvas, gpsDynamicDeviceContext };
#pragma option pop

class DELPHICLASS TwwIntl;
class PASCALIMPLEMENTATION TwwIntl : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TwwADOIntl* FADO;
	TwwDBNavigatorIntl* FNavigator;
	TwwSearchDialogIntl* FSearchDialog;
	TwwLocateDialogIntl* FLocateDialog;
	TwwMonthCalendarIntl* FMonthCalendar;
	bool FOKCancelBitmapped;
	Graphics::TFontStyles FDialogFontStyle;
	AnsiString FBtnOKCaption;
	AnsiString FBtnCancelCaption;
	bool FConnected;
	TwwUserMessagesIntl* FUserMessages;
	TwwFilterDialogIntl* FFilterDialog;
	TwwDBRichEditIntl* FRichEdit;
	AnsiString FIPVersion;
	AnsiString FIniFileName;
	AnsiString FRegistrationNo;
	bool FFastSQLCancelRange;
	TwwCheckBoxInGridStyle FCheckBoxInGridStyle;
	TwwGridPaintStyle FGridPaintStyle;
	bool FUseLocateMethodForSearch;
	int FDefaultEpochYear;
	int FFilterMemoSize;
	TwwPictureValidationError FOnValidationErrorUsingMask;
	void __fastcall SetConnected(bool val);
	void __fastcall SetIPVersion(AnsiString val);
	void __fastcall SetRegistrationNo(AnsiString val);
	void __fastcall SetCheckboxInGridStyle(TwwCheckBoxInGridStyle val);
	void __fastcall SetGridPaintStyle(TwwGridPaintStyle val);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall Connect(void);
	
public:
	__fastcall virtual TwwIntl(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwIntl(void);
	virtual void __fastcall ValidationErrorUsingMask(Classes::TComponent* Component, Db::TField* Field);
	__property bool FastSQLCancelRange = {read=FFastSQLCancelRange, write=FFastSQLCancelRange, nodefault};
	
__published:
	__property TwwADOIntl* ADO = {read=FADO, write=FADO};
	__property TwwDBNavigatorIntl* Navigator = {read=FNavigator, write=FNavigator};
	__property TwwSearchDialogIntl* SearchDialog = {read=FSearchDialog, write=FSearchDialog};
	__property TwwLocateDialogIntl* LocateDialog = {read=FLocateDialog, write=FLocateDialog};
	__property TwwMonthCalendarIntl* MonthCalendar = {read=FMonthCalendar, write=FMonthCalendar};
	__property TwwFilterDialogIntl* FilterDialog = {read=FFilterDialog, write=FFilterDialog};
	__property TwwDBRichEditIntl* RichEdit = {read=FRichEdit, write=FRichEdit};
	__property TwwUserMessagesIntl* UserMessages = {read=FUserMessages, write=FUserMessages};
	__property bool OKCancelBitmapped = {read=FOKCancelBitmapped, write=FOKCancelBitmapped, nodefault};
	__property AnsiString BtnOKCaption = {read=FBtnOKCaption, write=FBtnOKCaption};
	__property AnsiString BtnCancelCaption = {read=FBtnCancelCaption, write=FBtnCancelCaption};
	__property TwwCheckBoxInGridStyle CheckBoxInGridStyle = {read=FCheckBoxInGridStyle, write=SetCheckboxInGridStyle, nodefault};
	__property TwwGridPaintStyle GridPaintStyle = {read=FGridPaintStyle, write=SetGridPaintStyle, default=1};
	__property AnsiString VersionInfoPower = {read=FIPVersion, write=SetIPVersion};
	__property int FilterMemoSize = {read=FFilterMemoSize, write=FFilterMemoSize, nodefault};
	__property AnsiString IniFileName = {read=FIniFileName, write=FIniFileName};
	__property bool UseLocateMethodForSearch = {read=FUseLocateMethodForSearch, write=FUseLocateMethodForSearch, default=1};
	__property Graphics::TFontStyles DialogFontStyle = {read=FDialogFontStyle, write=FDialogFontStyle, nodefault};
	__property int DefaultEpochYear = {read=FDefaultEpochYear, write=FDefaultEpochYear, default=1950};
	__property AnsiString RegistrationNo = {read=FRegistrationNo, write=SetRegistrationNo};
	__property TwwPictureValidationError OnValidationErrorUsingMask = {read=FOnValidationErrorUsingMask, write=FOnValidationErrorUsingMask};
	__property bool Connected = {read=FConnected, write=SetConnected, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwintl)
extern PACKAGE TwwIntl* wwInternational;
extern PACKAGE void __fastcall Register(void);
extern PACKAGE Classes::TComponent* __fastcall wwCreateCommonButton(Forms::TForm* AOwner, Buttons::TBitBtnKind ButtonKind);

}	/* namespace Wwintl */
using namespace Wwintl;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwintl
