// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Volume.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_VolumeHPP
#define Fmxtee_Editor_Series_VolumeHPP

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
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Series.Candle.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
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
namespace Volume
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVolumeSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVolumeSeriesEditor : public Fmxtee::Editor::Stroke::TStrokeEditor
{
	typedef Fmxtee::Editor::Stroke::TStrokeEditor inherited;
	
__published:
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TCheckBox* CBUseOrigin;
	Fmx::Edit::TEdit* EOrigin;
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	HIDESBASE void __fastcall ComboColorBox1Change(System::TObject* Sender);
	void __fastcall CBUseOriginChange(System::TObject* Sender);
	void __fastcall EOriginChangeTracking(System::TObject* Sender);
	
private:
	Fmxtee::Series::Candle::TVolumeSeries* TheSeries;
	
protected:
	virtual System::Uitypes::TAlphaColor __fastcall GetDefaultColor();
	virtual void __fastcall SetDefaultColor();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVolumeSeriesEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Stroke::TStrokeEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVolumeSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Stroke::TStrokeEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVolumeSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Volume */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_VOLUME)
using namespace Fmxtee::Editor::Series::Volume;
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
#endif	// Fmxtee_Editor_Series_VolumeHPP
