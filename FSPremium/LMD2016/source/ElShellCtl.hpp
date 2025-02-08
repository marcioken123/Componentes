// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElShellCtl.pas' rev: 31.00 (Windows)

#ifndef ElshellctlHPP
#define ElshellctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ShellAPI.hpp>
#include <System.Masks.hpp>
#include <System.Win.ComObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <Vcl.Forms.hpp>
#include <LMDUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Variants.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <LMDSysIn.hpp>
#include <LMDTypes.hpp>
#include <ElACtrls.hpp>
#include <ElTreeStdEditors.hpp>
#include <ElShellUtils.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDProcs.hpp>
#include <LMDObjectList.hpp>
#include <ElHeader.hpp>
#include <ElCombos.hpp>
#include <ElTreeCombo.hpp>
#include <ElTree.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDGraphUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <ElScrollBar.hpp>
#include <ElImgFrm.hpp>
#include <ElIni.hpp>
#include <ElSBCtrl.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElDragDrop.hpp>
#include <ElInputProcessor.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elshellctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElShellError;
class DELPHICLASS TElShellTreeItem;
class DELPHICLASS TElShellTree;
class DELPHICLASS TElShellComboBox;
class DELPHICLASS TElShellListItem;
class DELPHICLASS TElShellList;
//-- type declarations -------------------------------------------------------
typedef unsigned TShellAttr;

enum DECLSPEC_DENUM TElPathType : unsigned char { ptFolderOrFile, ptFolder, ptFile };

enum DECLSPEC_DENUM TElShellSortType : unsigned char { sstCustom, sstName, sstDefault, sstSize, sstCreationDate, sstModifyDate, sstAccessDate, sstExt };

enum DECLSPEC_DENUM TElShellSortModifier : unsigned char { ssmFoldersFirst, ssmExecutablesFirst };

typedef System::Set<TElShellSortModifier, TElShellSortModifier::ssmFoldersFirst, TElShellSortModifier::ssmExecutablesFirst> TElShellSortModifiers;

enum DECLSPEC_DENUM TElShellSizeFormat : unsigned char { ssfAsIs, ssfKb, ssfAuto };

#pragma pack(push,4)
class PASCALIMPLEMENTATION EElShellError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElShellError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElShellError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElShellError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElShellError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElShellError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElShellError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElShellError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElShellError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElShellError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElShellError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElShellError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElShellError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElShellError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElShellTreeItem : public Eltree::TElTreeItem
{
	typedef Eltree::TElTreeItem inherited;
	
protected:
	bool FIsValidFile;
	bool FValid;
	Lmdtypes::TLMDString FAttrAsString;
	Lmdtypes::TLMDString FComment;
	Lmdtypes::TLMDString FSizeAsString;
	Lmdtypes::TLMDString FDisplayName;
	Lmdtypes::TLMDString FTypeName;
	Lmdtypes::TLMDString FFileName;
	unsigned FAttr;
	_ITEMIDLIST *FPIDL;
	_ITEMIDLIST *FFullPIDL;
	_WIN32_FIND_DATAW *Win32FindDataW;
	_WIN32_FIND_DATAW *Win32FindData;
	Lmdtypes::TLMDString FEditName;
	Lmdtypes::TLMDString FHint;
	void __fastcall GetAttributes(const _di_IShellFolder iParentFolder);
	Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetFullName(void);
	bool __fastcall GetHasSubFolders(void);
	bool __fastcall GetIsFolder(void);
	bool __fastcall GetIsRemovable(void);
	_di_IShellFolder __fastcall GetParentFolder(void);
	unsigned __fastcall GetSize(void);
	void __fastcall SetDisplayName(const Lmdtypes::TLMDString Value);
	System::TDateTime __fastcall GetCreationTime(void);
	System::TDateTime __fastcall GetModificationTime(void);
	System::TDateTime __fastcall GetLastAccessTime(void);
	void __fastcall GetWin32Data(const _di_IShellFolder ParentFolder);
	void __fastcall CheckWin32FindData(void);
	Lmdtypes::TLMDString __fastcall GetFileName(void);
	Lmdtypes::TLMDString __fastcall GetSizeAsString(void);
	Lmdtypes::TLMDString __fastcall GetTypeName(void);
	bool __fastcall GetIsFileObject(void);
	Lmdtypes::TLMDString __fastcall GetAttrAsString(void);
	Lmdtypes::TLMDString __fastcall GetComment(void);
	void __fastcall Invalidate(void);
	TElShellTreeItem* __fastcall FindItemByPIDL(Winapi::Shlobj::PItemIDList APIDL);
	bool __fastcall GetCanRename(void);
	Lmdtypes::TLMDString __fastcall GetHintText(const _di_IShellFolder ParentFolder);
	int __fastcall GetPicture(const _di_IShellFolder ParentFolder);
	Winapi::Shlobj::PItemIDList __fastcall GetFullPIDL(void);
	Lmdtypes::TLMDString __fastcall GetEditName(void);
	void __fastcall SetEditName(const Lmdtypes::TLMDString Value);
	void __fastcall ClearData(bool bRelease);
	
public:
	__fastcall virtual TElShellTreeItem(Eltree::TCustomElTree* AOwner);
	__fastcall virtual ~TElShellTreeItem(void);
	bool __fastcall IsExists(void);
	Winapi::Shlobj::PItemIDList __fastcall BuildFullPIDL(void);
	__property unsigned Attr = {read=FAttr, nodefault};
	__property Lmdtypes::TLMDString DisplayName = {read=GetDisplayName, write=SetDisplayName};
	__property Lmdtypes::TLMDString FullName = {read=GetFullName};
	__property bool HasSubFolders = {read=GetHasSubFolders, nodefault};
	__property bool IsFolder = {read=GetIsFolder, nodefault};
	__property bool IsRemovable = {read=GetIsRemovable, nodefault};
	__property _di_IShellFolder ParentFolder = {read=GetParentFolder};
	__property Winapi::Shlobj::PItemIDList PIDL = {read=FPIDL};
	__property Winapi::Shlobj::PItemIDList FullPIDL = {read=GetFullPIDL};
	__property System::TDateTime ModificationTime = {read=GetModificationTime};
	__property System::TDateTime CreationTime = {read=GetCreationTime};
	__property System::TDateTime LastAccessTime = {read=GetLastAccessTime};
	__property Lmdtypes::TLMDString FileName = {read=GetFileName};
	__property Lmdtypes::TLMDString SizeAsString = {read=GetSizeAsString};
	__property bool IsFileObject = {read=GetIsFileObject, nodefault};
	__property Lmdtypes::TLMDString Comment = {read=GetComment};
	__property bool CanRename = {read=GetCanRename, nodefault};
	__property Lmdtypes::TLMDString EditName = {read=GetEditName, write=SetEditName};
	__property bool IsValidFile = {read=FIsValidFile, nodefault};
	
__published:
	__property unsigned Size = {read=GetSize, nodefault};
	__property Lmdtypes::TLMDString TypeName = {read=GetTypeName};
	__property Lmdtypes::TLMDString AttrAsString = {read=GetAttrAsString};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TShellTreeItemAddingEvent)(System::TObject* Sender, Lmdtypes::TLMDString ItemName, _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, bool &Allowed);

typedef void __fastcall (__closure *TShellTreeItemAddedEvent)(System::TObject* Sender, Lmdtypes::TLMDString ItemName, _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, TElShellTreeItem* Item);

typedef void __fastcall (__closure *TInvokeVerbCommand)(System::TObject* Sender, Lmdtypes::TLMDString Verb, bool &Handled);

typedef void __fastcall (__closure *TAddColumnEvent)(System::TObject* Sender, int SectionIndex);

class PASCALIMPLEMENTATION TElShellTree : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
protected:
	Eltreestdeditors::TElTreeInplaceEdit* FEditor;
	Elshellutils::TShellFolders FRootFolder;
	_ITEMIDLIST *FRootPIDL;
	_ITEMIDLIST *FFocusedPIDL;
	_di_IShellFolder FIFolder;
	Lmdtypes::TLMDString FCustomRootFolder;
	bool FUseSystemMenus;
	bool FClearOnCollapse;
	bool FCheckForChildren;
	bool FShowHidden;
	bool FShowFiles;
	bool FHighlightCompressed;
	System::Classes::TStringList* FFileFilters;
	System::Classes::TList* FFileMasks;
	bool FFileFiltered;
	TShellTreeItemAddingEvent FOnFilterItem;
	TShellTreeItemAddedEvent FOnItemAdded;
	bool FFileSystemOnly;
	TElShellSortType FSortType;
	TElShellSortModifiers FSortModifiers;
	TElShellSizeFormat FSizeFormat;
	bool FDefaultColumns;
	bool FDefaultEditor;
	int FMaxColumns;
	bool FExpandRoot;
	TElShellList* FShellListView;
	TElShellComboBox* FShellComboBox;
	bool fIsSyncControls;
	bool FAutoNavigate;
	bool FAutoExecute;
	TInvokeVerbCommand fOnInvokeVerbCommand;
	System::Classes::TNotifyEvent fOnRootChanged;
	TAddColumnEvent fOnAddColumn;
	Winapi::Shlobj::PItemIDList __fastcall _GetFocusedPIDL(void);
	Winapi::Shlobj::PItemIDList __fastcall GetFocusedPIDL(void);
	Lmdtypes::TLMDString __fastcall GetFocusedDisplayName(void);
	void __fastcall BuildTree(void);
	void __fastcall ReleaseFocusedPIDL(void);
	virtual void __fastcall DoItemFocused(void);
	void __fastcall SetCustomRootFolder(const Lmdtypes::TLMDString Value);
	virtual Eltree::TElTreeView* __fastcall CreateView(void);
	virtual Eltree::TElTreeItems* __fastcall CreateItems(void);
	bool __fastcall CheckChildren(Eltree::TElTreeItem* Item, const _di_IShellFolder AFolder);
	bool __fastcall FillItemWithData(TElShellTreeItem* Item, const _di_IShellFolder AFolder, int Recursive);
	void __fastcall SetShowHidden(bool Value);
	void __fastcall SetShowFiles(bool Value);
	void __fastcall SetHighlightCompressed(bool Value);
	System::Classes::TStrings* __fastcall GetFileFilters(void);
	void __fastcall SetFileFiltered(const bool Value);
	void __fastcall SetFileFilters(System::Classes::TStrings* const Value);
	virtual bool __fastcall NameFiltered(const Lmdtypes::TLMDString S, const _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DoItemCollapse(Eltree::TElTreeItem* Item);
	virtual void __fastcall DoItemExpand(Eltree::TElTreeItem* Item);
	virtual void __fastcall DoItemExpanding(Eltree::TElTreeItem* Item, bool &CanProcess);
	Elshellutils::TShellFolders __fastcall GetRootFolder(void);
	void __fastcall SetRootFolder(Elshellutils::TShellFolders Value);
	virtual void __fastcall DoItemAdded(const Lmdtypes::TLMDString S, const _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, TElShellTreeItem* Item);
	void __fastcall SetFileSystemOnly(bool Value);
	TElShellTreeItem* __fastcall GetItemFocused(void);
	void __fastcall SetItemFocused(TElShellTreeItem* Value);
	virtual void __fastcall DoCompareItems(Eltree::TElTreeItem* Item1, Eltree::TElTreeItem* Item2, int &res);
	void __fastcall SetSortType(TElShellSortType Value);
	void __fastcall SetSortModifiers(TElShellSortModifiers Value);
	void __fastcall SetSizeFormat(TElShellSizeFormat Value);
	void __fastcall SetDefaultColumns(bool Value);
	void __fastcall AddDefaultColumns(void);
	int __fastcall DeleteDefaultColumns(void);
	virtual void __fastcall TriggerVirtualTextNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerVirtualValueNeeded(Eltree::TElTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);
	virtual void __fastcall TriggerSortBegin(void);
	virtual void __fastcall TriggerTryEditEvent(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);
	virtual void __fastcall TriggerInplaceEditorNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	void __fastcall FileFiltersChange(System::TObject* Sender);
	void __fastcall OnBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall OnValidateEdit(System::TObject* Sender, bool &InputValid);
	void __fastcall SetExpandRoot(bool Value);
	virtual void __fastcall TriggerVirtualHintNeeded(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString &Hint);
	virtual int __fastcall DoGetPicture(Eltree::TElTreeItem* Item);
	void __fastcall SetShellListView(TElShellList* Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SyncControls(System::TObject* Sender);
	void __fastcall SetShellComboBox(TElShellComboBox* Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall MouseLButtonDblClickExt(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall MouseLButtonDblClickItem(TElShellTreeItem* Item, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyPressTransfer(System::TObject* Sender, System::WideChar &Key);
	virtual void __fastcall Paint(void);
	
public:
	bool __fastcall SetRootPIDL(Winapi::Shlobj::PItemIDList PIDL);
	__fastcall virtual TElShellTree(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElShellTree(void);
	virtual void __fastcall Loaded(void);
	void __fastcall RefreshTree(Eltree::TElTreeItem* Item, int Recursive);
	TElShellTreeItem* __fastcall GetItemForPIDL(Winapi::Shlobj::PItemIDList PIDL);
	bool __fastcall SetSelectionPIDL(Winapi::Shlobj::PItemIDList PIDL);
	bool __fastcall IsSelectionPIDL(Winapi::Shlobj::PItemIDList PIDL);
	TElShellTreeItem* __fastcall GetItemForPath(const Lmdtypes::TLMDString Path, TElPathType PathType = (TElPathType)(0x0));
	bool __fastcall SetSelectionPath(const Lmdtypes::TLMDString Path, TElPathType PathType = (TElPathType)(0x0));
	Winapi::Shlobj::PItemIDList __fastcall BuildRootPIDL(void);
	__property Winapi::Shlobj::PItemIDList FocusedPIDL = {read=GetFocusedPIDL};
	__property Lmdtypes::TLMDString FocusedDisplayName = {read=GetFocusedDisplayName};
	__property TElShellTreeItem* ItemFocused = {read=GetItemFocused, write=SetItemFocused};
	__property Images;
	__property Images2;
	__property AlphaForImages;
	__property AlphaForImages2;
	__property _di_IShellFolder RootIShellFolder = {read=FIFolder};
	Winapi::Shlobj::PItemIDList __fastcall GetPIDLFromPath(const Lmdtypes::TLMDString Path, TElPathType PathType = (TElPathType)(0x0));
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SyncShellComboBox(TElShellComboBox* ShellComboBox);
	void __fastcall SyncShellTree(TElShellTree* ShellTree);
	void __fastcall SyncShellList(TElShellList* ShellList);
	__property Winapi::Shlobj::PItemIDList RootPIDL = {read=FRootPIDL};
	__property Items = {stored=false};
	
__published:
	__property bool AutoNavigate = {read=FAutoNavigate, write=FAutoNavigate, default=1};
	__property bool AutoExecute = {read=FAutoExecute, write=FAutoExecute, default=0};
	__property TInvokeVerbCommand OnInvokeVerbCommand = {read=fOnInvokeVerbCommand, write=fOnInvokeVerbCommand};
	__property TElShellList* ShellListView = {read=FShellListView, write=SetShellListView};
	__property TElShellComboBox* ShellComboBox = {read=FShellComboBox, write=SetShellComboBox};
	__property Elshellutils::TShellFolders RootFolder = {read=GetRootFolder, write=SetRootFolder, default=1};
	__property Lmdtypes::TLMDString CustomRootFolder = {read=FCustomRootFolder, write=SetCustomRootFolder};
	__property bool UseSystemMenus = {read=FUseSystemMenus, write=FUseSystemMenus, default=0};
	__property bool ClearOnCollapse = {read=FClearOnCollapse, write=FClearOnCollapse, default=1};
	__property bool CheckForChildren = {read=FCheckForChildren, write=FCheckForChildren, default=0};
	__property bool ShowHidden = {read=FShowHidden, write=SetShowHidden, default=1};
	__property bool ShowFiles = {read=FShowFiles, write=SetShowFiles, default=0};
	__property bool HighlightCompressed = {read=FHighlightCompressed, write=SetHighlightCompressed, default=1};
	__property bool FileFiltered = {read=FFileFiltered, write=SetFileFiltered, default=0};
	__property System::Classes::TStrings* FileFilters = {read=GetFileFilters, write=SetFileFilters};
	__property TShellTreeItemAddingEvent OnItemAdding = {read=FOnFilterItem, write=FOnFilterItem};
	__property TShellTreeItemAddedEvent OnItemAdded = {read=FOnItemAdded, write=FOnItemAdded};
	__property bool FileSystemOnly = {read=FFileSystemOnly, write=SetFileSystemOnly, default=0};
	__property TElShellSortType SortType = {read=FSortType, write=SetSortType, default=2};
	__property TElShellSortModifiers SortModifiers = {read=FSortModifiers, write=SetSortModifiers, default=3};
	__property TElShellSizeFormat SizeFormat = {read=FSizeFormat, write=SetSizeFormat, default=0};
	__property bool DefaultColumns = {read=FDefaultColumns, write=SetDefaultColumns, default=0};
	__property bool DefaultEditor = {read=FDefaultEditor, write=FDefaultEditor, default=1};
	__property bool ExpandRoot = {read=FExpandRoot, write=SetExpandRoot, default=0};
	__property System::Classes::TNotifyEvent OnRootChanged = {read=fOnRootChanged, write=fOnRootChanged};
	__property TAddColumnEvent OnAddColumn = {read=fOnAddColumn, write=fOnAddColumn};
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=1};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property DefaultSectionWidth = {default=120};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BorderSides = {default=15};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxFlat = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DblClickMode = {default=1};
	__property DoInplaceEdit = {default=1};
	__property DragAllowed = {default=0};
	__property DragCursor = {default=-12};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragImageMode = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=1};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=true};
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
	__property HorizontalLines = {default=0};
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property HintType = {default=2};
	__property HighlightAlphaLevel = {default=255};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property HeaderImageForm;
	__property ImageForm;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property IncrementalSearchScope = {default=0};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
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
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MouseFrameSelect = {default=1};
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
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
	__property SortUseCase = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property StickyHeaderSections = {default=0};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property Tracking = {default=1};
	__property TrackColor = {default=-16777203};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property VertDivLinesColor = {default=-16777201};
	__property VerticalLines = {default=0};
	__property VerticalLinesLong = {default=1};
	__property VertScrollBarStyles;
	__property UseSystemHintColors = {default=0};
	__property TextColor = {default=-16777208};
	__property BkColor = {default=-16777211};
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
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnTryEdit;
	__property OnInplaceEditorNeeded;
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
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnHeaderMouseDown;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered = {default=1};
	__property DragKind = {default=0};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property Enabled = {default=1};
	__property Hint;
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Visible = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
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
	__property OnResize;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElShellTree(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElShellTree(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElShellComboBox : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
protected:
	bool FNoRebuild;
	_ITEMIDLIST *FSelectionPIDL;
	bool FExplorerStyle;
	bool FShowHidden;
	bool FFileSystemOnly;
	int FDummyInt;
	Vcl::Stdctrls::TCustomEdit* FEditor;
	System::Uitypes::TCursor FCursor;
	Vcl::Stdctrls::TComboBoxStyle FStyle;
	TElShellList* FShellListView;
	TElShellTree* FShellTreeView;
	bool fIsSyncControls;
	bool FAutoCompletion;
	bool FReadOnly;
	void __fastcall SetExplorerStyle(bool Value);
	void __fastcall FillCombo(const _di_IShellFolder BaseFolder, Winapi::Shlobj::PItemIDList BasePIDL, int Level);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetShowHidden(bool Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual int __fastcall GetItemWidth(int Index);
	void __fastcall SetFileSystemOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Msg);
	MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Msg);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	Winapi::Shlobj::PItemIDList __fastcall GetSelection(void);
	void __fastcall ShowEdit(void);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMDeleteItem(Winapi::Messages::TWMDeleteItem &Message);
	void __fastcall AcceptEdit(void);
	void __fastcall CancelEdit(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMSetNewPath(Winapi::Messages::TMessage &Message);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor Value);
	void __fastcall FillItems(void);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TComboBoxStyle Value);
	virtual void __fastcall DestroyWnd(void);
	void __fastcall SyncControls(System::TObject* Sender);
	void __fastcall SetShellListView(TElShellList* Value);
	void __fastcall SetShellTreeView(TElShellTree* Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetAutoCompletion(bool Value);
	Lmdtypes::TLMDString __fastcall GetEditorText(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual ~TElShellComboBox(void);
	__fastcall virtual TElShellComboBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall CloseUp(bool AcceptValue);
	HIDESBASE void __fastcall SetSelection(Winapi::Shlobj::PItemIDList PIDL);
	bool __fastcall SetSelectionPIDL(Winapi::Shlobj::PItemIDList PIDL);
	__property Winapi::Shlobj::PItemIDList Selection = {read=GetSelection, write=SetSelection};
	void __fastcall SyncShellComboBox(TElShellComboBox* ShellComboBox);
	void __fastcall SyncShellTree(TElShellTree* ShellTree);
	void __fastcall SyncShellList(TElShellList* ShellList);
	bool __fastcall SetSelectionPath(Lmdtypes::TLMDString Path);
	__property Lmdtypes::TLMDString EditorText = {read=GetEditorText};
	
__published:
	__property Style = {default=4};
	__property int Items = {read=FDummyInt, nodefault};
	__property int ItemHeight = {read=FDummyInt, nodefault};
	__property bool ExplorerStyle = {read=FExplorerStyle, write=SetExplorerStyle, default=1};
	__property bool ShowHidden = {read=FShowHidden, write=SetShowHidden, default=1};
	__property bool FileSystemOnly = {read=FFileSystemOnly, write=SetFileSystemOnly, default=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property TElShellList* ShellListView = {read=FShellListView, write=SetShellListView};
	__property TElShellTree* ShellTreeView = {read=FShellTreeView, write=SetShellTreeView};
	__property bool AutoCompletion = {read=FAutoCompletion, write=SetAutoCompletion, default=0};
	__property ButtonArrowColor = {default=-16777198};
	__property CanDrop = {default=1};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=-1};
	__property ListTransparentSelection = {default=0};
	__property ListColor = {default=-16777211};
	__property ListImageForm;
	__property ListInvertSelection = {default=0};
	__property UseBackground = {default=0};
	__property OnDropDown;
	__property AdjustDropDownPos = {default=1};
	__property ShowLineHint = {default=0};
	__property OnMeasureItem;
	__property ShowGripper = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property RightAlignedView = {default=0};
	__property OnSelect;
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property BorderSides = {default=15};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property ImageForm;
	__property IncrementalSearchTimeout = {default=500};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property OnKeyPressEx;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Text;
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property Alignment = {default=0};
	__property AutoSelect = {default=1};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonOldStyled = {default=0};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonShowBorder = {default=1};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIsSwitch = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonOldStyled = {default=0};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShowBorder = {default=1};
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property OnAltButtonClick;
	__property BorderStyle = {default=1};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElShellComboBox(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElShellListItem : public Eltree::TElTreeItem
{
	typedef Eltree::TElTreeItem inherited;
	
private:
	bool FIsValidFile;
	bool FValid;
	
protected:
	unsigned FAttr;
	Lmdtypes::TLMDString FAttrAsString;
	Lmdtypes::TLMDString FComment;
	Lmdtypes::TLMDString FDisplayName;
	Lmdtypes::TLMDString FFileName;
	_ITEMIDLIST *FPIDL;
	Lmdtypes::TLMDString FSizeAsString;
	Lmdtypes::TLMDString FTypeName;
	_WIN32_FIND_DATAW *Win32FindData;
	_WIN32_FIND_DATAW *Win32FindDataW;
	Lmdtypes::TLMDString FEditName;
	Lmdtypes::TLMDString FHint;
	Lmdtypes::TLMDString __fastcall GetAttrAsString(void);
	bool __fastcall GetCanRename(void);
	Lmdtypes::TLMDString __fastcall GetComment(void);
	System::TDateTime __fastcall GetCreationTime(void);
	Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	Lmdtypes::TLMDString __fastcall GetFileName(void);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetFullName(void);
	bool __fastcall GetIsFileObject(void);
	bool __fastcall GetIsFolder(void);
	bool __fastcall GetIsRemovable(void);
	System::TDateTime __fastcall GetLastAccessTime(void);
	System::TDateTime __fastcall GetModificationTime(void);
	unsigned __fastcall GetSize(void);
	Lmdtypes::TLMDString __fastcall GetSizeAsString(void);
	Lmdtypes::TLMDString __fastcall GetTypeName(void);
	void __fastcall SetDisplayName(const Lmdtypes::TLMDString Value);
	void __fastcall CheckWin32FindData(void);
	void __fastcall GetWin32Data(const _di_IShellFolder ParentFolder);
	void __fastcall Invalidate(void);
	void __fastcall GetAttributes(const _di_IShellFolder iParentFolder);
	Lmdtypes::TLMDString __fastcall GetHintText(const _di_IShellFolder ParentFolder);
	int __fastcall GetPicture(const _di_IShellFolder ParentFolder);
	Lmdtypes::TLMDString __fastcall GetEditName(void);
	void __fastcall SetEditName(const Lmdtypes::TLMDString Value);
	void __fastcall ClearData(bool bRelease);
	
public:
	__fastcall virtual TElShellListItem(Eltree::TCustomElTree* AOwner);
	__fastcall virtual ~TElShellListItem(void);
	Winapi::Shlobj::PItemIDList __fastcall BuildFullPIDL(void);
	bool __fastcall IsExists(void);
	__property unsigned Attr = {read=FAttr, nodefault};
	__property bool CanRename = {read=GetCanRename, nodefault};
	__property Lmdtypes::TLMDString Comment = {read=GetComment};
	__property System::TDateTime CreationTime = {read=GetCreationTime};
	__property Lmdtypes::TLMDString DisplayName = {read=GetDisplayName, write=SetDisplayName};
	__property Lmdtypes::TLMDString FileName = {read=GetFileName};
	__property Lmdtypes::TLMDString FullName = {read=GetFullName};
	__property bool IsFileObject = {read=GetIsFileObject, nodefault};
	__property bool IsFolder = {read=GetIsFolder, nodefault};
	__property bool IsRemovable = {read=GetIsRemovable, nodefault};
	__property System::TDateTime LastAccessTime = {read=GetLastAccessTime};
	__property System::TDateTime ModificationTime = {read=GetModificationTime};
	__property Winapi::Shlobj::PItemIDList PIDL = {read=FPIDL};
	__property Lmdtypes::TLMDString SizeAsString = {read=GetSizeAsString};
	__property Lmdtypes::TLMDString EditName = {read=GetEditName, write=SetEditName};
	
__published:
	__property Lmdtypes::TLMDString AttrAsString = {read=GetAttrAsString};
	__property unsigned Size = {read=GetSize, nodefault};
	__property Lmdtypes::TLMDString TypeName = {read=GetTypeName};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TShellListItemAddingEvent)(System::TObject* Sender, Lmdtypes::TLMDString ItemName, _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, bool &Allowed);

typedef void __fastcall (__closure *TShellListItemAddedEvent)(System::TObject* Sender, Lmdtypes::TLMDString ItemName, _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, TElShellListItem* Item);

class PASCALIMPLEMENTATION TElShellList : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
private:
	unsigned FAttr;
	bool FAutoNavigate;
	bool FAutoExecute;
	
protected:
	Eltreestdeditors::TElTreeInplaceEdit* FEditor;
	Lmdtypes::TLMDString FCustomFolder;
	bool FDefaultColumns;
	_ITEMIDLIST *FFocusedPIDL;
	bool FHighlightCompressed;
	Elshellutils::TShellFolders FFolder;
	bool FShowHidden;
	bool FShowFolders;
	TElShellSizeFormat FSizeFormat;
	TElShellSortModifiers FSortModifiers;
	TElShellSortType FSortType;
	bool FUseSystemMenus;
	_di_IShellFolder FIFolder;
	int FMaxColumns;
	bool FFileSystemOnly;
	System::Classes::TStringList* FFileFilters;
	bool FShowFiles;
	System::Classes::TList* FFileMasks;
	bool FFileFiltered;
	TShellListItemAddingEvent FOnFilterItem;
	TShellListItemAddedEvent FOnItemAdded;
	bool FDefaultEditor;
	_ITEMIDLIST *FRootPIDL;
	bool FSaveShowColumns;
	TElShellTree* FShellTreeView;
	TElShellComboBox* FShellComboBox;
	bool fIsSyncControls;
	TInvokeVerbCommand fOnInvokeVerbCommand;
	System::Classes::TNotifyEvent fOnRootChanged;
	TAddColumnEvent fOnAddColumn;
	void __fastcall SetCustomFolder(const Lmdtypes::TLMDString Value);
	virtual void __fastcall SetShowHeader(bool value);
	void __fastcall SetDefaultColumns(bool Value);
	Lmdtypes::TLMDString __fastcall GetFocusedDisplayName(void);
	Winapi::Shlobj::PItemIDList __fastcall GetFocusedPIDL(void);
	TElShellListItem* __fastcall GetItemFocused(void);
	void __fastcall SetHighlightCompressed(bool Value);
	void __fastcall SetItemFocused(TElShellListItem* const Value);
	void __fastcall SetFolder(Elshellutils::TShellFolders Value);
	void __fastcall SetShowFiles(bool Value);
	void __fastcall SetShowFolders(const bool Value);
	void __fastcall SetShowHidden(bool Value);
	void __fastcall SetSizeFormat(TElShellSizeFormat Value);
	void __fastcall SetSortModifiers(TElShellSortModifiers Value);
	void __fastcall SetSortType(TElShellSortType Value);
	void __fastcall SetPIDL(Winapi::Shlobj::PItemIDList PIDL);
	void __fastcall AddDefaultColumns(void);
	int __fastcall DeleteDefaultColumns(void);
	virtual void __fastcall TriggerSortBegin(void);
	virtual void __fastcall TriggerTryEditEvent(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType &CellType, bool &CanEdit);
	virtual void __fastcall TriggerVirtualTextNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	virtual void __fastcall TriggerVirtualValueNeeded(Eltree::TElTreeItem* Item, int SectionIndex, int VarType, System::Variant &Value);
	void __fastcall SetFileSystemOnly(bool Value);
	TElShellListItem* __fastcall FindItemByPIDL(Winapi::Shlobj::PItemIDList APIDL);
	virtual bool __fastcall NameFiltered(const Lmdtypes::TLMDString S, const _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL);
	System::Classes::TStrings* __fastcall GetFileFilters(void);
	void __fastcall SetFileFiltered(const bool Value);
	void __fastcall SetFileFilters(System::Classes::TStrings* const Value);
	void __fastcall FileFiltersChange(System::TObject* Sender);
	virtual void __fastcall CreateHandle(void);
	virtual Eltree::TElTreeItems* __fastcall CreateItems(void);
	virtual Eltree::TElTreeView* __fastcall CreateView(void);
	virtual void __fastcall DoCompareItems(Eltree::TElTreeItem* Item1, Eltree::TElTreeItem* Item2, int &res);
	virtual void __fastcall TriggerVirtualHintNeeded(Eltree::TElTreeItem* Item, Lmdtypes::TLMDString &Hint);
	virtual int __fastcall DoGetPicture(Eltree::TElTreeItem* Item);
	virtual void __fastcall DoItemAdded(const Lmdtypes::TLMDString S, const _di_IShellFolder ShellFolder, Winapi::Shlobj::PItemIDList RelPIDL, TElShellListItem* Item);
	void __fastcall SetShellTreeView(TElShellTree* Value);
	void __fastcall SetShellComboBox(TElShellComboBox* Value);
	void __fastcall SyncControls(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OnBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall OnValidateEdit(System::TObject* Sender, bool &InputValid);
	virtual void __fastcall TriggerInplaceEditorNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	__property Items = {stored=false};
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall MouseLButtonDblClickExt(int X, int Y, System::Classes::TShiftState Shift);
	void __fastcall MouseLButtonDblClickItem(TElShellListItem* Item, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyPressTransfer(System::TObject* Sender, System::WideChar &Key);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Message);
	
public:
	__fastcall virtual TElShellList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElShellList(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall RefreshList(bool bReload);
	bool __fastcall SetRootPIDL(Winapi::Shlobj::PItemIDList PIDL);
	bool __fastcall SetSelectionPIDL(Winapi::Shlobj::PItemIDList PIDL);
	Winapi::Shlobj::PItemIDList __fastcall BuildRootPIDL(void);
	void __fastcall BackToParentPIDL(void);
	void __fastcall SyncShellComboBox(TElShellComboBox* ShellComboBox);
	void __fastcall SyncShellTree(TElShellTree* ShellTree);
	void __fastcall SyncShellList(TElShellList* ShellList);
	__property Lmdtypes::TLMDString FocusedDisplayName = {read=GetFocusedDisplayName};
	__property Winapi::Shlobj::PItemIDList FocusedPIDL = {read=GetFocusedPIDL};
	__property TElShellListItem* ItemFocused = {read=GetItemFocused, write=SetItemFocused};
	__property Winapi::Shlobj::PItemIDList RootPIDL = {read=FRootPIDL};
	
__published:
	__property bool AutoNavigate = {read=FAutoNavigate, write=FAutoNavigate, default=1};
	__property bool AutoExecute = {read=FAutoExecute, write=FAutoExecute, default=0};
	__property TInvokeVerbCommand OnInvokeVerbCommand = {read=fOnInvokeVerbCommand, write=fOnInvokeVerbCommand};
	__property TElShellTree* ShellTreeView = {read=FShellTreeView, write=SetShellTreeView};
	__property TElShellComboBox* ShellComboBox = {read=FShellComboBox, write=SetShellComboBox};
	__property Lmdtypes::TLMDString CustomFolder = {read=FCustomFolder, write=SetCustomFolder};
	__property bool DefaultColumns = {read=FDefaultColumns, write=SetDefaultColumns, default=0};
	__property bool HighlightCompressed = {read=FHighlightCompressed, write=SetHighlightCompressed, default=1};
	__property Elshellutils::TShellFolders Folder = {read=FFolder, write=SetFolder, default=1};
	__property bool ShowHidden = {read=FShowHidden, write=SetShowHidden, default=1};
	__property TElShellSizeFormat SizeFormat = {read=FSizeFormat, write=SetSizeFormat, default=0};
	__property TElShellSortModifiers SortModifiers = {read=FSortModifiers, write=SetSortModifiers, default=3};
	__property TElShellSortType SortType = {read=FSortType, write=SetSortType, default=2};
	__property bool UseSystemMenus = {read=FUseSystemMenus, write=FUseSystemMenus, default=0};
	__property bool ShowFiles = {read=FShowFiles, write=SetShowFiles, default=1};
	__property bool ShowFolders = {read=FShowFolders, write=SetShowFolders, default=1};
	__property bool FileSystemOnly = {read=FFileSystemOnly, write=SetFileSystemOnly, default=0};
	__property bool FileFiltered = {read=FFileFiltered, write=SetFileFiltered, default=0};
	__property System::Classes::TStrings* FileFilters = {read=GetFileFilters, write=SetFileFilters};
	__property TShellListItemAddedEvent OnItemAdded = {read=FOnItemAdded, write=FOnItemAdded};
	__property TShellListItemAddingEvent OnItemAdding = {read=FOnFilterItem, write=FOnFilterItem};
	__property bool DefaultEditor = {read=FDefaultEditor, write=FDefaultEditor, default=1};
	__property System::Classes::TNotifyEvent OnRootChanged = {read=fOnRootChanged, write=fOnRootChanged};
	__property TAddColumnEvent OnAddColumn = {read=fOnAddColumn, write=fOnAddColumn};
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property AlwaysKeepFocus = {default=0};
	__property AlwaysKeepSelection = {default=1};
	__property AutoLineHeight = {default=1};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property DefaultSectionWidth = {default=120};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property BorderSides = {default=15};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property DeselectChildrenOnCollapse = {default=0};
	__property DblClickMode = {default=1};
	__property DoInplaceEdit = {default=1};
	__property DragAllowed = {default=0};
	__property DragCursor = {default=-12};
	__property DragExpandDelay = {default=500};
	__property DraggableSections = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragImageMode = {default=0};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property DragScrollInterval = {default=100};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=1};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=true};
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
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HintType = {default=2};
	__property HorizontalLines = {default=0};
	__property HorzDivLinesColor = {default=-16777201};
	__property HorzScrollBarStyles;
	__property HeaderImageForm;
	__property ImageForm;
	__property InactiveBorderType = {default=3};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property IncrementalSearchColumn = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
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
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveColumnOnDrag = {default=0};
	__property MoveFocusOnCollapse = {default=0};
	__property MouseFrameSelect = {default=1};
	__property MultiSelect = {default=1};
	__property MultiSelectLevel = {default=-1};
	__property OwnerDrawByColumn = {default=1};
	__property OwnerDrawMask = {default=0};
	__property PathSeparator = {default=92};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
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
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=1};
	__property ShowLeafButton = {default=0};
	__property ShowLines = {default=0};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=0};
	__property SelectionMode = {default=1};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property Storage;
	__property StoragePath = {default=0};
	__property StickyHeaderSections = {default=0};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property Tracking = {default=1};
	__property TrackColor = {default=-16777203};
	__property UnderlineTracked = {default=1};
	__property UseCustomScrollBars = {default=1};
	__property VertDivLinesColor = {default=-16777201};
	__property VerticalLines = {default=0};
	__property VerticalLinesLong = {default=1};
	__property VertScrollBarStyles;
	__property UseSystemHintColors = {default=0};
	__property TextColor = {default=-16777208};
	__property BkColor = {default=-16777211};
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
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnInplaceEditorNeeded;
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
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnHeaderMouseDown;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered = {default=1};
	__property DragKind = {default=0};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property Enabled = {default=1};
	__property Hint;
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Visible = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
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
	__property OnResize;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElShellList(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElShellList(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
};


typedef System::StaticArray<Lmdtypes::TLMDString, 8> Elshellctl__7;

//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_SETNEWPATH = System::Word(0xf10);
static const System::Word siBase = System::Word(0x5b2);
static const System::Int8 siMin = System::Int8(0x0);
static const System::Int8 siName = System::Int8(0x0);
static const System::Int8 siSize = System::Int8(0x1);
static const System::Int8 siType = System::Int8(0x2);
static const System::Int8 siModified = System::Int8(0x3);
static const System::Int8 siAttr = System::Int8(0x4);
static const System::Int8 siComment = System::Int8(0x5);
static const System::Int8 siCreated = System::Int8(0x6);
static const System::Int8 siAccessed = System::Int8(0x7);
static const System::Int8 siMax = System::Int8(0x7);
extern DELPHI_PACKAGE Elshellctl__7 DefaultColumnNames;
extern DELPHI_PACKAGE System::StaticArray<int, 8> DefaultColumnAlignments;
extern DELPHI_PACKAGE System::StaticArray<TElShellSortType, 8> ColumnSortTypes;
#define cExecutableExtensionsWin9X L".EXE\r.DLL\r.BAT"
#define cExecutableExtensionsWinNTUp L".EXE\r.DLL\r.BAT\r.CMD"
extern DELPHI_PACKAGE Lmdtypes::TLMDString ExecutableExtensions;
}	/* namespace Elshellctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSHELLCTL)
using namespace Elshellctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElshellctlHPP
