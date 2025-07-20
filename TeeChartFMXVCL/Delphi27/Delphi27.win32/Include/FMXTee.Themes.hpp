// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Themes.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_ThemesHPP
#define Fmxtee_ThemesHPP

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
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Procs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Themes
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
class PASCALIMPLEMENTATION TDefaultTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
protected:
	__classmethod void __fastcall ChangeSeries(Fmxtee::Engine::TChartSeries* const Series);
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TDefaultTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDefaultTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFlatTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TFlatTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFlatTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLookoutTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall SetDefaultValues();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TLookoutTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLookoutTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAndrosTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall SetDefaultValues();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TAndrosTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAndrosTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TExcelTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TExcelTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TExcelTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TClassicTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TClassicTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
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
	/* TChartTheme.Create */ inline __fastcall virtual TBusinessTheme(Fmxtee::Chart::TCustomChart* AChart) : TDefaultTheme(AChart) { }
	
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
	/* TChartTheme.Create */ inline __fastcall virtual TWebTheme(Fmxtee::Chart::TCustomChart* AChart) : TDefaultTheme(AChart) { }
	
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
	/* TChartTheme.Create */ inline __fastcall virtual TWindowsXPTheme(Fmxtee::Chart::TCustomChart* AChart) : TBusinessTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWindowsXPTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBlueSkyTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TBlueSkyTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlueSkyTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFactsTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
private:
	Fmxtee::Tools::TGridBandTool* FBands;
	Fmxtee::Tools::TGridBandTool* __fastcall GetBands();
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	__property Fmxtee::Tools::TGridBandTool* Bands = {read=GetBands};
public:
	/* TChartTheme.Create */ inline __fastcall virtual TFactsTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFactsTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TOperaTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TOperaTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TOperaTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBlackIsBackTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TBlackIsBackTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlackIsBackTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGrayscaleTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TGrayscaleTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGrayscaleTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSpeedTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
public:
	/* TChartTheme.Create */ inline __fastcall virtual TSpeedTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSpeedTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSystemTheme : public Fmxtee::Chart::TChartTheme
{
	typedef Fmxtee::Chart::TChartTheme inherited;
	
public:
	__classmethod void __fastcall ApplyStyle(Fmxtee::Chart::TCustomChart* const AChart, Fmx::Types::TFmxObject* AStyle = (Fmx::Types::TFmxObject*)(0x0));
	virtual void __fastcall Apply();
	virtual System::UnicodeString __fastcall Description();
	__classmethod System::UnicodeString __fastcall StyleExtension();
	__classmethod System::UnicodeString __fastcall StylesPath();
	__classmethod System::Classes::TStrings* __fastcall SystemStyles(const System::UnicodeString APath);
public:
	/* TChartTheme.Create */ inline __fastcall virtual TSystemTheme(Fmxtee::Chart::TCustomChart* AChart) : Fmxtee::Chart::TChartTheme(AChart) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSystemTheme() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TThemesList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	Fmxtee::Chart::TChartThemeClass operator[](int Index) { return this->Theme[Index]; }
	
private:
	Fmxtee::Chart::TChartThemeClass __fastcall GetTheme(int Index);
	
public:
	__classmethod void __fastcall Apply(Fmxtee::Chart::TCustomChart* const Dest, Fmxtee::Chart::TCustomChart* const Origin)/* overload */;
	__classmethod void __fastcall Apply(Fmxtee::Chart::TCustomChart* const Dest, const System::UnicodeString FileName)/* overload */;
	__classmethod void __fastcall ApplyColors(Fmxtee::Chart::TCustomChart* const Chart, const Fmxtee::Procs::TColorArray Scheme, int Start = 0x0);
	__classmethod void __fastcall ApplyFont(Fmxtee::Chart::TCustomChart* const Chart, const System::UnicodeString AName);
	__classmethod void __fastcall ApplyFontSizeDelta(Fmxtee::Chart::TCustomChart* const Chart, const float ADelta);
	__classmethod void __fastcall ApplyFromResource(Fmxtee::Chart::TCustomChart* const Dest, const System::UnicodeString ResourceName);
	__classmethod System::UnicodeString __fastcall ThemesPath();
	__property Fmxtee::Chart::TChartThemeClass Theme[int Index] = {read=GetTheme/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TThemesList() { }
	
public:
	/* TObject.Create */ inline __fastcall TThemesList() : System::Classes::TList() { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<Fmxtee::Procs::TColorArray> Fmxtee_Themes__81;

//-- var, const, procedure ---------------------------------------------------
#define TeeMsg_ThemesPath L"FMXThemesPath"
extern DELPHI_PACKAGE TThemesList* ChartThemes;
extern DELPHI_PACKAGE Fmxtee_Themes__81 TeeColorSchemes;
extern DELPHI_PACKAGE void __fastcall ApplyChartTheme(const Fmxtee::Chart::TChartThemeClass Theme, Fmxtee::Chart::TCustomChart* const Chart, int PaletteIndex = 0xffffffff);
extern DELPHI_PACKAGE void __fastcall RegisterChartThemes(Fmxtee::Chart::TChartThemeClass const *Themes, const int Themes_High);
}	/* namespace Themes */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_THEMES)
using namespace Fmxtee::Themes;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_ThemesHPP
