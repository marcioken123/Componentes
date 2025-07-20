// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeCamera.pas' rev: 34.00 (Windows)

#ifndef TeecameraHPP
#define TeecameraHPP

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
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teecamera
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFrameBuffer;
class DELPHICLASS TMakerCamera;
class DELPHICLASS TMakerCameras;
class DELPHICLASS TCameraEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFrameBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned fb;
	unsigned color_rb;
	unsigned depth_rb;
	unsigned status;
	int W;
	int H;
	bool HasDepth;
	bool FEnabled;
	void __fastcall SetEnabled(const bool Value);
	
public:
	__fastcall TFrameBuffer(const int Width, const int Height, bool Depth);
	__fastcall virtual ~TFrameBuffer();
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TMakerCamera : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcltee::Tecanvas::TPointXYZFloat* FLocation;
	System::Classes::TNotifyEvent FOnChange;
	double FPerspective;
	Vcltee::Tecanvas::TPointXYZFloat* FRotation;
	System::UnicodeString FTitle;
	double FZoom;
	TFrameBuffer* IBuffer;
	Vcltee::Tecanvas::TView3DOptions* IViewBackup;
	HIDESBASE void __fastcall Changed(System::TObject* Sender);
	void __fastcall SetLocation(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetPerspective(const double Value);
	void __fastcall SetRotation(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetZoom(const double Value);
	
public:
	Vcltee::Tecanvas::TView3DOptions* View;
	__fastcall virtual TMakerCamera(System::Classes::TCollection* AOwner);
	__fastcall virtual ~TMakerCamera();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DrawToBitmap(Vcltee::Teeprocs::TCustomTeePanel* const APanel, Vcl::Graphics::TBitmap* const ABitmap, unsigned ATexture = (unsigned)(0x0));
	void __fastcall SetFromView(Vcltee::Tecanvas::TView3DOptions* const AView);
	void __fastcall SetToView(Vcltee::Tecanvas::TView3DOptions* const View);
	
__published:
	__property Vcltee::Tecanvas::TPointXYZFloat* Location = {read=FLocation, write=SetLocation};
	__property double Perspective = {read=FPerspective, write=SetPerspective};
	__property Vcltee::Tecanvas::TPointXYZFloat* Rotation = {read=FRotation, write=SetRotation};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property double Zoom = {read=FZoom, write=SetZoom};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TMakerCameras : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TMakerCamera* operator[](int Index) { return this->Camera[Index]; }
	
private:
	TMakerCamera* FSelected;
	TMakerCamera* __fastcall Get(int Index);
	int __fastcall GetCurrent();
	void __fastcall Put(int Index, TMakerCamera* const Value);
	void __fastcall SetCurrent(int Index);
	void __fastcall SetSelected(TMakerCamera* Value);
	
public:
	__property TMakerCamera* Camera[int Index] = {read=Get, write=Put/*, default*/};
	__property TMakerCamera* Selected = {read=FSelected, write=SetSelected};
	
__published:
	__property int Current = {read=GetCurrent, write=SetCurrent, default=-1};
public:
	/* TOwnedCollection.Create */ inline __fastcall TMakerCameras(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TMakerCameras() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCameraEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* LRotation;
	Vcl::Stdctrls::TLabel* LElevation;
	Vcl::Stdctrls::TLabel* LTilt;
	Vcl::Stdctrls::TLabel* LXOffset;
	Vcl::Stdctrls::TLabel* LYOffset;
	Vcl::Stdctrls::TLabel* LZOffset;
	Vcl::Stdctrls::TLabel* Label123;
	Vcl::Stdctrls::TLabel* LZoom;
	Vcl::Stdctrls::TLabel* Label24;
	Vcl::Stdctrls::TLabel* LCameraPerspective;
	Vcl::Stdctrls::TScrollBar* CameraTilt;
	Vcl::Stdctrls::TScrollBar* CameraElevation;
	Vcl::Stdctrls::TScrollBar* CameraRotation;
	Vcl::Stdctrls::TScrollBar* CameraZoom;
	Vcl::Stdctrls::TScrollBar* CameraPerspective;
	Vcl::Stdctrls::TLabel* Label9;
	void __fastcall CameraTiltChange(System::TObject* Sender);
	void __fastcall CameraElevationChange(System::TObject* Sender);
	void __fastcall CameraRotationChange(System::TObject* Sender);
	void __fastcall CameraZoomChange(System::TObject* Sender);
	void __fastcall CameraPerspectiveChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	TMakerCamera* Camera;
	bool IModifying;
	
public:
	void __fastcall RefreshCamera(TMakerCamera* ACamera);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCameraEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCameraEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCameraEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCameraEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecamera */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECAMERA)
using namespace Teecamera;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeecameraHPP
