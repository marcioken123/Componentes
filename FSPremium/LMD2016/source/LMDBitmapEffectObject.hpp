// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBitmapEffectObject.pas' rev: 31.00 (Windows)

#ifndef LmdbitmapeffectobjectHPP
#define LmdbitmapeffectobjectHPP

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
#include <LMDObject.hpp>
#include <LMDGraph.hpp>
#include <LMDAlphaObject.hpp>
#include <LMDBmp.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbitmapeffectobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBitmapEffectObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBitmapEffectObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdalphaobject::TLMDAlphaObject* FAlphaObject;
	bool FBufferValid;
	bool FInvert;
	bool FBuffered;
	bool FGrayScale;
	bool FFlipVert;
	bool FMonochrome;
	bool FFlipHoriz;
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdbmp::TLMDBrightness FBrightness;
	void __fastcall SetAlphaObject(Lmdalphaobject::TLMDAlphaObject* aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetBrightness(Lmdbmp::TLMDBrightness aValue);
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDBitmapEffectObject(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDBitmapEffectObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	bool __fastcall Enabled(void);
	void __fastcall Draw(Vcl::Graphics::TBitmap* target);
	void __fastcall DrawCopy(Vcl::Graphics::TBitmap* source, Vcl::Graphics::TBitmap* target);
	void __fastcall DrawCopyFromRect(Vcl::Graphics::TBitmap* source, const System::Types::TRect &sourceRect, Vcl::Graphics::TBitmap* target);
	void __fastcall DrawCopyRect(Vcl::Graphics::TBitmap* source, const System::Types::TRect &sourceRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt);
	void __fastcall DrawCutRect(Vcl::Graphics::TBitmap* source, const System::Types::TRect &sourceRect, Vcl::Graphics::TBitmap* target, const System::Types::TRect &targetRect);
	void __fastcall DrawCutRect2(Vcl::Graphics::TBitmap* source, const System::Types::TRect &sourceRect, Vcl::Graphics::TBitmap* target, const System::Types::TRect &targetRect);
	void __fastcall DestroyBuffer(void);
	__property Vcl::Graphics::TBitmap* BufferBitmap = {read=FBitmap};
	__property bool BufferValid = {read=FBufferValid, nodefault};
	
__published:
	__property Lmdalphaobject::TLMDAlphaObject* AlphaBlend = {read=FAlphaObject, write=SetAlphaObject};
	__property bool FlipVertical = {read=FFlipVert, write=SetBoolean, index=0, default=0};
	__property bool FlipHorizontal = {read=FFlipHoriz, write=SetBoolean, index=1, default=0};
	__property bool GrayScale = {read=FGrayScale, write=SetBoolean, index=2, default=0};
	__property bool Invert = {read=FInvert, write=SetBoolean, index=3, default=0};
	__property bool Buffered = {read=FBuffered, write=SetBoolean, index=4, default=0};
	__property Lmdbmp::TLMDBrightness Brightness = {read=FBrightness, write=SetBrightness, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbitmapeffectobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBITMAPEFFECTOBJECT)
using namespace Lmdbitmapeffectobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbitmapeffectobjectHPP
