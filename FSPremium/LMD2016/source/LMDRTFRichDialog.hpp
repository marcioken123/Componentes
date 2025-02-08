// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFRichDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtfrichdialogHPP
#define LmdrtfrichdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFRichDialogForm.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfrichdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichDialogGeneral;
class DELPHICLASS TLMDRichDialogEditor;
class DELPHICLASS TLMDRichDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdrtfrichdialog__1 : unsigned char { rdaNew, rdaLoad, rdaSave, rdaPrint, rdaPreview, rdaFind, rdaCut, rdaCopy, rdaPaste, rdaUndo, rdaRedo, rdaTextAttributes, rdaTextBold, rdaTextItalic, rdaTextUnderline, rdaTextSubscript, rdaTextSuperscript, rdaParaAlign1, rdaParaAlign2, rdaParaAlign3, rdaNumbering1, rdaNumbering2, rdaIndent, rdaUnindent };

typedef System::Set<Lmdrtfrichdialog__1, Lmdrtfrichdialog__1::rdaNew, Lmdrtfrichdialog__1::rdaUnindent> TLMDRichDialogActions;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichDialogGeneral : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FShowMainMenu;
	bool FShowStatusBar;
	bool FShowToolbar;
	System::UnicodeString FCaption;
	int FLeft;
	int FTop;
	int FHeight;
	int FWidth;
	
public:
	__fastcall TLMDRichDialogGeneral(void);
	__fastcall virtual ~TLMDRichDialogGeneral(void);
	
__published:
	__property bool ShowMainMenu = {read=FShowMainMenu, write=FShowMainMenu, default=1};
	__property bool ShowStatusBar = {read=FShowStatusBar, write=FShowStatusBar, default=1};
	__property bool ShowToolbar = {read=FShowToolbar, write=FShowToolbar, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property int Left = {read=FLeft, write=FLeft, default=-1};
	__property int Top = {read=FTop, write=FTop, default=-1};
	__property int Height = {read=FHeight, write=FHeight, default=-1};
	__property int Width = {read=FWidth, write=FWidth, default=-1};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichDialogEditor : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FShowRuler;
	bool FAutoURLDetect;
	System::Uitypes::TScrollStyle FScrollBars;
	bool FHideScrollBars;
	Lmdtypes::TLMDUnits FMeasurement;
	
public:
	__fastcall TLMDRichDialogEditor(void);
	__fastcall virtual ~TLMDRichDialogEditor(void);
	
__published:
	__property bool ShowRuler = {read=FShowRuler, write=FShowRuler, default=1};
	__property bool AutoURLDetect = {read=FAutoURLDetect, write=FAutoURLDetect, default=0};
	__property System::Uitypes::TScrollStyle ScrollBars = {read=FScrollBars, write=FScrollBars, default=0};
	__property bool HideScrollBars = {read=FHideScrollBars, write=FHideScrollBars, default=1};
	__property Lmdtypes::TLMDUnits Measurement = {read=FMeasurement, write=FMeasurement, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDRichDialog : public Lmdrtfbase::TLMDRichComponent
{
	typedef Lmdrtfbase::TLMDRichComponent inherited;
	
private:
	Lmdrtfrichdialogform::TLMDRichDialogForm* FDialog;
	TLMDRichDialogGeneral* FGeneral;
	TLMDRichDialogEditor* FEditor;
	TLMDRichDialogActions FActions;
	void __fastcall SetDialog(Lmdrtfrichdialogform::TLMDRichDialogForm* const Value);
	void __fastcall SetGeneral(TLMDRichDialogGeneral* const Value);
	void __fastcall SetEditor(TLMDRichDialogEditor* const Value);
	void __fastcall SetActions(const TLMDRichDialogActions Value);
	
protected:
	void __fastcall SetUpRichDialog(void);
	
public:
	__fastcall virtual TLMDRichDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRichDialog(void);
	void __fastcall Execute(void);
	__property Lmdrtfrichdialogform::TLMDRichDialogForm* Dialog = {read=FDialog, write=SetDialog};
	
__published:
	__property TLMDRichDialogGeneral* General = {read=FGeneral, write=SetGeneral};
	__property TLMDRichDialogEditor* Editor = {read=FEditor, write=SetEditor};
	__property TLMDRichDialogActions Actions = {read=FActions, write=SetActions, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfrichdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFRICHDIALOG)
using namespace Lmdrtfrichdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfrichdialogHPP
