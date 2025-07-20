// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFlexCanvas.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeflexcanvasHPP
#define Vcltee_TeeflexcanvasHPP

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
#include <System.TypInfo.hpp>
#include <System.StrUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeeAnimations.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeflexcanvas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFlexCanvas;
class DELPHICLASS TFlexOptions;
class DELPHICLASS TFlexExportFormat;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFlexCanvas : public Vcltee::Tecanvas::TTeeNeutralCanvas
{
	typedef Vcltee::Tecanvas::TTeeNeutralCanvas inherited;
	
private:
	int FX;
	int FY;
	System::Classes::TStrings* FStrings;
	bool IAddedInitApp;
	int IApplication;
	System::UnicodeString IIdent;
	System::Classes::TStrings* IItems;
	int IImageID;
	Vcltee::Teeprocs::TCustomTeePanel* IPanel;
	System::Classes::TStrings* IPath;
	int IScript;
	int IStyle;
	bool ITreeMode;
	System::UnicodeString __fastcall AddAnimation(const System::UnicodeString ID);
	void __fastcall AddAnimationTypes();
	void __fastcall AddMarksTip();
	void __fastcall AddItem(const System::UnicodeString S);
	void __fastcall AddTag(const System::UnicodeString ATag, const System::UnicodeString AText, bool Finish = true);
	System::UnicodeString __fastcall CalcID(const System::UnicodeString Prefix);
	System::UnicodeString __fastcall FlexAlpha()/* overload */;
	System::UnicodeString __fastcall FlexAlpha(const Vcltee::Tecanvas::TTeeTransparency Alpha)/* overload */;
	System::UnicodeString __fastcall FlexBrush();
	System::UnicodeString __fastcall FlexFloatToStr(const double Value);
	System::UnicodeString __fastcall FlexFont(Vcl::Graphics::TFont* AFont, System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	System::UnicodeString __fastcall FlexGradient(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient)/* overload */;
	System::UnicodeString __fastcall FlexGradient(const System::Uitypes::TColor StartColor, const System::Uitypes::TColor MidColor, const System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance)/* overload */;
	System::UnicodeString __fastcall FlexPen();
	System::UnicodeString __fastcall FlexPoints(const System::Types::TPoint *Points, const int Points_High);
	System::UnicodeString __fastcall FlexPosition(int x, int y);
	System::UnicodeString __fastcall FlexSize(int w, int h)/* overload */;
	System::UnicodeString __fastcall FlexSize(const System::Types::TRect &R)/* overload */;
	System::UnicodeString __fastcall ImageFileName(Vcl::Graphics::TGraphic* const Graphic);
	
protected:
	void __fastcall AddLink(int x, int y, const System::UnicodeString Text, const System::UnicodeString URL, const System::UnicodeString Hint);
	void __fastcall AddToolTip(const System::UnicodeString Entity, const System::UnicodeString ToolTip);
	virtual Vcltee::Tecanvas::TVisualBlock* __fastcall BeginEntity(const System::UnicodeString Entity, Vcltee::Tecanvas::TVisualBlock* const Visual = (Vcltee::Tecanvas::TVisualBlock*)(0x0), Vcltee::Tecanvas::TTeeTransform* const Transform = (Vcltee::Tecanvas::TTeeTransform*)(0x0));
	virtual void __fastcall EndEntity();
	virtual void __fastcall SetPixel(int X, int Y, System::Uitypes::TColor Value);
	virtual void __fastcall SetPixel3D(int X, int Y, int Z, System::Uitypes::TColor Value);
	
public:
	bool EmbeddImages;
	System::UnicodeString ImagePath;
	__fastcall TFlexCanvas(Vcltee::Teeprocs::TCustomTeePanel* const Panel, System::Classes::TStrings* const AStrings);
	__fastcall virtual ~TFlexCanvas();
	virtual System::Types::TRect __fastcall InitWindow(Vcl::Graphics::TCanvas* const DestCanvas, Vcltee::Tecanvas::TView3DOptions* const A3DOptions, System::Uitypes::TColor ABackColor, bool Is3D, const System::Types::TRect &UserRect);
	virtual void __fastcall Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY)/* overload */;
	virtual void __fastcall Draw(int X, int Y, Vcl::Graphics::TGraphic* const Graphic);
	virtual void __fastcall FillRect(const System::Types::TRect &Rect);
	virtual void __fastcall Ellipse(const int X1, const int Y1, const int X2, const int Y2)/* overload */;
	virtual void __fastcall LineTo(const int X, const int Y)/* overload */;
	virtual void __fastcall MoveTo(const int X, const int Y)/* overload */;
	virtual void __fastcall Pie(int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4)/* overload */;
	virtual void __fastcall Rectangle(const int X0, const int Y0, const int X1, const int Y1)/* overload */;
	virtual void __fastcall RoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3)/* overload */;
	virtual void __fastcall StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
	virtual void __fastcall TextOut(int X, int Y, const System::UnicodeString Text)/* overload */;
	virtual void __fastcall ClipEllipse(const System::Types::TRect &Rect, bool Inverted = false);
	virtual void __fastcall ClipRectangle(const System::Types::TRect &Rect)/* overload */;
	virtual void __fastcall UnClipRectangle();
	virtual void __fastcall GradientFill(const System::Types::TRect &Rect, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, Vcltee::Tecanvas::TGradientDirection Direction, int Balance = 0x32, int RadialX = 0x0, int RadialY = 0x0)/* overload */;
	virtual void __fastcall RotateLabel(int x, int y, const System::UnicodeString St, double RotDegree, bool AllowHTML = false);
	virtual void __fastcall Polygon(const System::Types::TPoint *Points, const int Points_High);
	virtual void __fastcall Polyline(const System::Types::TPoint *Points, const int Points_High)/* overload */;
	virtual void __fastcall ShowImage(Vcl::Graphics::TCanvas* const DestCanvas, Vcl::Graphics::TCanvas* const DefaultCanvas, const System::Types::TRect &UserRect);
	virtual void __fastcall TextOut3D(int X, int Y, int Z, const System::UnicodeString Text, bool AllowHTML = false)/* overload */;
public:
	/* TTeeNeutralCanvas.Create */ inline __fastcall virtual TFlexCanvas() : Vcltee::Tecanvas::TTeeNeutralCanvas() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const int StartX, const int StartY, const int EndX, const int EndY, const int Z){ Vcltee::Tecanvas::TCanvas3D::Arc(Left, Top, Right, Bottom, StartX, StartY, EndX, EndY, Z); }
	inline void __fastcall  Arc(const int Left, const int Top, const int Right, const int Bottom, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(Left, Top, Right, Bottom, StartAngle, EndAngle); }
	inline void __fastcall  Arc(const System::Types::TRect &R, const float StartAngle, const float EndAngle){ Vcltee::Tecanvas::TTeeCanvas::Arc(R, StartAngle, EndAngle); }
	inline void __fastcall  Ellipse(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Ellipse(R); }
	inline void __fastcall  LineTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  LineTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::LineTo(P); }
	inline void __fastcall  MoveTo(const System::Types::TPoint &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  MoveTo(const _POINTFLOAT &P){ Vcltee::Tecanvas::TTeeCanvas::MoveTo(P); }
	inline void __fastcall  Pie(const System::Types::TRect &R, const double StartAngle, const double EndAngle){ Vcltee::Tecanvas::TTeeCanvas3D::Pie(R, StartAngle, EndAngle); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(R, Z); }
	inline void __fastcall  Rectangle(const int X0, const int Y0, const int X1, const int Y1, int Z){ Vcltee::Tecanvas::TCanvas3D::Rectangle(X0, Y0, X1, Y1, Z); }
	inline void __fastcall  Rectangle(const System::Types::TRect &R){ Vcltee::Tecanvas::TTeeCanvas::Rectangle(R); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, int Z0, int Z1){ Vcltee::Tecanvas::TCanvas3D::RoundRect(R, X, Y, Z0, Z1); }
	inline void __fastcall  RoundRect(const System::Types::TRect &R, int X, int Y, Vcltee::Tecanvas::TTeeCorners* const ACorners = (Vcltee::Tecanvas::TTeeCorners*)(0x0)){ Vcltee::Tecanvas::TTeeCanvas::RoundRect(R, X, Y, ACorners); }
	inline void __fastcall  StretchDraw(const System::Types::TRect &Rect, Vcl::Graphics::TGraphic* const Graphic, const double Pos, Vcltee::Tecanvas::TCanvas3DPlane Plane = (Vcltee::Tecanvas::TCanvas3DPlane)(0x2)){ Vcltee::Tecanvas::TCanvas3D::StretchDraw(Rect, Graphic, Pos, Plane); }
	inline void __fastcall  TextOut(const int X, const int Y, const System::UnicodeString Text, bool AllowHtml){ Vcltee::Tecanvas::TTeeCanvas::TextOut(X, Y, Text, AllowHtml); }
	inline void __fastcall  ClipRectangle(const System::Types::TRect &Rect, int RoundX, int RoundY){ Vcltee::Tecanvas::TTeeCanvas::ClipRectangle(Rect, RoundX, RoundY); }
	inline void __fastcall  GradientFill(Vcltee::Tecanvas::TCustomTeeGradient* const Gradient, const System::Types::TRect &Rect){ Vcltee::Tecanvas::TTeeCanvas3D::GradientFill(Gradient, Rect); }
	inline void __fastcall  Polyline(const System::Types::TPoint *Points, const int Points_High, int Z){ Vcltee::Tecanvas::TCanvas3D::Polyline(Points, Points_High, Z); }
	inline void __fastcall  TextOut3D(int x, int y, int z, const System::UnicodeString Text){ Vcltee::Tecanvas::TCanvas3D::TextOut3D(x, y, z, Text); }
	
private:
	void *__ICanvasToolTips;	// Vcltee::Tecanvas::ICanvasToolTips 
	void *__ICanvasHyperlinks;	// Vcltee::Tecanvas::ICanvasHyperlinks 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {03EBCB55-D01F-4CA8-8A2F-48EB3BEBC5E3}
	operator Vcltee::Tecanvas::_di_ICanvasToolTips()
	{
		Vcltee::Tecanvas::_di_ICanvasToolTips intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Tecanvas::ICanvasToolTips*(void) { return (Vcltee::Tecanvas::ICanvasToolTips*)&__ICanvasToolTips; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {84DBB276-CBD2-4BBB-AC31-AACBF8B6F34C}
	operator Vcltee::Tecanvas::_di_ICanvasHyperlinks()
	{
		Vcltee::Tecanvas::_di_ICanvasHyperlinks intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Tecanvas::ICanvasHyperlinks*(void) { return (Vcltee::Tecanvas::ICanvasHyperlinks*)&__ICanvasHyperlinks; }
	#endif
	
};


class PASCALIMPLEMENTATION TFlexOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBDelete;
	Vcl::Stdctrls::TCheckBox* CBEmbedd;
	Vcl::Stdctrls::TCheckBox* CBDebugMode;
	Vcl::Stdctrls::TCheckBox* CBStatic;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Stdctrls::TButton* BCompile;
	Vcl::Stdctrls::TEdit* ETemp;
	Vcl::Stdctrls::TEdit* EFlex;
	Vcl::Stdctrls::TCheckBox* CBPreview;
	Vcl::Stdctrls::TCheckBox* CBTreeMode;
	Vcl::Stdctrls::TCheckBox* CBFontAntialias;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall ETempChange(System::TObject* Sender);
	void __fastcall EFlexChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BCompileClick(System::TObject* Sender);
	
private:
	bool IReadingOptions;
	void __fastcall CheckCompile();
	bool __fastcall Compile(const System::UnicodeString TargetFile)/* overload */;
	void __fastcall ReadOptions();
	
public:
	Vcltee::Teeprocs::TCustomTeePanel* Panel;
	bool SilentMode;
	void __fastcall Compile(int AWidth, int AHeight, const System::UnicodeString FileName)/* overload */;
	bool __fastcall Compile(System::Classes::TStrings* const Strings, int AWidth, int AHeight, const System::UnicodeString FileName)/* overload */;
	__classmethod void __fastcall Compile(Vcltee::Teeprocs::TCustomTeePanel* const AChart, int AWidth, int AHeight, const System::UnicodeString FlexPath, const System::UnicodeString TempPath, const System::UnicodeString FileName, bool Preview = true)/* overload */;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFlexOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFlexOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFlexOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFlexOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TFlexExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	void __fastcall CheckProperties();
	
protected:
	TFlexOptions* FProperties;
	virtual void __fastcall DoCopyToClipboard();
	
public:
	bool EmbeddImages;
	System::UnicodeString ImagePath;
	bool __fastcall Compile(const System::UnicodeString TargetFile);
	virtual System::UnicodeString __fastcall Description();
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	System::Classes::TStringList* __fastcall FlexMXML();
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TFlexExportFormat() : Vcltee::Teeexport::TTeeExportFormat() { }
	/* TTeeExportFormat.Destroy */ inline __fastcall virtual ~TFlexExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToFlexFile(Vcltee::Teeprocs::TCustomTeePanel* const APanel, const System::WideString FileName, int AWidth = 0x0, int AHeight = 0x0, bool EmbededImages = true);
}	/* namespace Teeflexcanvas */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFLEXCANVAS)
using namespace Vcltee::Teeflexcanvas;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeflexcanvasHPP
