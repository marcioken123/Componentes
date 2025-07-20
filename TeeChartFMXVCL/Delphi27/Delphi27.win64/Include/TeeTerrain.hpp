// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeTerrain.pas' rev: 34.00 (Windows)

#ifndef TeeterrainHPP
#define TeeterrainHPP

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
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <System.Math.Vectors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeterrain
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTerrainBlock;
class DELPHICLASS TTerrainEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTerrainBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
	
private:
	typedef System::DynamicArray<Vcltee::Tecanvas::TPoint3DArray> _TTerrainBlock__1;
	
	typedef System::DynamicArray<int> _TTerrainBlock__2;
	
	typedef System::DynamicArray<Teeblocks::TRGBAlpha> _TTerrainBlock__3;
	
	typedef System::DynamicArray<System::DynamicArray<Teeblocks::TRGBAlpha> > _TTerrainBlock__4;
	
	typedef System::DynamicArray<double> _TTerrainBlock__5;
	
	typedef System::DynamicArray<System::DynamicArray<double> > _TTerrainBlock__6;
	
	
private:
	bool FDrawNormals;
	System::UnicodeString FHeightMap;
	bool FUseLists;
	System::Types::TPoint IBoundsLow;
	System::Types::TPoint IBoundsHigh;
	Vcltee::Tecanvas::TFloatPoint IBoundsZ;
	bool INormalsDone;
	_TTerrainBlock__1 Normals;
	bool FInvert;
	_TTerrainBlock__2 ICallLists;
	void __fastcall FillSampleGrid(int AX, int AY);
	void __fastcall InvertGrid();
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall SetDrawNormals(const bool Value);
	void __fastcall SetHeightMap(const System::UnicodeString Value);
	void __fastcall SetInvert(const bool Value);
	void __fastcall SetUseLists(const bool Value);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DeleteLists();
	void __fastcall InternalRecalcBounds();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	_TTerrainBlock__4 Colors;
	_TTerrainBlock__6 Grid;
	__fastcall virtual TTerrainBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTerrainBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	Vcl::Graphics::TBitmap* __fastcall GetAsBitmap();
	System::Types::TPoint __fastcall GridSize();
	void __fastcall Load(Vcl::Graphics::TGraphic* Graphic)/* overload */;
	void __fastcall Load(const System::UnicodeString PictureFileName)/* overload */;
	void __fastcall RecalcBounds();
	
__published:
	__property bool DrawNormals = {read=FDrawNormals, write=SetDrawNormals, default=0};
	__property System::UnicodeString HeightMap = {read=FHeightMap, write=SetHeightMap};
	__property bool InvertHeight = {read=FInvert, write=SetInvert, default=0};
	__property bool OptimizeSpeed = {read=FUseLists, write=SetUseLists, default=1};
};


class PASCALIMPLEMENTATION TTerrainEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* LTerrainSize;
	Vcl::Stdctrls::TGroupBox* GroupBox11;
	Vcl::Stdctrls::TLabel* Label81;
	Vcl::Stdctrls::TLabel* LTerrainHeightMap;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TCheckBox* BlockTerrainSpeed;
	Vcl::Stdctrls::TButton* Button5;
	Vcl::Stdctrls::TCheckBox* CBInvert;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TCheckBox* CBNormals;
	void __fastcall CBInvertClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall BlockTerrainSpeedClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CBNormalsClick(System::TObject* Sender);
	
private:
	TTerrainBlock* Terrain;
	void __fastcall ChangeHeightMap(const System::UnicodeString FileName);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTerrainEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTerrainEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTerrainEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTerrainEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeterrain */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEETERRAIN)
using namespace Teeterrain;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeterrainHPP
