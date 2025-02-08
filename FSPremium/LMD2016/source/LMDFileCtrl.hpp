// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFileCtrl.pas' rev: 31.00 (Windows)

#ifndef LmdfilectrlHPP
#define LmdfilectrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <System.SysUtils.hpp>
#include <LMDShBase.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfilectrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFileCtrl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFileOpFlag : unsigned char { ffFilesOnly, ffNoActionConfirm, ffNoMKDIRConfirm, ffRenameFileOnCollision, ffShowNoErrors, ffShowNoProgress, ffSimpleProgress, ffUseRecycleBin };

typedef System::Set<TLMDFileOpFlag, TLMDFileOpFlag::ffFilesOnly, TLMDFileOpFlag::ffUseRecycleBin> TLMDFileOpFlags;

enum DECLSPEC_DENUM TLMDFileCtrlAttribute : unsigned char { fcaArchive, fcaDirectory, fcaHidden, fcaNormal, fcaOffline, fcaReadonly, fcaSystem, fcaTemporary, fcaCompressed };

typedef System::Set<TLMDFileCtrlAttribute, TLMDFileCtrlAttribute::fcaArchive, TLMDFileCtrlAttribute::fcaCompressed> TLMDFileCtrlAttributes;

enum DECLSPEC_DENUM TLMDFileOperation : unsigned char { foCopy, foRename, foMove, foDelete };

class PASCALIMPLEMENTATION TLMDFileCtrl : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	System::UnicodeString FFileStampFormat;
	System::Sysutils::TFileName FFileName;
	TLMDFileOpFlags FOptions;
	void __fastcall SetAttributes(TLMDFileCtrlAttributes aValue);
	TLMDFileCtrlAttributes __fastcall GetAttributes(void);
	bool __fastcall FileOps(System::UnicodeString aSource, System::UnicodeString aDestination, TLMDFileOperation Operation);
	int __fastcall GetFileBytes(void);
	void __fastcall SetFileBytes(int aDummy);
	System::UnicodeString __fastcall GetFileTimeb(int index);
	void __fastcall SetFileTimeb(int index, System::UnicodeString aValue);
	System::UnicodeString __fastcall GetFileType(void);
	void __fastcall SetFileType(System::UnicodeString aDummy);
	System::UnicodeString __fastcall GetExecuteable(void);
	System::UnicodeString __fastcall GetFileExtension(void);
	System::UnicodeString __fastcall GetShortAttrib(void);
	bool __fastcall GetFileExist(void);
	System::UnicodeString __fastcall GetFilePath(void);
	System::UnicodeString __fastcall GetFileNameOnly(void);
	void __fastcall SetFileName(const System::Sysutils::TFileName aValue);
	System::UnicodeString __fastcall GetFileIconPath(void);
	int __fastcall GetFileIconIndex(void);
	unsigned __fastcall GetSmallIconListHandle(void);
	unsigned __fastcall GetLargeIconListHandle(void);
	int __fastcall GetLargeIconHeight(void);
	int __fastcall GetSmallIconHeight(void);
	int __fastcall GetLargeIconWidth(void);
	int __fastcall GetSmallIconWidth(void);
	int __fastcall GetIconNum(void);
	
public:
	__fastcall virtual TLMDFileCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFileCtrl(void);
	bool __fastcall CopyFiles(System::UnicodeString aSource, System::UnicodeString aDestination);
	bool __fastcall DeleteFiles(System::UnicodeString aSource);
	bool __fastcall MoveFiles(System::UnicodeString aSource, System::UnicodeString aDestination);
	bool __fastcall RenameFiles(System::UnicodeString aSource, System::UnicodeString aDestination);
	void __fastcall GetLargeFileIcon(Vcl::Graphics::TIcon* &TempIcon);
	void __fastcall GetSmallFileIcon(Vcl::Graphics::TIcon* &TempIcon);
	void __fastcall GetLargeIconFromFile(unsigned aIndex, Vcl::Graphics::TIcon* &TempIcon);
	void __fastcall GetSmallIconFromFile(unsigned aIndex, Vcl::Graphics::TIcon* &TempIcon);
	void __fastcall ExtractIconsFromFile(Vcl::Imglist::TCustomImageList* &TempList, bool Small);
	__property System::UnicodeString FileIconPath = {read=GetFileIconPath};
	__property int FileIconSysIndex = {read=GetFileIconIndex, nodefault};
	__property unsigned SmallIconSysList = {read=GetSmallIconListHandle, nodefault};
	__property unsigned LargeIconSysList = {read=GetLargeIconListHandle, nodefault};
	__property int LargeIconHeight = {read=GetLargeIconHeight, nodefault};
	__property int SmallIconHeight = {read=GetSmallIconHeight, nodefault};
	__property int LargeIconWidth = {read=GetLargeIconWidth, nodefault};
	__property int SmallIconWidth = {read=GetSmallIconWidth, nodefault};
	__property int ExtractIconsNumber = {read=GetIconNum, nodefault};
	__property System::UnicodeString Executeable = {read=GetExecuteable};
	__property System::UnicodeString FileExtension = {read=GetFileExtension};
	__property System::UnicodeString ShortAttributes = {read=GetShortAttrib};
	__property bool FileExist = {read=GetFileExist, nodefault};
	__property System::UnicodeString FilePath = {read=GetFilePath};
	__property System::UnicodeString FileNameOnly = {read=GetFileNameOnly};
	
__published:
	__property About = {default=0};
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=SetFileName};
	__property TLMDFileCtrlAttributes Attributes = {read=GetAttributes, write=SetAttributes, stored=false, nodefault};
	__property TLMDFileOpFlags Options = {read=FOptions, write=FOptions, default=129};
	__property int FileSize = {read=GetFileBytes, write=SetFileBytes, stored=false, nodefault};
	__property System::UnicodeString FileCreateStamp = {read=GetFileTimeb, write=SetFileTimeb, stored=false, index=0};
	__property System::UnicodeString FileAccessStamp = {read=GetFileTimeb, write=SetFileTimeb, stored=false, index=1};
	__property System::UnicodeString FileWriteStamp = {read=GetFileTimeb, write=SetFileTimeb, stored=false, index=2};
	__property System::UnicodeString FileType = {read=GetFileType, write=SetFileType, stored=false};
	__property System::UnicodeString FileStampFormat = {read=FFileStampFormat, write=FFileStampFormat};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfilectrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILECTRL)
using namespace Lmdfilectrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfilectrlHPP
