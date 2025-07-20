// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFaderTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeefadertoolHPP
#define Vcltee_TeefadertoolHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teefadertool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFaderTool;
class DELPHICLASS TFaderEditor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TFaderStyle : unsigned char { fsFadeIn, fsFadeOut };

class PASCALIMPLEMENTATION TFaderTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	System::Uitypes::TColor FColor;
	int FDelay;
	System::Classes::TNotifyEvent FOnStop;
	bool FParentColor;
	double FSpeed;
	TFaderStyle FStyle;
	Vcl::Graphics::TBitmap* IDest;
	Vcl::Extctrls::TTimer* ITimer;
	double ITransp;
	bool IInitial;
	void __fastcall DoTimer(System::TObject* Sender);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TFaderTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFaderTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Start();
	void __fastcall Stop();
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=0};
	__property int InitialDelay = {read=FDelay, write=FDelay, default=100};
	__property bool ParentColor = {read=FParentColor, write=FParentColor, default=0};
	__property double Speed = {read=FSpeed, write=FSpeed};
	__property TFaderStyle Style = {read=FStyle, write=FStyle, default=0};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
};


class PASCALIMPLEMENTATION TFaderEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TButton* BStart;
	Vcl::Stdctrls::TButton* BReset;
	Vcl::Stdctrls::TScrollBar* SBSpeed;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Extctrls::TRadioGroup* RGStyle;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDDelay;
	Vcl::Stdctrls::TCheckBox* CBParent;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BStartClick(System::TObject* Sender);
	void __fastcall SBSpeedChange(System::TObject* Sender);
	void __fastcall RGStyleClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall BResetClick(System::TObject* Sender);
	void __fastcall CBParentClick(System::TObject* Sender);
	
private:
	TFaderTool* Tool;
	System::Classes::TNotifyEvent OldOnStop;
	void __fastcall FaderStop(System::TObject* Sender);
	void __fastcall SetLabelSpeed();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFaderEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFaderEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFaderEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFaderEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefadertool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFADERTOOL)
using namespace Vcltee::Teefadertool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeefadertoolHPP
