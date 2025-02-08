// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwcheckbox.pas' rev: 6.00

#ifndef wwcheckboxHPP
#define wwcheckboxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <Wwdbgrid.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <wwradiobutton.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwcheckbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCustomCheckBox;
class PASCALIMPLEMENTATION TwwCustomCheckBox : public Stdctrls::TCustomCheckBox 
{
	typedef Stdctrls::TCustomCheckBox inherited;
	
private:
	Controls::TControlCanvas* FCanvas;
	Wwframe::TwwEditFrame* FFrame;
	Wwradiobutton::TwwWinButtonIndents* FIndents;
	bool FAlwaysTransparent;
	AnsiString FValueChecked;
	AnsiString FValueUnchecked;
	AnsiString FDisplayValueChecked;
	AnsiString FDisplayValueUnchecked;
	bool FShowFocusRect;
	bool FShowBoxAroundGlyph;
	bool FDynamicCaption;
	Imglist::TCustomImageList* FImages;
	bool FWordWrap;
	Graphics::TBitmap* FPaintBitmap;
	Graphics::TCanvas* FPaintCanvas;
	bool SpaceKeyPressed;
	bool FModified;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	bool FShowAsButton;
	Stdctrls::TCheckBoxState FNullAndBlankState;
	bool FShowText;
	bool FCenterTextVertically;
	bool FDisableThemes;
	bool __fastcall isTransparentEffective(void);
	MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	virtual void __fastcall DrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall BMSetCheck(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall EMGetModify(Messages::TMessage &Message);
	void __fastcall SetValueChecked(const AnsiString Value);
	void __fastcall SetValueUnchecked(const AnsiString Value);
	AnsiString __fastcall GetDisplayValueChecked();
	AnsiString __fastcall GetDisplayValueUnchecked();
	void __fastcall SetDisplayValueChecked(const AnsiString Value);
	void __fastcall SetDisplayValueUnchecked(const AnsiString Value);
	void __fastcall ComputeTextRect(Types::TRect &DrawRect);
	bool __fastcall GetModified(void);
	void __fastcall SetModified(bool Value);
	HIDESBASE void __fastcall SetColor(Graphics::TColor Value);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE bool __fastcall IsColorStored(void);
	
protected:
	virtual AnsiString __fastcall GetDisplayText();
	virtual int __fastcall GetExtraIndentX(void);
	virtual bool __fastcall IsMouseInControl(bool CheckAreaOnly = false);
	virtual bool __fastcall FillBackground(void);
	virtual Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	void __fastcall PaintBorder(void);
	virtual void __fastcall DataChange(System::TObject* Sender);
	virtual Graphics::TCanvas* __fastcall GetCanvas(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	virtual Controls::TImageList* __fastcall GetImageList(void);
	virtual bool __fastcall HideExpand(void);
	virtual Db::TField* __fastcall GetField(void);
	virtual Classes::TAlignment __fastcall GetAlignment(void);
	virtual int __fastcall GetDrawFlags(void);
	
public:
	__fastcall virtual ~TwwCustomCheckBox(void);
	__fastcall virtual TwwCustomCheckBox(Classes::TComponent* AOwner);
	virtual void __fastcall ComputeGlyphRect(Types::TRect &DrawRect);
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
	__property bool DisableThemes = {read=FDisableThemes, write=FDisableThemes, nodefault};
	__property bool AlwaysTransparent = {read=FAlwaysTransparent, write=FAlwaysTransparent, nodefault};
	__property Wwframe::TwwEditFrame* Frame = {read=FFrame, write=FFrame};
	__property Wwradiobutton::TwwWinButtonIndents* Indents = {read=FIndents, write=FIndents};
	__property bool DynamicCaption = {read=FDynamicCaption, write=FDynamicCaption, default=0};
	__property AnsiString ValueChecked = {read=FValueChecked, write=SetValueChecked};
	__property AnsiString ValueUnchecked = {read=FValueUnchecked, write=SetValueUnchecked};
	__property AnsiString DisplayValueChecked = {read=GetDisplayValueChecked, write=SetDisplayValueChecked};
	__property AnsiString DisplayValueUnchecked = {read=GetDisplayValueUnchecked, write=SetDisplayValueUnchecked};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=FShowFocusRect, default=1};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=0};
	__property Stdctrls::TCheckBoxState NullAndBlankState = {read=FNullAndBlankState, write=FNullAndBlankState, nodefault};
	__property bool ShowText = {read=FShowText, write=FShowText, default=1};
	__property bool ShowAsButton = {read=FShowAsButton, write=FShowAsButton, default=0};
	__property bool ShowBoxAroundGlyph = {read=FShowBoxAroundGlyph, write=FShowBoxAroundGlyph, default=0};
	__property bool CenterTextVertically = {read=FCenterTextVertically, write=FCenterTextVertically, default=1};
	__property Action ;
	__property Alignment  = {default=1};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Caption ;
	__property Checked  = {default=0};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, stored=IsColorStored, nodefault};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property State  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomCheckBox(HWND ParentWindow) : Stdctrls::TCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBCustomCheckBox;
class PASCALIMPLEMENTATION TwwDBCustomCheckBox : public TwwCustomCheckBox 
{
	typedef TwwCustomCheckBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall ValueMatch(const AnsiString ValueList, const AnsiString Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	
protected:
	bool __fastcall IsDataBound(void);
	virtual void __fastcall DataChange(System::TObject* Sender);
	virtual void __fastcall Toggle(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual Db::TField* __fastcall GetField(void);
	virtual Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	
public:
	__fastcall virtual TwwDBCustomCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomCheckBox(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property Action ;
	__property Alignment  = {default=1};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Caption ;
	__property Checked  = {default=0};
	__property Constraints ;
	__property Ctl3D ;
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Images ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property State  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomCheckBox(HWND ParentWindow) : TwwCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwCheckBox;
class PASCALIMPLEMENTATION TwwCheckBox : public TwwDBCustomCheckBox 
{
	typedef TwwDBCustomCheckBox inherited;
	
__published:
	__property DisableThemes ;
	__property AlwaysTransparent ;
	__property Frame ;
	__property DynamicCaption  = {default=0};
	__property ValueChecked ;
	__property ValueUnchecked ;
	__property DisplayValueChecked ;
	__property DisplayValueUnchecked ;
	__property ShowFocusRect  = {default=1};
	__property NullAndBlankState ;
	__property Indents ;
	__property Action ;
	__property Alignment  = {default=1};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Caption ;
	__property Checked  = {default=0};
	__property Color ;
	__property Constraints ;
	__property CenterTextVertically  = {default=1};
	__property Ctl3D ;
	__property DataField ;
	__property DataSource ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Images ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property ShowText  = {default=1};
	__property State  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property ReadOnly  = {default=0};
public:
	#pragma option push -w-inl
	/* TwwDBCustomCheckBox.Create */ inline __fastcall virtual TwwCheckBox(Classes::TComponent* AOwner) : TwwDBCustomCheckBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomCheckBox.Destroy */ inline __fastcall virtual ~TwwCheckBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCheckBox(HWND ParentWindow) : TwwDBCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwExpandGridIndents;
class PASCALIMPLEMENTATION TwwExpandGridIndents : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Controls::TWinControl* FWinControl;
	int FIndentX;
	int FIndentY;
	
public:
	__fastcall TwwExpandGridIndents(Classes::TComponent* AOwner);
	
__published:
	__property int X = {read=FIndentX, write=FIndentX, default=0};
	__property int Y = {read=FIndentY, write=FIndentY, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwExpandGridIndents(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwExpandButton;
typedef void __fastcall (__closure *TwwCheckVisibleButton)(TwwExpandButton* Sender, Db::TDataSet* DataSet, bool &AShowExpand);

class PASCALIMPLEMENTATION TwwExpandButton : public TwwDBCustomCheckBox 
{
	typedef TwwDBCustomCheckBox inherited;
	
private:
	Classes::TAlignment FButtonAlignment;
	Controls::TWinControl* FGrid;
	Controls::TImageList* FExpandImages;
	bool FAutoShrink;
	Classes::TNotifyEvent FOnBeforeExpand;
	Classes::TNotifyEvent FOnBeforeCollapse;
	Classes::TNotifyEvent FOnAfterExpand;
	Classes::TNotifyEvent FOnAfterCollapse;
	bool FAutoHideExpand;
	bool InClickEvent;
	TwwExpandGridIndents* FGridIndents;
	TwwCheckVisibleButton FOnCheckVisibleButton;
	int BeforeExpandHeightOfParentGrid;
	int BeforeExpandRowHeight;
	HIDESBASE MESSAGE void __fastcall BMSetCheck(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	void __fastcall SetGrid(Controls::TWinControl* value);
	void __fastcall SetExpanded(bool val);
	bool __fastcall GetExpanded(void);
	
protected:
	int OriginalHeight;
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual Classes::TAlignment __fastcall GetAlignment(void);
	virtual AnsiString __fastcall GetDisplayText();
	virtual int __fastcall GetExtraIndentX(void);
	virtual Controls::TImageList* __fastcall GetImageList(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Toggle(void);
	virtual void __fastcall DataChange(System::TObject* Sender);
	virtual Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	virtual bool __fastcall FillBackground(void);
	virtual void __fastcall DoBeforeExpand(void);
	virtual void __fastcall DoBeforeCollapse(void);
	virtual void __fastcall DoAfterExpand(void);
	virtual void __fastcall DoAfterCollapse(void);
	virtual bool __fastcall HideExpand(void);
	virtual int __fastcall GetDrawFlags(void);
	
public:
	bool PaintAsExpanded;
	int DesiredRow;
	int ExpandedGridRow;
	bool InRefreshCalcField;
	bool InToggle;
	__fastcall virtual TwwExpandButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwExpandButton(void);
	void __fastcall ResetHeight(void);
	DYNAMIC void __fastcall Click(void);
	__property bool Expanded = {read=GetExpanded, write=SetExpanded, nodefault};
	void __fastcall RefreshCalcField(void);
	void __fastcall ExpandAfterDelay(void);
	
__published:
	__property DisableThemes ;
	__property Controls::TWinControl* Grid = {read=FGrid, write=SetGrid};
	__property bool AutoShrink = {read=FAutoShrink, write=FAutoShrink, default=1};
	__property bool AutoHideExpand = {read=FAutoHideExpand, write=FAutoHideExpand, default=0};
	__property ShowFocusRect  = {default=1};
	__property Classes::TNotifyEvent OnBeforeExpand = {read=FOnBeforeExpand, write=FOnBeforeExpand};
	__property Classes::TNotifyEvent OnBeforeCollapse = {read=FOnBeforeCollapse, write=FOnBeforeCollapse};
	__property Classes::TNotifyEvent OnAfterExpand = {read=FOnAfterExpand, write=FOnAfterExpand};
	__property Classes::TNotifyEvent OnAfterCollapse = {read=FOnAfterCollapse, write=FOnAfterCollapse};
	__property TwwCheckVisibleButton OnCheckVisibleButton = {read=FOnCheckVisibleButton, write=FOnCheckVisibleButton};
	__property TwwExpandGridIndents* GridIndents = {read=FGridIndents, write=FGridIndents};
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property DataField ;
	__property DataSource ;
	__property Enabled  = {default=1};
	__property Font ;
	__property Images ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property Indents ;
	__property ShowAsButton  = {default=0};
	__property ShowText  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property Classes::TAlignment ButtonAlignment = {read=FButtonAlignment, write=FButtonAlignment, default=0};
	__property OnContextPopup ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property ReadOnly  = {default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwExpandButton(HWND ParentWindow) : TwwDBCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwcheckbox)

}	/* namespace Wwcheckbox */
using namespace Wwcheckbox;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwcheckbox
