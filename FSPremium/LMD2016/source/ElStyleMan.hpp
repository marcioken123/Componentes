// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElStyleMan.pas' rev: 31.00 (Windows)

#ifndef ElstylemanHPP
#define ElstylemanHPP

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
#include <LMDDebugUnit.hpp>
#include <LMDTypes.hpp>
#include <ElVCLUtils.hpp>
#include <LMDFiles.hpp>
#include <ElImgLst.hpp>
#include <ElIni.hpp>
#include <ElComponent.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDObjectList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elstyleman
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElStyleManager;
class DELPHICLASS TElStyleMgrChangeLink;
class DELPHICLASS TElStyleController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElStyleManager : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
protected:
	Elini::TElIniFile* FStyles;
	Lmdobjectlist::TLMDObjectList* FLinksList;
	int FUpdateCount;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TStringList* FUsesList;
	System::Classes::TStringList* FValues;
	virtual void __fastcall TriggerChange(void);
	virtual void __fastcall NotifyLinks(void);
	void __fastcall DoApplyStyle(System::Classes::TComponent* AComponent, System::UnicodeString StyleName);
	void __fastcall WriteStyle(System::Classes::TStream* Stream);
	void __fastcall ReadStyle(System::Classes::TStream* Stream);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	
public:
	__fastcall virtual TElStyleManager(System::Classes::TComponent* AOwner);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall RegisterChanges(TElStyleMgrChangeLink* Value);
	void __fastcall UnregisterChanges(TElStyleMgrChangeLink* Value);
	__fastcall virtual ~TElStyleManager(void);
	void __fastcall ApplyStyle(System::Classes::TComponent* AComponent, System::UnicodeString StyleName);
	void __fastcall LoadFromFile(Lmdtypes::TLMDString FileName);
	void __fastcall SaveToFile(Lmdtypes::TLMDString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall Clear(void);
	void __fastcall GetStyleNames(System::Classes::TStrings* SL);
	System::UnicodeString __fastcall GetAncestorStyle(System::UnicodeString StyleName);
	void __fastcall GetProperties(System::UnicodeString StyleName, System::Classes::TStrings* PropNames);
	__property Elini::TElIniFile* Styles = {read=FStyles};
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TElStyleMgrChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElStyleManager* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TElStyleMgrChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property TElStyleManager* Sender = {read=FSender};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TObject.Create */ inline __fastcall TElStyleMgrChangeLink(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TElStyleController : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	TElStyleMgrChangeLink* FStyleMgrLink;
	
protected:
	TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	System::Classes::TComponent* FComponent;
	void __fastcall SetStyleManager(TElStyleManager* Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall UpdateStyle(void);
	void __fastcall SetComponent(System::Classes::TComponent* Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElStyleController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElStyleController(void);
	
__published:
	__property TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property System::Classes::TComponent* Component = {read=FComponent, write=SetComponent};
};


//-- var, const, procedure ---------------------------------------------------
#define sDefaultStyleName L"(Default)"
#define sTempStyleName L"...Temp"
extern DELPHI_PACKAGE TElStyleManager* __fastcall DefaultStyleManager(void);
}	/* namespace Elstyleman */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSTYLEMAN)
using namespace Elstyleman;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElstylemanHPP
