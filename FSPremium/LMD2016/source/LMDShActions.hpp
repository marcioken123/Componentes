// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShActions.pas' rev: 31.00 (Windows)

#ifndef LmdshactionsHPP
#define LmdshactionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.StdActns.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDShBase.hpp>
#include <LMDShFolder.hpp>
#include <LMDShList.hpp>
#include <LMDShDlg.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshactions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellAction;
class DELPHICLASS TLMDShellFolderAction;
class DELPHICLASS TLMDShellEditAction;
class DELPHICLASS TLMDShellDlgAction;
class DELPHICLASS TLMDShellEditShowProperties;
class DELPHICLASS TLMDShellEditCopyFiles;
class DELPHICLASS TLMDShellEditMoveFiles;
class DELPHICLASS TLMDShellEditCut;
class DELPHICLASS TLMDShellEditCopy;
class DELPHICLASS TLMDShellEditPaste;
class DELPHICLASS TLMDShellEditDelete;
class DELPHICLASS TLMDShellEditOpen;
class DELPHICLASS TLMDShellFilterDlg;
class DELPHICLASS TLMDShellMailTo;
class DELPHICLASS TLMDShellEditCopyFileNameAsText;
class DELPHICLASS TLMDShellEditCopyPathNameAsText;
class DELPHICLASS TLMDShellEditRename;
class DELPHICLASS TLMDShellEditSelectAll;
class DELPHICLASS TLMDShellEditInvertSelection;
class DELPHICLASS TLMDShellFolderCreateFolder;
class DELPHICLASS TLMDShellFolderBackward;
class DELPHICLASS TLMDShellFolderForward;
class DELPHICLASS TLMDShellFolderUpLevel;
class DELPHICLASS TLMDShellMapDrive;
class DELPHICLASS TLMDShellUnMapDrive;
class DELPHICLASS TLMDShellFindComputer;
class DELPHICLASS TLMDShellFindFiles;
class DELPHICLASS TLMDShellDiskFormat;
class DELPHICLASS TLMDShellDiskCopy;
class DELPHICLASS TLMDShellDiskLabelEdit;
class DELPHICLASS TLMDShellRun;
class DELPHICLASS TLMDShellOpenDosWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShellAction : public Vcl::Actnlist::TAction
{
	typedef Vcl::Actnlist::TAction inherited;
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDShellAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFolderAction : public TLMDShellAction
{
	typedef TLMDShellAction inherited;
	
private:
	Lmdshfolder::TLMDShellFolder* FFolder;
	void __fastcall SetFolder(Lmdshfolder::TLMDShellFolder* Value);
	
protected:
	virtual Lmdshfolder::TLMDShellFolder* __fastcall GetFolder(System::TObject* Target);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	
__published:
	__property Lmdshfolder::TLMDShellFolder* Folder = {read=FFolder, write=SetFolder};
public:
	/* TAction.Create */ inline __fastcall virtual TLMDShellFolderAction(System::Classes::TComponent* AOwner) : TLMDShellAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFolderAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditAction : public TLMDShellAction
{
	typedef TLMDShellAction inherited;
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
public:
	/* TAction.Create */ inline __fastcall virtual TLMDShellEditAction(System::Classes::TComponent* AOwner) : TLMDShellAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellDlgAction : public TLMDShellAction
{
	typedef TLMDShellAction inherited;
	
private:
	Lmdshbase::TLMDShellParentHandle FParent;
	
protected:
	__property Lmdshbase::TLMDShellParentHandle OwnerHandle = {read=FParent, write=FParent, default=0};
	
public:
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
public:
	/* TAction.Create */ inline __fastcall virtual TLMDShellDlgAction(System::Classes::TComponent* AOwner) : TLMDShellAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellDlgAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditShowProperties : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditShowProperties(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditShowProperties(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditCopyFiles : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
private:
	System::UnicodeString FDestination;
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgInstructionText;
	Lmdshbase::TLMDShellParentHandle FParent;
	
public:
	__fastcall virtual TLMDShellEditCopyFiles(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property Lmdshbase::TLMDShellParentHandle OwnerHandle = {read=FParent, write=FParent, default=0};
	__property System::UnicodeString DlgCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DlgInstructionText = {read=FDlgInstructionText, write=FDlgInstructionText};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditCopyFiles(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditMoveFiles : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
private:
	System::UnicodeString FDestination;
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgInstructionText;
	Lmdshbase::TLMDShellParentHandle FParent;
	
public:
	__fastcall virtual TLMDShellEditMoveFiles(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property Lmdshbase::TLMDShellParentHandle OwnerHandle = {read=FParent, write=FParent, default=0};
	__property System::UnicodeString DlgCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DlgInstructionText = {read=FDlgInstructionText, write=FDlgInstructionText};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditMoveFiles(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditCut : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditCut(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditCut(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditCopy : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditCopy(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditCopy(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditPaste : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditPaste(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditPaste(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditDelete : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditDelete(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditDelete(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellEditOpenMode : unsigned char { eomOpenWidth, eomOpen };

class PASCALIMPLEMENTATION TLMDShellEditOpen : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
private:
	TLMDShellEditOpenMode FMode;
	void __fastcall SetMode(const TLMDShellEditOpenMode Value);
	
public:
	__fastcall virtual TLMDShellEditOpen(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	
__published:
	__property TLMDShellEditOpenMode Mode = {read=FMode, write=SetMode, default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditOpen(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFilterDlg : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
private:
	int FCount;
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgInstructionText;
	Lmdshlist::TLMDShellList* FShellList;
	System::Classes::TStringList* FHistory;
	void __fastcall SetHistoryList(System::Classes::TStringList* const Value);
	void __fastcall SetShellList(Lmdshlist::TLMDShellList* const Value);
	
protected:
	virtual Lmdshlist::TLMDShellList* __fastcall GetList(System::TObject* Target);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDShellFilterDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellFilterDlg(void);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
	__property System::UnicodeString DlgCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DlgInstructionText = {read=FDlgInstructionText, write=FDlgInstructionText};
	__property Lmdshlist::TLMDShellList* ShellList = {read=FShellList, write=SetShellList};
	__property System::Classes::TStringList* HistoryList = {read=FHistory, write=SetHistoryList};
	__property int HistoryCount = {read=FCount, write=FCount, default=10};
};


class PASCALIMPLEMENTATION TLMDShellMailTo : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellMailTo(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellMailTo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditCopyFileNameAsText : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditCopyFileNameAsText(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditCopyFileNameAsText(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditCopyPathNameAsText : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditCopyPathNameAsText(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditCopyPathNameAsText(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditRename : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditRename(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditRename(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditSelectAll : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditSelectAll(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditSelectAll(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellEditInvertSelection : public TLMDShellEditAction
{
	typedef TLMDShellEditAction inherited;
	
public:
	__fastcall virtual TLMDShellEditInvertSelection(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellEditInvertSelection(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFolderCreateFolder : public TLMDShellFolderAction
{
	typedef TLMDShellFolderAction inherited;
	
public:
	__fastcall virtual TLMDShellFolderCreateFolder(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFolderCreateFolder(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFolderBackward : public TLMDShellFolderAction
{
	typedef TLMDShellFolderAction inherited;
	
public:
	__fastcall virtual TLMDShellFolderBackward(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFolderBackward(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFolderForward : public TLMDShellFolderAction
{
	typedef TLMDShellFolderAction inherited;
	
public:
	__fastcall virtual TLMDShellFolderForward(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFolderForward(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFolderUpLevel : public TLMDShellFolderAction
{
	typedef TLMDShellFolderAction inherited;
	
public:
	__fastcall virtual TLMDShellFolderUpLevel(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFolderUpLevel(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellMapDrive : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellMapDrive(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellMapDrive(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellUnMapDrive : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellUnMapDrive(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellUnMapDrive(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFindComputer : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellFindComputer(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFindComputer(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellFindFiles : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellFindFiles(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellFindFiles(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellDiskFormat : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellDiskFormat(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellDiskFormat(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellDiskCopy : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellDiskCopy(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellDiskCopy(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellDiskLabelEdit : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
public:
	__fastcall virtual TLMDShellDiskLabelEdit(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property OwnerHandle = {default=0};
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellDiskLabelEdit(void) { }
	
};


class PASCALIMPLEMENTATION TLMDShellRun : public TLMDShellDlgAction
{
	typedef TLMDShellDlgAction inherited;
	
private:
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgDescription;
	Vcl::Graphics::TIcon* FDlgIcon;
	Lmdshdlg::TLMDShellRunFileOptions FDlgOptions;
	System::Sysutils::TFileName FDlgWorkingPath;
	void __fastcall SetIcon(Vcl::Graphics::TIcon* Value);
	bool __fastcall StoreIcon(void);
	
public:
	__fastcall virtual TLMDShellRun(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellRun(void);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	
__published:
	__property System::UnicodeString DlgCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DlgDescription = {read=FDlgDescription, write=FDlgDescription};
	__property Vcl::Graphics::TIcon* DlgIcon = {read=FDlgIcon, write=SetIcon, stored=StoreIcon};
	__property Lmdshdlg::TLMDShellRunFileOptions DlgOptions = {read=FDlgOptions, write=FDlgOptions, default=0};
	__property System::Sysutils::TFileName DlgWorkingPath = {read=FDlgWorkingPath, write=FDlgWorkingPath};
	__property OwnerHandle = {default=0};
};


class PASCALIMPLEMENTATION TLMDShellOpenDosWindow : public TLMDShellFolderAction
{
	typedef TLMDShellFolderAction inherited;
	
public:
	__fastcall virtual TLMDShellOpenDosWindow(System::Classes::TComponent* aOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDShellOpenDosWindow(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshactions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHACTIONS)
using namespace Lmdshactions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshactionsHPP
