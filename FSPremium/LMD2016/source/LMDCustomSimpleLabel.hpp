// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomSimpleLabel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomsimplelabelHPP
#define LmdcustomsimplelabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomsimplelabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomSimpleLabel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDJumpModes : unsigned char { jmInternet, jmApplication, jmNone, jmCustom };

class PASCALIMPLEMENTATION TLMDCustomSimpleLabel : public Lmdbaselabel::TLMDBaseLabel
{
	typedef Lmdbaselabel::TLMDBaseLabel inherited;
	
private:
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	System::UnicodeString FJump;
	System::Uitypes::TColor FActiveColor;
	System::Uitypes::TColor FInActiveColor;
	bool FUseAsJump;
	bool FShowURLInHint;
	bool FShowURLMenu;
	bool FJumpUnderline;
	TLMDJumpModes FJumpMode;
	int FCounter;
	int __fastcall GetCounter(void);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetJumpUnderLine(bool aValue);
	void __fastcall ReadBoolean(System::Classes::TReader* Reader);
	void __fastcall SetJumpMode(TLMDJumpModes aValue);
	void __fastcall OnOpen(System::TObject* Sender);
	void __fastcall OnCopy(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	__property Caption = {default=0};
	__property System::Uitypes::TColor ActiveColor = {read=FActiveColor, write=SetColor, index=0, default=8388736};
	__property System::UnicodeString Jump = {read=FJump, write=FJump};
	__property System::Uitypes::TColor InActiveColor = {read=FInActiveColor, write=SetColor, index=1, default=16711680};
	__property bool JumpUnderline = {read=FJumpUnderline, write=SetJumpUnderLine, default=1};
	__property TLMDJumpModes JumpMode = {read=FJumpMode, write=SetJumpMode, default=2};
	__property bool ShowURLInHint = {read=FShowURLInHint, write=FShowURLInHint, default=0};
	__property bool ShowURLMenu = {read=FShowURLMenu, write=FShowURLMenu, default=0};
	
public:
	__fastcall virtual TLMDCustomSimpleLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSimpleLabel(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall CorrectBounds(void);
	void __fastcall ResetCounter(void);
	void __fastcall Execute(void);
	void __fastcall CopyURL(void);
	__property int Counter = {read=GetCounter, nodefault};
	
__published:
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property MultiLine = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {index=2, default=1};
	__property ShowHint;
	__property Transparent = {default=1};
	__property Twinkle = {index=3, default=0};
	__property TwinkleColor = {default=536870911};
	__property TwinkleVisible = {index=0, default=700};
	__property TwinkleInVisible = {index=1, default=700};
	__property UseGlobalTimer = {default=0};
	__property Visible = {default=1};
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
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomsimplelabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSIMPLELABEL)
using namespace Lmdcustomsimplelabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomsimplelabelHPP
