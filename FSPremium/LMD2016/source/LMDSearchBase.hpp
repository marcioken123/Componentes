// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSearchBase.pas' rev: 31.00 (Windows)

#ifndef LmdsearchbaseHPP
#define LmdsearchbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <LMDSearchConsts.hpp>
#include <LMDRVEFormUnit.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsearchbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSearchOptions;
class DELPHICLASS TLMDSearchBaseDlgComponent;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TLMDSearchTemplate;

enum DECLSPEC_DENUM Lmdsearchbase__1 : unsigned char { vboShowEvaluateButton, vboShowCancelButton, vboShowHelpButton, vboShowGlyphs, vboShowOptionsPage, vboAutoSelect, vboCenterDialog, vboCenterOwnerForm, vboSimpleInterface };

typedef System::Set<Lmdsearchbase__1, Lmdsearchbase__1::vboShowEvaluateButton, Lmdsearchbase__1::vboSimpleInterface> TLMDSPDialogOptions;

class PASCALIMPLEMENTATION TLMDSearchOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FNearestLength;
	bool FMatchCase;
	bool FWholeWordsOnly;
	System::Byte FUpdate;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetNearestLength(const int Value);
	void __fastcall SetMatchCase(const bool Value);
	void __fastcall SetWholeWordsOnly(const bool Value);
	
public:
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool Update = true);
	void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__fastcall virtual TLMDSearchOptions(System::Classes::TComponent* AOwner);
	__property int NearestLength = {read=FNearestLength, write=SetNearestLength, default=50};
	__property bool MatchCase = {read=FMatchCase, write=SetMatchCase, default=0};
	__property bool WholeWordsOnly = {read=FWholeWordsOnly, write=SetWholeWordsOnly, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDSearchOptions(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSearchBaseDlgComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDSPDialogOptions FOptions;
	System::Classes::TNotifyEvent FOnCustomize;
	System::Classes::TNotifyEvent FOnHelp;
	TLMDSearchOptions* FSearchOptions;
	System::WideChar FAnySingleCharacter;
	System::WideChar FAnySequenceCharacter;
	void __fastcall SetSearchOptions(TLMDSearchOptions* const Value);
	void __fastcall SetAnySingleCharacter(const System::WideChar Value);
	void __fastcall SetAnySequenceCharacter(const System::WideChar Value);
	
protected:
	virtual void __fastcall SetTemplate(const TLMDSearchTemplate Value);
	virtual TLMDSearchTemplate __fastcall GetTemplate(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	__property System::Classes::TNotifyEvent OnDlgHelpClick = {read=FOnHelp, write=FOnHelp};
	__property System::Classes::TNotifyEvent OnDlgCustomize = {read=FOnCustomize, write=FOnCustomize};
	__property TLMDSPDialogOptions DlgBuilderOptions = {read=FOptions, write=FOptions, default=339};
	__property TLMDSearchOptions* SearchOptions = {read=FSearchOptions, write=SetSearchOptions};
	__property TLMDSearchTemplate SearchString = {read=GetTemplate, write=SetTemplate};
	
public:
	__fastcall virtual TLMDSearchBaseDlgComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSearchBaseDlgComponent(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
	__property System::WideChar AnySingleCharacter = {read=FAnySingleCharacter, write=SetAnySingleCharacter, nodefault};
	__property System::WideChar AnySequenceCharacter = {read=FAnySequenceCharacter, write=SetAnySequenceCharacter, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define def_SPDialogOptions (System::Set<Lmdsearchbase__1, Lmdsearchbase__1::vboShowEvaluateButton, Lmdsearchbase__1::vboSimpleInterface>() << Lmdsearchbase__1::vboShowEvaluateButton << Lmdsearchbase__1::vboShowCancelButton << Lmdsearchbase__1::vboShowOptionsPage << Lmdsearchbase__1::vboCenterDialog << Lmdsearchbase__1::vboSimpleInterface )
extern DELPHI_PACKAGE void __fastcall LMDSPSetUpDialog(Lmdrveformunit::TLMDRVEForm* VisualBuilderForm, TLMDSearchBaseDlgComponent* aComponent);
extern DELPHI_PACKAGE void __fastcall LMDSPAssignDialogValues(Lmdrveformunit::TLMDRVEForm* VisualBuilderForm, TLMDSearchBaseDlgComponent* aComponent);
}	/* namespace Lmdsearchbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEARCHBASE)
using namespace Lmdsearchbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsearchbaseHPP
