// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.DB.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_DbHPP
#define Fmxtee_Editor_DbHPP

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
#include <FMXTee.Editor.Source.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.ListBox.hpp>
#include <Data.DB.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Db
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBSourceEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDBSourceEditor : public Fmxtee::Editor::Source::TBaseSourceEditor
{
	typedef Fmxtee::Editor::Source::TBaseSourceEditor inherited;
	
__published:
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	
private:
	void __fastcall FillSourceDatasets();
	void __fastcall FillSources();
	
protected:
	bool IChanging;
	static Fmxtee::Editor::Source::TOnGetDesignerNamesEvent OnGetDesignerNames;
	Data::Db::TDataSet* __fastcall DataSet();
	void __fastcall FillFields(Fmx::Comboedit::TComboEdit* const *Combos, const int Combos_High);
	virtual bool __fastcall IsValid(System::Classes::TComponent* AComponent);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBSourceEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Source::TBaseSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBSourceEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Source::TBaseSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBSourceEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Db */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_DB)
using namespace Fmxtee::Editor::Db;
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
#endif	// Fmxtee_Editor_DbHPP
