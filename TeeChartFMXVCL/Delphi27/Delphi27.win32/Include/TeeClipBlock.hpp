// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeClipBlock.pas' rev: 34.00 (Windows)

#ifndef TeeclipblockHPP
#define TeeclipblockHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeePointEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeclipblock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TClipPlane;
class DELPHICLASS TClipPlanes;
class DELPHICLASS TClipBlock;
class DELPHICLASS TClipBlockEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TClipPlane : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FActive;
	Vcltee::Tecanvas::TPointXYZFloat* FPlane;
	double FPosition;
	TClipBlock* IOwner;
	void __fastcall Changed(System::TObject* Sender);
	void __fastcall DrawPreview(const double RotX, const double RotY, const double RotZ);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetPlane(Vcltee::Tecanvas::TPointXYZFloat* const Value);
	void __fastcall SetPosition(const double Value);
	
public:
	__fastcall TClipPlane();
	__fastcall virtual ~TClipPlane();
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Vcltee::Tecanvas::TPointXYZFloat* Plane = {read=FPlane, write=SetPlane};
	__property double Position = {read=FPosition, write=SetPosition};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TClipPlanes : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TClipPlane* FBottom;
	TClipPlane* FFront;
	TClipPlane* FBack;
	TClipPlane* FRight;
	TClipPlane* FLeft;
	TClipPlane* FTop;
	void __fastcall DisableClip();
	void __fastcall EnableClip();
	void __fastcall SetBack(TClipPlane* const Value);
	void __fastcall SetBottom(TClipPlane* const Value);
	void __fastcall SetFront(TClipPlane* const Value);
	void __fastcall SetLeft(TClipPlane* const Value);
	void __fastcall SetRight(TClipPlane* const Value);
	void __fastcall SetTop(TClipPlane* const Value);
	
public:
	bool Preview;
	__fastcall TClipPlanes();
	__fastcall virtual ~TClipPlanes();
	__classmethod void __fastcall ClipPlane(TClipPlane* APlane, int Index);
	
__published:
	__property TClipPlane* Left = {read=FLeft, write=SetLeft};
	__property TClipPlane* Right = {read=FRight, write=SetRight};
	__property TClipPlane* Top = {read=FTop, write=SetTop};
	__property TClipPlane* Bottom = {read=FBottom, write=SetBottom};
	__property TClipPlane* Front = {read=FFront, write=SetFront};
	__property TClipPlane* Back = {read=FBack, write=SetBack};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TClipBlock : public Teeblocks::TObjectBlock
{
	typedef Teeblocks::TObjectBlock inherited;
	
private:
	TClipPlanes* FPlanes;
	void __fastcall SetPlanes(TClipPlanes* const Value);
	
protected:
	virtual void __fastcall DoDrawItems();
	
public:
	__fastcall virtual TClipBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TClipBlock();
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	
__published:
	__property TClipPlanes* Planes = {read=FPlanes, write=SetPlanes};
};


class PASCALIMPLEMENTATION TClipBlockEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TListBox* ListBox1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* PanelPoint;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TCheckBox* CBPreview;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CBActive;
	Vcl::Stdctrls::TEdit* EPosition;
	Vcl::Stdctrls::TScrollBar* ScrollBar1;
	void __fastcall ListBox1Click(System::TObject* Sender);
	void __fastcall EPositionChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBActiveClick(System::TObject* Sender);
	void __fastcall ScrollBar1Change(System::TObject* Sender);
	void __fastcall CBPreviewClick(System::TObject* Sender);
	
private:
	TClipPlane* IPlane;
	Teepointeditor::TPointEditor* IPoint;
	TClipBlock* Clip;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TClipBlockEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TClipBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TClipBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TClipBlockEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeclipblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECLIPBLOCK)
using namespace Teeclipblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeclipblockHPP
