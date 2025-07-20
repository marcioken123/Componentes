// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Commander.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_CommanderHPP
#define Fmxtee_CommanderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.StdCtrls.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Editor.EditorPanel.hpp>
#include <FMX.Dialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Commander
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomTeeCommander;
class DELPHICLASS TTeeCommander;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomTeeCommander : public Fmxtee::Procs::TCustomPanelNoCaption
{
	typedef Fmxtee::Procs::TCustomPanelNoCaption inherited;
	
private:
	Fmxtee::Canvas::TTeeGradient* FGradient;
	System::Uitypes::TMouseButton FMouseButton;
	Fmxtee::Procs::TCustomTeePanel* FPanel;
	bool FVertical;
	void __fastcall CanvasChanged(System::TObject* Sender);
	void __fastcall CheckVerticalAlign();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall ReAlignTeeControls();
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetVertical(bool Value);
	
protected:
	bool FDragging;
	int __fastcall ChildCount();
	Fmx::Types::TFmxObject* __fastcall GetChild(int Index);
	virtual void __fastcall DoMouseDown(int X, int Y);
	virtual void __fastcall DoMouseMove(int X, int Y, const System::Classes::TShiftState Shift);
	virtual void __fastcall DoMouseUp();
	virtual bool __fastcall DoPanelMouse();
	void __fastcall FreeOwnedControls();
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint();
	DYNAMIC void __fastcall RemovingControl(System::Classes::TComponent* const AComponent);
	virtual void __fastcall SetPanel(Fmxtee::Procs::TCustomTeePanel* const Value);
	virtual void __fastcall ShowHideControls(bool Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	System::UnicodeString __fastcall TeePanelClass();
	
public:
	__fastcall virtual TCustomTeeCommander(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTeeCommander();
	void __fastcall CreateBevel(int APos);
	Fmx::Stdctrls::TSpeedButton* __fastcall CreateButton(int APos, System::Classes::TNotifyEvent AProc, const System::UnicodeString AHint, const System::UnicodeString AResName, int AGroupIndex)/* overload */;
	Fmx::Stdctrls::TSpeedButton* __fastcall CreateButton(int APos, System::Classes::TNotifyEvent AProc, const System::UnicodeString AHint, Fmx::Graphics::TBitmap* const ABitmap, int AGroupIndex)/* overload */;
	Fmx::Stdctrls::TLabel* __fastcall CreateLabel(int APos, System::Uitypes::TAlphaColor AColor);
	__property Fmx::Types::TFmxObject* Child[int Index] = {read=GetChild};
	
__published:
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Fmxtee::Procs::TCustomTeePanel* Panel = {read=FPanel, write=SetPanel};
	__property bool Vertical = {read=FVertical, write=SetVertical, default=0};
	__property Align = {default=0};
	__property ClipChildren = {default=1};
	__property Color = {default=-986896};
	__property DragMode = {default=0};
	__property Enabled;
	__property ParentShowHint = {default=1};
	__property ShowHint = {default=1};
	__property PopupMenu;
	__property Size;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Action;
	__property Anchors;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


enum DECLSPEC_DENUM TCommanderControls : unsigned char { tcbNormal, tcbSeparator, tcbRotate, tcbMove, tcbZoom, tcbDepth, tcbEdit, tcbPrintPreview, tcbCopy, tcbSave, tcbLabel, tcb3D };

typedef void __fastcall (__closure *TTeeEditedChartEvent)(TTeeCommander* Sender, Fmxtee::Chart::TCustomChart* AChart);

typedef void __fastcall (__closure *TTeeCommanderOnSetLabel)(TTeeCommander* Sender, System::UnicodeString &Text);

class PASCALIMPLEMENTATION TTeeCommander : public TCustomTeeCommander
{
	typedef TCustomTeeCommander inherited;
	
private:
	bool FAllowFull;
	Fmx::Stdctrls::TSpeedButton* FButtonCopy;
	Fmx::Stdctrls::TSpeedButton* FButtonDepth;
	Fmx::Stdctrls::TSpeedButton* FButtonEdit;
	Fmx::Stdctrls::TSpeedButton* FButtonMove;
	Fmx::Stdctrls::TSpeedButton* FButtonNormal;
	Fmx::Stdctrls::TSpeedButton* FButtonPrint;
	Fmx::Stdctrls::TSpeedButton* FButtonRotate;
	Fmx::Stdctrls::TSpeedButton* FButtonSave;
	Fmx::Stdctrls::TSpeedButton* FButtonZoom;
	Fmx::Stdctrls::TSpeedButton* FButton3D;
	Fmxtee::Editor::Editorpanel::TChartEditor* FEditor;
	Fmxtee::Editor::Editorpanel::TChartPreviewer* FPreviewer;
	bool FEnablePieExp;
	Fmx::Stdctrls::TLabel* FLabel;
	bool FLabelValues;
	int FDraggingIndex;
	int FInertia;
	int FOldX;
	int FOldY;
	double IDifX;
	double IDifY;
	System::Classes::TShiftState IShift;
	Fmxtee::Series::TCircledSeries* ICircledSeries;
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
	void __fastcall InvalidatePanel();
	bool __fastcall IsButtonDown(Fmx::Stdctrls::TSpeedButton* const AButton);
	TCommanderControls __fastcall GetDefault();
	void __fastcall SetDefault(const TCommanderControls AButton);
	void __fastcall SetLabelCaption(const System::UnicodeString ACaption);
	void __fastcall SetLabelValues(bool Value);
	System::UnicodeString __fastcall CaptionPanel(const System::UnicodeString ACaption);
	Fmxtee::Series::TCircledSeries* __fastcall GetCircledSeries(int x, int y);
	void __fastcall SetEditor(Fmxtee::Editor::Editorpanel::TChartEditor* const Value);
	void __fastcall SetPreviewer(Fmxtee::Editor::Editorpanel::TChartPreviewer* const Value);
	
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
	__property Fmx::Stdctrls::TSpeedButton* Button3D = {read=FButton3D};
	__property Fmx::Stdctrls::TSpeedButton* ButtonCopy = {read=FButtonCopy};
	__property Fmx::Stdctrls::TSpeedButton* ButtonDepth = {read=FButtonDepth};
	__property Fmx::Stdctrls::TSpeedButton* ButtonEdit = {read=FButtonEdit};
	__property Fmx::Stdctrls::TSpeedButton* ButtonMove = {read=FButtonMove};
	__property Fmx::Stdctrls::TSpeedButton* ButtonNormal = {read=FButtonNormal};
	__property Fmx::Stdctrls::TSpeedButton* ButtonPrint = {read=FButtonPrint};
	__property Fmx::Stdctrls::TSpeedButton* ButtonRotate = {read=FButtonRotate};
	__property Fmx::Stdctrls::TSpeedButton* ButtonSave = {read=FButtonSave};
	__property Fmx::Stdctrls::TSpeedButton* ButtonZoom = {read=FButtonZoom};
	__property TCommanderControls DefaultButton = {read=GetDefault, write=SetDefault, nodefault};
	__property bool FullRotation = {read=FAllowFull, write=FAllowFull, default=0};
	__property Fmx::Stdctrls::TLabel* LabelText = {read=FLabel};
	void __fastcall ShowValues();
	
__published:
	__property Fmxtee::Editor::Editorpanel::TChartEditor* ChartEditor = {read=FEditor, write=SetEditor};
	__property Fmxtee::Editor::Editorpanel::TChartPreviewer* Previewer = {read=FPreviewer, write=SetPreviewer};
	__property bool EnablePieExploding = {read=FEnablePieExp, write=FEnablePieExp, default=1};
	__property bool LabelValues = {read=FLabelValues, write=SetLabelValues, default=1};
	__property int RotateInertia = {read=FInertia, write=FInertia, default=3};
	__property TTeeEditedChartEvent OnEditedChart = {read=FOnEditedChart, write=FOnEditedChart};
	__property TTeeCommanderOnSetLabel OnSetLabel = {read=FOnSetLabel, write=FOnSetLabel};
	__property OnMouseEnter;
	__property OnMouseLeave;
public:
	/* TCustomTeeCommander.Destroy */ inline __fastcall virtual ~TTeeCommander() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Commander */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_COMMANDER)
using namespace Fmxtee::Commander;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_CommanderHPP
