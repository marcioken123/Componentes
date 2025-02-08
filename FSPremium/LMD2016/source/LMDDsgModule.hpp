// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgModule.pas' rev: 31.00 (Windows)

#ifndef LmddsgmoduleHPP
#define LmddsgmoduleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <System.RTLConsts.hpp>
#include <LMDUnicode.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgmodule
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDModule;
class DELPHICLASS ILMDModuleNotifier;
class DELPHICLASS TLMDModuleFrameContext;
struct TLMDEventValue;
class DELPHICLASS TLMDModule;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDComponentChangeNotification)(System::TObject* Sender, System::Classes::TList* AChangedComps);

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDModule : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDModule(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDModule(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDModule(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDModule(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDModule(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDModule(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDModule(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDModule(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDModule(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDModule(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDModule(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDModule(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDModule(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDModuleNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall RootChange(TLMDModule* AModule) = 0 ;
	virtual void __fastcall RootReloaded(TLMDModule* AModule) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDModuleNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDModuleNotifier(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDModuleFrameQueryKind : unsigned char { fqkGetModule, fqkLoadBase };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDModuleFrameContext : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDModule* FOwnedModule;
	TLMDModuleFrameQueryKind FQueryKind;
	Lmdtypes::TLMDString FFrameModuleName;
	System::Classes::TComponent* FFrameOwner;
	bool FHandled;
	TLMDModule* FResultFrameModule;
	Vcl::Forms::TCustomFrame* FResultFrame;
public:
	/* TObject.Create */ inline __fastcall TLMDModuleFrameContext(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDModuleFrameContext(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDEventValue
{
public:
	System::Classes::TComponent* Owner;
	Lmdtypes::TLMDString Name;
};


enum DECLSPEC_DENUM Lmddsgmodule__4 : unsigned char { msReading, msWriting, msEvtHdrRenaming };

typedef System::Set<Lmddsgmodule__4, Lmddsgmodule__4::msReading, Lmddsgmodule__4::msEvtHdrRenaming> TLMDModuleState;

typedef void __fastcall (__closure *TLMDModuleOnValidateCompName)(System::TObject* Sender, System::Classes::TComponent* AComponent, const Lmdtypes::TLMDString AName, bool &AIsValidName, Lmdtypes::TLMDString &AErrorMsg);

typedef void __fastcall (__closure *TLMDModuleOnGetUniqueCompName)(System::TObject* Sender, const Lmdtypes::TLMDString ABaseName, Lmdtypes::TLMDString &AUniqueName);

typedef void __fastcall (__closure *TLMDModuleOnGetCompRef)(System::TObject* Sender, const Lmdtypes::TLMDString ACompName, System::Classes::TComponent* &AComponent);

typedef void __fastcall (__closure *TLMDOnGetLoadingCompRef)(System::TObject* Sender, const System::UnicodeString Name, System::Classes::TComponent* &Instance);

typedef void __fastcall (__closure *TLMDModuleOnGetCompRefName)(System::TObject* Sender, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AName);

typedef void __fastcall (__closure *TLMDModuleOnGetCompRefList)(System::TObject* Sender, System::Classes::TComponentClass AClass, System::Classes::TList* AResult);

typedef void __fastcall (__closure *TLMDModuleOnValidateEventHandlerName)(System::TObject* Sender, const Lmdtypes::TLMDString AName, bool &AIsValidName);

typedef void __fastcall (__closure *TLMDModuleOnGetEventHandlerName)(System::TObject* Sender, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo, Lmdtypes::TLMDString &AName);

typedef void __fastcall (__closure *TLMDModuleOnGetEventHandlerList)(System::TObject* Sender, System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);

typedef void __fastcall (__closure *TLMDModuleOnEnsureEventHandlerSource)(System::TObject* Sender, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo, bool AShowSource, bool &AIsRenamed);

typedef void __fastcall (__closure *TLMDModuleOnValidateEventHandler)(System::TObject* Sender, System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo, const Lmdtypes::TLMDString AHandlerName, bool &ACancel);

typedef void __fastcall (__closure *TLMDModuleOnHookEvent)(System::TObject* Sender, System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo, const TLMDEventValue &AEventHandler);

typedef void __fastcall (__closure *TLMDModuleOnLoadError)(System::TObject* Sender, const Lmdtypes::TLMDString AMessage, bool &AHandled);

typedef void __fastcall (__closure *TLMDModuleOnQueryFrameData)(System::TObject* Sender, const Lmdtypes::TLMDString AFrameModuleName, TLMDModuleFrameQueryKind AQueryKind, TLMDModuleFrameContext* AContext);

class PASCALIMPLEMENTATION TLMDModule : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDModuleState FState;
	Vcl::Controls::TWinControl* FRoot;
	int FReadLevel;
	int FWriteLevel;
	System::Classes::TComponent* FReadingEventOwner;
	Lmdtypes::TLMDString FCreateCompClassName;
	Lmdtypes::TLMDString FModuleName;
	System::TObject* FTraits;
	System::Classes::TList* FFramesMap;
	System::Classes::TList* FAncestoredComps;
	System::Classes::TList* FEventHandlers;
	System::TObject* FRenamingOld;
	System::TObject* FRenamingNew;
	System::Word FNextEventHandlerId;
	System::TObject* FReaderNameReplaces;
	System::Classes::TList* FNotifiers;
	TLMDModuleOnGetUniqueCompName FOnGetUniqueCompName;
	TLMDModuleOnValidateCompName FOnValidateCompName;
	TLMDModuleOnValidateEventHandlerName FOnValidateEventHandlerName;
	TLMDModuleOnGetCompRef FOnGetCompRef;
	TLMDOnGetLoadingCompRef FOnGetLoadingCompRef;
	TLMDModuleOnGetCompRefList FOnGetCompRefList;
	TLMDModuleOnGetCompRefName FOnGetCompRefName;
	TLMDModuleOnGetEventHandlerName FOnGetEventHandlerName;
	TLMDModuleOnGetEventHandlerList FOnGetEventHandlerList;
	TLMDModuleOnEnsureEventHandlerSource FOnEnsureEventHandlerSource;
	TLMDModuleOnValidateEventHandler FOnValidateEventHandler;
	TLMDModuleOnHookEvent FOnHookEvent;
	TLMDModuleOnQueryFrameData FOnQueryFrameData;
	TLMDModuleOnLoadError FOnLoadError;
	System::Classes::TNotifyEvent FOnCompsModified;
	void __fastcall SetRoot(Vcl::Controls::TWinControl* const Value);
	void __fastcall SetModuleName(const Lmdtypes::TLMDString Value);
	void __fastcall ReaderSetName(System::Classes::TReader* Reader, System::Classes::TComponent* Component, System::UnicodeString &Name);
	void __fastcall ReaderReferenceName(System::Classes::TReader* Reader, System::UnicodeString &Name);
	void __fastcall ReaderError(System::Classes::TReader* Reader, const System::UnicodeString Message, bool &Handled);
	void __fastcall ReaderFindComponentClass(System::Classes::TReader* Reader, const System::UnicodeString ClassName, System::Classes::TComponentClass &ComponentClass);
	void __fastcall ReaderFindComponentInstance(System::Classes::TReader* Reader, const System::UnicodeString Name, void * &Instance);
	void __fastcall ReaderCreateComponent(System::Classes::TReader* Reader, System::Classes::TComponentClass ComponentClass, System::Classes::TComponent* &Component);
	void __fastcall WriterFindAncestor(System::Classes::TWriter* Writer, System::Classes::TComponent* Component, const System::UnicodeString Name, System::Classes::TComponent* &Ancestor, System::Classes::TComponent* &RootAncestor);
	void __fastcall RenameHandlerProc(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo);
	void __fastcall ResetEventProc(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo);
	void __fastcall ValidateHandlerProc(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo);
	void __fastcall HookEventProc(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo);
	void __fastcall UpdateDesigner(void);
	void __fastcall CompsChangeNotification(System::TObject* Sender, System::Classes::TList* AChangedComps);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoRootChange(void);
	virtual void __fastcall DoRootReload(void);
	virtual void __fastcall DoCompsModified(void);
	void __fastcall BeforeRead(System::Classes::TComponent* AEventOwner, System::Classes::TReader* AReader, /* out */ System::Classes::TComponent* &AOldEventOwner);
	void __fastcall AfterRead(System::Classes::TComponent* AOldEventOwner);
	void __fastcall BeforeWrite(System::Classes::TWriter* AWriter);
	void __fastcall AfterWrite(void);
	void __fastcall RemoveAncestorFlags(void);
	void __fastcall ReplaceRootClassName(void);
	System::TObject* __fastcall FindEventHandler(int AId)/* overload */;
	System::TObject* __fastcall FindEventHandler(System::Classes::TComponent* AOwner, const Lmdtypes::TLMDString AName)/* overload */;
	System::TObject* __fastcall EventHandlerNeeded(System::Classes::TComponent* AOwner, const Lmdtypes::TLMDString AName);
	bool __fastcall HasOwnedEventHandlers(System::Classes::TComponent* AOwner);
	void __fastcall RenameEventHandler(System::Classes::TComponent* AOwner, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName);
	void __fastcall ClearEventHandlers(void);
	void __fastcall ClearOwnedEventHandlers(System::Classes::TComponent* AOwner);
	void __fastcall CollectUnusedEventHandlers(void);
	void __fastcall DeleteEventHandler(int AIndex);
	void __fastcall InsertFrameToMap(Vcl::Forms::TCustomFrame* AFrame, const Lmdtypes::TLMDString AModuleName);
	void __fastcall RemoveFrameFromMap(Vcl::Forms::TCustomFrame* AFrame);
	int __fastcall IndexOfFrame(Vcl::Forms::TCustomFrame* AFrame);
	void __fastcall ClearFramesMap(void);
	bool __fastcall CreateInitedFrameInstance(const Lmdtypes::TLMDString AFrameModuleName, System::Classes::TComponent* AFrameOwner, /* out */ Vcl::Forms::TCustomFrame* &AResFrame);
	bool __fastcall GetBaseFrameModule(const Lmdtypes::TLMDString AFrameModuleName, /* out */ TLMDModule* &AResModule);
	void __fastcall DoLoadFrameCopy(Vcl::Forms::TCustomFrame* AFrame, System::Classes::TStream* AStream);
	
public:
	__fastcall virtual TLMDModule(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDModule(void);
	void __fastcall AddNotifier(ILMDModuleNotifier* ANotifier);
	void __fastcall RemoveNotifier(ILMDModuleNotifier* ANotifier);
	bool __fastcall IsUniqueCompName(const Lmdtypes::TLMDString AName);
	bool __fastcall IsValidCompName(System::Classes::TComponent* AComponent, const Lmdtypes::TLMDString AName, Lmdtypes::TLMDString &AErrorMsg);
	void __fastcall CheckCompName(System::Classes::TComponent* AComponent, const Lmdtypes::TLMDString AName);
	Lmdtypes::TLMDString __fastcall GetUniqueCompName(const Lmdtypes::TLMDString ABaseName);
	System::Classes::TComponent* __fastcall GetCompRef(const Lmdtypes::TLMDString ACompName);
	Lmdtypes::TLMDString __fastcall GetCompRefName(System::Classes::TComponent* AComponent);
	void __fastcall GetCompRefList(System::Classes::TComponentClass AClass, System::Classes::TList* AResult);
	Lmdtypes::TLMDString __fastcall GetEventHandlerName(System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo);
	bool __fastcall IsValidEventHandlerName(const Lmdtypes::TLMDString AName);
	void __fastcall CheckEventHandler(const TLMDEventValue &AValue);
	TLMDEventValue __fastcall GetEventProp(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo);
	void __fastcall SetEventProp(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo, const TLMDEventValue &AValue);
	void __fastcall GetEventHandlerList(System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);
	void __fastcall EnsureEventHandlerSource(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo, bool AShowSource = false);
	bool __fastcall ValidateEventHandlers(void);
	void __fastcall HookEvents(void);
	void __fastcall ClipboardSave(System::Classes::TStream* AStream, System::Classes::TList* AComponents);
	void __fastcall ClipboardLoad(System::Classes::TStream* AStream, Vcl::Controls::TWinControl* AParent, System::Classes::TReadComponentsProc AProc);
	void __fastcall SaveToStream(System::Classes::TStream* AStream, System::Classes::TStreamOriginalFormat AFormat = (System::Classes::TStreamOriginalFormat)(0x2));
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName, System::Classes::TStreamOriginalFormat AFormat = (System::Classes::TStreamOriginalFormat)(0x2));
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName);
	System::Types::TPoint __fastcall ClientToScreen(const System::Types::TPoint &APoint);
	System::Types::TPoint __fastcall ScreenToClient(const System::Types::TPoint &APoint);
	Lmdtypes::TLMDString __fastcall GetFrameModuleName(Vcl::Forms::TCustomFrame* AFrame);
	void __fastcall SetFrameModuleName(Vcl::Forms::TCustomFrame* AFrame, const Lmdtypes::TLMDString AValue);
	Vcl::Forms::TCustomFrame* __fastcall InsertFrame(const Lmdtypes::TLMDString AFrameModuleName);
	__property Vcl::Controls::TWinControl* Root = {read=FRoot, write=SetRoot};
	__property Lmdtypes::TLMDString ModuleName = {read=FModuleName, write=SetModuleName};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property System::Classes::TNotifyEvent OnCompsModified = {read=FOnCompsModified, write=FOnCompsModified};
	__property TLMDModuleOnGetUniqueCompName OnGetUniqueCompName = {read=FOnGetUniqueCompName, write=FOnGetUniqueCompName};
	__property TLMDModuleOnValidateCompName OnValidateCompName = {read=FOnValidateCompName, write=FOnValidateCompName};
	__property TLMDModuleOnGetCompRef OnGetCompRef = {read=FOnGetCompRef, write=FOnGetCompRef};
	__property TLMDOnGetLoadingCompRef OnGetLoadingCompRef = {read=FOnGetLoadingCompRef, write=FOnGetLoadingCompRef};
	__property TLMDModuleOnGetCompRefName OnGetCompRefName = {read=FOnGetCompRefName, write=FOnGetCompRefName};
	__property TLMDModuleOnGetCompRefList OnGetCompRefList = {read=FOnGetCompRefList, write=FOnGetCompRefList};
	__property TLMDModuleOnValidateEventHandlerName OnValidateEventHandlerName = {read=FOnValidateEventHandlerName, write=FOnValidateEventHandlerName};
	__property TLMDModuleOnGetEventHandlerName OnGetEventHandlerName = {read=FOnGetEventHandlerName, write=FOnGetEventHandlerName};
	__property TLMDModuleOnGetEventHandlerList OnGetEventHandlerList = {read=FOnGetEventHandlerList, write=FOnGetEventHandlerList};
	__property TLMDModuleOnEnsureEventHandlerSource OnEnsureEventHandlerSource = {read=FOnEnsureEventHandlerSource, write=FOnEnsureEventHandlerSource};
	__property TLMDModuleOnValidateEventHandler OnValidateEventHandler = {read=FOnValidateEventHandler, write=FOnValidateEventHandler};
	__property TLMDModuleOnHookEvent OnHookEvent = {read=FOnHookEvent, write=FOnHookEvent};
	__property TLMDModuleOnQueryFrameData OnQueryFrameData = {read=FOnQueryFrameData, write=FOnQueryFrameData};
	__property TLMDModuleOnLoadError OnLoadError = {read=FOnLoadError, write=FOnLoadError};
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


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDEventValue __fastcall LMDEventValue(System::Classes::TComponent* AOwner, const Lmdtypes::TLMDString AName);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDMakeEventHandlerName(const Lmdtypes::TLMDString AInstanceName, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo)/* overload */;
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDMakeEventHandlerName(System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TComponent* ARoot = (System::Classes::TComponent*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSetFrameModule(TLMDModuleFrameContext* AContext, TLMDModule* AFrameModule);
extern DELPHI_PACKAGE void __fastcall LMDLoadFrameBase(TLMDModuleFrameContext* AContext, TLMDModule* AFrameModule)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDLoadFrameBase(TLMDModuleFrameContext* AContext, Vcl::Forms::TCustomFrameClass AFrameClass, System::Classes::TStream* ASavedFrame)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDLoadFrameBase(TLMDModuleFrameContext* AContext, Vcl::Forms::TCustomFrameClass AFrameClass, const Lmdtypes::TLMDString AFileName)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDIsOwnerValid(Vcl::Controls::TWinControl* ARoot, System::Classes::TComponent* AOwner);
extern DELPHI_PACKAGE bool __fastcall LMDIsFrameCopy(System::Classes::TComponent* AComp);
extern DELPHI_PACKAGE bool __fastcall LMDIsOwnedByFrameCopy(System::Classes::TComponent* AComp);
extern DELPHI_PACKAGE void __fastcall LMDShowModuleStructure(TLMDModule* AModule);
extern DELPHI_PACKAGE TLMDModule* __fastcall LMDFindObjectModule(System::Classes::TPersistent* AObject);
extern DELPHI_PACKAGE bool __fastcall LMDIsObjectOwnedBy(System::Classes::TPersistent* AObject, Vcl::Controls::TWinControl* AOwner);
extern DELPHI_PACKAGE void __fastcall LMDRegisterComponentChangeNotification(System::TObject* AKey, TLMDComponentChangeNotification AProc);
extern DELPHI_PACKAGE void __fastcall LMDUnregisterComponentChangeNotification(System::TObject* AKey);
extern DELPHI_PACKAGE void __fastcall LMDComponentsChanged(System::TObject* Sender, System::Classes::TList* AComps);
extern DELPHI_PACKAGE void __fastcall LMDComponentChanged(System::TObject* Sender, System::Classes::TComponent* AComp);
extern DELPHI_PACKAGE void __fastcall LMDTransformToCompList(System::Classes::TList* APersObjects);
extern DELPHI_PACKAGE bool __fastcall LMDHasCommonItems(System::Classes::TList* AListA, System::Classes::TList* AListB);
extern DELPHI_PACKAGE System::Classes::TComponent* __fastcall LMDGetPersistentComponent(System::Classes::TPersistent* AObj);
extern DELPHI_PACKAGE void __fastcall LMDShowDefaultEventHandler(System::Classes::TPersistent* AInstance, bool ANotifyCompChange = true);
}	/* namespace Lmddsgmodule */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGMODULE)
using namespace Lmddsgmodule;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgmoduleHPP
