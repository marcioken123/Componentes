// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTree.pas' rev: 31.00 (Windows)

#ifndef LmdtreeHPP
#define LmdtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDWriter.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTree;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTree : public Lmdtext::TLMDParsedTextList
{
	typedef Lmdtext::TLMDParsedTextList inherited;
	
private:
	int FOffset;
	int FWidth;
	int FHeight;
	bool FRoot;
	int __fastcall GetDataCount(void);
	int __fastcall GetItemCount(void);
	Lmdtext::TLMDBaseText* __fastcall GetData(int index);
	TLMDTree* __fastcall GetItem(int index);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDTree(Lmdtext::TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDTree(Lmdtext::TLMDParsedTextList* aParent, bool aRoot)/* overload */;
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual Lmdtext::TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property int Offset = {read=FOffset, write=FOffset, nodefault};
	__property int DataCount = {read=GetDataCount, nodefault};
	__property Lmdtext::TLMDBaseText* Data[int index] = {read=GetData};
	__property int ItemCount = {read=GetItemCount, nodefault};
	__property TLMDTree* Item[int index] = {read=GetItem};
	__property bool Root = {read=FRoot, nodefault};
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDTree(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTREE)
using namespace Lmdtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtreeHPP
