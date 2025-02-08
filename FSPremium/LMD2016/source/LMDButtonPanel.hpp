// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonPanel.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonpanelHPP
#define LmdbuttonpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDClass.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDSBtn.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonBase.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonPanel;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDBtnClickEvent)(System::TObject* Sender, System::TObject* SendBtn, int Btn);

class PASCALIMPLEMENTATION TLMDButtonPanel : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	bool FCustomXP;
	void __fastcall SetCustomButtonXP(const bool Value);
	void __fastcall SetButtons(Lmdsbtn::TLMDSpecialButtons* aValue);
	void __fastcall SetBtnStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetBtnSize(int index, int aValue);
	int __fastcall GetBtnSize(int index);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	
protected:
	System::Types::TPoint FBtnSize;
	Lmdsbtn::TLMDSpecialButtons* FButtons;
	TLMDBtnClickEvent FOnBtnClick;
	bool FSetBorders;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall InitBtnStyle(void);
	virtual bool __fastcall GetEmpty(void);
	void __fastcall GetBtnsChange(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	void __fastcall DoBtnClick(System::TObject* Sender);
	void __fastcall SetCustomButtonsXPMode(const Lmdclass::TLMDThemeMode Value);
	
public:
	__fastcall virtual TLMDButtonPanel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDButtonPanel(void);
	virtual void __fastcall CreateButtons(void);
	virtual void __fastcall SetBorders(void);
	virtual int __fastcall AddButton(void);
	void __fastcall InsertButton(int index);
	__property CtlXP = {default=1};
	__property DockManager;
	
__published:
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBackground = {default=0};
	__property ParentColor = {default=0};
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
	__property Lmdsbtn::TLMDSpecialButtons* Buttons = {read=FButtons, write=SetButtons};
	__property int ButtonHeight = {read=GetBtnSize, write=SetBtnSize, index=0, default=20};
	__property int ButtonWidth = {read=GetBtnSize, write=SetBtnSize, index=1, default=20};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FBtnStyle, write=SetBtnStyle, default=1};
	__property bool ButtonParentCtlXP = {read=FCustomXP, write=SetCustomButtonXP, default=1};
	__property Color = {default=-16777201};
	__property Align = {default=0};
	__property BackFX;
	__property Bevel;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property FillObject;
	__property Flat = {default=0};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Visible = {default=1};
	__property PopupMenu;
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property Transparent = {default=0};
	__property ShowHint;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property ParentShowHint = {default=1};
	__property TLMDBtnClickEvent OnButtonClick = {read=FOnBtnClick, write=FOnBtnClick};
	__property OnClick;
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnMouseWheel;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButtonPanel(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbuttonpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONPANEL)
using namespace Lmdbuttonpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonpanelHPP
