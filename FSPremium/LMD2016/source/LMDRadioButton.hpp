// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRadioButton.pas' rev: 31.00 (Windows)

#ifndef LmdradiobuttonHPP
#define LmdradiobuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDButtonControl.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdradiobutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRadioButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRadioButton : public Lmdbuttoncontrol::TLMDButtonControl
{
	typedef Lmdbuttoncontrol::TLMDButtonControl inherited;
	
private:
	bool FTurnSibling;
	bool FChecked;
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	
protected:
	virtual bool __fastcall isSibling(Vcl::Controls::TControl* aControl);
	virtual void __fastcall DoFlatChanged(void);
	virtual void __fastcall CreateGlyph(void);
	virtual void __fastcall CreateStandardGlyph(void);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool aValue);
	DYNAMIC void __fastcall DoEnter(void);
	int __fastcall GetGlyphNumber(System::Word flag);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawFace(Vcl::Graphics::TCanvas* aCanvas, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags);
	virtual System::Types::TRect __fastcall DrawItem(Vcl::Graphics::TCanvas* target, bool toDraw, System::Byte flag);
	virtual void __fastcall DrawGlyph(Vcl::Graphics::TCanvas* Target = (Vcl::Graphics::TCanvas*)(0x0));
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDRadioButton(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRadioButton(void);
	__property bool TurnSibling = {read=FTurnSibling, write=FTurnSibling, default=0};
	
__published:
	__property About = {default=0};
	__property Alignment;
	__property AutoSize = {index=0, default=0};
	__property BackFX;
	__property Caption = {default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, nodefault};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property FocusColor = {default=8421504};
	__property FocusStyle = {default=1};
	__property Font;
	__property Font3D;
	__property GlyphTransparent = {index=1, default=1};
	__property GlyphTransparentColor = {default=32896};
	__property GlyphFlat = {index=2, default=0};
	__property GlyphSize = {default=13};
	__property Height;
	__property HelpContext = {default=0};
	__property Hint;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property Left;
	__property ListIndex = {index=1, default=0};
	__property MultiLine = {default=1};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Tag = {default=0};
	__property Top;
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property UseFocusColor = {default=0};
	__property Visible = {default=1};
	__property Width;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property Action;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRadioButton(HWND ParentWindow) : Lmdbuttoncontrol::TLMDButtonControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdradiobutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRADIOBUTTON)
using namespace Lmdradiobutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdradiobuttonHPP
