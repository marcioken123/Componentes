// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeComma.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecommaHPP
#define Vcltee_TeecommaHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.Chart.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecomma
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomTeeCommander;
class DELPHICLASS TTeeCommander;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomTeeCommander : public Vcltee::Teeprocs::TCustomPanelNoCaption
{
	typedef Vcltee::Teeprocs::TCustomPanelNoCaption inherited;
	
private:
	Vcltee::Tecanvas::TTeeGradient* FGradient;
	System::Uitypes::TMouseButton FMouseButton;
	Vcltee::Teeprocs::TCustomTeePanel* FPanel;
	bool FVertical;
	void __fastcall CanvasChanged(System::TObject* Sender);
	void __fastcall CheckVerticalAlign();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall ReAlignTeeControls();
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetVertical(bool Value);
	
protected:
	bool FDragging;
	int __fastcall ChildCount();
	Vcl::Controls::TControl* __fastcall GetChild(int Index);
	HIDESBASE virtual void __fastcall DoMouseDown(int X, int Y);
	virtual void __fastcall DoMouseMove(int X, int Y, const System::Classes::TShiftState Shift);
	HIDESBASE virtual void __fastcall DoMouseUp();
	virtual bool __fastcall DoPanelMouse();
	void __fastcall FreeOwnedControls();
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint();
	DYNAMIC void __fastcall RemovingControl(System::Classes::TComponent* const AComponent);
	virtual void __fastcall SetPanel(Vcltee::Teeprocs::TCustomTeePanel* const Value);
	virtual void __fastcall ShowHideControls(bool Value);
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	System::UnicodeString __fastcall TeePanelClass();
	
public:
	__fastcall virtual TCustomTeeCommander(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTeeCommander();
	void __fastcall CreateBevel(int APos);
	Vcl::Buttons::TSpeedButton* __fastcall CreateButton(int APos, System::Classes::TNotifyEvent AProc, const System::UnicodeString AHint, const System::UnicodeString AResName, int AGroupIndex)/* overload */;
	Vcl::Buttons::TSpeedButton* __fastcall CreateButton(int APos, System::Classes::TNotifyEvent AProc, const System::UnicodeString AHint, Vcl::Graphics::TBitmap* const ABitmap, int AGroupIndex)/* overload */;
	Vcl::Stdctrls::TLabel* __fastcall CreateLabel(int APos, System::Uitypes::TColor AColor);
	__property Vcl::Controls::TControl* Child[int Index] = {read=GetChild};
	
__published:
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Vcltee::Teeprocs::TCustomTeePanel* Panel = {read=FPanel, write=SetPanel};
	__property bool Vertical = {read=FVertical, write=SetVertical, default=0};
	__property Align = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=0};
	__property Color = {default=-16777201};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint = {default=1};
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property AutoSize = {default=0};
	__property DragKind = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnConstrainedResize;
	__property OnCanResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnStartDock;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomTeeCommander(HWND ParentWindow) : Vcltee::Teeprocs::TCustomPanelNoCaption(ParentWindow) { }
	
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


enum DECLSPEC_DENUM TCommanderControls : unsigned char { tcbNormal, tcbSeparator, tcbRotate, tcbMove, tcbZoom, tcbDepth, tcbEdit, tcbPrintPreview, tcbCopy, tcbSave, tcbLabel, tcb3D };

typedef void __fastcall (__closure *TTeeEditedChartEvent)(TTeeCommander* Sender, Vcltee::Chart::TCustomChart* AChart);

typedef void __fastcall (__closure *TTeeCommanderOnSetLabel)(TTeeCommander* Sender, System::UnicodeString &Text);

class PASCALIMPLEMENTATION TTeeCommander : public TCustomTeeCommander
{
	typedef TCustomTeeCommander inherited;
	
private:
	bool FAllowFull;
	Vcl::Buttons::TSpeedButton* FButtonCopy;
	Vcl::Buttons::TSpeedButton* FButtonDepth;
	Vcl::Buttons::TSpeedButton* FButtonEdit;
	Vcl::Buttons::TSpeedButton* FButtonMove;
	Vcl::Buttons::TSpeedButton* FButtonNormal;
	Vcl::Buttons::TSpeedButton* FButtonPrint;
	Vcl::Buttons::TSpeedButton* FButtonRotate;
	Vcl::Buttons::TSpeedButton* FButtonSave;
	Vcl::Buttons::TSpeedButton* FButtonZoom;
	Vcl::Buttons::TSpeedButton* FButton3D;
	Vcltee::Teeedit::TChartEditor* FEditor;
	Vcltee::Teeedit::TChartPreviewer* FPreviewer;
	bool FEnablePieExp;
	Vcl::Stdctrls::TLabel* FLabel;
	bool FLabelValues;
	int FDraggingIndex;
	int FInertia;
	int FOldX;
	int FOldY;
	double IDifX;
	double IDifY;
	System::Classes::TShiftState IShift;
	Vcltee::Series::TCircledSeries* ICircledSeries;
	bool IRotating;
	TTeeEditedChartEvent FOnEditedChart;
	TTeeCommanderOnSetLabel FOnSetLabel;
	void __fastcall Button3DClick(System::TObject* Sender);
	void __fastcall ButtonCopyClick(System::TObject* Sender);
	void __fastcall ButtonDepthClick(System::TObject* Sender);
	void __fastcall ButtonEditClick(System::TObject* Sender);
	void __fastcall ButtonMoveClick(System::TObject* Sender);
	void __fastcall ButtonNormalClick(System::TObject* Sender);
	void __fastcall ButtonPrintClick(System::TObject* Sender);
	void __fastcall ButtonRotateClick(System::TObject* Sender);
	void __fastcall ButtonSaveClick(System::TObject* Sender);
	void __fastcall ButtonZoomClick(System::TObject* Sender);
	bool __fastcall DoCustomButton();
	void __fastcall DoRotation(const double IDifX, const double IDifY);
	bool __fastcall IsButtonDown(Vcl::Buttons::TSpeedButton* const AButton);
	TCommanderControls __fastcall GetDefault();
	void __fastcall SetDefault(const TCommanderControls AButton);
	void __fastcall SetLabelCaption(const System::UnicodeString ACaption);
	void __fastcall SetLabelValues(bool Value);
	System::UnicodeString __fastcall CaptionPanel(const System::UnicodeString ACaption);
	Vcltee::Series::TCircledSeries* __fastcall GetCircledSeries(int x, int y);
	void __fastcall SetEditor(Vcltee::Teeedit::TChartEditor* const Value);
	void __fastcall SetPreviewer(Vcltee::Teeedit::TChartPreviewer* const Value);
	
protected:
	bool FAllowRotationX;
	bool FAllowRotationY;
	void __fastcall CheckPendingInertia();
	virtual void __fastcall DoMouseDown(int X, int Y);
	virtual void __fastcall DoMouseMove(int X, int Y, const System::Classes::TShiftState Shift);
	virtual void __fastcall DoMouseUp();
	virtual bool __fastcall DoPanelMouse();
	DYNAMIC void __fastcall RemovingControl(System::Classes::TComponent* const AComponent);
	virtual void __fastcall ShowHideControls(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TTeeCommander(System::Classes::TComponent* AOwner);
	void __fastcall CreateControls(const TCommanderControls *AControls, const int AControls_High);
	void __fastcall RepositionControls();
	__property Vcl::Buttons::TSpeedButton* Button3D = {read=FButton3D};
	__property Vcl::Buttons::TSpeedButton* ButtonCopy = {read=FButtonCopy};
	__property Vcl::Buttons::TSpeedButton* ButtonDepth = {read=FButtonDepth};
	__property Vcl::Buttons::TSpeedButton* ButtonEdit = {read=FButtonEdit};
	__property Vcl::Buttons::TSpeedButton* ButtonMove = {read=FButtonMove};
	__property Vcl::Buttons::TSpeedButton* ButtonNormal = {read=FButtonNormal};
	__property Vcl::Buttons::TSpeedButton* ButtonPrint = {read=FButtonPrint};
	__property Vcl::Buttons::TSpeedButton* ButtonRotate = {read=FButtonRotate};
	__property Vcl::Buttons::TSpeedButton* ButtonSave = {read=FButtonSave};
	__property Vcl::Buttons::TSpeedButton* ButtonZoom = {read=FButtonZoom};
	__property TCommanderControls DefaultButton = {read=GetDefault, write=SetDefault, nodefault};
	__property bool FullRotation = {read=FAllowFull, write=FAllowFull, default=0};
	__property Vcl::Stdctrls::TLabel* LabelText = {read=FLabel};
	void __fastcall ShowValues();
	
__published:
	__property Vcltee::Teeedit::TChartEditor* ChartEditor = {read=FEditor, write=SetEditor};
	__property Vcltee::Teeedit::TChartPreviewer* Previewer = {read=FPreviewer, write=SetPreviewer};
	__property bool EnablePieExploding = {read=FEnablePieExp, write=FEnablePieExp, default=1};
	__property bool LabelValues = {read=FLabelValues, write=SetLabelValues, default=1};
	__property int RotateInertia = {read=FInertia, write=FInertia, default=3};
	__property TTeeEditedChartEvent OnEditedChart = {read=FOnEditedChart, write=FOnEditedChart};
	__property TTeeCommanderOnSetLabel OnSetLabel = {read=FOnSetLabel, write=FOnSetLabel};
	__property OnMouseEnter;
	__property OnMouseLeave;
public:
	/* TCustomTeeCommander.Destroy */ inline __fastcall virtual ~TTeeCommander() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeCommander(HWND ParentWindow) : TCustomTeeCommander(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecomma */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOMMA)
using namespace Vcltee::Teecomma;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecommaHPP
