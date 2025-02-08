// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStyleMan.pas' rev: 31.00 (Windows)

#ifndef LmdstylemanHPP
#define LmdstylemanHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.TypInfo.hpp>
#include <System.SysUtils.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseController.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <LMDCFCStateObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstyleman
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStyleManager;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 7> Lmdstyleman__1;

class PASCALIMPLEMENTATION TLMDStyleManager : public Lmdbasecontroller::TLMDBaseController
{
	typedef Lmdbasecontroller::TLMDBaseController inherited;
	
protected:
	System::Classes::TStringList* FStyleNames;
	Lmdinictrl::TLMDIniCtrl* FStyles;
	int FUpdateCount;
	System::Classes::TStringList* FUsesList;
	System::Classes::TStringList* FValues;
	virtual void __fastcall TriggerChange(void);
	void __fastcall DoApplyStyle(System::Classes::TComponent* AComponent, System::UnicodeString StyleName);
	void __fastcall WriteStyle(System::Classes::TStream* Stream);
	void __fastcall ReadStyle(System::Classes::TStream* Stream);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	void __fastcall ApplyStyle(System::Classes::TComponent* AComponent, System::UnicodeString AStyleNameQualifier, bool ACascadeStyles = true, System::UnicodeString AStateStyleName = System::UnicodeString());
	HIDESBASE void __fastcall BeginUpdate(void);
	void __fastcall Clear(void);
	__fastcall virtual TLMDStyleManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStyleManager(void);
	HIDESBASE void __fastcall EndUpdate(void);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall EraseProperty(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName);
	void __fastcall EraseStyle(System::UnicodeString AStyleName);
	void __fastcall GetStyleNames(System::Classes::TStrings* SL);
	void __fastcall GetProperties(System::UnicodeString AStyleName, System::Classes::TStrings* APropNames);
	bool __fastcall IsStateStyle(System::UnicodeString AStyleName);
	bool __fastcall IsValidStyleName(System::UnicodeString AStyleName);
	bool __fastcall PropValueExists(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName);
	void __fastcall RenameStyle(System::UnicodeString AOldName, System::UnicodeString ANewName);
	void __fastcall ReadPropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, int &AValue)/* overload */;
	void __fastcall ReadPropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, double &AValue)/* overload */;
	void __fastcall ReadPropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, System::UnicodeString &AValue)/* overload */;
	void __fastcall ReadPropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, System::Classes::TMemoryStream* &AValue)/* overload */;
	void __fastcall WritePropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, int AValue)/* overload */;
	void __fastcall WritePropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, double AValue)/* overload */;
	void __fastcall WritePropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, System::UnicodeString AValue)/* overload */;
	void __fastcall WritePropValue(System::UnicodeString AStyleName, System::UnicodeString APropName, System::UnicodeString ATypeName, System::Classes::TStream* AValue)/* overload */;
};


//-- var, const, procedure ---------------------------------------------------
#define sDefaultStyleName L"(Default)"
#define sTempStyleName L"...Temp"
static const System::WideChar AncestorDelim = (System::WideChar)(0x7c);
static const System::WideChar TypeNameDelim = (System::WideChar)(0x3a);
static const System::WideChar StylePrefix = (System::WideChar)(0x2e);
#define StyleKindStringID L"_StyleKind"
extern DELPHI_PACKAGE Lmdstyleman__1 StateStyleNames;
}	/* namespace Lmdstyleman */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTYLEMAN)
using namespace Lmdstyleman;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstylemanHPP
