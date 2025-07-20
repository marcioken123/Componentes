// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeStairs.pas' rev: 34.00 (Windows)

#ifndef TeestairsHPP
#define TeestairsHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teestairs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TStairsBlock;
class DELPHICLASS TStairsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TStairsBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	bool FBack;
	bool FSides;
	int FStepHeight;
	int FStepDepth;
	int FStepRoundY;
	int FStepRoundX;
	int IListBack;
	int IListSide1;
	int IListSide2;
	Teeblocks::TCustomBlock* IStepBlock;
	void __fastcall FreeStepBlock();
	void __fastcall SetBack(const bool Value);
	void __fastcall SetSides(const bool Value);
	void __fastcall SetStepDepth(const int Value);
	void __fastcall SetStepHeight(const int Value);
	void __fastcall SetStepRoundX(const int Value);
	void __fastcall SetStepRoundY(const int Value);
	
protected:
	virtual void __fastcall DeleteLists();
	
public:
	__fastcall virtual TStairsBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TStairsBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property bool Back = {read=FBack, write=SetBack, default=0};
	__property bool Sides = {read=FSides, write=SetSides, default=0};
	__property int StepDepth = {read=FStepDepth, write=SetStepDepth, default=20};
	__property int StepHeight = {read=FStepHeight, write=SetStepHeight, default=10};
	__property int StepRoundX = {read=FStepRoundX, write=SetStepRoundX, default=10};
	__property int StepRoundY = {read=FStepRoundY, write=SetStepRoundY, default=10};
};


class PASCALIMPLEMENTATION TStairsEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label63;
	Vcl::Stdctrls::TLabel* Label64;
	Vcl::Stdctrls::TLabel* Label68;
	Vcl::Stdctrls::TLabel* Label69;
	Vcl::Stdctrls::TCheckBox* BlockStairsSides;
	Vcl::Stdctrls::TScrollBar* BlockStepDepth;
	Vcl::Stdctrls::TScrollBar* BlockStepHeight;
	Vcl::Stdctrls::TCheckBox* BlockStairsBack;
	Vcl::Stdctrls::TScrollBar* BlockStairsRoundX;
	Vcl::Stdctrls::TScrollBar* BlockStairsRoundY;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BlockStairsSidesClick(System::TObject* Sender);
	void __fastcall BlockStepDepthChange(System::TObject* Sender);
	void __fastcall BlockStepHeightChange(System::TObject* Sender);
	void __fastcall BlockStairsBackClick(System::TObject* Sender);
	void __fastcall BlockStairsRoundXChange(System::TObject* Sender);
	void __fastcall BlockStairsRoundYChange(System::TObject* Sender);
	
private:
	TStairsBlock* Stairs;
	bool IModifying;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TStairsEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStairsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStairsEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TStairsEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teestairs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEESTAIRS)
using namespace Teestairs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeestairsHPP
