// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonBase.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonbaseHPP
#define LmdbuttonbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonFace;
struct TLMDButtonFaceIndex;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDButtonState : unsigned char { bsUp, bsDisabledUp, bsMouseOver, bsOptionSet, bsDown, bsDragOver, bsDropDownOpen, bsDisabledDown, bsDefaultEd };

enum DECLSPEC_DENUM TLMDUserButtonStyle : unsigned char { ubsWin31, ubsWin40, ubsDelphi, ubsDelphiFlat, ubsFlat, ubsFlatUnColored, ubsNavigator, ubsExplorer, ubsExplorerColored, ubsIntegrated, ubsCombo, ubsOffice, ubsOfficeTransp, ubsWin40Ext };

enum DECLSPEC_DENUM TLMDGlyphKind : unsigned char { gkCustom, gkEllipsis, gkFile, gkFolder, gkCalculator, gkCalender, gkSearch, gkColor, gkFont };

enum DECLSPEC_DENUM TLMDArrowPosition : unsigned char { apRightText, apLeftText, apRightGlyph, apLeftGlyph };

enum DECLSPEC_DENUM TLMDNormalButtonStyle : unsigned char { nbsAutoDetect, nbsWin31, nbsWin40 };

typedef System::StaticArray<System::UnicodeString, 3> Lmdbuttonbase__1;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonFace : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDButtonFace(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDButtonFace(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDButtonFaceIndex
{
public:
	System::Word ListIndex;
	System::Word ImageIndex;
};
#pragma pack(pop)


typedef System::StaticArray<TLMDButtonFaceIndex, 9> TLMDButtonFaceIndices;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 BDF_ROUNDED = System::Int8(0x1);
static const System::Int8 BDF_FOCUSED = System::Int8(0x2);
static const System::Int8 BDF_SPEEDBUTTON = System::Int8(0x4);
static const System::Int8 BDF_EXTDOWNSTYLE = System::Int8(0x8);
static const System::Int8 BDF_MIDDLE = System::Int8(0x10);
static const System::Int8 BDF_DEFAULT = System::Int8(0x20);
static const System::Int8 BDF_MOUSEOVER = System::Int8(0x40);
static const System::Byte BDF_SPLIT = System::Byte(0x80);
static const System::Word BDF_SPLITPARTTWO = System::Word(0x100);
static const System::Word BDF_CTLXP = System::Word(0x200);
static const System::Int8 LMDBTNTIMERBORDER = System::Int8(0x0);
static const System::Int8 LMDBTNTIMERREPEATED = System::Int8(0x1);
extern DELPHI_PACKAGE Lmdbuttonbase__1 TLMDNormalBtnStyleString;
extern DELPHI_PACKAGE void __fastcall LMDButtonReadExtStyle(System::Classes::TReader* Reader, TLMDUserButtonStyle &aExtStyle, bool &aXP);
extern DELPHI_PACKAGE bool __fastcall LMDIsXPToolButton(const TLMDUserButtonStyle Value);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetButtonBevel(TLMDUserButtonStyle Style, TLMDButtonState State);
extern DELPHI_PACKAGE TLMDButtonFaceIndex __fastcall LMDMMReturnFaceIndex(int ListIndex, int ImageIndex);
extern DELPHI_PACKAGE void __fastcall LMDMMSynchronize(TLMDButtonFaceIndices &aValue, bool HotState = false);
extern DELPHI_PACKAGE void __fastcall LMDMMInitFace(TLMDButtonFaceIndices &aValue);
extern DELPHI_PACKAGE void __fastcall LMDMMCopyFace(TLMDButtonFaceIndices &aTarget, const TLMDButtonFaceIndices &aSource);
}	/* namespace Lmdbuttonbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONBASE)
using namespace Lmdbuttonbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonbaseHPP
