// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDVldBase.pas' rev: 31.00 (Windows)

#ifndef LmdvldbaseHPP
#define LmdvldbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdvldbase
{
//-- forward type declarations -----------------------------------------------
__interface ILMDValidatedControl;
typedef System::DelphiInterface<ILMDValidatedControl> _di_ILMDValidatedControl;
__interface ILMDValidatingMsgControl;
typedef System::DelphiInterface<ILMDValidatingMsgControl> _di_ILMDValidatingMsgControl;
class DELPHICLASS TLMDValidatorItem;
class DELPHICLASS TLMDValidators;
class DELPHICLASS TLMDErrorProviderItem;
class DELPHICLASS TLMDErrorProviders;
class DELPHICLASS TLMDValidatedControlItem;
class DELPHICLASS TLMDValidatedControls;
class DELPHICLASS TLMDCustomErrorProvider;
class DELPHICLASS TLMDValidationEntity;
class DELPHICLASS TLMDCustomValidator;
class DELPHICLASS TLMDCustomValidationGroup;
class DELPHICLASS TLMDValidationGroup;
class DELPHICLASS TLMDTypedValidator;
class DELPHICLASS TLMDCustomRangeValidator;
//-- type declarations -------------------------------------------------------
typedef int TLMDErrorLevel;

enum DECLSPEC_DENUM TLMDValueType : unsigned char { vtNumber, vtString, vtDate };

enum DECLSPEC_DENUM TLMDRefSign : unsigned char { rsEqual, rsGreater, rsLess };

enum DECLSPEC_DENUM TLMDValidatedListValue : unsigned char { vlvText, vlvIndex };

typedef void __fastcall (__closure *TLMDValidationErrorEvent)(System::TObject* Sender, int ErrorLevel);

__interface  INTERFACE_UUID("{ED0CAB4C-DBF2-4078-8C06-000841566690}") ILMDValidatedControl  : public System::IInterface 
{
	virtual void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetValidationMsgString(void) = 0 ;
	virtual Vcl::Controls::TControl* __fastcall GetControl(void) = 0 ;
	virtual Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void) = 0 ;
	virtual Vcl::Graphics::TFont* __fastcall GetControlFont(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetValueToValidate(void) = 0 ;
	virtual bool __fastcall SupportsDefaultIndication(void) = 0 ;
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	virtual void __fastcall RespondToError(int ErrorLevel) = 0 ;
	virtual TLMDValidationEntity* __fastcall GetValidator(void) = 0 ;
	virtual void __fastcall SetValidator(TLMDValidationEntity* Validator) = 0 ;
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Vcl::Controls::TControl* Control = {read=GetControl};
	__property TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
};

__interface  INTERFACE_UUID("{F85159D2-2952-4FAB-B795-D772368DEBC4}") ILMDValidatingMsgControl  : public System::IInterface 
{
	virtual void __fastcall SetErrorMessage(Lmdtypes::TLMDString val, int errorLevel) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetLastErrorMessage(void) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDValidatorItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	void __fastcall SetValidator(TLMDValidationEntity* const Value);
	
protected:
	TLMDValidationEntity* FValidator;
	int FTag;
	
__published:
	__property TLMDValidationEntity* Validator = {read=FValidator, write=SetValidator};
	__property int Tag = {read=FTag, write=FTag, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDValidatorItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDValidatorItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDValidators : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDValidatorItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDValidatorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDValidatorItem* const Value);
	
protected:
	System::Classes::TComponent* FOwnerComponent;
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDValidators(System::Classes::TComponent* AComponent);
	HIDESBASE TLMDValidatorItem* __fastcall Add(void);
	__property TLMDValidatorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDValidators(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDErrorProviderItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	TLMDCustomErrorProvider* FErrorProvider;
	void __fastcall SetErrorProvider(TLMDCustomErrorProvider* const Value);
	
public:
	__fastcall virtual TLMDErrorProviderItem(System::Classes::TCollection* Collection);
	
__published:
	__property TLMDCustomErrorProvider* ErrorProvider = {read=FErrorProvider, write=SetErrorProvider};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDErrorProviderItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDErrorProviders : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDErrorProviderItem* operator[](int Index) { return this->Items[Index]; }
	
protected:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDErrorProviderItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDErrorProviderItem* const Value);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDErrorProviders(System::Classes::TComponent* Owner);
	HIDESBASE TLMDErrorProviderItem* __fastcall Add(void);
	__property TLMDErrorProviderItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	TLMDErrorProviderItem* __fastcall GetByProviderName(System::UnicodeString name);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDErrorProviders(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDValidatedControlItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	_di_ILMDValidatedControl FControl;
	void __fastcall SetControl(const _di_ILMDValidatedControl Value);
	
public:
	__fastcall virtual TLMDValidatedControlItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDValidatedControlItem(void);
	
__published:
	__property _di_ILMDValidatedControl Control = {read=FControl, write=SetControl};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDValidatedControls : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDValidatedControlItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomValidationGroup* FValidationGroup;
	HIDESBASE TLMDValidatedControlItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDValidatedControlItem* const Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDValidatedControls(TLMDCustomValidationGroup* Group);
	HIDESBASE TLMDValidatedControlItem* __fastcall Add(void);
	__property TLMDValidatedControlItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TLMDCustomValidationGroup* ValidationGroup = {read=FValidationGroup};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDValidatedControls(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomErrorProvider : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int FMaxErrorLevel;
	int FMinErrorLevel;
	bool FActive;
	
protected:
	virtual void __fastcall DoDisplayError(_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel) = 0 ;
	
public:
	__fastcall virtual TLMDCustomErrorProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomErrorProvider(void);
	virtual void __fastcall DisplayError(_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	
__published:
	__property About = {default=0};
	__property int MinErrorLevel = {read=FMinErrorLevel, write=FMinErrorLevel, default=0};
	__property int MaxErrorLevel = {read=FMaxErrorLevel, write=FMaxErrorLevel, default=100};
	__property bool Active = {read=FActive, write=FActive, default=1};
};


class PASCALIMPLEMENTATION TLMDValidationEntity : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int FErrorLevel;
	bool FActive;
	
protected:
	__property int ErrorLevel = {read=FErrorLevel, write=FErrorLevel, default=1};
	__property bool Active = {read=FActive, write=FActive, default=1};
	
public:
	__fastcall virtual TLMDValidationEntity(System::Classes::TComponent* AComponent);
	int __fastcall Validate(_di_ILMDValidatedControl Sender)/* overload */;
	virtual int __fastcall Validate(_di_ILMDValidatedControl Sender, bool doIndication) = 0 /* overload */;
	virtual System::UnicodeString __fastcall GetMessage(_di_ILMDValidatedControl Sender, int errorLevel) = 0 ;
	
__published:
	__property About = {default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDValidationEntity(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomValidator : public TLMDValidationEntity
{
	typedef TLMDValidationEntity inherited;
	
private:
	System::UnicodeString FErrorMessage;
	_di_ILMDValidatedControl FControl;
	TLMDCustomErrorProvider* FErrorProvider;
	bool FValidateOnFocus;
	bool FValidateOnLostFocus;
	void __fastcall SetErrorProvider(TLMDCustomErrorProvider* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall PerformValidation(System::UnicodeString value) = 0 ;
	
public:
	__fastcall virtual TLMDCustomValidator(System::Classes::TComponent* AOwner);
	virtual int __fastcall Validate(_di_ILMDValidatedControl Sender, bool doIndication)/* overload */;
	virtual System::UnicodeString __fastcall GetMessage(_di_ILMDValidatedControl Sender, int errorLevel);
	__property _di_ILMDValidatedControl Control = {read=FControl};
	
__published:
	__property bool ValidateOnFocus = {read=FValidateOnFocus, write=FValidateOnFocus, nodefault};
	__property bool ValidateOnLostFocus = {read=FValidateOnLostFocus, write=FValidateOnLostFocus, nodefault};
	__property TLMDCustomErrorProvider* ErrorProvider = {read=FErrorProvider, write=SetErrorProvider};
	__property System::UnicodeString ErrorMessage = {read=FErrorMessage, write=FErrorMessage};
	__property ErrorLevel = {default=1};
	__property Active = {default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomValidator(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Validate(_di_ILMDValidatedControl Sender){ return TLMDValidationEntity::Validate(Sender); }
	
};


class PASCALIMPLEMENTATION TLMDCustomValidationGroup : public TLMDValidationEntity
{
	typedef TLMDValidationEntity inherited;
	
private:
	bool FFirstErrorOnly;
	TLMDValidators* FValidators;
	TLMDErrorProviders* FErrorProviders;
	void __fastcall SetValidators(TLMDValidators* const Value);
	void __fastcall SetErrorProviders(TLMDErrorProviders* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property TLMDValidators* Validators = {read=FValidators, write=SetValidators};
	__property TLMDErrorProviders* ErrorProviders = {read=FErrorProviders, write=SetErrorProviders};
	__property bool FirstErrorOnly = {read=FFirstErrorOnly, write=FFirstErrorOnly, default=0};
	
public:
	__fastcall virtual TLMDCustomValidationGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomValidationGroup(void);
	virtual int __fastcall Validate(_di_ILMDValidatedControl Sender, bool doIndication)/* overload */;
	virtual System::UnicodeString __fastcall GetMessage(_di_ILMDValidatedControl Sender, int errorLevel);
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Validate(_di_ILMDValidatedControl Sender){ return TLMDValidationEntity::Validate(Sender); }
	
};


class PASCALIMPLEMENTATION TLMDValidationGroup : public TLMDCustomValidationGroup
{
	typedef TLMDCustomValidationGroup inherited;
	
__published:
	__property Validators;
	__property ErrorProviders;
	__property FirstErrorOnly = {default=0};
	__property Active = {default=1};
public:
	/* TLMDCustomValidationGroup.Create */ inline __fastcall virtual TLMDValidationGroup(System::Classes::TComponent* AOwner) : TLMDCustomValidationGroup(AOwner) { }
	/* TLMDCustomValidationGroup.Destroy */ inline __fastcall virtual ~TLMDValidationGroup(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTypedValidator : public TLMDCustomValidator
{
	typedef TLMDCustomValidator inherited;
	
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDTypedValidator(System::Classes::TComponent* AOwner) : TLMDCustomValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDTypedValidator(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomRangeValidator : public TLMDTypedValidator
{
	typedef TLMDTypedValidator inherited;
	
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDCustomRangeValidator(System::Classes::TComponent* AOwner) : TLMDTypedValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomRangeValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall ValidatorItemsCompare(void * Item1, void * Item2);
}	/* namespace Lmdvldbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDVLDBASE)
using namespace Lmdvldbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdvldbaseHPP
