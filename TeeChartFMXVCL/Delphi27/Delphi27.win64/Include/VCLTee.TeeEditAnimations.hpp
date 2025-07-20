// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEditAnimations.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeeditanimationsHPP
#define Vcltee_TeeeditanimationsHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeAnimations.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeAnimationEditor.hpp>
#include <VCLTee.TeeAnimationEditors.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeeditanimations
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormTeeAnimations;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFormTeeAnimations : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* PanelEditor;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TListBox* LBAnims;
	Vcl::Extctrls::TPanel* PanelItems;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabAnimation;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TListBox* LBItems;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Buttons::TSpeedButton* SBPlay;
	Vcl::Buttons::TSpeedButton* SBPause;
	Vcl::Buttons::TSpeedButton* SBStop;
	Vcl::Buttons::TSpeedButton* SBFrame;
	Vcl::Stdctrls::TLabel* LFramesPerSecond;
	Vcl::Comctrls::TTrackBar* TBFramesPerSecond;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Buttons::TSpeedButton* BAdd;
	Vcl::Buttons::TSpeedButton* BDelete;
	Vcl::Buttons::TSpeedButton* SBAddItem;
	Vcl::Buttons::TSpeedButton* BDeleteItem;
	Vcl::Buttons::TSpeedButton* BRename;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Extctrls::TTimer* Timer1;
	Vcltee::Tecanvas::TComboFlat* CBSpeed;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Stdctrls::TCheckBox* CBAutoPlay;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall SBPlayClick(System::TObject* Sender);
	void __fastcall SBPauseClick(System::TObject* Sender);
	void __fastcall SBStopClick(System::TObject* Sender);
	void __fastcall SBFrameClick(System::TObject* Sender);
	void __fastcall TBFramesPerSecondChange(System::TObject* Sender);
	void __fastcall CBLoopClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall LBAnimsClick(System::TObject* Sender);
	void __fastcall LBItemsClick(System::TObject* Sender);
	void __fastcall SBAddItemClick(System::TObject* Sender);
	void __fastcall BDeleteItemClick(System::TObject* Sender);
	void __fastcall BRenameClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall CBSpeedChange(System::TObject* Sender);
	void __fastcall CBAutoPlayClick(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TTeeAnimate* IAnimate;
	Vcltee::Teeanimations::TTeeAnimationTool* IOldAnimation;
	Vcltee::Teeanimationeditor::TAnimationEditor* IAnimEditor;
	void __fastcall AnimateStop(System::TObject* Sender);
	void __fastcall ChangedAnimation(System::TObject* Sender);
	void __fastcall CheckPlayButtons(System::TObject* Sender);
	void __fastcall ClearOnChangeEvent();
	void __fastcall ClearOnStopEvent();
	void __fastcall FillAnimations();
	Vcltee::Teeanimations::TTeeAnimationTool* __fastcall NewAnimation();
	void __fastcall PopupSelected(System::TObject* Sender);
	void __fastcall RefreshAnimate(Vcltee::Teeanimate::TTeeAnimate* const Value);
	Vcltee::Teeanimate::TTeeAnimate* __fastcall SelectedAnimate();
	Vcltee::Teeanimations::TTeeAnimationTool* __fastcall SelectedAnimation();
	Vcltee::Teeanimate::TTeeAnimation* __fastcall SelectedItem();
	
protected:
	System::Classes::TNotifyEvent OnAdded;
	System::Classes::TNotifyEvent OnDeleted;
	
public:
	Vcltee::Teengine::TChartAnimations* Animations;
	__classmethod bool __fastcall Edit(System::Classes::TComponent* const AOwner, Vcltee::Teeanimate::TTeeAnimate* const Animate)/* overload */;
	__classmethod bool __fastcall Edit(System::Classes::TComponent* const AOwner, Vcltee::Chart::TChart* const AChart)/* overload */;
	void __fastcall RefreshAnimations(Vcltee::Teengine::TChartAnimations* const Value);
	void __fastcall Reload();
	void __fastcall SelectAnimation(Vcltee::Teengine::TTeeCustomAnimation* const Value);
	void __fastcall SelectIfAny();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormTeeAnimations(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormTeeAnimations(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormTeeAnimations() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormTeeAnimations(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeeditanimations */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEDITANIMATIONS)
using namespace Vcltee::Teeeditanimations;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeeditanimationsHPP
