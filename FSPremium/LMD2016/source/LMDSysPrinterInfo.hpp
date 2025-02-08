// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPrinterInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysprinterinfoHPP
#define LmdsysprinterinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.WinSpool.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysprinterinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrinterItem;
class DELPHICLASS TLMDPrintersInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysPrinterDisplayInfo : unsigned char { ppidDeviceName, ppidDriver, ppidComment, ppidLocation, ppidPort, ppidServer, ppidDataType, ppidPrintProcessor, ppidPrintProcessorParams, ppidSepFile, ppidStartTime, ppidUntilTime, ppidDriverVersion, ppidDuplex, ppidOrientation, ppidPaperSize, ppidQuality, ppidScale, ppidCopies, ppidTrueTypeOption, ppidCollate, ppidCustomXRes, ppidCustomYRes, ppidPaperLength, ppidPaperWidth, ppidValidFlags, ppidMonochrome, ppidAvailableBins, ppidDefaultBin };

typedef System::Set<TLMDSysPrinterDisplayInfo, TLMDSysPrinterDisplayInfo::ppidDeviceName, TLMDSysPrinterDisplayInfo::ppidDefaultBin> TLMDSysPrinterDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 29> Lmdsysprinterinfo__1;

enum DECLSPEC_DENUM TLMDPaperSize : unsigned char { psCustom, psLETTER, psLETTERSMALL, psTABLOID, psLEDGER, psLEGAL, psSTATEMENT, psEXECUTIVE, psA3, psA4, psA4SMALL, psA5, psB4, psB5, psFOLIO, psQUARTO, ps10X14, ps11X17, psNOTE, psENV_9, psENV_10, psENV_11, psENV_12, psENV_14, psCSHEET, psDSHEET, psESHEET, psENV_DL, psENV_C5, psENV_C3, psENV_C4, psENV_C6, psENV_C65, psENV_B4, psENV_B5, psENV_B6, psENV_ITALY, psENV_MONARCH, psENV_PERSONAL, psFANFOLD_US, psFANFOLD_STD_GERMAN, psFANFOLD_LGL_GERMAN };

enum DECLSPEC_DENUM TLMDPrinterOrientation : unsigned char { poPortrait, poLandscape };

enum DECLSPEC_DENUM TLMDPrintQuality : unsigned char { pqHigh, pqMedium, pqLow, pqDraft, pqCustom };

enum DECLSPEC_DENUM TLMDPrintDuplex : unsigned char { pdSimplex, pdHorizontal, psVertical };

enum DECLSPEC_DENUM TLMDPrintTTOption : unsigned char { poBitmap, poDownload, poSubDev };

enum DECLSPEC_DENUM TLMDPrintFlag : unsigned char { pfORIENTATION, pfPAPERSIZE, pfPAPERLENGTH, pfPAPERWIDTH, pfSCALE, pfCOPIES, pfPRINTQUALITY, pfCOLOR, pfDUPLEX, pfYRESOLUTION, pfTTOPTION, pfCOLLATE };

typedef System::Set<TLMDPrintFlag, TLMDPrintFlag::pfORIENTATION, TLMDPrintFlag::pfCOLLATE> TLMDPrintFlags;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPrinterItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	unsigned FDriverVersion;
	unsigned FStartTime;
	unsigned FUntilTime;
	System::UnicodeString FSepFile;
	System::UnicodeString FServerName;
	System::UnicodeString FDriverName;
	System::UnicodeString FComment;
	System::UnicodeString FLocation;
	System::UnicodeString FPort;
	System::UnicodeString FPrintProc;
	System::UnicodeString FDataType;
	System::UnicodeString FParams;
	System::UnicodeString FDefaultBin;
	System::UnicodeString FAvailableBins;
	System::UnicodeString FName;
	TLMDPrintDuplex FDuplex;
	TLMDPrinterOrientation FOrientation;
	TLMDPaperSize FPaperSize;
	short FPaperLength;
	short FPaperWidth;
	short FCustomXRes;
	short FCustomYRes;
	short FScale;
	short FCopies;
	TLMDPrintQuality FQuality;
	TLMDPrintTTOption FTTOption;
	bool FMonochrome;
	bool FCollate;
	TLMDPrintFlags FFlags;
	System::Classes::TStringList* FPaperBins;
	void __fastcall SetDummyString(System::UnicodeString aValue);
	void __fastcall SetDummyShort(short aValue);
	void __fastcall SetDummyBool(bool aValue);
	void __fastcall SetDummyTTOption(TLMDPrintTTOption aValue);
	void __fastcall SetDummyQuality(TLMDPrintQuality aValue);
	void __fastcall SetDummyPaperSize(TLMDPaperSize aValue);
	void __fastcall SetDummyOrientation(TLMDPrinterOrientation aValue);
	void __fastcall SetDummyDuplex(TLMDPrintDuplex aValue);
	void __fastcall SetDummyDWORD(unsigned aValue);
	System::UnicodeString __fastcall DuplexToStr(TLMDPrintDuplex aValue);
	System::UnicodeString __fastcall OrientationToStr(TLMDPrinterOrientation aValue);
	System::UnicodeString __fastcall PaperSizeToStr(TLMDPaperSize aValue);
	System::UnicodeString __fastcall QualityToStr(TLMDPrintQuality aValue);
	System::UnicodeString __fastcall TrueTypeOptionToStr(TLMDPrintTTOption aValue);
	System::UnicodeString __fastcall ValidFlagsToStr(TLMDPrintFlags aValue);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	TLMDSysPrinterDisplayInfos __fastcall GetDisplayInfo(void);
	
public:
	__fastcall virtual TLMDPrinterItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDPrinterItem(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property System::Classes::TStringList* PaperBins = {read=FPaperBins};
	
__published:
	__property System::UnicodeString DeviceName = {read=FName, write=SetDummyString, stored=false};
	__property System::UnicodeString Driver = {read=FDriverName, write=SetDummyString, stored=false};
	__property System::UnicodeString Comment = {read=FComment, write=SetDummyString, stored=false};
	__property System::UnicodeString Location = {read=FLocation, write=SetDummyString, stored=false};
	__property System::UnicodeString Port = {read=FPort, write=SetDummyString, stored=false};
	__property System::UnicodeString Server = {read=FServerName, write=SetDummyString, stored=false};
	__property System::UnicodeString DataType = {read=FDataType, write=SetDummyString, stored=false};
	__property System::UnicodeString PrintProcessor = {read=FPrintProc, write=SetDummyString, stored=false};
	__property System::UnicodeString PrintProcessorParams = {read=FParams, write=SetDummyString, stored=false};
	__property System::UnicodeString DefaultBin = {read=FDefaultBin, write=SetDummyString, stored=false};
	__property System::UnicodeString AvailableBins = {read=FAvailableBins, write=SetDummyString, stored=false};
	__property System::UnicodeString SepFile = {read=FSepFile, write=SetDummyString, stored=false};
	__property unsigned StartTime = {read=FStartTime, write=SetDummyDWORD, stored=false, nodefault};
	__property unsigned UntilTime = {read=FUntilTime, write=SetDummyDWORD, stored=false, nodefault};
	__property unsigned DriverVersion = {read=FDriverVersion, write=SetDummyDWORD, stored=false, nodefault};
	__property TLMDPrintDuplex Duplex = {read=FDuplex, write=SetDummyDuplex, stored=false, nodefault};
	__property TLMDPrinterOrientation Orientation = {read=FOrientation, write=SetDummyOrientation, stored=false, nodefault};
	__property TLMDPaperSize PaperSize = {read=FPaperSize, write=SetDummyPaperSize, stored=false, nodefault};
	__property TLMDPrintQuality Quality = {read=FQuality, write=SetDummyQuality, stored=false, nodefault};
	__property short Scale = {read=FScale, write=SetDummyShort, stored=false, nodefault};
	__property short Copies = {read=FCopies, write=SetDummyShort, stored=false, nodefault};
	__property TLMDPrintTTOption TrueTypeOption = {read=FTTOption, write=SetDummyTTOption, stored=false, nodefault};
	__property bool Collate = {read=FCollate, write=SetDummyBool, stored=false, nodefault};
	__property short CustomXRes = {read=FCustomXRes, write=SetDummyShort, stored=false, nodefault};
	__property short CustomYRes = {read=FCustomYRes, write=SetDummyShort, stored=false, nodefault};
	__property short PaperLength = {read=FPaperLength, write=SetDummyShort, stored=false, nodefault};
	__property short PaperWidth = {read=FPaperWidth, write=SetDummyShort, stored=false, nodefault};
	__property TLMDPrintFlags ValidFlags = {read=FFlags, write=FFlags, stored=false, nodefault};
	__property bool Monochrome = {read=FMonochrome, write=SetDummyBool, stored=false, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDPrintersInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDPrinterItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDPrinterItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDPrinterItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDPrinterItem* __fastcall Add(void);
	__fastcall TLMDPrintersInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDPrintersInfo(void);
	void __fastcall UpdateProperties(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDPrinterItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysPrinterDisplayInfos (System::Set<TLMDSysPrinterDisplayInfo, TLMDSysPrinterDisplayInfo::ppidDeviceName, TLMDSysPrinterDisplayInfo::ppidDefaultBin>() << TLMDSysPrinterDisplayInfo::ppidDeviceName << TLMDSysPrinterDisplayInfo::ppidDriver << TLMDSysPrinterDisplayInfo::ppidComment << TLMDSysPrinterDisplayInfo::ppidLocation << TLMDSysPrinterDisplayInfo::ppidPort << TLMDSysPrinterDisplayInfo::ppidServer << TLMDSysPrinterDisplayInfo::ppidDataType << TLMDSysPrinterDisplayInfo::ppidPrintProcessor << TLMDSysPrinterDisplayInfo::ppidPrintProcessorParams << TLMDSysPrinterDisplayInfo::ppidSepFile << TLMDSysPrinterDisplayInfo::ppidStartTime << TLMDSysPrinterDisplayInfo::ppidUntilTime << TLMDSysPrinterDisplayInfo::ppidDriverVersion << TLMDSysPrinterDisplayInfo::ppidDuplex \
	<< TLMDSysPrinterDisplayInfo::ppidOrientation << TLMDSysPrinterDisplayInfo::ppidPaperSize << TLMDSysPrinterDisplayInfo::ppidQuality << TLMDSysPrinterDisplayInfo::ppidScale << TLMDSysPrinterDisplayInfo::ppidCopies << TLMDSysPrinterDisplayInfo::ppidTrueTypeOption << TLMDSysPrinterDisplayInfo::ppidCollate << TLMDSysPrinterDisplayInfo::ppidCustomXRes << TLMDSysPrinterDisplayInfo::ppidCustomYRes << TLMDSysPrinterDisplayInfo::ppidPaperLength << TLMDSysPrinterDisplayInfo::ppidPaperWidth << TLMDSysPrinterDisplayInfo::ppidValidFlags << TLMDSysPrinterDisplayInfo::ppidMonochrome << TLMDSysPrinterDisplayInfo::ppidAvailableBins << TLMDSysPrinterDisplayInfo::ppidDefaultBin )
extern DELPHI_PACKAGE Lmdsysprinterinfo__1 LMDSysPrinterProps;
}	/* namespace Lmdsysprinterinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPRINTERINFO)
using namespace Lmdsysprinterinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysprinterinfoHPP
