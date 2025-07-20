// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeClustering.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeclusteringHPP
#define Vcltee_TeeclusteringHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeclustering
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFastList;
class DELPHICLASS TCluster;
class DELPHICLASS TClusterProvider;
struct TClusterEvaluation;
class DELPHICLASS TBaseClustering;
class DELPHICLASS TFloatList;
struct TMatrixItem;
class DELPHICLASS TMatrix;
class DELPHICLASS TMatrixList;
class DELPHICLASS THierarchicalClustering;
class DELPHICLASS TKMeansClustering;
struct TDistance;
class DELPHICLASS TQTClustering;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<void *, 134217727> TPointerList;

typedef TPointerList *PPointerList;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFastList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	void * operator[](int Index) { return this->Items[Index]; }
	
private:
	int FCapacity;
	int FCount;
	TPointerList *List;
	void * __fastcall Get(int Index);
	void __fastcall Grow();
	void __fastcall SetCapacity(const int NewCapacity);
	
public:
	__fastcall virtual ~TFastList();
	void __fastcall Add(const void * Item);
	virtual void __fastcall Clear();
	void __fastcall Delete(const int Index);
	__property int Count = {read=FCount, nodefault};
	__property void * Items[int Index] = {read=Get/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TFastList() : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCluster : public TFastList
{
	typedef TFastList inherited;
	
public:
	TCluster* operator[](int Index) { return this->Item[Index]; }
	
private:
	bool Flag;
	HIDESBASE TCluster* __fastcall Get(int Index);
	
protected:
	bool OwnsData;
	
public:
	void *Data;
	__fastcall TCluster(bool AOwnsData);
	__fastcall virtual ~TCluster();
	TCluster* __fastcall AddItem(const void * AData, const bool AOwnsData = false);
	virtual void __fastcall Clear();
	__property TCluster* Item[int Index] = {read=Get/*, default*/};
};

#pragma pack(pop)

typedef System::DynamicArray<float> TSingleArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TClusterProvider : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual void __fastcall BeginClustering();
	virtual float __fastcall CalcDistanceData(const int A, const int B) = 0 /* overload */;
	virtual float __fastcall CalcDistanceData(TCluster* const A, TCluster* const B) = 0 /* overload */;
	virtual float __fastcall CalcDistanceData(const int A, TCluster* const B) = 0 /* overload */;
	virtual void * __fastcall CloneData(const void * AData) = 0 /* overload */;
	void * __fastcall EmptyData();
	virtual void __fastcall EndClustering();
	virtual void * __fastcall GetData(const int Index) = 0 ;
	virtual void __fastcall RecalcValues(TCluster* const ACluster) = 0 ;
	virtual int __fastcall SourceCount() = 0 ;
public:
	/* TObject.Create */ inline __fastcall TClusterProvider() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TClusterProvider() { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TClusterEvaluation
{
public:
	double DaviesBouldin;
	double Dunn;
};


enum DECLSPEC_DENUM TLinkageMethod : unsigned char { lmNone, lmSingle, lmComplete, lmAverage, lmWard };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBaseClustering : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
	
private:
	typedef System::DynamicArray<TSingleArray> _TBaseClustering__1;
	
	
private:
	TLinkageMethod FLinkage;
	int FThreads;
	TClusterProvider* FProvider;
	int SourceCount;
	_TBaseClustering__1 Matrix;
	void __fastcall BuildMatrix();
	void __fastcall CalcMatrix(int Index);
	
protected:
	float __fastcall CalcDistance(TCluster* const A, TCluster* const B);
	
public:
	TCluster* Clusters;
	__fastcall virtual TBaseClustering(TClusterProvider* const AProvider);
	__fastcall virtual ~TBaseClustering();
	virtual TCluster* __fastcall Execute();
	__classmethod bool __fastcall IsUndefined(TCluster* const ACluster);
	__classmethod TClusterEvaluation __fastcall Evaluation(TClusterProvider* AProvider, TCluster* ACluster);
	__property int Threads = {read=FThreads, write=FThreads, default=1};
	
__published:
	__property TLinkageMethod Linkage = {read=FLinkage, write=FLinkage, default=0};
	__property TClusterProvider* Provider = {read=FProvider};
};

#pragma pack(pop)

typedef System::StaticArray<float, 134217727> TSingleList;

typedef TSingleList *PSingleList;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFloatList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	float operator[](int Index) { return this->Items[Index]; }
	
private:
	int FCapacity;
	int FCount;
	TSingleList *List;
	float __fastcall Get(int Index);
	void __fastcall Grow();
	void __fastcall SetCapacity(const int NewCapacity);
	
public:
	__fastcall virtual ~TFloatList();
	void __fastcall Add(const float Item);
	virtual void __fastcall Clear();
	void __fastcall Delete(const int Index);
	__property int Count = {read=FCount, nodefault};
	__property float Items[int Index] = {read=Get/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TFloatList() : System::TObject() { }
	
};

#pragma pack(pop)

typedef TMatrixItem *PMatrixItem;

struct DECLSPEC_DRECORD TMatrixItem
{
public:
	float Value;
	TMatrixItem *Next;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TMatrix : public TFloatList
{
	typedef TFloatList inherited;
	
private:
	float Min;
	int MinIndex;
	bool NeedsRecalcMin;
	void __fastcall RecalcMin();
	
public:
	virtual void __fastcall Clear();
public:
	/* TFloatList.Destroy */ inline __fastcall virtual ~TMatrix() { }
	
public:
	/* TObject.Create */ inline __fastcall TMatrix() : TFloatList() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMatrixList : public TFastList
{
	typedef TFastList inherited;
	
public:
	virtual void __fastcall Clear();
public:
	/* TFastList.Destroy */ inline __fastcall virtual ~TMatrixList() { }
	
public:
	/* TObject.Create */ inline __fastcall TMatrixList() : TFastList() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION THierarchicalClustering : public TBaseClustering
{
	typedef TBaseClustering inherited;
	
private:
	int FCount;
	TMatrixList* Matrices;
	HIDESBASE void __fastcall BuildMatrix(int Index);
	
public:
	__fastcall virtual THierarchicalClustering(TClusterProvider* const AProvider);
	virtual TCluster* __fastcall Execute();
	
__published:
	__property int NumClusters = {read=FCount, write=FCount, default=5};
public:
	/* TBaseClustering.Destroy */ inline __fastcall virtual ~THierarchicalClustering() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TKMeansClustering : public TBaseClustering
{
	typedef TBaseClustering inherited;
	
private:
	int FKCount;
	int FMaxIter;
	
public:
	__fastcall virtual TKMeansClustering(TClusterProvider* const AProvider);
	virtual TCluster* __fastcall Execute();
	
__published:
	__property int NumClusters = {read=FKCount, write=FKCount, default=5};
	__property int MaxIterations = {read=FMaxIter, write=FMaxIter, default=1000};
public:
	/* TBaseClustering.Destroy */ inline __fastcall virtual ~TKMeansClustering() { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TDistance
{
public:
	int Index;
	float Value;
};


typedef System::DynamicArray<TDistance> TDistances;

class PASCALIMPLEMENTATION TQTClustering : public TBaseClustering
{
	typedef TBaseClustering inherited;
	
	
private:
	typedef System::DynamicArray<TDistances> _TQTClustering__1;
	
	
private:
	int FMinCount;
	double FMaxDiameter;
	_TQTClustering__1 Distances;
	void __fastcall SortedDists(int n);
	
public:
	__fastcall virtual TQTClustering(TClusterProvider* const AProvider);
	virtual TCluster* __fastcall Execute();
	
__published:
	__property int MinCount = {read=FMinCount, write=FMinCount, default=1};
	__property double MaxDiameter = {read=FMaxDiameter, write=FMaxDiameter};
public:
	/* TBaseClustering.Destroy */ inline __fastcall virtual ~TQTClustering() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeclustering */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECLUSTERING)
using namespace Vcltee::Teeclustering;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeclusteringHPP
