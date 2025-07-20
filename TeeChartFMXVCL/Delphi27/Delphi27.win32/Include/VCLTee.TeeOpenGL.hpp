// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeOpenGL.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeopenglHPP
#define Vcltee_TeeopenglHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeGLCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeopengl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLPosition;
class DELPHICLASS TGLLight;
class DELPHICLASS TGLLightSource;
class DELPHICLASS TGLLights;
class DELPHICLASS TTeeOpenGL;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGLPosition : public Vcltee::Tecanvas::TPointXYZFloat
{
	typedef Vcltee::Tecanvas::TPointXYZFloat inherited;
	
public:
	/* TPointXYZFloat.Create */ inline __fastcall virtual TGLPosition(Vcltee::Tecanvas::TVisualBlock* const AOwner, const double AValue, const System::Classes::TNotifyEvent ChangedEvent) : Vcltee::Tecanvas::TPointXYZFloat(AOwner, AValue, ChangedEvent) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLPosition() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLLight : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FDiffuse;
	System::Uitypes::TColor FSpecular;
	bool FVisible;
	TTeeOpenGL* IOwner;
	
protected:
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetDiffuse(const System::Uitypes::TColor Value);
	void __fastcall SetSpecular(const System::Uitypes::TColor Value);
	void __fastcall SetVisible(bool Value);
	
public:
	__fastcall TGLLight(TTeeOpenGL* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall GLColor(System::Uitypes::TColor AColor, /* out */ Vcltee::Teeglcanvas::GLMat &Value);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property System::Uitypes::TColor Diffuse = {read=FDiffuse, write=SetDiffuse, default=16777215};
	__property System::Uitypes::TColor Specular = {read=FSpecular, write=SetSpecular, default=16777215};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLLight() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLLightSource : public TGLLight
{
	typedef TGLLight inherited;
	
private:
	TGLPosition* FDirection;
	bool FFixedPos;
	TGLPosition* FPosition;
	double FSpotDegrees;
	int FSpotExp;
	bool FUseDirection;
	void __fastcall SetFixed(const bool Value);
	void __fastcall SetSpotDegrees(const double Value);
	void __fastcall SetSpotExp(const int Value);
	void __fastcall SetUseDirection(const bool Value);
	
protected:
	void __fastcall SetDirection(TGLPosition* const Value);
	void __fastcall SetPosition(TGLPosition* const Value);
	
public:
	__fastcall TGLLightSource(TTeeOpenGL* AOwner);
	__fastcall virtual ~TGLLightSource();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TGLPosition* Direction = {read=FDirection, write=SetDirection};
	__property bool FixedPosition = {read=FFixedPos, write=SetFixed, default=1};
	__property TGLPosition* Position = {read=FPosition, write=SetPosition};
	__property double SpotDegrees = {read=FSpotDegrees, write=SetSpotDegrees};
	__property int SpotExponent = {read=FSpotExp, write=SetSpotExp, default=0};
	__property bool UseDirection = {read=FUseDirection, write=SetUseDirection, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLLights : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TGLLightSource*> _TGLLights__1;
	
	
public:
	TGLLightSource* operator[](int Index) { return this->Items[Index]; }
	
private:
	_TGLLights__1 FItems;
	TTeeOpenGL* IOwner;
	TGLLightSource* __fastcall Get(int Index);
	
public:
	__fastcall virtual ~TGLLights();
	TGLLightSource* __fastcall Add();
	int __fastcall Count();
	void __fastcall Delete(int Index);
	__property TGLLightSource* Items[int Index] = {read=Get/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TGLLights() : System::TObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeeOpenGL : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FActive;
	int FAmbientLight;
	bool FAntialias;
	Vcltee::Tecanvas::TTeeCanvasSurfaceStyle FDrawStyle;
	double FFontExtrusion;
	Vcltee::Tecanvas::TTeeFontStyle FFontStyle;
	bool FLightHelpers;
	TGLLights* FLights;
	bool FShadeQuality;
	double FShininess;
	Vcltee::Teeprocs::TCustomTeePanel* FTeePanel;
	bool FTexQuality;
	System::Classes::TNotifyEvent FOnInit;
	System::Classes::TNotifyEvent FOnRepaint;
	Vcltee::Tecanvas::TCanvas3DClass IOldCanvas;
	void __fastcall Activate();
	void __fastcall Changed(System::TObject* Sender);
	Vcltee::Teeglcanvas::TGLCanvas* __fastcall GetCanvas();
	bool __fastcall GetFontOutlines();
	TGLLightSource* __fastcall GetLight0();
	TGLLightSource* __fastcall GetLight1();
	TGLLightSource* __fastcall GetLight2();
	bool __fastcall GetWireframe();
	void __fastcall OnCanvasInit(System::TObject* Sender);
	void __fastcall OnCanvasFinish(System::TObject* Sender);
	void __fastcall ResetOldCanvas();
	void __fastcall SetActive(bool Value);
	void __fastcall SetAmbientLight(int Value);
	void __fastcall SetAntialias(bool Value);
	void __fastcall SetDoubleProperty(double &Variable, const double Value);
	void __fastcall SetDrawStyle(const Vcltee::Tecanvas::TTeeCanvasSurfaceStyle Value);
	void __fastcall SetFontExtrusion(const double Value);
	void __fastcall SetFontOutlines(bool Value);
	void __fastcall SetFontStyle(const Vcltee::Tecanvas::TTeeFontStyle Value);
	void __fastcall SetLightHelpers(const bool Value);
	void __fastcall SetLightSource0(TGLLightSource* const Value);
	void __fastcall SetLightSource1(TGLLightSource* const Value);
	void __fastcall SetLightSource2(TGLLightSource* const Value);
	void __fastcall SetShadeQuality(bool Value);
	void __fastcall SetShininess(const double Value);
	void __fastcall SetTeePanel(Vcltee::Teeprocs::TCustomTeePanel* const Value);
	void __fastcall SetTexQuality(const bool Value);
	void __fastcall SetWireframe(const bool Value);
	
protected:
	bool IAlwaysActive;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Repaint();
	
public:
	__fastcall virtual TTeeOpenGL(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeOpenGL();
	void __fastcall DrawLamps();
	__property Vcltee::Teeglcanvas::TGLCanvas* Canvas = {read=GetCanvas};
	__property TGLLightSource* Light0 = {read=GetLight0};
	__property TGLLights* Lights = {read=FLights};
	__property bool Wireframe = {read=GetWireframe, write=SetWireframe, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property int AmbientLight = {read=FAmbientLight, write=SetAmbientLight, nodefault};
	__property bool Antialias = {read=FAntialias, write=SetAntialias, default=1};
	__property Vcltee::Tecanvas::TTeeCanvasSurfaceStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property double FontExtrusion = {read=FFontExtrusion, write=SetFontExtrusion};
	__property bool FontOutlines = {read=GetFontOutlines, write=SetFontOutlines, default=0};
	__property Vcltee::Tecanvas::TTeeFontStyle FontStyle = {read=FFontStyle, write=SetFontStyle, default=0};
	__property bool LightHelpers = {read=FLightHelpers, write=SetLightHelpers, default=0};
	__property TGLLightSource* Light = {read=GetLight0, write=SetLightSource0};
	__property TGLLightSource* Light1 = {read=GetLight1, write=SetLightSource1};
	__property TGLLightSource* Light2 = {read=GetLight2, write=SetLightSource2};
	__property bool ShadeQuality = {read=FShadeQuality, write=SetShadeQuality, default=1};
	__property double Shininess = {read=FShininess, write=SetShininess};
	__property Vcltee::Teeprocs::TCustomTeePanel* TeePanel = {read=FTeePanel, write=SetTeePanel};
	__property bool TextureQuality = {read=FTexQuality, write=SetTexQuality, default=1};
	__property System::Classes::TNotifyEvent OnInit = {read=FOnInit, write=FOnInit};
	__property System::Classes::TNotifyEvent OnRepaint = {read=FOnRepaint, write=FOnRepaint};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeopengl */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEOPENGL)
using namespace Vcltee::Teeopengl;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeopenglHPP
