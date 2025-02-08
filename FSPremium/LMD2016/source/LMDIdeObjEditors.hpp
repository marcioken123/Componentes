// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeObjEditors.pas' rev: 31.00 (Windows)

#ifndef LmdideobjeditorsHPP
#define LmdideobjeditorsHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <LMDIdeObjEdrMgr.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideobjeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCollectionObjEditor;
class DELPHICLASS TLMDMenuObjEditor;
class DELPHICLASS TLMDActionListObjEditor;
class DELPHICLASS TLMDPageControlObjEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCollectionObjEditor : public Lmdideobjedrmgr::TLMDObjectEditor
{
	typedef Lmdideobjedrmgr::TLMDObjectEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual Lmdtypes::TLMDString __fastcall GetVerb(int AIndex);
	virtual void __fastcall ExecuteVerb(int AIndex);
public:
	/* TLMDObjectEditor.Create */ inline __fastcall virtual TLMDCollectionObjEditor(Lmdideobjedrmgr::TLMDObjectEditorManager* AOwner, System::Classes::TPersistent* AInstance) : Lmdideobjedrmgr::TLMDObjectEditor(AOwner, AInstance) { }
	/* TLMDObjectEditor.Destroy */ inline __fastcall virtual ~TLMDCollectionObjEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMenuObjEditor : public Lmdideobjedrmgr::TLMDObjectEditor
{
	typedef Lmdideobjedrmgr::TLMDObjectEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual Lmdtypes::TLMDString __fastcall GetVerb(int AIndex);
	virtual void __fastcall ExecuteVerb(int AIndex);
public:
	/* TLMDObjectEditor.Create */ inline __fastcall virtual TLMDMenuObjEditor(Lmdideobjedrmgr::TLMDObjectEditorManager* AOwner, System::Classes::TPersistent* AInstance) : Lmdideobjedrmgr::TLMDObjectEditor(AOwner, AInstance) { }
	/* TLMDObjectEditor.Destroy */ inline __fastcall virtual ~TLMDMenuObjEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDActionListObjEditor : public Lmdideobjedrmgr::TLMDObjectEditor
{
	typedef Lmdideobjedrmgr::TLMDObjectEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual Lmdtypes::TLMDString __fastcall GetVerb(int AIndex);
	virtual void __fastcall ExecuteVerb(int AIndex);
public:
	/* TLMDObjectEditor.Create */ inline __fastcall virtual TLMDActionListObjEditor(Lmdideobjedrmgr::TLMDObjectEditorManager* AOwner, System::Classes::TPersistent* AInstance) : Lmdideobjedrmgr::TLMDObjectEditor(AOwner, AInstance) { }
	/* TLMDObjectEditor.Destroy */ inline __fastcall virtual ~TLMDActionListObjEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPageControlObjEditor : public Lmdideobjedrmgr::TLMDObjectEditor
{
	typedef Lmdideobjedrmgr::TLMDObjectEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual Lmdtypes::TLMDString __fastcall GetVerb(int AIndex);
	virtual void __fastcall ExecuteVerb(int AIndex);
public:
	/* TLMDObjectEditor.Create */ inline __fastcall virtual TLMDPageControlObjEditor(Lmdideobjedrmgr::TLMDObjectEditorManager* AOwner, System::Classes::TPersistent* AInstance) : Lmdideobjedrmgr::TLMDObjectEditor(AOwner, AInstance) { }
	/* TLMDObjectEditor.Destroy */ inline __fastcall virtual ~TLMDPageControlObjEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdideobjeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEOBJEDITORS)
using namespace Lmdideobjeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideobjeditorsHPP
