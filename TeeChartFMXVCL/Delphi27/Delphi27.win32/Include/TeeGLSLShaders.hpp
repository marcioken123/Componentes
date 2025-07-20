// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeGLSLShaders.pas' rev: 34.00 (Windows)

#ifndef TeeglslshadersHPP
#define TeeglslshadersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <VCLTee.OpenGL2.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeglslshaders
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TShader;
class DELPHICLASS TProgramShader;
class DELPHICLASS TGLSLEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TShader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned FHandle;
	System::UnicodeString FSource;
	TProgramShader* IProgram;
	unsigned IType;
	unsigned __fastcall GetHandle();
	void __fastcall SetSource(const System::UnicodeString Value);
	
public:
	__fastcall TShader(unsigned ShaderType);
	__fastcall virtual ~TShader();
	void __fastcall CompileAndAttach();
	System::UnicodeString __fastcall ErrorLog();
	__property unsigned Handle = {read=GetHandle, nodefault};
	__property System::UnicodeString Source = {read=FSource, write=SetSource};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TProgramShader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FEnabled;
	bool __fastcall GetEnabled();
	void __fastcall SetEnabled(const bool Value);
	
public:
	unsigned Handle;
	TShader* Vertex;
	TShader* Fragment;
	__fastcall TProgramShader();
	__fastcall virtual ~TProgramShader();
	System::UnicodeString __fastcall ErrorLog();
	void __fastcall Link();
	void __fastcall SetUniform(const System::UnicodeString Uniform, const int Value);
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLSLEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGLSLEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGLSLEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGLSLEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGLSLEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TGLSLEditor* GLSLEditor;
}	/* namespace Teeglslshaders */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEGLSLSHADERS)
using namespace Teeglslshaders;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeglslshadersHPP
