// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFormContainer.pas' rev: 31.00 (Windows)

#ifndef ElformcontainerHPP
#define ElformcontainerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <ElComponent.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>
#include <ElHTMLContainer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elformcontainer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFormContainerChangeLink;
class DELPHICLASS TElFormListItem;
class DELPHICLASS TElFormList;
class DELPHICLASS TElFormContainer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElFormContainerChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElFormContainer* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TElFormContainerChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElFormContainer* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TElFormContainerChangeLink(void) : System::TObject() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFormListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFormName;
	int FHTMLContainerIndex;
	System::UnicodeString FFormClassName;
	Vcl::Forms::TFormClass FFormClass;
	Vcl::Forms::TCustomForm* FForm;
	int FTag;
	int FWidth;
	int FHeight;
	void __fastcall SetFormExt(Vcl::Forms::TCustomForm* const Value);
	void __fastcall SetFormClassName(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TElFormListItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElFormListItem(void);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	__property Vcl::Forms::TCustomForm* Form = {read=FForm, write=SetFormExt};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	
__published:
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::UnicodeString FormName = {read=FFormName, write=FFormName};
	__property System::UnicodeString FormClassName = {read=FFormClassName, write=SetFormClassName};
	__property int HTMLContainerIndex = {read=FHTMLContainerIndex, write=FHTMLContainerIndex, nodefault};
	__property Index;
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFormList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElFormListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TPersistent* FOwner;
	TElFormListItem* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElFormListItem* newValue);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TElFormList(System::Classes::TComponent* AOwner);
	HIDESBASE TElFormListItem* __fastcall Add(void);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	int __fastcall IndexOf(Vcl::Forms::TCustomForm* Form)/* overload */;
	int __fastcall IndexOf(Vcl::Forms::TFormClass FormClass)/* overload */;
	int __fastcall IndexOf(System::UnicodeString FormName)/* overload */;
	__property TElFormListItem* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElFormList(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElFormContainer : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Elhtmlcontainer::TElHTMLContainer* FHTMLContainer;
	Elhtmlcontainer::TElHTMLChangeLink* FHTMLChangeLink;
	bool FCheckHTMLContainer;
	System::Classes::TList* FClients;
	TElFormList* FFormList;
	void __fastcall SetFormList(TElFormList* newValue);
	void __fastcall SetHTMLContainer(Elhtmlcontainer::TElHTMLContainer* const aValue);
	void __fastcall DoChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall AddForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall Add(Vcl::Forms::TCustomForm* aValue);
	__fastcall virtual TElFormContainer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFormContainer(void);
	DYNAMIC void __fastcall Change(void);
	void __fastcall RegisterChanges(TElFormContainerChangeLink* aValue);
	void __fastcall UnRegisterChanges(TElFormContainerChangeLink* aValue);
	
__published:
	__property bool CheckHTMLContainer = {read=FCheckHTMLContainer, write=FCheckHTMLContainer, nodefault};
	__property TElFormList* FormList = {read=FFormList, write=SetFormList};
	__property Elhtmlcontainer::TElHTMLContainer* HTMLContainer = {read=FHTMLContainer, write=SetHTMLContainer};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elformcontainer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFORMCONTAINER)
using namespace Elformcontainer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElformcontainerHPP
