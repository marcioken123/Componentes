// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Bubble.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_BubbleHPP
#define Fmxtee_Editor_Series_BubbleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Series.Bubble.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
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
namespace Bubble
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBubbleSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBubbleSeriesEditor : public Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor
{
	typedef Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor inherited;
	
__published:
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBubbleSeriesEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBubbleSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBubbleSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bubble */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_BUBBLE)
using namespace Fmxtee::Editor::Series::Bubble;
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
#endif	// Fmxtee_Editor_Series_BubbleHPP
