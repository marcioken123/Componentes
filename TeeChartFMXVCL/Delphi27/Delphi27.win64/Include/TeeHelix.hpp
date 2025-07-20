// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeHelix.pas' rev: 34.00 (Windows)

#ifndef TeehelixHPP
#define TeehelixHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teehelix
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THelixBlock;
class DELPHICLASS THelixEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THelixBlock : public Teeblocks::TCustomCoverBlock
{
	typedef Teeblocks::TCustomCoverBlock inherited;
	
private:
	int FSlices;
	int FStacks;
	double FTwists;
	double FTwistSize;
	int IList;
	bool __fastcall IsTwistsStored();
	bool __fastcall IsTwistSizeStored();
	void __fastcall SetSlices(const int Value);
	void __fastcall SetStacks(const int Value);
	void __fastcall SetTwists(const double Value);
	void __fastcall SetTwistSize(const double Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual THelixBlock(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	
__published:
	__property int Slices = {read=FSlices, write=SetSlices, default=32};
	__property int Stacks = {read=FStacks, write=SetStacks, default=32};
	__property double Twists = {read=FTwists, write=SetTwists, stored=IsTwistsStored};
	__property double TwistSize = {read=FTwistSize, write=SetTwistSize, stored=IsTwistSizeStored};
public:
	/* TCustomCoverBlock.Destroy */ inline __fastcall virtual ~THelixBlock() { }
	
};


class PASCALIMPLEMENTATION THelixEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label86;
	Vcl::Stdctrls::TLabel* Label87;
	Vcl::Stdctrls::TLabel* Label88;
	Vcl::Stdctrls::TLabel* LHelixSlices;
	Vcl::Stdctrls::TLabel* LHelixStacks;
	Vcl::Stdctrls::TLabel* LHelixTwists;
	Vcl::Stdctrls::TLabel* Label89;
	Vcl::Stdctrls::TLabel* LHelixTwistSize;
	Vcl::Stdctrls::TScrollBar* BlockHelixTwists;
	Vcl::Stdctrls::TScrollBar* BlockHelixSlices;
	Vcl::Stdctrls::TScrollBar* BlockHelixStacks;
	Vcl::Stdctrls::TScrollBar* BlockHelixTwistSize;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BlockHelixTwistsChange(System::TObject* Sender);
	void __fastcall BlockHelixSlicesChange(System::TObject* Sender);
	void __fastcall BlockHelixStacksChange(System::TObject* Sender);
	void __fastcall BlockHelixTwistSizeChange(System::TObject* Sender);
	
private:
	THelixBlock* Helix;
	bool IModifying;
public:
	/* TCustomForm.Create */ inline __fastcall virtual THelixEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THelixEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THelixEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THelixEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teehelix */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEHELIX)
using namespace Teehelix;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeehelixHPP
