// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDControlPrintTasks.pas' rev: 31.00 (Windows)

#ifndef LmdcontrolprinttasksHPP
#define LmdcontrolprinttasksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDDocElementRenderer.hpp>
#include <LMDPageLayout.hpp>
#include <LMDSimpleDocLayout.hpp>
#include <LMDLayoutRenderPrintTask.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcontrolprinttasks
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomControlPrintTask;
class DELPHICLASS TLMDControlCellFormat;
class DELPHICLASS TLMDCustomEditPrintTask;
class DELPHICLASS TLMDEditPrintTask;
class DELPHICLASS TLMDTabularControlPrintTask;
class DELPHICLASS TLMDStringGridPrintTask;
class DELPHICLASS TLMDListViewPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomControlPrintTask : public Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask
{
	typedef Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask inherited;
	
protected:
	virtual void __fastcall CreateLayoutManager(void);
	virtual void __fastcall ConstructDocument(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomPrintTask.Create */ inline __fastcall virtual TLMDCustomControlPrintTask(System::Classes::TComponent* AOwner) : Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask(AOwner) { }
	/* TLMDCustomPrintTask.Destroy */ inline __fastcall virtual ~TLMDCustomControlPrintTask(void) { }
	
};


class PASCALIMPLEMENTATION TLMDControlCellFormat : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TPen* FTopBorderPen;
	Vcl::Graphics::TPen* FBottomBorderPen;
	Vcl::Graphics::TPen* FRightBorderPen;
	Vcl::Graphics::TPen* FLeftBorderPen;
	Lmddocmodel::TLMDTextAreaSettings* FTextFormat;
	bool FIsRTF;
	double FMarginBottom;
	double FMarginTop;
	double FMarginLeft;
	double FMarginRight;
	TLMDTabularControlPrintTask* FParent;
	void __fastcall CheckMargin(double Value);
	void __fastcall SetBottomBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetLeftBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetRightBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetTopBorderPen(Vcl::Graphics::TPen* const Value);
	void __fastcall SetTextFormat(Lmddocmodel::TLMDTextAreaSettings* const Value);
	void __fastcall SetIsRTF(const bool Value);
	void __fastcall SetMarginBottom(const double Value);
	void __fastcall SetMarginLeft(const double Value);
	void __fastcall SetMarginRight(const double Value);
	void __fastcall SetMarginTop(const double Value);
	bool __fastcall IsMarginBottomStored(void);
	bool __fastcall IsMarginLeftStored(void);
	bool __fastcall IsMarginRightStored(void);
	bool __fastcall IsMarginTopStored(void);
	void __fastcall ReadMarginsZero(System::Classes::TReader* Reader);
	void __fastcall WriteMarginsZero(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall TLMDControlCellFormat(TLMDTabularControlPrintTask* AParent);
	__fastcall virtual ~TLMDControlCellFormat(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TPen* LeftBorderPen = {read=FLeftBorderPen, write=SetLeftBorderPen};
	__property Vcl::Graphics::TPen* RightBorderPen = {read=FRightBorderPen, write=SetRightBorderPen};
	__property Vcl::Graphics::TPen* TopBorderPen = {read=FTopBorderPen, write=SetTopBorderPen};
	__property Vcl::Graphics::TPen* BottomBorderPen = {read=FBottomBorderPen, write=SetBottomBorderPen};
	__property Lmddocmodel::TLMDTextAreaSettings* TextFormat = {read=FTextFormat, write=SetTextFormat};
	__property bool IsRTF = {read=FIsRTF, write=SetIsRTF, default=0};
	__property double MarginLeft = {read=FMarginLeft, write=SetMarginLeft, stored=IsMarginLeftStored};
	__property double MarginRight = {read=FMarginRight, write=SetMarginRight, stored=IsMarginRightStored};
	__property double MarginTop = {read=FMarginTop, write=SetMarginTop, stored=IsMarginTopStored};
	__property double MarginBottom = {read=FMarginBottom, write=SetMarginBottom, stored=IsMarginBottomStored};
};


class PASCALIMPLEMENTATION TLMDCustomEditPrintTask : public TLMDCustomControlPrintTask
{
	typedef TLMDCustomControlPrintTask inherited;
	
private:
	Lmddocmodel::TLMDTextAreaSettings* FTextFormatOptions;
	Vcl::Stdctrls::TCustomEdit* FEditControl;
	void __fastcall SetTextFormatOptions(Lmddocmodel::TLMDTextAreaSettings* const Value);
	void __fastcall SetEditControl(Vcl::Stdctrls::TCustomEdit* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateLayoutManager(void);
	virtual void __fastcall ConstructDocument(void);
	virtual void __fastcall GetControlText(System::Classes::TStrings* ATargetStrings);
	__property Vcl::Stdctrls::TCustomEdit* EditControl = {read=FEditControl, write=SetEditControl};
	
public:
	__fastcall virtual TLMDCustomEditPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomEditPrintTask(void);
	
__published:
	__property Lmddocmodel::TLMDTextAreaSettings* TextFormatOptions = {read=FTextFormatOptions, write=SetTextFormatOptions};
};


class PASCALIMPLEMENTATION TLMDEditPrintTask : public TLMDCustomEditPrintTask
{
	typedef TLMDCustomEditPrintTask inherited;
	
__published:
	__property EditControl;
public:
	/* TLMDCustomEditPrintTask.Create */ inline __fastcall virtual TLMDEditPrintTask(System::Classes::TComponent* AOwner) : TLMDCustomEditPrintTask(AOwner) { }
	/* TLMDCustomEditPrintTask.Destroy */ inline __fastcall virtual ~TLMDEditPrintTask(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTabularControlPrintTask : public TLMDCustomControlPrintTask
{
	typedef TLMDCustomControlPrintTask inherited;
	
private:
	TLMDControlCellFormat* FFixedCellFormat;
	TLMDControlCellFormat* FCellFormat;
	void __fastcall SetCellFormat(TLMDControlCellFormat* const Value);
	void __fastcall SetFixedCellFormat(TLMDControlCellFormat* const Value);
	double __fastcall GetDefaultMargin(void);
	
protected:
	virtual void __fastcall CreateLayoutManager(void);
	void __fastcall AssignCellFormats(Lmddocmodel::TLMDTableCellFormat* ADest, TLMDControlCellFormat* ASrc);
	virtual void __fastcall OnUnitsChanged(Lmdtypes::TLMDMeasureUnits AOldUnits, Lmdtypes::TLMDMeasureUnits ANewUnits);
	
public:
	__fastcall virtual TLMDTabularControlPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTabularControlPrintTask(void);
	
__published:
	__property TLMDControlCellFormat* CellFormat = {read=FCellFormat, write=SetCellFormat};
	__property TLMDControlCellFormat* FixedCellFormat = {read=FFixedCellFormat, write=SetFixedCellFormat};
	__property Units = {default=2};
	__property RealUnits;
};


class PASCALIMPLEMENTATION TLMDStringGridPrintTask : public TLMDTabularControlPrintTask
{
	typedef TLMDTabularControlPrintTask inherited;
	
private:
	Vcl::Grids::TStringGrid* FGrid;
	void __fastcall SetGrid(Vcl::Grids::TStringGrid* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ConstructDocument(void);
	
public:
	__fastcall virtual ~TLMDStringGridPrintTask(void);
	
__published:
	__property Vcl::Grids::TStringGrid* Grid = {read=FGrid, write=SetGrid};
public:
	/* TLMDTabularControlPrintTask.Create */ inline __fastcall virtual TLMDStringGridPrintTask(System::Classes::TComponent* AOwner) : TLMDTabularControlPrintTask(AOwner) { }
	
};


class PASCALIMPLEMENTATION TLMDListViewPrintTask : public TLMDTabularControlPrintTask
{
	typedef TLMDTabularControlPrintTask inherited;
	
private:
	Vcl::Comctrls::TListView* FListView;
	void __fastcall SetListView(Vcl::Comctrls::TListView* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ConstructDocument(void);
	
public:
	__fastcall virtual ~TLMDListViewPrintTask(void);
	
__published:
	__property Vcl::Comctrls::TListView* ListView = {read=FListView, write=SetListView};
public:
	/* TLMDTabularControlPrintTask.Create */ inline __fastcall virtual TLMDListViewPrintTask(System::Classes::TComponent* AOwner) : TLMDTabularControlPrintTask(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcontrolprinttasks */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONTROLPRINTTASKS)
using namespace Lmdcontrolprinttasks;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcontrolprinttasksHPP
