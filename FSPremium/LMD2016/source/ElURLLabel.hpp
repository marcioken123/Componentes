// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElURLLabel.pas' rev: 31.00 (Windows)

#ifndef ElurllabelHPP
#define ElurllabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElVCLUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <LMDUtils.hpp>
#include <ElCLabel.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elurllabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElURLLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElURLLabel : public Elclabel::TCustomElLabel
{
	typedef Elclabel::TCustomElLabel inherited;
	
private:
	bool FShowURLInHint;
	bool FVisited;
	System::Uitypes::TColor FVisitedColor;
	System::UnicodeString FURI;
	System::Uitypes::TColor FHyperLinkColour;
	System::Uitypes::TColor FOldColour;
	System::Uitypes::TFontStyles FHyperLinkStyle;
	System::Uitypes::TFontStyles FOldStyle;
	void __fastcall SetHyperLinkStyle(const System::Uitypes::TFontStyles Value);
	void __fastcall SetHyperLinkColour(const System::Uitypes::TColor Value);
	void __fastcall SetVisitedColor(System::Uitypes::TColor newValue);
	void __fastcall SetVisited(bool newValue);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	
protected:
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	void __fastcall OnOpen(System::TObject* Sender);
	void __fastcall OnCopy(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	__fastcall virtual TElURLLabel(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	void __fastcall GotoURL(void);
	void __fastcall CopyURL(void);
	
__published:
	__property System::UnicodeString URL = {read=FURI, write=FURI};
	__property System::Uitypes::TColor VisitedColor = {read=FVisitedColor, write=SetVisitedColor, default=16711680};
	__property bool Visited = {read=FVisited, write=SetVisited, default=0};
	__property System::Uitypes::TColor HyperLinkColor = {read=FHyperLinkColour, write=SetHyperLinkColour, default=16711680};
	__property System::Uitypes::TFontStyles HyperLinkStyle = {read=FHyperLinkStyle, write=SetHyperLinkStyle, nodefault};
	__property bool ShowURLInHint = {read=FShowURLInHint, write=FShowURLInHint, default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DragKind = {default=0};
	__property AutoSize = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property ShowHint;
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {default=1};
	__property Transparent = {default=1};
	__property Layout = {default=0};
	__property Visible = {default=1};
	__property WordWrap = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
public:
	/* TCustomElLabel.Destroy */ inline __fastcall virtual ~TElURLLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elurllabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELURLLABEL)
using namespace Elurllabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElurllabelHPP
