// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeRain.pas' rev: 34.00 (Windows)

#ifndef TeerainHPP
#define TeerainHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeWater.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teerain
{
//-- forward type declarations -----------------------------------------------
struct TElement;
class DELPHICLASS TElementsBlock;
class DELPHICLASS TRainBlock;
class DELPHICLASS TStarsBlock;
class DELPHICLASS TSkydomeBlock;
class DELPHICLASS TRainEditor;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TElement
{
public:
	System::Math::Vectors::TPoint3D Location;
	System::Math::Vectors::TPoint3D Size;
	System::Math::Vectors::TPoint3D Speed;
};


class PASCALIMPLEMENTATION TElementsBlock : public Teewater::TAnimatedBlock
{
	typedef Teewater::TAnimatedBlock inherited;
	
	
private:
	typedef System::DynamicArray<TElement> _TElementsBlock__1;
	
	
private:
	int FCount;
	_TElementsBlock__1 IElements;
	void __fastcall SetCount(const int Value);
	
protected:
	virtual void __fastcall InitElements(int StartIndex);
	
public:
	__fastcall virtual ~TElementsBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int ElementCount = {read=FCount, write=SetCount, nodefault};
public:
	/* TAnimatedBlock.Create */ inline __fastcall virtual TElementsBlock(System::Classes::TComponent* AOwner) : Teewater::TAnimatedBlock(AOwner) { }
	
};


class PASCALIMPLEMENTATION TRainBlock : public TElementsBlock
{
	typedef TElementsBlock inherited;
	
private:
	int FLength;
	bool FSound;
	bool IPlayingSound;
	bool FRandomLength;
	void __fastcall SetDropLength(const int Value);
	void __fastcall SetSound(const bool Value);
	void __fastcall SetRandomLength(const bool Value);
	
protected:
	virtual void __fastcall DoAnimation(Vcltee::Teeanimate::TTeeAnimation* Sender, const float Fraction);
	virtual void __fastcall InitElements(int StartIndex);
	void __fastcall InitLengths(int StartIndex);
	virtual void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall virtual TRainBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRainBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	void __fastcall PlaySound();
	void __fastcall StopSound();
	
__published:
	__property int DropLength = {read=FLength, write=SetDropLength, default=15};
	__property ElementCount = {default=100};
	__property bool RandomLength = {read=FRandomLength, write=SetRandomLength, default=1};
	__property bool Sound = {read=FSound, write=SetSound, default=1};
};


class PASCALIMPLEMENTATION TStarsBlock : public TElementsBlock
{
	typedef TElementsBlock inherited;
	
	
private:
	typedef System::DynamicArray<Vcltee::Tecanvas::TRGB> _TStarsBlock__1;
	
	
private:
	int FSize;
	_TStarsBlock__1 IColors;
	HIDESBASE void __fastcall SetSize(const int Value);
	
protected:
	virtual void __fastcall InitElements(int StartIndex);
	virtual bool __fastcall ShouldDraw(bool After = false);
	
public:
	__fastcall virtual TStarsBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TStarsBlock();
	virtual void __fastcall Draw();
	
__published:
	__property ElementCount = {default=1000};
	__property int Size = {read=FSize, write=SetSize, default=1};
};


class PASCALIMPLEMENTATION TSkydomeBlock : public Teeblocks::TSphereBlock
{
	typedef Teeblocks::TSphereBlock inherited;
	
public:
	__fastcall virtual TSkydomeBlock(System::Classes::TComponent* AOwner);
public:
	/* TEllipsoidBlock.Destroy */ inline __fastcall virtual ~TSkydomeBlock() { }
	
};


class PASCALIMPLEMENTATION TRainEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* LRainDrops;
	Vcl::Stdctrls::TLabel* LRainLength;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TScrollBar* BlockRainCount;
	Vcl::Stdctrls::TScrollBar* BlockRainLength;
	Vcl::Stdctrls::TButton* BRainPlay;
	Vcl::Stdctrls::TCheckBox* BlockRainSound;
	Vcl::Stdctrls::TScrollBar* BlockRainSpeed;
	Vcl::Stdctrls::TLabel* LDropCount;
	Vcl::Stdctrls::TLabel* LDropLength;
	Vcl::Stdctrls::TCheckBox* CBRandomLengths;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BlockRainCountChange(System::TObject* Sender);
	void __fastcall BlockRainLengthChange(System::TObject* Sender);
	void __fastcall BRainPlayClick(System::TObject* Sender);
	void __fastcall BlockRainSoundClick(System::TObject* Sender);
	void __fastcall BlockRainSpeedChange(System::TObject* Sender);
	void __fastcall CBRandomLengthsClick(System::TObject* Sender);
	
private:
	TRainBlock* Rain;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRainEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRainEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRainEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRainEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerain */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEERAIN)
using namespace Teerain;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeerainHPP
