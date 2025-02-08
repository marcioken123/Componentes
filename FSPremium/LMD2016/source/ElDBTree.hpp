// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBTree.pas' rev: 31.00 (Windows)

#ifndef EldbtreeHPP
#define EldbtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDObjectList.hpp>
#include <System.TypInfo.hpp>
#include <Data.DB.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <ElComponent.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElTree.hpp>
#include <ElDBXTree.hpp>
#include <ElHeader.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDElDBConst.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>
#include <ElScrollBar.hpp>
#include <ElSBCtrl.hpp>
#include <LMDHTMLUnit.hpp>
#include <Vcl.Menus.hpp>
#include <ElIni.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeDataLink;
class DELPHICLASS TSourceDataLink;
class DELPHICLASS TElRelationsItem;
class DELPHICLASS TElRelations;
class DELPHICLASS TElRelDataSource;
class DELPHICLASS TElTreeItemDataLink;
class DELPHICLASS TElDBTreeItem;
class DELPHICLASS TElDBTreeItems;
class DELPHICLASS TElStylesDefsItem;
class DELPHICLASS TElStylesDefs;
class DELPHICLASS TElCustomDataLink;
class DELPHICLASS TElDBTreeView;
class DELPHICLASS TCustomElDBTree;
class DELPHICLASS TElDBTree;
class DELPHICLASS THackElTreeInplaceManager;
class DELPHICLASS TElHackTreeView;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElOnActivateLevel)(System::TObject* Sender, TElDBTreeItem* Parent);

typedef void __fastcall (__closure *TElOnItemChangedEvent)(TElDBTreeItem* AItem);

typedef void __fastcall (__closure *TElOnItemCreated)(TElDBTreeItem* Item);

typedef void __fastcall (__closure *TElOnCustomColumnDataNeed)(System::TObject* Sender, TElDBTreeItem* Item, int SectionNumber, System::Variant &UserData, bool &IsPicture);

enum DECLSPEC_DENUM TElCustomEvent : unsigned char { elSetModify, elSetRelActive, elRecordChange, elUserDefined, elRelDeleted, elRelAdded, elRelSetChanged, elSetRelRefresh };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeDataLink : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FDataSetName;
	TCustomElDBTree* FTreeView;
	
protected:
	virtual void __fastcall NotifyControl(TElCustomEvent Event, int UserTag);
	
public:
	__fastcall TElTreeDataLink(TCustomElDBTree* ATreeView);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElTreeDataLink(void) { }
	
};

#pragma pack(pop)

typedef System::UnicodeString TElMasterField;

typedef System::UnicodeString TElDetailField;

typedef System::UnicodeString TElDetailDisplayField;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSourceDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TElRelationsItem* FElRelationsItem;
	TElRelDataSource* FElRelDataSource;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	
public:
	__fastcall TSourceDataLink(TElRelDataSource* AElRelDataSource, TElRelationsItem* AElRelationsItem);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TSourceDataLink(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElRelationsItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	bool FActive;
	int FActiveOnLevel;
	Data::Db::TDataSetNotifyEvent FAfterRefresh;
	bool FDenyLookSetPosition;
	TSourceDataLink* FDetailDataLink;
	Data::Db::TDataSource* FDetailDataSource;
	TElDetailDisplayField FDetailDisplayField;
	TElDetailField FDetailField;
	Data::Db::TDataSource* FMasterDataSource;
	TElMasterField FMasterField;
	System::UnicodeString FOldFilter;
	bool FOldFiltering;
	Data::Db::TDataSet* __fastcall GetDetailDataSet(void);
	Data::Db::TDataSet* __fastcall GetMasterDataSet(void);
	void __fastcall SetAfterRefresh(Data::Db::TDataSet* ADataset);
	void __fastcall SetDenyLookSetPosition(bool Value);
	void __fastcall SetDetailDataSet(Data::Db::TDataSet* ADataSet);
	void __fastcall SetDetailDisplayField(TElDetailDisplayField AField);
	void __fastcall SetDetailField(TElDetailField AField);
	void __fastcall SetMasterDataSet(Data::Db::TDataSet* ADataSet);
	void __fastcall SetMasterField(TElMasterField AField);
	
public:
	__fastcall virtual TElRelationsItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElRelationsItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Data::Db::TDataSource* __fastcall GetDetailDataSource(void);
	Data::Db::TDataSource* __fastcall GetMasterDataSource(void);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property int ActiveOnLevel = {read=FActiveOnLevel, write=FActiveOnLevel, default=-1};
	__property bool DenyLookSetPosition = {read=FDenyLookSetPosition, write=SetDenyLookSetPosition, default=0};
	__property Data::Db::TDataSet* DetailDataSet = {read=GetDetailDataSet, write=SetDetailDataSet};
	__property TElDetailDisplayField DetailDisplayField = {read=FDetailDisplayField, write=SetDetailDisplayField};
	__property TElDetailField DetailField = {read=FDetailField, write=SetDetailField};
	__property Data::Db::TDataSet* MasterDataSet = {read=GetMasterDataSet, write=SetMasterDataSet};
	__property TElMasterField MasterField = {read=FMasterField, write=SetMasterField};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElRelations : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElRelationsItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TElRelDataSource* FElRelDataSource;
	HIDESBASE TElRelationsItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TElRelationsItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TElRelations(TElRelDataSource* AElRelDataSource, System::Classes::TCollectionItemClass ItemClass);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall EndUpdate(void);
	__property TElRelDataSource* DataSource = {read=FElRelDataSource};
	__property TElRelationsItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElRelations(void) { }
	
};

#pragma pack(pop)

typedef System::UnicodeString TElDataField;

class PASCALIMPLEMENTATION TElRelDataSource : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Data::Db::TDataSetNotifyEvent FAfterRefresh;
	TElDataField FDataField;
	bool FDenyLookSetPosition;
	System::UnicodeString FFilter;
	bool FFiltered;
	bool FOwnFilter;
	TElRelations* FRelations;
	TSourceDataLink* FRootDataLink;
	Data::Db::TDataSource* FRootDataSource;
	System::Classes::TList* FTreeDataLinks;
	Data::Db::TDataSet* __fastcall GetRootDataSet(void);
	virtual void __fastcall SetAfterRefresh(Data::Db::TDataSet* ADataset);
	void __fastcall SetDataField(const TElDataField Value);
	void __fastcall SetDenyLookSetPosition(bool Value);
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetFiltered(const bool Value);
	void __fastcall SetRelations(TElRelations* Value);
	void __fastcall SetRootDataSet(Data::Db::TDataSet* ADataSet);
	
public:
	__fastcall virtual TElRelDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElRelDataSource(void);
	Data::Db::TDataSource* __fastcall GetRootDataSource(void);
	virtual void __fastcall NotifyLinks(TElCustomEvent Event, int UserTag);
	virtual void __fastcall RegisterLink(TElTreeDataLink* ALink);
	virtual void __fastcall UnRegisterLink(TElTreeDataLink* ALink);
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=GetRootDataSet, write=SetRootDataSet};
	__property bool DenyLookSetPosition = {read=FDenyLookSetPosition, write=SetDenyLookSetPosition, default=0};
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property bool OwnFilter = {read=FOwnFilter, write=FOwnFilter, default=1};
	__property TElRelations* Relations = {read=FRelations, write=SetRelations};
	__property TElDataField RootDataField = {read=FDataField, write=SetDataField};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTreeItemDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TElDBTreeItem* FElDBTreeItem;
	
protected:
	virtual void __fastcall RecordChanged(Data::Db::TField* Field);
	
public:
	__fastcall TElTreeItemDataLink(TElDBTreeItem* AElDBTreeItem);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TElTreeItemDataLink(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBTreeItem : public Eltree::TElTreeItem
{
	typedef Eltree::TElTreeItem inherited;
	
private:
	HIDESBASE TElDBTreeItem* __fastcall GetAncestor(void);
	
protected:
	System::DynamicArray<System::Byte> FBookmark;
	bool FChangingItem;
	System::UnicodeString FCheckBoxField;
	bool FCheckBoxFromBase;
	System::UnicodeString FDataField;
	TElTreeItemDataLink* FDataLink;
	bool FDenyLookSetPosition;
	System::UnicodeString FDetailField;
	System::UnicodeString FEditingField;
	System::UnicodeString FHintField;
	bool FHintFromBase;
	System::UnicodeString FImage2Index;
	System::UnicodeString FImageIndex;
	bool FImagesFromBase;
	bool FMarker;
	System::UnicodeString FMasterField;
	Lmdtypes::TLMDString FMasterValue;
	Lmdtypes::TLMDString FPattern;
	int FRecNum;
	int FRelIndex;
	System::UnicodeString FStImage2Index;
	System::UnicodeString FStImageIndex;
	HIDESBASE void __fastcall DeleteChild(void);
	HIDESBASE TElDBTreeItem* __fastcall GetItems(int Index);
	HIDESBASE TCustomElDBTree* __fastcall GetOwner(void);
	HIDESBASE TElDBTreeItem* __fastcall GetParent(void);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetText(void);
	System::UnicodeString __fastcall GetCheckBoxField(void);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall SetStyle(void);
	virtual void __fastcall SetText(Lmdtypes::TLMDString Value);
	__property bool CheckBoxFromBase = {read=FCheckBoxFromBase, write=FCheckBoxFromBase, nodefault};
	__property System::UnicodeString DataField = {read=FDataField, write=FDataField};
	__property System::UnicodeString DetailField = {read=FDetailField, write=FDetailField};
	__property System::UnicodeString HintField = {read=FHintField, write=FHintField};
	__property bool HintFromBase = {read=FHintFromBase, write=FHintFromBase, nodefault};
	__property System::UnicodeString Image2IndexField = {read=FImage2Index, write=FImage2Index};
	__property System::UnicodeString ImageIndexField = {read=FImageIndex, write=FImageIndex};
	__property bool ImagesFromBase = {read=FImagesFromBase, write=FImagesFromBase, nodefault};
	__property System::UnicodeString MasterField = {read=FMasterField, write=FMasterField};
	__property System::UnicodeString StateImage2IndexField = {read=FStImage2Index, write=FStImage2Index};
	__property System::UnicodeString StateImageIndexField = {read=FStImageIndex, write=FStImageIndex};
	
public:
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Eltree::PElTreeItemStaticData __fastcall GetStaticData(void);
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__fastcall virtual TElDBTreeItem(Eltree::TCustomElTree* AOwner);
	__fastcall virtual ~TElDBTreeItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Delete(void);
	HIDESBASE TElDBTreeItem* __fastcall GetChildByIndex(int index);
	HIDESBASE TElDBTreeItem* __fastcall GetFirstChild(void);
	HIDESBASE TElDBTreeItem* __fastcall GetFirstSibling(void);
	HIDESBASE TElDBTreeItem* __fastcall GetFirstVisibleChild(void);
	HIDESBASE TElDBTreeItem* __fastcall GetLastChild(void);
	HIDESBASE TElDBTreeItem* __fastcall GetLastSibling(void);
	HIDESBASE TElDBTreeItem* __fastcall GetLastSubItem(void);
	HIDESBASE virtual TElDBTreeItem* __fastcall GetNext(void);
	HIDESBASE TElDBTreeItem* __fastcall GetNextChild(TElDBTreeItem* Child);
	HIDESBASE TElDBTreeItem* __fastcall GetNextSibling(void);
	HIDESBASE TElDBTreeItem* __fastcall GetNextVisible(void);
	HIDESBASE virtual TElDBTreeItem* __fastcall GetPrev(void);
	HIDESBASE TElDBTreeItem* __fastcall GetPrevChild(TElDBTreeItem* Child);
	HIDESBASE TElDBTreeItem* __fastcall GetPrevSibling(void);
	HIDESBASE TElDBTreeItem* __fastcall GetPrevVisible(void);
	HIDESBASE void __fastcall MoveTo(TElDBTreeItem* NewParent);
	HIDESBASE void __fastcall MoveToIns(TElDBTreeItem* NewParent, int AnIndex);
	HIDESBASE void __fastcall MoveToItem(TElDBTreeItem* Item, Eltreeinplaceeditors::TNodeAttachMode Mode);
	void __fastcall Refresh(void);
	__property TElDBTreeItem* Ancestor = {read=GetAncestor};
	__property System::DynamicArray<System::Byte> Bookmark = {read=FBookmark};
	__property TElDBTreeItem* Children[int Index] = {read=GetItems};
	__property System::UnicodeString EditingField = {read=FEditingField};
	__property TElDBTreeItem* Item[int Index] = {read=GetItems};
	__property Lmdtypes::TLMDString MasterValue = {read=FMasterValue};
	__property TCustomElDBTree* Owner = {read=GetOwner};
	__property TElDBTreeItem* Parent = {read=GetParent};
	__property int RelationIndex = {read=FRelIndex, nodefault};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property TCustomElDBTree* TreeView = {read=GetOwner};
	__property System::UnicodeString CheckBoxField = {read=GetCheckBoxField};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBTreeItems : public Eltree::TElTreeItems
{
	typedef Eltree::TElTreeItems inherited;
	
public:
	TElDBTreeItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TElDBTreeItem* __fastcall GetDBItem(int Index);
	TElDBTreeItem* __fastcall GetDBRootItem(int Index);
	TElDBTreeItem* __fastcall GetDBVisItem(int Index);
	
public:
	virtual Eltree::TElTreeItem* __fastcall Add(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Eltree::TElTreeItem* __fastcall AddChild(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Eltree::TElTreeItem* __fastcall AddChildFirst(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Eltree::TElTreeItem* __fastcall AddChildObject(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Eltree::TElTreeItem* __fastcall AddChildObjectFirst(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Eltree::TElTreeItem* __fastcall AddFirst(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	HIDESBASE Eltree::TElTreeItem* __fastcall AddItem(Eltree::TElTreeItem* Parent);
	HIDESBASE Eltree::TElTreeItem* __fastcall AddLastItem(Eltree::TElTreeItem* Parent);
	virtual Eltree::TElTreeItem* __fastcall AddObject(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Eltree::TElTreeItem* __fastcall AddObjectFirst(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	HIDESBASE void __fastcall Clear(void);
	virtual void __fastcall Delete(Eltree::TElTreeItem* Item);
	HIDESBASE void __fastcall DeleteItem(Eltree::TElTreeItem* Child);
	virtual Eltree::TElTreeItem* __fastcall Insert(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Eltree::TElTreeItem* __fastcall InsertAfter(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Eltree::TElTreeItem* __fastcall InsertAfterObject(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	HIDESBASE Eltree::TElTreeItem* __fastcall InsertItem(int Index, Eltree::TElTreeItem* Parent);
	virtual Eltree::TElTreeItem* __fastcall InsertObject(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	HIDESBASE void __fastcall LoadFromFile(System::UnicodeString FileName);
	HIDESBASE void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	HIDESBASE void __fastcall LoadFromStringList(System::Classes::TStrings* Strings);
	HIDESBASE void __fastcall LoadFromWideStringList(System::Classes::TStrings* Strings);
	HIDESBASE void __fastcall SetItem(int Index, Eltree::TElTreeItem* Value);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TElDBTreeItem* __fastcall GetFirstNode(void);
	__property TElDBTreeItem* Item[int Index] = {read=GetDBItem/*, default*/};
	__property TElDBTreeItem* ItemAsVis[int Index] = {read=GetDBVisItem};
	__property TElDBTreeItem* RootItem[int Index] = {read=GetDBRootItem};
public:
	/* TElTreeItems.Create */ inline __fastcall virtual TElDBTreeItems(Eltree::TCustomElTree* AOwner) : Eltree::TElTreeItems(AOwner) { }
	/* TElTreeItems.CreateClass */ inline __fastcall TElDBTreeItems(Eltree::TCustomElTree* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TElTreeItems(AOwner, ItemClass) { }
	/* TElTreeItems.Destroy */ inline __fastcall virtual ~TElDBTreeItems(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStylesDefsItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	bool FAllowEdit;
	System::Uitypes::TColor FBkColor;
	bool FBold;
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
	Lmdtypes::TLMDString FCaption;
	System::UnicodeString FCheckBox;
	bool FCheckBoxEnabled;
	System::Uitypes::TColor FColor;
	System::UnicodeString FDataField;
	System::Classes::TStringList* FDataFields;
	bool FHasColumn;
	Data::Db::TDataLink* FDataLink;
	bool FDrawHLine;
	bool FEnabled;
	bool FForceButtons;
	int FHeight;
	bool FHidden;
	System::UnicodeString FHint;
	System::UnicodeString FHintField;
	bool FHintIsHTML;
	System::UnicodeString FImage;
	System::UnicodeString FImage2;
	int FImageIndex;
	int FImageIndex2;
	bool FImagesFromBase;
	int FIndentAdjust;
	bool FInDesign;
	bool FIsHTML;
	bool FItalic;
	bool FMultiline;
	bool FOwnerHeight;
	bool FParentColors;
	bool FParentStyle;
	Lmdtypes::TLMDString FPattern;
	System::Uitypes::TColor FRowBkColor;
	bool FShowCaption;
	bool FShowCheckBox;
	System::UnicodeString FStImage;
	System::UnicodeString FStImage2;
	int FStImageIndex;
	int FStImageIndex2;
	System::Uitypes::TColor FStrikedLineColor;
	bool FStrikedOutLine;
	bool FStrikeout;
	System::UnicodeString FStyleCaption;
	bool FSuppressButtons;
	bool FSuppressLines;
	bool FUnderlined;
	bool FUseBkColor;
	bool FUsePattern;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	System::Classes::TStringList* __fastcall GetDataFields(void);
	System::UnicodeString __fastcall GetDataSetName(void);
	void __fastcall ReadParentStyle(System::Classes::TReader* Reader);
	void __fastcall SetAllowEdit(bool Value);
	void __fastcall SetBkColor(System::Uitypes::TColor Value);
	void __fastcall SetBold(bool Value);
	void __fastcall SetBorderStyle(Eltreeinplaceeditors::TElItemBorderStyle Value);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	void __fastcall SetCheckBox(const System::UnicodeString Value);
	void __fastcall SetCheckBoxEnabled(bool Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetDataFields(System::Classes::TStringList* Value);
	void __fastcall SetDrawHLine(bool Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetForceButtons(bool Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetHidden(bool Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetHintField(const System::UnicodeString Value);
	void __fastcall SetHintIsHTML(bool Value);
	void __fastcall SetImage(const System::UnicodeString Value);
	void __fastcall SetImage2(const System::UnicodeString Value);
	void __fastcall SetImageIndex(int Value);
	void __fastcall SetImageIndex2(int Value);
	void __fastcall SetImagesFromBase(bool Value);
	void __fastcall SetIndentAdjust(int Value);
	void __fastcall SetIsHTML(bool Value);
	void __fastcall SetItalic(bool Value);
	void __fastcall SetMultiline(bool Value);
	void __fastcall SetOwnerHeight(bool Value);
	void __fastcall SetParentColors(bool Value);
	void __fastcall SetParentStyle(bool Value);
	void __fastcall SetPattern(Lmdtypes::TLMDString Value);
	void __fastcall SetRowBkColor(System::Uitypes::TColor Value);
	void __fastcall SetShowCaption(bool Value);
	void __fastcall SetShowCheckBox(bool Value);
	void __fastcall SetStateImageIndex(int Value);
	void __fastcall SetStateImageIndex2(int Value);
	void __fastcall SetStImage(const System::UnicodeString Value);
	void __fastcall SetStImage2(const System::UnicodeString Value);
	void __fastcall SetStrikedLineColor(System::Uitypes::TColor Value);
	void __fastcall SetStrikedOutLine(bool Value);
	void __fastcall SetStrikeout(bool Value);
	void __fastcall SetStyleCaption(const System::UnicodeString Value);
	void __fastcall SetSuppressButtons(bool Value);
	void __fastcall SetSuppressLines(bool Value);
	void __fastcall SetUnderlined(bool Value);
	void __fastcall SetUseBkColor(bool Value);
	void __fastcall SetUsePattern(bool Value);
	void __fastcall SetHasColumn(bool Value);
	
public:
	__fastcall virtual TElStylesDefsItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElStylesDefsItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Data::Db::TDataLink* DataLink = {read=FDataLink};
	__property bool InDesign = {read=FInDesign, nodefault};
	__property System::UnicodeString DataField = {read=FDataField};
	__property System::UnicodeString DataSetName = {read=GetDataSetName};
	
__published:
	__property bool AllowEdit = {read=FAllowEdit, write=SetAllowEdit, nodefault};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=SetBkColor, nodefault};
	__property bool Bold = {read=FBold, write=SetBold, nodefault};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString CheckBox = {read=FCheckBox, write=SetCheckBox};
	__property bool CheckBoxEnabled = {read=FCheckBoxEnabled, write=SetCheckBoxEnabled, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property System::Classes::TStringList* DataFields = {read=GetDataFields, write=SetDataFields};
	__property bool DrawHLine = {read=FDrawHLine, write=SetDrawHLine, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property bool ForceButtons = {read=FForceButtons, write=SetForceButtons, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property bool Hidden = {read=FHidden, write=SetHidden, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::UnicodeString HintField = {read=FHintField, write=SetHintField};
	__property bool HintIsHTML = {read=FHintIsHTML, write=SetHintIsHTML, nodefault};
	__property System::UnicodeString Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Image2 = {read=FImage2, write=SetImage2};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int ImageIndex2 = {read=FImageIndex2, write=SetImageIndex2, nodefault};
	__property bool ImagesFromBase = {read=FImagesFromBase, write=SetImagesFromBase, nodefault};
	__property int IndentAdjust = {read=FIndentAdjust, write=SetIndentAdjust, nodefault};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, nodefault};
	__property bool Italic = {read=FItalic, write=SetItalic, nodefault};
	__property bool Multiline = {read=FMultiline, write=SetMultiline, nodefault};
	__property bool OwnerHeight = {read=FOwnerHeight, write=SetOwnerHeight, nodefault};
	__property bool ParentColors = {read=FParentColors, write=SetParentColors, nodefault};
	__property bool ParentFontStyle = {read=FParentStyle, write=SetParentStyle, nodefault};
	__property Lmdtypes::TLMDString Pattern = {read=FPattern, write=SetPattern};
	__property System::Uitypes::TColor RowBkColor = {read=FRowBkColor, write=SetRowBkColor, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, nodefault};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, nodefault};
	__property int StateImageIndex = {read=FStImageIndex, write=SetStateImageIndex, nodefault};
	__property int StateImageIndex2 = {read=FStImageIndex2, write=SetStateImageIndex2, nodefault};
	__property System::UnicodeString StImage = {read=FStImage, write=SetStImage};
	__property System::UnicodeString StImage2 = {read=FStImage2, write=SetStImage2};
	__property System::Uitypes::TColor StrikedLineColor = {read=FStrikedLineColor, write=SetStrikedLineColor, nodefault};
	__property bool StrikedOutLine = {read=FStrikedOutLine, write=SetStrikedOutLine, nodefault};
	__property bool Strikeout = {read=FStrikeout, write=SetStrikeout, nodefault};
	__property System::UnicodeString StyleCaption = {read=FStyleCaption, write=SetStyleCaption};
	__property bool SuppressButtons = {read=FSuppressButtons, write=SetSuppressButtons, nodefault};
	__property bool SuppressLines = {read=FSuppressLines, write=SetSuppressLines, nodefault};
	__property bool Underlined = {read=FUnderlined, write=SetUnderlined, nodefault};
	__property bool UseBkColor = {read=FUseBkColor, write=SetUseBkColor, nodefault};
	__property bool UsePattern = {read=FUsePattern, write=SetUsePattern, default=0};
	__property bool HasColumn = {read=FHasColumn, write=SetHasColumn, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStylesDefs : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElStylesDefsItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FCanAppend;
	TCustomElDBTree* FCustomElDBTree;
	HIDESBASE TElStylesDefsItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TElStylesDefsItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TElStylesDefs(TCustomElDBTree* ACustomElDBTree, System::Classes::TCollectionItemClass ItemClass);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TElStylesDefsItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	__property TElStylesDefsItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TCustomElDBTree* Tree = {read=FCustomElDBTree};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElStylesDefs(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCustomDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	System::UnicodeString FOldFilter;
	bool FOldFiltered;
	int FRecCount;
	TCustomElDBTree* FTree;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall RecordChanged(Data::Db::TField* Field);
	
public:
	__fastcall TElCustomDataLink(void);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TElCustomDataLink(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElDBTreeView : public Eltree::TElTreeView
{
	typedef Eltree::TElTreeView inherited;
	
protected:
	virtual void __fastcall EditOperationAccepted(void);
	virtual void __fastcall EditOperationCancelled(void);
public:
	/* TElTreeView.Create */ inline __fastcall virtual TElDBTreeView(System::Classes::TComponent* Owner) : Eltree::TElTreeView(Owner) { }
	/* TElTreeView.Destroy */ inline __fastcall virtual ~TElDBTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBTreeView(HWND ParentWindow) : Eltree::TElTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElDBTree : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
private:
	bool FNoRebuildOnDataChange;
	bool FCustomDataEditing;
	int FCustomSectionNum;
	TElDBTreeItem* __fastcall GetDBDropTarget(void);
	TElDBTreeItem* __fastcall GetDBSelected(void);
	TElDBTreeItem* __fastcall GetDBTopItem(void);
	TElDBTreeItem* __fastcall GetDBTrackItem(void);
	void __fastcall SetDBSelected(TElDBTreeItem* const Value);
	void __fastcall SetDBTopItem(TElDBTreeItem* const Value);
	void __fastcall SetPrebuildLevelCount(const int Value);
	Lmdtypes::TLMDString __fastcall ParsePattern(Lmdtypes::TLMDString Pattern, Data::Db::TDataSet* ADataSet);
	System::WideString __fastcall GetWideStringText(Data::Db::TField* Field);
	
protected:
	bool FChanging;
	bool FCheckField;
	TElTreeDataLink* FDataLink;
	TElDBTreeItem* FDragItem;
	bool FGlobalChange;
	bool FInserting;
	System::Classes::TList* FListOfSets;
	int FMaxLevelCount;
	TElOnActivateLevel FOnActivateLevel;
	System::Classes::TNotifyEvent FOnAfterRebuildTree;
	TElOnCustomColumnDataNeed FOnCustomColumnDataNeed;
	TElOnItemChangedEvent FOnItemChanged;
	TElOnItemCreated FOnItemCreated;
	Vcl::Controls::TEndDragEvent FOnMyDrag;
	Vcl::Controls::TDragOverEvent FOnMyOver;
	Vcl::Controls::TStartDragEvent FOnMyStartDrag;
	int FPrebuildLevelCount;
	TElRelDataSource* FSource;
	TElStylesDefs* FStylesDefs;
	Lmdeldbconst::TElTableName FTablRelName;
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	void __fastcall CheckField(Data::Db::TField* Field);
	virtual TElDBTreeItem* __fastcall CreateNewItemInRoot(void);
	virtual Eltree::TElTreeView* __fastcall CreateView(void);
	virtual Eltree::TElTreeItems* __fastcall CreateItems(void);
	void __fastcall DataSetChanged(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoItemCollapsing(Eltree::TElTreeItem* AItem, bool &CanProcess);
	virtual void __fastcall DoItemExpanding(Eltree::TElTreeItem* AItem, bool &CanProcess);
	TElDBTreeItems* __fastcall GetDBItems(void);
	TElDBTreeItem* __fastcall GetItemFocused(void);
	TElRelDataSource* __fastcall GetSource(void);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall MoveToNewParent(TElDBTreeItem* FElDBTreeItem, Data::Db::TField* Field);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall OnHeaderSectionChange(Elheader::TCustomElHeader* Sender, Elheader::TElHeaderSection* Section, Elheader::TSectionChangeMode Change);
	void __fastcall ProcessItem(TElDBTreeItem* ACurItem, int FStepCount);
	void __fastcall RebuildStylesOnLevel(int StyleNum, Lmdeldbconst::TElUpdateStylesType code);
	virtual void __fastcall RebuildTableRelationsLevels(Lmdeldbconst::TElTableName AName);
	void __fastcall SetItemFocused(TElDBTreeItem* Value);
	virtual void __fastcall SetSource(TElRelDataSource* Source);
	void __fastcall SetStylesDefs(TElStylesDefs* Value);
	virtual void __fastcall TriggerInplaceEditorNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	virtual void __fastcall TriggerItemSelectedChangeEvent(Eltree::TElTreeItem* AItem);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef, int X, int Y);
	
public:
	__fastcall virtual TCustomElDBTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElDBTree(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE virtual TElDBTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	HIDESBASE virtual TElDBTreeItem* __fastcall GetItemAtY(int Y);
	HIDESBASE virtual TElDBTreeItem* __fastcall GetNextSelected(Eltree::TElTreeItem* Prev);
	HIDESBASE TElDBTreeItem* __fastcall GetNodeAt(int X, int Y);
	void __fastcall RebuildItemChilds(TElDBTreeItem* AElDBTreeItem);
	virtual void __fastcall RebuildTree(bool KeepCurrentID);
	__property Color = {default=-16777211};
	__property BkColor = {default=-16777211};
	__property bool DataChange = {read=FChanging, write=FChanging, nodefault};
	__property TElDBTreeItem* DropTarget = {read=GetDBDropTarget};
	__property TElDBTreeItem* ItemFocused = {read=GetItemFocused, write=SetItemFocused};
	__property TElDBTreeItems* Items = {read=GetDBItems};
	__property TElDBTreeItem* Selected = {read=GetDBSelected, write=SetDBSelected};
	__property TElDBTreeItem* TopItem = {read=GetDBTopItem, write=SetDBTopItem};
	__property TElDBTreeItem* TrackItem = {read=GetDBTrackItem};
	
__published:
	__property bool NoRebuildOnDataChange = {read=FNoRebuildOnDataChange, write=FNoRebuildOnDataChange, default=0};
	__property AlphaForImages;
	__property TElRelDataSource* DataSource = {read=GetSource, write=SetSource};
	__property Images;
	__property int MaxLevelCount = {read=FMaxLevelCount, write=FMaxLevelCount, default=10};
	__property TElOnActivateLevel OnActivateLevel = {read=FOnActivateLevel, write=FOnActivateLevel};
	__property System::Classes::TNotifyEvent OnAfterRebuildTree = {read=FOnAfterRebuildTree, write=FOnAfterRebuildTree};
	__property TElOnCustomColumnDataNeed OnCustomColumnDataNeed = {read=FOnCustomColumnDataNeed, write=FOnCustomColumnDataNeed};
	__property TElOnItemChangedEvent OnItemChanged = {read=FOnItemChanged, write=FOnItemChanged};
	__property TElOnItemCreated OnItemCreated = {read=FOnItemCreated, write=FOnItemCreated};
	__property int PrebuildLevelCount = {read=FPrebuildLevelCount, write=SetPrebuildLevelCount, default=2};
	__property TElStylesDefs* StylesDefs = {read=FStylesDefs, write=SetStylesDefs};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property VirtualityLevel = {default=0};
	__property ShowCheckBoxes = {default=0};
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TCustomElDBTree(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElDBTree(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBTree : public TCustomElDBTree
{
	typedef TCustomElDBTree inherited;
	
__published:
	__property UseThemeForSelection = {default=0};
	__property NoRebuildOnDataChange = {default=0};
	__property ActiveBorderType = {default=1};
	__property AdjustMultilineHeight = {default=1};
	__property Align = {default=0};
	__property AlphaForImages;
	__property AlphaForImages2;
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property Anchors = {default=3};
	__property AutoCollapse = {default=0};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=1};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BevelKind = {default=0};
	__property BkColor = {default=-16777211};
	__property BorderSides = {default=15};
	__property BorderStyle = {default=1};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxFlat = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property Cursor = {default=0};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DataSource;
	__property DblClickMode = {default=1};
	__property DefaultSectionWidth = {default=120};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DockOrientation;
	__property DoInplaceEdit = {default=1};
	__property DoubleBuffered = {default=1};
	__property DragAllowed = {default=0};
	__property DragCursor = {default=-12};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DragImageMode = {default=0};
	__property DragKind = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property DrawFocusRect = {default=1};
	__property Enabled = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=0};
	__property FilteredVisibility = {default=0};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property Floating;
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property Font = {stored=true};
	__property ForcedScrollBars = {default=0};
	__property FullRowSelect = {default=1};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=64};
	__property HeaderImageForm;
	__property HideFocusRect = {default=0};
	__property HideHintOnMove = {default=1};
	__property HideHintOnTimer = {default=0};
	__property HideHorzScrollBar = {default=0};
	__property HideSelectColor = {default=-16777201};
	__property HideSelection = {default=0};
	__property HideSelectTextColor = {default=-16777200};
	__property HideVertScrollBar = {default=0};
	__property Hint;
	__property HintType = {default=2};
	__property HorizontalLines = {default=0};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property HorzScrollTracking = {default=0};
	__property IgnoreEnabled = {default=0};
	__property ImageForm;
	__property Images;
	__property Images2;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property ItemIndent = {default=17};
	__property KeepSelectionWithinLevel = {default=0};
	__property LeafPicture;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property LineHeight;
	__property LineHintColor = {default=-16777211};
	__property LineHintMode = {default=1};
	__property LineHintTimeout = {default=3000};
	__property LineHintType = {default=2};
	__property LinesColor = {default=-16777201};
	__property LinesStyle = {default=2};
	__property LinkColor = {default=16711680};
	__property LinkCursor = {default=-21};
	__property LinkStyle = {default=4};
	__property LockHeaderHeight = {default=0};
	__property MainTreeColumn = {default=0};
	__property MaxLevelCount = {default=10};
	__property MinusPicture;
	__property MouseFrameSelect = {default=1};
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OnAfterRebuildTree;
	__property OnAfterSelectionChange;
	__property OnCellStyleLoad;
	__property OnCellStyleSave;
	__property OnChanging;
	__property OnClick;
	__property OnCompareItems;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDragTargetChange;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnHorzScrollDrawPart;
	__property OnHorzScrollHintNeeded;
	__property OnHotTrack;
	__property OnHTMLImageNeeded;
	__property OnInplaceEditorNeeded;
	__property OnItemChange;
	__property OnItemChecked;
	__property OnItemCollapse;
	__property OnItemCollapsing;
	__property OnItemDraw;
	__property OnItemExpand;
	__property OnItemExpanding;
	__property OnItemFocused;
	__property OnItemPicDraw;
	__property OnItemPicDraw2;
	__property OnItemPostDraw;
	__property OnItemPreDraw;
	__property OnItemSave;
	__property OnItemSelectedChange;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnLinkClick;
	__property OnMeasureItemPart;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnResize;
	__property OnScroll;
	__property OnShowLineHint;
	__property OnSortBegin;
	__property OnSortEnd;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnVertScrollDrawPart;
	__property OnVertScrollHintNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualStyleNeeded;
	__property OnVirtualTextNeeded;
	__property OnVirtualValueNeeded;
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
	__property PopupMenu;
	__property RadioButtonGlyph;
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property RightClickSelect = {default=1};
	__property RowHotTrack = {default=0};
	__property RowSelect = {default=1};
	__property ScrollbarOpposite = {default=0};
	__property SelectColumn = {default=-1};
	__property SelectionMode = {default=1};
	__property ShowButtons = {default=1};
	__property ShowCheckBoxes = {default=0};
	__property ShowColumns = {default=0};
	__property ShowEmptyImages = {default=0};
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=1};
	__property ShowLeafButton = {default=0};
	__property ShowLines = {default=1};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=1};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property SortSection = {default=0};
	__property SortType = {default=1};
	__property SortUseCase = {default=1};
	__property StickyHeaderSections = {default=0};
	__property Storage;
	__property StoragePath = {default=0};
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property StripedOddColor;
	__property StylesDefs;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property TextColor = {default=-16777208};
	__property TrackColor = {default=-16777203};
	__property Tracking = {default=1};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property UseSystemHintColors = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property VertDivLinesColor = {default=-16777201};
	__property VerticalLines = {default=0};
	__property VerticalLinesLong = {default=1};
	__property VertScrollBarStyles;
	__property VertScrollTracking = {default=0};
	__property VirtualityLevel = {default=0};
	__property Visible = {default=1};
public:
	/* TCustomElDBTree.Create */ inline __fastcall virtual TElDBTree(System::Classes::TComponent* AOwner) : TCustomElDBTree(AOwner) { }
	/* TCustomElDBTree.Destroy */ inline __fastcall virtual ~TElDBTree(void) { }
	
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElDBTree(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : TCustomElDBTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBTree(HWND ParentWindow) : TCustomElDBTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackElTreeInplaceManager : public Eltreeinplaceeditors::TElTreeInplaceManager
{
	typedef Eltreeinplaceeditors::TElTreeInplaceManager inherited;
	
public:
	/* TElTreeInplaceManager.Create */ inline __fastcall virtual THackElTreeInplaceManager(System::Classes::TComponent* AOwner) : Eltreeinplaceeditors::TElTreeInplaceManager(AOwner) { }
	/* TElTreeInplaceManager.Destroy */ inline __fastcall virtual ~THackElTreeInplaceManager(void) { }
	
};


class PASCALIMPLEMENTATION TElHackTreeView : public Eltree::TElTreeView
{
	typedef Eltree::TElTreeView inherited;
	
public:
	/* TElTreeView.Create */ inline __fastcall virtual TElHackTreeView(System::Classes::TComponent* Owner) : Eltree::TElTreeView(Owner) { }
	/* TElTreeView.Destroy */ inline __fastcall virtual ~TElHackTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHackTreeView(HWND ParentWindow) : Eltree::TElTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBTREE)
using namespace Eldbtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbtreeHPP
