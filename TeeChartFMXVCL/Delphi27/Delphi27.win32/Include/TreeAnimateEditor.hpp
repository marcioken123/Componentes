// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeAnimateEditor.pas' rev: 34.00 (Windows)

#ifndef TreeanimateeditorHPP
#define TreeanimateeditorHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeTree.hpp>
#include <TreeEd.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TreeAnimate.hpp>
#include <VCLTee.TeeInspector.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeanimateeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeAnimateEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeAnimateEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Buttons::TSpeedButton* SBPlay;
	Vcl::Buttons::TSpeedButton* SBPause;
	Vcl::Buttons::TSpeedButton* SBStop;
	Vcl::Buttons::TSpeedButton* SBFrame;
	Vcl::Buttons::TSpeedButton* SpeedButton5;
	Vcl::Buttons::TSpeedButton* SpeedButton6;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TrackBar1;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Extctrls::TSplitter* Splitter1;
	Teetree::TTree* TreeMap;
	Teetree::TTree* Tree1;
	Vcl::Extctrls::TPanel* PanelAnim;
	Teetree::TTreeRuler* Ruler;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Comctrls::TUpDown* UpScale;
	Vcltee::Teeinspector::TTeeInspector* TeeInspector1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Buttons::TSpeedButton* SBClose;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TreeMapScroll(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBPlayClick(System::TObject* Sender);
	void __fastcall TreeMapAfterDraw(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall SBPauseClick(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall SBStopClick(System::TObject* Sender);
	void __fastcall CBLoopClick(System::TObject* Sender);
	void __fastcall SBFrameClick(System::TObject* Sender);
	void __fastcall TreeMapSelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall Tree1SelectShape(Teetree::TTreeNodeShape* Sender);
	void __fastcall TreeMapDeletedShapes(System::TObject* Sender);
	void __fastcall TreeMapDeletingShapes(Teetree::TSelectedShapeList* Sender, bool &AllowDelete);
	void __fastcall TreeMapMovingShape(Teetree::TTreeNodeShape* Sender, int &DeltaX, int &DeltaY);
	void __fastcall TreeMapResizingShape(Teetree::TTreeNodeShape* Sender, Teetree::TTreeShapeHandle ACorner, int &DeltaX, int &DeltaY);
	void __fastcall SpeedButton6Click(System::TObject* Sender);
	void __fastcall SpeedButton5Click(System::TObject* Sender);
	void __fastcall Tree1DeletedShapes(System::TObject* Sender);
	void __fastcall RulerGetUnit(Teetree::TTreeRuler* Sender, int Pixel, System::UnicodeString &Text);
	void __fastcall UpScaleClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall TeeInspector1Items2Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items3Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items1Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items0Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items4Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items0GetItems(Vcltee::Teeinspector::TInspectorItem* Sender, Vcltee::Teeinspector::TGetItemProc Proc);
	void __fastcall TeeInspector1Items6Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items5Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items7Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items8Change(System::TObject* Sender);
	void __fastcall SBCloseClick(System::TObject* Sender);
	void __fastcall PanelAnimResize(System::TObject* Sender);
	void __fastcall TeeInspector1Items9GetItems(Vcltee::Teeinspector::TInspectorItem* Sender, Vcltee::Teeinspector::TGetItemProc Proc);
	void __fastcall TeeInspector1Items9Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items10GetItems(Vcltee::Teeinspector::TInspectorItem* Sender, Vcltee::Teeinspector::TGetItemProc Proc);
	void __fastcall TeeInspector1Items10Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items11GetItems(Vcltee::Teeinspector::TInspectorItem* Sender, Vcltee::Teeinspector::TGetItemProc Proc);
	void __fastcall TeeInspector1Items11Change(System::TObject* Sender);
	
private:
	Treeanimate::TTreeAnimate* FAnimate;
	System::Classes::TNotifyEvent FOnModified;
	Vcltee::Teeanimate::TTeeAnimateEvents FEvents;
	bool Changing;
	int IHorizScale;
	int IVertScale;
	void __fastcall AnimateDeletedShapes(System::TObject* Sender);
	void __fastcall AnimateClear(System::TObject* Sender);
	void __fastcall AnimateContinue(System::TObject* Sender);
	void __fastcall AnimateFrame(System::TObject* Sender);
	void __fastcall AnimatePause(System::TObject* Sender);
	void __fastcall AnimatePlay(System::TObject* Sender);
	void __fastcall AnimateStop(System::TObject* Sender);
	void __fastcall FillNodes();
	System::UnicodeString __fastcall NodeText(Teetree::TTreeNodeShape* ANode);
	void __fastcall TeeModified();
	Vcltee::Teeanimate::TTeeAnimation* __fastcall TheAction();
	Teetree::TTreeNodeShape* __fastcall TheActionBar();
	void __fastcall SetActionBarColor();
	void __fastcall SetAnimate(Treeanimate::TTreeAnimate* const Value);
	
public:
	__property Treeanimate::TTreeAnimate* Animate = {read=FAnimate, write=SetAnimate};
	__classmethod void __fastcall ModalShow(System::Classes::TComponent* AOwner, Treeanimate::TTreeAnimate* TreeAnimate);
	__property System::Classes::TNotifyEvent OnModified = {read=FOnModified, write=FOnModified};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTreeAnimateEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTreeAnimateEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTreeAnimateEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeAnimateEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treeanimateeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEANIMATEEDITOR)
using namespace Treeanimateeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeanimateeditorHPP
