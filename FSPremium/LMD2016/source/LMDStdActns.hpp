// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStdActns.pas' rev: 31.00 (Windows)

#ifndef LmdstdactnsHPP
#define LmdstdactnsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.StdActns.hpp>
#include <LMDUtils.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDActnList.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstdactns
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHintAction;
class DELPHICLASS TLMDUEditAction;
class DELPHICLASS TLMDUEditCut;
class DELPHICLASS TLMDUEditCopy;
class DELPHICLASS TLMDUEditPaste;
class DELPHICLASS TLMDUEditSelectAll;
class DELPHICLASS TLMDUEditUndo;
class DELPHICLASS TLMDUEditDelete;
class DELPHICLASS TLMDUWindowAction;
class DELPHICLASS TLMDUWindowClose;
class DELPHICLASS TLMDUWindowCascade;
class DELPHICLASS TLMDUWindowTileHorizontal;
class DELPHICLASS TLMDUWindowTileVertical;
class DELPHICLASS TLMDUWindowMinimizeAll;
class DELPHICLASS TLMDUWindowArrange;
class DELPHICLASS TLMDUHelpAction;
class DELPHICLASS TLMDUHelpContents;
class DELPHICLASS TLMDUHelpTopicSearch;
class DELPHICLASS TLMDUHelpOnHelp;
class DELPHICLASS TLMDUHelpContextAction;
class DELPHICLASS TLMDUCommonDialogAction;
class DELPHICLASS TLMDUFileAction;
class DELPHICLASS TLMDUFileOpen;
class DELPHICLASS TLMDUFileOpenWith;
class DELPHICLASS TLMDUFileSaveAs;
class DELPHICLASS TLMDUFilePrintSetup;
class DELPHICLASS TLMDUFilePageSetup;
class DELPHICLASS TLMDUFileExit;
class DELPHICLASS TLMDUSearchAction;
class DELPHICLASS TLMDUSearchFind;
class DELPHICLASS TLMDUSearchReplace;
class DELPHICLASS TLMDUSearchFindFirst;
class DELPHICLASS TLMDUSearchFindNext;
class DELPHICLASS TLMDUFontEdit;
class DELPHICLASS TLMDUColorSelect;
class DELPHICLASS TLMDUPrintDlg;
class DELPHICLASS TLMDUBrowseForFolder;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHintAction : public Vcl::Stdactns::THintAction
{
	typedef Vcl::Stdactns::THintAction inherited;
	
public:
	/* THintAction.Create */ inline __fastcall virtual TLMDHintAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THintAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDHintAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditAction : public Vcl::Stdactns::TEditAction
{
	typedef Vcl::Stdactns::TEditAction inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditAction(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditCut : public Vcl::Stdactns::TEditCut
{
	typedef Vcl::Stdactns::TEditCut inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditCut(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditCut(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditCut(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditCopy : public Vcl::Stdactns::TEditCopy
{
	typedef Vcl::Stdactns::TEditCopy inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditCopy(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditCopy(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditCopy(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditPaste : public Vcl::Stdactns::TEditPaste
{
	typedef Vcl::Stdactns::TEditPaste inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditPaste(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditPaste(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditPaste(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditSelectAll : public Vcl::Stdactns::TEditSelectAll
{
	typedef Vcl::Stdactns::TEditSelectAll inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditSelectAll(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditSelectAll(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditSelectAll(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditUndo : public Vcl::Stdactns::TEditUndo
{
	typedef Vcl::Stdactns::TEditUndo inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditUndo(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditUndo(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditUndo(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUEditDelete : public Vcl::Stdactns::TEditDelete
{
	typedef Vcl::Stdactns::TEditDelete inherited;
	
public:
	/* TEditAction.Destroy */ inline __fastcall virtual ~TLMDUEditDelete(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDUEditDelete(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TEditDelete(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowAction : public Vcl::Stdactns::TWindowAction
{
	typedef Vcl::Stdactns::TWindowAction inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowClose : public Vcl::Stdactns::TWindowClose
{
	typedef Vcl::Stdactns::TWindowClose inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowClose(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowClose(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowClose(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowCascade : public Vcl::Stdactns::TWindowCascade
{
	typedef Vcl::Stdactns::TWindowCascade inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowCascade(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowCascade(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowCascade(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowTileHorizontal : public Vcl::Stdactns::TWindowTileHorizontal
{
	typedef Vcl::Stdactns::TWindowTileHorizontal inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowTileHorizontal(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowTileHorizontal(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowTileHorizontal(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowTileVertical : public Vcl::Stdactns::TWindowTileVertical
{
	typedef Vcl::Stdactns::TWindowTileVertical inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowTileVertical(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowTileVertical(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowTileVertical(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowMinimizeAll : public Vcl::Stdactns::TWindowMinimizeAll
{
	typedef Vcl::Stdactns::TWindowMinimizeAll inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowMinimizeAll(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowMinimizeAll(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowMinimizeAll(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUWindowArrange : public Vcl::Stdactns::TWindowArrange
{
	typedef Vcl::Stdactns::TWindowArrange inherited;
	
public:
	/* TWindowAction.Create */ inline __fastcall virtual TLMDUWindowArrange(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TWindowArrange(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUWindowArrange(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUHelpAction : public Vcl::Stdactns::THelpAction
{
	typedef Vcl::Stdactns::THelpAction inherited;
	
public:
	/* THelpAction.Create */ inline __fastcall virtual TLMDUHelpAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THelpAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUHelpAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUHelpContents : public Vcl::Stdactns::THelpContents
{
	typedef Vcl::Stdactns::THelpContents inherited;
	
public:
	/* THelpAction.Create */ inline __fastcall virtual TLMDUHelpContents(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THelpContents(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUHelpContents(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUHelpTopicSearch : public Vcl::Stdactns::THelpTopicSearch
{
	typedef Vcl::Stdactns::THelpTopicSearch inherited;
	
public:
	/* THelpAction.Create */ inline __fastcall virtual TLMDUHelpTopicSearch(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THelpTopicSearch(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUHelpTopicSearch(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUHelpOnHelp : public Vcl::Stdactns::THelpOnHelp
{
	typedef Vcl::Stdactns::THelpOnHelp inherited;
	
public:
	/* THelpAction.Create */ inline __fastcall virtual TLMDUHelpOnHelp(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THelpOnHelp(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUHelpOnHelp(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUHelpContextAction : public Vcl::Stdactns::THelpContextAction
{
	typedef Vcl::Stdactns::THelpContextAction inherited;
	
public:
	/* THelpAction.Create */ inline __fastcall virtual TLMDUHelpContextAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::THelpContextAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUHelpContextAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUCommonDialogAction : public Vcl::Stdactns::TCommonDialogAction
{
	typedef Vcl::Stdactns::TCommonDialogAction inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUCommonDialogAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TCommonDialogAction(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUCommonDialogAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFileAction : public Vcl::Stdactns::TFileAction
{
	typedef Vcl::Stdactns::TFileAction inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUFileAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFileAction(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFileAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFileOpen : public Vcl::Stdactns::TFileOpen
{
	typedef Vcl::Stdactns::TFileOpen inherited;
	
public:
	/* TFileOpen.Create */ inline __fastcall virtual TLMDUFileOpen(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFileOpen(AOwner) { }
	
public:
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFileOpen(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFileOpenWith : public Vcl::Stdactns::TFileOpenWith
{
	typedef Vcl::Stdactns::TFileOpenWith inherited;
	
public:
	/* TFileOpen.Create */ inline __fastcall virtual TLMDUFileOpenWith(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFileOpenWith(AOwner) { }
	
public:
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFileOpenWith(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFileSaveAs : public Vcl::Stdactns::TFileSaveAs
{
	typedef Vcl::Stdactns::TFileSaveAs inherited;
	
public:
	/* TFileSaveAs.Create */ inline __fastcall virtual TLMDUFileSaveAs(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFileSaveAs(AOwner) { }
	
public:
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFileSaveAs(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFilePrintSetup : public Vcl::Stdactns::TFilePrintSetup
{
	typedef Vcl::Stdactns::TFilePrintSetup inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUFilePrintSetup(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFilePrintSetup(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFilePrintSetup(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFilePageSetup : public Vcl::Stdactns::TFilePageSetup
{
	typedef Vcl::Stdactns::TFilePageSetup inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUFilePageSetup(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFilePageSetup(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFilePageSetup(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFileExit : public Vcl::Stdactns::TFileExit
{
	typedef Vcl::Stdactns::TFileExit inherited;
	
public:
	/* TCustomAction.Create */ inline __fastcall virtual TLMDUFileExit(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFileExit(AOwner) { }
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUFileExit(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUSearchAction : public Vcl::Stdactns::TSearchAction
{
	typedef Vcl::Stdactns::TSearchAction inherited;
	
public:
	/* TSearchAction.Create */ inline __fastcall virtual TLMDUSearchAction(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TSearchAction(AOwner) { }
	/* TSearchAction.Destroy */ inline __fastcall virtual ~TLMDUSearchAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUSearchFind : public Vcl::Stdactns::TSearchFind
{
	typedef Vcl::Stdactns::TSearchFind inherited;
	
public:
	/* TSearchAction.Create */ inline __fastcall virtual TLMDUSearchFind(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TSearchFind(AOwner) { }
	/* TSearchAction.Destroy */ inline __fastcall virtual ~TLMDUSearchFind(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUSearchReplace : public Vcl::Stdactns::TSearchReplace
{
	typedef Vcl::Stdactns::TSearchReplace inherited;
	
public:
	/* TSearchAction.Create */ inline __fastcall virtual TLMDUSearchReplace(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TSearchReplace(AOwner) { }
	/* TSearchAction.Destroy */ inline __fastcall virtual ~TLMDUSearchReplace(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUSearchFindFirst : public Vcl::Stdactns::TSearchFindFirst
{
	typedef Vcl::Stdactns::TSearchFindFirst inherited;
	
public:
	/* TSearchFindFirst.Create */ inline __fastcall virtual TLMDUSearchFindFirst(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TSearchFindFirst(AOwner) { }
	
public:
	/* TSearchAction.Destroy */ inline __fastcall virtual ~TLMDUSearchFindFirst(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUSearchFindNext : public Vcl::Stdactns::TSearchFindNext
{
	typedef Vcl::Stdactns::TSearchFindNext inherited;
	
public:
	/* TSearchFindNext.Create */ inline __fastcall virtual TLMDUSearchFindNext(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TSearchFindNext(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDUSearchFindNext(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUFontEdit : public Vcl::Stdactns::TFontEdit
{
	typedef Vcl::Stdactns::TFontEdit inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUFontEdit(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TFontEdit(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUFontEdit(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUColorSelect : public Vcl::Stdactns::TColorSelect
{
	typedef Vcl::Stdactns::TColorSelect inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUColorSelect(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TColorSelect(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUColorSelect(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUPrintDlg : public Vcl::Stdactns::TPrintDlg
{
	typedef Vcl::Stdactns::TPrintDlg inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUPrintDlg(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TPrintDlg(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUPrintDlg(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUBrowseForFolder : public Vcl::Stdactns::TBrowseForFolder
{
	typedef Vcl::Stdactns::TBrowseForFolder inherited;
	
public:
	/* TCommonDialogAction.Create */ inline __fastcall virtual TLMDUBrowseForFolder(System::Classes::TComponent* AOwner) : Vcl::Stdactns::TBrowseForFolder(AOwner) { }
	/* TCommonDialogAction.Destroy */ inline __fastcall virtual ~TLMDUBrowseForFolder(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstdactns */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTDACTNS)
using namespace Lmdstdactns;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstdactnsHPP
