// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMakerConst.pas' rev: 34.00 (Windows)

#ifndef TeemakerconstHPP
#define TeemakerconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemakerconst
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMakerLanguages;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMakerLanguages : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall English();
	__classmethod void __fastcall Spanish();
public:
	/* TObject.Create */ inline __fastcall TMakerLanguages() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMakerLanguages() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::WideChar BlockAction_LeftClick = (System::WideChar)(0x30);
static const System::WideChar BlockAction_RightClick = (System::WideChar)(0x31);
static const System::WideChar BlockAction_LeftDrag = (System::WideChar)(0x32);
static const System::WideChar BlockAction_MouseEnter = (System::WideChar)(0x33);
static const System::WideChar BlockAction_MouseExit = (System::WideChar)(0x34);
static const System::WideChar BlockAction_RightDrag = (System::WideChar)(0x35);
static const System::WideChar BlockAction_LeftDoubleClick = (System::WideChar)(0x36);
static const System::WideChar BlockAction_RightDoubleClick = (System::WideChar)(0x37);
static const System::WideChar BlockAction_WheelDrag = (System::WideChar)(0x38);
static const System::WideChar BlockAction_LifeBirth = (System::WideChar)(0x39);
#define BlockAction_LifeDeath L"10"
extern DELPHI_PACKAGE System::UnicodeString TeeMakerVersion;
extern DELPHI_PACKAGE System::UnicodeString TeeMakerExtension;
extern DELPHI_PACKAGE System::UnicodeString TeeMakerLibRegistry;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_WebLibraryURL;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_DefaultFormat;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_TexturesLibrary;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ObjectsLibrary;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SoundsLibrary;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CannotFind;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ErrorCannotLink;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ErrorTesselator;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_OpenWithTeeMaker;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_TeeMakerFile;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureNewFile;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_TeeMakerWelcome;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerLibraryFolder;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerLibraryObjects;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerLibrarySounds;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerLibraryTextures;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_TeeMakerFiles;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureToDelete;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Untitled;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_TeeMaker;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerLoaded;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CannotFindFile;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_FileReadOnly;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SaveChanges;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CopyOfBlock;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_LinkToBlock;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Folder;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SelectLibraryFolder;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ObjectBlock;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CannotExecute;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ColorReplacer;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Animation;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Animations;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_NewAnimation;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_RenameAnimation;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_RotateBlockHelp;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MoveBlockHelp;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SizeBlockHelp;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureToReload;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureToConvertLink;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerBasic;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_WebLibrary;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_FolderToLink;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Link;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ErrorRenamingFolder;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ClearCaption;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_LoadCaption;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CachedFonts;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerWorld;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerRender;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_MakerBlocks;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CreateFolder;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_CannotSaveFile;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SelfBlock;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SystemObject;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseLeft;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseRight;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseLeftDrag;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseRightDrag;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseEnter;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseExit;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseLeftDoubleClick;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseRightDoubleClick;
extern DELPHI_PACKAGE System::UnicodeString Tee_MouseWheelDrag;
extern DELPHI_PACKAGE System::UnicodeString Tee_LifeBirth;
extern DELPHI_PACKAGE System::UnicodeString Tee_LifeDeath;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureToDeleteAction;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_SureToDeleteProperty;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_PropertyCannotBeEmpty;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_PropertyAlreadyExists;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_NewProperty;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_Property;
extern DELPHI_PACKAGE System::UnicodeString TeeMsg_ChangeProperty;
}	/* namespace Teemakerconst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMAKERCONST)
using namespace Teemakerconst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemakerconstHPP
