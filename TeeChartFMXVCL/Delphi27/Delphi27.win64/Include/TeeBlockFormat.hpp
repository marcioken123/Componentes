// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockFormat.pas' rev: 34.00 (Windows)

#ifndef TeeblockformatHPP
#define TeeblockformatHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockFormatEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockFormatEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Comctrls::TTabSheet* TabTexture;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label28;
	Vcltee::Tecanvas::TButtonColor* BlockColor;
	Vcl::Stdctrls::TScrollBar* BlockTransp;
	Vcl::Comctrls::TTrackBar* TBShininess;
	Vcl::Stdctrls::TCheckBox* BlockSolid;
	Vcl::Comctrls::TPageControl* PageTexture;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Buttons::TSpeedButton* SBTextureSelect;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Buttons::TSpeedButton* SBLoadExternal;
	Vcl::Stdctrls::TButton* BLoadPic;
	Vcl::Stdctrls::TButton* BSavePicture;
	Vcltee::Tecanvas::TComboFlat* BlockPictureLink;
	Vcl::Comctrls::TTabSheet* TabTextureFormat;
	Vcl::Stdctrls::TCheckBox* CBImageTransp;
	Vcl::Extctrls::TRadioGroup* RGTranspMode;
	Vcltee::Tecanvas::TButtonColor* BTranspColor;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Stdctrls::TCheckBox* CBImageAlpha;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TLabel* Label79;
	Vcl::Stdctrls::TScrollBar* BlockTextureRotate;
	Vcl::Stdctrls::TLabel* LTextureRotate;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label30;
	Vcl::Stdctrls::TLabel* Label31;
	Vcl::Stdctrls::TEdit* BlockTextureRepeatX;
	Vcl::Stdctrls::TEdit* BlockTextureRepeatY;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TScrollBar* BlockTextureTransX;
	Vcl::Stdctrls::TScrollBar* BlockTextureTransY;
	Vcl::Stdctrls::TScrollBar* BlockTextureTransZ;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TCheckBox* BlockBorderVisible;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TButtonColor* BlockBorderColor;
	Vcltee::Tecanvas::TComboFlat* BlockBorderStyle;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TScrollBar* BlockBorderTransp;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* BlockBorderWidth;
	Vcl::Comctrls::TUpDown* UDBorderWidth;
	Vcl::Stdctrls::TButton* BEmbeddPic;
	Vcl::Stdctrls::TLabel* LTextureX;
	Vcl::Stdctrls::TLabel* LTextureZ;
	Vcl::Stdctrls::TLabel* LTextureY;
	Vcl::Stdctrls::TCheckBox* CBAlphaInvert;
	Vcl::Stdctrls::TCheckBox* BlockColorDefault;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* BlockTextureRepeatZ;
	Vcl::Stdctrls::TCheckBox* BlockVisibleInterior;
	Vcl::Stdctrls::TCheckBox* BlockBright;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Stdctrls::TCheckBox* CBParentTexture;
	void __fastcall BlockTranspChange(System::TObject* Sender);
	void __fastcall TBShininessChange(System::TObject* Sender);
	void __fastcall CBImageTranspClick(System::TObject* Sender);
	void __fastcall RGTranspModeClick(System::TObject* Sender);
	void __fastcall BTranspColorClick(System::TObject* Sender);
	void __fastcall SBTextureSelectClick(System::TObject* Sender);
	void __fastcall BlockPictureLinkChange(System::TObject* Sender);
	void __fastcall BLoadPicClick(System::TObject* Sender);
	void __fastcall BlockSolidClick(System::TObject* Sender);
	void __fastcall SBLoadExternalClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BlockTextureRepeatXChange(System::TObject* Sender);
	void __fastcall BlockTextureRepeatYChange(System::TObject* Sender);
	void __fastcall BlockTextureRotateChange(System::TObject* Sender);
	void __fastcall CBImageAlphaClick(System::TObject* Sender);
	void __fastcall BlockTextureTransXChange(System::TObject* Sender);
	void __fastcall BlockTextureTransYChange(System::TObject* Sender);
	void __fastcall BlockTextureTransZChange(System::TObject* Sender);
	void __fastcall BlockBorderVisibleClick(System::TObject* Sender);
	void __fastcall BlockBorderStyleChange(System::TObject* Sender);
	void __fastcall BlockBorderTranspChange(System::TObject* Sender);
	void __fastcall BlockBorderWidthChange(System::TObject* Sender);
	void __fastcall BlockBorderColorClick(System::TObject* Sender);
	void __fastcall BEmbeddPicClick(System::TObject* Sender);
	void __fastcall PageTextureChange(System::TObject* Sender);
	void __fastcall CBAlphaInvertClick(System::TObject* Sender);
	void __fastcall BlockColorClick(System::TObject* Sender);
	void __fastcall BlockColorDefaultClick(System::TObject* Sender);
	void __fastcall BlockTextureRepeatZChange(System::TObject* Sender);
	void __fastcall BlockVisibleInteriorClick(System::TObject* Sender);
	void __fastcall BlockBrightClick(System::TObject* Sender);
	void __fastcall BSavePictureClick(System::TObject* Sender);
	void __fastcall CBParentTextureClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Teeblocks::TBlockFormat* IFormat;
	bool IModifying;
	bool ITextureDone;
	void __fastcall CheckTransparentControls();
	Teeblocks::TCustomBlock* __fastcall Current();
	void __fastcall SetPictureLink();
	
public:
	__classmethod int __fastcall FromScaleValue(const double Value);
	void __fastcall RefreshFormat(Teeblocks::TBlockFormat* AFormat);
	__classmethod double __fastcall ToScaleValue(const int Value);
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TBlockFormat* AFormat);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlockFormatEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlockFormatEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlockFormatEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlockFormatEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeblockformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKFORMAT)
using namespace Teeblockformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockformatHPP
