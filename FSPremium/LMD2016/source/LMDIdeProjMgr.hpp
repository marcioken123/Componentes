// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeProjMgr.pas' rev: 31.00 (Windows)

#ifndef LmdideprojmgrHPP
#define LmdideprojmgrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDXML.hpp>
#include <LMDIdeCst.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideprojmgr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDProjectManager;
class DELPHICLASS TLMDProjNode;
class DELPHICLASS TLMDProjDocument;
class DELPHICLASS TLMDProjDocOpenContext;
class DELPHICLASS TLMDProjectManager;
class DELPHICLASS TLMDOpenedDocument;
class DELPHICLASS TLMDProjectManagerView;
class DELPHICLASS TLMDDocEditorsViewItem;
class DELPHICLASS TLMDDocEditorsViewEditors;
class DELPHICLASS TLMDDocEditorsView;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDProjectManager : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDProjectManager(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDProjectManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDProjectManager(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDProjectManager(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDProjectManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDProjectManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDProjectManager(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDProjectManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDProjectManager(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDProjectManager(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDProjectManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDProjectManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDProjectManager(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDProjNodeClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProjNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDProjectManager* FProjMgr;
	TLMDProjNode* FParent;
	System::Classes::TList* FNodes;
	System::Classes::TList* FDocuments;
	bool FModified;
	int FChildModifyCount;
	void *FData;
	System::Classes::TList* FTreeNodes;
	bool FDestroying;
	void __fastcall InsertNode(TLMDProjNode* ANode);
	void __fastcall RemoveNode(TLMDProjNode* ANode);
	void __fastcall SetTreeNode(Vcl::Comctrls::TCustomTreeView* ATreeView, Vcl::Comctrls::TTreeNode* ANode);
	Vcl::Comctrls::TTreeNode* __fastcall GetTreeNode(Vcl::Comctrls::TCustomTreeView* ATreeView);
	void __fastcall ClearTreeNodes(void);
	void __fastcall ClearNodes(void);
	void __fastcall SetModified(bool AValue);
	int __fastcall GetNodeCount(void);
	TLMDProjNode* __fastcall GetNodes(int AIndex);
	int __fastcall GetDocumentCount(void);
	TLMDProjDocument* __fastcall GetDocuments(int AIndex);
	Lmdtypes::TLMDString __fastcall GetIdent(void);
	void __fastcall SetParent(TLMDProjNode* const Value);
	
protected:
	void __fastcall ReadChildren(Lmdxml::_di_ILMDXmlElement AParent);
	void __fastcall WriteChildren(Lmdxml::_di_ILMDXmlElement AParent);
	virtual void __fastcall DoRead(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoWrite(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual Lmdtypes::TLMDString __fastcall DoGetDisplayName(void);
	virtual void __fastcall DrawImage(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	
public:
	__fastcall virtual TLMDProjNode(TLMDProjectManager* AProjMgr, TLMDProjNode* AParent);
	__fastcall virtual ~TLMDProjNode(void);
	virtual void __fastcall AfterConstruction(void);
	__classmethod Lmdtypes::TLMDString __fastcall GetNodeClassIdent();
	__classmethod void __fastcall SetNodeClassIdent(const Lmdtypes::TLMDString AValue);
	void __fastcall UpdateViews(void);
	void __fastcall MarkModified(void);
	void __fastcall ResetModified(void);
	bool __fastcall IsModified(bool AWithChildren = true);
	TLMDProjDocument* __fastcall FindParentDocument(void);
	void __fastcall Delete(void);
	__property TLMDProjectManager* ProjMgr = {read=FProjMgr};
	__property TLMDProjNode* Parent = {read=FParent, write=SetParent};
	__property Lmdtypes::TLMDString Ident = {read=GetIdent};
	__property Lmdtypes::TLMDString DisplayName = {read=DoGetDisplayName};
	__property int NodeCount = {read=GetNodeCount, nodefault};
	__property TLMDProjNode* Nodes[int AIndex] = {read=GetNodes};
	__property int DocumentCount = {read=GetDocumentCount, nodefault};
	__property TLMDProjDocument* Documents[int AIndex] = {read=GetDocuments};
	__property void * Data = {read=FData, write=FData};
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdideprojmgr__3 : unsigned char { dsLoading, dsSaving, dsChangeName, dsOpening };

typedef System::Set<Lmdideprojmgr__3, Lmdideprojmgr__3::dsLoading, Lmdideprojmgr__3::dsOpening> TLMDProjDocumentState;

enum DECLSPEC_DENUM TLMDProjDocumentSaveQueryRes : unsigned char { sqrYes, sqrNo, sqrCancel };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProjDocument : public TLMDProjNode
{
	typedef TLMDProjNode inherited;
	
private:
	TLMDProjDocumentState FDocumentState;
	Lmdtypes::TLMDString FFilePath;
	Lmdtypes::TLMDString FNewFilePath;
	bool FIsNew;
	TLMDOpenedDocument* FOpenedDocument;
	bool __fastcall SaveOpenedFile(const Lmdtypes::TLMDString AFileIdent, const Lmdtypes::TLMDString AFilePath);
	Lmdtypes::TLMDString __fastcall MakeUniqueFileName(const Lmdtypes::TLMDString ABaseName);
	bool __fastcall GetDiscardable(void);
	bool __fastcall GetNeedSave(void);
	bool __fastcall GetOpened(void);
	Lmdtypes::TLMDString __fastcall GetFilePath(void);
	void __fastcall InternalSetFilePath(const Lmdtypes::TLMDString AValue);
	
protected:
	void __fastcall Load(const Lmdtypes::TLMDString AFilePath);
	void __fastcall Save(bool AChangeName = false);
	void __fastcall SaveAssociatedFile(const Lmdtypes::TLMDString AFileIdent, const Lmdtypes::TLMDString AFilePath, const Lmdtypes::TLMDString AOldFilePath);
	Lmdtypes::TLMDString __fastcall GetRelativeFilePath(void);
	Lmdtypes::TLMDString __fastcall MakeFullFilePath(const Lmdtypes::TLMDString ARelFilePath);
	void __fastcall LoadFromXml(const Lmdtypes::TLMDString AFilePath);
	void __fastcall SaveToXml(const Lmdtypes::TLMDString AFilePath);
	virtual Lmdtypes::TLMDString __fastcall DoGetDisplayName(void);
	virtual void __fastcall DoLoad(const Lmdtypes::TLMDString AFilePath) = 0 ;
	virtual void __fastcall DoSave(const Lmdtypes::TLMDString AFilePath) = 0 ;
	virtual System::Classes::TStream* __fastcall DoOpenFileStream(const Lmdtypes::TLMDString AFileIdent);
	virtual Lmdtypes::TLMDString __fastcall DoGetDefaultBaseName(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall DoGetFileExt(void) = 0 ;
	
public:
	__fastcall virtual TLMDProjDocument(TLMDProjectManager* AProjMgr, TLMDProjNode* AParent);
	__fastcall virtual ~TLMDProjDocument(void);
	bool __fastcall Open(bool AShowEditor);
	System::Classes::TStream* __fastcall OpenFileStream(const Lmdtypes::TLMDString AFileIdent);
	void __fastcall Close(void);
	__property TLMDProjDocumentState DocumentState = {read=FDocumentState, nodefault};
	__property Lmdtypes::TLMDString FileExt = {read=DoGetFileExt};
	__property Lmdtypes::TLMDString FilePath = {read=GetFilePath};
	__property Lmdtypes::TLMDString NewFilePath = {read=FNewFilePath};
	__property bool IsNew = {read=FIsNew, nodefault};
	__property bool NeedSave = {read=GetNeedSave, nodefault};
	__property bool Discardable = {read=GetDiscardable, nodefault};
	__property bool Opened = {read=GetOpened, nodefault};
	__property TLMDOpenedDocument* OpenedDocument = {read=FOpenedDocument};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProjDocOpenContext : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDProjDocument* FDocument;
	
public:
	__fastcall TLMDProjDocOpenContext(TLMDProjDocument* ADocument);
	void __fastcall Open(TLMDOpenedDocument* AOpenedDocument);
	__property TLMDProjDocument* Document = {read=FDocument};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDProjDocOpenContext(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDProjMgrStreamKind : unsigned char { skRead, skWrite };

typedef void __fastcall (__closure *TLMDProjMgrOnCreateStream)(System::TObject* Sender, const Lmdtypes::TLMDString AFilePath, TLMDProjMgrStreamKind AStreamKind, System::Classes::TStream* &AStream);

typedef void __fastcall (__closure *TLMDProjMgrOnSaveQuery)(System::TObject* Sender, TLMDProjDocument* ADocument, TLMDProjDocumentSaveQueryRes &ASave);

typedef void __fastcall (__closure *TLMDProjMgrOnSaveAs)(System::TObject* Sender, TLMDProjDocument* ADocument, Lmdtypes::TLMDString &AFilePath, bool &ASave);

typedef void __fastcall (__closure *TLMDProjMgrOnOpen)(System::TObject* Sender, bool AShowEditor, TLMDProjDocOpenContext* AContext);

typedef void __fastcall (__closure *TLMDProjMgrOnAddition)(System::TObject* Sender, TLMDProjNode* ANode);

typedef void __fastcall (__closure *TLMDProjMgrOnDeletion)(System::TObject* Sender, TLMDProjNode* ANode);

typedef void __fastcall (__closure *TLMDProjMgrOnFilePathChanged)(System::TObject* Sender, TLMDProjDocument* ADocument);

class PASCALIMPLEMENTATION TLMDProjectManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDProjDocument* FRoot;
	System::Classes::TList* FViews;
	System::Classes::TList* FNodeClasses;
	TLMDProjMgrOnCreateStream FOnCreateStream;
	TLMDProjMgrOnSaveQuery FOnSaveQuery;
	TLMDProjMgrOnSaveAs FOnSaveAs;
	TLMDProjMgrOnOpen FOnOpen;
	TLMDDocEditorsView* FEditorsView;
	TLMDProjMgrOnAddition FOnAddition;
	TLMDProjMgrOnDeletion FOnDeletion;
	TLMDProjMgrOnFilePathChanged FOnFilePathChanged;
	TLMDProjNodeClass __fastcall FindNodeClass(const Lmdtypes::TLMDString AIdent);
	void __fastcall DissociateViews(void);
	void __fastcall UpdateViews(void);
	void __fastcall SetEditorsView(TLMDDocEditorsView* const Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual TLMDProjNodeClass __fastcall GetNodeClass(const Lmdtypes::TLMDString AIdent);
	virtual System::Classes::TStream* __fastcall DoCreateStream(const Lmdtypes::TLMDString AFilePath, TLMDProjMgrStreamKind AStreamKind);
	virtual TLMDProjDocumentSaveQueryRes __fastcall DoSaveQuery(TLMDProjDocument* ADocument);
	virtual bool __fastcall DoSaveAs(TLMDProjDocument* ADocument, Lmdtypes::TLMDString &AFilePath);
	virtual void __fastcall DoOpen(bool AShowEditor, TLMDProjDocOpenContext* AContext);
	virtual void __fastcall DoAddition(TLMDProjNode* ANode);
	virtual void __fastcall DoDeletion(TLMDProjNode* ANode);
	virtual void __fastcall DoFilePathChanged(TLMDProjDocument* ADocument);
	
public:
	__fastcall virtual TLMDProjectManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDProjectManager(void);
	void __fastcall Clear(void);
	void __fastcall Load(const Lmdtypes::TLMDString AFilePath, TLMDProjNodeClass ARootClass);
	bool __fastcall Save(bool AChangeName)/* overload */;
	bool __fastcall Save(TLMDProjDocument* ADocument, bool AChangeName)/* overload */;
	TLMDProjDocumentSaveQueryRes __fastcall SaveQuery(void)/* overload */;
	TLMDProjDocumentSaveQueryRes __fastcall SaveQuery(TLMDProjDocument* ADocument)/* overload */;
	TLMDProjNode* __fastcall New(TLMDProjNode* AParent, TLMDProjNodeClass ANodeClass);
	TLMDProjNode* __fastcall AddExisting(const Lmdtypes::TLMDString AFilePath, TLMDProjNode* AParent, TLMDProjNodeClass ANodeClass);
	System::Classes::TStream* __fastcall CreateStream(const Lmdtypes::TLMDString AFilePath, TLMDProjMgrStreamKind AStreamKind);
	void __fastcall RegisterNodeClass(TLMDProjNodeClass AClass);
	void __fastcall UnregisterNodeClass(TLMDProjNodeClass AClass);
	__property TLMDProjDocument* Root = {read=FRoot};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDocEditorsView* EditorsView = {read=FEditorsView, write=SetEditorsView};
	__property TLMDProjMgrOnCreateStream OnCreateStream = {read=FOnCreateStream, write=FOnCreateStream};
	__property TLMDProjMgrOnSaveQuery OnSaveQuery = {read=FOnSaveQuery, write=FOnSaveQuery};
	__property TLMDProjMgrOnSaveAs OnSaveAs = {read=FOnSaveAs, write=FOnSaveAs};
	__property TLMDProjMgrOnOpen OnOpen = {read=FOnOpen, write=FOnOpen};
	__property TLMDProjMgrOnAddition OnAddition = {read=FOnAddition, write=FOnAddition};
	__property TLMDProjMgrOnDeletion OnDeletion = {read=FOnDeletion, write=FOnDeletion};
	__property TLMDProjMgrOnFilePathChanged OnFilePathChanged = {read=FOnFilePathChanged, write=FOnFilePathChanged};
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


typedef void __fastcall (__closure *TLMDOpenedDocumentBeforeSave)(System::TObject* Sender, const Lmdtypes::TLMDString AFilePath, bool &ACancel);

typedef void __fastcall (__closure *TLMDOpenedDocumentOnSave)(System::TObject* Sender, const Lmdtypes::TLMDString AFilePath);

typedef void __fastcall (__closure *TLMDOpenedDocumentOnSaveFile)(System::TObject* Sender, const Lmdtypes::TLMDString AFileIdent, System::Classes::TStream* AFileStream, bool &AHandled);

typedef void __fastcall (__closure *TLMDOpenedDocumentOnOpening)(System::TObject* Sender, TLMDProjDocument* ADocument);

class PASCALIMPLEMENTATION TLMDOpenedDocument : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDProjDocument* FNode;
	bool FEditorVisible;
	TLMDOpenedDocumentBeforeSave FOnBeforeSave;
	TLMDOpenedDocumentOnSave FOnAfterSave;
	TLMDOpenedDocumentOnSaveFile FOnSaveFile;
	System::Classes::TNotifyEvent FOnClose;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	TLMDOpenedDocumentOnOpening FOnOpening;
	void __fastcall AssociateNode(TLMDProjDocument* AValue);
	bool __fastcall GetOpened(void);
	void __fastcall SetEditorVisible(const bool Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual bool __fastcall DoBeforeSave(const Lmdtypes::TLMDString AFilePath);
	virtual void __fastcall DoAfterSave(const Lmdtypes::TLMDString AFilePath);
	virtual bool __fastcall DoSaveFile(const Lmdtypes::TLMDString AFileIdent, System::Classes::TStream* AFileStream);
	virtual void __fastcall DoClose(void);
	virtual void __fastcall DoShow(void);
	virtual void __fastcall DoHide(void);
	virtual void __fastcall DoOpening(TLMDProjDocument* ADocument);
	
public:
	__fastcall virtual TLMDOpenedDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDOpenedDocument(void);
	void __fastcall MarkClosed(void);
	__property TLMDProjDocument* Node = {read=FNode};
	__property bool Opened = {read=GetOpened, nodefault};
	__property bool EditorVisible = {read=FEditorVisible, write=SetEditorVisible, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDOpenedDocumentBeforeSave OnBeforeSave = {read=FOnBeforeSave, write=FOnBeforeSave};
	__property TLMDOpenedDocumentOnSave OnAfterSave = {read=FOnAfterSave, write=FOnAfterSave};
	__property TLMDOpenedDocumentOnSaveFile OnSaveFile = {read=FOnSaveFile, write=FOnSaveFile};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property TLMDOpenedDocumentOnOpening OnOpening = {read=FOnOpening, write=FOnOpening};
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


class PASCALIMPLEMENTATION TLMDProjectManagerView : public Vcl::Comctrls::TCustomTreeView
{
	typedef Vcl::Comctrls::TCustomTreeView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDProjectManager* FProjectManager;
	int FUpdateCount;
	bool FDblClicking;
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall SetProjectManager(TLMDProjectManager* const Value);
	void __fastcall UpdateView(void);
	TLMDProjDocument* __fastcall GetSelectedDoc(void);
	HIDESBASE TLMDProjNode* __fastcall GetSelected(void);
	void __fastcall DummyDrawHandler(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual Vcl::Comctrls::TTreeNode* __fastcall CreateNode(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC bool __fastcall CanCollapse(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanExpand(Vcl::Comctrls::TTreeNode* Node);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages);
	
public:
	__fastcall virtual TLMDProjectManagerView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDProjectManagerView(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	TLMDProjNode* __fastcall ConvertTreeNode(Vcl::Comctrls::TTreeNode* ATreeNode);
	__property TLMDProjNode* Selected = {read=GetSelected};
	__property TLMDProjDocument* SelectedDoc = {read=GetSelectedDoc};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDProjectManager* ProjectManager = {read=FProjectManager, write=SetProjectManager};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoExpand = {default=0};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property ChangeDelay = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Constraints;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=0};
	__property HotTrack = {default=0};
	__property Indent;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RightClickSelect = {default=0};
	__property RowSelect = {default=0};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnAddition;
	__property OnClick;
	__property OnCollapsed;
	__property OnCollapsing;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnHint;
	__property OnExpanding;
	__property OnExpanded;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDProjectManagerView(HWND ParentWindow) : Vcl::Comctrls::TCustomTreeView(ParentWindow) { }
	
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


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocEditorsViewItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDocEditorsViewEditors* FEditors;
	TLMDProjectManager* FProjManager;
	TLMDOpenedDocument* FOpenedDocument;
	Vcl::Forms::TCustomFrame* FFrame;
	TLMDProjDocument* __fastcall GetNode(void);
	
public:
	__fastcall TLMDDocEditorsViewItem(TLMDDocEditorsViewEditors* AEditors, TLMDProjectManager* AProjManager, TLMDOpenedDocument* AOpenedDocument, Vcl::Forms::TCustomFrame* AFrame);
	__fastcall virtual ~TLMDDocEditorsViewItem(void);
	void __fastcall Delete(void);
	void __fastcall Close(void);
	__property TLMDProjectManager* ProjManager = {read=FProjManager};
	__property TLMDOpenedDocument* OpenedDocument = {read=FOpenedDocument};
	__property TLMDProjDocument* Node = {read=GetNode};
	__property Vcl::Forms::TCustomFrame* Frame = {read=FFrame};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocEditorsViewEditors : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDDocEditorsViewItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDDocEditorsView* FView;
	System::Classes::TList* FItems;
	int __fastcall GetCount(void);
	TLMDDocEditorsViewItem* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDDocEditorsViewEditors(TLMDDocEditorsView* AView);
	__fastcall virtual ~TLMDDocEditorsViewEditors(void);
	void __fastcall DeleteAll(void);
	int __fastcall IndexOf(TLMDDocEditorsViewItem* AItem);
	TLMDDocEditorsViewItem* __fastcall Find(TLMDOpenedDocument* ADocument)/* overload */;
	TLMDDocEditorsViewItem* __fastcall Find(TLMDProjNode* ANode)/* overload */;
	__property int Count = {read=GetCount, nodefault};
	__property TLMDDocEditorsViewItem* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDDocEditorsViewOnCreateEditor)(System::TObject* Sender, TLMDProjDocument* ADocument, Vcl::Forms::TCustomFrame* &AEditor);

typedef void __fastcall (__closure *TLMDDocEditorsViewOnGetTabName)(System::TObject* Sender, TLMDDocEditorsViewItem* AEditor, Lmdtypes::TLMDString &AName);

class PASCALIMPLEMENTATION TLMDDocEditorsView : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	Vcl::Comctrls::TTabControl* FTabs;
	Vcl::Extctrls::TPanel* FClientPanel;
	int FTabHeight;
	TLMDDocEditorsViewEditors* FEditors;
	TLMDDocEditorsViewItem* FActiveEditor;
	bool FNeedUpdate;
	int FUpdateCount;
	TLMDDocEditorsViewOnCreateEditor FOnCreateEditor;
	TLMDDocEditorsViewOnGetTabName FOnGetTabName;
	System::Classes::TNotifyEvent FOnChange;
	bool __fastcall ContainsFocus(void);
	void __fastcall SetTabHeight(const int Value);
	void __fastcall ItemDestroying(TLMDDocEditorsViewItem* AItem);
	void __fastcall CreateEditor(bool AShowEditor, TLMDProjDocOpenContext* AContext);
	void __fastcall ShowEditor(TLMDOpenedDocument* ADocument);
	void __fastcall HideEditor(TLMDOpenedDocument* ADocument);
	void __fastcall FreeEditor(TLMDOpenedDocument* ADocument);
	void __fastcall FreeMgrEditors(TLMDProjectManager* AProjMgr);
	TLMDDocEditorsViewItem* __fastcall FindNearVisibleEditor(TLMDDocEditorsViewItem* AItem);
	void __fastcall TabChanged(void);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall Resize(void);
	virtual Vcl::Forms::TCustomFrame* __fastcall DoCreateEditor(TLMDProjDocument* ADocument);
	virtual Lmdtypes::TLMDString __fastcall DoGetTaName(TLMDDocEditorsViewItem* AEditor);
	virtual void __fastcall DoChange(void);
	void __fastcall UpdateView(void);
	
public:
	__fastcall virtual TLMDDocEditorsView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDocEditorsView(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property TLMDDocEditorsViewEditors* Editors = {read=FEditors};
	__property TLMDDocEditorsViewItem* ActiveEditor = {read=FActiveEditor};
	
__published:
	__property int TabHeight = {read=FTabHeight, write=SetTabHeight, default=18};
	__property TLMDDocEditorsViewOnCreateEditor OnCreateEditor = {read=FOnCreateEditor, write=FOnCreateEditor};
	__property TLMDDocEditorsViewOnGetTabName OnGetTabName = {read=FOnGetTabName, write=FOnGetTabName};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=1};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDocEditorsView(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdideprojmgr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEPROJMGR)
using namespace Lmdideprojmgr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideprojmgrHPP
