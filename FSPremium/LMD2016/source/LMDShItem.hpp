// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShItem.pas' rev: 31.00 (Windows)

#ifndef LmdshitemHPP
#define LmdshitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.ShlObj.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ActiveX.hpp>
#include <LMDShBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshitem
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellItem;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellIconType : unsigned char { itSmallClosed, itSmallOpen, itLargeClosed, itLargeOpen };

enum DECLSPEC_DENUM TLMDShellFolderOption : unsigned char { foFolders, foNonFolders, foIncludeHidden, foHighlightCompressed, foFilterDirs };

typedef System::Set<TLMDShellFolderOption, TLMDShellFolderOption::foFolders, TLMDShellFolderOption::foFilterDirs> TLMDShellFolderOptions;

class PASCALIMPLEMENTATION TLMDShellItem : public Lmdshbase::TLMDCustomShellItem
{
	typedef Lmdshbase::TLMDCustomShellItem inherited;
	
private:
	_di_IShellFolder FParentFolder;
	bool FOpened;
	TLMDShellItem* FParentShellItem;
	Winapi::Shlobj::PItemIDList __fastcall GetPIDL(void);
	_di_IShellFolder __fastcall GetShellFolder(void);
	_di_IShellFolder2 __fastcall GetParentShellFolder2(void);
	int __fastcall GetImageIndex(TLMDShellIconType iType);
	void __fastcall UpdateAttributes(void);
	bool __fastcall CheckAttribute(unsigned aFlags);
	void __fastcall InitFromPIDL(Winapi::Shlobj::PItemIDList aPIDL, Lmdshbase::TLMDShellComponent* aController);
	void __fastcall InitFromPIDLs(Winapi::Shlobj::PItemIDList aParentPIDL, Winapi::Shlobj::PItemIDList aRelPIDL, Lmdshbase::TLMDShellComponent* aController);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual System::UnicodeString __fastcall GetShortFileName(void);
	virtual System::UnicodeString __fastcall GetPath(void);
	virtual System::UnicodeString __fastcall GetTypeName(void);
	virtual System::UnicodeString __fastcall GetExtDisplayName(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual unsigned __fastcall GetDWFileAttributes(void);
	virtual Lmdshbase::TLMDShellFileAttributes __fastcall GetFileAttributes(void);
	virtual System::UnicodeString __fastcall GetFileAttributesStr(void);
	virtual Lmdshbase::TLMDShellFolderProperties __fastcall GetFileProperties(void);
	virtual Lmdshbase::TLMDShellFolderCapabilities __fastcall GetFileCapabilities(void);
	virtual __int64 __fastcall GetFileSize(void);
	virtual System::TDateTime __fastcall GetModifiedDate(void);
	virtual System::TDateTime __fastcall GetAccessDate(void);
	virtual System::TDateTime __fastcall GetCreationDate(void);
	virtual int __fastcall GetIconIndex(void);
	virtual int __fastcall GetOpenIconIndex(void);
	virtual int __fastcall GetOverlayIconIndex(void);
	virtual Vcl::Graphics::TIcon* __fastcall GetLargeIcon(void);
	virtual Vcl::Graphics::TIcon* __fastcall GetLargeOpenIcon(void);
	virtual Vcl::Graphics::TIcon* __fastcall GetSmallIcon(void);
	virtual Vcl::Graphics::TIcon* __fastcall GetSmallOpenIcon(void);
	virtual int __fastcall GetDriveType(void);
	virtual bool __fastcall GetIsNamespaceRoot(void);
	virtual bool __fastcall GetIsFile(void);
	virtual bool __fastcall GetIsFileFolder(void);
	virtual bool __fastcall GetIsFileSystem(void);
	virtual bool __fastcall GetIsLink(void);
	virtual bool __fastcall GetIsShared(void);
	virtual bool __fastcall GetCanCopy(void);
	virtual bool __fastcall GetCanPaste(void);
	virtual bool __fastcall GetCanLink(void);
	virtual bool __fastcall GetCanRename(void);
	virtual bool __fastcall GetHasPropSheet(void);
	virtual bool __fastcall GetHasRemovableMedia(void);
	virtual bool __fastcall GetHasSubFolder(void);
	virtual bool __fastcall GetIsCompressed(void);
	virtual bool __fastcall GetIsDropTarget(void);
	virtual bool __fastcall GetIsFileSystemAncestor(void);
	virtual bool __fastcall GetIsFolder(void);
	virtual bool __fastcall GetIsGhosted(void);
	virtual bool __fastcall GetIsHidden(void);
	virtual bool __fastcall GetIsReadOnly(void);
	virtual System::Classes::TStringList* __fastcall GetDetails(void);
	virtual _di_IShellFolder __fastcall GetParentShellFolderIntf(void);
	virtual _di_IDropTarget __fastcall GetDropTargetIntf(void);
	virtual bool __fastcall GetDetailsEx(int ColID, System::UnicodeString &Res);
	
public:
	__fastcall TLMDShellItem(Winapi::Shlobj::PItemIDList aPIDL, Lmdshbase::TLMDShellComponent* aController);
	__fastcall TLMDShellItem(Winapi::Shlobj::PItemIDList aParentPIDL, Winapi::Shlobj::PItemIDList aRelPIDL, Lmdshbase::TLMDShellComponent* aController);
	__fastcall TLMDShellItem(const System::UnicodeString aPath, Lmdshbase::TLMDShellComponent* aController);
	__fastcall virtual ~TLMDShellItem(void);
	virtual void __fastcall Assign(Lmdshbase::TLMDCustomShellItem* aSource);
	virtual void __fastcall LoadDetailsEx(const int *ColIDs, const int ColIDs_High);
	void __fastcall GetIcon(TLMDShellIconType iType, Vcl::Graphics::TIcon* aIcon);
	bool __fastcall IsDesktop(void);
	bool __fastcall HasSubItems(TLMDShellFolderOptions aOptions);
	int __fastcall ExecuteDefault(void);
	virtual void __fastcall Delete(void);
	__property _di_IShellFolder ParentFolder = {read=FParentFolder};
	__property Winapi::Shlobj::PItemIDList PIDL = {read=GetPIDL};
	__property _di_IShellFolder ParentShellFolder = {read=FParentFolder};
	__property System::UnicodeString PathName = {read=GetPath};
	__property Lmdshbase::TLMDShellFolderCapabilities Capabilities = {read=GetFileCapabilities, nodefault};
	__property Lmdshbase::TLMDShellFolderProperties Properties = {read=GetFileProperties, nodefault};
	__property _di_IShellFolder2 ParentShellFolder2 = {read=GetParentShellFolder2};
	__property bool Opened = {read=FOpened, nodefault};
	__property TLMDShellItem* ParentShellItem = {read=FParentShellItem};
	__property int ImageIndex[TLMDShellIconType iType] = {read=GetImageIndex};
	__property _di_IShellFolder ShellFolder = {read=GetShellFolder};
public:
	/* TLMDCustomShellItem.Create */ inline __fastcall virtual TLMDShellItem(Lmdshbase::TLMDShellComponent* aController) : Lmdshbase::TLMDCustomShellItem(aController) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshitem */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHITEM)
using namespace Lmdshitem;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshitemHPP
