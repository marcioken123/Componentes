// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAntiAlias.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeantialiasHPP
#define Vcltee_TeeantialiasHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeantialias
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAntiAliasCanvas;
class DELPHICLASS TAntiAliasTool;
class DELPHICLASS TAntiAliasEditor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TAntiAlias : unsigned char { aaYes, aaNo };

typedef System::StaticArray<bool, 8> TPenDots;

typedef Vcltee::Teegdiplus::TGDIPlusCanvas TAntiAliasAncestor;

class PASCALIMPLEMENTATION TAntiAliasCanvas : public Vcltee::Teegdiplus::TGDIPlusCanvas
{
	typedef Vcltee::Teegdiplus::TGDIPlusCanvas inherited;
	
private:
	TAntiAlias FAlias;
	System::Types::TPoint FCurrent;
	TAntiAliasTool* ITool;
	void __fastcall SetAlias(const TAntiAlias Value);
	
public:
	__fastcall virtual ~TAntiAliasCanvas();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall EditorClass();
	__property TAntiAlias AntiAlias = {read=FAlias, write=SetAlias, default=0};
	__property System::Types::TPoint Current = {read=FCurrent, write=FCurrent};
public:
	/* TGDIPlusCanvas.Create */ inline __fastcall virtual TAntiAliasCanvas() : Vcltee::Teegdiplus::TGDIPlusCanvas() { }
	
};


class PASCALIMPLEMENTATION TAntiAliasTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	TAntiAliasCanvas* FCanvas;
	Vcltee::Tecanvas::TFilterItems* FFilters;
	void __fastcall CheckParentCanvas();
	bool __fastcall FiltersStored();
	bool __fastcall GetAntiAlias();
	void __fastcall ReadFilters(System::Classes::TReader* Reader);
	void __fastcall SetFilters(Vcltee::Tecanvas::TFilterItems* const Value);
	void __fastcall SetAntiAlias(const bool Value);
	void __fastcall WriteFilters(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TAntiAliasTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAntiAliasTool();
	Vcl::Graphics::TBitmap* __fastcall Bitmap();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property TAntiAliasCanvas* Canvas = {read=FCanvas};
	
__published:
	__property Active = {default=1};
	__property bool AntiAlias = {read=GetAntiAlias, write=SetAntiAlias, default=1};
	__property Vcltee::Tecanvas::TFilterItems* Filters = {read=FFilters, write=SetFilters, stored=false};
};


class PASCALIMPLEMENTATION TAntiAliasEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* BFilters;
	Vcl::Stdctrls::TCheckBox* CBAnti;
	void __fastcall BFiltersClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAntiClick(System::TObject* Sender);
	
private:
	TAntiAliasTool* Tool;
	TAntiAliasCanvas* Anti;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAntiAliasEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAntiAliasEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAntiAliasEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAntiAliasEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeantialias */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEANTIALIAS)
using namespace Vcltee::Teeantialias;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeantialiasHPP
