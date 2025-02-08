// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeSprigs.pas' rev: 31.00 (Windows)

#ifndef LmdidesprigsHPP
#define LmdidesprigsHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <LMDIdeCompTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidesprigs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDComponentSprig;
class DELPHICLASS TLMDCollectionSprig;
class DELPHICLASS TLMDCollectionItemSprig;
class DELPHICLASS TLMDControlSprig;
class DELPHICLASS TLMDWinControlSprig;
class DELPHICLASS TLMDRootControlSprig;
class DELPHICLASS TLMDFormSprig;
class DELPHICLASS TLMDFrameSprig;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDComponentSprig : public Lmdidecomptree::TLMDSprig
{
	typedef Lmdidecomptree::TLMDSprig inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	virtual Lmdidecomptree::TLMDSprigImageKind __fastcall GetImageKind(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDComponentSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : Lmdidecomptree::TLMDSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDComponentSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCollectionSprig : public Lmdidecomptree::TLMDSprig
{
	typedef Lmdidecomptree::TLMDSprig inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetDisplayName(void);
	virtual void __fastcall CreateChildren(Lmdidecomptree::TLMDGetSprigClassProc AGetEditorClassProc);
	virtual Lmdidecomptree::TLMDSprigImageKind __fastcall GetImageKind(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDCollectionSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : Lmdidecomptree::TLMDSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDCollectionSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCollectionItemSprig : public Lmdidecomptree::TLMDSprig
{
	typedef Lmdidecomptree::TLMDSprig inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetDisplayName(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDCollectionItemSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : Lmdidecomptree::TLMDSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDCollectionItemSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDControlSprig : public TLMDComponentSprig
{
	typedef TLMDComponentSprig inherited;
	
protected:
	virtual Lmdidecomptree::TLMDSprigImageKind __fastcall GetImageKind(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDControlSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : TLMDComponentSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDControlSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWinControlSprig : public TLMDControlSprig
{
	typedef TLMDControlSprig inherited;
	
protected:
	virtual Lmdidecomptree::TLMDSprigImageKind __fastcall GetImageKind(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDWinControlSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : TLMDControlSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDWinControlSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRootControlSprig : public TLMDWinControlSprig
{
	typedef TLMDWinControlSprig inherited;
	
protected:
	virtual void __fastcall CreateChildren(Lmdidecomptree::TLMDGetSprigClassProc AGetEditorClassProc);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDRootControlSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : TLMDWinControlSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDRootControlSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFormSprig : public TLMDRootControlSprig
{
	typedef TLMDRootControlSprig inherited;
	
protected:
	virtual Lmdidecomptree::TLMDSprigImageKind __fastcall GetImageKind(void);
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDFormSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : TLMDRootControlSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDFormSprig(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFrameSprig : public TLMDRootControlSprig
{
	typedef TLMDRootControlSprig inherited;
	
public:
	/* TLMDSprig.Create */ inline __fastcall virtual TLMDFrameSprig(Lmdidecomptree::TLMDComponentTree* ATree, Lmdidecomptree::TLMDSprig* AParent, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName) : TLMDRootControlSprig(ATree, AParent, AInstance, APropName) { }
	/* TLMDSprig.Destroy */ inline __fastcall virtual ~TLMDFrameSprig(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdidesprigs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDESPRIGS)
using namespace Lmdidesprigs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidesprigsHPP
