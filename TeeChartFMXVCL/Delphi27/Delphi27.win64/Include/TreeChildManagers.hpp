// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeChildManagers.pas' rev: 34.00 (Windows)

#ifndef TreechildmanagersHPP
#define TreechildmanagersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <TeeTree.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treechildmanagers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeExplorerAlignRight;
class DELPHICLASS TTreeCircularAlignChild;
class DELPHICLASS TTreeSideAlignChild;
class DELPHICLASS TTreeTopBottomAlignChild;
class DELPHICLASS TTreeLeftRightAlignChild;
class DELPHICLASS TTreeListViewAlignChild;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeExplorerAlignRight : public Teetree::TTreeExplorerAlignChild
{
	typedef Teetree::TTreeExplorerAlignChild inherited;
	
public:
	__fastcall TTreeExplorerAlignRight();
	virtual System::Types::TPoint __fastcall CalcXYCross(Teetree::TTreeNodeShape* const ANode, Teetree::TTreeNodeShape* const AParent);
	virtual int __fastcall XPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeExplorerAlignRight() { }
	
};


class PASCALIMPLEMENTATION TTreeCircularAlignChild : public Teetree::TChildManager
{
	typedef Teetree::TChildManager inherited;
	
private:
	int FOffset;
	int FTotalAngle;
	int FXRadius;
	int FYRadius;
	int FYOffset;
	int FXOffset;
	double __fastcall AngleNode(Teetree::TTreeNodeShape* const ANode);
	
public:
	__fastcall TTreeCircularAlignChild();
	virtual System::Types::TPoint __fastcall CalcXYCross(Teetree::TTreeNodeShape* const ANode, Teetree::TTreeNodeShape* const AParent);
	virtual bool __fastcall DrawConnection(Teetree::TTreeConnection* const AConnection);
	virtual int __fastcall XPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	virtual int __fastcall YPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	__property int AngleOffset = {read=FOffset, write=FOffset, default=0};
	__property int TotalAngle = {read=FTotalAngle, write=FTotalAngle, default=360};
	__property int XOffset = {read=FXOffset, write=FXOffset, default=0};
	__property int XRadius = {read=FXRadius, write=FXRadius, default=100};
	__property int YOffset = {read=FYOffset, write=FYOffset, default=0};
	__property int YRadius = {read=FYRadius, write=FYRadius, default=100};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeCircularAlignChild() { }
	
};


class PASCALIMPLEMENTATION TTreeSideAlignChild : public Teetree::TChildManager
{
	typedef Teetree::TChildManager inherited;
	
private:
	int FCrossMargin;
	int FHorizMargin;
	int FToShapeOffset;
	int FVertMargin;
	
public:
	__fastcall virtual TTreeSideAlignChild();
	__property int CrossMargin = {read=FCrossMargin, write=FCrossMargin, nodefault};
	__property int HorizMargin = {read=FHorizMargin, write=FHorizMargin, nodefault};
	__property int ToShapeOffset = {read=FToShapeOffset, write=FToShapeOffset, nodefault};
	__property int VertMargin = {read=FVertMargin, write=FVertMargin, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeSideAlignChild() { }
	
};


class PASCALIMPLEMENTATION TTreeTopBottomAlignChild : public TTreeSideAlignChild
{
	typedef TTreeSideAlignChild inherited;
	
public:
	__fastcall virtual TTreeTopBottomAlignChild();
	virtual System::Types::TPoint __fastcall CalcXYCross(Teetree::TTreeNodeShape* const ANode, Teetree::TTreeNodeShape* const AParent);
	virtual bool __fastcall DrawConnection(Teetree::TTreeConnection* const AConnection);
	virtual int __fastcall XPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	virtual int __fastcall YPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeTopBottomAlignChild() { }
	
};


class PASCALIMPLEMENTATION TTreeLeftRightAlignChild : public TTreeSideAlignChild
{
	typedef TTreeSideAlignChild inherited;
	
public:
	__fastcall virtual TTreeLeftRightAlignChild();
	virtual System::Types::TPoint __fastcall CalcXYCross(Teetree::TTreeNodeShape* const ANode, Teetree::TTreeNodeShape* const AParent);
	virtual bool __fastcall DrawConnection(Teetree::TTreeConnection* const AConnection);
	virtual int __fastcall XPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	virtual int __fastcall YPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeLeftRightAlignChild() { }
	
};


class PASCALIMPLEMENTATION TTreeListViewAlignChild : public Teetree::TChildManager
{
	typedef Teetree::TChildManager inherited;
	
private:
	int RowCount;
	int RowHeight;
	int FHorizMargin;
	int FVertMargin;
	int IHeight;
	int IWidth;
	void __fastcall CalculateSizes(Teetree::TTreeNodeShape* const ANode);
	void __fastcall SetVertMargin(const int Value);
	void __fastcall SetHorizMargin(const int Value);
	
public:
	int ColWidth;
	__fastcall virtual TTreeListViewAlignChild();
	virtual System::Types::TPoint __fastcall CalcXYCross(Teetree::TTreeNodeShape* const ANode, Teetree::TTreeNodeShape* const AParent);
	virtual bool __fastcall DrawConnection(Teetree::TTreeConnection* const AConnection);
	virtual int __fastcall XPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	virtual int __fastcall YPosition(Teetree::TTreeNodeShape* const ANode, int ABrotherIndex);
	__property int HorizMargin = {read=FHorizMargin, write=SetHorizMargin, default=5};
	__property int VertMargin = {read=FVertMargin, write=SetVertMargin, default=2};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreeListViewAlignChild() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treechildmanagers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREECHILDMANAGERS)
using namespace Treechildmanagers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreechildmanagersHPP
