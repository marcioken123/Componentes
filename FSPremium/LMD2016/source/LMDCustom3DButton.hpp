// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustom3DButton.pas' rev: 31.00 (Windows)

#ifndef Lmdcustom3dbuttonHPP
#define Lmdcustom3dbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDClass.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyph.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustom3dbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustom3DButton;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMD3DButtonBevelWidth;

class PASCALIMPLEMENTATION TLMDCustom3DButton : public Lmdbasegraphicbutton::TLMDBaseGraphicButton
{
	typedef Lmdbasegraphicbutton::TLMDBaseGraphicButton inherited;
	
private:
	TLMD3DButtonBevelWidth FBevelWidth;
	Lmdbuttonbase::TLMDButtonFace* FButtonFace;
	Lmdgraph::TLMDSavePixelFormat FPixelFormat;
	System::TObject* FClipX;
	System::Uitypes::TColor FColorLight;
	System::Uitypes::TColor FColorShadow;
	System::Uitypes::TColor FColorBevel;
	System::Uitypes::TColor FColorDisabled;
	bool FCompressed;
	void __fastcall SetBevelWidth(TLMD3DButtonBevelWidth aValue);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetQuickDraw(bool aValue);
	void __fastcall ReadBitmap(System::Classes::TStream* Stream);
	void __fastcall ReadCount(System::Classes::TReader* Reader);
	void __fastcall ReadWidth(System::Classes::TReader* Reader);
	void __fastcall WriteBitmap(System::Classes::TStream* Stream);
	void __fastcall WriteCount(System::Classes::TWriter* Writer);
	void __fastcall WriteWidth(System::Classes::TWriter* Writer);
	
protected:
	bool FQuickDraw;
	bool FProcessRunning;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall VerifyTransparency(int X, int Y);
	void __fastcall DoTerminate(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual bool __fastcall IsCustom(void);
	
public:
	int FKind;
	void __fastcall Set3DPics(Vcl::Graphics::TBitmap* TempUp, Vcl::Graphics::TBitmap* TempDown, Vcl::Graphics::TBitmap* TempDis, Vcl::Graphics::TBitmap* MonoUp, Vcl::Graphics::TBitmap* MonoDown, Vcl::Graphics::TBitmap* MonoDis);
	__fastcall virtual TLMDCustom3DButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustom3DButton(void);
	__property TLMD3DButtonBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=2};
	__property System::Uitypes::TColor ColorLight = {read=FColorLight, write=SetColor, index=0, default=-16777196};
	__property System::Uitypes::TColor ColorShadow = {read=FColorShadow, write=SetColor, index=1, default=-16777200};
	__property System::Uitypes::TColor ColorBevel = {read=FColorBevel, write=SetColor, index=2, default=0};
	__property System::Uitypes::TColor ColorDisabled = {read=FColorDisabled, write=SetColor, index=3, default=16777215};
	__property bool QuickDraw = {read=FQuickDraw, write=SetQuickDraw, default=1};
	
__published:
	__property ButtonLayout;
	__property EnterColor = {default=-16777207};
	__property EnterColorChange = {default=0};
	__property Glyph;
	__property Font;
	__property FontFX;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property NumGlyphs = {default=1};
	__property RepeatedClick = {default=0};
	__property RepeatingInterval = {default=100};
	__property RepeatingDelay = {default=500};
	__property UseCaption = {default=1};
	__property OnDropDown;
	__property AllowTransparency;
	__property Lmdbuttonbase::TLMDButtonFace* ButtonFace = {read=FButtonFace, write=FButtonFace};
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=0};
	__property GroupIndex = {default=0};
	__property Pressed = {default=0};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property Lmdgraph::TLMDSavePixelFormat PixelFormat = {read=FPixelFormat, write=FPixelFormat, default=0};
	__property Transparent = {default=0};
	__property MultiLine = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustom3dbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOM3DBUTTON)
using namespace Lmdcustom3dbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdcustom3dbuttonHPP
