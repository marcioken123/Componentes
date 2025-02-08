// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwdbedit.pas' rev: 6.00

#ifndef wwdbeditHPP
#define wwdbeditHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Wwtypes.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Wwdatsrc.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdbedit
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TwwValidateEvent)(System::TObject* Sender, bool PassesPictureTest);

#pragma option push -b-
enum TwwEditDataType { wwDefault, wwEdtDate, wwEdtTime, wwEdtDateTime };
#pragma option pop

class DELPHICLASS TwwDBPicture;
class PASCALIMPLEMENTATION TwwDBPicture : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FPictureMaskFromDataSet;
	AnsiString FPictureMask;
	bool FAutoFill;
	bool FAllowInvalidExit;
	Classes::TComponent* RelatedComponent;
	void __fastcall FlushToDataset(bool SetMask, bool SetAutoFill, bool SetUsePictureMask);
	void __fastcall SetPictureMask(AnsiString val);
	void __fastcall SetAutoFill(bool val);
	void __fastcall SetAllowInvalidExit(bool val);
	AnsiString __fastcall GetPictureMask();
	bool __fastcall GetAutoFill(void);
	bool __fastcall GetAllowInvalidExit(void);
	
public:
	__fastcall TwwDBPicture(Classes::TComponent* Owner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall IsDatasetMask(void);
	
__published:
	__property bool PictureMaskFromDataSet = {read=FPictureMaskFromDataSet, write=FPictureMaskFromDataSet, default=1};
	__property AnsiString PictureMask = {read=GetPictureMask, write=SetPictureMask};
	__property bool AutoFill = {read=GetAutoFill, write=SetAutoFill, default=1};
	__property bool AllowInvalidExit = {read=GetAllowInvalidExit, write=SetAllowInvalidExit, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwDBPicture(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwCustomMaskEdit;
class PASCALIMPLEMENTATION TwwCustomMaskEdit : public Mask::TCustomMaskEdit 
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	TwwDBPicture* FwwPicture;
	bool FWordWrap;
	TwwValidateEvent FOnCheckValue;
	bool FUsePictureMask;
	bool FWantReturns;
	bool FShowVertScrollBar;
	bool DoExitPictureError;
	Wwframe::TwwEditFrame* FFrame;
	bool FMaskStoreLiteralTemplate;
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	
protected:
	bool ModifiedInKeyPress;
	bool SetModifiedInChangeEvent;
	char __fastcall GetMaskBlank(void);
	virtual bool __fastcall OwnerDraw(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall EnableEdit(void);
	void __fastcall SetWordWrap(bool val);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	bool __fastcall HavePictureMask(void);
	HIDESBASE AnsiString __fastcall RemoveEditFormat(const AnsiString Value);
	virtual void __fastcall DoOnCheckValue(bool Valid);
	void __fastcall SetShowVertScrollBar(bool Value);
	
public:
	Variant Patch;
	bool __fastcall IsValidPictureValue(AnsiString s);
	bool __fastcall IsValidPictureMask(AnsiString s);
	__fastcall virtual TwwCustomMaskEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwCustomMaskEdit(void);
	void __fastcall ApplyMask(void);
	bool __fastcall Is3DBorder(void);
	bool __fastcall JustHaveLiteralTemplate(void);
	__property bool MaskStoreLiteralTemplate = {read=FMaskStoreLiteralTemplate, write=FMaskStoreLiteralTemplate, default=0};
	__property Wwframe::TwwEditFrame* Frame = {read=FFrame, write=FFrame};
	__property TwwDBPicture* Picture = {read=FwwPicture, write=FwwPicture};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property TwwValidateEvent OnCheckValue = {read=FOnCheckValue, write=FOnCheckValue};
	__property bool UsePictureMask = {read=FUsePictureMask, write=FUsePictureMask, default=1};
	__property bool WantReturns = {read=FWantReturns, write=FWantReturns, nodefault};
	__property bool ShowVertScrollBar = {read=FShowVertScrollBar, write=SetShowVertScrollBar, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomMaskEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TwwPictureValidationError)(System::TObject* Sender, Db::TField* Field, AnsiString &Msg, bool &DoDefault);

class DELPHICLASS TwwDBCustomEdit;
class PASCALIMPLEMENTATION TwwDBCustomEdit : public TwwCustomMaskEdit 
{
	typedef TwwCustomMaskEdit inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Controls::TControlCanvas* FCanvas;
	Classes::TAlignment FAlignment;
	Classes::TAlignment FUnboundAlignment;
	int FTextMargin;
	AnsiString StartValue;
	bool FAutoFillDate;
	TwwEditDataType FDataType;
	int FEpochYear;
	Wwtypes::TwwEditAlignment FEditAlignment;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	AnsiString FDisplayFormat;
	bool FDisableThemes;
	void __fastcall SetPicture(TwwDBPicture* val);
	TwwDBPicture* __fastcall GetPicture(void);
	bool __fastcall DoAutoFillDate(char &key);
	void __fastcall CalcTextMargin(void);
	void __fastcall EditingChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	MESSAGE void __fastcall WMUndo(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFont(Messages::TWMSetFont &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	bool FFocused;
	virtual AnsiString __fastcall GetDisplayFormat();
	virtual void __fastcall SetDisplayFormat(AnsiString val);
	virtual bool __fastcall PreventEdit(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall DataChange(System::TObject* Sender);
	DYNAMIC void __fastcall Change(void);
	virtual bool __fastcall EditCanModify(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Reset(void);
	DYNAMIC int __fastcall GetIconIndent(void);
	DYNAMIC int __fastcall GetIconLeft(void);
	DYNAMIC void __fastcall EnableEdit(void);
	virtual bool __fastcall IsMemoField(void);
	AnsiString __fastcall GetDBPicture();
	virtual bool __fastcall Editable(void);
	virtual Types::TRect __fastcall GetClientEditRect();
	virtual AnsiString __fastcall GetStoredText();
	virtual void __fastcall ShowText(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, int indentLeft, int indentTop, AnsiString AText);
	bool __fastcall StorePictureProperty(void);
	HIDESBASE void __fastcall SetModified(bool val);
	bool __fastcall ParentGridFocused(void);
	bool __fastcall AllSelected(void);
	virtual bool __fastcall GetShowButton(void);
	virtual void __fastcall SetShowButton(bool sel);
	bool __fastcall isDateField(void);
	bool __fastcall isTimeField(void);
	bool __fastcall isDateTimeField(void);
	__property Controls::TControlCanvas* ControlCanvas = {read=FCanvas};
	__property Picture  = {read=GetPicture, write=SetPicture, stored=StorePictureProperty};
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall DrawFrame(Controls::TWinControl* Control, Graphics::TCanvas* Canvas);
	Classes::TAlignment __fastcall GetEffectiveAlignment(void);
	virtual void __fastcall ValidationErrorUsingMask(Db::TField* Field);
	virtual bool __fastcall IsDroppedDown(void);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	
public:
	__property int EpochYear = {read=FEpochYear, write=FEpochYear, default=0};
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	__fastcall virtual TwwDBCustomEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomEdit(void);
	bool __fastcall isTransparentEffective(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	virtual bool __fastcall GetFieldMapText(AnsiString StoreValue, AnsiString &res);
	void __fastcall UpdateRecord(void);
	void __fastcall InitText(AnsiString val);
	__property Color  = {default=-16777211};
	__property Font ;
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	__property Db::TField* Field = {read=GetField};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool AutoFillDate = {read=FAutoFillDate, write=FAutoFillDate, default=1};
	__property bool ShowButton = {read=GetShowButton, write=SetShowButton, nodefault};
	__property TwwEditDataType UnboundDataType = {read=FDataType, write=FDataType, nodefault};
	__property Classes::TAlignment UnboundAlignment = {read=FUnboundAlignment, write=FUnboundAlignment, default=0};
	__property Wwtypes::TwwEditAlignment EditAlignment = {read=FEditAlignment, write=FEditAlignment, default=0};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=SetDisplayFormat};
	__property bool DisableThemes = {read=FDisableThemes, write=FDisableThemes, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomEdit(HWND ParentWindow) : TwwCustomMaskEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBEdit;
class PASCALIMPLEMENTATION TwwDBEdit : public TwwDBCustomEdit 
{
	typedef TwwDBCustomEdit inherited;
	
__published:
	__property DisableThemes  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property AutoFillDate  = {default=1};
	__property AutoSelect  = {default=1};
	__property AutoSize  = {default=1};
	__property BorderStyle  = {default=1};
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property ParentBiDiMode  = {default=1};
	__property Ctl3D ;
	__property DataField ;
	__property DataSource ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property EditAlignment  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Frame ;
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property MaxLength  = {default=0};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PasswordChar  = {default=0};
	__property Picture ;
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property MaskStoreLiteralTemplate  = {default=0};
	__property ShowVertScrollBar  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property UnboundDataType ;
	__property UnboundAlignment  = {default=0};
	__property UsePictureMask  = {default=1};
	__property Visible  = {default=1};
	__property WantReturns ;
	__property WordWrap ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnCheckValue ;
public:
	#pragma option push -w-inl
	/* TwwDBCustomEdit.Create */ inline __fastcall virtual TwwDBEdit(Classes::TComponent* AOwner) : TwwDBCustomEdit(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomEdit.Destroy */ inline __fastcall virtual ~TwwDBEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBEdit(HWND ParentWindow) : TwwDBCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwdbedit)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwdbedit */
using namespace Wwdbedit;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwdbedit
