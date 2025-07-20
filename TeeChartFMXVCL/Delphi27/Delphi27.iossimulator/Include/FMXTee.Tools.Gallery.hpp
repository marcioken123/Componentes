// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Gallery.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_GalleryHPP
#define Fmxtee_Tools_GalleryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Objects.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Gallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeToolType;
class DELPHICLASS TToolsGallery;
//-- type declarations -------------------------------------------------------
typedef System::TObject* __fastcall (*TToolsGalleryHook)(TToolsGallery* const Gallery);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeToolType : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Fmxtee::Engine::TTeeCustomToolClass ToolClass;
public:
	/* TObject.Create */ inline __fastcall TTeeToolType() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TTeeToolType() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TToolsGallery : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<TTeeToolType*> _TToolsGallery__1;
	
	
__published:
	Fmx::Stdctrls::TPanel* PanelBottom;
	Fmx::Stdctrls::TCheckBox* CBView3D;
	Fmx::Objects::TText* LabelClass;
	Fmx::Stdctrls::TPanel* PanelButtons;
	Fmx::Stdctrls::TButton* BOk;
	Fmx::Stdctrls::TButton* Button2;
	Fmx::Memo::TMemo* MemoDesc;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Stdctrls::TPanel* PanelDemos;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Listbox::TListBox* LBTool;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Tabcontrol::TTabItem* TabItem3;
	Fmx::Controls::TStyleBook* StyleBook1;
	Fmx::Stdctrls::TSplitter* Splitter1;
	void __fastcall LBToolDblClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LBToolChange(System::TObject* Sender);
	void __fastcall CBView3DChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	System::TObject* IGalleryHook;
	Fmxtee::Engine::TTeeCustomToolClass __fastcall ToolAtIndex(int AIndex);
	
protected:
	TToolsGalleryHook TheGalleryHook;
	_TToolsGallery__1 TypesToShow;
	bool DontAddTools;
	Fmx::Listbox::TListBoxItem* __fastcall AddTool(const System::UnicodeString ADesc, TTeeToolType* const ATool);
	virtual void __fastcall FillTools();
	void __fastcall FillTypes(Fmxtee::Chart::TTeeToolTypes* const AList);
	virtual bool __fastcall FilterTool(int Index);
	
public:
	__classmethod void __fastcall ApplyListToolItem(Fmx::Listbox::TListBoxItem* const AItem, const System::UnicodeString AToolClass);
	__classmethod Fmxtee::Engine::TTeeCustomToolClass __fastcall Choose(System::Classes::TComponent* const AOwner);
	__classmethod TToolsGallery* __fastcall CreateEditor(System::Classes::TComponent* const AOwner);
	Fmxtee::Chart::TCustomChart* __fastcall FindDemoChart();
	Fmxtee::Engine::TTeeCustomToolClass __fastcall SelectedTool();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TToolsGallery(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TToolsGallery(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TToolsGallery() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TToolsGalleryHook ToolsGalleryHook;
}	/* namespace Gallery */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_GALLERY)
using namespace Fmxtee::Tools::Gallery;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_GalleryHPP
