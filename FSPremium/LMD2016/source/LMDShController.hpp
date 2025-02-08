// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShController.pas' rev: 31.00 (Windows)

#ifndef LmdshcontrollerHPP
#define LmdshcontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDShBase.hpp>
#include <LMDShItem.hpp>
#include <LMDShPIDL.hpp>
#include <LMDShNtf.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshcontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellController;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShGetIconOption : unsigned char { iSmall, iOpen };

typedef System::Set<TLMDShGetIconOption, TLMDShGetIconOption::iSmall, TLMDShGetIconOption::iOpen> TLMDShGetIconOptions;

enum DECLSPEC_DENUM TLMDShellFileOpFlag : unsigned char { ffFilesOnly, ffNoActionConfirm, ffNoMKDIRConfirm, ffRenameFileOnCollision, ffShowNoErrors, ffShowNoProgress, ffSimpleProgress, ffUseRecycleBin };

typedef System::Set<TLMDShellFileOpFlag, TLMDShellFileOpFlag::ffFilesOnly, TLMDShellFileOpFlag::ffUseRecycleBin> TLMDShellFileOpFlags;

enum DECLSPEC_DENUM TLMDShellFileOperation : unsigned char { foCopy, foRename, foMove, foDelete };

class PASCALIMPLEMENTATION TLMDShellController : public Lmdshbase::TLMDCustomShellController
{
	typedef Lmdshbase::TLMDCustomShellController inherited;
	
private:
	Vcl::Controls::TImageList* FLargeFolderImages;
	Vcl::Controls::TImageList* FSmallFolderImages;
	_ITEMIDLIST *FComboExtID;
	Lmdshntf::TLMDShellNotify* FObserver;
	System::Classes::TStringList* FForwardPathList;
	System::Classes::TStringList* FBackwardPathList;
	bool FStopPathLog;
	bool FObserveChanges;
	Winapi::Shlobj::PItemIDList __fastcall GetDesktopID(void);
	_di_IShellFolder __fastcall GetDesktopFolder(void);
	bool __fastcall ID_ANSID(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall OnFileChange(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnFileCreate(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnFileDelete(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall OnFileRename(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall OnFolderChange(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnFolderCreate(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnFolderDelete(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnFolderRename(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall OnDriveAdd(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnDriveRemove(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnMediaInsert(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnMediaRemove(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnNetShare(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall OnNetUnShare(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall SetObserveChanges(bool aValue);
	
protected:
	void __fastcall ClearPathList(System::Classes::TStringList* aList);
	
public:
	__fastcall virtual TLMDShellController(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellController(void);
	virtual Lmdshbase::TLMDCustomShellItem* __fastcall CreateShellItem(Winapi::Shlobj::PItemIDList aPIDL)/* overload */;
	virtual Lmdshbase::TLMDCustomShellItem* __fastcall CreateShellItem(const System::UnicodeString aPath)/* overload */;
	virtual void __fastcall Enumerate(Winapi::Shlobj::PItemIDList aPIDL, System::TObject* aView, Lmdshbase::TLMDShellEnumOptions aEnumOptions);
	virtual Winapi::Shlobj::PItemIDList __fastcall GetNamespaceRootID(void);
	virtual Winapi::Shlobj::PItemIDList __fastcall GetComboExtID(void);
	_SHFILEINFOW __fastcall ID_Info(Winapi::Shlobj::PItemIDList aPIDL, unsigned aFlags, unsigned aAttr = (unsigned)(0x0));
	virtual bool __fastcall ID_HasChildren(Winapi::Shlobj::PItemIDList aPIDL, Lmdshbase::TLMDShellEnumOptions aEnumOptions);
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Clone(Winapi::Shlobj::PItemIDList aPIDL);
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_FindLast(Winapi::Shlobj::PItemIDList aPIDL);
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_CloneFirst(Winapi::Shlobj::PItemIDList aPIDL);
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Combine(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Next(Winapi::Shlobj::PItemIDList aPIDL);
	virtual bool __fastcall ID_RemoveLastID(Winapi::Shlobj::PItemIDList aPIDL);
	virtual System::Word __fastcall ID_Size(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall ID_Free(Winapi::Shlobj::PItemIDList aPIDL);
	Winapi::Shlobj::PItemIDList __fastcall ID_PathToPIDL(const System::UnicodeString aPath, _di_IShellFolder aParentFolder);
	_di_IShellFolder __fastcall ID_ParentFolder(Winapi::Shlobj::PItemIDList aPIDL);
	System::UnicodeString __fastcall ID_Name(Winapi::Shlobj::PItemIDList aPIDL, _di_IShellFolder aParentFolder, unsigned aFlags);
	bool __fastcall ID_HasAttribute(Winapi::Shlobj::PItemIDList aPIDL, _di_IShellFolder aParentFolder, unsigned aFlags);
	_WIN32_FIND_DATAW __fastcall ID_Data(Winapi::Shlobj::PItemIDList aPIDL, _di_IShellFolder aParentFolder);
	bool __fastcall ID_Equal(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	Vcl::Graphics::TIcon* __fastcall ID_Icon(Winapi::Shlobj::PItemIDList aPIDL, TLMDShGetIconOptions aOptions = TLMDShGetIconOptions() );
	unsigned __fastcall ID_Attributes(Winapi::Shlobj::PItemIDList aPIDL, _di_IShellFolder aParentFolder, unsigned aFlags);
	virtual int __fastcall ID_Compare(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2, Winapi::Shlobj::PItemIDList aAbsoluteID = (Winapi::Shlobj::PItemIDList)(0x0));
	virtual void __fastcall ChDir(Winapi::Shlobj::PItemIDList aPIDL)/* overload */;
	virtual void __fastcall ChDir(const System::UnicodeString aPath)/* overload */;
	virtual void __fastcall LevelUp(void);
	virtual void __fastcall GoBack(int index = 0xffffffff);
	virtual void __fastcall GoForward(int index = 0xffffffff);
	virtual bool __fastcall ExecuteDefault(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual bool __fastcall ShowPropertySheet(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual bool __fastcall CopyToClipboard(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual bool __fastcall CutToClipboard(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual bool __fastcall PasteFromClipboard(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual bool __fastcall RenameItem(Lmdshbase::TLMDCustomShellItem* aItem, const System::UnicodeString aNewName);
	virtual bool __fastcall DeleteItem(Lmdshbase::TLMDCustomShellItem* aItem);
	virtual System::UnicodeString __fastcall NewFolder(void);
	bool __fastcall CopyFiles(const System::UnicodeString aSource, const System::UnicodeString aDestination);
	bool __fastcall MoveFiles(const System::UnicodeString aSource, const System::UnicodeString aDestination);
	__property Winapi::Shlobj::PItemIDList ID_DesktopID = {read=GetDesktopID};
	__property _di_IShellFolder ID_DesktopFolder = {read=GetDesktopFolder};
	__property Vcl::Controls::TImageList* LargeFolderImages = {read=FLargeFolderImages};
	__property Vcl::Controls::TImageList* SmallFolderImages = {read=FSmallFolderImages};
	__property System::Classes::TStringList* ForwardPathList = {read=FForwardPathList};
	__property System::Classes::TStringList* BackwardPathList = {read=FBackwardPathList};
	__property bool ObserveChanges = {read=FObserveChanges, write=SetObserveChanges, default=1};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE _di_IContextMenu2 ContextMenu2;
extern DELPHI_PACKAGE bool __fastcall LMDShellFileOperation(System::UnicodeString aSource, System::UnicodeString aDestination, TLMDShellFileOperation Operation, TLMDShellFileOpFlags Options);
extern DELPHI_PACKAGE bool __fastcall LMDShellDoContextMenuVerb(System::TObject* aSender, _di_IShellFolder aFolder, const Lmdshpidl::PLMDShellPIDLArray aPIDL, NativeUInt aHandle, const System::UnicodeString aVerb)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDShellDoContextMenuVerb(System::TObject* aSender, _di_IShellFolder aFolder, Winapi::Shlobj::PItemIDList aPIDL, NativeUInt aHandle, const System::UnicodeString aVerb)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDShellDoContextMenuVerb(Vcl::Controls::TWinControl* Owner, Lmdshbase::TLMDCustomShellItem* aItem, const System::UnicodeString Verb)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDShellInvokeContextMenu(System::TObject* aSender, _di_IShellFolder aFolder, const Lmdshpidl::PLMDShellPIDLArray aPIDL, int aX, int aY, NativeUInt aHandle, unsigned aFlags, bool aSuppressCmd = false)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDShellInvokeContextMenu(System::TObject* aSender, _di_IShellFolder aFolder, Winapi::Shlobj::PItemIDList aPIDL, int aX, int aY, NativeUInt aHandle, unsigned aFlags, bool aSuppressCmd = false)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDShellInvokeContextMenu(System::TObject* aSender, Lmdtypes::TLMDString aFullName, int aX, int aY, NativeUInt aHandle, unsigned aFlags, bool aSuppressCmd = false)/* overload */;
}	/* namespace Lmdshcontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHCONTROLLER)
using namespace Lmdshcontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshcontrollerHPP
