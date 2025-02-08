// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRVEFormUnit.pas' rev: 31.00 (Windows)

#ifndef LmdrveformunitHPP
#define LmdrveformunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDYParser.hpp>
#include <LMDBaseRefine.hpp>
#include <LMDREFINELEX.hpp>
#include <LMDREFINEParser.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDSearchConsts.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrveformunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRVEForm;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TOnLMDRVEChange)(System::TObject* Sender, System::UnicodeString szText);

class PASCALIMPLEMENTATION TLMDRVEForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl;
	Vcl::Comctrls::TTabSheet* VESheet;
	Vcl::Comctrls::TTabSheet* OptionsPage;
	Vcl::Extctrls::TPanel* Panel;
	Vcl::Comctrls::TTreeView* VETree;
	Vcl::Controls::TImageList* TreeImageList;
	Vcl::Menus::TPopupMenu* OperatorMenu;
	Vcl::Menus::TMenuItem* AND1;
	Vcl::Menus::TMenuItem* OR1;
	Vcl::Menus::TMenuItem* NEAR1;
	Vcl::Extctrls::TTimer* UpdateTimer;
	Vcl::Extctrls::TPanel* BottomPanel;
	Vcl::Extctrls::TNotebook* Pages;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* WordEdit;
	Vcl::Buttons::TSpeedButton* AddButton;
	Vcl::Stdctrls::TCheckBox* NOTCheckBox;
	Vcl::Stdctrls::TRadioButton* ANDRadio;
	Vcl::Stdctrls::TRadioButton* ORRadio;
	Vcl::Stdctrls::TRadioButton* NEARRadio;
	Vcl::Buttons::TSpeedButton* AddOperatorBtn;
	Vcl::Buttons::TSpeedButton* DelBtn;
	Vcl::Buttons::TSpeedButton* GroupBtn;
	Vcl::Buttons::TSpeedButton* UngroupBtn;
	Vcl::Stdctrls::TMemo* SearchMemo;
	Vcl::Buttons::TBitBtn* OpenBBtn;
	Vcl::Buttons::TBitBtn* CloseBBtn;
	Vcl::Buttons::TBitBtn* AsteriskButton;
	Vcl::Buttons::TBitBtn* QuestButton;
	Vcl::Buttons::TBitBtn* NearBtn;
	Vcl::Buttons::TBitBtn* NotBtn;
	Vcl::Buttons::TBitBtn* OrBtn;
	Vcl::Buttons::TBitBtn* AndBtn;
	Vcl::Buttons::TBitBtn* EvaluateButton;
	Vcl::Buttons::TBitBtn* CancelButton;
	Vcl::Buttons::TBitBtn* OKButton;
	Vcl::Stdctrls::TCheckBox* MCCheck;
	Vcl::Stdctrls::TCheckBox* WWCheck;
	Vcl::Buttons::TBitBtn* HelpButton;
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall NEARRadio1Click(System::TObject* Sender);
	void __fastcall AddOperatorBtn1Click(System::TObject* Sender);
	void __fastcall VETreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall VETreeEditing(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall VETreeEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall AND1Click(System::TObject* Sender);
	void __fastcall VETreeGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall VETreeMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall UpdateTimerTimer(System::TObject* Sender);
	void __fastcall SearchMemo1Change(System::TObject* Sender);
	void __fastcall WordEditChange(System::TObject* Sender);
	void __fastcall WordEditKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall AddButtonClick(System::TObject* Sender);
	void __fastcall NEARRadioClick(System::TObject* Sender);
	void __fastcall AddOperatorBtnClick(System::TObject* Sender);
	void __fastcall DelBtnClick(System::TObject* Sender);
	void __fastcall GroupBtnClick(System::TObject* Sender);
	void __fastcall UngroupBtnClick(System::TObject* Sender);
	void __fastcall SearchMemoChange(System::TObject* Sender);
	void __fastcall OpenBBtnClick(System::TObject* Sender);
	void __fastcall CloseBBtnClick(System::TObject* Sender);
	void __fastcall AsteriskButtonClick(System::TObject* Sender);
	void __fastcall QuestButtonClick(System::TObject* Sender);
	void __fastcall AndBtnClick(System::TObject* Sender);
	void __fastcall OrBtnClick(System::TObject* Sender);
	void __fastcall NotBtnClick(System::TObject* Sender);
	void __fastcall NearBtnClick(System::TObject* Sender);
	void __fastcall EvaluateButtonClick(System::TObject* Sender);
	
private:
	bool FSimpleInterface;
	TOnLMDRVEChange FOnChangeSearchString;
	bool __fastcall CheckSelected(void);
	Vcl::Comctrls::TTreeNode* __fastcall AddNewNode(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall SetOnChangeSearchString(const TOnLMDRVEChange Value);
	void __fastcall ChangedSS(void);
	void __fastcall SetSimpleInterface(const bool Value);
	
protected:
	void __fastcall BuildTree(Lmdyparser::TSegment* Code);
	bool __fastcall CheckForNearParam(Vcl::Comctrls::TTreeNode* Node);
	bool __fastcall GetNOT(Vcl::Comctrls::TTreeNode* Node);
	int __fastcall GetTag(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall SetTag(Vcl::Comctrls::TTreeNode* Node, int iTag);
	void __fastcall SetNOT(Vcl::Comctrls::TTreeNode* Node, bool b);
	int __fastcall GetUITag(void);
	void __fastcall AddSearchString(System::UnicodeString szAdd);
	
public:
	System::WideChar AnySingleCharacter;
	System::WideChar AnySequenceCharacter;
	void __fastcall UpdateBuilder(void);
	void __fastcall UpdateOnShow(void);
	void __fastcall UpdateBtn(void);
	System::UnicodeString __fastcall BuildSearchString(Vcl::Comctrls::TTreeNode* Node = (Vcl::Comctrls::TTreeNode*)(0x0), System::UnicodeString szOperator = L"AND");
	bool __fastcall BuildVE(System::UnicodeString szString);
	void __fastcall SetSearchString(System::UnicodeString szString);
	
__published:
	__property bool SimpleInterface = {read=FSimpleInterface, write=SetSimpleInterface, nodefault};
	__property TOnLMDRVEChange OnChangeSearchString = {read=FOnChangeSearchString, write=SetOnChangeSearchString};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRVEForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRVEForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRVEForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRVEForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 T_OR = System::Int8(0x0);
static const System::Int8 T_AND = System::Int8(0x1);
static const System::Int8 T_NEAR = System::Int8(0x2);
}	/* namespace Lmdrveformunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRVEFORMUNIT)
using namespace Lmdrveformunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrveformunitHPP
