// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeObjFormat.pas' rev: 34.00 (Windows)

#ifndef TeeobjformatHPP
#define TeeobjformatHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeFacesBlock.hpp>
#include <VCLTee.TeeGeometry.hpp>
#include <VCLTee.OpenGL2.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeePointEditor.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeobjformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBaseObjBlock;
class DELPHICLASS TObjBlock;
class DELPHICLASS TObjBlockEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBaseObjBlock : public Teeblocks::TCustomObjectBlock
{
	typedef Teeblocks::TCustomObjectBlock inherited;
	
	
private:
	typedef System::DynamicArray<Teefacesblock::TFaceMaterial> _TBaseObjBlock__1;
	
	
private:
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall VertexBounds(System::Math::Vectors::TPoint3D &Min, System::Math::Vectors::TPoint3D &Max);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	_TBaseObjBlock__1 FMaterials;
	Teefacesblock::TGeometry* Geometry;
	Teefacesblock::TFacesBlock* Group;
	void __fastcall CalculateNormals();
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	int __fastcall FindMaterial(const System::UnicodeString AName);
	void __fastcall NormalizeVertexes();
	void __fastcall RecalcNormals();
	void __fastcall ResetPreviewNormals();
	
public:
	Teefacesblock::TFacePreview Preview;
	__fastcall virtual TBaseObjBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBaseObjBlock();
	virtual void __fastcall Clear();
};


class PASCALIMPLEMENTATION TObjBlock : public TBaseObjBlock
{
	typedef TBaseObjBlock inherited;
	
private:
	System::Classes::TStringList* IMaterial;
	System::Uitypes::TColor OldColor;
	System::UnicodeString OldPicLink;
	int OldSmoothGroup;
	void __fastcall Process(System::UnicodeString S);
	
protected:
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	virtual void __fastcall LoadItems(const System::UnicodeString ASource, const System::UnicodeString AFile);
	
public:
	__fastcall virtual ~TObjBlock();
	virtual void __fastcall Clear();
	
__published:
	__property Items;
	__property LinkFile = {default=0};
	__property Properties;
public:
	/* TBaseObjBlock.Create */ inline __fastcall virtual TObjBlock(System::Classes::TComponent* AOwner) : TBaseObjBlock(AOwner) { }
	
};


class PASCALIMPLEMENTATION TObjBlockEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TMemo* MemoInfo;
	Vcl::Comctrls::TTabSheet* TabNormals;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TMemo* MemoMaterial;
	Vcl::Stdctrls::TCheckBox* CBPreviewNormals;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TButtonColor* BNormalColor;
	Vcl::Stdctrls::TEdit* ENormalLength;
	Vcl::Comctrls::TUpDown* UDLength;
	Vcl::Comctrls::TTabSheet* TabGroups;
	Vcl::Stdctrls::TListBox* LBGroups;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CBFaceVisible;
	Vcl::Stdctrls::TCheckBox* CBShowCurrent;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* SortbyTitle1;
	Vcl::Menus::TMenuItem* SortbyIndex1;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTrackBar* TBVertex;
	Vcl::Stdctrls::TEdit* EVertex;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabVertexFaces;
	Vcl::Comctrls::TTabSheet* TabVertexPoint;
	Vcl::Stdctrls::TListBox* LVertexFaces;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall CBPreviewNormalsClick(System::TObject* Sender);
	void __fastcall ENormalLengthChange(System::TObject* Sender);
	void __fastcall BNormalColorClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall LBGroupsClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBFaceVisibleClick(System::TObject* Sender);
	void __fastcall CBShowCurrentClick(System::TObject* Sender);
	void __fastcall SortbyTitle1Click(System::TObject* Sender);
	void __fastcall SortbyIndex1Click(System::TObject* Sender);
	void __fastcall TBVertexChange(System::TObject* Sender);
	void __fastcall EVertexChange(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	TBaseObjBlock* ObjBlock;
	Teefacesblock::TFacesBlockEditor* IFaceEditor;
	Teepointeditor::TPointEditor* IPoint;
	Vcltee::Tecanvas::TPointXYZFloat* XYZ;
	Teefacesblock::TFacesBlock* __fastcall CurrentFaceBlock();
	void __fastcall FillGroups();
	void __fastcall LocateVertex(System::TObject* Sender, int Index);
	void __fastcall ResortGroups();
	void __fastcall ShowStats();
	void __fastcall XYZChanged(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TObjBlockEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TObjBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TObjBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TObjBlockEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeObjExtension L".obj"
}	/* namespace Teeobjformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEOBJFORMAT)
using namespace Teeobjformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeobjformatHPP
