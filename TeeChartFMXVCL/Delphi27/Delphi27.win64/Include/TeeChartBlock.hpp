// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeChartBlock.pas' rev: 34.00 (Windows)

#ifndef TeechartblockHPP
#define TeechartblockHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Dialogs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teechartblock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomBlockChart;
class DELPHICLASS TChartBlock;
class DELPHICLASS TChartBlockEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomBlockChart : public Vcltee::Chart::TChart
{
	typedef Vcltee::Chart::TChart inherited;
	
protected:
	Teeblocks::TCustomBlock* IBlock;
	void __fastcall DoInternalDraw(const System::Types::TRect &R);
	DYNAMIC System::TClass __fastcall Form3DClass();
	DYNAMIC System::Classes::TComponent* __fastcall GetDesignOwner();
	virtual void __fastcall PanelPaint(const System::Types::TRect &UserRect);
	
public:
	__fastcall virtual TCustomBlockChart(System::Classes::TComponent* AOwner);
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent();
	DYNAMIC bool __fastcall HasParent();
	virtual void __fastcall Invalidate();
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* Value);
public:
	/* TCustomChart.Destroy */ inline __fastcall virtual ~TCustomBlockChart() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomBlockChart(HWND ParentWindow) : Vcltee::Chart::TChart(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TChartBlock : public Teeblocks::TCustomObjectBlock
{
	typedef Teeblocks::TCustomObjectBlock inherited;
	
private:
	Vcltee::Chart::TChart* FChart;
	System::UnicodeString FTemplateFile;
	bool IItemsOk;
	bool IItemsDone;
	bool IOwnedChart;
	Teeblocks::TBlocks* ITemplate;
	void __fastcall DrawChartDirect();
	Vcltee::Chart::TChart* __fastcall GetChart();
	Teeblocks::TBlocks* __fastcall GetTemplate();
	void __fastcall SetChart(Vcltee::Chart::TChart* const Value);
	void __fastcall SetDirty();
	void __fastcall SetTemplateFile(const System::UnicodeString Value);
	
protected:
	void __fastcall ApplyTemplate();
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC bool __fastcall SaveChildren();
	void __fastcall SetSeriesTemplate(Vcltee::Teengine::TChartSeries* Series);
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	
public:
	bool DirectDraw;
	bool KeepLeft;
	bool TextAsPictures;
	double TextDepth;
	__fastcall virtual ~TChartBlock();
	virtual bool __fastcall BoundingBox(/* out */ System::Math::Vectors::TPoint3D &AMin, /* out */ System::Math::Vectors::TPoint3D &AMax);
	void __fastcall CreateItems();
	virtual void __fastcall DoDrawItems();
	virtual void __fastcall Draw();
	virtual Vcl::Controls::TControl* __fastcall Editor(System::Classes::TComponent* const AOwner, bool Embeddable = false);
	virtual bool __fastcall HasContents();
	void __fastcall LoadChart(const System::UnicodeString FileName);
	__property Teeblocks::TBlocks* Template = {read=GetTemplate};
	
__published:
	__property Vcltee::Chart::TChart* Chart = {read=GetChart, write=SetChart};
	__property System::UnicodeString TemplateFile = {read=FTemplateFile, write=SetTemplateFile};
public:
	/* TCustomObjectBlock.Create */ inline __fastcall virtual TChartBlock(System::Classes::TComponent* AOwner) : Teeblocks::TCustomObjectBlock(AOwner) { }
	
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


class PASCALIMPLEMENTATION TChartBlockEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TCheckBox* CBDirect;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* LabelItems;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* ETemplate;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TCheckBox* CBTextAsPictures;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TBTextDepth;
	Vcl::Stdctrls::TLabel* LTextDepth;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CBDirectClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall CBTextAsPicturesClick(System::TObject* Sender);
	void __fastcall TBTextDepthChange(System::TObject* Sender);
	
private:
	TChartBlock* Chart;
	void __fastcall CountItems();
	
public:
	__classmethod int __fastcall CountAll(Teeblocks::TBlocks* ABlocks);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartBlockEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartBlockEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechartblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECHARTBLOCK)
using namespace Teechartblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeechartblockHPP
