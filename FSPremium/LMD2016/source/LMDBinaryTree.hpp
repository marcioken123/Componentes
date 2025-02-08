// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBinaryTree.pas' rev: 34.00 (Windows)

#ifndef LmdbinarytreeHPP
#define LmdbinarytreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbinarytree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBinaryTreeNode;
class DELPHICLASS TLMDCompareMethod;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDBinaryTreeAddType : unsigned char { adtLeft, adtRight };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBinaryTreeNode : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::TObject* FData;
	TLMDBinaryTreeNode* FLeft;
	TLMDBinaryTreeNode* FRight;
	bool __fastcall GetIsLeaf();
	void __fastcall SetLeft(TLMDBinaryTreeNode* const Value);
	void __fastcall SetRight(TLMDBinaryTreeNode* const Value);
	
public:
	__fastcall TLMDBinaryTreeNode();
	__fastcall virtual ~TLMDBinaryTreeNode();
	System::TObject* __fastcall AddData(System::TObject* AnObject, TLMDBinaryTreeAddType AAddType);
	void __fastcall AddNode(TLMDBinaryTreeNode* ANode, TLMDBinaryTreeAddType AAddType);
	__property System::TObject* Data = {read=FData, write=FData};
	__property TLMDBinaryTreeNode* LeftNode = {read=FLeft, write=SetLeft};
	__property TLMDBinaryTreeNode* RightNode = {read=FRight, write=SetRight};
	__property bool IsLeaf = {read=GetIsLeaf, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompareMethod : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Byte FPriority;
	System::WideChar FSymbol;
	
public:
	__property System::WideChar Symbol = {read=FSymbol, write=FSymbol, nodefault};
	__property System::Byte Priority = {read=FPriority, write=FPriority, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDCompareMethod() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCompareMethod() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbinarytree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBINARYTREE)
using namespace Lmdbinarytree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbinarytreeHPP
