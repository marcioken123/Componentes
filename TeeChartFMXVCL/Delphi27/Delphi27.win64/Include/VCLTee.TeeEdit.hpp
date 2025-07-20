// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeeditHPP
#define Vcltee_TeeeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeEditCha.hpp>
#include <VCLTee.TeeLisB.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePrevi.hpp>
#include <VCLTee.TeePreviewPanel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomChartEditor;
class DELPHICLASS TChartEditor;
class DELPHICLASS TChartPreviewer;
class DELPHICLASS TChartEditorPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomChartEditor : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcltee::Chart::TCustomChart* FChart;
	System::UnicodeString FTitle;
	System::Classes::TNotifyEvent FOnClose;
	System::Classes::TNotifyEvent FOnShow;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetChart(Vcltee::Chart::TCustomChart* const Value);
	
public:
	virtual void __fastcall Execute();
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	
__published:
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomChartEditor(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomChartEditor() { }
	
};


class PASCALIMPLEMENTATION TChartEditor : public TCustomChartEditor
{
	typedef TCustomChartEditor inherited;
	
private:
	bool FAutoRepaint;
	Vcltee::Teeeditcha::TChartEditorTab FDefaultTab;
	Vcltee::Teeeditcha::TChartEditorHiddenTabs FHideTabs;
	bool FHighLight;
	Vcltee::Teelisb::TChangeOrderEvent FOnChangeOrder;
	Vcltee::Teeeditcha::TChartEditorOptions FOptions;
	int FPixels;
	bool FRememberPosition;
	Vcltee::Teengine::TChartSeries* FSeries;
	bool FTree;
	int FGalleryHeight;
	int FGalleryWidth;
	int FHeight;
	int FWidth;
	void __fastcall ChangeSeriesOrder(Vcltee::Teelisb::TChartListBox* Sender, Vcltee::Teengine::TCustomChartSeries* Series1, Vcltee::Teengine::TCustomChartSeries* Series2);
	void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetChart(Vcltee::Chart::TCustomChart* const Value);
	
public:
	__fastcall virtual TChartEditor(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute();
	
__published:
	__property bool AutoRepaint = {read=FAutoRepaint, write=FAutoRepaint, default=1};
	__property Vcltee::Teeeditcha::TChartEditorTab DefaultTab = {read=FDefaultTab, write=FDefaultTab, default=0};
	__property Vcltee::Teeeditcha::TChartEditorHiddenTabs HideTabs = {read=FHideTabs, write=FHideTabs, default=0};
	__property bool HighLightTabs = {read=FHighLight, write=FHighLight, default=0};
	__property Vcltee::Teeeditcha::TChartEditorOptions Options = {read=FOptions, write=FOptions, default=3967};
	__property int PixelsPerInch = {read=FPixels, write=FPixels, default=0};
	__property bool RememberPosition = {read=FRememberPosition, write=FRememberPosition, default=0};
	__property Vcltee::Teengine::TChartSeries* Series = {read=FSeries, write=SetSeries};
	__property Title = {default=0};
	__property bool TreeView = {read=FTree, write=FTree, default=0};
	__property int GalleryHeight = {read=FGalleryHeight, write=FGalleryHeight, nodefault};
	__property int GalleryWidth = {read=FGalleryWidth, write=FGalleryWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property Vcltee::Teelisb::TChangeOrderEvent OnChangeSeriesOrder = {read=FOnChangeOrder, write=FOnChangeOrder};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TChartEditor() { }
	
};


enum DECLSPEC_DENUM TChartPreviewOption : unsigned char { cpoChangePrinter, cpoSetupPrinter, cpoResizeChart, cpoMoveChart, cpoChangeDetail, cpoChangePaperOrientation, cpoChangeMargins, cpoProportional, cpoDragChart, cpoPrintPanel, cpoAsBitmap };

typedef System::Set<TChartPreviewOption, TChartPreviewOption::cpoChangePrinter, TChartPreviewOption::cpoAsBitmap> TChartPreviewOptions;

class PASCALIMPLEMENTATION TChartPreviewer : public TCustomChartEditor
{
	typedef TCustomChartEditor inherited;
	
private:
	System::Classes::TNotifyEvent FOnAfterDraw;
	TChartPreviewOptions FOptions;
	System::Uitypes::TColor FPaperColor;
	System::Uitypes::TWindowState FWindowState;
	Vcltee::Teeprevi::TChartPreview* TheForm;
	Vcltee::Teepreviewpanel::TTeePreviewPanel* __fastcall GetPreview();
	
public:
	__fastcall virtual TChartPreviewer(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute();
	__property Vcltee::Teepreviewpanel::TTeePreviewPanel* PreviewPanel = {read=GetPreview};
	
__published:
	__property TChartPreviewOptions Options = {read=FOptions, write=FOptions, default=255};
	__property System::Uitypes::TColor PaperColor = {read=FPaperColor, write=FPaperColor, default=16777215};
	__property Title = {default=0};
	__property System::Uitypes::TWindowState WindowState = {read=FWindowState, write=FWindowState, default=0};
	__property System::Classes::TNotifyEvent OnAfterDraw = {read=FOnAfterDraw, write=FOnAfterDraw};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TChartPreviewer() { }
	
};


class PASCALIMPLEMENTATION TChartEditorPanel : public Vcltee::Teeprocs::TCustomPanelNoCaption
{
	typedef Vcltee::Teeprocs::TCustomPanelNoCaption inherited;
	
private:
	Vcltee::Chart::TCustomChart* FChart;
	Vcltee::Teeeditcha::TChartEditForm* FEditor;
	Vcltee::Teengine::TChartSeries* FSeries;
	TChartEditor* FChartEditor;
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetChart(Vcltee::Chart::TCustomChart* const Value);
	void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	void __fastcall SetChartEditor(TChartEditor* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TChartEditorPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartEditorPanel();
	void __fastcall SelectUnderMouse();
	__property Vcltee::Teeeditcha::TChartEditForm* Editor = {read=FEditor};
	
__published:
	__property Align = {default=0};
	__property BevelOuter = {default=1};
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
	__property TChartEditor* ChartEditor = {read=FChartEditor, write=SetChartEditor};
	__property Vcltee::Teengine::TChartSeries* Series = {read=FSeries, write=SetSeries};
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property Locked = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDrag;
	__property OnConstrainedResize;
	__property OnCanResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartEditorPanel(HWND ParentWindow) : Vcltee::Teeprocs::TCustomPanelNoCaption(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define DefaultChartPreviewOptions (System::Set<TChartPreviewOption, TChartPreviewOption::cpoChangePrinter, TChartPreviewOption::cpoAsBitmap>() << TChartPreviewOption::cpoChangePrinter << TChartPreviewOption::cpoSetupPrinter << TChartPreviewOption::cpoResizeChart << TChartPreviewOption::cpoMoveChart << TChartPreviewOption::cpoChangeDetail << TChartPreviewOption::cpoChangePaperOrientation << TChartPreviewOption::cpoChangeMargins << TChartPreviewOption::cpoProportional )
}	/* namespace Teeedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEDIT)
using namespace Vcltee::Teeedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeeditHPP
