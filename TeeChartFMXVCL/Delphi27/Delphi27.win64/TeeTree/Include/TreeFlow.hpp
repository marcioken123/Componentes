// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeFlow.pas' rev: 34.00 (Windows)

#ifndef TreeflowHPP
#define TreeflowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeflow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFlowChartShape;
class DELPHICLASS TDecisionShape;
class DELPHICLASS TConditionShape;
class DELPHICLASS TProcessShape;
class DELPHICLASS TPredefinedProcessShape;
class DELPHICLASS TTerminalShape;
class DELPHICLASS TConnectorShape;
class DELPHICLASS TInputOutputShape;
class DELPHICLASS TTitleShape;
class DELPHICLASS TManualOperationShape;
class DELPHICLASS TSelectShape;
class DELPHICLASS TDocumentShape;
class DELPHICLASS TPunchCardShape;
class DELPHICLASS TCardShape;
class DELPHICLASS TPunchTapeShape;
class DELPHICLASS TDelayShape;
class DELPHICLASS TManualInputShape;
class DELPHICLASS TManualShape;
class DELPHICLASS TFlowChartCircleShape;
class DELPHICLASS TAndShape;
class DELPHICLASS TOrShape;
class DELPHICLASS TOnlineStorageShape;
class DELPHICLASS TDataShape;
class DELPHICLASS TMagneticTapeShape;
class DELPHICLASS TTapeShape;
class DELPHICLASS TPentagonShape;
class DELPHICLASS THexagonShape;
class DELPHICLASS TOctagonShape;
class DELPHICLASS TCrossShape;
class DELPHICLASS TTriangleRectShape;
class DELPHICLASS TTriangleRectRightShape;
class DELPHICLASS TTriangleRectLeftShape;
class DELPHICLASS THouseShape;
class DELPHICLASS TEnvelopeShape;
class DELPHICLASS TRingShape;
class DELPHICLASS TTreeCustomArrowShape;
class DELPHICLASS TArrowUpShape;
class DELPHICLASS TArrowDownShape;
class DELPHICLASS TArrowLeftShape;
class DELPHICLASS TArrowRightShape;
class DELPHICLASS TCallOutShape;
class DELPHICLASS TStarShape;
class DELPHICLASS TGridCellShape;
class DELPHICLASS TGridShape;
class DELPHICLASS TBeveledShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFlowChartShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TFlowChartShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TFlowChartShape() { }
	
};


class PASCALIMPLEMENTATION TDecisionShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
public:
	__fastcall virtual TDecisionShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Style = {default=6};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDecisionShape() { }
	
};


class PASCALIMPLEMENTATION TConditionShape : public TDecisionShape
{
	typedef TDecisionShape inherited;
	
public:
	/* TDecisionShape.Create */ inline __fastcall virtual TConditionShape(System::Classes::TComponent* AOwner) : TDecisionShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TConditionShape() { }
	
};


class PASCALIMPLEMENTATION TProcessShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
public:
	__fastcall virtual TProcessShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Style = {default=0};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TProcessShape() { }
	
};


class PASCALIMPLEMENTATION TPredefinedProcessShape : public TProcessShape
{
	typedef TProcessShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TProcessShape.Create */ inline __fastcall virtual TPredefinedProcessShape(System::Classes::TComponent* AOwner) : TProcessShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TPredefinedProcessShape() { }
	
};


class PASCALIMPLEMENTATION TTerminalShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TTerminalShape(System::Classes::TComponent* AOwner) : TFlowChartShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTerminalShape() { }
	
};


class PASCALIMPLEMENTATION TConnectorShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
public:
	__fastcall virtual TConnectorShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Style = {default=1};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TConnectorShape() { }
	
};


class PASCALIMPLEMENTATION TInputOutputShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
private:
	double FSlant;
	bool __fastcall ClickedSlantPoint(int x, int y);
	void __fastcall SetSlant(const double Value);
	int __fastcall SlantSize(const System::Types::TRect &R);
	
protected:
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TInputOutputShape(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DrawHandles();
	DYNAMIC Teetree::TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	DYNAMIC void __fastcall Resize(Teetree::TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
	
__published:
	__property double Slant = {read=FSlant, write=SetSlant};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TInputOutputShape() { }
	
};


class PASCALIMPLEMENTATION TTitleShape : public TInputOutputShape
{
	typedef TInputOutputShape inherited;
	
public:
	/* TInputOutputShape.Create */ inline __fastcall virtual TTitleShape(System::Classes::TComponent* AOwner) : TInputOutputShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTitleShape() { }
	
};


class PASCALIMPLEMENTATION TManualOperationShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TManualOperationShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TManualOperationShape() { }
	
};


class PASCALIMPLEMENTATION TSelectShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TSelectShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TSelectShape() { }
	
};


class PASCALIMPLEMENTATION TDocumentShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TDocumentShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDocumentShape() { }
	
};


class PASCALIMPLEMENTATION TPunchCardShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
private:
	int FPercentHoriz;
	int FPercentVert;
	void __fastcall SetPercentHoriz(const int Value);
	void __fastcall SetPercentVert(const int Value);
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TPunchCardShape(System::Classes::TComponent* AOwner);
	
__published:
	__property int PercentHoriz = {read=FPercentHoriz, write=SetPercentHoriz, default=25};
	__property int PercentVert = {read=FPercentVert, write=SetPercentVert, default=25};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TPunchCardShape() { }
	
};


class PASCALIMPLEMENTATION TCardShape : public TPunchCardShape
{
	typedef TPunchCardShape inherited;
	
public:
	/* TPunchCardShape.Create */ inline __fastcall virtual TCardShape(System::Classes::TComponent* AOwner) : TPunchCardShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TCardShape() { }
	
};


class PASCALIMPLEMENTATION TPunchTapeShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TPunchTapeShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TPunchTapeShape() { }
	
};


class PASCALIMPLEMENTATION TDelayShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TDelayShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDelayShape() { }
	
};


class PASCALIMPLEMENTATION TManualInputShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TManualInputShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TManualInputShape() { }
	
};


class PASCALIMPLEMENTATION TManualShape : public TManualInputShape
{
	typedef TManualInputShape inherited;
	
public:
	/* TManualInputShape.Create */ inline __fastcall virtual TManualShape(System::Classes::TComponent* AOwner) : TManualInputShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TManualShape() { }
	
};


class PASCALIMPLEMENTATION TFlowChartCircleShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
public:
	__fastcall virtual TFlowChartCircleShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Style = {default=1};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TFlowChartCircleShape() { }
	
};


class PASCALIMPLEMENTATION TAndShape : public TFlowChartCircleShape
{
	typedef TFlowChartCircleShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TFlowChartCircleShape.Create */ inline __fastcall virtual TAndShape(System::Classes::TComponent* AOwner) : TFlowChartCircleShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TAndShape() { }
	
};


class PASCALIMPLEMENTATION TOrShape : public TFlowChartCircleShape
{
	typedef TFlowChartCircleShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TFlowChartCircleShape.Create */ inline __fastcall virtual TOrShape(System::Classes::TComponent* AOwner) : TFlowChartCircleShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TOrShape() { }
	
};


class PASCALIMPLEMENTATION TOnlineStorageShape : public TFlowChartShape
{
	typedef TFlowChartShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TOnlineStorageShape(System::Classes::TComponent* AOwner) : TFlowChartShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TOnlineStorageShape() { }
	
};


class PASCALIMPLEMENTATION TDataShape : public TOnlineStorageShape
{
	typedef TOnlineStorageShape inherited;
	
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TDataShape(System::Classes::TComponent* AOwner) : TOnlineStorageShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TDataShape() { }
	
};


class PASCALIMPLEMENTATION TMagneticTapeShape : public TFlowChartCircleShape
{
	typedef TFlowChartCircleShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
public:
	/* TFlowChartCircleShape.Create */ inline __fastcall virtual TMagneticTapeShape(System::Classes::TComponent* AOwner) : TFlowChartCircleShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TMagneticTapeShape() { }
	
};


class PASCALIMPLEMENTATION TTapeShape : public TMagneticTapeShape
{
	typedef TMagneticTapeShape inherited;
	
public:
	/* TFlowChartCircleShape.Create */ inline __fastcall virtual TTapeShape(System::Classes::TComponent* AOwner) : TMagneticTapeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTapeShape() { }
	
};


class PASCALIMPLEMENTATION TPentagonShape : public Teetree::TTreeCustomPolygonShape
{
	typedef Teetree::TTreeCustomPolygonShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TPentagonShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TPentagonShape() { }
	
};


class PASCALIMPLEMENTATION THexagonShape : public Teetree::TTreeCustomPolygonShape
{
	typedef Teetree::TTreeCustomPolygonShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual THexagonShape(System::Classes::TComponent* AOwner) : Teetree::TTreeCustomPolygonShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~THexagonShape() { }
	
};


class PASCALIMPLEMENTATION TOctagonShape : public Teetree::TTreeCustomPolygonShape
{
	typedef Teetree::TTreeCustomPolygonShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TOctagonShape(System::Classes::TComponent* AOwner);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TOctagonShape() { }
	
};


class PASCALIMPLEMENTATION TCrossShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
private:
	int FPercentHoriz;
	int FPercentVert;
	void __fastcall SetHoriz(const int Value);
	void __fastcall SetVert(const int Value);
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TCrossShape(System::Classes::TComponent* AOwner);
	
__published:
	__property int PercentHoriz = {read=FPercentHoriz, write=SetHoriz, default=25};
	__property int PercentVert = {read=FPercentVert, write=SetVert, default=25};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TCrossShape() { }
	
};


class PASCALIMPLEMENTATION TTriangleRectShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
public:
	__fastcall virtual TTriangleRectShape(System::Classes::TComponent* AOwner);
	
__published:
	__property VertTextAlign = {default=2};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTriangleRectShape() { }
	
};


class PASCALIMPLEMENTATION TTriangleRectRightShape : public TTriangleRectShape
{
	typedef TTriangleRectShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTriangleRectShape.Create */ inline __fastcall virtual TTriangleRectRightShape(System::Classes::TComponent* AOwner) : TTriangleRectShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTriangleRectRightShape() { }
	
};


class PASCALIMPLEMENTATION TTriangleRectLeftShape : public TTriangleRectShape
{
	typedef TTriangleRectShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTriangleRectShape.Create */ inline __fastcall virtual TTriangleRectLeftShape(System::Classes::TComponent* AOwner) : TTriangleRectShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTriangleRectLeftShape() { }
	
};


class PASCALIMPLEMENTATION THouseShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
private:
	double FWallSize;
	bool __fastcall ClickedMiddle(int x, int y);
	int __fastcall InternalWallSize(const System::Types::TRect &R);
	void __fastcall SetWallSize(const double Value);
	
protected:
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual THouseShape(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DrawHandles();
	DYNAMIC Teetree::TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	DYNAMIC void __fastcall Resize(Teetree::TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
	
__published:
	__property double WallSize = {read=FWallSize, write=SetWallSize};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~THouseShape() { }
	
};


class PASCALIMPLEMENTATION TEnvelopeShape : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
private:
	int FOffsetY;
	bool __fastcall ClickedMiddle(int x, int y);
	System::Types::TPoint __fastcall MiddlePoint(const System::Types::TRect &R);
	void __fastcall SetOffsetY(const int Value);
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	
public:
	__fastcall virtual TEnvelopeShape(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DrawHandles();
	DYNAMIC Teetree::TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	DYNAMIC void __fastcall Resize(Teetree::TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
	
__published:
	__property int OffsetY = {read=FOffsetY, write=SetOffsetY, default=33};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TEnvelopeShape() { }
	
};


class PASCALIMPLEMENTATION TRingShape : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TRingShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Style = {default=1};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TRingShape() { }
	
};


class PASCALIMPLEMENTATION TTreeCustomArrowShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
private:
	int FPercentHoriz;
	int FPercentVert;
	void __fastcall SetHoriz(const int Value);
	void __fastcall SetVert(const int Value);
	
public:
	__fastcall virtual TTreeCustomArrowShape(System::Classes::TComponent* AOwner);
	
__published:
	__property int PercentHoriz = {read=FPercentHoriz, write=SetHoriz, default=25};
	__property int PercentVert = {read=FPercentVert, write=SetVert, default=33};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TTreeCustomArrowShape() { }
	
};


class PASCALIMPLEMENTATION TArrowUpShape : public TTreeCustomArrowShape
{
	typedef TTreeCustomArrowShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTreeCustomArrowShape.Create */ inline __fastcall virtual TArrowUpShape(System::Classes::TComponent* AOwner) : TTreeCustomArrowShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TArrowUpShape() { }
	
};


class PASCALIMPLEMENTATION TArrowDownShape : public TTreeCustomArrowShape
{
	typedef TTreeCustomArrowShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTreeCustomArrowShape.Create */ inline __fastcall virtual TArrowDownShape(System::Classes::TComponent* AOwner) : TTreeCustomArrowShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TArrowDownShape() { }
	
};


class PASCALIMPLEMENTATION TArrowLeftShape : public TTreeCustomArrowShape
{
	typedef TTreeCustomArrowShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTreeCustomArrowShape.Create */ inline __fastcall virtual TArrowLeftShape(System::Classes::TComponent* AOwner) : TTreeCustomArrowShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TArrowLeftShape() { }
	
};


class PASCALIMPLEMENTATION TArrowRightShape : public TTreeCustomArrowShape
{
	typedef TTreeCustomArrowShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TTreeCustomArrowShape.Create */ inline __fastcall virtual TArrowRightShape(System::Classes::TComponent* AOwner) : TTreeCustomArrowShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TArrowRightShape() { }
	
};


class PASCALIMPLEMENTATION TCallOutShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
private:
	int FPosX;
	int FPosY;
	System::Types::TPoint __fastcall CallOutPoint(const System::Types::TRect &R);
	bool __fastcall ClickedCallOut(int x, int y);
	
protected:
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
	
public:
	__fastcall virtual TCallOutShape(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DrawHandles();
	DYNAMIC Teetree::TTreeShapeHandle __fastcall GetResizingHandle(int x, int y);
	DYNAMIC void __fastcall Resize(Teetree::TTreeShapeHandle ACorner, int DeltaX, int DeltaY);
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TCallOutShape() { }
	
};


class PASCALIMPLEMENTATION TStarShape : public Teetree::TCustomTreeShape
{
	typedef Teetree::TCustomTreeShape inherited;
	
protected:
	virtual int __fastcall GetShapePoints(const System::Types::TRect &R, Teetree::TShapePoints &P);
public:
	/* TCustomTreeShape.Create */ inline __fastcall virtual TStarShape(System::Classes::TComponent* AOwner) : Teetree::TCustomTreeShape(AOwner) { }
	
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TStarShape() { }
	
};


class PASCALIMPLEMENTATION TGridCellShape : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
protected:
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall SetSelected(bool Value);
	
public:
	int Column;
	int Row;
public:
	/* TTreeNodeShape.Create */ inline __fastcall virtual TGridCellShape(System::Classes::TComponent* AOwner) : Teetree::TTreeNodeShape(AOwner) { }
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TGridCellShape() { }
	
};


typedef void __fastcall (__closure *TGridShapeNewCellEvent)(TGridShape* Sender, int Row, int Col);

class PASCALIMPLEMENTATION TGridShape : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
private:
	System::StaticArray<System::StaticArray<TGridCellShape*, 101>, 101> FCell;
	int FColumns;
	int FRows;
	Vcltee::Tecanvas::TTeePen* FGridLines;
	TGridShapeNewCellEvent FOnNewCell;
	int FSelectedCol;
	int FSelectedRow;
	void __fastcall SetColumns(const int Value);
	void __fastcall SetRows(const int Value);
	void __fastcall SetGridLines(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	System::Types::TRect __fastcall CellRect(const System::Types::TRect &R, int Row, int Col);
	DYNAMIC void __fastcall DoClick(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int x, int y);
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	virtual TGridCellShape* __fastcall GetCell(int Row, int Col);
	DYNAMIC Teetree::TTreeNodeShape* __fastcall GetEditedShape();
	DYNAMIC System::Uitypes::TCursor __fastcall GetHandleCursor(int x, int y);
	virtual void __fastcall Loaded();
	virtual void __fastcall SetSelected(bool Value);
	
public:
	__fastcall virtual TGridShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGridShape();
	void __fastcall AddColumn();
	void __fastcall AddRow();
	TGridCellShape* __fastcall CellAt(int x, int y);
	void __fastcall ClearSelection();
	void __fastcall DeleteColumn(int Column);
	void __fastcall DeleteRow(int Row);
	virtual void __fastcall RecalcSize(Vcltee::Tecanvas::TCanvas3D* const ACanvas);
	__property TGridCellShape* Cells[int Row][int Col] = {read=GetCell/*, default*/};
	
__published:
	__property AutoSize = {default=0};
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
	__property Vcltee::Tecanvas::TTeePen* GridLines = {read=FGridLines, write=SetGridLines};
	__property int Rows = {read=FRows, write=SetRows, nodefault};
	__property Transparent = {default=1};
	__property TGridShapeNewCellEvent OnNewCell = {read=FOnNewCell, write=FOnNewCell};
};


class PASCALIMPLEMENTATION TBeveledShape : public Teetree::TTreeNodeShape
{
	typedef Teetree::TTreeNodeShape inherited;
	
private:
	Vcl::Controls::TBevelCut FBevel;
	int FBevelSize;
	void __fastcall SetBevel(const Vcl::Controls::TBevelCut Value);
	void __fastcall SetBevelSize(const int Value);
	
protected:
	virtual void __fastcall DrawShapeCanvas(Vcltee::Tecanvas::TCanvas3D* const ACanvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TBeveledShape(System::Classes::TComponent* AOwner);
	
__published:
	__property Vcl::Controls::TBevelCut Bevel = {read=FBevel, write=SetBevel, default=2};
	__property int BevelSize = {read=FBevelSize, write=SetBevelSize, default=1};
	__property Color = {default=-16777201};
public:
	/* TTreeNodeShape.Destroy */ inline __fastcall virtual ~TBeveledShape() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxRows = System::Int8(0x64);
static const System::Int8 MaxCols = System::Int8(0x64);
}	/* namespace Treeflow */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEFLOW)
using namespace Treeflow;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeflowHPP
