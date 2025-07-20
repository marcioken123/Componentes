// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDosCommand.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedoscommandHPP
#define Vcltee_TeedoscommandHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedoscommand
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCreatePipeError;
class DELPHICLASS TCreateProcessError;
class DELPHICLASS TProcessTimer;
class DELPHICLASS TDosThread;
class DELPHICLASS TDosCommand;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCreatePipeError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall TCreatePipeError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TCreatePipeError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall TCreatePipeError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TCreatePipeError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TCreatePipeError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall TCreatePipeError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall TCreatePipeError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TCreatePipeError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TCreatePipeError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TCreatePipeError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TCreatePipeError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TCreatePipeError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TCreatePipeError() { }
	
};


class PASCALIMPLEMENTATION TCreateProcessError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall TCreateProcessError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TCreateProcessError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall TCreateProcessError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TCreateProcessError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TCreateProcessError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall TCreateProcessError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall TCreateProcessError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TCreateProcessError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TCreateProcessError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TCreateProcessError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TCreateProcessError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TCreateProcessError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TCreateProcessError() { }
	
};


enum DECLSPEC_DENUM TOutputType : unsigned char { otEntireLine, otBeginningOfLine };

class PASCALIMPLEMENTATION TProcessTimer : public Vcl::Extctrls::TTimer
{
	typedef Vcl::Extctrls::TTimer inherited;
	
private:
	int FSinceBeginning;
	int FSinceLastOutput;
	void __fastcall MyTimer(System::TObject* Sender);
	
public:
	__fastcall virtual TProcessTimer(System::Classes::TComponent* AOwner);
	void __fastcall Beginning();
	void __fastcall NewOutput();
	void __fastcall Ending();
	__property int SinceBeginning = {read=FSinceBeginning, nodefault};
	__property int SinceLastOutput = {read=FSinceLastOutput, nodefault};
public:
	/* TTimer.Destroy */ inline __fastcall virtual ~TProcessTimer() { }
	
};


typedef void __fastcall (__closure *TNewLineEvent)(System::TObject* Sender, System::UnicodeString NewLine, TOutputType OutputType);

class PASCALIMPLEMENTATION TDosThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::TObject* FOwner;
	System::UnicodeString FCommandLine;
	System::Classes::TStringList* FLines;
	System::Classes::TStrings* FOutputLines;
	bool FInputToOutput;
	TProcessTimer* FTimer;
	int FMaxTimeAfterBeginning;
	int FMaxTimeAfterLastOutput;
	TNewLineEvent FOnNewLine;
	System::Classes::TNotifyEvent FOnTerminated;
	TCreatePipeError* FCreatePipeError;
	TCreateProcessError* FCreateProcessError;
	int FPriority;
	void __fastcall FExecute();
	
protected:
	virtual void __fastcall Execute();
	
public:
	bool Terminated;
	int DosExitCode;
	System::Classes::TStringList* InputLines;
	__fastcall TDosThread(System::TObject* AOwner, System::UnicodeString Cl, System::Classes::TStringList* L, System::Classes::TStrings* Ol, TProcessTimer* t, int mtab, int mtalo, TNewLineEvent Onl, System::Classes::TNotifyEvent Ot, int p, bool ito);
	__fastcall virtual ~TDosThread();
};


class PASCALIMPLEMENTATION TDosCommand : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::Classes::TComponent* FOwner;
	System::UnicodeString FCommandLine;
	System::Classes::TStringList* FLines;
	System::Classes::TStrings* FOutputLines;
	bool FInputToOutput;
	TNewLineEvent FOnNewLine;
	System::Classes::TNotifyEvent FOnTerminated;
	TDosThread* FThread;
	TProcessTimer* FTimer;
	int FMaxTimeAfterBeginning;
	int FMaxTimeAfterLastOutput;
	int FPriority;
	void __fastcall SetOutputLines(System::Classes::TStrings* Value);
	
public:
	__fastcall virtual TDosCommand(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDosCommand();
	void __fastcall Execute();
	void __fastcall Stop();
	void __fastcall SendLine(System::UnicodeString Value, bool Eol);
	__property System::Classes::TStrings* OutputLines = {read=FOutputLines, write=SetOutputLines};
	__property System::Classes::TStringList* Lines = {read=FLines};
	__property int Priority = {read=FPriority, write=FPriority, nodefault};
	bool __fastcall Terminated();
	int __fastcall DosExitCode();
	
__published:
	__property System::UnicodeString CommandLine = {read=FCommandLine, write=FCommandLine};
	__property TDosThread* Thread = {read=FThread};
	__property TNewLineEvent OnNewLine = {read=FOnNewLine, write=FOnNewLine};
	__property System::Classes::TNotifyEvent OnTerminated = {read=FOnTerminated, write=FOnTerminated};
	__property bool InputToOutput = {read=FInputToOutput, write=FInputToOutput, nodefault};
	__property int MaxTimeAfterBeginning = {read=FMaxTimeAfterBeginning, write=FMaxTimeAfterBeginning, nodefault};
	__property int MaxTimeAfterLastOutput = {read=FMaxTimeAfterLastOutput, write=FMaxTimeAfterLastOutput, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedoscommand */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDOSCOMMAND)
using namespace Vcltee::Teedoscommand;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedoscommandHPP
