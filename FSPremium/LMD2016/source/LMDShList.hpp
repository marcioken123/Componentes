// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShList.pas' rev: 31.00 (Windows)

#ifndef LmdshlistHPP
#define LmdshlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Classes.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.ActiveX.hpp>
#include <Winapi.ShlObj.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDShBase.hpp>
#include <LMDShView.hpp>
#include <LMDShFolder.hpp>
#include <LMDShMisc.hpp>
#include <LMDShPIDL.hpp>
#include <LMDShItem.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellListItem;
class DELPHICLASS TLMDShellListCustomColumn;
class DELPHICLASS TLMDShellListCustomColumns;
class DELPHICLASS TLMDShellList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellListOption : unsigned char { loShowHidden, loShowFolders, loShowNonFolders, loAllowRename, loAllowDrag, loAllowDrop, loColorCompressed, loExtendedMenu, loOpenFoldersInNewWindow, loShellMenu, loSortTypeByExt, loUseSuppressFolderNavigation };

typedef System::Set<TLMDShellListOption, TLMDShellListOption::loShowHidden, TLMDShellListOption::loUseSuppressFolderNavigation> TLMDShellListOptions;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellListItem : public Vcl::Comctrls::TListItem
{
	typedef Vcl::Comctrls::TListItem inherited;
	
private:
	int fIndex;
	Lmdshitem::TLMDShellItem* __fastcall GetShellItem(void);
	
public:
	__property Lmdshitem::TLMDShellItem* ShellItem = {read=GetShellItem};
public:
	/* TListItem.Create */ inline __fastcall virtual TLMDShellListItem(Vcl::Comctrls::TListItems* AOwner) : Vcl::Comctrls::TListItem(AOwner) { }
	/* TListItem.Destroy */ inline __fastcall virtual ~TLMDShellListItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellListCustomColumn : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdshbase::TLMDShellItemDetailsColumn FDataType;
	bool FAutoSize;
	int FTag;
	System::UnicodeString FCaption;
	System::Classes::TAlignment FAlignment;
	Vcl::Comctrls::TWidth FMinWidth;
	Vcl::Comctrls::TWidth FMaxWidth;
	Vcl::Comctrls::TWidth FWidth;
	int FImageIndex;
	bool FVisible;
	bool FDefaultColumn;
	int FColID;
	void __fastcall SetDataType(const Lmdshbase::TLMDShellItemDetailsColumn Value);
	bool __fastcall IsWidthStored(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetMaxWidth(const Vcl::Comctrls::TWidth Value);
	void __fastcall SetMinWidth(const Vcl::Comctrls::TWidth Value);
	void __fastcall SetWidth(const Vcl::Comctrls::TWidth Value);
	bool __fastcall IsCaptionStored(void);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetVisible(const bool value);
	void __fastcall SetDefaultColumn(const bool value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	void __fastcall DoChange(void);
	void __fastcall Store(const System::UnicodeString aPath);
	void __fastcall Restore(const System::UnicodeString aPath);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDShellListCustomColumn(System::Classes::TCollection* Collection);
	System::UnicodeString __fastcall GetText(Lmdshbase::TLMDCustomShellItem* aItem);
	void __fastcall SetDefaultWidth(void);
	__property int ColID = {read=FColID, write=FColID, nodefault};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property Lmdshbase::TLMDShellItemDetailsColumn DataType = {read=FDataType, write=SetDataType, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Comctrls::TWidth MaxWidth = {read=FMaxWidth, write=SetMaxWidth, default=0};
	__property Vcl::Comctrls::TWidth MinWidth = {read=FMinWidth, write=SetMinWidth, default=0};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Vcl::Comctrls::TWidth Width = {read=FWidth, write=SetWidth, stored=IsWidthStored, default=-1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property bool DefaultColumn = {read=FDefaultColumn, write=SetDefaultColumn, default=1};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDShellListCustomColumn(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellListCustomColumns : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDShellListCustomColumn* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FColumnChanged;
	int FLockUpdates;
	TLMDShellList* __fastcall GetListView(void);
	HIDESBASE TLMDShellListCustomColumn* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDShellListCustomColumn* const Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	void __fastcall SetColumnChanged(void);
	void __fastcall DoChange(void);
	void __fastcall Store(const System::UnicodeString aPath);
	void __fastcall Restore(const System::UnicodeString aPath);
	__property TLMDShellList* ListView = {read=GetListView};
	
public:
	__fastcall TLMDShellListCustomColumns(TLMDShellList* aOwner);
	__fastcall virtual ~TLMDShellListCustomColumns(void);
	HIDESBASE System::Classes::TPersistent* __fastcall Owner(void);
	void __fastcall BeginUpdates(void);
	void __fastcall EndUpdates(void);
	void __fastcall CreateDefaultColumns(void);
	__property TLMDShellListCustomColumn* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDShellList : public Lmdcontrol::TLMDBaseListView
{
	typedef Lmdcontrol::TLMDBaseListView inherited;
	
private:
	int FHighlightedHeaderItem;
	Lmdshfolder::TLMDShellFolder* FShellFolder;
	Lmdshbase::TLMDShellItems* FShellItems;
	Lmdshbase::TLMDShellItemsList* FItemsCache;
	System::Uitypes::TColor FCompressedColor;
	System::Classes::TStringList* FFileFilter;
	bool FFiltered;
	bool FFilterDirs;
	TLMDShellListOptions FOptions;
	bool FShowCheckBoxes;
	Lmdshmisc::TLMDShellSortDirection FSortDirection;
	Vcl::Comctrls::TViewStyle FViewStyle;
	TLMDShellListCustomColumns* FColumns;
	bool FStoreSettings;
	System::UnicodeString FRegistryPath;
	bool FDefaultColumns;
	void *FNewHeaderProc;
	void *FOldHeaderProc;
	Lmdshmisc::TLMDShellSortDirection FOldSortDirection;
	int FOldColumn;
	int FClickedColumn;
	Vcl::Controls::TImageList* FStateImages;
	HWND FHeaderHandle;
	int FHeaderID;
	Lmdshbase::TLMDShellEnumOptions FEnumOptions;
	System::Types::TPoint FClickPoint;
	_di_IDataObject FDataObject;
	System::UnicodeString FDropTargetItem;
	bool FFileSystemSort;
	Vcl::Menus::TPopupMenu* FPopup;
	Vcl::Graphics::TIcon* FTempIcon;
	bool FAutoContext;
	bool FAutoSortSupport;
	Lmdshfolder::TLMDShellInfoEvent FOnSelectionInfo;
	bool FShowOverlayIcon;
	Lmdshview::TLMDShellItemFilter FOnFilterItem;
	Lmdshview::TLMDShellItemEvent FOnItemDblClick;
	Lmdshview::TLMDShellItemEvent FOnItemSelected;
	_ITEMIDLIST *RootPid;
	_ITEMIDLIST *OldFolder;
	bool FSuppressDefaultAction;
	bool FSuppressFolderNavigation;
	Vcl::Extctrls::TTimer* FRefreshTimer;
	void __fastcall SetShellFolder(Lmdshfolder::TLMDShellFolder* const aValue);
	void __fastcall SetCompressedColor(const System::Uitypes::TColor aValue);
	System::UnicodeString __fastcall GetFileFilter(void);
	void __fastcall SetFileFilter(const System::UnicodeString aValue);
	void __fastcall SetFiltered(const bool aValue);
	void __fastcall SetFilterDirs(const bool aValue);
	void __fastcall SetOptions(const TLMDShellListOptions aValue);
	void __fastcall SetShowCheckBoxes(const bool aValue);
	void __fastcall SetSortDirection(const Lmdshmisc::TLMDShellSortDirection aValue);
	void __fastcall SetDefaultColumns(const bool aValue);
	int __fastcall GetCheckedCount(void);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetCheckedItem(int index);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetSelectedItems(int index);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetShellItem(Vcl::Comctrls::TListItem* Item);
	Lmdshbase::TLMDCustomShellItem* __fastcall GetSelectedItem(void);
	void __fastcall SetCustomColumns(TLMDShellListCustomColumns* const value);
	void __fastcall SetShowOverlayIcon(bool value);
	void __fastcall FilterShellItems(void);
	void __fastcall SortShellItems(void);
	void __fastcall RepaintEx(void);
	void __fastcall UpdateEx(void);
	void __fastcall ClearLists(void);
	void __fastcall EnumItems(void);
	void __fastcall DrawHeaderItem(const tagDRAWITEMSTRUCT &PDIS);
	void __fastcall DrawOverlayItem(Vcl::Comctrls::TCustomListView* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	MESSAGE void __fastcall LMDWMRefresh(Winapi::Messages::TMessage &Msg);
	void __fastcall NeedRefresh(void);
	void __fastcall SelectionChange(Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall UpdateSelectionInfo(void);
	void __fastcall ApplyFilter(void);
	void __fastcall RefreshTimerFire(System::TObject* Sender);
	void __fastcall FakeReadMethod(System::Classes::TReader* Reader);
	Lmdshpidl::TLMDShellPIDLS* __fastcall MakeSelectedList(bool IncludeParent = false);
	void __fastcall AdjustColumnWidth(void);
	HIDESBASE MESSAGE void __fastcall CNNotify(Winapi::Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMParentNotify(Winapi::Messages::TWMParentNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMNotify(Winapi::Messages::TWMNotify &Message);
	MESSAGE void __fastcall LMDWMAdjustColumns(Winapi::Messages::TMessage &Message);
	void __fastcall SetSuppressDefaultAction(const bool Value);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall OwnerDataStateChange(int StartIndex, int EndIndex, Vcl::Comctrls::TItemStates OldState, Vcl::Comctrls::TItemStates NewState);
	virtual void __fastcall DoFilterItem(Lmdshbase::TLMDCustomShellItem* const aItem, bool &aAccept);
	virtual void __fastcall SetViewStyle(Vcl::Comctrls::TViewStyle aValue);
	virtual Vcl::Comctrls::TListItem* __fastcall CreateListItem(void);
	DYNAMIC bool __fastcall CanEdit(Vcl::Comctrls::TListItem* Item);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall ColClick(Vcl::Comctrls::TListColumn* Column);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall Edit(const tagLVITEMW &Item);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TListItem* Item, int Change);
	HIDESBASE virtual void __fastcall HeaderWndProc(Winapi::Messages::TMessage &Message);
	virtual bool __fastcall OwnerDataFetch(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemRequest Request);
	virtual int __fastcall OwnerDataFind(Vcl::Comctrls::TItemFind Find, const System::UnicodeString FindString, const System::Types::TPoint &FindPosition, void * FindData, int StartIndex, Vcl::Comctrls::TSearchDirection Direction, bool Wrap);
	virtual bool __fastcall OwnerDataHint(int StartIndex, int EndIndex);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall IsCustomDrawn(Vcl::Comctrls::TCustomDrawTarget Target, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CanResize(int &NewWidth, int &NewHeight);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property Lmdshbase::TLMDShellItems* ShellItems = {read=FShellItems};
	HRESULT __stdcall ShellListDragEnter(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall ShellListDragOver(int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall ShellListDragLeave(void);
	HRESULT __stdcall ShellListDrop(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	__property Columns;
	
public:
	__fastcall virtual TLMDShellList(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellList(void);
	void __fastcall EnumColumns(void);
	void __fastcall Store(const System::UnicodeString aPath);
	void __fastcall Restore(const System::UnicodeString aPath);
	virtual void __fastcall Clear(void);
	void __fastcall RefreshData(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall BeginEnumeration(void);
	void __fastcall EndEnumeration(void);
	bool __fastcall TerminateEnumeration(void);
	HIDESBASE void __fastcall AddItem(Lmdshbase::TLMDCustomShellItem* aItem);
	void __fastcall ActiveFolderChanged(void);
	Lmdshbase::TLMDCustomShellController* __fastcall Controller(void);
	void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall SortColumn(Lmdshbase::TLMDShellItemDetailsColumn aColumn)/* overload */;
	void __fastcall SortColumn(Lmdshbase::TLMDShellItemDetailsColumn aColumn, Lmdshmisc::TLMDShellSortDirection aDirection)/* overload */;
	void __fastcall SortColumn(int aIndex = 0xffffffff)/* overload */;
	void __fastcall SortColumn(int aIndex, Lmdshmisc::TLMDShellSortDirection aDirection)/* overload */;
	bool __fastcall Editable(void);
	bool __fastcall CanCut(void);
	bool __fastcall CanCopy(void);
	bool __fastcall CanDelete(void);
	bool __fastcall CanPaste(void);
	bool __fastcall CanRename(void);
	bool __fastcall CanAccessItem(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall DeleteItems(void);
	void __fastcall CopyItems(const System::UnicodeString Target);
	void __fastcall MoveItems(const System::UnicodeString Target);
	bool __fastcall Rename(void);
	void __fastcall ShowProperties(void);
	void __fastcall CopyFileNameAsText(void);
	void __fastcall CopyPathAsText(void);
	bool __fastcall NewFolder(void);
	void __fastcall Open(void);
	void __fastcall OpenWith(void);
	void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled)/* overload */;
	bool __fastcall ExecuteCommand(const System::UnicodeString Verb)/* overload */;
	void __fastcall InvertSelection(void);
	void __fastcall CalculateSelectionInfo(int &Count, __int64 &Size);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Lmdshbase::TLMDCustomShellItem* CheckedItem[int index] = {read=GetCheckedItem};
	__property int CheckedCount = {read=GetCheckedCount, nodefault};
	__property Lmdshbase::TLMDCustomShellItem* SelectedItem = {read=GetSelectedItem};
	__property Lmdshbase::TLMDCustomShellItem* SelectedItems[int index] = {read=GetSelectedItems};
	__property Items;
	
__published:
	__property About = {default=0};
	__property System::UnicodeString FileFilter = {read=GetFileFilter, write=SetFileFilter};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property bool FilterDirs = {read=FFilterDirs, write=SetFilterDirs, default=0};
	__property Lmdshfolder::TLMDShellFolder* Folder = {read=FShellFolder, write=SetShellFolder};
	__property System::Uitypes::TColor CompressedColor = {read=FCompressedColor, write=SetCompressedColor, default=16711680};
	__property TLMDShellListOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property bool ShowCheckBoxes = {read=FShowCheckBoxes, write=SetShowCheckBoxes, nodefault};
	__property Lmdshmisc::TLMDShellSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, nodefault};
	__property Vcl::Comctrls::TViewStyle ViewStyle = {read=FViewStyle, write=SetViewStyle, nodefault};
	__property TLMDShellListCustomColumns* CustomColumns = {read=FColumns, write=SetCustomColumns};
	__property bool StoreSettings = {read=FStoreSettings, write=FStoreSettings, nodefault};
	__property System::UnicodeString RegistryPath = {read=FRegistryPath, write=FRegistryPath};
	__property bool DefaultColumns = {read=FDefaultColumns, write=SetDefaultColumns, nodefault};
	__property bool ShowOverlayIcon = {read=FShowOverlayIcon, write=SetShowOverlayIcon, default=1};
	__property bool AutoContextMenus = {read=FAutoContext, write=FAutoContext, nodefault};
	__property bool AutoSortSupport = {read=FAutoSortSupport, write=FAutoSortSupport, nodefault};
	__property Lmdshfolder::TLMDShellInfoEvent OnSelectionInfo = {read=FOnSelectionInfo, write=FOnSelectionInfo};
	__property bool SuppressDefaultAction = {read=FSuppressDefaultAction, write=SetSuppressDefaultAction, default=0};
	__property bool SuppressFolderNavigation = {read=FSuppressFolderNavigation, write=FSuppressFolderNavigation, default=0};
	__property Lmdshview::TLMDShellItemFilter OnFilterItem = {read=FOnFilterItem, write=FOnFilterItem};
	__property Lmdshview::TLMDShellItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property Lmdshview::TLMDShellItemEvent OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property Constraints;
	__property FlatScrollBars = {default=0};
	__property FullDrag = {default=0};
	__property HotTrackStyles = {default=0};
	__property ParentBiDiMode = {default=1};
	__property HoverTime = {default=-1};
	__property ShowWorkAreas = {default=0};
	__property AllocBy = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property GridLines = {default=0};
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property IconOptions;
	__property MultiSelect;
	__property ReadOnly;
	__property RowSelect = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowColumnHeaders = {default=1};
	__property ShowHint;
	__property SortType = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnColumnClick;
	__property OnDblClick;
	__property OnDeletion;
	__property OnEdited;
	__property OnEditing;
	__property OnEnter;
	__property OnExit;
	__property OnInsert;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnColumnRightClick;
	__property OnContextPopup;
	__property OnGetSubItemImage;
	__property OnInfoTip;
	__property OnEndDock;
	__property OnGetImageIndex;
	__property OnResize;
	__property OnSelectItem;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellList(HWND ParentWindow) : Lmdcontrol::TLMDBaseListView(ParentWindow) { }
	
private:
	void *__ILMDShellEdit;	// Lmdshview::ILMDShellEdit 
	void *__ILMDShellView;	// Lmdshview::ILMDShellView 
	void *__IDropTarget;	// IDropTarget 
	
public:
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
static const System::Word LMDWM_Refresh = System::Word(0x289e);
static const System::Word LMDWM_AdjustColumns = System::Word(0x289f);
}	/* namespace Lmdshlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHLIST)
using namespace Lmdshlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshlistHPP
