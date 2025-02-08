// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDImageBox.pas' rev: 31.00 (Windows)

#ifndef PlmdimageboxHPP
#define PlmdimageboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdimagebox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImageCBox;
class DELPHICLASS TLMDImageLBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDImageCBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	System::Classes::TNotifyEvent FOnSelect;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FWidth;
	int FHeight;
	Vcl::Imglist::TChangeLink* FChangeLink;
	bool FNeedToPopulate;
	int FImageIndex;
	int __fastcall GetImageIndex(void);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetImageIndex(int aValue);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PopulateList(void);
	void __fastcall DoSelect(void);
	
public:
	__fastcall virtual TLMDImageCBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDImageCBox(void);
	
__published:
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDImageCBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDImageLBox : public Vcl::Stdctrls::TCustomListBox
{
	typedef Vcl::Stdctrls::TCustomListBox inherited;
	
private:
	System::Classes::TNotifyEvent FOnSelect;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FWidth;
	int FHeight;
	Vcl::Imglist::TChangeLink* FChangeLink;
	bool FNeedToPopulate;
	int FImageIndex;
	int __fastcall GetImageIndex(void);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetImageIndex(int aValue);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PopulateList(void);
	void __fastcall DoSelect(void);
	
public:
	__fastcall virtual TLMDImageLBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDImageLBox(void);
	
__published:
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight = {default=16};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
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
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDImageLBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdimagebox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDIMAGEBOX)
using namespace Plmdimagebox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdimageboxHPP
