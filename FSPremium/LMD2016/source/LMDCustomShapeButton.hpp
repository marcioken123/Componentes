// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomShapeButton.pas' rev: 31.00 (Windows)

#ifndef LmdcustomshapebuttonHPP
#define LmdcustomshapebuttonHPP

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
#include <Vcl.ImgList.hpp>
#include <LMDShapeBase.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDShapeButtonColor.hpp>
#include <LMDShape.hpp>
#include <LMDPointList.hpp>
#include <LMDCont.hpp>
#include <LMDShadow.hpp>
#include <LMDShapeFill.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDButtonLayout.hpp>
#include <System.UITypes.hpp>
#include <LMDFXCaption.hpp>
#include <LMDGlyph.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomshapebutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomShapeButton;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShapeButtonStyle : unsigned char { sbsShadow, sbs3D };

class PASCALIMPLEMENTATION TLMDCustomShapeButton : public Lmdbasegraphicbutton::TLMDBaseGraphicButton
{
	typedef Lmdbasegraphicbutton::TLMDBaseGraphicButton inherited;
	
private:
	Lmdshape::TLMDShape* FShape;
	Lmdshapebuttoncolor::TLMDShapeButtonColor* FColors;
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdshapefill::TLMDShapeFill* FShapeFill;
	Vcl::Imglist::TCustomImageList* FBtnFaceImageList;
	int FBtnFaceIndex;
	int FBtnFaceListIndex;
	Vcl::Imglist::TChangeLink* FBtnFaceChangeLink;
	void __fastcall SetBtnFaceImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetBtnFaceIndex(int index, int aValue);
	void __fastcall SetMode(Lmdshapebase::TLMDShapeButtonMode aValue);
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	HIDESBASE bool __fastcall CheckCont(void);
	HIDESBASE bool __fastcall HasControl(void);
	void __fastcall SetShapeFill(Lmdshapefill::TLMDShapeFill* aValue);
	void __fastcall SetColors(Lmdshapebuttoncolor::TLMDShapeButtonColor* aValue);
	void __fastcall SetBevel3D(bool aValue);
	void __fastcall SetShape(Lmdshape::TLMDShape* aValue);
	void __fastcall SetShapeStyle(TLMDShapeButtonStyle aValue);
	void __fastcall ReadBool(System::Classes::TReader* Reader);
	
protected:
	TLMDShapeButtonStyle FStyle;
	Lmdshapebase::TLMDShapeButtonMode FMode;
	bool FBevel3D;
	Vcl::Graphics::TBrush* FBrush;
	Lmdpointlist::TLMDPointList* FList;
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall GetIMLFaceChange(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	bool __fastcall IMLFaceEmpty(void);
	virtual bool __fastcall IsCustom(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall ButtonColorChange(void);
	virtual bool __fastcall VerifyTransparency(int X, int Y);
	__property bool Bevel3D = {read=FBevel3D, write=SetBevel3D, default=0};
	
public:
	__fastcall virtual TLMDCustomShapeButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomShapeButton(void);
	virtual void __fastcall Paint(void);
	__property MouseOver;
	
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
	__property AllowMouseOver;
	__property AllowAllUp = {default=0};
	__property Lmdshapebuttoncolor::TLMDShapeButtonColor* Colors = {read=FColors, write=SetColors};
	__property GroupIndex = {default=0};
	__property Pressed = {default=0};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property Lmdshapebase::TLMDShapeButtonMode Mode = {read=FMode, write=SetMode, default=0};
	__property Lmdshape::TLMDShape* Shape = {read=FShape, write=SetShape};
	__property TLMDShapeButtonStyle Style = {read=FStyle, write=SetShapeStyle, default=0};
	__property Transparent = {default=0};
	__property Lmdshapefill::TLMDShapeFill* ShapeFill = {read=FShapeFill, write=SetShapeFill};
	__property Vcl::Imglist::TCustomImageList* ShapeFillImageList = {read=FBtnFaceImageList, write=SetBtnFaceImageList, stored=HasControl};
	__property int ShapeFillImageIndex = {read=FBtnFaceIndex, write=SetBtnFaceIndex, index=0, default=0};
	__property int ShapeFillListIndex = {read=FBtnFaceListIndex, write=SetBtnFaceIndex, index=1, default=0};
	__property MultiLine = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomshapebutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSHAPEBUTTON)
using namespace Lmdcustomshapebutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomshapebuttonHPP
