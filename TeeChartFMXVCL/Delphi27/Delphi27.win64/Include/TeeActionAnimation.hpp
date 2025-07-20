// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeActionAnimation.pas' rev: 34.00 (Windows)

#ifndef TeeactionanimationHPP
#define TeeactionanimationHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeAnimationEditor.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeactionanimation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockActionAnimation;
class DELPHICLASS TActionAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockActionAnimation : public Vcltee::Teeanimate::TTeeAnimation
{
	typedef Vcltee::Teeanimate::TTeeAnimation inherited;
	
private:
	Teeblocks::TCustomBlock* FBlock;
	System::UnicodeString FBlockAction;
	void __fastcall SetBlock(Teeblocks::TCustomBlock* const Value);
	
public:
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	virtual void __fastcall Play()/* overload */;
	
__published:
	__property Teeblocks::TCustomBlock* Block = {read=FBlock, write=SetBlock};
	__property System::UnicodeString BlockAction = {read=FBlockAction, write=FBlockAction};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TBlockActionAnimation(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TBlockActionAnimation() { }
	
};


class PASCALIMPLEMENTATION TActionAnimationEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Comctrls::TTabSheet* TabAction;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelAction;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* ComboBlocks;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcltee::Teeanimationeditor::TAnimationEditor* IBasic;
	
public:
	TBlockActionAnimation* Animation;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TActionAnimationEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TActionAnimationEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TActionAnimationEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TActionAnimationEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeactionanimation */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEACTIONANIMATION)
using namespace Teeactionanimation;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeactionanimationHPP
