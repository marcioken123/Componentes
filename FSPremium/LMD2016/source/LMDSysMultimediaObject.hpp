// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMultimediaObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysmultimediaobjectHPP
#define LmdsysmultimediaobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysLog.hpp>
#include <LMDSysLogStrings.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmultimediaobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMMediaItem;
class DELPHICLASS TLMDMixerItem;
class DELPHICLASS TLMDMixersInfo;
class DELPHICLASS TLMDVolumedItem;
class DELPHICLASS TLMDauxAudioItem;
class DELPHICLASS TLMDauxAudioInfo;
class DELPHICLASS TLMDwaveInAudioItem;
class DELPHICLASS TLMDwaveInAudioInfo;
class DELPHICLASS TLMDwaveOutAudioItem;
class DELPHICLASS TLMDwaveOutAudioInfo;
class DELPHICLASS TLMDmidiInAudioItem;
class DELPHICLASS TLMDmidiInAudioInfo;
class DELPHICLASS TLMDmidiOutAudioItem;
class DELPHICLASS TLMDmidiOutAudioInfo;
class DELPHICLASS TLMDJoystickItem;
class DELPHICLASS TLMDJoystickInfo;
class DELPHICLASS TLMDSysMultimediaObject;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMMediaItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::Word FDeviceID;
	System::Byte FMinorVer;
	System::Byte FMajorVer;
	System::UnicodeString FName;
	System::Word FProductID;
	System::Word FManufacturerID;
	
protected:
	void __fastcall SetDummyByte(const System::Byte Value);
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyWord(const System::Word Value);
	void __fastcall SetDummyLong(const int Value);
	
__published:
	__property System::Word DeviceID = {read=FDeviceID, write=SetDummyWord, nodefault};
	__property System::Word ManufacturerID = {read=FManufacturerID, write=SetDummyWord, nodefault};
	__property System::Word ProductID = {read=FProductID, write=SetDummyWord, nodefault};
	__property System::Byte MajorVer = {read=FMajorVer, write=SetDummyByte, nodefault};
	__property System::Byte MinorVer = {read=FMinorVer, write=SetDummyByte, nodefault};
	__property System::UnicodeString Name = {read=FName, write=SetDummyString};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDMMediaItem(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDMMediaItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMixerItem : public TLMDMMediaItem
{
	typedef TLMDMMediaItem inherited;
	
private:
	unsigned FDestinations;
	void __fastcall SetDummyDword(const unsigned Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property unsigned Destinations = {read=FDestinations, write=SetDummyDword, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDMixerItem(System::Classes::TCollection* Collection) : TLMDMMediaItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDMixerItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDMixersInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDMixerItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDMixerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDMixerItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDMixerItem* __fastcall Add(void);
	__fastcall TLMDMixersInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDMixerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDMixersInfo(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVolumedItem : public TLMDMMediaItem
{
	typedef TLMDMMediaItem inherited;
	
private:
	System::Word FVolumeL;
	System::Word FVolumeR;
	virtual void __fastcall SetVolume(int Index, const System::Word Value) = 0 ;
	
__published:
	__property System::Word VolumeL = {read=FVolumeL, write=SetVolume, index=0, nodefault};
	__property System::Word VolumeR = {read=FVolumeR, write=SetVolume, index=1, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDVolumedItem(System::Classes::TCollection* Collection) : TLMDMMediaItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDVolumedItem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDauxTech : unsigned char { atNone, atAUXIN, atCDAUDIO };

enum DECLSPEC_DENUM TLMDauxSupport : unsigned char { asNone, asVolume, asLRVolume };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDauxAudioItem : public TLMDVolumedItem
{
	typedef TLMDVolumedItem inherited;
	
private:
	TLMDauxTech FTechnology;
	TLMDauxSupport FSupport;
	void __fastcall SetDummySupport(const TLMDauxSupport Value);
	void __fastcall SetDummyTech(const TLMDauxTech Value);
	System::UnicodeString __fastcall DauxSupportToStr(TLMDauxSupport aDauxSupport);
	System::UnicodeString __fastcall DauxTechToStr(TLMDauxTech aDauxTech);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual void __fastcall SetVolume(int Index, const System::Word Value);
	
public:
	void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDauxTech Technology = {read=FTechnology, write=SetDummyTech, nodefault};
	__property TLMDauxSupport Support = {read=FSupport, write=SetDummySupport, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDauxAudioItem(System::Classes::TCollection* Collection) : TLMDVolumedItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDauxAudioItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDauxAudioInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDauxAudioItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDauxAudioItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDauxAudioItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDauxAudioItem* __fastcall Add(void);
	__fastcall TLMDauxAudioInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDauxAudioItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDauxAudioInfo(void) { }
	
};


enum DECLSPEC_DENUM TLMDwaveFormat : unsigned char { wf1M08, wf1M16, wf1S08, wf1S16, wf2M08, wf2M16, wf2S08, wf2S16, wf4M08, wf4M16, wf4S08, wf4S16 };

typedef System::Set<TLMDwaveFormat, TLMDwaveFormat::wf1M08, TLMDwaveFormat::wf4S16> TLMDwaveFormats;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDwaveInAudioItem : public TLMDMMediaItem
{
	typedef TLMDMMediaItem inherited;
	
private:
	TLMDwaveFormats FFormats;
	System::Word FChannels;
	void __fastcall SetDummyFormats(const TLMDwaveFormats Value);
	System::UnicodeString __fastcall waveFormatsToStr(TLMDwaveFormats awaveFormats);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDwaveFormats Formats = {read=FFormats, write=SetDummyFormats, nodefault};
	__property System::Word Channels = {read=FChannels, write=SetDummyWord, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDwaveInAudioItem(System::Classes::TCollection* Collection) : TLMDMMediaItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDwaveInAudioItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDwaveInAudioInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDwaveInAudioItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDwaveInAudioItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDwaveInAudioItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDwaveInAudioItem* __fastcall Add(void);
	__fastcall TLMDwaveInAudioInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDwaveInAudioItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDwaveInAudioInfo(void) { }
	
};


enum DECLSPEC_DENUM TLMDwaveOutSupport : unsigned char { wosLRVOLUME, wosVOLUME, wosPITCH, wosPLAYBACKRATE, wosSYNC, wosSAMPLEACCURATE };

typedef System::Set<TLMDwaveOutSupport, TLMDwaveOutSupport::wosLRVOLUME, TLMDwaveOutSupport::wosSAMPLEACCURATE> TLMDwaveOutSupports;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDwaveOutAudioItem : public TLMDVolumedItem
{
	typedef TLMDVolumedItem inherited;
	
private:
	TLMDwaveFormats FFormats;
	System::Word FChannels;
	TLMDwaveOutSupports FSupport;
	void __fastcall SetDummyFormats(const TLMDwaveFormats Value);
	void __fastcall SetDummySupport(const TLMDwaveOutSupports Value);
	System::UnicodeString __fastcall waveFormatsToStr(TLMDwaveFormats awaveFormats);
	System::UnicodeString __fastcall waveOutSupportsToStr(TLMDwaveOutSupports awaveOutSupports);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual void __fastcall SetVolume(int Index, const System::Word Value);
	
public:
	virtual void __fastcall Apply(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDwaveFormats Formats = {read=FFormats, write=SetDummyFormats, nodefault};
	__property System::Word Channels = {read=FChannels, write=SetDummyWord, nodefault};
	__property TLMDwaveOutSupports Support = {read=FSupport, write=SetDummySupport, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDwaveOutAudioItem(System::Classes::TCollection* Collection) : TLMDVolumedItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDwaveOutAudioItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDwaveOutAudioInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDwaveOutAudioItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDwaveOutAudioItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDwaveOutAudioItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDwaveOutAudioItem* __fastcall Add(void);
	__fastcall TLMDwaveOutAudioInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDwaveOutAudioItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDwaveOutAudioInfo(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDmidiInAudioItem : public TLMDMMediaItem
{
	typedef TLMDMMediaItem inherited;
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDmidiInAudioItem(System::Classes::TCollection* Collection) : TLMDMMediaItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDmidiInAudioItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDmidiInAudioInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDmidiInAudioItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDmidiInAudioItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDmidiInAudioItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDmidiInAudioItem* __fastcall Add(void);
	__fastcall TLMDmidiInAudioInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDmidiInAudioItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDmidiInAudioInfo(void) { }
	
};


enum DECLSPEC_DENUM TLMDMIDITechnology : unsigned char { mtMIDIPORT, mtSYNTH, mtSQSYNTH, mtFMSYNTH, mtMAPPER, mtWAVETABLE, mtSWSYNTH };

enum DECLSPEC_DENUM TLMDMIDIChannel : unsigned char { ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 };

typedef System::Set<TLMDMIDIChannel, TLMDMIDIChannel::ch0, TLMDMIDIChannel::ch15> TLMDMIDIChannels;

enum DECLSPEC_DENUM TLMDmidiOutSupport : unsigned char { mosCACHE, mosLRVOLUME, mosSTREAM, mosVOLUME };

typedef System::Set<TLMDmidiOutSupport, TLMDmidiOutSupport::mosCACHE, TLMDmidiOutSupport::mosVOLUME> TLMDmidiOutSupports;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDmidiOutAudioItem : public TLMDVolumedItem
{
	typedef TLMDVolumedItem inherited;
	
private:
	TLMDMIDIChannels FChannelMask;
	TLMDmidiOutSupports FSupport;
	TLMDMIDITechnology FTechnology;
	System::Word FVoices;
	System::Word FNotes;
	void __fastcall SetDummyChannels(const TLMDMIDIChannels Value);
	void __fastcall SetDummySupport(const TLMDmidiOutSupports Value);
	void __fastcall SetDummyTechnology(const TLMDMIDITechnology Value);
	System::UnicodeString __fastcall MIDITechnologyToStr(TLMDMIDITechnology aTec);
	System::UnicodeString __fastcall ChannelMaskToStr(TLMDMIDIChannels aMask);
	System::UnicodeString __fastcall SupportToStr(TLMDmidiOutSupports aSupp);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual void __fastcall SetVolume(int Index, const System::Word Value);
	
public:
	virtual void __fastcall Apply(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDMIDITechnology Technology = {read=FTechnology, write=SetDummyTechnology, nodefault};
	__property System::Word Voices = {read=FVoices, write=SetDummyWord, nodefault};
	__property System::Word Notes = {read=FNotes, write=SetDummyWord, nodefault};
	__property TLMDMIDIChannels ChannelMask = {read=FChannelMask, write=SetDummyChannels, nodefault};
	__property TLMDmidiOutSupports Support = {read=FSupport, write=SetDummySupport, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDmidiOutAudioItem(System::Classes::TCollection* Collection) : TLMDVolumedItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDmidiOutAudioItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDmidiOutAudioInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDmidiOutAudioItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDmidiOutAudioItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDmidiOutAudioItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDmidiOutAudioItem* __fastcall Add(void);
	__fastcall TLMDmidiOutAudioInfo(Lmdsysobject::TLMDSysObject* aOwner);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDmidiOutAudioItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDmidiOutAudioInfo(void) { }
	
};


enum DECLSPEC_DENUM TLMDjoyCap : unsigned char { jcHASZ, jcHASR, jcHASU, jcHASV, jcHASPOV, jcPOV4DIR, jcPOVCTS };

typedef System::Set<TLMDjoyCap, TLMDjoyCap::jcHASZ, TLMDjoyCap::jcPOVCTS> TLMDjoyCaps;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDJoystickItem : public TLMDMMediaItem
{
	typedef TLMDMMediaItem inherited;
	
private:
	int FRmax;
	int FZMin;
	int FRmin;
	int FZMax;
	int FYMax;
	int FPeriodMax;
	int FXMax;
	int FNumAxes;
	int FYMin;
	int FMaxAxes;
	int FNumButtons;
	int FXMin;
	int FPeriodMin;
	System::UnicodeString FOEMVxD;
	System::UnicodeString FRegKey;
	TLMDjoyCaps FCaps;
	int FVmax;
	int FUmax;
	int FVmin;
	int FUmin;
	int FMaxButtons;
	void __fastcall SetDummyCaps(const TLMDjoyCaps Value);
	System::UnicodeString __fastcall JoyCapsToStr(TLMDjoyCaps aCaps);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property int Xmin = {read=FXMin, write=SetDummyLong, nodefault};
	__property int Xmax = {read=FXMax, write=SetDummyLong, nodefault};
	__property int Ymin = {read=FYMin, write=SetDummyLong, nodefault};
	__property int Ymax = {read=FYMax, write=SetDummyLong, nodefault};
	__property int Zmin = {read=FZMin, write=SetDummyLong, nodefault};
	__property int Zmax = {read=FZMax, write=SetDummyLong, nodefault};
	__property int NumButtons = {read=FNumButtons, write=SetDummyLong, nodefault};
	__property int PeriodMin = {read=FPeriodMin, write=SetDummyLong, nodefault};
	__property int PeriodMax = {read=FPeriodMax, write=SetDummyLong, nodefault};
	__property int Rmin = {read=FRmin, write=SetDummyLong, nodefault};
	__property int Rmax = {read=FRmax, write=SetDummyLong, nodefault};
	__property int Umin = {read=FUmin, write=SetDummyLong, nodefault};
	__property int Umax = {read=FUmax, write=SetDummyLong, nodefault};
	__property int Vmin = {read=FVmin, write=SetDummyLong, nodefault};
	__property int Vmax = {read=FVmax, write=SetDummyLong, nodefault};
	__property TLMDjoyCaps Caps = {read=FCaps, write=SetDummyCaps, nodefault};
	__property int MaxAxes = {read=FMaxAxes, write=SetDummyLong, nodefault};
	__property int NumAxes = {read=FNumAxes, write=SetDummyLong, nodefault};
	__property int MaxButtons = {read=FMaxButtons, write=SetDummyLong, nodefault};
	__property System::UnicodeString RegKey = {read=FRegKey, write=SetDummyString};
	__property System::UnicodeString OEMVxD = {read=FOEMVxD, write=SetDummyString};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDJoystickItem(System::Classes::TCollection* Collection) : TLMDMMediaItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDJoystickItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDJoystickInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDJoystickItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	HIDESBASE TLMDJoystickItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDJoystickItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	int __fastcall GetNumberConJoysticks(void);
	
public:
	HIDESBASE TLMDJoystickItem* __fastcall Add(void);
	__fastcall TLMDJoystickInfo(Lmdsysobject::TLMDSysObject* aOwner);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	void __fastcall Refresh(void);
	__property TLMDJoystickItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDJoystickInfo(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysMultimediaObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	TLMDMixersInfo* FMixers;
	TLMDauxAudioInfo* FauxDevices;
	TLMDwaveInAudioInfo* FwaveInDevices;
	TLMDwaveOutAudioInfo* FwaveOutDevices;
	TLMDmidiInAudioInfo* FmidiInDevices;
	TLMDmidiOutAudioInfo* FmidiOutDevices;
	TLMDJoystickInfo* FJoysticks;
	
public:
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	__fastcall virtual TLMDSysMultimediaObject(void);
	__fastcall virtual ~TLMDSysMultimediaObject(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDMixersInfo* Mixers = {read=FMixers, write=FMixers};
	__property TLMDauxAudioInfo* auxDevices = {read=FauxDevices, write=FauxDevices};
	__property TLMDwaveInAudioInfo* waveInDevices = {read=FwaveInDevices, write=FwaveInDevices};
	__property TLMDwaveOutAudioInfo* waveOutDevices = {read=FwaveOutDevices, write=FwaveOutDevices};
	__property TLMDmidiInAudioInfo* midiInDevices = {read=FmidiInDevices, write=FmidiInDevices};
	__property TLMDmidiOutAudioInfo* midiOutDevices = {read=FmidiOutDevices, write=FmidiOutDevices};
	__property TLMDJoystickInfo* Joysticks = {read=FJoysticks, write=FJoysticks};
private:
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D8DECF0C-3DE0-4E44-AD38-F022380E2970}
	operator Lmdsysbase::_di_ILMDSysContainer()
	{
		Lmdsysbase::_di_ILMDSysContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysContainer*(void) { return (Lmdsysbase::ILMDSysContainer*)&__ILMDSysContainer; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysmultimediaobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMULTIMEDIAOBJECT)
using namespace Lmdsysmultimediaobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmultimediaobjectHPP
