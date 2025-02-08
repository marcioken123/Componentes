// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwdbcomb.pas' rev: 6.00

#ifndef WwdbcombHPP
#define WwdbcombHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <wwhistorylist.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <Wwdatsrc.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Wwdotdot.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdbcomb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDBComboBox;
typedef void __fastcall (__closure *TwwComboCloseUpEvent)(TwwDBComboBox* Sender, bool Select);

class DELPHICLASS TwwDBCustomComboBox;
typedef void __fastcall (__closure *TwwAddHistoryItemEvent)(TwwDBCustomComboBox* Sender, AnsiString Value, bool &Accept);

class DELPHICLASS TwwPopupListbox;
class PASCALIMPLEMENTATION TwwPopupListbox : public Stdctrls::TCustomListBox 
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	AnsiString FSearchText;
	int FSearchTickCount;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	DYNAMIC void __fastcall Keypress(char &Key);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	
public:
	__fastcall virtual TwwPopupListbox(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TwwPopupListbox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwPopupListbox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwDBCustomComboBox : public Wwdotdot::TwwDBCustomCombo 
{
	typedef Wwdotdot::TwwDBCustomCombo inherited;
	
private:
	bool FMapList;
	Classes::TStrings* FItems;
	int FDropDownCount;
	int FItemHeight;
	TwwPopupListbox* FListbox;
	bool FListVisible;
	bool FNoKeysEnteredYet;
	bool FAllowClearKey;
	int FItemIndex;
	Stdctrls::TComboBoxStyle FStyle;
	Graphics::TCanvas* FCanvas;
	int FDropDownWidth;
	bool FAutoDropDown;
	bool FShowMatchText;
	Wwhistorylist::TwwHistoryList* FHistoryList;
	Classes::TNotifyEvent FOnDropDown;
	TwwComboCloseUpEvent FOnCloseUp;
	Stdctrls::TDrawItemEvent FOnDrawItem;
	Stdctrls::TMeasureItemEvent FOnMeasureItem;
	TwwAddHistoryItemEvent FOnAddHistoryItem;
	bool InAutoDropDown;
	bool LastShowHint;
	AnsiString PreDropDownText;
	bool DoSelChange;
	bool DirtyListBox;
	bool FDisableDropDownList;
	int FColumn1Width;
	bool FTwoColumnDisplay;
	HIDESBASE void __fastcall DataChange(System::TObject* Sender);
	AnsiString __fastcall GetComboText();
	void __fastcall SetComboText(const AnsiString Value);
	void __fastcall SetItemList(Classes::TStrings* Value);
	bool __fastcall GetSorted(void);
	void __fastcall SetSorted(bool val);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(int val);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMClear(Messages::TMessage &Message);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall SetStyle(Stdctrls::TComboBoxStyle val);
	void __fastcall SetValue(AnsiString Value);
	AnsiString __fastcall GetValue();
	void __fastcall SetDroppedDown(bool val);
	
protected:
	virtual int __fastcall IndexOf(AnsiString Value, int StartIndex = 0x0);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall OwnerDraw(void);
	virtual AnsiString __fastcall GetStoredText();
	virtual void __fastcall CloseUp(bool Accept);
	virtual bool __fastcall IsDroppedDown(void);
	virtual bool __fastcall Editable(void);
	virtual bool __fastcall MouseEditable(void);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	void __fastcall ListBoxNeeded(void);
	void __fastcall DoSelectAll(void);
	virtual void __fastcall ShowText(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, int indentLeft, int indentTop, AnsiString AText);
	void __fastcall SetListBoxItemIndex(int val);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall ProcessSearchKey(char Key, int NewItemIndex, int OldItemIndex, AnsiString FSearchText, AnsiString MatchTextFromList);
	
public:
	__property TwwPopupListbox* Listbox = {read=FListbox};
	__fastcall virtual TwwDBCustomComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomComboBox(void);
	void __fastcall ListBoxItemsNeeded(void);
	virtual void __fastcall DeleteItem(AnsiString Value, bool DeleteFromHistory = false);
	virtual void __fastcall AddItem(AnsiString Value, bool AddToHistory = false);
	virtual void __fastcall ClearHistory(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual bool __fastcall GetFieldMapText(AnsiString StoreValue, AnsiString &res);
	AnsiString __fastcall GetComboValue(AnsiString DisplayText);
	AnsiString __fastcall GetComboDisplay(AnsiString Value);
	void __fastcall ApplyList(void);
	virtual void __fastcall DropDown(void);
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property bool DroppedDown = {read=IsDroppedDown, write=SetDroppedDown, nodefault};
	__property AnsiString Value = {read=GetValue, write=SetValue};
	__property ShowButton ;
	__property Stdctrls::TComboBoxStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property bool MapList = {read=FMapList, write=FMapList, nodefault};
	__property bool AllowClearKey = {read=FAllowClearKey, write=FAllowClearKey, nodefault};
	__property bool AutoDropDown = {read=FAutoDropDown, write=FAutoDropDown, default=0};
	__property EditAlignment  = {default=0};
	__property bool ShowMatchText = {read=FShowMatchText, write=FShowMatchText, default=0};
	__property ButtonStyle  = {default=1};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, nodefault};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property bool DisableDropDownList = {read=FDisableDropDownList, write=FDisableDropDownList, default=0};
	__property bool TwoColumnDisplay = {read=FTwoColumnDisplay, write=FTwoColumnDisplay, default=0};
	__property int Column1Width = {read=FColumn1Width, write=FColumn1Width, default=0};
	__property Wwhistorylist::TwwHistoryList* HistoryList = {read=FHistoryList, write=FHistoryList};
	__property int ItemHeight = {read=FItemHeight, write=FItemHeight, nodefault};
	__property Classes::TStrings* Items = {read=FItems, write=SetItemList};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, default=-1};
	__property bool Sorted = {read=GetSorted, write=SetSorted, nodefault};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TwwComboCloseUpEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property Stdctrls::TMeasureItemEvent OnMeasureItem = {read=FOnMeasureItem, write=FOnMeasureItem};
	__property TwwAddHistoryItemEvent OnAddHistoryItem = {read=FOnAddHistoryItem, write=FOnAddHistoryItem};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomComboBox(HWND ParentWindow) : Wwdotdot::TwwDBCustomCombo(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwDBComboBox : public TwwDBCustomComboBox 
{
	typedef TwwDBCustomComboBox inherited;
	
__published:
	__property DisableThemes  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property ParentBiDiMode  = {default=1};
	__property ShowButton ;
	__property Style ;
	__property MapList ;
	__property AllowClearKey ;
	__property AutoDropDown  = {default=0};
	__property ShowMatchText  = {default=0};
	__property AutoFillDate  = {default=1};
	__property AutoSelect  = {default=1};
	__property AutoSize  = {default=1};
	__property BorderStyle  = {default=1};
	__property ButtonStyle  = {default=1};
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Column1Width  = {default=0};
	__property Ctl3D ;
	__property DataField ;
	__property DataSource ;
	__property DisableDropDownList  = {default=0};
	__property DragMode  = {default=0};
	__property DragCursor  = {default=-12};
	__property DropDownCount ;
	__property DropDownWidth  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property ButtonEffects ;
	__property Frame ;
	__property ButtonWidth  = {default=0};
	__property ButtonGlyph ;
	__property HistoryList ;
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property ItemHeight ;
	__property Items ;
	__property ItemIndex  = {default=-1};
	__property LimitEditRect  = {default=0};
	__property MaxLength  = {default=0};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property Picture ;
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ShowHint ;
	__property Sorted ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property UnboundDataType ;
	__property UsePictureMask  = {default=1};
	__property Visible  = {default=1};
	__property UnboundAlignment  = {default=0};
	__property TwoColumnDisplay  = {default=0};
	__property OnAddHistoryItem ;
	__property OnChange ;
	__property OnCheckValue ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDropDown ;
	__property OnCloseUp ;
	__property OnDrawItem ;
	__property OnMeasureItem ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
public:
	#pragma option push -w-inl
	/* TwwDBCustomComboBox.Create */ inline __fastcall virtual TwwDBComboBox(Classes::TComponent* AOwner) : TwwDBCustomComboBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomComboBox.Destroy */ inline __fastcall virtual ~TwwDBComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBComboBox(HWND ParentWindow) : TwwDBCustomComboBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwdbcomb)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwdbcomb */
using namespace Wwdbcomb;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwdbcomb
