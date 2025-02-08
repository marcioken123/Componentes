// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCommon.pas' rev: 31.00 (Windows)

#ifndef PlmdcommonHPP
#define PlmdcommonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcommon
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDsgnGlobalEditorOption : unsigned char { geoBrushEditor, geoCaptionEditor, geoHintEditor, geoHotKeyEditor, geoStringEditor, geoFontOI, geoBooleanOI, geoSetOI, geoWideStringEditor };

typedef System::Set<TLMDDsgnGlobalEditorOption, TLMDDsgnGlobalEditorOption::geoBrushEditor, TLMDDsgnGlobalEditorOption::geoWideStringEditor> TLMDDsgnGlobalEditorOptions;

enum DECLSPEC_DENUM TLMDToolsEditorOption : unsigned char { leoInstallLabeledControls, leoInstallDesignEditorControls, leoInstallScriptPackImporter };

typedef System::Set<TLMDToolsEditorOption, TLMDToolsEditorOption::leoInstallLabeledControls, TLMDToolsEditorOption::leoInstallScriptPackImporter> TLMDToolsEditorOptions;

//-- var, const, procedure ---------------------------------------------------
#define sLMDCategoryName L"LMD-Tools"
extern DELPHI_PACKAGE TLMDDsgnGlobalEditorOptions LMDGLOBALEDITOROPTIONS;
extern DELPHI_PACKAGE TLMDToolsEditorOptions LMDTOOLSEDITOROPTIONS;
extern DELPHI_PACKAGE void __fastcall LMDDsgnRefreshOptions(void);
extern DELPHI_PACKAGE void __fastcall LMDDsgnGetJPEGResource(NativeUInt Instance, const System::UnicodeString aName, Vcl::Graphics::TPicture* aPicture);
extern DELPHI_PACKAGE void __fastcall LMDComLoadDelphiCustomColor(System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDComSaveDelphiCustomColor(System::Classes::TStrings* aList);
}	/* namespace Plmdcommon */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCOMMON)
using namespace Plmdcommon;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcommonHPP
