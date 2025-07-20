// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeWater.pas' rev: 34.00 (Windows)

#ifndef TeewaterHPP
#define TeewaterHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teewater
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimatedBlock;
class DELPHICLASS TWaterBlock;
class DELPHICLASS TWaterEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnimatedBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	bool FAutoPlay;
	Vcltee::Teeanimate::TTeeAnimate* IAnimate;
	bool IAutoPlayDone;
	int __fastcall GetSpeed();
	void __fastcall SetSpeed(const int Value);
	
protected:
	virtual void __fastcall DoAnimation(Vcltee::Teeanimate::TTeeAnimation* Sender, const float Fraction) = 0 ;
	virtual void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall virtual TAnimatedBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAnimatedBlock();
	__property Vcltee::Teeanimate::TTeeAnimate* Animate = {read=IAnimate};
	
__published:
	__property bool AutoPlay = {read=FAutoPlay, write=FAutoPlay, default=1};
	__property int Speed = {read=GetSpeed, write=SetSpeed, default=10};
};


class PASCALIMPLEMENTATION TWaterBlock : public TAnimatedBlock
{
	typedef TAnimatedBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FGrid;
	Vcltee::Tecanvas::TPointXYFloat* FSpeed;
	Vcltee::Tecanvas::TPointXYFloat* FWaves;
	Vcltee::Tecanvas::TFloatPoint IOffset;
	Vcltee::Tecanvas::TDoubleArray IPrevious;
	void __fastcall SetGrid(Vcltee::Tecanvas::TPointXYFloat* const Value);
	HIDESBASE void __fastcall SetSpeed(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetWaves(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	virtual void __fastcall DoAnimation(Vcltee::Teeanimate::TTeeAnimation* Sender, const float Fraction);
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TWaterBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TWaterBlock();
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* Grid = {read=FGrid, write=SetGrid};
	__property Vcltee::Tecanvas::TPointXYFloat* Speed = {read=FSpeed, write=SetSpeed};
	__property Vcltee::Tecanvas::TPointXYFloat* Waves = {read=FWaves, write=SetWaves};
};


class PASCALIMPLEMENTATION TWaterEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBPlay;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TScrollBar* SBWavesX;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDGridX;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDGridZ;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TScrollBar* SBSpeedX;
	Vcl::Stdctrls::TScrollBar* SBWavesY;
	Vcl::Stdctrls::TScrollBar* SBSpeedY;
	Vcl::Stdctrls::TCheckBox* CBAutoPlay;
	Vcl::Stdctrls::TLabel* LSpeedX;
	Vcl::Stdctrls::TLabel* LSpeedY;
	Vcl::Stdctrls::TLabel* LWavesX;
	Vcl::Stdctrls::TLabel* LWavesY;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBPlayClick(System::TObject* Sender);
	void __fastcall SBWavesXChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall SBSpeedXChange(System::TObject* Sender);
	void __fastcall SBWavesYChange(System::TObject* Sender);
	void __fastcall SBSpeedYChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall CBAutoPlayClick(System::TObject* Sender);
	
private:
	TWaterBlock* Block;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWaterEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWaterEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWaterEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TWaterEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teewater */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEWATER)
using namespace Teewater;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeewaterHPP
