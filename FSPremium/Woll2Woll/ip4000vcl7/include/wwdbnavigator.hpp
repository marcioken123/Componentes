// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwDBNavigator.pas' rev: 6.00

#ifndef wwDBNavigatorHPP
#define wwDBNavigatorHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <wwframe.hpp>	// Pascal unit
#include <wwclearpanel.hpp>	// Pascal unit
#include <wwCollection.hpp>	// Pascal unit
#include <wwSpeedButton.hpp>	// Pascal unit
#include <Wwintl.hpp>	// Pascal unit
#include <DBConsts.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <wwDialog.hpp>	// Pascal unit
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

namespace Wwdbnavigator
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwNavDataLink;
class DELPHICLASS TwwDBNavigator;
class DELPHICLASS TwwNavButtons;
class DELPHICLASS TwwNavButton;
#pragma option push -b-
enum TwwNavButtonStyle { nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage, nbsNextPage, nbsSaveBookmark, nbsRestoreBookmark, nbsFilterDialog, nbsRecordViewDialog, nbsLocateDialog, nbsSearchDialog, nbsCustom };
#pragma option pop

#pragma option push -b-
enum TwwUpdateCause { usDataChanged, usEditingChanged, usActiveChanged, usOther };
#pragma option pop

class PASCALIMPLEMENTATION TwwNavButtons : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
public:
	TwwNavButton* operator[](int Index) { return Items[Index]; }
	
private:
	Controls::TControl* FDesigner;
	TwwDBNavigator* FNavigator;
	int FUpdateLock;
	
protected:
	virtual void __fastcall AddButton(const TwwNavButton* Button);
	virtual void __fastcall RemoveButton(const TwwNavButton* Button);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	virtual TwwNavButton* __fastcall BottommostButton(void);
	virtual TwwNavButton* __fastcall FindButtonAtPos(TwwNavButton* IgnoreButton, int x, int y);
	virtual bool __fastcall IgnoreButton(TwwNavButton* Button);
	virtual TwwNavButton* __fastcall RightmostButton(void);
	void __fastcall MakeButtonsVisible(void);
	virtual void __fastcall MakeVisible(TwwNavButtonStyle AStyle, bool CanCreate);
	virtual void __fastcall MakeInvisible(TwwNavButtonStyle AStyle);
	virtual int __fastcall GetCount(void);
	virtual TwwNavButton* __fastcall GetItems(int Index);
	virtual TwwDBNavigator* __fastcall GetNavigator(void);
	virtual TwwNavButton* __fastcall GetVisibleButton(int Index);
	virtual int __fastcall GetVisibleCount(void);
	
public:
	__fastcall TwwNavButtons(TwwDBNavigator* ANav);
	__fastcall virtual ~TwwNavButtons(void);
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
	Wwcollection::_di_IwwCollectionItem __fastcall IwwCollection_Add();
	Wwcollection::_di_IwwCollectionItem __fastcall GetItem(int Index);
	void __fastcall SetDesigner(Controls::TControl* Value);
	virtual TwwNavButton* __fastcall Add(TwwNavButtonStyle AStyle = (TwwNavButtonStyle)(0x12), Classes::TComponent* AComponent = (Classes::TComponent*)(0x0));
	virtual void __fastcall AddInfoPowerDialogs(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall CreateDefaultButtons(void);
	virtual void __fastcall UpdateButtonsRect(void);
	virtual void __fastcall UpdateButtonsPos(void);
	virtual void __fastcall UpdateButtonsState(TwwUpdateCause Cause);
	__property int Count = {read=GetCount, nodefault};
	__property TwwDBNavigator* Navigator = {read=GetNavigator};
	__property TwwNavButton* Items[int Index] = {read=GetItems/*, default*/};
	__property int UpdateLock = {read=FUpdateLock, nodefault};
	__property TwwNavButton* VisibleButtons[int Index] = {read=GetVisibleButton};
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
private:
	void *__IwwCollection;	/* Wwcollection::IwwCollection [Add=IwwCollection_Add] */
	void *__IwwNavButtons;	/* Wwcollection::IwwNavButtons */
	
public:
	operator IwwNavButtons*(void) { return (IwwNavButtons*)&__IwwNavButtons; }
	operator IwwCollection*(void) { return (IwwCollection*)&__IwwCollection; }
	operator IInterface*(void) { return (IInterface*)&__IwwNavButtons; }
	
};


#pragma option push -b-
enum TwwNavAutoSizeStyle { asSizeNavigator, asSizeNavButtons, asNone };
#pragma option pop

#pragma option push -b-
enum TwwNavLayout { nlHorizontal, nlVertical };
#pragma option pop

#pragma option push -b-
enum TwwNavOption { noConfirmDelete, noUseInternationalText };
#pragma option pop

typedef Set<TwwNavOption, noConfirmDelete, noUseInternationalText>  TwwNavOptions;

class DELPHICLASS TwwNavRepeatInterval;
class PASCALIMPLEMENTATION TwwNavRepeatInterval : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FInitialDelay;
	int FRepeatInterval;
	
public:
	__fastcall TwwNavRepeatInterval(void);
	
__published:
	__property int InitialDelay = {read=FInitialDelay, write=FInitialDelay, nodefault};
	__property int Interval = {read=FRepeatInterval, write=FRepeatInterval, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwNavRepeatInterval(void) { }
	#pragma option pop
	
};


typedef Set<TwwNavButtonStyle, nbsFirst, nbsCustom>  TwwNavButtonNavStylesEx;

class PASCALIMPLEMENTATION TwwDBNavigator : public Wwclearpanel::TwwCustomTransparentPanel 
{
	typedef Wwclearpanel::TwwCustomTransparentPanel inherited;
	
private:
	TwwNavButtons* FButtons;
	Db::TDataLink* FDataLink;
	Classes::TList* FBookmarks;
	TwwNavAutoSizeStyle FAutosizeStyle;
	Db::TDataSource* FDataSource;
	bool FFlat;
	Controls::TImageList* FImageList;
	TwwNavLayout FLayout;
	int FMoveBy;
	TwwNavOptions FOptions;
	TwwNavRepeatInterval* FRepeatInterval;
	bool InPaint;
	bool FTransparentClearsBackground;
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	virtual void __fastcall ControlListChange(const Controls::TControl* Control, const bool Inserting);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall AlignControls(Controls::TControl* Control, Types::TRect &Rect);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall DataChanged(void);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall ActiveChanged(void);
	virtual bool __fastcall GetShowHint(void);
	virtual TwwNavButtonNavStylesEx __fastcall GetVisibleButtons(void);
	HIDESBASE virtual void __fastcall SetAlignment(TwwNavLayout Value);
	virtual void __fastcall SetAutosizeStyle(TwwNavAutoSizeStyle Value);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetImageList(Controls::TImageList* Value);
	virtual void __fastcall SetMoveBy(int Value);
	virtual void __fastcall SetName(const AnsiString NewName);
	virtual void __fastcall SetOptions(TwwNavOptions Value);
	HIDESBASE virtual void __fastcall SetShowHint(bool Value);
	virtual void __fastcall SetVisibleButtons(TwwNavButtonNavStylesEx Value);
	virtual int __fastcall CalcBorderWidth(void);
	virtual int __fastcall CalcWidth(void);
	virtual Db::TDataSet* __fastcall GetDataSet(bool RaiseException);
	void * __fastcall GetBookmark(Db::TDataSet* DataSet, bool GetNew);
	void __fastcall AdjustButtonsSize(Controls::TControl* Control);
	void __fastcall FreeBookmark(Db::TDataSet* DataSet);
	virtual void __fastcall UpdateAutosize(void);
	
public:
	Variant Patch;
	__fastcall virtual TwwDBNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBNavigator(void);
	virtual void __fastcall SetDataSourceFromComponent(Classes::TComponent* Component, bool AllowNil);
	__property TwwNavButtonNavStylesEx VisibleButtons = {read=GetVisibleButtons, write=SetVisibleButtons, nodefault};
	
__published:
	__property TwwNavAutoSizeStyle AutosizeStyle = {read=FAutosizeStyle, write=SetAutosizeStyle, default=0};
	__property TwwNavButtons* Buttons = {read=FButtons, stored=false};
	__property Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property TwwNavLayout Layout = {read=FLayout, write=SetAlignment, default=0};
	__property int MoveBy = {read=FMoveBy, write=SetMoveBy, default=10};
	__property TwwNavOptions Options = {read=FOptions, write=SetOptions, default=1};
	__property bool ShowHint = {read=GetShowHint, write=SetShowHint, default=0};
	__property TwwNavRepeatInterval* RepeatInterval = {read=FRepeatInterval, write=FRepeatInterval};
	__property bool TransparentClearsBackground = {read=FTransparentClearsBackground, write=FTransparentClearsBackground, default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Align  = {default=0};
	__property BevelInner  = {default=0};
	__property BevelOuter  = {default=0};
	__property Color  = {default=-16777201};
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentShowHint  = {default=1};
	__property Visible  = {default=1};
	__property Transparent  = {default=0};
	__property OnResize ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBNavigator(HWND ParentWindow) : Wwclearpanel::TwwCustomTransparentPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwNavDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TwwDBNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TwwNavDataLink(TwwDBNavigator* ANav);
	__fastcall virtual ~TwwNavDataLink(void);
};


typedef Set<TwwNavButtonStyle, nbsFirst, nbsCustom>  TwwNavButtonStyles;

typedef TwwNavButtonStyle TwwNavButtonNavStyleEx;

typedef TwwNavButtonStyle TwwNavButtonNavStyle;

typedef TwwNavButtonStyle TwwNavButtonDlgStyle;

typedef void __fastcall (__closure *TwwUpdateStateEvent)(TwwDBNavigator* Navigator, TwwNavButton* Button, TwwUpdateCause Cause);

typedef void __fastcall (__closure *TwwCustomDialogEvent)(Wwdialog::TwwCustomDialog* Dialog);

class PASCALIMPLEMENTATION TwwNavButton : public Wwspeedbutton::TwwSpeedButton 
{
	typedef Wwspeedbutton::TwwSpeedButton inherited;
	
private:
	Wwcollection::TwwUpdateNameEvent FOnUpdateName;
	Wwcollection::TwwSelectionMethod FSelectionMethod;
	TwwNavButtons* FNavButtons;
	Extctrls::TTimer* FTimer;
	bool FLineBreak;
	Wwdialog::TwwCustomDialog* FDialog;
	TwwNavButtonStyle FStyle;
	Classes::TNotifyEvent FOnRowChanged;
	TwwUpdateStateEvent FOnUpdateState;
	TwwCustomDialogEvent FOnAfterCreateDialog;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual int __fastcall GetImageIndex(void);
	virtual int __fastcall GetIndex(void);
	virtual TwwNavButtons* __fastcall GetNavButtons(void);
	virtual TwwDBNavigator* __fastcall GetNavigator(void);
	virtual void __fastcall SetDialog(Wwdialog::TwwCustomDialog* Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetIndex(int Value);
	virtual void __fastcall SetLineBreak(bool Value);
	virtual void __fastcall SetName(const AnsiString NewName);
	virtual void __fastcall SetParent(Controls::TWinControl* Value);
	virtual void __fastcall SetStyle(TwwNavButtonStyle Value);
	virtual AnsiString __fastcall GetDefaultHint();
	Wwdialog::TwwCustomDialog* __fastcall GetDialog(Db::TDataSet* DataSet);
	virtual void __fastcall CancelTimer(void);
	virtual void __fastcall CreateTimer(void);
	virtual void __fastcall TimerEvent(System::TObject* Sender);
	virtual void __fastcall UpdateName(void);
	virtual void __fastcall UpdateGlyph(void);
	virtual void __fastcall UpdateState(TwwUpdateCause Cause);
	__property TwwNavButtons* NavButtons = {read=GetNavButtons};
	
public:
	__fastcall virtual TwwNavButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	virtual bool __fastcall IsVisible(void);
	__property TwwDBNavigator* Navigator = {read=GetNavigator};
	Wwcollection::_di_IwwCollection __fastcall GetCollection();
	AnsiString __fastcall GetDisplayName();
	Classes::TPersistent* __fastcall GetInstance(void);
	void __fastcall SetOnUpdateName(Wwcollection::TwwUpdateNameEvent Value);
	void __fastcall SetSelectionMethod(Wwcollection::TwwSelectionMethod Value);
	virtual void __fastcall PaintTransparentBackground(void);
	
__published:
	__property Wwdialog::TwwCustomDialog* Dialog = {read=FDialog, write=SetDialog};
	__property int Index = {read=GetIndex, write=SetIndex, nodefault};
	__property bool LineBreak = {read=FLineBreak, write=SetLineBreak, default=0};
	__property TwwNavButtonStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Visible  = {default=1};
	__property TwwCustomDialogEvent OnAfterCreateDialog = {read=FOnAfterCreateDialog, write=FOnAfterCreateDialog};
	__property Classes::TNotifyEvent OnRowChanged = {read=FOnRowChanged, write=FOnRowChanged};
	__property TwwUpdateStateEvent OnUpdateState = {read=FOnUpdateState, write=FOnUpdateState};
public:
	#pragma option push -w-inl
	/* TwwSpeedButton.Destroy */ inline __fastcall virtual ~TwwNavButton(void) { }
	#pragma option pop
	
private:
	void *__IwwCollectionItem;	/* Wwcollection::IwwCollectionItem */
	
public:
	operator IwwCollectionItem*(void) { return (IwwCollectionItem*)&__IwwCollectionItem; }
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwDBNavigator)
static const Shortint WW_NAV_DEFAULT_MOVEBY = 0xa;
#define swwControlNotAllowed "TwwDBNavigator only accepts controls derived from TwwNavBu"\
	"tton"
#define swwNoDataSource "Error, DataSource not assigned"
#define swwParentNotNav "Parent of TwwNavButton must be TwwDBNavigator"
#define swwParentNotDefined "Parent propety of TwwNavButton not defined"
#define swwButtonNotInList "Button parameter of RetrieveIndex not in Buttons list"
#define swwIndexOutOfRange "Index of Buttons[] out of range"
#define swwOwnerRequired "Owner cannot be nil"
#define swwBookmarkInvalid "Cannot read or set property Bookmark because the Bookmark "\
	"is invalid."
#define swwConfirmButtonAdd "Add a button to %s for %s"
#define swwVisibleIndexOutRange "Index of VisibleButtons[] out of range"
extern PACKAGE Controls::TImageList* wwNavButtonGlyphs;

}	/* namespace Wwdbnavigator */
using namespace Wwdbnavigator;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwDBNavigator
