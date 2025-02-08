// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomGraphicLabel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomgraphiclabelHPP
#define LmdcustomgraphiclabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGrlf.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMDFXCaption.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomgraphiclabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomGraphicLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomGraphicLabel : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	Lmdgrlf::TLMDToggle FToggle;
	Lmdfxcaption::TLMDFxCaption* FFontFX;
	int FPerspectiveDepth;
	int FFactor;
	Lmdgrlf::TLMDTransLabelTypes FTransform;
	Lmdgrlf::TLMDTransLabelAttr FTransAttr;
	Lmdgrlf::TLMDPerspective FPerspective;
	bool FInvertCaption;
	bool FAutoSize;
	Lmdfillobject::TLMDFillObject* FFillObject;
	System::Uitypes::TColor FBrushBack;
	void __fastcall SetBrushBack(System::Uitypes::TColor aValue);
	void __fastcall SetToggle(Lmdgrlf::TLMDToggle Value);
	void __fastcall SetInteger(int Index, int Value);
	void __fastcall SetBoolean(int Index, bool Value);
	void __fastcall SetFontFX(Lmdfxcaption::TLMDFxCaption* Value);
	void __fastcall SetTransform(Lmdgrlf::TLMDTransLabelTypes Value);
	void __fastcall SetTransAttr(Lmdgrlf::TLMDTransLabelAttr Value);
	void __fastcall SetPerspective(Lmdgrlf::TLMDPerspective Value);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomGraphicLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomGraphicLabel(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property System::Uitypes::TColor BrushBackColor = {read=FBrushBack, write=SetBrushBack, default=-16777201};
	__property Font;
	__property Lmdgrlf::TLMDToggle Toggle = {read=FToggle, write=SetToggle, default=0};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFX, write=SetFontFX};
	__property int Factor = {read=FFactor, write=SetInteger, index=2, default=5};
	__property Lmdgrlf::TLMDTransLabelTypes Transform = {read=FTransform, write=SetTransform, default=0};
	__property Lmdgrlf::TLMDTransLabelAttr Attributes = {read=FTransAttr, write=SetTransAttr, default=4};
	__property Lmdgrlf::TLMDPerspective Perspective = {read=FPerspective, write=SetPerspective, default=1};
	__property int PerspectiveDepth = {read=FPerspectiveDepth, write=SetInteger, index=4, default=5};
	__property bool AutoSize = {read=FAutoSize, write=SetBoolean, index=1, default=0};
	__property bool InvertCaption = {read=FInvertCaption, write=SetBoolean, index=2, default=0};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property Transparent = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property DragKind = {default=0};
	__property Constraints;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomgraphiclabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMGRAPHICLABEL)
using namespace Lmdcustomgraphiclabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomgraphiclabelHPP
