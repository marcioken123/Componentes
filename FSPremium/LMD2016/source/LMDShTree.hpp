// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShTree.pas' rev: 31.00 (Windows)

#ifndef LmdshtreeHPP
#define LmdshtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <Winapi.ShellAPI.hpp>
#include <LMDShBase.hpp>
#include <LMDShView.hpp>
#include <LMDShFolder.hpp>
#include <LMDShMisc.hpp>
#include <LMDShItem.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellTreeNode;
class DELPHICLASS TLMDShellTree;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellTreeOption : unsigned char { toShowHidden, toShowFolders, toShowNonFolders, toAllowRename, toAllowDrag, toAllowDrop, toColorCompressed, toExpandTopNode, toExtendedMenu, toShellMenu };

typedef System::Set<TLMDShellTreeOption, TLMDShellTreeOption::toShowHidden, TLMDShellTreeOption::toShellMenu> TLMDShellTreeOptions;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellTreeNode : public Vcl::Comctrls::TTreeNode
{
	typedef Vcl::Comctrls::TTreeNode inherited;
	
private:
	Lmdshbase::TLMDCustomShellItem* FShellItem;
	void __fastcall SetShellItem(Lmdshbase::TLMDCustomShellItem* const aValue);
	
protected:
	void __fastcall SetHasChildren(void);
	
public:
	__fastcall virtual TLMDShellTreeNode(Vcl::Comctrls::TTreeNodes* AOwner);
	__fastcall virtual ~TLMDShellTreeNode(void);
	__property Lmdshbase::TLMDCustomShellItem* ShellItem = {read=FShellItem, write=SetShellItem};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDShellTree : public Lmdcontrol::TLMDBaseTreeView
{
	typedef Lmdcontrol::TLMDBaseTreeView inherited;
	
private:
	Lmdshfolder::TLMDShellFolder* FShellFolder;
	System::Uitypes::TColor FCompressedColor;
	System::Classes::TStringList* FFileFilter;
	bool FFiltered;
	TLMDShellTreeOptions FOptions;
	bool FShowCheckBoxes;
	Vcl::Controls::TImageList* FStateImages;
	Lmdshbase::TLMDShellItemsList* FItemsCache;
	Lmdshbase::TLMDShellItemsList* FCheckedItems;
	Lmdshbase::TLMDShellEnumOptions FEnumOptions;
	System::Types::TPoint FClickPoint;
	bool FChangeLocked;
	bool FActiveChangeLocked;
	_di_IDataObject FDataObject;
	bool FDragScroll;
	bool FDoingDragDrop;
	Vcl::Comctrls::TTreeNode* FDropTargetNode;
	Vcl::Comctrls::TTreeNode* FDragNode;
	bool FAutoContext;
	bool FAutoSortSupport;
	Lmdshfolder::TLMDShellInfoEvent FSelectionInfoEvent;
	Vcl::Extctrls::TTimer* FRefreshTimer;
	System::Classes::TList* FRefreshList;
	Lmdshview::TLMDShellItemFilter FOnFilterItem;
	Lmdshview::TLMDShellItemEvent FOnItemSelected;
	void __fastcall SetShellFolder(Lmdshfolder::TLMDShellFolder* const aValue);
	void __fastcall SetCompressedColor(const System::Uitypes::TColor aValue);
	System::UnicodeString __fastcall GetFileFilter(void);
	void __fastcall SetFileFilter(const System::UnicodeString aValue);
	void __fastcall SetFiltered(const bool aValue);
	void __fastcall SetOptions(const TLMDShellTreeOptions aValue);
	void __fastcall SetShowCheckBoxes(const bool aValue);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetSelectedItem(void);
	bool __fastcall GetShowNonFolder(void);
	void __fastcall SetShowNonFolder(const bool value);
	void __fastcall RepaintEx(void);
	void __fastcall ReloadTree(void);
	void __fastcall EnumItems(Winapi::Shlobj::PItemIDList aPIDL, Lmdshbase::TLMDShellItemsList* &aItems);
	void __fastcall DoAdvancedCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	void __fastcall AddToRefreshList(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall RefreshTimerFire(System::TObject* Sender);
	bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	void __fastcall FakeReadMethod(System::Classes::TReader* Reader);
	Vcl::Comctrls::TTreeNode* __fastcall ChangeTimerNode(void);
	HIDESBASE int __fastcall GetChangeDelay(void);
	HIDESBASE void __fastcall SetChangeDelay(int V);
	int __fastcall GetCheckedCount(void);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetCheckedItem(const int Index);
	void __fastcall HandlerCheckItem(System::TObject* Sender, bool Checked);
	
protected:
	virtual void __fastcall DoFilterItem(Lmdshbase::TLMDCustomShellItem* const aItem, bool &aAccept);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanExpand(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Collapse(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Edit(const tagTVITEMW &Item);
	DYNAMIC bool __fastcall CanEdit(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Click(void);
	virtual Vcl::Comctrls::TTreeNode* __fastcall CreateNode(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNNotify(Winapi::Messages::TWMNotify &Message);
	virtual void __fastcall DoCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall ToggleItemCheckbox(Vcl::Comctrls::TTreeNode* Node, bool AChecked);
	HRESULT __stdcall ShellTreeDragEnter(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall ShellTreeDragOver(int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall ShellTreeDragLeave(void);
	HRESULT __stdcall ShellTreeDrop(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	TLMDShellTreeNode* __fastcall FindNodeByShellItem(Lmdshitem::TLMDShellItem* AItem);
	
public:
	__fastcall virtual TLMDShellTree(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellTree(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall BeginEnumeration(void);
	void __fastcall EndEnumeration(void);
	bool __fastcall TerminateEnumeration(void);
	void __fastcall AddItem(Lmdshbase::TLMDCustomShellItem* aItem);
	void __fastcall ActiveFolderChanged(void);
	Lmdshbase::TLMDCustomShellController* __fastcall Controller(void);
	TLMDShellTreeNode* __fastcall FindNode(Winapi::Shlobj::PItemIDList PIDL, bool CanExpand);
	void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	bool __fastcall Editable(void);
	bool __fastcall CanCut(void);
	bool __fastcall CanCopy(void);
	bool __fastcall CanDelete(void);
	bool __fastcall CanPaste(void);
	bool __fastcall CanRename(void);
	bool __fastcall CanAccessItem(void);
	void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall CopyItems(const System::UnicodeString Target);
	void __fastcall MoveItems(const System::UnicodeString Target);
	void __fastcall DeleteItems(void);
	bool __fastcall Rename(void);
	void __fastcall ShowProperties(void);
	void __fastcall CopyFileNameAsText(void);
	void __fastcall CopyPathAsText(void);
	void __fastcall Open(void);
	void __fastcall OpenWith(void);
	void __fastcall MailTo(void);
	bool __fastcall NewFolder(void);
	void __fastcall RefreshBranches(Vcl::Comctrls::TTreeNode* const *aNodes, const int aNodes_High);
	void __fastcall RefreshBranch(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall ClearCheckboxes(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Lmdshbase::TLMDCustomShellItem* SelectedItem = {read=GetSelectedItem};
	__property int CheckedCount = {read=GetCheckedCount, nodefault};
	__property Lmdshbase::TLMDCustomShellItem* CheckedItems[const int Index] = {read=GetCheckedItem};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoExpand = {default=0};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property ChangeDelay = {read=GetChangeDelay, write=SetChangeDelay, default=500};
	__property Constraints;
	__property HotTrack = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ToolTips = {default=1};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property Indent;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowButtons = {default=1};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnCollapsed;
	__property OnCollapsing;
	__property OnDblClick;
	__property OnDeletion;
	__property OnEdited;
	__property OnEditing;
	__property OnEnter;
	__property OnExit;
	__property OnExpanding;
	__property OnExpanded;
	__property OnGetImageIndex;
	__property OnGetSelectedIndex;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property Lmdshfolder::TLMDShellFolder* Folder = {read=FShellFolder, write=SetShellFolder};
	__property System::Uitypes::TColor CompressedColor = {read=FCompressedColor, write=SetCompressedColor, nodefault};
	__property System::UnicodeString FileFilter = {read=GetFileFilter, write=SetFileFilter};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, nodefault};
	__property TLMDShellTreeOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property bool ShowCheckBoxes = {read=FShowCheckBoxes, write=SetShowCheckBoxes, nodefault};
	__property Lmdshview::TLMDShellItemFilter OnFilterItem = {read=FOnFilterItem, write=FOnFilterItem};
	__property Lmdshview::TLMDShellItemEvent OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property bool ShowNonFolders = {read=GetShowNonFolder, write=SetShowNonFolder, nodefault};
	__property bool AutoContextMenus = {read=FAutoContext, write=FAutoContext, nodefault};
	__property bool AutoSortSupport = {read=FAutoSortSupport, write=FAutoSortSupport, nodefault};
	__property Lmdshfolder::TLMDShellInfoEvent OnSelectionInfo = {read=FSelectionInfoEvent, write=FSelectionInfoEvent};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellTree(HWND ParentWindow) : Lmdcontrol::TLMDBaseTreeView(ParentWindow) { }
	
private:
	void *__IDropTarget;	// IDropTarget 
	void *__ILMDShellEdit;	// Lmdshview::ILMDShellEdit 
	void *__ILMDShellView;	// Lmdshview::ILMDShellView 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000122-0000-0000-C000-000000000046}
	operator _di_IDropTarget()
	{
		_di_IDropTarget intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDropTarget*(void) { return (IDropTarget*)&__IDropTarget; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CF5219D0-A7F6-494D-9329-D38F24217EEC}
	operator Lmdshview::_di_ILMDShellEdit()
	{
		Lmdshview::_di_ILMDShellEdit intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdshview::ILMDShellEdit*(void) { return (Lmdshview::ILMDShellEdit*)&__ILMDShellEdit; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {3E2D823C-8076-4FB1-8676-CE94E56ED34F}
	operator Lmdshview::_di_ILMDShellView()
	{
		Lmdshview::_di_ILMDShellView intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdshview::ILMDShellView*(void) { return (Lmdshview::ILMDShellView*)&__ILMDShellView; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDShellEdit; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHTREE)
using namespace Lmdshtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshtreeHPP
