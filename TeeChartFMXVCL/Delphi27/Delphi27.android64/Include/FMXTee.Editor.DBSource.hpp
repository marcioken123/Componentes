// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.DBSource.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_DbsourceHPP
#define Fmxtee_Editor_DbsourceHPP

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
#include <FMXTee.Editor.DB.hpp>
#include <FMX.ListBox.hpp>
#include <Data.DB.hpp>
#include <FMXTee.Editor.SelectList.hpp>
#include <FMX.Layouts.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Dbsource
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBChartSourceEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDBChartSourceEditor : public Fmxtee::Editor::Db::TDBSourceEditor
{
	typedef Fmxtee::Editor::Db::TDBSourceEditor inherited;
	
__published:
	Fmx::Layouts::TLayout* Layout1;
	void __fastcall BApplyClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	HIDESBASE void __fastcall CBSourcesChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Selectlist::TSelectListForm* ISources;
	HIDESBASE void __fastcall FillFields();
	Data::Db::TDataSource* __fastcall DataSource();
	void __fastcall OnChangeSources(System::TObject* Sender);
	
protected:
	virtual bool __fastcall IsValid(System::Classes::TComponent* AComponent);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBChartSourceEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBChartSourceEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Db::TDBSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBChartSourceEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dbsource */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_DBSOURCE)
using namespace Fmxtee::Editor::Dbsource;
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
#endif	// Fmxtee_Editor_DbsourceHPP
