// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomLabelFill.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlabelfillHPP
#define LmdcustomlabelfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMDCustomLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTypes.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlabelfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomLabelFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomLabelFill : public Lmdcustomlabel::TLMDCustomLabel
{
	typedef Lmdcustomlabel::TLMDCustomLabel inherited;
	
private:
	System::Uitypes::TColor FBrushBack;
	Lmdfillobject::TLMDFillObject* FFillObject;
	void __fastcall SetBrushBack(System::Uitypes::TColor aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomLabelFill(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomLabelFill(void);
	
__published:
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property System::Uitypes::TColor BrushBackColor = {read=FBrushBack, write=SetBrushBack, default=-16777201};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property FontFX;
	__property MultiLine = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {index=2, default=1};
	__property ShowHint;
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
}	/* namespace Lmdcustomlabelfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLABELFILL)
using namespace Lmdcustomlabelfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlabelfillHPP
