// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXTreeCellCombo.pas' rev: 31.00 (Windows)

#ifndef ElxtreecellcomboHPP
#define ElxtreecellcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDProcs.hpp>
#include <ElHeader.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElXTree.hpp>
#include <ElXTreeCell.hpp>
#include <ElTreeComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elxtreecellcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElItemsStrings;
class DELPHICLASS TElXCellComboBox;
class DELPHICLASS TElXCellCombpInplaceCombo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElItemsStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
public:
	/* TStringList.Create */ inline __fastcall TElItemsStrings(void)/* overload */ : System::Classes::TStringList() { }
	/* TStringList.Create */ inline __fastcall TElItemsStrings(bool OwnsObjects)/* overload */ : System::Classes::TStringList(OwnsObjects) { }
	/* TStringList.Create */ inline __fastcall TElItemsStrings(System::WideChar QuoteChar, System::WideChar Delimiter)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter) { }
	/* TStringList.Create */ inline __fastcall TElItemsStrings(System::WideChar QuoteChar, System::WideChar Delimiter, System::Classes::TStringsOptions Options)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter, Options) { }
	/* TStringList.Create */ inline __fastcall TElItemsStrings(System::Types::TDuplicates Duplicates, bool Sorted, bool CaseSensitive)/* overload */ : System::Classes::TStringList(Duplicates, Sorted, CaseSensitive) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TElItemsStrings(void) { }
	
};


class PASCALIMPLEMENTATION TElXCellComboBox : public Elxtreecell::TElXCellControl
{
	typedef Elxtreecell::TElXCellControl inherited;
	
private:
	Lmdtypes::TLMDString __fastcall GetText(void);
	void __fastcall SetText(const Lmdtypes::TLMDString Value);
	
protected:
	System::Types::TRect FArrRect;
	int FItemIndex;
	int FDropDownWidth;
	bool FAutoCompletion;
	Vcl::Stdctrls::TComboBoxStyle FStyle;
	bool FIsHTML;
	Lmdtypes::TLMDString FText;
	System::Classes::TStrings* FItems;
	bool FMouseOverArrow;
	Elxtreecell::TElXCustomTreeCell* FCell;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnDropDown;
	System::Classes::TNotifyEvent FOnCloseUp;
	void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall InternalChange(System::TObject* Sender);
	void __fastcall TranslateOnDropDown(System::TObject* Sender);
	void __fastcall TranslateOnCloseUp(System::TObject* Sender);
	
public:
	virtual void __fastcall SetControlActive(void);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseMoveEvent(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Assign(Elxtreecell::TElXCellControl* Source);
	__fastcall virtual TElXCellComboBox(void);
	__fastcall virtual ~TElXCellComboBox(void);
	virtual void __fastcall Paint(Elxtreecell::TElXCustomTreeCell* ACell, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
__published:
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property System::Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, nodefault};
	__property bool AutoCompletion = {read=FAutoCompletion, write=FAutoCompletion, nodefault};
	__property Vcl::Stdctrls::TComboBoxStyle Style = {read=FStyle, write=FStyle, nodefault};
	__property bool IsHTML = {read=FIsHTML, write=FIsHTML, nodefault};
};


class PASCALIMPLEMENTATION TElXCellCombpInplaceCombo : public Eltreecombobox::TElTreeInplaceComboBox
{
	typedef Eltreecombobox::TElTreeInplaceComboBox inherited;
	
public:
	virtual void __fastcall CompleteOperation(bool Accepted);
public:
	/* TElTreeInplaceComboBox.Create */ inline __fastcall virtual TElXCellCombpInplaceCombo(System::Classes::TComponent* AOwner) : Eltreecombobox::TElTreeInplaceComboBox(AOwner) { }
	/* TElTreeInplaceComboBox.Destroy */ inline __fastcall virtual ~TElXCellCombpInplaceCombo(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElXCellCombpInplaceCombo* HelperInplaceCombo;
}	/* namespace Elxtreecellcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXTREECELLCOMBO)
using namespace Elxtreecellcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxtreecellcomboHPP
