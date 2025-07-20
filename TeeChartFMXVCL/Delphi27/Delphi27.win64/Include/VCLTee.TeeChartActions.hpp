// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeChartActions.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeechartactionsHPP
#define Vcltee_TeechartactionsHPP

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
#include <Vcl.ActnList.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teechartactions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomChartAction;
class DELPHICLASS TChartAction;
class DELPHICLASS TChartAction3D;
class DELPHICLASS TChartActionEdit;
class DELPHICLASS TChartActionCopy;
class DELPHICLASS TChartActionSave;
class DELPHICLASS TChartActionPrint;
class DELPHICLASS TChartActionAxes;
class DELPHICLASS TChartActionGrid;
class DELPHICLASS TChartActionLegend;
class DELPHICLASS TCustomSeriesAction;
class DELPHICLASS TSeriesAction;
class DELPHICLASS TSeriesActionActive;
class DELPHICLASS TSeriesActionEdit;
class DELPHICLASS TSeriesActionMarks;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomChartAction : public Vcl::Actnlist::TCustomAction
{
	typedef Vcl::Actnlist::TCustomAction inherited;
	
private:
	Vcltee::Chart::TCustomChart* FChart;
	void __fastcall SetChart(Vcltee::Chart::TCustomChart* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	
__published:
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
public:
	/* TCustomAction.Create */ inline __fastcall virtual TCustomChartAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TCustomAction(AOwner) { }
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TCustomChartAction() { }
	
};


class PASCALIMPLEMENTATION TChartAction : public TCustomChartAction
{
	typedef TCustomChartAction inherited;
	
__published:
	__property Caption = {default=0};
	__property Checked = {default=0};
	__property Enabled = {default=1};
	__property HelpContext = {default=0};
	__property Hint = {default=0};
	__property ImageIndex = {default=-1};
	__property ShortCut = {default=0};
	__property Visible = {default=1};
	__property OnExecute;
	__property OnHint;
	__property OnUpdate;
public:
	/* TCustomAction.Create */ inline __fastcall virtual TChartAction(System::Classes::TComponent* AOwner) : TCustomChartAction(AOwner) { }
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartAction() { }
	
};


class PASCALIMPLEMENTATION TChartAction3D : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartAction3D(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartAction3D() { }
	
};


class PASCALIMPLEMENTATION TChartActionEdit : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionEdit() { }
	
};


class PASCALIMPLEMENTATION TChartActionCopy : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionCopy(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionCopy() { }
	
};


class PASCALIMPLEMENTATION TChartActionSave : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionSave(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionSave() { }
	
};


class PASCALIMPLEMENTATION TChartActionPrint : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionPrint(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionPrint() { }
	
};


class PASCALIMPLEMENTATION TChartActionAxes : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionAxes(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionAxes() { }
	
};


class PASCALIMPLEMENTATION TChartActionGrid : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionGrid(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionGrid() { }
	
};


class PASCALIMPLEMENTATION TChartActionLegend : public TChartAction
{
	typedef TChartAction inherited;
	
public:
	__fastcall virtual TChartActionLegend(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TChartActionLegend() { }
	
};


class PASCALIMPLEMENTATION TCustomSeriesAction : public Vcl::Actnlist::TCustomAction
{
	typedef Vcl::Actnlist::TCustomAction inherited;
	
private:
	Vcltee::Teengine::TChartSeries* FSeries;
	void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	
__published:
	__property Vcltee::Teengine::TChartSeries* Series = {read=FSeries, write=SetSeries};
public:
	/* TCustomAction.Create */ inline __fastcall virtual TCustomSeriesAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TCustomAction(AOwner) { }
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TCustomSeriesAction() { }
	
};


class PASCALIMPLEMENTATION TSeriesAction : public TCustomSeriesAction
{
	typedef TCustomSeriesAction inherited;
	
__published:
	__property Caption = {default=0};
	__property Checked = {default=0};
	__property Enabled = {default=1};
	__property HelpContext = {default=0};
	__property Hint = {default=0};
	__property ImageIndex = {default=-1};
	__property ShortCut = {default=0};
	__property Visible = {default=1};
	__property OnExecute;
	__property OnHint;
	__property OnUpdate;
public:
	/* TCustomAction.Create */ inline __fastcall virtual TSeriesAction(System::Classes::TComponent* AOwner) : TCustomSeriesAction(AOwner) { }
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TSeriesAction() { }
	
};


class PASCALIMPLEMENTATION TSeriesActionActive : public TSeriesAction
{
	typedef TSeriesAction inherited;
	
public:
	__fastcall virtual TSeriesActionActive(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TSeriesActionActive() { }
	
};


class PASCALIMPLEMENTATION TSeriesActionEdit : public TSeriesAction
{
	typedef TSeriesAction inherited;
	
public:
	__fastcall virtual TSeriesActionEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TSeriesActionEdit() { }
	
};


class PASCALIMPLEMENTATION TSeriesActionMarks : public TSeriesAction
{
	typedef TSeriesAction inherited;
	
public:
	__fastcall virtual TSeriesActionMarks(System::Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TSeriesActionMarks() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechartactions */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECHARTACTIONS)
using namespace Vcltee::Teechartactions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeechartactionsHPP
