// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDVistaDialogs.pas' rev: 31.00 (Windows)

#ifndef LmdvistadialogsHPP
#define LmdvistadialogsHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.ActiveX.hpp>
#include <intfLMDFileDialog.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDRegExpr.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDUnicodeDialogs.hpp>
#include <LMDStrings.hpp>
#include <LMDShUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdvistadialogs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFavoritePlace;
class DELPHICLASS TLMDFavoritePlaces;
class DELPHICLASS TLMDFileTypeItem;
class DELPHICLASS TLMDFileTypeItems;
class DELPHICLASS TLMDCustomFileDialog;
class DELPHICLASS TLMDCustomFileOpenDialog;
class DELPHICLASS TLMDCustomFileSaveDialog;
class DELPHICLASS TLMDFileOpenDialog;
class DELPHICLASS TLMDFileSaveDialog;
//-- type declarations -------------------------------------------------------
typedef System::WideChar * TLMDWideString;

enum DECLSPEC_DENUM TLMDFileDialogOption : unsigned char { fdoOverWritePrompt, fdoStrictFileTypes, fdoNoChangeDir, fdoPickFolders, fdoForceFileSystem, fdoAllNonStorageItems, fdoNoValidate, fdoAllowMultiSelect, fdoPathMustExist, fdoFileMustExist, fdoCreatePrompt, fdoShareAware, fdoNoReadOnlyReturn, fdoNoTestFileCreate, fdoHideMRUPlaces, fdoHidePinnedPlaces, fdoNoDereferenceLinks, fdoDontAddToRecent, fdoForceShowHidden, fdoDefaultNoMiniMode, fdoForcePreviewPaneOn };

typedef System::Set<TLMDFileDialogOption, TLMDFileDialogOption::fdoOverWritePrompt, TLMDFileDialogOption::fdoForcePreviewPaneOn> TLMDFileDialogOptions;

enum DECLSPEC_DENUM TLMDFileDialogOverwriteResponse : unsigned char { forDefault, forAccept, forRefuse };

enum DECLSPEC_DENUM TLMDFileDialogShareViolationResponse : unsigned char { fsrDefault, fsrAccept, fsrRefuse };

enum DECLSPEC_DENUM TLMDFileDialogAddPlace : unsigned char { fdapBottom, fdapTop };

typedef void __fastcall (__closure *TLMDFileDialogCloseEvent)(System::TObject* Sender, bool &CanClose);

typedef void __fastcall (__closure *TLMDFileDialogFolderChangingEvent)(System::TObject* Sender, bool &CanChange);

typedef void __fastcall (__closure *TLMDFileDialogOverwriteEvent)(System::TObject* Sender, TLMDFileDialogOverwriteResponse &Response);

typedef void __fastcall (__closure *TLMDFileDialogShareViolationEvent)(System::TObject* Sender, TLMDFileDialogShareViolationResponse &Response);

typedef void __fastcall (__closure *TLMDFileDialogItemSelected)(System::TObject* Sender, int dwIDCtl, int dwIDItem);

typedef void __fastcall (__closure *TLMDFileDialogItemNotify)(System::TObject* Sender, int dwIDCtl);

typedef void __fastcall (__closure *TLMDFileDialogCheckButtonToggled)(System::TObject* Sender, int dwIDCtl, bool AChecked);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFavoritePlace : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FLocation;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	Intflmdfiledialog::_di_IShellItem __fastcall GetIShellItem(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdtypes::TLMDString Location = {read=FLocation, write=FLocation};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDFavoritePlace(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDFavoritePlace(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFavoritePlaces : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	HIDESBASE TLMDFavoritePlace* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFavoritePlace* const Value);
	
public:
	HIDESBASE TLMDFavoritePlace* __fastcall Add(void);
	__property TLMDFavoritePlace* Items[int Index] = {read=GetItem, write=SetItem};
public:
	/* TCollection.Create */ inline __fastcall TLMDFavoritePlaces(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDFavoritePlaces(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileTypeItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FDisplayName;
	Lmdtypes::TLMDString FFileMask;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdtypes::TLMDString DisplayName = {read=FDisplayName, write=FDisplayName};
	__property Lmdtypes::TLMDString FileMask = {read=FFileMask, write=FFileMask};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDFileTypeItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDFileTypeItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileTypeItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	Intflmdfiledialog::_COMDLG_FILTERSPEC *FNativeBuffer;
	HIDESBASE TLMDFileTypeItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFileTypeItem* const Value);
	Lmdtypes::TLMDString __fastcall GetOldFilter(void);
	void __fastcall SetOldFilter(const Lmdtypes::TLMDString Value);
	
protected:
	void __fastcall AllocNativeBuffer(void);
	void __fastcall FreeNativeBuffer(void);
	Intflmdfiledialog::PComDlgFilterspec __fastcall FillNativeBuffer(void);
	
public:
	HIDESBASE TLMDFileTypeItem* __fastcall Add(void);
	__property Lmdtypes::TLMDString OldFilter = {read=GetOldFilter, write=SetOldFilter};
	__property TLMDFileTypeItem* Items[int Index] = {read=GetItem, write=SetItem};
public:
	/* TCollection.Create */ inline __fastcall TLMDFileTypeItems(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDFileTypeItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomFileDialog : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDFileDialogAddPlace FFavoriteLinksPlace;
	unsigned FFileTypeIndex;
	System::UnicodeString FClientGuid;
	TLMDFavoritePlaces* FFavoriteLinks;
	TLMDFileDialogCloseEvent FOnFileOkClick;
	TLMDFileDialogFolderChangingEvent FOnFolderChanging;
	TLMDFileDialogOptions FOptions;
	TLMDFileDialogOverwriteEvent FOnOverwrite;
	TLMDFileDialogShareViolationEvent FOnShareViolation;
	TLMDFileTypeItems* FFileTypes;
	System::Classes::TNotifyEvent FOnExecute;
	System::Classes::TNotifyEvent FOnFolderChange;
	System::Classes::TNotifyEvent FOnSelectionChange;
	System::Classes::TNotifyEvent FOnTypeChange;
	Lmdtypes::TLMDString FFileNameLabel;
	Lmdtypes::TLMDString FDefaultFolder;
	Lmdtypes::TLMDString FTitle;
	Lmdtypes::TLMDString FOKButtonLabel;
	Lmdtypes::TLMDString FFileName;
	Lmdtypes::TLMDString FDefaultExt;
	Intflmdfiledialog::_di_IFileDialog FDialog;
	System::Classes::TStrings* FFiles;
	HWND FHandle;
	Intflmdfiledialog::_di_IShellItem FShellItem;
	Intflmdfiledialog::_di_IShellItemArray FShellItems;
	TLMDFileDialogItemSelected FOnItemSelected;
	TLMDFileDialogItemNotify FOnButtonClicked;
	TLMDFileDialogCheckButtonToggled FOnCheckButtonToggled;
	TLMDFileDialogItemNotify FOnControlActivating;
	void __fastcall SetClientGuid(const System::UnicodeString Value);
	void __fastcall SetDefaultExt(const Lmdtypes::TLMDString Value);
	void __fastcall SetDefaultFolder(const Lmdtypes::TLMDString Value);
	void __fastcall SetFileName(const Lmdtypes::TLMDString Value);
	void __fastcall SetFileNameLable(const Lmdtypes::TLMDString Value);
	void __fastcall SetFileTypeIndex(const int Value);
	void __fastcall SetOKButtonLabel(const Lmdtypes::TLMDString Value);
	void __fastcall SetOptions(const TLMDFileDialogOptions Value);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	Intflmdfiledialog::_di_IFileDialogCustomize __fastcall GetFileDialogCustomize(void);
	void __fastcall SetFavoriteLinks(TLMDFavoritePlaces* const Value);
	void __fastcall SetFileTypes(TLMDFileTypeItems* const Value);
	
protected:
	virtual void __fastcall TriggerSelectionChange(void);
	virtual int __fastcall GetFileTypeIndex(void);
	virtual void __fastcall CreateNativeDialog(void) = 0 ;
	virtual void __fastcall DestroyDialog(void) = 0 ;
	virtual bool __fastcall ExecuteOldDialog(HWND AParent) = 0 ;
	bool __fastcall GetItemName(Intflmdfiledialog::_di_IShellItem AShellItem, Lmdtypes::TLMDString &AFileName);
	virtual HRESULT __fastcall SelectionChange(void);
	virtual bool __fastcall GetResults(void);
	virtual void __fastcall TriggerExecute(void);
	virtual bool __fastcall TriggerButtonClicked(int dwIDCtl);
	virtual bool __fastcall TriggerItemSelected(int dwIDCtl, int dwIDItem);
	virtual bool __fastcall TriggerControlActivating(int dwIDCtl);
	virtual bool __fastcall TriggerCheckButtonToogled(int dwIDCtl, bool AChecked);
	
public:
	__fastcall virtual TLMDCustomFileDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomFileDialog(void);
	virtual bool __fastcall Execute(void)/* overload */;
	virtual bool __fastcall Execute(HWND AParent)/* overload */;
	__property Intflmdfiledialog::_di_IFileDialog Dialog = {read=FDialog};
	__property Intflmdfiledialog::_di_IFileDialogCustomize DialogCustomize = {read=GetFileDialogCustomize};
	__property System::UnicodeString ClientGuid = {read=FClientGuid, write=SetClientGuid};
	__property Lmdtypes::TLMDString DefaultExtension = {read=FDefaultExt, write=SetDefaultExt};
	__property Lmdtypes::TLMDString DefaultFolder = {read=FDefaultFolder, write=SetDefaultFolder};
	__property TLMDFavoritePlaces* FavoriteLinks = {read=FFavoriteLinks, write=SetFavoriteLinks};
	__property TLMDFileDialogAddPlace FavoriteLinksPlace = {read=FFavoriteLinksPlace, write=FFavoriteLinksPlace, default=0};
	__property Lmdtypes::TLMDString FileName = {read=FFileName, write=SetFileName};
	__property Lmdtypes::TLMDString FileNameLabel = {read=FFileNameLabel, write=SetFileNameLable};
	__property int FileTypeIndex = {read=GetFileTypeIndex, write=SetFileTypeIndex, nodefault};
	__property TLMDFileTypeItems* FileTypes = {read=FFileTypes, write=SetFileTypes};
	__property System::Classes::TStrings* Files = {read=FFiles};
	__property HWND Handle = {read=FHandle, nodefault};
	__property Lmdtypes::TLMDString OkButtonLabel = {read=FOKButtonLabel, write=SetOKButtonLabel};
	__property TLMDFileDialogOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Lmdtypes::TLMDString Title = {read=FTitle, write=SetTitle};
	__property Intflmdfiledialog::_di_IShellItem ShellItem = {read=FShellItem};
	__property Intflmdfiledialog::_di_IShellItemArray ShellItems = {read=FShellItems};
	__property System::Classes::TNotifyEvent OnExecute = {read=FOnExecute, write=FOnExecute};
	__property TLMDFileDialogCloseEvent OnFileOkClick = {read=FOnFileOkClick, write=FOnFileOkClick};
	__property System::Classes::TNotifyEvent OnFolderChange = {read=FOnFolderChange, write=FOnFolderChange};
	__property TLMDFileDialogFolderChangingEvent OnFolderChanging = {read=FOnFolderChanging, write=FOnFolderChanging};
	__property TLMDFileDialogOverwriteEvent OnOverwrite = {read=FOnOverwrite, write=FOnOverwrite};
	__property System::Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property TLMDFileDialogShareViolationEvent OnShareViolation = {read=FOnShareViolation, write=FOnShareViolation};
	__property System::Classes::TNotifyEvent OnTypeChange = {read=FOnTypeChange, write=FOnTypeChange};
	__property TLMDFileDialogItemSelected OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property TLMDFileDialogItemNotify OnButtonClicked = {read=FOnButtonClicked, write=FOnButtonClicked};
	__property TLMDFileDialogCheckButtonToggled OnCheckButtonToggled = {read=FOnCheckButtonToggled, write=FOnCheckButtonToggled};
	__property TLMDFileDialogItemNotify OnControlActivating = {read=FOnControlActivating, write=FOnControlActivating};
};


class PASCALIMPLEMENTATION TLMDCustomFileOpenDialog : public TLMDCustomFileDialog
{
	typedef TLMDCustomFileDialog inherited;
	
private:
	Lmdunicodedialogs::TLMDOpenDialog* FOpenDialog;
	bool FExteranlDialog;
	HRESULT __fastcall EnumShellItems(Intflmdfiledialog::_di_IShellItemArray LShellItems);
	
protected:
	virtual bool __fastcall GetResults(void);
	virtual void __fastcall CreateNativeDialog(void);
	virtual void __fastcall DestroyDialog(void);
	virtual bool __fastcall ExecuteOldDialog(HWND AParent);
	virtual HRESULT __fastcall SelectionChange(void);
	__property Lmdunicodedialogs::TLMDOpenDialog* OpenDialog = {read=FOpenDialog, write=FOpenDialog};
public:
	/* TLMDCustomFileDialog.Create */ inline __fastcall virtual TLMDCustomFileOpenDialog(System::Classes::TComponent* AOwner) : TLMDCustomFileDialog(AOwner) { }
	/* TLMDCustomFileDialog.Destroy */ inline __fastcall virtual ~TLMDCustomFileOpenDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomFileSaveDialog : public TLMDCustomFileDialog
{
	typedef TLMDCustomFileDialog inherited;
	
private:
	Lmdunicodedialogs::TLMDOpenDialog* FSaveDialog;
	bool FExternalDialog;
	
protected:
	virtual int __fastcall GetFileTypeIndex(void);
	virtual void __fastcall CreateNativeDialog(void);
	virtual void __fastcall DestroyDialog(void);
	virtual bool __fastcall ExecuteOldDialog(HWND AParent);
	__property Lmdunicodedialogs::TLMDOpenDialog* SaveDialog = {read=FSaveDialog, write=FSaveDialog};
public:
	/* TLMDCustomFileDialog.Create */ inline __fastcall virtual TLMDCustomFileSaveDialog(System::Classes::TComponent* AOwner) : TLMDCustomFileDialog(AOwner) { }
	/* TLMDCustomFileDialog.Destroy */ inline __fastcall virtual ~TLMDCustomFileSaveDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDFileOpenDialog : public TLMDCustomFileOpenDialog
{
	typedef TLMDCustomFileOpenDialog inherited;
	
__published:
	__property About = {default=0};
	__property ClientGuid = {default=0};
	__property DefaultExtension = {default=0};
	__property DefaultFolder = {default=0};
	__property FavoriteLinks;
	__property FavoriteLinksPlace = {default=0};
	__property FileName = {default=0};
	__property FileNameLabel = {default=0};
	__property FileTypes;
	__property FileTypeIndex;
	__property OkButtonLabel = {default=0};
	__property Options;
	__property OpenDialog;
	__property Title = {default=0};
	__property OnExecute;
	__property OnFileOkClick;
	__property OnFolderChange;
	__property OnFolderChanging;
	__property OnSelectionChange;
	__property OnShareViolation;
	__property OnTypeChange;
	__property OnItemSelected;
	__property OnButtonClicked;
	__property OnCheckButtonToggled;
	__property OnControlActivating;
public:
	/* TLMDCustomFileDialog.Create */ inline __fastcall virtual TLMDFileOpenDialog(System::Classes::TComponent* AOwner) : TLMDCustomFileOpenDialog(AOwner) { }
	/* TLMDCustomFileDialog.Destroy */ inline __fastcall virtual ~TLMDFileOpenDialog(void) { }
	
};


class PASCALIMPLEMENTATION TLMDFileSaveDialog : public TLMDCustomFileSaveDialog
{
	typedef TLMDCustomFileSaveDialog inherited;
	
__published:
	__property About = {default=0};
	__property ClientGuid = {default=0};
	__property DefaultExtension = {default=0};
	__property DefaultFolder = {default=0};
	__property FavoriteLinks;
	__property FavoriteLinksPlace = {default=0};
	__property FileName = {default=0};
	__property FileNameLabel = {default=0};
	__property FileTypes;
	__property FileTypeIndex;
	__property OkButtonLabel = {default=0};
	__property Options;
	__property SaveDialog;
	__property Title = {default=0};
	__property OnExecute;
	__property OnFileOkClick;
	__property OnFolderChange;
	__property OnFolderChanging;
	__property OnSelectionChange;
	__property OnShareViolation;
	__property OnTypeChange;
	__property OnItemSelected;
	__property OnButtonClicked;
	__property OnCheckButtonToggled;
	__property OnControlActivating;
public:
	/* TLMDCustomFileDialog.Create */ inline __fastcall virtual TLMDFileSaveDialog(System::Classes::TComponent* AOwner) : TLMDCustomFileSaveDialog(AOwner) { }
	/* TLMDCustomFileDialog.Destroy */ inline __fastcall virtual ~TLMDFileSaveDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdvistadialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDVISTADIALOGS)
using namespace Lmdvistadialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdvistadialogsHPP
