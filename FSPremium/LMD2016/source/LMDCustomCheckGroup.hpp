// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomCheckGroup.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcheckgroupHPP
#define LmdcustomcheckgroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcheckgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomCheckGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomCheckGroup : public Lmdcustombuttongroup::TLMDCustomButtonGroup
{
	typedef Lmdcustombuttongroup::TLMDCustomButtonGroup inherited;
	
private:
	System::Byte FNumGlyphs;
	void __fastcall SetNumGlyphs(System::Byte aValue);
	void __fastcall SetValue(int aValue);
	void __fastcall SetItemCheck(int Index, bool aValue);
	bool __fastcall GetItemCheck(int Index);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	
protected:
	virtual void __fastcall UpdateButtons(void);
	void __fastcall UpdateValue(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetButtonCount(int aValue);
	__property int Value = {read=FResult, write=SetValue, default=0};
	
public:
	__property bool Checked[int Index] = {read=GetItemCheck, write=SetItemCheck};
	__fastcall virtual TLMDCustomCheckGroup(System::Classes::TComponent* aOwner);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Bevel;
	__property BtnAlignment;
	__property Caption = {default=0};
	__property CaptionFont;
	__property CaptionFont3D;
	__property CaptionOffset = {default=8};
	__property CaptionParentFont = {default=1};
	__property Color = {default=-16777201};
	__property Columns = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusStyle = {default=1};
	__property FocusColor = {default=8421504};
	__property UseFocusColor = {default=0};
	__property FlatGlyphs = {default=0};
	__property Font;
	__property Font3D;
	__property GlyphImageList;
	__property GlyphImageIndex = {index=0, default=0};
	__property GlyphListIndex = {index=1, default=0};
	__property System::Byte GlyphNumber = {read=FNumGlyphs, write=SetNumGlyphs, default=3};
	__property GlyphFlat = {default=0};
	__property GlyphSize = {default=13};
	__property GlyphTransparent = {default=0};
	__property GlyphTransparentColor = {default=32896};
	__property HelpContextBtn = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property Items;
	__property ItemHeight = {default=-1};
	__property ItemOffset = {default=4};
	__property ListIndex = {index=1, default=0};
	__property MultiLine = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowAccelChar = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property UseBitmap = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
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
	__property OnResize;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TLMDCustomButtonGroup.Destroy */ inline __fastcall virtual ~TLMDCustomCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomCheckGroup(HWND ParentWindow) : Lmdcustombuttongroup::TLMDCustomButtonGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomcheckgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCHECKGROUP)
using namespace Lmdcustomcheckgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcheckgroupHPP
