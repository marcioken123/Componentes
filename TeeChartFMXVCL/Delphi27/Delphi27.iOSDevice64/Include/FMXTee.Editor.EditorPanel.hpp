// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.EditorPanel.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_EditorpanelHPP
#define Fmxtee_Editor_EditorpanelHPP

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
#include <System.UIConsts.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Editor.Chart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Print.Preview.hpp>
#include <FMXTee.Print.PreviewPanel.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.Controls.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Editorpanel
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
	Fmxtee::Chart::TCustomChart* FChart;
	System::UnicodeString FTitle;
	System::Classes::TNotifyEvent FOnClose;
	System::Classes::TNotifyEvent FOnShow;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetChart(Fmxtee::Chart::TCustomChart* const Value);
	
public:
	virtual void __fastcall Execute();
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	
__published:
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
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
	bool FHighLight;
	int FPixels;
	bool FRememberPosition;
	Fmxtee::Engine::TChartSeries* FSeries;
	bool FTree;
	int FGalleryHeight;
	int FGalleryWidth;
	int FHeight;
	int FWidth;
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetChart(Fmxtee::Chart::TCustomChart* const Value);
	
public:
	__fastcall virtual TChartEditor(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute();
	
__published:
	__property bool AutoRepaint = {read=FAutoRepaint, write=FAutoRepaint, default=1};
	__property bool HighLightTabs = {read=FHighLight, write=FHighLight, default=0};
	__property int PixelsPerInch = {read=FPixels, write=FPixels, default=0};
	__property bool RememberPosition = {read=FRememberPosition, write=FRememberPosition, default=0};
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=SetSeries};
	__property Title = {default=0};
	__property bool TreeView = {read=FTree, write=FTree, default=0};
	__property int GalleryHeight = {read=FGalleryHeight, write=FGalleryHeight, nodefault};
	__property int GalleryWidth = {read=FGalleryWidth, write=FGalleryWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
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
	System::Uitypes::TAlphaColor FPaperColor;
	System::Uitypes::TWindowState FWindowState;
	Fmxtee::Print::Preview::TChartPreview* TheForm;
	Fmxtee::Print::Previewpanel::TTeePreviewPanel* __fastcall GetPreview();
	
public:
	__fastcall virtual TChartPreviewer(System::Classes::TComponent* AOwner);
	virtual void __fastcall Execute();
	__property Fmxtee::Print::Previewpanel::TTeePreviewPanel* PreviewPanel = {read=GetPreview};
	
__published:
	__property TChartPreviewOptions Options = {read=FOptions, write=FOptions, default=255};
	__property System::Uitypes::TAlphaColor PaperColor = {read=FPaperColor, write=FPaperColor, default=-1};
	__property Title = {default=0};
	__property System::Uitypes::TWindowState WindowState = {read=FWindowState, write=FWindowState, default=0};
	__property System::Classes::TNotifyEvent OnAfterDraw = {read=FOnAfterDraw, write=FOnAfterDraw};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TChartPreviewer() { }
	
};


class PASCALIMPLEMENTATION TChartEditorPanel : public Fmxtee::Procs::TCustomPanelNoCaption
{
	typedef Fmxtee::Procs::TCustomPanelNoCaption inherited;
	
private:
	Fmxtee::Chart::TCustomChart* FChart;
	Fmxtee::Editor::Chart::TChartEditForm* FEditor;
	Fmxtee::Engine::TChartSeries* FSeries;
	TChartEditor* FChartEditor;
	void __fastcall SetChart(Fmxtee::Chart::TCustomChart* const Value);
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	void __fastcall SetChartEditor(TChartEditor* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TChartEditorPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartEditorPanel();
	__property Fmxtee::Editor::Chart::TChartEditForm* Editor = {read=FEditor};
	
__published:
	__property Align = {default=0};
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
	__property TChartEditor* ChartEditor = {read=FChartEditor, write=SetChartEditor};
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=SetSeries};
	__property DragMode = {default=0};
	__property Enabled;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Action;
	__property Anchors;
	__property Locked = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnMouseWheel;
};


//-- var, const, procedure ---------------------------------------------------
#define DefaultChartPreviewOptions (System::Set<TChartPreviewOption, TChartPreviewOption::cpoChangePrinter, TChartPreviewOption::cpoAsBitmap>() << TChartPreviewOption::cpoChangePrinter << TChartPreviewOption::cpoSetupPrinter << TChartPreviewOption::cpoResizeChart << TChartPreviewOption::cpoMoveChart << TChartPreviewOption::cpoChangeDetail << TChartPreviewOption::cpoChangePaperOrientation << TChartPreviewOption::cpoChangeMargins << TChartPreviewOption::cpoProportional )
}	/* namespace Editorpanel */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_EDITORPANEL)
using namespace Fmxtee::Editor::Editorpanel;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR)
using namespace Fmxtee::Editor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Editor_EditorpanelHPP
