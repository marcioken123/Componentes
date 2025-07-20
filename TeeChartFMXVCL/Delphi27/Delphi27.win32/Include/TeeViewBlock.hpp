// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeViewBlock.pas' rev: 34.00 (Windows)

#ifndef TeeviewblockHPP
#define TeeviewblockHPP

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
#include <System.Types.hpp>
#include <TeeBlocks.hpp>
#include <TeeMakerControl.hpp>
#include <TeeCamera.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeviewblock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCameraViewBlock;
class DELPHICLASS TView2DBlock;
class DELPHICLASS TCameraViewBlockEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCameraViewBlock : public Teeblocks::TRectangleBlock
{
	typedef Teeblocks::TRectangleBlock inherited;
	
private:
	Teecamera::TMakerCamera* FCamera;
	Vcl::Graphics::TBitmap* IBitmap;
	bool IRefreshing;
	void __fastcall CameraChanged(System::TObject* Sender);
	void __fastcall SetCamera(Teecamera::TMakerCamera* const Value);
	
protected:
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TCameraViewBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCameraViewBlock();
	virtual void __fastcall DrawBlock()/* overload */;
	
__published:
	__property Teecamera::TMakerCamera* Camera = {read=FCamera, write=SetCamera};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  DrawBlock(Teeblocks::TBlocks* AItems){ Teeblocks::TCustomBlock::DrawBlock(AItems); }
	
};


class PASCALIMPLEMENTATION TView2DBlock : public Teeblocks::TRectangleBlock
{
	typedef Teeblocks::TRectangleBlock inherited;
	
private:
	bool IRefreshing;
	
public:
	virtual void __fastcall Draw();
public:
	/* TRectangleBlock.Create */ inline __fastcall virtual TView2DBlock(System::Classes::TComponent* AOwner) : Teeblocks::TRectangleBlock(AOwner) { }
	/* TRectangleBlock.Destroy */ inline __fastcall virtual ~TView2DBlock() { }
	
};


class PASCALIMPLEMENTATION TCameraViewBlockEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	TCameraViewBlock* View;
	Teecamera::TCameraEditor* ICameraEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCameraViewBlockEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCameraViewBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCameraViewBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCameraViewBlockEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeviewblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEVIEWBLOCK)
using namespace Teeviewblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeviewblockHPP
