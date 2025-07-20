// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeDBTre.pas' rev: 34.00 (Windows)

#ifndef TeedbtreHPP
#define TeedbtreHPP

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
#include <System.Generics.Collections.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeTree.hpp>
#include <Data.DB.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teedbtre
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EDBTreeException;
struct TDBTreeFields;
class DELPHICLASS TDBLayout;
class DELPHICLASS TDBTreeLayout;
class DELPHICLASS TCustomDBTree;
class DELPHICLASS TDBTree;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EDBTreeException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EDBTreeException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EDBTreeException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EDBTreeException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EDBTreeException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EDBTreeException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EDBTreeException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EDBTreeException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EDBTreeException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDBTreeException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDBTreeException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDBTreeException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDBTreeException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EDBTreeException() { }
	
};

#pragma pack(pop)

typedef System::StaticArray<Data::Db::TField*, 20> TMaxDBTreeFields;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TDBTreeFields
{
public:
	int Count;
	TMaxDBTreeFields Field;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TDBLayoutDisplay : unsigned char { ldSingle, ldMultiLine, ldGrid };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDBLayout : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCodeField;
	Data::Db::TDataSet* FDataSet;
	TDBLayoutDisplay FDisplayMode;
	Teetree::TTreeNodeShape* FHeaderFormat;
	System::UnicodeString FParentField;
	Teetree::TTreeNodeShape* FFormat;
	System::UnicodeString FFields;
	Data::Db::TField* ICodeField;
	System::Generics::Collections::TList__1<Data::Db::TDataSet*>* IDetails;
	TDBTreeFields IFields;
	TDBTreeFields IParents;
	Teetree::TTreeNodeShape* __fastcall AddNode(Teetree::TTreeNodeShape* AParent);
	void __fastcall AddNodeText(Teetree::TTreeNodeShape* ANode, TDBTreeFields &AFields);
	Teetree::TTreeNodeShape* __fastcall AddText(Teetree::TTreeNodeShape* AChild);
	void __fastcall InitDetails();
	void __fastcall RunNextLayouts(Teetree::TTreeNodeShape* ADetailRoot);
	void __fastcall SetDataSet(Data::Db::TDataSet* const Value);
	void __fastcall SetFields(const System::UnicodeString Value);
	void __fastcall SetCodeField(const System::UnicodeString Value);
	void __fastcall SetParentField(const System::UnicodeString Value);
	void __fastcall SetFormat(Teetree::TTreeNodeShape* const Value);
	Teetree::TTreeNodeShape* __fastcall GetFormat();
	Teetree::TTreeNodeShape* __fastcall GetHeaderFormat();
	void __fastcall SetHeaderFormat(Teetree::TTreeNodeShape* const Value);
	void __fastcall ReadFormat(System::Classes::TStream* Reader);
	void __fastcall WriteFormat(System::Classes::TStream* Writer);
	void __fastcall ReadHeaderFormat(System::Classes::TStream* Reader);
	void __fastcall WriteHeaderFormat(System::Classes::TStream* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall FinishAddingText(Teetree::TTreeNodeShape* ANode);
	virtual void __fastcall Prepare();
	virtual void __fastcall Run(Teetree::TTreeNodeShape* ARoot);
	
public:
	__fastcall virtual ~TDBLayout();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TCustomDBTree* __fastcall Tree();
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property TDBLayoutDisplay DisplayMode = {read=FDisplayMode, write=FDisplayMode, default=0};
	__property Teetree::TTreeNodeShape* HeaderFormat = {read=GetHeaderFormat, write=SetHeaderFormat, stored=false};
	__property System::UnicodeString Fields = {read=FFields, write=SetFields};
	__property System::UnicodeString CodeField = {read=FCodeField, write=SetCodeField};
	__property System::UnicodeString ParentField = {read=FParentField, write=SetParentField};
	__property Teetree::TTreeNodeShape* Format = {read=GetFormat, write=SetFormat, stored=false};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TDBLayout(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDBTreeLayout : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TDBLayout* operator[](int Index) { return this->Node[Index]; }
	
private:
	TDBLayout* __fastcall Get(int Index);
	void __fastcall Put(int Index, TDBLayout* const Value);
	
public:
	HIDESBASE TDBLayout* __fastcall Add();
	__property TDBLayout* Node[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TDBTreeLayout(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBTreeLayout() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomDBTree : public Teetree::TCustomTree
{
	typedef Teetree::TCustomTree inherited;
	
private:
	TDBTreeLayout* FLayout;
	void __fastcall CreateDetail();
	void __fastcall CreateParentLayout();
	void __fastcall SetDataSet(Data::Db::TDataSet* const Value);
	void __fastcall SetDetail(Data::Db::TDataSet* const Value);
	void __fastcall CheckDataSet(Data::Db::TDataSet* &ADataSet, Data::Db::TDataSet* const Value);
	void __fastcall SetLayout(TDBTreeLayout* const Value);
	Data::Db::TDataSet* __fastcall GetDataSet();
	bool __fastcall GetMultiLineText();
	void __fastcall SetMultiLineText(const bool Value);
	System::UnicodeString __fastcall GetTextFields();
	void __fastcall SetTextFields(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetCodeField();
	Data::Db::TDataSet* __fastcall GetDetail();
	System::UnicodeString __fastcall GetDetailFields();
	System::UnicodeString __fastcall GetParentField();
	void __fastcall SetCodeField(const System::UnicodeString Value);
	void __fastcall SetDetailFields(const System::UnicodeString Value);
	void __fastcall SetParentField(const System::UnicodeString Value);
	bool __fastcall IsLayoutStored();
	
protected:
	int IPreviewRecords;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TCustomDBTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomDBTree();
	Teetree::TTreeNodeShape* __fastcall FindNodeCode(int ACode);
	HIDESBASE void __fastcall Refresh();
	__property TDBTreeLayout* Layout = {read=FLayout, write=SetLayout, stored=IsLayoutStored};
	__property System::UnicodeString CodeField = {read=GetCodeField, write=SetCodeField};
	__property Data::Db::TDataSet* DataSet = {read=GetDataSet, write=SetDataSet};
	__property Data::Db::TDataSet* Detail = {read=GetDetail, write=SetDetail};
	__property System::UnicodeString DetailFields = {read=GetDetailFields, write=SetDetailFields};
	__property bool MultiLineText = {read=GetMultiLineText, write=SetMultiLineText, default=0};
	__property System::UnicodeString ParentField = {read=GetParentField, write=SetParentField};
	__property System::UnicodeString TextFields = {read=GetTextFields, write=SetTextFields};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomDBTree(HWND ParentWindow) : Teetree::TCustomTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TDBTree : public TCustomDBTree
{
	typedef TCustomDBTree inherited;
	
public:
	__property DockManager;
	
__published:
	__property CodeField = {default=0};
	__property DataSet;
	__property Detail;
	__property DetailFields = {default=0};
	__property MultiLineText = {default=0};
	__property ParentField = {default=0};
	__property TextFields = {default=0};
	__property AllowDelete = {default=1};
	__property AllowPanning = {default=3};
	__property BackImage;
	__property BackImageMode = {default=0};
	__property BufferedDisplay = {default=1};
	__property CrossBox;
	__property Designing = {default=0};
	__property DragAndDrop;
	__property Gradient;
	__property Grid;
	__property HorzScrollBar;
	__property HotTrack;
	__property Images;
	__property Layout;
	__property Monochrome = {default=0};
	__property Page;
	__property PrintProportional = {default=1};
	__property ReadOnly = {default=0};
	__property ScrollMouseButton = {default=1};
	__property Selected;
	__property SingleSelection = {default=1};
	__property Shadow;
	__property ShowHintShapes = {default=1};
	__property ShowRootCross = {default=1};
	__property SnapToGrid = {default=1};
	__property TextEditor;
	__property VertScrollBar;
	__property View3DOptions;
	__property WheelNavigation = {default=0};
	__property Zoom;
	__property OnAddingConnection;
	__property OnAfterDraw;
	__property OnBeforeDraw;
	__property OnChanging;
	__property OnClickBackground;
	__property OnClickConnection;
	__property OnClickShape;
	__property OnDblClickConnection;
	__property OnDblClickShape;
	__property OnDeletingShapes;
	__property OnDeletedShapes;
	__property OnExpandingCollapsing;
	__property OnExpandedCollapsed;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMovingShape;
	__property OnMouseEnterShape;
	__property OnMouseLeaveShape;
	__property OnNewConnection;
	__property OnNewShape;
	__property OnResizingShape;
	__property OnSelectConnection;
	__property OnSelectShape;
	__property OnScroll;
	__property OnShowHint;
	__property OnStartEditing;
	__property OnStopEditing;
	__property OnUnSelectConnection;
	__property OnUnSelectShape;
	__property OnUndoZoom;
	__property OnZoom;
	__property Align = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=0};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=16777215};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property Locked = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragDropShape;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property OnCanResize;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
public:
	/* TCustomDBTree.Create */ inline __fastcall virtual TDBTree(System::Classes::TComponent* AOwner) : TCustomDBTree(AOwner) { }
	/* TCustomDBTree.Destroy */ inline __fastcall virtual ~TDBTree() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBTree(HWND ParentWindow) : TCustomDBTree(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxFields = System::Int8(0x14);
}	/* namespace Teedbtre */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEDBTRE)
using namespace Teedbtre;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeedbtreHPP
