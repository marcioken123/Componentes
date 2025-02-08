// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPluginImpl.pas' rev: 31.00 (Windows)

#ifndef LmdpluginimplHPP
#define LmdpluginimplHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDPluginManager.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpluginimpl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPluginComponent;
class DELPHICLASS TLMDCustomPlugin;
class DELPHICLASS TLMDPlugin;
class DELPHICLASS TLMDParametersEnum;
class DELPHICLASS TLMDParameter;
class DELPHICLASS TLMDAction;
class DELPHICLASS TLMDPluginForm;
class DELPHICLASS TLMDDelphiPluginForm;
class DELPHICLASS TLMDPluginEvent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPluginComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDPluginComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDPluginComponent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomPlugin : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	NativeUInt FHandle;
	System::WideString FAuthor;
	System::WideString FDescription;
	int FMajorVersion;
	int FMinorVersion;
	System::UnicodeString FFileName;
	Lmdpluginmanager::_di_ILMDHost FHost;
	Lmdpluginmanager::TLMDSetHostEvent FOnSetHost;
	System::Classes::TInterfaceList* FActions;
	System::Classes::TInterfaceList* FForms;
	System::Classes::TList* FIdentifiers;
	Lmdpluginmanager::_di_ILMDPluginEvent FEventInterface;
	Lmdpluginmanager::_di_ILMDAction __stdcall GetNamedAction(const System::WideString AName);
	Lmdpluginmanager::_di_ILMDPluginForm __stdcall GetNamedForm(const System::WideString AName);
	HRESULT __stdcall GetPluginForm(System::WideString AFormName, /* out */ Lmdpluginmanager::_di_ILMDPluginForm &APluginForm);
	int __stdcall GetIdentifierCount(void);
	GUID __stdcall GetIdentifier(int ANum);
	
public:
	__fastcall TLMDCustomPlugin(void);
	__fastcall virtual ~TLMDCustomPlugin(void);
	NativeUInt __stdcall GetHandle(void);
	void __stdcall SetHandle(NativeUInt AHandle);
	System::WideString __stdcall GetAuthor(void);
	System::WideString __stdcall GetDescription(void);
	int __stdcall GetMajorVersion(void);
	int __stdcall GetMinorVersion(void);
	System::WideString __stdcall GetFileName(void);
	HRESULT __stdcall GetHost(/* out */ Lmdpluginmanager::_di_ILMDHost &AHost);
	void __stdcall SetFileName(System::WideString AFileName);
	HRESULT __stdcall SetHost(Lmdpluginmanager::_di_ILMDHost AHost);
	HRESULT __stdcall GetAction(const System::WideString AName, /* out */ Lmdpluginmanager::_di_ILMDAction &AnAction);
	HRESULT __stdcall SetOnSetHostEvent(Lmdpluginmanager::TLMDSetHostEvent AnEvent);
	TLMDAction* __fastcall AddAction(const System::WideString AName);
	void __stdcall EventCallback(Lmdpluginmanager::_di_ILMDPluginEvent AEventInterface);
	Lmdpluginmanager::_di_ILMDPluginEvent __stdcall GetEventCallback(void);
	void __stdcall AddForm(const Lmdpluginmanager::_di_ILMDPluginForm AForm);
	void __stdcall AddIdentifier(const GUID &AIdentifier);
	__property System::WideString Author = {read=GetAuthor};
	__property System::WideString FileName = {read=GetFileName, write=SetFileName};
	__property Lmdpluginmanager::_di_ILMDAction Actions[const System::WideString AName] = {read=GetNamedAction};
	__property int IdentifierCount = {read=GetIdentifierCount, nodefault};
	__property GUID Identifiers[int AIndex] = {read=GetIdentifier};
private:
	void *__ILMDPlugin;	// Lmdpluginmanager::ILMDPlugin 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {04580D43-A86E-4C74-A606-F3F4301DD078}
	operator Lmdpluginmanager::_di_ILMDPlugin()
	{
		Lmdpluginmanager::_di_ILMDPlugin intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDPlugin*(void) { return (Lmdpluginmanager::ILMDPlugin*)&__ILMDPlugin; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDPlugin : public TLMDCustomPlugin
{
	typedef TLMDCustomPlugin inherited;
	
public:
	__fastcall TLMDPlugin(const System::WideString AAuthor, const System::WideString ADescription, const int AMajorVersion, const int AMinorVersion);
public:
	/* TLMDCustomPlugin.Destroy */ inline __fastcall virtual ~TLMDPlugin(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParametersEnum : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FCount;
	int FTail;
	System::Classes::TInterfaceList* FParams;
	int FPosition;
	
public:
	__fastcall TLMDParametersEnum(int ACount);
	__fastcall virtual ~TLMDParametersEnum(void);
	void __fastcall Add(const Lmdpluginmanager::_di_ILMDParameter AParam);
	HRESULT __stdcall Reset(void);
	HRESULT __stdcall Skip(int ACount);
	HRESULT __stdcall Next(/* out */ Lmdpluginmanager::_di_ILMDParameter &AParam, /* out */ bool &AFetched);
	HRESULT __stdcall Clone(/* out */ Lmdpluginmanager::_di_ILMDParametersEnum &AClone);
	int __stdcall Count(void);
private:
	void *__ILMDParametersEnum;	// Lmdpluginmanager::ILMDParametersEnum 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0CECD86D-8CAC-461F-A5DE-52D4014888B2}
	operator Lmdpluginmanager::_di_ILMDParametersEnum()
	{
		Lmdpluginmanager::_di_ILMDParametersEnum intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDParametersEnum*(void) { return (Lmdpluginmanager::ILMDParametersEnum*)&__ILMDParametersEnum; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParameter : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	void *FValue;
	Lmdpluginmanager::TLMDParameterType FType;
	bool FIsOptional;
	Lmdtypes::TLMDString FName;
	void __stdcall SetAsBoolean(const bool AValue);
	void __stdcall SetAsInteger(const int AValue);
	void __stdcall SetAsReal(const System::Extended AValue);
	void __stdcall SetAsString(const System::WideString AValue);
	void __stdcall SetAsCurrency(const System::Currency AValue);
	void __stdcall SetAsSmallInt(const short AValue);
	void __stdcall SetAsWord(const System::Word AValue);
	void __stdcall SetAsLongWord(const unsigned AValue);
	void __stdcall SetAsInt64(const __int64 AValue);
	void __stdcall SetAsObject(System::TObject* const AValue);
	void __stdcall SetAsPointer(const void * AValue);
	bool __stdcall GetAsBoolean(void);
	int __stdcall GetAsInteger(void);
	System::Extended __stdcall GetAsReal(void);
	System::WideString __stdcall GetAsString(void);
	System::Currency __stdcall GetAsCurrency(void);
	short __stdcall GetAsSmallInt(void);
	System::Word __stdcall GetAsWord(void);
	unsigned __stdcall GetAsLongWord(void);
	__int64 __stdcall GetAsInt64(void);
	System::TObject* __stdcall GetAsObject(void);
	void * __stdcall GetAsPointer(void);
	System::TByteDynArray __stdcall GetAsByteDynArray(void);
	void __stdcall SetAsByteDynArray(const System::TByteDynArray AValue);
	void __stdcall SetAsIntegerDynArray(const System::TIntegerDynArray AValue);
	void __stdcall SetAsWordDynArray(const System::TWordDynArray AValue);
	void __stdcall SetAsInt64DynArray(const System::TInt64DynArray AValue);
	void __stdcall SetAsWideStringDynArray(const System::TWideStringDynArray AValue);
	void __stdcall SetAsLongWordDynArray(const System::TLongWordDynArray AValue);
	void __stdcall SetAsDoubleDynArray(const System::TDoubleDynArray AValue);
	void __stdcall SetAsBooleanDynArray(const System::TBooleanDynArray AValue);
	System::TIntegerDynArray __stdcall GetAsIntegerDynArray(void);
	System::TWordDynArray __stdcall GetAsWordDynArray(void);
	System::TInt64DynArray __stdcall GetAsInt64DynArray(void);
	System::TWideStringDynArray __stdcall GetAsWideStringDynArray(void);
	System::TLongWordDynArray __stdcall GetAsLongWordDynArray(void);
	System::TDoubleDynArray __stdcall GetAsDoubleDynArray(void);
	System::TBooleanDynArray __stdcall GetAsBooleanDynArray(void);
	void __stdcall SetType(const Lmdpluginmanager::TLMDParameterType AType);
	Lmdpluginmanager::TLMDParameterType __stdcall GetType(void);
	bool __stdcall GetIsOptional(void);
	void __stdcall SetIsOptional(const bool AIsOptional);
	Lmdtypes::TLMDString __stdcall GetName(void);
	GUID __stdcall GetAsGUID(void);
	void __stdcall SetAsGUID(const GUID &Value);
	
public:
	__fastcall TLMDParameter(void)/* overload */;
	__fastcall TLMDParameter(const System::WideString AName)/* overload */;
	__fastcall virtual ~TLMDParameter(void);
	HRESULT __stdcall GetValue(/* out */ void * &APointer);
	HRESULT __stdcall SetValue(const void * APointer);
	__property bool AsBoolean = {read=GetAsBoolean, write=SetAsBoolean, nodefault};
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger, nodefault};
	__property System::Extended AsReal = {read=GetAsReal, write=SetAsReal};
	__property System::WideString AsString = {read=GetAsString, write=SetAsString};
	__property System::Currency AsCurrency = {read=GetAsCurrency, write=SetAsCurrency};
	__property short AsSmallInt = {read=GetAsSmallInt, write=SetAsSmallInt, nodefault};
	__property System::Word AsWord = {read=GetAsWord, write=SetAsWord, nodefault};
	__property unsigned AsLongWord = {read=GetAsLongWord, write=SetAsLongWord, nodefault};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
	__property void * AsPointer = {read=GetAsPointer, write=SetAsPointer};
	__property System::TByteDynArray AsByteDynArray = {read=GetAsByteDynArray, write=SetAsByteDynArray};
	__property System::TIntegerDynArray AsIntegerDynArray = {read=GetAsIntegerDynArray, write=SetAsIntegerDynArray};
	__property System::TWordDynArray AsWordDynArray = {read=GetAsWordDynArray, write=SetAsWordDynArray};
	__property System::TInt64DynArray AsInt64DynArray = {read=GetAsInt64DynArray, write=SetAsInt64DynArray};
	__property System::TWideStringDynArray AsWideStringDynArray = {read=GetAsWideStringDynArray, write=SetAsWideStringDynArray};
	__property System::TLongWordDynArray AsLongWordDynArray = {read=GetAsLongWordDynArray, write=SetAsLongWordDynArray};
	__property System::TDoubleDynArray AsDoubleDynArray = {read=GetAsDoubleDynArray, write=SetAsDoubleDynArray};
	__property System::TBooleanDynArray AsBooleanDynArray = {read=GetAsBooleanDynArray, write=SetAsBooleanDynArray};
	__property GUID AsGUID = {read=GetAsGUID, write=SetAsGUID};
	__property Lmdpluginmanager::TLMDParameterType ParameterType = {read=GetType, write=SetType, nodefault};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property bool IsOptional = {read=GetIsOptional, write=SetIsOptional, nodefault};
private:
	void *__ILMDParameter;	// Lmdpluginmanager::ILMDParameter 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD1FA603-752B-45E5-921F-97F1C8D61644}
	operator Lmdpluginmanager::_di_ILMDParameter()
	{
		Lmdpluginmanager::_di_ILMDParameter intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDParameter*(void) { return (Lmdpluginmanager::ILMDParameter*)&__ILMDParameter; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDAction : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
public:
	Lmdpluginmanager::_di_ILMDParameter operator[](int Index) { return this->Parameters[Index]; }
	
protected:
	System::WideString FName;
	System::Classes::TInterfaceList* FParameters;
	int FParamCount;
	Lmdpluginmanager::_di_ILMDParameter FResult;
	Lmdpluginmanager::TLMDPerformActionEvent FOnPerformAction;
	Lmdpluginmanager::_di_ILMDParameter __stdcall GetParameter(int AIndex);
	void __stdcall SetParameter(int AIndex, const Lmdpluginmanager::_di_ILMDParameter AParameter);
	System::WideString __stdcall GetName(void);
	
public:
	__fastcall TLMDAction(const System::WideString AName);
	__fastcall virtual ~TLMDAction(void);
	virtual Lmdpluginmanager::_di_ILMDParameter __stdcall PerformAction(void);
	HRESULT __stdcall GetParametersEnum(Lmdpluginmanager::_di_ILMDParametersEnum &AParamEnum);
	HRESULT __stdcall IsParametersCorrect(void);
	TLMDParameter* __fastcall AddParameter(void)/* overload */;
	TLMDParameter* __fastcall AddParameter(const System::WideString AName)/* overload */;
	Lmdpluginmanager::_di_ILMDParameter __stdcall GetParameterByName(System::WideString AName);
	__property System::WideString Name = {read=GetName};
	__property Lmdpluginmanager::_di_ILMDParameter Parameters[int Index] = {read=GetParameter, write=SetParameter/*, default*/};
	__property Lmdpluginmanager::_di_ILMDParameter ParametersByName[System::WideString Index] = {read=GetParameterByName};
	__property int ParamCount = {read=FParamCount, nodefault};
	__property Lmdpluginmanager::TLMDPerformActionEvent OnPerformAction = {read=FOnPerformAction, write=FOnPerformAction};
private:
	void *__ILMDAction;	// Lmdpluginmanager::ILMDAction 
	
public:
	operator Lmdpluginmanager::ILMDAction*(void) { return (Lmdpluginmanager::ILMDAction*)&__ILMDAction; }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginForm : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Vcl::Forms::TForm* FForm;
	System::WideString FFormName;
	System::WideString __stdcall GetTitle(void);
	void __stdcall SetTitle(System::WideString ATitle);
	bool __stdcall GetVisible(void);
	void __stdcall SetVisible(bool AVisible);
	System::WideString __stdcall GetFormName(void);
	
public:
	__fastcall TLMDPluginForm(const System::WideString AName, Vcl::Forms::TFormClass AForm);
	__fastcall virtual ~TLMDPluginForm(void);
	virtual void __stdcall Show(void);
	virtual void __stdcall Hide(void);
	virtual void __stdcall ShowAsMDIChild(Vcl::Forms::TForm* AParentForm);
	virtual void __stdcall ShowModal(void);
	virtual void __stdcall ShowParented(HWND AParentWindow);
	virtual void __stdcall SetFormData(void * AData);
	__property System::WideString FormName = {read=GetFormName};
	__property System::WideString Title = {read=GetTitle, write=SetTitle};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
private:
	void *__ILMDPluginForm;	// Lmdpluginmanager::ILMDPluginForm 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {9BA7E398-3673-4213-B2B2-6287EC3D6466}
	operator Lmdpluginmanager::_di_ILMDPluginForm()
	{
		Lmdpluginmanager::_di_ILMDPluginForm intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDPluginForm*(void) { return (Lmdpluginmanager::ILMDPluginForm*)&__ILMDPluginForm; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDelphiPluginForm : public TLMDPluginForm
{
	typedef TLMDPluginForm inherited;
	
public:
	Vcl::Forms::TForm* __stdcall GetTFormInstance(void);
public:
	/* TLMDPluginForm.Create */ inline __fastcall TLMDDelphiPluginForm(const System::WideString AName, Vcl::Forms::TFormClass AForm) : TLMDPluginForm(AName, AForm) { }
	/* TLMDPluginForm.Destroy */ inline __fastcall virtual ~TLMDDelphiPluginForm(void) { }
	
private:
	void *__ILMDDelphiPluginForm;	// Lmdpluginmanager::ILMDDelphiPluginForm 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0BEF55CC-2761-4CCB-B08A-553766806984}
	operator Lmdpluginmanager::_di_ILMDDelphiPluginForm()
	{
		Lmdpluginmanager::_di_ILMDDelphiPluginForm intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDDelphiPluginForm*(void) { return (Lmdpluginmanager::ILMDDelphiPluginForm*)&__ILMDDelphiPluginForm; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {9BA7E398-3673-4213-B2B2-6287EC3D6466}
	operator Lmdpluginmanager::_di_ILMDPluginForm()
	{
		Lmdpluginmanager::_di_ILMDPluginForm intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDPluginForm*(void) { return (Lmdpluginmanager::ILMDPluginForm*)&__ILMDDelphiPluginForm; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDPluginEvent : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Lmdpluginmanager::TLMDPluginModuleOnPerformEvent FOnPerformEvent;
	
public:
	__fastcall TLMDPluginEvent(Lmdpluginmanager::TLMDPluginModuleOnPerformEvent AOnPerformEvent);
	void __stdcall PerformEvent(const System::WideString AName, void * AData);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPluginEvent(void) { }
	
private:
	void *__ILMDPluginEvent;	// Lmdpluginmanager::ILMDPluginEvent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {DDB19212-0409-4AA5-BF83-F9C6BB786CCA}
	operator Lmdpluginmanager::_di_ILMDPluginEvent()
	{
		Lmdpluginmanager::_di_ILMDPluginEvent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdpluginmanager::ILMDPluginEvent*(void) { return (Lmdpluginmanager::ILMDPluginEvent*)&__ILMDPluginEvent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpluginimpl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPLUGINIMPL)
using namespace Lmdpluginimpl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpluginimplHPP
