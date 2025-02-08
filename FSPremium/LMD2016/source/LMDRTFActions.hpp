// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFActions.pas' rev: 31.00 (Windows)

#ifndef LmdrtfactionsHPP
#define LmdrtfactionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDRTFRichEdit.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfactions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichEditAction;
class DELPHICLASS TLMDRichEditOutTo;
class DELPHICLASS TLMDRichEditBaseEditAction;
class DELPHICLASS TLMDRichEditNew;
class DELPHICLASS TLMDRichEditLoad;
class DELPHICLASS TLMDRichEditSave;
class DELPHICLASS TLMDRichEditSaveAs;
class DELPHICLASS TLMDRichEditFind;
class DELPHICLASS TLMDRichEditReplace;
class DELPHICLASS TLMDRichEditParagraph;
class DELPHICLASS TLMDRichEditParaAlign;
class DELPHICLASS TLMDRichEditParaAlignLeft;
class DELPHICLASS TLMDRichEditParaAlignCenter;
class DELPHICLASS TLMDRichEditParaAlignRight;
class DELPHICLASS TLMDRichEditNumbering;
class DELPHICLASS TLMDRichEditNumberingBullet;
class DELPHICLASS TLMDRichEditNumberingArabicNumbers;
class DELPHICLASS TLMDRichEditTextAttributes;
class DELPHICLASS TLMDRichEditTextFontStyle;
class DELPHICLASS TLMDRichEditTextBold;
class DELPHICLASS TLMDRichEditTextItalic;
class DELPHICLASS TLMDRichEditTextUnderline;
class DELPHICLASS TLMDRichEditTextSubscript;
class DELPHICLASS TLMDRichEditTextSuperscript;
class DELPHICLASS TLMDRichEditUndo;
class DELPHICLASS TLMDRichEditRedo;
class DELPHICLASS TLMDRichEditPrint;
class DELPHICLASS TLMDRichEditPreview;
class DELPHICLASS TLMDRichEditPageSetting;
class DELPHICLASS TLMDRichEditCut;
class DELPHICLASS TLMDRichEditCopy;
class DELPHICLASS TLMDRichEditPaste;
class DELPHICLASS TLMDRichEditInsertObject;
class DELPHICLASS TLMDRichEditObjectProperties;
class DELPHICLASS TLMDRichEditPasteSpecial;
class DELPHICLASS TLMDRichEditSelectAll;
class DELPHICLASS TLMDRichEditDelete;
class DELPHICLASS TLMDRichEditIndent;
class DELPHICLASS TLMDRichEditUnindent;
class DELPHICLASS TLMDRichEditInsertChar;
class DELPHICLASS TLMDRichEditInsertDateTime;
class DELPHICLASS TLMDRichEditStatistics;
class DELPHICLASS TLMDRTFSupportedAction;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDAllowExecuteEvent)(System::TObject* Sender, bool &Allow);

class PASCALIMPLEMENTATION TLMDRichEditAction : public Vcl::Actnlist::TAction
{
	typedef Vcl::Actnlist::TAction inherited;
	
private:
	Lmdrtfrichedit::TLMDCustomRichEdit* FControl;
	TLMDAllowExecuteEvent FOnAllowExecute;
	System::Classes::TNotifyEvent FOnAfterExecute;
	void __fastcall SetControl(Lmdrtfrichedit::TLMDCustomRichEdit* Value);
	
protected:
	virtual void __fastcall AfterExecute(void);
	virtual bool __fastcall AllowExecute(void);
	virtual Lmdrtfrichedit::TLMDCustomRichEdit* __fastcall GetControl(System::TObject* Target);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	bool __fastcall CanChange(System::TObject* Target);
	bool __fastcall HasData(System::TObject* Target);
	bool __fastcall HasSelected(System::TObject* Target);
	virtual bool __fastcall vExecuteTarget(Lmdrtfrichedit::TLMDCustomRichEdit* RichEdit);
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	__property Lmdrtfrichedit::TLMDCustomRichEdit* Control = {read=FControl, write=SetControl};
	
__published:
	__property TLMDAllowExecuteEvent OnAllowExecute = {read=FOnAllowExecute, write=FOnAllowExecute};
	__property System::Classes::TNotifyEvent OnAfterExecute = {read=FOnAfterExecute, write=FOnAfterExecute};
public:
	/* TAction.Create */ inline __fastcall virtual TLMDRichEditAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditAction(void) { }
	
};


typedef System::TMetaClass* TLMDRichEditActionClass;

class PASCALIMPLEMENTATION TLMDRichEditOutTo : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
public:
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAction.Create */ inline __fastcall virtual TLMDRichEditOutTo(System::Classes::TComponent* AOwner) : TLMDRichEditAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditOutTo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditBaseEditAction : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
public:
	/* TAction.Create */ inline __fastcall virtual TLMDRichEditBaseEditAction(System::Classes::TComponent* AOwner) : TLMDRichEditAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditBaseEditAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditNew : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
protected:
	virtual bool __fastcall vExecuteTarget(Lmdrtfrichedit::TLMDCustomRichEdit* RichEdit);
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditNew(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditNew(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditLoad : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
private:
	System::UnicodeString FDefaultExt;
	System::UnicodeString FFilter;
	System::UnicodeString FInitialDir;
	System::Uitypes::TOpenOptions FOptions;
	System::UnicodeString FTitle;
	bool __fastcall IsCustom(void);
	
protected:
	virtual bool __fastcall vExecuteTarget(Lmdrtfrichedit::TLMDCustomRichEdit* RichEdit);
	
public:
	__fastcall virtual TLMDRichEditLoad(System::Classes::TComponent* aOwner);
	
__published:
	__property System::UnicodeString DefaultExt = {read=FDefaultExt, write=FDefaultExt};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter, stored=IsCustom};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property System::Uitypes::TOpenOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditLoad(void) { }
	
};


typedef void __fastcall (__closure *TLMDRichEditSaveEvent)(System::TObject* Sender, System::TObject* Target, bool &Saved);

class PASCALIMPLEMENTATION TLMDRichEditSave : public TLMDRichEditOutTo
{
	typedef TLMDRichEditOutTo inherited;
	
private:
	bool FSaved;
	TLMDRichEditSaveEvent FOnUnNamedFile;
	
public:
	__fastcall virtual TLMDRichEditSave(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	__property bool Saved = {read=FSaved, nodefault};
	
__published:
	__property TLMDRichEditSaveEvent OnUnknownFilename = {read=FOnUnNamedFile, write=FOnUnNamedFile};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditSave(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditSaveAs : public TLMDRichEditLoad
{
	typedef TLMDRichEditLoad inherited;
	
private:
	bool FSaved;
	
public:
	__fastcall virtual TLMDRichEditSaveAs(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	__property bool Saved = {read=FSaved, nodefault};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditSaveAs(void) { }
	
};


typedef System::TMetaClass* TFindDialogClass;

class PASCALIMPLEMENTATION TLMDRichEditFind : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
private:
	Vcl::Dialogs::TFindDialog* FDialog;
	System::Classes::TNotifyEvent FDlgOnShow;
	System::Classes::TNotifyEvent FDlgOnClose;
	Lmdrtfrichedit::TLMDCustomRichEdit* FRichEdit;
	TFindDialogClass DialogClass;
	void __fastcall DoFindReplace(System::TObject* Sender);
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditFind(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRichEditFind(void);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property System::Classes::TNotifyEvent OnDlgClose = {read=FDlgOnClose, write=FDlgOnClose};
	__property System::Classes::TNotifyEvent OnDlgShow = {read=FDlgOnShow, write=FDlgOnShow};
};


class PASCALIMPLEMENTATION TLMDRichEditReplace : public TLMDRichEditFind
{
	typedef TLMDRichEditFind inherited;
	
public:
	__fastcall virtual TLMDRichEditReplace(System::Classes::TComponent* aOwner);
public:
	/* TLMDRichEditFind.Destroy */ inline __fastcall virtual ~TLMDRichEditReplace(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditParagraph : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditParagraph(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditParagraph(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditParaAlign : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
private:
	Lmdrtfrichedit::TLMDParaAlignment FAlignment;
	
public:
	__fastcall virtual TLMDRichEditParaAlign(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property Lmdrtfrichedit::TLMDParaAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditParaAlign(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditParaAlignLeft : public TLMDRichEditParaAlign
{
	typedef TLMDRichEditParaAlign inherited;
	
public:
	__fastcall virtual TLMDRichEditParaAlignLeft(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditParaAlignLeft(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditParaAlignCenter : public TLMDRichEditParaAlign
{
	typedef TLMDRichEditParaAlign inherited;
	
public:
	__fastcall virtual TLMDRichEditParaAlignCenter(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditParaAlignCenter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditParaAlignRight : public TLMDRichEditParaAlign
{
	typedef TLMDRichEditParaAlign inherited;
	
public:
	__fastcall virtual TLMDRichEditParaAlignRight(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditParaAlignRight(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditNumbering : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
private:
	int FFirstIndent;
	int FLeftIndent;
	Lmdrtfrichedit::TLMDNumbering FNumbering;
	Lmdrtfrichedit::TLMDNumberingStyle FNumberingStyle;
	int FNumberingStart;
	
public:
	__fastcall virtual TLMDRichEditNumbering(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property Lmdrtfrichedit::TLMDNumbering Numbering = {read=FNumbering, write=FNumbering, nodefault};
	__property Lmdrtfrichedit::TLMDNumberingStyle NumberingStyle = {read=FNumberingStyle, write=FNumberingStyle, nodefault};
	__property int NumberingStart = {read=FNumberingStart, write=FNumberingStart, default=1};
	__property int FirstIndent = {read=FFirstIndent, write=FFirstIndent, default=-10};
	__property int LeftIndent = {read=FLeftIndent, write=FLeftIndent, default=10};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditNumbering(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditNumberingBullet : public TLMDRichEditNumbering
{
	typedef TLMDRichEditNumbering inherited;
	
public:
	__fastcall virtual TLMDRichEditNumberingBullet(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditNumberingBullet(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditNumberingArabicNumbers : public TLMDRichEditNumbering
{
	typedef TLMDRichEditNumbering inherited;
	
public:
	__fastcall virtual TLMDRichEditNumberingArabicNumbers(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditNumberingArabicNumbers(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextAttributes : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditTextAttributes(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextAttributes(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextFontStyle : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual System::Uitypes::TFontStyles __fastcall FontStyle(void);
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAction.Create */ inline __fastcall virtual TLMDRichEditTextFontStyle(System::Classes::TComponent* AOwner) : TLMDRichEditBaseEditAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextFontStyle(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextBold : public TLMDRichEditTextFontStyle
{
	typedef TLMDRichEditTextFontStyle inherited;
	
protected:
	virtual System::Uitypes::TFontStyles __fastcall FontStyle(void);
	
public:
	__fastcall virtual TLMDRichEditTextBold(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextBold(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextItalic : public TLMDRichEditTextFontStyle
{
	typedef TLMDRichEditTextFontStyle inherited;
	
protected:
	virtual System::Uitypes::TFontStyles __fastcall FontStyle(void);
	
public:
	__fastcall virtual TLMDRichEditTextItalic(System::Classes::TComponent* aOwner);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextItalic(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextUnderline : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
private:
	Lmdrtfrichedit::TLMDUnderlineType FUnderlineType;
	
public:
	__fastcall virtual TLMDRichEditTextUnderline(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property Lmdrtfrichedit::TLMDUnderlineType UnderlineType = {read=FUnderlineType, write=FUnderlineType, default=1};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextUnderline(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextSubscript : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditTextSubscript(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextSubscript(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditTextSuperscript : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditTextSuperscript(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditTextSuperscript(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditUndo : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditUndo(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditUndo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditRedo : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditRedo(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditRedo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditPrint : public TLMDRichEditOutTo
{
	typedef TLMDRichEditOutTo inherited;
	
private:
	bool FShowDialog;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditPrint(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditPrint(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditPreview : public TLMDRichEditOutTo
{
	typedef TLMDRichEditOutTo inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditPreview(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditPreview(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditPageSetting : public TLMDRichEditOutTo
{
	typedef TLMDRichEditOutTo inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditPageSetting(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditPageSetting(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditCut : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditCut(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditCut(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditCopy : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditCopy(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditCopy(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditPaste : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditPaste(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditPaste(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditInsertObject : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditInsertObject(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditInsertObject(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditObjectProperties : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditObjectProperties(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditObjectProperties(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditPasteSpecial : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditPasteSpecial(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditPasteSpecial(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditSelectAll : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditSelectAll(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditSelectAll(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditDelete : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditDelete(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditDelete(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditIndent : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
private:
	int FIndent;
	void __fastcall SetIndent(int V);
	
public:
	__fastcall virtual TLMDRichEditIndent(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property int IndentValue = {read=FIndent, write=SetIndent, default=10};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditIndent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditUnindent : public TLMDRichEditIndent
{
	typedef TLMDRichEditIndent inherited;
	
protected:
	virtual bool __fastcall IsEnabled(System::TObject* Target);
	
public:
	__fastcall virtual TLMDRichEditUnindent(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditUnindent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditInsertChar : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditInsertChar(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditInsertChar(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditInsertDateTime : public TLMDRichEditBaseEditAction
{
	typedef TLMDRichEditBaseEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditInsertDateTime(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditInsertDateTime(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichEditStatistics : public TLMDRichEditAction
{
	typedef TLMDRichEditAction inherited;
	
public:
	__fastcall virtual TLMDRichEditStatistics(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDRichEditStatistics(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFSupportedAction : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	__fastcall TLMDRTFSupportedAction(void);
	__fastcall virtual ~TLMDRTFSupportedAction(void);
	HIDESBASE System::ShortString __fastcall ClassName(int Index);
	TLMDRichEditAction* __fastcall GetAction(int Index);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define sDefaultFilter L"Rich Text files (*.rtf)|*.rtf|Text Files (*.txt)|*.txt|All"\
	L" Files (*.*)|*.*"
}	/* namespace Lmdrtfactions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFACTIONS)
using namespace Lmdrtfactions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfactionsHPP
