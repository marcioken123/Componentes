// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFillers.pas' rev: 31.00 (Windows)

#ifndef LmdfillersHPP
#define LmdfillersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraphUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfillers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDColorChannel;
class DELPHICLASS TLMDContainerColorChannel;
class DELPHICLASS TLMDMixedColorChannel;
class DELPHICLASS TLMDCompositeColorChannel;
class DELPHICLASS TLMDSolidColorChannel;
class DELPHICLASS TLMDVerticalColorChannel;
class DELPHICLASS TLMDHorizontalColorChannel;
class DELPHICLASS TLMDEllipseColorChannel;
class DELPHICLASS TLMDDirectedColorChannel;
class DELPHICLASS TLMDLineColorChannel;
class DELPHICLASS TLMDBandColorChannel;
class DELPHICLASS TLMDRectangleColorChannel;
class DELPHICLASS TLMDFiller;
class DELPHICLASS TLMDContainerFiller;
class DELPHICLASS TLMDCompositeFiller;
class DELPHICLASS TLMDMixedFiller;
class DELPHICLASS TLMDSolidFiller;
class DELPHICLASS TLMDEllipseFiller;
class DELPHICLASS TLMDRoundFiller;
class DELPHICLASS TLMDLineFiller;
class DELPHICLASS TLMDVerticalGradient;
class DELPHICLASS TLMDHorizontalGradient;
class DELPHICLASS TLMDBandFiller;
class DELPHICLASS TLMDRectangleFiller;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDColorChannel : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<System::Byte> _TLMDColorChannel__1;
	
	
private:
	System::Types::TPoint FBasePoint;
	int FLengthN;
	int FLengthT;
	_TLMDColorChannel__1 FValues;
	System::Types::TPoint FVectorN;
	System::Types::TPoint FVectorT;
	virtual System::Types::TPoint __fastcall GetBasePoint(void);
	System::Byte __fastcall GetFixedValues(int Index);
	virtual System::Byte __fastcall GetStartValue(void);
	virtual System::Byte __fastcall GetValueByPosAndDist(int ADist, int APos);
	int __fastcall GetValueCount(void);
	virtual System::Byte __fastcall GetEndValue(void);
	virtual System::Types::TPoint __fastcall GetVectorN(void);
	virtual System::Types::TPoint __fastcall GetVectorT(void);
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	void __fastcall SetFixedValues(int Index, const System::Byte Value);
	virtual void __fastcall SetLengthN(int Value);
	virtual void __fastcall SetLengthT(int Value);
	virtual void __fastcall SetStartValue(System::Byte Value);
	void __fastcall SetValueCount(int NewCount);
	virtual void __fastcall SetEndValue(System::Byte Value);
	virtual void __fastcall SetVectorN(const System::Types::TPoint &Value);
	virtual void __fastcall SetVectorT(const System::Types::TPoint &Value);
	__property int LengthN = {read=FLengthN, write=SetLengthN, nodefault};
	__property int LengthT = {read=FLengthT, write=SetLengthT, nodefault};
	
protected:
	virtual void __fastcall BoundRect(const System::Types::TRect &ARect);
	virtual void __fastcall SetPosition(System::TObject* AObject);
	
public:
	__fastcall TLMDColorChannel(void);
	__fastcall virtual ~TLMDColorChannel(void);
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
	__property System::Types::TPoint BasePoint = {read=GetBasePoint, write=SetBasePoint};
	__property System::Byte FixedValues[int Index] = {read=GetFixedValues, write=SetFixedValues};
	__property System::Byte StartValue = {read=GetStartValue, write=SetStartValue, nodefault};
	__property int ValueCount = {read=GetValueCount, write=SetValueCount, nodefault};
	__property System::Byte EndValue = {read=GetEndValue, write=SetEndValue, nodefault};
	__property System::Types::TPoint VectorN = {read=GetVectorN, write=SetVectorN};
	__property System::Types::TPoint VectorT = {read=GetVectorT, write=SetVectorT};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDContainerColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
private:
	System::Classes::TList* FComponentFillerList;
	virtual System::Types::TPoint __fastcall GetBasePoint(void);
	virtual TLMDColorChannel* __fastcall GetItem(int Index);
	virtual System::Byte __fastcall GetStartValue(void);
	virtual System::Byte __fastcall GetEndValue(void);
	virtual System::Types::TPoint __fastcall GetVectorN(void);
	virtual System::Types::TPoint __fastcall GetVectorT(void);
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	virtual void __fastcall SetItem(int Index, TLMDColorChannel* Value);
	virtual void __fastcall SetLengthN(int Value);
	virtual void __fastcall SetLengthT(int Value);
	virtual void __fastcall SetStartValue(System::Byte Value);
	virtual void __fastcall SetEndValue(System::Byte Value);
	virtual void __fastcall SetVectorN(const System::Types::TPoint &Value);
	virtual void __fastcall SetVectorT(const System::Types::TPoint &Value);
	
public:
	__fastcall virtual TLMDContainerColorChannel(void);
	__fastcall virtual ~TLMDContainerColorChannel(void);
	virtual void __fastcall Add(TLMDColorChannel* AComponentFiller);
	virtual int __fastcall Count(void);
	virtual void __fastcall Delete(TLMDColorChannel* AComponentFiller);
	__property TLMDColorChannel* Item[int Index] = {read=GetItem, write=SetItem};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMixedColorChannel : public TLMDContainerColorChannel
{
	typedef TLMDContainerColorChannel inherited;
	
	
private:
	typedef System::DynamicArray<System::Byte> _TLMDMixedColorChannel__1;
	
	
private:
	_TLMDMixedColorChannel__1 FWeight;
	System::Byte __fastcall GetWeight(int Index);
	void __fastcall SetWeight(int Index, System::Byte NewValue);
	
public:
	__fastcall virtual ~TLMDMixedColorChannel(void);
	virtual void __fastcall Add(TLMDColorChannel* AComponentFiller);
	virtual void __fastcall Delete(TLMDColorChannel* AComponentFiller);
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
	__property System::Byte Weight[int Index] = {read=GetWeight, write=SetWeight};
public:
	/* TLMDContainerColorChannel.Create */ inline __fastcall virtual TLMDMixedColorChannel(void) : TLMDContainerColorChannel() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompositeColorChannel : public TLMDContainerColorChannel
{
	typedef TLMDContainerColorChannel inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TLMDCompositeColorChannel__1;
	
	
private:
	_TLMDCompositeColorChannel__1 FFillerRects;
	System::Types::TRect __fastcall GetFillerRect(int Index);
	void __fastcall SetFillerRect(int Index, const System::Types::TRect &Value);
	
protected:
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	
public:
	__fastcall virtual ~TLMDCompositeColorChannel(void);
	virtual void __fastcall Add(TLMDColorChannel* AComponentFiller);
	virtual void __fastcall Delete(TLMDColorChannel* AComponentFiller);
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
	__property System::Types::TRect FillerRect[int Index] = {read=GetFillerRect, write=SetFillerRect};
public:
	/* TLMDContainerColorChannel.Create */ inline __fastcall virtual TLMDCompositeColorChannel(void) : TLMDContainerColorChannel() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSolidColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDSolidColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDSolidColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVerticalColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDVerticalColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDVerticalColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHorizontalColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDHorizontalColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDHorizontalColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEllipseColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
private:
	int FAxis1;
	int FAxis2;
	System::Types::TPoint FFirstAxisDirection;
	int FLengthNt;
	void __fastcall SetAxis1(int Value);
	void __fastcall SetAxis2(int Value);
	void __fastcall SetFirstAxisDirection(const System::Types::TPoint &Value);
	virtual void __fastcall SetLengthN(int Value);
	virtual void __fastcall SetLengthT(int Value);
	void __fastcall SetParam(void);
	
protected:
	virtual void __fastcall SetPosition(System::TObject* AObject);
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
	__property int Axis1 = {read=FAxis1, write=SetAxis1, nodefault};
	__property int Axis2 = {read=FAxis2, write=SetAxis2, nodefault};
	__property System::Types::TPoint FirstAxisDirection = {read=FFirstAxisDirection, write=SetFirstAxisDirection};
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDEllipseColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDEllipseColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDirectedColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
private:
	System::Types::TPoint __fastcall GetDirection(void);
	void __fastcall SetDirection(const System::Types::TPoint &Value);
	
protected:
	virtual void __fastcall BoundRect(const System::Types::TRect &ARect);
	
public:
	__property System::Types::TPoint Direction = {read=GetDirection, write=SetDirection};
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDDirectedColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDDirectedColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLineColorChannel : public TLMDDirectedColorChannel
{
	typedef TLMDDirectedColorChannel inherited;
	
protected:
	virtual void __fastcall SetPosition(System::TObject* AObject);
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDLineColorChannel(void) : TLMDDirectedColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDLineColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBandColorChannel : public TLMDDirectedColorChannel
{
	typedef TLMDDirectedColorChannel inherited;
	
private:
	int FWidth;
	
protected:
	virtual void __fastcall BoundRect(const System::Types::TRect &ARect);
	virtual void __fastcall SetPosition(System::TObject* AObject);
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
	__property int Width = {read=FWidth, write=FWidth, nodefault};
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDBandColorChannel(void) : TLMDDirectedColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDBandColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRectangleColorChannel : public TLMDColorChannel
{
	typedef TLMDColorChannel inherited;
	
public:
	virtual System::Byte __fastcall Value(const System::Types::TPoint &APoint);
public:
	/* TLMDColorChannel.Create */ inline __fastcall TLMDRectangleColorChannel(void) : TLMDColorChannel() { }
	/* TLMDColorChannel.Destroy */ inline __fastcall virtual ~TLMDRectangleColorChannel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFiller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int __fastcall GetColorCount(void);
	System::Byte __fastcall GetFixedAlpha(int Index);
	System::Uitypes::TColor __fastcall GetFixedColors(int Index);
	void __fastcall SetColorCount(int Value);
	void __fastcall SetFixedAlpha(int Index, System::Byte Value);
	void __fastcall SetFixedColors(int Index, System::Uitypes::TColor Value);
	
protected:
	bool FUseRelativeUnits;
	TLMDColorChannel* FRedChannel;
	TLMDColorChannel* FGreenChannel;
	TLMDColorChannel* FBlueChannel;
	TLMDColorChannel* FAlphaChannel;
	virtual System::Types::TPoint __fastcall GetBasePoint(void);
	virtual System::Uitypes::TColor __fastcall GetStartColor(void);
	virtual System::Uitypes::TColor __fastcall GetEndColor(void);
	virtual System::Types::TPoint __fastcall GetVectorN(void);
	virtual System::Types::TPoint __fastcall GetVectorT(void);
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	virtual void __fastcall SetStartColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetEndColor(System::Uitypes::TColor Value);
	virtual System::Byte __fastcall GetStartAlpha(void);
	virtual System::Byte __fastcall GetEndAlpha(void);
	virtual void __fastcall SetStartAlpha(System::Byte Value);
	virtual void __fastcall SetEndAlpha(System::Byte Value);
	virtual void __fastcall SetVectorN(const System::Types::TPoint &Value);
	virtual void __fastcall SetVectorT(const System::Types::TPoint &Value);
	
public:
	__fastcall virtual TLMDFiller(void);
	__fastcall virtual ~TLMDFiller(void);
	TLMDFiller* __fastcall CreateFrom(TLMDFiller* aFiller);
	TLMDFiller* __fastcall Clone(bool aCopyColorsAndAlpha = true);
	void __fastcall ChangeColorBrightness(int aPercent, int aIndex = 0xffffffff);
	void __fastcall ReplaceColor(System::Uitypes::TColor aOldColor, System::Uitypes::TColor aNewColor, int aIndex = 0xffffffff);
	void __fastcall SetNewColor(System::Uitypes::TColor aColor, int aIndex = 0xffffffff);
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	virtual void __fastcall BoundRect(const System::Types::TRect &ARect);
	void __fastcall CopyColorsAndAlphaFrom(TLMDFiller* aFiller, bool aReverse = false);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABitmap24);
	virtual void __fastcall SetPosition(System::TObject* AObject);
	__property System::Types::TPoint BasePoint = {read=GetBasePoint, write=SetBasePoint};
	__property System::Uitypes::TColor StartColor = {read=GetStartColor, write=SetStartColor, nodefault};
	__property System::Uitypes::TColor EndColor = {read=GetEndColor, write=SetEndColor, nodefault};
	__property System::Byte StartAlpha = {read=GetStartAlpha, write=SetStartAlpha, nodefault};
	__property System::Byte EndAlpha = {read=GetEndAlpha, write=SetEndAlpha, nodefault};
	__property TLMDColorChannel* RedChannel = {read=FRedChannel, write=FRedChannel};
	__property TLMDColorChannel* GreenChannel = {read=FGreenChannel, write=FGreenChannel};
	__property TLMDColorChannel* BlueChannel = {read=FBlueChannel, write=FBlueChannel};
	__property TLMDColorChannel* AlphaChannel = {read=FAlphaChannel, write=FAlphaChannel};
	__property System::Types::TPoint VectorN = {read=GetVectorN, write=SetVectorN};
	__property System::Types::TPoint VectorT = {read=GetVectorT, write=SetVectorT};
	__property int ColorCount = {read=GetColorCount, write=SetColorCount, nodefault};
	__property System::Byte FixedAlpha[int Index] = {read=GetFixedAlpha, write=SetFixedAlpha};
	__property System::Uitypes::TColor FixedColors[int Index] = {read=GetFixedColors, write=SetFixedColors};
	__property bool UseRelativeUnits = {read=FUseRelativeUnits, write=FUseRelativeUnits, nodefault};
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDFillerClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDContainerFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	System::Classes::TList* FFillerList;
	int __fastcall GetCount(void);
	TLMDFiller* __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, TLMDFiller* Value);
	
public:
	virtual void __fastcall Add(TLMDFiller* AFiller);
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	__fastcall virtual TLMDContainerFiller(void);
	void __fastcall Clear(bool aFreeItems = false);
	__fastcall virtual ~TLMDContainerFiller(void);
	virtual void __fastcall Delete(TLMDFiller* AFiller)/* overload */;
	virtual void __fastcall Delete(int aFillerIndex)/* overload */;
	__property int Count = {read=GetCount, nodefault};
	__property TLMDFiller* Item[int Index] = {read=GetItem, write=SetItem};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompositeFiller : public TLMDContainerFiller
{
	typedef TLMDContainerFiller inherited;
	
private:
	System::Types::TRect __fastcall GetFillerRect(int Index);
	void __fastcall SetFillerRect(int Index, const System::Types::TRect &Value);
	
protected:
	virtual void __fastcall SetBasePoint(const System::Types::TPoint &Value);
	
public:
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	__fastcall virtual TLMDCompositeFiller(void);
	__property System::Types::TRect FillerRect[int Index] = {read=GetFillerRect, write=SetFillerRect};
public:
	/* TLMDContainerFiller.Destroy */ inline __fastcall virtual ~TLMDCompositeFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMixedFiller : public TLMDContainerFiller
{
	typedef TLMDContainerFiller inherited;
	
private:
	System::Byte __fastcall GetWeight(int Index);
	void __fastcall SetWeight(int Index, System::Byte NewValue);
	
public:
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	__fastcall virtual TLMDMixedFiller(void);
	__property System::Byte Weight[int Index] = {read=GetWeight, write=SetWeight};
public:
	/* TLMDContainerFiller.Destroy */ inline __fastcall virtual ~TLMDMixedFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSolidFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	System::Uitypes::TColor __fastcall GetColor(void);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TLMDSolidFiller(void);
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, nodefault};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDSolidFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEllipseFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	int FAxis1;
	int FAxis2;
	System::Types::TPoint FFirstAxisDirection;
	void __fastcall SetAxis1(int Value);
	void __fastcall SetAxis2(int Value);
	void __fastcall SetFirstAxisDirection(const System::Types::TPoint &Value);
	
public:
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	__fastcall virtual TLMDEllipseFiller(void);
	__property int Axis1 = {read=FAxis1, write=SetAxis1, nodefault};
	__property int Axis2 = {read=FAxis2, write=SetAxis2, nodefault};
	__property System::Types::TPoint FirstAxisDirection = {read=FFirstAxisDirection, write=SetFirstAxisDirection};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDEllipseFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRoundFiller : public TLMDEllipseFiller
{
	typedef TLMDEllipseFiller inherited;
	
private:
	int __fastcall GetRadius(void);
	void __fastcall SetRadius(int Value);
	
public:
	virtual void __fastcall AssignTo(TLMDFiller* aDestFiller, bool aCopyColorsAndAlpha = true);
	__property int Radius = {read=GetRadius, write=SetRadius, nodefault};
public:
	/* TLMDEllipseFiller.Create */ inline __fastcall virtual TLMDRoundFiller(void) : TLMDEllipseFiller() { }
	
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDRoundFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLineFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	System::Types::TPoint __fastcall GetDirection(void);
	void __fastcall SetDirection(const System::Types::TPoint &Value);
	
public:
	__fastcall virtual TLMDLineFiller(void);
	__property System::Types::TPoint Direction = {read=GetDirection, write=SetDirection};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDLineFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVerticalGradient : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	int __fastcall GetHeight(void);
	void __fastcall SetHeight(int Value);
	
public:
	__fastcall virtual TLMDVerticalGradient(void);
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDVerticalGradient(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHorizontalGradient : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	int __fastcall GetHeight(void);
	void __fastcall SetHeight(int Value);
	
public:
	__fastcall virtual TLMDHorizontalGradient(void);
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDHorizontalGradient(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBandFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
private:
	System::Types::TPoint __fastcall GetDirection(void);
	int __fastcall GetWidth(void);
	void __fastcall SetDirection(const System::Types::TPoint &Value);
	void __fastcall SetWidth(int Value);
	
public:
	__fastcall virtual TLMDBandFiller(void);
	__property System::Types::TPoint Direction = {read=GetDirection, write=SetDirection};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDBandFiller(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRectangleFiller : public TLMDFiller
{
	typedef TLMDFiller inherited;
	
public:
	__fastcall virtual TLMDRectangleFiller(void);
public:
	/* TLMDFiller.Destroy */ inline __fastcall virtual ~TLMDRectangleFiller(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfillers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILLERS)
using namespace Lmdfillers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfillersHPP
