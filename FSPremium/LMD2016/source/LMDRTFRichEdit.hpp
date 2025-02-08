// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFRichEdit.pas' rev: 31.00 (Windows)

#ifndef LmdrtfricheditHPP
#define LmdrtfricheditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.RichEdit.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Themes.hpp>
#include <LMDUnicode.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFRuler.hpp>
#include <LMDRTFStorage.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------
#define CHARFORMAT2A Richedit::CHARFORMAT2A
namespace Lmdrtfrichedit
{
#pragma option push -b-
enum TLMDSearchType { stWholeWord, stMatchCase, stSearchDown };
#pragma option pop

typedef Set<TLMDSearchType, stWholeWord, stSearchDown>  TLMDSearchTypes;
class DELPHICLASS TLMDBaseCustomRichEdit;
class PASCALIMPLEMENTATION TLMDBaseCustomRichEdit : public Stdctrls::TCustomMemo
{
  typedef Stdctrls::TCustomMemo inherited;
protected:
  virtual int __fastcall DoFindText(const String SearchStr, int StartPos, int Length, TLMDSearchTypes Options ) = 0 ;
  virtual int __fastcall DoReplaceText(const String SearchStr, const String ReplaceStr, int StartPos, int Len, TLMDSearchTypes Options) = 0 ;
public:
  #pragma option push -w-inl
  /* TCustomMemo.Create */ inline __fastcall virtual TLMDBaseCustomRichEdit(Classes::TComponent* AOwner) : Stdctrls::TCustomMemo(AOwner) { }
  #pragma option pop
  #pragma option push -w-inl
  /* TCustomMemo.Destroy */ inline __fastcall virtual ~TLMDBaseCustomRichEdit(void) { }
  #pragma option pop

public:
  #pragma option push -w-inl
  /* TWinControl.CreateParented */ inline __fastcall TLMDBaseCustomRichEdit(HWND ParentWindow) : Stdctrls::TCustomMemo(ParentWindow) { }
  #pragma option pop
};
}

namespace Lmdrtfrichedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextAttributes;
class DELPHICLASS TLMDParaAttributes;
class DELPHICLASS TLMDConversion;
struct TLMDConversionFormat;
struct TLMDRichEditStreamInfo;
class DELPHICLASS TLMDCustomRichEdit;
class DELPHICLASS TLMDRichEdit;
class DELPHICLASS TLMDRichCustomComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAttributeType : unsigned char { atDefaultText, atSelected, atWord };

enum DECLSPEC_DENUM TLMDConsistentAttribute : unsigned char { caBold, caColor, caFace, caItalic, caSize, caStrikeOut, caUnderline, caProtected, caOffset, caHidden, caLink, caBackColor, caDisabled, caWeight, caSubscript, caRevAuthor, caRevised };

enum DECLSPEC_DENUM TLMDRichSubscriptStyle : unsigned char { ssNone, ssSubscript, ssSuperscript };

typedef System::Set<TLMDConsistentAttribute, TLMDConsistentAttribute::caBold, TLMDConsistentAttribute::caRevised> TLMDConsistentAttributes;

enum DECLSPEC_DENUM TLMDUnderlineType : unsigned char { utNone, utSolid, utWord, utDouble, utDotted, utDash, utDashDot, utDashDotDot, urWave, utThick };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextAttributes : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomRichEdit* RichEdit;
	TLMDAttributeType FType;
	void __fastcall AssignFont(Vcl::Graphics::TFont* Font);
	void __fastcall GetAttributes(Winapi::Richedit::_CHARFORMAT2W &Format);
	System::Uitypes::TColor __fastcall GetBackColor(void);
	System::Uitypes::TFontCharset __fastcall GetCharset(void);
	System::Uitypes::TColor __fastcall GetColor(void);
	TLMDConsistentAttributes __fastcall GetConsistentAttributes(void);
	int __fastcall GetHeight(void);
	bool __fastcall GetHidden(void);
	bool __fastcall GetDisabled(void);
	bool __fastcall GetLink(void);
	System::Uitypes::TFontName __fastcall GetName(void);
	int __fastcall GetOffset(void);
	System::Uitypes::TFontPitch __fastcall GetPitch(void);
	bool __fastcall GetProtected(void);
	bool __fastcall GetRevised(void);
	System::Byte __fastcall GetRevAuthorIndex(void);
	int __fastcall GetSize(void);
	System::Uitypes::TFontStyles __fastcall GetStyle(void);
	TLMDRichSubscriptStyle __fastcall GetSubscriptStyle(void);
	TLMDUnderlineType __fastcall GetUnderlineType(void);
	void __fastcall SetAttributes(Winapi::Richedit::_CHARFORMAT2W &Format);
	void __fastcall SetBackColor(System::Uitypes::TColor Value);
	void __fastcall SetCharset(System::Uitypes::TFontCharset Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetDisabled(bool Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetHidden(bool Value);
	void __fastcall SetLink(bool Value);
	void __fastcall SetName(System::Uitypes::TFontName Value);
	void __fastcall SetOffset(int Value);
	void __fastcall SetPitch(System::Uitypes::TFontPitch Value);
	void __fastcall SetProtected(bool Value);
	void __fastcall SetRevised(bool Value);
	void __fastcall SetRevAuthorIndex(System::Byte Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetStyle(System::Uitypes::TFontStyles Value);
	void __fastcall SetSubscriptStyle(TLMDRichSubscriptStyle Value);
	void __fastcall SetUnderlineType(TLMDUnderlineType Value);
	
protected:
	void __fastcall InitFormat(Winapi::Richedit::_CHARFORMAT2W &Format);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall TLMDTextAttributes(TLMDCustomRichEdit* AOwner, TLMDAttributeType AttributeType);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall TextAttributesDialog(void);
	__property System::Uitypes::TColor BackColor = {read=GetBackColor, write=SetBackColor, nodefault};
	__property System::Uitypes::TFontCharset Charset = {read=GetCharset, write=SetCharset, nodefault};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property TLMDConsistentAttributes ConsistentAttributes = {read=GetConsistentAttributes, nodefault};
	__property bool Disabled = {read=GetDisabled, write=SetDisabled, nodefault};
	__property bool Hidden = {read=GetHidden, write=SetHidden, nodefault};
	__property bool Link = {read=GetLink, write=SetLink, nodefault};
	__property System::Uitypes::TFontName Name = {read=GetName, write=SetName};
	__property int Offset = {read=GetOffset, write=SetOffset, nodefault};
	__property System::Uitypes::TFontPitch Pitch = {read=GetPitch, write=SetPitch, nodefault};
	__property bool Protected = {read=GetProtected, write=SetProtected, nodefault};
	__property bool Revised = {read=GetRevised, write=SetRevised, nodefault};
	__property System::Byte RevAuthorIndex = {read=GetRevAuthorIndex, write=SetRevAuthorIndex, nodefault};
	__property TLMDRichSubscriptStyle SubscriptStyle = {read=GetSubscriptStyle, write=SetSubscriptStyle, nodefault};
	__property int Size = {read=GetSize, write=SetSize, nodefault};
	__property System::Uitypes::TFontStyles Style = {read=GetStyle, write=SetStyle, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property TLMDUnderlineType UnderlineType = {read=GetUnderlineType, write=SetUnderlineType, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTextAttributes(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDNumbering : unsigned char { nsNone, nsBullet, nsArabicNumbers, nsLoCaseLetter, nsUpCaseLetter, nsLoCaseRoman, nsUpCaseRoman };

enum DECLSPEC_DENUM TLMDNumberingStyle : unsigned char { nsParenthesis, nsPeriod, nsEnclosed, nsSimple };

enum DECLSPEC_DENUM TLMDParaAlignment : unsigned char { paLeftJustify, paRightJustify, paCenter };

enum DECLSPEC_DENUM TLMDLineSpacingRule : unsigned char { lsSingle, lsOneAndHalf, lsDouble, lsSpecifiedOrMore, lsSpecified, lsMultiple };

typedef System::Int8 TLMDHeadingStyle;

enum DECLSPEC_DENUM TLMDParaTableStyle : unsigned char { tsNone, tsTable, tsTableRow, tsTableCellEnd, tsTableCell };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParaAttributes : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomRichEdit* RichEdit;
	void __fastcall GetAttributes(PARAFORMAT2 &Paragraph);
	TLMDParaAlignment __fastcall GetAlignment(void);
	int __fastcall GetFirstIndent(void);
	TLMDHeadingStyle __fastcall GetHeadingStyle(void);
	int __fastcall GetLeftIndent(void);
	int __fastcall GetRightIndent(void);
	int __fastcall GetSpaceAfter(void);
	int __fastcall GetSpaceBefore(void);
	int __fastcall GetLineSpacing(void);
	TLMDLineSpacingRule __fastcall GetLineSpacingRule(void);
	TLMDNumbering __fastcall GetNumbering(void);
	TLMDNumberingStyle __fastcall GetNumberingStyle(void);
	System::Word __fastcall GetNumberingTab(void);
	int __fastcall GetTab(System::Byte Index);
	int __fastcall GetTabCount(void);
	TLMDParaTableStyle __fastcall GetTableStyle(void);
	void __fastcall SetAlignment(TLMDParaAlignment Value);
	void __fastcall SetAttributes(PARAFORMAT2 &Paragraph);
	void __fastcall SetFirstIndent(int Value);
	void __fastcall SetHeadingStyle(TLMDHeadingStyle Value);
	void __fastcall SetLeftIndent(int Value);
	void __fastcall SetRightIndent(int Value);
	void __fastcall SetSpaceAfter(int Value);
	void __fastcall SetSpaceBefore(int Value);
	void __fastcall SetLineSpacing(int Value);
	void __fastcall SetLineSpacingRule(TLMDLineSpacingRule Value);
	void __fastcall SetNumbering(TLMDNumbering Value);
	void __fastcall SetNumberingStyle(TLMDNumberingStyle Value);
	void __fastcall SetNumberingTab(System::Word Value);
	void __fastcall SetTab(System::Byte Index, int Value);
	void __fastcall SetTabCount(int Value);
	void __fastcall SetTableStyle(TLMDParaTableStyle Value);
	int __fastcall GetNumberingStart(void);
	void __fastcall SetNumberingStart(const int Value);
	
protected:
	void __fastcall InitPara(PARAFORMAT2 &Paragraph);
	void __fastcall GetIndents(int &Left, int &First, int &Right);
	
public:
	__fastcall TLMDParaAttributes(TLMDCustomRichEdit* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall ClearToDefaults(void);
	void __fastcall SetTabs(const int *Tabs, const int Tabs_High);
	bool __fastcall ParagraphDialog(void);
	bool __fastcall TabsDialog(void);
	void __fastcall SetParagraphIndent(int Left, int First);
	__property TLMDParaAlignment Alignment = {read=GetAlignment, write=SetAlignment, nodefault};
	__property int FirstIndent = {read=GetFirstIndent, write=SetFirstIndent, nodefault};
	__property TLMDHeadingStyle HeadingStyle = {read=GetHeadingStyle, write=SetHeadingStyle, nodefault};
	__property int LeftIndent = {read=GetLeftIndent, write=SetLeftIndent, nodefault};
	__property int LineSpacing = {read=GetLineSpacing, write=SetLineSpacing, nodefault};
	__property TLMDLineSpacingRule LineSpacingRule = {read=GetLineSpacingRule, write=SetLineSpacingRule, nodefault};
	__property TLMDNumbering Numbering = {read=GetNumbering, write=SetNumbering, nodefault};
	__property int NumberingStart = {read=GetNumberingStart, write=SetNumberingStart, nodefault};
	__property TLMDNumberingStyle NumberingStyle = {read=GetNumberingStyle, write=SetNumberingStyle, nodefault};
	__property System::Word NumberingTab = {read=GetNumberingTab, write=SetNumberingTab, nodefault};
	__property int RightIndent = {read=GetRightIndent, write=SetRightIndent, nodefault};
	__property int SpaceAfter = {read=GetSpaceAfter, write=SetSpaceAfter, nodefault};
	__property int SpaceBefore = {read=GetSpaceBefore, write=SetSpaceBefore, nodefault};
	__property int Tab[System::Byte Index] = {read=GetTab, write=SetTab};
	__property int TabCount = {read=GetTabCount, write=SetTabCount, nodefault};
	__property TLMDParaTableStyle TableStyle = {read=GetTableStyle, write=SetTableStyle, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDParaAttributes(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRichLangOption : unsigned char { rlAutoKeyboard, rlAutoFont, rlImeCancelComplete, rlImeAlwaysSendNotify };

typedef System::Set<TLMDRichLangOption, TLMDRichLangOption::rlAutoKeyboard, TLMDRichLangOption::rlImeAlwaysSendNotify> TLMDRichLangOptions;

enum DECLSPEC_DENUM TLMDRichSelection : unsigned char { stText, stObject, stMultiChar, stMultiObject };

typedef System::Set<TLMDRichSelection, TLMDRichSelection::stText, TLMDRichSelection::stMultiObject> TLMDRichSelectionType;

enum DECLSPEC_DENUM TLMDRedoUndoType : unsigned char { uidUnknown, uidTyping, uidDelete, uidDragDrop, uidCut, uidPaste };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDConversion : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__fastcall virtual TLMDConversion(void);
	virtual int __fastcall ConvertReadStream(System::Classes::TStream* Stream, char * Buffer, int BufSize);
	virtual int __fastcall ConvertWriteStream(System::Classes::TStream* Stream, char * Buffer, int BufSize);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDConversion(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDConversionClass;

typedef TLMDConversionFormat *PLMDConversionFormat;

struct DECLSPEC_DRECORD TLMDConversionFormat
{
public:
	TLMDConversionClass ConversionClass;
	System::UnicodeString Extension;
	TLMDConversionFormat *Next;
};


typedef TLMDRichEditStreamInfo *PLMDRichEditStreamInfo;

struct DECLSPEC_DRECORD TLMDRichEditStreamInfo
{
public:
	TLMDConversion* Converter;
	System::Classes::TStream* Stream;
};


typedef System::Int8 TLMDZoom;

enum DECLSPEC_DENUM TLMDRichEditMode : unsigned char { edModeAppOnly, edModePrinterSupport };

enum DECLSPEC_DENUM TLMDSmoothingType : unsigned char { stSystem, stActive, stInactive };

enum DECLSPEC_DENUM TLMDRichTypographyOptions : unsigned char { toAdvanced, toSimple };

typedef void __fastcall (__closure *TLMDRichDropFileEvent)(System::TObject* Sender, const System::UnicodeString FileName, bool &Accept);

typedef void __fastcall (__closure *TLMDRichHandleEvent)(System::TObject* Sender, bool &skipDefaultBehaviour);

class PASCALIMPLEMENTATION TLMDCustomRichEdit : public TLMDBaseCustomRichEdit
{
	typedef TLMDBaseCustomRichEdit inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FCombos;
	bool FAllowObjects;
	bool FAllowInPlace;
	bool FAutoURLDetect;
	bool FAutoVerbMenu;
	System::TInterfacedObject* FCallback;
	System::_di_IInterface FCallbackIntf;
	TLMDConversionClass FDefaultConverter;
	bool FHideSelection;
	bool FHideScrollBars;
	TLMDRichLangOptions FLangOptions;
	System::Classes::TMemoryStream* FMemStream;
	bool FModified;
	System::Classes::TAlignment FOldParaAlignment;
	TLMDParaAttributes* FParagraph;
	Vcl::Menus::TPopupMenu* FPopupVerbMenu;
	Lmdrtfbase::TLMDRichPageMargins* FPageRect;
	Lmdrtfbase::TLMDRichPageMargins* FPageMargins;
	Lmdrtfbase::TLMDRichPageMargins* FTempMargins;
	int FPrinterPageWidth;
	System::Classes::TStrings* FRichEditStrings;
	System::_di_IInterface FRichEditOle;
	Lmdrtfruler::TLMDRTFRuler* FRuler;
	bool FShowRuler;
	int FScreenLogPixels;
	System::UnicodeString FTitle;
	int FUndoLimit;
	TLMDZoom FZoom;
	System::Classes::TNotifyEvent FOnCustomize;
	TLMDTextAttributes* FSelAttributes;
	TLMDTextAttributes* FWordAttributes;
	TLMDTextAttributes* FDefAttributes;
	System::Classes::TNotifyEvent FOnSelChange;
	Vcl::Comctrls::TRichEditResizeEvent FOnResizeRequest;
	Vcl::Comctrls::TRichEditProtectChange FOnProtectChange;
	Vcl::Comctrls::TRichEditSaveClipboard FOnSaveClipboard;
	Lmdrtfbase::TLMDRichURLClickEvent FOnURLClick;
	Lmdrtfbase::TLMDRichURLClickEvent FOnLinkClick;
	Lmdrtfstorage::TLMDRichStorage* FRichStorage;
	int FRichStorageItem;
	Lmdrtfstorage::TLMDRTFChangeLink* FStorageLink;
	bool FAcceptDropFiles;
	Vcl::Menus::TPopupMenu* FDefaultPopup;
	Vcl::Menus::TPopupMenu* FDefaultPopupURL;
	bool FDefaultProtect;
	bool FShowDefaultPopup;
	Lmdtypes::TLMDUnits FMeasurement;
	TLMDRichEditMode FRichEditMode;
	bool FRecreateInProcess;
	CHARRANGE FOldSel;
	bool FForcedChange;
	int FHeaderSize;
	bool FTextEmpty;
	System::Classes::TNotifyEvent FOnVScroll;
	System::Classes::TNotifyEvent FOnHScroll;
	bool FLockLinkClick;
	Lmdrtfbase::TLMDRichDialogPosition FDlgPosition;
	System::Classes::TNotifyEvent FOnDlgAfterShow;
	System::Classes::TNotifyEvent FOnDlgInit;
	TLMDRichDropFileEvent FOnDropFile;
	Lmdrtfbase::TLMDLinkMouseMoveEvent FOnLinkMouseMove;
	System::UnicodeString FInMousePosURL;
	int FInMousePosURLc;
	bool FInRulerPosition;
	TLMDRichHandleEvent FOnAfterSave;
	System::Classes::TNotifyEvent FOnBeforeSave;
	bool FProtectLinks;
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMDocWindowActivate(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CNNotify(Winapi::Messages::TWMNotify &Message);
	MESSAGE void __fastcall CMUIDeactivate(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMDropFiles(Winapi::Messages::TWMDropFiles &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFont(Winapi::Messages::TWMSetFont &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	bool __fastcall GetAutoURLDetect(void);
	bool __fastcall GetCanRedo(void);
	TLMDRichLangOptions __fastcall GetLangOptions(void);
	bool __fastcall GetPlainText(void);
	TLMDRedoUndoType __fastcall GetRedoName(void);
	TLMDRichSelectionType __fastcall GetSelectionType(void);
	TLMDRedoUndoType __fastcall GetUndoName(void);
	int __fastcall GetVersion(void);
	TLMDZoom __fastcall GetZoom(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerTabCreate(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerTabChange(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerTabDestroy(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerFirstIdentChange(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerLeftIdentChange(void);
	Lmdrtfruler::TLMDRTFRulerEvent __fastcall GetOnRulerRightIdentChange(void);
	void __fastcall SetRichEditMode(TLMDRichEditMode value);
	void __fastcall SetAllowObjects(const bool Value);
	void __fastcall SetAutoURLDetect(bool Value);
	HIDESBASE void __fastcall SetHideSelection(bool Value);
	void __fastcall SetHideScrollBars(bool Value);
	void __fastcall SetLangOptions(TLMDRichLangOptions Value);
	void __fastcall SetRichEditStrings(System::Classes::TStrings* Value);
	void __fastcall SetPlainText(bool Value);
	void __fastcall SetRuler(bool aValue);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetUndoLimit(int Value);
	void __fastcall SetVersion(int aValue);
	void __fastcall SetZoom(const TLMDZoom Value);
	void __fastcall SetDefAttributes(TLMDTextAttributes* Value);
	void __fastcall SetSelAttributes(TLMDTextAttributes* Value);
	void __fastcall SetWordAttributes(TLMDTextAttributes* Value);
	void __fastcall SetOnRulerTabCreate(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall SetOnRulerTabChange(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall SetOnRulerTabDestroy(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall SetOnRulerFirstIdentChange(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall SetOnRulerLeftIdentChange(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall SetOnRulerRightIdentChange(Lmdrtfruler::TLMDRTFRulerEvent Value);
	void __fastcall CloseObjects(void);
	void __fastcall ObjectPropsClick(System::TObject* Sender);
	bool __fastcall ProtectChange(int StartPos, int EndPos);
	void __fastcall PopupVerbClick(System::TObject* Sender);
	bool __fastcall SaveClipboard(int NumObj, int NumChars);
	void __fastcall UpdateHostNames(void);
	void __fastcall SetPageMargins(Lmdrtfbase::TLMDRichPageMargins* const Value);
	void __fastcall SetStorage(Lmdrtfstorage::TLMDRichStorage* const Value);
	void __fastcall SetStorageItem(const int Value);
	bool __fastcall IsStringsStored(void);
	void __fastcall UpdateFromStorage(void);
	void __fastcall StorageDataChanged(System::TObject* Sender);
	System::Types::TPoint __fastcall GetCurPos(void);
	void __fastcall SetCurPos(const System::Types::TPoint &Value);
	void __fastcall SetMeasurement(const Lmdtypes::TLMDUnits Value);
	void __fastcall ChangeMargins(System::TObject* Sender);
	void __fastcall SetRulerMeasurement(void);
	void __fastcall UpdateRuler(void);
	void __fastcall SetTypographyOptions(const TLMDRichTypographyOptions Value);
	TLMDRichTypographyOptions __fastcall GetTypographyOptions(void);
	void __fastcall SetAcceptDropFiles(bool Value);
	bool __fastcall IsValidRichStorageItem(void);
	int __fastcall GetTopLineIndex(void);
	void __fastcall SetTopLineIndex(int Value);
	void __fastcall SetRTFText(const System::UnicodeString aValue);
	System::UnicodeString __fastcall GetRTFText(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool aValue);
	void __fastcall SetAllowInPlace(bool aValue);
	int __fastcall GetTextLengthHelper(const GETTEXTLENGTHEX &Struct);
	void __fastcall SetProtectLinks(const bool Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual int __fastcall DoFindText(const System::UnicodeString SearchStr, int StartPos, int Length, TLMDSearchTypes Options);
	virtual int __fastcall DoReplaceText(const System::UnicodeString SearchStr, const System::UnicodeString ReplaceStr, int StartPos, int Len, TLMDSearchTypes Options);
	HWND __fastcall GetDlgParentHandle(void);
	virtual System::Types::TPoint __fastcall GetCaretPos(void);
	virtual void __fastcall SetCaretPos(const System::Types::TPoint &Value);
	virtual int __fastcall GetSelLength(void);
	virtual int __fastcall GetSelStart(void);
	virtual System::UnicodeString __fastcall GetSelText(void);
	void __fastcall InformCombos(void);
	virtual void __fastcall SetSelLength(int Value);
	virtual void __fastcall SetSelStart(int Value);
	virtual void __fastcall DoSetMaxLength(int Value);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall RequestSize(const System::Types::TRect &Rect);
	virtual bool __fastcall GetCanPaste(void);
	DYNAMIC void __fastcall SelectionChange(void);
	DYNAMIC void __fastcall URLClick(const System::UnicodeString URLText, System::Uitypes::TMouseButton Button);
	DYNAMIC void __fastcall LinkClick(const System::UnicodeString LinkText, System::Uitypes::TMouseButton Button);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall LoadStorageIndexProperty(System::Classes::TReader* Reader);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	virtual System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	virtual void __fastcall MarkUpParse(int aStart, int aEnd);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall BeforeSave(System::Classes::TStream* aStream);
	virtual void __fastcall AfterSave(void);
	virtual void __fastcall BeforeLoad(System::Classes::TStream* aStream);
	virtual void __fastcall AfterLoad(void);
	bool __fastcall DoDropFile(const System::UnicodeString FileName);
	__property TLMDRichDropFileEvent OnDropFile = {read=FOnDropFile, write=FOnDropFile};
	__property Lmdrtfbase::TLMDLinkMouseMoveEvent OnLinkMouseMove = {read=FOnLinkMouseMove, write=FOnLinkMouseMove};
	__property TLMDRichHandleEvent OnAfterSave = {read=FOnAfterSave, write=FOnAfterSave};
	__property System::Classes::TNotifyEvent OnBeforeSave = {read=FOnBeforeSave, write=FOnBeforeSave};
	void __fastcall GetPrinterPageParams(int &aPrinterPageWidth, Lmdrtfbase::TLMDRichPageMargins* &aPageMargins);
	
public:
	__fastcall virtual TLMDCustomRichEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomRichEdit(void);
	virtual void __fastcall Clear(void);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	void __fastcall Render(Vcl::Graphics::TBitmap* BMP, int &LastChar)/* overload */;
	void __fastcall Render(Vcl::Graphics::TBitmap* BMP, int Wd, int Hg, int MaxWidth, int MaxHeight, int VSB_Width, int HSB_Height, int &LastChar, TLMDSmoothingType Smoothing = (TLMDSmoothingType)(0x0))/* overload */;
	virtual System::Types::TRect __fastcall Preview(Vcl::Graphics::TCanvas* PrintTo, bool Render, int &LastChar);
	virtual void __fastcall Print(const System::UnicodeString Caption);
	void __fastcall SetRulerPosition(void);
	void __fastcall GetRulerPosition(System::Types::TRect &Rect);
	void __fastcall SetEditRect(void);
	void __fastcall PrepareDialog(Vcl::Forms::TCustomForm* dlg)/* overload */;
	void __fastcall PrepareDialog(Lmdrtfbase::TLMDRichBaseDialog* dlg)/* overload */;
	System::UnicodeString __fastcall GetTextRange(int StartPos, int EndPos);
	virtual int __fastcall GetSelTextBuf(System::WideChar * Buffer, int BufSize);
	void __fastcall SetUIActive(bool Active);
	int __fastcall FindTextExt(const System::UnicodeString SearchStr, int StartPos, int Length, TLMDSearchTypes Options);
	int __fastcall ReplaceTextExt(const System::UnicodeString SearchStr, const System::UnicodeString ReplaceStr, int StartPos, int Len, TLMDSearchTypes Options);
	bool __fastcall InsertObjectDialog(void);
	bool __fastcall ObjectPropertiesDialog(void);
	bool __fastcall PasteSpecialDialog(void);
	bool __fastcall PagePropertiesDialog(void);
	bool __fastcall PreviewDialog(void);
	bool __fastcall InsertDateTimeDialog(void);
	bool __fastcall InsertCharDialog(void);
	void __fastcall StatisticsDialog(void);
	void __fastcall Redo(void);
	void __fastcall InsertBitmap(Vcl::Graphics::TBitmap* aBitmap);
	void __fastcall InsertGraphic(Vcl::Graphics::TGraphic* aGraphic);
	void __fastcall SaveToStreamAsHTML(System::Classes::TStream* aStream);
	void __fastcall CopyToStream(System::Classes::TStream* aStream, bool aSelection = true, bool aPlainText = false, bool aObjects = false, bool aPlainRtf = false);
	void __fastcall PastePlainText(void);
	void __fastcall PasteFromStream(System::Classes::TStream* aStream, bool aSelection = true, bool aPlainText = false, bool aPlainRtf = false);
	__classmethod void __fastcall RegisterConversionFormat(const System::UnicodeString AExtension, TLMDConversionClass AConversionClass);
	System::Types::TRect __fastcall GetEditRect(void);
	void __fastcall ScrollByLines(int delta);
	void __fastcall SynchronizeLines(TLMDCustomRichEdit* aControl);
	void __fastcall RegisterCombo(TLMDRichCustomComboBox* aCombo);
	void __fastcall UnRegisterCombo(TLMDRichCustomComboBox* aCombo);
	void __fastcall SetSelRange(int SelStart, int SelLength);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Lmdrtfbase::TLMDRichDialogPosition DlgPosition = {read=FDlgPosition, write=FDlgPosition, default=0};
	__property System::Classes::TNotifyEvent OnDlgCustomize = {read=FOnCustomize, write=FOnCustomize};
	__property System::Classes::TNotifyEvent OnDlgInit = {read=FOnDlgInit, write=FOnDlgInit};
	__property System::Classes::TNotifyEvent OnDlgAfterShow = {read=FOnDlgAfterShow, write=FOnDlgAfterShow};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool AcceptDropFiles = {read=FAcceptDropFiles, write=SetAcceptDropFiles, default=1};
	__property bool AllowInPlace = {read=FAllowInPlace, write=SetAllowInPlace, default=1};
	__property bool AllowObjects = {read=FAllowObjects, write=SetAllowObjects, default=1};
	__property bool AutoURLDetect = {read=GetAutoURLDetect, write=SetAutoURLDetect, default=0};
	__property bool AutoVerbMenu = {read=FAutoVerbMenu, write=FAutoVerbMenu, default=1};
	__property bool CanPaste = {read=GetCanPaste, nodefault};
	__property bool CanRedo = {read=GetCanRedo, nodefault};
	__property TLMDConversionClass DefaultConverter = {read=FDefaultConverter, write=FDefaultConverter};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property bool HideScrollBars = {read=FHideScrollBars, write=SetHideScrollBars, default=1};
	__property Lmdrtfruler::TLMDRTFRuler* Ruler = {read=FRuler, write=FRuler};
	__property TLMDRichLangOptions LanguageOptions = {read=GetLangOptions, write=SetLangOptions, default=2};
	__property System::Classes::TStrings* Lines = {read=FRichEditStrings, write=SetRichEditStrings, stored=IsStringsStored};
	__property Lmdrtfbase::TLMDRichPageMargins* PageRect = {read=FPageRect, write=FPageRect};
	__property int PrinterPageWidth = {read=FPrinterPageWidth, nodefault};
	__property TLMDParaAttributes* Paragraph = {read=FParagraph};
	__property bool PlainText = {read=GetPlainText, write=SetPlainText, default=0};
	__property TLMDRedoUndoType NextRedoAction = {read=GetRedoName, nodefault};
	__property System::_di_IInterface RichEditOle = {read=FRichEditOle};
	__property Lmdrtfstorage::TLMDRichStorage* RichStorage = {read=FRichStorage, write=SetStorage};
	__property int RichStorageItem = {read=FRichStorageItem, write=SetStorageItem, default=-1};
	__property bool ShowRuler = {read=FShowRuler, write=SetRuler, default=0};
	__property TLMDRichSelectionType SelectionType = {read=GetSelectionType, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property int UndoLimit = {read=FUndoLimit, write=SetUndoLimit, default=100};
	__property TLMDRedoUndoType NextUndoAction = {read=GetUndoName, nodefault};
	__property int Version = {read=GetVersion, write=SetVersion, stored=false, nodefault};
	__property TLMDZoom Zoom = {read=GetZoom, write=SetZoom, default=0};
	__property TLMDTextAttributes* DefAttributes = {read=FDefAttributes, write=SetDefAttributes};
	__property TLMDTextAttributes* SelAttributes = {read=FSelAttributes, write=SetSelAttributes};
	__property TLMDTextAttributes* WordAttributes = {read=FWordAttributes, write=SetWordAttributes};
	__property TLMDRichEditMode Mode = {read=FRichEditMode, write=SetRichEditMode, default=0};
	__property Lmdrtfbase::TLMDRichPageMargins* PageMargins = {read=FPageMargins, write=SetPageMargins};
	__property System::UnicodeString RTFText = {read=GetRTFText, write=SetRTFText};
	__property Vcl::Comctrls::TRichEditProtectChange OnProtectChange = {read=FOnProtectChange, write=FOnProtectChange};
	__property Vcl::Comctrls::TRichEditResizeEvent OnResizeRequest = {read=FOnResizeRequest, write=FOnResizeRequest};
	__property Vcl::Comctrls::TRichEditSaveClipboard OnSaveClipboard = {read=FOnSaveClipboard, write=FOnSaveClipboard};
	__property System::Classes::TNotifyEvent OnSelectionChange = {read=FOnSelChange, write=FOnSelChange};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerTabCreate = {read=GetOnRulerTabCreate, write=SetOnRulerTabCreate};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerTabChange = {read=GetOnRulerTabChange, write=SetOnRulerTabChange};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerTabDestroy = {read=GetOnRulerTabDestroy, write=SetOnRulerTabDestroy};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerFirstIdentChange = {read=GetOnRulerFirstIdentChange, write=SetOnRulerFirstIdentChange};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerLeftIdentChange = {read=GetOnRulerLeftIdentChange, write=SetOnRulerLeftIdentChange};
	__property Lmdrtfruler::TLMDRTFRulerEvent OnRulerRightIdentChange = {read=GetOnRulerRightIdentChange, write=SetOnRulerRightIdentChange};
	__property System::Types::TPoint CursorPos = {read=GetCurPos, write=SetCurPos};
	__property MaxLength = {default=0};
	__property Font;
	__property Alignment = {default=0};
	__property Lmdtypes::TLMDUnits Measurement = {read=FMeasurement, write=SetMeasurement, default=0};
	__property WordWrap = {default=1};
	__property bool ShowDefaultPopup = {read=FShowDefaultPopup, write=FShowDefaultPopup, default=1};
	__property TLMDRichTypographyOptions TypographyOptions = {read=GetTypographyOptions, write=SetTypographyOptions, default=1};
	__property int TopLineIndex = {read=GetTopLineIndex, write=SetTopLineIndex, nodefault};
	__property System::Classes::TNotifyEvent OnVScroll = {read=FOnVScroll, write=FOnVScroll};
	__property System::Classes::TNotifyEvent OnHScroll = {read=FOnHScroll, write=FOnHScroll};
	__property bool ProtectLinks = {read=FProtectLinks, write=SetProtectLinks, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property OnChange;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomRichEdit(HWND ParentWindow) : TLMDBaseCustomRichEdit(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDRichEdit : public TLMDCustomRichEdit
{
	typedef TLMDCustomRichEdit inherited;
	
__published:
	__property AcceptDropFiles = {default=1};
	__property AllowObjects = {default=1};
	__property AllowInPlace = {default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property AutoURLDetect = {default=0};
	__property AutoVerbMenu = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DlgPosition = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Mode = {default=0};
	__property Font;
	__property HideSelection = {default=1};
	__property HideScrollBars = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property Constraints;
	__property LanguageOptions = {default=2};
	__property Lines;
	__property MaxLength = {default=0};
	__property Measurement = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PageMargins;
	__property PlainText = {default=0};
	__property PopupMenu;
	__property ProtectLinks = {default=1};
	__property ReadOnly = {default=0};
	__property RichStorage;
	__property RichStorageItem = {default=-1};
	__property ShowRuler = {default=0};
	__property ScrollBars = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Title = {default=0};
	__property TypographyOptions = {default=1};
	__property UndoLimit = {default=100};
	__property Visible = {default=1};
	__property Version;
	__property WantTabs = {default=1};
	__property WantReturns = {default=1};
	__property WordWrap = {default=1};
	__property Zoom = {default=0};
	__property ShowDefaultPopup = {default=1};
	__property OnAfterSave;
	__property OnBeforeSave;
	__property OnContextPopup;
	__property OnDlgCustomize;
	__property OnDlgInit;
	__property OnDlgAfterShow;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnProtectChange;
	__property OnResizeRequest;
	__property OnSaveClipboard;
	__property OnSelectionChange;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnURLClick;
	__property OnLinkClick;
	__property OnRulerTabCreate;
	__property OnRulerTabChange;
	__property OnRulerTabDestroy;
	__property OnRulerFirstIdentChange;
	__property OnRulerLeftIdentChange;
	__property OnRulerRightIdentChange;
	__property OnVScroll;
	__property OnHScroll;
	__property OnDropFile;
	__property OnLinkMouseMove;
public:
	/* TLMDCustomRichEdit.Create */ inline __fastcall virtual TLMDRichEdit(System::Classes::TComponent* AOwner) : TLMDCustomRichEdit(AOwner) { }
	/* TLMDCustomRichEdit.Destroy */ inline __fastcall virtual ~TLMDRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichEdit(HWND ParentWindow) : TLMDCustomRichEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichCustomComboBox : public Lmdrtfbase::TLMDRichBaseComboBox
{
	typedef Lmdrtfbase::TLMDRichBaseComboBox inherited;
	
private:
	TLMDCustomRichEdit* FControl;
	void __fastcall SetControl(TLMDCustomRichEdit* const Value);
	
protected:
	virtual void __fastcall ChangeSettings(void) = 0 ;
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall UpdateInfo(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDRichCustomComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property TLMDCustomRichEdit* RichEditControl = {read=FControl, write=SetControl};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDRichCustomComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichCustomComboBox(HWND ParentWindow) : Lmdrtfbase::TLMDRichBaseComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<TLMDParaAlignment, 3> AlignConverter;
extern DELPHI_PACKAGE int __fastcall SafeStrToInt(const System::UnicodeString Value);
}	/* namespace Lmdrtfrichedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFRICHEDIT)
using namespace Lmdrtfrichedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfricheditHPP
