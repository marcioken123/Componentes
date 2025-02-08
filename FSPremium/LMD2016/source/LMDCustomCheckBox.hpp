// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomCheckBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcheckboxHPP
#define LmdcustomcheckboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcheckbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomCheckBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomCheckBox : public Lmdbuttoncontrol::TLMDButtonControl
{
	typedef Lmdbuttoncontrol::TLMDButtonControl inherited;
	
private:
	bool FAllowGrayed;
	Vcl::Stdctrls::TCheckBoxState FState;
	System::Byte FIntNumGlyphs;
	System::Byte FNumGlyphs;
	HIDESBASE void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetNumGlyphs(System::Byte aValue);
	void __fastcall SetState(Vcl::Stdctrls::TCheckBoxState aValue);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	System::Byte __fastcall GetNumGlyphs(void);
	
protected:
	virtual void __fastcall DoFlatChanged(void);
	virtual void __fastcall CreateStandardGlyph(void);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool aValue);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall CreateGlyph(void);
	int __fastcall GetGlyphNumber(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawFace(Vcl::Graphics::TCanvas* aCanvas, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags);
	virtual System::Types::TRect __fastcall DrawItem(Vcl::Graphics::TCanvas* target, bool toDraw, System::Byte flag);
	virtual void __fastcall DrawGlyph(Vcl::Graphics::TCanvas* Target = (Vcl::Graphics::TCanvas*)(0x0));
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual Vcl::Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	virtual void __fastcall Toggle(void);
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	
public:
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__fastcall virtual TLMDCustomCheckBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomCheckBox(void);
	
__published:
	__property About = {default=0};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetBool, index=1, default=0};
	__property Alignment;
	__property AutoSize = {index=0, default=0};
	__property Caption = {default=0};
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
	__property GlyphTransparent = {index=1, default=0};
	__property GlyphTransparentColor = {default=32896};
	__property GlyphFlat = {index=2, default=0};
	__property System::Byte GlyphNumber = {read=FNumGlyphs, write=SetNumGlyphs, default=3};
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
	__property TabStop = {default=1};
	__property Tag = {default=0};
	__property Top;
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property UseFocusColor = {default=0};
	__property Visible = {default=1};
	__property Width;
	__property OnClick;
	__property OnChange;
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomCheckBox(HWND ParentWindow) : Lmdbuttoncontrol::TLMDButtonControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomcheckbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCHECKBOX)
using namespace Lmdcustomcheckbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcheckboxHPP
