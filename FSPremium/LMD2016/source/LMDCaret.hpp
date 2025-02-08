// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCaret.pas' rev: 31.00 (Windows)

#ifndef LmdcaretHPP
#define LmdcaretHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <LMDObject.hpp>
#include <LMDGraph.hpp>
#include <LMDCont.hpp>
#include <LMDUtils.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcaret
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaret;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDCaretStyles : unsigned char { csDefault, csBlock, csUnder, csOver, csBitmap, csUnderBlock };

enum DECLSPEC_DENUM TLMDCaretBitmap : unsigned char { cbBmpSize, cbTile, cbStretch };

class PASCALIMPLEMENTATION TLMDCaret : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Types::TPoint FPos;
	Vcl::Graphics::TBitmap* FHBmp;
	Vcl::Graphics::TBitmap* FBitmap;
	Vcl::Imglist::TCustomImageList* FImageList;
	System::Word FFontHeight;
	System::Word FOldBlinkRate;
	System::Word FWidth;
	System::Word FHeight;
	System::Word FImageIndex;
	System::Word FListIndex;
	System::Word FBlinkRate;
	TLMDCaretStyles FStyle;
	Lmdcustomcontrol::TLMDCustomControl* FOwner;
	bool FCanEnable;
	bool FCreated;
	bool FEnabled;
	TLMDCaretBitmap FCaretBmp;
	int __fastcall GetPos(int Index);
	void __fastcall SetPos(int Index, int aValue);
	void __fastcall SetStyle(TLMDCaretStyles aValue);
	void __fastcall SetWord(int Index, System::Word aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	
public:
	__fastcall TLMDCaret(Lmdcustomcontrol::TLMDCustomControl* Owner);
	void __fastcall BuildCaret(void);
	void __fastcall DestroyCaret(void);
	__fastcall virtual ~TLMDCaret(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall GetIMLChange(System::TObject* Sender);
	void __fastcall Enable(void);
	void __fastcall Disable(void);
	void __fastcall SetCaretPos(int X, int Y);
	__property System::Word FontHeight = {read=FFontHeight, write=SetWord, index=4, nodefault};
	__property bool Enabled = {read=FEnabled, default=0};
	__property int Row = {read=GetPos, write=SetPos, index=0, nodefault};
	__property int Col = {read=GetPos, write=SetPos, index=1, nodefault};
	
__published:
	__property System::Word BlinkRate = {read=FBlinkRate, write=FBlinkRate, nodefault};
	__property TLMDCaretStyles Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Word Width = {read=FWidth, write=SetWord, index=0, default=2};
	__property System::Word Height = {read=FHeight, write=SetWord, index=1, default=10};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property System::Word ImageIndex = {read=FImageIndex, write=SetWord, index=2, default=0};
	__property System::Word ListIndex = {read=FListIndex, write=SetWord, index=3, default=0};
	__property TLMDCaretBitmap CaretBmpMode = {read=FCaretBmp, write=FCaretBmp, default=0};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property bool CanEnable = {read=FCanEnable, write=FCanEnable, default=1};
protected:
	/* TLMDObject.Create */ inline __fastcall virtual TLMDCaret(System::Classes::TPersistent* Owner) : Lmdobject::TLMDObject(Owner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcaret */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCARET)
using namespace Lmdcaret;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcaretHPP
