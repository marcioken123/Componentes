// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeThemes.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeethemesHPP
#define Vcltee_TeethemesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teethemes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDefaultTheme;
class DELPHICLASS TFlatTheme;
class DELPHICLASS TLookoutTheme;
class DELPHICLASS TAndrosTheme;
class DELPHICLASS TExcelTheme;
class DELPHICLASS TClassicTheme;
class DELPHICLASS TBusinessTheme;
class DELPHICLASS TWebTheme;
class DELPHICLASS TWindowsXPTheme;
class DELPHICLASS TBlueSkyTheme;
class DELPHICLASS TFactsTheme;
class DELPHICLASS TOperaTheme;
class DELPHICLASS TBlackIsBackTheme;
class DELPHICLASS TGrayscaleTheme;
class DELPHICLASS TSpeedTheme;
class DELPHICLASS TSystemTheme;
class DELPHICLASS TThemesList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDefaultTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
protected:
	__classmethod void __fastcall ChangeSeries(Vcltee::Teengine::TChartSeries* const Series);
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TDefaultTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDefaultTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFlatTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TFlatTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFlatTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLookoutTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall SetDefaultValues();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TLookoutTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLookoutTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAndrosTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall SetDefaultValues();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TAndrosTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAndrosTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TExcelTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TExcelTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TExcelTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TClassicTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TClassicTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TClassicTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBusinessTheme : public TDefaultTheme
{
	typedef TDefaultTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TBusinessTheme(Vcltee::Chart::TCustomChart* AChart) : TDefaultTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBusinessTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWebTheme : public TDefaultTheme
{
	typedef TDefaultTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TWebTheme(Vcltee::Chart::TCustomChart* AChart) : TDefaultTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWebTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TWindowsXPTheme : public TBusinessTheme
{
	typedef TBusinessTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TWindowsXPTheme(Vcltee::Chart::TCustomChart* AChart) : TBusinessTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWindowsXPTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBlueSkyTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TBlueSkyTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlueSkyTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFactsTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
private:
	Vcltee::Teetools::TGridBandTool* FBands;
	Vcltee::Teetools::TGridBandTool* __fastcall GetBands();
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	__property Vcltee::Teetools::TGridBandTool* Bands = {read=GetBands};
public:
	/* TChartTheme.Create */ inline __fastcall virtual TFactsTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFactsTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TOperaTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TOperaTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TOperaTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBlackIsBackTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TBlackIsBackTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlackIsBackTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGrayscaleTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TGrayscaleTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGrayscaleTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSpeedTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TSpeedTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSpeedTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSystemTheme : public Vcltee::Chart::TChartTheme
{
	typedef Vcltee::Chart::TChartTheme inherited;
	
public:
	__classmethod void __fastcall ApplyStyle(Vcltee::Chart::TCustomChart* const AChart, Vcl::Themes::TCustomStyleServices* AStyle = (Vcl::Themes::TCustomStyleServices*)(0x0));
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	__classmethod System::UnicodeString __fastcall StyleExtension();
	__classmethod System::UnicodeString __fastcall StylesPath();
	__classmethod System::Classes::TStrings* __fastcall SystemStyles(const System::UnicodeString APath);
public:
	/* TChartTheme.Create */ inline __fastcall virtual TSystemTheme(Vcltee::Chart::TCustomChart* AChart) : Vcltee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSystemTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TThemesList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	Vcltee::Chart::TChartThemeClass operator[](int Index) { return this->Theme[Index]; }
	
private:
	Vcltee::Chart::TChartThemeClass __fastcall GetTheme(int Index);
	
public:
	__classmethod void __fastcall Apply(Vcltee::Chart::TCustomChart* const Dest, Vcltee::Chart::TCustomChart* const Origin)/* overload */;
	__classmethod void __fastcall Apply(Vcltee::Chart::TCustomChart* const Dest, const System::UnicodeString FileName)/* overload */;
	__classmethod void __fastcall ApplyColors(Vcltee::Chart::TCustomChart* const Chart, const Vcltee::Teeprocs::TColorArray Scheme, int Start = 0x0);
	__classmethod void __fastcall ApplyFont(Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString AName);
	__classmethod void __fastcall ApplyFontSizeDelta(Vcltee::Chart::TCustomChart* const Chart, const float ADelta);
	__classmethod void __fastcall ApplyFromResource(Vcltee::Chart::TCustomChart* const Dest, const System::UnicodeString ResourceName);
	__classmethod System::UnicodeString __fastcall ThemesPath();
	__property Vcltee::Chart::TChartThemeClass Theme[int Index] = {read=GetTheme/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TThemesList() { }
	
public:
	/* TObject.Create */ inline __fastcall TThemesList() : System::Classes::TList() { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<Vcltee::Teeprocs::TColorArray> Vcltee_Teethemes__81;

//-- var, const, procedure ---------------------------------------------------
#define TeeMsg_ThemesPath L"VCLThemesPath"
extern DELPHI_PACKAGE TThemesList* ChartThemes;
extern DELPHI_PACKAGE Vcltee_Teethemes__81 TeeColorSchemes;
extern DELPHI_PACKAGE void __fastcall ApplyChartTheme(const Vcltee::Chart::TChartThemeClass Theme, Vcltee::Chart::TCustomChart* const Chart, int PaletteIndex = 0xffffffff);
extern DELPHI_PACKAGE void __fastcall RegisterChartThemes(Vcltee::Chart::TChartThemeClass const *Themes, const int Themes_High);
}	/* namespace Teethemes */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETHEMES)
using namespace Vcltee::Teethemes;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeethemesHPP
