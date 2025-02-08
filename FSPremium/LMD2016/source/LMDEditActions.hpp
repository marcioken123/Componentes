// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEditActions.pas' rev: 31.00 (Windows)

#ifndef LmdeditactionsHPP
#define LmdeditactionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDBaseEdit.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDConst.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdeditactions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditAction;
class DELPHICLASS TLMDEditCut;
class DELPHICLASS TLMDEditCopy;
class DELPHICLASS TLMDEditPaste;
class DELPHICLASS TLMDEditSelectAll;
class DELPHICLASS TLMDEditUndo;
class DELPHICLASS TLMDEditRedo;
class DELPHICLASS TLMDEditDelete;
class DELPHICLASS TLMDEditFind;
class DELPHICLASS TLMDEditReplace;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEditAction : public Vcl::Actnlist::TAction
{
	typedef Vcl::Actnlist::TAction inherited;
	
private:
	Lmdbaseedit::TLMDBaseEdit* FControl;
	void __fastcall SetControl(Lmdbaseedit::TLMDBaseEdit* Value);
	
protected:
	virtual Lmdbaseedit::TLMDBaseEdit* __fastcall GetControl(System::TObject* Target);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	__property Lmdbaseedit::TLMDBaseEdit* Control = {read=FControl, write=SetControl};
public:
	/* TAction.Create */ inline __fastcall virtual TLMDEditAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditAction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditCut : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditCut(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditCut(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditCopy : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditCopy(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditCopy(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditPaste : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditPaste(System::Classes::TComponent* AOwner);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditPaste(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditSelectAll : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditSelectAll(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditSelectAll(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditUndo : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditUndo(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditUndo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditRedo : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditRedo(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditRedo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditDelete : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
public:
	__fastcall virtual TLMDEditDelete(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditDelete(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditFind : public TLMDEditAction
{
	typedef TLMDEditAction inherited;
	
private:
	Vcl::Dialogs::TFindDialog* FindDialog;
	void __fastcall FindDialogFind(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDEditFind(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditFind(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEditReplace : public TLMDEditFind
{
	typedef TLMDEditFind inherited;
	
private:
	Vcl::Dialogs::TReplaceDialog* ReplaceDialog;
	void __fastcall ReplaceDialogFind(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDEditReplace(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDEditReplace(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdeditactions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEDITACTIONS)
using namespace Lmdeditactions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeditactionsHPP
