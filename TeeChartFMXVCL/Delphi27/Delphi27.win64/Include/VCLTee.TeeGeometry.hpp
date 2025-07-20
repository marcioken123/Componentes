// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGeometry.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegeometryHPP
#define Vcltee_TeegeometryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegeometry
{
//-- forward type declarations -----------------------------------------------
struct TQuaternion;
struct TRectangle;
//-- type declarations -------------------------------------------------------
typedef System::Byte *PByte;

typedef System::Word *PWord;

typedef int *PInteger;

typedef float *PFloat;

typedef double *PDouble;

typedef System::Extended *PExtended;

typedef void * *PPointer;

typedef System::StaticArray<System::Byte, 65536> TByteVector;

typedef TByteVector *PByteVector;

typedef System::StaticArray<System::Word, 65536> TWordVector;

typedef TWordVector *PWordVector;

typedef System::StaticArray<int, 65536> TIntVector;

typedef TIntVector *PIntVector;

typedef System::StaticArray<float, 65536> TFloatVector;

typedef TFloatVector *PFloatVector;

typedef System::StaticArray<double, 65536> TDblVector;

typedef TDblVector *PDblVector;

typedef System::StaticArray<System::Byte, 4> THomogeneousByteVector;

typedef THomogeneousByteVector *PHomogeneousByteVector;

typedef THomogeneousByteVector TVector4b;

typedef System::StaticArray<System::Word, 4> THomogeneousWordVector;

typedef THomogeneousWordVector *PHomogeneousWordVector;

typedef THomogeneousWordVector TVector4w;

typedef System::StaticArray<int, 4> THomogeneousIntVector;

typedef THomogeneousIntVector *PHomogeneousIntVector;

typedef THomogeneousIntVector TVector4i;

typedef System::StaticArray<float, 4> THomogeneousFltVector;

typedef THomogeneousFltVector *PHomogeneousFltVector;

typedef THomogeneousFltVector TVector4f;

typedef System::StaticArray<double, 4> THomogeneousDblVector;

typedef THomogeneousDblVector *PHomogeneousDblVector;

typedef THomogeneousDblVector TVector4d;

typedef System::StaticArray<System::Extended, 4> THomogeneousExtVector;

typedef THomogeneousExtVector *PHomogeneousExtVector;

typedef THomogeneousExtVector TVector4e;

typedef System::StaticArray<void *, 4> THomogeneousPtrVector;

typedef THomogeneousPtrVector *PHomogeneousPtrVector;

typedef THomogeneousPtrVector TVector4p;

typedef System::StaticArray<System::Byte, 3> TAffineByteVector;

typedef TAffineByteVector *PAffineByteVector;

typedef TAffineByteVector TVector3b;

typedef System::StaticArray<System::Word, 3> TAffineWordVector;

typedef TAffineWordVector *PAffineWordVector;

typedef TAffineWordVector TVector3w;

typedef System::StaticArray<int, 3> TAffineIntVector;

typedef TAffineIntVector *PAffineIntVector;

typedef TAffineIntVector TVector3i;

typedef System::StaticArray<float, 3> TAffineFltVector;

typedef TAffineFltVector *PAffineFltVector;

typedef TAffineFltVector TVector3f;

typedef System::StaticArray<double, 3> TAffineDblVector;

typedef TAffineDblVector *PAffineDblVector;

typedef TAffineDblVector TVector3d;

typedef System::StaticArray<System::Extended, 3> TAffineExtVector;

typedef TAffineExtVector *PAffineExtVector;

typedef TAffineExtVector TVector3e;

typedef System::StaticArray<void *, 3> TAffinePtrVector;

typedef TAffinePtrVector *PAffinePtrVector;

typedef TAffinePtrVector TVector3p;

typedef THomogeneousFltVector *PVector;

typedef THomogeneousFltVector TVector;

typedef THomogeneousFltVector *PHomogeneousVector;

typedef THomogeneousFltVector THomogeneousVector;

typedef TAffineFltVector *PAffineVector;

typedef TAffineFltVector TAffineVector;

typedef System::StaticArray<System::StaticArray<float, 3>, 65536> TVectorArray;

typedef TVectorArray *PVectorArray;

typedef System::StaticArray<System::StaticArray<System::Byte, 4>, 4> THomogeneousByteMatrix;

typedef THomogeneousByteMatrix TMatrix4b;

typedef System::StaticArray<System::StaticArray<System::Word, 4>, 4> THomogeneousWordMatrix;

typedef THomogeneousWordMatrix TMatrix4w;

typedef System::StaticArray<System::StaticArray<int, 4>, 4> THomogeneousIntMatrix;

typedef THomogeneousIntMatrix TMatrix4i;

typedef System::StaticArray<System::StaticArray<float, 4>, 4> THomogeneousFltMatrix;

typedef THomogeneousFltMatrix TMatrix4f;

typedef System::StaticArray<System::StaticArray<double, 4>, 4> THomogeneousDblMatrix;

typedef THomogeneousDblMatrix TMatrix4d;

typedef System::StaticArray<System::StaticArray<System::Extended, 4>, 4> THomogeneousExtMatrix;

typedef THomogeneousExtMatrix TMatrix4e;

typedef System::StaticArray<System::StaticArray<System::Byte, 3>, 3> TAffineByteMatrix;

typedef TAffineByteMatrix TMatrix3b;

typedef System::StaticArray<System::StaticArray<System::Word, 3>, 3> TAffineWordMatrix;

typedef TAffineWordMatrix TMatrix3w;

typedef System::StaticArray<System::StaticArray<int, 3>, 3> TAffineIntMatrix;

typedef TAffineIntMatrix TMatrix3i;

typedef System::StaticArray<System::StaticArray<float, 3>, 3> TAffineFltMatrix;

typedef TAffineFltMatrix TMatrix3f;

typedef System::StaticArray<System::StaticArray<double, 3>, 3> TAffineDblMatrix;

typedef TAffineDblMatrix TMatrix3d;

typedef System::StaticArray<System::StaticArray<System::Extended, 3>, 3> TAffineExtMatrix;

typedef TAffineExtMatrix TMatrix3e;

typedef THomogeneousFltMatrix *PMatrix;

typedef THomogeneousFltMatrix TMatrix;

typedef THomogeneousFltMatrix *PHomogeneousMatrix;

typedef THomogeneousFltMatrix THomogeneousMatrix;

typedef TAffineFltMatrix *PAffineMatrix;

typedef TAffineFltMatrix TAffineMatrix;

struct DECLSPEC_DRECORD TQuaternion
{
	
public:
	union
	{
		struct 
		{
			THomogeneousFltVector Vector;
		};
		struct 
		{
			TAffineFltVector Axis;
			float Angle;
		};
		
	};
};


struct DECLSPEC_DRECORD TRectangle
{
public:
	int Left;
	int Top;
	int Width;
	int Height;
};


enum DECLSPEC_DENUM TTransType : unsigned char { ttScaleX, ttScaleY, ttScaleZ, ttShearXY, ttShearXZ, ttShearYZ, ttRotateX, ttRotateY, ttRotateZ, ttTranslateX, ttTranslateY, ttTranslateZ, ttPerspectiveX, ttPerspectiveY, ttPerspectiveZ, ttPerspectiveW };

typedef System::StaticArray<System::Extended, 16> TTransformations;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TAffineFltVector XVector;
extern DELPHI_PACKAGE TAffineFltVector YVector;
extern DELPHI_PACKAGE TAffineFltVector ZVector;
extern DELPHI_PACKAGE TAffineFltVector NullVector;
extern DELPHI_PACKAGE THomogeneousFltMatrix IdentityMatrix;
extern DELPHI_PACKAGE THomogeneousFltMatrix EmptyMatrix;
static const double EPSILON = 1.000000E-100;
static const double EPSILON2 = 1.000000E-50;
extern DELPHI_PACKAGE bool __fastcall PointInPolygon(const float *xp, const int xp_High, const float *yp, const int yp_High, const float x, const float y);
extern DELPHI_PACKAGE TQuaternion __fastcall QuaternionMultiply(const TQuaternion &qL, const TQuaternion &qR);
extern DELPHI_PACKAGE float __fastcall VectorDotProduct(const THomogeneousFltVector &V1, const THomogeneousFltVector &V2);
extern DELPHI_PACKAGE float __fastcall VectorAffineDotProduct(const TAffineFltVector &V1, const TAffineFltVector &V2);
extern DELPHI_PACKAGE float __fastcall MatrixAffineDeterminant(const TAffineFltMatrix &M);
extern DELPHI_PACKAGE void __fastcall MatrixAdjoint(THomogeneousFltMatrix &M);
extern DELPHI_PACKAGE float __fastcall MatrixDeterminant(const THomogeneousFltMatrix &M);
extern DELPHI_PACKAGE void __fastcall MatrixScale(THomogeneousFltMatrix &M, const float Factor);
extern DELPHI_PACKAGE void __fastcall MatrixInvert(THomogeneousFltMatrix &M);
extern DELPHI_PACKAGE void __fastcall MatrixTranspose(THomogeneousFltMatrix &M);
extern DELPHI_PACKAGE void __fastcall MatrixAffineTranspose(TAffineFltMatrix &M);
}	/* namespace Teegeometry */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGEOMETRY)
using namespace Vcltee::Teegeometry;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegeometryHPP
