// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Vector.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_VectorHPP
#define Fmxtee_Editor_Series_VectorHPP

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
#include <FMX.Edit.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMX.StdCtrls.hpp>
#include <System.UIConsts.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.TabControl.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Vector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVectorSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVectorSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Stdctrls::TLabel* LHeight;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TButton* BStart;
	Fmx::Stdctrls::TButton* BEnd;
	Fmx::Stdctrls::TCheckBox* CBStart;
	Fmx::Stdctrls::TCheckBox* CBEnd;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabGrid3D;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BStartClick(System::TObject* Sender);
	void __fastcall BEndClick(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDHeightChange(System::TObject* Sender);
	void __fastcall CBStartChange(System::TObject* Sender);
	void __fastcall CBEndChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Fmxtee::Series::Surface::TVector3DSeries* Vector;
	Fmx::Forms::TCustomForm* Grid3DForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVectorSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVectorSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVectorSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TVectorSeriesEditor* VectorSeriesEditor;
}	/* namespace Vector */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_VECTOR)
using namespace Fmxtee::Editor::Series::Vector;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
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
#endif	// Fmxtee_Editor_Series_VectorHPP
