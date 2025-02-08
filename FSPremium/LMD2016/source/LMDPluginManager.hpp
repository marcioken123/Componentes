// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPluginManager.pas' rev: 31.00 (Windows)

#ifndef LmdpluginmanagerHPP
#define LmdpluginmanagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpluginmanager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseMenuController;
class DELPHICLASS TLMDBaseToolbarController;
__interface ILMDHost;
typedef System::DelphiInterface<ILMDHost> _di_ILMDHost;
__interface ILMDPluginForm;
typedef System::DelphiInterface<ILMDPluginForm> _di_ILMDPluginForm;
__interface ILMDDelphiPluginForm;
typedef System::DelphiInterface<ILMDDelphiPluginForm> _di_ILMDDelphiPluginForm;
__interface ILMDFormWithData;
typedef System::DelphiInterface<ILMDFormWithData> _di_ILMDFormWithData;
__interface ILMDParameter;
typedef System::DelphiInterface<ILMDParameter> _di_ILMDParameter;
__interface ILMDParametersEnum;
typedef System::DelphiInterface<ILMDParametersEnum> _di_ILMDParametersEnum;
__interface ILMDAction;
typedef System::DelphiInterface<ILMDAction> _di_ILMDAction;
__interface ILMDActionEnum;
typedef System::DelphiInterface<ILMDActionEnum> _di_ILMDActionEnum;
__interface ILMDPluginEvent;
typedef System::DelphiInterface<ILMDPluginEvent> _di_ILMDPluginEvent;
__interface ILMDPlugin;
typedef System::DelphiInterface<ILMDPlugin> _di_ILMDPlugin;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseMenuController : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDBaseMenuController(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseMenuController(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseToolbarController : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDBaseToolbarController(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseToolbarController(void) { }
	
};

#pragma pack(pop)

__interface  INTERFACE_UUID("{66BAAB09-7AF9-4F1F-9002-E4092E2CD8E3}") ILMDHost  : public System::IInterface 
{
	
};

__interface  INTERFACE_UUID("{9BA7E398-3673-4213-B2B2-6287EC3D6466}") ILMDPluginForm  : public System::IInterface 
{
	virtual void __stdcall Show(void) = 0 ;
	virtual void __stdcall Hide(void) = 0 ;
	virtual void __stdcall ShowAsMDIChild(Vcl::Forms::TForm* AParentForm) = 0 ;
	virtual void __stdcall ShowModal(void) = 0 ;
	virtual void __stdcall ShowParented(HWND AParentWindow) = 0 ;
	virtual void __stdcall SetFormData(void * AData) = 0 ;
	virtual System::WideString __stdcall GetTitle(void) = 0 ;
	virtual void __stdcall SetTitle(System::WideString ATitle) = 0 ;
	virtual bool __stdcall GetVisible(void) = 0 ;
	virtual void __stdcall SetVisible(bool AVisible) = 0 ;
	virtual System::WideString __stdcall GetFormName(void) = 0 ;
	__property bool Visible = {read=GetVisible, write=SetVisible};
	__property System::WideString Title = {read=GetTitle, write=SetTitle};
	__property System::WideString FormName = {read=GetFormName};
};

__interface  INTERFACE_UUID("{0BEF55CC-2761-4CCB-B08A-553766806984}") ILMDDelphiPluginForm  : public ILMDPluginForm 
{
	virtual Vcl::Forms::TForm* __stdcall GetTFormInstance(void) = 0 ;
};

__interface  INTERFACE_UUID("{8999ED41-2791-4471-BFEB-994923CE1CD4}") ILMDFormWithData  : public System::IInterface 
{
	virtual void __fastcall SetFormData(void * AData) = 0 ;
};

enum DECLSPEC_DENUM TLMDParameterType : unsigned char { ptBoolean, ptInteger, ptReal, ptString, ptCurrency, ptSmallInt, ptWord, ptLongWord, ptInt64, ptObject, ptPointer, ptDynArray, ptDateTime, ptGUID };

__interface  INTERFACE_UUID("{CD1FA603-752B-45E5-921F-97F1C8D61644}") ILMDParameter  : public System::IInterface 
{
	virtual HRESULT __stdcall GetValue(/* out */ void * &APointer) = 0 ;
	virtual TLMDParameterType __stdcall GetType(void) = 0 ;
	virtual HRESULT __stdcall SetValue(const void * APointer) = 0 ;
	virtual void __stdcall SetType(const TLMDParameterType AType) = 0 ;
	virtual bool __stdcall GetIsOptional(void) = 0 ;
	virtual Lmdtypes::TLMDString __stdcall GetName(void) = 0 ;
	virtual void __stdcall SetIsOptional(const bool AIsOptional) = 0 ;
	virtual void __stdcall SetAsBoolean(const bool AValue) = 0 ;
	virtual void __stdcall SetAsInteger(const int AValue) = 0 ;
	virtual void __stdcall SetAsReal(const System::Extended AValue) = 0 ;
	virtual void __stdcall SetAsString(const System::WideString AValue) = 0 ;
	virtual void __stdcall SetAsCurrency(const System::Currency AValue) = 0 ;
	virtual void __stdcall SetAsSmallInt(const short AValue) = 0 ;
	virtual void __stdcall SetAsWord(const System::Word AValue) = 0 ;
	virtual void __stdcall SetAsLongWord(const unsigned AValue) = 0 ;
	virtual void __stdcall SetAsInt64(const __int64 AValue) = 0 ;
	virtual void __stdcall SetAsObject(System::TObject* const AValue) = 0 ;
	virtual void __stdcall SetAsPointer(const void * AValue) = 0 ;
	virtual void __stdcall SetAsByteDynArray(const System::TByteDynArray AValue) = 0 ;
	virtual void __stdcall SetAsIntegerDynArray(const System::TIntegerDynArray AValue) = 0 ;
	virtual void __stdcall SetAsWordDynArray(const System::TWordDynArray AValue) = 0 ;
	virtual void __stdcall SetAsInt64DynArray(const System::TInt64DynArray AValue) = 0 ;
	virtual void __stdcall SetAsWideStringDynArray(const System::TWideStringDynArray AValue) = 0 ;
	virtual void __stdcall SetAsLongWordDynArray(const System::TLongWordDynArray AValue) = 0 ;
	virtual void __stdcall SetAsDoubleDynArray(const System::TDoubleDynArray AValue) = 0 ;
	virtual void __stdcall SetAsBooleanDynArray(const System::TBooleanDynArray AValue) = 0 ;
	virtual void __stdcall SetAsGUID(const GUID &AValue) = 0 ;
	virtual bool __stdcall GetAsBoolean(void) = 0 ;
	virtual int __stdcall GetAsInteger(void) = 0 ;
	virtual System::Extended __stdcall GetAsReal(void) = 0 ;
	virtual System::WideString __stdcall GetAsString(void) = 0 ;
	virtual System::Currency __stdcall GetAsCurrency(void) = 0 ;
	virtual short __stdcall GetAsSmallInt(void) = 0 ;
	virtual System::Word __stdcall GetAsWord(void) = 0 ;
	virtual unsigned __stdcall GetAsLongWord(void) = 0 ;
	virtual __int64 __stdcall GetAsInt64(void) = 0 ;
	virtual System::TObject* __stdcall GetAsObject(void) = 0 ;
	virtual void * __stdcall GetAsPointer(void) = 0 ;
	virtual System::TByteDynArray __stdcall GetAsByteDynArray(void) = 0 ;
	virtual System::TIntegerDynArray __stdcall GetAsIntegerDynArray(void) = 0 ;
	virtual System::TWordDynArray __stdcall GetAsWordDynArray(void) = 0 ;
	virtual System::TInt64DynArray __stdcall GetAsInt64DynArray(void) = 0 ;
	virtual System::TWideStringDynArray __stdcall GetAsWideStringDynArray(void) = 0 ;
	virtual System::TLongWordDynArray __stdcall GetAsLongWordDynArray(void) = 0 ;
	virtual System::TDoubleDynArray __stdcall GetAsDoubleDynArray(void) = 0 ;
	virtual System::TBooleanDynArray __stdcall GetAsBooleanDynArray(void) = 0 ;
	virtual GUID __stdcall GetAsGUID(void) = 0 ;
	__property bool AsBoolean = {read=GetAsBoolean, write=SetAsBoolean};
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger};
	__property System::Extended AsReal = {read=GetAsReal, write=SetAsReal};
	__property System::WideString AsString = {read=GetAsString, write=SetAsString};
	__property System::Currency AsCurrency = {read=GetAsCurrency, write=SetAsCurrency};
	__property short AsSmallInt = {read=GetAsSmallInt, write=SetAsSmallInt};
	__property System::Word AsWord = {read=GetAsWord, write=SetAsWord};
	__property unsigned AsLongWord = {read=GetAsLongWord, write=SetAsLongWord};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
	__property void * AsPointer = {read=GetAsPointer, write=SetAsPointer};
	__property System::TByteDynArray AsByteArray = {read=GetAsByteDynArray, write=SetAsByteDynArray};
	__property System::TIntegerDynArray AsIntegerDynArray = {read=GetAsIntegerDynArray, write=SetAsIntegerDynArray};
	__property System::TWordDynArray AsWordDynArray = {read=GetAsWordDynArray, write=SetAsWordDynArray};
	__property System::TInt64DynArray AsInt64DynArray = {read=GetAsInt64DynArray, write=SetAsInt64DynArray};
	__property System::TWideStringDynArray AsWideStringDynArray = {read=GetAsWideStringDynArray, write=SetAsWideStringDynArray};
	__property System::TLongWordDynArray AsLongWordDynArray = {read=GetAsLongWordDynArray, write=SetAsLongWordDynArray};
	__property System::TDoubleDynArray AsDoubleDynArray = {read=GetAsDoubleDynArray, write=SetAsDoubleDynArray};
	__property System::TBooleanDynArray AsBooleanDynArray = {read=GetAsBooleanDynArray, write=SetAsBooleanDynArray};
	__property GUID AsGUID = {read=GetAsGUID, write=SetAsGUID};
	__property TLMDParameterType ParameterType = {read=GetType, write=SetType};
	__property bool IsOptional = {read=GetIsOptional, write=SetIsOptional};
	__property Lmdtypes::TLMDString Name = {read=GetName};
};

__interface  INTERFACE_UUID("{0CECD86D-8CAC-461F-A5DE-52D4014888B2}") ILMDParametersEnum  : public System::IInterface 
{
	virtual HRESULT __stdcall Reset(void) = 0 ;
	virtual HRESULT __stdcall Skip(int ACount) = 0 ;
	virtual HRESULT __stdcall Next(/* out */ _di_ILMDParameter &AnParam, /* out */ bool &AFetched) = 0 ;
	virtual HRESULT __stdcall Clone(/* out */ _di_ILMDParametersEnum &AClone) = 0 ;
	virtual int __stdcall Count(void) = 0 ;
};

__interface ILMDAction  : public System::IInterface 
{
	
public:
	_di_ILMDParameter operator[](int Index) { return this->Parameters[Index]; }
	virtual _di_ILMDParameter __stdcall PerformAction(void) = 0 ;
	virtual HRESULT __stdcall GetParametersEnum(_di_ILMDParametersEnum &AParamEnum) = 0 ;
	virtual HRESULT __stdcall IsParametersCorrect(void) = 0 ;
	virtual System::WideString __stdcall GetName(void) = 0 ;
	virtual _di_ILMDParameter __stdcall GetParameter(int AIndex) = 0 ;
	virtual _di_ILMDParameter __stdcall GetParameterByName(System::WideString AName) = 0 ;
	__property _di_ILMDParameter Parameters[int Index] = {read=GetParameter/*, default*/};
	__property _di_ILMDParameter ParametersByName[System::WideString Index] = {read=GetParameterByName};
	__property System::WideString Name = {read=GetName};
};

typedef void __stdcall (__closure *TLMDPerformActionEvent)(const _di_ILMDAction AnAction, _di_ILMDParameter &AResult);

__interface  INTERFACE_UUID("{7A47C15F-DA0D-4EAA-8D6B-0E2D9DF38E8A}") ILMDActionEnum  : public System::IInterface 
{
	virtual HRESULT __stdcall Reset(void) = 0 ;
	virtual HRESULT __stdcall Skip(int ACount) = 0 ;
	virtual HRESULT __stdcall Next(/* out */ _di_ILMDAction &AnAction, /* out */ bool &AFetched) = 0 ;
	virtual HRESULT __stdcall Clone(/* out */ _di_ILMDActionEnum &AClone) = 0 ;
};

typedef void __fastcall (__closure *TLMDSetHostEvent)(System::TInterfacedObject* ASender, bool &AnAccept);

typedef void __fastcall (__closure *TLMDPluginModuleOnPerformEvent)(const System::WideString AName, void * AData);

__interface  INTERFACE_UUID("{DDB19212-0409-4AA5-BF83-F9C6BB786CCA}") ILMDPluginEvent  : public System::IInterface 
{
	virtual void __stdcall PerformEvent(const System::WideString AName, void * AData) = 0 ;
};

__interface  INTERFACE_UUID("{04580D43-A86E-4C74-A606-F3F4301DD078}") ILMDPlugin  : public System::IInterface 
{
	
public:
	_di_ILMDAction operator[](const System::WideString AName) { return this->Actions[AName]; }
	virtual HRESULT __stdcall GetPluginForm(System::WideString AFormName, /* out */ _di_ILMDPluginForm &APluginForm) = 0 ;
	virtual NativeUInt __stdcall GetHandle(void) = 0 ;
	virtual void __stdcall SetHandle(NativeUInt AHandle) = 0 ;
	virtual System::WideString __stdcall GetAuthor(void) = 0 ;
	virtual System::WideString __stdcall GetDescription(void) = 0 ;
	virtual int __stdcall GetMajorVersion(void) = 0 ;
	virtual int __stdcall GetMinorVersion(void) = 0 ;
	virtual System::WideString __stdcall GetFileName(void) = 0 ;
	virtual HRESULT __stdcall GetHost(/* out */ _di_ILMDHost &AHost) = 0 ;
	virtual void __stdcall SetFileName(System::WideString AFileName) = 0 ;
	virtual HRESULT __stdcall SetHost(_di_ILMDHost AHost) = 0 ;
	virtual _di_ILMDAction __stdcall GetNamedAction(const System::WideString AName) = 0 ;
	virtual _di_ILMDPluginForm __stdcall GetNamedForm(const System::WideString AName) = 0 ;
	virtual HRESULT __stdcall GetAction(const System::WideString AName, /* out */ _di_ILMDAction &AnAction) = 0 ;
	virtual HRESULT __stdcall SetOnSetHostEvent(TLMDSetHostEvent AnEvent) = 0 ;
	virtual int __stdcall GetIdentifierCount(void) = 0 ;
	virtual GUID __stdcall GetIdentifier(int ANum) = 0 ;
	virtual void __stdcall EventCallback(_di_ILMDPluginEvent AEventCallbackInterface) = 0 ;
	virtual _di_ILMDPluginEvent __stdcall GetEventCallback(void) = 0 ;
	__property System::WideString Author = {read=GetAuthor};
	__property System::WideString FileName = {read=GetFileName, write=SetFileName};
	__property _di_ILMDAction Actions[const System::WideString AName] = {read=GetNamedAction/*, default*/};
	__property _di_ILMDPluginForm Forms[const System::WideString AName] = {read=GetNamedForm};
	__property int IdentifierCount = {read=GetIdentifierCount};
	__property GUID Identifiers[int AIndex] = {read=GetIdentifier};
};

typedef _di_ILMDPlugin __stdcall (*TLMDGetPluginProc)(Vcl::Forms::TApplication* const AnApp);

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpluginmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPLUGINMANAGER)
using namespace Lmdpluginmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpluginmanagerHPP
