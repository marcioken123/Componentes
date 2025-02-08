// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStaticText.pas' rev: 31.00 (Windows)

#ifndef LmdstatictextHPP
#define LmdstatictextHPP

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
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Themes.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDControl.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstatictext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStaticText;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStaticText : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Vcl::Controls::TWinControl* FFocusControl;
	bool FShowAccelChar;
	bool FMultiLine;
	bool FAutoSize;
	Lmdbaselabel::TLMDLabelOptions FOptions;
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetOptions(Lmdbaselabel::TLMDLabelOptions aValue);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
protected:
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	
public:
	__fastcall virtual TLMDStaticText(System::Classes::TComponent* aOwner);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CorrectBounds(void);
	System::Word __fastcall GetOptionsFlag(void);
	System::UnicodeString __fastcall GetLabelText(void);
	__property DockManager;
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Alignment = {default=4};
	__property bool AutoSize = {read=FAutoSize, write=SetBoolean, index=0, default=1};
	__property BackFX;
	__property Bevel;
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FillObject;
	__property Vcl::Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Font;
	__property FontFX;
	__property HelpContext = {default=0};
	__property Hint;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property bool MultiLine = {read=FMultiLine, write=SetBoolean, index=1, default=0};
	__property Lmdbaselabel::TLMDLabelOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property ParentBackground = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ShowAccelChar = {read=FShowAccelChar, write=SetBoolean, index=2, default=1};
	__property ShowHint;
	__property Transparent = {default=0};
	__property TransparentBorder = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TLMDCustomPanelFill.Destroy */ inline __fastcall virtual ~TLMDStaticText(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStaticText(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstatictext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTATICTEXT)
using namespace Lmdstatictext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstatictextHPP
