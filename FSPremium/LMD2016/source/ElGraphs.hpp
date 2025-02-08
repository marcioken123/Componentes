// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElGraphs.pas' rev: 31.00 (Windows)

#ifndef ElgraphsHPP
#define ElgraphsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Printers.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <ElVCLUtils.hpp>
#include <LMDObjectList.hpp>
#include <ElImgFrm.hpp>
#include <ElCGControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elgraphs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDataEntry;
class DELPHICLASS TElGraph;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDataEntry : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int operator[](int index) { return this->Value[index]; }
	
private:
	Lmdobjectlist::TLMDObjectList* FValues;
	System::Uitypes::TColor FColor;
	System::UnicodeString FName;
	int FMinGrid;
	int FMaxGrid;
	TElGraph* FOwner;
	bool FVisible;
	bool FAutoGrid;
	int FFaults;
	int __fastcall GetLimit(void);
	void __fastcall SetLimit(int newValue);
	void __fastcall SetColor(System::Uitypes::TColor value);
	void __fastcall SetName(System::UnicodeString value);
	void __fastcall SetMinGrid(int newValue);
	void __fastcall SetMaxGrid(int newValue);
	void __fastcall SetVisible(bool value);
	int __fastcall GetValueCount(void);
	
public:
	void __fastcall CalcMinMax(int &Min, int &Max, int &Avg);
	__fastcall TDataEntry(void);
	__fastcall virtual ~TDataEntry(void);
	void __fastcall AddValue(int value);
	int __fastcall GetValue(int index);
	void __fastcall Reset(void);
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property TElGraph* Owner = {read=FOwner};
	__property Lmdobjectlist::TLMDObjectList* Values = {read=FValues};
	__property int Value[int index] = {read=GetValue/*, default*/};
	__property int ValueCount = {read=GetValueCount, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property int MinGrid = {read=FMinGrid, write=SetMinGrid, default=0};
	__property int MaxGrid = {read=FMaxGrid, write=SetMaxGrid, default=100};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Limit = {read=GetLimit, write=SetLimit, default=1000};
	__property bool AutoGrid = {read=FAutoGrid, write=FAutoGrid, nodefault};
	__property int Faults = {read=FFaults, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElGraph : public Elcgcontrol::TElCustomGraphicControl
{
	typedef Elcgcontrol::TElCustomGraphicControl inherited;
	
private:
	bool FShowTimeouts;
	System::UnicodeString FStatus;
	TDataEntry* FColumnEntry;
	int FHGridLines;
	int FVGridLines;
	System::Classes::TNotifyEvent FOnResize;
	System::Uitypes::TColor FLegendBkColor;
	int FLegendWidth;
	bool FLegendAtRight;
	System::Classes::TList* FEntryList;
	bool FShowLegend;
	bool FShowMinMax;
	bool FShowGrid;
	TDataEntry* FMinMaxEntry;
	Elimgfrm::TElImageForm* FImgForm;
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	TDataEntry* __fastcall GetDataList(int index);
	void __fastcall SetShowLegend(bool newValue);
	void __fastcall SetShowMinMax(bool newValue);
	int __fastcall GetEntriesCount(void);
	void __fastcall SetShowGrid(bool newValue);
	void __fastcall SetLegendAtRight(bool newValue);
	void __fastcall SetLegendWidth(int newValue);
	void __fastcall SetLegendBkColor(System::Uitypes::TColor newValue);
	void __fastcall SetMinMaxEntry(TDataEntry* newValue);
	void __fastcall SetHGridLines(int newValue);
	void __fastcall SetVGridLines(int newValue);
	TDataEntry* __fastcall GetColumnEntry(void);
	void __fastcall SetColumnEntry(TDataEntry* newValue);
	MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	void __fastcall SetShowTimeouts(bool newValue);
	bool __fastcall GetTransparent(void);
	void __fastcall SetTransparent(bool newValue);
	
protected:
	virtual TDataEntry* __fastcall CreateEntry(void);
	virtual void __fastcall DoDrawGraph(Vcl::Graphics::TCanvas* Surface);
	virtual void __fastcall Paint(void);
	virtual System::Types::TRect __fastcall GetLegendRect(void);
	virtual System::Types::TRect __fastcall GetMinMaxRect(void);
	virtual System::Types::TRect __fastcall GetMainRect(void);
	virtual void __fastcall TriggerResizeEvent(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual TElGraph(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElGraph(void);
	void __fastcall Print(void);
	TDataEntry* __fastcall AddEntry(void);
	TDataEntry* __fastcall InsertEntry(int index);
	void __fastcall DeleteEntry(int index);
	HIDESBASE void __fastcall Refresh(void);
	__property TDataEntry* DataList[int index] = {read=GetDataList};
	__property int EntriesCount = {read=GetEntriesCount, nodefault};
	__property TDataEntry* MinMaxEntry = {read=FMinMaxEntry, write=SetMinMaxEntry};
	__property TDataEntry* ColumnEntry = {read=GetColumnEntry, write=SetColumnEntry};
	
__published:
	__property bool ShowLegend = {read=FShowLegend, write=SetShowLegend, default=0};
	__property bool ShowMinMax = {read=FShowMinMax, write=SetShowMinMax, default=0};
	__property bool ShowGrid = {read=FShowGrid, write=SetShowGrid, default=0};
	__property Align = {default=0};
	__property Color;
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property bool LegendAtRight = {read=FLegendAtRight, write=SetLegendAtRight, default=1};
	__property int LegendWidth = {read=FLegendWidth, write=SetLegendWidth, default=100};
	__property System::Uitypes::TColor LegendBkColor = {read=FLegendBkColor, write=SetLegendBkColor, default=0};
	__property System::Classes::TNotifyEvent OnResize = {read=FOnResize, write=FOnResize};
	__property int HGridLines = {read=FHGridLines, write=SetHGridLines, default=5};
	__property int VGridLines = {read=FVGridLines, write=SetVGridLines, default=0};
	__property System::UnicodeString Status = {read=FStatus, write=FStatus};
	__property bool ShowTimeouts = {read=FShowTimeouts, write=SetShowTimeouts, default=1};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, nodefault};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DragKind = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elgraphs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELGRAPHS)
using namespace Elgraphs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElgraphsHPP
