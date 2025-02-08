// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBXTree.pas' rev: 31.00 (Windows)

#ifndef EldbxtreeHPP
#define EldbxtreeHPP

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
#include <System.TypInfo.hpp>
#include <Data.DB.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <ElVCLUtils.hpp>
#include <ElComponent.hpp>
#include <ElXPThemedControl.hpp>
#include <ElXTree.hpp>
#include <ElXTreeCell.hpp>
#include <ElXHeader.hpp>
#include <ElHeader.hpp>
#include <ElMTree.hpp>
#include <ElSBCtrl.hpp>
#include <LMDObjectList.hpp>
#include <LMDStrings.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDElDBConst.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>
#include <ElScrollBar.hpp>
#include <LMDHTMLUnit.hpp>
#include <Vcl.Menus.hpp>
#include <ElIni.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbxtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EOnErrorInMTree;
class DELPHICLASS EOnDeleteFromDenyDataSet;
class DELPHICLASS TElDBTreeInplaceEditor;
class DELPHICLASS TElXTreeDataLink;
class DELPHICLASS TElXSourceDataLink;
class DELPHICLASS TElXRelationsItem;
class DELPHICLASS TElXRelations;
class DELPHICLASS TElXRelDataSource;
class DELPHICLASS TElXHackTreeView;
class DELPHICLASS THackElXTreeInplaceManager;
class DELPHICLASS THackElXTreeItem;
class DELPHICLASS TElMDBTree;
class DELPHICLASS TElDBXTreeItem;
class DELPHICLASS TElDBXTreeItems;
class DELPHICLASS TElXStylesDefsItem;
class DELPHICLASS TElXStylesDefs;
class DELPHICLASS TElDBXTreeView;
class DELPHICLASS TCustomElDBXTree;
class DELPHICLASS TElDBXTree;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnErrorInMTree : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnErrorInMTree(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnErrorInMTree(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnErrorInMTree(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnErrorInMTree(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnErrorInMTree(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnErrorInMTree(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnErrorInMTree(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnErrorInMTree(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnErrorInMTree(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnErrorInMTree(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnErrorInMTree(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnErrorInMTree(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnErrorInMTree(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnDeleteFromDenyDataSet : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnDeleteFromDenyDataSet(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnDeleteFromDenyDataSet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnDeleteFromDenyDataSet(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnDeleteFromDenyDataSet(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnDeleteFromDenyDataSet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnDeleteFromDenyDataSet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnDeleteFromDenyDataSet(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnDeleteFromDenyDataSet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnDeleteFromDenyDataSet(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnDeleteFromDenyDataSet(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnDeleteFromDenyDataSet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnDeleteFromDenyDataSet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnDeleteFromDenyDataSet(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElXOnActivateLevel)(System::TObject* Sender, Lmdtypes::TLMDString MasterValue, int RelNo);

typedef void __fastcall (__closure *TElXOnItemChangedEvent)(TElDBXTreeItem* AItem);

typedef void __fastcall (__closure *TElXOnItemCreated)(TElDBXTreeItem* Item);

typedef void __fastcall (__closure *TElXOnCustomColumnDataNeed)(System::TObject* Sender, Lmdtypes::TLMDString MasterValue, int RelNo, int SectionNumber, System::Variant &UserData, bool &IsPicture);

enum DECLSPEC_DENUM TElXCustomEvent : unsigned char { elSetModify, elSetRelActive, elRecordChange, elUserDefined, elRelDeleted, elRelAdded, elRelSetChanged, elSetRelRefresh, elTreeNeedRefresh, elTreeNeedRepaint };

enum DECLSPEC_DENUM Eldbxtree__3 : unsigned char { elIsCaption, elDenyLookSetPosition };

typedef System::Set<Eldbxtree__3, Eldbxtree__3::elIsCaption, Eldbxtree__3::elDenyLookSetPosition> TElXDataSetOptions;

enum DECLSPEC_DENUM TValName : unsigned char { vnCellType, vnHint, vnDataField, vnDetailField, vnMasterField, vnMasterValue, vnText, vnMarker, vnHasPicture, vnCheckBoxField, vnCheckBoxFromBase, vnImageIndex2, vnImageIndex, vnImagesFromBase, vnRelIndex, vnStateImageIndex2, vnStateImageIndex, vnCheckBoxState, vnPicture, vnOwnerHeight, vnHeight, vnImageIndexField, vnImageIndex2Field, vnStImageIndexField, vnStImageIndex2Field };

class PASCALIMPLEMENTATION TElDBTreeInplaceEditor : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
protected:
	System::Classes::TNotifyEvent FOnAfterCompleteOperation;
	Eltreeinplaceeditors::TElTreeAncestor* __fastcall GetTree(void);
	HIDESBASE void __fastcall SetTree(Eltreeinplaceeditors::TElTreeAncestor* Value);
	virtual void __fastcall TriggerAfterCompleteOperation(void);
	
public:
	virtual void __fastcall StartOperation(void);
	
__published:
	__property Eltreeinplaceeditors::TElTreeAncestor* Tree = {read=GetTree, write=SetTree};
	__property System::Classes::TNotifyEvent OnAfterCompleteOperation = {read=FOnAfterCompleteOperation, write=FOnAfterCompleteOperation};
public:
	/* TElTreeInplaceEditor.Create */ inline __fastcall virtual TElDBTreeInplaceEditor(System::Classes::TComponent* AOwner) : Eltreeinplaceeditors::TElTreeInplaceEditor(AOwner) { }
	/* TElTreeInplaceEditor.Destroy */ inline __fastcall virtual ~TElDBTreeInplaceEditor(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeDataLink : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FDataSetName;
	TCustomElDBXTree* FTreeView;
	
protected:
	virtual void __fastcall NotifyControl(TElXCustomEvent Event, int UserTag);
	
public:
	__fastcall TElXTreeDataLink(TCustomElDBXTree* ATreeView);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElXTreeDataLink(void) { }
	
};

#pragma pack(pop)

typedef System::UnicodeString TElXMasterField;

typedef System::UnicodeString TElXDetailField;

typedef System::UnicodeString TElXDetailDisplayField;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXSourceDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TElXRelationsItem* FElRelationsItem;
	TElXRelDataSource* FElRelDataSource;
	int FCount;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall EditingChanged(void);
	
public:
	__fastcall TElXSourceDataLink(TElXRelDataSource* AElRelDataSource, TElXRelationsItem* AElRelationsItem);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TElXSourceDataLink(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElXRelationsItem : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	int ID;
	System::UnicodeString FName;
	TElXRelations* FRelations;
	Lmdtypes::TLMDString FCaption;
	bool FShowCaption;
	bool FActive;
	int FActiveOnLevel;
	Data::Db::TDataSetNotifyEvent FAfterRefresh;
	bool FDenyLookSetPosition;
	TElXSourceDataLink* FDetailDataLink;
	Data::Db::TDataSource* FDetailDataSource;
	TElXDetailDisplayField FDetailDisplayField;
	TElXDetailField FDetailField;
	Data::Db::TDataSource* FMasterDataSource;
	TElXMasterField FMasterField;
	System::UnicodeString FOwnFilter;
	bool FOwnFiltered;
	int __fastcall GetIndex(void);
	Data::Db::TDataSet* __fastcall GetDetailDataSet(void);
	Data::Db::TDataSet* __fastcall GetMasterDataSet(void);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetAfterRefresh(Data::Db::TDataSet* ADataset);
	void __fastcall SetDenyLookSetPosition(bool Value);
	void __fastcall SetDetailDataSet(Data::Db::TDataSet* ADataSet);
	void __fastcall SetDetailDisplayField(TElXDetailDisplayField AField);
	void __fastcall SetDetailField(TElXDetailField AField);
	void __fastcall SetMasterField(TElXMasterField AField);
	void __fastcall SetMasterDataSet(Data::Db::TDataSet* ADataSet);
	Data::Db::TDataSource* __fastcall GetDetailDataSource(void);
	Data::Db::TDataSource* __fastcall GetMasterDataSource(void);
	
public:
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall WriteToStream(System::Classes::TStream* Stream);
	__fastcall virtual TElXRelationsItem(TElXRelations* ARelations, int AID);
	__fastcall virtual ~TElXRelationsItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property int ActiveOnLevel = {read=FActiveOnLevel, write=FActiveOnLevel, default=-1};
	__property bool DenyLookSetPosition = {read=FDenyLookSetPosition, write=SetDenyLookSetPosition, default=0};
	__property Data::Db::TDataSet* DetailDataSet = {read=GetDetailDataSet, write=SetDetailDataSet};
	__property TElXDetailDisplayField DetailDisplayField = {read=FDetailDisplayField, write=SetDetailDisplayField};
	__property TElXDetailField DetailField = {read=FDetailField, write=SetDetailField};
	__property Data::Db::TDataSet* MasterDataSet = {read=GetMasterDataSet, write=SetMasterDataSet};
	__property TElXMasterField MasterField = {read=FMasterField, write=SetMasterField};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, nodefault};
	__property int Index = {read=GetIndex, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXRelations : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TElXRelationsItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TElXRelDataSource* FElRelDataSource;
	System::Classes::TList* FList;
	TElXRelationsItem* __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, TElXRelationsItem* Value);
	int __fastcall GetCount(void);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall LoadRelProperty(System::Classes::TStream* Stream);
	void __fastcall WriteRelProperty(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TElXRelations(TElXRelDataSource* AElRelDataSource);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual ~TElXRelations(void);
	void __fastcall Changed(void);
	void __fastcall DeleteItem(int Index);
	void __fastcall AddItem(int Index);
	__property TElXRelDataSource* DataSource = {read=FElRelDataSource};
	__property TElXRelationsItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

typedef System::UnicodeString TElXDataField;

class PASCALIMPLEMENTATION TElXRelDataSource : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Lmdtypes::TLMDString FCaption;
	bool FShowCaption;
	Data::Db::TDataSetNotifyEvent FAfterRefresh;
	TElXDataField FDataField;
	bool FDenyLookSetPosition;
	System::UnicodeString FOwnFilter;
	bool FOwnFiltered;
	System::UnicodeString FFilter;
	bool FFiltered;
	TElXRelations* FRelations;
	TElXSourceDataLink* FRootDataLink;
	Data::Db::TDataSource* FRootDataSource;
	System::Classes::TList* FTreeDataLinks;
	virtual void __fastcall SetAfterRefresh(Data::Db::TDataSet* ADataset);
	Data::Db::TDataSet* __fastcall GetRootDataSet(void);
	void __fastcall SetRelations(TElXRelations* Value);
	Data::Db::TDataSet* __fastcall GetSetOnLevel(int Level, TElXDataSetOptions &DataSetOptions);
	
protected:
	void __fastcall SetRootDataSet(Data::Db::TDataSet* ADataSet);
	void __fastcall SetDataField(const TElXDataField Value);
	void __fastcall SetDenyLookSetPosition(bool Value);
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetFiltered(const bool Value);
	void __fastcall LoadCompProperty(System::Classes::TStream* Stream);
	void __fastcall StoreCompProperty(System::Classes::TStream* Stream);
	
public:
	int __fastcall GetRelNoOnLevel(int Level, TElXDataSetOptions &DataSetOptions);
	virtual int __fastcall RecCountOnLevel(int Level, Lmdtypes::TLMDString MasterValue);
	__fastcall virtual TElXRelDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElXRelDataSource(void);
	Data::Db::TDataSource* __fastcall GetRootDataSource(void);
	virtual void __fastcall NotifyLinks(TElXCustomEvent Event, int UserTag);
	virtual void __fastcall RegisterLink(TElXTreeDataLink* ALink);
	virtual void __fastcall UnRegisterLink(TElXTreeDataLink* ALink);
	__property Data::Db::TDataSet* RootDataSet = {read=GetRootDataSet, write=SetRootDataSet};
	__property TElXDataField DataField = {read=FDataField, write=SetDataField};
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=GetRootDataSet, write=SetRootDataSet};
	__property bool DenyLookSetPosition = {read=FDenyLookSetPosition, write=SetDenyLookSetPosition, default=0};
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property TElXRelations* Relations = {read=FRelations, write=SetRelations};
	__property TElXDataField RootDataField = {read=FDataField, write=SetDataField};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
};


class PASCALIMPLEMENTATION TElXHackTreeView : public Elxtree::TElXTreeView
{
	typedef Elxtree::TElXTreeView inherited;
	
public:
	/* TElXTreeView.Create */ inline __fastcall virtual TElXHackTreeView(System::Classes::TComponent* Owner) : Elxtree::TElXTreeView(Owner) { }
	/* TElXTreeView.Destroy */ inline __fastcall virtual ~TElXHackTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXHackTreeView(HWND ParentWindow) : Elxtree::TElXTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackElXTreeInplaceManager : public Eltreeinplaceeditors::TElTreeInplaceManager
{
	typedef Eltreeinplaceeditors::TElTreeInplaceManager inherited;
	
public:
	/* TElTreeInplaceManager.Create */ inline __fastcall virtual THackElXTreeInplaceManager(System::Classes::TComponent* AOwner) : Eltreeinplaceeditors::TElTreeInplaceManager(AOwner) { }
	/* TElTreeInplaceManager.Destroy */ inline __fastcall virtual ~THackElXTreeInplaceManager(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION THackElXTreeItem : public Elxtree::TElXTreeItem
{
	typedef Elxtree::TElXTreeItem inherited;
	
public:
	/* TElXTreeItem.Create */ inline __fastcall virtual THackElXTreeItem(Elxtree::TCustomElXTree* AOwner) : Elxtree::TElXTreeItem(AOwner) { }
	/* TElXTreeItem.Destroy */ inline __fastcall virtual ~THackElXTreeItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElMDBTree : public Elmtree::TElMTree
{
	typedef Elmtree::TElMTree inherited;
	
private:
	TCustomElDBXTree* FTree;
	int __fastcall GetRowCount(void);
	
public:
	void __fastcall RebuildTree(void);
	void __fastcall RefreshData(void);
	virtual void __fastcall Clear(void);
	int __fastcall DBChildrensCount(Elmtree::TElMTreeItem* Parent);
	void __fastcall CheckActualChildrensCount(Elmtree::TElMTreeItem* AParent);
	void __fastcall GetDataForChildrens(Elmtree::TElMTreeItem* Parent, int StartIndex, int StopIndex);
	__property TCustomElDBXTree* Tree = {read=FTree, write=FTree};
	__property int RowCount = {read=GetRowCount, nodefault};
public:
	/* TElMTree.Create */ inline __fastcall TElMDBTree(void) : Elmtree::TElMTree() { }
	/* TElMTree.Destroy */ inline __fastcall virtual ~TElMDBTree(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBXTreeItem : public Elxtree::TElXTreeItem
{
	typedef Elxtree::TElXTreeItem inherited;
	
private:
	HIDESBASE TElDBXTreeItem* __fastcall GetAncestor(void);
	
protected:
	Elmtree::TElMTreeItem* FMItem;
	System::DynamicArray<System::Byte> FBookmark;
	System::UnicodeString FDataField;
	System::UnicodeString FDetailField;
	System::UnicodeString FMasterField;
	Lmdtypes::TLMDString FMasterValue;
	bool FMarker;
	bool FHasPicture;
	bool FChangingItem;
	System::UnicodeString FCheckBoxField;
	bool FCheckBoxFromBase;
	System::UnicodeString FImage2Index;
	System::UnicodeString FImageIndex;
	bool FImagesFromBase;
	int FRelIndex;
	System::UnicodeString FStImage2Index;
	System::UnicodeString FStImageIndex;
	HIDESBASE void __fastcall DeleteChild(void);
	void __fastcall CheckActualChildrens(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetItems(int Index);
	HIDESBASE TCustomElDBXTree* __fastcall GetOwner(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetParent(void);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetText(void);
	int __fastcall GetRelIndex(void);
	System::UnicodeString __fastcall GetCheckBoxField(void);
	bool __fastcall GetCheckBoxFromBase(void);
	System::UnicodeString __fastcall GetDataField(void);
	System::DynamicArray<System::Byte> __fastcall GetBookmark(void);
	System::UnicodeString __fastcall GetDetailField(void);
	System::UnicodeString __fastcall GetImage2IndexField(void);
	System::UnicodeString __fastcall GetImageIndexField(void);
	bool __fastcall GetImagesFromBase(void);
	System::UnicodeString __fastcall GetMasterField(void);
	System::UnicodeString __fastcall GetEditingField(void);
	Lmdtypes::TLMDString __fastcall GetMasterValue(void);
	System::UnicodeString __fastcall GetStateImage2IndexField(void);
	System::UnicodeString __fastcall GetStateImageIndexField(void);
	void __fastcall SetStyle(void);
	virtual void __fastcall SetText(Lmdtypes::TLMDString Value);
	void __fastcall SetEditingField(System::UnicodeString Value);
	__property bool CheckBoxFromBase = {read=GetCheckBoxFromBase, write=FCheckBoxFromBase, nodefault};
	__property System::UnicodeString DetailField = {read=GetDetailField, write=FDetailField};
	__property System::UnicodeString Image2IndexField = {read=GetImage2IndexField, write=FImage2Index};
	__property System::UnicodeString ImageIndexField = {read=GetImageIndexField, write=FImageIndex};
	__property bool ImagesFromBase = {read=GetImagesFromBase, write=FImagesFromBase, nodefault};
	__property System::UnicodeString StateImage2IndexField = {read=GetStateImage2IndexField, write=FStImage2Index};
	__property System::UnicodeString StateImageIndexField = {read=GetStateImageIndexField, write=FStImageIndex};
	virtual void __fastcall DeleteFromDataSet(void);
	void __fastcall InsertSiblingToDataSet(void);
	void __fastcall InsertChildToDataSet(void);
	
public:
	__fastcall virtual TElDBXTreeItem(Elxtree::TCustomElXTree* AOwner);
	__fastcall virtual ~TElDBXTreeItem(void);
	virtual void __fastcall MoveTo(Elxtree::TElXTreeItem* NewParent);
	virtual void __fastcall MoveToIns(Elxtree::TElXTreeItem* NewParent, int AnIndex);
	__property int RelIndex = {read=GetRelIndex, nodefault};
	__property System::UnicodeString MasterField = {read=GetMasterField};
	__property Lmdtypes::TLMDString MasterValue = {read=GetMasterValue};
	__property System::UnicodeString DataField = {read=GetDataField};
	HIDESBASE virtual void __fastcall EndEdit(bool ByCancel);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Delete(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetChildByIndex(int index);
	HIDESBASE TElDBXTreeItem* __fastcall GetFirstChild(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetFirstSibling(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetFirstVisibleChild(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetLastChild(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetLastSibling(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetLastSubItem(void);
	HIDESBASE virtual TElDBXTreeItem* __fastcall GetNext(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetNextChild(TElDBXTreeItem* Child);
	HIDESBASE TElDBXTreeItem* __fastcall GetNextSibling(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetNextVisible(void);
	HIDESBASE virtual TElDBXTreeItem* __fastcall GetPrev(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetPrevChild(TElDBXTreeItem* Child);
	HIDESBASE TElDBXTreeItem* __fastcall GetPrevSibling(void);
	HIDESBASE TElDBXTreeItem* __fastcall GetPrevVisible(void);
	__property TElDBXTreeItem* Ancestor = {read=GetAncestor};
	__property System::DynamicArray<System::Byte> Bookmark = {read=GetBookmark};
	__property TElDBXTreeItem* Children[int Index] = {read=GetItems};
	__property System::UnicodeString EditingField = {read=GetEditingField, write=SetEditingField};
	__property TElDBXTreeItem* Item[int Index] = {read=GetItems};
	__property TCustomElDBXTree* Owner = {read=GetOwner};
	__property TElDBXTreeItem* Parent = {read=GetParent};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property TCustomElDBXTree* TreeView = {read=GetOwner};
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	__property System::UnicodeString CheckBoxField = {read=GetCheckBoxField};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBXTreeItems : public Elxtree::TElXTreeItems
{
	typedef Elxtree::TElXTreeItems inherited;
	
public:
	TElDBXTreeItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TElDBXTreeItem* __fastcall GetDBItem(int Index);
	TElDBXTreeItem* __fastcall GetDBRootItem(int Index);
	TElDBXTreeItem* __fastcall GetDBVisItem(int Index);
	
protected:
	virtual Elxtree::TElXTreeItem* __fastcall Add(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Elxtree::TElXTreeItem* __fastcall AddChild(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Elxtree::TElXTreeItem* __fastcall AddChildFirst(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Elxtree::TElXTreeItem* __fastcall AddChildObject(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Elxtree::TElXTreeItem* __fastcall AddChildObjectFirst(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Elxtree::TElXTreeItem* __fastcall AddFirst(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	HIDESBASE Elxtree::TElXTreeItem* __fastcall AddItem(Elxtree::TElXTreeItem* Parent);
	HIDESBASE Elxtree::TElXTreeItem* __fastcall AddLastItem(Elxtree::TElXTreeItem* Parent);
	virtual Elxtree::TElXTreeItem* __fastcall AddObject(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual Elxtree::TElXTreeItem* __fastcall AddObjectFirst(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	virtual void __fastcall Delete(Elxtree::TElXTreeItem* Item);
	HIDESBASE void __fastcall DeleteItem(Elxtree::TElXTreeItem* Child);
	virtual Elxtree::TElXTreeItem* __fastcall Insert(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Elxtree::TElXTreeItem* __fastcall InsertAfter(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text);
	virtual Elxtree::TElXTreeItem* __fastcall InsertAfterObject(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	HIDESBASE Elxtree::TElXTreeItem* __fastcall InsertItem(int Index, Elxtree::TElXTreeItem* Parent);
	virtual Elxtree::TElXTreeItem* __fastcall InsertObject(Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString Text, void * Ptr);
	HIDESBASE void __fastcall LoadFromFile(System::UnicodeString FileName);
	HIDESBASE void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	HIDESBASE void __fastcall LoadFromStringList(System::Classes::TStrings* Strings);
	HIDESBASE void __fastcall LoadFromWideStringList(System::Classes::TStrings* Strings);
	HIDESBASE void __fastcall SetItem(int Index, Elxtree::TElXTreeItem* Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TElDBXTreeItem* __fastcall GetFirstNode(void);
	__property TElDBXTreeItem* Item[int Index] = {read=GetDBItem/*, default*/};
	__property TElDBXTreeItem* ItemAsVis[int Index] = {read=GetDBVisItem};
	__property TElDBXTreeItem* RootItem[int Index] = {read=GetDBRootItem};
public:
	/* TElXTreeItems.Create */ inline __fastcall virtual TElDBXTreeItems(Elxtree::TCustomElXTree* AOwner) : Elxtree::TElXTreeItems(AOwner) { }
	/* TElXTreeItems.CreateClass */ inline __fastcall TElDBXTreeItems(Elxtree::TCustomElXTree* AOwner, Elxtree::TElXTreeItemClass ItemClass) : Elxtree::TElXTreeItems(AOwner, ItemClass) { }
	/* TElXTreeItems.Destroy */ inline __fastcall virtual ~TElDBXTreeItems(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXStylesDefsItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	bool FAllowEdit;
	System::Uitypes::TColor FBkColor;
	bool FBold;
	Eltreeinplaceeditors::TElItemBorderStyle FBorderStyle;
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
	bool FWordWrap;
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
	void __fastcall SetAllowEdit(bool Value);
	void __fastcall SetBkColor(System::Uitypes::TColor Value);
	void __fastcall SetBold(bool Value);
	void __fastcall SetBorderStyle(Eltreeinplaceeditors::TElItemBorderStyle Value);
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
	__fastcall virtual TElXStylesDefsItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElXStylesDefsItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Data::Db::TDataLink* DataLink = {read=FDataLink};
	__property bool InDesign = {read=FInDesign, nodefault};
	__property System::UnicodeString DataField = {read=FDataField};
	__property System::UnicodeString DataSetName = {read=GetDataSetName};
	
__published:
	__property bool AllowEdit = {read=FAllowEdit, write=SetAllowEdit, nodefault};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=SetBkColor, default=-16777211};
	__property bool Bold = {read=FBold, write=SetBold, nodefault};
	__property Eltreeinplaceeditors::TElItemBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property System::UnicodeString CheckBox = {read=FCheckBox, write=SetCheckBox};
	__property bool CheckBoxEnabled = {read=FCheckBoxEnabled, write=SetCheckBoxEnabled, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777208};
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
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, nodefault};
	__property bool OwnerHeight = {read=FOwnerHeight, write=SetOwnerHeight, nodefault};
	__property bool ParentColors = {read=FParentColors, write=SetParentColors, nodefault};
	__property bool ParentFontStyle = {read=FParentStyle, write=SetParentStyle, nodefault};
	__property Lmdtypes::TLMDString Pattern = {read=FPattern, write=SetPattern};
	__property System::Uitypes::TColor RowBkColor = {read=FRowBkColor, write=SetRowBkColor, default=-16777211};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
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
class PASCALIMPLEMENTATION TElXStylesDefs : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElXStylesDefsItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FCanAppend;
	TCustomElDBXTree* FCustomElDBTree;
	HIDESBASE TElXStylesDefsItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TElXStylesDefsItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TElXStylesDefs(TCustomElDBXTree* ACustomElDBTree, System::Classes::TCollectionItemClass ItemClass);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TElXStylesDefsItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	__property TElXStylesDefsItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TCustomElDBXTree* Tree = {read=FCustomElDBTree};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElXStylesDefs(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElDBXTreeView : public Elxtree::TElXTreeView
{
	typedef Elxtree::TElXTreeView inherited;
	
public:
	virtual void __fastcall DefineHRange(void);
public:
	/* TElXTreeView.Create */ inline __fastcall virtual TElDBXTreeView(System::Classes::TComponent* Owner) : Elxtree::TElXTreeView(Owner) { }
	/* TElXTreeView.Destroy */ inline __fastcall virtual ~TElDBXTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBXTreeView(HWND ParentWindow) : Elxtree::TElXTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomElDBXTree : public Elxtree::TCustomElXTree
{
	typedef Elxtree::TCustomElXTree inherited;
	
private:
	bool FSorting;
	bool FCustomDataEditing;
	int FCustomSectionNum;
	TElDBXTreeItem* __fastcall GetDBDropTarget(void);
	TElDBXTreeItem* __fastcall GetDBSelected(void);
	TElDBXTreeItem* __fastcall GetDBTopItem(void);
	TElDBXTreeItem* __fastcall GetDBTrackItem(void);
	void __fastcall SetDBSelected(TElDBXTreeItem* const Value);
	void __fastcall SetDBTopItem(TElDBXTreeItem* const Value);
	Lmdtypes::TLMDString __fastcall ParsePattern(Lmdtypes::TLMDString Pattern, Data::Db::TDataSet* ADataSet);
	int __fastcall SizeToPixels(int Value);
	void __fastcall RebuildOnDisignTime(void);
	System::WideString __fastcall GetWideStringText(Data::Db::TField* Field);
	
protected:
	bool FNoRebuildOnDataChange;
	bool FChanging;
	bool FCheckField;
	TElXTreeDataLink* FDataLink;
	TElDBXTreeItem* FDragItem;
	bool FGlobalChange;
	bool FInserting;
	TElXOnActivateLevel FOnActivateLevel;
	System::Classes::TNotifyEvent FOnAfterBuildTree;
	System::Classes::TNotifyEvent FOnBeforeBuildTree;
	TElXOnCustomColumnDataNeed FOnCustomColumnDataNeed;
	TElXOnItemChangedEvent FOnItemChanged;
	TElXOnItemCreated FOnItemCreated;
	Vcl::Controls::TEndDragEvent FOnMyDrag;
	Vcl::Controls::TDragOverEvent FOnMyOver;
	Vcl::Controls::TStartDragEvent FOnMyStartDrag;
	TElXRelDataSource* FSource;
	TElXStylesDefs* FStylesDefs;
	Lmdeldbconst::TElTableName FTablRelName;
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	TElMDBTree* FDataTree;
	virtual void __fastcall DoItemChecked(Elxtree::TElXTreeItem* Item);
	virtual int __fastcall DataWidth(void);
	virtual int __fastcall ColumnWidth(int ASectionIndex, int Level);
	virtual void __fastcall SetRightAlignedText(bool newValue);
	virtual Elxtree::TElXTreeView* __fastcall CreateView(void);
	virtual Elxtree::TElXTreeItems* __fastcall CreateItems(void);
	virtual void __fastcall OnHeaderSectionClick(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall NewOnVirtualTextNeeded(System::TObject* Sender, Elxtree::TElXTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	void __fastcall NewTreeVirtualPropsNeeded(System::TObject* Sender, Elxtree::TElXTreeItem* Item, Eltreeinplaceeditors::TElVirtPropTypes PropTypes, Elxtree::TElXTreeItemStaticDataEx* Value);
	void __fastcall NewVirtualStyleNeeded(System::TObject* Sender, Elxtree::TElXTreeItem* Item, int SectionIndex, Elxtreecell::TElXCellStyle* Style);
	void __fastcall NewVirtualHintNeeded(System::TObject* Sender, Elxtree::TElXTreeItem* Item, Lmdtypes::TLMDString &Hint);
	void __fastcall DataSetChanged(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall AfterEdit(void);
	TElDBXTreeItems* __fastcall GetDBItems(void);
	TElDBXTreeItem* __fastcall GetItemFocused(void);
	TElXRelDataSource* __fastcall GetSource(void);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall OnHeaderSectionChange(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section, Elheader::TSectionChangeMode Change);
	void __fastcall SetItemFocused(TElDBXTreeItem* Value);
	virtual void __fastcall SetSource(TElXRelDataSource* Source);
	void __fastcall SetStylesDefs(TElXStylesDefs* Value);
	virtual void __fastcall TriggerInplaceEditorNeeded(Elxtree::TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	void __fastcall NavigateInDataSet(Elxtree::TElXTreeItem* AItem, bool ChangeTreeState);
	virtual void __fastcall TriggerItemSelectedChangeEvent(Elxtree::TElXTreeItem* AItem);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef, int X, int Y);
	void __fastcall CheckRootLevel(void);
	virtual void __fastcall TriggerSortBegin(void);
	virtual void __fastcall TriggerSortEnd(void);
	void __fastcall InsertToRootDataSet(void);
	
public:
	__fastcall virtual TCustomElDBXTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElDBXTree(void);
	virtual int __fastcall MeasureColumnWidth(int ColumnNum, bool VisibleOnly);
	virtual void __fastcall MeasureCell(Elxtree::TElXTreeItem* Item, int ColumnNum, int MaxWidth, System::Types::TPoint &Size);
	HIDESBASE virtual void __fastcall Refresh(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE virtual TElDBXTreeItem* __fastcall GetItemAt(int X, int Y, Eltreeinplaceeditors::TSTItemPart &ItemPart, int &HitColumn);
	HIDESBASE virtual TElDBXTreeItem* __fastcall GetItemAtY(int Y);
	HIDESBASE virtual TElDBXTreeItem* __fastcall GetNextSelected(Elxtree::TElXTreeItem* Prev);
	HIDESBASE TElDBXTreeItem* __fastcall GetNodeAt(int X, int Y);
	virtual void __fastcall RebuildTree(bool KeepCurrentID);
	__property Color = {default=-16777211};
	__property BackGroundColor = {default=-16777211};
	__property TextColor = {default=-16777208};
	__property LineHeight;
	__property bool DataChange = {read=FChanging, write=FChanging, nodefault};
	__property TElDBXTreeItem* DropTarget = {read=GetDBDropTarget};
	__property TElDBXTreeItem* ItemFocused = {read=GetItemFocused, write=SetItemFocused};
	__property TElDBXTreeItems* Items = {read=GetDBItems};
	__property TElDBXTreeItem* Selected = {read=GetDBSelected, write=SetDBSelected};
	__property TElDBXTreeItem* TopItem = {read=GetDBTopItem, write=SetDBTopItem};
	__property TElDBXTreeItem* TrackItem = {read=GetDBTrackItem};
	__property UseXPThemes;
	
__published:
	__property bool NoRebuildOnDataChange = {read=FNoRebuildOnDataChange, write=FNoRebuildOnDataChange, default=0};
	__property AlphaForImages;
	__property TElXRelDataSource* DataSource = {read=GetSource, write=SetSource};
	__property Images;
	__property TElXOnActivateLevel OnActivateLevel = {read=FOnActivateLevel, write=FOnActivateLevel};
	__property System::Classes::TNotifyEvent OnAfterBuildTree = {read=FOnAfterBuildTree, write=FOnAfterBuildTree};
	__property System::Classes::TNotifyEvent OnBeforeBuildTree = {read=FOnBeforeBuildTree, write=FOnBeforeBuildTree};
	__property TElXOnCustomColumnDataNeed OnCustomColumnDataNeed = {read=FOnCustomColumnDataNeed, write=FOnCustomColumnDataNeed};
	__property TElXOnItemChangedEvent OnItemChanged = {read=FOnItemChanged, write=FOnItemChanged};
	__property TElXOnItemCreated OnItemCreated = {read=FOnItemCreated, write=FOnItemCreated};
	__property TElXStylesDefs* StylesDefs = {read=FStylesDefs, write=SetStylesDefs};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
	__property ShowCheckBoxes = {default=0};
public:
	/* TCustomElXTree.CreateClass */ inline __fastcall TCustomElDBXTree(System::Classes::TComponent* AOwner, Elxtree::TElXTreeItemClass ItemClass) : Elxtree::TCustomElXTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElDBXTree(HWND ParentWindow) : Elxtree::TCustomElXTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBXTree : public TCustomElDBXTree
{
	typedef TCustomElDBXTree inherited;
	
__published:
	__property UseThemeForSelection = {default=0};
	__property FixedTopRowNum;
	__property FixedBottomRowNum;
	__property FixedColNum;
	__property GutterWidth;
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
	__property AutoLineVisibleOnly = {default=0};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BarStyleNotRaise = {default=0};
	__property BevelKind = {default=0};
	__property BackGroundColor = {default=-16777211};
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
	__property HeaderActiveFilterColor = {default=0};
	__property HeaderColor = {default=-16777201};
	__property HeaderHeight;
	__property HeaderRowCount = {default=1};
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
	__property HeaderImageForm;
	__property ImageForm;
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
	__property MinusPicture;
	__property MouseFrameSelect = {default=1};
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OnAfterBuildTree;
	__property OnBeforeBuildTree;
	__property OnAfterSelectionChange;
	__property OnCellStyleLoad;
	__property OnCellStyleSave;
	__property OnCellDeletion;
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
	__property OnCellChange;
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
	__property OnItemCreated;
	__property OnItemDeletion;
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
	__property ShowLeafButton;
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
	__property Visible = {default=1};
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
public:
	/* TCustomElDBXTree.Create */ inline __fastcall virtual TElDBXTree(System::Classes::TComponent* AOwner) : TCustomElDBXTree(AOwner) { }
	/* TCustomElDBXTree.Destroy */ inline __fastcall virtual ~TElDBXTree(void) { }
	
public:
	/* TCustomElXTree.CreateClass */ inline __fastcall TElDBXTree(System::Classes::TComponent* AOwner, Elxtree::TElXTreeItemClass ItemClass) : TCustomElDBXTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBXTree(HWND ParentWindow) : TCustomElDBXTree(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbxtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBXTREE)
using namespace Eldbxtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbxtreeHPP
