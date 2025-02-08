// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDckStyles.pas' rev: 31.00 (Windows)

#ifndef LmddckstylesHPP
#define LmddckstylesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.GraphUtil.hpp>
#include <System.StrUtils.hpp>
#include <System.TypInfo.hpp>
#include <System.Math.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.Themes.hpp>
#include <System.Win.Registry.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDHashTable.hpp>
#include <LMDStrings.hpp>
#include <LMDXML.hpp>
#include <LMDDckClass.hpp>
#include <LMDDckCst.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddckstyles
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDDockStyles;
class DELPHICLASS TLMDStyleObject;
class DELPHICLASS TLMDValueObject;
class DELPHICLASS TLMDMargins;
class DELPHICLASS TLMDRegion;
class DELPHICLASS ELMDColor;
__interface ILMDColor;
typedef System::DelphiInterface<ILMDColor> _di_ILMDColor;
struct TLMDColorVal;
struct TLMDTokenData;
class DELPHICLASS TLMDColor;
class DELPHICLASS TLMDBufferCanvas;
class DELPHICLASS TLMDBuffer;
struct TLMDGetStateClassData;
class DELPHICLASS TLMDStateLayer;
class DELPHICLASS TLMDEmptyLayer;
class DELPHICLASS TLMDColorLayer;
struct TLMDStretchSizes;
class DELPHICLASS TLMDRegionLayerBase;
class DELPHICLASS TLMDStretchLayer;
class DELPHICLASS TLMDCenterLayer;
class DELPHICLASS TLMDTileLayer;
class DELPHICLASS TLMDMyLayer;
class DELPHICLASS TLMDElemState;
class DELPHICLASS TLMDStyleColor;
class DELPHICLASS TLMDStyleElem;
class DELPHICLASS TLMDElemSet;
class DELPHICLASS TLMDStyleSource;
class DELPHICLASS TLMDFileSource;
class DELPHICLASS TLMDResourceSource;
class DELPHICLASS TLMDDockStyle;
class DELPHICLASS TLMDRegisteredSource;
class DELPHICLASS TLMDDockStyles;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDDockStyles : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDDockStyles(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDDockStyles(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDockStyles(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDockStyles(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDockStyles(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDockStyles(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDDockStyles(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDDockStyles(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDockStyles(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDockStyles(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDockStyles(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDockStyles(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDDockStyles(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDStateLayerClass;

typedef System::TMetaClass* TLMDStyleElemClass;

typedef System::TMetaClass* TLMDElemSetClass;

typedef void __fastcall (__closure *TLMDEnumPropProc)(System::Typinfo::PPropInfo AProp, void * AData);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStyleObject : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall EnumProps(TLMDEnumPropProc AProc, void * AData);
public:
	/* TObject.Create */ inline __fastcall TLMDStyleObject(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStyleObject(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDValType : unsigned char { vtString, vtNode };

typedef Lmdxml::_di_ILMDXmlElement __fastcall (__closure *TLMDNodeGetter)(void);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDValueObject : public TLMDStyleObject
{
	typedef TLMDStyleObject inherited;
	
protected:
	virtual TLMDValType __fastcall Write(void *V) = 0 ;
	virtual bool __fastcall Read(TLMDValType AType, const void *V) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDValueObject(void) : TLMDStyleObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDValueObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMargins : public TLMDValueObject
{
	typedef TLMDValueObject inherited;
	
private:
	TLMDMargins* FNext;
	int FRight;
	int FBottom;
	int FTop;
	int FLeft;
	Lmdtypes::TLMDString __fastcall GetAsString(void);
	void __fastcall SetAsString(const Lmdtypes::TLMDString Value);
	
protected:
	virtual TLMDValType __fastcall Write(void *V);
	virtual bool __fastcall Read(TLMDValType AType, const void *V);
	
public:
	System::Types::TRect __fastcall AdjustRect(const System::Types::TRect &R);
	System::Types::TSize __fastcall AdjustSize(const System::Types::TRect &R)/* overload */;
	System::Types::TSize __fastcall AdjustSize(const System::Types::TSize &ASize)/* overload */;
	System::Types::TSize __fastcall AdjustSize(int AWidth, int AHeight)/* overload */;
	System::Types::TRect __fastcall UnadjustRect(const System::Types::TRect &R);
	System::Types::TSize __fastcall UnadjustSize(const System::Types::TRect &R)/* overload */;
	System::Types::TSize __fastcall UnadjustSize(const System::Types::TSize &ASize)/* overload */;
	System::Types::TSize __fastcall UnadjustSize(int AWidth, int AHeight)/* overload */;
	bool __fastcall IsEqualTo(TLMDMargins* M);
	__property Lmdtypes::TLMDString AsString = {read=GetAsString, write=SetAsString};
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property int Right = {read=FRight, write=FRight, nodefault};
	__property int Bottom = {read=FBottom, write=FBottom, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDMargins(void) : TLMDValueObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDMargins(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegion : public TLMDValueObject
{
	typedef TLMDValueObject inherited;
	
private:
	System::Types::TRect FRect;
	int __fastcall GetInt(const int Index);
	void __fastcall SetInt(const int Index, const int Value);
	
protected:
	virtual TLMDValType __fastcall Write(void *V);
	virtual bool __fastcall Read(TLMDValType AType, const void *V);
	
public:
	bool __fastcall IsEmpty(void);
	__property System::Types::TRect Rect = {read=FRect, write=FRect};
	__property int Left = {read=GetInt, write=SetInt, index=0, nodefault};
	__property int Top = {read=GetInt, write=SetInt, index=1, nodefault};
	__property int Right = {read=GetInt, write=SetInt, index=2, nodefault};
	__property int Bottom = {read=GetInt, write=SetInt, index=3, nodefault};
	__property int Width = {read=GetInt, index=4, nodefault};
	__property int Height = {read=GetInt, index=5, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDRegion(void) : TLMDValueObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRegion(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDColor : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDColor(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDColor(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDColor(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDColor(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDColor(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDColor(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDColor(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDColor(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDColor(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDColor(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDColor(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDColor(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDColor(void) { }
	
};

#pragma pack(pop)

__interface ILMDColor  : public System::IInterface 
{
	virtual System::Uitypes::TColor __fastcall Get(void) = 0 ;
};

struct DECLSPEC_DRECORD TLMDColorVal
{
public:
	System::Uitypes::TColor Simple;
	_di_ILMDColor Complex;
};


typedef void __fastcall (__closure *TLMDEnumProc)(void * AData, const Lmdtypes::TLMDString AName, int AValue);

enum DECLSPEC_DENUM TLMDColorToken : unsigned char { ctIdent, ctInteger, ctOpenRound, ctCloseRound, ctComma, ctEof };

struct DECLSPEC_DRECORD TLMDTokenData
{
public:
	Lmdtypes::TLMDString S;
	int I;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDColor : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
	
private:
	typedef System::DynamicArray<System::Byte> _TLMDColor__1;
	
	
private:
	_TLMDColor__1 FByteCode;
	Vcl::Themes::TThemedElementDetails __fastcall GetDetails(Vcl::Themes::TThemedElement AElem, int APart);
	__classmethod void __fastcall GetEnumNames(System::Typinfo::PTypeInfo AEnum, TLMDEnumProc AProc, void * AData);
	System::PByte __fastcall Grow(int ASize);
	void __fastcall EmitByte(System::Byte V);
	void __fastcall EmitInt(int V);
	void __fastcall Emit(const void *V, int ASize);
	void __fastcall Compile(System::WideChar * &P);
	System::Uitypes::TColor __fastcall Interpret(System::PByte &P);
	bool __fastcall IsSimple(/* out */ System::Uitypes::TColor &C);
	__classmethod void __fastcall AddIdent(const void *KI);
	__classmethod void __fastcall AddStyleColor(void * AData, const Lmdtypes::TLMDString AName, int AValue);
	__classmethod void __fastcall AddFontColor(void * AData, const Lmdtypes::TLMDString AName, int AValue);
	__classmethod void __fastcall AddElemPart(void * AData, const Lmdtypes::TLMDString AName, int AValue);
	__classmethod void __fastcall AddElemColor(void * AData, const Lmdtypes::TLMDString AName, int AValue);
	__classmethod void __fastcall AddElemParts(Vcl::Themes::TThemedElement AElem, System::Typinfo::PTypeInfo AParts);
	__classmethod void __fastcall AddHighlight();
	__classmethod void __fastcall AddShadow();
	__classmethod void __fastcall AddBlend();
	__classmethod void __fastcall AddAccent();
	__classmethod void __fastcall AddAccentText();
	__classmethod void __fastcall InitKnownIdents();
	__classmethod bool __fastcall TryGetKnownIdent(const Lmdtypes::TLMDString S, /* out */ void *KI);
	__classmethod void __fastcall SyntaxError();
	__classmethod int __fastcall MakeInteger(System::WideChar * S, System::WideChar * E);
	__classmethod TLMDColorToken __fastcall NextToken(System::WideChar * &P, TLMDTokenData &AData);
	__classmethod void __fastcall CheckAndSkip(System::WideChar * &P, TLMDColorToken AToken)/* overload */;
	__classmethod void __fastcall CheckAndSkip(System::WideChar * &P, TLMDColorToken AToken, TLMDTokenData &AData)/* overload */;
	
protected:
	System::Uitypes::TColor __fastcall Get(void)/* overload */;
	
public:
	__classmethod TLMDColorVal __fastcall Make(System::Uitypes::TColor C)/* overload */;
	__classmethod TLMDColorVal __fastcall Make(Vcl::Themes::TStyleColor C)/* overload */;
	__classmethod TLMDColorVal __fastcall Make(Vcl::Themes::TStyleFont C)/* overload */;
	__classmethod TLMDColorVal __fastcall Make(Vcl::Themes::TThemedElement AElem, int APart, Vcl::Themes::TElementColor C)/* overload */;
	__classmethod TLMDColorVal __fastcall Parse(const Lmdtypes::TLMDString S);
	__classmethod System::Uitypes::TColor __fastcall Get(const TLMDColorVal &C)/* overload */;
	__classmethod void __fastcall BeginSetProp(const TLMDColorVal &C, /* out */ System::Uitypes::TColor &V)/* overload */;
	__classmethod void __fastcall BeginSetProp(const Lmdtypes::TLMDString S, /* out */ System::Uitypes::TColor &V)/* overload */;
	__classmethod void __fastcall PropSetter(TLMDColorVal &C, System::Uitypes::TColor V);
	__classmethod void __fastcall EndSetProp();
public:
	/* TObject.Create */ inline __fastcall TLMDColor(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDColor(void) { }
	
private:
	void *__ILMDColor;	// ILMDColor 
	
public:
	operator ILMDColor*(void) { return (ILMDColor*)&__ILMDColor; }
	
};

#pragma pack(pop)

typedef System::StaticArray<unsigned, 1025> TLMDPixels;

typedef TLMDPixels *PLMDPixels;

class PASCALIMPLEMENTATION TLMDBufferCanvas : public Vcl::Graphics::TCanvas
{
	typedef Vcl::Graphics::TCanvas inherited;
	
private:
	HDC FDC;
	HBITMAP FDefDIB;
	TLMDBuffer* FSelected;
	HDC __fastcall GetDC(void);
	void __fastcall FreeDC(void);
	
protected:
	void __fastcall DoSelect(void);
	virtual void __fastcall CreateHandle(void);
	
public:
	__fastcall TLMDBufferCanvas(void)/* overload */;
	__fastcall TLMDBufferCanvas(TLMDBuffer* ABuffer)/* overload */;
	__fastcall virtual ~TLMDBufferCanvas(void);
	void __fastcall Select(TLMDBuffer* ABuffer);
	__property TLMDBuffer* Selected = {read=FSelected};
	__property HDC DC = {read=GetDC, nodefault};
};


enum DECLSPEC_DENUM TLMDBufferFormat : unsigned char { bf24bit, bf32bit };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDBufferFormat FFormat;
	int FWidth;
	int FHeight;
	TLMDBufferCanvas* FSelectedIn;
	TLMDBufferCanvas* FDefCanvas;
	HBITMAP FDIB;
	TLMDPixels *FData;
	int FOldSize;
	void __fastcall RecreateDIB(void);
	void __fastcall FinalizeDIB(void);
	void __fastcall AdjustStatistic(void);
	
protected:
	virtual Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	
public:
	__fastcall TLMDBuffer(TLMDBufferFormat AFormat)/* overload */;
	__fastcall TLMDBuffer(int AWidth, int AHeight, TLMDBufferFormat AFormat)/* overload */;
	__fastcall virtual ~TLMDBuffer(void);
	__classmethod void __fastcall BeginDraw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R);
	__classmethod void __fastcall EndDraw();
	__classmethod int __fastcall Allocated();
	__classmethod int __fastcall MaxAllocated();
	void __fastcall Resize(int AWidth, int AHeight);
	PLMDPixels __fastcall ScanLine(int ALine);
	__property TLMDBufferFormat Format = {read=FFormat, nodefault};
	__property int Width = {read=FWidth, nodefault};
	__property int Height = {read=FHeight, nodefault};
	__property HBITMAP DIB = {read=FDIB, nodefault};
	__property PLMDPixels Data = {read=FData};
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRegionOpacity : unsigned char { roEmpty, roTranslucent, roOpaque };

enum DECLSPEC_DENUM TLMDDrawMode : unsigned char { dmBlt, dmBlend };

typedef void __fastcall (__closure *TLMDGetStateClassProc)(TLMDStateLayerClass AClass, void * AData);

struct DECLSPEC_DRECORD TLMDGetStateClassData
{
public:
	Lmdtypes::TLMDString SType;
	TLMDStateLayerClass Result;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStateLayer : public TLMDStyleObject
{
	typedef TLMDStyleObject inherited;
	
private:
	TLMDStateLayer* FNext;
	TLMDElemState* FState;
	int FId;
	TLMDRegionOpacity FOpacity;
	bool FUpdated;
	bool __fastcall LayerTypeFilter(const Lmdtypes::TLMDString AName);
	void __fastcall Write(const Lmdxml::_di_ILMDXmlElement ANode);
	void __fastcall Read(const Lmdxml::_di_ILMDXmlElement ANode);
	__classmethod void __fastcall GetClassProc(TLMDStateLayerClass AClass, void * AData);
	
protected:
	virtual void __fastcall InvaidateDrawInfo(void);
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void) = 0 ;
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode) = 0 ;
	TLMDBuffer* __fastcall GetMaster(void);
	Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	TLMDRegionOpacity __fastcall MasterOpacity(const System::Types::TRect &R);
	void __fastcall FillEmptyRect(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R);
	
public:
	__fastcall virtual TLMDStateLayer(TLMDElemState* AState);
	__fastcall virtual ~TLMDStateLayer(void);
	__classmethod Lmdtypes::TLMDString __fastcall GetType();
	__classmethod TLMDStateLayerClass __fastcall GetClass(const Lmdtypes::TLMDString AType);
	__classmethod void __fastcall GetLayerClasses(void * AData, TLMDGetStateClassProc AProc);
	__property TLMDElemState* State = {read=FState};
	__property int Id = {read=FId, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEmptyLayer : public TLMDStateLayer
{
	typedef TLMDStateLayer inherited;
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
public:
	/* TLMDStateLayer.Create */ inline __fastcall virtual TLMDEmptyLayer(TLMDElemState* AState) : TLMDStateLayer(AState) { }
	/* TLMDStateLayer.Destroy */ inline __fastcall virtual ~TLMDEmptyLayer(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDColorLayer : public TLMDStateLayer
{
	typedef TLMDStateLayer inherited;
	
private:
	TLMDColorVal FColor;
	System::Byte FAlpha;
	TLMDBuffer* FPattern;
	HBRUSH FBrush;
	System::Uitypes::TColor __fastcall GetColor(void);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
	
public:
	__fastcall virtual TLMDColorLayer(TLMDElemState* AState);
	__fastcall virtual ~TLMDColorLayer(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property System::Byte Alpha = {read=FAlpha, write=FAlpha, nodefault};
};

#pragma pack(pop)

typedef System::Int8 TLMDStretchZone;

typedef System::Set<TLMDStretchZone, 0, 8> TLMDStretchZones;

struct DECLSPEC_DRECORD TLMDStretchSizes
{
	
public:
	union
	{
		struct 
		{
			int LM;
			int X1;
			int RM;
			int TM;
			int Y1;
			int BM;
		};
		struct 
		{
			System::StaticArray<int, 3> CX;
			System::StaticArray<int, 3> CY;
		};
		
	};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegionLayerBase : public TLMDStateLayer
{
	typedef TLMDStateLayer inherited;
	
private:
	TLMDRegion* FRegion;
	TLMDBuffer* FRecolored;
	TLMDColorVal FRecolorFrom;
	TLMDColorVal FRecolorTo;
	System::Uitypes::TColor __fastcall GetRecolorFrom(void);
	void __fastcall SetRecolorFrom(const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetRecolorTo(void);
	void __fastcall SetRecolorTo(const System::Uitypes::TColor Value);
	
protected:
	virtual void __fastcall InvaidateDrawInfo(void);
	TLMDBuffer* __fastcall Recolor(System::Uitypes::TColor AFrom, System::Uitypes::TColor ATo);
	Vcl::Graphics::TCanvas* __fastcall RecoloredCanvas(void);
	
public:
	__fastcall virtual TLMDRegionLayerBase(TLMDElemState* AState);
	__fastcall virtual ~TLMDRegionLayerBase(void);
	
__published:
	__property TLMDRegion* Region = {read=FRegion};
	__property System::Uitypes::TColor RecolorFrom = {read=GetRecolorFrom, write=SetRecolorFrom, nodefault};
	__property System::Uitypes::TColor RecolorTo = {read=GetRecolorTo, write=SetRecolorTo, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStretchLayer : public TLMDRegionLayerBase
{
	typedef TLMDRegionLayerBase inherited;
	
private:
	TLMDMargins* FStretchMargins;
	TLMDStretchSizes FSrcSizes;
	System::StaticArray<TLMDRegionOpacity, 9> FZnOpacity;
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	TLMDStretchSizes __fastcall GetSizes(int AWidth, int AHeight, int LM, int TM, int RM, int BM);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
	
public:
	__fastcall virtual TLMDStretchLayer(TLMDElemState* AState);
	__fastcall virtual ~TLMDStretchLayer(void);
	
__published:
	__property TLMDMargins* StretchMargins = {read=FStretchMargins};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCenterLayer : public TLMDRegionLayerBase
{
	typedef TLMDRegionLayerBase inherited;
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
public:
	/* TLMDRegionLayerBase.Create */ inline __fastcall virtual TLMDCenterLayer(TLMDElemState* AState) : TLMDRegionLayerBase(AState) { }
	/* TLMDRegionLayerBase.Destroy */ inline __fastcall virtual ~TLMDCenterLayer(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTileLayer : public TLMDRegionLayerBase
{
	typedef TLMDRegionLayerBase inherited;
	
private:
	TLMDBuffer* FPattern;
	HBRUSH FBrush;
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
	
public:
	__fastcall virtual TLMDTileLayer(TLMDElemState* AState);
	__fastcall virtual ~TLMDTileLayer(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMyLayer : public TLMDStateLayer
{
	typedef TLMDStateLayer inherited;
	
protected:
	virtual TLMDRegionOpacity __fastcall UpdateDrawInfo(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* C, const System::Types::TRect &R, TLMDDrawMode AMode);
public:
	/* TLMDStateLayer.Create */ inline __fastcall virtual TLMDMyLayer(TLMDElemState* AState) : TLMDStateLayer(AState) { }
	/* TLMDStateLayer.Destroy */ inline __fastcall virtual ~TLMDMyLayer(void) { }
	
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TLMDLayerFilter)(TLMDStateLayer* L, void * AData);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDElemState : public TLMDValueObject
{
	typedef TLMDValueObject inherited;
	
public:
	TLMDStateLayer* operator[](int AIndex) { return this->Layers[AIndex]; }
	
private:
	TLMDElemState* FNext;
	TLMDStyleElem* FElem;
	int FId;
	TLMDStateLayer* FLayers;
	TLMDDockStyle* __fastcall GetStyle(void);
	int __fastcall GetLayerCount(void);
	TLMDStateLayer* __fastcall GetLayers(int AIndex);
	TLMDStateLayer* __fastcall GetFirst(void);
	TLMDStateLayer* __fastcall GetLast(void);
	void __fastcall InsertLayer(TLMDStateLayer* AItem, int AIndex);
	void __fastcall RemoveLayer(TLMDStateLayer* AItem);
	HRGN __fastcall RegionFromBuffer(TLMDBuffer* B, const System::Types::TRect &R);
	void __fastcall DoDraw(Vcl::Graphics::TCanvas* C, TLMDDrawMode AMode, const System::Types::TRect &R, TLMDStateLayer* L = (TLMDStateLayer*)(0x0));
	void __fastcall InvaidateDrawInfo(void);
	
protected:
	virtual TLMDValType __fastcall Write(void *V);
	virtual bool __fastcall Read(TLMDValType AType, const void *V);
	
public:
	__fastcall TLMDElemState(TLMDStyleElem* AElem);
	__fastcall virtual ~TLMDElemState(void);
	TLMDRegionOpacity __fastcall Opacity(void);
	void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R);
	void __fastcall DrawLayer(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R, TLMDStateLayer* L);
	HRGN __fastcall MakeRegion(const System::Types::TRect &R);
	void __fastcall Clear(void);
	TLMDStateLayer* __fastcall Add(TLMDStateLayerClass AClass);
	void __fastcall AddLayers(System::Classes::TStream* AStream);
	void __fastcall MoveLayer(int AFrom, int ATo);
	TLMDStateLayer* __fastcall LayerById(int AId);
	void __fastcall LayersToStream(System::Classes::TStream* AStream, TLMDLayerFilter AFilter, void * AData);
	__property int Id = {read=FId, nodefault};
	__property int LayerCount = {read=GetLayerCount, nodefault};
	__property TLMDStateLayer* Layers[int AIndex] = {read=GetLayers/*, default*/};
	__property TLMDStateLayer* First = {read=GetFirst};
	__property TLMDStateLayer* Last = {read=GetLast};
	__property TLMDStyleElem* Elem = {read=FElem};
	__property TLMDDockStyle* Style = {read=GetStyle};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStyleColor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDStyleColor* FNext;
	TLMDColorVal FColor;
public:
	/* TObject.Create */ inline __fastcall TLMDStyleColor(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStyleColor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStyleElem : public TLMDStyleObject
{
	typedef TLMDStyleObject inherited;
	
private:
	TLMDDockStyle* FStyle;
	TLMDElemState* FStates;
	TLMDMargins* FMargins;
	TLMDStyleColor* FColors;
	void __fastcall InvalidateDrawInfo(void);
	TLMDStyleColor* __fastcall GetColorItem(int AIndex);
	
protected:
	virtual void __fastcall Write(const Lmdxml::_di_ILMDXmlElement ANode);
	virtual void __fastcall Read(const Lmdxml::_di_ILMDXmlElement ANode);
	TLMDElemState* __fastcall GetState(const int Index);
	TLMDMargins* __fastcall GetMargins(const int Index);
	System::Uitypes::TColor __fastcall GetColor(const int Index);
	void __fastcall SetColor(const int Index, System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TLMDStyleElem(TLMDDockStyle* AStyle);
	__fastcall virtual ~TLMDStyleElem(void);
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetName();
	__property TLMDDockStyle* Style = {read=FStyle};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDElemSetChange : unsigned char { escProps, escBitmap, escReloaded };

typedef System::Set<TLMDElemSetChange, TLMDElemSetChange::escProps, TLMDElemSetChange::escReloaded> TLMDElemSetChanges;

typedef void __fastcall (__closure *TLMDElemSetChanged)(System::TObject* Sender, TLMDElemSetChanges AChanges);

class PASCALIMPLEMENTATION TLMDElemSet : public TLMDStyleObject
{
	typedef TLMDStyleObject inherited;
	
private:
	TLMDDockStyle* FStyle;
	TLMDElemSetChanged FOnChange;
	void __fastcall SetStyle(TLMDDockStyle* const Value);
	void __fastcall AssignElemProc(System::Typinfo::PPropInfo AProp, void * AData);
	void __fastcall AssignElems(void);
	
protected:
	virtual void __fastcall Changed(TLMDElemSetChanges AChanges);
	
public:
	__fastcall TLMDElemSet(void)/* overload */;
	__fastcall TLMDElemSet(TLMDDockStyle* AStyle)/* overload */;
	__property TLMDDockStyle* Style = {read=FStyle, write=SetStyle};
	__property TLMDElemSetChanged OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDElemSet(void) { }
	
};


enum DECLSPEC_DENUM TLMDStyleDataKind : unsigned char { sdkXml, sdkBmp };

typedef void __fastcall (__closure *TLMDStyleSourceProc)(TLMDStyleDataKind AKind, System::Classes::TStream* AStream);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStyleSource : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual void __fastcall Read(TLMDStyleSourceProc AProc) = 0 ;
	virtual void __fastcall Write(TLMDStyleSourceProc AProc) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDStyleSource(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStyleSource(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileSource : public TLMDStyleSource
{
	typedef TLMDStyleSource inherited;
	
private:
	Lmdtypes::TLMDString FFileName;
	void __fastcall CallProc(TLMDStyleDataKind AKind, System::Word AMode, TLMDStyleSourceProc AProc);
	
protected:
	virtual void __fastcall Read(TLMDStyleSourceProc AProc);
	virtual void __fastcall Write(TLMDStyleSourceProc AProc);
	
public:
	__fastcall TLMDFileSource(const Lmdtypes::TLMDString AFileName);
	__property Lmdtypes::TLMDString FileName = {read=FFileName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFileSource(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDResourceSource : public TLMDStyleSource
{
	typedef TLMDStyleSource inherited;
	
private:
	Lmdtypes::TLMDString FResName;
	void __fastcall CallProc(TLMDStyleDataKind AKind, TLMDStyleSourceProc AProc);
	
protected:
	virtual void __fastcall Read(TLMDStyleSourceProc AProc);
	virtual void __fastcall Write(TLMDStyleSourceProc AProc);
	
public:
	__fastcall TLMDResourceSource(const Lmdtypes::TLMDString AResName);
	__property Lmdtypes::TLMDString ResName = {read=FResName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDResourceSource(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmddckstyles__52 : unsigned char { dssLoading, dssValid, dssReloaded, dssBitmapChanged };

typedef System::Set<Lmddckstyles__52, Lmddckstyles__52::dssLoading, Lmddckstyles__52::dssBitmapChanged> TLMDDockStyleState;

typedef Lmdtypes::TLMDString TLMDStyleName;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockStyle : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDockStyleState FState;
	TLMDDockStyles* FStyles;
	TLMDStyleName FName;
	TLMDStyleSource* FLazy;
	bool FOwnLazy;
	Lmdxml::_di_ILMDXmlDocument FXml;
	Vcl::Graphics::TBitmap* FBitmap;
	TLMDBuffer* FMaster;
	System::Classes::TList* FElems;
	System::Classes::TList* FElemSets;
	void __fastcall ClearElems(void);
	void __fastcall InvalidateDrawInfo(void);
	Lmdxml::_di_ILMDXmlElement __fastcall CreateElemNode(TLMDStyleElem* AElem);
	void __fastcall InsertElemSet(TLMDElemSet* AElemSet);
	void __fastcall RemoveElemSet(TLMDElemSet* AElemSet);
	void __fastcall ReassignSetsElems(void);
	void __fastcall UpdateMaster(void);
	void __fastcall BitmapChanged(System::TObject* Sender);
	void __fastcall SaveProc(TLMDStyleDataKind AKind, System::Classes::TStream* AStream);
	void __fastcall LoadProc(TLMDStyleDataKind AKind, System::Classes::TStream* AStream);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* const Value);
	
public:
	__fastcall TLMDDockStyle(TLMDDockStyles* AStyles, const TLMDStyleName AName);
	__fastcall TLMDDockStyle(TLMDDockStyles* AStyles, const TLMDStyleName AName, TLMDStyleSource* ASource, bool AOwnSource);
	__fastcall virtual ~TLMDDockStyle(void);
	TLMDBuffer* __fastcall GetMaster(void);
	TLMDStyleElem* __fastcall GetElem(TLMDStyleElemClass AClass);
	void __fastcall Changed(void);
	void __fastcall Save(TLMDStyleSource* ASource);
	void __fastcall Load(TLMDStyleSource* ASource);
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromResource(const Lmdtypes::TLMDString AResName);
	__property TLMDStyleName Name = {read=FName};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegisteredSource : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDockStyles* FStyles;
	TLMDStyleName FName;
	bool FIsDefault;
	TLMDStyleSource* FSource;
	
public:
	__fastcall TLMDRegisteredSource(TLMDDockStyles* AStyles, const TLMDStyleName AName, bool AIsDefault, TLMDStyleSource* ASource);
	__fastcall virtual ~TLMDRegisteredSource(void);
	__property TLMDStyleName Name = {read=FName};
	__property bool IsDefault = {read=FIsDefault, nodefault};
	__property TLMDStyleSource* Source = {read=FSource};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockStyles : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDDockStyle* operator[](int AIndex) { return this->Style[AIndex]; }
	
private:
	System::Classes::TList* FStyles;
	System::Classes::TList* FRegSources;
	TLMDDockStyle* FDefaultStyle;
	System::Classes::TList* FDefinedSets;
	System::Classes::TList* FDefinedElems;
	int FNextId;
	System::TObject* FBitmapCache;
	void __fastcall InsertStyle(TLMDDockStyle* AStyle);
	void __fastcall RemoveStyle(TLMDDockStyle* AStyle);
	void __fastcall InsertRegSource(TLMDRegisteredSource* ASource);
	void __fastcall RemoveRegSource(TLMDRegisteredSource* ASource);
	bool __fastcall TryGetElemClass(const Lmdtypes::TLMDString AName, /* out */ TLMDStyleElemClass &AClass);
	void __fastcall DefineElemProc(System::Typinfo::PPropInfo AProp, void * AData);
	TLMDDockStyle* __fastcall EnsureLazyInit(TLMDDockStyle* AStyle);
	int __fastcall GetNextId(void);
	int __fastcall GetCount(void);
	TLMDDockStyle* __fastcall GetStyle(int AIndex);
	TLMDDockStyle* __fastcall GetDefaultStyle(void);
	int __fastcall GetRegSourceCount(void);
	TLMDRegisteredSource* __fastcall GetRegSources(int Index);
	TLMDRegisteredSource* __fastcall GetDefaultRegSource(void);
	
protected:
	void __fastcall VCLStyleChanged(void);
	
public:
	__fastcall TLMDDockStyles(void);
	__fastcall virtual ~TLMDDockStyles(void);
	void __fastcall Register(const TLMDStyleName AName, Lmdtypes::TLMDString AResName, bool ADefault = false);
	void __fastcall DefineElements(TLMDElemSetClass AElementSet);
	void __fastcall Changed(void);
	TLMDDockStyle* __fastcall Add(const TLMDStyleName AName)/* overload */;
	TLMDDockStyle* __fastcall Add(const TLMDStyleName AName, TLMDStyleSource* ASource)/* overload */;
	void __fastcall AddLazy(const TLMDStyleName AName, TLMDStyleSource* ASource, bool AOwnSource);
	bool __fastcall TryGetByName(const TLMDStyleName AName, /* out */ TLMDDockStyle* &AStyle);
	TLMDDockStyle* __fastcall GetByName(const TLMDStyleName AName);
	__property int Count = {read=GetCount, nodefault};
	__property TLMDDockStyle* DefaultStyle = {read=GetDefaultStyle};
	__property TLMDDockStyle* Style[int AIndex] = {read=GetStyle/*, default*/};
	__property int RegSourceCount = {read=GetRegSourceCount, nodefault};
	__property TLMDRegisteredSource* RegSources[int Index] = {read=GetRegSources};
	__property TLMDRegisteredSource* DefaultRegSource = {read=GetDefaultRegSource};
};

#pragma pack(pop)

typedef void __fastcall (*TLMDColorProc)(System::Uitypes::TColor &C);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDDockStyles* DockStyles;
extern DELPHI_PACKAGE TLMDColorProc OnGetAccent;
extern DELPHI_PACKAGE TLMDColorProc OnGetAccentText;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDAccent(void);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDAccentText(void);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDBlend(System::Uitypes::TColor ABase, System::Uitypes::TColor C, int Alpha);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDHighlight(System::Uitypes::TColor C, int Amount);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDShadow(System::Uitypes::TColor C, int Amount);
}	/* namespace Lmddckstyles */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDCKSTYLES)
using namespace Lmddckstyles;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddckstylesHPP
