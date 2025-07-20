// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.ChartImage.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Tools_ChartimageHPP
#define Fmxtee_Editor_Tools_ChartimageHPP

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
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.Objects.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Chartimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartImageToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartImageToolEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TButton* BBorder;
	Fmx::Stdctrls::TGroupBox* GBImage;
	Fmx::Stdctrls::TButton* BBrowse;
	Fmx::Stdctrls::TButton* BFilters;
	Fmx::Stdctrls::TButton* BSave;
	Fmx::Objects::TRectangle* Bevel1;
	Fmx::Objects::TImage* Image1;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BBorderClick(System::TObject* Sender);
	void __fastcall BBrowseClick(System::TObject* Sender);
	void __fastcall BSaveClick(System::TObject* Sender);
	void __fastcall BFiltersClick(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TChartImageTool* ChartImage;
	void __fastcall CheckImageButton();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartImageToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartImageToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartImageToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Chartimage */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_CHARTIMAGE)
using namespace Fmxtee::Editor::Tools::Chartimage;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS)
using namespace Fmxtee::Editor::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR)
using namespace Fmxtee::Editor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Editor_Tools_ChartimageHPP
