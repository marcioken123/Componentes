// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acNoteBook.pas' rev: 27.00 (Windows)

#ifndef AcnotebookHPP
#define AcnotebookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acnotebook
{
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Acsbutils::TacMainWnd*> TacWndArray;

class DELPHICLASS TsNotebook;
class PASCALIMPLEMENTATION TsNotebook : public Vcl::Extctrls::TNotebook
{
	typedef Vcl::Extctrls::TNotebook inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	TacWndArray wa;
	
public:
	__fastcall virtual TsNotebook(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsNotebook(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Font;
	__property Enabled = {default=1};
	__property Constraints;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsNotebook(HWND ParentWindow) : Vcl::Extctrls::TNotebook(ParentWindow) { }
	
};


class DELPHICLASS TsPage;
class PASCALIMPLEMENTATION TsPage : public Vcl::Extctrls::TPage
{
	typedef Vcl::Extctrls::TPage inherited;
	
public:
	/* TPage.Create */ inline __fastcall virtual TsPage(System::Classes::TComponent* AOwner) : Vcl::Extctrls::TPage(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsPage(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsPage(HWND ParentWindow) : Vcl::Extctrls::TPage(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acnotebook */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACNOTEBOOK)
using namespace Acnotebook;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcnotebookHPP
