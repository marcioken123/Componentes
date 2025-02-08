// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalculatorDlg.pas' rev: 31.00 (Windows)

#ifndef LmdcalculatordlgHPP
#define LmdcalculatordlgHPP

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
#include <LMDGraph.hpp>
#include <LMDEmbeddedObject.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCalculator.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalculatordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalculatorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalculatorDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::Extended FReturnValue;
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	Lmdembeddedobject::TLMDEmbeddedObject* FDispStyle;
	Lmdcustommaskedit::TLMDNumberType FEditType;
	int FDecimals;
	System::TObject* FCalc;
	bool FCXP;
	void __fastcall SetDisplayStyle(Lmdembeddedobject::TLMDEmbeddedObject* aValue);
	void __fastcall DoOnKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall ReadStyle(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoCustomize(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCalculatorDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCalculatorDlg(void);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* aForm);
	__property Lmdbuttonbase::TLMDUserButtonStyle CalcBtnStyle = {read=FBtnStyle, write=FBtnStyle, nodefault};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Lmdbuttonbase::TLMDUserButtonStyle CalcButtonStyle = {read=FBtnStyle, write=FBtnStyle, default=7};
	__property bool CalcButtonCtlXP = {read=FCXP, write=FCXP, default=0};
	__property int CalcDecimals = {read=FDecimals, write=FDecimals, default=1};
	__property Lmdembeddedobject::TLMDEmbeddedObject* CalcDisplayStyle = {read=FDispStyle, write=SetDisplayStyle};
	__property Lmdcustommaskedit::TLMDNumberType CalcEditType = {read=FEditType, write=FEditType, default=1};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property Effect = {default=0};
	__property Hints;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property System::Extended Value = {read=FReturnValue, write=FReturnValue};
	__property OnCustomClick;
	__property OnCustomize;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalculatordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALCULATORDLG)
using namespace Lmdcalculatordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalculatordlgHPP
