// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomCheckListDlg.pas' rev: 31.00 (Windows)

#ifndef LmdcustomchecklistdlgHPP
#define LmdcustomchecklistdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <LMDClass.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDCheckListBox.hpp>
#include <LMDButtonListData.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomchecklistdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomCheckListDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdcustomchecklistdlg__1 : unsigned char { cloRadioButtons, cloHideBox, cloCheckButtons, cloSelectByClick, cloSpeedBtnFlat, cloUseResetButton };

typedef System::Set<Lmdcustomchecklistdlg__1, Lmdcustomchecklistdlg__1::cloRadioButtons, Lmdcustomchecklistdlg__1::cloUseResetButton> TLMDCheckListBoxDlgOptions;

class PASCALIMPLEMENTATION TLMDCustomCheckListDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::Classes::TStrings* FItems;
	System::Byte FMargin;
	int FDefaultValue;
	int FResult;
	int FItemIndex;
	int FItemHeight;
	int FWidth;
	int FListWidth;
	int FListHeight;
	TLMDCheckListBoxDlgOptions FOptions;
	System::UnicodeString FPrompt;
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	void __fastcall GetCheckClick(System::TObject* Sender);
	bool __fastcall GetChecked(int index);
	Lmdchecklistbox::TLMDCheckListBox* __fastcall GetCheckListBox(void);
	
protected:
	bool __fastcall ShowDialog(const System::UnicodeString Caption, const System::UnicodeString Prompt, System::Classes::TStrings* aList, int aValue, Vcl::Forms::TCustomForm* Main);
	
public:
	__fastcall virtual TLMDCustomCheckListDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomCheckListDlg(void);
	virtual bool __fastcall Execute(void);
	virtual bool __fastcall ExecuteEnh(Vcl::Forms::TForm* aForm);
	bool __fastcall DisplayOptionsDlg(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::Classes::TStrings* theOptions, int &aValue)/* overload */;
	bool __fastcall DisplayOptionsDlg(System::Classes::TStrings* theOptions, int &aValue)/* overload */;
	__property CtlXP = {default=1};
	__property int Value = {read=FResult, nodefault};
	__property bool Checked[int Index] = {read=GetChecked};
	__property Lmdchecklistbox::TLMDCheckListBox* CheckListBox = {read=GetCheckListBox};
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property int DefaultValue = {read=FDefaultValue, write=FDefaultValue, default=0};
	__property Effect = {default=0};
	__property Hints;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property int ListBoxShowItems = {read=FListHeight, write=FListHeight, default=-1};
	__property int ListBoxItemHeight = {read=FItemHeight, write=FItemHeight, default=16};
	__property int ListBoxItemIndex = {read=FItemIndex, write=FItemIndex, default=-1};
	__property int ListBoxWidth = {read=FListWidth, write=FListWidth, default=-1};
	__property TLMDCheckListBoxDlgOptions Options = {read=FOptions, write=FOptions, default=28};
	__property System::Byte Margin = {read=FMargin, write=FMargin, default=3};
	__property int Width = {read=FWidth, write=FWidth, default=-1};
	__property Position = {default=5};
	__property System::UnicodeString Prompt = {read=FPrompt, write=FPrompt};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnCustomClick;
	__property OnCustomize;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDCPSelectValueDialog(System::TObject* Instance, const System::UnicodeString PropName, Lmdclass::TLMDThemeMode vCtlXP = (Lmdclass::TLMDThemeMode)(0x0));
}	/* namespace Lmdcustomchecklistdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCHECKLISTDLG)
using namespace Lmdcustomchecklistdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomchecklistdlgHPP
