// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockAnimations.pas' rev: 34.00 (Windows)

#ifndef TeeblockanimationsHPP
#define TeeblockanimationsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeAnimationEditor.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeNumberAnimation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockanimations
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlocksAnimation;
class DELPHICLASS TFadeBlocksAnimation;
class DELPHICLASS TSequenceAnimation;
class DELPHICLASS TBounceAnimation;
class DELPHICLASS TBlocksAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlocksAnimation : public Vcltee::Teeanimate::TPropertyAnimation
{
	typedef Vcltee::Teeanimate::TPropertyAnimation inherited;
	
private:
	Vcltee::Teeanimate::TNumberAnimation* FNumber;
	int FOverlap;
	void __fastcall SetNumber(Vcltee::Teeanimate::TNumberAnimation* const Value);
	void __fastcall SetOverlap(const int Value);
	
protected:
	DYNAMIC bool __fastcall IsFolder();
	void __fastcall ResetItems();
	
public:
	__fastcall virtual TBlocksAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBlocksAnimation();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	DYNAMIC System::UnicodeString __fastcall EditorName();
	DYNAMIC bool __fastcall IsEnabled();
	__classmethod virtual bool __fastcall IsValidSource(System::TObject* const ASource, bool IsObject);
	virtual void __fastcall Prepare();
	
__published:
	__property Vcltee::Teeanimate::TNumberAnimation* Number = {read=FNumber, write=SetNumber};
	__property int Overlap = {read=FOverlap, write=SetOverlap, default=0};
	__property PropertyName = {default=0};
};


enum DECLSPEC_DENUM TFadeType : unsigned char { ftIn, ftOut };

class PASCALIMPLEMENTATION TFadeBlocksAnimation : public TBlocksAnimation
{
	typedef TBlocksAnimation inherited;
	
private:
	TFadeType FFadeType;
	void __fastcall SetFadeType(const TFadeType Value);
	
protected:
	virtual void __fastcall SetDuration(const int Value);
	
public:
	__fastcall virtual TFadeBlocksAnimation(System::Classes::TComponent* AOwner);
	DYNAMIC System::UnicodeString __fastcall EditorName();
	virtual void __fastcall Prepare();
	
__published:
	__property TFadeType FadeType = {read=FFadeType, write=SetFadeType, default=0};
public:
	/* TBlocksAnimation.Destroy */ inline __fastcall virtual ~TFadeBlocksAnimation() { }
	
};


class PASCALIMPLEMENTATION TSequenceAnimation : public Vcltee::Teeanimate::TTeeAnimation
{
	typedef Vcltee::Teeanimate::TTeeAnimation inherited;
	
private:
	void __fastcall RefreshStarts();
	
protected:
	DYNAMIC void __fastcall Added(Vcltee::Teeanimate::TTeeAnimation* const AAnimation);
	DYNAMIC void __fastcall ChildDurationChanged(Vcltee::Teeanimate::TTeeAnimation* const Child);
	DYNAMIC bool __fastcall IsFolder();
	DYNAMIC bool __fastcall IsSequence();
	DYNAMIC void __fastcall Removed(Vcltee::Teeanimate::TTeeAnimation* const AAnimation);
	virtual void __fastcall SetAnimate(Vcltee::Teeanimate::TTeeAnimate* const Value);
	
public:
	__fastcall virtual ~TSequenceAnimation();
	DYNAMIC System::UnicodeString __fastcall EditorName();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TSequenceAnimation(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TTeeAnimation(AOwner) { }
	
};


class PASCALIMPLEMENTATION TBounceAnimation : public Vcltee::Teeanimate::TNumberAnimation
{
	typedef Vcltee::Teeanimate::TNumberAnimation inherited;
	
public:
	virtual void __fastcall NextFrame(const float Fraction);
public:
	/* TNumberAnimation.Destroy */ inline __fastcall virtual ~TBounceAnimation() { }
	
public:
	/* TRangePropertyAnimation.Create */ inline __fastcall virtual TBounceAnimation(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TNumberAnimation(AOwner) { }
	
};


class PASCALIMPLEMENTATION TBlocksAnimationEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDOverlap;
	Vcl::Comctrls::TTabSheet* TabNumber;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EBlocksProperty;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelBlocks;
	Vcl::Stdctrls::TButton* BChange;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EBlocksPropertyChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall BChangeClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	TBlocksAnimation* Animation;
	Teenumberanimation::TNumberAnimationEditor* INumber;
	Vcltee::Teeanimationeditor::TAnimationEditor* IBasic;
	void __fastcall RefreshAnimation(TBlocksAnimation* AAnimation);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlocksAnimationEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlocksAnimationEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlocksAnimationEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlocksAnimationEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall BlockTitlePath(Teeblocks::TCustomBlock* ABlock);
}	/* namespace Teeblockanimations */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKANIMATIONS)
using namespace Teeblockanimations;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockanimationsHPP
