// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeExtruded.pas' rev: 34.00 (Windows)

#ifndef TeeextrudedHPP
#define TeeextrudedHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeRoundRect.hpp>
#include <System.Math.Vectors.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeextruded
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointItem;
class DELPHICLASS TPointCollection;
class DELPHICLASS TPointerBlock;
class DELPHICLASS TPathBlock;
class DELPHICLASS TTapeCorners;
struct TBoundVertex;
class DELPHICLASS TTapeBlock;
class DELPHICLASS TExtrudedBlock;
class DELPHICLASS TBridgeBlock;
class DELPHICLASS TTeePolygonBlock;
class DELPHICLASS TPentagonBlock;
class DELPHICLASS THexagonBlock;
class DELPHICLASS TOctagonBlock;
class DELPHICLASS TArrowBlock;
class DELPHICLASS TRombusBlock;
class DELPHICLASS TCrossBlock;
class DELPHICLASS TStarBlock;
class DELPHICLASS TPentagramBlock;
class DELPHICLASS THexagramBlock;
class DELPHICLASS TRectPyramidBlock;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPointItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcltee::Teeanimate::TPropertyLink* FLink;
	Teeblocks::TPointXYZColor* FPoint;
	System::UnicodeString IRealYPropertyName;
	System::UnicodeString IRealZPropertyName;
	void __fastcall DataChanged(System::TObject* Sender);
	Vcltee::Teeanimate::TPropertyLink* __fastcall GetLink();
	Teeblocks::TPointXYZColor* __fastcall GetPoint();
	void __fastcall SetLink(Vcltee::Teeanimate::TPropertyLink* const Value);
	void __fastcall SetPoint(Teeblocks::TPointXYZColor* const Value);
	
public:
	__fastcall virtual TPointItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TPointItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Teeanimate::TPropertyLink* Link = {read=GetLink, write=SetLink};
	__property Teeblocks::TPointXYZColor* Point = {read=GetPoint, write=SetPoint};
};


class PASCALIMPLEMENTATION TPointCollection : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TPointItem* operator[](int Index) { return this->Point[Index]; }
	
private:
	bool IChanged;
	Vcltee::Tecanvas::TVisualBlock* IOwner;
	TPointItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TPointItem* const Value);
	
protected:
	bool IConvex;
	void __fastcall DoChanged();
	Vcltee::Tecanvas::TPointFloatArray __fastcall GetPoints();
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	void __fastcall Repaint();
	HIDESBASE TPointItem* __fastcall Add(const float AX, const float AZ)/* overload */;
	HIDESBASE TPointItem* __fastcall Add(const float AX, const float AY, const float AZ)/* overload */;
	HIDESBASE TPointItem* __fastcall Add(const System::Math::Vectors::TPoint3D &XYZ)/* overload */;
	HIDESBASE TPointItem* __fastcall Add(const Vcltee::Tecanvas::TPoint3D &XYZ)/* overload */;
	HIDESBASE TPointItem* __fastcall Add(const System::Types::TPoint &Point)/* overload */;
	HIDESBASE void __fastcall Add(const Vcltee::Tecanvas::TPointArray Points)/* overload */;
	HIDESBASE void __fastcall Add(const Vcltee::Tecanvas::TFourPoints &Points)/* overload */;
	bool __fastcall IsConvexPolygon();
	__property TPointItem* Point[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TPointCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPointCollection() { }
	
};


class PASCALIMPLEMENTATION TPointerBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	bool FColorEach;
	Teeblocks::TCustomBlock* FPointer;
	int FSelected;
	System::Math::Vectors::TPoint3D IFac;
	System::Math::Vectors::TPoint3D IOff;
	void __fastcall SetColorEach(const bool Value);
	void __fastcall SetPointer(Teeblocks::TCustomBlock* const Value);
	void __fastcall SetSelected(const int Value);
	
protected:
	System::Math::Vectors::TPoint3D IMax;
	System::Math::Vectors::TPoint3D IMin;
	System::Math::Vectors::TPoint3D __fastcall CalcPoint(const System::Math::Vectors::TPoint3D &P);
	DYNAMIC void __fastcall DrawSelected();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PrepareCalcPoint();
	virtual System::Math::Vectors::TPoint3D __fastcall SelectedPoint() = 0 ;
	
public:
	__fastcall virtual TPointerBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPointerBlock();
	virtual void __fastcall Draw();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int Selected = {read=FSelected, write=SetSelected, nodefault};
	
__published:
	__property bool ColorEach = {read=FColorEach, write=SetColorEach, default=1};
	__property Teeblocks::TCustomBlock* Pointer = {read=FPointer, write=SetPointer};
};


class PASCALIMPLEMENTATION TPathBlock : public TPointerBlock
{
	typedef TPointerBlock inherited;
	
private:
	TPointCollection* FPoints;
	bool IStorePoints;
	bool __fastcall IsPointsStored();
	void __fastcall SetPoints(TPointCollection* const Value);
	
protected:
	int IPointCount;
	virtual void __fastcall AddPathPoint(const float X, const float Y, const System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	bool __fastcall CalcMinMax(System::Math::Vectors::TPoint3D &AMin, System::Math::Vectors::TPoint3D &AMax);
	virtual void __fastcall ClearPath();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual System::Math::Vectors::TPoint3D __fastcall SelectedPoint();
	
public:
	bool HasYValues;
	__fastcall virtual TPathBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPathBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property TPointCollection* Points = {read=FPoints, write=SetPoints, stored=IsPointsStored};
};


class PASCALIMPLEMENTATION TTapeCorners : public Teeroundrect::TRoundCorners
{
	typedef Teeroundrect::TRoundCorners inherited;
	
private:
	bool FEnabled;
	void __fastcall SetEnabled(const bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
public:
	/* TRoundCorners.Create */ inline __fastcall TTapeCorners(Teeblocks::TCustomBlock* AOwner, const float ASize) : Teeroundrect::TRoundCorners(AOwner, ASize) { }
	/* TRoundCorners.Destroy */ inline __fastcall virtual ~TTapeCorners() { }
	
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TBoundVertex
{
public:
	System::Math::Vectors::TPoint3D Normal;
	System::Uitypes::TColor Color;
	Vcltee::Tecanvas::TFloatPoint Point;
	float TexPos;
};
#pragma pack(pop)


typedef System::DynamicArray<TBoundVertex> TBoundVertexs;

class PASCALIMPLEMENTATION TTapeBlock : public TPathBlock
{
	typedef TPathBlock inherited;
	
private:
	bool FAdjustTexture;
	bool FClosed;
	TTapeCorners* FCorners;
	float FRadius;
	int FRoundness;
	int FSlices;
	int FSlices3D;
	float FTape3D;
	bool FTapeColorEach;
	TBoundVertexs IBounds;
	bool IExtruded;
	int IList;
	int IListArea;
	int IListLine;
	float ITotalLength;
	void __fastcall ColorChanged(System::TObject* Sender);
	void __fastcall CornersChanged(System::TObject* Sender);
	void __fastcall SetAdjustTexture(const bool Value);
	void __fastcall SetClosed(const bool Value);
	void __fastcall SetCorners(TTapeCorners* const Value);
	void __fastcall SetRadius(const float Value);
	void __fastcall SetRoundness(const int Value);
	void __fastcall SetSlices(const int Value);
	void __fastcall SetSlices3D(const int Value);
	void __fastcall SetTape3D(const float Value);
	void __fastcall SetTapeColorEach(const bool Value);
	
protected:
	bool ForceClosed;
	virtual void __fastcall DeleteLists();
	virtual void __fastcall SizeChanged(System::TObject* Sender);
	
public:
	bool AreaRound;
	bool ConcaveArea;
	bool IsArea;
	__fastcall virtual TTapeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTapeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	
__published:
	__property bool AdjustTexture = {read=FAdjustTexture, write=SetAdjustTexture, default=1};
	__property bool Closed = {read=FClosed, write=SetClosed, default=0};
	__property TTapeCorners* Corners = {read=FCorners, write=SetCorners};
	__property float Radius = {read=FRadius, write=SetRadius};
	__property int Roundness = {read=FRoundness, write=SetRoundness, default=0};
	__property int Slices = {read=FSlices, write=SetSlices, default=32};
	__property int Slices3D = {read=FSlices3D, write=SetSlices3D, default=32};
	__property float Tape3D = {read=FTape3D, write=SetTape3D};
	__property bool TapeColorEach = {read=FTapeColorEach, write=SetTapeColorEach, default=1};
};


class PASCALIMPLEMENTATION TExtrudedBlock : public TTapeBlock
{
	typedef TTapeBlock inherited;
	
private:
	Teeblocks::TBlockFormat* FBack;
	Teeblocks::TBlockFormat* FFront;
	bool IDrawSides;
	int IList1;
	int IList2;
	bool INeedsRecalc;
	Teeblocks::TBlockFormat* __fastcall GetBack();
	Teeblocks::TBlockFormat* __fastcall GetFront();
	bool __fastcall IsBackStored();
	bool __fastcall IsFrontStored();
	void __fastcall SetBack(Teeblocks::TBlockFormat* const Value);
	void __fastcall SetFront(Teeblocks::TBlockFormat* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	void __fastcall DoChanged(System::TObject* Sender);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TExtrudedBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TExtrudedBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	bool __fastcall HasBack();
	bool __fastcall HasFront();
	
__published:
	__property Teeblocks::TBlockFormat* Back = {read=GetBack, write=SetBack, stored=IsBackStored};
	__property Closed = {default=1};
	__property Teeblocks::TBlockFormat* Front = {read=GetFront, write=SetFront, stored=IsFrontStored};
};


class PASCALIMPLEMENTATION TBridgeBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FColumnSize;
	bool FRounded;
	int FRoundSlices;
	Vcltee::Tecanvas::TPointFloatArray IPoints;
	Vcltee::Tecanvas::TPointFloatArray ITexture;
	void __fastcall SetColumnSize(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetRoundSlices(const int Value);
	
protected:
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TBridgeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBridgeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* ColumnSize = {read=FColumnSize, write=SetColumnSize};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=1};
	__property int RoundSlices = {read=FRoundSlices, write=SetRoundSlices, default=32};
};


class PASCALIMPLEMENTATION TTeePolygonBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	void __fastcall CreatePoints(int Sides);
	
protected:
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TTeePolygonBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TTeePolygonBlock() { }
	
};


class PASCALIMPLEMENTATION TPentagonBlock : public TTeePolygonBlock
{
	typedef TTeePolygonBlock inherited;
	
public:
	__fastcall virtual TPentagonBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TPentagonBlock() { }
	
};


class PASCALIMPLEMENTATION THexagonBlock : public TTeePolygonBlock
{
	typedef TTeePolygonBlock inherited;
	
public:
	__fastcall virtual THexagonBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~THexagonBlock() { }
	
};


class PASCALIMPLEMENTATION TOctagonBlock : public TTeePolygonBlock
{
	typedef TTeePolygonBlock inherited;
	
public:
	__fastcall virtual TOctagonBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TOctagonBlock() { }
	
};


class PASCALIMPLEMENTATION TArrowBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FHead;
	float FIndent;
	void __fastcall SetHead(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetIndent(const float Value);
	
protected:
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TArrowBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TArrowBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* Head = {read=FHead, write=SetHead};
	__property float Indent = {read=FIndent, write=SetIndent};
};


class PASCALIMPLEMENTATION TRombusBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
public:
	__fastcall virtual TRombusBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TRombusBlock() { }
	
};


class PASCALIMPLEMENTATION TCrossBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	Vcltee::Tecanvas::TPointXYFloat* FCrossCenter;
	Vcltee::Tecanvas::TPointXYFloat* FCrossSize;
	void __fastcall SetCrossCenter(Vcltee::Tecanvas::TPointXYFloat* const Value);
	void __fastcall SetCrossSize(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TCrossBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCrossBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property Vcltee::Tecanvas::TPointXYFloat* CrossCenter = {read=FCrossCenter, write=SetCrossCenter};
	__property Vcltee::Tecanvas::TPointXYFloat* CrossSize = {read=FCrossSize, write=SetCrossSize};
};


class PASCALIMPLEMENTATION TStarBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	float FSlant;
	float FInner;
	int ISides;
	void __fastcall CreatePoints();
	bool __fastcall IsInnerStored();
	bool __fastcall IsSlantStored();
	void __fastcall SetInner(const float Value);
	void __fastcall SetSlant(const float Value);
	
public:
	__fastcall virtual TStarBlock(System::Classes::TComponent* AOwner);
	
__published:
	__property float InnerSize = {read=FInner, write=SetInner, stored=IsInnerStored};
	__property float SlantAngle = {read=FSlant, write=SetSlant, stored=IsSlantStored};
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TStarBlock() { }
	
};


class PASCALIMPLEMENTATION TPentagramBlock : public TStarBlock
{
	typedef TStarBlock inherited;
	
public:
	__fastcall virtual TPentagramBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TPentagramBlock() { }
	
};


class PASCALIMPLEMENTATION THexagramBlock : public TStarBlock
{
	typedef TStarBlock inherited;
	
public:
	__fastcall virtual THexagramBlock(System::Classes::TComponent* AOwner);
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~THexagramBlock() { }
	
};


class PASCALIMPLEMENTATION TRectPyramidBlock : public TExtrudedBlock
{
	typedef TExtrudedBlock inherited;
	
private:
	float FLeft;
	float FRight;
	void __fastcall CreatePoints();
	void __fastcall SetLeft(const float Value);
	void __fastcall SetRight(const float Value);
	
protected:
	DYNAMIC Teeblocks::TCustomBlock* __fastcall DesignHandles(System::Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TRectPyramidBlock(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property float LeftPercent = {read=FLeft, write=SetLeft};
	__property float RightPercent = {read=FRight, write=SetRight};
public:
	/* TExtrudedBlock.Destroy */ inline __fastcall virtual ~TRectPyramidBlock() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall CalcBezier(int CurvePoints, const _POINTFLOAT &P1, const _POINTFLOAT &P2, const _POINTFLOAT &P3, const _POINTFLOAT &P4, /* out */ Vcltee::Tecanvas::TPointFloatArray &Output, int NumPoints = 0x3);
}	/* namespace Teeextruded */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEEXTRUDED)
using namespace Teeextruded;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeextrudedHPP
