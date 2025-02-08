// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDistanceAndPositionDlg.pas' rev: 31.00 (Windows)

#ifndef PlmddistanceandpositiondlgHPP
#define PlmddistanceandpositiondlgHPP

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
#include <System.Variants.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <pLMDMarginsEditor.hpp>
#include <LMDShSpinEdit.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddistanceandpositiondlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDistanceAndSizeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDistanceAndSizeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* plArea;
	Vcl::Extctrls::TPanel* plTools;
	Vcl::Extctrls::TPanel* plBottomMargin;
	Vcl::Extctrls::TPanel* plTopMargin;
	Vcl::Extctrls::TPanel* plLeftMargin;
	Vcl::Extctrls::TPanel* plRightMargin;
	Vcl::Extctrls::TPanel* plElement;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Extctrls::TSplitter* Splitter3;
	Vcl::Extctrls::TSplitter* Splitter4;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Stdctrls::TLabel* Label1;
	Plmdmarginseditor::TLMDMarginsEditor* LMDMarginsEditor1;
	void __fastcall plElementMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall plElementMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall plElementMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall plTopMarginResize(System::TObject* Sender);
	
private:
	int FAreaWidth;
	int FAreaHeight;
	double FScaleCoef;
	bool FAllowsSizing;
	bool FAllowsMoving;
	int FStartX;
	int FStartY;
	bool FLiveMoving;
	void __fastcall AdjustElementPosition(int X, int Y);
	void __fastcall MarginSEValueChanged(System::TObject* ASender);
	void __fastcall SetMarginSEHandlers(bool assign);
	int __fastcall GetBottomMargin(void);
	int __fastcall GetElementHeight(void);
	int __fastcall GetLeftMargin(void);
	int __fastcall GetRightMargin(void);
	int __fastcall GetTopMargin(void);
	int __fastcall GetElementWidth(void);
	void __fastcall SetBottomMargin(const int Value);
	void __fastcall SetElementHeight(const int Value);
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetRightMargin(const int Value);
	void __fastcall SetTopMargin(const int Value);
	void __fastcall SetElementWidth(const int Value);
	void __fastcall SetAllowsSizing(const bool Value);
	void __fastcall SetScaleCoef(const double Value);
	
public:
	__fastcall virtual TLMDDistanceAndSizeEditor(System::Classes::TComponent* AOwner);
	bool __fastcall Edit(void);
	__property int AreaWidth = {read=FAreaWidth, write=FAreaWidth, nodefault};
	__property int AreaHeight = {read=FAreaHeight, write=FAreaHeight, nodefault};
	__property double ScaleCoef = {read=FScaleCoef, write=SetScaleCoef};
	__property int TopMargin = {read=GetTopMargin, write=SetTopMargin, nodefault};
	__property int LeftMargin = {read=GetLeftMargin, write=SetLeftMargin, nodefault};
	__property int RightMargin = {read=GetRightMargin, write=SetRightMargin, nodefault};
	__property int BottomMargin = {read=GetBottomMargin, write=SetBottomMargin, nodefault};
	__property int ElementHeight = {read=GetElementHeight, write=SetElementHeight, nodefault};
	__property int ElementWidth = {read=GetElementWidth, write=SetElementWidth, nodefault};
	__property bool AllowsMoving = {read=FAllowsMoving, write=FAllowsMoving, nodefault};
	__property bool AllowsSizing = {read=FAllowsSizing, write=SetAllowsSizing, nodefault};
	__property bool LiveMoving = {read=FLiveMoving, write=FLiveMoving, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDDistanceAndSizeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDDistanceAndSizeEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDistanceAndSizeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDDistanceAndSizeEditor* LMDDistanceAndSizeEditor;
}	/* namespace Plmddistanceandpositiondlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDISTANCEANDPOSITIONDLG)
using namespace Plmddistanceandpositiondlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddistanceandpositiondlgHPP
