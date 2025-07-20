// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeFacesBlock.pas' rev: 34.00 (Windows)

#ifndef TeefacesblockHPP
#define TeefacesblockHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeePointEditor.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Math.Vectors.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teefacesblock
{
//-- forward type declarations -----------------------------------------------
struct TVertexNormal;
struct TGroupNormals;
struct TVertexGroups;
class DELPHICLASS TGeometry;
struct TFaceVertex;
struct TFaceMaterial;
struct TFace;
struct TFacePreview;
class DELPHICLASS TFacesBlock;
class DELPHICLASS TFacesBlockEditor;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TVertexNormal
{
public:
	System::Math::Vectors::TPoint3D Normal;
	int Count;
};


struct DECLSPEC_DRECORD TGroupNormals
{
public:
	int Group;
	int Normal;
};


typedef System::DynamicArray<TVertexNormal> TVertexNormals;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TVertexGroups
{
	
private:
	typedef System::DynamicArray<TGroupNormals> _TVertexGroups__1;
	
	
public:
	System::Math::Vectors::TPoint3D Vertex;
	_TVertexGroups__1 NormalGroups;
	int NormalCount;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TGeometry : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TVertexGroups> _TGeometry__1;
	
	typedef System::DynamicArray<unsigned> _TGeometry__2;
	
	
protected:
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
public:
	_TGeometry__1 Vertex;
	int VertexCount;
	Vcltee::Tecanvas::TPoint3DArray Texture;
	int TextureCount;
	TVertexNormals Normals;
	int NormalCount;
	_TGeometry__2 SmoothGroups;
	__fastcall virtual ~TGeometry();
	void __fastcall AddVertex(const float AX, const float AY, const float AZ);
	void __fastcall AverageNormals();
	void __fastcall Clear();
	void __fastcall ClearSmoothGroups();
	unsigned __fastcall NewSmoothGroup(const unsigned Number);
public:
	/* TObject.Create */ inline __fastcall TGeometry() : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TFaceVertex
{
public:
	int Vertex;
	int Texture;
	int Normal;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TFaceMaterial
{
public:
	System::UnicodeString Name;
	Vcltee::Tecanvas::TRGB Ambient;
	Vcltee::Tecanvas::TRGB Diffuse;
	Vcltee::Tecanvas::TRGB Specular;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TFace
{
	
private:
	typedef System::DynamicArray<TFaceVertex> _TFace__1;
	
	
public:
	_TFace__1 Data;
	bool Line;
	bool HasTextures;
	int SmoothGroup;
	int Material;
};
#pragma pack(pop)


typedef System::DynamicArray<TFace> TFaces;

enum DECLSPEC_DENUM TFaceOutline : unsigned char { foNone, foOutline, foOutlineVertex, foOutlineAll, foAllVertexes };

struct DECLSPEC_DRECORD TFacePreview
{
public:
	System::Uitypes::TColor Color;
	int Length;
	bool Normals;
	TFaceOutline Outline;
	int SelectedFace;
	int SelectedVertex;
};


typedef Vcltee::Tecanvas::TRGB __fastcall (__closure *TGetColorProc)(int Material);

class PASCALIMPLEMENTATION TFacesBlock : public Teeblocks::TCustomBlock
{
	typedef Teeblocks::TCustomBlock inherited;
	
private:
	bool NotSaveFaces;
	int IList;
	int IListPen;
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	TGetColorProc GetMaterialColor;
	bool OwnsGeometry;
	void __fastcall AddFace(const int *Vertexes, const int Vertexes_High)/* overload */;
	bool __fastcall CalcFaceBounds(int Face, /* out */ System::Math::Vectors::TPoint3D &Min, /* out */ System::Math::Vectors::TPoint3D &Max);
	bool __fastcall CalcNormals();
	void __fastcall ClearNormals();
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DeleteLists();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	
public:
	TFaces Faces;
	int FacesCount;
	TGeometry* Geometry;
	TFacePreview Preview;
	__fastcall virtual ~TFacesBlock();
	virtual void __fastcall Draw();
	__classmethod void __fastcall InitPreview(TFacePreview &Preview);
public:
	/* TCustomBlock.Create */ inline __fastcall virtual TFacesBlock(System::Classes::TComponent* AOwner) : Teeblocks::TCustomBlock(AOwner) { }
	
};


typedef void __fastcall (__closure *TLocateVertexEvent)(System::TObject* Sender, int Index);

class PASCALIMPLEMENTATION TFacesBlockEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CBPreviewNormals;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* LFaceCount;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTrackBar* TBFace;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* LVertexCount;
	Vcl::Stdctrls::TCheckBox* CBLine;
	Vcl::Stdctrls::TEdit* ESmooth;
	Vcl::Comctrls::TUpDown* UDSmooth;
	Vcl::Stdctrls::TEdit* EFace;
	Vcltee::Tecanvas::TComboFlat* CBOutline;
	Vcl::Stdctrls::TLabel* LSmoothGroup;
	Vcltee::Tecanvas::TComboFlat* CBMaterial;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TListBox* LVertex;
	Vcl::Extctrls::TPanel* PanelPoint;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* LVertexIndex;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Buttons::TSpeedButton* SBNextFace;
	Vcl::Buttons::TSpeedButton* SBPrevFace;
	void __fastcall CBPreviewNormalsClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TBFaceChange(System::TObject* Sender);
	void __fastcall CBLineClick(System::TObject* Sender);
	void __fastcall LVertexClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ESmoothChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBOutlineClick(System::TObject* Sender);
	void __fastcall EFaceChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CBMaterialChange(System::TObject* Sender);
	void __fastcall SBNextFaceClick(System::TObject* Sender);
	void __fastcall SBPrevFaceClick(System::TObject* Sender);
	
private:
	TFacesBlock* Face;
	Vcltee::Tecanvas::TPointXYZFloat* XYZ;
	Teepointeditor::TPointEditor* IPoint;
	TLocateVertexEvent FOnLocateVertex;
	int __fastcall VertexIndex();
	void __fastcall XYZChanged(System::TObject* Sender);
	
public:
	__property TLocateVertexEvent OnLocateVertex = {read=FOnLocateVertex, write=FOnLocateVertex};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFacesBlockEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFacesBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFacesBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFacesBlockEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefacesblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEFACESBLOCK)
using namespace Teefacesblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeefacesblockHPP
