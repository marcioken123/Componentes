// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeClusteringToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeclusteringtooleditorHPP
#define Vcltee_TeeclusteringtooleditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeClusteringTool.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeclusteringtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TClusteringToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TClusteringToolEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabCalc;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* LLambda;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* LDepth;
	Vcltee::Tecanvas::TComboFlat* CBMethod;
	Vcltee::Tecanvas::TComboFlat* CBDistance;
	Vcltee::Tecanvas::TComboFlat* CBLinkage;
	Vcl::Stdctrls::TEdit* ECount;
	Vcl::Stdctrls::TEdit* ELambda;
	Vcl::Stdctrls::TEdit* EQTMin;
	Vcl::Stdctrls::TEdit* EQTMax;
	Vcl::Stdctrls::TEdit* EDepth;
	Vcl::Comctrls::TUpDown* UDDepth;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TCheckBox* CBBounds;
	Vcl::Stdctrls::TListBox* LBClusters;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Comctrls::TPageControl* PageFormat;
	Vcl::Comctrls::TTabSheet* TabCentroids;
	Vcl::Comctrls::TTabSheet* TabCenter;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	void __fastcall CBDistanceChange(System::TObject* Sender);
	void __fastcall ELambdaChange(System::TObject* Sender);
	void __fastcall CBMethodChange(System::TObject* Sender);
	void __fastcall CBLinkageChange(System::TObject* Sender);
	void __fastcall ECountChange(System::TObject* Sender);
	void __fastcall EQTMinChange(System::TObject* Sender);
	void __fastcall EQTMaxChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall CBBoundsClick(System::TObject* Sender);
	void __fastcall LBClustersClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageFormatChange(System::TObject* Sender);
	
private:
	Vcltee::Teeclusteringtool::TClusteringTool* Tool;
	void __fastcall FillClusters();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TClusteringToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TClusteringToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TClusteringToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TClusteringToolEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeclusteringtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECLUSTERINGTOOLEDITOR)
using namespace Vcltee::Teeclusteringtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeclusteringtooleditorHPP
