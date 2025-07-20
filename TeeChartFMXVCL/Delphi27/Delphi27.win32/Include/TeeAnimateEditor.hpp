// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeAnimateEditor.pas' rev: 34.00 (Windows)

#ifndef TeeanimateeditorHPP
#define TeeanimateeditorHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeInspector.hpp>
#include <Vcl.ImgList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeanimateeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeAnimateEditor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnimateEditorEvent)(System::TObject* Sender, /* out */ Vcltee::Teeanimate::TTeeAnimation* &Animation);

typedef void __fastcall (__closure *TAnimateGalleryEvent)(System::TObject* Sender, /* out */ Vcltee::Teeanimate::TTeeAnimation* &Animation, Vcltee::Teeanimate::TTeeAnimation* const AParent);

typedef void __fastcall (__closure *TAnimateGetName)(Vcltee::Teeanimate::TTeeAnimation* const Animation, /* out */ System::UnicodeString &S);

enum DECLSPEC_DENUM TClickedItem : unsigned char { ciNone, ciBody, ciLeftSide, ciRightSide };

class PASCALIMPLEMENTATION TTeeAnimateEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Buttons::TSpeedButton* SBPlay;
	Vcl::Buttons::TSpeedButton* SBPause;
	Vcl::Buttons::TSpeedButton* SBStop;
	Vcl::Buttons::TSpeedButton* SBFrame;
	Vcl::Comctrls::TTrackBar* TBFramesPerSecond;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* PanelAnim;
	Vcl::Extctrls::TPanel* PanelAnimTop;
	Vcl::Extctrls::TPanel* PanelAnimTree;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Comctrls::TUpDown* UpScale;
	Vcltee::Teeinspector::TTeeInspector* TeeInspector1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Buttons::TSpeedButton* SBClose;
	Vcl::Comctrls::TStatusBar* StatusBar1;
	Vcl::Extctrls::TPanel* PanelEditor;
	Vcl::Comctrls::TUpDown* UpHeight;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Insert1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* Duplicate1;
	Vcl::Extctrls::TPanel* PanelGroups;
	Vcltee::Tecanvas::TComboFlat* ComboGroups;
	Vcl::Buttons::TSpeedButton* SBAddGroup;
	Vcl::Buttons::TSpeedButton* SBRemoveGroup;
	Vcl::Buttons::TSpeedButton* SBCloseTree;
	Vcl::Comctrls::TTreeView* ListAnim;
	Vcl::Stdctrls::TLabel* LFramesPerSecond;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* View1;
	Vcl::Menus::TMenuItem* Flat1;
	Vcl::Menus::TMenuItem* ree1;
	Vcl::Controls::TImageList* Images;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabAnimEditor;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Buttons::TSpeedButton* SBAdd;
	Vcl::Buttons::TSpeedButton* SBRemove;
	Vcl::Extctrls::TPaintBox* PaintBox1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TreeMapScroll(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBPlayClick(System::TObject* Sender);
	void __fastcall TreeMapAfterDraw(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall SBPauseClick(System::TObject* Sender);
	void __fastcall TBFramesPerSecondChange(System::TObject* Sender);
	void __fastcall SBStopClick(System::TObject* Sender);
	void __fastcall CBLoopClick(System::TObject* Sender);
	void __fastcall SBFrameClick(System::TObject* Sender);
	void __fastcall TreeMapDeletedShapes(System::TObject* Sender);
	void __fastcall SBRemoveClick(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall Tree1DeletedShapes(System::TObject* Sender);
	void __fastcall TeeInspector1Items2Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items3Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items1Change(System::TObject* Sender);
	void __fastcall TeeInspector1Items4Change(System::TObject* Sender);
	void __fastcall SBCloseClick(System::TObject* Sender);
	void __fastcall PanelAnimResize(System::TObject* Sender);
	void __fastcall UpHeightClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall Delete1Click(System::TObject* Sender);
	void __fastcall Insert1Click(System::TObject* Sender);
	void __fastcall Duplicate1Click(System::TObject* Sender);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall SBCloseTreeClick(System::TObject* Sender);
	void __fastcall ListAnimChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall Flat1Click(System::TObject* Sender);
	void __fastcall ree1Click(System::TObject* Sender);
	void __fastcall ListAnimGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall ListAnimGetSelectedIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall ListAnimDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall ListAnimDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall ListAnimMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListAnimCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall ListAnimEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall PaintBox1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PaintBox1MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PaintBox1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
private:
	Vcltee::Teeanimate::TTeeAnimate* FAnimate;
	TAnimateGalleryEvent FOnGallery;
	TAnimateGetName FOnGetAnimationName;
	System::Classes::TNotifyEvent FOnModified;
	TAnimateEditorEvent FOnSelectedAnimation;
	Vcltee::Teeanimate::TTeeAnimateEvents FEvents;
	bool Changing;
	bool ITranslated;
	int IOldX;
	int IDragging;
	TClickedItem IDraggingMode;
	void __fastcall AddNewAnimation(Vcltee::Teeanimate::TTeeAnimation* const Animation);
	void __fastcall AnimateDeletedShapes(System::TObject* Sender);
	void __fastcall AnimateClear(System::TObject* Sender);
	void __fastcall AnimateContinue(System::TObject* Sender);
	void __fastcall AnimateFrame(System::TObject* Sender);
	void __fastcall AnimatePause(System::TObject* Sender);
	void __fastcall AnimatePlay(System::TObject* Sender);
	void __fastcall AnimateStop(System::TObject* Sender);
	TClickedItem __fastcall ClickedItem(int Index, int X, int Y);
	void __fastcall FillNodes();
	int __fastcall NodeIndex(Vcl::Comctrls::TTreeNode* const Node);
	void __fastcall SelectAnimation(Vcltee::Teeanimate::TTeeAnimation* const Animation);
	void __fastcall SetAnimate(Vcltee::Teeanimate::TTeeAnimate* const Value);
	void __fastcall SetScales();
	void __fastcall TeeModified();
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__classmethod void __fastcall ModalShow(System::Classes::TComponent* const AOwner, Vcltee::Teeanimate::TTeeAnimate* const TeeAnimate, const TAnimateGalleryEvent AGallery, const TAnimateEditorEvent ASelected);
	void __fastcall RefreshAnimate();
	void __fastcall RestoreAnimate();
	Vcltee::Teeanimate::TTeeAnimation* __fastcall Selected();
	__property Vcltee::Teeanimate::TTeeAnimate* Animate = {read=FAnimate, write=SetAnimate};
	__property TAnimateGetName OnGetAnimationName = {read=FOnGetAnimationName, write=FOnGetAnimationName};
	__property System::Classes::TNotifyEvent OnModified = {read=FOnModified, write=FOnModified};
	__property TAnimateEditorEvent OnSelectedAnimation = {read=FOnSelectedAnimation, write=FOnSelectedAnimation};
	__property TAnimateGalleryEvent OnShowGallery = {read=FOnGallery, write=FOnGallery};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeAnimateEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeAnimateEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeAnimateEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeAnimateEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeanimateeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEANIMATEEDITOR)
using namespace Teeanimateeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeanimateeditorHPP
