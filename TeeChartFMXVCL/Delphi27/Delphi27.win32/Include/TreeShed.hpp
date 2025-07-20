// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeShEd.pas' rev: 34.00 (Windows)

#ifndef TreeshedHPP
#define TreeshedHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.UITypes.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeFiltersEditor.hpp>
#include <VCLTee.TeeEdiGrad.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeshed
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TNodeTreeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TNodeTreeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabText;
	Vcl::Comctrls::TTabSheet* TabImage;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* ComboBox4;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TButton* Button5;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* CheckBox3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Comctrls::TTabSheet* TabGradient;
	Vcl::Comctrls::TTabSheet* TabShadow;
	Vcl::Comctrls::TTabSheet* TabPosition;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Comctrls::TUpDown* UpDown2;
	Vcl::Comctrls::TUpDown* UpDown3;
	Vcl::Comctrls::TUpDown* UpDown4;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TScrollBar* ScrollBar2;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TScrollBar* ScrollBar3;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TScrollBar* ScrollBar4;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TScrollBar* ScrollBar5;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label16;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Extctrls::TShape* Shape4;
	Vcl::Stdctrls::TLabel* Label18;
	Vcltee::Tecanvas::TComboFlat* ComboBox3;
	Vcl::Stdctrls::TCheckBox* CheckBox5;
	Vcl::Stdctrls::TCheckBox* CheckBox6;
	Vcl::Stdctrls::TEdit* Edit5;
	Vcl::Comctrls::TUpDown* UpDown5;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TEdit* Edit6;
	Vcl::Comctrls::TUpDown* UpDown6;
	Vcl::Stdctrls::TLabel* Label20;
	Vcltee::Tecanvas::TComboFlat* ComboBox5;
	Vcl::Stdctrls::TButton* Button2;
	Vcltee::Tecanvas::TButtonColor* BBackColor;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TEdit* ETransp;
	Vcl::Comctrls::TUpDown* UDTransp;
	Vcl::Stdctrls::TCheckBox* CheckBox8;
	Vcltee::Tecanvas::TComboFlat* CBConnStyle;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Stdctrls::TCheckBox* CBImgTransp;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TLabel* LRoundSize;
	Vcl::Stdctrls::TEdit* ERoundSize;
	Vcl::Comctrls::TUpDown* UDRound;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TCheckBox* CBGradientClip;
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall CheckBox3Click(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall ComboBox4Change(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ScrollBar2Change(System::TObject* Sender);
	void __fastcall ScrollBar4Change(System::TObject* Sender);
	void __fastcall ScrollBar5Change(System::TObject* Sender);
	void __fastcall ScrollBar3Change(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBGradientClipClick(System::TObject* Sender);
	void __fastcall Shape4MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ComboBox3Change(System::TObject* Sender);
	void __fastcall CheckBox5Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CheckBox6Click(System::TObject* Sender);
	void __fastcall Edit5Change(System::TObject* Sender);
	void __fastcall ComboBox5Change(System::TObject* Sender);
	void __fastcall BBackColorClick(System::TObject* Sender);
	void __fastcall ETranspChange(System::TObject* Sender);
	void __fastcall CBConnStyleChange(System::TObject* Sender);
	void __fastcall CheckBox8Click(System::TObject* Sender);
	void __fastcall CBImgTranspClick(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall ERoundSizeChange(System::TObject* Sender);
	
private:
	bool Changing;
	int OldX;
	int OldY;
	Vcltee::Teependlg::TPenDialog* IBorder;
	Vcltee::Teeedigrad::TTeeGradientEditor* IGradient;
	void __fastcall ChangedBorder(System::TObject* Sender);
	void __fastcall ChangedGradient(System::TObject* Sender);
	void __fastcall CheckImgTransp();
	void __fastcall Image1Assign(Vcl::Graphics::TPicture* Value);
	void __fastcall ProcGetCursors(const System::UnicodeString S);
	void __fastcall SetUpDowns();
	
public:
	Teetree::TCustomTree* Tree1;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNodeTreeEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNodeTreeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNodeTreeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TNodeTreeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TTreeShapeTabs : unsigned char { stFormat, stText, stImage, stGradient, stShadow, stPosition };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall EditTreeShape(System::Classes::TComponent* const AOwner, Teetree::TTreeNodeShape* const AShape);
extern DELPHI_PACKAGE void __fastcall EditTreeShapePage(System::Classes::TComponent* const AOwner, Teetree::TTreeNodeShape* const AShape, const TTreeShapeTabs ATab, bool ShowPosition);
extern DELPHI_PACKAGE void __fastcall InternalEditTreeShapePage(System::Classes::TComponent* const AOwner, Teetree::TTreeNodeShape* const AShape, const TTreeShapeTabs ATab, bool ShowPosition, System::Classes::TNotifyEvent CallOnShow);
extern DELPHI_PACKAGE Vcl::Dialogs::TOpenDialog* __fastcall PictureDialog(void);
}	/* namespace Treeshed */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREESHED)
using namespace Treeshed;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeshedHPP
