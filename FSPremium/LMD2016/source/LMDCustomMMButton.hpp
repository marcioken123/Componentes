// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomMMButton.pas' rev: 31.00 (Windows)

#ifndef LmdcustommmbuttonHPP
#define LmdcustommmbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDBaseController.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDMMButtonFaceController.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDFXCaption.hpp>
#include <LMDGlyph.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustommmbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomMMButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomMMButton : public Lmdbasegraphicbutton::TLMDBaseGraphicButton
{
	typedef Lmdbasegraphicbutton::TLMDBaseGraphicButton inherited;
	
private:
	Lmdmmbuttonfacecontroller::TLMDMMButtonFaceController* FButtonFaceController;
	Lmdbasecontroller::TLMDChangeLink* FButtonFaceControllerLink;
	Lmdbuttonbase::TLMDButtonFace* FButtonFace;
	Vcl::Imglist::TCustomImageList* FButtonFaceImageList;
	Vcl::Imglist::TChangeLink* FButtonFaceChangeLink;
	Lmdbuttonbase::TLMDButtonFaceIndices FButtonFaceIndices;
	int FCaptionDown;
	System::Uitypes::TColor FTransCol;
	bool FForceTransparent;
	bool FQuickDraw;
	Lmdgraph::TLMDBitmapStyle FStyle;
	System::Types::TRect FFaceRect;
	void __fastcall SetButtonFaceController(Lmdmmbuttonfacecontroller::TLMDMMButtonFaceController* aValue);
	void __fastcall SetButtonFaceImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetCaptionDown(int aValue);
	void __fastcall SetQuickDraw(bool aValue);
	void __fastcall SetForceTransparent(bool aValue);
	void __fastcall SetStyle(Lmdgraph::TLMDBitmapStyle aValue);
	void __fastcall SetButtonFaceIndex(Lmdbuttonbase::TLMDButtonState Index, Lmdbuttonbase::TLMDButtonFaceIndex aValue);
	Lmdbuttonbase::TLMDButtonFaceIndex __fastcall GetButtonFaceIndex(Lmdbuttonbase::TLMDButtonState Index);
	bool __fastcall ButtonFaceIMLEmpty(Lmdbuttonbase::TLMDButtonState aValue);
	bool __fastcall HasButtonFaceIML(void);
	void __fastcall OldReadIndexIdent(System::Classes::TReader* Reader);
	void __fastcall OldReadTransColIdent(System::Classes::TReader* Reader);
	void __fastcall ReadIndexIdent_old(System::Classes::TStream* S);
	void __fastcall ReadIndexIdent(System::Classes::TStream* S);
	void __fastcall WriteIndexIdent(System::Classes::TStream* S);
	void __fastcall ButtonFaceReadIdent(System::Classes::TReader* Reader);
	void __fastcall ButtonFaceWriteIdent(System::Classes::TWriter* Writer);
	void __fastcall ReadTransColIdent(System::Classes::TStream* S);
	void __fastcall WriteTransColIdent(System::Classes::TStream* S);
	bool __fastcall ButtonFaceCheckCont(void);
	bool __fastcall ButtonFaceHasControl(void);
	
protected:
	void __fastcall AssignControllerValues(void);
	virtual bool __fastcall ButtonColorChange(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall GetButtonFaceIMLChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual bool __fastcall IsCustom(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall VerifyTransparency(int X, int Y);
	
public:
	__fastcall virtual TLMDCustomMMButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomMMButton(void);
	void __fastcall GetButtonFaceIndices(Lmdbuttonbase::TLMDButtonFaceIndices &aValue);
	void __fastcall SetButtonFaceIndices(const Lmdbuttonbase::TLMDButtonFaceIndices &aValue);
	void __fastcall SetTransCol(void);
	void __fastcall Synchronize(const bool aValue = false);
	__property Lmdbuttonbase::TLMDButtonFaceIndex ButtonFaceIndex[Lmdbuttonbase::TLMDButtonState index] = {read=GetButtonFaceIndex, write=SetButtonFaceIndex};
	
__published:
	__property Lmdmmbuttonfacecontroller::TLMDMMButtonFaceController* ButtonFaceController = {read=FButtonFaceController, write=SetButtonFaceController};
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
	__property AllowAllUp = {default=0};
	__property AllowMouseOver;
	__property AllowTransparency = {default=1};
	__property Lmdbuttonbase::TLMDButtonFace* ButtonFace = {read=FButtonFace, write=FButtonFace};
	__property Lmdgraph::TLMDBitmapStyle ButtonFaceStyle = {read=FStyle, write=SetStyle, default=0};
	__property Vcl::Imglist::TCustomImageList* ButtonFaceImageList = {read=FButtonFaceImageList, write=SetButtonFaceImageList, stored=ButtonFaceHasControl};
	__property int CaptionDown = {read=FCaptionDown, write=SetCaptionDown, default=1};
	__property bool ForceTransparent = {read=FForceTransparent, write=SetForceTransparent, default=1};
	__property GroupIndex = {default=0};
	__property bool QuickDraw = {read=FQuickDraw, write=SetQuickDraw, default=0};
	__property Pressed = {default=0};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property Transparent = {default=0};
	__property MultiLine = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustommmbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMMMBUTTON)
using namespace Lmdcustommmbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustommmbuttonHPP
