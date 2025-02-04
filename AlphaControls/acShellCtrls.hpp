// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acShellCtrls.pas' rev: 27.00 (Windows)

#ifndef AcshellctrlsHPP
#define AcshellctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <Winapi.ShlObj.hpp>	// Pascal unit
#include <Winapi.ActiveX.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <sComboBoxes.hpp>	// Pascal unit
#include <sTreeView.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sListView.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acshellctrls
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacRootFolder : unsigned char { rfDesktop, rfMyComputer, rfNetwork, rfRecycleBin, rfAppData, rfCommonDesktopDirectory, rfCommonPrograms, rfCommonStartMenu, rfCommonStartup, rfControlPanel, rfDesktopDirectory, rfFavorites, rfFonts, rfInternet, rfPersonal, rfPrinters, rfPrintHood, rfPrograms, rfRecent, rfSendTo, rfStartMenu, rfStartup, rfTemplates };

enum DECLSPEC_DENUM TacShellFolderCapability : unsigned char { fcCanCopy, fcCanDelete, fcCanLink, fcCanMove, fcCanRename, fcDropTarget, fcHasPropSheet };

typedef System::Set<TacShellFolderCapability, TacShellFolderCapability::fcCanCopy, TacShellFolderCapability::fcHasPropSheet> TacShellFolderCapabilities;

enum DECLSPEC_DENUM TacShellFolderProperty : unsigned char { fpCut, fpIsLink, fpReadOnly, fpShared, fpFileSystem, fpFileSystemAncestor, fpRemovable, fpValidate };

typedef System::Set<TacShellFolderProperty, TacShellFolderProperty::fpCut, TacShellFolderProperty::fpValidate> TacShellFolderProperties;

enum DECLSPEC_DENUM TacShellObjectType : unsigned char { otFolders, otNonFolders, otHidden };

typedef System::Set<TacShellObjectType, TacShellObjectType::otFolders, TacShellObjectType::otHidden> TacShellObjectTypes;

enum DECLSPEC_DENUM TacShowExtension : unsigned char { seSystem, seShow, seHide };

__interface IacShellCommandVerb;
typedef System::DelphiInterface<IacShellCommandVerb> _di_IacShellCommandVerb;
__interface  INTERFACE_UUID("{7D2A7245-2376-4D33-8008-A130935A2E8B}") IacShellCommandVerb  : public System::IInterface 
{
	
public:
	virtual void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled) = 0 ;
	virtual void __fastcall CommandCompleted(const System::UnicodeString Verb, bool Succeeded) = 0 ;
};

__interface IShellDetails;
typedef System::DelphiInterface<IShellDetails> _di_IShellDetails;
__interface  INTERFACE_UUID("{000214EC-0000-0000-C000-000000000046}") IShellDetails  : public System::IInterface 
{
	
public:
	virtual HRESULT __stdcall GetDetailsOf(Winapi::Shlobj::PItemIDList pidl, unsigned iColumn, _SHELLDETAILS &pDetails) = 0 ;
	virtual HRESULT __stdcall ColumnClick(unsigned iColumn) = 0 ;
};

__interface IDetInterface;
typedef System::DelphiInterface<IDetInterface> _di_IDetInterface;
__interface  INTERFACE_UUID("{00000000-0000-0000-C000-000000000046}") IDetInterface  : public System::IInterface 
{
	
public:
	HIDESBASE virtual HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj) = 0 ;
	HIDESBASE virtual int __stdcall _AddRef(void) = 0 ;
	HIDESBASE virtual int __stdcall _Release(void) = 0 ;
};

class DELPHICLASS TacShellFolder;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacShellFolder : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	_ITEMIDLIST *FPIDL;
	_ITEMIDLIST *FFullPIDL;
	TacShellFolder* FParent;
	_di_IShellFolder FIShellFolder;
	_di_IShellFolder2 FIShellFolder2;
	_di_IShellDetails FIShellDetails;
	_di_IDetInterface FDetailInterface;
	int FLevel;
	NativeUInt FViewHandle;
	System::Classes::TStrings* FDetails;
	_di_IDetInterface __fastcall GetDetailInterface(void);
	_di_IShellDetails __fastcall GetShellDetails(void);
	_di_IShellFolder2 __fastcall GeTacShellFolder2(void);
	System::UnicodeString __fastcall GetDetails(int Index);
	void __fastcall SetDetails(int Index, const System::UnicodeString Value);
	void __fastcall LoadColumnDetails(TacShellFolder* RootFolder, NativeUInt Handle, int ColumnCount);
	
public:
	__fastcall virtual TacShellFolder(TacShellFolder* AParent, Winapi::Shlobj::PItemIDList ID, _di_IShellFolder SF);
	__fastcall virtual ~TacShellFolder(void);
	TacShellFolderCapabilities __fastcall Capabilities(void);
	System::UnicodeString __fastcall DisplayName(TacShowExtension ShowExt);
	int __fastcall ExecuteDefault(void);
	int __fastcall ImageIndex(bool LargeIcon);
	bool __fastcall IsFolder(const System::UnicodeString Name = System::UnicodeString(), bool OpenZipFiles = true);
	bool __fastcall IsFileFolder(void);
	bool __fastcall IsFile(const System::UnicodeString Name = System::UnicodeString(), bool OpenZipFiles = true);
	bool __fastcall IsReadOnly(void);
	_di_IShellFolder __fastcall ParenTacShellFolder(void);
	System::UnicodeString __fastcall PathName(void);
	TacShellFolderProperties __fastcall Properties(void);
	bool __fastcall Rename(const System::WideString NewName);
	bool __fastcall SubFolders(void);
	__property Winapi::Shlobj::PItemIDList AbsoluteID = {read=FFullPIDL};
	__property System::UnicodeString Details[int Index] = {read=GetDetails, write=SetDetails};
	__property int Level = {read=FLevel, nodefault};
	__property TacShellFolder* Parent = {read=FParent};
	__property Winapi::Shlobj::PItemIDList RelativeID = {read=FPIDL};
	__property _di_IShellFolder ShellFolder = {read=FIShellFolder};
	__property _di_IShellFolder2 ShellFolder2 = {read=GeTacShellFolder2};
	__property _di_IShellDetails ShellDetails = {read=GetShellDetails};
	__property NativeUInt ViewHandle = {read=FViewHandle, write=FViewHandle, nodefault};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TacNotifyFilter : unsigned char { nfFileNameChange, nfDirNameChange, nfAttributeChange, nfSizeChange, nfWriteChange, nfSecurityChange };

typedef System::Set<TacNotifyFilter, TacNotifyFilter::nfFileNameChange, TacNotifyFilter::nfSecurityChange> TacNotifyFilters;

class DELPHICLASS TacShellChangeThread;
class PASCALIMPLEMENTATION TacShellChangeThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	int FMutex;
	int FWaitHandle;
	System::Classes::TThreadMethod FChangeEvent;
	System::UnicodeString FDirectory;
	bool FWatchSubTree;
	bool FWaitChanged;
	unsigned FNotifyOptionFlags;
	System::Syncobjs::TEvent* FStopEvent;
	System::Syncobjs::TEvent* FActive;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall virtual TacShellChangeThread(System::Classes::TThreadMethod ChangeEvent);
	__fastcall virtual ~TacShellChangeThread(void);
	void __fastcall SetDirectoryOptions(const System::UnicodeString Directory, bool WatchSubTree, unsigned NotifyOptionFlags);
	__property System::Classes::TThreadMethod ChangeEvent = {read=FChangeEvent, write=FChangeEvent};
};


class DELPHICLASS TacCustomShellChangeNotifier;
class PASCALIMPLEMENTATION TacCustomShellChangeNotifier : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TacNotifyFilters FFilters;
	bool FWatchSubTree;
	Sconst::TacRoot FRoot;
	TacShellChangeThread* FThread;
	System::Classes::TThreadMethod FOnChange;
	void __fastcall SetRoot(const Sconst::TacRoot Value);
	void __fastcall SetWatchSubTree(const bool Value);
	void __fastcall SetFilters(const TacNotifyFilters Value);
	void __fastcall SetOnChange(const System::Classes::TThreadMethod Value);
	
protected:
	void __fastcall Change(void);
	void __fastcall Start(void);
	
public:
	__fastcall virtual TacCustomShellChangeNotifier(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacCustomShellChangeNotifier(void);
	__property TacNotifyFilters NotifyFilters = {read=FFilters, write=SetFilters, nodefault};
	__property Sconst::TacRoot Root = {read=FRoot, write=SetRoot};
	__property bool WatchSubTree = {read=FWatchSubTree, write=SetWatchSubTree, nodefault};
	__property System::Classes::TThreadMethod OnChange = {read=FOnChange, write=SetOnChange};
};


class DELPHICLASS TacShellChangeNotifier;
class PASCALIMPLEMENTATION TacShellChangeNotifier : public TacCustomShellChangeNotifier
{
	typedef TacCustomShellChangeNotifier inherited;
	
__published:
	__property NotifyFilters;
	__property Root = {default=0};
	__property WatchSubTree;
	__property OnChange;
public:
	/* TacCustomShellChangeNotifier.Create */ inline __fastcall virtual TacShellChangeNotifier(System::Classes::TComponent* AOwner) : TacCustomShellChangeNotifier(AOwner) { }
	/* TacCustomShellChangeNotifier.Destroy */ inline __fastcall virtual ~TacShellChangeNotifier(void) { }
	
};


typedef void __fastcall (__closure *TacAddFolderEvent)(System::TObject* Sender, TacShellFolder* AFolder, bool &CanAdd);

typedef void __fastcall (__closure *TacGetImageIndexEvent)(System::TObject* Sender, int Index, int &ImageIndex);

class DELPHICLASS TacCustomShellTreeView;
class DELPHICLASS TacCustomShellComboBox;
class DELPHICLASS TacCustomShellListView;
class PASCALIMPLEMENTATION TacCustomShellTreeView : public Streeview::TsTreeView
{
	typedef Streeview::TsTreeView inherited;
	
public:
	TacShellFolder* operator[](int Index) { return Folders[Index]; }
	
private:
	Sconst::TacRoot FRoot;
	Sconst::TacRoot FOldRoot;
	TacShellFolder* FRootFolder;
	TacShellObjectTypes FObjectTypes;
	bool FLoadingRoot;
	bool FAutoContext;
	bool FUpdating;
	TacCustomShellComboBox* FComboBox;
	TacCustomShellListView* FListView;
	bool FAutoRefresh;
	bool FImageListChanging;
	bool FUseShellImages;
	TacShellChangeNotifier* FNotifier;
	TacAddFolderEvent FOnAddFolder;
	System::UnicodeString FSavePath;
	Vcl::Comctrls::TTreeNode* FNodeToMonitor;
	TacShowExtension FShowExtension;
	Vcl::Comctrls::TTreeNode* __fastcall FolderExists(Winapi::Shlobj::PItemIDList FindID, Vcl::Comctrls::TTreeNode* InNode);
	TacShellFolder* __fastcall GetFolder(int Index);
	System::UnicodeString __fastcall GetPath(void);
	void __fastcall SetComboBox(TacCustomShellComboBox* Value);
	void __fastcall SetListView(TacCustomShellListView* const Value);
	void __fastcall SetPath(const System::UnicodeString Value);
	void __fastcall SetPathFromID(Winapi::Shlobj::PItemIDList ID);
	void __fastcall SetRoot(const Sconst::TacRoot Value);
	void __fastcall SetUseShellImages(const bool Value);
	void __fastcall SetAutoRefresh(const bool Value);
	bool __fastcall GetUpdating(void);
	void __fastcall DefferedRefreshEvent(void);
	MESSAGE void __fastcall OnDefferedRefreshEvent(Winapi::Messages::TMessage &Message);
	
protected:
	void __fastcall CreateRoot(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	DYNAMIC void __fastcall Edit(const tagTVITEMW &Item);
	virtual void __fastcall GetImageIndex(Vcl::Comctrls::TTreeNode* Node);
	virtual void __fastcall GetSelectedIndex(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall InitNode(Vcl::Comctrls::TTreeNode* NewNode, Winapi::Shlobj::PItemIDList ID, Vcl::Comctrls::TTreeNode* ParentNode);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Delete(Vcl::Comctrls::TTreeNode* Node);
	Vcl::Comctrls::TTreeNode* __fastcall NodeFromAbsoluteID(Vcl::Comctrls::TTreeNode* StartNode, Winapi::Shlobj::PItemIDList ID);
	Vcl::Comctrls::TTreeNode* __fastcall NodeFromRelativeID(Vcl::Comctrls::TTreeNode* ParentNode, Winapi::Shlobj::PItemIDList ID);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC bool __fastcall CanChange(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanExpand(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall PopulateNode(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall RootChanged(void);
	virtual void __fastcall SetObjectTypes(TacShellObjectTypes Value);
	HIDESBASE virtual void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall ClearItems(void);
	void __fastcall RefreshEvent(void);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TacCustomShellTreeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacCustomShellTreeView(void);
	HIDESBASE void __fastcall Refresh(Vcl::Comctrls::TTreeNode* Node);
	TacShellFolder* __fastcall SelectedFolder(void);
	__property bool AutoRefresh = {read=FAutoRefresh, write=SetAutoRefresh, nodefault};
	__property TacShellFolder* Folders[int Index] = {read=GetFolder/*, default*/};
	__property Items;
	__property System::UnicodeString Path = {read=GetPath, write=SetPath};
	__property bool AutoContextMenus = {read=FAutoContext, write=FAutoContext, default=1};
	__property TacShellObjectTypes ObjectTypes = {read=FObjectTypes, write=SetObjectTypes, nodefault};
	__property Sconst::TacRoot Root = {read=FRoot, write=SetRoot};
	__property TacCustomShellComboBox* ShellComboBox = {read=FComboBox, write=SetComboBox};
	__property TacCustomShellListView* ShellListView = {read=FListView, write=SetListView};
	__property bool UseShellImages = {read=FUseShellImages, write=SetUseShellImages, nodefault};
	__property bool InUpdating = {read=GetUpdating, nodefault};
	__property TacShowExtension ShowExt = {read=FShowExtension, write=FShowExtension, nodefault};
	__property TacAddFolderEvent OnAddFolder = {read=FOnAddFolder, write=FOnAddFolder};
	void __fastcall CommandCompleted(const System::UnicodeString Verb, bool Succeeded);
	void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled);
public:
	/* TWinControl.CreateParented */ inline __fastcall TacCustomShellTreeView(HWND ParentWindow) : Streeview::TsTreeView(ParentWindow) { }
	
private:
	void *__IacShellCommandVerb;	// IacShellCommandVerb 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {7D2A7245-2376-4D33-8008-A130935A2E8B}
	operator _di_IacShellCommandVerb()
	{
		_di_IacShellCommandVerb intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IacShellCommandVerb*(void) { return (IacShellCommandVerb*)&__IacShellCommandVerb; }
	#endif
	
};


class DELPHICLASS TsShellTreeView;
class PASCALIMPLEMENTATION TsShellTreeView : public TacCustomShellTreeView
{
	typedef TacCustomShellTreeView inherited;
	
__published:
	__property OnAddFolder;
	__property OnGetImageIndex;
	__property OnGetSelectedIndex;
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
	__property OnChanging;
	__property OnChange;
	__property OnExpanding;
	__property OnCollapsing;
	__property OnCollapsed;
	__property OnExpanded;
	__property OnEditing;
	__property OnEdited;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property Images;
	__property Indent;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RightClickSelect = {default=1};
	__property ShowButtons = {default=1};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ChangeDelay = {default=0};
	__property ShowRoot = {default=1};
	__property StateImages;
	__property AutoContextMenus = {default=1};
	__property ObjectTypes;
	__property Root = {default=0};
	__property ShellComboBox;
	__property ShellListView;
	__property UseShellImages;
	__property AutoRefresh;
	__property ShowExt;
public:
	/* TacCustomShellTreeView.Create */ inline __fastcall virtual TsShellTreeView(System::Classes::TComponent* AOwner) : TacCustomShellTreeView(AOwner) { }
	/* TacCustomShellTreeView.Destroy */ inline __fastcall virtual ~TsShellTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsShellTreeView(HWND ParentWindow) : TacCustomShellTreeView(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TacCustomShellComboBox : public Scomboboxes::TsCustomComboBoxEx
{
	typedef Scomboboxes::TsCustomComboBoxEx inherited;
	
private:
	int FImageHeight;
	int FImageWidth;
	Vcl::Imglist::TCustomImageList* FImageList;
	Sconst::TacRoot FOldRoot;
	Sconst::TacRoot FRoot;
	TacShellFolder* FRootFolder;
	TacCustomShellTreeView* FTreeView;
	TacCustomShellListView* FListView;
	TacShellObjectTypes FObjectTypes;
	bool FUseShellImages;
	bool FUpdating;
	TacGetImageIndexEvent FOnGetImageIndex;
	void __fastcall ClearItems(void);
	TacShellFolder* __fastcall GetFolder(int Index);
	System::UnicodeString __fastcall GetPath(void);
	void __fastcall SetPath(const System::UnicodeString Value);
	void __fastcall SetPathFromID(Winapi::Shlobj::PItemIDList ID);
	void __fastcall SetRoot(const Sconst::TacRoot Value);
	void __fastcall SetTreeView(TacCustomShellTreeView* Value);
	void __fastcall SetListView(TacCustomShellListView* Value);
	void __fastcall SetUseShellImages(const bool Value);
	int __fastcall GetShellImageIndex(TacShellFolder* AFolder);
	bool __fastcall GetUpdating(void);
	
protected:
	void __fastcall AddItems(int Index, TacShellFolder* ParentFolder);
	DYNAMIC void __fastcall Click(void);
	void __fastcall CreateRoot(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall Init(void);
	TacShellFolder* __fastcall InitItem(TacShellFolder* ParentFolder, Winapi::Shlobj::PItemIDList ID);
	void __fastcall RootChanged(void);
	void __fastcall TreeUpdate(Winapi::Shlobj::PItemIDList NewPath);
	virtual void __fastcall SetObjectTypes(TacShellObjectTypes Value);
	
public:
	bool ExtUpdating;
	__fastcall virtual TacCustomShellComboBox(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateWnd(void);
	int __fastcall IndexFromID(Winapi::Shlobj::PItemIDList AbsoluteID);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__fastcall virtual ~TacCustomShellComboBox(void);
	virtual void __fastcall Loaded(void);
	__property Items;
	__property System::UnicodeString Path = {read=GetPath, write=SetPath};
	__property TacShellFolder* Folders[int Index] = {read=GetFolder};
	__property Sconst::TacRoot Root = {read=FRoot, write=SetRoot};
	__property TacShellObjectTypes ObjectTypes = {read=FObjectTypes, write=SetObjectTypes, nodefault};
	__property TacCustomShellTreeView* ShellTreeView = {read=FTreeView, write=SetTreeView};
	__property TacCustomShellListView* ShellListView = {read=FListView, write=SetListView};
	__property bool InUpdating = {read=GetUpdating, nodefault};
	__property bool UseShellImages = {read=FUseShellImages, write=SetUseShellImages, default=1};
	__property TacGetImageIndexEvent OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
public:
	/* TWinControl.CreateParented */ inline __fastcall TacCustomShellComboBox(HWND ParentWindow) : Scomboboxes::TsCustomComboBoxEx(ParentWindow) { }
	
};


class DELPHICLASS TsShellComboBox;
class PASCALIMPLEMENTATION TsShellComboBox : public TacCustomShellComboBox
{
	typedef TacCustomShellComboBox inherited;
	
public:
	__property Path = {default=0};
	
__published:
	__property OnGetImageIndex;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Images;
	__property Root = {default=0};
	__property ShellTreeView;
	__property ShellListView;
	__property UseShellImages = {default=1};
public:
	/* TacCustomShellComboBox.Create */ inline __fastcall virtual TsShellComboBox(System::Classes::TComponent* AOwner) : TacCustomShellComboBox(AOwner) { }
	/* TacCustomShellComboBox.Destroy */ inline __fastcall virtual ~TsShellComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsShellComboBox(HWND ParentWindow) : TacCustomShellComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TacCustomShellListView : public Slistview::TsCustomListView
{
	typedef Slistview::TsCustomListView inherited;
	
private:
	Sconst::TacRoot FOldRoot;
	Sconst::TacRoot FRoot;
	TacShellFolder* FRootFolder;
	bool FAutoContext;
	bool FAutoRefresh;
	bool FAutoNavigate;
	bool FSorted;
	TacShellObjectTypes FObjectTypes;
	int FLargeImages;
	int FSmallImages;
	TacAddFolderEvent FOnAddFolder;
	TacCustomShellTreeView* FTreeView;
	TacCustomShellComboBox* FComboBox;
	TacShellChangeNotifier* FNotifier;
	Vcl::Comctrls::TLVEditingEvent FOnEditing;
	bool FSettingRoot;
	System::UnicodeString FSavePath;
	System::UnicodeString FMask;
	TacShowExtension FShowExtension;
	void __fastcall EnumColumns(void);
	TacShellFolder* __fastcall GetFolder(int Index);
	void __fastcall SetAutoRefresh(const bool Value);
	void __fastcall SetSorted(const bool Value);
	void __fastcall SetTreeView(TacCustomShellTreeView* Value);
	void __fastcall SetComboBox(TacCustomShellComboBox* Value);
	void __fastcall SynchPaths(void);
	void __fastcall SetMask(const System::UnicodeString Value);
	bool __fastcall GetUpdating(void);
	
protected:
	System::Classes::TList* FFolders;
	void __fastcall ClearItems(void);
	void __fastcall CreateRoot(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall EditText(void);
	DYNAMIC void __fastcall Edit(const tagLVITEMW &Item);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall OwnerDataFetch(Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemRequest Request);
	virtual int __fastcall OwnerDataFind(Vcl::Comctrls::TItemFind Find, const System::UnicodeString FindString, const System::Types::TPoint &FindPosition, void * FindData, int StartIndex, Vcl::Comctrls::TSearchDirection Direction, bool Wrap);
	virtual void __fastcall Populate(void);
	void __fastcall SetObjectTypes(TacShellObjectTypes Value);
	void __fastcall SetRoot(const Sconst::TacRoot Value);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	bool FUpdating;
	void __fastcall RootChanged(void);
	void __fastcall SetPathFromID(Winapi::Shlobj::PItemIDList ID);
	void __fastcall TreeUpdate(Winapi::Shlobj::PItemIDList NewRoot);
	__fastcall virtual TacCustomShellListView(System::Classes::TComponent* AOwner);
	virtual void __fastcall InitControl(const bool Skinned);
	__fastcall virtual ~TacCustomShellListView(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Back(void);
	HIDESBASE void __fastcall Refresh(void);
	void __fastcall MakeNewFolder(void);
	TacShellFolder* __fastcall SelectedFolder(void);
	void __fastcall CommandCompleted(const System::UnicodeString Verb, bool Succeeded);
	void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled);
	__property TacShellFolder* Folders[int Index] = {read=GetFolder};
	__property TacShellFolder* RootFolder = {read=FRootFolder};
	__property Items;
	__property Columns;
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property bool AutoContextMenus = {read=FAutoContext, write=FAutoContext, default=1};
	__property bool AutoRefresh = {read=FAutoRefresh, write=SetAutoRefresh, default=0};
	__property bool AutoNavigate = {read=FAutoNavigate, write=FAutoNavigate, default=1};
	__property TacShellObjectTypes ObjectTypes = {read=FObjectTypes, write=SetObjectTypes, nodefault};
	__property Sconst::TacRoot Root = {read=FRoot, write=SetRoot};
	__property TacCustomShellTreeView* ShellTreeView = {read=FTreeView, write=SetTreeView};
	__property TacCustomShellComboBox* ShellComboBox = {read=FComboBox, write=SetComboBox};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
	__property bool InUpdating = {read=GetUpdating, nodefault};
	__property TacShowExtension ShowExt = {read=FShowExtension, write=FShowExtension, nodefault};
	__property TacAddFolderEvent OnAddFolder = {read=FOnAddFolder, write=FOnAddFolder};
	__property Vcl::Comctrls::TLVEditingEvent OnEditing = {read=FOnEditing, write=FOnEditing};
public:
	/* TWinControl.CreateParented */ inline __fastcall TacCustomShellListView(HWND ParentWindow) : Slistview::TsCustomListView(ParentWindow) { }
	
private:
	void *__IacShellCommandVerb;	// IacShellCommandVerb 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {7D2A7245-2376-4D33-8008-A130935A2E8B}
	operator _di_IacShellCommandVerb()
	{
		_di_IacShellCommandVerb intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IacShellCommandVerb*(void) { return (IacShellCommandVerb*)&__IacShellCommandVerb; }
	#endif
	
};


class DELPHICLASS TsShellListView;
class PASCALIMPLEMENTATION TsShellListView : public TacCustomShellListView
{
	typedef TacCustomShellListView inherited;
	
__published:
	__property OnChange;
	__property OnChanging;
	__property OnColumnClick;
	__property OnContextPopup;
	__property OnEnter;
	__property OnExit;
	__property OnInsert;
	__property OnDragDrop;
	__property OnDragOver;
	__property DragCursor = {default=-12};
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property ColumnClick = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property Ctl3D;
	__property DragMode = {default=0};
	__property ReadOnly = {default=1};
	__property Enabled = {default=1};
	__property Font;
	__property GridLines = {default=0};
	__property Sorted;
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property IconOptions;
	__property AllocBy = {default=0};
	__property MultiSelect = {default=0};
	__property RowSelect = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ViewStyle = {default=0};
	__property OnEditing;
	__property OnAddFolder;
	__property AutoContextMenus = {default=1};
	__property AutoRefresh = {default=0};
	__property AutoNavigate = {default=1};
	__property ObjectTypes;
	__property Root = {default=0};
	__property ShellTreeView;
	__property ShellComboBox;
	__property ShowExt;
	__property Mask = {default=0};
	__property ShowColumnHeaders = {default=1};
public:
	/* TacCustomShellListView.Create */ inline __fastcall virtual TsShellListView(System::Classes::TComponent* AOwner) : TacCustomShellListView(AOwner) { }
	/* TacCustomShellListView.Destroy */ inline __fastcall virtual ~TsShellListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsShellListView(HWND ParentWindow) : TacCustomShellListView(ParentWindow) { }
	
};


class DELPHICLASS TsDlgShellListView;
class PASCALIMPLEMENTATION TsDlgShellListView : public TsShellListView
{
	typedef TsShellListView inherited;
	
protected:
	DYNAMIC void __fastcall DblClick(void);
public:
	/* TacCustomShellListView.Create */ inline __fastcall virtual TsDlgShellListView(System::Classes::TComponent* AOwner) : TsShellListView(AOwner) { }
	/* TacCustomShellListView.Destroy */ inline __fastcall virtual ~TsDlgShellListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsDlgShellListView(HWND ParentWindow) : TsShellListView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_DEFFERED_REFRESH = System::Word(0x401);
extern DELPHI_PACKAGE bool DontFoldersGenerate;
extern DELPHI_PACKAGE bool UseAllFolderAttributes;
extern DELPHI_PACKAGE NativeUInt SysSmallImages;
extern DELPHI_PACKAGE Acalphaimagelist::TsAlphaImageList* SysSmallImageList;
#define SRFDesktop L"rfDesktop"
#define SCmdVerbOpen L"open"
#define SCmdVerbRename L"rename"
#define SCmdVerbDelete L"delete"
#define SCmdVerbPaste L"paste"
#define SShellNoDetails L"Unable to retrieve folder details for \"%s\". Error code $"\
	L"%x"
#define NTFolders (System::Set<TacRootFolder, TacRootFolder::rfDesktop, TacRootFolder::rfTemplates>() << TacRootFolder::rfCommonDesktopDirectory << TacRootFolder::rfCommonPrograms << TacRootFolder::rfCommonStartMenu << TacRootFolder::rfCommonStartup )
extern DELPHI_PACKAGE System::StaticArray<int, 23> nFolder;
extern DELPHI_PACKAGE void __fastcall DisposePIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall DesktopShellFolder(void);
extern DELPHI_PACKAGE int __fastcall GetShellImage(Winapi::Shlobj::PItemIDList PIDL, bool Large, bool Open);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetDisplayName(_di_IShellFolder Parentfolder, Winapi::Shlobj::PItemIDList PIDL, unsigned Flags, TacShowExtension ShowExt);
extern DELPHI_PACKAGE void __fastcall InvokeContextMenu(Vcl::Controls::TWinControl* Owner, TacShellFolder* AFolder, int X, int Y);
extern DELPHI_PACKAGE TacShellFolder* __fastcall CreateRootFromPIDL(Winapi::Shlobj::PItemIDList Value);
extern DELPHI_PACKAGE bool __fastcall G_ValidateWildText(const System::UnicodeString S, const System::UnicodeString Mask, System::WideChar MaskChar = (System::WideChar)(0x3f), System::WideChar WildCard = (System::WideChar)(0x2a));
extern DELPHI_PACKAGE int __fastcall G_CharPos(System::WideChar C, const System::UnicodeString S, int StartPos = 0x1)/* overload */;
}	/* namespace Acshellctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACSHELLCTRLS)
using namespace Acshellctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcshellctrlsHPP
