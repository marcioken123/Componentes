// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sTreeView.pas' rev: 27.00 (Windows)

#ifndef StreeviewHPP
#define StreeviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sMessages.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Streeview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsTreeView;
class PASCALIMPLEMENTATION TsTreeView : public Vcl::Comctrls::TTreeView
{
	typedef Vcl::Comctrls::TTreeView inherited;
	
private:
	Scommondata::TsScrollWndData* FCommonData;
	Scommondata::TsBoundLabel* FBoundLabel;
	Vcl::Comctrls::TTVAdvancedCustomDrawItemEvent FOldDrawItem;
	
protected:
	Vcl::Comctrls::TTreeNode* RightNode;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	void __fastcall SkinCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	
public:
	Acsbutils::TacScrollWnd* ListSW;
	__fastcall virtual TsTreeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTreeView(void);
	virtual void __fastcall AfterConstruction(void);
	
__published:
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property Scommondata::TsScrollWndData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsTreeView(HWND ParentWindow) : Vcl::Comctrls::TTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Comctrls::TTreeNode* __fastcall GetNodeByText(Vcl::Comctrls::TCustomTreeView* const TreeView, const System::UnicodeString s);
}	/* namespace Streeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STREEVIEW)
using namespace Streeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StreeviewHPP
