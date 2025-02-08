// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeProjNodes.pas' rev: 31.00 (Windows)

#ifndef LmdideprojnodesHPP
#define LmdideprojnodesHPP

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
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDXML.hpp>
#include <LMDIdeClass.hpp>
#include <LMDIdeProjMgr.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideprojnodes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScriptUnit;
class DELPHICLASS TLMDScriptFormForm;
class DELPHICLASS TLMDScriptForm;
class DELPHICLASS TLMDScriptProject;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptUnit : public Lmdideprojmgr::TLMDProjDocument
{
	typedef Lmdideprojmgr::TLMDProjDocument inherited;
	
protected:
	virtual void __fastcall DrawImage(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall DoRead(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoWrite(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoLoad(const Lmdtypes::TLMDString AFilePath);
	virtual void __fastcall DoSave(const Lmdtypes::TLMDString AFilePath);
	virtual System::Classes::TStream* __fastcall DoOpenFileStream(const Lmdtypes::TLMDString AFileIdent);
	virtual Lmdtypes::TLMDString __fastcall DoGetDefaultBaseName(void);
	virtual Lmdtypes::TLMDString __fastcall DoGetFileExt(void);
public:
	/* TLMDProjDocument.Create */ inline __fastcall virtual TLMDScriptUnit(Lmdideprojmgr::TLMDProjectManager* AProjMgr, Lmdideprojmgr::TLMDProjNode* AParent) : Lmdideprojmgr::TLMDProjDocument(AProjMgr, AParent) { }
	/* TLMDProjDocument.Destroy */ inline __fastcall virtual ~TLMDScriptUnit(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptFormForm : public Lmdideprojmgr::TLMDProjNode
{
	typedef Lmdideprojmgr::TLMDProjNode inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall DoGetDisplayName(void);
	virtual void __fastcall DrawImage(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
public:
	/* TLMDProjNode.Create */ inline __fastcall virtual TLMDScriptFormForm(Lmdideprojmgr::TLMDProjectManager* AProjMgr, Lmdideprojmgr::TLMDProjNode* AParent) : Lmdideprojmgr::TLMDProjNode(AProjMgr, AParent) { }
	/* TLMDProjNode.Destroy */ inline __fastcall virtual ~TLMDScriptFormForm(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptForm : public TLMDScriptUnit
{
	typedef TLMDScriptUnit inherited;
	
private:
	Lmdtypes::TLMDString FFormName;
	void __fastcall SetFormName(const Lmdtypes::TLMDString Value);
	
protected:
	virtual void __fastcall DrawImage(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall DoRead(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoWrite(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoLoad(const Lmdtypes::TLMDString AFilePath);
	virtual void __fastcall DoSave(const Lmdtypes::TLMDString AFilePath);
	virtual System::Classes::TStream* __fastcall DoOpenFileStream(const Lmdtypes::TLMDString AFileIdent);
	
public:
	__fastcall virtual TLMDScriptForm(Lmdideprojmgr::TLMDProjectManager* AProjMgr, Lmdideprojmgr::TLMDProjNode* AParent);
	__property Lmdtypes::TLMDString FormName = {read=FFormName, write=SetFormName};
public:
	/* TLMDProjDocument.Destroy */ inline __fastcall virtual ~TLMDScriptForm(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptProject : public Lmdideprojmgr::TLMDProjDocument
{
	typedef Lmdideprojmgr::TLMDProjDocument inherited;
	
private:
	Lmdtypes::TLMDString FLanguageName;
	
protected:
	virtual void __fastcall DrawImage(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall DoRead(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoWrite(Lmdxml::_di_ILMDXmlElement AElem, bool AIsParentXml);
	virtual void __fastcall DoLoad(const Lmdtypes::TLMDString AFilePath);
	virtual void __fastcall DoSave(const Lmdtypes::TLMDString AFilePath);
	virtual Lmdtypes::TLMDString __fastcall DoGetDefaultBaseName(void);
	virtual Lmdtypes::TLMDString __fastcall DoGetFileExt(void);
	
public:
	__property Lmdtypes::TLMDString LanguageName = {read=FLanguageName, write=FLanguageName};
public:
	/* TLMDProjDocument.Create */ inline __fastcall virtual TLMDScriptProject(Lmdideprojmgr::TLMDProjectManager* AProjMgr, Lmdideprojmgr::TLMDProjNode* AParent) : Lmdideprojmgr::TLMDProjDocument(AProjMgr, AParent) { }
	/* TLMDProjDocument.Destroy */ inline __fastcall virtual ~TLMDScriptProject(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDRegisterStandardNodes(Lmdideprojmgr::TLMDProjectManager* AProjMgr);
}	/* namespace Lmdideprojnodes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEPROJNODES)
using namespace Lmdideprojnodes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideprojnodesHPP
