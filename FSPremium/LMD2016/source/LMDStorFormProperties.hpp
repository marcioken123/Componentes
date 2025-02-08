// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorFormProperties.pas' rev: 31.00 (Windows)

#ifndef LmdstorformpropertiesHPP
#define LmdstorformpropertiesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDStorPropertiesStorage.hpp>
#include <LMDStorBase.hpp>
#include <System.UITypes.hpp>
#include <LMDStorFormHook.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorformproperties
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorCustomFormProperties;
class DELPHICLASS TLMDStorFormStorage;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdstorformproperties__1 : unsigned char { fpColor, fpFont, fpPosition, fpHeight, fpWidth, fpWindowState };

typedef System::Set<Lmdstorformproperties__1, Lmdstorformproperties__1::fpColor, Lmdstorformproperties__1::fpWindowState> TLMDStorFormProps;

enum DECLSPEC_DENUM TLMDStorFormPosition : unsigned char { dfpUseDefaultValues, dfpDesktopCenter, dfpMainFormCenter, dfpOwnerFormCenter, dfpScreenPosCenter };

class PASCALIMPLEMENTATION TLMDStorCustomFormProperties : public Lmdstorpropertiesstorage::TLMDStorCustomPropertiesStorage
{
	typedef Lmdstorpropertiesstorage::TLMDStorCustomPropertiesStorage inherited;
	
private:
	TLMDStorFormProps FStorFormProps;
	int FDefaultTop;
	int FDefaultLeft;
	int FDefaultWidth;
	int FDefaultHeight;
	System::Uitypes::TWindowState FDefaultWindowState;
	TLMDStorFormPosition FDefaultPosition;
	void __fastcall SetDefaultTop(const int Value);
	void __fastcall SetDefaultLeft(const int Value);
	void __fastcall SetDefaultWidth(const int Value);
	void __fastcall SetDefaultHeight(const int Value);
	void __fastcall SetDefaultPosition(const TLMDStorFormPosition Value);
	void __fastcall SetDefaultWindowState(const System::Uitypes::TWindowState Value);
	void __fastcall SetStorFormProps(const TLMDStorFormProps Value);
	void __fastcall SetStorProps(void);
	
protected:
	virtual bool __fastcall IsPropListEmpty(void);
	__property int DefaultTop = {read=FDefaultTop, write=SetDefaultTop, default=0};
	__property int DefaultLeft = {read=FDefaultLeft, write=SetDefaultLeft, default=0};
	__property int DefaultWidth = {read=FDefaultWidth, write=SetDefaultWidth, default=0};
	__property int DefaultHeight = {read=FDefaultHeight, write=SetDefaultHeight, default=0};
	__property TLMDStorFormPosition DefaultPosition = {read=FDefaultPosition, write=SetDefaultPosition, default=0};
	__property System::Uitypes::TWindowState DefaultWindowState = {read=FDefaultWindowState, write=SetDefaultWindowState, default=0};
	__property TLMDStorFormProps StoredFormProps = {read=FStorFormProps, write=SetStorFormProps, nodefault};
	DYNAMIC void __fastcall DoOnLoadData(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnSaving(void);
	DYNAMIC void __fastcall OwnerFormDestroy(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDStorCustomFormProperties(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDStorCustomFormProperties(void);
	virtual void __fastcall Save(void);
};


class PASCALIMPLEMENTATION TLMDStorFormStorage : public TLMDStorCustomFormProperties
{
	typedef TLMDStorCustomFormProperties inherited;
	
__published:
	__property DefaultTop = {default=0};
	__property DefaultLeft = {default=0};
	__property DefaultWidth = {default=0};
	__property DefaultHeight = {default=0};
	__property DefaultPosition = {default=0};
	__property DefaultWindowState = {default=0};
	__property StoredFormProps;
	__property Enabled = {default=1};
	__property StorageVault;
	__property AutoLoad = {default=1};
	__property AutoSave = {default=1};
	__property OnLoading;
	__property OnSaving;
	__property OnLoadData;
	__property OnSaveData;
	__property OnNoStorageData;
public:
	/* TLMDStorCustomFormProperties.Create */ inline __fastcall virtual TLMDStorFormStorage(System::Classes::TComponent* aOwner) : TLMDStorCustomFormProperties(aOwner) { }
	/* TLMDStorCustomFormProperties.Destroy */ inline __fastcall virtual ~TLMDStorFormStorage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_FormProps (System::Set<Lmdstorformproperties__1, Lmdstorformproperties__1::fpColor, Lmdstorformproperties__1::fpWindowState>() << Lmdstorformproperties__1::fpPosition << Lmdstorformproperties__1::fpHeight << Lmdstorformproperties__1::fpWidth << Lmdstorformproperties__1::fpWindowState )
}	/* namespace Lmdstorformproperties */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORFORMPROPERTIES)
using namespace Lmdstorformproperties;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorformpropertiesHPP
