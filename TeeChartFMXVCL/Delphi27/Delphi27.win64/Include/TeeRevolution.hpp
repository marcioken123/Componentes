// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeRevolution.pas' rev: 34.00 (Windows)

#ifndef TeerevolutionHPP
#define TeerevolutionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeExtruded.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teerevolution
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRevolutionBlock;
class DELPHICLASS TRevolutionEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRevolutionBlock : public Teeblocks::TCustomCoverBlock
{
	typedef Teeblocks::TCustomCoverBlock inherited;
	
private:
	Teeblocks::TBlockFormat* FCover;
	int FCurvePoints;
	Teeextruded::TPointCollection* FOuter;
	int FSlices;
	double FTotalAngle;
	int IList;
	int IListCover;
	Teeblocks::TBlockFormat* __fastcall GetCover();
	bool __fastcall IsPointsStored();
	void __fastcall SetCover(Teeblocks::TBlockFormat* const Value);
	void __fastcall SetCurvePoints(const int Value);
	void __fastcall SetPoints(Teeextruded::TPointCollection* const Value);
	void __fastcall SetSlices(const int Value);
	void __fastcall SetTotalAngle(const double Value);
	
protected:
	virtual void __fastcall DeleteLists();
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TRevolutionBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRevolutionBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DataChanged();
	virtual void __fastcall Draw();
	bool __fastcall HasCover();
	
__published:
	__property Teeblocks::TBlockFormat* Cover = {read=GetCover, write=SetCover};
	__property int CurvePoints = {read=FCurvePoints, write=SetCurvePoints, default=16};
	__property Teeextruded::TPointCollection* OuterPoints = {read=FOuter, write=SetPoints, stored=IsPointsStored};
	__property int Slices = {read=FSlices, write=SetSlices, default=32};
	__property double TotalAngle = {read=FTotalAngle, write=SetTotalAngle};
};


class PASCALIMPLEMENTATION TRevolutionEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label82;
	Vcl::Stdctrls::TLabel* LRevoSlices;
	Vcl::Stdctrls::TLabel* Label83;
	Vcl::Stdctrls::TLabel* LRevolutionCurve;
	Vcl::Stdctrls::TLabel* Label59;
	Vcl::Stdctrls::TLabel* LRevolutionAngle;
	Vcl::Stdctrls::TScrollBar* BlockRevolutionSlices;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TScrollBar* BlockRevolutionCurve;
	Vcl::Stdctrls::TScrollBar* BlockRevolutionAngle;
	Vcl::Stdctrls::TGroupBox* GroupBox10;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Stdctrls::TCheckBox* BlockRevolutionCoverDef;
	Vcl::Stdctrls::TCheckBox* BlockRevolutionCoverVisible;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BlockRevolutionSlicesChange(System::TObject* Sender);
	void __fastcall BlockRevolutionCurveChange(System::TObject* Sender);
	void __fastcall BlockRevolutionAngleChange(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall BlockRevolutionCoverDefClick(System::TObject* Sender);
	void __fastcall BlockRevolutionCoverVisibleClick(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	
private:
	TRevolutionBlock* Revolution;
	bool IModifying;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRevolutionEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRevolutionEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRevolutionEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRevolutionEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerevolution */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEREVOLUTION)
using namespace Teerevolution;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeerevolutionHPP
