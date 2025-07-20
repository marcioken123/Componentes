// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMesh.pas' rev: 34.00 (Windows)

#ifndef TeemeshHPP
#define TeemeshHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeExtruded.hpp>
#include <TeePointEditor.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeTerrain.hpp>
#include <VCLTee.TeeTriangulate.hpp>
#include <System.Math.Vectors.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemesh
{
//-- forward type declarations -----------------------------------------------
struct TTrianglePoint;
struct TTriangle;
class DELPHICLASS TMeshBlock;
class DELPHICLASS TMeshEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TTrianglePoint
{
public:
	Teeblocks::TRGBAlpha Color;
	System::Math::Vectors::TPoint3D Point;
	bool UseColor;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TTriangle
{
public:
	int Point0;
	int Point1;
	int Point2;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TMeshBlock : public Teeextruded::TPointerBlock
{
	typedef Teeextruded::TPointerBlock inherited;
	
	
private:
	typedef System::DynamicArray<TTrianglePoint> _TMeshBlock__1;
	
	typedef System::DynamicArray<TTriangle> _TMeshBlock__2;
	
	
private:
	int FSelectedTriangle;
	int IList;
	int IListPen;
	System::Math::Vectors::TPoint3D IRange;
	double __fastcall GetX(int Index);
	double __fastcall GetZ(int Index);
	void __fastcall SetSelectedTriangle(const int Value);
	void __fastcall SetXYZ(int Dest, int Source);
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	bool Picking;
	void __fastcall DataChanged();
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DeleteLists();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual System::Math::Vectors::TPoint3D __fastcall SelectedPoint();
	
public:
	_TMeshBlock__1 Points;
	_TMeshBlock__2 Triangles;
	__fastcall virtual ~TMeshBlock();
	int __fastcall AddPoint(const System::Math::Vectors::TPoint3D &P)/* overload */;
	int __fastcall AddPoint(const float X, const float Y, const float Z)/* overload */;
	int __fastcall AddPoint(const float X, const float Y, const float Z, const System::Uitypes::TColor Color)/* overload */;
	int __fastcall ClickedPoint(int X, int Y);
	void __fastcall DeletePoint(int Index);
	void __fastcall MovePoint(int Index, const System::Math::Vectors::TPoint3D &Delta, bool LimitBounds = true);
	void __fastcall SetPointColor(int Index, const System::Uitypes::TColor AColor);
	int __fastcall AddTriangle(int Index0, int Index1, int Index2)/* overload */;
	int __fastcall AddTriangle(const System::Math::Vectors::TPoint3D &P0, const System::Math::Vectors::TPoint3D &P1, const System::Math::Vectors::TPoint3D &P2)/* overload */;
	void __fastcall DeleteTriangle(int TriangleIndex);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	void __fastcall SubDivide(int TriangleIndex);
	System::Math::Vectors::TPoint3D __fastcall TriangleCenter(int TriangleIndex);
	void __fastcall Triangulate();
	__property int SelectedTriangle = {read=FSelectedTriangle, write=SetSelectedTriangle, nodefault};
public:
	/* TPointerBlock.Create */ inline __fastcall virtual TMeshBlock(System::Classes::TComponent* AOwner) : Teeextruded::TPointerBlock(AOwner) { }
	
};


class PASCALIMPLEMENTATION TMeshEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabTriangles;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Stdctrls::TLabel* Label61;
	Vcltee::Tecanvas::TComboFlat* BlockPointer;
	Vcl::Stdctrls::TCheckBox* BlockColorEach;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TLabel* LabelTotalTriangles;
	Vcl::Stdctrls::TLabel* LabelTotalPoints;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TTabSheet* TabPoints;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EPoint;
	Vcl::Comctrls::TUpDown* UDPoint;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Stdctrls::TEdit* ETriangle;
	Vcl::Comctrls::TUpDown* UDTriangle;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* EPoint0;
	Vcl::Comctrls::TUpDown* UDPoint0;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* EPoint1;
	Vcl::Comctrls::TUpDown* UDPoint1;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* EPoint2;
	Vcl::Comctrls::TUpDown* UDPoint2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ETriangleChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall BlockPointerChange(System::TObject* Sender);
	void __fastcall BlockColorEachClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall EPointChange(System::TObject* Sender);
	
private:
	Teepointeditor::TPointEditor* IPoints;
	Teeblocks::TPointXYZColor* ThePoint;
	int __fastcall FirstTriangleWithPoint(int APoint);
	void __fastcall PointChanged(System::TObject* Sender);
	void __fastcall RefreshInfo();
	void __fastcall SetPointData(int APoint, Teeblocks::TPointXYZColor* P);
	
public:
	TMeshBlock* Mesh;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMeshEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMeshEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMeshEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMeshEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemesh */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMESH)
using namespace Teemesh;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemeshHPP
