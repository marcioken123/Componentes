// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeActns.pas' rev: 31.00 (Windows)

#ifndef LmdideactnsHPP
#define LmdideactnsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <LMDIdeCst.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgDesigner.hpp>
#include <LMDIdeUtils.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideactns
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDesignerAction;
class DELPHICLASS TLMDDsgAlignAction;
class DELPHICLASS TLMDAlignToGrid;
class DELPHICLASS TLMDAlignLeft;
class DELPHICLASS TLMDAlignRight;
class DELPHICLASS TLMDAlignHSpaceEqually;
class DELPHICLASS TLMDAlignHCenter;
class DELPHICLASS TLMDAlignHCenterInWindow;
class DELPHICLASS TLMDAlignTop;
class DELPHICLASS TLMDAlignBottom;
class DELPHICLASS TLMDAlignVSpaceEqually;
class DELPHICLASS TLMDAlignVCenter;
class DELPHICLASS TLMDAlignVCenterInWindow;
class DELPHICLASS TLMDDsgClipboardAction;
class DELPHICLASS TLMDDsgCut;
class DELPHICLASS TLMDDsgCopy;
class DELPHICLASS TLMDDsgPaste;
class DELPHICLASS TLMDDsgSelectAll;
class DELPHICLASS TLMDDsgDelSelected;
class DELPHICLASS TLMDDsgLockAction;
class DELPHICLASS TLMDDsgClearLocks;
class DELPHICLASS TLMDDsgLockSelected;
class DELPHICLASS TLMDDsgZOrderAction;
class DELPHICLASS TLMDDsgBringToFront;
class DELPHICLASS TLMDDsgSendToBack;
class DELPHICLASS TLMDDsgTabOrderDlg;
class DELPHICLASS TLMDDsgCreationOrderDlg;
class DELPHICLASS ILMDCurDesignerService;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDesignerAction : public Vcl::Actnlist::TAction
{
	typedef Vcl::Actnlist::TAction inherited;
	
private:
	Lmddsgdesigner::TLMDDesigner* FDesigner;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	void __fastcall SetDesigner(Lmddsgdesigner::TLMDDesigner* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	Lmddsgdesigner::TLMDDesigner* __fastcall GetActiveDesigner(void);
	
public:
	__fastcall virtual ~TLMDDesignerAction(void);
	virtual bool __fastcall Update(void);
	
__published:
	__property Lmddsgdesigner::TLMDDesigner* Designer = {read=FDesigner, write=SetDesigner};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
public:
	/* TAction.Create */ inline __fastcall virtual TLMDDesignerAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgAlignAction : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	virtual bool __fastcall Update(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgAlignAction(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDDsgAlignAction(System::Classes::TComponent* AOwner) : TLMDDesignerAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignToGrid : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignToGrid(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignToGrid(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignLeft : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignLeft(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignLeft(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignRight : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignRight(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignRight(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignHSpaceEqually : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignHSpaceEqually(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignHSpaceEqually(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignHCenter : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignHCenter(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignHCenter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignHCenterInWindow : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignHCenterInWindow(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignHCenterInWindow(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignTop : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignTop(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignTop(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignBottom : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignBottom(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignBottom(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignVSpaceEqually : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignVSpaceEqually(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignVSpaceEqually(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignVCenter : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignVCenter(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignVCenter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDAlignVCenterInWindow : public TLMDDsgAlignAction
{
	typedef TLMDDsgAlignAction inherited;
	
public:
	__fastcall virtual TLMDAlignVCenterInWindow(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDAlignVCenterInWindow(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgClipboardAction : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgClipboardAction(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDDsgClipboardAction(System::Classes::TComponent* AOwner) : TLMDDesignerAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgCut : public TLMDDsgClipboardAction
{
	typedef TLMDDsgClipboardAction inherited;
	
public:
	__fastcall virtual TLMDDsgCut(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Update(void);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgCut(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgCopy : public TLMDDsgClipboardAction
{
	typedef TLMDDsgClipboardAction inherited;
	
public:
	__fastcall virtual TLMDDsgCopy(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Update(void);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgCopy(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgPaste : public TLMDDsgClipboardAction
{
	typedef TLMDDsgClipboardAction inherited;
	
public:
	__fastcall virtual TLMDDsgPaste(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Update(void);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgPaste(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgSelectAll : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	__fastcall virtual TLMDDsgSelectAll(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgSelectAll(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgDelSelected : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	__fastcall virtual TLMDDsgDelSelected(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Update(void);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgDelSelected(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgLockAction : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgLockAction(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDDsgLockAction(System::Classes::TComponent* AOwner) : TLMDDesignerAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgClearLocks : public TLMDDsgLockAction
{
	typedef TLMDDsgLockAction inherited;
	
public:
	__fastcall virtual TLMDDsgClearLocks(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgClearLocks(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgLockSelected : public TLMDDsgLockAction
{
	typedef TLMDDsgLockAction inherited;
	
private:
	Lmddsgdesigner::TLMDDesignerLockMode FLockMode;
	
public:
	__fastcall virtual TLMDDsgLockSelected(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Update(void);
	DYNAMIC bool __fastcall Execute(void);
	
__published:
	__property Lmddsgdesigner::TLMDDesignerLockMode LockMode = {read=FLockMode, write=FLockMode, default=7};
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgLockSelected(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgZOrderAction : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	virtual bool __fastcall Update(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgZOrderAction(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TLMDDsgZOrderAction(System::Classes::TComponent* AOwner) : TLMDDesignerAction(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgBringToFront : public TLMDDsgZOrderAction
{
	typedef TLMDDsgZOrderAction inherited;
	
public:
	__fastcall virtual TLMDDsgBringToFront(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgBringToFront(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgSendToBack : public TLMDDsgZOrderAction
{
	typedef TLMDDsgZOrderAction inherited;
	
public:
	__fastcall virtual TLMDDsgSendToBack(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgSendToBack(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgTabOrderDlg : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	__fastcall virtual TLMDDsgTabOrderDlg(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgTabOrderDlg(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDsgCreationOrderDlg : public TLMDDesignerAction
{
	typedef TLMDDesignerAction inherited;
	
public:
	__fastcall virtual TLMDDsgCreationOrderDlg(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
public:
	/* TLMDDesignerAction.Destroy */ inline __fastcall virtual ~TLMDDsgCreationOrderDlg(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDCurDesignerService : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual Lmddsgdesigner::TLMDDesigner* __fastcall GetCurrentDesigner(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDCurDesignerService(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDCurDesignerService(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdideactns */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEACTNS)
using namespace Lmdideactns;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideactnsHPP
