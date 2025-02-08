// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElInspector.pas' rev: 31.00 (Windows)

#ifndef ElinspectorHPP
#define ElinspectorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Variants.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <ElEdits.hpp>
#include <ElComponent.hpp>
#include <ElPanel.hpp>
#include <ElHTMLPanel.hpp>
#include <ElTree.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDObjectList.hpp>
#include <ElHeader.hpp>
#include <ElStack.hpp>
#include <ElSplit.hpp>
#include <ElVCLUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <ElScrollBar.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.Menus.hpp>
#include <ElIni.hpp>
#include <LMDClass.hpp>
#include <ElSBCtrl.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElDragDrop.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElComponentAccess;
class DELPHICLASS TElTreeViewAccess;
class DELPHICLASS EElInpectorError;
class DELPHICLASS TElInspectorData;
class DELPHICLASS TElInspectorDataLink;
class DELPHICLASS TElInspectorDataSource;
class DELPHICLASS TElInspectorRegister;
class DELPHICLASS TElInspectorClassesList;
class DELPHICLASS TElCategory;
class DELPHICLASS TElCategories;
class DELPHICLASS TElEnumerator;
class DELPHICLASS TElInspectorItemStyle;
class DELPHICLASS TElTreeOptions;
class DELPHICLASS TElInspectorStyle;
class DELPHICLASS TElInspectorStyleSidewinder;
class DELPHICLASS TElInspectorStyleNET;
class DELPHICLASS TElInspectorStyleBorland;
class DELPHICLASS TElInspectorItem;
class DELPHICLASS TElInspectorTree;
class DELPHICLASS TCustomElInspector;
class DELPHICLASS TElInspector;
class DELPHICLASS THackElTreeItemStaticDataEx;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElInspectorAction : unsigned char { iRebuildInspector };

typedef System::TMetaClass* TElClassInplaceEditor;

typedef System::TMetaClass* TElClassInspectorData;

typedef void __fastcall (__closure *TNeedTextForHelpPanel)(System::TObject* Sender, Lmdtypes::TLMDString &TextFor);

typedef void __fastcall (__closure *TFilterItemEvent)(System::TObject* Sender, TElInspectorData* AItem, bool &Accept);

typedef void __fastcall (__closure *TNeedDisplayName)(System::TObject* Sender, TElInspectorData* AItem, Lmdtypes::TLMDString &ADisplayName);

typedef void __fastcall (__closure *TNeedCategory)(System::TObject* Sender, TElInspectorData* AItem, int &AIndex);

typedef void __fastcall (__closure *TGetValuesList)(TElInspectorItem* AItem, System::Classes::TStrings* ASList);

typedef void __fastcall (__closure *TValidateResult)(System::TObject* Sender, TElInspectorData* AItem, bool &Accepted);

class PASCALIMPLEMENTATION TElComponentAccess : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TElComponentAccess(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TElComponentAccess(void) { }
	
};


class PASCALIMPLEMENTATION TElTreeViewAccess : public Eltree::TElTreeView
{
	typedef Eltree::TElTreeView inherited;
	
public:
	/* TElTreeView.Create */ inline __fastcall virtual TElTreeViewAccess(System::Classes::TComponent* Owner) : Eltree::TElTreeView(Owner) { }
	/* TElTreeView.Destroy */ inline __fastcall virtual ~TElTreeViewAccess(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeViewAccess(HWND ParentWindow) : Eltree::TElTreeView(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION EElInpectorError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElInpectorError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElInpectorError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElInpectorError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElInpectorError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElInpectorError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElInpectorError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElInpectorError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElInpectorError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElInpectorError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElInpectorError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElInpectorError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElInpectorError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElInpectorError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorData : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	Lmdtypes::TLMDString FDisplayName;
	TElInspectorItem* FInspectorItem;
	virtual bool __fastcall GetAsBoolean(void);
	virtual System::TDateTime __fastcall GetAsDateTime(void);
	virtual double __fastcall GetAsFloat(void);
	virtual __int64 __fastcall GetAsInt64(void);
	virtual int __fastcall GetAsInteger(void);
	virtual System::TMethod __fastcall GetAsMethod(void);
	virtual System::TObject* __fastcall GetAsObject(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void) = 0 ;
	virtual System::Variant __fastcall GetAsVariant(void);
	virtual Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	virtual bool __fastcall GetIsComplex(void);
	virtual bool __fastcall GetIsDefault(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual bool __fastcall GetIsReadOnly(void);
	virtual bool __fastcall GetIsReference(void);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	virtual Lmdtypes::TLMDString __fastcall GetName(void) = 0 ;
	virtual void __fastcall SetAsBoolean(bool Value);
	virtual void __fastcall SetAsDateTime(System::TDateTime Value);
	virtual void __fastcall SetAsFloat(double Value);
	virtual void __fastcall SetAsInt64(__int64 Value);
	virtual void __fastcall SetAsInteger(int Value);
	virtual void __fastcall SetAsMethod(const System::TMethod &Value);
	virtual void __fastcall SetAsObject(System::TObject* Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value) = 0 ;
	virtual void __fastcall SetAsVariant(const System::Variant &Value);
	virtual void __fastcall SetDisplayName(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList) = 0 ;
	__property bool AsBoolean = {read=GetAsBoolean, write=SetAsBoolean, nodefault};
	__property System::TDateTime AsDateTime = {read=GetAsDateTime, write=SetAsDateTime};
	__property double AsFloat = {read=GetAsFloat, write=SetAsFloat};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger, nodefault};
	__property System::TMethod AsMethod = {read=GetAsMethod, write=SetAsMethod};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
	__property Lmdtypes::TLMDString AsString = {read=GetAsString, write=SetAsString};
	__property System::Variant AsVariant = {read=GetAsVariant, write=SetAsVariant};
	__property Lmdtypes::TLMDString DisplayName = {read=GetDisplayName, write=SetDisplayName};
	__property TElInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
	__property bool IsComplex = {read=GetIsComplex, nodefault};
	__property bool IsDefault = {read=GetIsDefault, nodefault};
	__property bool IsReference = {read=GetIsReference, nodefault};
	__property bool IsEnumerable = {read=GetIsEnumerable, nodefault};
	__property bool IsReadOnly = {read=GetIsReadOnly, nodefault};
	__property int MaxValue = {read=GetMaxValue, nodefault};
	__property int MinValue = {read=GetMinValue, nodefault};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property Lmdtypes::TLMDString Value = {read=GetAsString, write=SetAsString};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElInspectorData(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorDataLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TCustomElInspector* FInspector;
	TElInspectorDataSource* FInspectorDataSource;
	void __fastcall SetInspectorDataSource(TElInspectorDataSource* Value);
	
public:
	__fastcall TElInspectorDataLink(TCustomElInspector* AInspector);
	__fastcall virtual ~TElInspectorDataLink(void);
	__property TElInspectorDataSource* InspectorDataSource = {read=FInspectorDataSource, write=SetInspectorDataSource};
	__property TCustomElInspector* Inspector = {read=FInspector};
	void __fastcall NotifyInspector(TElInspectorAction Action);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorDataSource : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
protected:
	Lmdobjectlist::TLMDObjectList* FInspectors;
	TNeedCategory FNeedCategory;
	virtual TElCategories* __fastcall GetCategories(void) = 0 ;
	virtual TElInspectorClassesList* __fastcall GetRegClass(void) = 0 ;
	virtual void __fastcall SetCategories(TElCategories* const Value) = 0 ;
	
public:
	__fastcall virtual TElInspectorDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorDataSource(void);
	virtual TElEnumerator* __fastcall CreateEnumerator(TElInspectorData* Item) = 0 ;
	void __fastcall NotifyInspectors(TElInspectorAction Action);
	virtual void __fastcall ClearItemIndex(void) = 0 ;
	virtual void __fastcall DestroyEnumerator(TElEnumerator* AEnum) = 0 ;
	__property TElCategories* Categories = {read=GetCategories, write=SetCategories};
	__property TElInspectorClassesList* RegisterList = {read=GetRegClass};
	virtual void __fastcall RegisterDataLink(TElInspectorDataLink* Value);
	virtual void __fastcall UnregisterDataLink(TElInspectorDataLink* Value);
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorRegister : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TElClassInplaceEditor FEditorClass;
	TElClassInspectorData FInspectorData;
	
public:
	__fastcall TElInspectorRegister(const TElClassInplaceEditor AClass, const TElClassInspectorData AInspData);
	__property TElClassInplaceEditor EditorClass = {read=FEditorClass, write=FEditorClass};
	__property TElClassInspectorData InspectorData = {read=FInspectorData, write=FInspectorData};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorRegister(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorClassesList : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
protected:
	TElClassInspectorData __fastcall GetData(int Index);
	TElClassInplaceEditor __fastcall GetEditor(int Index);
	void __fastcall SetData(int Index, const TElClassInspectorData Value);
	void __fastcall SetEditor(int Index, const TElClassInplaceEditor Value);
	
public:
	TElInspectorRegister* __fastcall GetNeededData(TElInspectorItem* const AItem);
	virtual TElInspectorRegister* __fastcall GetNeededEditor(TElInspectorItem* const AItem) = 0 ;
	void __fastcall RegisterData(TElInspectorRegister* Value);
	__property TElClassInspectorData Data[int Index] = {read=GetData, write=SetData};
	__property TElClassInplaceEditor Editors[int Index] = {read=GetEditor, write=SetEditor};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElInspectorClassesList(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElInspectorClassesList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCategory : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	TElInspectorItem* FCategoryItem;
	Lmdtypes::TLMDString FName;
	int FTag;
	
public:
	__property TElInspectorItem* CategoryItem = {read=FCategoryItem, write=FCategoryItem, default=0};
	
__published:
	__property Lmdtypes::TLMDString Name = {read=FName, write=FName};
	__property int Tag = {read=FTag, write=FTag, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TElCategory(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TElCategory(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCategories : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElCategory* operator[](int index) { return this->Items[index]; }
	
protected:
	TElCategory* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, TElCategory* newValue);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TElCategory* __fastcall Add(void);
	__property TElCategory* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TElCategories(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TElCategories(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElEnumerator : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TElInspectorDataSource* FOwner;
	
public:
	virtual TElInspectorData* __fastcall GetFirstItem(void) = 0 ;
	virtual TElInspectorData* __fastcall GetNextItem(void) = 0 ;
	__property TElInspectorDataSource* Owner = {read=FOwner, write=FOwner};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElEnumerator(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElEnumerator(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorItemStyle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FBkColor;
	System::Uitypes::TFontStyles FFontStyles;
	
__published:
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=0};
	__property System::Uitypes::TFontStyles FontStyles = {read=FFontStyles, write=FFontStyles, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorItemStyle(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElInspectorItemStyle(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FItemIndent;
	bool FBarStyle;
	bool FDrawFocusRect;
	System::Uitypes::TColor FBkColor;
	System::Uitypes::TColor FHorzDivLinesColor;
	System::Uitypes::TColor FVertDivLinesColor;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectTextColor;
	
__published:
	__property bool BarStyle = {read=FBarStyle, write=FBarStyle, nodefault};
	__property bool DrawFocusRect = {read=FDrawFocusRect, write=FDrawFocusRect, nodefault};
	__property System::Uitypes::TColor HorzDivLinesColor = {read=FHorzDivLinesColor, write=FHorzDivLinesColor, nodefault};
	__property System::Uitypes::TColor VertDivLinesColor = {read=FVertDivLinesColor, write=FVertDivLinesColor, nodefault};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=FHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=FFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=FHideSelectTextColor, default=-16777200};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=FFocusedSelectTextColor, default=-16777202};
	__property int ItemIndent = {read=FItemIndent, write=FItemIndent, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElTreeOptions(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElTreeOptions(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorStyle : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	TElTreeOptions* FElTreeOptions;
	System::Uitypes::TColor FBackground;
	TElInspectorItemStyle* FCategory;
	TElInspectorItemStyle* FDefaultPropertyValue;
	System::Uitypes::TColor FEditBackground;
	TElInspectorItemStyle* FEditValue;
	TCustomElInspector* FOwner;
	TElInspectorItemStyle* FPropertyName;
	TElInspectorItemStyle* FPropertyValue;
	TElInspectorItemStyle* FReadOnlyProperty;
	TElInspectorItemStyle* FReferenceProperty;
	TElInspectorItemStyle* FSubProperty;
	TElInspectorItemStyle* FGutter;
	TElInspectorItemStyle* FLines;
	void __fastcall SetGutter(TElInspectorItemStyle* const Value);
	void __fastcall SetLines(TElInspectorItemStyle* const Value);
	void __fastcall SetBackground(const System::Uitypes::TColor Value);
	void __fastcall SetCategory(TElInspectorItemStyle* const Value);
	void __fastcall SetDefaultPropertyValue(TElInspectorItemStyle* const Value);
	void __fastcall SetEditBackground(const System::Uitypes::TColor Value);
	void __fastcall SetEditValue(TElInspectorItemStyle* const Value);
	void __fastcall SetPropertyName(TElInspectorItemStyle* const Value);
	void __fastcall SetPropertyValue(TElInspectorItemStyle* const Value);
	void __fastcall SetReadOnlyProperty(TElInspectorItemStyle* const Value);
	void __fastcall SetReferenceProperty(TElInspectorItemStyle* const Value);
	void __fastcall SetSubProperty(TElInspectorItemStyle* const Value);
	
protected:
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R, const int Width) = 0 ;
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R) = 0 ;
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	
public:
	__fastcall virtual TElInspectorStyle(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorStyle(void);
	
__published:
	__property System::Uitypes::TColor Background = {read=FBackground, write=SetBackground, nodefault};
	__property TElInspectorItemStyle* Category = {read=FCategory, write=SetCategory};
	__property TElInspectorItemStyle* DefaultPropertyValue = {read=FDefaultPropertyValue, write=SetDefaultPropertyValue};
	__property System::Uitypes::TColor EditBackground = {read=FEditBackground, write=SetEditBackground, nodefault};
	__property TElInspectorItemStyle* EditValue = {read=FEditValue, write=SetEditValue};
	__property TElInspectorItemStyle* PropertyName = {read=FPropertyName, write=SetPropertyName};
	__property TElInspectorItemStyle* PropertyValue = {read=FPropertyValue, write=SetPropertyValue};
	__property TElInspectorItemStyle* ReadOnlyProperty = {read=FReadOnlyProperty, write=SetReadOnlyProperty};
	__property TElInspectorItemStyle* ReferenceProperty = {read=FReferenceProperty, write=SetReferenceProperty};
	__property TElInspectorItemStyle* SubProperty = {read=FSubProperty, write=SetSubProperty};
	__property TElInspectorItemStyle* Gutter = {read=FGutter, write=SetGutter};
	__property TElInspectorItemStyle* Lines = {read=FLines, write=SetLines};
	__property TElTreeOptions* TreeOptions = {read=FElTreeOptions, write=FElTreeOptions};
};


class PASCALIMPLEMENTATION TElInspectorStyleSidewinder : public TElInspectorStyle
{
	typedef TElInspectorStyle inherited;
	
protected:
	Vcl::Graphics::TBitmap* FGutterMarker;
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R, const int Width);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R);
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	
public:
	__fastcall virtual TElInspectorStyleSidewinder(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorStyleSidewinder(void);
};


class PASCALIMPLEMENTATION TElInspectorStyleNET : public TElInspectorStyle
{
	typedef TElInspectorStyle inherited;
	
protected:
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R, const int Width);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R);
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	
public:
	__fastcall virtual TElInspectorStyleNET(System::Classes::TComponent* AOwner);
public:
	/* TElInspectorStyle.Destroy */ inline __fastcall virtual ~TElInspectorStyleNET(void) { }
	
};


class PASCALIMPLEMENTATION TElInspectorStyleBorland : public TElInspectorStyle
{
	typedef TElInspectorStyle inherited;
	
protected:
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R, const int Width);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, const System::Types::TRect &R);
	
public:
	__fastcall virtual TElInspectorStyleBorland(System::Classes::TComponent* AOwner);
public:
	/* TElInspectorStyle.Destroy */ inline __fastcall virtual ~TElInspectorStyleBorland(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorItem : public Eltree::TElTreeItem
{
	typedef Eltree::TElTreeItem inherited;
	
protected:
	TElInspectorData* FInspectorData;
	bool FIsCategory;
	
public:
	__fastcall virtual ~TElInspectorItem(void);
	__property TElInspectorData* InspectorData = {read=FInspectorData, write=FInspectorData};
	__property bool IsCategory = {read=FIsCategory, write=FIsCategory, default=0};
public:
	/* TElTreeItem.Create */ inline __fastcall virtual TElInspectorItem(Eltree::TCustomElTree* AOwner) : Eltree::TElTreeItem(AOwner) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorTree : public Eltree::TElTreeView
{
	typedef Eltree::TElTreeView inherited;
	
private:
	bool FResizeCol;
	
protected:
	int FLeftMargin;
	int FRightMargin;
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawHorzLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	virtual void __fastcall DrawVertLine(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	virtual void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, Eltree::TElTreeItem* Item, System::Types::TRect &R);
	
public:
	__fastcall virtual TElInspectorTree(System::Classes::TComponent* Owner);
public:
	/* TElTreeView.Destroy */ inline __fastcall virtual ~TElInspectorTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElInspectorTree(HWND ParentWindow) : Eltree::TElTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElInspector : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
protected:
	bool FCategorized;
	TElInspectorDataLink* FElInspectorDataLink;
	TElInspectorTree* FElInspectorTree;
	bool FFiltered;
	Elhtmlpanel::TElHTMLPanel* FHelpPanel;
	TElInspectorItem* FRebuildedItem;
	Elsplit::TElSplitter* FSplitter;
	TElInspectorStyle* FInspectorStyle;
	Elheader::TElHeaderSectionEvent FOldOnHeaderSectionResize;
	TFilterItemEvent FOnFilterItem;
	TNeedCategory FOnNeedCategory;
	TNeedDisplayName FOnNeedDisplayName;
	TNeedTextForHelpPanel FOnNeedTextForHelpPanel;
	TGetValuesList FOnGetValuesList;
	TValidateResult FOnValidateResult;
	bool FShowHeader;
	bool FShowHelpPanel;
	void __fastcall ValidateEditorInput(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall AlignPieces(void);
	void __fastcall ApplyStyleToItem(TElInspectorItem* AItem);
	virtual Elhtmlpanel::TElHTMLPanel* __fastcall CreateHelpPanel(void);
	virtual Elsplit::TElSplitter* __fastcall CreateSplit(void);
	virtual Eltreeinplaceeditors::TElTreeInplaceManager* __fastcall CreateInplaceManager(void);
	virtual Eltree::TElTreeItems* __fastcall CreateItems(void);
	virtual Eltree::TElTreeView* __fastcall CreateView(void);
	virtual void __fastcall DoEndEditItem(Eltree::TElTreeItem* Item, Elheader::TElHeaderSection* Section, bool Canceled);
	virtual bool __fastcall DoFilterItem(TElInspectorData* AItem);
	virtual void __fastcall DoItemCollapse(Eltree::TElTreeItem* Item);
	virtual void __fastcall DoItemExpand(Eltree::TElTreeItem* Item);
	virtual int __fastcall DoNeedCategory(TElInspectorData* AItem);
	virtual void __fastcall DoNeedDisplayName(TElInspectorData* AItem);
	virtual void __fastcall DoRebuildInspector(TElInspectorItem* AStartItem);
	TElInspectorItem* __fastcall GetCategory(TElInspectorItem* AParent, TElInspectorData* AItem);
	TElInspectorItem* __fastcall GetRebuildedItem(void);
	virtual void __fastcall MouseDownTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetCategorized(const bool Value);
	void __fastcall SetDataSource(TElInspectorDataSource* const Value);
	TElInspectorDataSource* __fastcall GetDataSource(void);
	void __fastcall SetFiltered(const bool Value);
	void __fastcall SetInspectorStyle(TElInspectorStyle* const Value);
	void __fastcall SetShowHelpPanel(const bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall TriggerInplaceEditorNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	virtual void __fastcall TriggerItemSelectedChangeEvent(Eltree::TElTreeItem* Item);
	virtual void __fastcall TriggerNeedTextForHelpPanel(System::TObject* Sender);
	virtual void __fastcall TriggerGetValuesList(TElInspectorItem* AItem, System::Classes::TStrings* ASList);
	HIDESBASE void __fastcall OnHeaderSectionResize(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	void __fastcall OnSplitPositionChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TCustomElInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElInspector(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Rebuild(TElInspectorItem* const AStartItem);
	virtual void __fastcall TriggerValidateResult(Eltreeinplaceeditors::TElTreeInplaceEditor* const AEditor, TElInspectorData* const AItem, bool &Accepted);
	
__published:
	__property bool Categorized = {read=FCategorized, write=SetCategorized, default=0};
	__property TElInspectorDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property TElInspectorStyle* InspectorStyle = {read=FInspectorStyle, write=SetInspectorStyle};
	__property TElInspectorItem* RebuildedItem = {read=GetRebuildedItem, write=FRebuildedItem};
	__property TGetValuesList OnGetValuesList = {read=FOnGetValuesList, write=FOnGetValuesList};
	__property TFilterItemEvent OnFilterItem = {read=FOnFilterItem, write=FOnFilterItem};
	__property TNeedCategory OnNeedCategory = {read=FOnNeedCategory, write=FOnNeedCategory};
	__property TNeedDisplayName OnNeedDisplayName = {read=FOnNeedDisplayName, write=FOnNeedDisplayName};
	__property TNeedTextForHelpPanel OnNeedTextForHelpPanel = {read=FOnNeedTextForHelpPanel, write=FOnNeedTextForHelpPanel};
	__property TValidateResult OnValidateResult = {read=FOnValidateResult, write=FOnValidateResult};
	__property bool ShowHelpPanel = {read=FShowHelpPanel, write=SetShowHelpPanel, nodefault};
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TCustomElInspector(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElInspector(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElInspector : public TCustomElInspector
{
	typedef TCustomElInspector inherited;
	
__published:
	__property ActiveBorderType = {default=1};
	__property DragCursor = {default=-12};
	__property Align = {default=0};
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property AutoCollapse = {default=0};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=1};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=1};
	__property DragKind = {default=0};
	__property DefaultSectionWidth = {default=120};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BorderStyle = {default=1};
	__property BorderSides = {default=15};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property Ctl3D;
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DblClickMode = {default=1};
	__property DoInplaceEdit = {default=1};
	__property DragAllowed = {default=0};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragImageMode = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property Enabled = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=0};
	__property FilteredVisibility = {default=0};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=IsFontStored};
	__property FullRowSelect = {default=1};
	__property GradientStartColor = {default=0};
	__property GradientEndColor = {default=0};
	__property GradientSteps = {default=64};
	__property HeaderActiveFilterColor = {default=0};
	__property HeaderColor = {default=-16777201};
	__property HeaderHeight;
	__property HeaderHotTrack = {default=1};
	__property HeaderInvertSortArrows = {default=0};
	__property HeaderSections;
	__property HeaderFilterColor = {default=-16777198};
	__property HeaderFlat = {default=0};
	__property HeaderFont;
	__property HeaderUseTreeFont = {default=1};
	__property HeaderImages;
	__property AlphaForHeaderImages;
	__property HeaderWrapCaptions = {default=0};
	__property HideFocusRect = {default=0};
	__property HideHintOnTimer = {default=0};
	__property HideHintOnMove = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HideSelection = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalLines = {default=0};
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property Hint;
	__property HintType = {default=2};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property IgnoreEnabled = {default=0};
	__property HeaderImageForm;
	__property ImageForm;
	__property Images;
	__property Images2;
	__property AlphaForImages;
	__property AlphaForImages2;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
	__property KeepSelectionWithinLevel = {default=0};
	__property LeafPicture;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property LineHeight;
	__property LinesColor = {default=-16777201};
	__property LinesStyle = {default=2};
	__property LineHintColor = {default=-16777211};
	__property LineHintMode = {default=1};
	__property LineHintTimeout = {default=3000};
	__property LineHintType = {default=2};
	__property LockHeaderHeight = {default=0};
	__property MainTextType = {default=1};
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MouseFrameSelect = {default=1};
	__property MouseFrameVisible = {default=1};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
	__property PopupMenu;
	__property QuickEditMode = {default=0};
	__property RadioButtonGlyph;
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property RightClickSelect = {default=1};
	__property RowHotTrack = {default=0};
	__property RowSelect = {default=1};
	__property ScrollbarOpposite = {default=0};
	__property HorzScrollTracking = {default=0};
	__property VertScrollTracking = {default=0};
	__property SelectColumn = {default=-1};
	__property ShowButtons = {default=1};
	__property ShowColumns = {default=0};
	__property ShowCheckBoxes = {default=0};
	__property ShowEmptyImages = {default=0};
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=1};
	__property ShowLeafButton = {default=0};
	__property ShowLines = {default=1};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=1};
	__property SelectionMode = {default=1};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property SortSection = {default=0};
	__property SortType = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property SortUseCase = {default=1};
	__property StickyHeaderSections = {default=0};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property Items;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property HotTrack = {default=1};
	__property TrackColor = {default=-16777203};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property VertScrollBarStyles;
	__property VirtualityLevel = {default=0};
	__property Visible = {default=1};
	__property UseSystemHintColors = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnScroll;
	__property OnHeaderColumnClick;
	__property OnHeaderColumnDraw;
	__property OnHeaderColumnResize;
	__property OnHeaderColumnMove;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnHeaderResize;
	__property OnHeaderSectionExpand;
	__property OnHeaderSectionCollapse;
	__property OnHeaderSectionFilterCall;
	__property OnHeaderSectionAutoSize;
	__property OnHeaderSectionMeasure;
	__property OnHorzScrollDrawPart;
	__property OnHorzScrollHintNeeded;
	__property OnAfterSelectionChange;
	__property OnApplyVisFilter;
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnResize;
	__property OnTryEdit;
	__property OnInplaceEditorNeeded;
	__property OnEndEditItem;
	__property OnItemChecked;
	__property OnItemExpand;
	__property OnItemCollapse;
	__property OnItemExpanding;
	__property OnItemCollapsing;
	__property OnItemDeletion;
	__property OnItemFocused;
	__property OnShowLineHint;
	__property OnCompareItems;
	__property OnItemPicDraw;
	__property OnItemPicDraw2;
	__property OnItemPostDraw;
	__property OnHotTrack;
	__property OnMeasureItemPart;
	__property OnSortBegin;
	__property OnSortEnd;
	__property OnItemSave;
	__property OnItemLoad;
	__property OnItemSelectedChange;
	__property OnCellStyleSave;
	__property OnCellStyleLoad;
	__property OnVertScrollDrawPart;
	__property OnVertScrollHintNeeded;
	__property OnHTMLImageNeeded;
	__property OnLinkClick;
	__property LinkCursor = {default=-21};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property OnVirtualPropsNeeded;
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnHeaderMouseDown;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
public:
	/* TCustomElInspector.Create */ inline __fastcall virtual TElInspector(System::Classes::TComponent* AOwner) : TCustomElInspector(AOwner) { }
	/* TCustomElInspector.Destroy */ inline __fastcall virtual ~TElInspector(void) { }
	
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElInspector(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : TCustomElInspector(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElInspector(HWND ParentWindow) : TCustomElInspector(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION THackElTreeItemStaticDataEx : public Eltree::TElTreeItemStaticDataEx
{
	typedef Eltree::TElTreeItemStaticDataEx inherited;
	
public:
	/* TObject.Create */ inline __fastcall THackElTreeItemStaticDataEx(void) : Eltree::TElTreeItemStaticDataEx() { }
	/* TObject.Destroy */ inline __fastcall virtual ~THackElTreeItemStaticDataEx(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elinspector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELINSPECTOR)
using namespace Elinspector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElinspectorHPP
