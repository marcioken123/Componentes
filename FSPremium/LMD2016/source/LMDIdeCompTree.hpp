// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeCompTree.pas' rev: 31.00 (Windows)

#ifndef LmdidecomptreeHPP
#define LmdidecomptreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgModule.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgDesigner.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidecomptree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSprig;
class DELPHICLASS TLMDComponentTree;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDSprigClass;

enum DECLSPEC_DENUM TLMDSprigImageKind : unsigned char { sikFake, sikFakeCollection, sikPersistent, sikCollection, sikComponent, sikControl, sikWinControl, sikContainer, sikForm };

typedef void __fastcall (__closure *TLMDGetSprigClassProc)(System::Classes::TPersistent* AInstance, TLMDSprigClass &ASprigClass);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSprig : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDSprig* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDComponentTree* FTree;
	TLMDSprig* FParent;
	Vcl::Comctrls::TTreeNode* FNode;
	System::Classes::TPersistent* FInstance;
	Lmdtypes::TLMDString FPropName;
	System::Classes::TList* FItems;
	void __fastcall SetNode(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall InsertItem(TLMDSprig* AItem);
	void __fastcall RemoveItem(TLMDSprig* AItem);
	void __fastcall ClearItems(void);
	int __fastcall GetCount(void);
	TLMDSprig* __fastcall GetItems(int AIndex);
	
protected:
	virtual void __fastcall CreateChildren(TLMDGetSprigClassProc AGetEditorClassProc);
	virtual void __fastcall ValidateParent(TLMDSprig* &AParent);
	virtual Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	virtual TLMDSprigImageKind __fastcall GetImageKind(void);
	
public:
	__fastcall virtual TLMDSprig(TLMDComponentTree* ATree, TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName);
	__fastcall virtual ~TLMDSprig(void);
	__property TLMDComponentTree* Tree = {read=FTree};
	__property Vcl::Comctrls::TTreeNode* Node = {read=FNode};
	__property TLMDSprig* Parent = {read=FParent};
	__property System::Classes::TPersistent* Instance = {read=FInstance};
	__property Lmdtypes::TLMDString PropName = {read=FPropName};
	__property Lmdtypes::TLMDString DisplayName = {read=GetDisplayName};
	__property TLMDSprigImageKind ImageKind = {read=GetImageKind, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDSprig* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdidecomptree__2 : unsigned char { ctmoAddCompEditorItems };

typedef System::Set<Lmdidecomptree__2, Lmdidecomptree__2::ctmoAddCompEditorItems, Lmdidecomptree__2::ctmoAddCompEditorItems> TLMDCompTreeMenuOptions;

enum DECLSPEC_DENUM Lmdidecomptree__3 : unsigned char { ctsoUseObjEditService };

typedef System::Set<Lmdidecomptree__3, Lmdidecomptree__3::ctsoUseObjEditService, Lmdidecomptree__3::ctsoUseObjEditService> TLMDCompTreeServiceOptions;

class PASCALIMPLEMENTATION TLMDComponentTree : public Vcl::Comctrls::TCustomTreeView
{
	typedef Vcl::Comctrls::TCustomTreeView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FSprigTypes;
	TLMDSprig* FRootSprig;
	Vcl::Controls::TWinControl* FRoot;
	System::Classes::TList* FAllSprigs;
	bool FDblClicking;
	int FUpdateCount;
	Lmddsgobjects::ILMDDsgObjsNotifier* FSelnNotifier;
	Lmddsgobjects::TLMDDesignObjects* FSelection;
	bool FUpdatingSeln;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	bool FUpdatingTreeNodes;
	Vcl::Menus::TPopupMenu* FTempMenu;
	TLMDCompTreeMenuOptions FMenuOptions;
	TLMDCompTreeServiceOptions FServiceOptions;
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall DummyDrawHandler(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	System::TObject* __fastcall FindSprigTypeItem(System::TClass AObjectClass);
	void __fastcall ClearSprigTypes(void);
	void __fastcall SetRoot(Vcl::Controls::TWinControl* const Value);
	void __fastcall SetSelection(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall CompsChangeNotification(System::TObject* Sender, System::Classes::TList* AChangedComps);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC bool __fastcall CanCollapse(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanExpand(Vcl::Comctrls::TTreeNode* Node);
	virtual Vcl::Comctrls::TTreeNode* __fastcall CreateNode(void);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TTreeNode* Node);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages);
	virtual void __fastcall GetSprigClass(System::Classes::TPersistent* AInstance, TLMDSprigClass &ASprigClass);
	void __fastcall RecreateSprigs(void);
	void __fastcall UpdateTreeNodes(void);
	void __fastcall UpdateSelection(void);
	
public:
	__fastcall virtual TLMDComponentTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDComponentTree(void);
	void __fastcall RegisterSprig(System::TClass AObjectClass, TLMDSprigClass ASprigClass);
	void __fastcall UnregisterSprig(System::TClass AObjectClass);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateSprigs(void);
	void __fastcall UpdateContent(void);
	TLMDSprig* __fastcall FindSprig(System::Classes::TPersistent* AInstance);
	TLMDSprig* __fastcall ConvertTreeNode(Vcl::Comctrls::TTreeNode* ATreeNode);
	__property TLMDSprig* RootSprig = {read=FRootSprig};
	__property Vcl::Controls::TWinControl* Root = {read=FRoot, write=SetRoot};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property TLMDCompTreeServiceOptions ServiceOptions = {read=FServiceOptions, write=FServiceOptions, default=1};
	__property Lmddsgobjects::TLMDDesignObjects* Selection = {read=FSelection, write=SetSelection};
	__property TLMDCompTreeMenuOptions MenuOptions = {read=FMenuOptions, write=FMenuOptions, default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDComponentTree(HWND ParentWindow) : Vcl::Comctrls::TCustomTreeView(ParentWindow) { }
	
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
}	/* namespace Lmdidecomptree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDECOMPTREE)
using namespace Lmdidecomptree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidecomptreeHPP
