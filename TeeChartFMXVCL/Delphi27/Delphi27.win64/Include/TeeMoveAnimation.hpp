// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMoveAnimation.pas' rev: 34.00 (Windows)

#ifndef TeemoveanimationHPP
#define TeemoveanimationHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeExtruded.hpp>
#include <TeePointItemEditor.hpp>
#include <VCLTee.TeeAnimationEditor.hpp>
#include <TeeExtrudedEditor.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemoveanimation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMoveAnimation;
class DELPHICLASS TMoveAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMoveAnimation : public Vcltee::Teeanimate::TRangePropertyAnimation
{
	typedef Vcltee::Teeanimate::TRangePropertyAnimation inherited;
	
private:
	Teeextruded::TPointCollection* FPoints;
	System::UnicodeString FPropY;
	System::UnicodeString FPropZ;
	bool FTwoWay;
	System::Math::Vectors::TPoint3D Old;
	System::UnicodeString IRealYPropertyName;
	System::UnicodeString IRealZPropertyName;
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetEnd();
	Vcltee::Tecanvas::TPointXYZFloat* __fastcall GetStart();
	void __fastcall SetEnd(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetPoints(Teeextruded::TPointCollection* const Value);
	void __fastcall SetPropY(const System::UnicodeString Value);
	void __fastcall SetPropZ(const System::UnicodeString Value);
	void __fastcall SetStart(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall FixupReferences(const System::UnicodeString AParentSource);
	virtual void __fastcall FindRealNames();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TMoveAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMoveAnimation();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC bool __fastcall IsEnabled();
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	DYNAMIC System::UnicodeString __fastcall EditorName();
	__classmethod virtual bool __fastcall IsValidSource(System::TObject* const ASource, bool IsObject);
	virtual void __fastcall StoreValue();
	
__published:
	__property Vcltee::Tecanvas::TPointXYZFloat* EndPoint = {read=GetEnd, write=SetEnd, stored=false};
	__property Teeextruded::TPointCollection* Points = {read=FPoints, write=SetPoints};
	__property Vcltee::Tecanvas::TPointXYZFloat* StartPoint = {read=GetStart, write=SetStart, stored=false};
	__property bool TwoWay = {read=FTwoWay, write=FTwoWay, default=0};
	__property System::UnicodeString XProperty = {read=FProp, write=SetProp};
	__property System::UnicodeString YProperty = {read=FPropY, write=SetPropY};
	__property System::UnicodeString ZProperty = {read=FPropZ, write=SetPropZ};
};


class PASCALIMPLEMENTATION TMoveAnimationEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Comctrls::TTabSheet* TabMove;
	Vcl::Comctrls::TTabSheet* TabPoints;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabStart;
	Vcl::Comctrls::TTabSheet* TabEnd;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CBTwoWay;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelProperty;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	Vcltee::Teeanimationeditor::TAnimationEditor* IBasic;
	Teepointitemeditor::TPointItemEditor* IEnd;
	Teeextrudededitor::TExtrudedEditor* IPoints;
	Teepointitemeditor::TPointItemEditor* IStart;
	TMoveAnimation* Animation;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMoveAnimationEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMoveAnimationEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMoveAnimationEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMoveAnimationEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemoveanimation */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMOVEANIMATION)
using namespace Teemoveanimation;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemoveanimationHPP
