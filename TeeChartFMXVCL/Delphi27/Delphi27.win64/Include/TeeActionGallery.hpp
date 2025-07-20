// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeActionGallery.pas' rev: 34.00 (Windows)

#ifndef TeeactiongalleryHPP
#define TeeactiongalleryHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeLoadBlock.hpp>
#include <TeeBlockEditor.hpp>
#include <TeeMakerControl.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeactiongallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActionGallery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TActionGallery : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Comctrls::TTabSheet* TabLoad;
	Vcl::Comctrls::TTabSheet* TabBrowse;
	Vcl::Comctrls::TTabSheet* TabPlay;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBURL;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBObject;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBAnimation;
	Vcl::Stdctrls::TButton* BTestAnimation;
	Vcl::Comctrls::TTabSheet* TabAction;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBObjectAction;
	Vcl::Comctrls::TTabSheet* TabEvents;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBObjectEvents;
	Vcltee::Tecanvas::TComboFlat* CBEvents;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTabSheet* TabSetProperty;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelProperty;
	Vcl::Stdctrls::TGroupBox* GroupRight;
	Vcl::Stdctrls::TRadioButton* RBConstant;
	Vcl::Stdctrls::TRadioButton* RBProperty;
	Vcl::Stdctrls::TButton* BSelectRight;
	Vcl::Stdctrls::TEdit* EConstant;
	Vcl::Stdctrls::TCheckBox* CBNot;
	Vcl::Stdctrls::TLabel* LabelRight;
	Vcl::Comctrls::TTabSheet* TabDrag;
	Vcl::Stdctrls::TLabel* LabelDrag;
	Vcl::Stdctrls::TButton* BDrag;
	Vcl::Stdctrls::TCheckBox* CBDragInvert;
	Vcl::Stdctrls::TCheckBox* CBDragMinMax;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TEdit* EDragMin;
	Vcl::Stdctrls::TEdit* EDragMax;
	Vcl::Buttons::TSpeedButton* SBConstant;
	Vcl::Stdctrls::TRadioButton* RBObjectEvent;
	Vcl::Stdctrls::TRadioButton* RBDelphiEvent;
	Vcl::Comctrls::TTabSheet* TabSound;
	Vcl::Stdctrls::TLabel* Label10;
	Vcltee::Tecanvas::TComboFlat* CBSoundFile;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Comctrls::TTabSheet* TabDelay;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TEdit* EDelay;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TGroupBox* GroupAnimation;
	Vcl::Stdctrls::TCheckBox* CBAnimated;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Comctrls::TTrackBar* TBDuration;
	Vcl::Stdctrls::TLabel* LabelDuration;
	Vcl::Stdctrls::TListBox* ListActions;
	Vcl::Comctrls::TTreeView* BlockEvents;
	Vcl::Stdctrls::TButton* BSoundPreview;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TCheckBox* CBIncrement;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Buttons::TSpeedButton* SpeedButton3;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TLabel* LDragAction;
	Vcl::Comctrls::TTabSheet* TabRepaint;
	Vcl::Comctrls::TTabSheet* TabTimer;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TEdit* ETimer;
	Vcl::Comctrls::TUpDown* UDTimer;
	Vcl::Stdctrls::TCheckBox* CBTimerRepeat;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TLabel* LTimerAction;
	Vcl::Buttons::TSpeedButton* SpeedButton4;
	Vcl::Stdctrls::TLabel* LTimerInterval;
	Vcl::Buttons::TSpeedButton* SpeedButton5;
	Vcl::Stdctrls::TLabel* LDelay;
	Vcl::Comctrls::TUpDown* UDDelay;
	void __fastcall CBObjectChange(System::TObject* Sender);
	void __fastcall CBAnimationChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BTestAnimationClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBObjectActionChange(System::TObject* Sender);
	void __fastcall CBURLChange(System::TObject* Sender);
	void __fastcall CBObjectEventsChange(System::TObject* Sender);
	void __fastcall CBEventsChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall RBConstantClick(System::TObject* Sender);
	void __fastcall RBPropertyClick(System::TObject* Sender);
	void __fastcall BSelectRightClick(System::TObject* Sender);
	void __fastcall EConstantChange(System::TObject* Sender);
	void __fastcall BDragClick(System::TObject* Sender);
	void __fastcall CBDragMinMaxClick(System::TObject* Sender);
	void __fastcall SBConstantClick(System::TObject* Sender);
	void __fastcall RBObjectEventClick(System::TObject* Sender);
	void __fastcall RBDelphiEventClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall CBSoundFileChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall TBDurationChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListActionsClick(System::TObject* Sender);
	void __fastcall BlockEventsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall BSoundPreviewClick(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall ETimerChange(System::TObject* Sender);
	void __fastcall SpeedButton5Click(System::TObject* Sender);
	void __fastcall EDelayChange(System::TObject* Sender);
	
private:
	Teeloadblock::TLoadBlockDialog* ILoadDialog;
	System::TObject* DragComp;
	System::TObject* LeftComp;
	System::TObject* RightComp;
	System::UnicodeString DragProp;
	System::UnicodeString LeftProp;
	System::UnicodeString RightProp;
	void __fastcall ChangeEvents(Vcl::Stdctrls::TComboBox* AObjects, Vcl::Stdctrls::TComboBox* AEvents);
	__classmethod System::UnicodeString __fastcall CheckObjectName(Teeblocks::TCustomBlock* AObject);
	void __fastcall FillObjectsAction();
	void __fastcall FillObjectsEvents(Vcl::Stdctrls::TComboBox* AObjects, Vcl::Stdctrls::TComboBox* AEvents);
	System::UnicodeString __fastcall ObjectAction(System::TObject* AComp, const System::UnicodeString AProp);
	System::UnicodeString __fastcall ObjectEvent(Vcl::Stdctrls::TComboBox* AObjects, Vcl::Stdctrls::TComboBox* AEvents);
	bool __fastcall SelectProperty(System::TObject* &AObject, System::UnicodeString &AName);
	
public:
	Teeblocks::TBlocks* Blocks;
	Teeblocks::TCustomBlock* Current;
	Teemakercontrol::TMaker* Maker;
	System::UnicodeString __fastcall ActionText();
	__classmethod void __fastcall AddBasicEvents(Vcl::Comctrls::TTreeView* Tree);
	__classmethod void __fastcall AddTreeEvent(Vcl::Comctrls::TTreeView* Tree, System::UnicodeString Text);
	__classmethod System::UnicodeString __fastcall IndexToEvent(Vcl::Comctrls::TTreeNode* Node);
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TCustomBlock* ABlock, Teemakercontrol::TMaker* AMaker, /* out */ System::UnicodeString &ResultAction, const System::UnicodeString AAction = System::UnicodeString());
	__classmethod System::UnicodeString __fastcall ObjectPathName(Teeblocks::TCustomBlock* AObject);
	__classmethod System::UnicodeString __fastcall PropertyText(System::TObject* const AObject, const System::UnicodeString AName)/* overload */;
	__classmethod System::UnicodeString __fastcall PropertyText(Vcltee::Teeanimate::TPropertyLink* Link)/* overload */;
	void __fastcall SetActionText(const System::UnicodeString Value);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TActionGallery(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TActionGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TActionGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TActionGallery(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeactiongallery */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEACTIONGALLERY)
using namespace Teeactiongallery;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeactiongalleryHPP
