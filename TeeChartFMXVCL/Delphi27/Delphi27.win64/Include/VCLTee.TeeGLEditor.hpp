// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGLEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegleditorHPP
#define Vcltee_TeegleditorHPP

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
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeeOpenGL.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeGLCanvas.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegleditor
{
//-- forward type declarations -----------------------------------------------
struct TTeeOpenGLBackup;
class DELPHICLASS TFormTeeGLEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TTeeOpenGLBackup
{
public:
	bool Active;
	int AmbientLight;
	bool FontOutlines;
	System::Uitypes::TColor LightColor;
	bool LightVisible;
	double LightX;
	double LightY;
	double LightZ;
	bool ShadeQuality;
	double Shininess;
	double FontExtrusion;
	Vcltee::Tecanvas::TTeeCanvasSurfaceStyle DrawStyle;
	int Tilt;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TFormTeeGLEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Extctrls::TPanel* PanelActive;
	Vcl::Stdctrls::TCheckBox* CBActive;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Comctrls::TTabSheet* TabLighting;
	Vcltee::Tecanvas::TComboFlat* CBFontStyle;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* EFontDepth;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Comctrls::TTabControl* TabLights;
	Vcl::Comctrls::TPageControl* PageControlLight;
	Vcl::Comctrls::TTabSheet* TabLightPos;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* LightPosX;
	Vcl::Stdctrls::TLabel* LightPosY;
	Vcl::Stdctrls::TLabel* LightPosZ;
	Vcl::Comctrls::TTrackBar* TBX;
	Vcl::Comctrls::TTrackBar* TBY;
	Vcl::Comctrls::TTrackBar* TBZ;
	Vcl::Stdctrls::TCheckBox* CBFixed;
	Vcl::Comctrls::TTabSheet* TabLightDir;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Comctrls::TTrackBar* TBXDirection;
	Vcl::Comctrls::TTrackBar* TBYDirection;
	Vcl::Comctrls::TTrackBar* TBZDirection;
	Vcl::Stdctrls::TCheckBox* CBUseDirection;
	Vcl::Comctrls::TTabSheet* TabLightAmount;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Comctrls::TTrackBar* TBDiffuse;
	Vcl::Comctrls::TTrackBar* TBSpecular;
	Vcl::Comctrls::TTabSheet* TabLightSpot;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Comctrls::TUpDown* UDSpot;
	Vcl::Stdctrls::TEdit* ESpot;
	Vcl::Stdctrls::TCheckBox* CBDefaultSpot;
	Vcl::Comctrls::TTrackBar* TBSpotExp;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TCheckBox* CBVisible;
	Vcltee::Tecanvas::TButtonColor* BLightColor;
	Vcl::Comctrls::TTrackBar* TBColor;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TCheckBox* CBShade;
	Vcl::Comctrls::TTrackBar* TBAmbient;
	Vcl::Comctrls::TTrackBar* TBShine;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Stdctrls::TCheckBox* CBAntialias;
	Vcl::Stdctrls::TScrollBar* SBTilt;
	Vcl::Stdctrls::TCheckBox* CBTextureQuality;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TMemo* MemoInfo;
	Vcl::Stdctrls::TCheckBox* CBSync;
	Vcl::Stdctrls::TCheckBox* CBLightHelpers;
	Vcl::Stdctrls::TLabel* LightDirX;
	Vcl::Stdctrls::TLabel* LightDirY;
	Vcl::Stdctrls::TLabel* LightDirZ;
	void __fastcall BOKClick(System::TObject* Sender);
	void __fastcall CBShadeClick(System::TObject* Sender);
	void __fastcall EFontDepthChange(System::TObject* Sender);
	void __fastcall TBShineChange(System::TObject* Sender);
	void __fastcall TBAmbientChange(System::TObject* Sender);
	void __fastcall CBActiveClick(System::TObject* Sender);
	void __fastcall CBVisibleClick(System::TObject* Sender);
	void __fastcall TBColorChange(System::TObject* Sender);
	void __fastcall TBXChange(System::TObject* Sender);
	void __fastcall TBYChange(System::TObject* Sender);
	void __fastcall TBZChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BCancelClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabLightsChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBFixedClick(System::TObject* Sender);
	void __fastcall BLightColorClick(System::TObject* Sender);
	void __fastcall ESpotChange(System::TObject* Sender);
	void __fastcall TBXDirectionChange(System::TObject* Sender);
	void __fastcall TBYDirectionChange(System::TObject* Sender);
	void __fastcall TBZDirectionChange(System::TObject* Sender);
	void __fastcall CBUseDirectionClick(System::TObject* Sender);
	void __fastcall CBDefaultSpotClick(System::TObject* Sender);
	void __fastcall CBAntialiasClick(System::TObject* Sender);
	void __fastcall SBTiltChange(System::TObject* Sender);
	void __fastcall TBDiffuseChange(System::TObject* Sender);
	void __fastcall TBSpecularChange(System::TObject* Sender);
	void __fastcall TBSpotExpChange(System::TObject* Sender);
	void __fastcall CBTextureQualityClick(System::TObject* Sender);
	void __fastcall CBFontStyleChange(System::TObject* Sender);
	void __fastcall CBSyncClick(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall CBLightHelpersClick(System::TObject* Sender);
	
private:
	bool CreatingForm;
	bool IRefreshingLight;
	Vcltee::Teeopengl::TTeeOpenGL* GL;
	TTeeOpenGLBackup GLBackup;
	Vcltee::Teeglcanvas::TGLCanvas* GLCanvas;
	void __fastcall RefreshGLCanvas();
	void __fastcall RefreshInfo();
	void __fastcall SetLight(Vcltee::Teeopengl::TGLLightSource* const ALight);
	Vcltee::Teeopengl::TGLLightSource* __fastcall TheLight();
	
public:
	void __fastcall RefreshOpenGL(Vcltee::Teeopengl::TTeeOpenGL* const AOpenGL);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormTeeGLEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormTeeGLEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormTeeGLEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormTeeGLEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall EditTeeOpenGL(System::Classes::TComponent* const AOwner, Vcltee::Teeopengl::TTeeOpenGL* const ATeeOpenGL);
}	/* namespace Teegleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGLEDITOR)
using namespace Vcltee::Teegleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegleditorHPP
