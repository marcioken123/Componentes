// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSTypes.pas' rev: 31.00 (Windows)

#ifndef JstypesHPP
#define JstypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.GraphUtil.hpp>
#include <JSGraphUtil.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jstypes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSChangePersistent;
class DELPHICLASS TJSGradient;
class DELPHICLASS TJSBackground;
//-- type declarations -------------------------------------------------------
typedef System::Classes::TStringList TJSWideStringList;

typedef System::UnicodeString TJSString;

typedef System::Classes::TStrings TJSStrings;

typedef Vcl::Stdctrls::TButton TJSButton;

typedef Vcl::Stdctrls::TRadioButton TJSRadioButtonCtrl;

class PASCALIMPLEMENTATION TJSChangePersistent : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	
protected:
	bool FIgnoreChange;
	virtual void __fastcall DoChange(void);
	__property bool IgnoreChange = {read=FIgnoreChange, write=FIgnoreChange, nodefault};
	
public:
	__fastcall virtual TJSChangePersistent(void);
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSChangePersistent(void) { }
	
};


class PASCALIMPLEMENTATION TJSGradient : public TJSChangePersistent
{
	typedef TJSChangePersistent inherited;
	
private:
	bool FEnabled;
	Vcl::Graphutil::TGradientDirection FDirection;
	System::Uitypes::TColor FEndColor;
	System::Uitypes::TColor FStartColor;
	void __fastcall SetDirection(const Vcl::Graphutil::TGradientDirection Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetStartColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TJSGradient(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphutil::TGradientDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property System::Uitypes::TColor EndColor = {read=FEndColor, write=SetEndColor, default=536870911};
	__property System::Uitypes::TColor StartColor = {read=FStartColor, write=SetStartColor, default=536870911};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSGradient(void) { }
	
};


class PASCALIMPLEMENTATION TJSBackground : public TJSChangePersistent
{
	typedef TJSChangePersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	TJSGradient* FGradient;
	bool FAutoFree;
	System::Types::TRect FCopyRect;
	bool FBuffered;
	
public:
	__fastcall TJSBackground(const System::Uitypes::TColor AColor, TJSGradient* AGradient, const System::Types::TRect &ACopyRect, bool ABuffered, bool AAutoFree);
	__fastcall virtual ~TJSBackground(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property TJSGradient* Gradient = {read=FGradient};
	__property bool AutoFree = {read=FAutoFree, nodefault};
	
public:
	__property System::Types::TRect CopyRect = {read=FCopyRect, write=FCopyRect};
	
__published:
	__property bool Buffered = {read=FBuffered, write=FBuffered, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jstypes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSTYPES)
using namespace Jstypes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JstypesHPP
